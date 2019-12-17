hiSetBindKey("Layout" "CtrlShift<Key>l" "GGRemoveDanglingWires()")
procedure(_GGRemoveDanglingWiresSelectByLine( w done pts )
    let((all_objects wires cv vias viaLayers matchingLayers)
        pts = foreach(mapcar p pts geWindowToEditPoint( w p ))
        cv = geGetEditCellView()
        when( done
            all_objects = geGetSortedSelectByLine( w pts )
            wires = setof(obj all_objects car(obj)~>objType == "pathSeg")
            foreach(wire wires   
                if(!pteIsVisible(buildString(car(wire)~>lpp) "Layers") then
                    geDeselectObject(car(wire))
                else
                    vias = leSearchHierarchy(cv car(wire)~>bBox 0 "via" nil)
                    when(!vias
                        geDeselectObject(car(wire))
                    )
                    matchingLayers = nil
                    foreach(via vias
                        viaLayers = via~>viaHeader~>master~>layerHeaders~>layer
                        when(member(car(wire)~>layerName viaLayers)
                            matchingLayers = t
                        )
                    )
                    when(!matchingLayers
                        geDeselectObject(car(wire)) 
                    )
                )
            )
        )
        t
    )
)

procedure(GGRemoveDanglingWires()
    let((cv wires width beginPt beginY endPt endY xy x y allwirevias wiresplitlist newwires viaLayers wlayer win points)
        cv  = geGetEditCellView()
        win = hiGetCurrentWindow()
        win~>spineSelection = nil
        points = enterLine( 
            ?prompts    '( "Please select objects by line" )
            ?doneProc   "_GGRemoveDanglingWiresSelectByLine"   
            ?wantPoints 2   
        )
        wires = setof(obj geGetSelectedSet() obj~>objType == "pathSeg" && pteIsVisible(buildString(obj~>lpp) "Layers"))
        if(!wires then
            hiDisplayAppDBox(
                ?name           'msgBox
                ?dialogType     hicInformationDialog
                ?dboxBanner     "Split wires by via"
                ?dboxText       "Please select wires and try again"
                ?buttonLayout   'Close
            )
            geDeselectAll()
        else
            foreach(wire wires
                wlayer  = wire~>layerName
                width   = wire~>width
                beginPt = wire~>beginPt
                endPt   = wire~>endPt  
                beginY  = yCoord(beginPt)
                endY    = yCoord(endPt)
                allwirevias = leSearchHierarchy(cv wire~>bBox 0 "via" nil)
                wiresplitlist = list(wire)
                foreach( wvia allwirevias
                    xy = wvia~>xy 
                    x  = car(xy)
                    y  = cadr(xy)
                    viaLayers = wvia~>viaHeader~>master~>layerHeaders~>layer
                    when(member(wlayer viaLayers)
                        foreach(spltwire wiresplitlist
                            if(beginY == endY then
                                newwires = leChopShape( spltwire list(x:y-width x:y+width x:y+width x:y-width) nil t )
                            else
                                newwires = leChopShape( spltwire list(x-width:y x+width:y x+width:y x-width:y) nil t )
                            )
                            wiresplitlist = remd( spltwire wiresplitlist )
                            when(newwires
                                wiresplitlist = append(wiresplitlist newwires)
                            )
                        )
                    )
                )
            )
            geDeselectAll()
            _GGRemoveDanglingWiresSelectByLine( win t points )
            foreach(obj geGetSelectedSet() dbDeleteObject(obj))
            win~>spineSelection = t
        )
        t
    )
)

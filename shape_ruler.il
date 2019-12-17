;hiSetBindKey("Layout" "Shift<Key>1" "shaperuler()")
procedure(shaperuler()
	prog((cv obj xlist ylist path)
		cv = geGetWindowCellView()
		obj = car(geGetSelSet(cv))
		case(obj->objType
			(("rect" "inst")
				path = obj->bBox
				xlist = list(lowerLeft(path) list(xCoord(upperRight(path)) yCoord(lowerLeft(path))))
				ylist = list(lowerLeft(path) list(xCoord(lowerLeft(path)) yCoord(upperRight(path))))
				leCreateRuler(cv xlist)
				leCreateRuler(cv ylist)
			)
			(("path")
				leCreateRuler(cv obj->points)
			)
			(t
				hiDisplayModelessDBox('form "Error Window" "No Select object(rect/cell/path )" "" "")
			)
		)
	)
);procedure

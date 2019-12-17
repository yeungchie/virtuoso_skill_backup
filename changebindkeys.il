;
;
foreach(x list("Layout" "Schematics" "Symbol")
	hiSetBindKeys(x
		list(
			list("None<Btn4Down>"		"geScroll(nil \"n\" nil)"						)
			list("None<Btn5Down>"		"geScroll(nil \"s\" nil)"						)
			list("Shift<Btn4Down>"		"geScroll(nil \"w\" nil)"						)
			list("Shift<Btn5Down>"		"geScroll(nil \"e\" nil)"						)
			list("Ctrl<Btn4Down>"		"geScroll(nil \"w\" nil)"						)
			list("Ctrl<Btn4Down>"		"hiZoomRelativeScale(getCurrentWindow() 1.25)"	)
			list("Ctrl<Btn5Down>"		"hiZoomRelativeScale(getCurrentWindow() 0.80)"	)
			list("<Key>D"				"geDeselectAllFig()"							)
			list("Ctrl<Key>D"			"geSubSelectPoint()"							)
		)
	)
);foreach
;
;Layout
hiSetBindKeys("Layout"
	list(
		list("Ctrl<Key>M"			"leHiModifyCorner()"							)
		list("<Key>H"				"leHiSize()"									)
		list("Ctrl<Key>G"			"leHiLayerGen()"								)
		;list("<Key>F7"				"leToggleDrdMode()"								)
		;list("<Key>F5"				"ddsOpenLibManager()"							)
		list("<Key>J"				"leHiConvertPolygonToPath()"					)
		list("Shift<Key>J"			"leHiConvertShapeToPolygon()"					)
	)
)
;
;

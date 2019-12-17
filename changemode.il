procedure(changemode()
	prog(()
		cond(
			(geGetEditCellView()~>mode=="a"
				geChangeEditMode("r")
			)
			(geGetEditCellView()~>mode=="r"
				geChangeEditMode("a")
			)
			(t
				return(nil)
			)
		)
	)
)

foreach(x list("Layout" "Schematics" "Symbol")
	hiSetBindKey(x	"<Key>F12" "changemode()")
)

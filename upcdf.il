procedure(upcdf(lib_name)
	prog((libId viewName listOfCells cellList cellName cvId evalParam value cdfgData callback)
		foreach(x list("fingers" "m" "segW" "segL" "w" "l")
			libId = ddGetObj(lib_name)
			viewName = "schematic"
			listOfCells = libId~>cells
			cellList = setof(cell listOfCells member(viewName cell~>views~>name))
			foreach(cell cellList
				cellName = cell~>name
				cvId = dbOpenCellViewByType(lib_name cellName viewName nil "a")
				foreach(instRef cvId~>instances
					sprintf(evalParam "instRef~>%s" x)
					when(value = evalstring(evalParam)
						printf("%s of %s is %L\n" x instRef~>name value)
						cdfgData = cdfGetInstCDF(instRef)
						callback = get(cdfgData x)~>callback
						when(callback && (nequal callback "")
							errset(evalstring(callback) t)
						)
					)
				)
				schCheck(cvId)
				dbSave(cvId)
			)
		)
	)
)

;hiSetBindKey("Layout" "<Key>F1" "CrossRuler(1 20)")
;hiSetBindKey("Layout" "Shift<Key>F1" "CrossRuler(2 3)")
procedure(CrossRuler(@optional (type 1) (Length 20))
	prog((start_point)
		leClearAllRuler(getEditRep())
		start_point = hiGetPoint(hiGetCurrentWindow())
		case(type
			(1
				leCreateRuler(getEditRep() list(start_point car(start_point) + Length : cadr(start_point)))
				leCreateRuler(getEditRep() list(start_point car(start_point) - Length : cadr(start_point)))
				leCreateRuler(getEditRep() list(start_point car(start_point) : cadr(start_point) + Length))
				leCreateRuler(getEditRep() list(start_point car(start_point) : cadr(start_point) - Length))
			)
			(2
				leCreateRuler(getEditRep() list(start_point car(start_point) + Length : cadr(start_point) + Length))
				leCreateRuler(getEditRep() list(start_point car(start_point) - Length : cadr(start_point) - Length))
				leCreateRuler(getEditRep() list(start_point car(start_point) + Length : cadr(start_point) - Length))
				leCreateRuler(getEditRep() list(start_point car(start_point) - Length : cadr(start_point) + Length))
			)
			(t)
		)
	)
); procedure

return {
	_rule_ = {
		none = {
			select_hundreds_place = {
				path = "select_hundreds_place",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UIControlScrollFlow"
				}
			},
			select_tens_place = {
				path = "select_tens_place",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UIControlScrollFlow"
				}
			},
			select_ones_place = {
				path = "select_ones_place",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UIControlScrollFlow"
				}
			}
		},
		ui_scroll_end = {
			select_hundreds_place = {
				tp = "UIControlScrollFlow"
			},
			select_tens_place = {
				tp = "UIControlScrollFlow"
			},
			select_ones_place = {
				tp = "UIControlScrollFlow"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			furniture_btn = {
				path = "furniture_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"ClickAndLongClickEvent",
					"PointerDownUpEvent",
					"DragableItem"
				}
			}
		},
		click = {
			furniture_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		drag = {
			furniture_btn = {
				tp = "DragableItem"
			}
		},
		click_and_long_click = {
			furniture_btn = {
				tp = "ClickAndLongClickEvent"
			}
		},
		pointer_down_up = {
			furniture_btn = {
				tp = "PointerDownUpEvent"
			}
		},
		canvas_set = {}
	}
}

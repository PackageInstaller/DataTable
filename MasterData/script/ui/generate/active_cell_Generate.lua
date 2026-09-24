return {
	_rule_ = {
		none = {
			pic_icon = {
				path = "pic_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			select_bg = {
				path = "select_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			pic_icon = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

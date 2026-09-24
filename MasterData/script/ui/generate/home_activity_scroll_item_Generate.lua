return {
	_rule_ = {
		none = {
			enter = {
				path = "enter",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"PointerDownUpEvent"
				}
			},
			mask_banar = {
				path = "mask_banar",
				list = {
					statis_text = {
						path = "mask_banar/statis_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					static_text2 = {
						path = "mask_banar/static_text2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			enter = {
				tp = "UnityEngine.UI.Button"
			}
		},
		pointer_down_up = {
			enter = {
				tp = "PointerDownUpEvent"
			}
		},
		canvas_set = {}
	}
}

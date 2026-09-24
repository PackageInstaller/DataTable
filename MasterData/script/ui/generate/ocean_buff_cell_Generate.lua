return {
	_rule_ = {
		none = {
			sign_bg = {
				path = "sign_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			detail_txt = {
				path = "detail_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter",
					"UnityEngine.UI.Button"
				}
			}
		},
		click = {
			detail_txt = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

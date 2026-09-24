return {
	_rule_ = {
		none = {
			btn = {
				path = "btn",
				list = {
					title = {
						path = "btn/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					pro_num = {
						path = "btn/pro_num",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		click = {
			btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					node = {
						path = "bg/node",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
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
			bg = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

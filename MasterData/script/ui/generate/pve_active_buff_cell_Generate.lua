return {
	_rule_ = {
		none = {
			buff_bg = {
				path = "buff_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			buff_image = {
				path = "buff_image",
				list = {
					buff_lv = {
						path = "buff_image/buff_lv",
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
			},
			buff_desc = {
				path = "buff_desc",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			},
			buff_button = {
				path = "buff_button",
				list = {
					cost_num = {
						path = "buff_button/cost_num",
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
			buff_button = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

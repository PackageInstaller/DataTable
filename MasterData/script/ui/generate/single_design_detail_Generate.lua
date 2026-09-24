return {
	_rule_ = {
		none = {
			name_txt = {
				path = "name_txt",
				list = {
					name_txt_1 = {
						path = "name_txt/name_txt_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_txt_2 = {
						path = "name_txt/name_txt_2",
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
					"UnityEngine.UI.Mask",
					"TextHorizonScroller",
					"UnityEngine.UI.Image"
				}
			},
			bg_line2 = {
				path = "bg_line2",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		canvas_set = {}
	}
}

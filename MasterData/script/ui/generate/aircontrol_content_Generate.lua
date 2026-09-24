return {
	_rule_ = {
		none = {
			aircontrol_bg = {
				path = "aircontrol_bg",
				list = {
					buff_name = {
						path = "aircontrol_bg/buff_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.CanvasGroup"
						}
					},
					aircontrol_img = {
						path = "aircontrol_bg/aircontrol_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup"
				}
			}
		},
		canvas_set = {}
	}
}

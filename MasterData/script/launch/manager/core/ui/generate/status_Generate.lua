return {
	_rule_ = {
		none = {
			percent = {
				path = "percent",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Text"
				}
			},
			status_text = {
				path = "status_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Text"
				}
			},
			details = {
				path = "details",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Text"
				}
			},
			progress = {
				path = "progress",
				list = {
					front = {
						path = "progress/front",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image"
				}
			}
		}
	}
}

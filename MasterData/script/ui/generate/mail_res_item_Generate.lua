return {
	_rule_ = {
		none = {
			item_name = {
				path = "item_name",
				list = {
					item_des = {
						path = "item_name/item_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					item_des_add = {
						path = "item_name/item_des_add",
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
					"UnityEngine.UI.Mask",
					"TextScroller",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			get_icon = {
				path = "get_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			line = {
				path = "line",
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

return {
	_rule_ = {
		none = {
			lvl_bg = {
				path = "lvl_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			detail_mask = {
				path = "detail_mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask",
					"TextScroller"
				}
			},
			detail_txt = {
				path = "detail_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			}
		},
		canvas_set = {}
	}
}

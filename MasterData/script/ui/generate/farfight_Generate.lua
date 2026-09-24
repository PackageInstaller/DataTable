return {
	_rule_ = {
		none = {
			scroll_view = {
				path = "scroll_view",
				list = {
					viewport = {
						path = "scroll_view/viewport",
						list = {
							content = {
								path = "scroll_view/viewport/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.VerticalLayoutGroup",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.ScrollRect",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			role_scroll_view = {
				path = "role_scroll_view",
				list = {
					viewport = {
						path = "role_scroll_view/viewport",
						list = {
							content = {
								path = "role_scroll_view/viewport/content",
								list = {},
								component = {
									"UnityEngine.RectTransform"
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
					"UnityEngine.CanvasRenderer",
					"LatticeScrollRect",
					"UnityEngine.UI.Image"
				}
			}
		},
		canvas_set = {}
	}
}

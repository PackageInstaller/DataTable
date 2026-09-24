return {
	_rule_ = {
		none = {
			scroll_view = {
				path = "scroll_view",
				list = {
					Viewport = {
						path = "scroll_view/Viewport",
						list = {
							Content = {
								path = "scroll_view/Viewport/Content",
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
			},
			select_big_server_item = {
				path = "select_big_server_item",
				list = {
					bar_bg = {
						path = "select_big_server_item/bar_bg",
						list = {
							server_name = {
								path = "select_big_server_item/bar_bg/server_name",
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
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["select_big_server_item/bar_bg"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

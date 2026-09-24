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
					},
					image = {
						path = "scroll_view/image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					scrollbar_vertical = {
						path = "scroll_view/scrollbar_vertical",
						list = {
							sliding_area = {
								path = "scroll_view/scrollbar_vertical/sliding_area",
								list = {
									handle = {
										path = "scroll_view/scrollbar_vertical/sliding_area/handle",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Scrollbar"
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
			info_text = {
				path = "info_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			}
		},
		canvas_set = {}
	}
}

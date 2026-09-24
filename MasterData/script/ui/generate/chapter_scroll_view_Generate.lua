return {
	_rule_ = {
		none = {
			curve_scroll_rect = {
				path = "curve_scroll_rect",
				list = {
					viewport = {
						path = "curve_scroll_rect/viewport",
						list = {
							edge_mask = {
								path = "curve_scroll_rect/viewport/edge_mask",
								list = {
									content = {
										path = "curve_scroll_rect/viewport/edge_mask/content",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask"
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
					select_bg_img = {
						path = "curve_scroll_rect/select_bg_img",
						list = {
							select_text = {
								path = "curve_scroll_rect/select_bg_img/select_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							select_icon = {
								path = "curve_scroll_rect/select_bg_img/select_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"CurveScrollRect",
					"UnityEngine.UI.Image"
				}
			}
		},
		canvas_set = {}
	}
}

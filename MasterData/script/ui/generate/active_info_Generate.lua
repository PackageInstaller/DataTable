return {
	_rule_ = {
		none = {
			all_active = {
				path = "all_active",
				list = {
					Viewport = {
						path = "all_active/Viewport",
						list = {
							Scrollbar = {
								path = "all_active/Viewport/Scrollbar",
								list = {
									["Sliding Area"] = {
										path = "all_active/Viewport/Scrollbar/Sliding Area",
										list = {
											Handle = {
												path = "all_active/Viewport/Scrollbar/Sliding Area/Handle",
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
							},
							edge_mask = {
								path = "all_active/Viewport/edge_mask",
								list = {
									Content = {
										path = "all_active/Viewport/edge_mask/Content",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"EndlessScrollView",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
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

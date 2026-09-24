return {
	_rule_ = {
		none = {
			lattice_scroll_view = {
				path = "lattice_scroll_view",
				list = {
					viewport = {
						path = "lattice_scroll_view/viewport",
						list = {
							content = {
								path = "lattice_scroll_view/viewport/content",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.RectMask2D"
						}
					},
					next_page_btn = {
						path = "lattice_scroll_view/next_page_btn",
						list = {
							next_page_spine = {
								path = "lattice_scroll_view/next_page_btn/next_page_spine",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					last_page_btn = {
						path = "lattice_scroll_view/last_page_btn",
						list = {
							last_page_spine = {
								path = "lattice_scroll_view/last_page_btn/last_page_spine",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"LatticeScrollRect",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			["lattice_scroll_view/next_page_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["lattice_scroll_view/last_page_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

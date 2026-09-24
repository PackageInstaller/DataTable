return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			content = {
				path = "content",
				list = {
					bg_layer = {
						path = "content/bg_layer",
						list = {
							bg = {
								path = "content/bg_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mask = {
								path = "content/bg_layer/mask",
								list = {
									glow = {
										path = "content/bg_layer/mask/glow",
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
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask"
								}
							},
							cover = {
								path = "content/bg_layer/cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							coner = {
								path = "content/bg_layer/coner",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_bg = {
								path = "content/bg_layer/title_bg",
								list = {
									arrow = {
										path = "content/bg_layer/title_bg/arrow",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/bg_layer/title_bg/title",
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
									"UnityEngine.UI.Image"
								}
							},
							close_btn = {
								path = "content/bg_layer/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							line = {
								path = "content/bg_layer/line",
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
							"UnityEngine.CanvasRenderer"
						}
					},
					scroll = {
						path = "content/scroll",
						list = {
							Viewport = {
								path = "content/scroll/Viewport",
								list = {
									Content = {
										path = "content/scroll/Viewport/Content",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"EndlessScrollView"
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
							Scrollbar = {
								path = "content/scroll/Scrollbar",
								list = {
									["Sliding Area"] = {
										path = "content/scroll/Scrollbar/Sliding Area",
										list = {
											Handle = {
												path = "content/scroll/Scrollbar/Sliding Area/Handle",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		call_node_list = {
			["ship_available/content/scroll/Scrollbar/Sliding Area"] = "_control.content.scroll.Scrollbar.Sliding Area",
			["ship_available/content/bg_layer/mask/glow"] = "_control.content.bg_layer.mask.glow",
			["ship_available/bg"] = "_control.bg",
			["ship_available/content/bg_layer/bg"] = "_control.content.bg_layer.bg",
			["ship_available/content/scroll/Scrollbar/Sliding Area/Handle"] = "_control.content.scroll.Scrollbar.Sliding Area.Handle",
			["ship_available/content/bg_layer/mask"] = "_control.content.bg_layer.mask",
			["ship_available/content/bg_layer/title_bg"] = "_control.content.bg_layer.title_bg",
			["ship_available/content/scroll/Scrollbar"] = "_control.content.scroll.Scrollbar",
			["ship_available/content/bg_layer/coner"] = "_control.content.bg_layer.coner",
			["ship_available/content/scroll/Viewport"] = "_control.content.scroll.Viewport",
			["ship_available/content/bg_layer/title_bg/arrow"] = "_control.content.bg_layer.title_bg.arrow",
			["ship_available/content/scroll/Viewport/Content"] = "_control.content.scroll.Viewport.Content",
			["ship_available/content/bg_layer/title_bg/title"] = "_control.content.bg_layer.title_bg.title",
			["ship_available/content/scroll"] = "_control.content.scroll",
			["ship_available/content"] = "_control.content",
			["ship_available/content/bg_layer/line"] = "_control.content.bg_layer.line",
			["ship_available/content/bg_layer/cover"] = "_control.content.bg_layer.cover",
			["ship_available/content/bg_layer"] = "_control.content.bg_layer",
			["ship_available/content/bg_layer/close_btn"] = "_control.content.bg_layer.close_btn"
		},
		scale_btn_click = {
			["content/bg_layer/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

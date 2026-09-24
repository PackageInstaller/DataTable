return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					bg_container = {
						path = "bg/bg_container",
						list = {
							mask_bg = {
								path = "bg/bg_container/mask_bg",
								list = {
									bg_blue_top = {
										path = "bg/bg_container/mask_bg/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top2 = {
										path = "bg/bg_container/mask_bg/bg_blue_top2",
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
							bg_blue_top3 = {
								path = "bg/bg_container/bg_blue_top3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "bg/bg_container/title",
								list = {
									three_point = {
										path = "bg/bg_container/title/three_point",
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
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					close_btn = {
						path = "bg/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					left_scrollview = {
						path = "bg/left_scrollview",
						list = {
							viewport = {
								path = "bg/left_scrollview/viewport",
								list = {
									content = {
										path = "bg/left_scrollview/viewport/content",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					right_scrollview = {
						path = "bg/right_scrollview",
						list = {
							viewport = {
								path = "bg/right_scrollview/viewport",
								list = {
									content = {
										path = "bg/right_scrollview/viewport/content",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					award = {
						path = "bg/award",
						list = {
							frame = {
								path = "bg/award/frame",
								list = {
									icon = {
										path = "bg/award/frame/icon",
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
									"UnityEngine.UI.Button"
								}
							},
							desc_layer = {
								path = "bg/award/desc_layer",
								list = {
									dot = {
										path = "bg/award/desc_layer/dot",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									desc = {
										path = "bg/award/desc_layer/desc",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							btn = {
								path = "bg/award/btn",
								list = {
									txt = {
										path = "bg/award/btn/txt",
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
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					icon_tip = {
						path = "bg/icon_tip",
						list = {
							bg = {
								path = "bg/icon_tip/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "bg/icon_tip/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							content = {
								path = "bg/icon_tip/content",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/award/frame"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/award/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/icon_tip"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

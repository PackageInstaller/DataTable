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
									"UnityEngine.UI.HorizontalLayoutGroup",
									"UnityEngine.UI.ContentSizeFitter",
									"UITweenSequence"
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
			user_core_bar = {
				path = "scroll_view/user_core_bar",
				list = {
					right_upon = {
						path = "scroll_view/user_core_bar/right_upon",
						list = {
							up_right_bg = {
								path = "scroll_view/user_core_bar/right_upon/up_right_bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							dd_core = {
								path = "scroll_view/user_core_bar/right_upon/dd_core",
								list = {
									dd_txt = {
										path = "scroll_view/user_core_bar/right_upon/dd_core/dd_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									dd_icon = {
										path = "scroll_view/user_core_bar/right_upon/dd_core/dd_icon",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							ca_core = {
								path = "scroll_view/user_core_bar/right_upon/ca_core",
								list = {
									ca_txt = {
										path = "scroll_view/user_core_bar/right_upon/ca_core/ca_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									ca_icon = {
										path = "scroll_view/user_core_bar/right_upon/ca_core/ca_icon",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							bb_core = {
								path = "scroll_view/user_core_bar/right_upon/bb_core",
								list = {
									bb_txt = {
										path = "scroll_view/user_core_bar/right_upon/bb_core/bb_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									bb_icon = {
										path = "scroll_view/user_core_bar/right_upon/bb_core/bb_icon",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							cv_core = {
								path = "scroll_view/user_core_bar/right_upon/cv_core",
								list = {
									cv_txt = {
										path = "scroll_view/user_core_bar/right_upon/cv_core/cv_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									cv_icon = {
										path = "scroll_view/user_core_bar/right_upon/cv_core/cv_icon",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							ss_core = {
								path = "scroll_view/user_core_bar/right_upon/ss_core",
								list = {
									ss_txt = {
										path = "scroll_view/user_core_bar/right_upon/ss_core/ss_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									ss_icon = {
										path = "scroll_view/user_core_bar/right_upon/ss_core/ss_icon",
										list = {},
										component = {
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
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			difficulty_btn = {
				path = "difficulty_btn",
				list = {
					SkeletonGraphic = {
						path = "difficulty_btn/SkeletonGraphic",
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
			difficulty_text = {
				path = "difficulty_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			revent_btn = {
				path = "revent_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			revent_txt = {
				path = "revent_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["campaign/scroll_view/user_core_bar/right_upon/cv_core/cv_txt"] = "_control.user_core_bar.right_upon.cv_core.cv_txt",
			["campaign/scroll_view/user_core_bar/right_upon/cv_core"] = "_control.user_core_bar.right_upon.cv_core",
			["campaign/scroll_view/user_core_bar"] = "_control.user_core_bar",
			["campaign/revent_txt"] = "_control.revent_txt",
			["campaign/scroll_view/user_core_bar/right_upon/dd_core"] = "_control.user_core_bar.right_upon.dd_core",
			["campaign/scroll_view/user_core_bar/right_upon/bb_core"] = "_control.user_core_bar.right_upon.bb_core",
			["campaign/scroll_view/user_core_bar/right_upon/up_right_bg"] = "_control.user_core_bar.right_upon.up_right_bg",
			["campaign/scroll_view/user_core_bar/right_upon/cv_core/cv_icon"] = "_control.user_core_bar.right_upon.cv_core.cv_icon",
			["campaign/scroll_view/user_core_bar/right_upon/ca_core/ca_icon"] = "_control.user_core_bar.right_upon.ca_core.ca_icon",
			["campaign/scroll_view/user_core_bar/right_upon/ca_core/ca_txt"] = "_control.user_core_bar.right_upon.ca_core.ca_txt",
			["campaign/scroll_view"] = "_control.scroll_view",
			["campaign/scroll_view/user_core_bar/right_upon/bb_core/bb_icon"] = "_control.user_core_bar.right_upon.bb_core.bb_icon",
			["campaign/scroll_view/user_core_bar/right_upon/dd_core/dd_icon"] = "_control.user_core_bar.right_upon.dd_core.dd_icon",
			["campaign/scroll_view/user_core_bar/right_upon/ca_core"] = "_control.user_core_bar.right_upon.ca_core",
			["campaign/scroll_view/user_core_bar/right_upon/ss_core"] = "_control.user_core_bar.right_upon.ss_core",
			["campaign/difficulty_btn"] = "_control.difficulty_btn",
			["campaign/scroll_view/user_core_bar/right_upon/ss_core/ss_icon"] = "_control.user_core_bar.right_upon.ss_core.ss_icon",
			["campaign/scroll_view/viewport"] = "_control.scroll_view.viewport",
			["campaign/scroll_view/user_core_bar/right_upon/ss_core/ss_txt"] = "_control.user_core_bar.right_upon.ss_core.ss_txt",
			["campaign/difficulty_btn/SkeletonGraphic"] = "_control.difficulty_btn.SkeletonGraphic",
			["campaign/difficulty_text"] = "_control.difficulty_text",
			["campaign/scroll_view/viewport/content"] = "_control.scroll_view.viewport.content",
			["campaign/revent_btn"] = "_control.revent_btn",
			["campaign/scroll_view/user_core_bar/right_upon/bb_core/bb_txt"] = "_control.user_core_bar.right_upon.bb_core.bb_txt",
			["campaign/scroll_view/user_core_bar/right_upon"] = "_control.user_core_bar.right_upon",
			["campaign/scroll_view/user_core_bar/right_upon/dd_core/dd_txt"] = "_control.user_core_bar.right_upon.dd_core.dd_txt"
		},
		click = {
			difficulty_btn = {
				tp = "UnityEngine.UI.Button"
			},
			revent_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

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
			top = {
				path = "top",
				list = {
					return_btn = {
						path = "top/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					title_txt = {
						path = "top/title_txt",
						list = {
							music_tip_bg = {
								path = "top/title_txt/music_tip_bg",
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
					},
					tip_txt = {
						path = "top/tip_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line_bg = {
						path = "top/line_bg",
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
			},
			music_reset_btn = {
				path = "music_reset_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			scrollview = {
				path = "scrollview",
				list = {
					left_line_bg = {
						path = "scrollview/left_line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					viewport = {
						path = "scrollview/viewport",
						list = {
							content = {
								path = "scrollview/viewport/content",
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
						path = "scrollview/Scrollbar",
						list = {
							["Sliding Area"] = {
								path = "scrollview/Scrollbar/Sliding Area",
								list = {
									Handle = {
										path = "scrollview/Scrollbar/Sliding Area/Handle",
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
			music_box_anim = {
				path = "music_box_anim",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.MeshFilter",
					"UnityEngine.MeshRenderer",
					"Spine.Unity.SkeletonAnimation"
				}
			},
			music_icon = {
				path = "music_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			reset_bgm_layer = {
				path = "reset_bgm_layer",
				list = {
					bg = {
						path = "reset_bgm_layer/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg_top = {
						path = "reset_bgm_layer/bg_top",
						list = {
							mask_bg = {
								path = "reset_bgm_layer/bg_top/mask_bg",
								list = {
									bg_blue_top = {
										path = "reset_bgm_layer/bg_top/mask_bg/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top2 = {
										path = "reset_bgm_layer/bg_top/mask_bg/bg_blue_top2",
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
								path = "reset_bgm_layer/bg_top/bg_blue_top3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "reset_bgm_layer/bg_top/title",
								list = {
									three_point = {
										path = "reset_bgm_layer/bg_top/title/three_point",
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
							},
							bg_line = {
								path = "reset_bgm_layer/bg_top/bg_line",
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
					},
					tip_txt = {
						path = "reset_bgm_layer/tip_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					ok_btn = {
						path = "reset_bgm_layer/ok_btn",
						list = {
							txt = {
								path = "reset_bgm_layer/ok_btn/txt",
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
					},
					cancel_btn = {
						path = "reset_bgm_layer/cancel_btn",
						list = {
							txt = {
								path = "reset_bgm_layer/cancel_btn/txt",
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
					"UIScaleTweener",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		call_node_list = {
			["music/reset_bgm_layer"] = "_control.reset_bgm_layer",
			["music/reset_bgm_layer/bg_top/title"] = "_control.reset_bgm_layer.bg_top.title",
			["music/music_reset_btn"] = "_control.music_reset_btn",
			["music/scrollview/Scrollbar/Sliding Area"] = "_control.scrollview.Scrollbar.Sliding Area",
			["music/scrollview/viewport"] = "_control.scrollview.viewport",
			["music/reset_bgm_layer/ok_btn/txt"] = "_control.reset_bgm_layer.ok_btn.txt",
			["music/reset_bgm_layer/bg_top/mask_bg/bg_blue_top"] = "_control.reset_bgm_layer.bg_top.mask_bg.bg_blue_top",
			["music/top/return_btn"] = "_control.top.return_btn",
			["music/reset_bgm_layer/bg_top/mask_bg"] = "_control.reset_bgm_layer.bg_top.mask_bg",
			["music/reset_bgm_layer/bg_top"] = "_control.reset_bgm_layer.bg_top",
			["music/reset_bgm_layer/bg_top/bg_blue_top3"] = "_control.reset_bgm_layer.bg_top.bg_blue_top3",
			["music/top/title_txt/music_tip_bg"] = "_control.top.title_txt.music_tip_bg",
			["music/top"] = "_control.top",
			["music/scrollview/Scrollbar"] = "_control.scrollview.Scrollbar",
			["music/reset_bgm_layer/bg_top/title/three_point"] = "_control.reset_bgm_layer.bg_top.title.three_point",
			["music/top/line_bg"] = "_control.top.line_bg",
			["music/music_icon"] = "_control.music_icon",
			["music/reset_bgm_layer/bg_top/mask_bg/bg_blue_top2"] = "_control.reset_bgm_layer.bg_top.mask_bg.bg_blue_top2",
			["music/reset_bgm_layer/bg_top/bg_line"] = "_control.reset_bgm_layer.bg_top.bg_line",
			["music/reset_bgm_layer/tip_txt"] = "_control.reset_bgm_layer.tip_txt",
			["music/reset_bgm_layer/ok_btn"] = "_control.reset_bgm_layer.ok_btn",
			["music/bg"] = "_control.bg",
			["music/top/title_txt"] = "_control.top.title_txt",
			["music/scrollview/left_line_bg"] = "_control.scrollview.left_line_bg",
			["music/scrollview/viewport/content"] = "_control.scrollview.viewport.content",
			["music/music_box_anim"] = "_control.music_box_anim",
			["music/reset_bgm_layer/bg"] = "_control.reset_bgm_layer.bg",
			["music/scrollview"] = "_control.scrollview",
			["music/top/tip_txt"] = "_control.top.tip_txt",
			["music/scrollview/Scrollbar/Sliding Area/Handle"] = "_control.scrollview.Scrollbar.Sliding Area.Handle",
			["music/reset_bgm_layer/cancel_btn"] = "_control.reset_bgm_layer.cancel_btn",
			["music/reset_bgm_layer/cancel_btn/txt"] = "_control.reset_bgm_layer.cancel_btn.txt"
		},
		click = {
			["top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			music_reset_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["reset_bgm_layer/ok_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["reset_bgm_layer/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			music_icon = {
				component = "UnityEngine.Canvas",
				path = "music_icon"
			},
			reset_bgm_layer = {
				component = "UnityEngine.Canvas",
				path = "reset_bgm_layer"
			}
		}
	}
}

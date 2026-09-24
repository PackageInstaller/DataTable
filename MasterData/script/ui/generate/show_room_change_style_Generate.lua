return {
	_rule_ = {
		none = {
			move_tween = {
				path = "move_tween",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			change_style_framework = {
				path = "change_style_framework",
				list = {
					bg_container = {
						path = "change_style_framework/bg_container",
						list = {
							blue_top = {
								path = "change_style_framework/bg_container/blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_cover = {
								path = "change_style_framework/bg_container/bg_cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							three_point = {
								path = "change_style_framework/bg_container/three_point",
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
					close_btn = {
						path = "change_style_framework/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					black_line = {
						path = "change_style_framework/black_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					styleselect = {
						path = "change_style_framework/styleselect",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					changestyle = {
						path = "change_style_framework/changestyle",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					bg_test = {
						path = "change_style_framework/bg_test",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					use_btn = {
						path = "change_style_framework/use_btn",
						list = {
							use = {
								path = "change_style_framework/use_btn/use",
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
							"UnityEngine.UI.Button",
							"UnityEngine.UI.Shadow"
						}
					},
					use_btn_lock = {
						path = "change_style_framework/use_btn_lock",
						list = {
							use = {
								path = "change_style_framework/use_btn_lock/use",
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
							"UnityEngine.UI.Shadow"
						}
					},
					style_bg = {
						path = "change_style_framework/style_bg",
						list = {
							tip_1 = {
								path = "change_style_framework/style_bg/tip_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							tip_2 = {
								path = "change_style_framework/style_bg/tip_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							tip_2_lock = {
								path = "change_style_framework/style_bg/tip_2_lock",
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
					content = {
						path = "change_style_framework/content",
						list = {
							style_default = {
								path = "change_style_framework/content/style_default",
								list = {
									normal = {
										path = "change_style_framework/content/style_default/normal",
										list = {
											selected = {
												path = "change_style_framework/content/style_default/normal/selected",
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
									},
									lock_txt = {
										path = "change_style_framework/content/style_default/lock_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									text = {
										path = "change_style_framework/content/style_default/text",
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
									"UnityEngine.UI.Toggle"
								}
							},
							style_1 = {
								path = "change_style_framework/content/style_1",
								list = {
									normal = {
										path = "change_style_framework/content/style_1/normal",
										list = {
											selected = {
												path = "change_style_framework/content/style_1/normal/selected",
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
									},
									lock_txt = {
										path = "change_style_framework/content/style_1/lock_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									text = {
										path = "change_style_framework/content/style_1/text",
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
									"UnityEngine.UI.Toggle"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["change_style_framework/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["change_style_framework/use_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["change_style_framework/content/style_default"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["change_style_framework/content/style_1"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

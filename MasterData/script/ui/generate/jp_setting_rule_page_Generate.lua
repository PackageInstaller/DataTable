return {
	_rule_ = {
		none = {
			shadow = {
				path = "shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup"
				}
			},
			tip_layer = {
				path = "tip_layer",
				list = {
					bg = {
						path = "tip_layer/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg_container = {
						path = "tip_layer/bg_container",
						list = {
							black_line = {
								path = "tip_layer/bg_container/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top = {
								path = "tip_layer/bg_container/bg_blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_2 = {
								path = "tip_layer/bg_container/bg_blue_top_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_3 = {
								path = "tip_layer/bg_container/bg_blue_top_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "tip_layer/bg_container/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							three_point = {
								path = "tip_layer/bg_container/three_point",
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
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					setting_rule_button_1 = {
						path = "tip_layer/setting_rule_button_1",
						list = {
							txt = {
								path = "tip_layer/setting_rule_button_1/txt",
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
					setting_rule_button_2 = {
						path = "tip_layer/setting_rule_button_2",
						list = {
							txt = {
								path = "tip_layer/setting_rule_button_2/txt",
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
					setting_rule_button_3 = {
						path = "tip_layer/setting_rule_button_3",
						list = {
							txt = {
								path = "tip_layer/setting_rule_button_3/txt",
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
					setting_rule_button_4 = {
						path = "tip_layer/setting_rule_button_4",
						list = {
							txt = {
								path = "tip_layer/setting_rule_button_4/txt",
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
					unfree_diamond_image = {
						path = "tip_layer/unfree_diamond_image",
						list = {
							text = {
								path = "tip_layer/unfree_diamond_image/text",
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
					free_diamond_image = {
						path = "tip_layer/free_diamond_image",
						list = {
							text = {
								path = "tip_layer/free_diamond_image/text",
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
					close = {
						path = "tip_layer/close",
						list = {},
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
			["tip_layer/setting_rule_button_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip_layer/setting_rule_button_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip_layer/setting_rule_button_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip_layer/setting_rule_button_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip_layer/close"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

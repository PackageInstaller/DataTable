return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			tactics_bg = {
				path = "tactics_bg",
				list = {
					close_btn = {
						path = "tactics_bg/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					center = {
						path = "tactics_bg/center",
						list = {
							adjutant_border = {
								path = "tactics_bg/center/adjutant_border",
								list = {
									adjutant_image = {
										path = "tactics_bg/center/adjutant_border/adjutant_image",
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
							card_lable = {
								path = "tactics_bg/center/card_lable",
								list = {
									card_title = {
										path = "tactics_bg/center/card_lable/card_title",
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
									"UnityEngine.UI.Text"
								}
							},
							desc_lable = {
								path = "tactics_bg/center/desc_lable",
								list = {
									desc_txt = {
										path = "tactics_bg/center/desc_lable/desc_txt",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							split_line = {
								path = "tactics_bg/center/split_line",
								list = {
									split_line_2 = {
										path = "tactics_bg/center/split_line/split_line_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									decoration_point = {
										path = "tactics_bg/center/split_line/decoration_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									decoration_point_2 = {
										path = "tactics_bg/center/split_line/decoration_point_2",
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
							bottom_btn = {
								path = "tactics_bg/center/bottom_btn",
								list = {
									title = {
										path = "tactics_bg/center/bottom_btn/title",
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
							"UnityEngine.UI.Image"
						}
					},
					left_btn = {
						path = "tactics_bg/left_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					right_btn = {
						path = "tactics_bg/right_btn",
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
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			["tactics_bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tactics_bg/center/bottom_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tactics_bg/left_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tactics_bg/right_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

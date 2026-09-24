return {
	_rule_ = {
		none = {
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			title = {
				path = "bg/title",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			line = {
				path = "bg/line",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			main = {
				path = "bg/main",
				list = {
					main_text = {
						path = "bg/main/main_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					input_main = {
						path = "bg/main/input_main",
						list = {
							bg = {
								path = "bg/main/input_main/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "bg/main/input_main/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							inputfield_1 = {
								path = "bg/main/input_main/inputfield_1",
								list = {
									Placeholder = {
										path = "bg/main/input_main/inputfield_1/Placeholder",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									text = {
										path = "bg/main/input_main/inputfield_1/text",
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
									"UnityEngine.UI.InputField"
								}
							},
							inputfield_2 = {
								path = "bg/main/input_main/inputfield_2",
								list = {
									Placeholder = {
										path = "bg/main/input_main/inputfield_2/Placeholder",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									text = {
										path = "bg/main/input_main/inputfield_2/text",
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
									"UnityEngine.UI.InputField"
								}
							},
							btn = {
								path = "bg/main/input_main/btn",
								list = {
									text = {
										path = "bg/main/input_main/btn/text",
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
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["real_name_box/bg/main/input_main/inputfield_2/text"] = "_control.main.input_main.inputfield_2.text",
			["real_name_box/bg/main/main_text"] = "_control.main.main_text",
			["real_name_box/bg/main/input_main/inputfield_1"] = "_control.main.input_main.inputfield_1",
			["real_name_box/bg/main/input_main/line"] = "_control.main.input_main.line",
			["real_name_box/bg/line"] = "_control.line",
			["real_name_box/bg/main/input_main/inputfield_1/Placeholder"] = "_control.main.input_main.inputfield_1.Placeholder",
			["real_name_box/bg/main/input_main/btn/text"] = "_control.main.input_main.btn.text",
			["real_name_box/mask"] = "_control.mask",
			["real_name_box/bg"] = "_control.bg",
			["real_name_box/bg/main/input_main/inputfield_2"] = "_control.main.input_main.inputfield_2",
			["real_name_box/bg/main/input_main/inputfield_2/Placeholder"] = "_control.main.input_main.inputfield_2.Placeholder",
			["real_name_box/bg/main/input_main/btn"] = "_control.main.input_main.btn",
			["real_name_box/bg/main/input_main/inputfield_1/text"] = "_control.main.input_main.inputfield_1.text",
			["real_name_box/bg/main/input_main"] = "_control.main.input_main",
			["real_name_box/bg/main"] = "_control.main",
			["real_name_box/bg/title"] = "_control.title",
			["real_name_box/bg/main/input_main/bg"] = "_control.main.input_main.bg"
		},
		click = {
			["bg/main/input_main/btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

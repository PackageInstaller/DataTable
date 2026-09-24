return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			left_node = {
				path = "left_node",
				list = {
					achievement_task_view = {
						path = "left_node/achievement_task_view",
						list = {
							view_port = {
								path = "left_node/achievement_task_view/view_port",
								list = {
									content = {
										path = "left_node/achievement_task_view/view_port/content",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"EndlessScrollView"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.UI.ScrollRect"
						}
					}
				},
				component = {}
			},
			right_node = {
				path = "right_node",
				list = {
					title_node = {
						path = "right_node/title_node",
						list = {
							title_bg = {
								path = "right_node/title_node/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							title_lab = {
								path = "right_node/title_node/title_lab",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
					},
					level_title_lab = {
						path = "right_node/level_title_lab",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					exp_bg = {
						path = "right_node/exp_bg",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					exp_lab = {
						path = "right_node/exp_lab",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					exp_slider_bg = {
						path = "right_node/exp_slider_bg",
						list = {
							exp_slider = {
								path = "right_node/exp_slider_bg/exp_slider",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {}
					},
					attr_title_lab = {
						path = "right_node/attr_title_lab",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					buff_list = {
						path = "right_node/buff_list",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.VerticalLayoutGroup"
						}
					}
				},
				component = {}
			},
			top = {
				path = "top",
				list = {
					title = {
						path = "top/title",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					return_btn = {
						path = "top/return_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			}
		},
		call_node_list = {
			["eighth_support_layer/right_node/attr_title_lab"] = "_control.right_node.attr_title_lab",
			["eighth_support_layer/right_node/title_node/title_lab"] = "_control.right_node.title_node.title_lab",
			["eighth_support_layer/right_node/exp_bg"] = "_control.right_node.exp_bg",
			["eighth_support_layer/left_node"] = "_control.left_node",
			["eighth_support_layer/right_node/title_node/title_bg"] = "_control.right_node.title_node.title_bg",
			["eighth_support_layer/right_node/level_title_lab"] = "_control.right_node.level_title_lab",
			["eighth_support_layer/right_node/title_node"] = "_control.right_node.title_node",
			["eighth_support_layer/top/return_btn"] = "_control.top.return_btn",
			["eighth_support_layer/right_node/buff_list"] = "_control.right_node.buff_list",
			["eighth_support_layer/top"] = "_control.top",
			["eighth_support_layer/bg"] = "_control.bg",
			["eighth_support_layer/left_node/achievement_task_view/view_port"] = "_control.left_node.achievement_task_view.view_port",
			["eighth_support_layer/right_node"] = "_control.right_node",
			["eighth_support_layer/right_node/exp_slider_bg/exp_slider"] = "_control.right_node.exp_slider_bg.exp_slider",
			["eighth_support_layer/right_node/exp_slider_bg"] = "_control.right_node.exp_slider_bg",
			["eighth_support_layer/left_node/achievement_task_view"] = "_control.left_node.achievement_task_view",
			["eighth_support_layer/right_node/exp_lab"] = "_control.right_node.exp_lab",
			["eighth_support_layer/top/title"] = "_control.top.title",
			["eighth_support_layer/left_node/achievement_task_view/view_port/content"] = "_control.left_node.achievement_task_view.view_port.content"
		},
		click = {
			["top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

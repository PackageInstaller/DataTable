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
			task_name_lab = {
				path = "task_name_lab",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			task_desc_lab_btn = {
				path = "task_desc_lab_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			task_desc_lab = {
				path = "task_desc_lab",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			reward_bg = {
				path = "reward_bg",
				list = {
					reward_lab = {
						path = "reward_bg/reward_lab",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					Image = {
						path = "reward_bg/Image",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					exp_lab = {
						path = "reward_bg/exp_lab",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					trophy_star_bg = {
						path = "reward_bg/trophy_star_bg",
						list = {
							trophy_star_lab = {
								path = "reward_bg/trophy_star_bg/trophy_star_lab",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image"
						}
					},
					complete_img = {
						path = "reward_bg/complete_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image"
						}
					},
					complete_bg = {
						path = "reward_bg/complete_bg",
						list = {
							complete_lab = {
								path = "reward_bg/complete_bg/complete_lab",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["eighth_achievement_task_item/reward_bg/reward_lab"] = "_control.reward_bg.reward_lab",
			["eighth_achievement_task_item/reward_bg/complete_img"] = "_control.reward_bg.complete_img",
			["eighth_achievement_task_item/reward_bg/exp_lab"] = "_control.reward_bg.exp_lab",
			["eighth_achievement_task_item/task_desc_lab"] = "_control.task_desc_lab",
			["eighth_achievement_task_item/reward_bg/trophy_star_bg/trophy_star_lab"] = "_control.reward_bg.trophy_star_bg.trophy_star_lab",
			["eighth_achievement_task_item/reward_bg/trophy_star_bg"] = "_control.reward_bg.trophy_star_bg",
			["eighth_achievement_task_item/task_name_lab"] = "_control.task_name_lab",
			["eighth_achievement_task_item/bg"] = "_control.bg",
			["eighth_achievement_task_item/task_desc_lab_btn"] = "_control.task_desc_lab_btn",
			["eighth_achievement_task_item/reward_bg"] = "_control.reward_bg",
			["eighth_achievement_task_item/reward_bg/complete_bg/complete_lab"] = "_control.reward_bg.complete_bg.complete_lab",
			["eighth_achievement_task_item/reward_bg/complete_bg"] = "_control.reward_bg.complete_bg",
			["eighth_achievement_task_item/reward_bg/Image"] = "_control.reward_bg.Image"
		},
		click = {
			task_desc_lab_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

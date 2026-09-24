return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {}
			},
			top = {
				path = "top",
				list = {},
				component = {}
			},
			title = {
				path = "top/title",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			["return"] = {
				path = "top/return",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			middle = {
				path = "middle",
				list = {},
				component = {}
			},
			buff_bg = {
				path = "middle/buff_bg",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			buff_item_root = {
				path = "middle/buff_bg/buff_item_root",
				list = {},
				component = {}
			},
			buff_entrance_1 = {
				path = "middle/buff_entrance_root/buff_entrance_1",
				list = {
					Text = {
						path = "middle/buff_entrance_root/buff_entrance_1/Text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Toggle",
					"UnityEngine.UI.ToggleGroup"
				}
			},
			buff_entrance_2 = {
				path = "middle/buff_entrance_root/buff_entrance_2",
				list = {
					Text = {
						path = "middle/buff_entrance_root/buff_entrance_2/Text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Toggle"
				}
			},
			buff_entrance_3 = {
				path = "middle/buff_entrance_root/buff_entrance_3",
				list = {
					Text = {
						path = "middle/buff_entrance_root/buff_entrance_3/Text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Toggle"
				}
			},
			reset = {
				path = "bottom/reset",
				list = {
					Text = {
						path = "bottom/reset/Text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			cur_have_point_text = {
				path = "bottom/skill_point_root/cur_have_point_text",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			point_text = {
				path = "bottom/skill_point_root/point_text",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			buff_detail = {
				path = "bottom/buff_detail",
				list = {},
				component = {}
			},
			buff_name_text = {
				path = "bottom/buff_detail/buff_name_text",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			buff_title = {
				path = "bottom/buff_detail/buff_name_text/buff_title",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			buff_desc_title = {
				path = "bottom/buff_detail/buff_desc_title",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			buff_desc = {
				path = "bottom/buff_detail/buff_desc_title/buff_desc",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			buff_active = {
				path = "bottom/buff_detail/buff_active",
				list = {
					Text = {
						path = "bottom/buff_detail/buff_active/Text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Button"
				}
			},
			need_buff_point = {
				path = "bottom/buff_detail/need_buff_point",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			need_point_text = {
				path = "bottom/buff_detail/need_buff_point/need_point_text",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			full_level_text = {
				path = "bottom/buff_detail/full_level_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["mix_battle_plan/middle/buff_bg/buff_item_root"] = "_control.buff_item_root",
			["mix_battle_plan/bottom/buff_detail/buff_active"] = "_control.buff_active",
			["mix_battle_plan/bottom/buff_detail/need_buff_point"] = "_control.need_buff_point",
			["mix_battle_plan/middle/buff_bg"] = "_control.buff_bg",
			["mix_battle_plan/middle/buff_entrance_root/buff_entrance_2"] = "_control.buff_entrance_2",
			["mix_battle_plan/middle/buff_entrance_root/buff_entrance_3"] = "_control.buff_entrance_3",
			["mix_battle_plan/bottom/reset"] = "_control.reset",
			["mix_battle_plan/middle/buff_entrance_root/buff_entrance_3/Text"] = "_control.buff_entrance_3.Text",
			["mix_battle_plan/middle"] = "_control.middle",
			["mix_battle_plan/bottom/skill_point_root/point_text"] = "_control.point_text",
			["mix_battle_plan/bottom/buff_detail/buff_active/Text"] = "_control.buff_active.Text",
			["mix_battle_plan/bg"] = "_control.bg",
			["mix_battle_plan/middle/buff_entrance_root/buff_entrance_2/Text"] = "_control.buff_entrance_2.Text",
			["mix_battle_plan/bottom/buff_detail/buff_name_text"] = "_control.buff_name_text",
			["mix_battle_plan/middle/buff_entrance_root/buff_entrance_1/Text"] = "_control.buff_entrance_1.Text",
			["mix_battle_plan/bottom/buff_detail/buff_desc_title/buff_desc"] = "_control.buff_desc",
			["mix_battle_plan/bottom/buff_detail/buff_desc_title"] = "_control.buff_desc_title",
			["mix_battle_plan/bottom/buff_detail/need_buff_point/need_point_text"] = "_control.need_point_text",
			["mix_battle_plan/top/title"] = "_control.title",
			["mix_battle_plan/bottom/buff_detail/full_level_text"] = "_control.full_level_text",
			["mix_battle_plan/bottom/buff_detail/buff_name_text/buff_title"] = "_control.buff_title",
			["mix_battle_plan/middle/buff_entrance_root/buff_entrance_1"] = "_control.buff_entrance_1",
			["mix_battle_plan/top"] = "_control.top",
			["mix_battle_plan/bottom/reset/Text"] = "_control.reset.Text",
			["mix_battle_plan/bottom/skill_point_root/cur_have_point_text"] = "_control.cur_have_point_text",
			["mix_battle_plan/bottom/buff_detail"] = "_control.buff_detail",
			["mix_battle_plan/top/return"] = "_control.return"
		},
		click = {
			["top/return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/reset"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/buff_detail/buff_active"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["middle/buff_entrance_root/buff_entrance_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["middle/buff_entrance_root/buff_entrance_2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["middle/buff_entrance_root/buff_entrance_3"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

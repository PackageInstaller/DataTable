return {
	_rule_ = {
		none = {
			enemy_title = {
				path = "tip_layer/bg_container/enemy_title",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			enemy_buff_back_btn = {
				path = "tip_layer/enemy_buff_back_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			enemy_buff_txt = {
				path = "enemy_buff_txt",
				list = {
					enemy_buff_level_txt = {
						path = "enemy_buff_txt/enemy_buff_level_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					buff_show_txt = {
						path = "enemy_buff_txt/buff_show_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			},
			enemy_list = {
				path = "enemy_list",
				list = {
					level_desc_1 = {
						path = "enemy_list/level_desc_1",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_2 = {
						path = "enemy_list/level_desc_2",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_3 = {
						path = "enemy_list/level_desc_3",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_4 = {
						path = "enemy_list/level_desc_4",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_5 = {
						path = "enemy_list/level_desc_5",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_6 = {
						path = "enemy_list/level_desc_6",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_7 = {
						path = "enemy_list/level_desc_7",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_8 = {
						path = "enemy_list/level_desc_8",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_9 = {
						path = "enemy_list/level_desc_9",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_desc_10 = {
						path = "enemy_list/level_desc_10",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			buff_show_txt_2 = {
				path = "buff_show_txt_2",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["eighth_enemy_buff/enemy_list/level_desc_10"] = "_control.enemy_list.level_desc_10",
			["eighth_enemy_buff/enemy_list"] = "_control.enemy_list",
			["eighth_enemy_buff/enemy_list/level_desc_4"] = "_control.enemy_list.level_desc_4",
			["eighth_enemy_buff/enemy_buff_txt"] = "_control.enemy_buff_txt",
			["eighth_enemy_buff/buff_show_txt_2"] = "_control.buff_show_txt_2",
			["eighth_enemy_buff/tip_layer/bg_container/enemy_title"] = "_control.enemy_title",
			["eighth_enemy_buff/enemy_list/level_desc_3"] = "_control.enemy_list.level_desc_3",
			["eighth_enemy_buff/enemy_buff_txt/enemy_buff_level_txt"] = "_control.enemy_buff_txt.enemy_buff_level_txt",
			["eighth_enemy_buff/tip_layer/enemy_buff_back_btn"] = "_control.enemy_buff_back_btn",
			["eighth_enemy_buff/enemy_list/level_desc_8"] = "_control.enemy_list.level_desc_8",
			["eighth_enemy_buff/enemy_list/level_desc_5"] = "_control.enemy_list.level_desc_5",
			["eighth_enemy_buff/enemy_list/level_desc_6"] = "_control.enemy_list.level_desc_6",
			["eighth_enemy_buff/enemy_list/level_desc_9"] = "_control.enemy_list.level_desc_9",
			["eighth_enemy_buff/enemy_buff_txt/buff_show_txt"] = "_control.enemy_buff_txt.buff_show_txt",
			["eighth_enemy_buff/enemy_list/level_desc_1"] = "_control.enemy_list.level_desc_1",
			["eighth_enemy_buff/enemy_list/level_desc_7"] = "_control.enemy_list.level_desc_7",
			["eighth_enemy_buff/enemy_list/level_desc_2"] = "_control.enemy_list.level_desc_2"
		},
		click = {
			["tip_layer/enemy_buff_back_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

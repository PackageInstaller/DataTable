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
			ship = {
				path = "ship",
				list = {
					ship_bg = {
						path = "ship/ship_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					ship_icon = {
						path = "ship/ship_icon",
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
			board = {
				path = "board",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			ship_level = {
				path = "ship_level",
				list = {
					level_num = {
						path = "ship_level/level_num",
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
			ship_type = {
				path = "ship_type",
				list = {
					type_name = {
						path = "ship_type/type_name",
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
			ship_name = {
				path = "ship_name",
				list = {
					ship_name_1 = {
						path = "ship_name/ship_name_1",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					ship_name_2 = {
						path = "ship_name/ship_name_2",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Mask",
					"TextHorizonScroller"
				}
			},
			ship_flag = {
				path = "ship_flag",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			ship_hp = {
				path = "ship_hp",
				list = {
					bar_bg = {
						path = "ship_hp/bar_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					hp_bar = {
						path = "ship_hp/hp_bar",
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
		call_node_list = {
			["fight_result_ship/bg"] = "_control.bg",
			["fight_result_ship/ship_type"] = "_control.ship_type",
			["fight_result_ship/ship_type/type_name"] = "_control.ship_type.type_name",
			["fight_result_ship/board"] = "_control.board",
			["fight_result_ship/ship/ship_bg"] = "_control.ship.ship_bg",
			["fight_result_ship/ship_level"] = "_control.ship_level",
			["fight_result_ship/ship/ship_icon"] = "_control.ship.ship_icon",
			["fight_result_ship/ship_name/ship_name_1"] = "_control.ship_name.ship_name_1",
			["fight_result_ship/ship_flag"] = "_control.ship_flag",
			["fight_result_ship/ship_level/level_num"] = "_control.ship_level.level_num",
			["fight_result_ship/ship_name"] = "_control.ship_name",
			["fight_result_ship/ship_hp"] = "_control.ship_hp",
			["fight_result_ship/ship_name/ship_name_2"] = "_control.ship_name.ship_name_2",
			["fight_result_ship/ship_hp/bar_bg"] = "_control.ship_hp.bar_bg",
			["fight_result_ship/ship_hp/hp_bar"] = "_control.ship_hp.hp_bar",
			["fight_result_ship/ship"] = "_control.ship"
		},
		canvas_set = {}
	}
}

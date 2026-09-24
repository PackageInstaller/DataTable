return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					ship_icon = {
						path = "bg/ship_icon",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					ship_select_light = {
						path = "bg/ship_select_light",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					ship_type_txt = {
						path = "bg/ship_type_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					ship_name_txt = {
						path = "bg/ship_name_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					ship_hp_bg = {
						path = "bg/ship_hp_bg",
						list = {
							ship_down = {
								path = "bg/ship_hp_bg/ship_down",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			select_btn = {
				path = "select_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["research_bureau_ship/select_btn"] = "_control.select_btn",
			["research_bureau_ship/bg"] = "_control.bg",
			["research_bureau_ship/bg/ship_hp_bg"] = "_control.bg.ship_hp_bg",
			["research_bureau_ship/bg/ship_icon"] = "_control.bg.ship_icon",
			["research_bureau_ship/bg/ship_hp_bg/ship_down"] = "_control.bg.ship_hp_bg.ship_down",
			["research_bureau_ship/bg/ship_select_light"] = "_control.bg.ship_select_light",
			["research_bureau_ship/bg/ship_type_txt"] = "_control.bg.ship_type_txt",
			["research_bureau_ship/bg/ship_name_txt"] = "_control.bg.ship_name_txt"
		},
		click = {
			select_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			node_image = {
				path = "node_image",
				list = {
					name_bg = {
						path = "node_image/name_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					reward_bg = {
						path = "node_image/reward_bg",
						list = {
							reward_icon = {
								path = "node_image/reward_bg/reward_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							reward_count = {
								path = "node_image/reward_bg/reward_count",
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
					guard_icon = {
						path = "node_image/guard_icon",
						list = {
							team_id = {
								path = "node_image/guard_icon/team_id",
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
							"UnityEngine.UI.Button",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					adyss_buff_image = {
						path = "node_image/adyss_buff_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					random_buff_icon = {
						path = "node_image/random_buff_icon",
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
			night_atk_point = {
				path = "night_atk_point",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			night_atk_point_2 = {
				path = "night_atk_point_2",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["map_node_obj/node_image/random_buff_icon"] = "_control.node_image.random_buff_icon",
			["map_node_obj/node_image/reward_bg/reward_icon"] = "_control.node_image.reward_bg.reward_icon",
			["map_node_obj/node_image"] = "_control.node_image",
			["map_node_obj/night_atk_point_2"] = "_control.night_atk_point_2",
			["map_node_obj/node_image/adyss_buff_image"] = "_control.node_image.adyss_buff_image",
			["map_node_obj/node_image/guard_icon/team_id"] = "_control.node_image.guard_icon.team_id",
			["map_node_obj/node_image/reward_bg/reward_count"] = "_control.node_image.reward_bg.reward_count",
			["map_node_obj/node_image/reward_bg"] = "_control.node_image.reward_bg",
			["map_node_obj/node_image/guard_icon"] = "_control.node_image.guard_icon",
			["map_node_obj/night_atk_point"] = "_control.night_atk_point",
			["map_node_obj/node_image/name_bg"] = "_control.node_image.name_bg"
		},
		click = {
			["node_image/guard_icon"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

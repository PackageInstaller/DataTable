return {
	_rule_ = {
		none = {
			food_quality = {
				path = "food_quality",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			border_bg = {
				path = "border_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			icon = {
				path = "icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			cover = {
				path = "cover",
				list = {
					tip = {
						path = "cover/tip",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					tip_mask = {
						path = "cover/tip_mask",
						list = {
							tip_name_1 = {
								path = "cover/tip_mask/tip_name_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							tip_name_2 = {
								path = "cover/tip_mask/tip_name_2",
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
							"UnityEngine.UI.Mask",
							"TextHorizonScroller",
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
			country_bg = {
				path = "country_bg",
				list = {
					country = {
						path = "country_bg/country",
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
			name_txt = {
				path = "name_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			line_bg = {
				path = "line_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			chest_dot = {
				path = "chest_dot",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			buff_txt = {
				path = "buff_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			type_txt = {
				path = "type_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["single_food_cell/line_bg"] = "_control.line_bg",
			["single_food_cell/border_bg"] = "_control.border_bg",
			["single_food_cell/icon"] = "_control.icon",
			["single_food_cell/country_bg/country"] = "_control.country_bg.country",
			["single_food_cell/name_txt"] = "_control.name_txt",
			["single_food_cell/food_quality"] = "_control.food_quality",
			["single_food_cell/cover/tip"] = "_control.cover.tip",
			["single_food_cell/cover"] = "_control.cover",
			["single_food_cell/cover/tip_mask/tip_name_1"] = "_control.cover.tip_mask.tip_name_1",
			["single_food_cell/buff_txt"] = "_control.buff_txt",
			["single_food_cell/chest_dot"] = "_control.chest_dot",
			["single_food_cell/type_txt"] = "_control.type_txt",
			["single_food_cell/country_bg"] = "_control.country_bg",
			["single_food_cell/cover/tip_mask/tip_name_2"] = "_control.cover.tip_mask.tip_name_2",
			["single_food_cell/cover/tip_mask"] = "_control.cover.tip_mask"
		},
		click = {
			food_quality = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

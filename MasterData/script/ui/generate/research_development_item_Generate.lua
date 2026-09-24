return {
	_rule_ = {
		none = {
			item_bg = {
				path = "item_bg",
				list = {
					item_bg_mask = {
						path = "item_bg/item_bg_mask",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					not_choose_bg = {
						path = "item_bg/not_choose_bg",
						list = {},
						component = {}
					},
					choose_bg = {
						path = "item_bg/choose_bg",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					icon_mask = {
						path = "item_bg/icon_mask",
						list = {},
						component = {
							"UnityEngine.UI.Mask"
						}
					},
					icon = {
						path = "item_bg/icon_mask/icon",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					state = {
						path = "item_bg/state",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					ship_name = {
						path = "item_bg/ship_name",
						list = {
							ship_name_1 = {
								path = "item_bg/ship_name/ship_name_1",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							ship_name_2 = {
								path = "item_bg/ship_name/ship_name_2",
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
					select_btn = {
						path = "item_bg/select_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					common_tips = {
						path = "item_bg/common_tips",
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
		call_node_list = {
			["research_development_item/item_bg/ship_name/ship_name_2"] = "_control.item_bg.ship_name.ship_name_2",
			["research_development_item/item_bg/ship_name/ship_name_1"] = "_control.item_bg.ship_name.ship_name_1",
			["research_development_item/item_bg/icon_mask"] = "_control.item_bg.icon_mask",
			["research_development_item/item_bg/common_tips"] = "_control.item_bg.common_tips",
			["research_development_item/item_bg/state"] = "_control.item_bg.state",
			["research_development_item/item_bg/not_choose_bg"] = "_control.item_bg.not_choose_bg",
			["research_development_item/item_bg"] = "_control.item_bg",
			["research_development_item/item_bg/choose_bg"] = "_control.item_bg.choose_bg",
			["research_development_item/item_bg/item_bg_mask"] = "_control.item_bg.item_bg_mask",
			["research_development_item/item_bg/ship_name"] = "_control.item_bg.ship_name",
			["research_development_item/item_bg/icon_mask/icon"] = "_control.item_bg.icon",
			["research_development_item/item_bg/select_btn"] = "_control.item_bg.select_btn"
		},
		click = {
			["item_bg/select_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

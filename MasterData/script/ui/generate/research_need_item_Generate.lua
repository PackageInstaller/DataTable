return {
	_rule_ = {
		none = {
			item_bg = {
				path = "item_bg",
				list = {
					icon_bg = {
						path = "item_bg/icon_bg",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					icon = {
						path = "item_bg/icon",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					have_name = {
						path = "item_bg/have_name",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					have_txt = {
						path = "item_bg/have_name/have_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					item_name = {
						path = "item_bg/item_name",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					add_btn = {
						path = "item_bg/add_btn",
						list = {},
						component = {
							"PointerDownAndLongClickEvent"
						}
					},
					subtract_btn = {
						path = "item_bg/subtract_btn",
						list = {},
						component = {
							"PointerDownAndLongClickEvent"
						}
					},
					max_core_btn = {
						path = "item_bg/max_core_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					now_txt = {
						path = "item_bg/now_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["research_need_item/item_bg/item_name"] = "_control.item_bg.item_name",
			["research_need_item/item_bg/icon_bg"] = "_control.item_bg.icon_bg",
			["research_need_item/item_bg/now_txt"] = "_control.item_bg.now_txt",
			["research_need_item/item_bg/add_btn"] = "_control.item_bg.add_btn",
			["research_need_item/item_bg/max_core_btn"] = "_control.item_bg.max_core_btn",
			["research_need_item/item_bg"] = "_control.item_bg",
			["research_need_item/item_bg/have_name"] = "_control.item_bg.have_name",
			["research_need_item/item_bg/subtract_btn"] = "_control.item_bg.subtract_btn",
			["research_need_item/item_bg/icon"] = "_control.item_bg.icon",
			["research_need_item/item_bg/have_name/have_txt"] = "_control.item_bg.have_txt"
		},
		click = {
			["item_bg/max_core_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		pointer_down_and_long_click = {
			["item_bg/add_btn"] = {
				tp = "PointerDownAndLongClickEvent"
			},
			["item_bg/subtract_btn"] = {
				tp = "PointerDownAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

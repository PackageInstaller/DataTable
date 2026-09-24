return {
	_rule_ = {
		none = {
			collcetion_quality = {
				path = "collcetion_quality",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
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
			name_scroller = {
				path = "name_scroller",
				list = {
					name_txt = {
						path = "name_scroller/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					name_txt_two = {
						path = "name_scroller/name_txt_two",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					}
				},
				component = {
					"UnityEngine.UI.Mask",
					"TextHorizonScroller"
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
			buff_tips_txt = {
				path = "buff_tips_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			describe = {
				path = "describe",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"ClickAndLongClickEvent",
					"PointerDownUpEvent"
				}
			},
			buff_tips_1_txt = {
				path = "buff_tips_1_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["single_collection_cell/buff_tips_txt"] = "_control.buff_tips_txt",
			["single_collection_cell/name_scroller/name_txt_two"] = "_control.name_scroller.name_txt_two",
			["single_collection_cell/describe"] = "_control.describe",
			["single_collection_cell/buff_tips_1_txt"] = "_control.buff_tips_1_txt",
			["single_collection_cell/icon"] = "_control.icon",
			["single_collection_cell/name_scroller/name_txt"] = "_control.name_scroller.name_txt",
			["single_collection_cell/border_bg"] = "_control.border_bg",
			["single_collection_cell/line_bg"] = "_control.line_bg",
			["single_collection_cell/collcetion_quality"] = "_control.collcetion_quality",
			["single_collection_cell/chest_dot"] = "_control.chest_dot",
			["single_collection_cell/name_scroller"] = "_control.name_scroller"
		},
		click = {
			describe = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			describe = {
				tp = "ClickAndLongClickEvent"
			}
		},
		pointer_down_up = {
			describe = {
				tp = "PointerDownUpEvent"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			btn = {
				path = "btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"ItemBase"
				}
			},
			rank_sort_txt = {
				path = "rank_sort_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			rank_head_black_bg = {
				path = "rank_head_black_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			rank_head_bg = {
				path = "rank_head_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			head_bg = {
				path = "head_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			user_icon = {
				path = "user_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			name_mask = {
				path = "name_mask",
				list = {
					name_txt = {
						path = "name_mask/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_txt_2 = {
						path = "name_mask/name_txt_2",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask",
					"TextHorizonScroller"
				}
			},
			merit_txt = {
				path = "merit_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			badge_icon = {
				path = "badge_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			badge_txt = {
				path = "badge_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			time_txt = {
				path = "time_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["single_ninth_honor_list/name_mask"] = "_control.name_mask",
			["single_ninth_honor_list/merit_txt"] = "_control.merit_txt",
			["single_ninth_honor_list/name_mask/name_txt_2"] = "_control.name_mask.name_txt_2",
			["single_ninth_honor_list/user_icon"] = "_control.user_icon",
			["single_ninth_honor_list/head_bg"] = "_control.head_bg",
			["single_ninth_honor_list/badge_icon"] = "_control.badge_icon",
			["single_ninth_honor_list/btn"] = "_control.btn",
			["single_ninth_honor_list/name_mask/name_txt"] = "_control.name_mask.name_txt",
			["single_ninth_honor_list/badge_txt"] = "_control.badge_txt",
			["single_ninth_honor_list/time_txt"] = "_control.time_txt",
			["single_ninth_honor_list/rank_head_black_bg"] = "_control.rank_head_black_bg",
			["single_ninth_honor_list/rank_head_bg"] = "_control.rank_head_bg",
			["single_ninth_honor_list/rank_sort_txt"] = "_control.rank_sort_txt"
		},
		click = {
			btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

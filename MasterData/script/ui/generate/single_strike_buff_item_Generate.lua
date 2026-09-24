return {
	_rule_ = {
		none = {
			active_bg = {
				path = "active_bg",
				list = {
					title = {
						path = "active_bg/title",
						list = {
							text = {
								path = "active_bg/title/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							text_2 = {
								path = "active_bg/title/text_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {}
					},
					Image = {
						path = "active_bg/Image",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			extra_icon = {
				path = "extra_icon",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			Button = {
				path = "Button",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			extra_btn = {
				path = "extra_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["single_strike_buff_item/active_bg/title/text_2"] = "_control.active_bg.title.text_2",
			["single_strike_buff_item/active_bg/title"] = "_control.active_bg.title",
			["single_strike_buff_item/Button"] = "_control.Button",
			["single_strike_buff_item/extra_btn"] = "_control.extra_btn",
			["single_strike_buff_item/extra_icon"] = "_control.extra_icon",
			["single_strike_buff_item/active_bg"] = "_control.active_bg",
			["single_strike_buff_item/active_bg/Image"] = "_control.active_bg.Image",
			["single_strike_buff_item/active_bg/title/text"] = "_control.active_bg.title.text"
		},
		click = {
			Button = {
				tp = "UnityEngine.UI.Button"
			},
			extra_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

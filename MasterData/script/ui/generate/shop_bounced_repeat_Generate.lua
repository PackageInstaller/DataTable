return {
	_rule_ = {
		none = {
			title = {
				path = "main/title",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			},
			count_text = {
				path = "main/count_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			minus_btn = {
				path = "main/minus_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"ClickAndLongClickEvent"
				}
			},
			count_num = {
				path = "main/count_num",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			plus_btn = {
				path = "main/plus_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"ClickAndLongClickEvent"
				}
			},
			quitbtn = {
				path = "main/quitbtn",
				list = {
					text = {
						path = "main/quitbtn/text",
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
					"UnityEngine.UI.Button"
				}
			},
			confirmbtn = {
				path = "main/confirmbtn",
				list = {
					text = {
						path = "main/confirmbtn/text",
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
					"UnityEngine.UI.Button"
				}
			},
			closebtn = {
				path = "main/closebtn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			max_text = {
				path = "main/max_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			use = {
				path = "main/main_text/use",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			diamond_icon = {
				path = "main/diamond_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			spoils_icon = {
				path = "main/spoils_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			exploit_icon = {
				path = "main/exploit_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			combat_icon = {
				path = "main/combat_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			furniture_icon = {
				path = "main/furniture_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			former_num = {
				path = "main/former_num",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			},
			latter_num = {
				path = "main/former_num/arrow/latter_num",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			}
		},
		call_node_list = {
			["shop_bounced_repeat/main/quitbtn/text"] = "_control.quitbtn.text",
			["shop_bounced_repeat/main/quitbtn"] = "_control.quitbtn",
			["shop_bounced_repeat/main/count_num"] = "_control.count_num",
			["shop_bounced_repeat/main/minus_btn"] = "_control.minus_btn",
			["shop_bounced_repeat/main/diamond_icon"] = "_control.diamond_icon",
			["shop_bounced_repeat/main/spoils_icon"] = "_control.spoils_icon",
			["shop_bounced_repeat/main/main_text/use"] = "_control.use",
			["shop_bounced_repeat/main/confirmbtn/text"] = "_control.confirmbtn.text",
			["shop_bounced_repeat/main/max_text"] = "_control.max_text",
			["shop_bounced_repeat/main/closebtn"] = "_control.closebtn",
			["shop_bounced_repeat/main/title"] = "_control.title",
			["shop_bounced_repeat/main/furniture_icon"] = "_control.furniture_icon",
			["shop_bounced_repeat/main/former_num"] = "_control.former_num",
			["shop_bounced_repeat/main/plus_btn"] = "_control.plus_btn",
			["shop_bounced_repeat/main/former_num/arrow/latter_num"] = "_control.latter_num",
			["shop_bounced_repeat/main/exploit_icon"] = "_control.exploit_icon",
			["shop_bounced_repeat/main/confirmbtn"] = "_control.confirmbtn",
			["shop_bounced_repeat/main/count_text"] = "_control.count_text",
			["shop_bounced_repeat/main/combat_icon"] = "_control.combat_icon"
		},
		click = {
			["main/quitbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/closebtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			["main/minus_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["main/plus_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

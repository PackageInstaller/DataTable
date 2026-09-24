return {
	_rule_ = {
		none = {
			icon = {
				path = "icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup"
				}
			},
			title_scroller = {
				path = "title_scroller",
				list = {
					title_text = {
						path = "title_scroller/title_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					title_text2 = {
						path = "title_scroller/title_text2",
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
					"TextHorizonScroller"
				}
			},
			text_scroller = {
				path = "text_scroller",
				list = {
					text = {
						path = "text_scroller/text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter",
							"UnityEngine.UI.GridLayoutGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.ScrollRect"
				}
			},
			placed = {
				path = "placed",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["strike_buff_obj/text_scroller"] = "_control.text_scroller",
			["strike_buff_obj/title_scroller"] = "_control.title_scroller",
			["strike_buff_obj/text_scroller/text"] = "_control.text_scroller.text",
			["strike_buff_obj/title_scroller/title_text2"] = "_control.title_scroller.title_text2",
			["strike_buff_obj/icon"] = "_control.icon",
			["strike_buff_obj/placed"] = "_control.placed",
			["strike_buff_obj/title_scroller/title_text"] = "_control.title_scroller.title_text"
		},
		canvas_set = {}
	}
}

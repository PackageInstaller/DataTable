return {
	_rule_ = {
		none = {
			collection_describe_test = {
				path = "collection_describe_test",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg_shadw = {
				path = "bg_shadw",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			bg_text = {
				path = "bg_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg_container = {
				path = "bg_container",
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
							"UnityEngine.UI.Text"
						}
					},
					name_txt_2 = {
						path = "name_scroller/name_txt_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"TextHorizonScroller",
					"UnityEngine.CanvasRenderer"
				}
			},
			describe_txt = {
				path = "describe_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			close_btn = {
				path = "close_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["collection_info/describe_txt"] = "_control.describe_txt",
			["collection_info/bg_shadw"] = "_control.bg_shadw",
			["collection_info/collection_describe_test"] = "_control.collection_describe_test",
			["collection_info/bg_text"] = "_control.bg_text",
			["collection_info/name_scroller/name_txt_2"] = "_control.name_scroller.name_txt_2",
			["collection_info/close_btn"] = "_control.close_btn",
			["collection_info/name_scroller"] = "_control.name_scroller",
			["collection_info/bg_container"] = "_control.bg_container",
			["collection_info/name_scroller/name_txt"] = "_control.name_scroller.name_txt"
		},
		click = {
			close_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

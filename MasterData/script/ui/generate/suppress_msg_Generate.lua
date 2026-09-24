return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					main_title = {
						path = "bg/main_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					target_title = {
						path = "bg/target_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					content_text = {
						path = "bg/content_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					mask_btn = {
						path = "bg/mask_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["suppress_msg/bg/main_title"] = "_control.bg.main_title",
			["suppress_msg/bg/mask_btn"] = "_control.bg.mask_btn",
			["suppress_msg/bg"] = "_control.bg",
			["suppress_msg/bg/target_title"] = "_control.bg.target_title",
			["suppress_msg/bg/content_text"] = "_control.bg.content_text"
		},
		click = {
			["bg/mask_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

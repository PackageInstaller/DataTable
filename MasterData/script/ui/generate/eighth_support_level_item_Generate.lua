return {
	_rule_ = {
		none = {
			title_lab = {
				path = "title_lab",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			desc_lab = {
				path = "desc_lab",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Text"
				}
			},
			bg_btn = {
				path = "bg_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["eighth_support_level_item/bg_btn"] = "_control.bg_btn",
			["eighth_support_level_item/desc_lab"] = "_control.desc_lab",
			["eighth_support_level_item/title_lab"] = "_control.title_lab"
		},
		click = {
			bg_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

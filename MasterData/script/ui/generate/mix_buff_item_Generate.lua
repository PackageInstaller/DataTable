return {
	_rule_ = {
		none = {
			lock_image = {
				path = "active_state_root/lock_image",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			activation_select_frame = {
				path = "select_state_root/activation_select_frame",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image"
				}
			},
			activation_select_state = {
				path = "select_state_root/activation_select_state",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			level_upgrade = {
				path = "buff_level_root/level_upgrade",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			buff_level_image = {
				path = "buff_level_root/buff_level_image",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			level_text = {
				path = "buff_level_root/level_text",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			buff_icon = {
				path = "buff_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["mix_buff_item/buff_level_root/buff_level_image"] = "_control.buff_level_image",
			["mix_buff_item/buff_level_root/level_upgrade"] = "_control.level_upgrade",
			["mix_buff_item/active_state_root/lock_image"] = "_control.lock_image",
			["mix_buff_item/select_state_root/activation_select_state"] = "_control.activation_select_state",
			["mix_buff_item/buff_level_root/level_text"] = "_control.level_text",
			["mix_buff_item/buff_icon"] = "_control.buff_icon",
			["mix_buff_item/select_state_root/activation_select_frame"] = "_control.activation_select_frame"
		},
		click = {
			buff_icon = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

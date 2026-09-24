return {
	_rule_ = {
		none = {
			active_bg = {
				path = "active_bg",
				list = {
					buff_desc = {
						path = "active_bg/buff_desc",
						list = {
							text = {
								path = "active_bg/buff_desc/text",
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
					buff_effect = {
						path = "active_bg/buff_effect",
						list = {
							text = {
								path = "active_bg/buff_effect/text",
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
					}
				},
				component = {
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["single_strike_whole_buff/active_bg"] = "_control.active_bg",
			["single_strike_whole_buff/active_bg/buff_desc/text"] = "_control.active_bg.buff_desc.text",
			["single_strike_whole_buff/active_bg/buff_effect/text"] = "_control.active_bg.buff_effect.text",
			["single_strike_whole_buff/active_bg/buff_effect"] = "_control.active_bg.buff_effect",
			["single_strike_whole_buff/active_bg/buff_desc"] = "_control.active_bg.buff_desc"
		},
		canvas_set = {}
	}
}

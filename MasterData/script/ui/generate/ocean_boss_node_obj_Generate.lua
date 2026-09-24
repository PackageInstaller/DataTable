return {
	_rule_ = {
		none = {
			boss_icon = {
				path = "boss_icon",
				list = {
					boss_hp_bg = {
						path = "boss_icon/boss_hp_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					boss_hp_bar = {
						path = "boss_icon/boss_hp_bar",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					boss_hp_die = {
						path = "boss_icon/boss_hp_die",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
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
			["ocean_boss_node_obj/boss_icon/boss_hp_bar"] = "_control.boss_icon.boss_hp_bar",
			["ocean_boss_node_obj/boss_icon/boss_hp_die"] = "_control.boss_icon.boss_hp_die",
			["ocean_boss_node_obj/boss_icon/boss_hp_bg"] = "_control.boss_icon.boss_hp_bg",
			["ocean_boss_node_obj/boss_icon"] = "_control.boss_icon"
		},
		canvas_set = {}
	}
}

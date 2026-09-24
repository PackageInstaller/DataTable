return {
	_rule_ = {
		none = {
			unactivated_point_image = {
				path = "point_image_root/unactivated_point_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image"
				}
			},
			activated_point_image = {
				path = "point_image_root/activated_point_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["mix_map_point_item/point_image_root/unactivated_point_image"] = "_control.unactivated_point_image",
			["mix_map_point_item/point_image_root/activated_point_image"] = "_control.activated_point_image"
		},
		click = {
			["point_image_root/activated_point_image"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

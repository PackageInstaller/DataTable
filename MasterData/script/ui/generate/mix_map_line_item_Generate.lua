return {
	_rule_ = {
		none = {
			line_image = {
				path = "lint_image_root/line_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["mix_map_line_item/lint_image_root/line_image"] = "_control.line_image"
		},
		canvas_set = {}
	}
}

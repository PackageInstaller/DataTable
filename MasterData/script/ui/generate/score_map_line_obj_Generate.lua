return {
	_rule_ = {
		none = {
			line_image = {
				path = "line_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["score_map_line_obj/line_image"] = "_control.line_image"
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			node_letter_image = {
				path = "node_letter_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["ninth_letter_name_obj/node_letter_image"] = "_control.node_letter_image"
		},
		canvas_set = {}
	}
}

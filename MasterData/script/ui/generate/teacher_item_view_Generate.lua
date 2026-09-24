return {
	_rule_ = {
		none = {
			teacher_detail = {
				path = "teacher_detail",
				list = {
					teacher_image = {
						path = "teacher_detail/teacher_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					role_name = {
						path = "teacher_detail/role_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		canvas_set = {}
	}
}

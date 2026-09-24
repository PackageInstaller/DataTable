return {
	_rule_ = {
		none = {
			gyroscope_sphere = {
				path = "gyroscope_sphere",
				list = {},
				component = {
					"UnityEngine.Transform",
					"UnityEngine.MeshFilter",
					"UnityEngine.MeshRenderer"
				}
			},
			camera_parent = {
				path = "camera_parent",
				list = {
					gyroscope_camera = {
						path = "camera_parent/gyroscope_camera",
						list = {},
						component = {
							"UnityEngine.Transform",
							"UnityEngine.Camera",
							"UnityEngine.FlareLayer"
						}
					}
				},
				component = {
					"UnityEngine.Transform"
				}
			},
			background = {
				path = "background",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image"
				}
			},
			version = {
				path = "version",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Text"
				}
			}
		}
	}
}

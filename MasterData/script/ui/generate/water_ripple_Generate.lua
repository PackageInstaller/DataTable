return {
	_rule_ = {
		none = {
			point = {
				path = "point",
				list = {
					water_image = {
						path = "point/water_image",
						list = {
							wave = {
								path = "point/water_image/wave",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
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
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		canvas_set = {}
	}
}

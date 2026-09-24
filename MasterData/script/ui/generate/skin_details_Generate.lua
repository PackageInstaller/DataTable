return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			left_layer = {
				path = "left_layer",
				list = {
					returnbtn = {
						path = "left_layer/returnbtn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					role = {
						path = "left_layer/role",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					namebg = {
						path = "left_layer/namebg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["left_layer/returnbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_layer/role"] = {
				tp = "UnityEngine.UI.Button"
			}
		}
	}
}

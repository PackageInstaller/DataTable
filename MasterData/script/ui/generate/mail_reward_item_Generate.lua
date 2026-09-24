return {
	_rule_ = {
		none = {
			rewardbg = {
				path = "rewardbg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			mask = {
				path = "mask",
				list = {
					reward = {
						path = "mask/reward",
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
					"UnityEngine.UI.Mask",
					"UnityEngine.UI.Image"
				}
			},
			number = {
				path = "number",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.UI.ContentSizeFitter"
				}
			},
			reward_des = {
				path = "reward_des",
				list = {
					item_name = {
						path = "reward_des/item_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					item_name_add = {
						path = "reward_des/item_name_add",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Mask",
					"TextHorizonScroller",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		canvas_set = {}
	}
}

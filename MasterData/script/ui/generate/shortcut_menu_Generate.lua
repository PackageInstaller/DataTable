return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			content = {
				path = "content",
				list = {
					main_bg = {
						path = "content/main_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					dock_team_btn = {
						path = "content/dock_team_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UIMoveTweener"
						}
					},
					dock_btn = {
						path = "content/dock_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UIMoveTweener"
						}
					},
					remake_btn = {
						path = "content/remake_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UIMoveTweener"
						}
					},
					restaurant_btn = {
						path = "content/restaurant_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UIMoveTweener"
						}
					},
					repair_btn = {
						path = "content/repair_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UIMoveTweener"
						}
					},
					equipment_btn = {
						path = "content/equipment_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UIMoveTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			}
		},
		click = {
			["content/dock_team_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/dock_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/remake_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/restaurant_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/repair_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/equipment_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

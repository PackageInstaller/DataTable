return {
	_rule_ = {
		none = {
			show_on_tween = {
				path = "show_on_tween",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			shadw = {
				path = "shadw",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			main = {
				path = "main",
				list = {
					prompt_icon = {
						path = "main/prompt_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					high_light = {
						path = "main/high_light",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIMoveTweener"
						}
					},
					prompt_des = {
						path = "main/prompt_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIMoveTweener"
						}
					},
					school_btn = {
						path = "main/school_btn",
						list = {
							btn_text = {
								path = "main/school_btn/btn_text",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["main/school_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

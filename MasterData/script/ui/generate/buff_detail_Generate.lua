return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					bg_1 = {
						path = "bg/bg_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					scrollview = {
						path = "bg/scrollview",
						list = {
							content = {
								path = "bg/scrollview/content",
								list = {
									info = {
										path = "bg/scrollview/content/info",
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
									"UnityEngine.UI.ContentSizeFitter",
									"UnityEngine.UI.VerticalLayoutGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					air_atk_txt = {
						path = "bg/air_atk_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					air_atk_value = {
						path = "bg/air_atk_value",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					level = {
						path = "bg/level",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.CanvasGroup"
						}
					},
					title = {
						path = "bg/title",
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
		call_node_list = {
			["buff_detail/bg/air_atk_value"] = "_control.bg.air_atk_value",
			["buff_detail/bg/air_atk_txt"] = "_control.bg.air_atk_txt",
			["buff_detail/bg/bg_1"] = "_control.bg.bg_1",
			["buff_detail/bg/title"] = "_control.bg.title",
			["buff_detail/bg/scrollview/content/info"] = "_control.bg.scrollview.content.info",
			["buff_detail/bg/scrollview"] = "_control.bg.scrollview",
			["buff_detail/bg/scrollview/content"] = "_control.bg.scrollview.content",
			["buff_detail/bg/level"] = "_control.bg.level",
			["buff_detail/bg"] = "_control.bg"
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/bg_1"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

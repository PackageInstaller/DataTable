return {
	_rule_ = {
		none = {
			select_layer = {
				path = "select_layer",
				list = {
					takeoff_btn = {
						path = "select_layer/takeoff_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			info_layer = {
				path = "info_layer",
				list = {
					bg = {
						path = "info_layer/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					map_title_txt = {
						path = "info_layer/map_title_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.Outline"
						}
					},
					task_txt = {
						path = "info_layer/task_txt",
						list = {
							task_txt_1 = {
								path = "info_layer/task_txt/task_txt_1",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							name_dd_2 = {
								path = "info_layer/task_txt/name_dd_2",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Mask",
							"TextHorizonScroller",
							"UnityEngine.UI.Image"
						}
					},
					complete_image = {
						path = "info_layer/complete_image",
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
		call_node_list = {
			["single_special_task/info_layer/map_title_txt"] = "_control.info_layer.map_title_txt",
			["single_special_task/select_layer/takeoff_btn"] = "_control.select_layer.takeoff_btn",
			["single_special_task/info_layer/complete_image"] = "_control.info_layer.complete_image",
			["single_special_task/info_layer"] = "_control.info_layer",
			["single_special_task/select_layer"] = "_control.select_layer",
			["single_special_task/info_layer/task_txt/task_txt_1"] = "_control.info_layer.task_txt.task_txt_1",
			["single_special_task/info_layer/task_txt"] = "_control.info_layer.task_txt",
			["single_special_task/info_layer/task_txt/name_dd_2"] = "_control.info_layer.task_txt.name_dd_2",
			["single_special_task/info_layer/bg"] = "_control.info_layer.bg"
		},
		click = {
			["select_layer/takeoff_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			takeoff_btn = {
				component = "UnityEngine.Canvas",
				path = "select_layer/takeoff_btn"
			}
		}
	}
}

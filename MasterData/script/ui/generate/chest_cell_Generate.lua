return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					icon = {
						path = "bg/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					lock_icon = {
						path = "bg/lock_icon",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask"
				}
			},
			frame = {
				path = "frame",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			name_mask = {
				path = "name_mask",
				list = {
					name_txt = {
						path = "name_mask/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_txt_1 = {
						path = "name_mask/name_txt_1",
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
					"UnityEngine.UI.Mask",
					"UnityEngine.UI.Image",
					"TextScroller"
				}
			},
			new_lable = {
				path = "new_lable",
				list = {
					txt = {
						path = "new_lable/txt",
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
					"UnityEngine.UI.Image"
				}
			},
			special_ske = {
				path = "special_ske",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			info_button = {
				path = "info_button",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["chest_cell/new_lable"] = "_control.new_lable",
			["chest_cell/frame"] = "_control.frame",
			["chest_cell/bg/icon"] = "_control.bg.icon",
			["chest_cell/special_ske"] = "_control.special_ske",
			["chest_cell/new_lable/txt"] = "_control.new_lable.txt",
			["chest_cell/name_mask"] = "_control.name_mask",
			["chest_cell/info_button"] = "_control.info_button",
			["chest_cell/bg/lock_icon"] = "_control.bg.lock_icon",
			["chest_cell/name_mask/name_txt"] = "_control.name_mask.name_txt",
			["chest_cell/bg"] = "_control.bg",
			["chest_cell/name_mask/name_txt_1"] = "_control.name_mask.name_txt_1"
		},
		click = {
			frame = {
				tp = "UnityEngine.UI.Button"
			},
			info_button = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

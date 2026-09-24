return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					not_open_layer = {
						path = "bg/not_open_layer",
						list = {
							not_open_txt = {
								path = "bg/not_open_layer/not_open_txt",
								list = {
									split_image = {
										path = "bg/not_open_layer/not_open_txt/split_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									split_image_end = {
										path = "bg/not_open_layer/not_open_txt/split_image_end",
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
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					not_active_layer = {
						path = "bg/not_active_layer",
						list = {
							not_open_txt = {
								path = "bg/not_active_layer/not_open_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					name_layer = {
						path = "bg/name_layer",
						list = {
							tactics_bg = {
								path = "bg/name_layer/tactics_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							name_bg = {
								path = "bg/name_layer/name_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							name_txt = {
								path = "bg/name_layer/name_txt",
								list = {
									name_txt_1 = {
										path = "bg/name_layer/name_txt/name_txt_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									name_txt_2 = {
										path = "bg/name_layer/name_txt/name_txt_2",
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
									"TextHorizonScroller",
									"UnityEngine.UI.Image"
								}
							},
							detail_btn = {
								path = "bg/name_layer/detail_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
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
					"UnityEngine.CanvasRenderer"
				}
			}
		},
		call_node_list = {
			["single_tactics_collection/bg/not_active_layer/not_open_txt"] = "_control.bg.not_active_layer.not_open_txt",
			["single_tactics_collection/bg/not_open_layer/not_open_txt/split_image_end"] = "_control.bg.not_open_layer.not_open_txt.split_image_end",
			["single_tactics_collection/bg/name_layer/name_txt"] = "_control.bg.name_layer.name_txt",
			["single_tactics_collection/bg/not_open_layer"] = "_control.bg.not_open_layer",
			["single_tactics_collection/bg/name_layer/name_txt/name_txt_1"] = "_control.bg.name_layer.name_txt.name_txt_1",
			["single_tactics_collection/bg/not_open_layer/not_open_txt/split_image"] = "_control.bg.not_open_layer.not_open_txt.split_image",
			["single_tactics_collection/bg/not_active_layer"] = "_control.bg.not_active_layer",
			["single_tactics_collection/bg/name_layer/tactics_bg"] = "_control.bg.name_layer.tactics_bg",
			["single_tactics_collection/bg/name_layer/name_txt/name_txt_2"] = "_control.bg.name_layer.name_txt.name_txt_2",
			["single_tactics_collection/bg"] = "_control.bg",
			["single_tactics_collection/bg/name_layer"] = "_control.bg.name_layer",
			["single_tactics_collection/bg/name_layer/detail_btn"] = "_control.bg.name_layer.detail_btn",
			["single_tactics_collection/bg/name_layer/name_bg"] = "_control.bg.name_layer.name_bg",
			["single_tactics_collection/bg/not_open_layer/not_open_txt"] = "_control.bg.not_open_layer.not_open_txt"
		},
		click = {
			["bg/name_layer/detail_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

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
			model = {
				path = "model",
				list = {
					bg = {
						path = "model/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mask = {
						path = "model/mask",
						list = {
							icon = {
								path = "model/mask/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							equip_icon = {
								path = "model/mask/equip_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							not_get_btn = {
								path = "model/mask/not_get_btn",
								list = {
									Text = {
										path = "model/mask/not_get_btn/Text",
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
							},
							already_get_btn = {
								path = "model/mask/already_get_btn",
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
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["single_ship_available/model/mask/not_get_btn"] = "_control.model.mask.not_get_btn",
			["single_ship_available/model/mask/equip_icon"] = "_control.model.mask.equip_icon",
			["single_ship_available/model/mask/already_get_btn"] = "_control.model.mask.already_get_btn",
			["single_ship_available/model/mask/not_get_btn/Text"] = "_control.model.mask.not_get_btn.Text",
			["single_ship_available/model/mask"] = "_control.model.mask",
			["single_ship_available/model/mask/icon"] = "_control.model.mask.icon",
			["single_ship_available/model"] = "_control.model",
			["single_ship_available/model/bg"] = "_control.model.bg",
			["single_ship_available/bg"] = "_control.bg"
		},
		click = {
			["model/mask/not_get_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["model/mask/already_get_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

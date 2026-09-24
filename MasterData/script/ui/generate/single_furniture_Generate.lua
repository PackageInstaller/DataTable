return {
	_rule_ = {
		none = {
			frame = {
				path = "frame",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask",
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
			put_dorm = {
				path = "put_dorm",
				list = {
					icondes = {
						path = "put_dorm/icondes",
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
			lock = {
				path = "lock",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			select = {
				path = "select",
				list = {
					icon = {
						path = "select/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					num = {
						path = "select/num",
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
			lock_btn = {
				path = "lock_btn",
				list = {
					lock_effect = {
						path = "lock_btn/lock_effect",
						list = {
							title = {
								path = "lock_btn/lock_effect/title",
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
			["single_furniture/bg"] = "_control.bg",
			["single_furniture/name_mask/name_txt_1"] = "_control.name_mask.name_txt_1",
			["single_furniture/name_mask/name_txt"] = "_control.name_mask.name_txt",
			["single_furniture/bg/icon"] = "_control.bg.icon",
			["single_furniture/select"] = "_control.select",
			["single_furniture/lock"] = "_control.lock",
			["single_furniture/put_dorm"] = "_control.put_dorm",
			["single_furniture/name_mask"] = "_control.name_mask",
			["single_furniture/lock_btn/lock_effect"] = "_control.lock_btn.lock_effect",
			["single_furniture/put_dorm/icondes"] = "_control.put_dorm.icondes",
			["single_furniture/frame"] = "_control.frame",
			["single_furniture/lock_btn"] = "_control.lock_btn",
			["single_furniture/select/num"] = "_control.select.num",
			["single_furniture/select/icon"] = "_control.select.icon",
			["single_furniture/lock_btn/lock_effect/title"] = "_control.lock_btn.lock_effect.title"
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			},
			put_dorm = {
				tp = "UnityEngine.UI.Button"
			},
			lock_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

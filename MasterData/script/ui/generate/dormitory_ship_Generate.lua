return {
	_rule_ = {
		none = {
			sort_layer = {
				path = "sort_layer",
				list = {
					shadow = {
						path = "sort_layer/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					ship = {
						path = "sort_layer/ship",
						list = {
							spine = {
								path = "sort_layer/ship/spine",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							expression = {
								path = "sort_layer/ship/expression",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup"
								}
							},
							love_up = {
								path = "sort_layer/ship/love_up",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							ship_collider = {
								path = "sort_layer/ship/ship_collider",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.BoxCollider2D",
									"UnityEngine.Rigidbody2D",
									"Trigger2DEvent"
								}
							},
							bone = {
								path = "sort_layer/ship/bone",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"Spine.Unity.BoneFollowerGraphic"
								}
							},
							love_num = {
								path = "sort_layer/ship/love_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.CanvasGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					ship_btn = {
						path = "sort_layer/ship_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"ClickAndLongClickEvent",
							"PointerDownUpEvent",
							"DragableItem"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		click = {
			["sort_layer/ship_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		drag = {
			["sort_layer/ship_btn"] = {
				tp = "DragableItem"
			}
		},
		click_and_long_click = {
			["sort_layer/ship_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		pointer_down_up = {
			["sort_layer/ship_btn"] = {
				tp = "PointerDownUpEvent"
			}
		},
		trigger_2d = {
			["sort_layer/ship/ship_collider"] = {
				tp = "Trigger2DEvent"
			}
		},
		canvas_set = {
			sort_layer = {
				component = "UnityEngine.Canvas",
				path = "sort_layer"
			}
		}
	}
}

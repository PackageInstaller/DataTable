return {
	_rule_ = {
		none = {
			sort_layer = {
				path = "sort_layer",
				list = {
					img = {
						path = "sort_layer/img",
						list = {
							childImg = {
								path = "sort_layer/img/childImg",
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
							"UnityEngine.CanvasGroup",
							"DragableItem",
							"PointerDownUpEvent"
						}
					},
					spine = {
						path = "sort_layer/spine",
						list = {
							furniture_collider = {
								path = "sort_layer/spine/furniture_collider",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.BoxCollider2D",
									"UnityEngine.Rigidbody2D",
									"Trigger2DEvent"
								}
							},
							hand_h = {
								path = "sort_layer/spine/hand_h",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							hand_m = {
								path = "sort_layer/spine/hand_m",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							hand_s = {
								path = "sort_layer/spine/hand_s",
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
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			sort_layer2 = {
				path = "sort_layer2",
				list = {
					img = {
						path = "sort_layer2/img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					spine = {
						path = "sort_layer2/spine",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas"
				}
			}
		},
		drag = {
			["sort_layer/img"] = {
				tp = "DragableItem"
			}
		},
		pointer_down_up = {
			["sort_layer/img"] = {
				tp = "PointerDownUpEvent"
			}
		},
		trigger_2d = {
			["sort_layer/spine/furniture_collider"] = {
				tp = "Trigger2DEvent"
			}
		},
		canvas_set = {
			sort_layer = {
				component = "UnityEngine.Canvas",
				path = "sort_layer"
			},
			sort_layer2 = {
				component = "UnityEngine.Canvas",
				path = "sort_layer2"
			}
		}
	}
}

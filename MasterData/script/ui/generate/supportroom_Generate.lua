return {
	_rule_ = {
		none = {
			bottom = {
				path = "bottom",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			back = {
				path = "back",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			home_back = {
				path = "home_back",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			main = {
				path = "main",
				list = {
					table = {
						path = "main/table",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					supportmap = {
						path = "main/supportmap",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"PointerDownUpEvent"
						}
					},
					supportbtn = {
						path = "main/supportbtn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					grademap = {
						path = "main/grademap",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"PointerDownUpEvent"
						}
					},
					gradebtn = {
						path = "main/gradebtn",
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
					"UnityEngine.RectTransform"
				}
			},
			menubtn = {
				path = "menubtn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			menu = {
				path = "menu",
				list = {
					main = {
						path = "menu/main",
						list = {
							bemask = {
								path = "menu/main/bemask",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btn = {
								path = "menu/main/btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							bubblezu = {
								path = "menu/main/bubblezu",
								list = {
									bubble = {
										path = "menu/main/bubblezu/bubble",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									support = {
										path = "menu/main/bubblezu/support",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button",
											"UnityEngine.CanvasGroup"
										}
									},
									grade = {
										path = "menu/main/bubblezu/grade",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button",
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
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
			character = {
				path = "character",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			model_layer = {
				path = "model_layer",
				list = {
					talk = {
						path = "model_layer/talk",
						list = {
							bg1 = {
								path = "model_layer/talk/bg1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg2 = {
								path = "model_layer/talk/bg2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							label_txt = {
								path = "model_layer/talk/label_txt",
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
							"UnityEngine.CanvasGroup",
							"PopVerticalAdaptive"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UIMoveTweener",
					"UIMoveTweener",
					"UIMoveTweener",
					"UITweenSequence"
				}
			}
		},
		call_node_list = {
			["supportroom/menu/main"] = "_control.menu.main",
			["supportroom/menu"] = "_control.menu",
			["supportroom/main/gradebtn"] = "_control.main.gradebtn",
			["supportroom/menu/main/btn"] = "_control.menu.main.btn",
			["supportroom/main/supportbtn"] = "_control.main.supportbtn",
			["supportroom/model_layer/talk/bg2"] = "_control.model_layer.talk.bg2",
			["supportroom/home_back"] = "_control.home_back",
			["supportroom/character"] = "_control.character",
			["supportroom/model_layer"] = "_control.model_layer",
			["supportroom/model_layer/talk"] = "_control.model_layer.talk",
			["supportroom/menu/main/bubblezu/grade"] = "_control.menu.main.bubblezu.grade",
			["supportroom/model_layer/talk/bg1"] = "_control.model_layer.talk.bg1",
			["supportroom/bg"] = "_control.bg",
			["supportroom/main/grademap"] = "_control.main.grademap",
			["supportroom/bottom"] = "_control.bottom",
			["supportroom/main/table"] = "_control.main.table",
			["supportroom/main"] = "_control.main",
			["supportroom/menubtn"] = "_control.menubtn",
			["supportroom/menu/main/bemask"] = "_control.menu.main.bemask",
			["supportroom/back"] = "_control.back",
			["supportroom/menu/main/bubblezu/bubble"] = "_control.menu.main.bubblezu.bubble",
			["supportroom/main/supportmap"] = "_control.main.supportmap",
			["supportroom/menu/main/bubblezu/support"] = "_control.menu.main.bubblezu.support",
			["supportroom/menu/main/bubblezu"] = "_control.menu.main.bubblezu",
			["supportroom/model_layer/talk/label_txt"] = "_control.model_layer.talk.label_txt"
		},
		click = {
			back = {
				tp = "UnityEngine.UI.Button"
			},
			home_back = {
				tp = "UnityEngine.UI.Button"
			},
			["main/supportmap"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/supportbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/grademap"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/gradebtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			menubtn = {
				tp = "UnityEngine.UI.Button"
			},
			menu = {
				tp = "UnityEngine.UI.Button"
			},
			["menu/main/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu/main/bubblezu/bubble"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu/main/bubblezu/support"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu/main/bubblezu/grade"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		pointer_down_up = {
			["main/supportmap"] = {
				tp = "PointerDownUpEvent"
			},
			["main/grademap"] = {
				tp = "PointerDownUpEvent"
			}
		},
		canvas_set = {}
	}
}

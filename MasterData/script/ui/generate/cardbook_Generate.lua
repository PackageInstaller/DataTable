return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			top = {
				path = "top",
				list = {
					return_btn = {
						path = "top/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					title_txt = {
						path = "top/title_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					Image = {
						path = "top/Image",
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
			},
			scrollview = {
				path = "scrollview",
				list = {
					content = {
						path = "scrollview/content",
						list = {
							rank_btn_1 = {
								path = "scrollview/content/rank_btn_1",
								list = {
									title = {
										path = "scrollview/content/rank_btn_1/title",
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
							rank_btn_2 = {
								path = "scrollview/content/rank_btn_2",
								list = {
									title = {
										path = "scrollview/content/rank_btn_2/title",
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
							rank_btn_3 = {
								path = "scrollview/content/rank_btn_3",
								list = {
									title = {
										path = "scrollview/content/rank_btn_3/title",
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
							rank_btn_4 = {
								path = "scrollview/content/rank_btn_4",
								list = {
									title = {
										path = "scrollview/content/rank_btn_4/title",
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
							"UnityEngine.RectTransform",
							"UnityEngine.UI.GridLayoutGroup",
							"UIMoveTweener",
							"UIMoveTweener"
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
			}
		},
		click = {
			["scrollview/content/rank_btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["scrollview/content/rank_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["scrollview/content/rank_btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["scrollview/content/rank_btn_4"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top/return_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

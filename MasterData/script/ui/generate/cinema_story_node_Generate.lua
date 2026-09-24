return {
	_rule_ = {
		none = {
			handover_tweem = {
				path = "handover_tweem",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
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
			test = {
				path = "test",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			scrollview_1 = {
				path = "scrollview_1",
				list = {
					viewport = {
						path = "scrollview_1/viewport",
						list = {
							content = {
								path = "scrollview_1/viewport/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.GridLayoutGroup",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					scrollbarvertical = {
						path = "scrollview_1/scrollbarvertical",
						list = {
							slidingarea = {
								path = "scrollview_1/scrollbarvertical/slidingarea",
								list = {
									handle = {
										path = "scrollview_1/scrollbarvertical/slidingarea/handle",
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
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Scrollbar"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.ScrollRect",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup",
					"Matrix.UIGroupFadeTweener",
					"Matrix.UIGroupFadeTweener"
				}
			},
			scrollview_2 = {
				path = "scrollview_2",
				list = {
					viewport = {
						path = "scrollview_2/viewport",
						list = {
							content = {
								path = "scrollview_2/viewport/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.GridLayoutGroup",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					scrollbarvertical = {
						path = "scrollview_2/scrollbarvertical",
						list = {
							slidingarea = {
								path = "scrollview_2/scrollbarvertical/slidingarea",
								list = {
									handle = {
										path = "scrollview_2/scrollbarvertical/slidingarea/handle",
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
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Scrollbar"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.ScrollRect",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup",
					"Matrix.UIGroupFadeTweener",
					"Matrix.UIGroupFadeTweener"
				}
			},
			title = {
				path = "title",
				list = {
					txt = {
						path = "title/txt",
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
			handover_btn = {
				path = "handover_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			close_btn = {
				path = "close_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			cover = {
				path = "cover",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			cover_2 = {
				path = "cover_2",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		click = {
			handover_btn = {
				tp = "UnityEngine.UI.Button"
			},
			close_btn = {
				tp = "UnityEngine.UI.Button"
			},
			cover = {
				tp = "UnityEngine.UI.Button"
			},
			cover_2 = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

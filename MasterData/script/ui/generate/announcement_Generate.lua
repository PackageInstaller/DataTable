return {
	_rule_ = {
		none = {
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			fragment = {
				path = "fragment",
				list = {
					mainfragment = {
						path = "fragment/mainfragment",
						list = {
							bg = {
								path = "fragment/mainfragment/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mask = {
								path = "fragment/mainfragment/mask",
								list = {
									glow = {
										path = "fragment/mainfragment/mask/glow",
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
							corner = {
								path = "fragment/mainfragment/corner",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							titlebg = {
								path = "fragment/mainfragment/titlebg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "fragment/mainfragment/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "fragment/mainfragment/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							toggle = {
								path = "fragment/mainfragment/toggle",
								list = {
									bg = {
										path = "fragment/mainfragment/toggle/bg",
										list = {
											checkmark = {
												path = "fragment/mainfragment/toggle/bg/checkmark",
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
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Toggle"
								}
							},
							tips = {
								path = "fragment/mainfragment/tips",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					main = {
						path = "fragment/main",
						list = {
							uni_web_view = {
								path = "fragment/main/uni_web_view",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UniWebView"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					line = {
						path = "fragment/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					returnbtn = {
						path = "fragment/returnbtn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		scale_btn_click = {
			["fragment/returnbtn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["fragment/mainfragment/toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		uni_web_view = {
			["fragment/main/uni_web_view"] = {
				tp = "UniWebView"
			}
		},
		canvas_set = {}
	}
}

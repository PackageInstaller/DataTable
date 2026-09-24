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
			main = {
				path = "main",
				list = {
					bg = {
						path = "main/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close = {
						path = "main/close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					main = {
						path = "main/main",
						list = {
							ship = {
								path = "main/main/ship",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							introduce = {
								path = "main/main/introduce",
								list = {
									bg = {
										path = "main/main/introduce/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									introduce_text = {
										path = "main/main/introduce/introduce_text",
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
							sign_main = {
								path = "main/main/sign_main",
								list = {
									scrollview = {
										path = "main/main/sign_main/scrollview",
										list = {
											viewport = {
												path = "main/main/sign_main/scrollview/viewport",
												list = {
													content = {
														path = "main/main/sign_main/scrollview/viewport/content",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"EndlessScrollView"
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
												path = "main/main/sign_main/scrollview/scrollbarvertical",
												list = {
													slidingarea = {
														path = "main/main/sign_main/scrollview/scrollbarvertical/slidingarea",
														list = {
															handle = {
																path = "main/main/sign_main/scrollview/scrollbarvertical/slidingarea/handle",
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
							"UnityEngine.RectTransform"
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
		click = {
			["main/close"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

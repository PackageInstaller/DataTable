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
			cardintroduce = {
				path = "cardintroduce",
				list = {
					bg = {
						path = "cardintroduce/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					unknow = {
						path = "cardintroduce/unknow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mainintroduce = {
						path = "cardintroduce/mainintroduce",
						list = {
							infobg = {
								path = "cardintroduce/mainintroduce/infobg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							infoname = {
								path = "cardintroduce/mainintroduce/infoname",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							cardcontent = {
								path = "cardintroduce/mainintroduce/cardcontent",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							btn = {
								path = "cardintroduce/mainintroduce/btn",
								list = {
									btn_text = {
										path = "cardintroduce/mainintroduce/btn/btn_text",
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
							"UnityEngine.RectTransform"
						}
					},
					allcards = {
						path = "cardintroduce/allcards",
						list = {
							cardslist = {
								path = "cardintroduce/allcards/cardslist",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mainlist_maybe = {
								path = "cardintroduce/allcards/mainlist_maybe",
								list = {
									scrollview = {
										path = "cardintroduce/allcards/mainlist_maybe/scrollview",
										list = {
											viewport = {
												path = "cardintroduce/allcards/mainlist_maybe/scrollview/viewport",
												list = {
													content = {
														path = "cardintroduce/allcards/mainlist_maybe/scrollview/viewport/content",
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
					},
					top = {
						path = "cardintroduce/top",
						list = {
							backbg = {
								path = "cardintroduce/top/backbg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							back = {
								path = "cardintroduce/top/back",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							line = {
								path = "cardintroduce/top/line",
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
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["cardintroduce/mainintroduce/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["cardintroduce/top/back"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

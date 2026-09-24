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
			test = {
				path = "test",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			return_btn = {
				path = "return_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"ScaleButton"
				}
			},
			line_group = {
				path = "line_group",
				list = {
					line_1 = {
						path = "line_group/line_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					line_2 = {
						path = "line_group/line_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					line_3 = {
						path = "line_group/line_3",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					line_4 = {
						path = "line_group/line_4",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			btn_group = {
				path = "btn_group",
				list = {
					main_story_btn = {
						path = "btn_group/main_story_btn",
						list = {
							bg = {
								path = "btn_group/main_story_btn/bg",
								list = {
									cm = {
										path = "btn_group/main_story_btn/bg/cm",
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
							},
							txt = {
								path = "btn_group/main_story_btn/txt",
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
							"UnityEngine.UI.Toggle"
						}
					},
					chara_story_btn = {
						path = "btn_group/chara_story_btn",
						list = {
							bg = {
								path = "btn_group/chara_story_btn/bg",
								list = {
									cm = {
										path = "btn_group/chara_story_btn/bg/cm",
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
							},
							txt = {
								path = "btn_group/chara_story_btn/txt",
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
							"UnityEngine.UI.Toggle"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.ToggleGroup"
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
					"UnityEngine.UI.Image"
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
					"UnityEngine.UI.Image"
				}
			}
		},
		scale_btn_click = {
			return_btn = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["btn_group/main_story_btn"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["btn_group/chara_story_btn"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

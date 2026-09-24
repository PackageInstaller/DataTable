return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					top_menu = {
						path = "bg/top_menu",
						list = {
							return_btn = {
								path = "bg/top_menu/return_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							medal_list_text = {
								path = "bg/top_menu/medal_list_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line_1 = {
								path = "bg/top_menu/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UITweenSequence"
								}
							},
							tips = {
								path = "bg/top_menu/tips",
								list = {
									front_point = {
										path = "bg/top_menu/tips/front_point",
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
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
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
					"UITweenSequence"
				}
			},
			bg_test = {
				path = "bg_test",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			medal_list_text = {
				path = "medal_list_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			line_2 = {
				path = "line_2",
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
					"UIMoveTweener",
					"UIMoveTweener",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.ScrollRect",
					"UnityEngine.CanvasRenderer",
					"UIMoveTweener",
					"UIMoveTweener",
					"UnityEngine.UI.Image"
				}
			},
			type = {
				path = "type",
				list = {
					type_text = {
						path = "type/type_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					type_bg = {
						path = "type/type_bg",
						list = {
							txt = {
								path = "type/type_bg/txt",
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
			},
			medal_count = {
				path = "medal_count",
				list = {
					line_3 = {
						path = "medal_count/line_3",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					medal_count_text = {
						path = "medal_count/medal_count_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					medal_count_number = {
						path = "medal_count/medal_count_number",
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
			show_medal = {
				path = "show_medal",
				list = {
					show_medal_text = {
						path = "show_medal/show_medal_text",
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
			use_medal = {
				path = "use_medal",
				list = {
					use_medal_text = {
						path = "use_medal/use_medal_text",
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
			supplement_tips = {
				path = "supplement_tips",
				list = {
					bg = {
						path = "supplement_tips/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					base_panel = {
						path = "supplement_tips/base_panel",
						list = {
							top = {
								path = "supplement_tips/base_panel/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							gogo = {
								path = "supplement_tips/base_panel/gogo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "supplement_tips/base_panel/title",
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
					line = {
						path = "supplement_tips/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					expand_des = {
						path = "supplement_tips/expand_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					supplement_btn = {
						path = "supplement_tips/supplement_btn",
						list = {
							txt = {
								path = "supplement_tips/supplement_btn/txt",
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
					cancel_btn = {
						path = "supplement_tips/cancel_btn",
						list = {
							txt = {
								path = "supplement_tips/cancel_btn/txt",
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
					collection_describe_test = {
						path = "supplement_tips/collection_describe_test",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_grey = {
						path = "supplement_tips/line_grey",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			cover = {
				path = "cover",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			type = {
				tp = "UnityEngine.UI.Button"
			},
			show_medal = {
				tp = "UnityEngine.UI.Button"
			},
			use_medal = {
				tp = "UnityEngine.UI.Button"
			},
			["supplement_tips/supplement_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["supplement_tips/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bg/top_menu/return_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {
			supplement_tips = {
				component = "UnityEngine.Canvas",
				path = "supplement_tips"
			}
		}
	}
}

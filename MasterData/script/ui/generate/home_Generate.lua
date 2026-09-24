return {
	_rule_ = {
		none = {
			background = {
				path = "background",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			camera_parent = {
				path = "camera_parent",
				list = {},
				component = {
					"UnityEngine.Transform"
				}
			},
			model_seq = {
				path = "model_seq",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			open_or_close_ui = {
				path = "open_or_close_ui",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			weather_layer = {
				path = "weather_layer",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			top_mask = {
				path = "top_mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			model_top_sprite = {
				path = "model_top_sprite",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			raw_image = {
				path = "raw_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.RawImage",
					"Live2DController"
				}
			},
			model_layer = {
				path = "model_layer",
				list = {
					cc_sprite = {
						path = "model_layer/cc_sprite",
						list = {
							icon = {
								path = "model_layer/cc_sprite/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.ContentSizeFitter",
									"ShipViewControl"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					model_btn = {
						path = "model_layer/model_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					model_btn_2 = {
						path = "model_layer/model_btn_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					home_spine_pre = {
						path = "model_layer/home_spine_pre",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"ShipViewControl"
						}
					},
					talk = {
						path = "model_layer/talk",
						list = {
							bg1 = {
								path = "model_layer/talk/bg1",
								list = {
									bg2 = {
										path = "model_layer/talk/bg1/bg2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg3 = {
										path = "model_layer/talk/bg1/bg3",
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
							"PopVerticalAdaptive",
							"UnityEngine.Canvas"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UIMoveTweener",
					"UIMoveTweener",
					"UIMoveTweener",
					"UIMoveTweener",
					"ShipViewControl"
				}
			},
			flower_day = {
				path = "flower_day",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			flower_night = {
				path = "flower_night",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			snow_day = {
				path = "snow_day",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			first_in_tween = {
				path = "first_in_tween",
				list = {
					shortcut_long_btn = {
						path = "first_in_tween/shortcut_long_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"HomeLongClickEvent",
							"UnityEngine.UI.Extensions.PassUIEvent"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			bottom = {
				path = "bottom",
				list = {
					main_bottom_bar = {
						path = "bottom/main_bottom_bar",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main_bottom_bar_mask = {
						path = "bottom/main_bottom_bar_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					menu_btn_glow = {
						path = "bottom/menu_btn_glow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					mp_new_mail_dot = {
						path = "bottom/mp_new_mail_dot",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main_float_content = {
						path = "bottom/main_float_content",
						list = {
							main_float_1 = {
								path = "bottom/main_float_content/main_float_1",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_1/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_1/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_1/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_1/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_1/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_1/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_2 = {
								path = "bottom/main_float_content/main_float_2",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_2/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_2/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_2/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_2/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_2/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_2/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_3 = {
								path = "bottom/main_float_content/main_float_3",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_3/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_3/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_3/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_3/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_3/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_3/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_4 = {
								path = "bottom/main_float_content/main_float_4",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_4/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_4/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_4/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_4/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_4/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_4/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_5 = {
								path = "bottom/main_float_content/main_float_5",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_5/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_5/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_5/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_5/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_5/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_5/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_6 = {
								path = "bottom/main_float_content/main_float_6",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_6/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_6/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_6/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_6/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_6/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_6/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_7 = {
								path = "bottom/main_float_content/main_float_7",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_7/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_7/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_7/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_7/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_7/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_7/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_8 = {
								path = "bottom/main_float_content/main_float_8",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_8/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "bottom/main_float_content/main_float_8/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									icon = {
										path = "bottom/main_float_content/main_float_8/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									red = {
										path = "bottom/main_float_content/main_float_8/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "bottom/main_float_content/main_float_8/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_8/click_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							main_float_9 = {
								path = "bottom/main_float_content/main_float_9",
								list = {},
								component = {}
							},
							main_float_10 = {
								path = "bottom/main_float_content/main_float_10",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_10/bg",
										list = {},
										component = {}
									},
									halo = {
										path = "bottom/main_float_content/main_float_10/halo",
										list = {},
										component = {}
									},
									icon = {
										path = "bottom/main_float_content/main_float_10/icon",
										list = {},
										component = {}
									},
									red = {
										path = "bottom/main_float_content/main_float_10/red",
										list = {},
										component = {}
									},
									num = {
										path = "bottom/main_float_content/main_float_10/num",
										list = {},
										component = {}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_10/click_btn",
										list = {},
										component = {
											"UnityEngine.UI.Button"
										}
									}
								},
								component = {}
							},
							main_float_11 = {
								path = "bottom/main_float_content/main_float_11",
								list = {
									bg = {
										path = "bottom/main_float_content/main_float_11/bg",
										list = {},
										component = {}
									},
									halo = {
										path = "bottom/main_float_content/main_float_11/halo",
										list = {},
										component = {}
									},
									icon = {
										path = "bottom/main_float_content/main_float_11/icon",
										list = {},
										component = {}
									},
									red = {
										path = "bottom/main_float_content/main_float_11/red",
										list = {},
										component = {}
									},
									num = {
										path = "bottom/main_float_content/main_float_11/num",
										list = {},
										component = {}
									},
									click_btn = {
										path = "bottom/main_float_content/main_float_11/click_btn",
										list = {},
										component = {
											"UnityEngine.UI.Button"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.HorizontalLayoutGroup",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					shortcut_btn = {
						path = "bottom/shortcut_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"LongClickDragAndPointerUpEvent",
							"UnityEngine.UI.Extensions.PassUIEvent"
						}
					},
					menu_btn = {
						path = "bottom/menu_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton",
							"ScaleButton",
							"ScaleButton"
						}
					},
					btn_out = {
						path = "bottom/btn_out",
						list = {
							light = {
								path = "bottom/btn_out/light",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							new = {
								path = "bottom/btn_out/new",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							red_image = {
								path = "bottom/btn_out/red_image",
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
							"ScaleButton"
						}
					},
					btn_ship = {
						path = "bottom/btn_ship",
						list = {
							light = {
								path = "bottom/btn_ship/light",
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
							"ScaleButton"
						}
					},
					btn_task = {
						path = "bottom/btn_task",
						list = {
							task_bg = {
								path = "bottom/btn_task/task_bg",
								list = {
									limit_time = {
										path = "bottom/btn_task/task_bg/limit_time",
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
							light = {
								path = "bottom/btn_task/light",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					outfight = {
						path = "bottom/outfight",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					shipyard = {
						path = "bottom/shipyard",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					task = {
						path = "bottom/task",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					task_event = {
						path = "bottom/task_event",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					fight_event = {
						path = "bottom/fight_event",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mp_task_light = {
						path = "bottom/mp_task_light",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mp_fight_light = {
						path = "bottom/mp_fight_light",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			bg = {
				path = "bottom/main_float_content/main_float_9/bg",
				list = {},
				component = {}
			},
			halo = {
				path = "bottom/main_float_content/main_float_9/halo",
				list = {},
				component = {}
			},
			icon = {
				path = "bottom/main_float_content/main_float_9/icon",
				list = {},
				component = {}
			},
			red = {
				path = "bottom/main_float_content/main_float_9/red",
				list = {},
				component = {}
			},
			num = {
				path = "bottom/main_float_content/main_float_9/num",
				list = {},
				component = {}
			},
			click_btn = {
				path = "bottom/main_float_content/main_float_9/click_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			action_layer = {
				path = "action_layer",
				list = {
					event_pve = {
						path = "action_layer/event_pve",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					event_dock = {
						path = "action_layer/event_dock",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					explore_finish = {
						path = "action_layer/explore_finish",
						list = {
							main_pop_big = {
								path = "action_layer/explore_finish/main_pop_big",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							main_event = {
								path = "action_layer/explore_finish/main_event",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							hasfinishedpveexplore = {
								path = "action_layer/explore_finish/hasfinishedpveexplore",
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
					dock_finish = {
						path = "action_layer/dock_finish",
						list = {
							main_pop_big = {
								path = "action_layer/dock_finish/main_pop_big",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							main_event = {
								path = "action_layer/dock_finish/main_event",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							label_txt = {
								path = "action_layer/dock_finish/label_txt",
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
					"UnityEngine.RectTransform"
				}
			},
			top = {
				path = "top",
				list = {
					main_up_bg = {
						path = "top/main_up_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main_up_bar_cover = {
						path = "top/main_up_bar_cover",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					user_res_bar = {
						path = "top/user_res_bar",
						list = {
							right_upon = {
								path = "top/user_res_bar/right_upon",
								list = {
									up_right_bg = {
										path = "top/user_res_bar/right_upon/up_right_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_bg = {
										path = "top/user_res_bar/right_upon/oil_bg",
										list = {
											oil_txt = {
												path = "top/user_res_bar/right_upon/oil_bg/oil_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											oil_icon = {
												path = "top/user_res_bar/right_upon/oil_bg/oil_icon",
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
									steel_bg = {
										path = "top/user_res_bar/right_upon/steel_bg",
										list = {
											steel_txt = {
												path = "top/user_res_bar/right_upon/steel_bg/steel_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											steel_icon = {
												path = "top/user_res_bar/right_upon/steel_bg/steel_icon",
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
									aluminum_bg = {
										path = "top/user_res_bar/right_upon/aluminum_bg",
										list = {
											aluminum_txt = {
												path = "top/user_res_bar/right_upon/aluminum_bg/aluminum_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											aluminuml_icon = {
												path = "top/user_res_bar/right_upon/aluminum_bg/aluminuml_icon",
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
									bullet_bg = {
										path = "top/user_res_bar/right_upon/bullet_bg",
										list = {
											bullet_txt = {
												path = "top/user_res_bar/right_upon/bullet_bg/bullet_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											bullet_icon = {
												path = "top/user_res_bar/right_upon/bullet_bg/bullet_icon",
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
									diamond_bg = {
										path = "top/user_res_bar/right_upon/diamond_bg",
										list = {
											diamond_txt = {
												path = "top/user_res_bar/right_upon/diamond_bg/diamond_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											diamond_icon = {
												path = "top/user_res_bar/right_upon/diamond_bg/diamond_icon",
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
									res_btn = {
										path = "top/user_res_bar/right_upon/res_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									buy_diamond = {
										path = "top/user_res_bar/right_upon/buy_diamond",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					resource_click = {
						path = "top/resource_click",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					exp_bar_bg = {
						path = "top/exp_bar_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					exp_bar = {
						path = "top/exp_bar",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					exp_decorate = {
						path = "top/exp_decorate",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					ui_close = {
						path = "top/ui_close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					ui_open = {
						path = "top/ui_open",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					level_txt = {
						path = "top/level_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_txt = {
						path = "top/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					icon_click = {
						path = "top/icon_click",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					role_scale = {
						path = "top/role_scale",
						list = {
							slide = {
								path = "top/role_scale/slide",
								list = {
									Background = {
										path = "top/role_scale/slide/Background",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									["Fill Area"] = {
										path = "top/role_scale/slide/Fill Area",
										list = {
											Fill = {
												path = "top/role_scale/slide/Fill Area/Fill",
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
									["Handle Slide Area"] = {
										path = "top/role_scale/slide/Handle Slide Area",
										list = {
											Handle = {
												path = "top/role_scale/slide/Handle Slide Area/Handle",
												list = {
													click_area = {
														path = "top/role_scale/slide/Handle Slide Area/Handle/click_area",
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
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Slider"
								}
							},
							add_btn = {
								path = "top/role_scale/add_btn",
								list = {
									add_btn2 = {
										path = "top/role_scale/add_btn/add_btn2",
										list = {
											add_btn3 = {
												path = "top/role_scale/add_btn/add_btn2/add_btn3",
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							reduce_btn = {
								path = "top/role_scale/reduce_btn",
								list = {
									reduce_btn2 = {
										path = "top/role_scale/reduce_btn/reduce_btn2",
										list = {
											reduce_btn3 = {
												path = "top/role_scale/reduce_btn/reduce_btn2/reduce_btn3",
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
					back_button = {
						path = "top/back_button",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					main_save_btn = {
						path = "top/main_save_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					main_reset_btn = {
						path = "top/main_reset_btn",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			mp_activity_node = {
				path = "mp_activity_node",
				list = {
					mask = {
						path = "mp_activity_node/mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main_activity_layer = {
						path = "mp_activity_node/main_activity_layer",
						list = {
							main_activity_bg = {
								path = "mp_activity_node/main_activity_layer/main_activity_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mp_activity_layer = {
								path = "mp_activity_node/main_activity_layer/mp_activity_layer",
								list = {
									layer_form = {
										path = "mp_activity_node/main_activity_layer/mp_activity_layer/layer_form",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									layer_black = {
										path = "mp_activity_node/main_activity_layer/mp_activity_layer/layer_black",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									layer_bottom = {
										path = "mp_activity_node/main_activity_layer/mp_activity_layer/layer_bottom",
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
							common_gray_bg = {
								path = "mp_activity_node/main_activity_layer/common_gray_bg",
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
					home_activity_scroll_view = {
						path = "mp_activity_node/home_activity_scroll_view",
						list = {
							lattice_scroll_view = {
								path = "mp_activity_node/home_activity_scroll_view/lattice_scroll_view",
								list = {
									viewport = {
										path = "mp_activity_node/home_activity_scroll_view/lattice_scroll_view/viewport",
										list = {
											content = {
												path = "mp_activity_node/home_activity_scroll_view/lattice_scroll_view/viewport/content",
												list = {},
												component = {
													"UnityEngine.RectTransform"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Mask"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"LatticeScrollRect",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					crumbs = {
						path = "mp_activity_node/crumbs",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.HorizontalLayoutGroup",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					cover = {
						path = "mp_activity_node/cover",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					back_image = {
						path = "mp_activity_node/back_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					surplus_time_text = {
						path = "mp_activity_node/surplus_time_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					light_layer = {
						path = "mp_activity_node/light_layer",
						list = {
							main_activity_light_0 = {
								path = "mp_activity_node/light_layer/main_activity_light_0",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							main_activity_light_1 = {
								path = "mp_activity_node/light_layer/main_activity_light_1",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			left_upon = {
				path = "left_upon",
				list = {
					on_button_living = {
						path = "left_upon/on_button_living",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					on_button_support = {
						path = "left_upon/on_button_support",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					node = {
						path = "left_upon/node",
						list = {
							on_button_buff = {
								path = "left_upon/node/on_button_buff",
								list = {
									buff_time = {
										path = "left_upon/node/on_button_buff/buff_time",
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
							on_item_button_buff = {
								path = "left_upon/node/on_item_button_buff",
								list = {
									buff_time = {
										path = "left_upon/node/on_item_button_buff/buff_time",
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
							on_furniture_button_buff = {
								path = "left_upon/node/on_furniture_button_buff",
								list = {
									buff_time = {
										path = "left_upon/node/on_furniture_button_buff/buff_time",
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
							on_combatshop_button_buff = {
								path = "left_upon/node/on_combatshop_button_buff",
								list = {
									buff_time = {
										path = "left_upon/node/on_combatshop_button_buff/buff_time",
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
							on_combattactics_button_buff = {
								path = "left_upon/node/on_combattactics_button_buff",
								list = {
									buff_time = {
										path = "left_upon/node/on_combattactics_button_buff/buff_time",
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
							"UnityEngine.UI.VerticalLayoutGroup"
						}
					},
					tip_bg = {
						path = "left_upon/tip_bg",
						list = {
							tip_bg_2 = {
								path = "left_upon/tip_bg/tip_bg_2",
								list = {
									title = {
										path = "left_upon/tip_bg/tip_bg_2/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									content = {
										path = "left_upon/tip_bg/tip_bg_2/content",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			blur_layer = {
				path = "blur_layer",
				list = {
					main_menu_mask = {
						path = "blur_layer/main_menu_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					resource_mask = {
						path = "blur_layer/resource_mask",
						list = {
							layer_1 = {
								path = "blur_layer/resource_mask/layer_1",
								list = {
									title = {
										path = "blur_layer/resource_mask/layer_1/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									oil_icon = {
										path = "blur_layer/resource_mask/layer_1/oil_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									txt = {
										path = "blur_layer/resource_mask/layer_1/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									recovery = {
										path = "blur_layer/resource_mask/layer_1/recovery",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							layer_2 = {
								path = "blur_layer/resource_mask/layer_2",
								list = {
									bullet_icon = {
										path = "blur_layer/resource_mask/layer_2/bullet_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									txt = {
										path = "blur_layer/resource_mask/layer_2/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									recovery = {
										path = "blur_layer/resource_mask/layer_2/recovery",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							layer_3 = {
								path = "blur_layer/resource_mask/layer_3",
								list = {
									steel_icon = {
										path = "blur_layer/resource_mask/layer_3/steel_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									txt = {
										path = "blur_layer/resource_mask/layer_3/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									recovery = {
										path = "blur_layer/resource_mask/layer_3/recovery",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							layer_4 = {
								path = "blur_layer/resource_mask/layer_4",
								list = {
									aluminuml_icon = {
										path = "blur_layer/resource_mask/layer_4/aluminuml_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									txt = {
										path = "blur_layer/resource_mask/layer_4/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									recovery = {
										path = "blur_layer/resource_mask/layer_4/recovery",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							layer_5 = {
								path = "blur_layer/resource_mask/layer_5",
								list = {
									title = {
										path = "blur_layer/resource_mask/layer_5/title",
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
									"UnityEngine.CanvasRenderer"
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
			model_blur_layer = {
				path = "model_blur_layer",
				list = {
					model_main_menu_mask = {
						path = "model_blur_layer/model_main_menu_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					resource_mask_layer = {
						path = "model_blur_layer/resource_mask_layer",
						list = {
							layer_1 = {
								path = "model_blur_layer/resource_mask_layer/layer_1",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							layer_2 = {
								path = "model_blur_layer/resource_mask_layer/layer_2",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							layer_3 = {
								path = "model_blur_layer/resource_mask_layer/layer_3",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							layer_4 = {
								path = "model_blur_layer/resource_mask_layer/layer_4",
								list = {},
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
					"UnityEngine.UI.Image"
				}
			},
			tip_layer = {
				path = "tip_layer",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bubble_layer = {
				path = "bubble_layer",
				list = {
					on_touch_bubble = {
						path = "bubble_layer/on_touch_bubble",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					bubble_btn_layer = {
						path = "bubble_layer/bubble_btn_layer",
						list = {
							main_bubble_bg = {
								path = "bubble_layer/bubble_btn_layer/main_bubble_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							main_bubble_develop = {
								path = "bubble_layer/bubble_btn_layer/main_bubble_develop",
								list = {
									main_bubble_new = {
										path = "bubble_layer/bubble_btn_layer/main_bubble_develop/main_bubble_new",
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
									"UnityEngine.UI.Button"
								}
							},
							main_bubble_mail = {
								path = "bubble_layer/bubble_btn_layer/main_bubble_mail",
								list = {
									main_bubble_new = {
										path = "bubble_layer/bubble_btn_layer/main_bubble_mail/main_bubble_new",
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
									"UnityEngine.UI.Button"
								}
							},
							main_bubble_build = {
								path = "bubble_layer/bubble_btn_layer/main_bubble_build",
								list = {
									main_bubble_new = {
										path = "bubble_layer/bubble_btn_layer/main_bubble_build/main_bubble_new",
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
									"UnityEngine.UI.Button"
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
					"UnityEngine.UI.Image"
				}
			},
			p_icon_touch_began = {
				path = "p_icon_touch_began",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["home/bottom/main_float_content/main_float_3/icon"] = "_control.bottom.main_float_content.main_float_3.icon",
			["home/blur_layer/resource_mask/layer_4/txt"] = "_control.blur_layer.resource_mask.layer_4.txt",
			["home/mp_activity_node"] = "_control.mp_activity_node",
			["home/bottom/main_float_content/main_float_2/num"] = "_control.bottom.main_float_content.main_float_2.num",
			["home/blur_layer/resource_mask/layer_4"] = "_control.blur_layer.resource_mask.layer_4",
			["home/blur_layer/resource_mask/layer_3/steel_icon"] = "_control.blur_layer.resource_mask.layer_3.steel_icon",
			["home/first_in_tween/shortcut_long_btn"] = "_control.first_in_tween.shortcut_long_btn",
			["home/mp_activity_node/main_activity_layer/mp_activity_layer"] = "_control.mp_activity_node.main_activity_layer.mp_activity_layer",
			["home/model_layer/talk"] = "_control.model_layer.talk",
			["home/blur_layer/resource_mask/layer_1/txt"] = "_control.blur_layer.resource_mask.layer_1.txt",
			["home/bottom/main_float_content/main_float_4/click_btn"] = "_control.bottom.main_float_content.main_float_4.click_btn",
			["home/blur_layer/resource_mask/layer_1/title"] = "_control.blur_layer.resource_mask.layer_1.title",
			["home/bottom/main_float_content/main_float_9/click_btn"] = "_control.click_btn",
			["home/bottom/main_bottom_bar"] = "_control.bottom.main_bottom_bar",
			["home/snow_day"] = "_control.snow_day",
			["home/mp_activity_node/light_layer/main_activity_light_0"] = "_control.mp_activity_node.light_layer.main_activity_light_0",
			["home/top/user_res_bar/right_upon/buy_diamond"] = "_control.top.user_res_bar.right_upon.buy_diamond",
			["home/weather_layer"] = "_control.weather_layer",
			["home/bottom/main_float_content/main_float_3/halo"] = "_control.bottom.main_float_content.main_float_3.halo",
			["home/bottom/main_float_content/main_float_5/num"] = "_control.bottom.main_float_content.main_float_5.num",
			["home/mp_activity_node/home_activity_scroll_view"] = "_control.mp_activity_node.home_activity_scroll_view",
			["home/bottom/main_float_content/main_float_8/icon"] = "_control.bottom.main_float_content.main_float_8.icon",
			["home/bottom/main_float_content/main_float_2/red"] = "_control.bottom.main_float_content.main_float_2.red",
			["home/blur_layer/resource_mask/layer_2/txt"] = "_control.blur_layer.resource_mask.layer_2.txt",
			["home/action_layer"] = "_control.action_layer",
			["home/bottom/btn_ship/light"] = "_control.bottom.btn_ship.light",
			["home/top/back_button"] = "_control.top.back_button",
			["home/bottom/main_float_content/main_float_6/bg"] = "_control.bottom.main_float_content.main_float_6.bg",
			["home/model_layer/model_btn"] = "_control.model_layer.model_btn",
			["home/top/role_scale/add_btn/add_btn2"] = "_control.top.role_scale.add_btn.add_btn2",
			["home/top/role_scale/slide/Fill Area/Fill"] = "_control.top.role_scale.slide.Fill Area.Fill",
			["home/bottom/outfight"] = "_control.bottom.outfight",
			["home/top/user_res_bar/right_upon/aluminum_bg"] = "_control.top.user_res_bar.right_upon.aluminum_bg",
			["home/top/role_scale/reduce_btn"] = "_control.top.role_scale.reduce_btn",
			["home/left_upon/node/on_item_button_buff"] = "_control.left_upon.node.on_item_button_buff",
			["home/model_layer/talk/bg1"] = "_control.model_layer.talk.bg1",
			["home/bottom/main_float_content/main_float_5/red"] = "_control.bottom.main_float_content.main_float_5.red",
			["home/top/exp_decorate"] = "_control.top.exp_decorate",
			["home/top/role_scale/slide/Handle Slide Area"] = "_control.top.role_scale.slide.Handle Slide Area",
			["home/bottom/main_float_content/main_float_6/num"] = "_control.bottom.main_float_content.main_float_6.num",
			["home/bottom/main_float_content/main_float_2/click_btn"] = "_control.bottom.main_float_content.main_float_2.click_btn",
			["home/top/user_res_bar/right_upon/diamond_bg"] = "_control.top.user_res_bar.right_upon.diamond_bg",
			["home/bottom/main_float_content/main_float_6/click_btn"] = "_control.bottom.main_float_content.main_float_6.click_btn",
			["home/top/role_scale"] = "_control.top.role_scale",
			["home/bottom/main_float_content/main_float_3"] = "_control.bottom.main_float_content.main_float_3",
			["home/bottom/main_float_content/main_float_8/num"] = "_control.bottom.main_float_content.main_float_8.num",
			["home/blur_layer/resource_mask/layer_5/title"] = "_control.blur_layer.resource_mask.layer_5.title",
			["home/top/user_res_bar/right_upon/bullet_bg/bullet_txt"] = "_control.top.user_res_bar.right_upon.bullet_bg.bullet_txt",
			["home/action_layer/explore_finish/hasfinishedpveexplore"] = "_control.action_layer.explore_finish.hasfinishedpveexplore",
			["home/bottom/main_float_content/main_float_4/icon"] = "_control.bottom.main_float_content.main_float_4.icon",
			["home/bottom/main_float_content/main_float_10/bg"] = "_control.bottom.main_float_content.main_float_10.bg",
			["home/first_in_tween"] = "_control.first_in_tween",
			["home/left_upon/node/on_combatshop_button_buff/buff_time"] = "_control.left_upon.node.on_combatshop_button_buff.buff_time",
			["home/bottom/main_float_content/main_float_3/red"] = "_control.bottom.main_float_content.main_float_3.red",
			["home/bottom/main_float_content/main_float_11/click_btn"] = "_control.bottom.main_float_content.main_float_11.click_btn",
			["home/bottom/main_float_content/main_float_11/bg"] = "_control.bottom.main_float_content.main_float_11.bg",
			["home/model_layer/model_btn_2"] = "_control.model_layer.model_btn_2",
			["home/bottom/main_float_content/main_float_5"] = "_control.bottom.main_float_content.main_float_5",
			["home/top/user_res_bar/right_upon/aluminum_bg/aluminum_txt"] = "_control.top.user_res_bar.right_upon.aluminum_bg.aluminum_txt",
			["home/left_upon/on_button_support"] = "_control.left_upon.on_button_support",
			["home/bottom/main_float_content/main_float_2/icon"] = "_control.bottom.main_float_content.main_float_2.icon",
			["home/bottom/main_float_content/main_float_10/red"] = "_control.bottom.main_float_content.main_float_10.red",
			["home/bottom/shortcut_btn"] = "_control.bottom.shortcut_btn",
			["home/top/main_up_bar_cover"] = "_control.top.main_up_bar_cover",
			["home/top/role_scale/reduce_btn/reduce_btn2/reduce_btn3"] = "_control.top.role_scale.reduce_btn.reduce_btn2.reduce_btn3",
			["home/bottom/main_float_content/main_float_1/icon"] = "_control.bottom.main_float_content.main_float_1.icon",
			["home/bottom/main_float_content/main_float_10/click_btn"] = "_control.bottom.main_float_content.main_float_10.click_btn",
			["home/top/user_res_bar/right_upon"] = "_control.top.user_res_bar.right_upon",
			["home/model_blur_layer/resource_mask_layer/layer_3"] = "_control.model_blur_layer.resource_mask_layer.layer_3",
			["home/bottom/main_float_content/main_float_1/click_btn"] = "_control.bottom.main_float_content.main_float_1.click_btn",
			["home/bottom/main_float_content/main_float_3/num"] = "_control.bottom.main_float_content.main_float_3.num",
			["home/bottom/main_float_content/main_float_9/icon"] = "_control.icon",
			["home/bubble_layer/bubble_btn_layer/main_bubble_develop"] = "_control.bubble_layer.bubble_btn_layer.main_bubble_develop",
			["home/bottom/main_float_content/main_float_1/bg"] = "_control.bottom.main_float_content.main_float_1.bg",
			["home/bottom/main_float_content/main_float_4/red"] = "_control.bottom.main_float_content.main_float_4.red",
			["home/top/user_res_bar/right_upon/steel_bg"] = "_control.top.user_res_bar.right_upon.steel_bg",
			["home/top/user_res_bar"] = "_control.top.user_res_bar",
			["home/blur_layer/resource_mask/layer_1/oil_icon"] = "_control.blur_layer.resource_mask.layer_1.oil_icon",
			["home/bottom/main_float_content/main_float_1/red"] = "_control.bottom.main_float_content.main_float_1.red",
			["home/top/user_res_bar/right_upon/steel_bg/steel_icon"] = "_control.top.user_res_bar.right_upon.steel_bg.steel_icon",
			["home/top/role_scale/slide/Handle Slide Area/Handle"] = "_control.top.role_scale.slide.Handle Slide Area.Handle",
			["home/bottom/main_float_content/main_float_5/click_btn"] = "_control.bottom.main_float_content.main_float_5.click_btn",
			["home/left_upon/on_button_living"] = "_control.left_upon.on_button_living",
			["home/model_layer/cc_sprite"] = "_control.model_layer.cc_sprite",
			["home/top/user_res_bar/right_upon/bullet_bg/bullet_icon"] = "_control.top.user_res_bar.right_upon.bullet_bg.bullet_icon",
			["home/bottom/main_float_content/main_float_6/halo"] = "_control.bottom.main_float_content.main_float_6.halo",
			["home/bottom/main_float_content/main_float_6/icon"] = "_control.bottom.main_float_content.main_float_6.icon",
			["home/bottom/main_float_content/main_float_6/red"] = "_control.bottom.main_float_content.main_float_6.red",
			["home/bottom/shipyard"] = "_control.bottom.shipyard",
			["home/bottom/main_float_content/main_float_7/bg"] = "_control.bottom.main_float_content.main_float_7.bg",
			["home/top/role_scale/slide/Background"] = "_control.top.role_scale.slide.Background",
			["home/bottom/main_float_content/main_float_2/bg"] = "_control.bottom.main_float_content.main_float_2.bg",
			["home/bottom/fight_event"] = "_control.bottom.fight_event",
			["home/flower_night"] = "_control.flower_night",
			["home/bottom/main_float_content/main_float_4/num"] = "_control.bottom.main_float_content.main_float_4.num",
			["home/bottom/main_float_content/main_float_7/red"] = "_control.bottom.main_float_content.main_float_7.red",
			["home/bottom/main_float_content/main_float_7/num"] = "_control.bottom.main_float_content.main_float_7.num",
			["home/bottom/main_float_content/main_float_8/red"] = "_control.bottom.main_float_content.main_float_8.red",
			["home/blur_layer/resource_mask/layer_1/recovery"] = "_control.blur_layer.resource_mask.layer_1.recovery",
			["home/bottom/main_float_content/main_float_9/halo"] = "_control.halo",
			["home/bottom/main_float_content/main_float_9/red"] = "_control.red",
			["home/bottom/main_float_content/main_float_5/halo"] = "_control.bottom.main_float_content.main_float_5.halo",
			["home/bottom/main_float_content/main_float_7/click_btn"] = "_control.bottom.main_float_content.main_float_7.click_btn",
			["home/left_upon/node/on_furniture_button_buff"] = "_control.left_upon.node.on_furniture_button_buff",
			["home/bottom/main_float_content/main_float_10/num"] = "_control.bottom.main_float_content.main_float_10.num",
			["home/bottom/main_float_content/main_float_3/bg"] = "_control.bottom.main_float_content.main_float_3.bg",
			["home/left_upon/node"] = "_control.left_upon.node",
			["home/bottom/main_float_content/main_float_11/red"] = "_control.bottom.main_float_content.main_float_11.red",
			["home/left_upon/node/on_button_buff"] = "_control.left_upon.node.on_button_buff",
			["home/bottom/main_float_content/main_float_3/click_btn"] = "_control.bottom.main_float_content.main_float_3.click_btn",
			["home/bottom/main_float_content/main_float_10/icon"] = "_control.bottom.main_float_content.main_float_10.icon",
			["home/mp_activity_node/home_activity_scroll_view/lattice_scroll_view/viewport"] = "_control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport",
			["home/bottom/main_float_content/main_float_9/num"] = "_control.num",
			["home/top/name_txt"] = "_control.top.name_txt",
			["home/left_upon/node/on_furniture_button_buff/buff_time"] = "_control.left_upon.node.on_furniture_button_buff.buff_time",
			["home/bottom/main_float_content/main_float_10/halo"] = "_control.bottom.main_float_content.main_float_10.halo",
			["home/bottom/main_float_content/main_float_1/halo"] = "_control.bottom.main_float_content.main_float_1.halo",
			["home/blur_layer/resource_mask/layer_2/recovery"] = "_control.blur_layer.resource_mask.layer_2.recovery",
			["home/bottom/main_float_content/main_float_5/icon"] = "_control.bottom.main_float_content.main_float_5.icon",
			["home/blur_layer/resource_mask/layer_3/recovery"] = "_control.blur_layer.resource_mask.layer_3.recovery",
			["home/bottom/main_float_content/main_float_10"] = "_control.bottom.main_float_content.main_float_10",
			["home/bottom/main_float_content/main_float_8/halo"] = "_control.bottom.main_float_content.main_float_8.halo",
			["home/top/ui_open"] = "_control.top.ui_open",
			["home/bottom/btn_ship"] = "_control.bottom.btn_ship",
			["home/top/role_scale/slide"] = "_control.top.role_scale.slide",
			["home/bottom/btn_task/light"] = "_control.bottom.btn_task.light",
			["home/bottom/main_float_content/main_float_7/halo"] = "_control.bottom.main_float_content.main_float_7.halo",
			["home/bubble_layer/bubble_btn_layer/main_bubble_bg"] = "_control.bubble_layer.bubble_btn_layer.main_bubble_bg",
			["home/bottom/main_float_content/main_float_4/halo"] = "_control.bottom.main_float_content.main_float_4.halo",
			["home/bubble_layer/bubble_btn_layer/main_bubble_mail/main_bubble_new"] = "_control.bubble_layer.bubble_btn_layer.main_bubble_mail.main_bubble_new",
			["home/bottom/menu_btn"] = "_control.bottom.menu_btn",
			["home/bubble_layer/bubble_btn_layer/main_bubble_build/main_bubble_new"] = "_control.bubble_layer.bubble_btn_layer.main_bubble_build.main_bubble_new",
			["home/bubble_layer/on_touch_bubble"] = "_control.bubble_layer.on_touch_bubble",
			["home/top/user_res_bar/right_upon/diamond_bg/diamond_txt"] = "_control.top.user_res_bar.right_upon.diamond_bg.diamond_txt",
			["home/bottom/mp_new_mail_dot"] = "_control.bottom.mp_new_mail_dot",
			["home/top/user_res_bar/right_upon/res_btn"] = "_control.top.user_res_bar.right_upon.res_btn",
			["home/mp_activity_node/main_activity_layer/main_activity_bg"] = "_control.mp_activity_node.main_activity_layer.main_activity_bg",
			["home/open_or_close_ui"] = "_control.open_or_close_ui",
			["home/bottom/btn_out/red_image"] = "_control.bottom.btn_out.red_image",
			["home/mp_activity_node/main_activity_layer/common_gray_bg"] = "_control.mp_activity_node.main_activity_layer.common_gray_bg",
			["home/top/exp_bar"] = "_control.top.exp_bar",
			["home/bottom/main_float_content/main_float_7"] = "_control.bottom.main_float_content.main_float_7",
			["home/left_upon/tip_bg/tip_bg_2/title"] = "_control.left_upon.tip_bg.tip_bg_2.title",
			["home/left_upon"] = "_control.left_upon",
			["home/background"] = "_control.background",
			["home/mp_activity_node/home_activity_scroll_view/lattice_scroll_view/viewport/content"] = "_control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view.viewport.content",
			["home/bottom/main_float_content/main_float_9"] = "_control.bottom.main_float_content.main_float_9",
			["home/top/main_up_bg"] = "_control.top.main_up_bg",
			["home/bottom/btn_task/task_bg"] = "_control.bottom.btn_task.task_bg",
			["home/mp_activity_node/main_activity_layer/mp_activity_layer/layer_bottom"] = "_control.mp_activity_node.main_activity_layer.mp_activity_layer.layer_bottom",
			["home/bottom/main_float_content/main_float_2/halo"] = "_control.bottom.main_float_content.main_float_2.halo",
			["home/top/user_res_bar/right_upon/oil_bg"] = "_control.top.user_res_bar.right_upon.oil_bg",
			["home/mp_activity_node/main_activity_layer/mp_activity_layer/layer_form"] = "_control.mp_activity_node.main_activity_layer.mp_activity_layer.layer_form",
			["home/flower_day"] = "_control.flower_day",
			["home/model_layer/talk/bg1/bg3"] = "_control.model_layer.talk.bg1.bg3",
			["home/left_upon/tip_bg/tip_bg_2"] = "_control.left_upon.tip_bg.tip_bg_2",
			["home/bottom/btn_task/task_bg/limit_time"] = "_control.bottom.btn_task.task_bg.limit_time",
			["home/blur_layer"] = "_control.blur_layer",
			["home/bottom/main_float_content/main_float_11/halo"] = "_control.bottom.main_float_content.main_float_11.halo",
			["home/bottom/main_float_content/main_float_2"] = "_control.bottom.main_float_content.main_float_2",
			["home/top/user_res_bar/right_upon/oil_bg/oil_icon"] = "_control.top.user_res_bar.right_upon.oil_bg.oil_icon",
			["home/action_layer/event_pve"] = "_control.action_layer.event_pve",
			["home/blur_layer/resource_mask/layer_1"] = "_control.blur_layer.resource_mask.layer_1",
			["home/bottom/task"] = "_control.bottom.task",
			["home/blur_layer/resource_mask/layer_3"] = "_control.blur_layer.resource_mask.layer_3",
			["home/bottom/task_event"] = "_control.bottom.task_event",
			["home/bottom/main_float_content/main_float_4/bg"] = "_control.bottom.main_float_content.main_float_4.bg",
			["home/top/role_scale/slide/Fill Area"] = "_control.top.role_scale.slide.Fill Area",
			["home/bottom/main_float_content"] = "_control.bottom.main_float_content",
			["home/top"] = "_control.top",
			["home/blur_layer/resource_mask/layer_5"] = "_control.blur_layer.resource_mask.layer_5",
			["home/bottom/main_float_content/main_float_5/bg"] = "_control.bottom.main_float_content.main_float_5.bg",
			["home/blur_layer/resource_mask"] = "_control.blur_layer.resource_mask",
			["home/top/role_scale/reduce_btn/reduce_btn2"] = "_control.top.role_scale.reduce_btn.reduce_btn2",
			["home/mp_activity_node/light_layer/main_activity_light_1"] = "_control.mp_activity_node.light_layer.main_activity_light_1",
			["home/left_upon/tip_bg"] = "_control.left_upon.tip_bg",
			["home/bottom/main_float_content/main_float_8/click_btn"] = "_control.bottom.main_float_content.main_float_8.click_btn",
			["home/bottom/mp_fight_light"] = "_control.bottom.mp_fight_light",
			["home/blur_layer/resource_mask/layer_4/recovery"] = "_control.blur_layer.resource_mask.layer_4.recovery",
			["home/model_layer"] = "_control.model_layer",
			["home/mp_activity_node/back_image"] = "_control.mp_activity_node.back_image",
			["home/bubble_layer/bubble_btn_layer"] = "_control.bubble_layer.bubble_btn_layer",
			["home/top/user_res_bar/right_upon/oil_bg/oil_txt"] = "_control.top.user_res_bar.right_upon.oil_bg.oil_txt",
			["home/top/user_res_bar/right_upon/bullet_bg"] = "_control.top.user_res_bar.right_upon.bullet_bg",
			["home/bottom/main_float_content/main_float_4"] = "_control.bottom.main_float_content.main_float_4",
			["home/left_upon/node/on_combatshop_button_buff"] = "_control.left_upon.node.on_combatshop_button_buff",
			["home/blur_layer/resource_mask/layer_2/bullet_icon"] = "_control.blur_layer.resource_mask.layer_2.bullet_icon",
			["home/mp_activity_node/main_activity_layer"] = "_control.mp_activity_node.main_activity_layer",
			["home/top/user_res_bar/right_upon/diamond_bg/diamond_icon"] = "_control.top.user_res_bar.right_upon.diamond_bg.diamond_icon",
			["home/bottom/btn_out"] = "_control.bottom.btn_out",
			["home/bottom/main_float_content/main_float_6"] = "_control.bottom.main_float_content.main_float_6",
			["home/bubble_layer/bubble_btn_layer/main_bubble_develop/main_bubble_new"] = "_control.bubble_layer.bubble_btn_layer.main_bubble_develop.main_bubble_new",
			["home/mp_activity_node/main_activity_layer/mp_activity_layer/layer_black"] = "_control.mp_activity_node.main_activity_layer.mp_activity_layer.layer_black",
			["home/model_blur_layer/model_main_menu_mask"] = "_control.model_blur_layer.model_main_menu_mask",
			["home/tip_layer"] = "_control.tip_layer",
			["home/model_blur_layer/resource_mask_layer/layer_2"] = "_control.model_blur_layer.resource_mask_layer.layer_2",
			["home/bubble_layer"] = "_control.bubble_layer",
			["home/model_blur_layer/resource_mask_layer/layer_4"] = "_control.model_blur_layer.resource_mask_layer.layer_4",
			["home/top/main_reset_btn"] = "_control.top.main_reset_btn",
			["home/left_upon/tip_bg/tip_bg_2/content"] = "_control.left_upon.tip_bg.tip_bg_2.content",
			["home/action_layer/explore_finish/main_pop_big"] = "_control.action_layer.explore_finish.main_pop_big",
			["home/bubble_layer/bubble_btn_layer/main_bubble_mail"] = "_control.bubble_layer.bubble_btn_layer.main_bubble_mail",
			["home/mp_activity_node/light_layer"] = "_control.mp_activity_node.light_layer",
			["home/bottom/mp_task_light"] = "_control.bottom.mp_task_light",
			["home/top/main_save_btn"] = "_control.top.main_save_btn",
			["home/left_upon/node/on_button_buff/buff_time"] = "_control.left_upon.node.on_button_buff.buff_time",
			["home/bottom/main_float_content/main_float_11"] = "_control.bottom.main_float_content.main_float_11",
			["home/blur_layer/resource_mask/layer_3/txt"] = "_control.blur_layer.resource_mask.layer_3.txt",
			["home/raw_image"] = "_control.raw_image",
			["home/camera_parent"] = "_control.camera_parent",
			["home/bottom/btn_task"] = "_control.bottom.btn_task",
			["home/left_upon/node/on_combattactics_button_buff"] = "_control.left_upon.node.on_combattactics_button_buff",
			["home/top/user_res_bar/right_upon/steel_bg/steel_txt"] = "_control.top.user_res_bar.right_upon.steel_bg.steel_txt",
			["home/top/role_scale/add_btn/add_btn2/add_btn3"] = "_control.top.role_scale.add_btn.add_btn2.add_btn3",
			["home/p_icon_touch_began"] = "_control.p_icon_touch_began",
			["home/model_blur_layer/resource_mask_layer/layer_1"] = "_control.model_blur_layer.resource_mask_layer.layer_1",
			["home/top/icon_click"] = "_control.top.icon_click",
			["home/model_layer/cc_sprite/icon"] = "_control.model_layer.cc_sprite.icon",
			["home/mp_activity_node/surplus_time_text"] = "_control.mp_activity_node.surplus_time_text",
			["home/top/resource_click"] = "_control.top.resource_click",
			["home/action_layer/dock_finish/main_pop_big"] = "_control.action_layer.dock_finish.main_pop_big",
			["home/model_blur_layer"] = "_control.model_blur_layer",
			["home/bottom/btn_out/new"] = "_control.bottom.btn_out.new",
			["home/blur_layer/main_menu_mask"] = "_control.blur_layer.main_menu_mask",
			["home/top/user_res_bar/right_upon/up_right_bg"] = "_control.top.user_res_bar.right_upon.up_right_bg",
			["home/left_upon/node/on_item_button_buff/buff_time"] = "_control.left_upon.node.on_item_button_buff.buff_time",
			["home/action_layer/event_dock"] = "_control.action_layer.event_dock",
			["home/bottom/main_float_content/main_float_8"] = "_control.bottom.main_float_content.main_float_8",
			["home/mp_activity_node/home_activity_scroll_view/lattice_scroll_view"] = "_control.mp_activity_node.home_activity_scroll_view.lattice_scroll_view",
			["home/blur_layer/resource_mask/layer_4/aluminuml_icon"] = "_control.blur_layer.resource_mask.layer_4.aluminuml_icon",
			["home/mp_activity_node/cover"] = "_control.mp_activity_node.cover",
			["home/model_layer/talk/label_txt"] = "_control.model_layer.talk.label_txt",
			["home/top/user_res_bar/right_upon/aluminum_bg/aluminuml_icon"] = "_control.top.user_res_bar.right_upon.aluminum_bg.aluminuml_icon",
			["home/model_seq"] = "_control.model_seq",
			["home/bottom/btn_out/light"] = "_control.bottom.btn_out.light",
			["home/left_upon/node/on_combattactics_button_buff/buff_time"] = "_control.left_upon.node.on_combattactics_button_buff.buff_time",
			["home/mp_activity_node/crumbs"] = "_control.mp_activity_node.crumbs",
			["home/top_mask"] = "_control.top_mask",
			["home/bubble_layer/bubble_btn_layer/main_bubble_build"] = "_control.bubble_layer.bubble_btn_layer.main_bubble_build",
			["home/bottom"] = "_control.bottom",
			["home/bottom/main_bottom_bar_mask"] = "_control.bottom.main_bottom_bar_mask",
			["home/action_layer/dock_finish/label_txt"] = "_control.action_layer.dock_finish.label_txt",
			["home/bottom/main_float_content/main_float_11/num"] = "_control.bottom.main_float_content.main_float_11.num",
			["home/bottom/menu_btn_glow"] = "_control.bottom.menu_btn_glow",
			["home/top/level_txt"] = "_control.top.level_txt",
			["home/bottom/main_float_content/main_float_11/icon"] = "_control.bottom.main_float_content.main_float_11.icon",
			["home/model_blur_layer/resource_mask_layer"] = "_control.model_blur_layer.resource_mask_layer",
			["home/bottom/main_float_content/main_float_1/num"] = "_control.bottom.main_float_content.main_float_1.num",
			["home/top/role_scale/slide/Handle Slide Area/Handle/click_area"] = "_control.top.role_scale.slide.Handle Slide Area.Handle.click_area",
			["home/action_layer/dock_finish"] = "_control.action_layer.dock_finish",
			["home/bottom/main_float_content/main_float_9/bg"] = "_control.bg",
			["home/top/role_scale/add_btn"] = "_control.top.role_scale.add_btn",
			["home/mp_activity_node/mask"] = "_control.mp_activity_node.mask",
			["home/bottom/main_float_content/main_float_7/icon"] = "_control.bottom.main_float_content.main_float_7.icon",
			["home/model_top_sprite"] = "_control.model_top_sprite",
			["home/bottom/main_float_content/main_float_1"] = "_control.bottom.main_float_content.main_float_1",
			["home/bottom/main_float_content/main_float_8/bg"] = "_control.bottom.main_float_content.main_float_8.bg",
			["home/top/exp_bar_bg"] = "_control.top.exp_bar_bg",
			["home/action_layer/dock_finish/main_event"] = "_control.action_layer.dock_finish.main_event",
			["home/blur_layer/resource_mask/layer_2"] = "_control.blur_layer.resource_mask.layer_2",
			["home/action_layer/explore_finish"] = "_control.action_layer.explore_finish",
			["home/top/ui_close"] = "_control.top.ui_close",
			["home/model_layer/talk/bg1/bg2"] = "_control.model_layer.talk.bg1.bg2",
			["home/action_layer/explore_finish/main_event"] = "_control.action_layer.explore_finish.main_event"
		},
		click = {
			["model_layer/model_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["model_layer/model_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/menu_btn_glow"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_1/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_2/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_3/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_4/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_5/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_6/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_7/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_8/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_9/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_10/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/main_float_content/main_float_11/click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/main_up_bar_cover"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/user_res_bar/right_upon/res_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/resource_click"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/ui_close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/ui_open"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/icon_click"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/role_scale/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/role_scale/reduce_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/back_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/main_save_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/main_reset_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_upon/on_button_support"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_upon/node/on_button_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_upon/node/on_item_button_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_upon/node/on_furniture_button_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_upon/node/on_combatshop_button_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_upon/node/on_combattactics_button_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_upon/tip_bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			blur_layer = {
				tp = "UnityEngine.UI.Button"
			},
			["bubble_layer/on_touch_bubble"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bubble_layer/bubble_btn_layer/main_bubble_develop"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bubble_layer/bubble_btn_layer/main_bubble_mail"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bubble_layer/bubble_btn_layer/main_bubble_build"] = {
				tp = "UnityEngine.UI.Button"
			},
			p_icon_touch_began = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bottom/menu_btn"] = {
				tp = "ScaleButton"
			},
			["bottom/menu_btn"] = {
				tp = "ScaleButton"
			},
			["bottom/menu_btn"] = {
				tp = "ScaleButton"
			},
			["bottom/btn_out"] = {
				tp = "ScaleButton"
			},
			["bottom/btn_ship"] = {
				tp = "ScaleButton"
			},
			["bottom/btn_task"] = {
				tp = "ScaleButton"
			},
			["top/user_res_bar/right_upon/buy_diamond"] = {
				tp = "ScaleButton"
			},
			["left_upon/on_button_living"] = {
				tp = "ScaleButton"
			}
		},
		long_click_drag_and_pointer_up = {
			["bottom/shortcut_btn"] = {
				tp = "LongClickDragAndPointerUpEvent"
			}
		},
		long_click_drag_and_pointer_up = {
			["first_in_tween/shortcut_long_btn"] = {
				tp = "HomeLongClickEvent"
			}
		},
		canvas_set = {
			talk = {
				component = "UnityEngine.Canvas",
				path = "model_layer/talk"
			}
		}
	}
}

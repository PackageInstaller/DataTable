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
			content = {
				path = "content",
				list = {
					bg_layer = {
						path = "content/bg_layer",
						list = {
							bg = {
								path = "content/bg_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mask = {
								path = "content/bg_layer/mask",
								list = {
									glow = {
										path = "content/bg_layer/mask/glow",
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
							cover = {
								path = "content/bg_layer/cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							coner = {
								path = "content/bg_layer/coner",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_bg = {
								path = "content/bg_layer/title_bg",
								list = {
									arrow = {
										path = "content/bg_layer/title_bg/arrow",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/bg_layer/title_bg/title",
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
							close_btn = {
								path = "content/bg_layer/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							line = {
								path = "content/bg_layer/line",
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
							"UnityEngine.CanvasRenderer"
						}
					},
					up_btns = {
						path = "content/up_btns",
						list = {
							log_fav_btn = {
								path = "content/up_btns/log_fav_btn",
								list = {
									title = {
										path = "content/up_btns/log_fav_btn/title",
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
							log_builder_btn = {
								path = "content/up_btns/log_builder_btn",
								list = {
									title = {
										path = "content/up_btns/log_builder_btn/title",
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
							log_cost_btn = {
								path = "content/up_btns/log_cost_btn",
								list = {
									title = {
										path = "content/up_btns/log_cost_btn/title",
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
							log_get_btn = {
								path = "content/up_btns/log_get_btn",
								list = {
									title = {
										path = "content/up_btns/log_get_btn/title",
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
					scroll = {
						path = "content/scroll",
						list = {
							Viewport = {
								path = "content/scroll/Viewport",
								list = {
									Content = {
										path = "content/scroll/Viewport/Content",
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
							["Scrollbar Vertical"] = {
								path = "content/scroll/Scrollbar Vertical",
								list = {
									["Sliding Area"] = {
										path = "content/scroll/Scrollbar Vertical/Sliding Area",
										list = {
											Handle = {
												path = "content/scroll/Scrollbar Vertical/Sliding Area/Handle",
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
					fav_tog = {
						path = "content/fav_tog",
						list = {
							Background = {
								path = "content/fav_tog/Background",
								list = {
									Checkmark = {
										path = "content/fav_tog/Background/Checkmark",
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
							title = {
								path = "content/fav_tog/title",
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
					toggle_group = {
						path = "content/toggle_group",
						list = {
							all_tog = {
								path = "content/toggle_group/all_tog",
								list = {
									Background = {
										path = "content/toggle_group/all_tog/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/all_tog/Background/Checkmark",
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
									title = {
										path = "content/toggle_group/all_tog/title",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tog_1 = {
								path = "content/toggle_group/tog_1",
								list = {
									Background = {
										path = "content/toggle_group/tog_1/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/tog_1/Background/Checkmark",
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
									title = {
										path = "content/toggle_group/tog_1/title",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tog_2 = {
								path = "content/toggle_group/tog_2",
								list = {
									Background = {
										path = "content/toggle_group/tog_2/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/tog_2/Background/Checkmark",
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
									title = {
										path = "content/toggle_group/tog_2/title",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tog_3 = {
								path = "content/toggle_group/tog_3",
								list = {
									Background = {
										path = "content/toggle_group/tog_3/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/tog_3/Background/Checkmark",
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
									title = {
										path = "content/toggle_group/tog_3/title",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tog_4 = {
								path = "content/toggle_group/tog_4",
								list = {
									Background = {
										path = "content/toggle_group/tog_4/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/tog_4/Background/Checkmark",
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
									title = {
										path = "content/toggle_group/tog_4/title",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["content/up_btns/log_fav_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/up_btns/log_builder_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/up_btns/log_cost_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/up_btns/log_get_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["content/bg_layer/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["content/fav_tog"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/toggle_group/all_tog"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/toggle_group/tog_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/toggle_group/tog_2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/toggle_group/tog_3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/toggle_group/tog_4"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

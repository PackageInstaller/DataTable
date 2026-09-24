return {
	_rule_ = {
		none = {
			research_bureau_bg = {
				path = "research_bureau_bg",
				list = {
					right = {
						path = "research_bureau_bg/right",
						list = {
							ship_research = {
								path = "research_bureau_bg/right/ship_research",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_layer = {
								path = "research_bureau_bg/right/ship_layer",
								list = {
									display_bg = {
										path = "research_bureau_bg/right/ship_layer/display_bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									intro_txt = {
										path = "research_bureau_bg/right/ship_layer/intro_txt",
										list = {
											ship_name_txt = {
												path = "research_bureau_bg/right/ship_layer/intro_txt/ship_name_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									intro_scrollview = {
										path = "research_bureau_bg/right/ship_layer/intro_scrollview",
										list = {
											intro_content = {
												path = "research_bureau_bg/right/ship_layer/intro_scrollview/intro_content",
												list = {
													intro_info_txt = {
														path = "research_bureau_bg/right/ship_layer/intro_scrollview/intro_content/intro_info_txt",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.ContentSizeFitter",
													"UnityEngine.UI.VerticalLayoutGroup"
												}
											}
										},
										component = {
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Mask"
										}
									},
									ship_name_txt = {
										path = "research_bureau_bg/right/ship_layer/ship_name_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									ship_name_image = {
										path = "research_bureau_bg/right/ship_layer/ship_name_image",
										list = {
											ship_type_txt = {
												path = "research_bureau_bg/right/ship_layer/ship_name_image/ship_type_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									ship_main_info = {
										path = "research_bureau_bg/right/ship_layer/ship_main_info",
										list = {
											detail_item_1 = {
												path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_1",
												list = {
													type_txt_1 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_1/type_txt_1",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													level_txt_1 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_1/level_txt_1",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {}
											},
											detail_item_2 = {
												path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_2",
												list = {
													type_txt_2 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_2/type_txt_2",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													level_txt_2 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_2/level_txt_2",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {}
											},
											detail_item_3 = {
												path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_3",
												list = {
													type_txt_3 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_3/type_txt_3",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													level_txt_3 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_3/level_txt_3",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {}
											},
											detail_item_4 = {
												path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_4",
												list = {
													type_txt_4 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_4/type_txt_4",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													level_txt_4 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_4/level_txt_4",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {}
											},
											detail_item_5 = {
												path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_5",
												list = {
													type_txt_5 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_5/type_txt_5",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													level_txt_5 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_5/level_txt_5",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {}
											},
											detail_item_6 = {
												path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_6",
												list = {
													type_txt_6 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_6/type_txt_6",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													level_txt_6 = {
														path = "research_bureau_bg/right/ship_layer/ship_main_info/detail_item_6/level_txt_6",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {}
											}
										},
										component = {}
									},
									progress_bg = {
										path = "research_bureau_bg/right/ship_layer/progress_bg",
										list = {
											finish_1 = {
												path = "research_bureau_bg/right/ship_layer/progress_bg/finish_1",
												list = {
													finish_1_1 = {
														path = "research_bureau_bg/right/ship_layer/progress_bg/finish_1/finish_1_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											finish_2 = {
												path = "research_bureau_bg/right/ship_layer/progress_bg/finish_2",
												list = {
													finish_2_2 = {
														path = "research_bureau_bg/right/ship_layer/progress_bg/finish_2/finish_2_2",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											finish_3 = {
												path = "research_bureau_bg/right/ship_layer/progress_bg/finish_3",
												list = {
													finish_3_3 = {
														path = "research_bureau_bg/right/ship_layer/progress_bg/finish_3/finish_3_3",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {}
							}
						},
						component = {}
					},
					left = {
						path = "research_bureau_bg/left",
						list = {
							up_image = {
								path = "research_bureau_bg/left/up_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							down_image = {
								path = "research_bureau_bg/left/down_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							left_scrollview = {
								path = "research_bureau_bg/left/left_scrollview",
								list = {
									viewport = {
										path = "research_bureau_bg/left/left_scrollview/viewport",
										list = {
											content = {
												path = "research_bureau_bg/left/left_scrollview/viewport/content",
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
										path = "research_bureau_bg/left/left_scrollview/scrollbarvertical",
										list = {
											slidingarea = {
												path = "research_bureau_bg/left/left_scrollview/scrollbarvertical/slidingarea",
												list = {
													handle = {
														path = "research_bureau_bg/left/left_scrollview/scrollbarvertical/slidingarea/handle",
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
						component = {}
					}
				},
				component = {}
			},
			top = {
				path = "research_bureau_bg/top",
				list = {
					title_txt = {
						path = "research_bureau_bg/top/title_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			return_btn = {
				path = "research_bureau_bg/top/return_btn",
				list = {},
				component = {
					"UnityEngine.UI.Image",
					"ScaleButton"
				}
			},
			down = {
				path = "research_bureau_bg/down",
				list = {},
				component = {}
			},
			start_btn = {
				path = "research_bureau_bg/down/start_btn",
				list = {
					start_btn_text = {
						path = "research_bureau_bg/down/start_btn/start_btn_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					start_btn_image = {
						path = "research_bureau_bg/down/start_btn/start_btn_image",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_4"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_4",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_name_image"] = "_control.research_bureau_bg.right.ship_layer.ship_name_image",
			["research_bureau/research_bureau_bg/top/title_txt"] = "_control.top.title_txt",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_3/level_txt_3"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_3.level_txt_3",
			["research_bureau/research_bureau_bg/left/left_scrollview/scrollbarvertical/slidingarea"] = "_control.research_bureau_bg.left.left_scrollview.scrollbarvertical.slidingarea",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_4/type_txt_4"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_4.type_txt_4",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_1"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_1",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_5/type_txt_5"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_5.type_txt_5",
			["research_bureau/research_bureau_bg"] = "_control.research_bureau_bg",
			["research_bureau/research_bureau_bg/right/ship_layer/intro_scrollview"] = "_control.research_bureau_bg.right.ship_layer.intro_scrollview",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_3"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_3",
			["research_bureau/research_bureau_bg/right/ship_layer/intro_scrollview/intro_content"] = "_control.research_bureau_bg.right.ship_layer.intro_scrollview.intro_content",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_2"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_2",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_name_image/ship_type_txt"] = "_control.research_bureau_bg.right.ship_layer.ship_name_image.ship_type_txt",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_5"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_5",
			["research_bureau/research_bureau_bg/right/ship_layer/intro_scrollview/intro_content/intro_info_txt"] = "_control.research_bureau_bg.right.ship_layer.intro_scrollview.intro_content.intro_info_txt",
			["research_bureau/research_bureau_bg/right/ship_layer/progress_bg"] = "_control.research_bureau_bg.right.ship_layer.progress_bg",
			["research_bureau/research_bureau_bg/right/ship_layer/progress_bg/finish_1/finish_1_1"] = "_control.research_bureau_bg.right.ship_layer.progress_bg.finish_1.finish_1_1",
			["research_bureau/research_bureau_bg/right/ship_layer/progress_bg/finish_3"] = "_control.research_bureau_bg.right.ship_layer.progress_bg.finish_3",
			["research_bureau/research_bureau_bg/right/ship_layer/progress_bg/finish_1"] = "_control.research_bureau_bg.right.ship_layer.progress_bg.finish_1",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_6"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_6",
			["research_bureau/research_bureau_bg/top"] = "_control.top",
			["research_bureau/research_bureau_bg/right/ship_layer/intro_txt/ship_name_txt"] = "_control.research_bureau_bg.right.ship_layer.intro_txt.ship_name_txt",
			["research_bureau/research_bureau_bg/right/ship_layer"] = "_control.research_bureau_bg.right.ship_layer",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_6/type_txt_6"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_6.type_txt_6",
			["research_bureau/research_bureau_bg/left"] = "_control.research_bureau_bg.left",
			["research_bureau/research_bureau_bg/left/down_image"] = "_control.research_bureau_bg.left.down_image",
			["research_bureau/research_bureau_bg/left/left_scrollview"] = "_control.research_bureau_bg.left.left_scrollview",
			["research_bureau/research_bureau_bg/top/return_btn"] = "_control.return_btn",
			["research_bureau/research_bureau_bg/right/ship_layer/progress_bg/finish_2/finish_2_2"] = "_control.research_bureau_bg.right.ship_layer.progress_bg.finish_2.finish_2_2",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_5/level_txt_5"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_5.level_txt_5",
			["research_bureau/research_bureau_bg/left/left_scrollview/viewport"] = "_control.research_bureau_bg.left.left_scrollview.viewport",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_2/type_txt_2"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_2.type_txt_2",
			["research_bureau/research_bureau_bg/left/up_image"] = "_control.research_bureau_bg.left.up_image",
			["research_bureau/research_bureau_bg/right/ship_layer/display_bg"] = "_control.research_bureau_bg.right.ship_layer.display_bg",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_4/level_txt_4"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_4.level_txt_4",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_6/level_txt_6"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_6.level_txt_6",
			["research_bureau/research_bureau_bg/left/left_scrollview/scrollbarvertical/slidingarea/handle"] = "_control.research_bureau_bg.left.left_scrollview.scrollbarvertical.slidingarea.handle",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_1/type_txt_1"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_1.type_txt_1",
			["research_bureau/research_bureau_bg/down"] = "_control.down",
			["research_bureau/research_bureau_bg/down/start_btn"] = "_control.start_btn",
			["research_bureau/research_bureau_bg/right"] = "_control.research_bureau_bg.right",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_name_txt"] = "_control.research_bureau_bg.right.ship_layer.ship_name_txt",
			["research_bureau/research_bureau_bg/down/start_btn/start_btn_text"] = "_control.start_btn.start_btn_text",
			["research_bureau/research_bureau_bg/down/start_btn/start_btn_image"] = "_control.start_btn.start_btn_image",
			["research_bureau/research_bureau_bg/left/left_scrollview/scrollbarvertical"] = "_control.research_bureau_bg.left.left_scrollview.scrollbarvertical",
			["research_bureau/research_bureau_bg/right/ship_layer/progress_bg/finish_3/finish_3_3"] = "_control.research_bureau_bg.right.ship_layer.progress_bg.finish_3.finish_3_3",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_3/type_txt_3"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_3.type_txt_3",
			["research_bureau/research_bureau_bg/right/ship_research"] = "_control.research_bureau_bg.right.ship_research",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_1/level_txt_1"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_1.level_txt_1",
			["research_bureau/research_bureau_bg/right/ship_layer/progress_bg/finish_2"] = "_control.research_bureau_bg.right.ship_layer.progress_bg.finish_2",
			["research_bureau/research_bureau_bg/right/ship_layer/ship_main_info/detail_item_2/level_txt_2"] = "_control.research_bureau_bg.right.ship_layer.ship_main_info.detail_item_2.level_txt_2",
			["research_bureau/research_bureau_bg/left/left_scrollview/viewport/content"] = "_control.research_bureau_bg.left.left_scrollview.viewport.content",
			["research_bureau/research_bureau_bg/right/ship_layer/intro_txt"] = "_control.research_bureau_bg.right.ship_layer.intro_txt"
		},
		click = {
			["research_bureau_bg/left/up_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["research_bureau_bg/left/down_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["research_bureau_bg/down/start_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["research_bureau_bg/top/return_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

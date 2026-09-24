return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					top = {
						path = "bg/top",
						list = {
							return_btn = {
								path = "bg/top/return_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							title_txt = {
								path = "bg/top/title_txt",
								list = {
									desc = {
										path = "bg/top/title_txt/desc",
										list = {
											desc_text = {
												path = "bg/top/title_txt/desc/desc_text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Text"
												}
											},
											mask = {
												path = "bg/top/title_txt/desc/mask",
												list = {
													desc = {
														path = "bg/top/title_txt/desc/mask/desc",
														list = {},
														component = {}
													},
													desc1 = {
														path = "bg/top/title_txt/desc/mask/desc1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Mask",
													"TextHorizonScroller"
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
									"UnityEngine.UI.Text"
								}
							},
							Image = {
								path = "bg/top/Image",
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
					rank_title = {
						path = "bg/rank_title",
						list = {
							rank_title_1 = {
								path = "bg/rank_title/rank_title_1",
								list = {
									btn_1 = {
										path = "bg/rank_title/rank_title_1/btn_1",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_1/btn_1/txt",
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
									btn_2 = {
										path = "bg/rank_title/rank_title_1/btn_2",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_1/btn_2/txt",
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
									btn_3 = {
										path = "bg/rank_title/rank_title_1/btn_3",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_1/btn_3/txt",
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
									btn_4 = {
										path = "bg/rank_title/rank_title_1/btn_4",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_1/btn_4/txt",
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
									btn_5 = {
										path = "bg/rank_title/rank_title_1/btn_5",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_1/btn_5/txt",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							rank_title_2 = {
								path = "bg/rank_title/rank_title_2",
								list = {
									btn_1 = {
										path = "bg/rank_title/rank_title_2/btn_1",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_2/btn_1/txt",
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
									btn_2 = {
										path = "bg/rank_title/rank_title_2/btn_2",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_2/btn_2/txt",
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
									btn_3 = {
										path = "bg/rank_title/rank_title_2/btn_3",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_2/btn_3/txt",
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
									btn_4 = {
										path = "bg/rank_title/rank_title_2/btn_4",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_2/btn_4/txt",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							rank_title_3 = {
								path = "bg/rank_title/rank_title_3",
								list = {
									btn_1 = {
										path = "bg/rank_title/rank_title_3/btn_1",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_3/btn_1/txt",
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
									btn_2 = {
										path = "bg/rank_title/rank_title_3/btn_2",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_3/btn_2/txt",
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
									btn_3 = {
										path = "bg/rank_title/rank_title_3/btn_3",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_3/btn_3/txt",
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
									btn_4 = {
										path = "bg/rank_title/rank_title_3/btn_4",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_3/btn_4/txt",
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
									btn_5 = {
										path = "bg/rank_title/rank_title_3/btn_5",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_3/btn_5/txt",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							rank_title_4 = {
								path = "bg/rank_title/rank_title_4",
								list = {
									btn_1 = {
										path = "bg/rank_title/rank_title_4/btn_1",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_4/btn_1/txt",
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
									btn_2 = {
										path = "bg/rank_title/rank_title_4/btn_2",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_4/btn_2/txt",
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
									btn_3 = {
										path = "bg/rank_title/rank_title_4/btn_3",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_4/btn_3/txt",
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
									btn_4 = {
										path = "bg/rank_title/rank_title_4/btn_4",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_4/btn_4/txt",
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
									btn_5 = {
										path = "bg/rank_title/rank_title_4/btn_5",
										list = {
											txt = {
												path = "bg/rank_title/rank_title_4/btn_5/txt",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					scrollview_1 = {
						path = "bg/scrollview_1",
						list = {
							["left_line_bg "] = {
								path = "bg/scrollview_1/left_line_bg ",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							viewport = {
								path = "bg/scrollview_1/viewport",
								list = {
									content = {
										path = "bg/scrollview_1/viewport/content",
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
								path = "bg/scrollview_1/scrollbarvertical",
								list = {
									slidingarea = {
										path = "bg/scrollview_1/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "bg/scrollview_1/scrollbarvertical/slidingarea/handle",
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
						path = "bg/scrollview_2",
						list = {
							["left_line_bg "] = {
								path = "bg/scrollview_2/left_line_bg ",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							viewport = {
								path = "bg/scrollview_2/viewport",
								list = {
									content = {
										path = "bg/scrollview_2/viewport/content",
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
								path = "bg/scrollview_2/scrollbarvertical",
								list = {
									slidingarea = {
										path = "bg/scrollview_2/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "bg/scrollview_2/scrollbarvertical/slidingarea/handle",
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
					scrollview_3 = {
						path = "bg/scrollview_3",
						list = {
							["left_line_bg "] = {
								path = "bg/scrollview_3/left_line_bg ",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							viewport = {
								path = "bg/scrollview_3/viewport",
								list = {
									content = {
										path = "bg/scrollview_3/viewport/content",
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
								path = "bg/scrollview_3/scrollbarvertical",
								list = {
									slidingarea = {
										path = "bg/scrollview_3/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "bg/scrollview_3/scrollbarvertical/slidingarea/handle",
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
					scrollview_4 = {
						path = "bg/scrollview_4",
						list = {
							["left_line_bg "] = {
								path = "bg/scrollview_4/left_line_bg ",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							viewport = {
								path = "bg/scrollview_4/viewport",
								list = {
									content = {
										path = "bg/scrollview_4/viewport/content",
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
								path = "bg/scrollview_4/scrollbarvertical",
								list = {
									slidingarea = {
										path = "bg/scrollview_4/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "bg/scrollview_4/scrollbarvertical/slidingarea/handle",
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
					bottom_line_bg = {
						path = "bg/bottom_line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bottom = {
						path = "bg/bottom",
						list = {
							info_1 = {
								path = "bg/bottom/info_1",
								list = {
									border_bg = {
										path = "bg/bottom/info_1/border_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									info_title = {
										path = "bg/bottom/info_1/info_title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									info_txt = {
										path = "bg/bottom/info_1/info_txt",
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
							info_2 = {
								path = "bg/bottom/info_2",
								list = {
									border_bg = {
										path = "bg/bottom/info_2/border_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									info_title = {
										path = "bg/bottom/info_2/info_title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									info_txt = {
										path = "bg/bottom/info_2/info_txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		call_node_list = {
			["ninth_honor_list/bg/scrollview_2"] = "_control.bg.scrollview_2",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_3"] = "_control.bg.rank_title.rank_title_1.btn_3",
			["ninth_honor_list/bg/scrollview_1/viewport/content"] = "_control.bg.scrollview_1.viewport.content",
			["ninth_honor_list/bg/scrollview_1/viewport"] = "_control.bg.scrollview_1.viewport",
			["ninth_honor_list/bg/scrollview_1/left_line_bg "] = "_control.bg.scrollview_1.left_line_bg ",
			["ninth_honor_list/bg/top/title_txt/desc/desc_text"] = "_control.bg.top.title_txt.desc.desc_text",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_5"] = "_control.bg.rank_title.rank_title_4.btn_5",
			["ninth_honor_list/bg/rank_title/rank_title_2"] = "_control.bg.rank_title.rank_title_2",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_5/txt"] = "_control.bg.rank_title.rank_title_4.btn_5.txt",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_4/txt"] = "_control.bg.rank_title.rank_title_4.btn_4.txt",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_4"] = "_control.bg.rank_title.rank_title_4.btn_4",
			["ninth_honor_list/bg/top/title_txt/desc/mask/desc"] = "_control.bg.top.title_txt.desc.mask.desc",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_3"] = "_control.bg.rank_title.rank_title_4.btn_3",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_2/txt"] = "_control.bg.rank_title.rank_title_4.btn_2.txt",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_1"] = "_control.bg.rank_title.rank_title_4.btn_1",
			["ninth_honor_list/bg/rank_title/rank_title_3"] = "_control.bg.rank_title.rank_title_3",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_1/txt"] = "_control.bg.rank_title.rank_title_4.btn_1.txt",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_4/txt"] = "_control.bg.rank_title.rank_title_2.btn_4.txt",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_5"] = "_control.bg.rank_title.rank_title_3.btn_5",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_4/txt"] = "_control.bg.rank_title.rank_title_3.btn_4.txt",
			["ninth_honor_list/bg/bottom_line_bg"] = "_control.bg.bottom_line_bg",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_3"] = "_control.bg.rank_title.rank_title_3.btn_3",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_2/txt"] = "_control.bg.rank_title.rank_title_3.btn_2.txt",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_2"] = "_control.bg.rank_title.rank_title_3.btn_2",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_1/txt"] = "_control.bg.rank_title.rank_title_3.btn_1.txt",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_1"] = "_control.bg.rank_title.rank_title_3.btn_1",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_1/txt"] = "_control.bg.rank_title.rank_title_1.btn_1.txt",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_1"] = "_control.bg.rank_title.rank_title_1.btn_1",
			["ninth_honor_list/bg/scrollview_1"] = "_control.bg.scrollview_1",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_2"] = "_control.bg.rank_title.rank_title_1.btn_2",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_2/txt"] = "_control.bg.rank_title.rank_title_1.btn_2.txt",
			["ninth_honor_list/bg/scrollview_1/scrollbarvertical"] = "_control.bg.scrollview_1.scrollbarvertical",
			["ninth_honor_list/bg/bottom/info_1/border_bg"] = "_control.bg.bottom.info_1.border_bg",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_1"] = "_control.bg.rank_title.rank_title_2.btn_1",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_4/txt"] = "_control.bg.rank_title.rank_title_1.btn_4.txt",
			["ninth_honor_list/bg/top/return_btn"] = "_control.bg.top.return_btn",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_2"] = "_control.bg.rank_title.rank_title_4.btn_2",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_4"] = "_control.bg.rank_title.rank_title_1.btn_4",
			["ninth_honor_list/bg/rank_title/rank_title_4/btn_3/txt"] = "_control.bg.rank_title.rank_title_4.btn_3.txt",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_3"] = "_control.bg.rank_title.rank_title_2.btn_3",
			["ninth_honor_list/bg/top/title_txt/desc/mask"] = "_control.bg.top.title_txt.desc.mask",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_5"] = "_control.bg.rank_title.rank_title_1.btn_5",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_4"] = "_control.bg.rank_title.rank_title_2.btn_4",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_5/txt"] = "_control.bg.rank_title.rank_title_1.btn_5.txt",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_1/txt"] = "_control.bg.rank_title.rank_title_2.btn_1.txt",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_2"] = "_control.bg.rank_title.rank_title_2.btn_2",
			["ninth_honor_list/bg/scrollview_2/viewport/content"] = "_control.bg.scrollview_2.viewport.content",
			["ninth_honor_list/bg/scrollview_4"] = "_control.bg.scrollview_4",
			["ninth_honor_list/bg/rank_title/rank_title_1"] = "_control.bg.rank_title.rank_title_1",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_3/txt"] = "_control.bg.rank_title.rank_title_2.btn_3.txt",
			["ninth_honor_list/bg/scrollview_2/scrollbarvertical"] = "_control.bg.scrollview_2.scrollbarvertical",
			["ninth_honor_list/bg/scrollview_2/scrollbarvertical/slidingarea"] = "_control.bg.scrollview_2.scrollbarvertical.slidingarea",
			["ninth_honor_list/bg/scrollview_2/scrollbarvertical/slidingarea/handle"] = "_control.bg.scrollview_2.scrollbarvertical.slidingarea.handle",
			["ninth_honor_list/bg/scrollview_3/left_line_bg "] = "_control.bg.scrollview_3.left_line_bg ",
			["ninth_honor_list/bg/scrollview_3/viewport"] = "_control.bg.scrollview_3.viewport",
			["ninth_honor_list/bg/bottom/info_2"] = "_control.bg.bottom.info_2",
			["ninth_honor_list/bg"] = "_control.bg",
			["ninth_honor_list/bg/scrollview_3/scrollbarvertical"] = "_control.bg.scrollview_3.scrollbarvertical",
			["ninth_honor_list/bg/scrollview_3/scrollbarvertical/slidingarea/handle"] = "_control.bg.scrollview_3.scrollbarvertical.slidingarea.handle",
			["ninth_honor_list/bg/top/Image"] = "_control.bg.top.Image",
			["ninth_honor_list/bg/rank_title/rank_title_2/btn_2/txt"] = "_control.bg.rank_title.rank_title_2.btn_2.txt",
			["ninth_honor_list/bg/scrollview_4/left_line_bg "] = "_control.bg.scrollview_4.left_line_bg ",
			["ninth_honor_list/bg/scrollview_4/viewport"] = "_control.bg.scrollview_4.viewport",
			["ninth_honor_list/bg/scrollview_4/viewport/content"] = "_control.bg.scrollview_4.viewport.content",
			["ninth_honor_list/bg/scrollview_4/scrollbarvertical"] = "_control.bg.scrollview_4.scrollbarvertical",
			["ninth_honor_list/bg/scrollview_4/scrollbarvertical/slidingarea/handle"] = "_control.bg.scrollview_4.scrollbarvertical.slidingarea.handle",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_3/txt"] = "_control.bg.rank_title.rank_title_3.btn_3.txt",
			["ninth_honor_list/bg/bottom/info_1"] = "_control.bg.bottom.info_1",
			["ninth_honor_list/bg/rank_title/rank_title_1/btn_3/txt"] = "_control.bg.rank_title.rank_title_1.btn_3.txt",
			["ninth_honor_list/bg/scrollview_1/scrollbarvertical/slidingarea"] = "_control.bg.scrollview_1.scrollbarvertical.slidingarea",
			["ninth_honor_list/bg/scrollview_3/viewport/content"] = "_control.bg.scrollview_3.viewport.content",
			["ninth_honor_list/bg/bottom/info_2/border_bg"] = "_control.bg.bottom.info_2.border_bg",
			["ninth_honor_list/bg/top/title_txt"] = "_control.bg.top.title_txt",
			["ninth_honor_list/bg/scrollview_1/scrollbarvertical/slidingarea/handle"] = "_control.bg.scrollview_1.scrollbarvertical.slidingarea.handle",
			["ninth_honor_list/bg/scrollview_2/viewport"] = "_control.bg.scrollview_2.viewport",
			["ninth_honor_list/bg/bottom/info_2/info_title"] = "_control.bg.bottom.info_2.info_title",
			["ninth_honor_list/bg/bottom/info_2/info_txt"] = "_control.bg.bottom.info_2.info_txt",
			["ninth_honor_list/bg/scrollview_2/left_line_bg "] = "_control.bg.scrollview_2.left_line_bg ",
			["ninth_honor_list/bg/bottom"] = "_control.bg.bottom",
			["ninth_honor_list/bg/scrollview_3"] = "_control.bg.scrollview_3",
			["ninth_honor_list/bg/scrollview_4/scrollbarvertical/slidingarea"] = "_control.bg.scrollview_4.scrollbarvertical.slidingarea",
			["ninth_honor_list/bg/scrollview_3/scrollbarvertical/slidingarea"] = "_control.bg.scrollview_3.scrollbarvertical.slidingarea",
			["ninth_honor_list/bg/rank_title/rank_title_4"] = "_control.bg.rank_title.rank_title_4",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_5/txt"] = "_control.bg.rank_title.rank_title_3.btn_5.txt",
			["ninth_honor_list/bg/top"] = "_control.bg.top",
			["ninth_honor_list/bg/rank_title/rank_title_3/btn_4"] = "_control.bg.rank_title.rank_title_3.btn_4",
			["ninth_honor_list/bg/top/title_txt/desc/mask/desc1"] = "_control.bg.top.title_txt.desc.mask.desc1",
			["ninth_honor_list/bg/top/title_txt/desc"] = "_control.bg.top.title_txt.desc",
			["ninth_honor_list/bg/bottom/info_1/info_title"] = "_control.bg.bottom.info_1.info_title",
			["ninth_honor_list/bg/rank_title"] = "_control.bg.rank_title",
			["ninth_honor_list/bg/bottom/info_1/info_txt"] = "_control.bg.bottom.info_1.info_txt"
		},
		click = {
			["bg/rank_title/rank_title_1/btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_1/btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_1/btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_1/btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_1/btn_5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_2/btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_2/btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_2/btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_2/btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_3/btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_3/btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_3/btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_3/btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_3/btn_5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_4/btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_4/btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_4/btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_4/btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/rank_title/rank_title_4/btn_5"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bg/top/return_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

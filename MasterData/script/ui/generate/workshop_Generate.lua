return {
	_rule_ = {
		none = {
			obj_pool_root = {
				path = "obj_pool_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
				}
			},
			background = {
				path = "background",
				list = {
					top_image = {
						path = "background/top_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					down_image = {
						path = "background/down_image",
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
			top_menu = {
				path = "top_menu",
				list = {
					return_btn = {
						path = "top_menu/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					line_left = {
						path = "top_menu/line_left",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_right = {
						path = "top_menu/line_right",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_1 = {
						path = "top_menu/line_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_2 = {
						path = "top_menu/line_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_3 = {
						path = "top_menu/line_3",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					tab_toggle = {
						path = "top_menu/tab_toggle",
						list = {
							tab_1 = {
								path = "top_menu/tab_toggle/tab_1",
								list = {
									bg = {
										path = "top_menu/tab_toggle/tab_1/bg",
										list = {
											checkmark = {
												path = "top_menu/tab_toggle/tab_1/bg/checkmark",
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
									sbt1 = {
										path = "top_menu/tab_toggle/tab_1/sbt1",
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
							tab_2 = {
								path = "top_menu/tab_toggle/tab_2",
								list = {
									bg = {
										path = "top_menu/tab_toggle/tab_2/bg",
										list = {
											checkmark = {
												path = "top_menu/tab_toggle/tab_2/bg/checkmark",
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
									sbt2 = {
										path = "top_menu/tab_toggle/tab_2/sbt2",
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
							tab_3 = {
								path = "top_menu/tab_toggle/tab_3",
								list = {
									bg = {
										path = "top_menu/tab_toggle/tab_3/bg",
										list = {
											checkmark = {
												path = "top_menu/tab_toggle/tab_3/bg/checkmark",
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
									sbt3 = {
										path = "top_menu/tab_toggle/tab_3/sbt3",
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
					top_menu_mask = {
						path = "top_menu/top_menu_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					money_bg = {
						path = "top_menu/money_bg",
						list = {
							icon = {
								path = "top_menu/money_bg/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "top_menu/money_bg/num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "top_menu/money_bg/line",
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
			},
			buttom_line = {
				path = "buttom_line",
				list = {
					buttom_corner_line = {
						path = "buttom_line/buttom_corner_line",
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
			chapter_scroll_view = {
				path = "chapter_scroll_view",
				list = {
					curve_scroll_rect = {
						path = "chapter_scroll_view/curve_scroll_rect",
						list = {
							viewport = {
								path = "chapter_scroll_view/curve_scroll_rect/viewport",
								list = {
									edge_mask = {
										path = "chapter_scroll_view/curve_scroll_rect/viewport/edge_mask",
										list = {
											content = {
												path = "chapter_scroll_view/curve_scroll_rect/viewport/edge_mask/content",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							select_bg_img = {
								path = "chapter_scroll_view/curve_scroll_rect/select_bg_img",
								list = {
									select_text = {
										path = "chapter_scroll_view/curve_scroll_rect/select_bg_img/select_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									select_icon = {
										path = "chapter_scroll_view/curve_scroll_rect/select_bg_img/select_icon",
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
							"UnityEngine.CanvasRenderer",
							"CurveScrollRect",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			ship_scroll_view = {
				path = "ship_scroll_view",
				list = {
					lattice_scroll_view = {
						path = "ship_scroll_view/lattice_scroll_view",
						list = {
							viewport = {
								path = "ship_scroll_view/lattice_scroll_view/viewport",
								list = {
									content = {
										path = "ship_scroll_view/lattice_scroll_view/viewport/content",
										list = {
											map_content = {
												path = "ship_scroll_view/lattice_scroll_view/viewport/content/map_content",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							next_page_btn = {
								path = "ship_scroll_view/lattice_scroll_view/next_page_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							last_page_btn = {
								path = "ship_scroll_view/lattice_scroll_view/last_page_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							ship_title = {
								path = "ship_scroll_view/lattice_scroll_view/ship_title",
								list = {
									icon = {
										path = "ship_scroll_view/lattice_scroll_view/ship_title/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_node = {
										path = "ship_scroll_view/lattice_scroll_view/ship_title/title_node",
										list = {
											title = {
												path = "ship_scroll_view/lattice_scroll_view/ship_title/title_node/title",
												list = {
													Image = {
														path = "ship_scroll_view/lattice_scroll_view/ship_title/title_node/title/Image",
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
									"UnityEngine.UI.Image"
								}
							},
							ship_info = {
								path = "ship_scroll_view/lattice_scroll_view/ship_info",
								list = {
									title = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									score = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/score",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									desc_bg = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/desc_bg",
										list = {
											title = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/desc_bg/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											scrollview = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/desc_bg/scrollview",
												list = {
													desc = {
														path = "ship_scroll_view/lattice_scroll_view/ship_info/desc_bg/scrollview/desc",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.ScrollRect",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Mask"
												}
											},
											desc = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/desc_bg/desc",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.ScrollRect",
													"UnityEngine.UI.Mask"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									condition_1 = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_1",
										list = {
											txt1 = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_1/txt1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											txt2 = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_1/txt2",
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
									condition_2 = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_2",
										list = {
											txt1 = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_2/txt1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											txt2 = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_2/txt2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											txt3 = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_2/txt3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											icon = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_2/icon",
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
									condition_3 = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_3",
										list = {
											txt1 = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_3/txt1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											txt2 = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/condition_3/txt2",
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
									cancel = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/cancel",
										list = {
											txt = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/cancel/txt",
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
									confirm = {
										path = "ship_scroll_view/lattice_scroll_view/ship_info/confirm",
										list = {
											txt = {
												path = "ship_scroll_view/lattice_scroll_view/ship_info/confirm/txt",
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
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.ScrollRect"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["top_menu/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_scroll_view/lattice_scroll_view/next_page_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_scroll_view/lattice_scroll_view/last_page_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_scroll_view/lattice_scroll_view/ship_info/confirm"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["top_menu/tab_toggle/tab_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_menu/tab_toggle/tab_2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_menu/tab_toggle/tab_3"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

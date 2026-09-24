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
					top_layer = {
						path = "content/top_layer",
						list = {
							top_line = {
								path = "content/top_layer/top_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							close_btn = {
								path = "content/top_layer/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							tip_title = {
								path = "content/top_layer/tip_title",
								list = {
									desc = {
										path = "content/top_layer/tip_title/desc",
										list = {
											dot_image = {
												path = "content/top_layer/tip_title/desc/dot_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											desc_text = {
												path = "content/top_layer/tip_title/desc/desc_text",
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
											"UnityEngine.RectTransform"
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
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					},
					user_res_1 = {
						path = "content/user_res_1",
						list = {
							bg = {
								path = "content/user_res_1/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							oil_image = {
								path = "content/user_res_1/oil_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bullet_image = {
								path = "content/user_res_1/bullet_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							iron_image = {
								path = "content/user_res_1/iron_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mineral_inmage = {
								path = "content/user_res_1/mineral_inmage",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							oil_num = {
								path = "content/user_res_1/oil_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							bullet_num = {
								path = "content/user_res_1/bullet_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							iron_num = {
								path = "content/user_res_1/iron_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							mineral_num = {
								path = "content/user_res_1/mineral_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					user_res_2 = {
						path = "content/user_res_2",
						list = {
							item_1 = {
								path = "content/user_res_2/item_1",
								list = {
									icon = {
										path = "content/user_res_2/item_1/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/user_res_2/item_1/num",
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
							item_2 = {
								path = "content/user_res_2/item_2",
								list = {
									icon = {
										path = "content/user_res_2/item_2/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/user_res_2/item_2/num",
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
							item_3 = {
								path = "content/user_res_2/item_3",
								list = {
									icon = {
										path = "content/user_res_2/item_3/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/user_res_2/item_3/num",
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
					build_panels = {
						path = "content/build_panels",
						list = {
							single_build_panel_1 = {
								path = "content/build_panels/single_build_panel_1",
								list = {
									bg = {
										path = "content/build_panels/single_build_panel_1/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									icon = {
										path = "content/build_panels/single_build_panel_1/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_1 = {
										path = "content/build_panels/single_build_panel_1/line_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/build_panels/single_build_panel_1/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									left = {
										path = "content/build_panels/single_build_panel_1/left",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									line_2 = {
										path = "content/build_panels/single_build_panel_1/line_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									scroll_root = {
										path = "content/build_panels/single_build_panel_1/scroll_root",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									up = {
										path = "content/build_panels/single_build_panel_1/up",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_3 = {
										path = "content/build_panels/single_build_panel_1/line_3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									right = {
										path = "content/build_panels/single_build_panel_1/right",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									down = {
										path = "content/build_panels/single_build_panel_1/down",
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
							single_build_panel_2 = {
								path = "content/build_panels/single_build_panel_2",
								list = {
									bg = {
										path = "content/build_panels/single_build_panel_2/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									icon = {
										path = "content/build_panels/single_build_panel_2/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_1 = {
										path = "content/build_panels/single_build_panel_2/line_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/build_panels/single_build_panel_2/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									scroll_root = {
										path = "content/build_panels/single_build_panel_2/scroll_root",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									up = {
										path = "content/build_panels/single_build_panel_2/up",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									down = {
										path = "content/build_panels/single_build_panel_2/down",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_2 = {
										path = "content/build_panels/single_build_panel_2/line_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_3 = {
										path = "content/build_panels/single_build_panel_2/line_3",
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
							single_build_panel_3 = {
								path = "content/build_panels/single_build_panel_3",
								list = {
									bg = {
										path = "content/build_panels/single_build_panel_3/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									icon = {
										path = "content/build_panels/single_build_panel_3/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_1 = {
										path = "content/build_panels/single_build_panel_3/line_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/build_panels/single_build_panel_3/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									scroll_root = {
										path = "content/build_panels/single_build_panel_3/scroll_root",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									up = {
										path = "content/build_panels/single_build_panel_3/up",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									down = {
										path = "content/build_panels/single_build_panel_3/down",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_2 = {
										path = "content/build_panels/single_build_panel_3/line_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_3 = {
										path = "content/build_panels/single_build_panel_3/line_3",
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
							single_build_panel_4 = {
								path = "content/build_panels/single_build_panel_4",
								list = {
									bg = {
										path = "content/build_panels/single_build_panel_4/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									icon = {
										path = "content/build_panels/single_build_panel_4/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_1 = {
										path = "content/build_panels/single_build_panel_4/line_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/build_panels/single_build_panel_4/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									left = {
										path = "content/build_panels/single_build_panel_4/left",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									mid = {
										path = "content/build_panels/single_build_panel_4/mid",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									scroll_root = {
										path = "content/build_panels/single_build_panel_4/scroll_root",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									right = {
										path = "content/build_panels/single_build_panel_4/right",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									down = {
										path = "content/build_panels/single_build_panel_4/down",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									up = {
										path = "content/build_panels/single_build_panel_4/up",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_2 = {
										path = "content/build_panels/single_build_panel_4/line_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_3 = {
										path = "content/build_panels/single_build_panel_4/line_3",
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
					},
					right_layer = {
						path = "content/right_layer",
						list = {
							dock_capacity = {
								path = "content/right_layer/dock_capacity",
								list = {
									bg = {
										path = "content/right_layer/dock_capacity/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/right_layer/dock_capacity/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "content/right_layer/dock_capacity/count",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "content/right_layer/dock_capacity/line",
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
							build_info_btn = {
								path = "content/right_layer/build_info_btn",
								list = {
									title = {
										path = "content/right_layer/build_info_btn/title",
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
							log_btn = {
								path = "content/right_layer/log_btn",
								list = {
									title = {
										path = "content/right_layer/log_btn/title",
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
							fast_btn = {
								path = "content/right_layer/fast_btn",
								list = {
									title = {
										path = "content/right_layer/fast_btn/title",
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
							build_btn = {
								path = "content/right_layer/build_btn",
								list = {
									title = {
										path = "content/right_layer/build_btn/title",
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
					source_layer = {
						path = "content/source_layer",
						list = {
							source_iten_1 = {
								path = "content/source_layer/source_iten_1",
								list = {
									icon = {
										path = "content/source_layer/source_iten_1/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/source_layer/source_iten_1/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "content/source_layer/source_iten_1/line",
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
							source_iten_2 = {
								path = "content/source_layer/source_iten_2",
								list = {
									icon = {
										path = "content/source_layer/source_iten_2/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/source_layer/source_iten_2/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "content/source_layer/source_iten_2/line",
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
							source_iten_3 = {
								path = "content/source_layer/source_iten_3",
								list = {
									icon = {
										path = "content/source_layer/source_iten_3/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/source_layer/source_iten_3/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "content/source_layer/source_iten_3/line",
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
							source_iten_4 = {
								path = "content/source_layer/source_iten_4",
								list = {
									icon = {
										path = "content/source_layer/source_iten_4/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/source_layer/source_iten_4/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "content/source_layer/source_iten_4/line",
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
							source_iten_5 = {
								path = "content/source_layer/source_iten_5",
								list = {
									icon = {
										path = "content/source_layer/source_iten_5/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/source_layer/source_iten_5/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "content/source_layer/source_iten_5/line",
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
							source_iten_6 = {
								path = "content/source_layer/source_iten_6",
								list = {
									icon = {
										path = "content/source_layer/source_iten_6/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "content/source_layer/source_iten_6/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "content/source_layer/source_iten_6/line",
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
							help_info = {
								path = "content/source_layer/help_info",
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
					"UnityEngine.RectTransform",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		call_node_list = {
			["dock_bet/content/user_res_1/bullet_num"] = "_control.content.user_res_1.bullet_num",
			["dock_bet/content/user_res_2"] = "_control.content.user_res_2",
			["dock_bet/content/build_panels/single_build_panel_1/title"] = "_control.content.build_panels.single_build_panel_1.title",
			["dock_bet/content/user_res_2/item_2"] = "_control.content.user_res_2.item_2",
			["dock_bet/content/build_panels/single_build_panel_3/down"] = "_control.content.build_panels.single_build_panel_3.down",
			["dock_bet/content/user_res_1/oil_image"] = "_control.content.user_res_1.oil_image",
			["dock_bet/content/build_panels/single_build_panel_2/line_2"] = "_control.content.build_panels.single_build_panel_2.line_2",
			["dock_bet/content/build_panels/single_build_panel_1/scroll_root"] = "_control.content.build_panels.single_build_panel_1.scroll_root",
			["dock_bet/content/right_layer/dock_capacity"] = "_control.content.right_layer.dock_capacity",
			["dock_bet/content/user_res_2/item_1/icon"] = "_control.content.user_res_2.item_1.icon",
			["dock_bet/content/build_panels/single_build_panel_2/scroll_root"] = "_control.content.build_panels.single_build_panel_2.scroll_root",
			["dock_bet/content/build_panels/single_build_panel_2/title"] = "_control.content.build_panels.single_build_panel_2.title",
			["dock_bet/content/build_panels/single_build_panel_1"] = "_control.content.build_panels.single_build_panel_1",
			["dock_bet/content/build_panels/single_build_panel_2/icon"] = "_control.content.build_panels.single_build_panel_2.icon",
			["dock_bet/content/build_panels/single_build_panel_2"] = "_control.content.build_panels.single_build_panel_2",
			["dock_bet/content/build_panels/single_build_panel_1/down"] = "_control.content.build_panels.single_build_panel_1.down",
			["dock_bet/content/user_res_2/item_2/num"] = "_control.content.user_res_2.item_2.num",
			["dock_bet/content/build_panels/single_build_panel_1/line_3"] = "_control.content.build_panels.single_build_panel_1.line_3",
			["dock_bet/content/right_layer/build_info_btn/title"] = "_control.content.right_layer.build_info_btn.title",
			["dock_bet/content/build_panels/single_build_panel_1/icon"] = "_control.content.build_panels.single_build_panel_1.icon",
			["dock_bet/content/top_layer"] = "_control.content.top_layer",
			["dock_bet/content/user_res_2/item_1/num"] = "_control.content.user_res_2.item_1.num",
			["dock_bet/content/top_layer/close_btn"] = "_control.content.top_layer.close_btn",
			["dock_bet/content/build_panels/single_build_panel_2/line_1"] = "_control.content.build_panels.single_build_panel_2.line_1",
			["dock_bet/content/user_res_1/iron_image"] = "_control.content.user_res_1.iron_image",
			["dock_bet/content/build_panels/single_build_panel_2/up"] = "_control.content.build_panels.single_build_panel_2.up",
			["dock_bet/content/build_panels/single_build_panel_2/line_3"] = "_control.content.build_panels.single_build_panel_2.line_3",
			["dock_bet/content/user_res_2/item_3/icon"] = "_control.content.user_res_2.item_3.icon",
			["dock_bet/content/top_layer/tip_title"] = "_control.content.top_layer.tip_title",
			["dock_bet/content/user_res_1/iron_num"] = "_control.content.user_res_1.iron_num",
			["dock_bet/content/build_panels/single_build_panel_3"] = "_control.content.build_panels.single_build_panel_3",
			["dock_bet/content/build_panels/single_build_panel_3/title"] = "_control.content.build_panels.single_build_panel_3.title",
			["dock_bet/content/user_res_2/item_2/icon"] = "_control.content.user_res_2.item_2.icon",
			["dock_bet/content/build_panels/single_build_panel_3/line_1"] = "_control.content.build_panels.single_build_panel_3.line_1",
			["dock_bet/content/build_panels/single_build_panel_3/line_2"] = "_control.content.build_panels.single_build_panel_3.line_2",
			["dock_bet/content/user_res_2/item_3/num"] = "_control.content.user_res_2.item_3.num",
			["dock_bet/content/build_panels/single_build_panel_4/icon"] = "_control.content.build_panels.single_build_panel_4.icon",
			["dock_bet/content/build_panels/single_build_panel_4/line_1"] = "_control.content.build_panels.single_build_panel_4.line_1",
			["dock_bet/bg"] = "_control.bg",
			["dock_bet/content/build_panels/single_build_panel_4/title"] = "_control.content.build_panels.single_build_panel_4.title",
			["dock_bet/content/build_panels/single_build_panel_4/left"] = "_control.content.build_panels.single_build_panel_4.left",
			["dock_bet/content/top_layer/top_line"] = "_control.content.top_layer.top_line",
			["dock_bet/content/right_layer/build_info_btn"] = "_control.content.right_layer.build_info_btn",
			["dock_bet/content/build_panels/single_build_panel_4/right"] = "_control.content.build_panels.single_build_panel_4.right",
			["dock_bet/content/build_panels/single_build_panel_4/down"] = "_control.content.build_panels.single_build_panel_4.down",
			["dock_bet/content/build_panels/single_build_panel_4/up"] = "_control.content.build_panels.single_build_panel_4.up",
			["dock_bet/content/build_panels/single_build_panel_4/line_2"] = "_control.content.build_panels.single_build_panel_4.line_2",
			["dock_bet/content/user_res_1/oil_num"] = "_control.content.user_res_1.oil_num",
			["dock_bet/content/build_panels/single_build_panel_1/left"] = "_control.content.build_panels.single_build_panel_1.left",
			["dock_bet/content/user_res_1/bg"] = "_control.content.user_res_1.bg",
			["dock_bet/content/build_panels/single_build_panel_4/line_3"] = "_control.content.build_panels.single_build_panel_4.line_3",
			["dock_bet/content/source_layer/help_info"] = "_control.content.source_layer.help_info",
			["dock_bet/content/build_panels/single_build_panel_2/down"] = "_control.content.build_panels.single_build_panel_2.down",
			["dock_bet/content/user_res_1/mineral_num"] = "_control.content.user_res_1.mineral_num",
			["dock_bet/content/right_layer/dock_capacity/title"] = "_control.content.right_layer.dock_capacity.title",
			["dock_bet/content/right_layer/dock_capacity/line"] = "_control.content.right_layer.dock_capacity.line",
			["dock_bet/content/right_layer/dock_capacity/count"] = "_control.content.right_layer.dock_capacity.count",
			["dock_bet/content/user_res_1/bullet_image"] = "_control.content.user_res_1.bullet_image",
			["dock_bet/content"] = "_control.content",
			["dock_bet/content/top_layer/tip_title/desc"] = "_control.content.top_layer.tip_title.desc",
			["dock_bet/content/right_layer/dock_capacity/bg"] = "_control.content.right_layer.dock_capacity.bg",
			["dock_bet/content/build_panels/single_build_panel_4/scroll_root"] = "_control.content.build_panels.single_build_panel_4.scroll_root",
			["dock_bet/content/source_layer"] = "_control.content.source_layer",
			["dock_bet/content/user_res_1"] = "_control.content.user_res_1",
			["dock_bet/content/build_panels/single_build_panel_3/line_3"] = "_control.content.build_panels.single_build_panel_3.line_3",
			["dock_bet/content/right_layer/log_btn"] = "_control.content.right_layer.log_btn",
			["dock_bet/content/right_layer/fast_btn/title"] = "_control.content.right_layer.fast_btn.title",
			["dock_bet/content/right_layer/build_btn"] = "_control.content.right_layer.build_btn",
			["dock_bet/content/build_panels/single_build_panel_1/line_2"] = "_control.content.build_panels.single_build_panel_1.line_2",
			["dock_bet/content/right_layer/log_btn/title"] = "_control.content.right_layer.log_btn.title",
			["dock_bet/content/source_layer/source_iten_1/icon"] = "_control.content.source_layer.source_iten_1.icon",
			["dock_bet/content/source_layer/source_iten_1/num"] = "_control.content.source_layer.source_iten_1.num",
			["dock_bet/content/source_layer/source_iten_1/line"] = "_control.content.source_layer.source_iten_1.line",
			["dock_bet/content/source_layer/source_iten_2/icon"] = "_control.content.source_layer.source_iten_2.icon",
			["dock_bet/content/source_layer/source_iten_2/num"] = "_control.content.source_layer.source_iten_2.num",
			["dock_bet/content/source_layer/source_iten_2/line"] = "_control.content.source_layer.source_iten_2.line",
			["dock_bet/content/build_panels/single_build_panel_4/bg"] = "_control.content.build_panels.single_build_panel_4.bg",
			["dock_bet/content/source_layer/source_iten_3/icon"] = "_control.content.source_layer.source_iten_3.icon",
			["dock_bet/content/build_panels/single_build_panel_1/right"] = "_control.content.build_panels.single_build_panel_1.right",
			["dock_bet/content/source_layer/source_iten_3/num"] = "_control.content.source_layer.source_iten_3.num",
			["dock_bet/content/source_layer/source_iten_3/line"] = "_control.content.source_layer.source_iten_3.line",
			["dock_bet/content/build_panels/single_build_panel_3/bg"] = "_control.content.build_panels.single_build_panel_3.bg",
			["dock_bet/content/source_layer/source_iten_4/icon"] = "_control.content.source_layer.source_iten_4.icon",
			["dock_bet/content/source_layer/source_iten_2"] = "_control.content.source_layer.source_iten_2",
			["dock_bet/content/right_layer/fast_btn"] = "_control.content.right_layer.fast_btn",
			["dock_bet/content/source_layer/source_iten_1"] = "_control.content.source_layer.source_iten_1",
			["dock_bet/content/build_panels/single_build_panel_3/up"] = "_control.content.build_panels.single_build_panel_3.up",
			["dock_bet/content/source_layer/source_iten_4/num"] = "_control.content.source_layer.source_iten_4.num",
			["dock_bet/content/build_panels/single_build_panel_3/icon"] = "_control.content.build_panels.single_build_panel_3.icon",
			["dock_bet/content/source_layer/source_iten_3"] = "_control.content.source_layer.source_iten_3",
			["dock_bet/content/source_layer/source_iten_4/line"] = "_control.content.source_layer.source_iten_4.line",
			["dock_bet/content/source_layer/source_iten_6"] = "_control.content.source_layer.source_iten_6",
			["dock_bet/content/source_layer/source_iten_5/num"] = "_control.content.source_layer.source_iten_5.num",
			["dock_bet/content/user_res_2/item_1"] = "_control.content.user_res_2.item_1",
			["dock_bet/content/source_layer/source_iten_5/line"] = "_control.content.source_layer.source_iten_5.line",
			["dock_bet/content/top_layer/tip_title/desc/desc_text"] = "_control.content.top_layer.tip_title.desc.desc_text",
			["dock_bet/content/source_layer/source_iten_5/icon"] = "_control.content.source_layer.source_iten_5.icon",
			["dock_bet/content/build_panels/single_build_panel_3/scroll_root"] = "_control.content.build_panels.single_build_panel_3.scroll_root",
			["dock_bet/content/source_layer/source_iten_6/icon"] = "_control.content.source_layer.source_iten_6.icon",
			["dock_bet/content/source_layer/source_iten_6/num"] = "_control.content.source_layer.source_iten_6.num",
			["dock_bet/content/source_layer/source_iten_6/line"] = "_control.content.source_layer.source_iten_6.line",
			["dock_bet/content/build_panels/single_build_panel_2/bg"] = "_control.content.build_panels.single_build_panel_2.bg",
			["dock_bet/content/top_layer/tip_title/desc/dot_image"] = "_control.content.top_layer.tip_title.desc.dot_image",
			["dock_bet/content/source_layer/source_iten_4"] = "_control.content.source_layer.source_iten_4",
			["dock_bet/content/right_layer"] = "_control.content.right_layer",
			["dock_bet/content/user_res_2/item_3"] = "_control.content.user_res_2.item_3",
			["dock_bet/content/build_panels"] = "_control.content.build_panels",
			["dock_bet/content/build_panels/single_build_panel_4/mid"] = "_control.content.build_panels.single_build_panel_4.mid",
			["dock_bet/content/build_panels/single_build_panel_4"] = "_control.content.build_panels.single_build_panel_4",
			["dock_bet/content/build_panels/single_build_panel_1/bg"] = "_control.content.build_panels.single_build_panel_1.bg",
			["dock_bet/content/user_res_1/mineral_inmage"] = "_control.content.user_res_1.mineral_inmage",
			["dock_bet/content/build_panels/single_build_panel_1/up"] = "_control.content.build_panels.single_build_panel_1.up",
			["dock_bet/content/build_panels/single_build_panel_1/line_1"] = "_control.content.build_panels.single_build_panel_1.line_1",
			["dock_bet/content/right_layer/build_btn/title"] = "_control.content.right_layer.build_btn.title",
			["dock_bet/content/source_layer/source_iten_5"] = "_control.content.source_layer.source_iten_5"
		},
		click = {
			["content/right_layer/build_info_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/right_layer/log_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/right_layer/fast_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/right_layer/build_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["content/top_layer/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

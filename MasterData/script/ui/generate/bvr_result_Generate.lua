return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			close_btn = {
				path = "close_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			top = {
				path = "top",
				list = {
					top_line = {
						path = "top/top_line",
						list = {},
						component = {
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title_txt = {
						path = "top/title_txt",
						list = {},
						component = {
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_head_image = {
						path = "top/name_head_image",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					player_name = {
						path = "top/player_name",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					player_level = {
						path = "top/player_level",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			right = {
				path = "right",
				list = {
					fleet_name = {
						path = "right/fleet_name",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					fleet_bg = {
						path = "right/fleet_bg",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					ship_list = {
						path = "right/ship_list",
						list = {
							fight_result_ship_1 = {
								path = "right/ship_list/fight_result_ship_1",
								list = {
									bg = {
										path = "right/ship_list/fight_result_ship_1/bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "right/ship_list/fight_result_ship_1/ship",
										list = {
											ship_bg = {
												path = "right/ship_list/fight_result_ship_1/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "right/ship_list/fight_result_ship_1/ship/ship_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									board = {
										path = "right/ship_list/fight_result_ship_1/board",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "right/ship_list/fight_result_ship_1/ship_level",
										list = {
											level_num = {
												path = "right/ship_list/fight_result_ship_1/ship_level/level_num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_type = {
										path = "right/ship_list/fight_result_ship_1/ship_type",
										list = {
											type_name = {
												path = "right/ship_list/fight_result_ship_1/ship_type/type_name",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_name = {
										path = "right/ship_list/fight_result_ship_1/ship_name",
										list = {
											ship_name_1 = {
												path = "right/ship_list/fight_result_ship_1/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "right/ship_list/fight_result_ship_1/ship_name/ship_name_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Mask",
											"TextHorizonScroller",
											"UnityEngine.UI.Image"
										}
									},
									sink = {
										path = "right/ship_list/fight_result_ship_1/sink",
										list = {
											bg = {
												path = "right/ship_list/fight_result_ship_1/sink/bg",
												list = {},
												component = {}
											},
											sink_word = {
												path = "right/ship_list/fight_result_ship_1/sink/sink_word",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									ship_flag = {
										path = "right/ship_list/fight_result_ship_1/ship_flag",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "right/ship_list/fight_result_ship_1/ship_hp",
										list = {
											bar_bg = {
												path = "right/ship_list/fight_result_ship_1/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "right/ship_list/fight_result_ship_1/ship_hp/hp_bar",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									smoke = {
										path = "right/ship_list/fight_result_ship_1/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							},
							fight_result_ship_2 = {
								path = "right/ship_list/fight_result_ship_2",
								list = {
									bg = {
										path = "right/ship_list/fight_result_ship_2/bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "right/ship_list/fight_result_ship_2/ship",
										list = {
											ship_bg = {
												path = "right/ship_list/fight_result_ship_2/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "right/ship_list/fight_result_ship_2/ship/ship_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									board = {
										path = "right/ship_list/fight_result_ship_2/board",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "right/ship_list/fight_result_ship_2/ship_level",
										list = {
											level_num = {
												path = "right/ship_list/fight_result_ship_2/ship_level/level_num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_type = {
										path = "right/ship_list/fight_result_ship_2/ship_type",
										list = {
											type_name = {
												path = "right/ship_list/fight_result_ship_2/ship_type/type_name",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_name = {
										path = "right/ship_list/fight_result_ship_2/ship_name",
										list = {
											ship_name_1 = {
												path = "right/ship_list/fight_result_ship_2/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "right/ship_list/fight_result_ship_2/ship_name/ship_name_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Mask",
											"TextHorizonScroller",
											"UnityEngine.UI.Image"
										}
									},
									sink = {
										path = "right/ship_list/fight_result_ship_2/sink",
										list = {
											bg = {
												path = "right/ship_list/fight_result_ship_2/sink/bg",
												list = {},
												component = {}
											},
											sink_word = {
												path = "right/ship_list/fight_result_ship_2/sink/sink_word",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									ship_flag = {
										path = "right/ship_list/fight_result_ship_2/ship_flag",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "right/ship_list/fight_result_ship_2/ship_hp",
										list = {
											bar_bg = {
												path = "right/ship_list/fight_result_ship_2/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "right/ship_list/fight_result_ship_2/ship_hp/hp_bar",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									smoke = {
										path = "right/ship_list/fight_result_ship_2/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							},
							fight_result_ship_3 = {
								path = "right/ship_list/fight_result_ship_3",
								list = {
									bg = {
										path = "right/ship_list/fight_result_ship_3/bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "right/ship_list/fight_result_ship_3/ship",
										list = {
											ship_bg = {
												path = "right/ship_list/fight_result_ship_3/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "right/ship_list/fight_result_ship_3/ship/ship_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									board = {
										path = "right/ship_list/fight_result_ship_3/board",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "right/ship_list/fight_result_ship_3/ship_level",
										list = {
											level_num = {
												path = "right/ship_list/fight_result_ship_3/ship_level/level_num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_type = {
										path = "right/ship_list/fight_result_ship_3/ship_type",
										list = {
											type_name = {
												path = "right/ship_list/fight_result_ship_3/ship_type/type_name",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_name = {
										path = "right/ship_list/fight_result_ship_3/ship_name",
										list = {
											ship_name_1 = {
												path = "right/ship_list/fight_result_ship_3/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "right/ship_list/fight_result_ship_3/ship_name/ship_name_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Mask",
											"TextHorizonScroller",
											"UnityEngine.UI.Image"
										}
									},
									sink = {
										path = "right/ship_list/fight_result_ship_3/sink",
										list = {
											bg = {
												path = "right/ship_list/fight_result_ship_3/sink/bg",
												list = {},
												component = {}
											},
											sink_word = {
												path = "right/ship_list/fight_result_ship_3/sink/sink_word",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									ship_flag = {
										path = "right/ship_list/fight_result_ship_3/ship_flag",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "right/ship_list/fight_result_ship_3/ship_hp",
										list = {
											bar_bg = {
												path = "right/ship_list/fight_result_ship_3/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "right/ship_list/fight_result_ship_3/ship_hp/hp_bar",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									smoke = {
										path = "right/ship_list/fight_result_ship_3/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							},
							fight_result_ship_4 = {
								path = "right/ship_list/fight_result_ship_4",
								list = {
									bg = {
										path = "right/ship_list/fight_result_ship_4/bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "right/ship_list/fight_result_ship_4/ship",
										list = {
											ship_bg = {
												path = "right/ship_list/fight_result_ship_4/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "right/ship_list/fight_result_ship_4/ship/ship_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									board = {
										path = "right/ship_list/fight_result_ship_4/board",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "right/ship_list/fight_result_ship_4/ship_level",
										list = {
											level_num = {
												path = "right/ship_list/fight_result_ship_4/ship_level/level_num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_type = {
										path = "right/ship_list/fight_result_ship_4/ship_type",
										list = {
											type_name = {
												path = "right/ship_list/fight_result_ship_4/ship_type/type_name",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_name = {
										path = "right/ship_list/fight_result_ship_4/ship_name",
										list = {
											ship_name_1 = {
												path = "right/ship_list/fight_result_ship_4/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "right/ship_list/fight_result_ship_4/ship_name/ship_name_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Mask",
											"TextHorizonScroller",
											"UnityEngine.UI.Image"
										}
									},
									sink = {
										path = "right/ship_list/fight_result_ship_4/sink",
										list = {
											bg = {
												path = "right/ship_list/fight_result_ship_4/sink/bg",
												list = {},
												component = {}
											},
											sink_word = {
												path = "right/ship_list/fight_result_ship_4/sink/sink_word",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									ship_flag = {
										path = "right/ship_list/fight_result_ship_4/ship_flag",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "right/ship_list/fight_result_ship_4/ship_hp",
										list = {
											bar_bg = {
												path = "right/ship_list/fight_result_ship_4/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "right/ship_list/fight_result_ship_4/ship_hp/hp_bar",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									smoke = {
										path = "right/ship_list/fight_result_ship_4/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							},
							fight_result_ship_5 = {
								path = "right/ship_list/fight_result_ship_5",
								list = {
									bg = {
										path = "right/ship_list/fight_result_ship_5/bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "right/ship_list/fight_result_ship_5/ship",
										list = {
											ship_bg = {
												path = "right/ship_list/fight_result_ship_5/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "right/ship_list/fight_result_ship_5/ship/ship_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									board = {
										path = "right/ship_list/fight_result_ship_5/board",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "right/ship_list/fight_result_ship_5/ship_level",
										list = {
											level_num = {
												path = "right/ship_list/fight_result_ship_5/ship_level/level_num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_type = {
										path = "right/ship_list/fight_result_ship_5/ship_type",
										list = {
											type_name = {
												path = "right/ship_list/fight_result_ship_5/ship_type/type_name",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_name = {
										path = "right/ship_list/fight_result_ship_5/ship_name",
										list = {
											ship_name_1 = {
												path = "right/ship_list/fight_result_ship_5/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "right/ship_list/fight_result_ship_5/ship_name/ship_name_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Mask",
											"TextHorizonScroller",
											"UnityEngine.UI.Image"
										}
									},
									sink = {
										path = "right/ship_list/fight_result_ship_5/sink",
										list = {
											bg = {
												path = "right/ship_list/fight_result_ship_5/sink/bg",
												list = {},
												component = {}
											},
											sink_word = {
												path = "right/ship_list/fight_result_ship_5/sink/sink_word",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									ship_flag = {
										path = "right/ship_list/fight_result_ship_5/ship_flag",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "right/ship_list/fight_result_ship_5/ship_hp",
										list = {
											bar_bg = {
												path = "right/ship_list/fight_result_ship_5/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "right/ship_list/fight_result_ship_5/ship_hp/hp_bar",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									smoke = {
										path = "right/ship_list/fight_result_ship_5/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							},
							fight_result_ship_6 = {
								path = "right/ship_list/fight_result_ship_6",
								list = {
									bg = {
										path = "right/ship_list/fight_result_ship_6/bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "right/ship_list/fight_result_ship_6/ship",
										list = {
											ship_bg = {
												path = "right/ship_list/fight_result_ship_6/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "right/ship_list/fight_result_ship_6/ship/ship_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									board = {
										path = "right/ship_list/fight_result_ship_6/board",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "right/ship_list/fight_result_ship_6/ship_level",
										list = {
											level_num = {
												path = "right/ship_list/fight_result_ship_6/ship_level/level_num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_type = {
										path = "right/ship_list/fight_result_ship_6/ship_type",
										list = {
											type_name = {
												path = "right/ship_list/fight_result_ship_6/ship_type/type_name",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_name = {
										path = "right/ship_list/fight_result_ship_6/ship_name",
										list = {
											ship_name_1 = {
												path = "right/ship_list/fight_result_ship_6/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "right/ship_list/fight_result_ship_6/ship_name/ship_name_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Mask",
											"TextHorizonScroller",
											"UnityEngine.UI.Image"
										}
									},
									sink = {
										path = "right/ship_list/fight_result_ship_6/sink",
										list = {
											bg = {
												path = "right/ship_list/fight_result_ship_6/sink/bg",
												list = {},
												component = {}
											},
											sink_word = {
												path = "right/ship_list/fight_result_ship_6/sink/sink_word",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									ship_flag = {
										path = "right/ship_list/fight_result_ship_6/ship_flag",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "right/ship_list/fight_result_ship_6/ship_hp",
										list = {
											bar_bg = {
												path = "right/ship_list/fight_result_ship_6/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "right/ship_list/fight_result_ship_6/ship_hp/hp_bar",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									smoke = {
										path = "right/ship_list/fight_result_ship_6/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.VerticalLayoutGroup",
							"UnityEngine.UI.ContentSizeFitter"
						}
					}
				},
				component = {
					"UIMoveTweener",
					"UIMoveTweener"
				}
			}
		},
		call_node_list = {
			["bvr_result/right/ship_list/fight_result_ship_6/ship_level"] = "_control.right.ship_list.fight_result_ship_6.ship_level",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_type/type_name"] = "_control.right.ship_list.fight_result_ship_3.ship_type.type_name",
			["bvr_result/right/ship_list/fight_result_ship_3/board"] = "_control.right.ship_list.fight_result_ship_3.board",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_name"] = "_control.right.ship_list.fight_result_ship_3.ship_name",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_hp"] = "_control.right.ship_list.fight_result_ship_5.ship_hp",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_type"] = "_control.right.ship_list.fight_result_ship_6.ship_type",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_name/ship_name_2"] = "_control.right.ship_list.fight_result_ship_5.ship_name.ship_name_2",
			["bvr_result/right/ship_list/fight_result_ship_3/ship/ship_bg"] = "_control.right.ship_list.fight_result_ship_3.ship.ship_bg",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_name"] = "_control.right.ship_list.fight_result_ship_5.ship_name",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_type/type_name"] = "_control.right.ship_list.fight_result_ship_5.ship_type.type_name",
			["bvr_result/right/ship_list/fight_result_ship_6/ship"] = "_control.right.ship_list.fight_result_ship_6.ship",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_type"] = "_control.right.ship_list.fight_result_ship_5.ship_type",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_hp/hp_bar"] = "_control.right.ship_list.fight_result_ship_2.ship_hp.hp_bar",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_level/level_num"] = "_control.right.ship_list.fight_result_ship_5.ship_level.level_num",
			["bvr_result/right/ship_list/fight_result_ship_5/sink/bg"] = "_control.right.ship_list.fight_result_ship_5.sink.bg",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_hp/bar_bg"] = "_control.right.ship_list.fight_result_ship_2.ship_hp.bar_bg",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_level"] = "_control.right.ship_list.fight_result_ship_5.ship_level",
			["bvr_result/right/ship_list/fight_result_ship_5/board"] = "_control.right.ship_list.fight_result_ship_5.board",
			["bvr_result/right/ship_list/fight_result_ship_5/ship/ship_icon"] = "_control.right.ship_list.fight_result_ship_5.ship.ship_icon",
			["bvr_result/right/ship_list/fight_result_ship_5/ship/ship_bg"] = "_control.right.ship_list.fight_result_ship_5.ship.ship_bg",
			["bvr_result/right/ship_list/fight_result_ship_5/ship"] = "_control.right.ship_list.fight_result_ship_5.ship",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_type"] = "_control.right.ship_list.fight_result_ship_4.ship_type",
			["bvr_result/right/ship_list/fight_result_ship_2/smoke"] = "_control.right.ship_list.fight_result_ship_2.smoke",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_level/level_num"] = "_control.right.ship_list.fight_result_ship_4.ship_level.level_num",
			["bvr_result/right/ship_list/fight_result_ship_4/smoke"] = "_control.right.ship_list.fight_result_ship_4.smoke",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_hp/hp_bar"] = "_control.right.ship_list.fight_result_ship_4.ship_hp.hp_bar",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_hp/bar_bg"] = "_control.right.ship_list.fight_result_ship_4.ship_hp.bar_bg",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_flag"] = "_control.right.ship_list.fight_result_ship_2.ship_flag",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_hp"] = "_control.right.ship_list.fight_result_ship_4.ship_hp",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_flag"] = "_control.right.ship_list.fight_result_ship_4.ship_flag",
			["bvr_result/right/ship_list/fight_result_ship_4/sink/sink_word"] = "_control.right.ship_list.fight_result_ship_4.sink.sink_word",
			["bvr_result/right/ship_list/fight_result_ship_4/sink/bg"] = "_control.right.ship_list.fight_result_ship_4.sink.bg",
			["bvr_result/right/ship_list/fight_result_ship_4/sink"] = "_control.right.ship_list.fight_result_ship_4.sink",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_name/ship_name_2"] = "_control.right.ship_list.fight_result_ship_4.ship_name.ship_name_2",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_name/ship_name_1"] = "_control.right.ship_list.fight_result_ship_4.ship_name.ship_name_1",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_name"] = "_control.right.ship_list.fight_result_ship_4.ship_name",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_type/type_name"] = "_control.right.ship_list.fight_result_ship_4.ship_type.type_name",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_level/level_num"] = "_control.right.ship_list.fight_result_ship_3.ship_level.level_num",
			["bvr_result/right/ship_list/fight_result_ship_4/ship_level"] = "_control.right.ship_list.fight_result_ship_4.ship_level",
			["bvr_result/right"] = "_control.right",
			["bvr_result/right/ship_list/fight_result_ship_4/ship/ship_icon"] = "_control.right.ship_list.fight_result_ship_4.ship.ship_icon",
			["bvr_result/right/ship_list/fight_result_ship_1/sink"] = "_control.right.ship_list.fight_result_ship_1.sink",
			["bvr_result/right/ship_list/fight_result_ship_4/ship/ship_bg"] = "_control.right.ship_list.fight_result_ship_4.ship.ship_bg",
			["bvr_result/right/ship_list/fight_result_ship_4"] = "_control.right.ship_list.fight_result_ship_4",
			["bvr_result/right/ship_list/fight_result_ship_3/sink"] = "_control.right.ship_list.fight_result_ship_3.sink",
			["bvr_result/right/ship_list/fight_result_ship_3/smoke"] = "_control.right.ship_list.fight_result_ship_3.smoke",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_hp/hp_bar"] = "_control.right.ship_list.fight_result_ship_3.ship_hp.hp_bar",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_hp/bar_bg"] = "_control.right.ship_list.fight_result_ship_3.ship_hp.bar_bg",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_hp"] = "_control.right.ship_list.fight_result_ship_3.ship_hp",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_flag"] = "_control.right.ship_list.fight_result_ship_3.ship_flag",
			["bvr_result/right/ship_list/fight_result_ship_3/sink/sink_word"] = "_control.right.ship_list.fight_result_ship_3.sink.sink_word",
			["bvr_result/right/ship_list/fight_result_ship_3/sink/bg"] = "_control.right.ship_list.fight_result_ship_3.sink.bg",
			["bvr_result/right/ship_list/fight_result_ship_1/sink/sink_word"] = "_control.right.ship_list.fight_result_ship_1.sink.sink_word",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_name/ship_name_2"] = "_control.right.ship_list.fight_result_ship_3.ship_name.ship_name_2",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_name/ship_name_1"] = "_control.right.ship_list.fight_result_ship_3.ship_name.ship_name_1",
			["bvr_result/right/ship_list/fight_result_ship_4/ship"] = "_control.right.ship_list.fight_result_ship_4.ship",
			["bvr_result/right/ship_list/fight_result_ship_6"] = "_control.right.ship_list.fight_result_ship_6",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_hp/bar_bg"] = "_control.right.ship_list.fight_result_ship_1.ship_hp.bar_bg",
			["bvr_result/right/ship_list/fight_result_ship_1/ship/ship_icon"] = "_control.right.ship_list.fight_result_ship_1.ship.ship_icon",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_name/ship_name_1"] = "_control.right.ship_list.fight_result_ship_1.ship_name.ship_name_1",
			["bvr_result/top"] = "_control.top",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_level/level_num"] = "_control.right.ship_list.fight_result_ship_1.ship_level.level_num",
			["bvr_result/right/ship_list/fight_result_ship_5/sink"] = "_control.right.ship_list.fight_result_ship_5.sink",
			["bvr_result/right/ship_list/fight_result_ship_1/ship/ship_bg"] = "_control.right.ship_list.fight_result_ship_1.ship.ship_bg",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_type"] = "_control.right.ship_list.fight_result_ship_1.ship_type",
			["bvr_result/right/ship_list/fight_result_ship_4/board"] = "_control.right.ship_list.fight_result_ship_4.board",
			["bvr_result/right/ship_list/fight_result_ship_5"] = "_control.right.ship_list.fight_result_ship_5",
			["bvr_result/right/ship_list/fight_result_ship_1/sink/bg"] = "_control.right.ship_list.fight_result_ship_1.sink.bg",
			["bvr_result/right/ship_list/fight_result_ship_5/bg"] = "_control.right.ship_list.fight_result_ship_5.bg",
			["bvr_result/right/ship_list/fight_result_ship_1/smoke"] = "_control.right.ship_list.fight_result_ship_1.smoke",
			["bvr_result/right/ship_list/fight_result_ship_1/ship"] = "_control.right.ship_list.fight_result_ship_1.ship",
			["bvr_result/right/ship_list/fight_result_ship_2/ship"] = "_control.right.ship_list.fight_result_ship_2.ship",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_name/ship_name_2"] = "_control.right.ship_list.fight_result_ship_1.ship_name.ship_name_2",
			["bvr_result/right/ship_list/fight_result_ship_2/ship/ship_bg"] = "_control.right.ship_list.fight_result_ship_2.ship.ship_bg",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_flag"] = "_control.right.ship_list.fight_result_ship_1.ship_flag",
			["bvr_result/right/ship_list/fight_result_ship_2/ship/ship_icon"] = "_control.right.ship_list.fight_result_ship_2.ship.ship_icon",
			["bvr_result/right/ship_list/fight_result_ship_2/board"] = "_control.right.ship_list.fight_result_ship_2.board",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_hp"] = "_control.right.ship_list.fight_result_ship_1.ship_hp",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_flag"] = "_control.right.ship_list.fight_result_ship_5.ship_flag",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_level"] = "_control.right.ship_list.fight_result_ship_2.ship_level",
			["bvr_result/right/ship_list/fight_result_ship_2"] = "_control.right.ship_list.fight_result_ship_2",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_hp"] = "_control.right.ship_list.fight_result_ship_2.ship_hp",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_level/level_num"] = "_control.right.ship_list.fight_result_ship_2.ship_level.level_num",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_type"] = "_control.right.ship_list.fight_result_ship_2.ship_type",
			["bvr_result/right/ship_list/fight_result_ship_5/smoke"] = "_control.right.ship_list.fight_result_ship_5.smoke",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_type/type_name"] = "_control.right.ship_list.fight_result_ship_2.ship_type.type_name",
			["bvr_result/right/ship_list/fight_result_ship_2/sink/bg"] = "_control.right.ship_list.fight_result_ship_2.sink.bg",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_name"] = "_control.right.ship_list.fight_result_ship_2.ship_name",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_name/ship_name_1"] = "_control.right.ship_list.fight_result_ship_2.ship_name.ship_name_1",
			["bvr_result/right/ship_list/fight_result_ship_3/ship"] = "_control.right.ship_list.fight_result_ship_3.ship",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_hp/hp_bar"] = "_control.right.ship_list.fight_result_ship_1.ship_hp.hp_bar",
			["bvr_result/right/ship_list/fight_result_ship_2/ship_name/ship_name_2"] = "_control.right.ship_list.fight_result_ship_2.ship_name.ship_name_2",
			["bvr_result/right/ship_list/fight_result_ship_2/sink"] = "_control.right.ship_list.fight_result_ship_2.sink",
			["bvr_result/right/ship_list/fight_result_ship_2/sink/sink_word"] = "_control.right.ship_list.fight_result_ship_2.sink.sink_word",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_type"] = "_control.right.ship_list.fight_result_ship_3.ship_type",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_hp/hp_bar"] = "_control.right.ship_list.fight_result_ship_5.ship_hp.hp_bar",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_name"] = "_control.right.ship_list.fight_result_ship_1.ship_name",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_type/type_name"] = "_control.right.ship_list.fight_result_ship_1.ship_type.type_name",
			["bvr_result/right/ship_list/fight_result_ship_1/board"] = "_control.right.ship_list.fight_result_ship_1.board",
			["bvr_result/right/ship_list/fight_result_ship_3/ship/ship_icon"] = "_control.right.ship_list.fight_result_ship_3.ship.ship_icon",
			["bvr_result/right/ship_list/fight_result_ship_6/ship/ship_bg"] = "_control.right.ship_list.fight_result_ship_6.ship.ship_bg",
			["bvr_result/right/ship_list/fight_result_ship_3/ship_level"] = "_control.right.ship_list.fight_result_ship_3.ship_level",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_name/ship_name_1"] = "_control.right.ship_list.fight_result_ship_6.ship_name.ship_name_1",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_name/ship_name_2"] = "_control.right.ship_list.fight_result_ship_6.ship_name.ship_name_2",
			["bvr_result/right/ship_list/fight_result_ship_6/sink"] = "_control.right.ship_list.fight_result_ship_6.sink",
			["bvr_result/right/ship_list/fight_result_ship_6/sink/bg"] = "_control.right.ship_list.fight_result_ship_6.sink.bg",
			["bvr_result/right/ship_list/fight_result_ship_6/sink/sink_word"] = "_control.right.ship_list.fight_result_ship_6.sink.sink_word",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_flag"] = "_control.right.ship_list.fight_result_ship_6.ship_flag",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_hp"] = "_control.right.ship_list.fight_result_ship_6.ship_hp",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_hp/bar_bg"] = "_control.right.ship_list.fight_result_ship_6.ship_hp.bar_bg",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_hp/hp_bar"] = "_control.right.ship_list.fight_result_ship_6.ship_hp.hp_bar",
			["bvr_result/right/ship_list/fight_result_ship_6/smoke"] = "_control.right.ship_list.fight_result_ship_6.smoke",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_type/type_name"] = "_control.right.ship_list.fight_result_ship_6.ship_type.type_name",
			["bvr_result/bg"] = "_control.bg",
			["bvr_result/right/ship_list/fight_result_ship_1/ship_level"] = "_control.right.ship_list.fight_result_ship_1.ship_level",
			["bvr_result/right/ship_list/fight_result_ship_6/ship/ship_icon"] = "_control.right.ship_list.fight_result_ship_6.ship.ship_icon",
			["bvr_result/right/fleet_name"] = "_control.right.fleet_name",
			["bvr_result/right/ship_list/fight_result_ship_1/bg"] = "_control.right.ship_list.fight_result_ship_1.bg",
			["bvr_result/right/ship_list/fight_result_ship_6/bg"] = "_control.right.ship_list.fight_result_ship_6.bg",
			["bvr_result/top/title_txt"] = "_control.top.title_txt",
			["bvr_result/close_btn"] = "_control.close_btn",
			["bvr_result/top/player_name"] = "_control.top.player_name",
			["bvr_result/top/top_line"] = "_control.top.top_line",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_name/ship_name_1"] = "_control.right.ship_list.fight_result_ship_5.ship_name.ship_name_1",
			["bvr_result/top/name_head_image"] = "_control.top.name_head_image",
			["bvr_result/right/ship_list/fight_result_ship_4/bg"] = "_control.right.ship_list.fight_result_ship_4.bg",
			["bvr_result/right/ship_list"] = "_control.right.ship_list",
			["bvr_result/right/ship_list/fight_result_ship_5/sink/sink_word"] = "_control.right.ship_list.fight_result_ship_5.sink.sink_word",
			["bvr_result/right/ship_list/fight_result_ship_2/bg"] = "_control.right.ship_list.fight_result_ship_2.bg",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_level/level_num"] = "_control.right.ship_list.fight_result_ship_6.ship_level.level_num",
			["bvr_result/right/fleet_bg"] = "_control.right.fleet_bg",
			["bvr_result/right/ship_list/fight_result_ship_1"] = "_control.right.ship_list.fight_result_ship_1",
			["bvr_result/right/ship_list/fight_result_ship_5/ship_hp/bar_bg"] = "_control.right.ship_list.fight_result_ship_5.ship_hp.bar_bg",
			["bvr_result/right/ship_list/fight_result_ship_6/ship_name"] = "_control.right.ship_list.fight_result_ship_6.ship_name",
			["bvr_result/right/ship_list/fight_result_ship_3"] = "_control.right.ship_list.fight_result_ship_3",
			["bvr_result/right/ship_list/fight_result_ship_3/bg"] = "_control.right.ship_list.fight_result_ship_3.bg",
			["bvr_result/right/ship_list/fight_result_ship_6/board"] = "_control.right.ship_list.fight_result_ship_6.board",
			["bvr_result/top/player_level"] = "_control.top.player_level"
		},
		click = {
			close_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

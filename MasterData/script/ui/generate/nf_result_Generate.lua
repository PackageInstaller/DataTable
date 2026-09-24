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
			close_btn = {
				path = "close_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
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
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title_txt = {
						path = "top/title_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_head_image = {
						path = "top/name_head_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					player_name = {
						path = "top/player_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					player_level = {
						path = "top/player_level",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			left = {
				path = "left",
				list = {
					fleet_name = {
						path = "left/fleet_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					fleet_bg = {
						path = "left/fleet_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					ship_list = {
						path = "left/ship_list",
						list = {
							fight_result_ship_1 = {
								path = "left/ship_list/fight_result_ship_1",
								list = {
									bg = {
										path = "left/ship_list/fight_result_ship_1/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "left/ship_list/fight_result_ship_1/ship",
										list = {
											ship_bg = {
												path = "left/ship_list/fight_result_ship_1/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "left/ship_list/fight_result_ship_1/ship/ship_icon",
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
									board = {
										path = "left/ship_list/fight_result_ship_1/board",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "left/ship_list/fight_result_ship_1/ship_level",
										list = {
											level_num = {
												path = "left/ship_list/fight_result_ship_1/ship_level/level_num",
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
									ship_type = {
										path = "left/ship_list/fight_result_ship_1/ship_type",
										list = {
											type_name = {
												path = "left/ship_list/fight_result_ship_1/ship_type/type_name",
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
									ship_name = {
										path = "left/ship_list/fight_result_ship_1/ship_name",
										list = {
											ship_name_1 = {
												path = "left/ship_list/fight_result_ship_1/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "left/ship_list/fight_result_ship_1/ship_name/ship_name_2",
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
									ship_flag = {
										path = "left/ship_list/fight_result_ship_1/ship_flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "left/ship_list/fight_result_ship_1/ship_hp",
										list = {
											bar_bg = {
												path = "left/ship_list/fight_result_ship_1/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "left/ship_list/fight_result_ship_1/ship_hp/hp_bar",
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
								component = {}
							},
							fight_result_ship_2 = {
								path = "left/ship_list/fight_result_ship_2",
								list = {
									bg = {
										path = "left/ship_list/fight_result_ship_2/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "left/ship_list/fight_result_ship_2/ship",
										list = {
											ship_bg = {
												path = "left/ship_list/fight_result_ship_2/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "left/ship_list/fight_result_ship_2/ship/ship_icon",
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
									board = {
										path = "left/ship_list/fight_result_ship_2/board",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "left/ship_list/fight_result_ship_2/ship_level",
										list = {
											level_num = {
												path = "left/ship_list/fight_result_ship_2/ship_level/level_num",
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
									ship_type = {
										path = "left/ship_list/fight_result_ship_2/ship_type",
										list = {
											type_name = {
												path = "left/ship_list/fight_result_ship_2/ship_type/type_name",
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
									ship_name = {
										path = "left/ship_list/fight_result_ship_2/ship_name",
										list = {
											ship_name_1 = {
												path = "left/ship_list/fight_result_ship_2/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "left/ship_list/fight_result_ship_2/ship_name/ship_name_2",
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
									ship_flag = {
										path = "left/ship_list/fight_result_ship_2/ship_flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "left/ship_list/fight_result_ship_2/ship_hp",
										list = {
											bar_bg = {
												path = "left/ship_list/fight_result_ship_2/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "left/ship_list/fight_result_ship_2/ship_hp/hp_bar",
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
								component = {}
							},
							fight_result_ship_3 = {
								path = "left/ship_list/fight_result_ship_3",
								list = {
									bg = {
										path = "left/ship_list/fight_result_ship_3/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "left/ship_list/fight_result_ship_3/ship",
										list = {
											ship_bg = {
												path = "left/ship_list/fight_result_ship_3/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "left/ship_list/fight_result_ship_3/ship/ship_icon",
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
									board = {
										path = "left/ship_list/fight_result_ship_3/board",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "left/ship_list/fight_result_ship_3/ship_level",
										list = {
											level_num = {
												path = "left/ship_list/fight_result_ship_3/ship_level/level_num",
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
									ship_type = {
										path = "left/ship_list/fight_result_ship_3/ship_type",
										list = {
											type_name = {
												path = "left/ship_list/fight_result_ship_3/ship_type/type_name",
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
									ship_name = {
										path = "left/ship_list/fight_result_ship_3/ship_name",
										list = {
											ship_name_1 = {
												path = "left/ship_list/fight_result_ship_3/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "left/ship_list/fight_result_ship_3/ship_name/ship_name_2",
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
									ship_flag = {
										path = "left/ship_list/fight_result_ship_3/ship_flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "left/ship_list/fight_result_ship_3/ship_hp",
										list = {
											bar_bg = {
												path = "left/ship_list/fight_result_ship_3/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "left/ship_list/fight_result_ship_3/ship_hp/hp_bar",
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
								component = {}
							},
							fight_result_ship_4 = {
								path = "left/ship_list/fight_result_ship_4",
								list = {
									bg = {
										path = "left/ship_list/fight_result_ship_4/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "left/ship_list/fight_result_ship_4/ship",
										list = {
											ship_bg = {
												path = "left/ship_list/fight_result_ship_4/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "left/ship_list/fight_result_ship_4/ship/ship_icon",
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
									board = {
										path = "left/ship_list/fight_result_ship_4/board",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "left/ship_list/fight_result_ship_4/ship_level",
										list = {
											level_num = {
												path = "left/ship_list/fight_result_ship_4/ship_level/level_num",
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
									ship_type = {
										path = "left/ship_list/fight_result_ship_4/ship_type",
										list = {
											type_name = {
												path = "left/ship_list/fight_result_ship_4/ship_type/type_name",
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
									ship_name = {
										path = "left/ship_list/fight_result_ship_4/ship_name",
										list = {
											ship_name_1 = {
												path = "left/ship_list/fight_result_ship_4/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "left/ship_list/fight_result_ship_4/ship_name/ship_name_2",
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
									ship_flag = {
										path = "left/ship_list/fight_result_ship_4/ship_flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "left/ship_list/fight_result_ship_4/ship_hp",
										list = {
											bar_bg = {
												path = "left/ship_list/fight_result_ship_4/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "left/ship_list/fight_result_ship_4/ship_hp/hp_bar",
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
								component = {}
							},
							fight_result_ship_5 = {
								path = "left/ship_list/fight_result_ship_5",
								list = {
									bg = {
										path = "left/ship_list/fight_result_ship_5/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "left/ship_list/fight_result_ship_5/ship",
										list = {
											ship_bg = {
												path = "left/ship_list/fight_result_ship_5/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "left/ship_list/fight_result_ship_5/ship/ship_icon",
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
									board = {
										path = "left/ship_list/fight_result_ship_5/board",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "left/ship_list/fight_result_ship_5/ship_level",
										list = {
											level_num = {
												path = "left/ship_list/fight_result_ship_5/ship_level/level_num",
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
									ship_type = {
										path = "left/ship_list/fight_result_ship_5/ship_type",
										list = {
											type_name = {
												path = "left/ship_list/fight_result_ship_5/ship_type/type_name",
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
									ship_name = {
										path = "left/ship_list/fight_result_ship_5/ship_name",
										list = {
											ship_name_1 = {
												path = "left/ship_list/fight_result_ship_5/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "left/ship_list/fight_result_ship_5/ship_name/ship_name_2",
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
									ship_flag = {
										path = "left/ship_list/fight_result_ship_5/ship_flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_hp = {
										path = "left/ship_list/fight_result_ship_5/ship_hp",
										list = {
											bar_bg = {
												path = "left/ship_list/fight_result_ship_5/ship_hp/bar_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_bar = {
												path = "left/ship_list/fight_result_ship_5/ship_hp/hp_bar",
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
								component = {}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.VerticalLayoutGroup",
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
			right = {
				path = "right",
				list = {
					rank = {
						path = "right/rank",
						list = {},
						component = {
							"Spine.Unity.SkeletonGraphic"
						}
					},
					continue_txt = {
						path = "right/continue_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					rank_word = {
						path = "right/rank_word",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			}
		},
		call_node_list = {
			["nf_result/left/ship_list/fight_result_ship_1/ship_hp/bar_bg"] = "_control.left.ship_list.fight_result_ship_1.ship_hp.bar_bg",
			["nf_result/left/ship_list/fight_result_ship_1/ship_hp"] = "_control.left.ship_list.fight_result_ship_1.ship_hp",
			["nf_result/right/rank"] = "_control.right.rank",
			["nf_result/left/ship_list/fight_result_ship_3"] = "_control.left.ship_list.fight_result_ship_3",
			["nf_result/right"] = "_control.right",
			["nf_result/left/ship_list/fight_result_ship_3/board"] = "_control.left.ship_list.fight_result_ship_3.board",
			["nf_result/left/ship_list/fight_result_ship_1/ship_name/ship_name_1"] = "_control.left.ship_list.fight_result_ship_1.ship_name.ship_name_1",
			["nf_result/left/ship_list/fight_result_ship_1/ship_type/type_name"] = "_control.left.ship_list.fight_result_ship_1.ship_type.type_name",
			["nf_result/left/ship_list/fight_result_ship_2/ship/ship_icon"] = "_control.left.ship_list.fight_result_ship_2.ship.ship_icon",
			["nf_result/left/ship_list/fight_result_ship_1/ship_flag"] = "_control.left.ship_list.fight_result_ship_1.ship_flag",
			["nf_result/left/ship_list/fight_result_ship_2"] = "_control.left.ship_list.fight_result_ship_2",
			["nf_result/left/ship_list/fight_result_ship_2/ship_hp/hp_bar"] = "_control.left.ship_list.fight_result_ship_2.ship_hp.hp_bar",
			["nf_result/left/ship_list/fight_result_ship_1/ship_level"] = "_control.left.ship_list.fight_result_ship_1.ship_level",
			["nf_result/left/ship_list/fight_result_ship_2/ship_hp/bar_bg"] = "_control.left.ship_list.fight_result_ship_2.ship_hp.bar_bg",
			["nf_result/left/ship_list/fight_result_ship_2/ship"] = "_control.left.ship_list.fight_result_ship_2.ship",
			["nf_result/left/ship_list/fight_result_ship_2/ship_hp"] = "_control.left.ship_list.fight_result_ship_2.ship_hp",
			["nf_result/left/ship_list/fight_result_ship_1/ship_type"] = "_control.left.ship_list.fight_result_ship_1.ship_type",
			["nf_result/left/ship_list/fight_result_ship_1/ship_name"] = "_control.left.ship_list.fight_result_ship_1.ship_name",
			["nf_result/left/ship_list/fight_result_ship_2/ship_flag"] = "_control.left.ship_list.fight_result_ship_2.ship_flag",
			["nf_result/left/ship_list/fight_result_ship_3/ship_level/level_num"] = "_control.left.ship_list.fight_result_ship_3.ship_level.level_num",
			["nf_result/left/ship_list/fight_result_ship_2/ship_name/ship_name_2"] = "_control.left.ship_list.fight_result_ship_2.ship_name.ship_name_2",
			["nf_result/left/ship_list/fight_result_ship_1/ship_level/level_num"] = "_control.left.ship_list.fight_result_ship_1.ship_level.level_num",
			["nf_result/left/ship_list/fight_result_ship_2/ship_name"] = "_control.left.ship_list.fight_result_ship_2.ship_name",
			["nf_result/left/ship_list/fight_result_ship_2/ship_type/type_name"] = "_control.left.ship_list.fight_result_ship_2.ship_type.type_name",
			["nf_result/left/ship_list/fight_result_ship_2/ship_type"] = "_control.left.ship_list.fight_result_ship_2.ship_type",
			["nf_result/left/ship_list/fight_result_ship_2/ship_level/level_num"] = "_control.left.ship_list.fight_result_ship_2.ship_level.level_num",
			["nf_result/left/ship_list"] = "_control.left.ship_list",
			["nf_result/left/ship_list/fight_result_ship_2/board"] = "_control.left.ship_list.fight_result_ship_2.board",
			["nf_result/left/ship_list/fight_result_ship_2/ship/ship_bg"] = "_control.left.ship_list.fight_result_ship_2.ship.ship_bg",
			["nf_result/top/player_name"] = "_control.top.player_name",
			["nf_result/left/ship_list/fight_result_ship_3/ship_flag"] = "_control.left.ship_list.fight_result_ship_3.ship_flag",
			["nf_result/left"] = "_control.left",
			["nf_result/top/top_line"] = "_control.top.top_line",
			["nf_result/left/ship_list/fight_result_ship_1/ship/ship_icon"] = "_control.left.ship_list.fight_result_ship_1.ship.ship_icon",
			["nf_result/left/ship_list/fight_result_ship_1/board"] = "_control.left.ship_list.fight_result_ship_1.board",
			["nf_result/left/ship_list/fight_result_ship_1/ship_name/ship_name_2"] = "_control.left.ship_list.fight_result_ship_1.ship_name.ship_name_2",
			["nf_result/left/ship_list/fight_result_ship_2/bg"] = "_control.left.ship_list.fight_result_ship_2.bg",
			["nf_result/left/ship_list/fight_result_ship_3/ship_type/type_name"] = "_control.left.ship_list.fight_result_ship_3.ship_type.type_name",
			["nf_result/left/ship_list/fight_result_ship_1/ship_hp/hp_bar"] = "_control.left.ship_list.fight_result_ship_1.ship_hp.hp_bar",
			["nf_result/left/ship_list/fight_result_ship_2/ship_level"] = "_control.left.ship_list.fight_result_ship_2.ship_level",
			["nf_result/left/ship_list/fight_result_ship_1/ship"] = "_control.left.ship_list.fight_result_ship_1.ship",
			["nf_result/left/ship_list/fight_result_ship_4/bg"] = "_control.left.ship_list.fight_result_ship_4.bg",
			["nf_result/left/ship_list/fight_result_ship_4/ship"] = "_control.left.ship_list.fight_result_ship_4.ship",
			["nf_result/top/name_head_image"] = "_control.top.name_head_image",
			["nf_result/right/rank_word"] = "_control.right.rank_word",
			["nf_result/left/ship_list/fight_result_ship_4/ship/ship_icon"] = "_control.left.ship_list.fight_result_ship_4.ship.ship_icon",
			["nf_result/left/ship_list/fight_result_ship_4/board"] = "_control.left.ship_list.fight_result_ship_4.board",
			["nf_result/left/ship_list/fight_result_ship_4/ship_level"] = "_control.left.ship_list.fight_result_ship_4.ship_level",
			["nf_result/left/ship_list/fight_result_ship_4/ship_level/level_num"] = "_control.left.ship_list.fight_result_ship_4.ship_level.level_num",
			["nf_result/left/ship_list/fight_result_ship_4/ship_type"] = "_control.left.ship_list.fight_result_ship_4.ship_type",
			["nf_result/left/ship_list/fight_result_ship_4/ship_type/type_name"] = "_control.left.ship_list.fight_result_ship_4.ship_type.type_name",
			["nf_result/bg"] = "_control.bg",
			["nf_result/left/ship_list/fight_result_ship_3/ship_hp"] = "_control.left.ship_list.fight_result_ship_3.ship_hp",
			["nf_result/left/ship_list/fight_result_ship_4/ship_name"] = "_control.left.ship_list.fight_result_ship_4.ship_name",
			["nf_result/left/ship_list/fight_result_ship_4/ship_name/ship_name_1"] = "_control.left.ship_list.fight_result_ship_4.ship_name.ship_name_1",
			["nf_result/left/ship_list/fight_result_ship_4/ship_name/ship_name_2"] = "_control.left.ship_list.fight_result_ship_4.ship_name.ship_name_2",
			["nf_result/left/ship_list/fight_result_ship_4/ship_flag"] = "_control.left.ship_list.fight_result_ship_4.ship_flag",
			["nf_result/left/ship_list/fight_result_ship_4/ship_hp"] = "_control.left.ship_list.fight_result_ship_4.ship_hp",
			["nf_result/left/ship_list/fight_result_ship_3/ship_hp/bar_bg"] = "_control.left.ship_list.fight_result_ship_3.ship_hp.bar_bg",
			["nf_result/left/ship_list/fight_result_ship_4/ship_hp/bar_bg"] = "_control.left.ship_list.fight_result_ship_4.ship_hp.bar_bg",
			["nf_result/left/ship_list/fight_result_ship_4/ship_hp/hp_bar"] = "_control.left.ship_list.fight_result_ship_4.ship_hp.hp_bar",
			["nf_result/left/ship_list/fight_result_ship_5/ship"] = "_control.left.ship_list.fight_result_ship_5.ship",
			["nf_result/left/ship_list/fight_result_ship_5/ship/ship_bg"] = "_control.left.ship_list.fight_result_ship_5.ship.ship_bg",
			["nf_result/right/continue_txt"] = "_control.right.continue_txt",
			["nf_result/left/ship_list/fight_result_ship_5/board"] = "_control.left.ship_list.fight_result_ship_5.board",
			["nf_result/left/ship_list/fight_result_ship_5/ship_level"] = "_control.left.ship_list.fight_result_ship_5.ship_level",
			["nf_result/left/ship_list/fight_result_ship_5"] = "_control.left.ship_list.fight_result_ship_5",
			["nf_result/left/ship_list/fight_result_ship_5/ship_level/level_num"] = "_control.left.ship_list.fight_result_ship_5.ship_level.level_num",
			["nf_result/left/ship_list/fight_result_ship_5/ship_type"] = "_control.left.ship_list.fight_result_ship_5.ship_type",
			["nf_result/left/fleet_name"] = "_control.left.fleet_name",
			["nf_result/left/ship_list/fight_result_ship_3/ship/ship_icon"] = "_control.left.ship_list.fight_result_ship_3.ship.ship_icon",
			["nf_result/left/ship_list/fight_result_ship_5/ship_type/type_name"] = "_control.left.ship_list.fight_result_ship_5.ship_type.type_name",
			["nf_result/top"] = "_control.top",
			["nf_result/left/ship_list/fight_result_ship_5/ship_name"] = "_control.left.ship_list.fight_result_ship_5.ship_name",
			["nf_result/left/ship_list/fight_result_ship_5/ship_name/ship_name_1"] = "_control.left.ship_list.fight_result_ship_5.ship_name.ship_name_1",
			["nf_result/left/fleet_bg"] = "_control.left.fleet_bg",
			["nf_result/left/ship_list/fight_result_ship_3/bg"] = "_control.left.ship_list.fight_result_ship_3.bg",
			["nf_result/left/ship_list/fight_result_ship_5/ship_name/ship_name_2"] = "_control.left.ship_list.fight_result_ship_5.ship_name.ship_name_2",
			["nf_result/left/ship_list/fight_result_ship_5/ship_flag"] = "_control.left.ship_list.fight_result_ship_5.ship_flag",
			["nf_result/left/ship_list/fight_result_ship_5/ship_hp"] = "_control.left.ship_list.fight_result_ship_5.ship_hp",
			["nf_result/left/ship_list/fight_result_ship_5/ship_hp/bar_bg"] = "_control.left.ship_list.fight_result_ship_5.ship_hp.bar_bg",
			["nf_result/left/ship_list/fight_result_ship_5/ship_hp/hp_bar"] = "_control.left.ship_list.fight_result_ship_5.ship_hp.hp_bar",
			["nf_result/left/ship_list/fight_result_ship_3/ship/ship_bg"] = "_control.left.ship_list.fight_result_ship_3.ship.ship_bg",
			["nf_result/left/ship_list/fight_result_ship_3/ship_name/ship_name_1"] = "_control.left.ship_list.fight_result_ship_3.ship_name.ship_name_1",
			["nf_result/left/ship_list/fight_result_ship_4"] = "_control.left.ship_list.fight_result_ship_4",
			["nf_result/left/ship_list/fight_result_ship_5/ship/ship_icon"] = "_control.left.ship_list.fight_result_ship_5.ship.ship_icon",
			["nf_result/left/ship_list/fight_result_ship_4/ship/ship_bg"] = "_control.left.ship_list.fight_result_ship_4.ship.ship_bg",
			["nf_result/left/ship_list/fight_result_ship_3/ship_name"] = "_control.left.ship_list.fight_result_ship_3.ship_name",
			["nf_result/left/ship_list/fight_result_ship_3/ship_type"] = "_control.left.ship_list.fight_result_ship_3.ship_type",
			["nf_result/left/ship_list/fight_result_ship_1"] = "_control.left.ship_list.fight_result_ship_1",
			["nf_result/left/ship_list/fight_result_ship_3/ship"] = "_control.left.ship_list.fight_result_ship_3.ship",
			["nf_result/left/ship_list/fight_result_ship_3/ship_level"] = "_control.left.ship_list.fight_result_ship_3.ship_level",
			["nf_result/left/ship_list/fight_result_ship_3/ship_hp/hp_bar"] = "_control.left.ship_list.fight_result_ship_3.ship_hp.hp_bar",
			["nf_result/left/ship_list/fight_result_ship_2/ship_name/ship_name_1"] = "_control.left.ship_list.fight_result_ship_2.ship_name.ship_name_1",
			["nf_result/left/ship_list/fight_result_ship_5/bg"] = "_control.left.ship_list.fight_result_ship_5.bg",
			["nf_result/top/title_txt"] = "_control.top.title_txt",
			["nf_result/left/ship_list/fight_result_ship_3/ship_name/ship_name_2"] = "_control.left.ship_list.fight_result_ship_3.ship_name.ship_name_2",
			["nf_result/top/player_level"] = "_control.top.player_level",
			["nf_result/left/ship_list/fight_result_ship_1/ship/ship_bg"] = "_control.left.ship_list.fight_result_ship_1.ship.ship_bg",
			["nf_result/left/ship_list/fight_result_ship_1/bg"] = "_control.left.ship_list.fight_result_ship_1.bg",
			["nf_result/close_btn"] = "_control.close_btn"
		},
		click = {
			close_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

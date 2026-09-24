return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					middle_menu = {
						path = "bg/middle_menu",
						list = {
							team_content_obj = {
								path = "bg/middle_menu/team_content_obj",
								list = {
									fade_content = {
										path = "bg/middle_menu/team_content_obj/fade_content",
										list = {
											team_content = {
												path = "bg/middle_menu/team_content_obj/fade_content/team_content",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"RankableLayoutGroup",
													"UnityEngine.CanvasGroup",
													"UITweenSequence"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UITweenSequence"
										}
									},
									left_btn = {
										path = "bg/middle_menu/team_content_obj/left_btn",
										list = {
											SkeletonGraphic = {
												path = "bg/middle_menu/team_content_obj/left_btn/SkeletonGraphic",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
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
									right_btn = {
										path = "bg/middle_menu/team_content_obj/right_btn",
										list = {
											SkeletonGraphic = {
												path = "bg/middle_menu/team_content_obj/right_btn/SkeletonGraphic",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
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
									"UIMoveTweener",
									"UIMoveTweener"
								}
							},
							team_content_all = {
								path = "bg/middle_menu/team_content_all",
								list = {
									Sp_supply = {
										path = "bg/middle_menu/team_content_all/Sp_supply",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"Spine.Unity.SkeletonGraphic",
											"UnityEngine.Canvas"
										}
									},
									Viewport = {
										path = "bg/middle_menu/team_content_all/Viewport",
										list = {
											Content = {
												path = "bg/middle_menu/team_content_all/Viewport/Content",
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
									Scrollbar = {
										path = "bg/middle_menu/team_content_all/Scrollbar",
										list = {
											["Sliding Area"] = {
												path = "bg/middle_menu/team_content_all/Scrollbar/Sliding Area",
												list = {
													Handle = {
														path = "bg/middle_menu/team_content_all/Scrollbar/Sliding Area/Handle",
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
									"UnityEngine.UI.Image",
									"UIMoveTweener",
									"UIMoveTweener",
									"UIMoveTweener"
								}
							},
							cancel_station = {
								path = "bg/middle_menu/cancel_station",
								list = {
									Text = {
										path = "bg/middle_menu/cancel_station/Text",
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
							"UITweenSequence"
						}
					},
					bot_menu = {
						path = "bg/bot_menu",
						list = {
							tips = {
								path = "bg/bot_menu/tips",
								list = {
									line = {
										path = "bg/bot_menu/tips/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ui_shiphint = {
										path = "bg/bot_menu/tips/ui_shiphint",
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
							supply = {
								path = "bg/bot_menu/supply",
								list = {
									supply_bg = {
										path = "bg/bot_menu/supply/supply_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil = {
										path = "bg/bot_menu/supply/oil",
										list = {
											image = {
												path = "bg/bot_menu/supply/oil/image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "bg/bot_menu/supply/oil/num",
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
									bullet = {
										path = "bg/bot_menu/supply/bullet",
										list = {
											image = {
												path = "bg/bot_menu/supply/bullet/image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "bg/bot_menu/supply/bullet/num",
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
									mineral = {
										path = "bg/bot_menu/supply/mineral",
										list = {
											image = {
												path = "bg/bot_menu/supply/mineral/image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "bg/bot_menu/supply/mineral/num",
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
									supply_btn = {
										path = "bg/bot_menu/supply/supply_btn",
										list = {
											pvesupplyall = {
												path = "bg/bot_menu/supply/supply_btn/pvesupplyall",
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
									pvesuplycost = {
										path = "bg/bot_menu/supply/pvesuplycost",
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
							filter = {
								path = "bg/bot_menu/filter",
								list = {
									sort_type_btn = {
										path = "bg/bot_menu/filter/sort_type_btn",
										list = {
											type = {
												path = "bg/bot_menu/filter/sort_type_btn/type",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											sort_txt = {
												path = "bg/bot_menu/filter/sort_type_btn/sort_txt",
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
									sort_order_btn = {
										path = "bg/bot_menu/filter/sort_order_btn",
										list = {
											sorttype = {
												path = "bg/bot_menu/filter/sort_order_btn/sorttype",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											sort_txt = {
												path = "bg/bot_menu/filter/sort_order_btn/sort_txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					},
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
							user_res = {
								path = "bg/top_menu/user_res",
								list = {
									bg = {
										path = "bg/top_menu/user_res/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_image = {
										path = "bg/top_menu/user_res/oil_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_image = {
										path = "bg/top_menu/user_res/bullet_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									iron_image = {
										path = "bg/top_menu/user_res/iron_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									mineral_inmage = {
										path = "bg/top_menu/user_res/mineral_inmage",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_num = {
										path = "bg/top_menu/user_res/oil_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline",
											"FontJump"
										}
									},
									bullet_num = {
										path = "bg/top_menu/user_res/bullet_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline",
											"FontJump"
										}
									},
									iron_num = {
										path = "bg/top_menu/user_res/iron_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline",
											"FontJump"
										}
									},
									mineral_num = {
										path = "bg/top_menu/user_res/mineral_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline",
											"FontJump"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							line_left = {
								path = "bg/top_menu/line_left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_right = {
								path = "bg/top_menu/line_right",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_1 = {
								path = "bg/top_menu/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_2 = {
								path = "bg/top_menu/line_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_3 = {
								path = "bg/top_menu/line_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tab_toggle = {
								path = "bg/top_menu/tab_toggle",
								list = {
									tab_1 = {
										path = "bg/top_menu/tab_toggle/tab_1",
										list = {
											bg = {
												path = "bg/top_menu/tab_toggle/tab_1/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/tab_toggle/tab_1/bg/checkmark",
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
												path = "bg/top_menu/tab_toggle/tab_1/sbt1",
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
										path = "bg/top_menu/tab_toggle/tab_3",
										list = {
											bg = {
												path = "bg/top_menu/tab_toggle/tab_3/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/tab_toggle/tab_3/bg/checkmark",
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
												path = "bg/top_menu/tab_toggle/tab_3/sbt3",
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
									tab_4 = {
										path = "bg/top_menu/tab_toggle/tab_4",
										list = {
											bg = {
												path = "bg/top_menu/tab_toggle/tab_4/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/tab_toggle/tab_4/bg/checkmark",
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
											sbt4 = {
												path = "bg/top_menu/tab_toggle/tab_4/sbt4",
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
							fleet_toggle = {
								path = "bg/top_menu/fleet_toggle",
								list = {
									fleetid1 = {
										path = "bg/top_menu/fleet_toggle/fleetid1",
										list = {
											bg = {
												path = "bg/top_menu/fleet_toggle/fleetid1/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/fleet_toggle/fleetid1/bg/checkmark",
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
											text = {
												path = "bg/top_menu/fleet_toggle/fleetid1/text",
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
									fleetid2 = {
										path = "bg/top_menu/fleet_toggle/fleetid2",
										list = {
											bg = {
												path = "bg/top_menu/fleet_toggle/fleetid2/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/fleet_toggle/fleetid2/bg/checkmark",
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
											text = {
												path = "bg/top_menu/fleet_toggle/fleetid2/text",
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
									fleetid3 = {
										path = "bg/top_menu/fleet_toggle/fleetid3",
										list = {
											bg = {
												path = "bg/top_menu/fleet_toggle/fleetid3/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/fleet_toggle/fleetid3/bg/checkmark",
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
											text = {
												path = "bg/top_menu/fleet_toggle/fleetid3/text",
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
									fleetid4 = {
										path = "bg/top_menu/fleet_toggle/fleetid4",
										list = {
											bg = {
												path = "bg/top_menu/fleet_toggle/fleetid4/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/fleet_toggle/fleetid4/bg/checkmark",
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
											text = {
												path = "bg/top_menu/fleet_toggle/fleetid4/text",
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
									fleet_name = {
										path = "bg/top_menu/fleet_toggle/fleet_name",
										list = {
											placeholder = {
												path = "bg/top_menu/fleet_toggle/fleet_name/placeholder",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											text = {
												path = "bg/top_menu/fleet_toggle/fleet_name/text",
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
											"UnityEngine.UI.InputField"
										}
									},
									fleetid5 = {
										path = "bg/top_menu/fleet_toggle/fleetid5",
										list = {
											bg = {
												path = "bg/top_menu/fleet_toggle/fleetid5/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/fleet_toggle/fleetid5/bg/checkmark",
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
											text = {
												path = "bg/top_menu/fleet_toggle/fleetid5/text",
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
									fleetid_pre_formation = {
										path = "bg/top_menu/fleet_toggle/fleetid_pre_formation",
										list = {
											bg = {
												path = "bg/top_menu/fleet_toggle/fleetid_pre_formation/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/fleet_toggle/fleetid_pre_formation/bg/checkmark",
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
											text = {
												path = "bg/top_menu/fleet_toggle/fleetid_pre_formation/text",
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
											"UnityEngine.UI.Button",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									equip_all_ship_info = {
										path = "bg/top_menu/fleet_toggle/equip_all_ship_info",
										list = {
											custom_ship_btn = {
												path = "bg/top_menu/fleet_toggle/equip_all_ship_info/custom_ship_btn",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											all_ship_btn_bg = {
												path = "bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_bg",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											all_ship_btn_txt = {
												path = "bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Button"
												}
											},
											custom_ship_2 = {
												path = "bg/top_menu/fleet_toggle/equip_all_ship_info/custom_ship_2",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup"
								}
							},
							repair_btn = {
								path = "bg/top_menu/repair_btn",
								list = {
									repairship = {
										path = "bg/top_menu/repair_btn/repairship",
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
							"UIMoveTweener",
							"UIMoveTweener"
						}
					},
					type_layer = {
						path = "bg/type_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					sort_layer = {
						path = "bg/sort_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					cover = {
						path = "bg/cover",
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
					"UITweenSequence"
				}
			},
			all_ship_2_btn = {
				path = "bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_txt/all_ship_2_btn",
				list = {},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["dock_team/bg/bot_menu/supply/bullet/image"] = "_control.bg.bot_menu.supply.bullet.image",
			["dock_team/bg/top_menu/user_res/iron_image"] = "_control.bg.top_menu.user_res.iron_image",
			["dock_team/bg/top_menu/return_btn"] = "_control.bg.top_menu.return_btn",
			["dock_team/bg/middle_menu/team_content_obj"] = "_control.bg.middle_menu.team_content_obj",
			["dock_team/bg"] = "_control.bg",
			["dock_team/bg/bot_menu/filter"] = "_control.bg.bot_menu.filter",
			["dock_team/bg/top_menu"] = "_control.bg.top_menu",
			["dock_team/bg/top_menu/tab_toggle/tab_1/sbt1"] = "_control.bg.top_menu.tab_toggle.tab_1.sbt1",
			["dock_team/bg/top_menu/fleet_toggle/fleetid1/bg"] = "_control.bg.top_menu.fleet_toggle.fleetid1.bg",
			["dock_team/bg/middle_menu/team_content_all/Scrollbar/Sliding Area/Handle"] = "_control.bg.middle_menu.team_content_all.Scrollbar.Sliding Area.Handle",
			["dock_team/bg/bot_menu/tips/line"] = "_control.bg.bot_menu.tips.line",
			["dock_team/bg/top_menu/line_right"] = "_control.bg.top_menu.line_right",
			["dock_team/bg/middle_menu/team_content_all/Scrollbar/Sliding Area"] = "_control.bg.middle_menu.team_content_all.Scrollbar.Sliding Area",
			["dock_team/bg/top_menu/user_res/bg"] = "_control.bg.top_menu.user_res.bg",
			["dock_team/bg/top_menu/tab_toggle/tab_1/bg"] = "_control.bg.top_menu.tab_toggle.tab_1.bg",
			["dock_team/bg/middle_menu/team_content_all"] = "_control.bg.middle_menu.team_content_all",
			["dock_team/bg/top_menu/user_res/oil_num"] = "_control.bg.top_menu.user_res.oil_num",
			["dock_team/bg/bot_menu/supply/supply_bg"] = "_control.bg.bot_menu.supply.supply_bg",
			["dock_team/bg/middle_menu/team_content_obj/right_btn"] = "_control.bg.middle_menu.team_content_obj.right_btn",
			["dock_team/bg/top_menu/fleet_toggle/fleetid3"] = "_control.bg.top_menu.fleet_toggle.fleetid3",
			["dock_team/bg/top_menu/user_res/bullet_num"] = "_control.bg.top_menu.user_res.bullet_num",
			["dock_team/bg/bot_menu"] = "_control.bg.bot_menu",
			["dock_team/bg/bot_menu/supply/oil/num"] = "_control.bg.bot_menu.supply.oil.num",
			["dock_team/bg/bot_menu/filter/sort_type_btn/sort_txt"] = "_control.bg.bot_menu.filter.sort_type_btn.sort_txt",
			["dock_team/bg/top_menu/tab_toggle/tab_1/bg/checkmark"] = "_control.bg.top_menu.tab_toggle.tab_1.bg.checkmark",
			["dock_team/bg/top_menu/fleet_toggle/fleetid2"] = "_control.bg.top_menu.fleet_toggle.fleetid2",
			["dock_team/bg/top_menu/user_res/oil_image"] = "_control.bg.top_menu.user_res.oil_image",
			["dock_team/bg/bot_menu/supply/bullet"] = "_control.bg.bot_menu.supply.bullet",
			["dock_team/bg/middle_menu/cancel_station/Text"] = "_control.bg.middle_menu.cancel_station.Text",
			["dock_team/bg/middle_menu/team_content_all/Viewport"] = "_control.bg.middle_menu.team_content_all.Viewport",
			["dock_team/bg/top_menu/user_res/mineral_inmage"] = "_control.bg.top_menu.user_res.mineral_inmage",
			["dock_team/bg/middle_menu/team_content_all/Viewport/Content"] = "_control.bg.middle_menu.team_content_all.Viewport.Content",
			["dock_team/bg/top_menu/user_res/iron_num"] = "_control.bg.top_menu.user_res.iron_num",
			["dock_team/bg/top_menu/tab_toggle/tab_3"] = "_control.bg.top_menu.tab_toggle.tab_3",
			["dock_team/bg/bot_menu/supply/oil"] = "_control.bg.bot_menu.supply.oil",
			["dock_team/bg/top_menu/tab_toggle/tab_3/bg"] = "_control.bg.top_menu.tab_toggle.tab_3.bg",
			["dock_team/bg/top_menu/line_1"] = "_control.bg.top_menu.line_1",
			["dock_team/bg/top_menu/tab_toggle/tab_4/sbt4"] = "_control.bg.top_menu.tab_toggle.tab_4.sbt4",
			["dock_team/bg/top_menu/tab_toggle/tab_4"] = "_control.bg.top_menu.tab_toggle.tab_4",
			["dock_team/bg/middle_menu/team_content_obj/fade_content"] = "_control.bg.middle_menu.team_content_obj.fade_content",
			["dock_team/bg/top_menu/tab_toggle/tab_4/bg/checkmark"] = "_control.bg.top_menu.tab_toggle.tab_4.bg.checkmark",
			["dock_team/bg/bot_menu/supply/mineral/num"] = "_control.bg.bot_menu.supply.mineral.num",
			["dock_team/bg/bot_menu/tips"] = "_control.bg.bot_menu.tips",
			["dock_team/bg/middle_menu/team_content_all/Scrollbar"] = "_control.bg.middle_menu.team_content_all.Scrollbar",
			["dock_team/bg/top_menu/user_res/mineral_num"] = "_control.bg.top_menu.user_res.mineral_num",
			["dock_team/bg/top_menu/tab_toggle/tab_3/bg/checkmark"] = "_control.bg.top_menu.tab_toggle.tab_3.bg.checkmark",
			["dock_team/bg/bot_menu/filter/sort_type_btn/type"] = "_control.bg.bot_menu.filter.sort_type_btn.type",
			["dock_team/bg/top_menu/line_left"] = "_control.bg.top_menu.line_left",
			["dock_team/bg/top_menu/fleet_toggle/fleetid_pre_formation/bg/checkmark"] = "_control.bg.top_menu.fleet_toggle.fleetid_pre_formation.bg.checkmark",
			["dock_team/bg/top_menu/fleet_toggle/fleetid1/text"] = "_control.bg.top_menu.fleet_toggle.fleetid1.text",
			["dock_team/bg/bot_menu/supply"] = "_control.bg.bot_menu.supply",
			["dock_team/bg/top_menu/fleet_toggle/fleetid2/bg/checkmark"] = "_control.bg.top_menu.fleet_toggle.fleetid2.bg.checkmark",
			["dock_team/bg/top_menu/fleet_toggle/fleetid2/text"] = "_control.bg.top_menu.fleet_toggle.fleetid2.text",
			["dock_team/bg/middle_menu/team_content_obj/right_btn/SkeletonGraphic"] = "_control.bg.middle_menu.team_content_obj.right_btn.SkeletonGraphic",
			["dock_team/bg/bot_menu/filter/sort_order_btn"] = "_control.bg.bot_menu.filter.sort_order_btn",
			["dock_team/bg/top_menu/fleet_toggle/fleetid3/bg/checkmark"] = "_control.bg.top_menu.fleet_toggle.fleetid3.bg.checkmark",
			["dock_team/bg/bot_menu/supply/mineral"] = "_control.bg.bot_menu.supply.mineral",
			["dock_team/bg/top_menu/fleet_toggle/fleetid5/bg"] = "_control.bg.top_menu.fleet_toggle.fleetid5.bg",
			["dock_team/bg/top_menu/fleet_toggle/fleetid4/bg/checkmark"] = "_control.bg.top_menu.fleet_toggle.fleetid4.bg.checkmark",
			["dock_team/bg/top_menu/fleet_toggle/fleetid4/text"] = "_control.bg.top_menu.fleet_toggle.fleetid4.text",
			["dock_team/bg/middle_menu/team_content_all/Sp_supply"] = "_control.bg.middle_menu.team_content_all.Sp_supply",
			["dock_team/bg/top_menu/fleet_toggle/equip_all_ship_info"] = "_control.bg.top_menu.fleet_toggle.equip_all_ship_info",
			["dock_team/bg/top_menu/fleet_toggle/fleet_name/text"] = "_control.bg.top_menu.fleet_toggle.fleet_name.text",
			["dock_team/bg/top_menu/fleet_toggle/fleetid5"] = "_control.bg.top_menu.fleet_toggle.fleetid5",
			["dock_team/bg/top_menu/tab_toggle"] = "_control.bg.top_menu.tab_toggle",
			["dock_team/bg/bot_menu/tips/ui_shiphint"] = "_control.bg.bot_menu.tips.ui_shiphint",
			["dock_team/bg/middle_menu/team_content_obj/fade_content/team_content"] = "_control.bg.middle_menu.team_content_obj.fade_content.team_content",
			["dock_team/bg/top_menu/fleet_toggle/fleetid3/text"] = "_control.bg.top_menu.fleet_toggle.fleetid3.text",
			["dock_team/bg/top_menu/fleet_toggle/fleetid_pre_formation/bg"] = "_control.bg.top_menu.fleet_toggle.fleetid_pre_formation.bg",
			["dock_team/bg/type_layer"] = "_control.bg.type_layer",
			["dock_team/bg/top_menu/fleet_toggle/fleetid_pre_formation"] = "_control.bg.top_menu.fleet_toggle.fleetid_pre_formation",
			["dock_team/bg/middle_menu"] = "_control.bg.middle_menu",
			["dock_team/bg/bot_menu/supply/bullet/num"] = "_control.bg.bot_menu.supply.bullet.num",
			["dock_team/bg/top_menu/line_2"] = "_control.bg.top_menu.line_2",
			["dock_team/bg/top_menu/fleet_toggle/fleetid5/bg/checkmark"] = "_control.bg.top_menu.fleet_toggle.fleetid5.bg.checkmark",
			["dock_team/bg/top_menu/tab_toggle/tab_3/sbt3"] = "_control.bg.top_menu.tab_toggle.tab_3.sbt3",
			["dock_team/bg/top_menu/fleet_toggle/fleetid1/bg/checkmark"] = "_control.bg.top_menu.fleet_toggle.fleetid1.bg.checkmark",
			["dock_team/bg/top_menu/fleet_toggle/fleet_name"] = "_control.bg.top_menu.fleet_toggle.fleet_name",
			["dock_team/bg/middle_menu/team_content_obj/left_btn"] = "_control.bg.middle_menu.team_content_obj.left_btn",
			["dock_team/bg/top_menu/fleet_toggle/equip_all_ship_info/custom_ship_btn"] = "_control.bg.top_menu.fleet_toggle.equip_all_ship_info.custom_ship_btn",
			["dock_team/bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_bg"] = "_control.bg.top_menu.fleet_toggle.equip_all_ship_info.all_ship_btn_bg",
			["dock_team/bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_txt"] = "_control.bg.top_menu.fleet_toggle.equip_all_ship_info.all_ship_btn_txt",
			["dock_team/bg/bot_menu/supply/supply_btn/pvesupplyall"] = "_control.bg.bot_menu.supply.supply_btn.pvesupplyall",
			["dock_team/bg/top_menu/line_3"] = "_control.bg.top_menu.line_3",
			["dock_team/bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_txt/all_ship_2_btn"] = "_control.all_ship_2_btn",
			["dock_team/bg/top_menu/fleet_toggle/fleetid4/bg"] = "_control.bg.top_menu.fleet_toggle.fleetid4.bg",
			["dock_team/bg/top_menu/fleet_toggle/fleetid1"] = "_control.bg.top_menu.fleet_toggle.fleetid1",
			["dock_team/bg/bot_menu/supply/supply_btn"] = "_control.bg.bot_menu.supply.supply_btn",
			["dock_team/bg/bot_menu/supply/oil/image"] = "_control.bg.bot_menu.supply.oil.image",
			["dock_team/bg/top_menu/fleet_toggle/fleet_name/placeholder"] = "_control.bg.top_menu.fleet_toggle.fleet_name.placeholder",
			["dock_team/bg/top_menu/fleet_toggle/equip_all_ship_info/custom_ship_2"] = "_control.bg.top_menu.fleet_toggle.equip_all_ship_info.custom_ship_2",
			["dock_team/bg/middle_menu/team_content_obj/left_btn/SkeletonGraphic"] = "_control.bg.middle_menu.team_content_obj.left_btn.SkeletonGraphic",
			["dock_team/bg/top_menu/repair_btn"] = "_control.bg.top_menu.repair_btn",
			["dock_team/bg/top_menu/tab_toggle/tab_1"] = "_control.bg.top_menu.tab_toggle.tab_1",
			["dock_team/bg/top_menu/repair_btn/repairship"] = "_control.bg.top_menu.repair_btn.repairship",
			["dock_team/bg/bot_menu/filter/sort_type_btn"] = "_control.bg.bot_menu.filter.sort_type_btn",
			["dock_team/bg/top_menu/user_res/bullet_image"] = "_control.bg.top_menu.user_res.bullet_image",
			["dock_team/bg/top_menu/fleet_toggle/fleetid5/text"] = "_control.bg.top_menu.fleet_toggle.fleetid5.text",
			["dock_team/bg/bot_menu/supply/pvesuplycost"] = "_control.bg.bot_menu.supply.pvesuplycost",
			["dock_team/bg/sort_layer"] = "_control.bg.sort_layer",
			["dock_team/bg/cover"] = "_control.bg.cover",
			["dock_team/bg/top_menu/fleet_toggle/fleetid4"] = "_control.bg.top_menu.fleet_toggle.fleetid4",
			["dock_team/bg/bot_menu/supply/mineral/image"] = "_control.bg.bot_menu.supply.mineral.image",
			["dock_team/bg/top_menu/fleet_toggle/fleetid2/bg"] = "_control.bg.top_menu.fleet_toggle.fleetid2.bg",
			["dock_team/bg/bot_menu/filter/sort_order_btn/sort_txt"] = "_control.bg.bot_menu.filter.sort_order_btn.sort_txt",
			["dock_team/bg/top_menu/fleet_toggle/fleetid3/bg"] = "_control.bg.top_menu.fleet_toggle.fleetid3.bg",
			["dock_team/bg/top_menu/fleet_toggle"] = "_control.bg.top_menu.fleet_toggle",
			["dock_team/bg/top_menu/fleet_toggle/fleetid_pre_formation/text"] = "_control.bg.top_menu.fleet_toggle.fleetid_pre_formation.text",
			["dock_team/bg/top_menu/tab_toggle/tab_4/bg"] = "_control.bg.top_menu.tab_toggle.tab_4.bg",
			["dock_team/bg/middle_menu/cancel_station"] = "_control.bg.middle_menu.cancel_station",
			["dock_team/bg/top_menu/user_res"] = "_control.bg.top_menu.user_res",
			["dock_team/bg/bot_menu/filter/sort_order_btn/sorttype"] = "_control.bg.bot_menu.filter.sort_order_btn.sorttype"
		},
		click = {
			["bg/middle_menu/team_content_obj/left_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/middle_menu/team_content_obj/right_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/middle_menu/cancel_station"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/bot_menu/supply/supply_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/bot_menu/filter/sort_type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/bot_menu/filter/sort_order_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/top_menu/fleet_toggle/fleetid_pre_formation"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/top_menu/fleet_toggle/equip_all_ship_info/custom_ship_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_txt"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/top_menu/fleet_toggle/equip_all_ship_info/all_ship_btn_txt/all_ship_2_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/top_menu/fleet_toggle/equip_all_ship_info/custom_ship_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/top_menu/repair_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bg/top_menu/return_btn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["bg/top_menu/tab_toggle/tab_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/tab_toggle/tab_3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/tab_toggle/tab_4"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/fleet_toggle/fleetid1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/fleet_toggle/fleetid2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/fleet_toggle/fleetid3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/fleet_toggle/fleetid4"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/fleet_toggle/fleetid5"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			Sp_supply = {
				component = "UnityEngine.Canvas",
				path = "bg/middle_menu/team_content_all/Sp_supply"
			}
		}
	}
}

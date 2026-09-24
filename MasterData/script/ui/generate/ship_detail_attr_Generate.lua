return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			ship_role = {
				path = "ship_role",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			left_field = {
				path = "left_field",
				list = {
					dress_btn = {
						path = "left_field/dress_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					achieve_btn = {
						path = "left_field/achieve_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					lock_toggle = {
						path = "left_field/lock_toggle",
						list = {
							Background = {
								path = "left_field/lock_toggle/Background",
								list = {
									Checkmark = {
										path = "left_field/lock_toggle/Background/Checkmark",
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
							"UnityEngine.UI.Toggle"
						}
					},
					leader_toggle = {
						path = "left_field/leader_toggle",
						list = {
							Background = {
								path = "left_field/leader_toggle/Background",
								list = {
									Checkmark = {
										path = "left_field/leader_toggle/Background/Checkmark",
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
							"UnityEngine.UI.Toggle"
						}
					},
					view_btn = {
						path = "left_field/view_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					return_btn = {
						path = "left_field/return_btn",
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
					"UnityEngine.RectTransform"
				}
			},
			ship_info = {
				path = "ship_info",
				list = {
					detail_info = {
						path = "ship_info/detail_info",
						list = {
							attr_info_bg = {
								path = "ship_info/detail_info/attr_info_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_icon = {
								path = "ship_info/detail_info/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_star = {
								path = "ship_info/detail_info/ship_star",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change_icon = {
								path = "ship_info/detail_info/change_icon",
								list = {
									ui_shi_change = {
										path = "ship_info/detail_info/change_icon/ui_shi_change",
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
							attr_hp = {
								path = "ship_info/detail_info/attr_hp",
								list = {
									hp = {
										path = "ship_info/detail_info/attr_hp/hp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_hp/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_hp/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_hp/tip_icon",
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
							attr_atk = {
								path = "ship_info/detail_info/attr_atk",
								list = {
									atk = {
										path = "ship_info/detail_info/attr_atk/atk",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_atk/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_atk/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_atk/tip_icon",
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
							attr_def = {
								path = "ship_info/detail_info/attr_def",
								list = {
									def = {
										path = "ship_info/detail_info/attr_def/def",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_def/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_def/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_def/tip_icon",
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
							attr_torpedo = {
								path = "ship_info/detail_info/attr_torpedo",
								list = {
									torpedo = {
										path = "ship_info/detail_info/attr_torpedo/torpedo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_torpedo/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_torpedo/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_torpedo/tip_icon",
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
							attr_miss = {
								path = "ship_info/detail_info/attr_miss",
								list = {
									miss = {
										path = "ship_info/detail_info/attr_miss/miss",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_miss/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_miss/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_miss/tip_icon",
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
							attr_airdef = {
								path = "ship_info/detail_info/attr_airdef",
								list = {
									airdef = {
										path = "ship_info/detail_info/attr_airdef/airdef",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_airdef/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_airdef/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_airdef/tip_icon",
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
							attr_capacity = {
								path = "ship_info/detail_info/attr_capacity",
								list = {
									capacity = {
										path = "ship_info/detail_info/attr_capacity/capacity",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_capacity/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_capacity/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_capacity/tip_icon",
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
							attr_antisub = {
								path = "ship_info/detail_info/attr_antisub",
								list = {
									antisub = {
										path = "ship_info/detail_info/attr_antisub/antisub",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_antisub/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_antisub/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_antisub/tip_icon",
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
							attr_speed = {
								path = "ship_info/detail_info/attr_speed",
								list = {
									speed = {
										path = "ship_info/detail_info/attr_speed/speed",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_speed/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_speed/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_speed/tip_icon",
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
							attr_radar = {
								path = "ship_info/detail_info/attr_radar",
								list = {
									radar = {
										path = "ship_info/detail_info/attr_radar/radar",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_radar/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_radar/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_radar/tip_icon",
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
							attr_range = {
								path = "ship_info/detail_info/attr_range",
								list = {
									range = {
										path = "ship_info/detail_info/attr_range/range",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_range/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_range/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_range/tip_icon",
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
							attr_luck = {
								path = "ship_info/detail_info/attr_luck",
								list = {
									luck = {
										path = "ship_info/detail_info/attr_luck/luck",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_bg = {
										path = "ship_info/detail_info/attr_luck/attr_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_num = {
										path = "ship_info/detail_info/attr_luck/attr_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tip_icon = {
										path = "ship_info/detail_info/attr_luck/tip_icon",
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
							ship_skill = {
								path = "ship_info/detail_info/ship_skill",
								list = {
									skill_name = {
										path = "ship_info/detail_info/ship_skill/skill_name",
										list = {
											text = {
												path = "ship_info/detail_info/ship_skill/skill_name/text",
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
									skill_level = {
										path = "ship_info/detail_info/ship_skill/skill_level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									skillstage = {
										path = "ship_info/detail_info/ship_skill/skillstage",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									skill_phase = {
										path = "ship_info/detail_info/ship_skill/skill_phase",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									skill_desc = {
										path = "ship_info/detail_info/ship_skill/skill_desc",
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
							right_arrow = {
								path = "ship_info/detail_info/right_arrow",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							left_arrow = {
								path = "ship_info/detail_info/left_arrow",
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
							"UnityEngine.RectTransform"
						}
					},
					ship_title = {
						path = "ship_info/ship_title",
						list = {
							title_bg = {
								path = "ship_info/ship_title/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							id_bg = {
								path = "ship_info/ship_title/id_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_id = {
								path = "ship_info/ship_title/ship_id",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_level = {
								path = "ship_info/ship_title/ship_level",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_name_move = {
								path = "ship_info/ship_title/ship_name_move",
								list = {
									ship_name = {
										path = "ship_info/ship_title/ship_name_move/ship_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									ship_name_move = {
										path = "ship_info/ship_title/ship_name_move/ship_name_move",
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
									"UnityEngine.UI.Mask",
									"TextHorizonScroller"
								}
							},
							ship_name = {
								path = "ship_info/ship_title/ship_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_exp = {
								path = "ship_info/ship_title/ship_exp",
								list = {
									exp_bg = {
										path = "ship_info/ship_title/ship_exp/exp_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_bar = {
										path = "ship_info/ship_title/ship_exp/exp_bar",
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
							exp_icon = {
								path = "ship_info/ship_title/exp_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							exp_num = {
								path = "ship_info/ship_title/exp_num",
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
					change_name_btn = {
						path = "ship_info/change_name_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					ship_equip = {
						path = "ship_info/ship_equip",
						list = {
							equip_bg = {
								path = "ship_info/ship_equip/equip_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_icon = {
								path = "ship_info/ship_equip/title_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							shipinfocurrentequips = {
								path = "ship_info/ship_equip/shipinfocurrentequips",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							equip_1 = {
								path = "ship_info/ship_equip/equip_1",
								list = {
									nil_bg = {
										path = "ship_info/ship_equip/equip_1/nil_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									add_equip = {
										path = "ship_info/ship_equip/equip_1/add_equip",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									equipment = {
										path = "ship_info/ship_equip/equip_1/equipment",
										list = {
											equip_rarity = {
												path = "ship_info/ship_equip/equip_1/equipment/equip_rarity",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_icon = {
												path = "ship_info/ship_equip/equip_1/equipment/equip_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name_bg = {
												path = "ship_info/ship_equip/equip_1/equipment/equip_name_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name = {
												path = "ship_info/ship_equip/equip_1/equipment/equip_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											change_btn = {
												path = "ship_info/ship_equip/equip_1/equipment/change_btn",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											off_btn = {
												path = "ship_info/ship_equip/equip_1/equipment/off_btn",
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
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							equip_2 = {
								path = "ship_info/ship_equip/equip_2",
								list = {
									nil_bg = {
										path = "ship_info/ship_equip/equip_2/nil_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									add_equip = {
										path = "ship_info/ship_equip/equip_2/add_equip",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									equipment = {
										path = "ship_info/ship_equip/equip_2/equipment",
										list = {
											equip_rarity = {
												path = "ship_info/ship_equip/equip_2/equipment/equip_rarity",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_icon = {
												path = "ship_info/ship_equip/equip_2/equipment/equip_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name_bg = {
												path = "ship_info/ship_equip/equip_2/equipment/equip_name_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name = {
												path = "ship_info/ship_equip/equip_2/equipment/equip_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											change_btn = {
												path = "ship_info/ship_equip/equip_2/equipment/change_btn",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											off_btn = {
												path = "ship_info/ship_equip/equip_2/equipment/off_btn",
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
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							equip_3 = {
								path = "ship_info/ship_equip/equip_3",
								list = {
									nil_bg = {
										path = "ship_info/ship_equip/equip_3/nil_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									add_equip = {
										path = "ship_info/ship_equip/equip_3/add_equip",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									equipment = {
										path = "ship_info/ship_equip/equip_3/equipment",
										list = {
											equip_rarity = {
												path = "ship_info/ship_equip/equip_3/equipment/equip_rarity",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_icon = {
												path = "ship_info/ship_equip/equip_3/equipment/equip_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name_bg = {
												path = "ship_info/ship_equip/equip_3/equipment/equip_name_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name = {
												path = "ship_info/ship_equip/equip_3/equipment/equip_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											change_btn = {
												path = "ship_info/ship_equip/equip_3/equipment/change_btn",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											off_btn = {
												path = "ship_info/ship_equip/equip_3/equipment/off_btn",
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
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							equip_4 = {
								path = "ship_info/ship_equip/equip_4",
								list = {
									nil_bg = {
										path = "ship_info/ship_equip/equip_4/nil_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									add_equip = {
										path = "ship_info/ship_equip/equip_4/add_equip",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									equipment = {
										path = "ship_info/ship_equip/equip_4/equipment",
										list = {
											equip_rarity = {
												path = "ship_info/ship_equip/equip_4/equipment/equip_rarity",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_icon = {
												path = "ship_info/ship_equip/equip_4/equipment/equip_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name_bg = {
												path = "ship_info/ship_equip/equip_4/equipment/equip_name_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_name = {
												path = "ship_info/ship_equip/equip_4/equipment/equip_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											change_btn = {
												path = "ship_info/ship_equip/equip_4/equipment/change_btn",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											off_btn = {
												path = "ship_info/ship_equip/equip_4/equipment/off_btn",
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
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			ship_love = {
				path = "ship_love",
				list = {
					love_bg = {
						path = "ship_love/love_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					heart_bg = {
						path = "ship_love/heart_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					heart_icon = {
						path = "ship_love/heart_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					love_num = {
						path = "ship_love/love_num",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					love_limit = {
						path = "ship_love/love_limit",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					dot_icon = {
						path = "ship_love/dot_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					national_text = {
						path = "ship_love/national_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					ship_type = {
						path = "ship_love/ship_type",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					love_btn = {
						path = "ship_love/love_btn",
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
					"UnityEngine.RectTransform"
				}
			},
			right_btn_group = {
				path = "right_btn_group",
				list = {
					change_btn = {
						path = "right_btn_group/change_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					view_btn = {
						path = "right_btn_group/view_btn",
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
					"UnityEngine.RectTransform"
				}
			},
			role_scale = {
				path = "role_scale",
				list = {
					slide = {
						path = "role_scale/slide",
						list = {
							Background = {
								path = "role_scale/slide/Background",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							["Fill Area"] = {
								path = "role_scale/slide/Fill Area",
								list = {
									Fill = {
										path = "role_scale/slide/Fill Area/Fill",
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
								path = "role_scale/slide/Handle Slide Area",
								list = {
									Handle = {
										path = "role_scale/slide/Handle Slide Area/Handle",
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
							"UnityEngine.UI.Slider"
						}
					},
					add_btn = {
						path = "role_scale/add_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					reduce_btn = {
						path = "role_scale/reduce_btn",
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
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["left_field/dress_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_field/achieve_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_field/view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_field/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/detail_info/right_arrow"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/detail_info/left_arrow"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/change_name_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_1/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_1/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_1/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_2/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_2/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_2/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_3/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_3/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_3/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_4/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_4/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_info/ship_equip/equip_4/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_love/love_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_btn_group/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_btn_group/view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["role_scale/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["role_scale/reduce_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["left_field/lock_toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_field/leader_toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

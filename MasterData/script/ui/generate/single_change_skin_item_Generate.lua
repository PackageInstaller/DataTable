return {
	_rule_ = {
		none = {
			BG = {
				path = "BG",
				list = {
					all_layer = {
						path = "BG/all_layer",
						list = {
							icon_layer = {
								path = "BG/all_layer/icon_layer",
								list = {
									icon = {
										path = "BG/all_layer/icon_layer/icon",
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
							love_layer = {
								path = "BG/all_layer/love_layer",
								list = {
									love = {
										path = "BG/all_layer/love_layer/love",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {}
							},
							mask_img = {
								path = "BG/all_layer/mask_img",
								list = {
									number_info = {
										path = "BG/all_layer/mask_img/number_info",
										list = {
											num = {
												path = "BG/all_layer/mask_img/number_info/num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									team_info = {
										path = "BG/all_layer/mask_img/team_info",
										list = {
											tip = {
												path = "BG/all_layer/mask_img/team_info/tip",
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
							formation_type_layer = {
								path = "BG/all_layer/formation_type_layer",
								list = {
									hp_layer = {
										path = "BG/all_layer/formation_type_layer/hp_layer",
										list = {
											full_img = {
												path = "BG/all_layer/formation_type_layer/hp_layer/full_img",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									},
									level_layer = {
										path = "BG/all_layer/formation_type_layer/level_layer",
										list = {
											type_txt = {
												path = "BG/all_layer/formation_type_layer/level_layer/type_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											level_txt = {
												path = "BG/all_layer/formation_type_layer/level_layer/level_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											country_txt = {
												path = "BG/all_layer/formation_type_layer/level_layer/country_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											lock_tag = {
												path = "BG/all_layer/formation_type_layer/level_layer/lock_tag",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											ship_remake = {
												path = "BG/all_layer/formation_type_layer/level_layer/ship_remake",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											star_layer = {
												path = "BG/all_layer/formation_type_layer/level_layer/star_layer",
												list = {
													star_1 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_1",
														list = {},
														component = {}
													},
													star_2 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_2",
														list = {},
														component = {}
													},
													star_3 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_3",
														list = {},
														component = {}
													},
													star_4 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_4",
														list = {},
														component = {}
													},
													star_5 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_5",
														list = {},
														component = {}
													},
													star_6 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_6",
														list = {},
														component = {}
													},
													star_7 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_7",
														list = {},
														component = {}
													}
												},
												component = {}
											}
										},
										component = {}
									},
									info_layer = {
										path = "BG/all_layer/formation_type_layer/info_layer",
										list = {
											name_level_1 = {
												path = "BG/all_layer/formation_type_layer/info_layer/name_level_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											["name_level _2"] = {
												path = "BG/all_layer/formation_type_layer/info_layer/name_level _2",
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
							}
						},
						component = {}
					}
				},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			team_id_info = {
				path = "team_id_info",
				list = {
					team_id = {
						path = "team_id_info/team_id",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			}
		},
		call_node_list = {
			["single_change_skin_item/BG/all_layer/mask_img"] = "_control.BG.all_layer.mask_img",
			["single_change_skin_item/BG/all_layer/formation_type_layer"] = "_control.BG.all_layer.formation_type_layer",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer/star_5"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_5",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer/star_6"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_6",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/level_txt"] = "_control.BG.all_layer.formation_type_layer.level_layer.level_txt",
			["single_change_skin_item/BG/all_layer/icon_layer"] = "_control.BG.all_layer.icon_layer",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer",
			["single_change_skin_item/BG/all_layer/formation_type_layer/info_layer"] = "_control.BG.all_layer.formation_type_layer.info_layer",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/country_txt"] = "_control.BG.all_layer.formation_type_layer.level_layer.country_txt",
			["single_change_skin_item/BG/all_layer/formation_type_layer/hp_layer"] = "_control.BG.all_layer.formation_type_layer.hp_layer",
			["single_change_skin_item/BG/all_layer/mask_img/team_info/tip"] = "_control.BG.all_layer.mask_img.team_info.tip",
			["single_change_skin_item/BG/all_layer/formation_type_layer/info_layer/name_level _2"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_level _2",
			["single_change_skin_item/BG/all_layer/love_layer"] = "_control.BG.all_layer.love_layer",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/ship_remake"] = "_control.BG.all_layer.formation_type_layer.level_layer.ship_remake",
			["single_change_skin_item/team_id_info/team_id"] = "_control.team_id_info.team_id",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/type_txt"] = "_control.BG.all_layer.formation_type_layer.level_layer.type_txt",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer/star_3"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_3",
			["single_change_skin_item/BG/all_layer/formation_type_layer/info_layer/name_level_1"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_level_1",
			["single_change_skin_item/BG/all_layer/formation_type_layer/hp_layer/full_img"] = "_control.BG.all_layer.formation_type_layer.hp_layer.full_img",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer/star_4"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_4",
			["single_change_skin_item/BG/all_layer"] = "_control.BG.all_layer",
			["single_change_skin_item/BG/all_layer/mask_img/team_info"] = "_control.BG.all_layer.mask_img.team_info",
			["single_change_skin_item/BG/all_layer/mask_img/number_info/num"] = "_control.BG.all_layer.mask_img.number_info.num",
			["single_change_skin_item/team_id_info"] = "_control.team_id_info",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer/star_7"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_7",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/lock_tag"] = "_control.BG.all_layer.formation_type_layer.level_layer.lock_tag",
			["single_change_skin_item/BG/all_layer/love_layer/love"] = "_control.BG.all_layer.love_layer.love",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer"] = "_control.BG.all_layer.formation_type_layer.level_layer",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer/star_1"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_1",
			["single_change_skin_item/BG/all_layer/icon_layer/icon"] = "_control.BG.all_layer.icon_layer.icon",
			["single_change_skin_item/BG/all_layer/formation_type_layer/level_layer/star_layer/star_2"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_2",
			["single_change_skin_item/BG/all_layer/mask_img/number_info"] = "_control.BG.all_layer.mask_img.number_info",
			["single_change_skin_item/BG"] = "_control.BG"
		},
		click = {
			["BG/all_layer"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			BG = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

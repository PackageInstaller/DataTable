return {
	_rule_ = {
		none = {
			empty = {
				path = "empty",
				list = {
					cover_sprite = {
						path = "empty/cover_sprite",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					flag_ship = {
						path = "empty/flag_ship",
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
					"UnityEngine.UI.Button",
					"UnityEngine.CanvasGroup",
					"UIFadeTweener"
				}
			},
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
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
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
							item_btn = {
								path = "BG/all_layer/item_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ClickAndLongClickEvent"
								}
							},
							drag_layer = {
								path = "BG/all_layer/drag_layer",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button",
									"RankableLayoutItem"
								}
							},
							love_layer = {
								path = "BG/all_layer/love_layer",
								list = {
									love = {
										path = "BG/all_layer/love_layer/love",
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
							level_layer = {
								path = "BG/all_layer/level_layer",
								list = {
									info_bg = {
										path = "BG/all_layer/level_layer/info_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									type_txt = {
										path = "BG/all_layer/level_layer/type_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "BG/all_layer/level_layer/level_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									country_txt = {
										path = "BG/all_layer/level_layer/country_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									lock_tag = {
										path = "BG/all_layer/level_layer/lock_tag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_remake = {
										path = "BG/all_layer/level_layer/ship_remake",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_custom = {
										path = "BG/all_layer/level_layer/ship_custom",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_layer = {
										path = "BG/all_layer/level_layer/star_layer",
										list = {
											star_1 = {
												path = "BG/all_layer/level_layer/star_layer/star_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_2 = {
												path = "BG/all_layer/level_layer/star_layer/star_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_3 = {
												path = "BG/all_layer/level_layer/star_layer/star_3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_4 = {
												path = "BG/all_layer/level_layer/star_layer/star_4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_5 = {
												path = "BG/all_layer/level_layer/star_layer/star_5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_6 = {
												path = "BG/all_layer/level_layer/star_layer/star_6",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_7 = {
												path = "BG/all_layer/level_layer/star_layer/star_7",
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
							repair_layer = {
								path = "BG/all_layer/repair_layer",
								list = {
									repair_bg = {
										path = "BG/all_layer/repair_layer/repair_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									repair_txt = {
										path = "BG/all_layer/repair_layer/repair_txt",
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
							stationed_layer = {
								path = "BG/all_layer/stationed_layer",
								list = {
									stationed_bg = {
										path = "BG/all_layer/stationed_layer/stationed_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									stationed_txt = {
										path = "BG/all_layer/stationed_layer/stationed_txt",
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
							hp_layer = {
								path = "BG/all_layer/hp_layer",
								list = {
									full_img = {
										path = "BG/all_layer/hp_layer/full_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp_num = {
										path = "BG/all_layer/hp_layer/hp_num",
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
							formation_type_layer = {
								path = "BG/all_layer/formation_type_layer",
								list = {
									info_layer = {
										path = "BG/all_layer/formation_type_layer/info_layer",
										list = {
											name_layer = {
												path = "BG/all_layer/formation_type_layer/info_layer/name_layer",
												list = {
													name_level = {
														path = "BG/all_layer/formation_type_layer/info_layer/name_layer/name_level",
														list = {
															name_level_1 = {
																path = "BG/all_layer/formation_type_layer/info_layer/name_layer/name_level/name_level_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															name_level_2 = {
																path = "BG/all_layer/formation_type_layer/info_layer/name_layer/name_level/name_level_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.UI.Image"
														}
													},
													name_dd = {
														path = "BG/all_layer/formation_type_layer/info_layer/name_layer/name_dd",
														list = {
															name_dd_1 = {
																path = "BG/all_layer/formation_type_layer/info_layer/name_layer/name_dd/name_dd_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															name_dd_2 = {
																path = "BG/all_layer/formation_type_layer/info_layer/name_layer/name_dd/name_dd_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer"
												}
											},
											atk_info = {
												path = "BG/all_layer/formation_type_layer/info_layer/atk_info",
												list = {
													Tip = {
														path = "BG/all_layer/formation_type_layer/info_layer/atk_info/Tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/info_layer/atk_info/num",
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
											torpedo_info = {
												path = "BG/all_layer/formation_type_layer/info_layer/torpedo_info",
												list = {
													Tip = {
														path = "BG/all_layer/formation_type_layer/info_layer/torpedo_info/Tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/info_layer/torpedo_info/num",
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
											def_info = {
												path = "BG/all_layer/formation_type_layer/info_layer/def_info",
												list = {
													Tip = {
														path = "BG/all_layer/formation_type_layer/info_layer/def_info/Tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/info_layer/def_info/num",
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
											air_def_info = {
												path = "BG/all_layer/formation_type_layer/info_layer/air_def_info",
												list = {
													Tip = {
														path = "BG/all_layer/formation_type_layer/info_layer/air_def_info/Tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/info_layer/air_def_info/num",
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
							supply_type_layer = {
								path = "BG/all_layer/supply_type_layer",
								list = {
									info_layer = {
										path = "BG/all_layer/supply_type_layer/info_layer",
										list = {
											name_layer = {
												path = "BG/all_layer/supply_type_layer/info_layer/name_layer",
												list = {
													name_level = {
														path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_level",
														list = {
															name_level_1 = {
																path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															name_level_2 = {
																path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.UI.Image"
														}
													},
													name_dd = {
														path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_dd",
														list = {
															name_dd_1 = {
																path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															name_dd_2 = {
																path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer"
												}
											},
											ammunition_layer = {
												path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer",
												list = {
													Tip = {
														path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/Tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ammunition_img = {
														path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img",
														list = {
															star_1 = {
																path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_2 = {
																path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_3 = {
																path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_4 = {
																path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_5 = {
																path = "BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_5",
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
											fuel_layer = {
												path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer",
												list = {
													Tip = {
														path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/Tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													fuel_img = {
														path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img",
														list = {
															star_1 = {
																path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_2 = {
																path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_3 = {
																path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_4 = {
																path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_5 = {
																path = "BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_5",
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
							equipment_type_layer = {
								path = "BG/all_layer/equipment_type_layer",
								list = {
									info_layer = {
										path = "BG/all_layer/equipment_type_layer/info_layer",
										list = {
											name_layer = {
												path = "BG/all_layer/equipment_type_layer/info_layer/name_layer",
												list = {
													name_level = {
														path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level",
														list = {
															name_level_1 = {
																path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level/name_level_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															name_level_2 = {
																path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level/name_level_2",
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
													name_dd = {
														path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_dd",
														list = {
															name_dd_1 = {
																path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_dd/name_dd_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															name_dd_2 = {
																path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_dd/name_dd_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer"
												}
											},
											equip_list = {
												path = "BG/all_layer/equipment_type_layer/info_layer/equip_list",
												list = {
													equip_1 = {
														path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1",
														list = {
															frame = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1/frame",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1/icon",
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
													equip_2 = {
														path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2",
														list = {
															frame = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2/frame",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2/icon",
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
													equip_3 = {
														path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3",
														list = {
															frame = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3/frame",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3/icon",
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
													equip_4 = {
														path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4",
														list = {
															frame = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4/frame",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4/icon",
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
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.GridLayoutGroup"
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
							shell_layer = {
								path = "BG/all_layer/shell_layer",
								list = {
									icon = {
										path = "BG/all_layer/shell_layer/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									count_txt = {
										path = "BG/all_layer/shell_layer/count_txt",
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
							tactic_layer = {
								path = "BG/all_layer/tactic_layer",
								list = {
									tactic_info = {
										path = "BG/all_layer/tactic_layer/tactic_info",
										list = {
											tactic_icon = {
												path = "BG/all_layer/tactic_layer/tactic_info/tactic_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											exp_plus = {
												path = "BG/all_layer/tactic_layer/tactic_info/exp_plus",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											exp_num = {
												path = "BG/all_layer/tactic_layer/tactic_info/exp_num",
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
											"UnityEngine.Canvas"
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
							"UnityEngine.CanvasGroup"
						}
					},
					cover_sprite = {
						path = "BG/cover_sprite",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					flag_ship = {
						path = "BG/flag_ship",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.UI.Image",
					"UIFadeTweener"
				}
			}
		},
		call_node_list = {
			["single_ship/BG/all_layer/formation_type_layer/info_layer/name_layer/name_level/name_level_2"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_level.name_level_2",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_2"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level.name_level_2",
			["single_ship/BG/all_layer/stationed_layer"] = "_control.BG.all_layer.stationed_layer",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/air_def_info"] = "_control.BG.all_layer.formation_type_layer.info_layer.air_def_info",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/torpedo_info/Tip"] = "_control.BG.all_layer.formation_type_layer.info_layer.torpedo_info.Tip",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_4",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/def_info"] = "_control.BG.all_layer.formation_type_layer.info_layer.def_info",
			["single_ship/BG/all_layer/love_layer/love"] = "_control.BG.all_layer.love_layer.love",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/torpedo_info/num"] = "_control.BG.all_layer.formation_type_layer.info_layer.torpedo_info.num",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/atk_info/num"] = "_control.BG.all_layer.formation_type_layer.info_layer.atk_info.num",
			["single_ship/BG/all_layer/hp_layer/hp_num"] = "_control.BG.all_layer.hp_layer.hp_num",
			["single_ship/BG/all_layer/repair_layer"] = "_control.BG.all_layer.repair_layer",
			["single_ship/BG/all_layer/level_layer"] = "_control.BG.all_layer.level_layer",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/name_layer"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_layer",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/atk_info"] = "_control.BG.all_layer.formation_type_layer.info_layer.atk_info",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_1"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level.name_level_1",
			["single_ship/BG/all_layer/level_layer/star_layer/star_5"] = "_control.BG.all_layer.level_layer.star_layer.star_5",
			["single_ship/BG/all_layer/level_layer/star_layer/star_6"] = "_control.BG.all_layer.level_layer.star_layer.star_6",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/name_layer/name_level"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_level",
			["single_ship/BG/all_layer/level_layer/level_txt"] = "_control.BG.all_layer.level_layer.level_txt",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_5"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_5",
			["single_ship/BG/all_layer/love_layer"] = "_control.BG.all_layer.love_layer",
			["single_ship/BG/all_layer/icon_layer"] = "_control.BG.all_layer.icon_layer",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/air_def_info/num"] = "_control.BG.all_layer.formation_type_layer.info_layer.air_def_info.num",
			["single_ship/BG/all_layer/supply_type_layer"] = "_control.BG.all_layer.supply_type_layer",
			["single_ship/BG/all_layer/stationed_layer/stationed_txt"] = "_control.BG.all_layer.stationed_layer.stationed_txt",
			["single_ship/BG/all_layer/icon_layer/icon"] = "_control.BG.all_layer.icon_layer.icon",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/name_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_1"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_dd.name_dd_1",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/num"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.num",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_2"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_2",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_4"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_4",
			["single_ship/BG/all_layer/tactic_layer/tactic_info/exp_num"] = "_control.BG.all_layer.tactic_layer.tactic_info.exp_num",
			["single_ship/BG/all_layer"] = "_control.BG.all_layer",
			["single_ship/BG/all_layer/formation_type_layer"] = "_control.BG.all_layer.formation_type_layer",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/def_info/Tip"] = "_control.BG.all_layer.formation_type_layer.info_layer.def_info.Tip",
			["single_ship/BG/all_layer/tactic_layer/tactic_info"] = "_control.BG.all_layer.tactic_layer.tactic_info",
			["single_ship/BG/all_layer/hp_layer"] = "_control.BG.all_layer.hp_layer",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/num"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.num",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/air_def_info/Tip"] = "_control.BG.all_layer.formation_type_layer.info_layer.air_def_info.Tip",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_5"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_5",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_2"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_2",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_4"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_4",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_1"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_1",
			["single_ship/BG/all_layer/equipment_type_layer"] = "_control.BG.all_layer.equipment_type_layer",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/name_layer"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level",
			["single_ship/BG/all_layer/level_layer/star_layer/star_2"] = "_control.BG.all_layer.level_layer.star_layer.star_2",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img",
			["single_ship/BG/all_layer/level_layer/star_layer"] = "_control.BG.all_layer.level_layer.star_layer",
			["single_ship/BG/all_layer/formation_type_layer/info_layer"] = "_control.BG.all_layer.formation_type_layer.info_layer",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level/name_level_1"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level.name_level_1",
			["single_ship/BG/all_layer/level_layer/info_bg"] = "_control.BG.all_layer.level_layer.info_bg",
			["single_ship/empty/flag_ship"] = "_control.empty.flag_ship",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level/name_level_2"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level.name_level_2",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_dd"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_dd",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_dd/name_dd_1"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_dd.name_dd_1",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_dd/name_dd_2"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_dd.name_dd_2",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_1",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_1.frame",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/name_layer/name_dd"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_dd",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_1.icon",
			["single_ship/BG/all_layer/supply_type_layer/info_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/torpedo_info"] = "_control.BG.all_layer.formation_type_layer.info_layer.torpedo_info",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_2",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/Tip"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.Tip",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_2"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_dd.name_dd_2",
			["single_ship/BG/all_layer/level_layer/star_layer/star_3"] = "_control.BG.all_layer.level_layer.star_layer.star_3",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_2.frame",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/def_info/num"] = "_control.BG.all_layer.formation_type_layer.info_layer.def_info.num",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_2.icon",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_3",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_3.frame",
			["single_ship/BG/all_layer/repair_layer/repair_txt"] = "_control.BG.all_layer.repair_layer.repair_txt",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_3.icon",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/atk_info/Tip"] = "_control.BG.all_layer.formation_type_layer.info_layer.atk_info.Tip",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/name_layer/name_dd"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_dd",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_4.frame",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_4.icon",
			["single_ship/BG/all_layer/level_layer/star_layer/star_1"] = "_control.BG.all_layer.level_layer.star_layer.star_1",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/name_layer/name_level/name_level_1"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_level.name_level_1",
			["single_ship/BG/all_layer/shell_layer"] = "_control.BG.all_layer.shell_layer",
			["single_ship/BG/all_layer/level_layer/ship_remake"] = "_control.BG.all_layer.level_layer.ship_remake",
			["single_ship/BG/all_layer/level_layer/country_txt"] = "_control.BG.all_layer.level_layer.country_txt",
			["single_ship/BG/all_layer/hp_layer/full_img"] = "_control.BG.all_layer.hp_layer.full_img",
			["single_ship/BG/flag_ship"] = "_control.BG.flag_ship",
			["single_ship/BG/all_layer/shell_layer/count_txt"] = "_control.BG.all_layer.shell_layer.count_txt",
			["single_ship/BG/all_layer/tactic_layer"] = "_control.BG.all_layer.tactic_layer",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_3"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_3",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer",
			["single_ship/BG/all_layer/level_layer/ship_custom"] = "_control.BG.all_layer.level_layer.ship_custom",
			["single_ship/BG/all_layer/level_layer/star_layer/star_7"] = "_control.BG.all_layer.level_layer.star_layer.star_7",
			["single_ship/BG/all_layer/tactic_layer/tactic_info/tactic_icon"] = "_control.BG.all_layer.tactic_layer.tactic_info.tactic_icon",
			["single_ship/BG/all_layer/level_layer/type_txt"] = "_control.BG.all_layer.level_layer.type_txt",
			["single_ship/BG/all_layer/tactic_layer/tactic_info/exp_plus"] = "_control.BG.all_layer.tactic_layer.tactic_info.exp_plus",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/name_layer/name_level"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level",
			["single_ship/BG/all_layer/drag_layer"] = "_control.BG.all_layer.drag_layer",
			["single_ship/BG/cover_sprite"] = "_control.BG.cover_sprite",
			["single_ship/BG/all_layer/item_btn"] = "_control.BG.all_layer.item_btn",
			["single_ship/BG/all_layer/shell_layer/icon"] = "_control.BG.all_layer.shell_layer.icon",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_3"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_3",
			["single_ship/BG/all_layer/equipment_type_layer/info_layer"] = "_control.BG.all_layer.equipment_type_layer.info_layer",
			["single_ship/empty/cover_sprite"] = "_control.empty.cover_sprite",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/name_layer/name_dd/name_dd_2"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_dd.name_dd_2",
			["single_ship/BG/all_layer/stationed_layer/stationed_bg"] = "_control.BG.all_layer.stationed_layer.stationed_bg",
			["single_ship/BG/all_layer/formation_type_layer/info_layer/name_layer/name_dd/name_dd_1"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_layer.name_dd.name_dd_1",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/fuel_layer/Tip"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.Tip",
			["single_ship/BG/all_layer/level_layer/star_layer/star_4"] = "_control.BG.all_layer.level_layer.star_layer.star_4",
			["single_ship/BG/all_layer/level_layer/lock_tag"] = "_control.BG.all_layer.level_layer.lock_tag",
			["single_ship/BG"] = "_control.BG",
			["single_ship/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_1"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_1",
			["single_ship/empty"] = "_control.empty",
			["single_ship/BG/all_layer/repair_layer/repair_bg"] = "_control.BG.all_layer.repair_layer.repair_bg"
		},
		click = {
			empty = {
				tp = "UnityEngine.UI.Button"
			},
			["BG/all_layer/drag_layer"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			["BG/all_layer/item_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {
			tactic_info = {
				component = "UnityEngine.Canvas",
				path = "BG/all_layer/tactic_layer/tactic_info"
			}
		}
	}
}

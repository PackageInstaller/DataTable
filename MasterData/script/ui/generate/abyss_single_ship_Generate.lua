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
							cover_sprite = {
								path = "BG/all_layer/cover_sprite",
								list = {},
								component = {
									"UnityEngine.RectTransform",
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
									ship_remake = {
										path = "BG/all_layer/level_layer/ship_remake",
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
							name_layer = {
								path = "BG/all_layer/name_layer",
								list = {
									name_level = {
										path = "BG/all_layer/name_layer/name_level",
										list = {
											name_level_1 = {
												path = "BG/all_layer/name_layer/name_level/name_level_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											name_level_2 = {
												path = "BG/all_layer/name_layer/name_level/name_level_2",
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
										path = "BG/all_layer/name_layer/name_dd",
										list = {
											name_dd_1 = {
												path = "BG/all_layer/name_layer/name_dd/name_dd_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											name_dd_2 = {
												path = "BG/all_layer/name_layer/name_dd/name_dd_2",
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
							formation_type_layer = {
								path = "BG/all_layer/formation_type_layer",
								list = {
									info_layer = {
										path = "BG/all_layer/formation_type_layer/info_layer",
										list = {
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
							},
							evo_image = {
								path = "BG/all_layer/evo_image",
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
							"UnityEngine.CanvasGroup"
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

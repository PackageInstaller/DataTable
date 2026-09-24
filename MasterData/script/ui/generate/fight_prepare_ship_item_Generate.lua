return {
	_rule_ = {
		none = {
			ship_empty = {
				path = "ship_empty",
				list = {
					bg = {
						path = "ship_empty/bg",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					add_ship_btn = {
						path = "ship_empty/add_ship_btn",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					bg_mask = {
						path = "ship_empty/bg_mask",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			campaign_layer = {
				path = "campaign_layer",
				list = {
					static_text = {
						path = "campaign_layer/static_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					limit_type = {
						path = "campaign_layer/limit_type",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			frame = {
				path = "frame",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			ship_item = {
				path = "ship_item",
				list = {
					item_icon_mask = {
						path = "ship_item/item_icon_mask",
						list = {
							quality = {
								path = "ship_item/item_icon_mask/quality",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							item_icon = {
								path = "ship_item/item_icon_mask/item_icon",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							mark_bg = {
								path = "ship_item/item_icon_mask/mark_bg",
								list = {
									expedition = {
										path = "ship_item/item_icon_mask/mark_bg/expedition",
										list = {
											txt = {
												path = "ship_item/item_icon_mask/mark_bg/expedition/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image",
											"UnityEngine.CanvasGroup"
										}
									},
									repair = {
										path = "ship_item/item_icon_mask/mark_bg/repair",
										list = {
											txt = {
												path = "ship_item/item_icon_mask/mark_bg/repair/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image",
											"UnityEngine.CanvasGroup"
										}
									},
									tower_limit = {
										path = "ship_item/item_icon_mask/mark_bg/tower_limit",
										list = {
											txt = {
												path = "ship_item/item_icon_mask/mark_bg/tower_limit/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image",
											"UnityEngine.CanvasGroup"
										}
									},
									stationed = {
										path = "ship_item/item_icon_mask/mark_bg/stationed",
										list = {
											txt = {
												path = "ship_item/item_icon_mask/mark_bg/stationed/txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image",
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.CanvasGroup"
								}
							},
							love_bg = {
								path = "ship_item/item_icon_mask/love_bg",
								list = {
									love = {
										path = "ship_item/item_icon_mask/love_bg/love",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					equipment_type_layer = {
						path = "ship_item/equipment_type_layer",
						list = {
							bg = {
								path = "ship_item/equipment_type_layer/bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							bg2 = {
								path = "ship_item/equipment_type_layer/bg2",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							shell_layer = {
								path = "ship_item/equipment_type_layer/shell_layer",
								list = {
									icon = {
										path = "ship_item/equipment_type_layer/shell_layer/icon",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									count_txt = {
										path = "ship_item/equipment_type_layer/shell_layer/count_txt",
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
							info_layer = {
								path = "ship_item/equipment_type_layer/info_layer",
								list = {
									ship_info = {
										path = "ship_item/equipment_type_layer/info_layer/ship_info",
										list = {
											bg = {
												path = "ship_item/equipment_type_layer/info_layer/ship_info/bg",
												list = {
													type_txt = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/type_txt",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													level_txt = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/level_txt",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													country_txt = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/country_txt",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													lock_tag = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/lock_tag",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													ship_remake = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/ship_remake",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													star_layer = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer",
														list = {
															star_1 = {
																path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.UI.Image"
																}
															},
															star_2 = {
																path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.UI.Image"
																}
															},
															star_3 = {
																path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.UI.Image"
																}
															},
															star_4 = {
																path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.UI.Image"
																}
															},
															star_5 = {
																path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_5",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.UI.Image"
																}
															},
															star_6 = {
																path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_6",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.UI.Image"
																}
															},
															star_7 = {
																path = "ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_7",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.UI.Image"
																}
															}
														},
														component = {}
													}
												},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											hp_bar_bg = {
												path = "ship_item/equipment_type_layer/info_layer/ship_info/hp_bar_bg",
												list = {
													hp_bar = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/hp_bar_bg/hp_bar",
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
											ship_name = {
												path = "ship_item/equipment_type_layer/info_layer/ship_info/ship_name",
												list = {
													ship_name_1 = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/ship_name/ship_name_1",
														list = {},
														component = {
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ship_name_2 = {
														path = "ship_item/equipment_type_layer/info_layer/ship_info/ship_name/ship_name_2",
														list = {},
														component = {
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {
													"UnityEngine.UI.Mask",
													"TextHorizonScroller",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									}
								},
								component = {}
							},
							equip_list = {
								path = "ship_item/equipment_type_layer/equip_list",
								list = {
									equip_1 = {
										path = "ship_item/equipment_type_layer/equip_list/equip_1",
										list = {
											frame = {
												path = "ship_item/equipment_type_layer/equip_list/equip_1/frame",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "ship_item/equipment_type_layer/equip_list/equip_1/icon",
												list = {},
												component = {
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
										path = "ship_item/equipment_type_layer/equip_list/equip_2",
										list = {
											frame = {
												path = "ship_item/equipment_type_layer/equip_list/equip_2/frame",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "ship_item/equipment_type_layer/equip_list/equip_2/icon",
												list = {},
												component = {
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
										path = "ship_item/equipment_type_layer/equip_list/equip_3",
										list = {
											frame = {
												path = "ship_item/equipment_type_layer/equip_list/equip_3/frame",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "ship_item/equipment_type_layer/equip_list/equip_3/icon",
												list = {},
												component = {
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
										path = "ship_item/equipment_type_layer/equip_list/equip_4",
										list = {
											frame = {
												path = "ship_item/equipment_type_layer/equip_list/equip_4/frame",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "ship_item/equipment_type_layer/equip_list/equip_4/icon",
												list = {},
												component = {
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
						component = {}
					},
					ship_item_btn = {
						path = "ship_item/ship_item_btn",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"ClickAndLongClickEvent"
						}
					},
					ship_item_drag = {
						path = "ship_item/ship_item_drag",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"RankableLayoutItem"
						}
					},
					nf_type_layer = {
						path = "ship_item/nf_type_layer",
						list = {
							info_layer = {
								path = "ship_item/nf_type_layer/info_layer",
								list = {
									atk_info = {
										path = "ship_item/nf_type_layer/info_layer/atk_info",
										list = {
											Tip = {
												path = "ship_item/nf_type_layer/info_layer/atk_info/Tip",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "ship_item/nf_type_layer/info_layer/atk_info/num",
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
									torpedo_info = {
										path = "ship_item/nf_type_layer/info_layer/torpedo_info",
										list = {
											Tip = {
												path = "ship_item/nf_type_layer/info_layer/torpedo_info/Tip",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "ship_item/nf_type_layer/info_layer/torpedo_info/num",
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
									def_info = {
										path = "ship_item/nf_type_layer/info_layer/def_info",
										list = {
											Tip = {
												path = "ship_item/nf_type_layer/info_layer/def_info/Tip",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "ship_item/nf_type_layer/info_layer/def_info/num",
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
									air_def_info = {
										path = "ship_item/nf_type_layer/info_layer/air_def_info",
										list = {
											Tip = {
												path = "ship_item/nf_type_layer/info_layer/air_def_info/Tip",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "ship_item/nf_type_layer/info_layer/air_def_info/num",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							ship_info = {
								path = "ship_item/nf_type_layer/ship_info",
								list = {
									bg = {
										path = "ship_item/nf_type_layer/ship_info/bg",
										list = {
											type_txt = {
												path = "ship_item/nf_type_layer/ship_info/bg/type_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											level_txt = {
												path = "ship_item/nf_type_layer/ship_info/bg/level_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											country_txt = {
												path = "ship_item/nf_type_layer/ship_info/bg/country_txt",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											star_layer = {
												path = "ship_item/nf_type_layer/ship_info/bg/star_layer",
												list = {
													star_1 = {
														path = "ship_item/nf_type_layer/ship_info/bg/star_layer/star_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "ship_item/nf_type_layer/ship_info/bg/star_layer/star_2",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "ship_item/nf_type_layer/ship_info/bg/star_layer/star_3",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "ship_item/nf_type_layer/ship_info/bg/star_layer/star_4",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "ship_item/nf_type_layer/ship_info/bg/star_layer/star_5",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "ship_item/nf_type_layer/ship_info/bg/star_layer/star_6",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "ship_item/nf_type_layer/ship_info/bg/star_layer/star_7",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									hp_bar_bg = {
										path = "ship_item/nf_type_layer/ship_info/hp_bar_bg",
										list = {
											hp_bar = {
												path = "ship_item/nf_type_layer/ship_info/hp_bar_bg/hp_bar",
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
									ship_name = {
										path = "ship_item/nf_type_layer/ship_info/ship_name",
										list = {
											ship_name_1 = {
												path = "ship_item/nf_type_layer/ship_info/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "ship_item/nf_type_layer/ship_info/ship_name/ship_name_2",
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
									}
								},
								component = {}
							}
						},
						component = {}
					},
					bottom_little = {
						path = "ship_item/bottom_little",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					bottom_small = {
						path = "ship_item/bottom_small",
						list = {
							bullet = {
								path = "ship_item/bottom_small/bullet",
								list = {
									title = {
										path = "ship_item/bottom_small/bullet/title",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "ship_item/bottom_small/bullet/count",
										list = {
											bullet1 = {
												path = "ship_item/bottom_small/bullet/count/bullet1",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet2 = {
												path = "ship_item/bottom_small/bullet/count/bullet2",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet3 = {
												path = "ship_item/bottom_small/bullet/count/bullet3",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet4 = {
												path = "ship_item/bottom_small/bullet/count/bullet4",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet5 = {
												path = "ship_item/bottom_small/bullet/count/bullet5",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									}
								},
								component = {}
							},
							fuel = {
								path = "ship_item/bottom_small/fuel",
								list = {
									title = {
										path = "ship_item/bottom_small/fuel/title",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "ship_item/bottom_small/fuel/count",
										list = {
											bullet1 = {
												path = "ship_item/bottom_small/fuel/count/bullet1",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet2 = {
												path = "ship_item/bottom_small/fuel/count/bullet2",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet3 = {
												path = "ship_item/bottom_small/fuel/count/bullet3",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet4 = {
												path = "ship_item/bottom_small/fuel/count/bullet4",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet5 = {
												path = "ship_item/bottom_small/fuel/count/bullet5",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					bottom_middle = {
						path = "ship_item/bottom_middle",
						list = {
							bullet = {
								path = "ship_item/bottom_middle/bullet",
								list = {
									title = {
										path = "ship_item/bottom_middle/bullet/title",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									count_text = {
										path = "ship_item/bottom_middle/bullet/count_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "ship_item/bottom_middle/bullet/count",
										list = {
											bullet1 = {
												path = "ship_item/bottom_middle/bullet/count/bullet1",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet2 = {
												path = "ship_item/bottom_middle/bullet/count/bullet2",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet3 = {
												path = "ship_item/bottom_middle/bullet/count/bullet3",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet4 = {
												path = "ship_item/bottom_middle/bullet/count/bullet4",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet5 = {
												path = "ship_item/bottom_middle/bullet/count/bullet5",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									}
								},
								component = {}
							},
							fuel = {
								path = "ship_item/bottom_middle/fuel",
								list = {
									title = {
										path = "ship_item/bottom_middle/fuel/title",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									count_text = {
										path = "ship_item/bottom_middle/fuel/count_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "ship_item/bottom_middle/fuel/count",
										list = {
											bullet1 = {
												path = "ship_item/bottom_middle/fuel/count/bullet1",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet2 = {
												path = "ship_item/bottom_middle/fuel/count/bullet2",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet3 = {
												path = "ship_item/bottom_middle/fuel/count/bullet3",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet4 = {
												path = "ship_item/bottom_middle/fuel/count/bullet4",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											bullet5 = {
												path = "ship_item/bottom_middle/fuel/count/bullet5",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					ship_info_1 = {
						path = "ship_item/ship_info_1",
						list = {
							bg = {
								path = "ship_item/ship_info_1/bg",
								list = {
									type_txt = {
										path = "ship_item/ship_info_1/bg/type_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "ship_item/ship_info_1/bg/level_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									country_txt = {
										path = "ship_item/ship_info_1/bg/country_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									lock_tag = {
										path = "ship_item/ship_info_1/bg/lock_tag",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_remake = {
										path = "ship_item/ship_info_1/bg/ship_remake",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									ship_custom = {
										path = "ship_item/ship_info_1/bg/ship_custom",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_layer = {
										path = "ship_item/ship_info_1/bg/star_layer",
										list = {
											star_1 = {
												path = "ship_item/ship_info_1/bg/star_layer/star_1",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											star_2 = {
												path = "ship_item/ship_info_1/bg/star_layer/star_2",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											star_3 = {
												path = "ship_item/ship_info_1/bg/star_layer/star_3",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											star_4 = {
												path = "ship_item/ship_info_1/bg/star_layer/star_4",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											star_5 = {
												path = "ship_item/ship_info_1/bg/star_layer/star_5",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											star_6 = {
												path = "ship_item/ship_info_1/bg/star_layer/star_6",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											star_7 = {
												path = "ship_item/ship_info_1/bg/star_layer/star_7",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							hp_bar_bg = {
								path = "ship_item/ship_info_1/hp_bar_bg",
								list = {
									hp_bar = {
										path = "ship_item/ship_info_1/hp_bar_bg/hp_bar",
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
							ship_name = {
								path = "ship_item/ship_info_1/ship_name",
								list = {
									ship_name_1 = {
										path = "ship_item/ship_info_1/ship_name/ship_name_1",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									ship_name_2 = {
										path = "ship_item/ship_info_1/ship_name/ship_name_2",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					shell_layer = {
						path = "ship_item/shell_layer",
						list = {
							icon = {
								path = "ship_item/shell_layer/icon",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							count_txt = {
								path = "ship_item/shell_layer/count_txt",
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
					shell_small = {
						path = "ship_item/shell_small",
						list = {
							icon = {
								path = "ship_item/shell_small/icon",
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
					ship_level_image = {
						path = "ship_item/ship_level_image",
						list = {
							ship_level_txt = {
								path = "ship_item/ship_level_image/ship_level_txt",
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
					cost_bg = {
						path = "ship_item/cost_bg",
						list = {
							cost = {
								path = "ship_item/cost_bg/cost",
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
					tactic_layer = {
						path = "ship_item/tactic_layer",
						list = {
							tactic_info = {
								path = "ship_item/tactic_layer/tactic_info",
								list = {
									tactic_icon = {
										path = "ship_item/tactic_layer/tactic_info/tactic_icon",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									exp_plus = {
										path = "ship_item/tactic_layer/tactic_info/exp_plus",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									exp_num = {
										path = "ship_item/tactic_layer/tactic_info/exp_num",
										list = {},
										component = {
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
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.CanvasGroup"
				}
			}
		},
		call_node_list = {
			["fight_prepare_ship_item/ship_item/bottom_small/bullet"] = "_control.ship_item.bottom_small.bullet",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/atk_info/num"] = "_control.ship_item.nf_type_layer.info_layer.atk_info.num",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_1"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer.star_1",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer/star_2"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer.star_2",
			["fight_prepare_ship_item/ship_item/equipment_type_layer"] = "_control.ship_item.equipment_type_layer",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer/star_3"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer.star_3",
			["fight_prepare_ship_item/ship_item/item_icon_mask/quality"] = "_control.ship_item.item_icon_mask.quality",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/country_txt"] = "_control.ship_item.nf_type_layer.ship_info.bg.country_txt",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/shell_layer"] = "_control.ship_item.equipment_type_layer.shell_layer",
			["fight_prepare_ship_item/ship_item/tactic_layer/tactic_info/exp_plus"] = "_control.ship_item.tactic_layer.tactic_info.exp_plus",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_1/frame"] = "_control.ship_item.equipment_type_layer.equip_list.equip_1.frame",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel"] = "_control.ship_item.bottom_small.fuel",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/count/bullet4"] = "_control.ship_item.bottom_middle.bullet.count.bullet4",
			["fight_prepare_ship_item/ship_item/tactic_layer/tactic_info"] = "_control.ship_item.tactic_layer.tactic_info",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer/star_6"] = "_control.ship_item.ship_info_1.bg.star_layer.star_6",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_4/icon"] = "_control.ship_item.equipment_type_layer.equip_list.equip_4.icon",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/country_txt"] = "_control.ship_item.ship_info_1.bg.country_txt",
			["fight_prepare_ship_item/ship_item/shell_small"] = "_control.ship_item.shell_small",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/def_info/num"] = "_control.ship_item.nf_type_layer.info_layer.def_info.num",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/tower_limit"] = "_control.ship_item.item_icon_mask.mark_bg.tower_limit",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer/star_5"] = "_control.ship_item.ship_info_1.bg.star_layer.star_5",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer/star_7"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer.star_7",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/count/bullet5"] = "_control.ship_item.bottom_middle.bullet.count.bullet5",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_6"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer.star_6",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/count/bullet2"] = "_control.ship_item.bottom_middle.bullet.count.bullet2",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/lock_tag"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.lock_tag",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/hp_bar_bg/hp_bar"] = "_control.ship_item.nf_type_layer.ship_info.hp_bar_bg.hp_bar",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list"] = "_control.ship_item.equipment_type_layer.equip_list",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer/star_1"] = "_control.ship_item.ship_info_1.bg.star_layer.star_1",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_7"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer.star_7",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_2/icon"] = "_control.ship_item.equipment_type_layer.equip_list.equip_2.icon",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer"] = "_control.ship_item.nf_type_layer.info_layer",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/type_txt"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.type_txt",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer/star_1"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer.star_1",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/count/bullet3"] = "_control.ship_item.bottom_middle.bullet.count.bullet3",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_2/frame"] = "_control.ship_item.equipment_type_layer.equip_list.equip_2.frame",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_1/icon"] = "_control.ship_item.equipment_type_layer.equip_list.equip_1.icon",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg"] = "_control.ship_item.item_icon_mask.mark_bg",
			["fight_prepare_ship_item/ship_empty/bg_mask"] = "_control.ship_empty.bg_mask",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/repair"] = "_control.ship_item.item_icon_mask.mark_bg.repair",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer/star_7"] = "_control.ship_item.ship_info_1.bg.star_layer.star_7",
			["fight_prepare_ship_item/ship_empty/bg"] = "_control.ship_empty.bg",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_4"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer.star_4",
			["fight_prepare_ship_item/campaign_layer/static_text"] = "_control.campaign_layer.static_text",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/ship_name/ship_name_1"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.ship_name.ship_name_1",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/atk_info"] = "_control.ship_item.nf_type_layer.info_layer.atk_info",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_2"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer.star_2",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer/star_3"] = "_control.ship_item.ship_info_1.bg.star_layer.star_3",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/atk_info/Tip"] = "_control.ship_item.nf_type_layer.info_layer.atk_info.Tip",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/ship_remake"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.ship_remake",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/torpedo_info/num"] = "_control.ship_item.nf_type_layer.info_layer.torpedo_info.num",
			["fight_prepare_ship_item/ship_item/shell_layer/count_txt"] = "_control.ship_item.shell_layer.count_txt",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_3"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer.star_3",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer/star_6"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer.star_6",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_4/frame"] = "_control.ship_item.equipment_type_layer.equip_list.equip_4.frame",
			["fight_prepare_ship_item/campaign_layer"] = "_control.campaign_layer",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/hp_bar_bg"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.hp_bar_bg",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/stationed"] = "_control.ship_item.item_icon_mask.mark_bg.stationed",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/repair/txt"] = "_control.ship_item.item_icon_mask.mark_bg.repair.txt",
			["fight_prepare_ship_item/ship_item/item_icon_mask"] = "_control.ship_item.item_icon_mask",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_2"] = "_control.ship_item.equipment_type_layer.equip_list.equip_2",
			["fight_prepare_ship_item/ship_item"] = "_control.ship_item",
			["fight_prepare_ship_item/ship_item/ship_item_btn"] = "_control.ship_item.ship_item_btn",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_3/icon"] = "_control.ship_item.equipment_type_layer.equip_list.equip_3.icon",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/torpedo_info/Tip"] = "_control.ship_item.nf_type_layer.info_layer.torpedo_info.Tip",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/count/bullet1"] = "_control.ship_item.bottom_middle.fuel.count.bullet1",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel/title"] = "_control.ship_item.bottom_small.fuel.title",
			["fight_prepare_ship_item/ship_item/bottom_little"] = "_control.ship_item.bottom_little",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/count/bullet4"] = "_control.ship_item.bottom_middle.fuel.count.bullet4",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/count/bullet5"] = "_control.ship_item.bottom_middle.fuel.count.bullet5",
			["fight_prepare_ship_item/ship_item/ship_info_1"] = "_control.ship_item.ship_info_1",
			["fight_prepare_ship_item/ship_item/bottom_small/bullet/count/bullet5"] = "_control.ship_item.bottom_small.bullet.count.bullet5",
			["fight_prepare_ship_item/ship_item/cost_bg/cost"] = "_control.ship_item.cost_bg.cost",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/level_txt"] = "_control.ship_item.ship_info_1.bg.level_txt",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/air_def_info"] = "_control.ship_item.nf_type_layer.info_layer.air_def_info",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer"] = "_control.ship_item.ship_info_1.bg.star_layer",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/ship_remake"] = "_control.ship_item.ship_info_1.bg.ship_remake",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/type_txt"] = "_control.ship_item.nf_type_layer.ship_info.bg.type_txt",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_3/frame"] = "_control.ship_item.equipment_type_layer.equip_list.equip_3.frame",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel/count"] = "_control.ship_item.bottom_small.fuel.count",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel/count/bullet5"] = "_control.ship_item.bottom_small.fuel.count.bullet5",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/count/bullet1"] = "_control.ship_item.bottom_middle.bullet.count.bullet1",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer/star_2"] = "_control.ship_item.ship_info_1.bg.star_layer.star_2",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/level_txt"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.level_txt",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/bg2"] = "_control.ship_item.equipment_type_layer.bg2",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/ship_custom"] = "_control.ship_item.ship_info_1.bg.ship_custom",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel/count/bullet4"] = "_control.ship_item.bottom_small.fuel.count.bullet4",
			["fight_prepare_ship_item/frame"] = "_control.frame",
			["fight_prepare_ship_item/ship_item/tactic_layer"] = "_control.ship_item.tactic_layer",
			["fight_prepare_ship_item/ship_empty"] = "_control.ship_empty",
			["fight_prepare_ship_item/ship_item/ship_info_1/ship_name/ship_name_2"] = "_control.ship_item.ship_info_1.ship_name.ship_name_2",
			["fight_prepare_ship_item/ship_item/ship_item_drag"] = "_control.ship_item.ship_item_drag",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel/count/bullet3"] = "_control.ship_item.bottom_small.fuel.count.bullet3",
			["fight_prepare_ship_item/ship_item/shell_layer"] = "_control.ship_item.shell_layer",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer/star_5"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer.star_5",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info"] = "_control.ship_item.nf_type_layer.ship_info",
			["fight_prepare_ship_item/ship_item/shell_small/icon"] = "_control.ship_item.shell_small.icon",
			["fight_prepare_ship_item/ship_item/bottom_small/bullet/count/bullet3"] = "_control.ship_item.bottom_small.bullet.count.bullet3",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet"] = "_control.ship_item.bottom_middle.bullet",
			["fight_prepare_ship_item/ship_item/ship_level_image/ship_level_txt"] = "_control.ship_item.ship_level_image.ship_level_txt",
			["fight_prepare_ship_item/ship_item/cost_bg"] = "_control.ship_item.cost_bg",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg"] = "_control.ship_item.ship_info_1.bg",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer"] = "_control.ship_item.equipment_type_layer.info_layer",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/torpedo_info"] = "_control.ship_item.nf_type_layer.info_layer.torpedo_info",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer/star_4"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer.star_4",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/count_text"] = "_control.ship_item.bottom_middle.bullet.count_text",
			["fight_prepare_ship_item/ship_item/tactic_layer/tactic_info/tactic_icon"] = "_control.ship_item.tactic_layer.tactic_info.tactic_icon",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/ship_name/ship_name_1"] = "_control.ship_item.nf_type_layer.ship_info.ship_name.ship_name_1",
			["fight_prepare_ship_item/ship_item/tactic_layer/tactic_info/exp_num"] = "_control.ship_item.tactic_layer.tactic_info.exp_num",
			["fight_prepare_ship_item/ship_item/bottom_small"] = "_control.ship_item.bottom_small",
			["fight_prepare_ship_item/ship_item/ship_info_1/ship_name/ship_name_1"] = "_control.ship_item.ship_info_1.ship_name.ship_name_1",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/count"] = "_control.ship_item.bottom_middle.bullet.count",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg"] = "_control.ship_item.nf_type_layer.ship_info.bg",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/lock_tag"] = "_control.ship_item.ship_info_1.bg.lock_tag",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/star_layer/star_4"] = "_control.ship_item.ship_info_1.bg.star_layer.star_4",
			["fight_prepare_ship_item/ship_item/bottom_small/bullet/count/bullet2"] = "_control.ship_item.bottom_small.bullet.count.bullet2",
			["fight_prepare_ship_item/ship_item/nf_type_layer"] = "_control.ship_item.nf_type_layer",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/air_def_info/Tip"] = "_control.ship_item.nf_type_layer.info_layer.air_def_info.Tip",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_1"] = "_control.ship_item.equipment_type_layer.equip_list.equip_1",
			["fight_prepare_ship_item/ship_empty/add_ship_btn"] = "_control.ship_empty.add_ship_btn",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/level_txt"] = "_control.ship_item.nf_type_layer.ship_info.bg.level_txt",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/ship_name"] = "_control.ship_item.nf_type_layer.ship_info.ship_name",
			["fight_prepare_ship_item/ship_item/item_icon_mask/love_bg/love"] = "_control.ship_item.item_icon_mask.love_bg.love",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/count"] = "_control.ship_item.bottom_middle.fuel.count",
			["fight_prepare_ship_item/ship_item/item_icon_mask/item_icon"] = "_control.ship_item.item_icon_mask.item_icon",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/hp_bar_bg"] = "_control.ship_item.nf_type_layer.ship_info.hp_bar_bg",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/country_txt"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.country_txt",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/air_def_info/num"] = "_control.ship_item.nf_type_layer.info_layer.air_def_info.num",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel"] = "_control.ship_item.bottom_middle.fuel",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/def_info"] = "_control.ship_item.nf_type_layer.info_layer.def_info",
			["fight_prepare_ship_item/ship_item/ship_level_image"] = "_control.ship_item.ship_level_image",
			["fight_prepare_ship_item/ship_item/bottom_small/bullet/count"] = "_control.ship_item.bottom_small.bullet.count",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel/count/bullet2"] = "_control.ship_item.bottom_small.fuel.count.bullet2",
			["fight_prepare_ship_item/campaign_layer/limit_type"] = "_control.campaign_layer.limit_type",
			["fight_prepare_ship_item/ship_item/ship_info_1/hp_bar_bg"] = "_control.ship_item.ship_info_1.hp_bar_bg",
			["fight_prepare_ship_item/ship_item/ship_info_1/hp_bar_bg/hp_bar"] = "_control.ship_item.ship_info_1.hp_bar_bg.hp_bar",
			["fight_prepare_ship_item/ship_item/nf_type_layer/info_layer/def_info/Tip"] = "_control.ship_item.nf_type_layer.info_layer.def_info.Tip",
			["fight_prepare_ship_item/ship_item/bottom_small/fuel/count/bullet1"] = "_control.ship_item.bottom_small.fuel.count.bullet1",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_3"] = "_control.ship_item.equipment_type_layer.equip_list.equip_3",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/tower_limit/txt"] = "_control.ship_item.item_icon_mask.mark_bg.tower_limit.txt",
			["fight_prepare_ship_item/ship_item/ship_info_1/ship_name"] = "_control.ship_item.ship_info_1.ship_name",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/stationed/txt"] = "_control.ship_item.item_icon_mask.mark_bg.stationed.txt",
			["fight_prepare_ship_item/ship_item/ship_info_1/bg/type_txt"] = "_control.ship_item.ship_info_1.bg.type_txt",
			["fight_prepare_ship_item/ship_item/shell_layer/icon"] = "_control.ship_item.shell_layer.icon",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/count_text"] = "_control.ship_item.bottom_middle.fuel.count_text",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/title"] = "_control.ship_item.bottom_middle.fuel.title",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/equip_list/equip_4"] = "_control.ship_item.equipment_type_layer.equip_list.equip_4",
			["fight_prepare_ship_item/ship_item/bottom_middle"] = "_control.ship_item.bottom_middle",
			["fight_prepare_ship_item/ship_item/bottom_middle/bullet/title"] = "_control.ship_item.bottom_middle.bullet.title",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/ship_name"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.ship_name",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/shell_layer/icon"] = "_control.ship_item.equipment_type_layer.shell_layer.icon",
			["fight_prepare_ship_item/ship_item/bottom_small/bullet/title"] = "_control.ship_item.bottom_small.bullet.title",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/ship_name/ship_name_2"] = "_control.ship_item.nf_type_layer.ship_info.ship_name.ship_name_2",
			["fight_prepare_ship_item/ship_item/nf_type_layer/ship_info/bg/star_layer"] = "_control.ship_item.nf_type_layer.ship_info.bg.star_layer",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/expedition"] = "_control.ship_item.item_icon_mask.mark_bg.expedition",
			["fight_prepare_ship_item/ship_item/item_icon_mask/mark_bg/expedition/txt"] = "_control.ship_item.item_icon_mask.mark_bg.expedition.txt",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/ship_name/ship_name_2"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.ship_name.ship_name_2",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/count/bullet3"] = "_control.ship_item.bottom_middle.fuel.count.bullet3",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/shell_layer/count_txt"] = "_control.ship_item.equipment_type_layer.shell_layer.count_txt",
			["fight_prepare_ship_item/ship_item/bottom_small/bullet/count/bullet4"] = "_control.ship_item.bottom_small.bullet.count.bullet4",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/hp_bar_bg/hp_bar"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.hp_bar_bg.hp_bar",
			["fight_prepare_ship_item/ship_item/bottom_middle/fuel/count/bullet2"] = "_control.ship_item.bottom_middle.fuel.count.bullet2",
			["fight_prepare_ship_item/ship_item/item_icon_mask/love_bg"] = "_control.ship_item.item_icon_mask.love_bg",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/bg"] = "_control.ship_item.equipment_type_layer.bg",
			["fight_prepare_ship_item/ship_item/bottom_small/bullet/count/bullet1"] = "_control.ship_item.bottom_small.bullet.count.bullet1",
			["fight_prepare_ship_item/ship_item/equipment_type_layer/info_layer/ship_info/bg/star_layer/star_5"] = "_control.ship_item.equipment_type_layer.info_layer.ship_info.bg.star_layer.star_5"
		},
		click = {
			["ship_empty/add_ship_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ship_item/ship_item_drag"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			["ship_item/ship_item_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {
			tactic_info = {
				component = "UnityEngine.Canvas",
				path = "ship_item/tactic_layer/tactic_info"
			}
		}
	}
}

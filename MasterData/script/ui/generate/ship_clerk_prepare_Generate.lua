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
			top_widget = {
				path = "top_widget",
				list = {
					return_btn = {
						path = "top_widget/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					secretary_btn = {
						path = "top_widget/secretary_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					top_title_text = {
						path = "top_widget/top_title_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			ship_sum_tip = {
				path = "ship_sum_tip",
				list = {
					ship_tip = {
						path = "ship_sum_tip/bg_1/ship_tip",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			bg_2_2 = {
				path = "ship_sum_tip/bg_2_2",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			left_list = {
				path = "left_list",
				list = {
					all_ship = {
						path = "left_list/all_ship",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"RankableLayoutGroup"
						}
					},
					team_content_obj = {
						path = "left_list/team_content_obj",
						list = {
							fade_content = {
								path = "left_list/team_content_obj/fade_content",
								list = {
									team_content = {
										path = "left_list/team_content_obj/fade_content/team_content",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					}
				},
				component = {}
			},
			left_main = {
				path = "left_list/left_main",
				list = {},
				component = {}
			},
			left_main_bg = {
				path = "left_list/left_main/left_main_bg",
				list = {},
				component = {}
			},
			all_layer = {
				path = "left_list/left_main/left_main_bg/all_layer",
				list = {
					icon_layer = {
						path = "left_list/left_main/left_main_bg/all_layer/icon_layer",
						list = {
							ship_icon = {
								path = "left_list/left_main/left_main_bg/all_layer/icon_layer/ship_icon",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					item_btn = {
						path = "left_list/left_main/left_main_bg/all_layer/item_btn",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"ClickAndLongClickEvent"
						}
					},
					love_layer = {
						path = "left_list/left_main/left_main_bg/all_layer/love_layer",
						list = {
							love = {
								path = "left_list/left_main/left_main_bg/all_layer/love_layer/love",
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
					main_icon = {
						path = "left_list/left_main/left_main_bg/all_layer/main_icon",
						list = {
							info_bg = {
								path = "left_list/left_main/left_main_bg/all_layer/main_icon/info_bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							info_bg_txt = {
								path = "left_list/left_main/left_main_bg/all_layer/main_icon/info_bg_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
					},
					level_layer = {
						path = "left_list/left_main/left_main_bg/all_layer/level_layer",
						list = {
							info_bg = {
								path = "left_list/left_main/left_main_bg/all_layer/level_layer/info_bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							type_txt = {
								path = "left_list/left_main/left_main_bg/all_layer/level_layer/type_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							level_txt = {
								path = "left_list/left_main/left_main_bg/all_layer/level_layer/level_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							country_txt = {
								path = "left_list/left_main/left_main_bg/all_layer/level_layer/country_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							lock_tag = {
								path = "left_list/left_main/left_main_bg/all_layer/level_layer/lock_tag",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							star_layer = {
								path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer",
								list = {
									star_1 = {
										path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_1",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									star_2 = {
										path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_2",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									star_3 = {
										path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_3",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									star_4 = {
										path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_4",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									star_5 = {
										path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_5",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									star_6 = {
										path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_6",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									star_7 = {
										path = "left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_7",
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
					supply_type_layer = {
						path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer",
						list = {
							info_layer = {
								path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer",
								list = {
									name_layer = {
										path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer",
										list = {
											name_level = {
												path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_level",
												list = {
													name_level_1 = {
														path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_1",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													name_level_2 = {
														path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_2",
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
											name_dd = {
												path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_dd",
												list = {
													name_dd_1 = {
														path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_1",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													},
													name_dd_2 = {
														path = "left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_2",
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
							}
						},
						component = {}
					}
				},
				component = {}
			},
			select_bg = {
				path = "left_list/left_main/left_main_bg/all_layer/select_bg",
				list = {
					select_bg_1 = {
						path = "left_list/left_main/left_main_bg/all_layer/select_bg/select_bg_1",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					select_bg_2 = {
						path = "left_list/left_main/left_main_bg/all_layer/select_bg/select_bg_2",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {}
			},
			right_list = {
				path = "right_list",
				list = {
					broke_close = {
						path = "right_list/broke_close",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					circulation = {
						path = "right_list/circulation",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			},
			broke_close_text = {
				path = "right_list/broke_close/broke_close_text",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			circulation_text = {
				path = "right_list/circulation/circulation_text",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			resert_btn = {
				path = "right_list/resert_btn",
				list = {
					resert_text = {
						path = "right_list/resert_btn/resert_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			down_show = {
				path = "down_show",
				list = {
					down_show_txt = {
						path = "down_show/down_show_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			bg_2 = {
				path = "bg_2",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			useragreement_msgbox = {
				path = "useragreement_msgbox",
				list = {
					btn_back = {
						path = "useragreement_msgbox/btn_back",
						list = {
							back = {
								path = "useragreement_msgbox/btn_back/back",
								list = {
									back_txt = {
										path = "useragreement_msgbox/btn_back/back/back_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					toptitle = {
						path = "useragreement_msgbox/toptitle",
						list = {
							agreetitle = {
								path = "useragreement_msgbox/toptitle/agreetitle",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
					},
					agreecontent = {
						path = "useragreement_msgbox/agreecontent",
						list = {
							agreetext = {
								path = "useragreement_msgbox/agreecontent/agreetext",
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
							"UnityEngine.UI.Mask",
							"UnityEngine.UI.ScrollRect"
						}
					}
				},
				component = {}
			}
		},
		call_node_list = {
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer"] = "_control.all_layer.supply_type_layer",
			["ship_clerk_prepare/right_list/circulation"] = "_control.right_list.circulation",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/item_btn"] = "_control.all_layer.item_btn",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_5"] = "_control.all_layer.level_layer.star_layer.star_5",
			["ship_clerk_prepare/left_list/all_ship"] = "_control.left_list.all_ship",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_6"] = "_control.all_layer.level_layer.star_layer.star_6",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_dd"] = "_control.all_layer.supply_type_layer.info_layer.name_layer.name_dd",
			["ship_clerk_prepare/left_list/left_main/left_main_bg"] = "_control.left_main_bg",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_7"] = "_control.all_layer.level_layer.star_layer.star_7",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer"] = "_control.all_layer.level_layer.star_layer",
			["ship_clerk_prepare/right_list/broke_close"] = "_control.right_list.broke_close",
			["ship_clerk_prepare/useragreement_msgbox/btn_back/back/back_txt"] = "_control.useragreement_msgbox.btn_back.back.back_txt",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/country_txt"] = "_control.all_layer.level_layer.country_txt",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/love_layer"] = "_control.all_layer.love_layer",
			["ship_clerk_prepare/top_widget/secretary_btn"] = "_control.top_widget.secretary_btn",
			["ship_clerk_prepare/right_list/circulation/circulation_text"] = "_control.circulation_text",
			["ship_clerk_prepare/left_list/left_main"] = "_control.left_main",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/info_bg"] = "_control.all_layer.level_layer.info_bg",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/main_icon/info_bg_txt"] = "_control.all_layer.main_icon.info_bg_txt",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/icon_layer"] = "_control.all_layer.icon_layer",
			["ship_clerk_prepare/useragreement_msgbox/toptitle"] = "_control.useragreement_msgbox.toptitle",
			["ship_clerk_prepare/left_list/team_content_obj/fade_content"] = "_control.left_list.team_content_obj.fade_content",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_1"] = "_control.all_layer.level_layer.star_layer.star_1",
			["ship_clerk_prepare/ship_sum_tip/bg_2_2"] = "_control.bg_2_2",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_1"] = "_control.all_layer.supply_type_layer.info_layer.name_layer.name_dd.name_dd_1",
			["ship_clerk_prepare/ship_sum_tip"] = "_control.ship_sum_tip",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_2"] = "_control.all_layer.supply_type_layer.info_layer.name_layer.name_level.name_level_2",
			["ship_clerk_prepare/useragreement_msgbox/toptitle/agreetitle"] = "_control.useragreement_msgbox.toptitle.agreetitle",
			["ship_clerk_prepare/right_list/broke_close/broke_close_text"] = "_control.broke_close_text",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_2"] = "_control.all_layer.level_layer.star_layer.star_2",
			["ship_clerk_prepare/top_widget"] = "_control.top_widget",
			["ship_clerk_prepare/useragreement_msgbox/agreecontent/agreetext"] = "_control.useragreement_msgbox.agreecontent.agreetext",
			["ship_clerk_prepare/left_list/team_content_obj/fade_content/team_content"] = "_control.left_list.team_content_obj.fade_content.team_content",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_3"] = "_control.all_layer.level_layer.star_layer.star_3",
			["ship_clerk_prepare/useragreement_msgbox/btn_back"] = "_control.useragreement_msgbox.btn_back",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/level_txt"] = "_control.all_layer.level_layer.level_txt",
			["ship_clerk_prepare/left_list"] = "_control.left_list",
			["ship_clerk_prepare/useragreement_msgbox"] = "_control.useragreement_msgbox",
			["ship_clerk_prepare/top_widget/return_btn"] = "_control.top_widget.return_btn",
			["ship_clerk_prepare/ship_sum_tip/bg_1/ship_tip"] = "_control.ship_sum_tip.ship_tip",
			["ship_clerk_prepare/down_show/down_show_txt"] = "_control.down_show.down_show_txt",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/main_icon/info_bg"] = "_control.all_layer.main_icon.info_bg",
			["ship_clerk_prepare/bg_2"] = "_control.bg_2",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/main_icon"] = "_control.all_layer.main_icon",
			["ship_clerk_prepare/right_list/resert_btn/resert_text"] = "_control.resert_btn.resert_text",
			["ship_clerk_prepare/useragreement_msgbox/agreecontent"] = "_control.useragreement_msgbox.agreecontent",
			["ship_clerk_prepare/down_show"] = "_control.down_show",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer"] = "_control.all_layer.supply_type_layer.info_layer.name_layer",
			["ship_clerk_prepare/left_list/team_content_obj"] = "_control.left_list.team_content_obj",
			["ship_clerk_prepare/top_widget/top_title_text"] = "_control.top_widget.top_title_text",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_level/name_level_1"] = "_control.all_layer.supply_type_layer.info_layer.name_layer.name_level.name_level_1",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_dd/name_dd_2"] = "_control.all_layer.supply_type_layer.info_layer.name_layer.name_dd.name_dd_2",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer"] = "_control.all_layer",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/select_bg"] = "_control.select_bg",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/lock_tag"] = "_control.all_layer.level_layer.lock_tag",
			["ship_clerk_prepare/right_list"] = "_control.right_list",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/love_layer/love"] = "_control.all_layer.love_layer.love",
			["ship_clerk_prepare/useragreement_msgbox/btn_back/back"] = "_control.useragreement_msgbox.btn_back.back",
			["ship_clerk_prepare/right_list/resert_btn"] = "_control.resert_btn",
			["ship_clerk_prepare/bg"] = "_control.bg",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/type_txt"] = "_control.all_layer.level_layer.type_txt",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/icon_layer/ship_icon"] = "_control.all_layer.icon_layer.ship_icon",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/select_bg/select_bg_2"] = "_control.select_bg.select_bg_2",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer"] = "_control.all_layer.level_layer",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer"] = "_control.all_layer.supply_type_layer.info_layer",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/select_bg/select_bg_1"] = "_control.select_bg.select_bg_1",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/level_layer/star_layer/star_4"] = "_control.all_layer.level_layer.star_layer.star_4",
			["ship_clerk_prepare/left_list/left_main/left_main_bg/all_layer/supply_type_layer/info_layer/name_layer/name_level"] = "_control.all_layer.supply_type_layer.info_layer.name_layer.name_level"
		},
		click = {
			["right_list/broke_close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_list/circulation"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_list/resert_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["useragreement_msgbox/btn_back/back"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top_widget/return_btn"] = {
				tp = "ScaleButton"
			},
			["top_widget/secretary_btn"] = {
				tp = "ScaleButton"
			}
		},
		click_and_long_click = {
			["left_list/left_main/left_main_bg/all_layer/item_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

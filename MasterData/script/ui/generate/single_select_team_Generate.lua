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
							formation_layer = {
								path = "BG/all_layer/formation_layer",
								list = {
									formation_bg = {
										path = "BG/all_layer/formation_layer/formation_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									formation_txt = {
										path = "BG/all_layer/formation_layer/formation_txt",
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
							expedition_layer = {
								path = "BG/all_layer/expedition_layer",
								list = {
									formation_bg = {
										path = "BG/all_layer/expedition_layer/formation_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									formation_txt = {
										path = "BG/all_layer/expedition_layer/formation_txt",
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
							status_layer = {
								path = "BG/all_layer/status_layer",
								list = {
									bg = {
										path = "BG/all_layer/status_layer/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									status = {
										path = "BG/all_layer/status_layer/status",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									status_txt = {
										path = "BG/all_layer/status_layer/status_txt",
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
							strike_layer = {
								path = "BG/all_layer/strike_layer",
								list = {
									strike_bg = {
										path = "BG/all_layer/strike_layer/strike_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									strike_txt = {
										path = "BG/all_layer/strike_layer/strike_txt",
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
							tactics_layer = {
								path = "BG/all_layer/tactics_layer",
								list = {
									tactics_bg = {
										path = "BG/all_layer/tactics_layer/tactics_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									tactics_level = {
										path = "BG/all_layer/tactics_layer/tactics_level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									tactics_exp = {
										path = "BG/all_layer/tactics_layer/tactics_exp",
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
							restaurant_layer = {
								path = "BG/all_layer/restaurant_layer",
								list = {
									restaurant_level = {
										path = "BG/all_layer/restaurant_layer/restaurant_level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									restaurant_exp = {
										path = "BG/all_layer/restaurant_layer/restaurant_exp",
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
									team_info = {
										path = "BG/all_layer/mask_img/team_info",
										list = {
											tip = {
												path = "BG/all_layer/mask_img/team_info/tip",
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
							},
							custom_img = {
								path = "BG/all_layer/custom_img",
								list = {
									custom_info = {
										path = "BG/all_layer/custom_img/custom_info",
										list = {
											custom_num = {
												path = "BG/all_layer/custom_img/custom_info/custom_num",
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
									team_info = {
										path = "BG/all_layer/custom_img/team_info",
										list = {
											tip = {
												path = "BG/all_layer/custom_img/team_info/tip",
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
										path = "BG/all_layer/formation_type_layer/level_layer",
										list = {
											info_bg = {
												path = "BG/all_layer/formation_type_layer/level_layer/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type_txt = {
												path = "BG/all_layer/formation_type_layer/level_layer/type_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											level_txt = {
												path = "BG/all_layer/formation_type_layer/level_layer/level_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											country_txt = {
												path = "BG/all_layer/formation_type_layer/level_layer/country_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											lock_tag = {
												path = "BG/all_layer/formation_type_layer/level_layer/lock_tag",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_remake = {
												path = "BG/all_layer/formation_type_layer/level_layer/ship_remake",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_layer = {
												path = "BG/all_layer/formation_type_layer/level_layer/star_layer",
												list = {
													star_1 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_2",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_3",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_4",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_5",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_6",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "BG/all_layer/formation_type_layer/level_layer/star_layer/star_7",
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
											line = {
												path = "BG/all_layer/formation_type_layer/level_layer/line",
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
									strength_level_layer = {
										path = "BG/all_layer/formation_type_layer/strength_level_layer",
										list = {
											info_bg = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											level_bg = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/level_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											level_txt = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/level_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											slv_txt = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/slv_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											item_1 = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/item_1",
												list = {
													no = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_1/no",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													have = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_1/have",
														list = {
															add = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/add",
																list = {
																	add_txt = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/add/add_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	num = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/add/num",
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
															max = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/max",
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
											item_2 = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/item_2",
												list = {
													no = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_2/no",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													have = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_2/have",
														list = {
															add = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/add",
																list = {
																	add_txt = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/add/add_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	num = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/add/num",
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
															max = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/max",
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
											item_3 = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/item_3",
												list = {
													no = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_3/no",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													have = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_3/have",
														list = {
															add = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/add",
																list = {
																	add_txt = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/add/add_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	num = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/add/num",
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
															max = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/max",
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
											item_4 = {
												path = "BG/all_layer/formation_type_layer/strength_level_layer/item_4",
												list = {
													no = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_4/no",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													have = {
														path = "BG/all_layer/formation_type_layer/strength_level_layer/item_4/have",
														list = {
															add = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/add",
																list = {
																	add_txt = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/add/add_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	num = {
																		path = "BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/add/num",
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
															max = {
																path = "BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/max",
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
											"UnityEngine.RectTransform"
										}
									},
									info_layer = {
										path = "BG/all_layer/formation_type_layer/info_layer",
										list = {
											name_level_1 = {
												path = "BG/all_layer/formation_type_layer/info_layer/name_level_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											["name_level _2"] = {
												path = "BG/all_layer/formation_type_layer/info_layer/name_level _2",
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
									detail_layer = {
										path = "BG/all_layer/formation_type_layer/detail_layer",
										list = {
											info_bg = {
												path = "BG/all_layer/formation_type_layer/detail_layer/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											txt_1 = {
												path = "BG/all_layer/formation_type_layer/detail_layer/txt_1",
												list = {
													tip = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_1/tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_1/num",
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
													"UnityEngine.CanvasRenderer"
												}
											},
											txt_2 = {
												path = "BG/all_layer/formation_type_layer/detail_layer/txt_2",
												list = {
													tip = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_2/tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_2/num",
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
													"UnityEngine.CanvasRenderer"
												}
											},
											txt_3 = {
												path = "BG/all_layer/formation_type_layer/detail_layer/txt_3",
												list = {
													tip = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_3/tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_3/num",
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
													"UnityEngine.CanvasRenderer"
												}
											},
											txt_4 = {
												path = "BG/all_layer/formation_type_layer/detail_layer/txt_4",
												list = {
													tip = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_4/tip",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "BG/all_layer/formation_type_layer/detail_layer/txt_4/num",
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
													"UnityEngine.CanvasRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									detail_layer_mist = {
										path = "BG/all_layer/formation_type_layer/detail_layer_mist",
										list = {
											info_bg = {
												path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg",
												list = {
													txt_1 = {
														path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_1",
														list = {
															tip = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_1/tip",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															num = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_1/num",
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
															"UnityEngine.CanvasRenderer"
														}
													},
													txt_2 = {
														path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_2",
														list = {
															tip = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_2/tip",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															num = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_2/num",
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
															"UnityEngine.CanvasRenderer"
														}
													},
													txt_3 = {
														path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_3",
														list = {
															tip = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_3/tip",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															num = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_3/num",
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
															"UnityEngine.CanvasRenderer"
														}
													},
													txt_4 = {
														path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_4",
														list = {
															tip = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_4/tip",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															num = {
																path = "BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_4/num",
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
															"UnityEngine.CanvasRenderer"
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
									custom = {
										path = "BG/all_layer/formation_type_layer/custom",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									strength_lock = {
										path = "BG/all_layer/formation_type_layer/strength_lock",
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
							supply_type_layer = {
								path = "BG/all_layer/supply_type_layer",
								list = {
									hp_layer = {
										path = "BG/all_layer/supply_type_layer/hp_layer",
										list = {
											full_img = {
												path = "BG/all_layer/supply_type_layer/hp_layer/full_img",
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
										path = "BG/all_layer/supply_type_layer/level_layer",
										list = {
											info_bg = {
												path = "BG/all_layer/supply_type_layer/level_layer/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type_txt = {
												path = "BG/all_layer/supply_type_layer/level_layer/type_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											level_txt = {
												path = "BG/all_layer/supply_type_layer/level_layer/level_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											country_txt = {
												path = "BG/all_layer/supply_type_layer/level_layer/country_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											lock_tag = {
												path = "BG/all_layer/supply_type_layer/level_layer/lock_tag",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_remake = {
												path = "BG/all_layer/supply_type_layer/level_layer/ship_remake",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_layer = {
												path = "BG/all_layer/supply_type_layer/level_layer/star_layer",
												list = {
													star_1 = {
														path = "BG/all_layer/supply_type_layer/level_layer/star_layer/star_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "BG/all_layer/supply_type_layer/level_layer/star_layer/star_2",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "BG/all_layer/supply_type_layer/level_layer/star_layer/star_3",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "BG/all_layer/supply_type_layer/level_layer/star_layer/star_4",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "BG/all_layer/supply_type_layer/level_layer/star_layer/star_5",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "BG/all_layer/supply_type_layer/level_layer/star_layer/star_6",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "BG/all_layer/supply_type_layer/level_layer/star_layer/star_7",
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
											line = {
												path = "BG/all_layer/supply_type_layer/level_layer/line",
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
									info_layer = {
										path = "BG/all_layer/supply_type_layer/info_layer",
										list = {
											name_layer = {
												path = "BG/all_layer/supply_type_layer/info_layer/name_layer",
												list = {
													name_level = {
														path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_level",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													["name_level _2"] = {
														path = "BG/all_layer/supply_type_layer/info_layer/name_layer/name_level _2",
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
															"UnityEngine.RectTransform",
															"UnityEngine.UI.GridLayoutGroup"
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
															"UnityEngine.RectTransform",
															"UnityEngine.UI.GridLayoutGroup"
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
									level_layer = {
										path = "BG/all_layer/equipment_type_layer/level_layer",
										list = {
											info_bg = {
												path = "BG/all_layer/equipment_type_layer/level_layer/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type_txt = {
												path = "BG/all_layer/equipment_type_layer/level_layer/type_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											level_txt = {
												path = "BG/all_layer/equipment_type_layer/level_layer/level_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											country_txt = {
												path = "BG/all_layer/equipment_type_layer/level_layer/country_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											lock_tag = {
												path = "BG/all_layer/equipment_type_layer/level_layer/lock_tag",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_remake = {
												path = "BG/all_layer/equipment_type_layer/level_layer/ship_remake",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_layer = {
												path = "BG/all_layer/equipment_type_layer/level_layer/star_layer",
												list = {
													star_1 = {
														path = "BG/all_layer/equipment_type_layer/level_layer/star_layer/star_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "BG/all_layer/equipment_type_layer/level_layer/star_layer/star_2",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "BG/all_layer/equipment_type_layer/level_layer/star_layer/star_3",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "BG/all_layer/equipment_type_layer/level_layer/star_layer/star_4",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "BG/all_layer/equipment_type_layer/level_layer/star_layer/star_5",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "BG/all_layer/equipment_type_layer/level_layer/star_layer/star_6",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "BG/all_layer/equipment_type_layer/level_layer/star_layer/star_7",
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
									info_layer = {
										path = "BG/all_layer/equipment_type_layer/info_layer",
										list = {
											name_layer = {
												path = "BG/all_layer/equipment_type_layer/info_layer/name_layer",
												list = {
													name_level = {
														path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													["name_level _2"] = {
														path = "BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level _2",
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
													"UnityEngine.UI.GridLayoutGroup",
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
							sixth_fight_layer = {
								path = "BG/all_layer/sixth_fight_layer",
								list = {
									formation_bg = {
										path = "BG/all_layer/sixth_fight_layer/formation_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									formation_txt = {
										path = "BG/all_layer/sixth_fight_layer/formation_txt",
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
							sixth_icon = {
								path = "BG/all_layer/sixth_icon",
								list = {
									money = {
										path = "BG/all_layer/sixth_icon/money",
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
							ship_level_image = {
								path = "BG/all_layer/ship_level_image",
								list = {
									ship_level_txt = {
										path = "BG/all_layer/ship_level_image/ship_level_txt",
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
							drag_layer = {
								path = "BG/all_layer/drag_layer",
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
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"ClickAndLongClickEvent"
				}
			},
			team_id_info = {
				path = "team_id_info",
				list = {
					team_id = {
						path = "team_id_info/team_id",
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
			cover_sprite = {
				path = "cover_sprite",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			tower_cost = {
				path = "tower_cost",
				list = {
					cost = {
						path = "tower_cost/cost",
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
		call_node_list = {
			["single_select_team/BG/all_layer/love_layer/love"] = "_control.BG.all_layer.love_layer.love",
			["single_select_team/BG/all_layer/expedition_layer"] = "_control.BG.all_layer.expedition_layer",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_3/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_3.num",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer/star_4"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer.star_4",
			["single_select_team/BG/all_layer/mask_img/team_info"] = "_control.BG.all_layer.mask_img.team_info",
			["single_select_team/BG/all_layer/stationed_layer"] = "_control.BG.all_layer.stationed_layer",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_2/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_2.num",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_2/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_2.tip",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_4/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_4.tip",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist",
			["single_select_team/BG/all_layer/supply_type_layer/hp_layer/full_img"] = "_control.BG.all_layer.supply_type_layer.hp_layer.full_img",
			["single_select_team/BG/all_layer/shell_layer/count_txt"] = "_control.BG.all_layer.shell_layer.count_txt",
			["single_select_team/BG/all_layer/stationed_layer/stationed_bg"] = "_control.BG.all_layer.stationed_layer.stationed_bg",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer/star_7"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer.star_7",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/add/num"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_1.have.add.num",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer/star_2"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_2",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_3/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_3.tip",
			["single_select_team/BG/all_layer/status_layer/status"] = "_control.BG.all_layer.status_layer.status",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_2/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_2.tip",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_2"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_2",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_1/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_1.num",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_1/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_1.tip",
			["single_select_team/BG/all_layer/icon_layer"] = "_control.BG.all_layer.icon_layer",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/level_txt"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.level_txt",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/add/num"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_4.have.add.num",
			["single_select_team/BG/all_layer/ship_level_image"] = "_control.BG.all_layer.ship_level_image",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_4"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_4",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/add"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_4.have.add",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer/star_7"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_7",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/max"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_3.have.max",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/add/num"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_3.have.add.num",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/add/add_txt"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_3.have.add.add_txt",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_3/have/add"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_3.have.add",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/add/add_txt"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_1.have.add.add_txt",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/max"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_2.have.max",
			["single_select_team/BG/all_layer/mask_img/number_info/num"] = "_control.BG.all_layer.mask_img.number_info.num",
			["single_select_team/BG/all_layer/formation_type_layer/hp_layer"] = "_control.BG.all_layer.formation_type_layer.hp_layer",
			["single_select_team/BG/all_layer/supply_type_layer/hp_layer"] = "_control.BG.all_layer.supply_type_layer.hp_layer",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/add/num"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_2.have.add.num",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_1"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_1",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_3/have"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_3.have",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_1.frame",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/lock_tag"] = "_control.BG.all_layer.formation_type_layer.level_layer.lock_tag",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/add"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_1.have.add",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_1/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_1.tip",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_2"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_2",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_1/have/max"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_1.have.max",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_4/no"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_4.no",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/info_bg"] = "_control.BG.all_layer.supply_type_layer.level_layer.info_bg",
			["single_select_team/BG/all_layer/custom_img/custom_info/custom_num"] = "_control.BG.all_layer.custom_img.custom_info.custom_num",
			["single_select_team/team_id_info"] = "_control.team_id_info",
			["single_select_team/BG/all_layer/restaurant_layer/restaurant_exp"] = "_control.BG.all_layer.restaurant_layer.restaurant_exp",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer/star_1"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer.star_1",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_2/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_2.num",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/level_txt"] = "_control.BG.all_layer.formation_type_layer.level_layer.level_txt",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_3/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_3.num",
			["single_select_team/BG/all_layer/tactics_layer/tactics_exp"] = "_control.BG.all_layer.tactics_layer.tactics_exp",
			["single_select_team/BG/all_layer/shell_layer/icon"] = "_control.BG.all_layer.shell_layer.icon",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_3"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_3",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_4/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_4.num",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_1/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_1.num",
			["single_select_team/BG/all_layer/custom_img/team_info"] = "_control.BG.all_layer.custom_img.team_info",
			["single_select_team/BG/all_layer/supply_type_layer"] = "_control.BG.all_layer.supply_type_layer",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer"] = "_control.BG.all_layer.formation_type_layer.level_layer",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_2"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_2",
			["single_select_team/BG/all_layer/custom_img"] = "_control.BG.all_layer.custom_img",
			["single_select_team/BG/all_layer/restaurant_layer"] = "_control.BG.all_layer.restaurant_layer",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/level_bg"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.level_bg",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_1/have"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_1.have",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_2",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/ship_remake"] = "_control.BG.all_layer.supply_type_layer.level_layer.ship_remake",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/name_layer/name_level _2"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level _2",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_3/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_3.tip",
			["single_select_team/BG/all_layer/tactics_layer/tactics_bg"] = "_control.BG.all_layer.tactics_layer.tactics_bg",
			["single_select_team/BG/all_layer/strike_layer"] = "_control.BG.all_layer.strike_layer",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/line"] = "_control.BG.all_layer.supply_type_layer.level_layer.line",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/country_txt"] = "_control.BG.all_layer.supply_type_layer.level_layer.country_txt",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/name_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/name_layer/name_level"] = "_control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level",
			["single_select_team/BG/all_layer/formation_layer/formation_txt"] = "_control.BG.all_layer.formation_layer.formation_txt",
			["single_select_team/BG/all_layer/formation_type_layer"] = "_control.BG.all_layer.formation_type_layer",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_2"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_2",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_3"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_3",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_5"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_5",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer",
			["single_select_team/BG/all_layer/formation_type_layer/info_layer/name_level_1"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_level_1",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer/Tip"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.Tip",
			["single_select_team/BG/all_layer/tactics_layer/tactics_level"] = "_control.BG.all_layer.tactics_layer.tactics_level",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_3"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_3",
			["single_select_team/BG/all_layer/custom_img/custom_info"] = "_control.BG.all_layer.custom_img.custom_info",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/add/add_txt"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_2.have.add.add_txt",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_5"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_5",
			["single_select_team/BG/all_layer/equipment_type_layer"] = "_control.BG.all_layer.equipment_type_layer",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer"] = "_control.BG.all_layer.equipment_type_layer.level_layer",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/type_txt"] = "_control.BG.all_layer.formation_type_layer.level_layer.type_txt",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/slv_txt"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.slv_txt",
			["single_select_team/BG/all_layer/tactics_layer"] = "_control.BG.all_layer.tactics_layer",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/info_bg"] = "_control.BG.all_layer.equipment_type_layer.level_layer.info_bg",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/type_txt"] = "_control.BG.all_layer.equipment_type_layer.level_layer.type_txt",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/info_bg"] = "_control.BG.all_layer.formation_type_layer.detail_layer.info_bg",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer/txt_1"] = "_control.BG.all_layer.formation_type_layer.detail_layer.txt_1",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/level_txt"] = "_control.BG.all_layer.equipment_type_layer.level_layer.level_txt",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/ship_remake"] = "_control.BG.all_layer.equipment_type_layer.level_layer.ship_remake",
			["single_select_team/BG/all_layer/formation_type_layer/info_layer/name_level _2"] = "_control.BG.all_layer.formation_type_layer.info_layer.name_level _2",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer",
			["single_select_team/BG/all_layer/stationed_layer/stationed_txt"] = "_control.BG.all_layer.stationed_layer.stationed_txt",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer/star_1"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer.star_1",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer/star_2"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer.star_2",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/lock_tag"] = "_control.BG.all_layer.equipment_type_layer.level_layer.lock_tag",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer",
			["single_select_team/BG/all_layer/expedition_layer/formation_txt"] = "_control.BG.all_layer.expedition_layer.formation_txt",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer/star_3"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer.star_3",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer"] = "_control.BG.all_layer.equipment_type_layer.info_layer",
			["single_select_team/BG/all_layer/formation_type_layer/custom"] = "_control.BG.all_layer.formation_type_layer.custom",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer"] = "_control.BG.all_layer.supply_type_layer.level_layer",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/info_bg"] = "_control.BG.all_layer.formation_type_layer.level_layer.info_bg",
			["single_select_team/BG/all_layer/restaurant_layer/restaurant_level"] = "_control.BG.all_layer.restaurant_layer.restaurant_level",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer/star_3"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_3",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/name_layer"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level",
			["single_select_team/BG/all_layer/status_layer"] = "_control.BG.all_layer.status_layer",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/name_layer/name_level _2"] = "_control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level _2",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_1",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_2/have"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_2.have",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/type_txt"] = "_control.BG.all_layer.supply_type_layer.level_layer.type_txt",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_2.frame",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_4/num"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_4.num",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_3"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_3",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer/star_1"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_1",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img/star_4"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.star_4",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_2"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_2",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_1/no"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_1.no",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/fuel_layer/fuel_img"] = "_control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_2/no"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_2.no",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/line"] = "_control.BG.all_layer.formation_type_layer.level_layer.line",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_4/have"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_4.have",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer/star_6"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer.star_6",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_2/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_2.icon",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_3",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_3.frame",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_3/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_3.icon",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4/frame"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_4.frame",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_4.icon",
			["single_select_team/BG/all_layer/shell_layer"] = "_control.BG.all_layer.shell_layer",
			["single_select_team/BG"] = "_control.BG",
			["single_select_team/BG/all_layer/formation_layer"] = "_control.BG.all_layer.formation_layer",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer/star_7"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer.star_7",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_1"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_1",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer/star_4"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer.star_4",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/lock_tag"] = "_control.BG.all_layer.supply_type_layer.level_layer.lock_tag",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/info_bg"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.info_bg",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_1/icon"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_1.icon",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_1"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_1",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_2/have/add"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_2.have.add",
			["single_select_team/BG/all_layer/sixth_fight_layer"] = "_control.BG.all_layer.sixth_fight_layer",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/ship_remake"] = "_control.BG.all_layer.formation_type_layer.level_layer.ship_remake",
			["single_select_team/BG/all_layer/sixth_fight_layer/formation_bg"] = "_control.BG.all_layer.sixth_fight_layer.formation_bg",
			["single_select_team/BG/all_layer/sixth_icon/money"] = "_control.BG.all_layer.sixth_icon.money",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/star_layer/star_5"] = "_control.BG.all_layer.equipment_type_layer.level_layer.star_layer.star_5",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_3/no"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_3.no",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_4"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_4",
			["single_select_team/BG/all_layer/formation_type_layer/strength_lock"] = "_control.BG.all_layer.formation_type_layer.strength_lock",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/add/add_txt"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_4.have.add.add_txt",
			["single_select_team/BG/all_layer/formation_type_layer/info_layer"] = "_control.BG.all_layer.formation_type_layer.info_layer",
			["single_select_team/BG/all_layer/ship_level_image/ship_level_txt"] = "_control.BG.all_layer.ship_level_image.ship_level_txt",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_4"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_4",
			["single_select_team/BG/all_layer/equipment_type_layer/info_layer/equip_list/equip_4"] = "_control.BG.all_layer.equipment_type_layer.info_layer.equip_list.equip_4",
			["single_select_team/BG/all_layer/drag_layer"] = "_control.BG.all_layer.drag_layer",
			["single_select_team/BG/all_layer/strike_layer/strike_txt"] = "_control.BG.all_layer.strike_layer.strike_txt",
			["single_select_team/team_id_info/team_id"] = "_control.team_id_info.team_id",
			["single_select_team/tower_cost"] = "_control.tower_cost",
			["single_select_team/tower_cost/cost"] = "_control.tower_cost.cost",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/level_txt"] = "_control.BG.all_layer.supply_type_layer.level_layer.level_txt",
			["single_select_team/BG/all_layer/equipment_type_layer/level_layer/country_txt"] = "_control.BG.all_layer.equipment_type_layer.level_layer.country_txt",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer/item_4/have/max"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer.item_4.have.max",
			["single_select_team/BG/all_layer/status_layer/bg"] = "_control.BG.all_layer.status_layer.bg",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_4"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_4",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer/star_5"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_5",
			["single_select_team/BG/all_layer"] = "_control.BG.all_layer",
			["single_select_team/BG/all_layer/love_layer"] = "_control.BG.all_layer.love_layer",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/ammunition_img/star_1"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_1",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer/star_6"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_6",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer/star_2"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer.star_2",
			["single_select_team/BG/all_layer/custom_img/team_info/tip"] = "_control.BG.all_layer.custom_img.team_info.tip",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/country_txt"] = "_control.BG.all_layer.formation_type_layer.level_layer.country_txt",
			["single_select_team/BG/all_layer/formation_type_layer/level_layer/star_layer/star_4"] = "_control.BG.all_layer.formation_type_layer.level_layer.star_layer.star_4",
			["single_select_team/BG/all_layer/sixth_icon"] = "_control.BG.all_layer.sixth_icon",
			["single_select_team/BG/all_layer/formation_type_layer/strength_level_layer"] = "_control.BG.all_layer.formation_type_layer.strength_level_layer",
			["single_select_team/BG/all_layer/icon_layer/icon"] = "_control.BG.all_layer.icon_layer.icon",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer/star_5"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer.star_5",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_4/tip"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_4.tip",
			["single_select_team/BG/all_layer/mask_img/team_info/tip"] = "_control.BG.all_layer.mask_img.team_info.tip",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer_mist/info_bg/txt_3"] = "_control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_3",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer/star_3"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer.star_3",
			["single_select_team/BG/all_layer/status_layer/status_txt"] = "_control.BG.all_layer.status_layer.status_txt",
			["single_select_team/BG/all_layer/formation_type_layer/hp_layer/full_img"] = "_control.BG.all_layer.formation_type_layer.hp_layer.full_img",
			["single_select_team/BG/all_layer/sixth_fight_layer/formation_txt"] = "_control.BG.all_layer.sixth_fight_layer.formation_txt",
			["single_select_team/BG/all_layer/formation_layer/formation_bg"] = "_control.BG.all_layer.formation_layer.formation_bg",
			["single_select_team/BG/all_layer/mask_img/number_info"] = "_control.BG.all_layer.mask_img.number_info",
			["single_select_team/BG/all_layer/mask_img"] = "_control.BG.all_layer.mask_img",
			["single_select_team/BG/all_layer/strike_layer/strike_bg"] = "_control.BG.all_layer.strike_layer.strike_bg",
			["single_select_team/BG/all_layer/formation_type_layer/detail_layer"] = "_control.BG.all_layer.formation_type_layer.detail_layer",
			["single_select_team/cover_sprite"] = "_control.cover_sprite",
			["single_select_team/BG/all_layer/supply_type_layer/level_layer/star_layer/star_6"] = "_control.BG.all_layer.supply_type_layer.level_layer.star_layer.star_6",
			["single_select_team/BG/all_layer/supply_type_layer/info_layer/ammunition_layer/Tip"] = "_control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.Tip",
			["single_select_team/BG/all_layer/expedition_layer/formation_bg"] = "_control.BG.all_layer.expedition_layer.formation_bg"
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

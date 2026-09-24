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
							"UnityEngine.UI.Mask",
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
			}
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

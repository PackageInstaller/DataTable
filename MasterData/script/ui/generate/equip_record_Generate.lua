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
			bg_container = {
				path = "bg_container",
				list = {
					title = {
						path = "bg_container/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line_up = {
						path = "bg_container/line_up",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_down = {
						path = "bg_container/line_down",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close_btn = {
						path = "bg_container/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					ship_hint_txt = {
						path = "bg_container/ship_hint_txt",
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
			content = {
				path = "content",
				list = {
					ship_layer = {
						path = "content/ship_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					content = {
						path = "content/content",
						list = {
							bg = {
								path = "content/content/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							toggle_group = {
								path = "content/content/toggle_group",
								list = {
									tog_one = {
										path = "content/content/toggle_group/tog_one",
										list = {
											Background = {
												path = "content/content/toggle_group/tog_one/Background",
												list = {
													Checkmark = {
														path = "content/content/toggle_group/tog_one/Background/Checkmark",
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
											title = {
												path = "content/content/toggle_group/tog_one/title",
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
									tog_two = {
										path = "content/content/toggle_group/tog_two",
										list = {
											Background = {
												path = "content/content/toggle_group/tog_two/Background",
												list = {
													Checkmark = {
														path = "content/content/toggle_group/tog_two/Background/Checkmark",
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
											title = {
												path = "content/content/toggle_group/tog_two/title",
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
									tog_three = {
										path = "content/content/toggle_group/tog_three",
										list = {
											Background = {
												path = "content/content/toggle_group/tog_three/Background",
												list = {
													Checkmark = {
														path = "content/content/toggle_group/tog_three/Background/Checkmark",
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
											title = {
												path = "content/content/toggle_group/tog_three/title",
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
									tog_four = {
										path = "content/content/toggle_group/tog_four",
										list = {
											Background = {
												path = "content/content/toggle_group/tog_four/Background",
												list = {
													Checkmark = {
														path = "content/content/toggle_group/tog_four/Background/Checkmark",
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
											title = {
												path = "content/content/toggle_group/tog_four/title",
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
							equips = {
								path = "content/content/equips",
								list = {
									equip_1 = {
										path = "content/content/equips/equip_1",
										list = {
											back_shadow = {
												path = "content/content/equips/equip_1/back_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "content/content/equips/equip_1/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equipment = {
												path = "content/content/equips/equip_1/equipment",
												list = {
													equip_rarity = {
														path = "content/content/equips/equip_1/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "content/content/equips/equip_1/equipment/equip_icon",
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
											name_mask = {
												path = "content/content/equips/equip_1/name_mask",
												list = {
													equipname = {
														path = "content/content/equips/equip_1/name_mask/equipname",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													equipname_2 = {
														path = "content/content/equips/equip_1/name_mask/equipname_2",
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
													"UnityEngine.UI.Image",
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									equip_2 = {
										path = "content/content/equips/equip_2",
										list = {
											back_shadow = {
												path = "content/content/equips/equip_2/back_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "content/content/equips/equip_2/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equipment = {
												path = "content/content/equips/equip_2/equipment",
												list = {
													equip_rarity = {
														path = "content/content/equips/equip_2/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "content/content/equips/equip_2/equipment/equip_icon",
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
											name_mask = {
												path = "content/content/equips/equip_2/name_mask",
												list = {
													equipname = {
														path = "content/content/equips/equip_2/name_mask/equipname",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													equipname_2 = {
														path = "content/content/equips/equip_2/name_mask/equipname_2",
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
													"UnityEngine.UI.Image",
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									equip_3 = {
										path = "content/content/equips/equip_3",
										list = {
											back_shadow = {
												path = "content/content/equips/equip_3/back_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "content/content/equips/equip_3/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equipment = {
												path = "content/content/equips/equip_3/equipment",
												list = {
													equip_rarity = {
														path = "content/content/equips/equip_3/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "content/content/equips/equip_3/equipment/equip_icon",
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
											name_mask = {
												path = "content/content/equips/equip_3/name_mask",
												list = {
													equipname = {
														path = "content/content/equips/equip_3/name_mask/equipname",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													equipname_2 = {
														path = "content/content/equips/equip_3/name_mask/equipname_2",
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
													"UnityEngine.UI.Image",
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									equip_4 = {
										path = "content/content/equips/equip_4",
										list = {
											back_shadow = {
												path = "content/content/equips/equip_4/back_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "content/content/equips/equip_4/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equipment = {
												path = "content/content/equips/equip_4/equipment",
												list = {
													equip_rarity = {
														path = "content/content/equips/equip_4/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "content/content/equips/equip_4/equipment/equip_icon",
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
											name_mask = {
												path = "content/content/equips/equip_4/name_mask",
												list = {
													equipname = {
														path = "content/content/equips/equip_4/name_mask/equipname",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													equipname_2 = {
														path = "content/content/equips/equip_4/name_mask/equipname_2",
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
													"UnityEngine.UI.Image",
													"TextHorizonScroller"
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
							ship_detail = {
								path = "content/content/ship_detail",
								list = {
									line_up = {
										path = "content/content/ship_detail/line_up",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attr_1 = {
										path = "content/content/ship_detail/attr_1",
										list = {
											title = {
												path = "content/content/ship_detail/attr_1/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_1/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_1/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_1/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_1/attr_change_num",
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
									attr_2 = {
										path = "content/content/ship_detail/attr_2",
										list = {
											title = {
												path = "content/content/ship_detail/attr_2/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_2/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_2/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_2/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_2/attr_change_num",
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
									attr_3 = {
										path = "content/content/ship_detail/attr_3",
										list = {
											title = {
												path = "content/content/ship_detail/attr_3/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_3/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_3/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_3/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_3/attr_change_num",
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
									attr_4 = {
										path = "content/content/ship_detail/attr_4",
										list = {
											title = {
												path = "content/content/ship_detail/attr_4/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_4/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_4/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_4/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_4/attr_change_num",
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
									attr_5 = {
										path = "content/content/ship_detail/attr_5",
										list = {
											title = {
												path = "content/content/ship_detail/attr_5/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_5/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_5/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_5/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_5/attr_change_num",
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
									attr_6 = {
										path = "content/content/ship_detail/attr_6",
										list = {
											title = {
												path = "content/content/ship_detail/attr_6/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_6/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_6/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_6/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_6/attr_change_num",
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
									attr_7 = {
										path = "content/content/ship_detail/attr_7",
										list = {
											title = {
												path = "content/content/ship_detail/attr_7/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_7/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_7/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_7/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_7/attr_change_num",
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
									attr_8 = {
										path = "content/content/ship_detail/attr_8",
										list = {
											title = {
												path = "content/content/ship_detail/attr_8/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_8/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_8/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_8/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_8/attr_change_num",
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
									attr_9 = {
										path = "content/content/ship_detail/attr_9",
										list = {
											title = {
												path = "content/content/ship_detail/attr_9/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_9/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_9/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_9/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_9/attr_change_num",
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
									attr_10 = {
										path = "content/content/ship_detail/attr_10",
										list = {
											title = {
												path = "content/content/ship_detail/attr_10/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_10/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_10/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_10/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_10/attr_change_num",
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
									attr_11 = {
										path = "content/content/ship_detail/attr_11",
										list = {
											title = {
												path = "content/content/ship_detail/attr_11/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_11/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_11/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_11/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_11/attr_change_num",
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
									attr_12 = {
										path = "content/content/ship_detail/attr_12",
										list = {
											title = {
												path = "content/content/ship_detail/attr_12/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_bg = {
												path = "content/content/ship_detail/attr_12/attr_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_num = {
												path = "content/content/ship_detail/attr_12/attr_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											frame = {
												path = "content/content/ship_detail/attr_12/frame",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_change_num = {
												path = "content/content/ship_detail/attr_12/attr_change_num",
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
									line_down = {
										path = "content/content/ship_detail/line_down",
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
							record_btn = {
								path = "content/content/record_btn",
								list = {
									title = {
										path = "content/content/record_btn/title",
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
							use_btn = {
								path = "content/content/use_btn",
								list = {
									title = {
										path = "content/content/use_btn/title",
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
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["equip_record/content/content/ship_detail/attr_8/attr_change_num"] = "_control.content.content.ship_detail.attr_8.attr_change_num",
			["equip_record/content/content/ship_detail/attr_8"] = "_control.content.content.ship_detail.attr_8",
			["equip_record/content/content/equips/equip_1/name_mask/equipname_2"] = "_control.content.content.equips.equip_1.name_mask.equipname_2",
			["equip_record/content/content/ship_detail/attr_9/attr_num"] = "_control.content.content.ship_detail.attr_9.attr_num",
			["equip_record/content/content/ship_detail/attr_9/title"] = "_control.content.content.ship_detail.attr_9.title",
			["equip_record/content/content/ship_detail/attr_6/title"] = "_control.content.content.ship_detail.attr_6.title",
			["equip_record/content/content/ship_detail/attr_8/frame"] = "_control.content.content.ship_detail.attr_8.frame",
			["equip_record/content/content/ship_detail/attr_8/attr_num"] = "_control.content.content.ship_detail.attr_8.attr_num",
			["equip_record/content/content/ship_detail/attr_8/attr_bg"] = "_control.content.content.ship_detail.attr_8.attr_bg",
			["equip_record/content/content/ship_detail/attr_8/title"] = "_control.content.content.ship_detail.attr_8.title",
			["equip_record/content/content/ship_detail/attr_7/attr_change_num"] = "_control.content.content.ship_detail.attr_7.attr_change_num",
			["equip_record/content/content/ship_detail/attr_7/frame"] = "_control.content.content.ship_detail.attr_7.frame",
			["equip_record/content/content/ship_detail/attr_7/attr_num"] = "_control.content.content.ship_detail.attr_7.attr_num",
			["equip_record/content/content/use_btn"] = "_control.content.content.use_btn",
			["equip_record/content/content/ship_detail/attr_7/title"] = "_control.content.content.ship_detail.attr_7.title",
			["equip_record/content/content/ship_detail/attr_6/attr_change_num"] = "_control.content.content.ship_detail.attr_6.attr_change_num",
			["equip_record/content/content/ship_detail/attr_6/frame"] = "_control.content.content.ship_detail.attr_6.frame",
			["equip_record/content/content/ship_detail/attr_1/attr_bg"] = "_control.content.content.ship_detail.attr_1.attr_bg",
			["equip_record/content/content/toggle_group/tog_two"] = "_control.content.content.toggle_group.tog_two",
			["equip_record/content/content/ship_detail/attr_1/attr_change_num"] = "_control.content.content.ship_detail.attr_1.attr_change_num",
			["equip_record/content/content/ship_detail/attr_5/frame"] = "_control.content.content.ship_detail.attr_5.frame",
			["equip_record/content/content/equips/equip_2/add_equip"] = "_control.content.content.equips.equip_2.add_equip",
			["equip_record/content/content/ship_detail/attr_5/attr_bg"] = "_control.content.content.ship_detail.attr_5.attr_bg",
			["equip_record/content/content/ship_detail/attr_5/title"] = "_control.content.content.ship_detail.attr_5.title",
			["equip_record/content/content/ship_detail/attr_4/attr_change_num"] = "_control.content.content.ship_detail.attr_4.attr_change_num",
			["equip_record/content/content/equips/equip_4/name_mask/equipname"] = "_control.content.content.equips.equip_4.name_mask.equipname",
			["equip_record/content/content/ship_detail/attr_7"] = "_control.content.content.ship_detail.attr_7",
			["equip_record/content/content/ship_detail/attr_4/attr_num"] = "_control.content.content.ship_detail.attr_4.attr_num",
			["equip_record/content/content/ship_detail/attr_4/attr_bg"] = "_control.content.content.ship_detail.attr_4.attr_bg",
			["equip_record/content/content/ship_detail/attr_4/title"] = "_control.content.content.ship_detail.attr_4.title",
			["equip_record/content/content/ship_detail/attr_3/attr_change_num"] = "_control.content.content.ship_detail.attr_3.attr_change_num",
			["equip_record/content/content/ship_detail/attr_1/frame"] = "_control.content.content.ship_detail.attr_1.frame",
			["equip_record/content/content/toggle_group/tog_three/title"] = "_control.content.content.toggle_group.tog_three.title",
			["equip_record/content/content/ship_detail/attr_3/attr_num"] = "_control.content.content.ship_detail.attr_3.attr_num",
			["equip_record/content/content/ship_detail/attr_6/attr_num"] = "_control.content.content.ship_detail.attr_6.attr_num",
			["equip_record/content/content/ship_detail/attr_10/frame"] = "_control.content.content.ship_detail.attr_10.frame",
			["equip_record/content/content/ship_detail/attr_3/title"] = "_control.content.content.ship_detail.attr_3.title",
			["equip_record/content/content/ship_detail/attr_1/title"] = "_control.content.content.ship_detail.attr_1.title",
			["equip_record/content/content/ship_detail/attr_2/attr_change_num"] = "_control.content.content.ship_detail.attr_2.attr_change_num",
			["equip_record/content/content/ship_detail/attr_2/frame"] = "_control.content.content.ship_detail.attr_2.frame",
			["equip_record/content/content/ship_detail/attr_2/attr_num"] = "_control.content.content.ship_detail.attr_2.attr_num",
			["equip_record/content/content/ship_detail/attr_2/attr_bg"] = "_control.content.content.ship_detail.attr_2.attr_bg",
			["equip_record/content/content/equips/equip_2/equipment/equip_icon"] = "_control.content.content.equips.equip_2.equipment.equip_icon",
			["equip_record/content/content/ship_detail/attr_10/attr_num"] = "_control.content.content.ship_detail.attr_10.attr_num",
			["equip_record/content/content/equips/equip_4/name_mask"] = "_control.content.content.equips.equip_4.name_mask",
			["equip_record/content/content/ship_detail/attr_1"] = "_control.content.content.ship_detail.attr_1",
			["equip_record/content/content/ship_detail"] = "_control.content.content.ship_detail",
			["equip_record/content/content/ship_detail/attr_2/title"] = "_control.content.content.ship_detail.attr_2.title",
			["equip_record/content/content/equips/equip_4/equipment/equip_icon"] = "_control.content.content.equips.equip_4.equipment.equip_icon",
			["equip_record/content/content/toggle_group/tog_one/title"] = "_control.content.content.toggle_group.tog_one.title",
			["equip_record/content/content/toggle_group/tog_four"] = "_control.content.content.toggle_group.tog_four",
			["equip_record/content/content/ship_detail/attr_3/attr_bg"] = "_control.content.content.ship_detail.attr_3.attr_bg",
			["equip_record/content/content/equips/equip_1"] = "_control.content.content.equips.equip_1",
			["equip_record/content/content/ship_detail/attr_1/attr_num"] = "_control.content.content.ship_detail.attr_1.attr_num",
			["equip_record/content/content/ship_detail/attr_3/frame"] = "_control.content.content.ship_detail.attr_3.frame",
			["equip_record/content/content/record_btn"] = "_control.content.content.record_btn",
			["equip_record/content/content/ship_detail/attr_2"] = "_control.content.content.ship_detail.attr_2",
			["equip_record/content/content/toggle_group/tog_two/title"] = "_control.content.content.toggle_group.tog_two.title",
			["equip_record/content/content/toggle_group/tog_three"] = "_control.content.content.toggle_group.tog_three",
			["equip_record/content/content/equips/equip_3/equipment"] = "_control.content.content.equips.equip_3.equipment",
			["equip_record/content/content/toggle_group/tog_one/Background/Checkmark"] = "_control.content.content.toggle_group.tog_one.Background.Checkmark",
			["equip_record/content/content/ship_detail/attr_5/attr_num"] = "_control.content.content.ship_detail.attr_5.attr_num",
			["equip_record/content/content/equips/equip_2/name_mask/equipname"] = "_control.content.content.equips.equip_2.name_mask.equipname",
			["equip_record/content/content/ship_detail/attr_4/frame"] = "_control.content.content.ship_detail.attr_4.frame",
			["equip_record/content/content/equips/equip_1/equipment"] = "_control.content.content.equips.equip_1.equipment",
			["equip_record/content/content/equips/equip_1/equipment/equip_rarity"] = "_control.content.content.equips.equip_1.equipment.equip_rarity",
			["equip_record/content/content/equips/equip_2"] = "_control.content.content.equips.equip_2",
			["equip_record/content/content/equips/equip_1/back_shadow"] = "_control.content.content.equips.equip_1.back_shadow",
			["equip_record/content/content/equips/equip_4/add_equip"] = "_control.content.content.equips.equip_4.add_equip",
			["equip_record/content/content/equips/equip_1/add_equip"] = "_control.content.content.equips.equip_1.add_equip",
			["equip_record/bg_container/ship_hint_txt"] = "_control.bg_container.ship_hint_txt",
			["equip_record/content/content/equips/equip_2/back_shadow"] = "_control.content.content.equips.equip_2.back_shadow",
			["equip_record/content/content/equips/equip_3"] = "_control.content.content.equips.equip_3",
			["equip_record/bg_container/line_up"] = "_control.bg_container.line_up",
			["equip_record/content/content/ship_detail/attr_6/attr_bg"] = "_control.content.content.ship_detail.attr_6.attr_bg",
			["equip_record/content/content/equips/equip_2/equipment"] = "_control.content.content.equips.equip_2.equipment",
			["equip_record/content/content/equips/equip_2/equipment/equip_rarity"] = "_control.content.content.equips.equip_2.equipment.equip_rarity",
			["equip_record/content/content/equips/equip_1/name_mask/equipname"] = "_control.content.content.equips.equip_1.name_mask.equipname",
			["equip_record/content/content/equips/equip_2/name_mask"] = "_control.content.content.equips.equip_2.name_mask",
			["equip_record/content/content/equips/equip_2/name_mask/equipname_2"] = "_control.content.content.equips.equip_2.name_mask.equipname_2",
			["equip_record/content/content/equips/equip_3/back_shadow"] = "_control.content.content.equips.equip_3.back_shadow",
			["equip_record/content/content/equips/equip_3/add_equip"] = "_control.content.content.equips.equip_3.add_equip",
			["equip_record/content/content/ship_detail/attr_3"] = "_control.content.content.ship_detail.attr_3",
			["equip_record/content/content/toggle_group/tog_two/Background"] = "_control.content.content.toggle_group.tog_two.Background",
			["equip_record/content/content/equips/equip_3/equipment/equip_rarity"] = "_control.content.content.equips.equip_3.equipment.equip_rarity",
			["equip_record/content/content/equips/equip_1/equipment/equip_icon"] = "_control.content.content.equips.equip_1.equipment.equip_icon",
			["equip_record/content/content/equips/equip_3/equipment/equip_icon"] = "_control.content.content.equips.equip_3.equipment.equip_icon",
			["equip_record/content/content/equips/equip_3/name_mask"] = "_control.content.content.equips.equip_3.name_mask",
			["equip_record/content/content/equips/equip_3/name_mask/equipname"] = "_control.content.content.equips.equip_3.name_mask.equipname",
			["equip_record/content/content/equips/equip_4/back_shadow"] = "_control.content.content.equips.equip_4.back_shadow",
			["equip_record/content/content/equips/equip_3/name_mask/equipname_2"] = "_control.content.content.equips.equip_3.name_mask.equipname_2",
			["equip_record/content/content/ship_detail/attr_9/attr_change_num"] = "_control.content.content.ship_detail.attr_9.attr_change_num",
			["equip_record/content/content/toggle_group/tog_four/Background"] = "_control.content.content.toggle_group.tog_four.Background",
			["equip_record/content/content/ship_detail/attr_11/title"] = "_control.content.content.ship_detail.attr_11.title",
			["equip_record/content/content/ship_detail/attr_9/attr_bg"] = "_control.content.content.ship_detail.attr_9.attr_bg",
			["equip_record/content/content/ship_detail/attr_11/attr_bg"] = "_control.content.content.ship_detail.attr_11.attr_bg",
			["equip_record/content/content/ship_detail/attr_11/attr_num"] = "_control.content.content.ship_detail.attr_11.attr_num",
			["equip_record/content/content/ship_detail/attr_11/frame"] = "_control.content.content.ship_detail.attr_11.frame",
			["equip_record/content/content/ship_detail/attr_11/attr_change_num"] = "_control.content.content.ship_detail.attr_11.attr_change_num",
			["equip_record/content/content/ship_detail/attr_12"] = "_control.content.content.ship_detail.attr_12",
			["equip_record/content/content/ship_detail/attr_12/title"] = "_control.content.content.ship_detail.attr_12.title",
			["equip_record/content/content/ship_detail/attr_12/attr_bg"] = "_control.content.content.ship_detail.attr_12.attr_bg",
			["equip_record/content/content/ship_detail/attr_12/attr_num"] = "_control.content.content.ship_detail.attr_12.attr_num",
			["equip_record/content/content/ship_detail/attr_12/frame"] = "_control.content.content.ship_detail.attr_12.frame",
			["equip_record/content/content/ship_detail/attr_12/attr_change_num"] = "_control.content.content.ship_detail.attr_12.attr_change_num",
			["equip_record/content/content/toggle_group/tog_two/Background/Checkmark"] = "_control.content.content.toggle_group.tog_two.Background.Checkmark",
			["equip_record/content/content/ship_detail/attr_7/attr_bg"] = "_control.content.content.ship_detail.attr_7.attr_bg",
			["equip_record/content/ship_layer"] = "_control.content.ship_layer",
			["equip_record/content/content/equips/equip_4/name_mask/equipname_2"] = "_control.content.content.equips.equip_4.name_mask.equipname_2",
			["equip_record/content"] = "_control.content",
			["equip_record/content/content"] = "_control.content.content",
			["equip_record/content/content/ship_detail/attr_6"] = "_control.content.content.ship_detail.attr_6",
			["equip_record/content/content/toggle_group/tog_one/Background"] = "_control.content.content.toggle_group.tog_one.Background",
			["equip_record/bg"] = "_control.bg",
			["equip_record/content/content/ship_detail/line_down"] = "_control.content.content.ship_detail.line_down",
			["equip_record/content/content/ship_detail/attr_5"] = "_control.content.content.ship_detail.attr_5",
			["equip_record/bg_container/close_btn"] = "_control.bg_container.close_btn",
			["equip_record/content/content/record_btn/title"] = "_control.content.content.record_btn.title",
			["equip_record/content/content/toggle_group/tog_one"] = "_control.content.content.toggle_group.tog_one",
			["equip_record/content/content/ship_detail/attr_10"] = "_control.content.content.ship_detail.attr_10",
			["equip_record/content/content/use_btn/title"] = "_control.content.content.use_btn.title",
			["equip_record/content/content/toggle_group/tog_three/Background/Checkmark"] = "_control.content.content.toggle_group.tog_three.Background.Checkmark",
			["equip_record/content/content/toggle_group"] = "_control.content.content.toggle_group",
			["equip_record/content/content/toggle_group/tog_four/title"] = "_control.content.content.toggle_group.tog_four.title",
			["equip_record/content/content/ship_detail/line_up"] = "_control.content.content.ship_detail.line_up",
			["equip_record/content/content/ship_detail/attr_11"] = "_control.content.content.ship_detail.attr_11",
			["equip_record/content/content/equips/equip_1/name_mask"] = "_control.content.content.equips.equip_1.name_mask",
			["equip_record/content/content/ship_detail/attr_4"] = "_control.content.content.ship_detail.attr_4",
			["equip_record/content/content/equips"] = "_control.content.content.equips",
			["equip_record/content/content/equips/equip_4/equipment/equip_rarity"] = "_control.content.content.equips.equip_4.equipment.equip_rarity",
			["equip_record/bg_container/line_down"] = "_control.bg_container.line_down",
			["equip_record/content/content/ship_detail/attr_9/frame"] = "_control.content.content.ship_detail.attr_9.frame",
			["equip_record/content/content/toggle_group/tog_four/Background/Checkmark"] = "_control.content.content.toggle_group.tog_four.Background.Checkmark",
			["equip_record/content/content/equips/equip_4/equipment"] = "_control.content.content.equips.equip_4.equipment",
			["equip_record/content/content/bg"] = "_control.content.content.bg",
			["equip_record/content/content/ship_detail/attr_5/attr_change_num"] = "_control.content.content.ship_detail.attr_5.attr_change_num",
			["equip_record/content/content/ship_detail/attr_10/attr_change_num"] = "_control.content.content.ship_detail.attr_10.attr_change_num",
			["equip_record/bg_container/title"] = "_control.bg_container.title",
			["equip_record/content/content/ship_detail/attr_9"] = "_control.content.content.ship_detail.attr_9",
			["equip_record/content/content/ship_detail/attr_10/title"] = "_control.content.content.ship_detail.attr_10.title",
			["equip_record/bg_container"] = "_control.bg_container",
			["equip_record/content/content/ship_detail/attr_10/attr_bg"] = "_control.content.content.ship_detail.attr_10.attr_bg",
			["equip_record/content/content/equips/equip_4"] = "_control.content.content.equips.equip_4",
			["equip_record/content/content/toggle_group/tog_three/Background"] = "_control.content.content.toggle_group.tog_three.Background"
		},
		click = {
			["content/content/record_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/content/use_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bg_container/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["content/content/toggle_group/tog_one"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/content/toggle_group/tog_two"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/content/toggle_group/tog_three"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/content/toggle_group/tog_four"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

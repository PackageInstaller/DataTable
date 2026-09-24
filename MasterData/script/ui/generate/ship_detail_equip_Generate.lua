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
			left_btn_group = {
				path = "left_btn_group",
				list = {
					equip_btn = {
						path = "left_btn_group/equip_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					achieve_btn = {
						path = "left_btn_group/achieve_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					lock_toggle = {
						path = "left_btn_group/lock_toggle",
						list = {
							Background = {
								path = "left_btn_group/lock_toggle/Background",
								list = {
									Checkmark = {
										path = "left_btn_group/lock_toggle/Background/Checkmark",
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
						path = "left_btn_group/leader_toggle",
						list = {
							Background = {
								path = "left_btn_group/leader_toggle/Background",
								list = {
									Checkmark = {
										path = "left_btn_group/leader_toggle/Background/Checkmark",
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
						path = "left_btn_group/view_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					return_btn = {
						path = "left_btn_group/return_btn",
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
					equip_bg = {
						path = "ship_info/equip_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					attr_bg = {
						path = "ship_info/attr_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title_bg = {
						path = "ship_info/title_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					ship_equip = {
						path = "ship_info/ship_equip",
						list = {
							id_bg = {
								path = "ship_info/ship_equip/id_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_id = {
								path = "ship_info/ship_equip/ship_id",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_name = {
								path = "ship_info/ship_equip/ship_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_class = {
								path = "ship_info/ship_equip/ship_class",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
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
									shadow_bg = {
										path = "ship_info/ship_equip/equip_1/shadow_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
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
											lock_icon = {
												path = "ship_info/ship_equip/equip_1/equipment/lock_icon",
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
											flight_num = {
												path = "ship_info/ship_equip/equip_1/equipment/flight_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
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
											},
											attr_1 = {
												path = "ship_info/ship_equip/equip_1/equipment/attr_1",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_1/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_1/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_1/attr_num",
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
												path = "ship_info/ship_equip/equip_1/equipment/attr_2",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_2/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_2/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_2/attr_num",
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
												path = "ship_info/ship_equip/equip_1/equipment/attr_3",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_3/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_3/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_1/equipment/attr_3/attr_num",
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
											list_icon = {
												path = "ship_info/ship_equip/equip_1/equipment/list_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_btn = {
												path = "ship_info/ship_equip/equip_1/equipment/attr_btn",
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
									shadow_bg = {
										path = "ship_info/ship_equip/equip_2/shadow_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
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
											lock_icon = {
												path = "ship_info/ship_equip/equip_2/equipment/lock_icon",
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
											flight_num = {
												path = "ship_info/ship_equip/equip_2/equipment/flight_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
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
											},
											attr_1 = {
												path = "ship_info/ship_equip/equip_2/equipment/attr_1",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_1/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_1/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_1/attr_num",
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
												path = "ship_info/ship_equip/equip_2/equipment/attr_2",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_2/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_2/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_2/attr_num",
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
												path = "ship_info/ship_equip/equip_2/equipment/attr_3",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_3/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_3/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_2/equipment/attr_3/attr_num",
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
											list_icon = {
												path = "ship_info/ship_equip/equip_2/equipment/list_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_btn = {
												path = "ship_info/ship_equip/equip_2/equipment/attr_btn",
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
									shadow_bg = {
										path = "ship_info/ship_equip/equip_3/shadow_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
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
											lock_icon = {
												path = "ship_info/ship_equip/equip_3/equipment/lock_icon",
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
											flight_num = {
												path = "ship_info/ship_equip/equip_3/equipment/flight_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
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
											},
											attr_1 = {
												path = "ship_info/ship_equip/equip_3/equipment/attr_1",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_1/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_1/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_1/attr_num",
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
												path = "ship_info/ship_equip/equip_3/equipment/attr_2",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_2/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_2/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_2/attr_num",
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
												path = "ship_info/ship_equip/equip_3/equipment/attr_3",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_3/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_3/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_3/equipment/attr_3/attr_num",
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
											list_icon = {
												path = "ship_info/ship_equip/equip_3/equipment/list_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_btn = {
												path = "ship_info/ship_equip/equip_3/equipment/attr_btn",
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
									shadow_bg = {
										path = "ship_info/ship_equip/equip_4/shadow_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
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
											lock_icon = {
												path = "ship_info/ship_equip/equip_4/equipment/lock_icon",
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
											flight_num = {
												path = "ship_info/ship_equip/equip_4/equipment/flight_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
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
											},
											attr_1 = {
												path = "ship_info/ship_equip/equip_4/equipment/attr_1",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_1/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_1/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_1/attr_num",
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
												path = "ship_info/ship_equip/equip_4/equipment/attr_2",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_2/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_2/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_2/attr_num",
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
												path = "ship_info/ship_equip/equip_4/equipment/attr_3",
												list = {
													attr_name = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_3/attr_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													symbol = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_3/symbol",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_num = {
														path = "ship_info/ship_equip/equip_4/equipment/attr_3/attr_num",
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
											list_icon = {
												path = "ship_info/ship_equip/equip_4/equipment/list_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											attr_btn = {
												path = "ship_info/ship_equip/equip_4/equipment/attr_btn",
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
					},
					detail_info = {
						path = "ship_info/detail_info",
						list = {
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
			["left_btn_group/equip_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_btn_group/achieve_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_btn_group/view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_btn_group/return_btn"] = {
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
			["ship_info/ship_equip/equip_1/equipment/attr_btn"] = {
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
			["ship_info/ship_equip/equip_2/equipment/attr_btn"] = {
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
			["ship_info/ship_equip/equip_3/equipment/attr_btn"] = {
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
			["ship_info/ship_equip/equip_4/equipment/attr_btn"] = {
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
			["left_btn_group/lock_toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_btn_group/leader_toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

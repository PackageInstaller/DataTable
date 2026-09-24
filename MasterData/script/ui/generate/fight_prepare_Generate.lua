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
					top_title_text = {
						path = "top_widget/top_title_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					top_title_line = {
						path = "top_widget/top_title_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top_widget_mask = {
						path = "top_widget/top_widget_mask",
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
			bottom_widget = {
				path = "bottom_widget",
				list = {
					bottom_line = {
						path = "bottom_widget/bottom_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					start_fight_btn = {
						path = "bottom_widget/start_fight_btn",
						list = {
							text = {
								path = "bottom_widget/start_fight_btn/text",
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
			},
			left_widget = {
				path = "left_widget",
				list = {
					team_toggle = {
						path = "left_widget/team_toggle",
						list = {
							line1 = {
								path = "left_widget/team_toggle/line1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line2 = {
								path = "left_widget/team_toggle/line2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line3 = {
								path = "left_widget/team_toggle/line3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line4 = {
								path = "left_widget/team_toggle/line4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							toggle1 = {
								path = "left_widget/team_toggle/toggle1",
								list = {
									bg = {
										path = "left_widget/team_toggle/toggle1/bg",
										list = {
											checkmark = {
												path = "left_widget/team_toggle/toggle1/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "left_widget/team_toggle/toggle1/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							},
							toggle2 = {
								path = "left_widget/team_toggle/toggle2",
								list = {
									bg = {
										path = "left_widget/team_toggle/toggle2/bg",
										list = {
											checkmark = {
												path = "left_widget/team_toggle/toggle2/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "left_widget/team_toggle/toggle2/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							},
							toggle3 = {
								path = "left_widget/team_toggle/toggle3",
								list = {
									bg = {
										path = "left_widget/team_toggle/toggle3/bg",
										list = {
											checkmark = {
												path = "left_widget/team_toggle/toggle3/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "left_widget/team_toggle/toggle3/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							},
							toggle4 = {
								path = "left_widget/team_toggle/toggle4",
								list = {
									bg = {
										path = "left_widget/team_toggle/toggle4/bg",
										list = {
											checkmark = {
												path = "left_widget/team_toggle/toggle4/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "left_widget/team_toggle/toggle4/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							},
							locks = {
								path = "left_widget/team_toggle/locks",
								list = {
									lock_1 = {
										path = "left_widget/team_toggle/locks/lock_1",
										list = {
											lock = {
												path = "left_widget/team_toggle/locks/lock_1/lock",
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
									lock_2 = {
										path = "left_widget/team_toggle/locks/lock_2",
										list = {
											lock = {
												path = "left_widget/team_toggle/locks/lock_2/lock",
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
									lock_3 = {
										path = "left_widget/team_toggle/locks/lock_3",
										list = {
											lock = {
												path = "left_widget/team_toggle/locks/lock_3/lock",
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
									lock_4 = {
										path = "left_widget/team_toggle/locks/lock_4",
										list = {
											lock = {
												path = "left_widget/team_toggle/locks/lock_4/lock",
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
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					},
					rankable_layout_group = {
						path = "left_widget/rankable_layout_group",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"RankableLayoutGroup"
						}
					},
					func_toggle = {
						path = "left_widget/func_toggle",
						list = {
							head = {
								path = "left_widget/func_toggle/head",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line1 = {
								path = "left_widget/func_toggle/line1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line2 = {
								path = "left_widget/func_toggle/line2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line3 = {
								path = "left_widget/func_toggle/line3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line4 = {
								path = "left_widget/func_toggle/line4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							toggle1 = {
								path = "left_widget/func_toggle/toggle1",
								list = {
									bg = {
										path = "left_widget/func_toggle/toggle1/bg",
										list = {
											checkmark = {
												path = "left_widget/func_toggle/toggle1/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Outline"
												}
											},
											title = {
												path = "left_widget/func_toggle/toggle1/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							},
							toggle2 = {
								path = "left_widget/func_toggle/toggle2",
								list = {
									bg = {
										path = "left_widget/func_toggle/toggle2/bg",
										list = {
											checkmark = {
												path = "left_widget/func_toggle/toggle2/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Outline"
												}
											},
											title = {
												path = "left_widget/func_toggle/toggle2/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							},
							toggle3 = {
								path = "left_widget/func_toggle/toggle3",
								list = {
									bg = {
										path = "left_widget/func_toggle/toggle3/bg",
										list = {
											checkmark = {
												path = "left_widget/func_toggle/toggle3/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Outline"
												}
											},
											title = {
												path = "left_widget/func_toggle/toggle3/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							},
							toggle4 = {
								path = "left_widget/func_toggle/toggle4",
								list = {
									bg = {
										path = "left_widget/func_toggle/toggle4/bg",
										list = {
											checkmark = {
												path = "left_widget/func_toggle/toggle4/bg/checkmark",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Outline"
												}
											},
											title = {
												path = "left_widget/func_toggle/toggle4/bg/title",
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
									"UnityEngine.UI.Toggle"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					},
					sixth_title = {
						path = "left_widget/sixth_title",
						list = {
							leftline = {
								path = "left_widget/sixth_title/leftline",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							sixth_team_img = {
								path = "left_widget/sixth_title/sixth_team_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							rightline = {
								path = "left_widget/sixth_title/rightline",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							team_name = {
								path = "left_widget/sixth_title/team_name",
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
					tower_cost = {
						path = "left_widget/tower_cost",
						list = {
							cost_bg = {
								path = "left_widget/tower_cost/cost_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_image = {
								path = "left_widget/tower_cost/title_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							cost_text = {
								path = "left_widget/tower_cost/cost_text",
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
					abyss_floor = {
						path = "left_widget/abyss_floor",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					abyss_btn = {
						path = "left_widget/abyss_btn",
						list = {
							leftline = {
								path = "left_widget/abyss_btn/leftline",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							rightline = {
								path = "left_widget/abyss_btn/rightline",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							owner_team_tog = {
								path = "left_widget/abyss_btn/owner_team_tog",
								list = {
									bg = {
										path = "left_widget/abyss_btn/owner_team_tog/bg",
										list = {
											checkmark = {
												path = "left_widget/abyss_btn/owner_team_tog/bg/checkmark",
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
										path = "left_widget/abyss_btn/owner_team_tog/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									sixth_team_img = {
										path = "left_widget/abyss_btn/owner_team_tog/sixth_team_img",
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
									"UnityEngine.UI.Toggle"
								}
							},
							deep_sea_team_tog = {
								path = "left_widget/abyss_btn/deep_sea_team_tog",
								list = {
									bg = {
										path = "left_widget/abyss_btn/deep_sea_team_tog/bg",
										list = {
											checkmark = {
												path = "left_widget/abyss_btn/deep_sea_team_tog/bg/checkmark",
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
										path = "left_widget/abyss_btn/deep_sea_team_tog/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									sixth_team_img = {
										path = "left_widget/abyss_btn/deep_sea_team_tog/sixth_team_img",
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
									"UnityEngine.UI.Toggle"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					},
					nf_info = {
						path = "left_widget/nf_info",
						list = {
							fire_info = {
								path = "left_widget/nf_info/fire_info",
								list = {
									fire = {
										path = "left_widget/nf_info/fire_info/fire",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fire_num = {
										path = "left_widget/nf_info/fire_info/fire_num",
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
							torpedo_info = {
								path = "left_widget/nf_info/torpedo_info",
								list = {
									torp = {
										path = "left_widget/nf_info/torpedo_info/torp",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fire_num = {
										path = "left_widget/nf_info/torpedo_info/fire_num",
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
							crit_info = {
								path = "left_widget/nf_info/crit_info",
								list = {
									crit = {
										path = "left_widget/nf_info/crit_info/crit",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fire_num = {
										path = "left_widget/nf_info/crit_info/fire_num",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {}
							},
							atk_info = {
								path = "left_widget/nf_info/atk_info",
								list = {
									atk = {
										path = "left_widget/nf_info/atk_info/atk",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fire_num = {
										path = "left_widget/nf_info/atk_info/fire_num",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {}
							},
							air_info = {
								path = "left_widget/nf_info/air_info",
								list = {
									air = {
										path = "left_widget/nf_info/air_info/air",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fire_num = {
										path = "left_widget/nf_info/air_info/fire_num",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {}
							},
							spotting_info = {
								path = "left_widget/nf_info/spotting_info",
								list = {
									spotting = {
										path = "left_widget/nf_info/spotting_info/spotting",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fire_num = {
										path = "left_widget/nf_info/spotting_info/fire_num",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {}
							},
							counterair_info = {
								path = "left_widget/nf_info/counterair_info",
								list = {
									counterair = {
										path = "left_widget/nf_info/counterair_info/counterair",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fire_num = {
										path = "left_widget/nf_info/counterair_info/fire_num",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {}
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
			abyss_floor = {
				path = "left_widget/abyss_floor/abyss_floor",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			right_widget = {
				path = "right_widget",
				list = {
					bg_back = {
						path = "right_widget/bg_back",
						list = {
							condition_panel = {
								path = "right_widget/bg_back/condition_panel",
								list = {
									title = {
										path = "right_widget/bg_back/condition_panel/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									first_ship_condition = {
										path = "right_widget/bg_back/condition_panel/first_ship_condition",
										list = {
											title = {
												path = "right_widget/bg_back/condition_panel/first_ship_condition/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											condition_txt = {
												path = "right_widget/bg_back/condition_panel/first_ship_condition/condition_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ok_icon = {
												path = "right_widget/bg_back/condition_panel/first_ship_condition/ok_icon",
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
									ship_num_condition = {
										path = "right_widget/bg_back/condition_panel/ship_num_condition",
										list = {
											title = {
												path = "right_widget/bg_back/condition_panel/ship_num_condition/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											condition_txt = {
												path = "right_widget/bg_back/condition_panel/ship_num_condition/condition_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ok_icon = {
												path = "right_widget/bg_back/condition_panel/ship_num_condition/ok_icon",
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
									ship_type_condition1 = {
										path = "right_widget/bg_back/condition_panel/ship_type_condition1",
										list = {
											title = {
												path = "right_widget/bg_back/condition_panel/ship_type_condition1/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											condition_txt = {
												path = "right_widget/bg_back/condition_panel/ship_type_condition1/condition_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ok_icon = {
												path = "right_widget/bg_back/condition_panel/ship_type_condition1/ok_icon",
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
									ship_type_condition2 = {
										path = "right_widget/bg_back/condition_panel/ship_type_condition2",
										list = {
											title = {
												path = "right_widget/bg_back/condition_panel/ship_type_condition2/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											condition_txt = {
												path = "right_widget/bg_back/condition_panel/ship_type_condition2/condition_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ok_icon = {
												path = "right_widget/bg_back/condition_panel/ship_type_condition2/ok_icon",
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
									line = {
										path = "right_widget/bg_back/condition_panel/line",
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
							props_panel = {
								path = "right_widget/bg_back/props_panel",
								list = {
									title = {
										path = "right_widget/bg_back/props_panel/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									radar_chart_bg = {
										path = "right_widget/bg_back/props_panel/radar_chart_bg",
										list = {
											web_img = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/web_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											draw_web = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/draw_web",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Extensions.UIPolygon"
												}
											},
											prop1 = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/prop1",
												list = {
													title = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop1/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop1/num",
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
											prop2 = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/prop2",
												list = {
													title = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop2/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop2/num",
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
											prop3 = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/prop3",
												list = {
													title = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop3/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop3/num",
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
											prop4 = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/prop4",
												list = {
													title = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop4/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop4/num",
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
											prop5 = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/prop5",
												list = {
													title = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop5/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop5/num",
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
											prop6 = {
												path = "right_widget/bg_back/props_panel/radar_chart_bg/prop6",
												list = {
													title = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop6/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/props_panel/radar_chart_bg/prop6/num",
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
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									speed_info_panel = {
										path = "right_widget/bg_back/props_panel/speed_info_panel",
										list = {
											min_speed = {
												path = "right_widget/bg_back/props_panel/speed_info_panel/min_speed",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											max_speed = {
												path = "right_widget/bg_back/props_panel/speed_info_panel/max_speed",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											mean_speed = {
												path = "right_widget/bg_back/props_panel/speed_info_panel/mean_speed",
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
											"UnityEngine.UI.Mask",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup"
								}
							},
							supply_panel = {
								path = "right_widget/bg_back/supply_panel",
								list = {
									title = {
										path = "right_widget/bg_back/supply_panel/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									supply1 = {
										path = "right_widget/bg_back/supply_panel/supply1",
										list = {
											icon = {
												path = "right_widget/bg_back/supply_panel/supply1/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "right_widget/bg_back/supply_panel/supply1/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											count = {
												path = "right_widget/bg_back/supply_panel/supply1/count",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											slash = {
												path = "right_widget/bg_back/supply_panel/supply1/slash",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											total = {
												path = "right_widget/bg_back/supply_panel/supply1/total",
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
									supply2 = {
										path = "right_widget/bg_back/supply_panel/supply2",
										list = {
											icon = {
												path = "right_widget/bg_back/supply_panel/supply2/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "right_widget/bg_back/supply_panel/supply2/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											count = {
												path = "right_widget/bg_back/supply_panel/supply2/count",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											slash = {
												path = "right_widget/bg_back/supply_panel/supply2/slash",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											total = {
												path = "right_widget/bg_back/supply_panel/supply2/total",
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
									supply3 = {
										path = "right_widget/bg_back/supply_panel/supply3",
										list = {
											icon = {
												path = "right_widget/bg_back/supply_panel/supply3/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "right_widget/bg_back/supply_panel/supply3/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											count = {
												path = "right_widget/bg_back/supply_panel/supply3/count",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											slash = {
												path = "right_widget/bg_back/supply_panel/supply3/slash",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											total = {
												path = "right_widget/bg_back/supply_panel/supply3/total",
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
									supply_all_btn = {
										path = "right_widget/bg_back/supply_panel/supply_all_btn",
										list = {
											text = {
												path = "right_widget/bg_back/supply_panel/supply_all_btn/text",
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
									map_support = {
										path = "right_widget/bg_back/supply_panel/map_support",
										list = {
											icon_bg = {
												path = "right_widget/bg_back/supply_panel/map_support/icon_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											support_button = {
												path = "right_widget/bg_back/supply_panel/map_support/support_button",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											count_parent = {
												path = "right_widget/bg_back/supply_panel/map_support/count_parent",
												list = {
													icon_1 = {
														path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_1",
														list = {
															full_image = {
																path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image",
																list = {
																	full1 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full1",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full2 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full2",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full3 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full3",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full4 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full4",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full5 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full5",
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
																	"UnityEngine.UI.HorizontalLayoutGroup"
																}
															}
														},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon_2 = {
														path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_2",
														list = {
															full_image = {
																path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image",
																list = {
																	full1 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full1",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full2 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full2",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full3 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full3",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full4 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full4",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full5 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full5",
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
																	"UnityEngine.UI.HorizontalLayoutGroup"
																}
															}
														},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon_3 = {
														path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_3",
														list = {
															full_image = {
																path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image",
																list = {
																	full1 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full1",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full2 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full2",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full3 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full3",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full4 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full4",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	full5 = {
																		path = "right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full5",
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
																	"UnityEngine.UI.HorizontalLayoutGroup"
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
													"UnityEngine.UI.VerticalLayoutGroup"
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
									"UnityEngine.CanvasGroup"
								}
							},
							repair_panel = {
								path = "right_widget/bg_back/repair_panel",
								list = {
									title = {
										path = "right_widget/bg_back/repair_panel/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									repair1 = {
										path = "right_widget/bg_back/repair_panel/repair1",
										list = {
											icon = {
												path = "right_widget/bg_back/repair_panel/repair1/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "right_widget/bg_back/repair_panel/repair1/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											count = {
												path = "right_widget/bg_back/repair_panel/repair1/count",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											slash = {
												path = "right_widget/bg_back/repair_panel/repair1/slash",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											total = {
												path = "right_widget/bg_back/repair_panel/repair1/total",
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
									repair2 = {
										path = "right_widget/bg_back/repair_panel/repair2",
										list = {
											icon = {
												path = "right_widget/bg_back/repair_panel/repair2/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "right_widget/bg_back/repair_panel/repair2/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											count = {
												path = "right_widget/bg_back/repair_panel/repair2/count",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											slash = {
												path = "right_widget/bg_back/repair_panel/repair2/slash",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											total = {
												path = "right_widget/bg_back/repair_panel/repair2/total",
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
									repair_info = {
										path = "right_widget/bg_back/repair_panel/repair_info",
										list = {
											icon = {
												path = "right_widget/bg_back/repair_panel/repair_info/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											line = {
												path = "right_widget/bg_back/repair_panel/repair_info/line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											count = {
												path = "right_widget/bg_back/repair_panel/repair_info/count",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											slash = {
												path = "right_widget/bg_back/repair_panel/repair_info/slash",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											total = {
												path = "right_widget/bg_back/repair_panel/repair_info/total",
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
									repair_all_btn = {
										path = "right_widget/bg_back/repair_panel/repair_all_btn",
										list = {
											text = {
												path = "right_widget/bg_back/repair_panel/repair_all_btn/text",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup"
								}
							},
							campaign = {
								path = "right_widget/bg_back/campaign",
								list = {
									difficulty = {
										path = "right_widget/bg_back/campaign/difficulty",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									campaign_name = {
										path = "right_widget/bg_back/campaign/campaign_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									campaign_info_panel = {
										path = "right_widget/bg_back/campaign/campaign_info_panel",
										list = {
											Viewport = {
												path = "right_widget/bg_back/campaign/campaign_info_panel/Viewport",
												list = {
													content = {
														path = "right_widget/bg_back/campaign/campaign_info_panel/Viewport/content",
														list = {
															campaign_info = {
																path = "right_widget/bg_back/campaign/campaign_info_panel/Viewport/content/campaign_info",
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
															"UnityEngine.UI.ContentSizeFitter",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.VerticalLayoutGroup"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Mask"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.ScrollRect"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup"
								}
							},
							speed_skeleton_mask = {
								path = "right_widget/bg_back/speed_skeleton_mask",
								list = {
									speed_skeleton = {
										path = "right_widget/bg_back/speed_skeleton_mask/speed_skeleton",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"Spine.Unity.SkeletonGraphic"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask"
								}
							},
							sixth_panel = {
								path = "right_widget/bg_back/sixth_panel",
								list = {
									buff_text = {
										path = "right_widget/bg_back/sixth_panel/buff_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									all_ship = {
										path = "right_widget/bg_back/sixth_panel/all_ship",
										list = {
											Viewport = {
												path = "right_widget/bg_back/sixth_panel/all_ship/Viewport",
												list = {
													Scrollbar = {
														path = "right_widget/bg_back/sixth_panel/all_ship/Viewport/Scrollbar",
														list = {
															["Sliding Area"] = {
																path = "right_widget/bg_back/sixth_panel/all_ship/Viewport/Scrollbar/Sliding Area",
																list = {
																	Handle = {
																		path = "right_widget/bg_back/sixth_panel/all_ship/Viewport/Scrollbar/Sliding Area/Handle",
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
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Scrollbar"
														}
													},
													edge_mask = {
														path = "right_widget/bg_back/sixth_panel/all_ship/Viewport/edge_mask",
														list = {
															Content = {
																path = "right_widget/bg_back/sixth_panel/all_ship/Viewport/edge_mask/Content",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"EndlessScrollView",
																	"UnityEngine.CanvasRenderer"
																}
															}
														},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Mask"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Mask",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
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
							strike_info = {
								path = "right_widget/bg_back/strike_info",
								list = {
									toggle_info = {
										path = "right_widget/bg_back/strike_info/toggle_info",
										list = {
											bg = {
												path = "right_widget/bg_back/strike_info/toggle_info/bg",
												list = {
													checkmark = {
														path = "right_widget/bg_back/strike_info/toggle_info/bg/checkmark",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right_widget/bg_back/strike_info/toggle_info/bg/title",
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
											"UnityEngine.UI.Toggle"
										}
									},
									toggle_buff = {
										path = "right_widget/bg_back/strike_info/toggle_buff",
										list = {
											bg = {
												path = "right_widget/bg_back/strike_info/toggle_buff/bg",
												list = {
													checkmark = {
														path = "right_widget/bg_back/strike_info/toggle_buff/bg/checkmark",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right_widget/bg_back/strike_info/toggle_buff/bg/title",
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
											"UnityEngine.UI.Toggle"
										}
									},
									point = {
										path = "right_widget/bg_back/strike_info/point",
										list = {
											bg = {
												path = "right_widget/bg_back/strike_info/point/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											now_score_text = {
												path = "right_widget/bg_back/strike_info/point/now_score_text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											icon = {
												path = "right_widget/bg_back/strike_info/point/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point_num = {
												path = "right_widget/bg_back/strike_info/point/point_num",
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
									buffs = {
										path = "right_widget/bg_back/strike_info/buffs",
										list = {
											Viewport = {
												path = "right_widget/bg_back/strike_info/buffs/Viewport",
												list = {
													Scrollbar = {
														path = "right_widget/bg_back/strike_info/buffs/Viewport/Scrollbar",
														list = {
															["Sliding Area"] = {
																path = "right_widget/bg_back/strike_info/buffs/Viewport/Scrollbar/Sliding Area",
																list = {
																	Handle = {
																		path = "right_widget/bg_back/strike_info/buffs/Viewport/Scrollbar/Sliding Area/Handle",
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
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Scrollbar"
														}
													},
													edge_mask = {
														path = "right_widget/bg_back/strike_info/buffs/Viewport/edge_mask",
														list = {
															content = {
																path = "right_widget/bg_back/strike_info/buffs/Viewport/edge_mask/content",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"EndlessScrollView",
																	"UnityEngine.CanvasRenderer"
																}
															}
														},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Mask"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Mask",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									radar_chart_bg = {
										path = "right_widget/bg_back/strike_info/radar_chart_bg",
										list = {
											web_img = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/web_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											draw_web = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/draw_web",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Extensions.UIPolygon"
												}
											},
											prop1 = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/prop1",
												list = {
													title = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop1/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop1/num",
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
											prop2 = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/prop2",
												list = {
													title = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop2/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop2/num",
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
											prop3 = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/prop3",
												list = {
													title = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop3/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop3/num",
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
											prop4 = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/prop4",
												list = {
													title = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop4/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop4/num",
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
											prop5 = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/prop5",
												list = {
													title = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop5/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop5/num",
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
											prop6 = {
												path = "right_widget/bg_back/strike_info/radar_chart_bg/prop6",
												list = {
													title = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop6/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right_widget/bg_back/strike_info/radar_chart_bg/prop6/num",
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
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									speed_info_panel = {
										path = "right_widget/bg_back/strike_info/speed_info_panel",
										list = {
											min_speed = {
												path = "right_widget/bg_back/strike_info/speed_info_panel/min_speed",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											max_speed = {
												path = "right_widget/bg_back/strike_info/speed_info_panel/max_speed",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											mean_speed = {
												path = "right_widget/bg_back/strike_info/speed_info_panel/mean_speed",
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
											"UnityEngine.UI.Mask",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup",
									"UnityEngine.CanvasGroup"
								}
							},
							ninth_info = {
								path = "right_widget/bg_back/ninth_info",
								list = {
									ninth_toggle_info = {
										path = "right_widget/bg_back/ninth_info/ninth_toggle_info",
										list = {
											ninth_bg = {
												path = "right_widget/bg_back/ninth_info/ninth_toggle_info/ninth_bg",
												list = {
													ninth_checkmark = {
														path = "right_widget/bg_back/ninth_info/ninth_toggle_info/ninth_bg/ninth_checkmark",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_toggle_info/ninth_bg/ninth_title",
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
											"UnityEngine.UI.Toggle"
										}
									},
									ninth_toggle_buff = {
										path = "right_widget/bg_back/ninth_info/ninth_toggle_buff",
										list = {
											ninth_bg = {
												path = "right_widget/bg_back/ninth_info/ninth_toggle_buff/ninth_bg",
												list = {
													ninth_checkmark = {
														path = "right_widget/bg_back/ninth_info/ninth_toggle_buff/ninth_bg/ninth_checkmark",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_toggle_buff/ninth_bg/ninth_title",
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
											"UnityEngine.UI.Toggle"
										}
									},
									ninth_buffs = {
										path = "right_widget/bg_back/ninth_info/ninth_buffs",
										list = {
											ninth_Viewport = {
												path = "right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport",
												list = {
													ninth_Scrollbar = {
														path = "right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_Scrollbar",
														list = {
															["ninth_Sliding Area"] = {
																path = "right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_Scrollbar/ninth_Sliding Area",
																list = {
																	ninth_Handle = {
																		path = "right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_Scrollbar/ninth_Sliding Area/ninth_Handle",
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
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Scrollbar"
														}
													},
													ninth_edge_mask = {
														path = "right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_edge_mask",
														list = {
															ninth_content = {
																path = "right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_edge_mask/ninth_content",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"EndlessScrollView",
																	"UnityEngine.CanvasRenderer"
																}
															}
														},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Mask"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Mask",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ninth_radar_chart_bg = {
										path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg",
										list = {
											ninth_web_img = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_web_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ninth_draw_web = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_draw_web",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Extensions.UIPolygon"
												}
											},
											ninth_prop1 = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop1",
												list = {
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop1/ninth_title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ninth_num = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop1/ninth_num",
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
											ninth_prop2 = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop2",
												list = {
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop2/ninth_title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ninth_num = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop2/ninth_num",
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
											ninth_prop3 = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop3",
												list = {
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop3/ninth_title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ninth_num = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop3/ninth_num",
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
											ninth_prop4 = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop4",
												list = {
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop4/ninth_title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ninth_num = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop4/ninth_num",
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
											ninth_prop5 = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop5",
												list = {
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop5/ninth_title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ninth_num = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop5/ninth_num",
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
											ninth_prop6 = {
												path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop6",
												list = {
													ninth_title = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop6/ninth_title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ninth_num = {
														path = "right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop6/ninth_num",
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
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ninth_speed_info_panel = {
										path = "right_widget/bg_back/ninth_info/ninth_speed_info_panel",
										list = {
											ninth_min_speed = {
												path = "right_widget/bg_back/ninth_info/ninth_speed_info_panel/ninth_min_speed",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ninth_max_speed = {
												path = "right_widget/bg_back/ninth_info/ninth_speed_info_panel/ninth_max_speed",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ninth_mean_speed = {
												path = "right_widget/bg_back/ninth_info/ninth_speed_info_panel/ninth_mean_speed",
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
											"UnityEngine.UI.Mask",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup",
									"UnityEngine.CanvasGroup"
								}
							},
							tower_info = {
								path = "right_widget/bg_back/tower_info",
								list = {
									toggle_info = {
										path = "right_widget/bg_back/tower_info/toggle_info",
										list = {
											bg = {
												path = "right_widget/bg_back/tower_info/toggle_info/bg",
												list = {
													checkmark = {
														path = "right_widget/bg_back/tower_info/toggle_info/bg/checkmark",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right_widget/bg_back/tower_info/toggle_info/bg/title",
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
											"UnityEngine.UI.Toggle"
										}
									},
									toggle_layer = {
										path = "right_widget/bg_back/tower_info/toggle_layer",
										list = {
											bg = {
												path = "right_widget/bg_back/tower_info/toggle_layer/bg",
												list = {
													checkmark = {
														path = "right_widget/bg_back/tower_info/toggle_layer/bg/checkmark",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right_widget/bg_back/tower_info/toggle_layer/bg/title",
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
											"UnityEngine.UI.Toggle"
										}
									},
									layer_list = {
										path = "right_widget/bg_back/tower_info/layer_list",
										list = {
											Viewport = {
												path = "right_widget/bg_back/tower_info/layer_list/Viewport",
												list = {
													Scrollbar = {
														path = "right_widget/bg_back/tower_info/layer_list/Viewport/Scrollbar",
														list = {
															["Sliding Area"] = {
																path = "right_widget/bg_back/tower_info/layer_list/Viewport/Scrollbar/Sliding Area",
																list = {
																	Handle = {
																		path = "right_widget/bg_back/tower_info/layer_list/Viewport/Scrollbar/Sliding Area/Handle",
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
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Scrollbar"
														}
													},
													edge_mask = {
														path = "right_widget/bg_back/tower_info/layer_list/Viewport/edge_mask",
														list = {
															Content = {
																path = "right_widget/bg_back/tower_info/layer_list/Viewport/edge_mask/Content",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer"
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
													"UnityEngine.UI.Image",
													"UnityEngine.UI.RectMask2D"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									enemy_listscrollview = {
										path = "right_widget/bg_back/tower_info/enemy_listscrollview",
										list = {
											content = {
												path = "right_widget/bg_back/tower_info/enemy_listscrollview/content",
												list = {
													enemy_list = {
														path = "right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_list",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.UI.GridLayoutGroup",
															"UnityEngine.UI.ContentSizeFitter"
														}
													},
													enemy_info_des = {
														path = "right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des",
														list = {
															title_point = {
																path = "right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des/title_point",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															gray_line = {
																path = "right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des/gray_line",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															gray_line_top = {
																path = "right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des/gray_line_top",
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
															"ItemBase",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.ContentSizeFitter",
													"UnityEngine.UI.VerticalLayoutGroup"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Mask"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup"
								}
							},
							ocean_panel = {
								path = "right_widget/bg_back/ocean_panel",
								list = {
									buff_text = {
										path = "right_widget/bg_back/ocean_panel/buff_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									all_buff = {
										path = "right_widget/bg_back/ocean_panel/all_buff",
										list = {
											Viewport = {
												path = "right_widget/bg_back/ocean_panel/all_buff/Viewport",
												list = {
													Scrollbar = {
														path = "right_widget/bg_back/ocean_panel/all_buff/Viewport/Scrollbar",
														list = {
															["Sliding Area"] = {
																path = "right_widget/bg_back/ocean_panel/all_buff/Viewport/Scrollbar/Sliding Area",
																list = {
																	Handle = {
																		path = "right_widget/bg_back/ocean_panel/all_buff/Viewport/Scrollbar/Sliding Area/Handle",
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
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Scrollbar"
														}
													},
													edge_mask = {
														path = "right_widget/bg_back/ocean_panel/all_buff/Viewport/edge_mask",
														list = {
															Content = {
																path = "right_widget/bg_back/ocean_panel/all_buff/Viewport/edge_mask/Content",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"EndlessScrollView",
																	"UnityEngine.CanvasRenderer"
																}
															}
														},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Mask"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Mask",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
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
							abyss_hp_info = {
								path = "right_widget/bg_back/abyss_hp_info",
								list = {
									hp_layer_back = {
										path = "right_widget/bg_back/abyss_hp_info/hp_layer_back",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp_layer = {
										path = "right_widget/bg_back/abyss_hp_info/hp_layer",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									residue_des = {
										path = "right_widget/bg_back/abyss_hp_info/residue_des",
										list = {
											hp_num = {
												path = "right_widget/bg_back/abyss_hp_info/residue_des/hp_num",
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
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							abyss_panel = {
								path = "right_widget/bg_back/abyss_panel",
								list = {
									power_tog = {
										path = "right_widget/bg_back/abyss_panel/power_tog",
										list = {
											bg = {
												path = "right_widget/bg_back/abyss_panel/power_tog/bg",
												list = {
													checkmark = {
														path = "right_widget/bg_back/abyss_panel/power_tog/bg/checkmark",
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
												path = "right_widget/bg_back/abyss_panel/power_tog/title",
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
											"UnityEngine.UI.Toggle",
											"UnityEngine.CanvasGroup"
										}
									},
									buff_tog = {
										path = "right_widget/bg_back/abyss_panel/buff_tog",
										list = {
											bg = {
												path = "right_widget/bg_back/abyss_panel/buff_tog/bg",
												list = {
													checkmark = {
														path = "right_widget/bg_back/abyss_panel/buff_tog/bg/checkmark",
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
												path = "right_widget/bg_back/abyss_panel/buff_tog/title",
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
									scrollview = {
										path = "right_widget/bg_back/abyss_panel/scrollview",
										list = {
											viewport = {
												path = "right_widget/bg_back/abyss_panel/scrollview/viewport",
												list = {
													content = {
														path = "right_widget/bg_back/abyss_panel/scrollview/viewport/content",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.UI.VerticalLayoutGroup",
															"UnityEngine.UI.ContentSizeFitter"
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
											scrollbarvertical = {
												path = "right_widget/bg_back/abyss_panel/scrollview/scrollbarvertical",
												list = {
													slidingarea = {
														path = "right_widget/bg_back/abyss_panel/scrollview/scrollbarvertical/slidingarea",
														list = {
															handle = {
																path = "right_widget/bg_back/abyss_panel/scrollview/scrollbarvertical/slidingarea/handle",
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
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Scrollbar"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup",
									"UnityEngine.CanvasGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					damage_group_bg = {
						path = "right_widget/damage_group_bg",
						list = {
							title = {
								path = "right_widget/damage_group_bg/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							count = {
								path = "right_widget/damage_group_bg/count",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							add_btn = {
								path = "right_widget/damage_group_bg/add_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
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
			repair_btn = {
				path = "repair_btn",
				list = {
					repair_txt = {
						path = "repair_btn/repair_txt",
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
			buff_btn = {
				path = "buff_btn",
				list = {
					repair_txt = {
						path = "buff_btn/repair_txt",
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
			parent = {
				path = "parent",
				list = {
					collect_icon_bg = {
						path = "parent/collect_icon_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					support_icon_bg = {
						path = "parent/support_icon_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					tower_icon_bg = {
						path = "parent/tower_icon_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					pre_formation_bg = {
						path = "parent/pre_formation_bg",
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
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup"
				}
			},
			support_layer = {
				path = "support_layer",
				list = {
					support_bg = {
						path = "support_layer/support_bg",
						list = {
							card_bg = {
								path = "support_layer/support_bg/card_bg",
								list = {
									icon_btn = {
										path = "support_layer/support_bg/card_bg/icon_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							info_title_text = {
								path = "support_layer/support_bg/info_title_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							info_text = {
								path = "support_layer/support_bg/info_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							get_btn = {
								path = "support_layer/support_bg/get_btn",
								list = {
									get_text = {
										path = "support_layer/support_bg/get_btn/get_text",
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
							limit_count = {
								path = "support_layer/support_bg/limit_count",
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
					"UnityEngine.UI.Button",
					"UnityEngine.UI.Image"
				}
			},
			collect_layer = {
				path = "collect_layer",
				list = {
					collect_cell1 = {
						path = "collect_layer/collect_cell1",
						list = {
							bg = {
								path = "collect_layer/collect_cell1/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_bg = {
								path = "collect_layer/collect_cell1/icon_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "collect_layer/collect_cell1/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_bg = {
								path = "collect_layer/collect_cell1/line_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							name_scroller = {
								path = "collect_layer/collect_cell1/name_scroller",
								list = {
									collect_name = {
										path = "collect_layer/collect_cell1/name_scroller/collect_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									collect_name_two = {
										path = "collect_layer/collect_cell1/name_scroller/collect_name_two",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer"
								}
							},
							title_icon = {
								path = "collect_layer/collect_cell1/title_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_type = {
								path = "collect_layer/collect_cell1/ship_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							buff_tips_txt = {
								path = "collect_layer/collect_cell1/buff_tips_txt",
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
					collect_cell2 = {
						path = "collect_layer/collect_cell2",
						list = {
							bg = {
								path = "collect_layer/collect_cell2/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_bg = {
								path = "collect_layer/collect_cell2/icon_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "collect_layer/collect_cell2/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_bg = {
								path = "collect_layer/collect_cell2/line_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							name_scroller = {
								path = "collect_layer/collect_cell2/name_scroller",
								list = {
									collect_name = {
										path = "collect_layer/collect_cell2/name_scroller/collect_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									collect_name_two = {
										path = "collect_layer/collect_cell2/name_scroller/collect_name_two",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer"
								}
							},
							title_icon = {
								path = "collect_layer/collect_cell2/title_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_type = {
								path = "collect_layer/collect_cell2/ship_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							buff_tips_txt = {
								path = "collect_layer/collect_cell2/buff_tips_txt",
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
					collect_cell3 = {
						path = "collect_layer/collect_cell3",
						list = {
							bg = {
								path = "collect_layer/collect_cell3/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_bg = {
								path = "collect_layer/collect_cell3/icon_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "collect_layer/collect_cell3/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_bg = {
								path = "collect_layer/collect_cell3/line_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							name_scroller = {
								path = "collect_layer/collect_cell3/name_scroller",
								list = {
									collect_name = {
										path = "collect_layer/collect_cell3/name_scroller/collect_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									collect_name_two = {
										path = "collect_layer/collect_cell3/name_scroller/collect_name_two",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer"
								}
							},
							title_icon = {
								path = "collect_layer/collect_cell3/title_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_type = {
								path = "collect_layer/collect_cell3/ship_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							buff_tips_txt = {
								path = "collect_layer/collect_cell3/buff_tips_txt",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			auto_supply_btn = {
				path = "auto_supply_btn",
				list = {
					toggle_img = {
						path = "auto_supply_btn/toggle_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					toggle_text = {
						path = "auto_supply_btn/toggle_text",
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
			supply_type_btn = {
				path = "supply_type_btn",
				list = {
					toggle_img = {
						path = "supply_type_btn/toggle_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					toggle_text = {
						path = "supply_type_btn/toggle_text",
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
			tower_buff = {
				path = "tower_buff",
				list = {
					buff_parent = {
						path = "tower_buff/buff_parent",
						list = {
							single_buff_cell1 = {
								path = "tower_buff/buff_parent/single_buff_cell1",
								list = {
									single_bg = {
										path = "tower_buff/buff_parent/single_buff_cell1/single_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_name = {
										path = "tower_buff/buff_parent/single_buff_cell1/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_info = {
										path = "tower_buff/buff_parent/single_buff_cell1/buff_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_icon = {
										path = "tower_buff/buff_parent/single_buff_cell1/buff_icon",
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
							single_buff_cell2 = {
								path = "tower_buff/buff_parent/single_buff_cell2",
								list = {
									single_bg = {
										path = "tower_buff/buff_parent/single_buff_cell2/single_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_name = {
										path = "tower_buff/buff_parent/single_buff_cell2/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_info = {
										path = "tower_buff/buff_parent/single_buff_cell2/buff_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_icon = {
										path = "tower_buff/buff_parent/single_buff_cell2/buff_icon",
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
							single_buff_cell3 = {
								path = "tower_buff/buff_parent/single_buff_cell3",
								list = {
									single_bg = {
										path = "tower_buff/buff_parent/single_buff_cell3/single_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_name = {
										path = "tower_buff/buff_parent/single_buff_cell3/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_info = {
										path = "tower_buff/buff_parent/single_buff_cell3/buff_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_icon = {
										path = "tower_buff/buff_parent/single_buff_cell3/buff_icon",
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
							single_buff_cell4 = {
								path = "tower_buff/buff_parent/single_buff_cell4",
								list = {
									single_bg = {
										path = "tower_buff/buff_parent/single_buff_cell4/single_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_name = {
										path = "tower_buff/buff_parent/single_buff_cell4/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_info = {
										path = "tower_buff/buff_parent/single_buff_cell4/buff_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_icon = {
										path = "tower_buff/buff_parent/single_buff_cell4/buff_icon",
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
							single_buff_cell5 = {
								path = "tower_buff/buff_parent/single_buff_cell5",
								list = {
									single_bg = {
										path = "tower_buff/buff_parent/single_buff_cell5/single_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_name = {
										path = "tower_buff/buff_parent/single_buff_cell5/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_info = {
										path = "tower_buff/buff_parent/single_buff_cell5/buff_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_icon = {
										path = "tower_buff/buff_parent/single_buff_cell5/buff_icon",
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
							"UnityEngine.UI.VerticalLayoutGroup",
							"UnityEngine.UI.ContentSizeFitter"
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
			input_map_node = {
				path = "input_map_node",
				list = {
					placeholder = {
						path = "input_map_node/placeholder",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					text = {
						path = "input_map_node/text",
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
					"UnityEngine.UI.InputField"
				}
			},
			ocean_cia_buff_info_bg = {
				path = "ocean_cia_buff_info_bg",
				list = {
					single_ocean_cia = {
						path = "ocean_cia_buff_info_bg/single_ocean_cia",
						list = {
							bg = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_line = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/bg_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_bg = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/icon_bg",
								list = {
									icon = {
										path = "ocean_cia_buff_info_bg/single_ocean_cia/icon_bg/icon",
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
							desc_text = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/desc_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							limit_text = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/limit_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							title = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/title",
								list = {
									title_text = {
										path = "ocean_cia_buff_info_bg/single_ocean_cia/title/title_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									title_text_2 = {
										path = "ocean_cia_buff_info_bg/single_ocean_cia/title/title_text_2",
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
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Mask",
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							silk_bg = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/silk_bg",
								list = {
									silk_text = {
										path = "ocean_cia_buff_info_bg/single_ocean_cia/silk_bg/silk_text",
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
							top_line = {
								path = "ocean_cia_buff_info_bg/single_ocean_cia/top_line",
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
							"ItemBase",
							"UnityEngine.Canvas"
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
			cover = {
				path = "cover",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			strike_buff = {
				path = "strike_buff",
				list = {
					weather_close_btn = {
						path = "strike_buff/weather_close_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					weather_info = {
						path = "strike_buff/weather_info",
						list = {
							weather_name = {
								path = "strike_buff/weather_info/weather_name",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							weather_content = {
								path = "strike_buff/weather_info/weather_content",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							time_txt = {
								path = "strike_buff/weather_info/time_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							time_txt_2 = {
								path = "strike_buff/weather_info/time_txt_2",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
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
			["fight_prepare/left_widget/func_toggle/toggle3/bg"] = "_control.left_widget.func_toggle.toggle3.bg",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_info/bg"] = "_control.right_widget.bg_back.strike_info.toggle_info.bg",
			["fight_prepare/left_widget/func_toggle/toggle2/bg"] = "_control.left_widget.func_toggle.toggle2.bg",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop3/num"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop3.num",
			["fight_prepare/left_widget/rankable_layout_group"] = "_control.left_widget.rankable_layout_group",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_all_btn"] = "_control.right_widget.bg_back.repair_panel.repair_all_btn",
			["fight_prepare/left_widget/func_toggle/toggle4/bg/title"] = "_control.left_widget.func_toggle.toggle4.bg.title",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/web_img"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.web_img",
			["fight_prepare/left_widget/abyss_btn/deep_sea_team_tog/title"] = "_control.left_widget.abyss_btn.deep_sea_team_tog.title",
			["fight_prepare/right_widget/bg_back/repair_panel/repair2/total"] = "_control.right_widget.bg_back.repair_panel.repair2.total",
			["fight_prepare/right_widget/bg_back/repair_panel/repair2/count"] = "_control.right_widget.bg_back.repair_panel.repair2.count",
			["fight_prepare/right_widget/bg_back/abyss_hp_info/hp_layer"] = "_control.right_widget.bg_back.abyss_hp_info.hp_layer",
			["fight_prepare/right_widget/bg_back/repair_panel/repair1/slash"] = "_control.right_widget.bg_back.repair_panel.repair1.slash",
			["fight_prepare/right_widget/bg_back/repair_panel/repair1/count"] = "_control.right_widget.bg_back.repair_panel.repair1.count",
			["fight_prepare/right_widget/bg_back/repair_panel/repair1/title"] = "_control.right_widget.bg_back.repair_panel.repair1.title",
			["fight_prepare/right_widget/bg_back/repair_panel/repair1/icon"] = "_control.right_widget.bg_back.repair_panel.repair1.icon",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop2/num"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop2.num",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support"] = "_control.right_widget.bg_back.supply_panel.map_support",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full4"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_2.full_image.full4",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full3"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_2.full_image.full3",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full2"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_2.full_image.full2",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full1"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_2.full_image.full1",
			["fight_prepare/right_widget/bg_back/props_panel/speed_info_panel/mean_speed"] = "_control.right_widget.bg_back.props_panel.speed_info_panel.mean_speed",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full3"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_1.full_image.full3",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_2.full_image",
			["fight_prepare/left_widget/nf_info/crit_info"] = "_control.left_widget.nf_info.crit_info",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop4/num"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop4.num",
			["fight_prepare/support_layer"] = "_control.support_layer",
			["fight_prepare/right_widget/bg_back/supply_panel/supply1/title"] = "_control.right_widget.bg_back.supply_panel.supply1.title",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_buff"] = "_control.right_widget.bg_back.strike_info.toggle_buff",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_info/icon"] = "_control.right_widget.bg_back.repair_panel.repair_info.icon",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_info/bg/title"] = "_control.right_widget.bg_back.strike_info.toggle_info.bg.title",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_info/bg"] = "_control.right_widget.bg_back.tower_info.toggle_info.bg",
			["fight_prepare/right_widget/bg_back/supply_panel/supply_all_btn/text"] = "_control.right_widget.bg_back.supply_panel.supply_all_btn.text",
			["fight_prepare/right_widget/bg_back/supply_panel/supply_all_btn"] = "_control.right_widget.bg_back.supply_panel.supply_all_btn",
			["fight_prepare/right_widget/bg_back/supply_panel/supply3/total"] = "_control.right_widget.bg_back.supply_panel.supply3.total",
			["fight_prepare/right_widget/bg_back/supply_panel/supply3/slash"] = "_control.right_widget.bg_back.supply_panel.supply3.slash",
			["fight_prepare/right_widget/damage_group_bg/count"] = "_control.right_widget.damage_group_bg.count",
			["fight_prepare/right_widget/bg_back/supply_panel/supply3/count"] = "_control.right_widget.bg_back.supply_panel.supply3.count",
			["fight_prepare/right_widget/bg_back/supply_panel/supply3/title"] = "_control.right_widget.bg_back.supply_panel.supply3.title",
			["fight_prepare/right_widget/bg_back/supply_panel/supply3/icon"] = "_control.right_widget.bg_back.supply_panel.supply3.icon",
			["fight_prepare/left_widget/team_toggle/line3"] = "_control.left_widget.team_toggle.line3",
			["fight_prepare/left_widget/func_toggle/line4"] = "_control.left_widget.func_toggle.line4",
			["fight_prepare/right_widget/bg_back/supply_panel/supply2/total"] = "_control.right_widget.bg_back.supply_panel.supply2.total",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop6"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop6",
			["fight_prepare/top_widget/top_title_text"] = "_control.top_widget.top_title_text",
			["fight_prepare/left_widget/team_toggle/locks/lock_1/lock"] = "_control.left_widget.team_toggle.locks.lock_1.lock",
			["fight_prepare/right_widget/bg_back/supply_panel/supply2/title"] = "_control.right_widget.bg_back.supply_panel.supply2.title",
			["fight_prepare/right_widget/bg_back/supply_panel/supply2/icon"] = "_control.right_widget.bg_back.supply_panel.supply2.icon",
			["fight_prepare/right_widget/bg_back/abyss_hp_info/residue_des"] = "_control.right_widget.bg_back.abyss_hp_info.residue_des",
			["fight_prepare/right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_list"] = "_control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_list",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop1/num"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop1.num",
			["fight_prepare/right_widget/bg_back/supply_panel/supply1/icon"] = "_control.right_widget.bg_back.supply_panel.supply1.icon",
			["fight_prepare/right_widget/bg_back/ocean_panel/all_buff"] = "_control.right_widget.bg_back.ocean_panel.all_buff",
			["fight_prepare/right_widget/bg_back/tower_info/enemy_listscrollview"] = "_control.right_widget.bg_back.tower_info.enemy_listscrollview",
			["fight_prepare/left_widget/team_toggle/toggle1/bg/checkmark"] = "_control.left_widget.team_toggle.toggle1.bg.checkmark",
			["fight_prepare/right_widget/bg_back/props_panel/speed_info_panel/max_speed"] = "_control.right_widget.bg_back.props_panel.speed_info_panel.max_speed",
			["fight_prepare/left_widget/func_toggle/line2"] = "_control.left_widget.func_toggle.line2",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop6/num"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop6.num",
			["fight_prepare/right_widget/bg_back/abyss_panel/scrollview"] = "_control.right_widget.bg_back.abyss_panel.scrollview",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop5/title"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop5.title",
			["fight_prepare/right_widget/bg_back/repair_panel/repair2/icon"] = "_control.right_widget.bg_back.repair_panel.repair2.icon",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition1/title"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition1.title",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full4"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_1.full_image.full4",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop4"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop4",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop3/title"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop3.title",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop3"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop3",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop2/title"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop2.title",
			["fight_prepare/right_widget/bg_back/repair_panel"] = "_control.right_widget.bg_back.repair_panel",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop2"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop2",
			["fight_prepare/right_widget/bg_back/campaign/campaign_info_panel/Viewport"] = "_control.right_widget.bg_back.campaign.campaign_info_panel.Viewport",
			["fight_prepare/right_widget/bg_back/props_panel"] = "_control.right_widget.bg_back.props_panel",
			["fight_prepare/right_widget/bg_back/supply_panel/supply2"] = "_control.right_widget.bg_back.supply_panel.supply2",
			["fight_prepare/right_widget/bg_back/condition_panel/first_ship_condition/condition_txt"] = "_control.right_widget.bg_back.condition_panel.first_ship_condition.condition_txt",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_3.full_image",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition2/ok_icon"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition2.ok_icon",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full5"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_3.full_image.full5",
			["fight_prepare/left_widget/abyss_btn/owner_team_tog/bg/checkmark"] = "_control.left_widget.abyss_btn.owner_team_tog.bg.checkmark",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_info/bg/checkmark"] = "_control.right_widget.bg_back.strike_info.toggle_info.bg.checkmark",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop1/title"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop1.title",
			["fight_prepare/left_widget/abyss_btn/deep_sea_team_tog/bg"] = "_control.left_widget.abyss_btn.deep_sea_team_tog.bg",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition2/condition_txt"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition2.condition_txt",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full5"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_1.full_image.full5",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_1.full_image",
			["fight_prepare/right_widget/bg_back/abyss_panel/power_tog"] = "_control.right_widget.bg_back.abyss_panel.power_tog",
			["fight_prepare/left_widget/sixth_title"] = "_control.left_widget.sixth_title",
			["fight_prepare/right_widget/bg_back/sixth_panel"] = "_control.right_widget.bg_back.sixth_panel",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop1"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop1",
			["fight_prepare/right_widget/bg_back/abyss_panel/buff_tog"] = "_control.right_widget.bg_back.abyss_panel.buff_tog",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_Scrollbar"] = "_control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport.ninth_Scrollbar",
			["fight_prepare/right_widget/bg_back/supply_panel"] = "_control.right_widget.bg_back.supply_panel",
			["fight_prepare/left_widget/func_toggle/toggle4"] = "_control.left_widget.func_toggle.toggle4",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_3"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_3",
			["fight_prepare/left_widget/nf_info/atk_info"] = "_control.left_widget.nf_info.atk_info",
			["fight_prepare/left_widget/nf_info/crit_info/crit"] = "_control.left_widget.nf_info.crit_info.crit",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop5"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop5",
			["fight_prepare/right_widget/bg_back/props_panel/speed_info_panel"] = "_control.right_widget.bg_back.props_panel.speed_info_panel",
			["fight_prepare/supply_type_btn"] = "_control.supply_type_btn",
			["fight_prepare/left_widget/nf_info/atk_info/fire_num"] = "_control.left_widget.nf_info.atk_info.fire_num",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full2"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_1.full_image.full2",
			["fight_prepare/right_widget/bg_back/ninth_info"] = "_control.right_widget.bg_back.ninth_info",
			["fight_prepare/right_widget/bg_back/abyss_panel/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.right_widget.bg_back.abyss_panel.scrollview.scrollbarvertical.slidingarea.handle",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_info/count"] = "_control.right_widget.bg_back.repair_panel.repair_info.count",
			["fight_prepare/left_widget/team_toggle/locks"] = "_control.left_widget.team_toggle.locks",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop1/num"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop1.num",
			["fight_prepare/left_widget/func_toggle/toggle4/bg"] = "_control.left_widget.func_toggle.toggle4.bg",
			["fight_prepare/right_widget/bg_back/supply_panel/supply2/slash"] = "_control.right_widget.bg_back.supply_panel.supply2.slash",
			["fight_prepare/parent/tower_icon_bg"] = "_control.parent.tower_icon_bg",
			["fight_prepare/left_widget/abyss_btn/owner_team_tog/bg"] = "_control.left_widget.abyss_btn.owner_team_tog.bg",
			["fight_prepare/support_layer/support_bg/info_text"] = "_control.support_layer.support_bg.info_text",
			["fight_prepare/left_widget/abyss_btn/leftline"] = "_control.left_widget.abyss_btn.leftline",
			["fight_prepare/left_widget/func_toggle/toggle3/bg/checkmark"] = "_control.left_widget.func_toggle.toggle3.bg.checkmark",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_1"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_1",
			["fight_prepare/support_layer/support_bg/card_bg/icon_btn"] = "_control.support_layer.support_bg.card_bg.icon_btn",
			["fight_prepare/left_widget/team_toggle/locks/lock_3"] = "_control.left_widget.team_toggle.locks.lock_3",
			["fight_prepare/left_widget/team_toggle/toggle2/bg"] = "_control.left_widget.team_toggle.toggle2.bg",
			["fight_prepare/left_widget/team_toggle/toggle3/bg/title"] = "_control.left_widget.team_toggle.toggle3.bg.title",
			["fight_prepare/right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des/gray_line_top"] = "_control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des.gray_line_top",
			["fight_prepare/left_widget/team_toggle/locks/lock_2"] = "_control.left_widget.team_toggle.locks.lock_2",
			["fight_prepare/left_widget/team_toggle/toggle4"] = "_control.left_widget.team_toggle.toggle4",
			["fight_prepare/left_widget/team_toggle/toggle4/bg"] = "_control.left_widget.team_toggle.toggle4.bg",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop1"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop1",
			["fight_prepare/right_widget/bg_back/props_panel/title"] = "_control.right_widget.bg_back.props_panel.title",
			["fight_prepare/left_widget/team_toggle/toggle3/bg/checkmark"] = "_control.left_widget.team_toggle.toggle3.bg.checkmark",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_info/bg/title"] = "_control.right_widget.bg_back.tower_info.toggle_info.bg.title",
			["fight_prepare/left_widget/nf_info/crit_info/fire_num"] = "_control.left_widget.nf_info.crit_info.fire_num",
			["fight_prepare/right_widget/bg_back/campaign/campaign_name"] = "_control.right_widget.bg_back.campaign.campaign_name",
			["fight_prepare/right_widget/bg_back/supply_panel/title"] = "_control.right_widget.bg_back.supply_panel.title",
			["fight_prepare/left_widget/team_toggle/line2"] = "_control.left_widget.team_toggle.line2",
			["fight_prepare/left_widget/abyss_btn"] = "_control.left_widget.abyss_btn",
			["fight_prepare/left_widget/nf_info/fire_info"] = "_control.left_widget.nf_info.fire_info",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition1"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition1",
			["fight_prepare/bg"] = "_control.bg",
			["fight_prepare/left_widget/func_toggle/toggle2/bg/title"] = "_control.left_widget.func_toggle.toggle2.bg.title",
			["fight_prepare/support_layer/support_bg/get_btn/get_text"] = "_control.support_layer.support_bg.get_btn.get_text",
			["fight_prepare/bottom_widget/bottom_line"] = "_control.bottom_widget.bottom_line",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_buff/bg/checkmark"] = "_control.right_widget.bg_back.strike_info.toggle_buff.bg.checkmark",
			["fight_prepare/left_widget/team_toggle/toggle4/bg/title"] = "_control.left_widget.team_toggle.toggle4.bg.title",
			["fight_prepare/right_widget/bg_back/condition_panel/first_ship_condition/title"] = "_control.right_widget.bg_back.condition_panel.first_ship_condition.title",
			["fight_prepare/left_widget/team_toggle/locks/lock_4/lock"] = "_control.left_widget.team_toggle.locks.lock_4.lock",
			["fight_prepare/left_widget/func_toggle/line1"] = "_control.left_widget.func_toggle.line1",
			["fight_prepare/left_widget/team_toggle/line4"] = "_control.left_widget.team_toggle.line4",
			["fight_prepare/right_widget/bg_back/tower_info/layer_list/Viewport/edge_mask/Content"] = "_control.right_widget.bg_back.tower_info.layer_list.Viewport.edge_mask.Content",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg",
			["fight_prepare/parent/collect_icon_bg"] = "_control.parent.collect_icon_bg",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_buff/bg/title"] = "_control.right_widget.bg_back.strike_info.toggle_buff.bg.title",
			["fight_prepare/left_widget/func_toggle/toggle2/bg/checkmark"] = "_control.left_widget.func_toggle.toggle2.bg.checkmark",
			["fight_prepare/right_widget/bg_back/repair_panel/repair2/title"] = "_control.right_widget.bg_back.repair_panel.repair2.title",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full1"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_3.full_image.full1",
			["fight_prepare/left_widget/team_toggle/toggle3/bg"] = "_control.left_widget.team_toggle.toggle3.bg",
			["fight_prepare/right_widget/bg_back/strike_info/point/now_score_text"] = "_control.right_widget.bg_back.strike_info.point.now_score_text",
			["fight_prepare/right_widget/bg_back/strike_info/point/point_num"] = "_control.right_widget.bg_back.strike_info.point.point_num",
			["fight_prepare/right_widget/bg_back/strike_info/buffs/Viewport/Scrollbar/Sliding Area"] = "_control.right_widget.bg_back.strike_info.buffs.Viewport.Scrollbar.Sliding Area",
			["fight_prepare/right_widget/bg_back/strike_info/buffs/Viewport/edge_mask"] = "_control.right_widget.bg_back.strike_info.buffs.Viewport.edge_mask",
			["fight_prepare/right_widget/bg_back/strike_info/buffs/Viewport/edge_mask/content"] = "_control.right_widget.bg_back.strike_info.buffs.Viewport.edge_mask.content",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg",
			["fight_prepare/left_widget/tower_cost/title_image"] = "_control.left_widget.tower_cost.title_image",
			["fight_prepare/left_widget/nf_info"] = "_control.left_widget.nf_info",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/web_img"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.web_img",
			["fight_prepare/left_widget/tower_cost/cost_text"] = "_control.left_widget.tower_cost.cost_text",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full3"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_3.full_image.full3",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/draw_web"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.draw_web",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop1"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop1",
			["fight_prepare/right_widget/bg_back/campaign/campaign_info_panel"] = "_control.right_widget.bg_back.campaign.campaign_info_panel",
			["fight_prepare/right_widget/damage_group_bg"] = "_control.right_widget.damage_group_bg",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop2"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop2",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop2/title"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop2.title",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop2/num"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop2.num",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop3"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop3",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop3/title"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop3.title",
			["fight_prepare/right_widget/bg_back/abyss_panel/scrollview/viewport/content"] = "_control.right_widget.bg_back.abyss_panel.scrollview.viewport.content",
			["fight_prepare/collect_layer/collect_cell1/bg"] = "_control.collect_layer.collect_cell1.bg",
			["fight_prepare/left_widget/nf_info/counterair_info/fire_num"] = "_control.left_widget.nf_info.counterair_info.fire_num",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop4/title"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop4.title",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop4/num"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop4.num",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop5"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop5",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop5/title"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop5.title",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_buff/bg"] = "_control.right_widget.bg_back.strike_info.toggle_buff.bg",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop5/num"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop5.num",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop6"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop6",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop6/title"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop6.title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_buffs"] = "_control.right_widget.bg_back.ninth_info.ninth_buffs",
			["fight_prepare/left_widget/team_toggle/locks/lock_1"] = "_control.left_widget.team_toggle.locks.lock_1",
			["fight_prepare/right_widget/bg_back/strike_info/speed_info_panel"] = "_control.right_widget.bg_back.strike_info.speed_info_panel",
			["fight_prepare/tower_buff"] = "_control.tower_buff",
			["fight_prepare/right_widget/bg_back/strike_info/speed_info_panel/mean_speed"] = "_control.right_widget.bg_back.strike_info.speed_info_panel.mean_speed",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_info/slash"] = "_control.right_widget.bg_back.repair_panel.repair_info.slash",
			["fight_prepare/left_widget/func_toggle/toggle2"] = "_control.left_widget.func_toggle.toggle2",
			["fight_prepare/right_widget/bg_back/abyss_panel/buff_tog/bg/checkmark"] = "_control.right_widget.bg_back.abyss_panel.buff_tog.bg.checkmark",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_speed_info_panel"] = "_control.right_widget.bg_back.ninth_info.ninth_speed_info_panel",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_buff"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_buff",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_buff/ninth_bg"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_buff.ninth_bg",
			["fight_prepare/right_widget/bg_back/sixth_panel/all_ship"] = "_control.right_widget.bg_back.sixth_panel.all_ship",
			["fight_prepare/collect_layer/collect_cell1/title_icon"] = "_control.collect_layer.collect_cell1.title_icon",
			["fight_prepare/collect_layer/collect_cell2"] = "_control.collect_layer.collect_cell2",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop6/num"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop6.num",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_info/line"] = "_control.right_widget.bg_back.repair_panel.repair_info.line",
			["fight_prepare/right_widget/bg_back/sixth_panel/all_ship/Viewport/Scrollbar/Sliding Area/Handle"] = "_control.right_widget.bg_back.sixth_panel.all_ship.Viewport.Scrollbar.Sliding Area.Handle",
			["fight_prepare/right_widget/bg_back/sixth_panel/all_ship/Viewport/edge_mask"] = "_control.right_widget.bg_back.sixth_panel.all_ship.Viewport.edge_mask",
			["fight_prepare/left_widget/sixth_title/team_name"] = "_control.left_widget.sixth_title.team_name",
			["fight_prepare/input_map_node"] = "_control.input_map_node",
			["fight_prepare/left_widget/nf_info/torpedo_info/fire_num"] = "_control.left_widget.nf_info.torpedo_info.fire_num",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_draw_web"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_draw_web",
			["fight_prepare/left_widget/nf_info/air_info/air"] = "_control.left_widget.nf_info.air_info.air",
			["fight_prepare/strike_buff/weather_info/weather_content"] = "_control.strike_buff.weather_info.weather_content",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop1/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop1.ninth_title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop1/ninth_num"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop1.ninth_num",
			["fight_prepare/right_widget/bg_back/sixth_panel/buff_text"] = "_control.right_widget.bg_back.sixth_panel.buff_text",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_edge_mask/ninth_content"] = "_control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport.ninth_edge_mask.ninth_content",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/support_button"] = "_control.right_widget.bg_back.supply_panel.map_support.support_button",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop2"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop2",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop2/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop2.ninth_title",
			["fight_prepare/right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des/gray_line"] = "_control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des.gray_line",
			["fight_prepare/right_widget/bg_back/tower_info/enemy_listscrollview/content"] = "_control.right_widget.bg_back.tower_info.enemy_listscrollview.content",
			["fight_prepare/right_widget/bg_back/condition_panel/line"] = "_control.right_widget.bg_back.condition_panel.line",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop3/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop3.ninth_title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop3/ninth_num"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop3.ninth_num",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop4"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop4",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop4/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop4.ninth_title",
			["fight_prepare/top_widget/top_title_line"] = "_control.top_widget.top_title_line",
			["fight_prepare/top_widget/top_widget_mask"] = "_control.top_widget.top_widget_mask",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop4/ninth_num"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop4.ninth_num",
			["fight_prepare/bottom_widget/start_fight_btn"] = "_control.bottom_widget.start_fight_btn",
			["fight_prepare/right_widget/damage_group_bg/add_btn"] = "_control.right_widget.damage_group_bg.add_btn",
			["fight_prepare/collect_layer/collect_cell3/bg"] = "_control.collect_layer.collect_cell3.bg",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop5/ninth_num"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop5.ninth_num",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop4/title"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop4.title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop6"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop6",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop6/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop6.ninth_title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop6/ninth_num"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop6.ninth_num",
			["fight_prepare/right_widget/bg_back/speed_skeleton_mask"] = "_control.right_widget.bg_back.speed_skeleton_mask",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition1/condition_txt"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition1.condition_txt",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_info"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_info",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell2"] = "_control.tower_buff.buff_parent.single_buff_cell2",
			["fight_prepare/support_layer/support_bg/info_title_text"] = "_control.support_layer.support_bg.info_title_text",
			["fight_prepare/right_widget/bg_back/campaign/campaign_info_panel/Viewport/content/campaign_info"] = "_control.right_widget.bg_back.campaign.campaign_info_panel.Viewport.content.campaign_info",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_2/full_image/full5"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_2.full_image.full5",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/desc_text"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.desc_text",
			["fight_prepare/left_widget/team_toggle/toggle2"] = "_control.left_widget.team_toggle.toggle2",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_info"] = "_control.right_widget.bg_back.tower_info.toggle_info",
			["fight_prepare/left_widget/func_toggle/toggle1/bg"] = "_control.left_widget.func_toggle.toggle1.bg",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/title/title_text_2"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.title.title_text_2",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_layer/bg/title"] = "_control.right_widget.bg_back.tower_info.toggle_layer.bg.title",
			["fight_prepare/left_widget/abyss_btn/deep_sea_team_tog/sixth_team_img"] = "_control.left_widget.abyss_btn.deep_sea_team_tog.sixth_team_img",
			["fight_prepare/right_widget/bg_back/tower_info/layer_list"] = "_control.right_widget.bg_back.tower_info.layer_list",
			["fight_prepare/left_widget/func_toggle/head"] = "_control.left_widget.func_toggle.head",
			["fight_prepare/right_widget/bg_back/tower_info/layer_list/Viewport/Scrollbar"] = "_control.right_widget.bg_back.tower_info.layer_list.Viewport.Scrollbar",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_num_condition/ok_icon"] = "_control.right_widget.bg_back.condition_panel.ship_num_condition.ok_icon",
			["fight_prepare/collect_layer/collect_cell1/icon_bg"] = "_control.collect_layer.collect_cell1.icon_bg",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_Scrollbar/ninth_Sliding Area"] = "_control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport.ninth_Scrollbar.ninth_Sliding Area",
			["fight_prepare/left_widget/func_toggle/toggle3/bg/title"] = "_control.left_widget.func_toggle.toggle3.bg.title",
			["fight_prepare/left_widget/team_toggle/toggle2/bg/title"] = "_control.left_widget.team_toggle.toggle2.bg.title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop3"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop3",
			["fight_prepare/right_widget/bg_back/repair_panel/repair2"] = "_control.right_widget.bg_back.repair_panel.repair2",
			["fight_prepare/right_widget/bg_back/supply_panel/supply1/slash"] = "_control.right_widget.bg_back.supply_panel.supply1.slash",
			["fight_prepare/right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des"] = "_control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des",
			["fight_prepare/right_widget/bg_back/strike_info/buffs"] = "_control.right_widget.bg_back.strike_info.buffs",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop2/ninth_num"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop2.ninth_num",
			["fight_prepare/right_widget/bg_back"] = "_control.right_widget.bg_back",
			["fight_prepare/left_widget/sixth_title/leftline"] = "_control.left_widget.sixth_title.leftline",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/bg_line"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.bg_line",
			["fight_prepare/right_widget/bg_back/tower_info/layer_list/Viewport/edge_mask"] = "_control.right_widget.bg_back.tower_info.layer_list.Viewport.edge_mask",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop5/num"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop5.num",
			["fight_prepare/right_widget/bg_back/ocean_panel/buff_text"] = "_control.right_widget.bg_back.ocean_panel.buff_text",
			["fight_prepare/left_widget/func_toggle/toggle4/bg/checkmark"] = "_control.left_widget.func_toggle.toggle4.bg.checkmark",
			["fight_prepare/right_widget/bg_back/ocean_panel/all_buff/Viewport"] = "_control.right_widget.bg_back.ocean_panel.all_buff.Viewport",
			["fight_prepare/right_widget/bg_back/ocean_panel/all_buff/Viewport/Scrollbar"] = "_control.right_widget.bg_back.ocean_panel.all_buff.Viewport.Scrollbar",
			["fight_prepare/left_widget/team_toggle/toggle1/bg/title"] = "_control.left_widget.team_toggle.toggle1.bg.title",
			["fight_prepare/right_widget/bg_back/ocean_panel/all_buff/Viewport/Scrollbar/Sliding Area"] = "_control.right_widget.bg_back.ocean_panel.all_buff.Viewport.Scrollbar.Sliding Area",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell1/buff_icon"] = "_control.tower_buff.buff_parent.single_buff_cell1.buff_icon",
			["fight_prepare/right_widget/bg_back/ocean_panel/all_buff/Viewport/edge_mask/Content"] = "_control.right_widget.bg_back.ocean_panel.all_buff.Viewport.edge_mask.Content",
			["fight_prepare/right_widget/bg_back/repair_panel/repair1/total"] = "_control.right_widget.bg_back.repair_panel.repair1.total",
			["fight_prepare/left_widget/abyss_btn/deep_sea_team_tog/bg/checkmark"] = "_control.left_widget.abyss_btn.deep_sea_team_tog.bg.checkmark",
			["fight_prepare/right_widget/bg_back/repair_panel/repair2/slash"] = "_control.right_widget.bg_back.repair_panel.repair2.slash",
			["fight_prepare/right_widget/bg_back/condition_panel"] = "_control.right_widget.bg_back.condition_panel",
			["fight_prepare/left_widget/nf_info/atk_info/atk"] = "_control.left_widget.nf_info.atk_info.atk",
			["fight_prepare/right_widget/bg_back/supply_panel/supply1/total"] = "_control.right_widget.bg_back.supply_panel.supply1.total",
			["fight_prepare/left_widget/abyss_floor/abyss_floor"] = "_control.abyss_floor",
			["fight_prepare/right_widget/bg_back/abyss_panel"] = "_control.right_widget.bg_back.abyss_panel",
			["fight_prepare/left_widget/team_toggle/locks/lock_2/lock"] = "_control.left_widget.team_toggle.locks.lock_2.lock",
			["fight_prepare/right_widget/bg_back/repair_panel/title"] = "_control.right_widget.bg_back.repair_panel.title",
			["fight_prepare/right_widget/bg_back/abyss_panel/power_tog/bg/checkmark"] = "_control.right_widget.bg_back.abyss_panel.power_tog.bg.checkmark",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/draw_web"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.draw_web",
			["fight_prepare/left_widget/nf_info/fire_info/fire_num"] = "_control.left_widget.nf_info.fire_info.fire_num",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_layer/bg/checkmark"] = "_control.right_widget.bg_back.tower_info.toggle_layer.bg.checkmark",
			["fight_prepare/right_widget/bg_back/abyss_panel/power_tog/title"] = "_control.right_widget.bg_back.abyss_panel.power_tog.title",
			["fight_prepare/input_map_node/placeholder"] = "_control.input_map_node.placeholder",
			["fight_prepare/right_widget/bg_back/abyss_panel/buff_tog/bg"] = "_control.right_widget.bg_back.abyss_panel.buff_tog.bg",
			["fight_prepare/left_widget/team_toggle/toggle3"] = "_control.left_widget.team_toggle.toggle3",
			["fight_prepare/right_widget/bg_back/abyss_panel/buff_tog/title"] = "_control.right_widget.bg_back.abyss_panel.buff_tog.title",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop5"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop5",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg/prop6/title"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg.prop6.title",
			["fight_prepare/right_widget/bg_back/abyss_panel/scrollview/viewport"] = "_control.right_widget.bg_back.abyss_panel.scrollview.viewport",
			["fight_prepare/right_widget/bg_back/campaign"] = "_control.right_widget.bg_back.campaign",
			["fight_prepare/right_widget/bg_back/strike_info/buffs/Viewport"] = "_control.right_widget.bg_back.strike_info.buffs.Viewport",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop3/num"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop3.num",
			["fight_prepare/right_widget/bg_back/abyss_panel/scrollview/scrollbarvertical"] = "_control.right_widget.bg_back.abyss_panel.scrollview.scrollbarvertical",
			["fight_prepare/left_widget/func_toggle/toggle1"] = "_control.left_widget.func_toggle.toggle1",
			["fight_prepare/left_widget/team_toggle/toggle4/bg/checkmark"] = "_control.left_widget.team_toggle.toggle4.bg.checkmark",
			["fight_prepare/left_widget/abyss_btn/owner_team_tog/sixth_team_img"] = "_control.left_widget.abyss_btn.owner_team_tog.sixth_team_img",
			["fight_prepare/left_widget/team_toggle"] = "_control.left_widget.team_toggle",
			["fight_prepare/right_widget/damage_group_bg/title"] = "_control.right_widget.damage_group_bg.title",
			["fight_prepare/left_widget/nf_info/torpedo_info"] = "_control.left_widget.nf_info.torpedo_info",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport"] = "_control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_layer/bg"] = "_control.right_widget.bg_back.tower_info.toggle_layer.bg",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition1/ok_icon"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition1.ok_icon",
			["fight_prepare/left_widget/team_toggle/toggle2/bg/checkmark"] = "_control.left_widget.team_toggle.toggle2.bg.checkmark",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_info/total"] = "_control.right_widget.bg_back.repair_panel.repair_info.total",
			["fight_prepare/left_widget/nf_info/spotting_info"] = "_control.left_widget.nf_info.spotting_info",
			["fight_prepare/left_widget/func_toggle/toggle3"] = "_control.left_widget.func_toggle.toggle3",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full2"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_3.full_image.full2",
			["fight_prepare/repair_btn/repair_txt"] = "_control.repair_btn.repair_txt",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_edge_mask"] = "_control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport.ninth_edge_mask",
			["fight_prepare/left_widget/sixth_title/rightline"] = "_control.left_widget.sixth_title.rightline",
			["fight_prepare/left_widget/nf_info/counterair_info/counterair"] = "_control.left_widget.nf_info.counterair_info.counterair",
			["fight_prepare/left_widget/abyss_btn/rightline"] = "_control.left_widget.abyss_btn.rightline",
			["fight_prepare/parent"] = "_control.parent",
			["fight_prepare/left_widget/nf_info/counterair_info"] = "_control.left_widget.nf_info.counterair_info",
			["fight_prepare/auto_supply_btn/toggle_text"] = "_control.auto_supply_btn.toggle_text",
			["fight_prepare/collect_layer/collect_cell1/name_scroller/collect_name"] = "_control.collect_layer.collect_cell1.name_scroller.collect_name",
			["fight_prepare/left_widget/func_toggle"] = "_control.left_widget.func_toggle",
			["fight_prepare/left_widget/team_toggle/toggle1/bg"] = "_control.left_widget.team_toggle.toggle1.bg",
			["fight_prepare/right_widget/bg_back/supply_panel/supply3"] = "_control.right_widget.bg_back.supply_panel.supply3",
			["fight_prepare/parent/pre_formation_bg"] = "_control.parent.pre_formation_bg",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_1/full_image/full1"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_1.full_image.full1",
			["fight_prepare/support_layer/support_bg"] = "_control.support_layer.support_bg",
			["fight_prepare/left_widget/func_toggle/toggle1/bg/title"] = "_control.left_widget.func_toggle.toggle1.bg.title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_info/ninth_bg/ninth_checkmark"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_info.ninth_bg.ninth_checkmark",
			["fight_prepare/strike_buff"] = "_control.strike_buff",
			["fight_prepare/buff_btn/repair_txt"] = "_control.buff_btn.repair_txt",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell1/single_bg"] = "_control.tower_buff.buff_parent.single_buff_cell1.single_bg",
			["fight_prepare/left_widget/nf_info/fire_info/fire"] = "_control.left_widget.nf_info.fire_info.fire",
			["fight_prepare/left_widget/nf_info/spotting_info/spotting"] = "_control.left_widget.nf_info.spotting_info.spotting",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop4"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop4",
			["fight_prepare/right_widget/bg_back/supply_panel/supply1"] = "_control.right_widget.bg_back.supply_panel.supply1",
			["fight_prepare/right_widget/bg_back/tower_info/layer_list/Viewport/Scrollbar/Sliding Area/Handle"] = "_control.right_widget.bg_back.tower_info.layer_list.Viewport.Scrollbar.Sliding Area.Handle",
			["fight_prepare/collect_layer/collect_cell1/name_scroller"] = "_control.collect_layer.collect_cell1.name_scroller",
			["fight_prepare/parent/support_icon_bg"] = "_control.parent.support_icon_bg",
			["fight_prepare/right_widget/bg_back/strike_info/point/icon"] = "_control.right_widget.bg_back.strike_info.point.icon",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_buff/ninth_bg/ninth_checkmark"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_buff.ninth_bg.ninth_checkmark",
			["fight_prepare/collect_layer/collect_cell1/ship_type"] = "_control.collect_layer.collect_cell1.ship_type",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_buff/ninth_bg/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_buff.ninth_bg.ninth_title",
			["fight_prepare/collect_layer/collect_cell2/bg"] = "_control.collect_layer.collect_cell2.bg",
			["fight_prepare/collect_layer/collect_cell2/icon_bg"] = "_control.collect_layer.collect_cell2.icon_bg",
			["fight_prepare/bottom_widget/start_fight_btn/text"] = "_control.bottom_widget.start_fight_btn.text",
			["fight_prepare/right_widget/bg_back/supply_panel/supply2/count"] = "_control.right_widget.bg_back.supply_panel.supply2.count",
			["fight_prepare/collect_layer/collect_cell2/icon"] = "_control.collect_layer.collect_cell2.icon",
			["fight_prepare/supply_type_btn/toggle_text"] = "_control.supply_type_btn.toggle_text",
			["fight_prepare/collect_layer/collect_cell2/name_scroller"] = "_control.collect_layer.collect_cell2.name_scroller",
			["fight_prepare/collect_layer/collect_cell2/name_scroller/collect_name"] = "_control.collect_layer.collect_cell2.name_scroller.collect_name",
			["fight_prepare/collect_layer/collect_cell2/name_scroller/collect_name_two"] = "_control.collect_layer.collect_cell2.name_scroller.collect_name_two",
			["fight_prepare/right_widget/bg_back/campaign/campaign_info_panel/Viewport/content"] = "_control.right_widget.bg_back.campaign.campaign_info_panel.Viewport.content",
			["fight_prepare/collect_layer/collect_cell2/title_icon"] = "_control.collect_layer.collect_cell2.title_icon",
			["fight_prepare/right_widget/bg_back/sixth_panel/all_ship/Viewport/Scrollbar"] = "_control.right_widget.bg_back.sixth_panel.all_ship.Viewport.Scrollbar",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_3/full_image/full4"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_3.full_image.full4",
			["fight_prepare/collect_layer/collect_cell2/ship_type"] = "_control.collect_layer.collect_cell2.ship_type",
			["fight_prepare/left_widget/abyss_floor"] = "_control.left_widget.abyss_floor",
			["fight_prepare/collect_layer/collect_cell2/buff_tips_txt"] = "_control.collect_layer.collect_cell2.buff_tips_txt",
			["fight_prepare/right_widget/bg_back/strike_info/point"] = "_control.right_widget.bg_back.strike_info.point",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_prop5/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_prop5.ninth_title",
			["fight_prepare/collect_layer/collect_cell3/icon_bg"] = "_control.collect_layer.collect_cell3.icon_bg",
			["fight_prepare/right_widget/bg_back/strike_info/buffs/Viewport/Scrollbar"] = "_control.right_widget.bg_back.strike_info.buffs.Viewport.Scrollbar",
			["fight_prepare/collect_layer/collect_cell3/icon"] = "_control.collect_layer.collect_cell3.icon",
			["fight_prepare/collect_layer/collect_cell3/line_bg"] = "_control.collect_layer.collect_cell3.line_bg",
			["fight_prepare/collect_layer/collect_cell3/name_scroller"] = "_control.collect_layer.collect_cell3.name_scroller",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_buffs/ninth_Viewport/ninth_Scrollbar/ninth_Sliding Area/ninth_Handle"] = "_control.right_widget.bg_back.ninth_info.ninth_buffs.ninth_Viewport.ninth_Scrollbar.ninth_Sliding Area.ninth_Handle",
			["fight_prepare/collect_layer/collect_cell3/name_scroller/collect_name"] = "_control.collect_layer.collect_cell3.name_scroller.collect_name",
			["fight_prepare/left_widget/team_toggle/line1"] = "_control.left_widget.team_toggle.line1",
			["fight_prepare/collect_layer/collect_cell3/name_scroller/collect_name_two"] = "_control.collect_layer.collect_cell3.name_scroller.collect_name_two",
			["fight_prepare/collect_layer/collect_cell3/title_icon"] = "_control.collect_layer.collect_cell3.title_icon",
			["fight_prepare/collect_layer/collect_cell3/ship_type"] = "_control.collect_layer.collect_cell3.ship_type",
			["fight_prepare/right_widget/bg_back/abyss_hp_info/hp_layer_back"] = "_control.right_widget.bg_back.abyss_hp_info.hp_layer_back",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia",
			["fight_prepare/auto_supply_btn"] = "_control.auto_supply_btn",
			["fight_prepare/right_widget/bg_back/strike_info/point/bg"] = "_control.right_widget.bg_back.strike_info.point.bg",
			["fight_prepare/collect_layer"] = "_control.collect_layer",
			["fight_prepare/auto_supply_btn/toggle_img"] = "_control.auto_supply_btn.toggle_img",
			["fight_prepare/left_widget/abyss_btn/owner_team_tog/title"] = "_control.left_widget.abyss_btn.owner_team_tog.title",
			["fight_prepare/right_widget/bg_back/props_panel/speed_info_panel/min_speed"] = "_control.right_widget.bg_back.props_panel.speed_info_panel.min_speed",
			["fight_prepare/left_widget/nf_info/torpedo_info/torp"] = "_control.left_widget.nf_info.torpedo_info.torp",
			["fight_prepare/left_widget/team_toggle/locks/lock_3/lock"] = "_control.left_widget.team_toggle.locks.lock_3.lock",
			["fight_prepare/left_widget/abyss_btn/owner_team_tog"] = "_control.left_widget.abyss_btn.owner_team_tog",
			["fight_prepare/supply_type_btn/toggle_img"] = "_control.supply_type_btn.toggle_img",
			["fight_prepare/collect_layer/collect_cell2/line_bg"] = "_control.collect_layer.collect_cell2.line_bg",
			["fight_prepare/right_widget/bg_back/strike_info/speed_info_panel/max_speed"] = "_control.right_widget.bg_back.strike_info.speed_info_panel.max_speed",
			["fight_prepare/right_widget"] = "_control.right_widget",
			["fight_prepare/tower_buff/buff_parent"] = "_control.tower_buff.buff_parent",
			["fight_prepare/left_widget/func_toggle/line3"] = "_control.left_widget.func_toggle.line3",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell1"] = "_control.tower_buff.buff_parent.single_buff_cell1",
			["fight_prepare/left_widget/team_toggle/toggle1"] = "_control.left_widget.team_toggle.toggle1",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell1/buff_info"] = "_control.tower_buff.buff_parent.single_buff_cell1.buff_info",
			["fight_prepare/right_widget/bg_back/sixth_panel/all_ship/Viewport/Scrollbar/Sliding Area"] = "_control.right_widget.bg_back.sixth_panel.all_ship.Viewport.Scrollbar.Sliding Area",
			["fight_prepare/right_widget/bg_back/ocean_panel/all_buff/Viewport/Scrollbar/Sliding Area/Handle"] = "_control.right_widget.bg_back.ocean_panel.all_buff.Viewport.Scrollbar.Sliding Area.Handle",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_speed_info_panel/ninth_max_speed"] = "_control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_max_speed",
			["fight_prepare/right_widget/bg_back/abyss_panel/scrollview/scrollbarvertical/slidingarea"] = "_control.right_widget.bg_back.abyss_panel.scrollview.scrollbarvertical.slidingarea",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell2/single_bg"] = "_control.tower_buff.buff_parent.single_buff_cell2.single_bg",
			["fight_prepare/collect_layer/collect_cell1/line_bg"] = "_control.collect_layer.collect_cell1.line_bg",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell2/buff_name"] = "_control.tower_buff.buff_parent.single_buff_cell2.buff_name",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell2/buff_info"] = "_control.tower_buff.buff_parent.single_buff_cell2.buff_info",
			["fight_prepare/left_widget/nf_info/air_info"] = "_control.left_widget.nf_info.air_info",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell2/buff_icon"] = "_control.tower_buff.buff_parent.single_buff_cell2.buff_icon",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell3/single_bg"] = "_control.tower_buff.buff_parent.single_buff_cell3.single_bg",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell3/buff_name"] = "_control.tower_buff.buff_parent.single_buff_cell3.buff_name",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell3/buff_info"] = "_control.tower_buff.buff_parent.single_buff_cell3.buff_info",
			["fight_prepare/right_widget/bg_back/strike_info/radar_chart_bg/prop1/title"] = "_control.right_widget.bg_back.strike_info.radar_chart_bg.prop1.title",
			["fight_prepare/right_widget/bg_back/tower_info/enemy_listscrollview/content/enemy_info_des/title_point"] = "_control.right_widget.bg_back.tower_info.enemy_listscrollview.content.enemy_info_des.title_point",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell3/buff_icon"] = "_control.tower_buff.buff_parent.single_buff_cell3.buff_icon",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_all_btn/text"] = "_control.right_widget.bg_back.repair_panel.repair_all_btn.text",
			["fight_prepare/right_widget/bg_back/abyss_panel/power_tog/bg"] = "_control.right_widget.bg_back.abyss_panel.power_tog.bg",
			["fight_prepare/left_widget/abyss_btn/deep_sea_team_tog"] = "_control.left_widget.abyss_btn.deep_sea_team_tog",
			["fight_prepare/left_widget/sixth_title/sixth_team_img"] = "_control.left_widget.sixth_title.sixth_team_img",
			["fight_prepare/left_widget/nf_info/spotting_info/fire_num"] = "_control.left_widget.nf_info.spotting_info.fire_num",
			["fight_prepare/repair_btn"] = "_control.repair_btn",
			["fight_prepare/right_widget/bg_back/strike_info"] = "_control.right_widget.bg_back.strike_info",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell4"] = "_control.tower_buff.buff_parent.single_buff_cell4",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_num_condition/title"] = "_control.right_widget.bg_back.condition_panel.ship_num_condition.title",
			["fight_prepare/right_widget/bg_back/strike_info/toggle_info"] = "_control.right_widget.bg_back.strike_info.toggle_info",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_num_condition/condition_txt"] = "_control.right_widget.bg_back.condition_panel.ship_num_condition.condition_txt",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent/icon_2"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent.icon_2",
			["fight_prepare/right_widget/bg_back/repair_panel/repair1"] = "_control.right_widget.bg_back.repair_panel.repair1",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell4/single_bg"] = "_control.tower_buff.buff_parent.single_buff_cell4.single_bg",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell4/buff_name"] = "_control.tower_buff.buff_parent.single_buff_cell4.buff_name",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell4/buff_info"] = "_control.tower_buff.buff_parent.single_buff_cell4.buff_info",
			["fight_prepare/support_layer/support_bg/card_bg"] = "_control.support_layer.support_bg.card_bg",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell4/buff_icon"] = "_control.tower_buff.buff_parent.single_buff_cell4.buff_icon",
			["fight_prepare/right_widget/bg_back/tower_info/layer_list/Viewport/Scrollbar/Sliding Area"] = "_control.right_widget.bg_back.tower_info.layer_list.Viewport.Scrollbar.Sliding Area",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell5"] = "_control.tower_buff.buff_parent.single_buff_cell5",
			["fight_prepare/support_layer/support_bg/limit_count"] = "_control.support_layer.support_bg.limit_count",
			["fight_prepare/right_widget/bg_back/condition_panel/title"] = "_control.right_widget.bg_back.condition_panel.title",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell5/single_bg"] = "_control.tower_buff.buff_parent.single_buff_cell5.single_bg",
			["fight_prepare/right_widget/bg_back/campaign/difficulty"] = "_control.right_widget.bg_back.campaign.difficulty",
			["fight_prepare/right_widget/bg_back/abyss_hp_info"] = "_control.right_widget.bg_back.abyss_hp_info",
			["fight_prepare/top_widget/return_btn"] = "_control.top_widget.return_btn",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell5/buff_name"] = "_control.tower_buff.buff_parent.single_buff_cell5.buff_name",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_info/ninth_bg/ninth_title"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_info.ninth_bg.ninth_title",
			["fight_prepare/collect_layer/collect_cell1/buff_tips_txt"] = "_control.collect_layer.collect_cell1.buff_tips_txt",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell5/buff_info"] = "_control.tower_buff.buff_parent.single_buff_cell5.buff_info",
			["fight_prepare/strike_buff/weather_info/time_txt_2"] = "_control.strike_buff.weather_info.time_txt_2",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition2"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition2",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_toggle_info/ninth_bg"] = "_control.right_widget.bg_back.ninth_info.ninth_toggle_info.ninth_bg",
			["fight_prepare/left_widget/func_toggle/toggle1/bg/checkmark"] = "_control.left_widget.func_toggle.toggle1.bg.checkmark",
			["fight_prepare/right_widget/bg_back/supply_panel/supply1/count"] = "_control.right_widget.bg_back.supply_panel.supply1.count",
			["fight_prepare/right_widget/bg_back/props_panel/radar_chart_bg"] = "_control.right_widget.bg_back.props_panel.radar_chart_bg",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/count_parent"] = "_control.right_widget.bg_back.supply_panel.map_support.count_parent",
			["fight_prepare/input_map_node/text"] = "_control.input_map_node.text",
			["fight_prepare/ocean_cia_buff_info_bg"] = "_control.ocean_cia_buff_info_bg",
			["fight_prepare/collect_layer/collect_cell3/buff_tips_txt"] = "_control.collect_layer.collect_cell3.buff_tips_txt",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/bg"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.bg",
			["fight_prepare/buff_btn"] = "_control.buff_btn",
			["fight_prepare/right_widget/bg_back/ocean_panel"] = "_control.right_widget.bg_back.ocean_panel",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/icon_bg"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.icon_bg",
			["fight_prepare/left_widget/nf_info/air_info/fire_num"] = "_control.left_widget.nf_info.air_info.fire_num",
			["fight_prepare/strike_buff/weather_info/weather_name"] = "_control.strike_buff.weather_info.weather_name",
			["fight_prepare/right_widget/bg_back/condition_panel/first_ship_condition"] = "_control.right_widget.bg_back.condition_panel.first_ship_condition",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_info/bg/checkmark"] = "_control.right_widget.bg_back.tower_info.toggle_info.bg.checkmark",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell1/buff_name"] = "_control.tower_buff.buff_parent.single_buff_cell1.buff_name",
			["fight_prepare/left_widget/team_toggle/locks/lock_4"] = "_control.left_widget.team_toggle.locks.lock_4",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/limit_text"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.limit_text",
			["fight_prepare/right_widget/bg_back/sixth_panel/all_ship/Viewport"] = "_control.right_widget.bg_back.sixth_panel.all_ship.Viewport",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_radar_chart_bg/ninth_web_img"] = "_control.right_widget.bg_back.ninth_info.ninth_radar_chart_bg.ninth_web_img",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/title"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.title",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_speed_info_panel/ninth_mean_speed"] = "_control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_mean_speed",
			["fight_prepare/right_widget/bg_back/repair_panel/repair_info"] = "_control.right_widget.bg_back.repair_panel.repair_info",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/title/title_text"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.title.title_text",
			["fight_prepare/collect_layer/collect_cell1/name_scroller/collect_name_two"] = "_control.collect_layer.collect_cell1.name_scroller.collect_name_two",
			["fight_prepare/right_widget/bg_back/tower_info/toggle_layer"] = "_control.right_widget.bg_back.tower_info.toggle_layer",
			["fight_prepare/right_widget/bg_back/tower_info/layer_list/Viewport"] = "_control.right_widget.bg_back.tower_info.layer_list.Viewport",
			["fight_prepare/right_widget/bg_back/supply_panel/map_support/icon_bg"] = "_control.right_widget.bg_back.supply_panel.map_support.icon_bg",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/silk_bg"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.silk_bg",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/silk_bg/silk_text"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.silk_bg.silk_text",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/top_line"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.top_line",
			["fight_prepare/right_widget/bg_back/speed_skeleton_mask/speed_skeleton"] = "_control.right_widget.bg_back.speed_skeleton_mask.speed_skeleton",
			["fight_prepare/collect_layer/collect_cell1"] = "_control.collect_layer.collect_cell1",
			["fight_prepare/cover"] = "_control.cover",
			["fight_prepare/right_widget/bg_back/tower_info"] = "_control.right_widget.bg_back.tower_info",
			["fight_prepare/strike_buff/weather_close_btn"] = "_control.strike_buff.weather_close_btn",
			["fight_prepare/left_widget/tower_cost"] = "_control.left_widget.tower_cost",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_type_condition2/title"] = "_control.right_widget.bg_back.condition_panel.ship_type_condition2.title",
			["fight_prepare/strike_buff/weather_info"] = "_control.strike_buff.weather_info",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell3"] = "_control.tower_buff.buff_parent.single_buff_cell3",
			["fight_prepare/ocean_cia_buff_info_bg/single_ocean_cia/icon_bg/icon"] = "_control.ocean_cia_buff_info_bg.single_ocean_cia.icon_bg.icon",
			["fight_prepare/right_widget/bg_back/condition_panel/first_ship_condition/ok_icon"] = "_control.right_widget.bg_back.condition_panel.first_ship_condition.ok_icon",
			["fight_prepare/support_layer/support_bg/get_btn"] = "_control.support_layer.support_bg.get_btn",
			["fight_prepare/right_widget/bg_back/sixth_panel/all_ship/Viewport/edge_mask/Content"] = "_control.right_widget.bg_back.sixth_panel.all_ship.Viewport.edge_mask.Content",
			["fight_prepare/right_widget/bg_back/condition_panel/ship_num_condition"] = "_control.right_widget.bg_back.condition_panel.ship_num_condition",
			["fight_prepare/right_widget/bg_back/strike_info/buffs/Viewport/Scrollbar/Sliding Area/Handle"] = "_control.right_widget.bg_back.strike_info.buffs.Viewport.Scrollbar.Sliding Area.Handle",
			["fight_prepare/strike_buff/weather_info/time_txt"] = "_control.strike_buff.weather_info.time_txt",
			["fight_prepare/left_widget/tower_cost/cost_bg"] = "_control.left_widget.tower_cost.cost_bg",
			["fight_prepare/collect_layer/collect_cell1/icon"] = "_control.collect_layer.collect_cell1.icon",
			["fight_prepare/tower_buff/buff_parent/single_buff_cell5/buff_icon"] = "_control.tower_buff.buff_parent.single_buff_cell5.buff_icon",
			["fight_prepare/right_widget/bg_back/abyss_hp_info/residue_des/hp_num"] = "_control.right_widget.bg_back.abyss_hp_info.residue_des.hp_num",
			["fight_prepare/collect_layer/collect_cell3"] = "_control.collect_layer.collect_cell3",
			["fight_prepare/right_widget/bg_back/ninth_info/ninth_speed_info_panel/ninth_min_speed"] = "_control.right_widget.bg_back.ninth_info.ninth_speed_info_panel.ninth_min_speed",
			["fight_prepare/top_widget"] = "_control.top_widget",
			["fight_prepare/right_widget/bg_back/ocean_panel/all_buff/Viewport/edge_mask"] = "_control.right_widget.bg_back.ocean_panel.all_buff.Viewport.edge_mask",
			["fight_prepare/right_widget/bg_back/strike_info/speed_info_panel/min_speed"] = "_control.right_widget.bg_back.strike_info.speed_info_panel.min_speed",
			["fight_prepare/bottom_widget"] = "_control.bottom_widget",
			["fight_prepare/left_widget"] = "_control.left_widget"
		},
		click = {
			["bottom_widget/start_fight_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_widget/bg_back/supply_panel/supply_all_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_widget/bg_back/supply_panel/map_support/support_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_widget/bg_back/repair_panel/repair_all_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			repair_btn = {
				tp = "UnityEngine.UI.Button"
			},
			buff_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["parent/support_icon_bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["parent/tower_icon_bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["parent/pre_formation_bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			support_layer = {
				tp = "UnityEngine.UI.Button"
			},
			["support_layer/support_bg/card_bg/icon_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_layer/support_bg/get_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			collect_layer = {
				tp = "UnityEngine.UI.Button"
			},
			auto_supply_btn = {
				tp = "UnityEngine.UI.Button"
			},
			supply_type_btn = {
				tp = "UnityEngine.UI.Button"
			},
			tower_buff = {
				tp = "UnityEngine.UI.Button"
			},
			ocean_cia_buff_info_bg = {
				tp = "UnityEngine.UI.Button"
			},
			["strike_buff/weather_close_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top_widget/return_btn"] = {
				tp = "ScaleButton"
			},
			["right_widget/damage_group_bg/add_btn"] = {
				tp = "ScaleButton"
			},
			["parent/collect_icon_bg"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["left_widget/team_toggle/toggle1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/team_toggle/toggle2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/team_toggle/toggle3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/team_toggle/toggle4"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/func_toggle/toggle1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/func_toggle/toggle2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/func_toggle/toggle3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/func_toggle/toggle4"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/abyss_btn/owner_team_tog"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left_widget/abyss_btn/deep_sea_team_tog"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/strike_info/toggle_info"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/strike_info/toggle_buff"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/ninth_info/ninth_toggle_info"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/ninth_info/ninth_toggle_buff"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/tower_info/toggle_info"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/tower_info/toggle_layer"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/abyss_panel/power_tog"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_widget/bg_back/abyss_panel/buff_tog"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			single_ocean_cia = {
				component = "UnityEngine.Canvas",
				path = "ocean_cia_buff_info_bg/single_ocean_cia"
			}
		}
	}
}

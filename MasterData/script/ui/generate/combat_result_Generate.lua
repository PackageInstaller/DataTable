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
			tool = {
				path = "tool",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			emptyimg = {
				path = "emptyimg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			character = {
				path = "character",
				list = {
					characterone = {
						path = "character/characterone",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					btn = {
						path = "character/btn",
						list = {
							text = {
								path = "character/btn/text",
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
			user_exp = {
				path = "user_exp",
				list = {
					lv = {
						path = "user_exp/lv",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					user_name = {
						path = "user_exp/user_name",
						list = {
							name_dd_1 = {
								path = "user_exp/user_name/name_dd_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							name_dd_2 = {
								path = "user_exp/user_name/name_dd_2",
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
					xie = {
						path = "user_exp/xie",
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
			enemy_info = {
				path = "enemy_info",
				list = {
					lv = {
						path = "enemy_info/lv",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					xie = {
						path = "enemy_info/xie",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					eneny_name = {
						path = "enemy_info/eneny_name",
						list = {
							name_dd_1 = {
								path = "enemy_info/eneny_name/name_dd_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							name_dd_2 = {
								path = "enemy_info/eneny_name/name_dd_2",
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
					"UnityEngine.CanvasGroup"
				}
			},
			enemy_fleet_info = {
				path = "enemy_fleet_info",
				list = {
					fleet_name = {
						path = "enemy_fleet_info/fleet_name",
						list = {
							fleet_name_1 = {
								path = "enemy_fleet_info/fleet_name/fleet_name_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							fleet_name_2 = {
								path = "enemy_fleet_info/fleet_name/fleet_name_2",
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
					list_bg = {
						path = "enemy_fleet_info/list_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					fight_result_ship_one = {
						path = "enemy_fleet_info/fight_result_ship_one",
						list = {
							main = {
								path = "enemy_fleet_info/fight_result_ship_one/main",
								list = {
									bg = {
										path = "enemy_fleet_info/fight_result_ship_one/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "enemy_fleet_info/fight_result_ship_one/main/ship",
										list = {
											ship_bg = {
												path = "enemy_fleet_info/fight_result_ship_one/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "enemy_fleet_info/fight_result_ship_one/main/ship/ship_icon",
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
									top = {
										path = "enemy_fleet_info/fight_result_ship_one/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "enemy_fleet_info/fight_result_ship_one/main/about_lv",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_one/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "enemy_fleet_info/fight_result_ship_one/main/about_lv/lv",
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
									ship_name = {
										path = "enemy_fleet_info/fight_result_ship_one/main/ship_name",
										list = {
											ship_name_1 = {
												path = "enemy_fleet_info/fight_result_ship_one/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "enemy_fleet_info/fight_result_ship_one/main/ship_name/ship_name_2",
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
									flag = {
										path = "enemy_fleet_info/fight_result_ship_one/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "enemy_fleet_info/fight_result_ship_one/main/about_hp",
										list = {
											hp_bg = {
												path = "enemy_fleet_info/fight_result_ship_one/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "enemy_fleet_info/fight_result_ship_one/main/about_hp/hp",
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
									about_type = {
										path = "enemy_fleet_info/fight_result_ship_one/main/about_type",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_one/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "enemy_fleet_info/fight_result_ship_one/main/about_type/type",
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
									mvp_one = {
										path = "enemy_fleet_info/fight_result_ship_one/main/mvp_one",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_one/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_one/main/mvp_one/mvp",
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
									mvp_two = {
										path = "enemy_fleet_info/fight_result_ship_one/main/mvp_two",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_one/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_one/main/mvp_two/mvp",
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
									goodwill = {
										path = "enemy_fleet_info/fight_result_ship_one/main/goodwill",
										list = {
											about_up = {
												path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_up = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up/love_up",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													increase = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up/increase",
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
											about_down = {
												path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													subtract = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down/subtract",
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
											other_love = {
												path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "enemy_fleet_info/fight_result_ship_one/main/smoke",
										list = {},
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
					fight_result_ship_two = {
						path = "enemy_fleet_info/fight_result_ship_two",
						list = {
							main = {
								path = "enemy_fleet_info/fight_result_ship_two/main",
								list = {
									bg = {
										path = "enemy_fleet_info/fight_result_ship_two/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "enemy_fleet_info/fight_result_ship_two/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "enemy_fleet_info/fight_result_ship_two/main/ship",
										list = {
											ship_bg = {
												path = "enemy_fleet_info/fight_result_ship_two/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "enemy_fleet_info/fight_result_ship_two/main/ship/ship_icon",
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
									top = {
										path = "enemy_fleet_info/fight_result_ship_two/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "enemy_fleet_info/fight_result_ship_two/main/about_lv",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_two/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "enemy_fleet_info/fight_result_ship_two/main/about_lv/lv",
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
									about_type = {
										path = "enemy_fleet_info/fight_result_ship_two/main/about_type",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_two/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "enemy_fleet_info/fight_result_ship_two/main/about_type/type",
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
									ship_name = {
										path = "enemy_fleet_info/fight_result_ship_two/main/ship_name",
										list = {
											ship_name_1 = {
												path = "enemy_fleet_info/fight_result_ship_two/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "enemy_fleet_info/fight_result_ship_two/main/ship_name/ship_name_2",
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
									flag = {
										path = "enemy_fleet_info/fight_result_ship_two/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "enemy_fleet_info/fight_result_ship_two/main/about_hp",
										list = {
											hp_bg = {
												path = "enemy_fleet_info/fight_result_ship_two/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "enemy_fleet_info/fight_result_ship_two/main/about_hp/hp",
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
									mvp_one = {
										path = "enemy_fleet_info/fight_result_ship_two/main/mvp_one",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_two/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_two/main/mvp_one/mvp",
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
									mvp_two = {
										path = "enemy_fleet_info/fight_result_ship_two/main/mvp_two",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_two/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_two/main/mvp_two/mvp",
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
									goodwill = {
										path = "enemy_fleet_info/fight_result_ship_two/main/goodwill",
										list = {
											about_up = {
												path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_up = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up/love_up",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													increase = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up/increase",
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
											about_down = {
												path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													subtract = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down/subtract",
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
											other_love = {
												path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "enemy_fleet_info/fight_result_ship_two/main/smoke",
										list = {},
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
					fight_result_ship_three = {
						path = "enemy_fleet_info/fight_result_ship_three",
						list = {
							main = {
								path = "enemy_fleet_info/fight_result_ship_three/main",
								list = {
									bg = {
										path = "enemy_fleet_info/fight_result_ship_three/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "enemy_fleet_info/fight_result_ship_three/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "enemy_fleet_info/fight_result_ship_three/main/ship",
										list = {
											ship_bg = {
												path = "enemy_fleet_info/fight_result_ship_three/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "enemy_fleet_info/fight_result_ship_three/main/ship/ship_icon",
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
									top = {
										path = "enemy_fleet_info/fight_result_ship_three/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "enemy_fleet_info/fight_result_ship_three/main/about_lv",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_three/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "enemy_fleet_info/fight_result_ship_three/main/about_lv/lv",
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
									about_type = {
										path = "enemy_fleet_info/fight_result_ship_three/main/about_type",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_three/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "enemy_fleet_info/fight_result_ship_three/main/about_type/type",
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
									ship_name = {
										path = "enemy_fleet_info/fight_result_ship_three/main/ship_name",
										list = {
											ship_name_1 = {
												path = "enemy_fleet_info/fight_result_ship_three/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "enemy_fleet_info/fight_result_ship_three/main/ship_name/ship_name_2",
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
									flag = {
										path = "enemy_fleet_info/fight_result_ship_three/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "enemy_fleet_info/fight_result_ship_three/main/about_hp",
										list = {
											hp_bg = {
												path = "enemy_fleet_info/fight_result_ship_three/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "enemy_fleet_info/fight_result_ship_three/main/about_hp/hp",
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
									mvp_one = {
										path = "enemy_fleet_info/fight_result_ship_three/main/mvp_one",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_three/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_three/main/mvp_one/mvp",
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
									mvp_two = {
										path = "enemy_fleet_info/fight_result_ship_three/main/mvp_two",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_three/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_three/main/mvp_two/mvp",
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
									goodwill = {
										path = "enemy_fleet_info/fight_result_ship_three/main/goodwill",
										list = {
											about_up = {
												path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_up = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up/love_up",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													increase = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up/increase",
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
											about_down = {
												path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													subtract = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down/subtract",
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
											other_love = {
												path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "enemy_fleet_info/fight_result_ship_three/main/smoke",
										list = {},
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
					fight_result_ship_four = {
						path = "enemy_fleet_info/fight_result_ship_four",
						list = {
							main = {
								path = "enemy_fleet_info/fight_result_ship_four/main",
								list = {
									bg = {
										path = "enemy_fleet_info/fight_result_ship_four/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "enemy_fleet_info/fight_result_ship_four/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "enemy_fleet_info/fight_result_ship_four/main/ship",
										list = {
											ship_bg = {
												path = "enemy_fleet_info/fight_result_ship_four/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "enemy_fleet_info/fight_result_ship_four/main/ship/ship_icon",
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
									top = {
										path = "enemy_fleet_info/fight_result_ship_four/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "enemy_fleet_info/fight_result_ship_four/main/about_lv",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_four/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "enemy_fleet_info/fight_result_ship_four/main/about_lv/lv",
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
									about_type = {
										path = "enemy_fleet_info/fight_result_ship_four/main/about_type",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_four/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "enemy_fleet_info/fight_result_ship_four/main/about_type/type",
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
									ship_name = {
										path = "enemy_fleet_info/fight_result_ship_four/main/ship_name",
										list = {
											ship_name_1 = {
												path = "enemy_fleet_info/fight_result_ship_four/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "enemy_fleet_info/fight_result_ship_four/main/ship_name/ship_name_2",
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
									flag = {
										path = "enemy_fleet_info/fight_result_ship_four/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "enemy_fleet_info/fight_result_ship_four/main/about_hp",
										list = {
											hp_bg = {
												path = "enemy_fleet_info/fight_result_ship_four/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "enemy_fleet_info/fight_result_ship_four/main/about_hp/hp",
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
									mvp_one = {
										path = "enemy_fleet_info/fight_result_ship_four/main/mvp_one",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_four/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_four/main/mvp_one/mvp",
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
									mvp_two = {
										path = "enemy_fleet_info/fight_result_ship_four/main/mvp_two",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_four/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_four/main/mvp_two/mvp",
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
									goodwill = {
										path = "enemy_fleet_info/fight_result_ship_four/main/goodwill",
										list = {
											about_up = {
												path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_up = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up/love_up",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													increase = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up/increase",
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
											about_down = {
												path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													subtract = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down/subtract",
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
											other_love = {
												path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "enemy_fleet_info/fight_result_ship_four/main/smoke",
										list = {},
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
					fight_result_ship_five = {
						path = "enemy_fleet_info/fight_result_ship_five",
						list = {
							main = {
								path = "enemy_fleet_info/fight_result_ship_five/main",
								list = {
									bg = {
										path = "enemy_fleet_info/fight_result_ship_five/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "enemy_fleet_info/fight_result_ship_five/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "enemy_fleet_info/fight_result_ship_five/main/ship",
										list = {
											ship_bg = {
												path = "enemy_fleet_info/fight_result_ship_five/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "enemy_fleet_info/fight_result_ship_five/main/ship/ship_icon",
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
									top = {
										path = "enemy_fleet_info/fight_result_ship_five/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "enemy_fleet_info/fight_result_ship_five/main/about_lv",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_five/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "enemy_fleet_info/fight_result_ship_five/main/about_lv/lv",
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
									about_type = {
										path = "enemy_fleet_info/fight_result_ship_five/main/about_type",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_five/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "enemy_fleet_info/fight_result_ship_five/main/about_type/type",
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
									ship_name = {
										path = "enemy_fleet_info/fight_result_ship_five/main/ship_name",
										list = {
											ship_name_1 = {
												path = "enemy_fleet_info/fight_result_ship_five/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "enemy_fleet_info/fight_result_ship_five/main/ship_name/ship_name_2",
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
									flag = {
										path = "enemy_fleet_info/fight_result_ship_five/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "enemy_fleet_info/fight_result_ship_five/main/about_hp",
										list = {
											hp_bg = {
												path = "enemy_fleet_info/fight_result_ship_five/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "enemy_fleet_info/fight_result_ship_five/main/about_hp/hp",
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
									mvp_one = {
										path = "enemy_fleet_info/fight_result_ship_five/main/mvp_one",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_five/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_five/main/mvp_one/mvp",
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
									mvp_two = {
										path = "enemy_fleet_info/fight_result_ship_five/main/mvp_two",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_five/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_five/main/mvp_two/mvp",
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
									goodwill = {
										path = "enemy_fleet_info/fight_result_ship_five/main/goodwill",
										list = {
											about_up = {
												path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_up = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up/love_up",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													increase = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up/increase",
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
											about_down = {
												path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													subtract = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down/subtract",
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
											other_love = {
												path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "enemy_fleet_info/fight_result_ship_five/main/smoke",
										list = {},
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
					fight_result_ship_six = {
						path = "enemy_fleet_info/fight_result_ship_six",
						list = {
							main = {
								path = "enemy_fleet_info/fight_result_ship_six/main",
								list = {
									bg = {
										path = "enemy_fleet_info/fight_result_ship_six/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "enemy_fleet_info/fight_result_ship_six/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "enemy_fleet_info/fight_result_ship_six/main/ship",
										list = {
											ship_bg = {
												path = "enemy_fleet_info/fight_result_ship_six/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "enemy_fleet_info/fight_result_ship_six/main/ship/ship_icon",
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
									top = {
										path = "enemy_fleet_info/fight_result_ship_six/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "enemy_fleet_info/fight_result_ship_six/main/about_lv",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_six/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "enemy_fleet_info/fight_result_ship_six/main/about_lv/lv",
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
									about_type = {
										path = "enemy_fleet_info/fight_result_ship_six/main/about_type",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_six/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "enemy_fleet_info/fight_result_ship_six/main/about_type/type",
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
									ship_name = {
										path = "enemy_fleet_info/fight_result_ship_six/main/ship_name",
										list = {
											ship_name_1 = {
												path = "enemy_fleet_info/fight_result_ship_six/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "enemy_fleet_info/fight_result_ship_six/main/ship_name/ship_name_2",
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
									flag = {
										path = "enemy_fleet_info/fight_result_ship_six/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "enemy_fleet_info/fight_result_ship_six/main/about_hp",
										list = {
											hp_bg = {
												path = "enemy_fleet_info/fight_result_ship_six/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "enemy_fleet_info/fight_result_ship_six/main/about_hp/hp",
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
									mvp_one = {
										path = "enemy_fleet_info/fight_result_ship_six/main/mvp_one",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_six/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_six/main/mvp_one/mvp",
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
									mvp_two = {
										path = "enemy_fleet_info/fight_result_ship_six/main/mvp_two",
										list = {
											bg = {
												path = "enemy_fleet_info/fight_result_ship_six/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "enemy_fleet_info/fight_result_ship_six/main/mvp_two/mvp",
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
									goodwill = {
										path = "enemy_fleet_info/fight_result_ship_six/main/goodwill",
										list = {
											about_up = {
												path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_up = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up/love_up",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													increase = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up/increase",
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
											about_down = {
												path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													subtract = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down/subtract",
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
											other_love = {
												path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love",
												list = {
													shadow = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "enemy_fleet_info/fight_result_ship_six/main/smoke",
										list = {},
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
				}
			},
			fight_results = {
				path = "fight_results",
				list = {
					expimg = {
						path = "fight_results/expimg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					unknowone = {
						path = "fight_results/unknowone",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					unknowtwo = {
						path = "fight_results/unknowtwo",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					addexp = {
						path = "fight_results/addexp",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"FontJump"
						}
					},
					exp = {
						path = "fight_results/exp",
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
			every_exp = {
				path = "every_exp",
				list = {
					main_one = {
						path = "every_exp/main_one",
						list = {
							frame = {
								path = "every_exp/main_one/frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							exp_frame = {
								path = "every_exp/main_one/exp_frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							addexp = {
								path = "every_exp/main_one/addexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							exp = {
								path = "every_exp/main_one/exp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							extra = {
								path = "every_exp/main_one/extra",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							remainword = {
								path = "every_exp/main_one/remainword",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							remainexp = {
								path = "every_exp/main_one/remainexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					main_two = {
						path = "every_exp/main_two",
						list = {
							frame = {
								path = "every_exp/main_two/frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							exp_frame = {
								path = "every_exp/main_two/exp_frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							addexp = {
								path = "every_exp/main_two/addexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							exp = {
								path = "every_exp/main_two/exp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							extra = {
								path = "every_exp/main_two/extra",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							remainword = {
								path = "every_exp/main_two/remainword",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							remainexp = {
								path = "every_exp/main_two/remainexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					main_three = {
						path = "every_exp/main_three",
						list = {
							frame = {
								path = "every_exp/main_three/frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							exp_frame = {
								path = "every_exp/main_three/exp_frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							addexp = {
								path = "every_exp/main_three/addexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							exp = {
								path = "every_exp/main_three/exp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							extra = {
								path = "every_exp/main_three/extra",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							remainword = {
								path = "every_exp/main_three/remainword",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							remainexp = {
								path = "every_exp/main_three/remainexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					main_four = {
						path = "every_exp/main_four",
						list = {
							frame = {
								path = "every_exp/main_four/frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							exp_frame = {
								path = "every_exp/main_four/exp_frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							addexp = {
								path = "every_exp/main_four/addexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							exp = {
								path = "every_exp/main_four/exp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							extra = {
								path = "every_exp/main_four/extra",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							remainword = {
								path = "every_exp/main_four/remainword",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							remainexp = {
								path = "every_exp/main_four/remainexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					main_five = {
						path = "every_exp/main_five",
						list = {
							frame = {
								path = "every_exp/main_five/frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							exp_frame = {
								path = "every_exp/main_five/exp_frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							addexp = {
								path = "every_exp/main_five/addexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							exp = {
								path = "every_exp/main_five/exp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							extra = {
								path = "every_exp/main_five/extra",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							remainword = {
								path = "every_exp/main_five/remainword",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							remainexp = {
								path = "every_exp/main_five/remainexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					main_six = {
						path = "every_exp/main_six",
						list = {
							frame = {
								path = "every_exp/main_six/frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							exp_frame = {
								path = "every_exp/main_six/exp_frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							addexp = {
								path = "every_exp/main_six/addexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							exp = {
								path = "every_exp/main_six/exp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							extra = {
								path = "every_exp/main_six/extra",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							remainword = {
								path = "every_exp/main_six/remainword",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							remainexp = {
								path = "every_exp/main_six/remainexp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
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
			user_fleet_info = {
				path = "user_fleet_info",
				list = {
					fleet_name = {
						path = "user_fleet_info/fleet_name",
						list = {
							fleet_name_1 = {
								path = "user_fleet_info/fleet_name/fleet_name_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							fleet_name_2 = {
								path = "user_fleet_info/fleet_name/fleet_name_2",
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
					fleet_bg = {
						path = "user_fleet_info/fleet_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					fight_result_ship_one = {
						path = "user_fleet_info/fight_result_ship_one",
						list = {
							main = {
								path = "user_fleet_info/fight_result_ship_one/main",
								list = {
									bg = {
										path = "user_fleet_info/fight_result_ship_one/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "user_fleet_info/fight_result_ship_one/main/ship",
										list = {
											ship_bg = {
												path = "user_fleet_info/fight_result_ship_one/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "user_fleet_info/fight_result_ship_one/main/ship/ship_icon",
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
									top = {
										path = "user_fleet_info/fight_result_ship_one/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "user_fleet_info/fight_result_ship_one/main/about_lv",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_one/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "user_fleet_info/fight_result_ship_one/main/about_lv/lv",
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
									about_type = {
										path = "user_fleet_info/fight_result_ship_one/main/about_type",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_one/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "user_fleet_info/fight_result_ship_one/main/about_type/type",
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
									ship_name = {
										path = "user_fleet_info/fight_result_ship_one/main/ship_name",
										list = {
											ship_name_1 = {
												path = "user_fleet_info/fight_result_ship_one/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "user_fleet_info/fight_result_ship_one/main/ship_name/ship_name_2",
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
									flag = {
										path = "user_fleet_info/fight_result_ship_one/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "user_fleet_info/fight_result_ship_one/main/about_hp",
										list = {
											hp_bg = {
												path = "user_fleet_info/fight_result_ship_one/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "user_fleet_info/fight_result_ship_one/main/about_hp/hp",
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
									mvp_one = {
										path = "user_fleet_info/fight_result_ship_one/main/mvp_one",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_one/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_one/main/mvp_one/mvp",
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
									mvp_two = {
										path = "user_fleet_info/fight_result_ship_one/main/mvp_two",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_one/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_one/main/mvp_two/mvp",
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
									goodwill = {
										path = "user_fleet_info/fight_result_ship_one/main/goodwill",
										list = {
											about_up = {
												path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_up",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													up = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_up/up",
														list = {
															love_up = {
																path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_up/up/love_up",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															increase = {
																path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_up/up/increase",
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
											about_down = {
												path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_down",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down",
														list = {
															love_down = {
																path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down/love_down",
																list = {
																	subtract = {
																		path = "user_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down/subtract",
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
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											other_love = {
												path = "user_fleet_info/fight_result_ship_one/main/goodwill/other_love",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "user_fleet_info/fight_result_ship_one/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "user_fleet_info/fight_result_ship_one/main/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									college_skill = {
										path = "user_fleet_info/fight_result_ship_one/main/college_skill",
										list = {
											skill = {
												path = "user_fleet_info/fight_result_ship_one/main/college_skill/skill",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_one/main/college_skill/skill/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													college_info = {
														path = "user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info",
														list = {
															icon = {
																path = "user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															add = {
																path = "user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															contrast = {
																path = "user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info/contrast",
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
					fight_result_ship_two = {
						path = "user_fleet_info/fight_result_ship_two",
						list = {
							main = {
								path = "user_fleet_info/fight_result_ship_two/main",
								list = {
									bg = {
										path = "user_fleet_info/fight_result_ship_two/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "user_fleet_info/fight_result_ship_two/main/ship",
										list = {
											ship_bg = {
												path = "user_fleet_info/fight_result_ship_two/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "user_fleet_info/fight_result_ship_two/main/ship/ship_icon",
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
									top = {
										path = "user_fleet_info/fight_result_ship_two/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "user_fleet_info/fight_result_ship_two/main/about_lv",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_two/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "user_fleet_info/fight_result_ship_two/main/about_lv/lv",
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
									about_type = {
										path = "user_fleet_info/fight_result_ship_two/main/about_type",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_two/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "user_fleet_info/fight_result_ship_two/main/about_type/type",
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
									ship_name = {
										path = "user_fleet_info/fight_result_ship_two/main/ship_name",
										list = {
											ship_name_1 = {
												path = "user_fleet_info/fight_result_ship_two/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "user_fleet_info/fight_result_ship_two/main/ship_name/ship_name_2",
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
									flag = {
										path = "user_fleet_info/fight_result_ship_two/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "user_fleet_info/fight_result_ship_two/main/about_hp",
										list = {
											hp_bg = {
												path = "user_fleet_info/fight_result_ship_two/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "user_fleet_info/fight_result_ship_two/main/about_hp/hp",
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
									mvp_one = {
										path = "user_fleet_info/fight_result_ship_two/main/mvp_one",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_two/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_two/main/mvp_one/mvp",
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
									mvp_two = {
										path = "user_fleet_info/fight_result_ship_two/main/mvp_two",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_two/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_two/main/mvp_two/mvp",
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
									goodwill = {
										path = "user_fleet_info/fight_result_ship_two/main/goodwill",
										list = {
											about_up = {
												path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_up",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													up = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_up/up",
														list = {
															love_up = {
																path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_up/up/love_up",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															increase = {
																path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_up/up/increase",
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
											about_down = {
												path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_down",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down",
														list = {
															love_down = {
																path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down/love_down",
																list = {
																	subtract = {
																		path = "user_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down/subtract",
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
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											other_love = {
												path = "user_fleet_info/fight_result_ship_two/main/goodwill/other_love",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "user_fleet_info/fight_result_ship_two/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "user_fleet_info/fight_result_ship_two/main/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									college_skill = {
										path = "user_fleet_info/fight_result_ship_two/main/college_skill",
										list = {
											skill = {
												path = "user_fleet_info/fight_result_ship_two/main/college_skill/skill",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_two/main/college_skill/skill/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													college_info = {
														path = "user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info",
														list = {
															icon = {
																path = "user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															add = {
																path = "user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															contrast = {
																path = "user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info/contrast",
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
					fight_result_ship_three = {
						path = "user_fleet_info/fight_result_ship_three",
						list = {
							main = {
								path = "user_fleet_info/fight_result_ship_three/main",
								list = {
									bg = {
										path = "user_fleet_info/fight_result_ship_three/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship = {
										path = "user_fleet_info/fight_result_ship_three/main/ship",
										list = {
											ship_bg = {
												path = "user_fleet_info/fight_result_ship_three/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "user_fleet_info/fight_result_ship_three/main/ship/ship_icon",
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
									top = {
										path = "user_fleet_info/fight_result_ship_three/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "user_fleet_info/fight_result_ship_three/main/about_lv",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_three/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "user_fleet_info/fight_result_ship_three/main/about_lv/lv",
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
									about_type = {
										path = "user_fleet_info/fight_result_ship_three/main/about_type",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_three/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "user_fleet_info/fight_result_ship_three/main/about_type/type",
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
									ship_name = {
										path = "user_fleet_info/fight_result_ship_three/main/ship_name",
										list = {
											ship_name_1 = {
												path = "user_fleet_info/fight_result_ship_three/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "user_fleet_info/fight_result_ship_three/main/ship_name/ship_name_2",
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
									flag = {
										path = "user_fleet_info/fight_result_ship_three/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "user_fleet_info/fight_result_ship_three/main/about_hp",
										list = {
											hp_bg = {
												path = "user_fleet_info/fight_result_ship_three/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "user_fleet_info/fight_result_ship_three/main/about_hp/hp",
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
									mvp_one = {
										path = "user_fleet_info/fight_result_ship_three/main/mvp_one",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_three/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_three/main/mvp_one/mvp",
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
									mvp_two = {
										path = "user_fleet_info/fight_result_ship_three/main/mvp_two",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_three/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_three/main/mvp_two/mvp",
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
									goodwill = {
										path = "user_fleet_info/fight_result_ship_three/main/goodwill",
										list = {
											about_up = {
												path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_up",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													up = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_up/up",
														list = {
															love_up = {
																path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_up/up/love_up",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															increase = {
																path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_up/up/increase",
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
											about_down = {
												path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_down",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down",
														list = {
															love_down = {
																path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down/love_down",
																list = {
																	subtract = {
																		path = "user_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down/subtract",
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
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											other_love = {
												path = "user_fleet_info/fight_result_ship_three/main/goodwill/other_love",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "user_fleet_info/fight_result_ship_three/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "user_fleet_info/fight_result_ship_three/main/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									college_skill = {
										path = "user_fleet_info/fight_result_ship_three/main/college_skill",
										list = {
											skill = {
												path = "user_fleet_info/fight_result_ship_three/main/college_skill/skill",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_three/main/college_skill/skill/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													college_info = {
														path = "user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info",
														list = {
															icon = {
																path = "user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															add = {
																path = "user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															contrast = {
																path = "user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info/contrast",
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
					fight_result_ship_four = {
						path = "user_fleet_info/fight_result_ship_four",
						list = {
							main = {
								path = "user_fleet_info/fight_result_ship_four/main",
								list = {
									bg = {
										path = "user_fleet_info/fight_result_ship_four/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "user_fleet_info/fight_result_ship_four/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "user_fleet_info/fight_result_ship_four/main/ship",
										list = {
											ship_bg = {
												path = "user_fleet_info/fight_result_ship_four/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "user_fleet_info/fight_result_ship_four/main/ship/ship_icon",
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
									top = {
										path = "user_fleet_info/fight_result_ship_four/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "user_fleet_info/fight_result_ship_four/main/about_lv",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_four/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "user_fleet_info/fight_result_ship_four/main/about_lv/lv",
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
									about_type = {
										path = "user_fleet_info/fight_result_ship_four/main/about_type",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_four/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "user_fleet_info/fight_result_ship_four/main/about_type/type",
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
									ship_name = {
										path = "user_fleet_info/fight_result_ship_four/main/ship_name",
										list = {
											ship_name_1 = {
												path = "user_fleet_info/fight_result_ship_four/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "user_fleet_info/fight_result_ship_four/main/ship_name/ship_name_2",
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
									flag = {
										path = "user_fleet_info/fight_result_ship_four/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "user_fleet_info/fight_result_ship_four/main/about_hp",
										list = {
											hp_bg = {
												path = "user_fleet_info/fight_result_ship_four/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "user_fleet_info/fight_result_ship_four/main/about_hp/hp",
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
									mvp_one = {
										path = "user_fleet_info/fight_result_ship_four/main/mvp_one",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_four/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_four/main/mvp_one/mvp",
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
									mvp_two = {
										path = "user_fleet_info/fight_result_ship_four/main/mvp_two",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_four/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_four/main/mvp_two/mvp",
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
									goodwill = {
										path = "user_fleet_info/fight_result_ship_four/main/goodwill",
										list = {
											about_up = {
												path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_up",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													up = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_up/up",
														list = {
															love_up = {
																path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_up/up/love_up",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															increase = {
																path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_up/up/increase",
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
											about_down = {
												path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_down",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down",
														list = {
															love_down = {
																path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down/love_down",
																list = {
																	subtract = {
																		path = "user_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down/subtract",
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
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											other_love = {
												path = "user_fleet_info/fight_result_ship_four/main/goodwill/other_love",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "user_fleet_info/fight_result_ship_four/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "user_fleet_info/fight_result_ship_four/main/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									college_skill = {
										path = "user_fleet_info/fight_result_ship_four/main/college_skill",
										list = {
											skill = {
												path = "user_fleet_info/fight_result_ship_four/main/college_skill/skill",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_four/main/college_skill/skill/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													college_info = {
														path = "user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info",
														list = {
															icon = {
																path = "user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															add = {
																path = "user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															contrast = {
																path = "user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info/contrast",
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
					fight_result_ship_five = {
						path = "user_fleet_info/fight_result_ship_five",
						list = {
							main = {
								path = "user_fleet_info/fight_result_ship_five/main",
								list = {
									bg = {
										path = "user_fleet_info/fight_result_ship_five/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "user_fleet_info/fight_result_ship_five/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "user_fleet_info/fight_result_ship_five/main/ship",
										list = {
											ship_bg = {
												path = "user_fleet_info/fight_result_ship_five/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "user_fleet_info/fight_result_ship_five/main/ship/ship_icon",
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
									top = {
										path = "user_fleet_info/fight_result_ship_five/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "user_fleet_info/fight_result_ship_five/main/about_lv",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_five/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "user_fleet_info/fight_result_ship_five/main/about_lv/lv",
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
									about_type = {
										path = "user_fleet_info/fight_result_ship_five/main/about_type",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_five/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "user_fleet_info/fight_result_ship_five/main/about_type/type",
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
									ship_name = {
										path = "user_fleet_info/fight_result_ship_five/main/ship_name",
										list = {
											ship_name_1 = {
												path = "user_fleet_info/fight_result_ship_five/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "user_fleet_info/fight_result_ship_five/main/ship_name/ship_name_2",
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
									flag = {
										path = "user_fleet_info/fight_result_ship_five/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "user_fleet_info/fight_result_ship_five/main/about_hp",
										list = {
											hp_bg = {
												path = "user_fleet_info/fight_result_ship_five/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "user_fleet_info/fight_result_ship_five/main/about_hp/hp",
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
									mvp_one = {
										path = "user_fleet_info/fight_result_ship_five/main/mvp_one",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_five/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_five/main/mvp_one/mvp",
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
									mvp_two = {
										path = "user_fleet_info/fight_result_ship_five/main/mvp_two",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_five/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_five/main/mvp_two/mvp",
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
									goodwill = {
										path = "user_fleet_info/fight_result_ship_five/main/goodwill",
										list = {
											about_up = {
												path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_up",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													up = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_up/up",
														list = {
															love_up = {
																path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_up/up/love_up",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															increase = {
																path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_up/up/increase",
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
											about_down = {
												path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_down",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down",
														list = {
															love_down = {
																path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down/love_down",
																list = {
																	subtract = {
																		path = "user_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down/subtract",
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
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											other_love = {
												path = "user_fleet_info/fight_result_ship_five/main/goodwill/other_love",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "user_fleet_info/fight_result_ship_five/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "user_fleet_info/fight_result_ship_five/main/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									college_skill = {
										path = "user_fleet_info/fight_result_ship_five/main/college_skill",
										list = {
											skill = {
												path = "user_fleet_info/fight_result_ship_five/main/college_skill/skill",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_five/main/college_skill/skill/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													college_info = {
														path = "user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info",
														list = {
															icon = {
																path = "user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															add = {
																path = "user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															contrast = {
																path = "user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info/contrast",
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
					fight_result_ship_six = {
						path = "user_fleet_info/fight_result_ship_six",
						list = {
							main = {
								path = "user_fleet_info/fight_result_ship_six/main",
								list = {
									bg = {
										path = "user_fleet_info/fight_result_ship_six/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									unknow = {
										path = "user_fleet_info/fight_result_ship_six/main/unknow",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									ship = {
										path = "user_fleet_info/fight_result_ship_six/main/ship",
										list = {
											ship_bg = {
												path = "user_fleet_info/fight_result_ship_six/main/ship/ship_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_icon = {
												path = "user_fleet_info/fight_result_ship_six/main/ship/ship_icon",
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
									top = {
										path = "user_fleet_info/fight_result_ship_six/main/top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_lv = {
										path = "user_fleet_info/fight_result_ship_six/main/about_lv",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_six/main/about_lv/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lv = {
												path = "user_fleet_info/fight_result_ship_six/main/about_lv/lv",
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
									about_type = {
										path = "user_fleet_info/fight_result_ship_six/main/about_type",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_six/main/about_type/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type = {
												path = "user_fleet_info/fight_result_ship_six/main/about_type/type",
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
									ship_name = {
										path = "user_fleet_info/fight_result_ship_six/main/ship_name",
										list = {
											ship_name_1 = {
												path = "user_fleet_info/fight_result_ship_six/main/ship_name/ship_name_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_2 = {
												path = "user_fleet_info/fight_result_ship_six/main/ship_name/ship_name_2",
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
									flag = {
										path = "user_fleet_info/fight_result_ship_six/main/flag",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									about_hp = {
										path = "user_fleet_info/fight_result_ship_six/main/about_hp",
										list = {
											hp_bg = {
												path = "user_fleet_info/fight_result_ship_six/main/about_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "user_fleet_info/fight_result_ship_six/main/about_hp/hp",
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
									mvp_one = {
										path = "user_fleet_info/fight_result_ship_six/main/mvp_one",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_six/main/mvp_one/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_six/main/mvp_one/mvp",
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
									mvp_two = {
										path = "user_fleet_info/fight_result_ship_six/main/mvp_two",
										list = {
											bg = {
												path = "user_fleet_info/fight_result_ship_six/main/mvp_two/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mvp = {
												path = "user_fleet_info/fight_result_ship_six/main/mvp_two/mvp",
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
									goodwill = {
										path = "user_fleet_info/fight_result_ship_six/main/goodwill",
										list = {
											about_up = {
												path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_up",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_up/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													up = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_up/up",
														list = {
															love_up = {
																path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_up/up/love_up",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															increase = {
																path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_up/up/increase",
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
											about_down = {
												path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_down",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_down/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down",
														list = {
															love_down = {
																path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down/love_down",
																list = {
																	subtract = {
																		path = "user_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down/subtract",
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
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											other_love = {
												path = "user_fleet_info/fight_result_ship_six/main/goodwill/other_love",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/other_love/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													love_down = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/other_love/love_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													add = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/other_love/add",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													contrast = {
														path = "user_fleet_info/fight_result_ship_six/main/goodwill/other_love/contrast",
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
									smoke = {
										path = "user_fleet_info/fight_result_ship_six/main/smoke",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									college_skill = {
										path = "user_fleet_info/fight_result_ship_six/main/college_skill",
										list = {
											skill = {
												path = "user_fleet_info/fight_result_ship_six/main/college_skill/skill",
												list = {
													shadow = {
														path = "user_fleet_info/fight_result_ship_six/main/college_skill/skill/shadow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													college_info = {
														path = "user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info",
														list = {
															icon = {
																path = "user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															add = {
																path = "user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															contrast = {
																path = "user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info/contrast",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener"
				}
			},
			dmg_set = {
				path = "dmg_set",
				list = {
					user_dmg_bg = {
						path = "dmg_set/user_dmg_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					user_dmg = {
						path = "dmg_set/user_dmg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIFillAmountChangeEffect"
						}
					},
					enemy_dmg_bg = {
						path = "dmg_set/enemy_dmg_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					enemy_dmg = {
						path = "dmg_set/enemy_dmg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIFillAmountChangeEffect"
						}
					},
					line = {
						path = "dmg_set/line",
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
			up_layer = {
				path = "up_layer",
				list = {
					line = {
						path = "up_layer/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					fight_result = {
						path = "up_layer/fight_result",
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
			bonus_layer = {
				path = "bonus_layer",
				list = {
					item_title = {
						path = "bonus_layer/item_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					item_main_one = {
						path = "bonus_layer/item_main_one",
						list = {
							bg = {
								path = "bonus_layer/item_main_one/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							item = {
								path = "bonus_layer/item_main_one/item",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "bonus_layer/item_main_one/num",
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
					item_main_two = {
						path = "bonus_layer/item_main_two",
						list = {
							bg = {
								path = "bonus_layer/item_main_two/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							item = {
								path = "bonus_layer/item_main_two/item",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "bonus_layer/item_main_two/num",
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
					item_main_three = {
						path = "bonus_layer/item_main_three",
						list = {
							bg = {
								path = "bonus_layer/item_main_three/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							item = {
								path = "bonus_layer/item_main_three/item",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "bonus_layer/item_main_three/num",
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
					item_main_four = {
						path = "bonus_layer/item_main_four",
						list = {
							bg = {
								path = "bonus_layer/item_main_four/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							item = {
								path = "bonus_layer/item_main_four/item",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "bonus_layer/item_main_four/num",
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
					get_item = {
						path = "bonus_layer/get_item",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					coreget = {
						path = "bonus_layer/coreget",
						list = {
							bg = {
								path = "bonus_layer/coreget/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							item = {
								path = "bonus_layer/coreget/item",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bottom_bg = {
								path = "bonus_layer/coreget/bottom_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "bonus_layer/coreget/num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							sample = {
								path = "bonus_layer/coreget/sample",
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
			get_booty = {
				path = "get_booty",
				list = {
					getword = {
						path = "get_booty/getword",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					get_num_booty = {
						path = "get_booty/get_num_booty",
						list = {
							bg = {
								path = "get_booty/get_num_booty/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							pangci = {
								path = "get_booty/get_num_booty/pangci",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "get_booty/get_num_booty/num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					already_have_booty = {
						path = "get_booty/already_have_booty",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					have_booty = {
						path = "get_booty/have_booty",
						list = {
							bg = {
								path = "get_booty/have_booty/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icons = {
								path = "get_booty/have_booty/icons",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							num = {
								path = "get_booty/have_booty/num",
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
			score = {
				path = "score",
				list = {
					resultword = {
						path = "score/resultword",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					spineparent = {
						path = "score/spineparent",
						list = {},
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
			countinue = {
				path = "countinue",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.CanvasGroup"
				}
			},
			closetwo = {
				path = "closetwo",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			closeone = {
				path = "closeone",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			maskto = {
				path = "maskto",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			battlereport = {
				path = "battlereport",
				list = {
					reportbtn = {
						path = "battlereport/reportbtn",
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
			report_bg = {
				path = "report_bg",
				list = {
					close = {
						path = "report_bg/close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					report_view = {
						path = "report_bg/report_view",
						list = {
							report = {
								path = "report_bg/report_view/report",
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
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
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
			["combat_result/bonus_layer/item_main_one/item"] = "_control.bonus_layer.item_main_one.item",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_up/up/increase"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_up.up.increase",
			["combat_result/user_fleet_info/fight_result_ship_four"] = "_control.user_fleet_info.fight_result_ship_four",
			["combat_result/user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info/contrast"] = "_control.user_fleet_info.fight_result_ship_three.main.college_skill.skill.college_info.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_lv/bg"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_lv.bg",
			["combat_result/every_exp/main_one/remainexp"] = "_control.every_exp.main_one.remainexp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/other_love/shadow"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_lv/lv"] = "_control.user_fleet_info.fight_result_ship_three.main.about_lv.lv",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_lv/bg"] = "_control.user_fleet_info.fight_result_ship_three.main.about_lv.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_up"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_up",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_down/shadow"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_down.shadow",
			["combat_result/every_exp/main_two/addexp"] = "_control.every_exp.main_two.addexp",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up/shadow"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_up.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_type"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_type",
			["combat_result/user_fleet_info/fight_result_ship_three/main/flag"] = "_control.user_fleet_info.fight_result_ship_three.main.flag",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/mvp_two"] = "_control.enemy_fleet_info.fight_result_ship_two.main.mvp_two",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/other_love/add"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.other_love.add",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_hp/hp"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_hp.hp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/college_skill/skill/shadow"] = "_control.user_fleet_info.fight_result_ship_three.main.college_skill.skill.shadow",
			["combat_result/tool"] = "_control.tool",
			["combat_result/every_exp/main_four/exp_frame"] = "_control.every_exp.main_four.exp_frame",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up/love_up"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_up.love_up",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down/shadow"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_down.shadow",
			["combat_result/user_fleet_info/fight_result_ship_two/main"] = "_control.user_fleet_info.fight_result_ship_two.main",
			["combat_result/user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info"] = "_control.user_fleet_info.fight_result_ship_two.main.college_skill.skill.college_info",
			["combat_result/user_fleet_info/fight_result_ship_two/main/college_skill"] = "_control.user_fleet_info.fight_result_ship_two.main.college_skill",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_up/up/love_up"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_up.up.love_up",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/other_love/love_down"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.other_love.love_down",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_lv/lv"] = "_control.user_fleet_info.fight_result_ship_four.main.about_lv.lv",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_type/type"] = "_control.user_fleet_info.fight_result_ship_four.main.about_type.type",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_type"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_type",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/other_love/contrast"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.other_love.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_lv/lv"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_lv.lv",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_up/shadow"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_up.shadow",
			["combat_result/user_fleet_info/fight_result_ship_two/main/mvp_one/mvp"] = "_control.user_fleet_info.fight_result_ship_two.main.mvp_one.mvp",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_hp/hp_bg"] = "_control.user_fleet_info.fight_result_ship_two.main.about_hp.hp_bg",
			["combat_result/user_fleet_info/fight_result_ship_two/main/flag"] = "_control.user_fleet_info.fight_result_ship_two.main.flag",
			["combat_result/user_fleet_info/fight_result_ship_two/main/ship_name/ship_name_2"] = "_control.user_fleet_info.fight_result_ship_two.main.ship_name.ship_name_2",
			["combat_result/user_fleet_info/fight_result_ship_two/main/ship_name/ship_name_1"] = "_control.user_fleet_info.fight_result_ship_two.main.ship_name.ship_name_1",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_type/type"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_type.type",
			["combat_result/user_fleet_info/fight_result_ship_one/main/top"] = "_control.user_fleet_info.fight_result_ship_one.main.top",
			["combat_result/user_fleet_info/fight_result_ship_two/main/bg"] = "_control.user_fleet_info.fight_result_ship_two.main.bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/college_skill/skill/shadow"] = "_control.user_fleet_info.fight_result_ship_one.main.college_skill.skill.shadow",
			["combat_result/user_fleet_info/fight_result_ship_one/main/smoke"] = "_control.user_fleet_info.fight_result_ship_one.main.smoke",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_down.love_down",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/other_love/shadow"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/other_love"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.other_love",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_down",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_down"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_down",
			["combat_result/user_fleet_info/fight_result_ship_one/main/college_skill/skill"] = "_control.user_fleet_info.fight_result_ship_one.main.college_skill.skill",
			["combat_result/user_fleet_info/fight_result_ship_one/main/ship/ship_bg"] = "_control.user_fleet_info.fight_result_ship_one.main.ship.ship_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_type"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_type",
			["combat_result/user_fleet_info/fight_result_ship_one/main/mvp_two/mvp"] = "_control.user_fleet_info.fight_result_ship_one.main.mvp_two.mvp",
			["combat_result/every_exp/main_four/frame"] = "_control.every_exp.main_four.frame",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_type/type"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_type.type",
			["combat_result/enemy_info"] = "_control.enemy_info",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_hp/hp_bg"] = "_control.user_fleet_info.fight_result_ship_one.main.about_hp.hp_bg",
			["combat_result/enemy_fleet_info/list_bg"] = "_control.enemy_fleet_info.list_bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_type/type"] = "_control.user_fleet_info.fight_result_ship_one.main.about_type.type",
			["combat_result/every_exp/main_three"] = "_control.every_exp.main_three",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_type"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_type",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_lv/bg"] = "_control.user_fleet_info.fight_result_ship_one.main.about_lv.bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/ship/ship_icon"] = "_control.user_fleet_info.fight_result_ship_one.main.ship.ship_icon",
			["combat_result/every_exp/main_one/frame"] = "_control.every_exp.main_one.frame",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_up/up"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_up.up",
			["combat_result/user_fleet_info/fight_result_ship_one/main/ship"] = "_control.user_fleet_info.fight_result_ship_one.main.ship",
			["combat_result/every_exp/main_five/remainword"] = "_control.every_exp.main_five.remainword",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/top"] = "_control.enemy_fleet_info.fight_result_ship_two.main.top",
			["combat_result/user_fleet_info/fight_result_ship_one/main"] = "_control.user_fleet_info.fight_result_ship_one.main",
			["combat_result/user_fleet_info/fight_result_ship_one/main/mvp_one"] = "_control.user_fleet_info.fight_result_ship_one.main.mvp_one",
			["combat_result/every_exp/main_six/remainexp"] = "_control.every_exp.main_six.remainexp",
			["combat_result/every_exp/main_six/remainword"] = "_control.every_exp.main_six.remainword",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_down.love_down",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_hp"] = "_control.user_fleet_info.fight_result_ship_three.main.about_hp",
			["combat_result/every_exp/main_one/addexp"] = "_control.every_exp.main_one.addexp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/top"] = "_control.user_fleet_info.fight_result_ship_three.main.top",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/unknow"] = "_control.enemy_fleet_info.fight_result_ship_two.main.unknow",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/mvp_two/bg"] = "_control.enemy_fleet_info.fight_result_ship_three.main.mvp_two.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main/ship_name/ship_name_1"] = "_control.user_fleet_info.fight_result_ship_three.main.ship_name.ship_name_1",
			["combat_result/user_fleet_info/fight_result_ship_one/main/ship_name"] = "_control.user_fleet_info.fight_result_ship_one.main.ship_name",
			["combat_result/every_exp/main_five/frame"] = "_control.every_exp.main_five.frame",
			["combat_result/bonus_layer"] = "_control.bonus_layer",
			["combat_result/every_exp/main_four/addexp"] = "_control.every_exp.main_four.addexp",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/mvp_two/mvp"] = "_control.enemy_fleet_info.fight_result_ship_three.main.mvp_two.mvp",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/other_love/love_down"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.other_love.love_down",
			["combat_result/fight_results/addexp"] = "_control.fight_results.addexp",
			["combat_result/every_exp/main_three/extra"] = "_control.every_exp.main_three.extra",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_type"] = "_control.user_fleet_info.fight_result_ship_four.main.about_type",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/bg"] = "_control.enemy_fleet_info.fight_result_ship_four.main.bg",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_up"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_up",
			["combat_result/user_fleet_info/fight_result_ship_two/main/mvp_one/bg"] = "_control.user_fleet_info.fight_result_ship_two.main.mvp_one.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_hp"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_hp",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_lv"] = "_control.user_fleet_info.fight_result_ship_two.main.about_lv",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_hp/hp"] = "_control.user_fleet_info.fight_result_ship_one.main.about_hp.hp",
			["combat_result/every_exp/main_two/remainword"] = "_control.every_exp.main_two.remainword",
			["combat_result/every_exp/main_two/extra"] = "_control.every_exp.main_two.extra",
			["combat_result/every_exp/main_two/exp"] = "_control.every_exp.main_two.exp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/mvp_one/mvp"] = "_control.user_fleet_info.fight_result_ship_three.main.mvp_one.mvp",
			["combat_result/user_fleet_info/fight_result_ship_two/main/ship/ship_bg"] = "_control.user_fleet_info.fight_result_ship_two.main.ship.ship_bg",
			["combat_result/get_booty/get_num_booty"] = "_control.get_booty.get_num_booty",
			["combat_result/user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info/contrast"] = "_control.user_fleet_info.fight_result_ship_six.main.college_skill.skill.college_info.contrast",
			["combat_result/every_exp/main_two/frame"] = "_control.every_exp.main_two.frame",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/smoke"] = "_control.enemy_fleet_info.fight_result_ship_two.main.smoke",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_hp/hp_bg"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_hp.hp_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/mvp_two/bg"] = "_control.enemy_fleet_info.fight_result_ship_two.main.mvp_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/mvp_one"] = "_control.enemy_fleet_info.fight_result_ship_two.main.mvp_one",
			["combat_result/user_fleet_info/fight_result_ship_four/main/mvp_two"] = "_control.user_fleet_info.fight_result_ship_four.main.mvp_two",
			["combat_result/every_exp"] = "_control.every_exp",
			["combat_result/user_fleet_info/fight_result_ship_three"] = "_control.user_fleet_info.fight_result_ship_three",
			["combat_result/user_fleet_info/fight_result_ship_one/main/mvp_two"] = "_control.user_fleet_info.fight_result_ship_one.main.mvp_two",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/add"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.other_love.add",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/love_down"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.other_love.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/shadow"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_lv/bg"] = "_control.user_fleet_info.fight_result_ship_two.main.about_lv.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.other_love",
			["combat_result/every_exp/main_six/exp"] = "_control.every_exp.main_six.exp",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down/subtract"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_down.subtract",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_hp"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_hp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/smoke"] = "_control.user_fleet_info.fight_result_ship_three.main.smoke",
			["combat_result/user_fleet_info/fleet_name"] = "_control.user_fleet_info.fleet_name",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_down",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up/increase"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_up.increase",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up/love_up"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_up.love_up",
			["combat_result/enemy_fleet_info/fight_result_ship_six"] = "_control.enemy_fleet_info.fight_result_ship_six",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_lv"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_lv",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/mvp_two/mvp"] = "_control.enemy_fleet_info.fight_result_ship_six.main.mvp_two.mvp",
			["combat_result/every_exp/main_three/addexp"] = "_control.every_exp.main_three.addexp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/ship/ship_icon"] = "_control.user_fleet_info.fight_result_ship_three.main.ship.ship_icon",
			["combat_result/report_bg/close"] = "_control.report_bg.close",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/mvp_one/mvp"] = "_control.enemy_fleet_info.fight_result_ship_six.main.mvp_one.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/mvp_two/bg"] = "_control.enemy_fleet_info.fight_result_ship_four.main.mvp_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_lv"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_lv",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/contrast"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.other_love.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/smoke"] = "_control.enemy_fleet_info.fight_result_ship_one.main.smoke",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/mvp_one/bg"] = "_control.enemy_fleet_info.fight_result_ship_two.main.mvp_one.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.other_love",
			["combat_result/bonus_layer/item_main_four/bg"] = "_control.bonus_layer.item_main_four.bg",
			["combat_result/user_fleet_info/fight_result_ship_two/main/mvp_two/bg"] = "_control.user_fleet_info.fight_result_ship_two.main.mvp_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/ship/ship_bg"] = "_control.enemy_fleet_info.fight_result_ship_two.main.ship.ship_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/smoke"] = "_control.enemy_fleet_info.fight_result_ship_five.main.smoke",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/ship"] = "_control.enemy_fleet_info.fight_result_ship_one.main.ship",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_lv/bg"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_lv.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_down",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up/love_up"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_up.love_up",
			["combat_result/every_exp/main_five/extra"] = "_control.every_exp.main_five.extra",
			["combat_result/get_booty/have_booty/num"] = "_control.get_booty.have_booty.num",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up/shadow"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_up.shadow",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_type/bg"] = "_control.user_fleet_info.fight_result_ship_two.main.about_type.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_up",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/ship"] = "_control.enemy_fleet_info.fight_result_ship_five.main.ship",
			["combat_result/user_exp/user_name/name_dd_1"] = "_control.user_exp.user_name.name_dd_1",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/mvp_two/mvp"] = "_control.enemy_fleet_info.fight_result_ship_two.main.mvp_two.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/flag"] = "_control.enemy_fleet_info.fight_result_ship_one.main.flag",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/mvp_one/mvp"] = "_control.enemy_fleet_info.fight_result_ship_two.main.mvp_one.mvp",
			["combat_result/every_exp/main_three/exp_frame"] = "_control.every_exp.main_three.exp_frame",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/bg"] = "_control.enemy_fleet_info.fight_result_ship_one.main.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main"] = "_control.user_fleet_info.fight_result_ship_three.main",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/love_down"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.other_love.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_up",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_hp"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_hp",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_type/bg"] = "_control.user_fleet_info.fight_result_ship_one.main.about_type.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/flag"] = "_control.enemy_fleet_info.fight_result_ship_three.main.flag",
			["combat_result/every_exp/main_one/extra"] = "_control.every_exp.main_one.extra",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/ship_name/ship_name_2"] = "_control.enemy_fleet_info.fight_result_ship_two.main.ship_name.ship_name_2",
			["combat_result/every_exp/main_four/extra"] = "_control.every_exp.main_four.extra",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/love_down"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.other_love.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/contrast"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.other_love.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/ship/ship_bg"] = "_control.enemy_fleet_info.fight_result_ship_six.main.ship.ship_bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/mvp_two/bg"] = "_control.user_fleet_info.fight_result_ship_one.main.mvp_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill",
			["combat_result/user_fleet_info"] = "_control.user_fleet_info",
			["combat_result/user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info/add"] = "_control.user_fleet_info.fight_result_ship_two.main.college_skill.skill.college_info.add",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/flag"] = "_control.enemy_fleet_info.fight_result_ship_five.main.flag",
			["combat_result/user_fleet_info/fight_result_ship_two/main/ship/ship_icon"] = "_control.user_fleet_info.fight_result_ship_two.main.ship.ship_icon",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_type/type"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_type.type",
			["combat_result/user_fleet_info/fight_result_ship_two/main/ship"] = "_control.user_fleet_info.fight_result_ship_two.main.ship",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/love_down"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.other_love.love_down",
			["combat_result/user_exp/user_name/name_dd_2"] = "_control.user_exp.user_name.name_dd_2",
			["combat_result/user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info/contrast"] = "_control.user_fleet_info.fight_result_ship_five.main.college_skill.skill.college_info.contrast",
			["combat_result/dmg_set"] = "_control.dmg_set",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_hp"] = "_control.user_fleet_info.fight_result_ship_one.main.about_hp",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/mvp_one"] = "_control.enemy_fleet_info.fight_result_ship_four.main.mvp_one",
			["combat_result/every_exp/main_four/exp"] = "_control.every_exp.main_four.exp",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_hp/hp_bg"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_hp.hp_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down/shadow"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_down.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/ship/ship_icon"] = "_control.enemy_fleet_info.fight_result_ship_five.main.ship.ship_icon",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_up/up/increase"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_up.up.increase",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_down.love_down",
			["combat_result/enemy_info/eneny_name/name_dd_2"] = "_control.enemy_info.eneny_name.name_dd_2",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/ship"] = "_control.enemy_fleet_info.fight_result_ship_three.main.ship",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_hp/hp"] = "_control.user_fleet_info.fight_result_ship_three.main.about_hp.hp",
			["combat_result/every_exp/main_one/exp"] = "_control.every_exp.main_one.exp",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_lv"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_lv",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_up",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_two"] = "_control.enemy_fleet_info.fight_result_ship_two",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/ship_name"] = "_control.enemy_fleet_info.fight_result_ship_four.main.ship_name",
			["combat_result/user_fleet_info/fight_result_ship_four/main/ship/ship_bg"] = "_control.user_fleet_info.fight_result_ship_four.main.ship.ship_bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/ship_name/ship_name_1"] = "_control.user_fleet_info.fight_result_ship_one.main.ship_name.ship_name_1",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/ship_name/ship_name_1"] = "_control.enemy_fleet_info.fight_result_ship_three.main.ship_name.ship_name_1",
			["combat_result/character/btn"] = "_control.character.btn",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_lv/bg"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_lv.bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_type"] = "_control.user_fleet_info.fight_result_ship_one.main.about_type",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_lv/lv"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_lv.lv",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/ship_name"] = "_control.enemy_fleet_info.fight_result_ship_six.main.ship_name",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/ship_name/ship_name_2"] = "_control.enemy_fleet_info.fight_result_ship_one.main.ship_name.ship_name_2",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/ship_name/ship_name_1"] = "_control.enemy_fleet_info.fight_result_ship_one.main.ship_name.ship_name_1",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/ship/ship_bg"] = "_control.enemy_fleet_info.fight_result_ship_one.main.ship.ship_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/mvp_two/bg"] = "_control.enemy_fleet_info.fight_result_ship_one.main.mvp_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/mvp_one/bg"] = "_control.enemy_fleet_info.fight_result_ship_five.main.mvp_one.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/smoke"] = "_control.enemy_fleet_info.fight_result_ship_six.main.smoke",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down/subtract"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_down.subtract",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_hp/hp"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_hp.hp",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/ship/ship_icon"] = "_control.enemy_fleet_info.fight_result_ship_one.main.ship.ship_icon",
			["combat_result/user_fleet_info/fight_result_ship_three/main/mvp_two/mvp"] = "_control.user_fleet_info.fight_result_ship_three.main.mvp_two.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up/love_up"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_up.love_up",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_lv"] = "_control.user_fleet_info.fight_result_ship_one.main.about_lv",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_hp"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_hp",
			["combat_result/user_fleet_info/fight_result_ship_one/main/mvp_one/bg"] = "_control.user_fleet_info.fight_result_ship_one.main.mvp_one.bg",
			["combat_result/get_booty/have_booty/bg"] = "_control.get_booty.have_booty.bg",
			["combat_result/user_fleet_info/fight_result_ship_four/main/mvp_two/bg"] = "_control.user_fleet_info.fight_result_ship_four.main.mvp_two.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down/subtract"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_down.love_down.love_down.subtract",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/bg"] = "_control.enemy_fleet_info.fight_result_ship_five.main.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/add"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.other_love.add",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/add"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.other_love.add",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/about_type/bg"] = "_control.enemy_fleet_info.fight_result_ship_one.main.about_type.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down/subtract"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_down.subtract",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_hp/hp"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_hp.hp",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_hp/hp"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_hp.hp",
			["combat_result/every_exp/main_six/exp_frame"] = "_control.every_exp.main_six.exp_frame",
			["combat_result/enemy_fleet_info/fleet_name"] = "_control.enemy_fleet_info.fleet_name",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.other_love",
			["combat_result/bonus_layer/item_main_one/bg"] = "_control.bonus_layer.item_main_one.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/ship/ship_icon"] = "_control.enemy_fleet_info.fight_result_ship_six.main.ship.ship_icon",
			["combat_result/user_fleet_info/fight_result_ship_four/main/ship_name/ship_name_2"] = "_control.user_fleet_info.fight_result_ship_four.main.ship_name.ship_name_2",
			["combat_result/every_exp/main_five/remainexp"] = "_control.every_exp.main_five.remainexp",
			["combat_result/enemy_fleet_info/fight_result_ship_five"] = "_control.enemy_fleet_info.fight_result_ship_five",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/unknow"] = "_control.enemy_fleet_info.fight_result_ship_six.main.unknow",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up/shadow"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_up.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_type/type"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_type.type",
			["combat_result/user_fleet_info/fight_result_ship_two/main/ship_name"] = "_control.user_fleet_info.fight_result_ship_two.main.ship_name",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_down/shadow"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_down.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_hp"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_hp",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/other_love/shadow"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_type/type"] = "_control.user_fleet_info.fight_result_ship_three.main.about_type.type",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_down",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/top"] = "_control.enemy_fleet_info.fight_result_ship_six.main.top",
			["combat_result/every_exp/main_four/remainword"] = "_control.every_exp.main_four.remainword",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/other_love/love_down"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.other_love.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/love_down"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.other_love.love_down",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down/subtract"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_down.love_down.love_down.subtract",
			["combat_result/get_booty/have_booty"] = "_control.get_booty.have_booty",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/ship/ship_icon"] = "_control.enemy_fleet_info.fight_result_ship_four.main.ship.ship_icon",
			["combat_result/dmg_set/user_dmg_bg"] = "_control.dmg_set.user_dmg_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/ship_name"] = "_control.enemy_fleet_info.fight_result_ship_one.main.ship_name",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_up/up/love_up"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_up.up.love_up",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/mvp_one/mvp"] = "_control.enemy_fleet_info.fight_result_ship_one.main.mvp_one.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_lv/lv"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_lv.lv",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_type/bg"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_type.bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/mvp_one/mvp"] = "_control.user_fleet_info.fight_result_ship_one.main.mvp_one.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/ship_name/ship_name_1"] = "_control.enemy_fleet_info.fight_result_ship_four.main.ship_name.ship_name_1",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_down/subtract"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_down.subtract",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/ship/ship_bg"] = "_control.enemy_fleet_info.fight_result_ship_four.main.ship.ship_bg",
			["combat_result/every_exp/main_six/frame"] = "_control.every_exp.main_six.frame",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main"] = "_control.enemy_fleet_info.fight_result_ship_two.main",
			["combat_result/user_exp/user_name"] = "_control.user_exp.user_name",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/contrast"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.other_love.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/mvp_two/bg"] = "_control.enemy_fleet_info.fight_result_ship_six.main.mvp_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main"] = "_control.enemy_fleet_info.fight_result_ship_six.main",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_up",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/bg"] = "_control.enemy_fleet_info.fight_result_ship_six.main.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/mvp_two"] = "_control.enemy_fleet_info.fight_result_ship_four.main.mvp_two",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/mvp_two/mvp"] = "_control.enemy_fleet_info.fight_result_ship_four.main.mvp_two.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/top"] = "_control.enemy_fleet_info.fight_result_ship_one.main.top",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_type/type"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_type.type",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/contrast"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.other_love.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up/increase"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_up.increase",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/mvp_one/bg"] = "_control.enemy_fleet_info.fight_result_ship_one.main.mvp_one.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_type/bg"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_type.bg",
			["combat_result/user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info/icon"] = "_control.user_fleet_info.fight_result_ship_two.main.college_skill.skill.college_info.icon",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down/shadow"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_down.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/add"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.other_love.add",
			["combat_result/fight_results/exp"] = "_control.fight_results.exp",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_lv/lv"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_lv.lv",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_down",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_down/shadow"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_down.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.other_love",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/ship_name/ship_name_2"] = "_control.enemy_fleet_info.fight_result_ship_five.main.ship_name.ship_name_2",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/ship_name/ship_name_1"] = "_control.enemy_fleet_info.fight_result_ship_five.main.ship_name.ship_name_1",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_type"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_type",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/other_love/contrast"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.other_love.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/mvp_one"] = "_control.enemy_fleet_info.fight_result_ship_five.main.mvp_one",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main"] = "_control.enemy_fleet_info.fight_result_ship_four.main",
			["combat_result/user_fleet_info/fight_result_ship_two/main/college_skill/skill"] = "_control.user_fleet_info.fight_result_ship_two.main.college_skill.skill",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_up/up/love_up"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_up.up.love_up",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/smoke"] = "_control.enemy_fleet_info.fight_result_ship_four.main.smoke",
			["combat_result/user_fleet_info/fight_result_ship_two/main/college_skill/skill/shadow"] = "_control.user_fleet_info.fight_result_ship_two.main.college_skill.skill.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/ship_name/ship_name_1"] = "_control.enemy_fleet_info.fight_result_ship_six.main.ship_name.ship_name_1",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/mvp_one/bg"] = "_control.enemy_fleet_info.fight_result_ship_three.main.mvp_one.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/shadow"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_down/shadow"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_down.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/ship"] = "_control.enemy_fleet_info.fight_result_ship_four.main.ship",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/other_love/add"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.other_love.add",
			["combat_result/user_fleet_info/fight_result_ship_four/main"] = "_control.user_fleet_info.fight_result_ship_four.main",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/flag"] = "_control.enemy_fleet_info.fight_result_ship_two.main.flag",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_up/shadow"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_up.shadow",
			["combat_result/user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info/icon"] = "_control.user_fleet_info.fight_result_ship_six.main.college_skill.skill.college_info.icon",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/bg"] = "_control.enemy_fleet_info.fight_result_ship_three.main.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill/about_up/increase"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill.about_up.increase",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_hp/hp_bg"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_hp.hp_bg",
			["combat_result/user_fleet_info/fight_result_ship_two/main/college_skill/skill/college_info/contrast"] = "_control.user_fleet_info.fight_result_ship_two.main.college_skill.skill.college_info.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up/increase"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_up.increase",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/ship/ship_bg"] = "_control.enemy_fleet_info.fight_result_ship_three.main.ship.ship_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/mvp_one/mvp"] = "_control.enemy_fleet_info.fight_result_ship_five.main.mvp_one.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/mvp_two/mvp"] = "_control.enemy_fleet_info.fight_result_ship_five.main.mvp_two.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up/love_up"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_up.love_up",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/ship_name"] = "_control.enemy_fleet_info.fight_result_ship_five.main.ship_name",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_down/shadow"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_down.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/unknow"] = "_control.enemy_fleet_info.fight_result_ship_five.main.unknow",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/love_down"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.other_love.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_lv/bg"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_lv.bg",
			["combat_result/user_fleet_info/fight_result_ship_four/main/mvp_two/mvp"] = "_control.user_fleet_info.fight_result_ship_four.main.mvp_two.mvp",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/flag"] = "_control.enemy_fleet_info.fight_result_ship_six.main.flag",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_up"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_up",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_up/up/love_up"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_up.up.love_up",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_up/up/increase"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_up.up.increase",
			["combat_result/battlereport/reportbtn"] = "_control.battlereport.reportbtn",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down/subtract"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_down.love_down.love_down.subtract",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/other_love/shadow"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/other_love/love_down"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.other_love.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/top"] = "_control.enemy_fleet_info.fight_result_ship_five.main.top",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/other_love/add"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.other_love.add",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/other_love/shadow"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_four/main/college_skill/skill/shadow"] = "_control.user_fleet_info.fight_result_ship_four.main.college_skill.skill.shadow",
			["combat_result/user_fleet_info/fight_result_ship_five"] = "_control.user_fleet_info.fight_result_ship_five",
			["combat_result/user_fleet_info/fight_result_ship_five/main"] = "_control.user_fleet_info.fight_result_ship_five.main",
			["combat_result/user_fleet_info/fight_result_ship_five/main/bg"] = "_control.user_fleet_info.fight_result_ship_five.main.bg",
			["combat_result/enemy_info/eneny_name"] = "_control.enemy_info.eneny_name",
			["combat_result/user_fleet_info/fight_result_ship_five/main/unknow"] = "_control.user_fleet_info.fight_result_ship_five.main.unknow",
			["combat_result/user_fleet_info/fight_result_ship_five/main/ship"] = "_control.user_fleet_info.fight_result_ship_five.main.ship",
			["combat_result/user_fleet_info/fight_result_ship_five/main/ship/ship_bg"] = "_control.user_fleet_info.fight_result_ship_five.main.ship.ship_bg",
			["combat_result/user_fleet_info/fight_result_ship_five/main/ship/ship_icon"] = "_control.user_fleet_info.fight_result_ship_five.main.ship.ship_icon",
			["combat_result/user_fleet_info/fight_result_ship_three/main/ship_name"] = "_control.user_fleet_info.fight_result_ship_three.main.ship_name",
			["combat_result/user_fleet_info/fight_result_ship_five/main/top"] = "_control.user_fleet_info.fight_result_ship_five.main.top",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_lv"] = "_control.user_fleet_info.fight_result_ship_five.main.about_lv",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_lv/bg"] = "_control.user_fleet_info.fight_result_ship_five.main.about_lv.bg",
			["combat_result/user_exp/xie"] = "_control.user_exp.xie",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_lv/lv"] = "_control.user_fleet_info.fight_result_ship_five.main.about_lv.lv",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_type"] = "_control.user_fleet_info.fight_result_ship_five.main.about_type",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_type/bg"] = "_control.user_fleet_info.fight_result_ship_five.main.about_type.bg",
			["combat_result/user_fleet_info/fight_result_ship_four/main/flag"] = "_control.user_fleet_info.fight_result_ship_four.main.flag",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_type/type"] = "_control.user_fleet_info.fight_result_ship_five.main.about_type.type",
			["combat_result/user_fleet_info/fight_result_ship_five/main/ship_name"] = "_control.user_fleet_info.fight_result_ship_five.main.ship_name",
			["combat_result/user_fleet_info/fight_result_ship_five/main/ship_name/ship_name_1"] = "_control.user_fleet_info.fight_result_ship_five.main.ship_name.ship_name_1",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/mvp_two/mvp"] = "_control.enemy_fleet_info.fight_result_ship_one.main.mvp_two.mvp",
			["combat_result/user_fleet_info/fight_result_ship_one/main/bg"] = "_control.user_fleet_info.fight_result_ship_one.main.bg",
			["combat_result/user_fleet_info/fight_result_ship_five/main/ship_name/ship_name_2"] = "_control.user_fleet_info.fight_result_ship_five.main.ship_name.ship_name_2",
			["combat_result/user_fleet_info/fight_result_ship_five/main/flag"] = "_control.user_fleet_info.fight_result_ship_five.main.flag",
			["combat_result/user_fleet_info/fight_result_ship_four/main/college_skill"] = "_control.user_fleet_info.fight_result_ship_four.main.college_skill",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_hp"] = "_control.user_fleet_info.fight_result_ship_five.main.about_hp",
			["combat_result/user_fleet_info/fight_result_ship_four/main/mvp_one/mvp"] = "_control.user_fleet_info.fight_result_ship_four.main.mvp_one.mvp",
			["combat_result/countinue"] = "_control.countinue",
			["combat_result/user_fleet_info/fight_result_ship_four/main/top"] = "_control.user_fleet_info.fight_result_ship_four.main.top",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_hp/hp"] = "_control.user_fleet_info.fight_result_ship_five.main.about_hp.hp",
			["combat_result/user_fleet_info/fight_result_ship_five/main/mvp_one"] = "_control.user_fleet_info.fight_result_ship_five.main.mvp_one",
			["combat_result/user_fleet_info/fight_result_ship_five/main/mvp_one/bg"] = "_control.user_fleet_info.fight_result_ship_five.main.mvp_one.bg",
			["combat_result/user_fleet_info/fight_result_ship_five/main/mvp_one/mvp"] = "_control.user_fleet_info.fight_result_ship_five.main.mvp_one.mvp",
			["combat_result/user_fleet_info/fight_result_ship_five/main/mvp_two"] = "_control.user_fleet_info.fight_result_ship_five.main.mvp_two",
			["combat_result/user_fleet_info/fight_result_ship_five/main/mvp_two/bg"] = "_control.user_fleet_info.fight_result_ship_five.main.mvp_two.bg",
			["combat_result/user_fleet_info/fight_result_ship_five/main/mvp_two/mvp"] = "_control.user_fleet_info.fight_result_ship_five.main.mvp_two.mvp",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_up"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_up",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_up/shadow"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_up.shadow",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_up/up"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_up.up",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main"] = "_control.enemy_fleet_info.fight_result_ship_three.main",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_up/up/love_up"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_up.up.love_up",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_up/up/increase"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_up.up.increase",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_down"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_down",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_down/shadow"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_down.shadow",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_down.love_down",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/about_down/love_down/love_down"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.about_down.love_down.love_down",
			["combat_result/user_fleet_info/fight_result_ship_six/main/unknow"] = "_control.user_fleet_info.fight_result_ship_six.main.unknow",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_type/bg"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_type.bg",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/other_love"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.other_love",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/other_love/shadow"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/other_love"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.other_love",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/other_love/love_down"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.other_love.love_down",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/other_love/add"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.other_love.add",
			["combat_result/user_fleet_info/fight_result_ship_five/main/goodwill/other_love/contrast"] = "_control.user_fleet_info.fight_result_ship_five.main.goodwill.other_love.contrast",
			["combat_result/user_fleet_info/fight_result_ship_five/main/smoke"] = "_control.user_fleet_info.fight_result_ship_five.main.smoke",
			["combat_result/user_fleet_info/fight_result_ship_four/main/mvp_one/bg"] = "_control.user_fleet_info.fight_result_ship_four.main.mvp_one.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_lv/lv"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_lv.lv",
			["combat_result/user_fleet_info/fight_result_ship_five/main/college_skill"] = "_control.user_fleet_info.fight_result_ship_five.main.college_skill",
			["combat_result/user_fleet_info/fight_result_ship_five/main/college_skill/skill"] = "_control.user_fleet_info.fight_result_ship_five.main.college_skill.skill",
			["combat_result/get_booty/already_have_booty"] = "_control.get_booty.already_have_booty",
			["combat_result/user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info"] = "_control.user_fleet_info.fight_result_ship_five.main.college_skill.skill.college_info",
			["combat_result/user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info/icon"] = "_control.user_fleet_info.fight_result_ship_five.main.college_skill.skill.college_info.icon",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_type"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_type",
			["combat_result/dmg_set/line"] = "_control.dmg_set.line",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/about_hp/hp_bg"] = "_control.enemy_fleet_info.fight_result_ship_six.main.about_hp.hp_bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_up/shadow"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_up.shadow",
			["combat_result/user_fleet_info/fight_result_ship_six"] = "_control.user_fleet_info.fight_result_ship_six",
			["combat_result/user_fleet_info/fight_result_ship_six/main"] = "_control.user_fleet_info.fight_result_ship_six.main",
			["combat_result/user_fleet_info/fight_result_ship_six/main/bg"] = "_control.user_fleet_info.fight_result_ship_six.main.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_up/shadow"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_up.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill",
			["combat_result/user_fleet_info/fight_result_ship_one/main/about_lv/lv"] = "_control.user_fleet_info.fight_result_ship_one.main.about_lv.lv",
			["combat_result/user_fleet_info/fight_result_ship_six/main/ship"] = "_control.user_fleet_info.fight_result_ship_six.main.ship",
			["combat_result/user_fleet_info/fight_result_ship_six/main/ship/ship_bg"] = "_control.user_fleet_info.fight_result_ship_six.main.ship.ship_bg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/ship/ship_icon"] = "_control.user_fleet_info.fight_result_ship_six.main.ship.ship_icon",
			["combat_result/user_fleet_info/fight_result_ship_six/main/top"] = "_control.user_fleet_info.fight_result_ship_six.main.top",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_lv"] = "_control.user_fleet_info.fight_result_ship_six.main.about_lv",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/other_love/add"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.other_love.add",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_lv/bg"] = "_control.user_fleet_info.fight_result_ship_six.main.about_lv.bg",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_hp/hp_bg"] = "_control.user_fleet_info.fight_result_ship_four.main.about_hp.hp_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_three"] = "_control.enemy_fleet_info.fight_result_ship_three",
			["combat_result/user_fleet_info/fight_result_ship_four/main/mvp_one"] = "_control.user_fleet_info.fight_result_ship_four.main.mvp_one",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_lv/lv"] = "_control.user_fleet_info.fight_result_ship_six.main.about_lv.lv",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_type"] = "_control.user_fleet_info.fight_result_ship_six.main.about_type",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down/subtract"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_down.love_down.love_down.subtract",
			["combat_result/every_exp/main_one/exp_frame"] = "_control.every_exp.main_one.exp_frame",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_up/up/increase"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_up.up.increase",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_type/bg"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_type.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.other_love",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_type/type"] = "_control.user_fleet_info.fight_result_ship_six.main.about_type.type",
			["combat_result/user_fleet_info/fight_result_ship_six/main/ship_name"] = "_control.user_fleet_info.fight_result_ship_six.main.ship_name",
			["combat_result/fight_results/expimg"] = "_control.fight_results.expimg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/ship_name/ship_name_1"] = "_control.user_fleet_info.fight_result_ship_six.main.ship_name.ship_name_1",
			["combat_result/user_fleet_info/fight_result_ship_six/main/ship_name/ship_name_2"] = "_control.user_fleet_info.fight_result_ship_six.main.ship_name.ship_name_2",
			["combat_result/user_fleet_info/fight_result_ship_six/main/flag"] = "_control.user_fleet_info.fight_result_ship_six.main.flag",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_hp"] = "_control.user_fleet_info.fight_result_ship_six.main.about_hp",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_hp/hp_bg"] = "_control.user_fleet_info.fight_result_ship_six.main.about_hp.hp_bg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_hp/hp"] = "_control.user_fleet_info.fight_result_ship_six.main.about_hp.hp",
			["combat_result/user_fleet_info/fight_result_ship_six/main/mvp_one"] = "_control.user_fleet_info.fight_result_ship_six.main.mvp_one",
			["combat_result/user_fleet_info/fight_result_ship_six/main/mvp_one/bg"] = "_control.user_fleet_info.fight_result_ship_six.main.mvp_one.bg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/mvp_one/mvp"] = "_control.user_fleet_info.fight_result_ship_six.main.mvp_one.mvp",
			["combat_result/user_fleet_info/fight_result_ship_six/main/mvp_two"] = "_control.user_fleet_info.fight_result_ship_six.main.mvp_two",
			["combat_result/user_fleet_info/fight_result_ship_six/main/mvp_two/bg"] = "_control.user_fleet_info.fight_result_ship_six.main.mvp_two.bg",
			["combat_result/every_exp/main_two/remainexp"] = "_control.every_exp.main_two.remainexp",
			["combat_result/user_fleet_info/fight_result_ship_six/main/mvp_two/mvp"] = "_control.user_fleet_info.fight_result_ship_six.main.mvp_two.mvp",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_up"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_up",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_up/shadow"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_up.shadow",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_up/up"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_up.up",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_lv"] = "_control.user_fleet_info.fight_result_ship_four.main.about_lv",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_hp/hp"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_hp.hp",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_up/up/love_up"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_up.up.love_up",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_up/up/increase"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_up.up.increase",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_down"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_down",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_up/up"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_up.up",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_down/shadow"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_down.shadow",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_hp/hp_bg"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_hp.hp_bg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/about_down/love_down/love_down"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.about_down.love_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_lv/bg"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_lv.bg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/about_type/bg"] = "_control.user_fleet_info.fight_result_ship_six.main.about_type.bg",
			["combat_result/get_booty/get_num_booty/num"] = "_control.get_booty.get_num_booty.num",
			["combat_result/dmg_set/enemy_dmg_bg"] = "_control.dmg_set.enemy_dmg_bg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/other_love/love_down"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.other_love.love_down",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/other_love"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.other_love",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/other_love/add"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.other_love.add",
			["combat_result/user_fleet_info/fleet_bg"] = "_control.user_fleet_info.fleet_bg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/other_love/contrast"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.other_love.contrast",
			["combat_result/user_fleet_info/fleet_name/fleet_name_2"] = "_control.user_fleet_info.fleet_name.fleet_name_2",
			["combat_result/fight_results"] = "_control.fight_results",
			["combat_result/user_fleet_info/fight_result_ship_six/main/smoke"] = "_control.user_fleet_info.fight_result_ship_six.main.smoke",
			["combat_result/user_fleet_info/fight_result_ship_six/main/college_skill"] = "_control.user_fleet_info.fight_result_ship_six.main.college_skill",
			["combat_result/user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info"] = "_control.user_fleet_info.fight_result_ship_four.main.college_skill.skill.college_info",
			["combat_result/every_exp/main_six"] = "_control.every_exp.main_six",
			["combat_result/user_fleet_info/fight_result_ship_six/main/college_skill/skill"] = "_control.user_fleet_info.fight_result_ship_six.main.college_skill.skill",
			["combat_result/dmg_set/enemy_dmg"] = "_control.dmg_set.enemy_dmg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info"] = "_control.user_fleet_info.fight_result_ship_six.main.college_skill.skill.college_info",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_lv"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_lv",
			["combat_result/user_fleet_info/fight_result_ship_six/main/college_skill/skill/college_info/add"] = "_control.user_fleet_info.fight_result_ship_six.main.college_skill.skill.college_info.add",
			["combat_result/every_exp/main_two/exp_frame"] = "_control.every_exp.main_two.exp_frame",
			["combat_result/character/characterone"] = "_control.character.characterone",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/mvp_one"] = "_control.enemy_fleet_info.fight_result_ship_one.main.mvp_one",
			["combat_result/dmg_set/user_dmg"] = "_control.dmg_set.user_dmg",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/other_love/shadow"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.other_love.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_down.love_down",
			["combat_result/user_fleet_info/fight_result_ship_six/main/college_skill/skill/shadow"] = "_control.user_fleet_info.fight_result_ship_six.main.college_skill.skill.shadow",
			["combat_result/user_fleet_info/fight_result_ship_five/main/college_skill/skill/college_info/add"] = "_control.user_fleet_info.fight_result_ship_five.main.college_skill.skill.college_info.add",
			["combat_result/up_layer/line"] = "_control.up_layer.line",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/ship_name/ship_name_2"] = "_control.enemy_fleet_info.fight_result_ship_four.main.ship_name.ship_name_2",
			["combat_result/bonus_layer/item_title"] = "_control.bonus_layer.item_title",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/top"] = "_control.enemy_fleet_info.fight_result_ship_four.main.top",
			["combat_result/bonus_layer/item_main_four"] = "_control.bonus_layer.item_main_four",
			["combat_result/user_fleet_info/fight_result_ship_four/main/smoke"] = "_control.user_fleet_info.fight_result_ship_four.main.smoke",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up/shadow"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_up.shadow",
			["combat_result/bonus_layer/item_main_two/item"] = "_control.bonus_layer.item_main_two.item",
			["combat_result/user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info"] = "_control.user_fleet_info.fight_result_ship_one.main.college_skill.skill.college_info",
			["combat_result/user_fleet_info/fight_result_ship_one/main/flag"] = "_control.user_fleet_info.fight_result_ship_one.main.flag",
			["combat_result/bonus_layer/item_main_two/num"] = "_control.bonus_layer.item_main_two.num",
			["combat_result/bonus_layer/item_main_three"] = "_control.bonus_layer.item_main_three",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/mvp_two"] = "_control.enemy_fleet_info.fight_result_ship_one.main.mvp_two",
			["combat_result/bonus_layer/item_main_three/num"] = "_control.bonus_layer.item_main_three.num",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/mvp_two"] = "_control.enemy_fleet_info.fight_result_ship_three.main.mvp_two",
			["combat_result/user_fleet_info/fight_result_ship_four/main/unknow"] = "_control.user_fleet_info.fight_result_ship_four.main.unknow",
			["combat_result/user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info/add"] = "_control.user_fleet_info.fight_result_ship_one.main.college_skill.skill.college_info.add",
			["combat_result/report_bg/report_view/report"] = "_control.report_bg.report_view.report",
			["combat_result/user_fleet_info/fight_result_ship_four/main/bg"] = "_control.user_fleet_info.fight_result_ship_four.main.bg",
			["combat_result/bonus_layer/coreget"] = "_control.bonus_layer.coreget",
			["combat_result/bonus_layer/coreget/num"] = "_control.bonus_layer.coreget.num",
			["combat_result/get_booty"] = "_control.get_booty",
			["combat_result/get_booty/getword"] = "_control.get_booty.getword",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down/shadow"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_down.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/unknow"] = "_control.enemy_fleet_info.fight_result_ship_four.main.unknow",
			["combat_result/bonus_layer/item_main_three/item"] = "_control.bonus_layer.item_main_three.item",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_down/shadow"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_down.shadow",
			["combat_result/get_booty/get_num_booty/bg"] = "_control.get_booty.get_num_booty.bg",
			["combat_result/get_booty/get_num_booty/pangci"] = "_control.get_booty.get_num_booty.pangci",
			["combat_result/user_fleet_info/fight_result_ship_six/main/goodwill/other_love"] = "_control.user_fleet_info.fight_result_ship_six.main.goodwill.other_love",
			["combat_result/user_fleet_info/fight_result_ship_five/main/college_skill/skill/shadow"] = "_control.user_fleet_info.fight_result_ship_five.main.college_skill.skill.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/mvp_one/bg"] = "_control.enemy_fleet_info.fight_result_ship_four.main.mvp_one.bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_up"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_up",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up/love_up"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_up.love_up",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_down"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_down",
			["combat_result/get_booty/have_booty/icons"] = "_control.get_booty.have_booty.icons",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/ship"] = "_control.enemy_fleet_info.fight_result_ship_six.main.ship",
			["combat_result/score/resultword"] = "_control.score.resultword",
			["combat_result/bonus_layer/item_main_four/item"] = "_control.bonus_layer.item_main_four.item",
			["combat_result/score/spineparent"] = "_control.score.spineparent",
			["combat_result/user_fleet_info/fight_result_ship_five/main/about_hp/hp_bg"] = "_control.user_fleet_info.fight_result_ship_five.main.about_hp.hp_bg",
			["combat_result/closetwo"] = "_control.closetwo",
			["combat_result/battlereport"] = "_control.battlereport",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/ship_name/ship_name_1"] = "_control.enemy_fleet_info.fight_result_ship_two.main.ship_name.ship_name_1",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_down"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_down",
			["combat_result/enemy_fleet_info/fleet_name/fleet_name_1"] = "_control.enemy_fleet_info.fleet_name.fleet_name_1",
			["combat_result/enemy_info/lv"] = "_control.enemy_info.lv",
			["combat_result/user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info/contrast"] = "_control.user_fleet_info.fight_result_ship_four.main.college_skill.skill.college_info.contrast",
			["combat_result/user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info/icon"] = "_control.user_fleet_info.fight_result_ship_one.main.college_skill.skill.college_info.icon",
			["combat_result/report_bg/report_view"] = "_control.report_bg.report_view",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/mvp_two"] = "_control.enemy_fleet_info.fight_result_ship_six.main.mvp_two",
			["combat_result/report_bg"] = "_control.report_bg",
			["combat_result/bonus_layer/item_main_four/num"] = "_control.bonus_layer.item_main_four.num",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_down",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/other_love/add"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.other_love.add",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/bg"] = "_control.enemy_fleet_info.fight_result_ship_two.main.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main"] = "_control.enemy_fleet_info.fight_result_ship_one.main",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_type/type"] = "_control.user_fleet_info.fight_result_ship_two.main.about_type.type",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/ship_name/ship_name_2"] = "_control.enemy_fleet_info.fight_result_ship_three.main.ship_name.ship_name_2",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/shadow"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fleet_name/fleet_name_1"] = "_control.user_fleet_info.fleet_name.fleet_name_1",
			["combat_result/bonus_layer/get_item"] = "_control.bonus_layer.get_item",
			["combat_result/user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info/icon"] = "_control.user_fleet_info.fight_result_ship_four.main.college_skill.skill.college_info.icon",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_lv/lv"] = "_control.user_fleet_info.fight_result_ship_two.main.about_lv.lv",
			["combat_result/bonus_layer/coreget/sample"] = "_control.bonus_layer.coreget.sample",
			["combat_result/user_fleet_info/fight_result_ship_three/main/college_skill"] = "_control.user_fleet_info.fight_result_ship_three.main.college_skill",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_hp"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_hp",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_type/type"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_type.type",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_type"] = "_control.user_fleet_info.fight_result_ship_three.main.about_type",
			["combat_result/every_exp/main_three/remainexp"] = "_control.every_exp.main_three.remainexp",
			["combat_result/emptyimg"] = "_control.emptyimg",
			["combat_result/user_fleet_info/fight_result_ship_four/main/ship"] = "_control.user_fleet_info.fight_result_ship_four.main.ship",
			["combat_result/user_fleet_info/fight_result_ship_four/main/college_skill/skill/college_info/add"] = "_control.user_fleet_info.fight_result_ship_four.main.college_skill.skill.college_info.add",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_down"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_down",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_lv"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_lv",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down/subtract"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_down.subtract",
			["combat_result/every_exp/main_four"] = "_control.every_exp.main_four",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_lv/bg"] = "_control.user_fleet_info.fight_result_ship_four.main.about_lv.bg",
			["combat_result/bonus_layer/coreget/bottom_bg"] = "_control.bonus_layer.coreget.bottom_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/ship_name"] = "_control.enemy_fleet_info.fight_result_ship_two.main.ship_name",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_type"] = "_control.user_fleet_info.fight_result_ship_two.main.about_type",
			["combat_result/bonus_layer/coreget/bg"] = "_control.bonus_layer.coreget.bg",
			["combat_result/every_exp/main_three/remainword"] = "_control.every_exp.main_three.remainword",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/ship/ship_bg"] = "_control.enemy_fleet_info.fight_result_ship_five.main.ship.ship_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/about_up"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.about_up",
			["combat_result/user_fleet_info/fight_result_ship_three/main/mvp_two"] = "_control.user_fleet_info.fight_result_ship_three.main.mvp_two",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/goodwill/other_love/contrast"] = "_control.enemy_fleet_info.fight_result_ship_six.main.goodwill.other_love.contrast",
			["combat_result/user_fleet_info/fight_result_ship_four/main/ship_name/ship_name_1"] = "_control.user_fleet_info.fight_result_ship_four.main.ship_name.ship_name_1",
			["combat_result/every_exp/main_five/exp"] = "_control.every_exp.main_five.exp",
			["combat_result/enemy_fleet_info/fight_result_ship_four"] = "_control.enemy_fleet_info.fight_result_ship_four",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_hp"] = "_control.user_fleet_info.fight_result_ship_two.main.about_hp",
			["combat_result/every_exp/main_five/addexp"] = "_control.every_exp.main_five.addexp",
			["combat_result/user_fleet_info/fight_result_ship_two"] = "_control.user_fleet_info.fight_result_ship_two",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_type/bg"] = "_control.user_fleet_info.fight_result_ship_four.main.about_type.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/flag"] = "_control.enemy_fleet_info.fight_result_ship_four.main.flag",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill",
			["combat_result/user_fleet_info/fight_result_ship_four/main/ship/ship_icon"] = "_control.user_fleet_info.fight_result_ship_four.main.ship.ship_icon",
			["combat_result/every_exp/main_six/extra"] = "_control.every_exp.main_six.extra",
			["combat_result/mask"] = "_control.mask",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/ship"] = "_control.enemy_fleet_info.fight_result_ship_two.main.ship",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/smoke"] = "_control.enemy_fleet_info.fight_result_ship_three.main.smoke",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_type/bg"] = "_control.user_fleet_info.fight_result_ship_three.main.about_type.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/mvp_one/bg"] = "_control.enemy_fleet_info.fight_result_ship_six.main.mvp_one.bg",
			["combat_result/user_exp/lv"] = "_control.user_exp.lv",
			["combat_result/every_exp/main_three/frame"] = "_control.every_exp.main_three.frame",
			["combat_result/user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info/icon"] = "_control.user_fleet_info.fight_result_ship_three.main.college_skill.skill.college_info.icon",
			["combat_result/bg"] = "_control.bg",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down/love_down"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_down.love_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_lv"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_lv",
			["combat_result/user_fleet_info/fight_result_ship_three/main/ship/ship_bg"] = "_control.user_fleet_info.fight_result_ship_three.main.ship.ship_bg",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/about_hp/hp_bg"] = "_control.enemy_fleet_info.fight_result_ship_four.main.about_hp.hp_bg",
			["combat_result/user_fleet_info/fight_result_ship_two/main/mvp_two"] = "_control.user_fleet_info.fight_result_ship_two.main.mvp_two",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down/subtract"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_down.love_down.love_down.subtract",
			["combat_result/user_fleet_info/fight_result_ship_three/main/college_skill/skill"] = "_control.user_fleet_info.fight_result_ship_three.main.college_skill.skill",
			["combat_result/bonus_layer/item_main_one/num"] = "_control.bonus_layer.item_main_one.num",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/shadow"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.other_love.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/ship/ship_icon"] = "_control.enemy_fleet_info.fight_result_ship_three.main.ship.ship_icon",
			["combat_result/enemy_fleet_info/fight_result_ship_one"] = "_control.enemy_fleet_info.fight_result_ship_one",
			["combat_result/user_fleet_info/fight_result_ship_two/main/about_hp/hp"] = "_control.user_fleet_info.fight_result_ship_two.main.about_hp.hp",
			["combat_result/enemy_fleet_info"] = "_control.enemy_fleet_info",
			["combat_result/user_fleet_info/fight_result_ship_three/main/mvp_two/bg"] = "_control.user_fleet_info.fight_result_ship_three.main.mvp_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/about_lv/bg"] = "_control.enemy_fleet_info.fight_result_ship_two.main.about_lv.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info/add"] = "_control.user_fleet_info.fight_result_ship_three.main.college_skill.skill.college_info.add",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down/love_down"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_down.love_down.love_down",
			["combat_result/every_exp/main_six/addexp"] = "_control.every_exp.main_six.addexp",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/mvp_two/bg"] = "_control.enemy_fleet_info.fight_result_ship_five.main.mvp_two.bg",
			["combat_result/enemy_info/xie"] = "_control.enemy_info.xie",
			["combat_result/user_fleet_info/fight_result_ship_two/main/mvp_one"] = "_control.user_fleet_info.fight_result_ship_two.main.mvp_one",
			["combat_result/maskto"] = "_control.maskto",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up/increase"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_up.increase",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/ship/ship_icon"] = "_control.enemy_fleet_info.fight_result_ship_two.main.ship.ship_icon",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_up/up"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_up.up",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/ship_name/ship_name_2"] = "_control.enemy_fleet_info.fight_result_ship_six.main.ship_name.ship_name_2",
			["combat_result/user_fleet_info/fight_result_ship_one"] = "_control.user_fleet_info.fight_result_ship_one",
			["combat_result/enemy_fleet_info/fleet_name/fleet_name_2"] = "_control.enemy_fleet_info.fleet_name.fleet_name_2",
			["combat_result/user_fleet_info/fight_result_ship_four/main/college_skill/skill"] = "_control.user_fleet_info.fight_result_ship_four.main.college_skill.skill",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_up"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_up",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/ship_name"] = "_control.enemy_fleet_info.fight_result_ship_three.main.ship_name",
			["combat_result/user_exp"] = "_control.user_exp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/other_love/contrast"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.other_love.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/mvp_one"] = "_control.enemy_fleet_info.fight_result_ship_three.main.mvp_one",
			["combat_result/enemy_fleet_info/fight_result_ship_six/main/mvp_one"] = "_control.enemy_fleet_info.fight_result_ship_six.main.mvp_one",
			["combat_result/every_exp/main_five"] = "_control.every_exp.main_five",
			["combat_result/user_fleet_info/fight_result_ship_three/main/ship_name/ship_name_2"] = "_control.user_fleet_info.fight_result_ship_three.main.ship_name.ship_name_2",
			["combat_result/user_fleet_info/fight_result_ship_one/main/college_skill/skill/college_info/contrast"] = "_control.user_fleet_info.fight_result_ship_one.main.college_skill.skill.college_info.contrast",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/top"] = "_control.enemy_fleet_info.fight_result_ship_three.main.top",
			["combat_result/user_fleet_info/fight_result_ship_two/main/top"] = "_control.user_fleet_info.fight_result_ship_two.main.top",
			["combat_result/closeone"] = "_control.closeone",
			["combat_result/bonus_layer/item_main_two/bg"] = "_control.bonus_layer.item_main_two.bg",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/mvp_one/mvp"] = "_control.enemy_fleet_info.fight_result_ship_three.main.mvp_one.mvp",
			["combat_result/user_fleet_info/fight_result_ship_four/main/ship_name"] = "_control.user_fleet_info.fight_result_ship_four.main.ship_name",
			["combat_result/up_layer/fight_result"] = "_control.up_layer.fight_result",
			["combat_result/user_fleet_info/fight_result_ship_two/main/mvp_two/mvp"] = "_control.user_fleet_info.fight_result_ship_two.main.mvp_two.mvp",
			["combat_result/bonus_layer/item_main_one"] = "_control.bonus_layer.item_main_one",
			["combat_result/enemy_info/eneny_name/name_dd_1"] = "_control.enemy_info.eneny_name.name_dd_1",
			["combat_result/user_fleet_info/fight_result_ship_one/main/college_skill"] = "_control.user_fleet_info.fight_result_ship_one.main.college_skill",
			["combat_result/user_fleet_info/fight_result_ship_three/main/ship"] = "_control.user_fleet_info.fight_result_ship_three.main.ship",
			["combat_result/user_fleet_info/fight_result_ship_three/main/mvp_one/bg"] = "_control.user_fleet_info.fight_result_ship_three.main.mvp_one.bg",
			["combat_result/every_exp/main_five/exp_frame"] = "_control.every_exp.main_five.exp_frame",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/other_love/contrast"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.other_love.contrast",
			["combat_result/user_fleet_info/fight_result_ship_one/main/ship_name/ship_name_2"] = "_control.user_fleet_info.fight_result_ship_one.main.ship_name.ship_name_2",
			["combat_result/character/btn/text"] = "_control.character.btn.text",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main"] = "_control.enemy_fleet_info.fight_result_ship_five.main",
			["combat_result/every_exp/main_one"] = "_control.every_exp.main_one",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/about_lv/lv"] = "_control.enemy_fleet_info.fight_result_ship_five.main.about_lv.lv",
			["combat_result/bonus_layer/item_main_three/bg"] = "_control.bonus_layer.item_main_three.bg",
			["combat_result/score"] = "_control.score",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/about_down/subtract"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.about_down.subtract",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/goodwill/about_up/shadow"] = "_control.enemy_fleet_info.fight_result_ship_five.main.goodwill.about_up.shadow",
			["combat_result/every_exp/main_four/remainexp"] = "_control.every_exp.main_four.remainexp",
			["combat_result/every_exp/main_one/remainword"] = "_control.every_exp.main_one.remainword",
			["combat_result/enemy_fleet_info/fight_result_ship_two/main/goodwill"] = "_control.enemy_fleet_info.fight_result_ship_two.main.goodwill",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/about_up/increase"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.about_up.increase",
			["combat_result/user_fleet_info/fight_result_ship_four/main/goodwill/about_up/shadow"] = "_control.user_fleet_info.fight_result_ship_four.main.goodwill.about_up.shadow",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_hp/hp"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_hp.hp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_down/love_down/love_down"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_down.love_down.love_down",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/unknow"] = "_control.enemy_fleet_info.fight_result_ship_three.main.unknow",
			["combat_result/user_fleet_info/fight_result_ship_three/main/goodwill/about_up/up"] = "_control.user_fleet_info.fight_result_ship_three.main.goodwill.about_up.up",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/other_love/contrast"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.other_love.contrast",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_hp"] = "_control.user_fleet_info.fight_result_ship_four.main.about_hp",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.other_love",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/about_type/bg"] = "_control.enemy_fleet_info.fight_result_ship_three.main.about_type.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_hp/hp_bg"] = "_control.user_fleet_info.fight_result_ship_three.main.about_hp.hp_bg",
			["combat_result/every_exp/main_three/exp"] = "_control.every_exp.main_three.exp",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/mvp_one/mvp"] = "_control.enemy_fleet_info.fight_result_ship_four.main.mvp_one.mvp",
			["combat_result/every_exp/main_two"] = "_control.every_exp.main_two",
			["combat_result/enemy_fleet_info/fight_result_ship_three/main/goodwill/other_love/add"] = "_control.enemy_fleet_info.fight_result_ship_three.main.goodwill.other_love.add",
			["combat_result/user_fleet_info/fight_result_ship_three/main/bg"] = "_control.user_fleet_info.fight_result_ship_three.main.bg",
			["combat_result/user_fleet_info/fight_result_ship_three/main/about_lv"] = "_control.user_fleet_info.fight_result_ship_three.main.about_lv",
			["combat_result/user_fleet_info/fight_result_ship_four/main/about_hp/hp"] = "_control.user_fleet_info.fight_result_ship_four.main.about_hp.hp",
			["combat_result/user_fleet_info/fight_result_ship_three/main/college_skill/skill/college_info"] = "_control.user_fleet_info.fight_result_ship_three.main.college_skill.skill.college_info",
			["combat_result/bonus_layer/item_main_two"] = "_control.bonus_layer.item_main_two",
			["combat_result/character"] = "_control.character",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/other_love"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.other_love",
			["combat_result/user_fleet_info/fight_result_ship_three/main/mvp_one"] = "_control.user_fleet_info.fight_result_ship_three.main.mvp_one",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill",
			["combat_result/user_fleet_info/fight_result_ship_one/main/goodwill/about_down/love_down/subtract"] = "_control.user_fleet_info.fight_result_ship_one.main.goodwill.about_down.love_down.love_down.subtract",
			["combat_result/up_layer"] = "_control.up_layer",
			["combat_result/enemy_fleet_info/fight_result_ship_five/main/mvp_two"] = "_control.enemy_fleet_info.fight_result_ship_five.main.mvp_two",
			["combat_result/bonus_layer/coreget/item"] = "_control.bonus_layer.coreget.item",
			["combat_result/enemy_fleet_info/fight_result_ship_four/main/goodwill/about_down/love_down"] = "_control.enemy_fleet_info.fight_result_ship_four.main.goodwill.about_down.love_down",
			["combat_result/fight_results/unknowone"] = "_control.fight_results.unknowone",
			["combat_result/user_fleet_info/fight_result_ship_two/main/smoke"] = "_control.user_fleet_info.fight_result_ship_two.main.smoke",
			["combat_result/fight_results/unknowtwo"] = "_control.fight_results.unknowtwo",
			["combat_result/enemy_fleet_info/fight_result_ship_one/main/goodwill/other_love/shadow"] = "_control.enemy_fleet_info.fight_result_ship_one.main.goodwill.other_love.shadow",
			["combat_result/user_fleet_info/fight_result_ship_two/main/goodwill/about_down/love_down/love_down"] = "_control.user_fleet_info.fight_result_ship_two.main.goodwill.about_down.love_down.love_down"
		},
		click = {
			["character/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			closetwo = {
				tp = "UnityEngine.UI.Button"
			},
			closeone = {
				tp = "UnityEngine.UI.Button"
			},
			battlereport = {
				tp = "UnityEngine.UI.Button"
			},
			["report_bg/close"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

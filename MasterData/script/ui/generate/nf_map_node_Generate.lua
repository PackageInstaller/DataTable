return {
	_rule_ = {
		none = {
			empty_bg = {
				path = "empty_bg",
				list = {},
				component = {
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg = {
				path = "bg",
				list = {
					ship_layer = {
						path = "bg/ship_layer",
						list = {
							ship_icon = {
								path = "bg/ship_layer/ship_icon",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							encounter_effect = {
								path = "bg/ship_layer/encounter_effect",
								list = {
									encounter_spine = {
										path = "bg/ship_layer/encounter_effect/encounter_spine",
										list = {},
										component = {
											"Spine.Unity.SkeletonGraphic"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup"
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
					"UnityEngine.UI.Button",
					"PointerDownUpEvent"
				}
			},
			big_bg = {
				path = "big_bg",
				list = {},
				component = {}
			},
			return_btn = {
				path = "return_btn",
				list = {
					return_text = {
						path = "return_btn/return_text",
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
			left_people = {
				path = "left_people",
				list = {
					talk = {
						path = "left_people/talk",
						list = {
							bg1 = {
								path = "left_people/talk/bg1",
								list = {
									bg2 = {
										path = "left_people/talk/bg1/bg2",
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
							label_txt = {
								path = "left_people/talk/label_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.CanvasGroup",
							"PopVerticalAdaptive"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			left_bg = {
				path = "left_bg",
				list = {
					imagebackground = {
						path = "left_bg/imagebackground",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					icon = {
						path = "left_bg/icon",
						list = {
							skill_trans = {
								path = "left_bg/icon/skill_trans",
								list = {
									skill_bg = {
										path = "left_bg/icon/skill_trans/skill_bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									skill_title = {
										path = "left_bg/icon/skill_trans/skill_title",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									skill_line = {
										path = "left_bg/icon/skill_trans/skill_line",
										list = {},
										component = {}
									},
									skill_info = {
										path = "left_bg/icon/skill_trans/skill_info",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									skill_image = {
										path = "left_bg/icon/skill_trans/skill_image",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					buy_btn = {
						path = "left_bg/buy_btn",
						list = {
							info_text = {
								path = "left_bg/buy_btn/info_text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							count_text = {
								path = "left_bg/buy_btn/count_text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							icon = {
								path = "left_bg/buy_btn/icon",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					cur_icon = {
						path = "left_bg/cur_icon",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					static_cur = {
						path = "left_bg/static_cur",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					cur_count = {
						path = "left_bg/cur_count",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_text = {
						path = "left_bg/level_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					slider_bg = {
						path = "left_bg/slider_bg",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					slider = {
						path = "left_bg/slider",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					level_slider = {
						path = "left_bg/level_slider",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					six_line = {
						path = "left_bg/six_line",
						list = {},
						component = {}
					}
				},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			buff_btn = {
				path = "buff_btn",
				list = {
					open = {
						path = "buff_btn/open",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					buff_icon = {
						path = "buff_btn/buff_icon",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			right_bg = {
				path = "right_bg",
				list = {
					select_team_btn = {
						path = "right_bg/select_team_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					goto_btn = {
						path = "right_bg/goto_btn",
						list = {
							spine_effect = {
								path = "right_bg/goto_btn/spine_effect",
								list = {},
								component = {
									"Spine.Unity.SkeletonGraphic"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					select_text = {
						path = "right_bg/select_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					goto_text = {
						path = "right_bg/goto_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			select_node_layer = {
				path = "select_node_layer",
				list = {
					node_trans = {
						path = "select_node_layer/node_trans",
						list = {
							select_1 = {
								path = "select_node_layer/node_trans/select_1",
								list = {
									point = {
										path = "select_node_layer/node_trans/select_1/point",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									point_text = {
										path = "select_node_layer/node_trans/select_1/point_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									point_img = {
										path = "select_node_layer/node_trans/select_1/point_img",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "select_node_layer/node_trans/select_1/title",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									info_text = {
										path = "select_node_layer/node_trans/select_1/info_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									select_bg = {
										path = "select_node_layer/node_trans/select_1/select_bg",
										list = {
											select_bg2 = {
												path = "select_node_layer/node_trans/select_1/select_bg/select_bg2",
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
									mask = {
										path = "select_node_layer/node_trans/select_1/mask",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							select_2 = {
								path = "select_node_layer/node_trans/select_2",
								list = {
									point = {
										path = "select_node_layer/node_trans/select_2/point",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									point_text = {
										path = "select_node_layer/node_trans/select_2/point_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									point_img = {
										path = "select_node_layer/node_trans/select_2/point_img",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "select_node_layer/node_trans/select_2/title",
										list = {},
										component = {}
									},
									info_text = {
										path = "select_node_layer/node_trans/select_2/info_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									select_bg = {
										path = "select_node_layer/node_trans/select_2/select_bg",
										list = {
											select_bg2 = {
												path = "select_node_layer/node_trans/select_2/select_bg/select_bg2",
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
									mask = {
										path = "select_node_layer/node_trans/select_2/mask",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							select_3 = {
								path = "select_node_layer/node_trans/select_3",
								list = {
									point = {
										path = "select_node_layer/node_trans/select_3/point",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									point_text = {
										path = "select_node_layer/node_trans/select_3/point_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									point_img = {
										path = "select_node_layer/node_trans/select_3/point_img",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "select_node_layer/node_trans/select_3/title",
										list = {},
										component = {}
									},
									info_text = {
										path = "select_node_layer/node_trans/select_3/info_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									select_bg = {
										path = "select_node_layer/node_trans/select_3/select_bg",
										list = {
											select_bg2 = {
												path = "select_node_layer/node_trans/select_3/select_bg/select_bg2",
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
									mask = {
										path = "select_node_layer/node_trans/select_3/mask",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					static_text = {
						path = "select_node_layer/static_text",
						list = {
							Image = {
								path = "select_node_layer/static_text/Image",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							Text = {
								path = "select_node_layer/static_text/Text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					select_node_btn = {
						path = "select_node_layer/select_node_btn",
						list = {
							text = {
								path = "select_node_layer/select_node_btn/text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup"
				}
			},
			input_node = {
				path = "input_node",
				list = {
					field = {
						path = "input_node/field",
						list = {
							placeholder = {
								path = "input_node/field/placeholder",
								list = {},
								component = {}
							},
							text = {
								path = "input_node/field/text",
								list = {},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.InputField"
						}
					},
					enter = {
						path = "input_node/enter",
						list = {
							Text = {
								path = "input_node/enter/Text",
								list = {},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			},
			six_msgbox = {
				path = "six_msgbox",
				list = {
					black = {
						path = "six_msgbox/black",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					main = {
						path = "six_msgbox/main",
						list = {
							left = {
								path = "six_msgbox/main/left",
								list = {
									line = {
										path = "six_msgbox/main/left/line",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									light = {
										path = "six_msgbox/main/left/light",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									select = {
										path = "six_msgbox/main/left/select",
										list = {
											["1"] = {
												path = "six_msgbox/main/left/select/1",
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
									"UnityEngine.UI.Button"
								}
							},
							right = {
								path = "six_msgbox/main/right",
								list = {
									line = {
										path = "six_msgbox/main/right/line",
										list = {},
										component = {}
									},
									light = {
										path = "six_msgbox/main/right/light",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									select = {
										path = "six_msgbox/main/right/select",
										list = {
											["1"] = {
												path = "six_msgbox/main/right/select/1",
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
									"UnityEngine.UI.Button"
								}
							},
							word = {
								path = "six_msgbox/main/word",
								list = {
									text_one = {
										path = "six_msgbox/main/word/text_one",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									text_two = {
										path = "six_msgbox/main/word/text_two",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									text_three = {
										path = "six_msgbox/main/word/text_three",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									text_four = {
										path = "six_msgbox/main/word/text_four",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {}
							},
							line = {
								path = "six_msgbox/main/line",
								list = {},
								component = {}
							}
						},
						component = {
							"UIScaleTweener",
							"UIScaleTweener"
						}
					},
					select_msg_btn = {
						path = "six_msgbox/select_msg_btn",
						list = {
							text = {
								path = "six_msgbox/select_msg_btn/text",
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
				component = {
					"UnityEngine.Canvas"
				}
			},
			activity_select_two_buff = {
				path = "activity_select_two_buff",
				list = {
					bg = {
						path = "activity_select_two_buff/bg",
						list = {
							bg_frame = {
								path = "activity_select_two_buff/bg/bg_frame",
								list = {},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					bg_image = {
						path = "activity_select_two_buff/bg_image",
						list = {
							bg = {
								path = "activity_select_two_buff/bg_image/bg",
								list = {
									tip = {
										path = "activity_select_two_buff/bg_image/bg/tip",
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
							"UnityEngine.CanvasGroup"
						}
					},
					top = {
						path = "activity_select_two_buff/top",
						list = {
							title_image = {
								path = "activity_select_two_buff/top/title_image",
								list = {},
								component = {}
							},
							title_txt = {
								path = "activity_select_two_buff/top/title_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							coin = {
								path = "activity_select_two_buff/top/coin",
								list = {
									coin_image = {
										path = "activity_select_two_buff/top/coin/coin_image",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									coin_image_split = {
										path = "activity_select_two_buff/top/coin/coin_image_split",
										list = {},
										component = {}
									},
									coin_count = {
										path = "activity_select_two_buff/top/coin/coin_count",
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
							"UnityEngine.CanvasGroup"
						}
					},
					buff_array = {
						path = "activity_select_two_buff/buff_array",
						list = {
							buff_1 = {
								path = "activity_select_two_buff/buff_array/buff_1",
								list = {
									buff_name = {
										path = "activity_select_two_buff/buff_array/buff_1/buff_name",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									buff_bg = {
										path = "activity_select_two_buff/buff_array/buff_1/buff_bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									buff_img = {
										path = "activity_select_two_buff/buff_array/buff_1/buff_img",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									no_money = {
										path = "activity_select_two_buff/buff_array/buff_1/no_money",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									buff_text = {
										path = "activity_select_two_buff/buff_array/buff_1/buff_text",
										list = {
											buff_text_1 = {
												path = "activity_select_two_buff/buff_array/buff_1/buff_text/buff_text_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											buff_text_2 = {
												path = "activity_select_two_buff/buff_array/buff_1/buff_text/buff_text_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											buff_text_3 = {
												path = "activity_select_two_buff/buff_array/buff_1/buff_text/buff_text_3",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									select = {
										path = "activity_select_two_buff/buff_array/buff_1/select",
										list = {},
										component = {}
									},
									bottom_change = {
										path = "activity_select_two_buff/buff_array/buff_1/bottom_change",
										list = {
											cur_icon = {
												path = "activity_select_two_buff/buff_array/buff_1/bottom_change/cur_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											text_1 = {
												path = "activity_select_two_buff/buff_array/buff_1/bottom_change/text_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "activity_select_two_buff/buff_array/buff_1/bottom_change/num",
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
									bottom_use = {
										path = "activity_select_two_buff/buff_array/buff_1/bottom_use",
										list = {
											use = {
												path = "activity_select_two_buff/buff_array/buff_1/bottom_use/use",
												list = {},
												component = {}
											},
											text = {
												path = "activity_select_two_buff/buff_array/buff_1/bottom_use/text",
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
									"UnityEngine.UI.Button"
								}
							},
							buff_2 = {
								path = "activity_select_two_buff/buff_array/buff_2",
								list = {
									buff_name = {
										path = "activity_select_two_buff/buff_array/buff_2/buff_name",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									buff_bg = {
										path = "activity_select_two_buff/buff_array/buff_2/buff_bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									buff_img = {
										path = "activity_select_two_buff/buff_array/buff_2/buff_img",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									no_money = {
										path = "activity_select_two_buff/buff_array/buff_2/no_money",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									buff_text = {
										path = "activity_select_two_buff/buff_array/buff_2/buff_text",
										list = {
											buff_text_1 = {
												path = "activity_select_two_buff/buff_array/buff_2/buff_text/buff_text_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											buff_text_2 = {
												path = "activity_select_two_buff/buff_array/buff_2/buff_text/buff_text_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											buff_text_3 = {
												path = "activity_select_two_buff/buff_array/buff_2/buff_text/buff_text_3",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									select = {
										path = "activity_select_two_buff/buff_array/buff_2/select",
										list = {},
										component = {}
									},
									bottom_change = {
										path = "activity_select_two_buff/buff_array/buff_2/bottom_change",
										list = {
											cur_icon = {
												path = "activity_select_two_buff/buff_array/buff_2/bottom_change/cur_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											text_1 = {
												path = "activity_select_two_buff/buff_array/buff_2/bottom_change/text_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "activity_select_two_buff/buff_array/buff_2/bottom_change/num",
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
									bottom_use = {
										path = "activity_select_two_buff/buff_array/buff_2/bottom_use",
										list = {
											use = {
												path = "activity_select_two_buff/buff_array/buff_2/bottom_use/use",
												list = {},
												component = {}
											},
											text = {
												path = "activity_select_two_buff/buff_array/buff_2/bottom_use/text",
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
									"UnityEngine.UI.Button"
								}
							},
							buff_3 = {
								path = "activity_select_two_buff/buff_array/buff_3",
								list = {
									buff_name = {
										path = "activity_select_two_buff/buff_array/buff_3/buff_name",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									buff_bg = {
										path = "activity_select_two_buff/buff_array/buff_3/buff_bg",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									buff_img = {
										path = "activity_select_two_buff/buff_array/buff_3/buff_img",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									no_money = {
										path = "activity_select_two_buff/buff_array/buff_3/no_money",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									},
									buff_text = {
										path = "activity_select_two_buff/buff_array/buff_3/buff_text",
										list = {
											buff_text_1 = {
												path = "activity_select_two_buff/buff_array/buff_3/buff_text/buff_text_1",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											buff_text_2 = {
												path = "activity_select_two_buff/buff_array/buff_3/buff_text/buff_text_2",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											},
											buff_text_3 = {
												path = "activity_select_two_buff/buff_array/buff_3/buff_text/buff_text_3",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									select = {
										path = "activity_select_two_buff/buff_array/buff_3/select",
										list = {},
										component = {}
									},
									bottom_change = {
										path = "activity_select_two_buff/buff_array/buff_3/bottom_change",
										list = {
											cur_icon = {
												path = "activity_select_two_buff/buff_array/buff_3/bottom_change/cur_icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											text_1 = {
												path = "activity_select_two_buff/buff_array/buff_3/bottom_change/text_1",
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
									bottom_use = {
										path = "activity_select_two_buff/buff_array/buff_3/bottom_use",
										list = {
											use = {
												path = "activity_select_two_buff/buff_array/buff_3/bottom_use/use",
												list = {},
												component = {}
											},
											text = {
												path = "activity_select_two_buff/buff_array/buff_3/bottom_use/text",
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
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					bottom = {
						path = "activity_select_two_buff/bottom",
						list = {
							refresh_btn = {
								path = "activity_select_two_buff/bottom/refresh_btn",
								list = {
									title = {
										path = "activity_select_two_buff/bottom/refresh_btn/title",
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
							confirm_btn = {
								path = "activity_select_two_buff/bottom/confirm_btn",
								list = {
									title = {
										path = "activity_select_two_buff/bottom/confirm_btn/title",
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
							move_target = {
								path = "activity_select_two_buff/bottom/move_target",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							close = {
								path = "activity_select_two_buff/bottom/close",
								list = {
									title = {
										path = "activity_select_two_buff/bottom/close/title",
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
							confirm = {
								path = "activity_select_two_buff/bottom/confirm",
								list = {
									title = {
										path = "activity_select_two_buff/bottom/confirm/title",
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
						component = {
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.CanvasRenderer",
					"UnityEngine.Canvas"
				}
			},
			num = {
				path = "activity_select_two_buff/buff_array/buff_3/bottom_change/num",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			}
		},
		call_node_list = {
			["nf_map_node/input_node/enter/Text"] = "_control.input_node.enter.Text",
			["nf_map_node/six_msgbox/main/right"] = "_control.six_msgbox.main.right",
			["nf_map_node/right_bg"] = "_control.right_bg",
			["nf_map_node/activity_select_two_buff/bg/bg_frame"] = "_control.activity_select_two_buff.bg.bg_frame",
			["nf_map_node/six_msgbox/main/left/line"] = "_control.six_msgbox.main.left.line",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/buff_bg"] = "_control.activity_select_two_buff.buff_array.buff_1.buff_bg",
			["nf_map_node/select_node_layer/node_trans"] = "_control.select_node_layer.node_trans",
			["nf_map_node/activity_select_two_buff"] = "_control.activity_select_two_buff",
			["nf_map_node/empty_bg"] = "_control.empty_bg",
			["nf_map_node/six_msgbox/black"] = "_control.six_msgbox.black",
			["nf_map_node/big_bg"] = "_control.big_bg",
			["nf_map_node/activity_select_two_buff/bg"] = "_control.activity_select_two_buff.bg",
			["nf_map_node/select_node_layer/node_trans/select_1/select_bg/select_bg2"] = "_control.select_node_layer.node_trans.select_1.select_bg.select_bg2",
			["nf_map_node/six_msgbox"] = "_control.six_msgbox",
			["nf_map_node/activity_select_two_buff/bg_image"] = "_control.activity_select_two_buff.bg_image",
			["nf_map_node/input_node/field/text"] = "_control.input_node.field.text",
			["nf_map_node/select_node_layer/node_trans/select_3/mask"] = "_control.select_node_layer.node_trans.select_3.mask",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/buff_text/buff_text_2"] = "_control.activity_select_two_buff.buff_array.buff_1.buff_text.buff_text_2",
			["nf_map_node/select_node_layer/node_trans/select_3/select_bg/select_bg2"] = "_control.select_node_layer.node_trans.select_3.select_bg.select_bg2",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/buff_text/buff_text_3"] = "_control.activity_select_two_buff.buff_array.buff_1.buff_text.buff_text_3",
			["nf_map_node/select_node_layer/node_trans/select_3/point_img"] = "_control.select_node_layer.node_trans.select_3.point_img",
			["nf_map_node/input_node/field"] = "_control.input_node.field",
			["nf_map_node/activity_select_two_buff/top/title_txt"] = "_control.activity_select_two_buff.top.title_txt",
			["nf_map_node/six_msgbox/main/right/line"] = "_control.six_msgbox.main.right.line",
			["nf_map_node/left_bg/icon/skill_trans/skill_line"] = "_control.left_bg.icon.skill_trans.skill_line",
			["nf_map_node/six_msgbox/main/word/text_one"] = "_control.six_msgbox.main.word.text_one",
			["nf_map_node/select_node_layer/node_trans/select_3/title"] = "_control.select_node_layer.node_trans.select_3.title",
			["nf_map_node/select_node_layer/node_trans/select_3/select_bg"] = "_control.select_node_layer.node_trans.select_3.select_bg",
			["nf_map_node/select_node_layer/node_trans/select_3/point_text"] = "_control.select_node_layer.node_trans.select_3.point_text",
			["nf_map_node/select_node_layer/node_trans/select_3/point"] = "_control.select_node_layer.node_trans.select_3.point",
			["nf_map_node/six_msgbox/select_msg_btn/text"] = "_control.six_msgbox.select_msg_btn.text",
			["nf_map_node/bg/ship_layer/encounter_effect/encounter_spine"] = "_control.bg.ship_layer.encounter_effect.encounter_spine",
			["nf_map_node/select_node_layer/node_trans/select_1/select_bg"] = "_control.select_node_layer.node_trans.select_1.select_bg",
			["nf_map_node/left_bg/cur_count"] = "_control.left_bg.cur_count",
			["nf_map_node/select_node_layer/node_trans/select_3/info_text"] = "_control.select_node_layer.node_trans.select_3.info_text",
			["nf_map_node/bg/ship_layer/ship_icon"] = "_control.bg.ship_layer.ship_icon",
			["nf_map_node/six_msgbox/main/left/select/1"] = "_control.six_msgbox.main.left.select.1",
			["nf_map_node/left_bg/icon/skill_trans/skill_bg"] = "_control.left_bg.icon.skill_trans.skill_bg",
			["nf_map_node/left_bg/buy_btn/icon"] = "_control.left_bg.buy_btn.icon",
			["nf_map_node/select_node_layer/node_trans/select_2/point_img"] = "_control.select_node_layer.node_trans.select_2.point_img",
			["nf_map_node/select_node_layer/node_trans/select_1/title"] = "_control.select_node_layer.node_trans.select_1.title",
			["nf_map_node/select_node_layer/node_trans/select_2/point"] = "_control.select_node_layer.node_trans.select_2.point",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3"] = "_control.activity_select_two_buff.buff_array.buff_3",
			["nf_map_node/left_bg/icon/skill_trans"] = "_control.left_bg.icon.skill_trans",
			["nf_map_node/left_bg/six_line"] = "_control.left_bg.six_line",
			["nf_map_node/select_node_layer/node_trans/select_2/select_bg"] = "_control.select_node_layer.node_trans.select_2.select_bg",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1"] = "_control.activity_select_two_buff.buff_array.buff_1",
			["nf_map_node/select_node_layer/node_trans/select_1/point_text"] = "_control.select_node_layer.node_trans.select_1.point_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2"] = "_control.activity_select_two_buff.buff_array.buff_2",
			["nf_map_node/select_node_layer/node_trans/select_2/info_text"] = "_control.select_node_layer.node_trans.select_2.info_text",
			["nf_map_node/six_msgbox/main/right/select"] = "_control.six_msgbox.main.right.select",
			["nf_map_node/select_node_layer/node_trans/select_2"] = "_control.select_node_layer.node_trans.select_2",
			["nf_map_node/select_node_layer/node_trans/select_2/mask"] = "_control.select_node_layer.node_trans.select_2.mask",
			["nf_map_node/buff_btn/open"] = "_control.buff_btn.open",
			["nf_map_node/select_node_layer/node_trans/select_1/point_img"] = "_control.select_node_layer.node_trans.select_1.point_img",
			["nf_map_node/left_people/talk/label_txt"] = "_control.left_people.talk.label_txt",
			["nf_map_node/activity_select_two_buff/top/coin"] = "_control.activity_select_two_buff.top.coin",
			["nf_map_node/select_node_layer/node_trans/select_1/info_text"] = "_control.select_node_layer.node_trans.select_1.info_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/bottom_change"] = "_control.activity_select_two_buff.buff_array.buff_1.bottom_change",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/bottom_change/cur_icon"] = "_control.activity_select_two_buff.buff_array.buff_1.bottom_change.cur_icon",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/bottom_use"] = "_control.activity_select_two_buff.buff_array.buff_1.bottom_use",
			["nf_map_node/bg/ship_layer"] = "_control.bg.ship_layer",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/bottom_use/text"] = "_control.activity_select_two_buff.buff_array.buff_1.bottom_use.text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/buff_text/buff_text_1"] = "_control.activity_select_two_buff.buff_array.buff_1.buff_text.buff_text_1",
			["nf_map_node/select_node_layer/node_trans/select_1/point"] = "_control.select_node_layer.node_trans.select_1.point",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/buff_name"] = "_control.activity_select_two_buff.buff_array.buff_2.buff_name",
			["nf_map_node/select_node_layer/static_text"] = "_control.select_node_layer.static_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/buff_bg"] = "_control.activity_select_two_buff.buff_array.buff_2.buff_bg",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/buff_img"] = "_control.activity_select_two_buff.buff_array.buff_2.buff_img",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/no_money"] = "_control.activity_select_two_buff.buff_array.buff_2.no_money",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/buff_text"] = "_control.activity_select_two_buff.buff_array.buff_2.buff_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/buff_text/buff_text_1"] = "_control.activity_select_two_buff.buff_array.buff_2.buff_text.buff_text_1",
			["nf_map_node/left_bg/static_cur"] = "_control.left_bg.static_cur",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/buff_text/buff_text_2"] = "_control.activity_select_two_buff.buff_array.buff_2.buff_text.buff_text_2",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/buff_text/buff_text_3"] = "_control.activity_select_two_buff.buff_array.buff_2.buff_text.buff_text_3",
			["nf_map_node/activity_select_two_buff/bg_image/bg"] = "_control.activity_select_two_buff.bg_image.bg",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/select"] = "_control.activity_select_two_buff.buff_array.buff_2.select",
			["nf_map_node/select_node_layer/node_trans/select_1"] = "_control.select_node_layer.node_trans.select_1",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/bottom_change"] = "_control.activity_select_two_buff.buff_array.buff_2.bottom_change",
			["nf_map_node/select_node_layer/select_node_btn/text"] = "_control.select_node_layer.select_node_btn.text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/bottom_change/cur_icon"] = "_control.activity_select_two_buff.buff_array.buff_2.bottom_change.cur_icon",
			["nf_map_node/six_msgbox/select_msg_btn"] = "_control.six_msgbox.select_msg_btn",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/bottom_change/text_1"] = "_control.activity_select_two_buff.buff_array.buff_2.bottom_change.text_1",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/bottom_change/num"] = "_control.activity_select_two_buff.buff_array.buff_2.bottom_change.num",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/bottom_use"] = "_control.activity_select_two_buff.buff_array.buff_2.bottom_use",
			["nf_map_node/return_btn/return_text"] = "_control.return_btn.return_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/bottom_use/use"] = "_control.activity_select_two_buff.buff_array.buff_2.bottom_use.use",
			["nf_map_node/activity_select_two_buff/buff_array/buff_2/bottom_use/text"] = "_control.activity_select_two_buff.buff_array.buff_2.bottom_use.text",
			["nf_map_node/buff_btn"] = "_control.buff_btn",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/buff_name"] = "_control.activity_select_two_buff.buff_array.buff_3.buff_name",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/buff_bg"] = "_control.activity_select_two_buff.buff_array.buff_3.buff_bg",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/buff_img"] = "_control.activity_select_two_buff.buff_array.buff_3.buff_img",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/no_money"] = "_control.activity_select_two_buff.buff_array.buff_3.no_money",
			["nf_map_node/select_node_layer/node_trans/select_2/select_bg/select_bg2"] = "_control.select_node_layer.node_trans.select_2.select_bg.select_bg2",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/buff_text"] = "_control.activity_select_two_buff.buff_array.buff_3.buff_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/bottom_change/num"] = "_control.activity_select_two_buff.buff_array.buff_1.bottom_change.num",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/buff_text/buff_text_1"] = "_control.activity_select_two_buff.buff_array.buff_3.buff_text.buff_text_1",
			["nf_map_node/six_msgbox/main/word"] = "_control.six_msgbox.main.word",
			["nf_map_node/six_msgbox/main/word/text_two"] = "_control.six_msgbox.main.word.text_two",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/buff_text/buff_text_2"] = "_control.activity_select_two_buff.buff_array.buff_3.buff_text.buff_text_2",
			["nf_map_node/select_node_layer/static_text/Image"] = "_control.select_node_layer.static_text.Image",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/buff_text/buff_text_3"] = "_control.activity_select_two_buff.buff_array.buff_3.buff_text.buff_text_3",
			["nf_map_node/six_msgbox/main"] = "_control.six_msgbox.main",
			["nf_map_node/select_node_layer/node_trans/select_2/point_text"] = "_control.select_node_layer.node_trans.select_2.point_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/select"] = "_control.activity_select_two_buff.buff_array.buff_3.select",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/bottom_change"] = "_control.activity_select_two_buff.buff_array.buff_3.bottom_change",
			["nf_map_node/return_btn"] = "_control.return_btn",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/bottom_change/cur_icon"] = "_control.activity_select_two_buff.buff_array.buff_3.bottom_change.cur_icon",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/bottom_change/text_1"] = "_control.activity_select_two_buff.buff_array.buff_3.bottom_change.text_1",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/bottom_change/num"] = "_control.num",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/bottom_change/text_1"] = "_control.activity_select_two_buff.buff_array.buff_1.bottom_change.text_1",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/bottom_use"] = "_control.activity_select_two_buff.buff_array.buff_3.bottom_use",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/bottom_use/use"] = "_control.activity_select_two_buff.buff_array.buff_3.bottom_use.use",
			["nf_map_node/six_msgbox/main/right/select/1"] = "_control.six_msgbox.main.right.select.1",
			["nf_map_node/buff_btn/buff_icon"] = "_control.buff_btn.buff_icon",
			["nf_map_node/activity_select_two_buff/buff_array/buff_3/bottom_use/text"] = "_control.activity_select_two_buff.buff_array.buff_3.bottom_use.text",
			["nf_map_node/activity_select_two_buff/bottom/refresh_btn/title"] = "_control.activity_select_two_buff.bottom.refresh_btn.title",
			["nf_map_node/activity_select_two_buff/bottom/confirm_btn"] = "_control.activity_select_two_buff.bottom.confirm_btn",
			["nf_map_node/six_msgbox/main/word/text_three"] = "_control.six_msgbox.main.word.text_three",
			["nf_map_node/activity_select_two_buff/bottom/confirm_btn/title"] = "_control.activity_select_two_buff.bottom.confirm_btn.title",
			["nf_map_node/left_bg/icon"] = "_control.left_bg.icon",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/buff_name"] = "_control.activity_select_two_buff.buff_array.buff_1.buff_name",
			["nf_map_node/activity_select_two_buff/bottom/close"] = "_control.activity_select_two_buff.bottom.close",
			["nf_map_node/activity_select_two_buff/bottom/confirm/title"] = "_control.activity_select_two_buff.bottom.confirm.title",
			["nf_map_node/left_bg/slider_bg"] = "_control.left_bg.slider_bg",
			["nf_map_node/select_node_layer/select_node_btn"] = "_control.select_node_layer.select_node_btn",
			["nf_map_node/activity_select_two_buff/bottom/confirm"] = "_control.activity_select_two_buff.bottom.confirm",
			["nf_map_node/right_bg/goto_text"] = "_control.right_bg.goto_text",
			["nf_map_node/bg"] = "_control.bg",
			["nf_map_node/right_bg/goto_btn"] = "_control.right_bg.goto_btn",
			["nf_map_node/activity_select_two_buff/bottom/close/title"] = "_control.activity_select_two_buff.bottom.close.title",
			["nf_map_node/left_bg"] = "_control.left_bg",
			["nf_map_node/left_bg/icon/skill_trans/skill_title"] = "_control.left_bg.icon.skill_trans.skill_title",
			["nf_map_node/left_bg/slider"] = "_control.left_bg.slider",
			["nf_map_node/select_node_layer/node_trans/select_3"] = "_control.select_node_layer.node_trans.select_3",
			["nf_map_node/bg/ship_layer/encounter_effect"] = "_control.bg.ship_layer.encounter_effect",
			["nf_map_node/left_people/talk/bg1"] = "_control.left_people.talk.bg1",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/select"] = "_control.activity_select_two_buff.buff_array.buff_1.select",
			["nf_map_node/activity_select_two_buff/bottom"] = "_control.activity_select_two_buff.bottom",
			["nf_map_node/activity_select_two_buff/bg_image/bg/tip"] = "_control.activity_select_two_buff.bg_image.bg.tip",
			["nf_map_node/right_bg/goto_btn/spine_effect"] = "_control.right_bg.goto_btn.spine_effect",
			["nf_map_node/activity_select_two_buff/top/coin/coin_count"] = "_control.activity_select_two_buff.top.coin.coin_count",
			["nf_map_node/input_node/field/placeholder"] = "_control.input_node.field.placeholder",
			["nf_map_node/left_bg/buy_btn"] = "_control.left_bg.buy_btn",
			["nf_map_node/six_msgbox/main/right/light"] = "_control.six_msgbox.main.right.light",
			["nf_map_node/left_bg/buy_btn/info_text"] = "_control.left_bg.buy_btn.info_text",
			["nf_map_node/select_node_layer"] = "_control.select_node_layer",
			["nf_map_node/activity_select_two_buff/buff_array"] = "_control.activity_select_two_buff.buff_array",
			["nf_map_node/right_bg/select_text"] = "_control.right_bg.select_text",
			["nf_map_node/left_bg/level_text"] = "_control.left_bg.level_text",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/bottom_use/use"] = "_control.activity_select_two_buff.buff_array.buff_1.bottom_use.use",
			["nf_map_node/six_msgbox/main/left/light"] = "_control.six_msgbox.main.left.light",
			["nf_map_node/left_bg/buy_btn/count_text"] = "_control.left_bg.buy_btn.count_text",
			["nf_map_node/select_node_layer/static_text/Text"] = "_control.select_node_layer.static_text.Text",
			["nf_map_node/six_msgbox/main/line"] = "_control.six_msgbox.main.line",
			["nf_map_node/activity_select_two_buff/bottom/move_target"] = "_control.activity_select_two_buff.bottom.move_target",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/no_money"] = "_control.activity_select_two_buff.buff_array.buff_1.no_money",
			["nf_map_node/input_node/enter"] = "_control.input_node.enter",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/buff_img"] = "_control.activity_select_two_buff.buff_array.buff_1.buff_img",
			["nf_map_node/right_bg/select_team_btn"] = "_control.right_bg.select_team_btn",
			["nf_map_node/activity_select_two_buff/bottom/refresh_btn"] = "_control.activity_select_two_buff.bottom.refresh_btn",
			["nf_map_node/activity_select_two_buff/buff_array/buff_1/buff_text"] = "_control.activity_select_two_buff.buff_array.buff_1.buff_text",
			["nf_map_node/select_node_layer/node_trans/select_1/mask"] = "_control.select_node_layer.node_trans.select_1.mask",
			["nf_map_node/activity_select_two_buff/top/coin/coin_image"] = "_control.activity_select_two_buff.top.coin.coin_image",
			["nf_map_node/six_msgbox/main/word/text_four"] = "_control.six_msgbox.main.word.text_four",
			["nf_map_node/left_bg/level_slider"] = "_control.left_bg.level_slider",
			["nf_map_node/input_node"] = "_control.input_node",
			["nf_map_node/activity_select_two_buff/top/title_image"] = "_control.activity_select_two_buff.top.title_image",
			["nf_map_node/select_node_layer/node_trans/select_2/title"] = "_control.select_node_layer.node_trans.select_2.title",
			["nf_map_node/left_people/talk/bg1/bg2"] = "_control.left_people.talk.bg1.bg2",
			["nf_map_node/six_msgbox/main/left/select"] = "_control.six_msgbox.main.left.select",
			["nf_map_node/left_people/talk"] = "_control.left_people.talk",
			["nf_map_node/activity_select_two_buff/top"] = "_control.activity_select_two_buff.top",
			["nf_map_node/left_people"] = "_control.left_people",
			["nf_map_node/left_bg/cur_icon"] = "_control.left_bg.cur_icon",
			["nf_map_node/left_bg/icon/skill_trans/skill_image"] = "_control.left_bg.icon.skill_trans.skill_image",
			["nf_map_node/left_bg/icon/skill_trans/skill_info"] = "_control.left_bg.icon.skill_trans.skill_info",
			["nf_map_node/left_bg/imagebackground"] = "_control.left_bg.imagebackground",
			["nf_map_node/activity_select_two_buff/top/coin/coin_image_split"] = "_control.activity_select_two_buff.top.coin.coin_image_split",
			["nf_map_node/six_msgbox/main/left"] = "_control.six_msgbox.main.left"
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			},
			return_btn = {
				tp = "UnityEngine.UI.Button"
			},
			left_people = {
				tp = "UnityEngine.UI.Button"
			},
			["left_bg/icon/skill_trans"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_bg/buy_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			buff_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["right_bg/select_team_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_bg/goto_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_node_layer/node_trans/select_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_node_layer/node_trans/select_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_node_layer/node_trans/select_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_node_layer/select_node_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["input_node/enter"] = {
				tp = "UnityEngine.UI.Button"
			},
			["six_msgbox/main/left"] = {
				tp = "UnityEngine.UI.Button"
			},
			["six_msgbox/main/right"] = {
				tp = "UnityEngine.UI.Button"
			},
			["six_msgbox/select_msg_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/buff_array/buff_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/buff_array/buff_1/bottom_change"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/buff_array/buff_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/buff_array/buff_2/bottom_change"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/buff_array/buff_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/buff_array/buff_3/bottom_change"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/bottom/refresh_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/bottom/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/bottom/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["activity_select_two_buff/bottom/confirm"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click_and_pointer_up = {
			["left_bg/icon"] = {
				tp = "ClickAndLongClickAndPointerUpEvent"
			}
		},
		pointer_down_up = {
			bg = {
				tp = "PointerDownUpEvent"
			}
		},
		canvas_set = {
			six_msgbox = {
				component = "UnityEngine.Canvas",
				path = "six_msgbox"
			},
			activity_select_two_buff = {
				component = "UnityEngine.Canvas",
				path = "activity_select_two_buff"
			}
		}
	}
}

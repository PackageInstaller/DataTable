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
			shine = {
				path = "shine",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			left_seq = {
				path = "left_seq",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			right_seq = {
				path = "right_seq",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			skin_layer_seq = {
				path = "skin_layer_seq",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			left = {
				path = "left",
				list = {
					ship_role = {
						path = "left/ship_role",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIMoveTweener",
							"UIMoveTweener",
							"UIMoveTweener",
							"UIMoveTweener",
							"UnityEngine.UI.ContentSizeFitter",
							"ShipViewControl"
						}
					},
					drag_for_switch = {
						path = "left/drag_for_switch",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"SwitchByDrag",
							"UITweenSequence"
						}
					},
					return_btn = {
						path = "left/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					alone_view_btn = {
						path = "left/alone_view_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					ship_info = {
						path = "left/ship_info",
						list = {
							info_bg = {
								path = "left/ship_info/info_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							dot_icon = {
								path = "left/ship_info/dot_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							country_txt = {
								path = "left/ship_info/country_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_type = {
								path = "left/ship_info/ship_type",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			right = {
				path = "right",
				list = {
					ship_detail = {
						path = "right/ship_detail",
						list = {
							detail_info = {
								path = "right/ship_detail/detail_info",
								list = {
									attr_info_bg = {
										path = "right/ship_detail/detail_info/attr_info_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									detail = {
										path = "right/ship_detail/detail_info/detail",
										list = {
											ship_icon = {
												path = "right/ship_detail/detail_info/detail/ship_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_star = {
												path = "right/ship_detail/detail_info/detail/ship_star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											change_icon = {
												path = "right/ship_detail/detail_info/detail/change_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_hp = {
												path = "right/ship_detail/detail_info/detail/attr_hp",
												list = {
													hp = {
														path = "right/ship_detail/detail_info/detail/attr_hp/hp",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_hp/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_hp/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_hp/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_atk",
												list = {
													atk = {
														path = "right/ship_detail/detail_info/detail/attr_atk/atk",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_atk/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_atk/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_atk/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_def",
												list = {
													def = {
														path = "right/ship_detail/detail_info/detail/attr_def/def",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_def/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_def/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_def/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_torpedo",
												list = {
													torpedo = {
														path = "right/ship_detail/detail_info/detail/attr_torpedo/torpedo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_torpedo/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_torpedo/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_torpedo/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_miss",
												list = {
													miss = {
														path = "right/ship_detail/detail_info/detail/attr_miss/miss",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_miss/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_miss/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_miss/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_airdef",
												list = {
													airdef = {
														path = "right/ship_detail/detail_info/detail/attr_airdef/airdef",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_airdef/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_airdef/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_airdef/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_capacity",
												list = {
													capacity = {
														path = "right/ship_detail/detail_info/detail/attr_capacity/capacity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_capacity/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_capacity/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_capacity/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_antisub",
												list = {
													antisub = {
														path = "right/ship_detail/detail_info/detail/attr_antisub/antisub",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_antisub/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_antisub/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_antisub/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_speed",
												list = {
													speed = {
														path = "right/ship_detail/detail_info/detail/attr_speed/speed",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_speed/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_speed/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_speed/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_radar",
												list = {
													radar = {
														path = "right/ship_detail/detail_info/detail/attr_radar/radar",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_radar/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_radar/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_radar/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_range",
												list = {
													range = {
														path = "right/ship_detail/detail_info/detail/attr_range/range",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_range/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_range/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_range/tip_icon",
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
												path = "right/ship_detail/detail_info/detail/attr_luck",
												list = {
													luck = {
														path = "right/ship_detail/detail_info/detail/attr_luck/luck",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_detail/detail_info/detail/attr_luck/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_detail/detail_info/detail/attr_luck/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_detail/detail_info/detail/attr_luck/tip_icon",
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
											skill_name = {
												path = "right/ship_detail/detail_info/detail/skill_name",
												list = {
													text = {
														path = "right/ship_detail/detail_info/detail/skill_name/text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													text_2 = {
														path = "right/ship_detail/detail_info/detail/skill_name/text_2",
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
											ship_skill = {
												path = "right/ship_detail/detail_info/detail/ship_skill",
												list = {
													skill_level = {
														path = "right/ship_detail/detail_info/detail/ship_skill/skill_level",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													skill_stage = {
														path = "right/ship_detail/detail_info/detail/ship_skill/skill_stage",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													},
													skill_phase = {
														path = "right/ship_detail/detail_info/detail/ship_skill/skill_phase",
														list = {
															skill_phase_1 = {
																path = "right/ship_detail/detail_info/detail/ship_skill/skill_phase/skill_phase_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															skill_phase_2 = {
																path = "right/ship_detail/detail_info/detail/ship_skill/skill_phase/skill_phase_2",
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
													scrollview = {
														path = "right/ship_detail/detail_info/detail/ship_skill/scrollview",
														list = {
															content = {
																path = "right/ship_detail/detail_info/detail/ship_skill/scrollview/content",
																list = {
																	skill_desc = {
																		path = "right/ship_detail/detail_info/detail/ship_skill/scrollview/content/skill_desc",
																		list = {
																			skill_desc_2 = {
																				path = "right/ship_detail/detail_info/detail/ship_skill/scrollview/content/skill_desc/skill_desc_2",
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
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.ContentSizeFitter"
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
															"UnityEngine.UI.ScrollRect",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Mask"
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
							ship_title = {
								path = "right/ship_detail/ship_title",
								list = {
									title_bg = {
										path = "right/ship_detail/ship_title/title_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_level = {
										path = "right/ship_detail/ship_title/ship_level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									ship_name_move = {
										path = "right/ship_detail/ship_title/ship_name_move",
										list = {
											ship_name = {
												path = "right/ship_detail/ship_title/ship_name_move/ship_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name_move = {
												path = "right/ship_detail/ship_title/ship_name_move/ship_name_move",
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
									ship_name = {
										path = "right/ship_detail/ship_title/ship_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									ship_exp = {
										path = "right/ship_detail/ship_title/ship_exp",
										list = {
											exp_bg = {
												path = "right/ship_detail/ship_title/ship_exp/exp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											exp_bar = {
												path = "right/ship_detail/ship_title/ship_exp/exp_bar",
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
									exp_icon = {
										path = "right/ship_detail/ship_title/exp_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									exp_num = {
										path = "right/ship_detail/ship_title/exp_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									strengthen_btn = {
										path = "right/ship_detail/ship_title/strengthen_btn",
										list = {
											Text = {
												path = "right/ship_detail/ship_title/strengthen_btn/Text",
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
							ship_equip = {
								path = "right/ship_detail/ship_equip",
								list = {
									equip_bg = {
										path = "right/ship_detail/ship_equip/equip_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_icon = {
										path = "right/ship_detail/ship_equip/title_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									shipinfocurrentequips = {
										path = "right/ship_detail/ship_equip/shipinfocurrentequips",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									equip_1 = {
										path = "right/ship_detail/ship_equip/equip_1",
										list = {
											nil_bg = {
												path = "right/ship_detail/ship_equip/equip_1/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_detail/ship_equip/equip_1/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											equipment = {
												path = "right/ship_detail/ship_equip/equip_1/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_detail/ship_equip/equip_1/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_detail/ship_equip/equip_1/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_detail/ship_equip/equip_1/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													carry_num = {
														path = "right/ship_detail/ship_equip/equip_1/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													name_mask = {
														path = "right/ship_detail/ship_equip/equip_1/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_detail/ship_equip/equip_1/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_detail/ship_equip/equip_1/equipment/name_mask/equipname_2",
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
													},
													change_btn = {
														path = "right/ship_detail/ship_equip/equip_1/equipment/change_btn",
														list = {
															selected_mask = {
																path = "right/ship_detail/ship_equip/equip_1/equipment/change_btn/selected_mask",
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
															"ClickAndLongClickAndPointerUpEvent"
														}
													},
													off_btn = {
														path = "right/ship_detail/ship_equip/equip_1/equipment/off_btn",
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
										path = "right/ship_detail/ship_equip/equip_2",
										list = {
											nil_bg = {
												path = "right/ship_detail/ship_equip/equip_2/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_detail/ship_equip/equip_2/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											equipment = {
												path = "right/ship_detail/ship_equip/equip_2/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_detail/ship_equip/equip_2/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_detail/ship_equip/equip_2/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_detail/ship_equip/equip_2/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													carry_num = {
														path = "right/ship_detail/ship_equip/equip_2/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													name_mask = {
														path = "right/ship_detail/ship_equip/equip_2/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_detail/ship_equip/equip_2/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_detail/ship_equip/equip_2/equipment/name_mask/equipname_2",
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
													},
													change_btn = {
														path = "right/ship_detail/ship_equip/equip_2/equipment/change_btn",
														list = {
															selected_mask = {
																path = "right/ship_detail/ship_equip/equip_2/equipment/change_btn/selected_mask",
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
															"ClickAndLongClickAndPointerUpEvent"
														}
													},
													off_btn = {
														path = "right/ship_detail/ship_equip/equip_2/equipment/off_btn",
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
										path = "right/ship_detail/ship_equip/equip_3",
										list = {
											nil_bg = {
												path = "right/ship_detail/ship_equip/equip_3/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_detail/ship_equip/equip_3/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											equipment = {
												path = "right/ship_detail/ship_equip/equip_3/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_detail/ship_equip/equip_3/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_detail/ship_equip/equip_3/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_detail/ship_equip/equip_3/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													carry_num = {
														path = "right/ship_detail/ship_equip/equip_3/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													name_mask = {
														path = "right/ship_detail/ship_equip/equip_3/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_detail/ship_equip/equip_3/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_detail/ship_equip/equip_3/equipment/name_mask/equipname_2",
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
													},
													change_btn = {
														path = "right/ship_detail/ship_equip/equip_3/equipment/change_btn",
														list = {
															selected_mask = {
																path = "right/ship_detail/ship_equip/equip_3/equipment/change_btn/selected_mask",
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
															"ClickAndLongClickAndPointerUpEvent"
														}
													},
													off_btn = {
														path = "right/ship_detail/ship_equip/equip_3/equipment/off_btn",
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
										path = "right/ship_detail/ship_equip/equip_4",
										list = {
											nil_bg = {
												path = "right/ship_detail/ship_equip/equip_4/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_detail/ship_equip/equip_4/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											equipment = {
												path = "right/ship_detail/ship_equip/equip_4/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_detail/ship_equip/equip_4/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_detail/ship_equip/equip_4/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_detail/ship_equip/equip_4/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													carry_num = {
														path = "right/ship_detail/ship_equip/equip_4/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													name_mask = {
														path = "right/ship_detail/ship_equip/equip_4/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_detail/ship_equip/equip_4/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_detail/ship_equip/equip_4/equipment/name_mask/equipname_2",
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
													},
													change_btn = {
														path = "right/ship_detail/ship_equip/equip_4/equipment/change_btn",
														list = {
															selected_mask = {
																path = "right/ship_detail/ship_equip/equip_4/equipment/change_btn/selected_mask",
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
															"ClickAndLongClickAndPointerUpEvent"
														}
													},
													off_btn = {
														path = "right/ship_detail/ship_equip/equip_4/equipment/off_btn",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			right_btn_ship = {
				path = "right_btn_ship",
				list = {
					view_btn = {
						path = "right_btn_ship/view_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					change_btn = {
						path = "right_btn_ship/change_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					switch_btn = {
						path = "right_btn_ship/switch_btn",
						list = {
							Background = {
								path = "right_btn_ship/switch_btn/Background",
								list = {
									Checkmark = {
										path = "right_btn_ship/switch_btn/Background/Checkmark",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup"
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
										list = {
											click_area = {
												path = "role_scale/slide/Handle Slide Area/Handle/click_area",
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
							"UnityEngine.UI.Slider"
						}
					},
					add_btn = {
						path = "role_scale/add_btn",
						list = {
							add_btn2 = {
								path = "role_scale/add_btn/add_btn2",
								list = {
									add_btn3 = {
										path = "role_scale/add_btn/add_btn2/add_btn3",
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
									"UnityEngine.UI.Mask"
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
					reduce_btn = {
						path = "role_scale/reduce_btn",
						list = {
							reduce_btn2 = {
								path = "role_scale/reduce_btn/reduce_btn2",
								list = {
									reduce_btn3 = {
										path = "role_scale/reduce_btn/reduce_btn2/reduce_btn3",
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
									"UnityEngine.UI.Mask"
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
			tip_layer = {
				path = "tip_layer",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		click = {
			["left/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/alone_view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_title/strengthen_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_1/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_1/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_2/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_2/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_3/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_3/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_4/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/ship_equip/equip_4/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_btn_ship/view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_btn_ship/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["role_scale/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["role_scale/reduce_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			tip_layer = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["right_btn_ship/switch_btn"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		click_and_long_click_and_pointer_up = {
			["right/ship_detail/ship_equip/equip_1/equipment/change_btn"] = {
				tp = "ClickAndLongClickAndPointerUpEvent"
			},
			["right/ship_detail/ship_equip/equip_2/equipment/change_btn"] = {
				tp = "ClickAndLongClickAndPointerUpEvent"
			},
			["right/ship_detail/ship_equip/equip_3/equipment/change_btn"] = {
				tp = "ClickAndLongClickAndPointerUpEvent"
			},
			["right/ship_detail/ship_equip/equip_4/equipment/change_btn"] = {
				tp = "ClickAndLongClickAndPointerUpEvent"
			}
		},
		switch_by_drag = {
			["left/drag_for_switch"] = {
				tp = "SwitchByDrag"
			}
		},
		canvas_set = {}
	}
}

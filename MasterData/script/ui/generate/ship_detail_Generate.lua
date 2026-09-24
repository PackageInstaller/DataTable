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
					skin_btns = {
						path = "left/skin_btns",
						list = {
							view_btn = {
								path = "left/skin_btns/view_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							clothes_btn = {
								path = "left/skin_btns/clothes_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							video_btn = {
								path = "left/skin_btns/video_btn",
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
							"UnityEngine.UI.VerticalLayoutGroup"
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
					ship_btns = {
						path = "left/ship_btns",
						list = {
							view_btn = {
								path = "left/ship_btns/view_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							set_custom_btn = {
								path = "left/ship_btns/set_custom_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							cancel_custom_btn = {
								path = "left/ship_btns/cancel_custom_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							secretary_btn = {
								path = "left/ship_btns/secretary_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							leader_toggle = {
								path = "left/ship_btns/leader_toggle",
								list = {
									Background = {
										path = "left/ship_btns/leader_toggle/Background",
										list = {
											Checkmark = {
												path = "left/ship_btns/leader_toggle/Background/Checkmark",
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
							lock_toggle = {
								path = "left/ship_btns/lock_toggle",
								list = {
									Background = {
										path = "left/ship_btns/lock_toggle/Background",
										list = {
											Checkmark = {
												path = "left/ship_btns/lock_toggle/Background/Checkmark",
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
							achieve_btn = {
								path = "left/ship_btns/achieve_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							equip_record_btn = {
								path = "left/ship_btns/equip_record_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							dress_toggle = {
								path = "left/ship_btns/dress_toggle",
								list = {
									Background = {
										path = "left/ship_btns/dress_toggle/Background",
										list = {
											Checkmark = {
												path = "left/ship_btns/dress_toggle/Background/Checkmark",
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
							"UnityEngine.UI.VerticalLayoutGroup"
						}
					},
					skip_info = {
						path = "left/skip_info",
						list = {
							info_bg = {
								path = "left/skip_info/info_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							dot_icon = {
								path = "left/skip_info/dot_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							country_txt = {
								path = "left/skip_info/country_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							name_txt = {
								path = "left/skip_info/name_txt",
								list = {
									text1 = {
										path = "left/skip_info/name_txt/text1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									text2 = {
										path = "left/skip_info/name_txt/text2",
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
							star_layer = {
								path = "left/skip_info/star_layer",
								list = {
									star_1 = {
										path = "left/skip_info/star_layer/star_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_2 = {
										path = "left/skip_info/star_layer/star_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_3 = {
										path = "left/skip_info/star_layer/star_3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_4 = {
										path = "left/skip_info/star_layer/star_4",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_5 = {
										path = "left/skip_info/star_layer/star_5",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_6 = {
										path = "left/skip_info/star_layer/star_6",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_7 = {
										path = "left/skip_info/star_layer/star_7",
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
							"UnityEngine.RectTransform"
						}
					},
					skin_info = {
						path = "left/skin_info",
						list = {
							namebg = {
								path = "left/skin_info/namebg",
								list = {
									name_txt = {
										path = "left/skin_info/namebg/name_txt",
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
							"UnityEngine.RectTransform"
						}
					},
					ship_love = {
						path = "left/ship_love",
						list = {
							love_bg = {
								path = "left/ship_love/love_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							heart_bg = {
								path = "left/ship_love/heart_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							heart_icon = {
								path = "left/ship_love/heart_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							love_num = {
								path = "left/ship_love/love_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							love_limit = {
								path = "left/ship_love/love_limit",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							dot_icon = {
								path = "left/ship_love/dot_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							national_text = {
								path = "left/ship_love/national_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_type = {
								path = "left/ship_love/ship_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							love_btn = {
								path = "left/ship_love/love_btn",
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
											change_icon = {
												path = "right/ship_detail/detail_info/detail/change_icon",
												list = {
													ui_shi_change = {
														path = "right/ship_detail/detail_info/detail/change_icon/ui_shi_change",
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
													},
													long_scrollview = {
														path = "right/ship_detail/detail_info/detail/ship_skill/long_scrollview",
														list = {
															long_content = {
																path = "right/ship_detail/detail_info/detail/ship_skill/long_scrollview/long_content",
																list = {
																	long_skill_desc = {
																		path = "right/ship_detail/detail_info/detail/ship_skill/long_scrollview/long_content/long_skill_desc",
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
									},
									tactics = {
										path = "right/ship_detail/detail_info/tactics",
										list = {
											content = {
												path = "right/ship_detail/detail_info/tactics/content",
												list = {
													change_tactics_btn = {
														path = "right/ship_detail/detail_info/tactics/content/change_tactics_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													tactics_1 = {
														path = "right/ship_detail/detail_info/tactics/content/tactics_1",
														list = {
															tactics_1_content = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content",
																list = {
																	icon_bg = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content/icon_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	bg = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content/bg",
																		list = {
																			studying = {
																				path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content/bg/studying",
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
																	level = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content/level",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tactics_name = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content/tactics_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	exp = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_1/tactics_1_content/exp",
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
															no_open = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_1/no_open",
																list = {
																	lock = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_1/no_open/lock",
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
																	"UnityEngine.UI.Text"
																}
															},
															add_btn = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_1/add_btn",
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
													tactics_2 = {
														path = "right/ship_detail/detail_info/tactics/content/tactics_2",
														list = {
															tactics_2_content = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content",
																list = {
																	icon_bg = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content/icon_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	bg = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content/bg",
																		list = {
																			studying = {
																				path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content/bg/studying",
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
																	level = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content/level",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tactics_name = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content/tactics_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	exp = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_2/tactics_2_content/exp",
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
															no_open = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_2/no_open",
																list = {
																	lock = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_2/no_open/lock",
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
																	"UnityEngine.UI.Text"
																}
															},
															add_btn = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_2/add_btn",
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
													tactics_3 = {
														path = "right/ship_detail/detail_info/tactics/content/tactics_3",
														list = {
															tactics_3_content = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content",
																list = {
																	icon_bg = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content/icon_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	bg = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content/bg",
																		list = {
																			studying = {
																				path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content/bg/studying",
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
																	level = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content/level",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tactics_name = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content/tactics_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	exp = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_3/tactics_3_content/exp",
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
															no_open = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_3/no_open",
																list = {
																	lock = {
																		path = "right/ship_detail/detail_info/tactics/content/tactics_3/no_open/lock",
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
																	"UnityEngine.UI.Text"
																}
															},
															add_btn = {
																path = "right/ship_detail/detail_info/tactics/content/tactics_3/add_btn",
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
													line_1 = {
														path = "right/ship_detail/detail_info/tactics/content/line_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													line_2 = {
														path = "right/ship_detail/detail_info/tactics/content/line_2",
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
									right_arrow = {
										path = "right/ship_detail/detail_info/right_arrow",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									left_arrow = {
										path = "right/ship_detail/detail_info/left_arrow",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									page_1 = {
										path = "right/ship_detail/detail_info/page_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									page_2 = {
										path = "right/ship_detail/detail_info/page_2",
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
									id_bg = {
										path = "right/ship_detail/ship_title/id_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_id = {
										path = "right/ship_detail/ship_title/ship_id",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
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
											ship_name_2 = {
												path = "right/ship_detail/ship_title/ship_name_move/ship_name_2",
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
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							change_name = {
								path = "right/ship_detail/change_name",
								list = {
									input_text = {
										path = "right/ship_detail/change_name/input_text",
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
					},
					ship_layer = {
						path = "right/ship_layer",
						list = {
							display_bg = {
								path = "right/ship_layer/display_bg",
								list = {
									ship_girl = {
										path = "right/ship_layer/display_bg/ship_girl",
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
									"UnityEngine.UI.Image"
								}
							},
							detail_bg = {
								path = "right/ship_layer/detail_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							id_bg = {
								path = "right/ship_layer/id_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_layer_ship_id = {
								path = "right/ship_layer/ship_layer_ship_id",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							detail_item_1 = {
								path = "right/ship_layer/detail_item_1",
								list = {
									type_txt = {
										path = "right/ship_layer/detail_item_1/type_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "right/ship_layer/detail_item_1/level_txt",
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
							detail_item_2 = {
								path = "right/ship_layer/detail_item_2",
								list = {
									type_txt = {
										path = "right/ship_layer/detail_item_2/type_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "right/ship_layer/detail_item_2/level_txt",
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
							detail_item_3 = {
								path = "right/ship_layer/detail_item_3",
								list = {
									type_txt = {
										path = "right/ship_layer/detail_item_3/type_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "right/ship_layer/detail_item_3/level_txt",
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
							detail_item_4 = {
								path = "right/ship_layer/detail_item_4",
								list = {
									type_txt = {
										path = "right/ship_layer/detail_item_4/type_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "right/ship_layer/detail_item_4/level_txt",
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
							detail_item_5 = {
								path = "right/ship_layer/detail_item_5",
								list = {
									type_txt = {
										path = "right/ship_layer/detail_item_5/type_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "right/ship_layer/detail_item_5/level_txt",
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
							detail_item_6 = {
								path = "right/ship_layer/detail_item_6",
								list = {
									type_txt = {
										path = "right/ship_layer/detail_item_6/type_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level_txt = {
										path = "right/ship_layer/detail_item_6/level_txt",
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
							ship_type = {
								path = "right/ship_layer/ship_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ship_name_mask = {
								path = "right/ship_layer/ship_name_mask",
								list = {
									ship_name = {
										path = "right/ship_layer/ship_name_mask/ship_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									ship_name_move = {
										path = "right/ship_layer/ship_name_mask/ship_name_move",
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
							intro_txt = {
								path = "right/ship_layer/intro_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title_mask = {
								path = "right/ship_layer/title_mask",
								list = {
									txt = {
										path = "right/ship_layer/title_mask/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_2 = {
										path = "right/ship_layer/title_mask/txt_2",
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
							scrollview = {
								path = "right/ship_layer/scrollview",
								list = {
									content = {
										path = "right/ship_layer/scrollview/content",
										list = {
											info_txt = {
												path = "right/ship_layer/scrollview/content/info_txt",
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
							"UnityEngine.RectTransform"
						}
					},
					ship_equip_detail = {
						path = "right/ship_equip_detail",
						list = {
							bg_contains = {
								path = "right/ship_equip_detail/bg_contains",
								list = {
									bg_1 = {
										path = "right/ship_equip_detail/bg_contains/bg_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_2 = {
										path = "right/ship_equip_detail/bg_contains/bg_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_3 = {
										path = "right/ship_equip_detail/bg_contains/bg_3",
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
							ship_equip_detail_content = {
								path = "right/ship_equip_detail/ship_equip_detail_content",
								list = {
									ship_equip = {
										path = "right/ship_equip_detail/ship_equip_detail_content/ship_equip",
										list = {
											id_bg = {
												path = "right/ship_equip_detail/ship_equip_detail_content/ship_equip/id_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_id = {
												path = "right/ship_equip_detail/ship_equip_detail_content/ship_equip/ship_id",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_name = {
												path = "right/ship_equip_detail/ship_equip_detail_content/ship_equip/ship_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_type = {
												path = "right/ship_equip_detail/ship_equip_detail_content/ship_equip/ship_type",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											equip_bg = {
												path = "right/ship_equip_detail/ship_equip_detail_content/ship_equip/equip_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equip_title = {
												path = "right/ship_equip_detail/ship_equip_detail_content/ship_equip/equip_title",
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
									equip_1 = {
										path = "right/ship_equip_detail/ship_equip_detail_content/equip_1",
										list = {
											equip_shadow = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equip_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											nil_bg = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											equipment = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													clock = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/clock",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													name_mask = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/name_mask/equipname_2",
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
													carry_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													change_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/change_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													off_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/off_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													attrib_1 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_1",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_1/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_1/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_1/count",
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
													attrib_2 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_2",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_2/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_2/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_2/count",
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
													attrib_3 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_3",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_3/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_3/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attrib_3/count",
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
													down = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attr_btn",
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
										path = "right/ship_equip_detail/ship_equip_detail_content/equip_2",
										list = {
											equip_shadow = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equip_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											nil_bg = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equipment = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													clock = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/clock",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													name_mask = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/name_mask/equipname_2",
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
													carry_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													change_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/change_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													off_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/off_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													attrib_1 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_1",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_1/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_1/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_1/count",
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
													attrib_2 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_2",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_2/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_2/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_2/count",
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
													attrib_3 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_3",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_3/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_3/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attrib_3/count",
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
													down = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attr_btn",
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
										path = "right/ship_equip_detail/ship_equip_detail_content/equip_3",
										list = {
											equip_shadow = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equip_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											nil_bg = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equipment = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													clock = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/clock",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													name_mask = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/name_mask/equipname_2",
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
													carry_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													change_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/change_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													off_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/off_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													attrib_1 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_1",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_1/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_1/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_1/count",
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
													attrib_2 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_2",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_2/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_2/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_2/count",
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
													attrib_3 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_3",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_3/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_3/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attrib_3/count",
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
													down = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attr_btn",
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
										path = "right/ship_equip_detail/ship_equip_detail_content/equip_4",
										list = {
											equip_shadow = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equip_shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											add_equip = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/add_equip",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											nil_bg = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/nil_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											equipment = {
												path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment",
												list = {
													equip_rarity = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/equip_rarity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/equip_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													clock = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/clock",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													equip_name_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/equip_name_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													name_mask = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/name_mask",
														list = {
															equipname = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/name_mask/equipname",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															equipname_2 = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/name_mask/equipname_2",
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
													carry_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/carry_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.Outline"
														}
													},
													change_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/change_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													off_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/off_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													attrib_1 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_1",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_1/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_1/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_1/count",
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
													attrib_2 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_2",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_2/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_2/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_2/count",
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
													attrib_3 = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_3",
														list = {
															title = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_3/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_3/add",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															count = {
																path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attrib_3/count",
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
													down = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_btn = {
														path = "right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attr_btn",
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
									detail_2 = {
										path = "right/ship_equip_detail/ship_equip_detail_content/detail_2",
										list = {
											ship_icon = {
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/ship_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_star = {
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/ship_star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											change_icon = {
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/change_icon",
												list = {
													ui_shi_change = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/change_icon/ui_shi_change",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_hp",
												list = {
													hp = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_hp/hp",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_hp/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_hp/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_hp/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_atk",
												list = {
													atk = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_atk/atk",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_atk/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_atk/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_atk/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_def",
												list = {
													def = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_def/def",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_def/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_def/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_def/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_torpedo",
												list = {
													torpedo = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_torpedo/torpedo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_torpedo/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_torpedo/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_torpedo/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_miss",
												list = {
													miss = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_miss/miss",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_miss/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_miss/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_miss/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_airdef",
												list = {
													airdef = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_airdef/airdef",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_airdef/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_airdef/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_airdef/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_capacity",
												list = {
													capacity = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_capacity/capacity",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_capacity/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_capacity/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_capacity/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_antisub",
												list = {
													antisub = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_antisub/antisub",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_antisub/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_antisub/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_antisub/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_speed",
												list = {
													speed = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_speed/speed",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_speed/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_speed/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_speed/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_radar",
												list = {
													radar = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_radar/radar",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_radar/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_radar/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_radar/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_range",
												list = {
													range = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_range/range",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_range/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_range/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_range/tip_icon",
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
												path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_luck",
												list = {
													luck = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_luck/luck",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													attr_bg = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_luck/attr_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													attr_num = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_luck/attr_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													tip_icon = {
														path = "right/ship_equip_detail/ship_equip_detail_content/detail_2/attr_luck/tip_icon",
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
			skin_layer = {
				path = "skin_layer",
				list = {
					skin_list_bg = {
						path = "skin_layer/skin_list_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					scrollview = {
						path = "skin_layer/scrollview",
						list = {
							content = {
								path = "skin_layer/scrollview/content",
								list = {
									single_skin_icon = {
										path = "skin_layer/scrollview/content/single_skin_icon",
										list = {
											icon_bg = {
												path = "skin_layer/scrollview/content/single_skin_icon/icon_bg",
												list = {
													icon = {
														path = "skin_layer/scrollview/content/single_skin_icon/icon_bg/icon",
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
											role_bg = {
												path = "skin_layer/scrollview/content/single_skin_icon/role_bg",
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
											"UnityEngine.UI.Toggle"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.GridLayoutGroup",
									"UnityEngine.UI.ToggleGroup"
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
					},
					skin_bg_1 = {
						path = "skin_layer/skin_bg_1",
						list = {
							skeleton = {
								path = "skin_layer/skin_bg_1/skeleton",
								list = {
									ship_girl = {
										path = "skin_layer/skin_bg_1/skeleton/ship_girl",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"Spine.Unity.SkeletonGraphic"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							desc_list = {
								path = "skin_layer/skin_bg_1/desc_list",
								list = {
									desc = {
										path = "skin_layer/skin_bg_1/desc_list/desc",
										list = {
											tip_bg = {
												path = "skin_layer/skin_bg_1/desc_list/desc/tip_bg",
												list = {
													title = {
														path = "skin_layer/skin_bg_1/desc_list/desc/tip_bg/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													content = {
														path = "skin_layer/skin_bg_1/desc_list/desc/tip_bg/content",
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
													"UnityEngine.Canvas",
													"UnityEngine.UI.GraphicRaycaster"
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
									"UnityEngine.UI.GridLayoutGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					skin_bg_2 = {
						path = "skin_layer/skin_bg_2",
						list = {
							slash = {
								path = "skin_layer/skin_bg_2/slash",
								list = {
									name_bg = {
										path = "skin_layer/skin_bg_2/slash/name_bg",
										list = {
											name_txt = {
												path = "skin_layer/skin_bg_2/slash/name_bg/name_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											name_txt_2 = {
												path = "skin_layer/skin_bg_2/slash/name_bg/name_txt_2",
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							scrollview = {
								path = "skin_layer/skin_bg_2/scrollview",
								list = {
									content = {
										path = "skin_layer/skin_bg_2/scrollview/content",
										list = {
											info_txt = {
												path = "skin_layer/skin_bg_2/scrollview/content/info_txt",
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
							},
							price_icon = {
								path = "skin_layer/skin_bg_2/price_icon",
								list = {
									num = {
										path = "skin_layer/skin_bg_2/price_icon/num",
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
							confirmbtn = {
								path = "skin_layer/skin_bg_2/confirmbtn",
								list = {
									buy_txt = {
										path = "skin_layer/skin_bg_2/confirmbtn/buy_txt",
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
							usebtn = {
								path = "skin_layer/skin_bg_2/usebtn",
								list = {
									title = {
										path = "skin_layer/skin_bg_2/usebtn/title",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			video_btn_layer = {
				path = "video_btn_layer",
				list = {
					white_bg = {
						path = "video_btn_layer/white_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					black_line_bg = {
						path = "video_btn_layer/black_line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "video_btn_layer/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					close_btn = {
						path = "video_btn_layer/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					video_btn_1 = {
						path = "video_btn_layer/video_btn_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					video_btn_2 = {
						path = "video_btn_layer/video_btn_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					btn_mask = {
						path = "video_btn_layer/btn_mask",
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
			["left/skin_btns/view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/skin_btns/clothes_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/skin_btns/video_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/alone_view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/ship_btns/view_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/ship_btns/set_custom_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/ship_btns/cancel_custom_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/ship_btns/secretary_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/ship_btns/achieve_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/ship_btns/equip_record_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left/ship_love/love_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/detail_info/tactics/content/change_tactics_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/detail_info/tactics/content/tactics_1/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/detail_info/tactics/content/tactics_2/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/detail_info/tactics/content/tactics_3/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/detail_info/right_arrow"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_detail/detail_info/left_arrow"] = {
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
			["right/ship_equip_detail/ship_equip_detail_content/equip_1/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_1/equipment/attr_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_2/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_2/equipment/attr_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_3/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_3/equipment/attr_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_4/add_equip"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/off_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/ship_equip_detail/ship_equip_detail_content/equip_4/equipment/attr_btn"] = {
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
			["skin_layer/skin_bg_1/desc_list/desc"] = {
				tp = "UnityEngine.UI.Button"
			},
			["skin_layer/skin_bg_2/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["skin_layer/skin_bg_2/usebtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["video_btn_layer/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["video_btn_layer/video_btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["video_btn_layer/video_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			tip_layer = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["left/ship_btns/leader_toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left/ship_btns/lock_toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["left/ship_btns/dress_toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_btn_ship/switch_btn"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["skin_layer/scrollview/content/single_skin_icon"] = {
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
		canvas_set = {
			tip_bg = {
				component = "UnityEngine.Canvas",
				path = "skin_layer/skin_bg_1/desc_list/desc/tip_bg"
			}
		}
	}
}

return {
	_rule_ = {
		none = {
			obj_pool_root = {
				path = "obj_pool_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
				}
			},
			big_map_bg = {
				path = "big_map_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			mask = {
				path = "mask",
				list = {
					Button = {
						path = "mask/Button",
						list = {
							Text = {
								path = "mask/Button/Text",
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
					Button_2 = {
						path = "mask/Button_2",
						list = {
							Text = {
								path = "mask/Button_2/Text",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.CanvasRenderer"
				}
			},
			point_line_panel = {
				path = "point_line_panel",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UnityEngine.CanvasGroup"
				}
			},
			point_panel = {
				path = "point_panel",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UnityEngine.CanvasGroup"
				}
			},
			bg = {
				path = "bg",
				list = {
					back_btn = {
						path = "bg/back_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					title_bg = {
						path = "bg/title_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "bg/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					map_mask = {
						path = "bg/map_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mode_panel = {
						path = "bg/mode_panel",
						list = {
							normal_image = {
								path = "bg/mode_panel/normal_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							hard_image = {
								path = "bg/mode_panel/hard_image",
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
							"UnityEngine.CanvasRenderer"
						}
					},
					btns = {
						path = "bg/btns",
						list = {
							special_task_btn = {
								path = "bg/btns/special_task_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							story_btn = {
								path = "bg/btns/story_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							explain_talk_btn = {
								path = "bg/btns/explain_talk_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							honor_btn = {
								path = "bg/btns/honor_btn",
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
					info_icon_btn = {
						path = "bg/info_icon_btn",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			back_image = {
				path = "back_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			push_guide = {
				path = "push_guide",
				list = {
					tip_layer = {
						path = "push_guide/tip_layer",
						list = {
							bg = {
								path = "push_guide/tip_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_container = {
								path = "push_guide/tip_layer/bg_container",
								list = {
									black_line = {
										path = "push_guide/tip_layer/bg_container/black_line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top = {
										path = "push_guide/tip_layer/bg_container/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_2 = {
										path = "push_guide/tip_layer/bg_container/bg_blue_top_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_3 = {
										path = "push_guide/tip_layer/bg_container/bg_blue_top_3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "push_guide/tip_layer/bg_container/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									three_point = {
										path = "push_guide/tip_layer/bg_container/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									gray_line = {
										path = "push_guide/tip_layer/bg_container/gray_line",
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
							close = {
								path = "push_guide/tip_layer/close",
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
							"UnityEngine.UI.Image",
							"UITweenSequence",
							"UIScaleTweener",
							"UIScaleTweener"
						}
					},
					guidecontent = {
						path = "push_guide/guidecontent",
						list = {
							guidetext = {
								path = "push_guide/guidecontent/guidetext",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter",
									"UnityEngine.UI.GridLayoutGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask",
							"UnityEngine.UI.ScrollRect"
						}
					},
					botoom_line = {
						path = "push_guide/botoom_line",
						list = {
							Image = {
								path = "push_guide/botoom_line/Image",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			map_preview = {
				path = "map_preview",
				list = {
					map_bg = {
						path = "map_preview/map_bg",
						list = {
							map_panel = {
								path = "map_preview/map_bg/map_panel",
								list = {
									map_image = {
										path = "map_preview/map_bg/map_panel/map_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									map_node_root = {
										path = "map_preview/map_bg/map_panel/map_node_root",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									pass_icon = {
										path = "map_preview/map_bg/map_panel/pass_icon",
										list = {
											pass_txt = {
												path = "map_preview/map_bg/map_panel/pass_icon/pass_txt",
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
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_all_count = {
										path = "map_preview/map_bg/map_panel/buff_all_count",
										list = {
											buff_all_img = {
												path = "map_preview/map_bg/map_panel/buff_all_count/buff_all_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num_txt = {
												path = "map_preview/map_bg/map_panel/buff_all_count/num_txt",
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
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.Image"
								}
							},
							title_bg = {
								path = "map_preview/map_bg/title_bg",
								list = {
									title_txt = {
										path = "map_preview/map_bg/title_bg/title_txt",
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
							close_btn = {
								path = "map_preview/map_bg/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							boss_panel = {
								path = "map_preview/map_bg/boss_panel",
								list = {
									boss_bg = {
										path = "map_preview/map_bg/boss_panel/boss_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									boss_image = {
										path = "map_preview/map_bg/boss_panel/boss_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									boss_head = {
										path = "map_preview/map_bg/boss_panel/boss_head",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									boss_hp_black = {
										path = "map_preview/map_bg/boss_panel/boss_hp_black",
										list = {
											boss_hp_bar = {
												path = "map_preview/map_bg/boss_panel/boss_hp_black/boss_hp_bar",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_percent_num = {
												path = "map_preview/map_bg/boss_panel/boss_hp_black/hp_percent_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											percent = {
												path = "map_preview/map_bg/boss_panel/boss_hp_black/percent",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							reward_panel = {
								path = "map_preview/map_bg/reward_panel",
								list = {
									reward_title = {
										path = "map_preview/map_bg/reward_panel/reward_title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									reward_line = {
										path = "map_preview/map_bg/reward_panel/reward_line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_icon_bg = {
										path = "map_preview/map_bg/reward_panel/reward_icon_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_icon = {
										path = "map_preview/map_bg/reward_panel/reward_icon",
										list = {
											get_icon = {
												path = "map_preview/map_bg/reward_panel/reward_icon/get_icon",
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
									},
									reward_line_2 = {
										path = "map_preview/map_bg/reward_panel/reward_line_2",
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
							confirm_btn = {
								path = "map_preview/map_bg/confirm_btn",
								list = {
									title = {
										path = "map_preview/map_bg/confirm_btn/title",
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
							bottom_tips = {
								path = "map_preview/map_bg/bottom_tips",
								list = {
									dot_image = {
										path = "map_preview/map_bg/bottom_tips/dot_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									tips_txt = {
										path = "map_preview/map_bg/bottom_tips/tips_txt",
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
							random_buff_btn = {
								path = "map_preview/map_bg/random_buff_btn",
								list = {
									Text = {
										path = "map_preview/map_bg/random_buff_btn/Text",
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
							drop_available = {
								path = "map_preview/map_bg/drop_available",
								list = {
									Text = {
										path = "map_preview/map_bg/drop_available/Text",
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
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					map_tips_panel = {
						path = "map_preview/map_tips_panel",
						list = {
							tips_txt = {
								path = "map_preview/map_tips_panel/tips_txt",
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
					"UnityEngine.UI.Mask"
				}
			},
			msg_panel = {
				path = "msg_panel",
				list = {
					finish_special_mission = {
						path = "msg_panel/finish_special_mission",
						list = {
							finish_title = {
								path = "msg_panel/finish_special_mission/finish_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "msg_panel/finish_special_mission/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							coin_num = {
								path = "msg_panel/finish_special_mission/coin_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							map_title = {
								path = "msg_panel/finish_special_mission/map_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							task_title = {
								path = "msg_panel/finish_special_mission/task_title",
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
					hard_tips = {
						path = "msg_panel/hard_tips",
						list = {
							bg = {
								path = "msg_panel/hard_tips/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup",
									"Matrix.UIGroupFadeTweener",
									"Matrix.UIGroupFadeTweener"
								}
							},
							hard_tips_txt = {
								path = "msg_panel/hard_tips/hard_tips_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							mode_start_pos = {
								path = "msg_panel/hard_tips/mode_start_pos",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			special_task_panel = {
				path = "special_task_panel",
				list = {
					special_task_bg = {
						path = "special_task_panel/special_task_bg",
						list = {
							task_close_btn = {
								path = "special_task_panel/special_task_bg/task_close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button",
									"UnityEngine.Canvas",
									"UnityEngine.UI.GraphicRaycaster"
								}
							},
							special_task_title_image = {
								path = "special_task_panel/special_task_bg/special_task_title_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							left = {
								path = "special_task_panel/special_task_bg/left",
								list = {
									left_title_panel = {
										path = "special_task_panel/special_task_bg/left/left_title_panel",
										list = {
											title_bg = {
												path = "special_task_panel/special_task_bg/left/left_title_panel/title_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title_txt = {
												path = "special_task_panel/special_task_bg/left/left_title_panel/title_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											coin_icon = {
												path = "special_task_panel/special_task_bg/left/left_title_panel/coin_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											coin_num = {
												path = "special_task_panel/special_task_bg/left/left_title_panel/coin_num",
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
									all_task = {
										path = "special_task_panel/special_task_bg/left/all_task",
										list = {
											viewport = {
												path = "special_task_panel/special_task_bg/left/all_task/viewport",
												list = {
													content = {
														path = "special_task_panel/special_task_bg/left/all_task/viewport/content",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"EndlessScrollView"
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
									"UnityEngine.CanvasRenderer"
								}
							},
							right = {
								path = "special_task_panel/special_task_bg/right",
								list = {
									right_title_txt = {
										path = "special_task_panel/special_task_bg/right/right_title_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									dot_image = {
										path = "special_task_panel/special_task_bg/right/dot_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									dot_image_2 = {
										path = "special_task_panel/special_task_bg/right/dot_image_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									dot_image_3 = {
										path = "special_task_panel/special_task_bg/right/dot_image_3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									task_bg_title_txt = {
										path = "special_task_panel/special_task_bg/right/task_bg_title_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									task_bg_txt = {
										path = "special_task_panel/special_task_bg/right/task_bg_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									task_aim_title_txt = {
										path = "special_task_panel/special_task_bg/right/task_aim_title_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									task_aim_txt = {
										path = "special_task_panel/special_task_bg/right/task_aim_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									task_reward_title_txt = {
										path = "special_task_panel/special_task_bg/right/task_reward_title_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									task_reward_txt = {
										path = "special_task_panel/special_task_bg/right/task_reward_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									reward_coin_icon = {
										path = "special_task_panel/special_task_bg/right/reward_coin_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									task_reward_num = {
										path = "special_task_panel/special_task_bg/right/task_reward_num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									task_reward_image = {
										path = "special_task_panel/special_task_bg/right/task_reward_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									task_reward_text = {
										path = "special_task_panel/special_task_bg/right/task_reward_text",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			equip_mask = {
				path = "equip_mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			reward_mask = {
				path = "reward_mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			["mask/Button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mask/Button_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/back_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/mode_panel/normal_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/mode_panel/hard_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/btns/special_task_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/btns/story_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/btns/explain_talk_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/btns/honor_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_icon_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["push_guide/tip_layer/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/reward_panel/reward_icon"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/random_buff_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/drop_available"] = {
				tp = "UnityEngine.UI.Button"
			},
			["special_task_panel/special_task_bg/task_close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			equip_mask = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			point_line_panel = {
				component = "UnityEngine.Canvas",
				path = "point_line_panel"
			},
			point_panel = {
				component = "UnityEngine.Canvas",
				path = "point_panel"
			},
			push_guide = {
				component = "UnityEngine.Canvas",
				path = "push_guide"
			},
			map_bg = {
				component = "UnityEngine.Canvas",
				path = "map_preview/map_bg"
			},
			special_task_panel = {
				component = "UnityEngine.Canvas",
				path = "special_task_panel"
			},
			task_close_btn = {
				component = "UnityEngine.Canvas",
				path = "special_task_panel/special_task_bg/task_close_btn"
			}
		}
	}
}

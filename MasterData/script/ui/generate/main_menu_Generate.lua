return {
	_rule_ = {
		none = {
			ui_tween = {
				path = "ui_tween",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			back_btn = {
				path = "back_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			content = {
				path = "content",
				list = {
					menu_bg = {
						path = "content/menu_bg",
						list = {
							Image = {
								path = "content/menu_bg/Image",
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
					toggle_group = {
						path = "content/toggle_group",
						list = {
							mall = {
								path = "content/toggle_group/mall",
								list = {
									checkMark = {
										path = "content/toggle_group/mall/checkMark",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/toggle_group/mall/title",
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
							activity = {
								path = "content/toggle_group/activity",
								list = {
									checkMark = {
										path = "content/toggle_group/activity/checkMark",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/toggle_group/activity/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									activity_finish = {
										path = "content/toggle_group/activity/activity_finish",
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
							build = {
								path = "content/toggle_group/build",
								list = {
									checkMark = {
										path = "content/toggle_group/build/checkMark",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/toggle_group/build/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									main_menu_build_finish = {
										path = "content/toggle_group/build/main_menu_build_finish",
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
							remake = {
								path = "content/toggle_group/remake",
								list = {
									checkMark = {
										path = "content/toggle_group/remake/checkMark",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/toggle_group/remake/title",
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
							cardbookui = {
								path = "content/toggle_group/cardbookui",
								list = {
									checkMark = {
										path = "content/toggle_group/cardbookui/checkMark",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/toggle_group/cardbookui/title",
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
							friend = {
								path = "content/toggle_group/friend",
								list = {
									checkMark = {
										path = "content/toggle_group/friend/checkMark",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "content/toggle_group/friend/title",
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
					return_btn = {
						path = "content/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					official_btn = {
						path = "content/official_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					mail_btn = {
						path = "content/mail_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					mail_red_dot = {
						path = "content/mail_red_dot",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					setting_btn = {
						path = "content/setting_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					line = {
						path = "content/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					arrow = {
						path = "content/arrow",
						list = {
							arrow_icon = {
								path = "content/arrow/arrow_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							content = {
								path = "content/arrow/content",
								list = {
									item_btn_1 = {
										path = "content/arrow/content/item_btn_1",
										list = {
											icon = {
												path = "content/arrow/content/item_btn_1/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "content/arrow/content/item_btn_1/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "content/arrow/content/item_btn_1/title_mask",
												list = {
													txt = {
														path = "content/arrow/content/item_btn_1/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "content/arrow/content/item_btn_1/title_mask/txt_2",
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
													"TextHorizonScroller"
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
									item_btn_2 = {
										path = "content/arrow/content/item_btn_2",
										list = {
											icon = {
												path = "content/arrow/content/item_btn_2/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "content/arrow/content/item_btn_2/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "content/arrow/content/item_btn_2/title_mask",
												list = {
													txt = {
														path = "content/arrow/content/item_btn_2/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "content/arrow/content/item_btn_2/title_mask/txt_2",
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
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIMoveTweener",
											"UIMoveTweener",
											"UIMoveTweener",
											"UnityEngine.UI.Button"
										}
									},
									item_btn_3 = {
										path = "content/arrow/content/item_btn_3",
										list = {
											icon = {
												path = "content/arrow/content/item_btn_3/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "content/arrow/content/item_btn_3/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "content/arrow/content/item_btn_3/title_mask",
												list = {
													txt = {
														path = "content/arrow/content/item_btn_3/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "content/arrow/content/item_btn_3/title_mask/txt_2",
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
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIMoveTweener",
											"UIMoveTweener",
											"UIMoveTweener",
											"UnityEngine.UI.Button",
											"UnityEngine.CanvasGroup"
										}
									},
									item_btn_4 = {
										path = "content/arrow/content/item_btn_4",
										list = {
											icon = {
												path = "content/arrow/content/item_btn_4/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "content/arrow/content/item_btn_4/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "content/arrow/content/item_btn_4/title_mask",
												list = {
													txt = {
														path = "content/arrow/content/item_btn_4/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "content/arrow/content/item_btn_4/title_mask/txt_2",
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
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIMoveTweener",
											"UIMoveTweener",
											"UIMoveTweener",
											"UnityEngine.UI.Button",
											"UnityEngine.CanvasGroup"
										}
									},
									item_btn_5 = {
										path = "content/arrow/content/item_btn_5",
										list = {
											icon = {
												path = "content/arrow/content/item_btn_5/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "content/arrow/content/item_btn_5/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "content/arrow/content/item_btn_5/title_mask",
												list = {
													txt = {
														path = "content/arrow/content/item_btn_5/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "content/arrow/content/item_btn_5/title_mask/txt_2",
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
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIMoveTweener",
											"UIMoveTweener",
											"UIMoveTweener",
											"UnityEngine.UI.Button",
											"UnityEngine.CanvasGroup"
										}
									},
									item_btn_6 = {
										path = "content/arrow/content/item_btn_6",
										list = {
											icon = {
												path = "content/arrow/content/item_btn_6/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "content/arrow/content/item_btn_6/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "content/arrow/content/item_btn_6/title_mask",
												list = {
													txt = {
														path = "content/arrow/content/item_btn_6/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "content/arrow/content/item_btn_6/title_mask/txt_2",
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
													"TextHorizonScroller"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIMoveTweener",
											"UIMoveTweener",
											"UIMoveTweener",
											"UnityEngine.UI.Button",
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UITweenSequence"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			}
		},
		call_node_list = {
			["main_menu/content/toggle_group"] = "_control.content.toggle_group",
			["main_menu/content/arrow/content/item_btn_1/text"] = "_control.content.arrow.content.item_btn_1.text",
			["main_menu/content/toggle_group/mall/title"] = "_control.content.toggle_group.mall.title",
			["main_menu/content/arrow/content/item_btn_4/title_mask/txt"] = "_control.content.arrow.content.item_btn_4.title_mask.txt",
			["main_menu/content/arrow/content/item_btn_4/title_mask"] = "_control.content.arrow.content.item_btn_4.title_mask",
			["main_menu/content/arrow/content/item_btn_1"] = "_control.content.arrow.content.item_btn_1",
			["main_menu/content/arrow/content/item_btn_4/icon"] = "_control.content.arrow.content.item_btn_4.icon",
			["main_menu/content/arrow/content/item_btn_4"] = "_control.content.arrow.content.item_btn_4",
			["main_menu/content/arrow/content/item_btn_3/title_mask/txt_2"] = "_control.content.arrow.content.item_btn_3.title_mask.txt_2",
			["main_menu/content/toggle_group/friend/title"] = "_control.content.toggle_group.friend.title",
			["main_menu/content/arrow/content/item_btn_3/title_mask"] = "_control.content.arrow.content.item_btn_3.title_mask",
			["main_menu/content/return_btn"] = "_control.content.return_btn",
			["main_menu/content/arrow/content/item_btn_1/title_mask/txt_2"] = "_control.content.arrow.content.item_btn_1.title_mask.txt_2",
			["main_menu/content/arrow/content/item_btn_3/text"] = "_control.content.arrow.content.item_btn_3.text",
			["main_menu/content/arrow/content/item_btn_3/icon"] = "_control.content.arrow.content.item_btn_3.icon",
			["main_menu/content/arrow/content/item_btn_2/text"] = "_control.content.arrow.content.item_btn_2.text",
			["main_menu/content/arrow/content/item_btn_2/title_mask/txt_2"] = "_control.content.arrow.content.item_btn_2.title_mask.txt_2",
			["main_menu/content/arrow/content/item_btn_2/title_mask/txt"] = "_control.content.arrow.content.item_btn_2.title_mask.txt",
			["main_menu/content/arrow/arrow_icon"] = "_control.content.arrow.arrow_icon",
			["main_menu/content/arrow/content/item_btn_2/icon"] = "_control.content.arrow.content.item_btn_2.icon",
			["main_menu/content/arrow/content/item_btn_2/title_mask"] = "_control.content.arrow.content.item_btn_2.title_mask",
			["main_menu/content/arrow/content/item_btn_1/title_mask"] = "_control.content.arrow.content.item_btn_1.title_mask",
			["main_menu/content/arrow/content/item_btn_1/icon"] = "_control.content.arrow.content.item_btn_1.icon",
			["main_menu/content/arrow/content/item_btn_4/text"] = "_control.content.arrow.content.item_btn_4.text",
			["main_menu/content/arrow/content/item_btn_3/title_mask/txt"] = "_control.content.arrow.content.item_btn_3.title_mask.txt",
			["main_menu/content/menu_bg/Image"] = "_control.content.menu_bg.Image",
			["main_menu/content/menu_bg"] = "_control.content.menu_bg",
			["main_menu/content/toggle_group/activity"] = "_control.content.toggle_group.activity",
			["main_menu/content/toggle_group/remake/checkMark"] = "_control.content.toggle_group.remake.checkMark",
			["main_menu/content/toggle_group/mall/checkMark"] = "_control.content.toggle_group.mall.checkMark",
			["main_menu/content/toggle_group/activity/checkMark"] = "_control.content.toggle_group.activity.checkMark",
			["main_menu/content/arrow/content/item_btn_2"] = "_control.content.arrow.content.item_btn_2",
			["main_menu/content/arrow/content/item_btn_5"] = "_control.content.arrow.content.item_btn_5",
			["main_menu/content/toggle_group/remake/title"] = "_control.content.toggle_group.remake.title",
			["main_menu/content/toggle_group/build/main_menu_build_finish"] = "_control.content.toggle_group.build.main_menu_build_finish",
			["main_menu/content/arrow/content/item_btn_1/title_mask/txt"] = "_control.content.arrow.content.item_btn_1.title_mask.txt",
			["main_menu/content/toggle_group/friend/checkMark"] = "_control.content.toggle_group.friend.checkMark",
			["main_menu/content/toggle_group/cardbookui/checkMark"] = "_control.content.toggle_group.cardbookui.checkMark",
			["main_menu/content/arrow/content/item_btn_5/title_mask/txt_2"] = "_control.content.arrow.content.item_btn_5.title_mask.txt_2",
			["main_menu/content/arrow/content/item_btn_6"] = "_control.content.arrow.content.item_btn_6",
			["main_menu/content/arrow/content/item_btn_6/icon"] = "_control.content.arrow.content.item_btn_6.icon",
			["main_menu/content/arrow/content/item_btn_5/icon"] = "_control.content.arrow.content.item_btn_5.icon",
			["main_menu/content/arrow/content/item_btn_6/text"] = "_control.content.arrow.content.item_btn_6.text",
			["main_menu/content/arrow"] = "_control.content.arrow",
			["main_menu/content/arrow/content/item_btn_6/title_mask"] = "_control.content.arrow.content.item_btn_6.title_mask",
			["main_menu/ui_tween"] = "_control.ui_tween",
			["main_menu/content/toggle_group/mall"] = "_control.content.toggle_group.mall",
			["main_menu/content/arrow/content/item_btn_6/title_mask/txt"] = "_control.content.arrow.content.item_btn_6.title_mask.txt",
			["main_menu/content/official_btn"] = "_control.content.official_btn",
			["main_menu/content/arrow/content/item_btn_6/title_mask/txt_2"] = "_control.content.arrow.content.item_btn_6.title_mask.txt_2",
			["main_menu/content/toggle_group/activity/activity_finish"] = "_control.content.toggle_group.activity.activity_finish",
			["main_menu/back_btn"] = "_control.back_btn",
			["main_menu/content/setting_btn"] = "_control.content.setting_btn",
			["main_menu/content/toggle_group/friend"] = "_control.content.toggle_group.friend",
			["main_menu/content/arrow/content/item_btn_5/text"] = "_control.content.arrow.content.item_btn_5.text",
			["main_menu/content/toggle_group/build/title"] = "_control.content.toggle_group.build.title",
			["main_menu/content/arrow/content/item_btn_5/title_mask/txt"] = "_control.content.arrow.content.item_btn_5.title_mask.txt",
			["main_menu/content/toggle_group/build/checkMark"] = "_control.content.toggle_group.build.checkMark",
			["main_menu/content/arrow/content"] = "_control.content.arrow.content",
			["main_menu/content/mail_red_dot"] = "_control.content.mail_red_dot",
			["main_menu/content/toggle_group/cardbookui"] = "_control.content.toggle_group.cardbookui",
			["main_menu/content/arrow/content/item_btn_3"] = "_control.content.arrow.content.item_btn_3",
			["main_menu/content/line"] = "_control.content.line",
			["main_menu/content/mail_btn"] = "_control.content.mail_btn",
			["main_menu/content/toggle_group/activity/title"] = "_control.content.toggle_group.activity.title",
			["main_menu/content"] = "_control.content",
			["main_menu/content/arrow/content/item_btn_4/title_mask/txt_2"] = "_control.content.arrow.content.item_btn_4.title_mask.txt_2",
			["main_menu/content/toggle_group/cardbookui/title"] = "_control.content.toggle_group.cardbookui.title",
			["main_menu/content/toggle_group/build"] = "_control.content.toggle_group.build",
			["main_menu/content/toggle_group/remake"] = "_control.content.toggle_group.remake",
			["main_menu/content/arrow/content/item_btn_5/title_mask"] = "_control.content.arrow.content.item_btn_5.title_mask"
		},
		click = {
			back_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["content/toggle_group/mall"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/toggle_group/activity"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/toggle_group/build"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/toggle_group/remake"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/toggle_group/cardbookui"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/toggle_group/friend"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/setting_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/arrow/content/item_btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/arrow/content/item_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/arrow/content/item_btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/arrow/content/item_btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/arrow/content/item_btn_5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/arrow/content/item_btn_6"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["content/return_btn"] = {
				tp = "ScaleButton"
			},
			["content/official_btn"] = {
				tp = "ScaleButton"
			},
			["content/mail_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

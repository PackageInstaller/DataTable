return {
	_rule_ = {
		none = {
			buy_msgbox = {
				path = "buy_msgbox",
				list = {
					maskbg = {
						path = "buy_msgbox/maskbg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					main = {
						path = "buy_msgbox/main",
						list = {
							main_bg = {
								path = "buy_msgbox/main/main_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_decore = {
								path = "buy_msgbox/main/top_decore",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_bg = {
								path = "buy_msgbox/main/top_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_text = {
								path = "buy_msgbox/main/title_text",
								list = {
									gogo = {
										path = "buy_msgbox/main/title_text/gogo",
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
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							quitbtn = {
								path = "buy_msgbox/main/quitbtn",
								list = {
									text = {
										path = "buy_msgbox/main/quitbtn/text",
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
							confirmbtn = {
								path = "buy_msgbox/main/confirmbtn",
								list = {
									text = {
										path = "buy_msgbox/main/confirmbtn/text",
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
							main_text = {
								path = "buy_msgbox/main/main_text",
								list = {
									text = {
										path = "buy_msgbox/main/main_text/text",
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
							"UIScaleTweener",
							"UIScaleTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
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
			mainpage = {
				path = "mainpage",
				list = {
					scrollview = {
						path = "mainpage/scrollview",
						list = {
							viewport = {
								path = "mainpage/scrollview/viewport",
								list = {
									content = {
										path = "mainpage/scrollview/viewport/content",
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
							},
							scrollbarvertical = {
								path = "mainpage/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "mainpage/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "mainpage/scrollview/scrollbarvertical/slidingarea/handle",
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
					"UIMoveTweener",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			sidepage = {
				path = "sidepage",
				list = {
					scrollview = {
						path = "sidepage/scrollview",
						list = {
							viewport = {
								path = "sidepage/scrollview/viewport",
								list = {
									content = {
										path = "sidepage/scrollview/viewport/content",
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
							},
							scrollbarvertical = {
								path = "sidepage/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "sidepage/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "sidepage/scrollview/scrollbarvertical/slidingarea/handle",
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
					"UIMoveTweener",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			top = {
				path = "top",
				list = {
					return_btn = {
						path = "top/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					title_text = {
						path = "top/title_text",
						list = {
							dot_image = {
								path = "top/title_text/dot_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							desc_text = {
								path = "top/title_text/desc_text",
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
							"UnityEngine.UI.Text"
						}
					},
					line_bg = {
						path = "top/line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					change_limit = {
						path = "top/change_limit",
						list = {
							change_name = {
								path = "top/change_limit/change_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							change_time = {
								path = "top/change_limit/change_time",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							Image = {
								path = "top/change_limit/Image",
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
					search_btn = {
						path = "top/search_btn",
						list = {
							search = {
								path = "top/search_btn/search",
								list = {
									input_text = {
										path = "top/search_btn/search/input_text",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					ship_type_btn = {
						path = "top/ship_type_btn",
						list = {
							text = {
								path = "top/ship_type_btn/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							type_text = {
								path = "top/ship_type_btn/type_text",
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
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			type_layer = {
				path = "type_layer",
				list = {
					bg = {
						path = "type_layer/bg",
						list = {
							line_mid = {
								path = "type_layer/bg/line_mid",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							filter_type = {
								path = "type_layer/bg/filter_type",
								list = {
									sort_title_line = {
										path = "type_layer/bg/filter_type/sort_title_line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									type_txt = {
										path = "type_layer/bg/filter_type/type_txt",
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
							btn_series = {
								path = "type_layer/bg/btn_series",
								list = {
									confirm_btn = {
										path = "type_layer/bg/btn_series/confirm_btn",
										list = {
											confirm = {
												path = "type_layer/bg/btn_series/confirm_btn/confirm",
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
									cancel_btn = {
										path = "type_layer/bg/btn_series/cancel_btn",
										list = {
											cancel = {
												path = "type_layer/bg/btn_series/cancel_btn/cancel",
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
							effect_group = {
								path = "type_layer/bg/effect_group",
								list = {
									toggle_group = {
										path = "type_layer/bg/effect_group/toggle_group",
										list = {
											all = {
												path = "type_layer/bg/effect_group/toggle_group/all",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/all/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/all/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/all/Label",
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
											shell_effect = {
												path = "type_layer/bg/effect_group/toggle_group/shell_effect",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/shell_effect/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/shell_effect/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/shell_effect/Label",
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
											live = {
												path = "type_layer/bg/effect_group/toggle_group/live",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/live/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/live/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/live/Label",
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
											sp_music = {
												path = "type_layer/bg/effect_group/toggle_group/sp_music",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/sp_music/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/sp_music/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/sp_music/Label",
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
											sp_dialogue = {
												path = "type_layer/bg/effect_group/toggle_group/sp_dialogue",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/sp_dialogue/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/sp_dialogue/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/sp_dialogue/Label",
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
											sp_menu = {
												path = "type_layer/bg/effect_group/toggle_group/sp_menu",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/sp_menu/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/sp_menu/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/sp_menu/Label",
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
											airplane = {
												path = "type_layer/bg/effect_group/toggle_group/airplane",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/airplane/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/airplane/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/airplane/Label",
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
											voice = {
												path = "type_layer/bg/effect_group/toggle_group/voice",
												list = {
													Background = {
														path = "type_layer/bg/effect_group/toggle_group/voice/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/effect_group/toggle_group/voice/Background/Checkmark",
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
													Label = {
														path = "type_layer/bg/effect_group/toggle_group/voice/Label",
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
		call_node_list = {
			["voucher_shop/sidepage/scrollview/viewport"] = "_control.sidepage.scrollview.viewport",
			["voucher_shop/buy_msgbox/main/title_text/gogo"] = "_control.buy_msgbox.main.title_text.gogo",
			["voucher_shop/buy_msgbox"] = "_control.buy_msgbox",
			["voucher_shop/type_layer/bg/effect_group"] = "_control.type_layer.bg.effect_group",
			["voucher_shop/top/search_btn"] = "_control.top.search_btn",
			["voucher_shop/type_layer/bg/filter_type"] = "_control.type_layer.bg.filter_type",
			["voucher_shop/type_layer/bg/btn_series"] = "_control.type_layer.bg.btn_series",
			["voucher_shop/type_layer/bg"] = "_control.type_layer.bg",
			["voucher_shop/type_layer/bg/btn_series/confirm_btn/confirm"] = "_control.type_layer.bg.btn_series.confirm_btn.confirm",
			["voucher_shop/sidepage/scrollview/scrollbarvertical/slidingarea"] = "_control.sidepage.scrollview.scrollbarvertical.slidingarea",
			["voucher_shop/type_layer/bg/line_mid"] = "_control.type_layer.bg.line_mid",
			["voucher_shop/mainpage/scrollview/viewport/content"] = "_control.mainpage.scrollview.viewport.content",
			["voucher_shop/sidepage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.sidepage.scrollview.scrollbarvertical.slidingarea.handle",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/all/Background"] = "_control.type_layer.bg.effect_group.toggle_group.all.Background",
			["voucher_shop/buy_msgbox/main/main_text"] = "_control.buy_msgbox.main.main_text",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/voice/Label"] = "_control.type_layer.bg.effect_group.toggle_group.voice.Label",
			["voucher_shop/mainpage/scrollview"] = "_control.mainpage.scrollview",
			["voucher_shop/top/change_limit"] = "_control.top.change_limit",
			["voucher_shop/shine"] = "_control.shine",
			["voucher_shop/type_layer/bg/filter_type/type_txt"] = "_control.type_layer.bg.filter_type.type_txt",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/shell_effect/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.shell_effect.Background.Checkmark",
			["voucher_shop/mainpage"] = "_control.mainpage",
			["voucher_shop/buy_msgbox/main"] = "_control.buy_msgbox.main",
			["voucher_shop/buy_msgbox/main/main_text/text"] = "_control.buy_msgbox.main.main_text.text",
			["voucher_shop/sidepage/scrollview"] = "_control.sidepage.scrollview",
			["voucher_shop/top/return_btn"] = "_control.top.return_btn",
			["voucher_shop/buy_msgbox/main/title_text"] = "_control.buy_msgbox.main.title_text",
			["voucher_shop/sidepage/scrollview/viewport/content"] = "_control.sidepage.scrollview.viewport.content",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/shell_effect/Background"] = "_control.type_layer.bg.effect_group.toggle_group.shell_effect.Background",
			["voucher_shop/top/ship_type_btn/type_text"] = "_control.top.ship_type_btn.type_text",
			["voucher_shop/buy_msgbox/main/top_bg"] = "_control.buy_msgbox.main.top_bg",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/live/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.live.Background.Checkmark",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_music"] = "_control.type_layer.bg.effect_group.toggle_group.sp_music",
			["voucher_shop/type_layer/bg/filter_type/sort_title_line"] = "_control.type_layer.bg.filter_type.sort_title_line",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_music/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.sp_music.Background.Checkmark",
			["voucher_shop/mainpage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.mainpage.scrollview.scrollbarvertical.slidingarea.handle",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_music/Label"] = "_control.type_layer.bg.effect_group.toggle_group.sp_music.Label",
			["voucher_shop/top/change_limit/Image"] = "_control.top.change_limit.Image",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_dialogue/Background"] = "_control.type_layer.bg.effect_group.toggle_group.sp_dialogue.Background",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_dialogue/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.sp_dialogue.Background.Checkmark",
			["voucher_shop/mainpage/scrollview/scrollbarvertical"] = "_control.mainpage.scrollview.scrollbarvertical",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_menu"] = "_control.type_layer.bg.effect_group.toggle_group.sp_menu",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_menu/Background"] = "_control.type_layer.bg.effect_group.toggle_group.sp_menu.Background",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_menu/Label"] = "_control.type_layer.bg.effect_group.toggle_group.sp_menu.Label",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/airplane/Background"] = "_control.type_layer.bg.effect_group.toggle_group.airplane.Background",
			["voucher_shop/buy_msgbox/main/confirmbtn"] = "_control.buy_msgbox.main.confirmbtn",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/all"] = "_control.type_layer.bg.effect_group.toggle_group.all",
			["voucher_shop/type_layer/bg/effect_group/toggle_group"] = "_control.type_layer.bg.effect_group.toggle_group",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/airplane/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.airplane.Background.Checkmark",
			["voucher_shop/top"] = "_control.top",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/live/Label"] = "_control.type_layer.bg.effect_group.toggle_group.live.Label",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_dialogue"] = "_control.type_layer.bg.effect_group.toggle_group.sp_dialogue",
			["voucher_shop/top/title_text/dot_image"] = "_control.top.title_text.dot_image",
			["voucher_shop/type_layer/bg/btn_series/cancel_btn"] = "_control.type_layer.bg.btn_series.cancel_btn",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/airplane/Label"] = "_control.type_layer.bg.effect_group.toggle_group.airplane.Label",
			["voucher_shop/top/ship_type_btn"] = "_control.top.ship_type_btn",
			["voucher_shop/type_layer/bg/btn_series/cancel_btn/cancel"] = "_control.type_layer.bg.btn_series.cancel_btn.cancel",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/voice"] = "_control.type_layer.bg.effect_group.toggle_group.voice",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/shell_effect"] = "_control.type_layer.bg.effect_group.toggle_group.shell_effect",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.all.Background.Checkmark",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/voice/Background"] = "_control.type_layer.bg.effect_group.toggle_group.voice.Background",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/voice/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.voice.Background.Checkmark",
			["voucher_shop/top/change_limit/change_time"] = "_control.top.change_limit.change_time",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_music/Background"] = "_control.type_layer.bg.effect_group.toggle_group.sp_music.Background",
			["voucher_shop/top/title_text/desc_text"] = "_control.top.title_text.desc_text",
			["voucher_shop/top/search_btn/search/input_text"] = "_control.top.search_btn.search.input_text",
			["voucher_shop/sidepage/scrollview/scrollbarvertical"] = "_control.sidepage.scrollview.scrollbarvertical",
			["voucher_shop/type_layer/bg/btn_series/confirm_btn"] = "_control.type_layer.bg.btn_series.confirm_btn",
			["voucher_shop/top/line_bg"] = "_control.top.line_bg",
			["voucher_shop/buy_msgbox/main/main_bg"] = "_control.buy_msgbox.main.main_bg",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/shell_effect/Label"] = "_control.type_layer.bg.effect_group.toggle_group.shell_effect.Label",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/live"] = "_control.type_layer.bg.effect_group.toggle_group.live",
			["voucher_shop/top/search_btn/search"] = "_control.top.search_btn.search",
			["voucher_shop/buy_msgbox/main/confirmbtn/text"] = "_control.buy_msgbox.main.confirmbtn.text",
			["voucher_shop/top/title_text"] = "_control.top.title_text",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_menu/Background/Checkmark"] = "_control.type_layer.bg.effect_group.toggle_group.sp_menu.Background.Checkmark",
			["voucher_shop/buy_msgbox/maskbg"] = "_control.buy_msgbox.maskbg",
			["voucher_shop/buy_msgbox/main/quitbtn/text"] = "_control.buy_msgbox.main.quitbtn.text",
			["voucher_shop/buy_msgbox/main/top_decore"] = "_control.buy_msgbox.main.top_decore",
			["voucher_shop/bg"] = "_control.bg",
			["voucher_shop/top/ship_type_btn/text"] = "_control.top.ship_type_btn.text",
			["voucher_shop/buy_msgbox/main/quitbtn"] = "_control.buy_msgbox.main.quitbtn",
			["voucher_shop/type_layer"] = "_control.type_layer",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/all/Label"] = "_control.type_layer.bg.effect_group.toggle_group.all.Label",
			["voucher_shop/sidepage"] = "_control.sidepage",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/airplane"] = "_control.type_layer.bg.effect_group.toggle_group.airplane",
			["voucher_shop/mainpage/scrollview/viewport"] = "_control.mainpage.scrollview.viewport",
			["voucher_shop/mainpage/scrollview/scrollbarvertical/slidingarea"] = "_control.mainpage.scrollview.scrollbarvertical.slidingarea",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/live/Background"] = "_control.type_layer.bg.effect_group.toggle_group.live.Background",
			["voucher_shop/top/change_limit/change_name"] = "_control.top.change_limit.change_name",
			["voucher_shop/type_layer/bg/effect_group/toggle_group/sp_dialogue/Label"] = "_control.type_layer.bg.effect_group.toggle_group.sp_dialogue.Label"
		},
		click = {
			["buy_msgbox/main/quitbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buy_msgbox/main/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/search_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/ship_type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/bg/btn_series/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/bg/btn_series/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["type_layer/bg/effect_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/effect_group/toggle_group/shell_effect"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/effect_group/toggle_group/live"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/effect_group/toggle_group/sp_music"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/effect_group/toggle_group/sp_dialogue"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/effect_group/toggle_group/sp_menu"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/effect_group/toggle_group/airplane"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/effect_group/toggle_group/voice"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			buy_msgbox = {
				component = "UnityEngine.Canvas",
				path = "buy_msgbox"
			}
		}
	}
}

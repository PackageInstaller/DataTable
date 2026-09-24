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
							top = {
								path = "buy_msgbox/main/top",
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
							quitbtn_revert = {
								path = "buy_msgbox/main/quitbtn_revert",
								list = {
									text = {
										path = "buy_msgbox/main/quitbtn_revert/text",
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
							confirmbtn_revert = {
								path = "buy_msgbox/main/confirmbtn_revert",
								list = {
									text = {
										path = "buy_msgbox/main/confirmbtn_revert/text",
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
							closebtn = {
								path = "buy_msgbox/main/closebtn",
								list = {},
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
			npc = {
				path = "npc",
				list = {
					img = {
						path = "npc/img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					talk = {
						path = "npc/talk",
						list = {
							bg1 = {
								path = "npc/talk/bg1",
								list = {
									bg2 = {
										path = "npc/talk/bg1/bg2",
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
							label_txt = {
								path = "npc/talk/label_txt",
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
							"UnityEngine.CanvasGroup",
							"PopVerticalAdaptive",
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence",
					"UIMoveTweener",
					"UIMoveTweener",
					"UnityEngine.UI.Button"
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
							desc = {
								path = "top/title_text/desc",
								list = {
									desc_text = {
										path = "top/title_text/desc/desc_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									desc_text_2 = {
										path = "top/title_text/desc/desc_text_2",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
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
					score = {
						path = "top/score",
						list = {
							icon = {
								path = "top/score/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							score_node = {
								path = "top/score/score_node",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							score_num = {
								path = "top/score/score_num",
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
					},
					type_btn = {
						path = "top/type_btn",
						list = {
							text = {
								path = "top/type_btn/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							type_text = {
								path = "top/type_btn/type_text",
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
					},
					revert_btn = {
						path = "top/revert_btn",
						list = {
							revert_text = {
								path = "top/revert_btn/revert_text",
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
					"UIMoveTweener"
				}
			},
			type = {
				path = "type",
				list = {
					bg_shadow = {
						path = "type/bg_shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup",
							"UnityEngine.UI.Button"
						}
					},
					btn_group = {
						path = "type/btn_group",
						list = {
							all = {
								path = "type/btn_group/all",
								list = {
									text = {
										path = "type/btn_group/all/text",
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
									"UnityEngine.UI.Toggle"
								}
							},
							disable = {
								path = "type/btn_group/disable",
								list = {
									text = {
										path = "type/btn_group/disable/text",
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
									"UnityEngine.CanvasGroup",
									"UnityEngine.UI.Toggle"
								}
							},
							brought = {
								path = "type/btn_group/brought",
								list = {
									text = {
										path = "type/btn_group/brought/text",
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
									"UnityEngine.CanvasGroup",
									"UnityEngine.UI.Toggle"
								}
							},
							active = {
								path = "type/btn_group/active",
								list = {
									text = {
										path = "type/btn_group/active/text",
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
									"UnityEngine.CanvasGroup",
									"UnityEngine.UI.Toggle"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			type_layer = {
				path = "type_layer",
				list = {
					line_mid = {
						path = "type_layer/line_mid",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					filter_type = {
						path = "type_layer/filter_type",
						list = {
							sort_title_line = {
								path = "type_layer/filter_type/sort_title_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_txt = {
								path = "type_layer/filter_type/type_txt",
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
						path = "type_layer/btn_series",
						list = {
							confirm_btn = {
								path = "type_layer/btn_series/confirm_btn",
								list = {
									confirm = {
										path = "type_layer/btn_series/confirm_btn/confirm",
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
								path = "type_layer/btn_series/cancel_btn",
								list = {
									cancel = {
										path = "type_layer/btn_series/cancel_btn/cancel",
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
					country_group = {
						path = "type_layer/country_group",
						list = {
							toggle_group = {
								path = "type_layer/country_group/toggle_group",
								list = {
									all = {
										path = "type_layer/country_group/toggle_group/all",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/all/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/all/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/all/Label",
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
									C_country = {
										path = "type_layer/country_group/toggle_group/C_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/C_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/C_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/C_country/Label",
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
									E_country = {
										path = "type_layer/country_group/toggle_group/E_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/E_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/E_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/E_country/Label",
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
									F_country = {
										path = "type_layer/country_group/toggle_group/F_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/F_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/F_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/F_country/Label",
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
									G_country = {
										path = "type_layer/country_group/toggle_group/G_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/G_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/G_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/G_country/Label",
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
									I_country = {
										path = "type_layer/country_group/toggle_group/I_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/I_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/I_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/I_country/Label",
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
									J_country = {
										path = "type_layer/country_group/toggle_group/J_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/J_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/J_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/J_country/Label",
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
									S_country = {
										path = "type_layer/country_group/toggle_group/S_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/S_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/S_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/S_country/Label",
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
									U_country = {
										path = "type_layer/country_group/toggle_group/U_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/U_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/U_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/U_country/Label",
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
									other_country = {
										path = "type_layer/country_group/toggle_group/other_country",
										list = {
											Background = {
												path = "type_layer/country_group/toggle_group/other_country/Background",
												list = {
													Checkmark = {
														path = "type_layer/country_group/toggle_group/other_country/Background/Checkmark",
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
												path = "type_layer/country_group/toggle_group/other_country/Label",
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
					},
					type_group = {
						path = "type_layer/type_group",
						list = {
							toggle_group = {
								path = "type_layer/type_group/toggle_group",
								list = {
									all = {
										path = "type_layer/type_group/toggle_group/all",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/all/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/all/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/all/Label",
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
									CV = {
										path = "type_layer/type_group/toggle_group/CV",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CV/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CV/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CV/Label",
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
									CVL = {
										path = "type_layer/type_group/toggle_group/CVL",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CVL/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CVL/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CVL/Label",
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
									AV = {
										path = "type_layer/type_group/toggle_group/AV",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/AV/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/AV/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/AV/Label",
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
									BB = {
										path = "type_layer/type_group/toggle_group/BB",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/BB/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/BB/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/BB/Label",
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
									BBV = {
										path = "type_layer/type_group/toggle_group/BBV",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/BBV/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/BBV/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/BBV/Label",
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
									BC = {
										path = "type_layer/type_group/toggle_group/BC",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/BC/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/BC/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/BC/Label",
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
									CA = {
										path = "type_layer/type_group/toggle_group/CA",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CA/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CA/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CA/Label",
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
									CAV = {
										path = "type_layer/type_group/toggle_group/CAV",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CAV/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CAV/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CAV/Label",
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
									CLT = {
										path = "type_layer/type_group/toggle_group/CLT",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CLT/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CLT/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CLT/Label",
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
									CL = {
										path = "type_layer/type_group/toggle_group/CL",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CL/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CL/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CL/Label",
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
									BM = {
										path = "type_layer/type_group/toggle_group/BM",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/BM/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/BM/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/BM/Label",
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
									DD = {
										path = "type_layer/type_group/toggle_group/DD",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/DD/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/DD/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/DD/Label",
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
									SSG = {
										path = "type_layer/type_group/toggle_group/SSG",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/SSG/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/SSG/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/SSG/Label",
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
									SS = {
										path = "type_layer/type_group/toggle_group/SS",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/SS/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/SS/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/SS/Label",
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
									SC = {
										path = "type_layer/type_group/toggle_group/SC",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/SC/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/SC/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/SC/Label",
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
									AP = {
										path = "type_layer/type_group/toggle_group/AP",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/AP/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/AP/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/AP/Label",
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
									ASDG = {
										path = "type_layer/type_group/toggle_group/ASDG",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/ASDG/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/ASDG/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/ASDG/Label",
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
									AADG = {
										path = "type_layer/type_group/toggle_group/AADG",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/AADG/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/AADG/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/AADG/Label",
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
									KP = {
										path = "type_layer/type_group/toggle_group/KP",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/KP/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/KP/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/KP/Label",
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
									CG = {
										path = "type_layer/type_group/toggle_group/CG",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CG/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CG/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CG/Label",
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
									CBG = {
										path = "type_layer/type_group/toggle_group/CBG",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/CBG/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/CBG/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/CBG/Label",
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
									BBG = {
										path = "type_layer/type_group/toggle_group/BBG",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/BBG/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/BBG/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/BBG/Label",
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
									BG = {
										path = "type_layer/type_group/toggle_group/BG",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/BG/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/BG/Background/Checkmark",
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
												path = "type_layer/type_group/toggle_group/BG/Label",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					size_group = {
						path = "type_layer/size_group",
						list = {
							toggle_group = {
								path = "type_layer/size_group/toggle_group",
								list = {
									all = {
										path = "type_layer/size_group/toggle_group/all",
										list = {
											Background = {
												path = "type_layer/size_group/toggle_group/all/Background",
												list = {
													Checkmark = {
														path = "type_layer/size_group/toggle_group/all/Background/Checkmark",
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
												path = "type_layer/size_group/toggle_group/all/Label",
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
									large = {
										path = "type_layer/size_group/toggle_group/large",
										list = {
											Background = {
												path = "type_layer/size_group/toggle_group/large/Background",
												list = {
													Checkmark = {
														path = "type_layer/size_group/toggle_group/large/Background/Checkmark",
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
												path = "type_layer/size_group/toggle_group/large/Label",
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
									middle = {
										path = "type_layer/size_group/toggle_group/middle",
										list = {
											Background = {
												path = "type_layer/size_group/toggle_group/middle/Background",
												list = {
													Checkmark = {
														path = "type_layer/size_group/toggle_group/middle/Background/Checkmark",
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
												path = "type_layer/size_group/toggle_group/middle/Label",
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
									small = {
										path = "type_layer/size_group/toggle_group/small",
										list = {
											Background = {
												path = "type_layer/size_group/toggle_group/small/Background",
												list = {
													Checkmark = {
														path = "type_layer/size_group/toggle_group/small/Background/Checkmark",
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
												path = "type_layer/size_group/toggle_group/small/Label",
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
									maip = {
										path = "type_layer/size_group/toggle_group/maip",
										list = {
											Background = {
												path = "type_layer/size_group/toggle_group/maip/Background",
												list = {
													Checkmark = {
														path = "type_layer/size_group/toggle_group/maip/Background/Checkmark",
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
												path = "type_layer/size_group/toggle_group/maip/Label",
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
									protect = {
										path = "type_layer/size_group/toggle_group/protect",
										list = {
											Background = {
												path = "type_layer/size_group/toggle_group/protect/Background",
												list = {
													Checkmark = {
														path = "type_layer/size_group/toggle_group/protect/Background/Checkmark",
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
												path = "type_layer/size_group/toggle_group/protect/Label",
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
					},
					buff_type_group = {
						path = "type_layer/buff_type_group",
						list = {
							toggle_group = {
								path = "type_layer/buff_type_group/toggle_group",
								list = {
									all = {
										path = "type_layer/buff_type_group/toggle_group/all",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/all/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/all/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/all/Label",
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
									attribute_up = {
										path = "type_layer/buff_type_group/toggle_group/attribute_up",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/attribute_up/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/attribute_up/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/attribute_up/Label",
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
									damage_up = {
										path = "type_layer/buff_type_group/toggle_group/damage_up",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/damage_up/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/damage_up/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/damage_up/Label",
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
									ignore_hurt = {
										path = "type_layer/buff_type_group/toggle_group/ignore_hurt",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/ignore_hurt/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/ignore_hurt/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/ignore_hurt/Label",
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
									ignore_lack_ammu = {
										path = "type_layer/buff_type_group/toggle_group/ignore_lack_ammu",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/ignore_lack_ammu/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/ignore_lack_ammu/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/ignore_lack_ammu/Label",
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
									capacity_up = {
										path = "type_layer/buff_type_group/toggle_group/capacity_up",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/capacity_up/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/capacity_up/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/capacity_up/Label",
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
									support_atk = {
										path = "type_layer/buff_type_group/toggle_group/support_atk",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/support_atk/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/support_atk/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/support_atk/Label",
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
							}
						},
						component = {}
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
		call_node_list = {
			["ninth_cia/type_layer/buff_type_group/toggle_group/damage_up/Label"] = "_control.type_layer.buff_type_group.toggle_group.damage_up.Label",
			["ninth_cia/type_layer/buff_type_group/toggle_group/attribute_up/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.attribute_up.Background.Checkmark",
			["ninth_cia/type_layer/buff_type_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.all.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/DD/Background"] = "_control.type_layer.type_group.toggle_group.DD.Background",
			["ninth_cia/type/btn_group/all"] = "_control.type.btn_group.all",
			["ninth_cia/type_layer/country_group/toggle_group/C_country/Label"] = "_control.type_layer.country_group.toggle_group.C_country.Label",
			["ninth_cia/type_layer/buff_type_group/toggle_group/damage_up/Background"] = "_control.type_layer.buff_type_group.toggle_group.damage_up.Background",
			["ninth_cia/type_layer/size_group/toggle_group/maip"] = "_control.type_layer.size_group.toggle_group.maip",
			["ninth_cia/type_layer/size_group/toggle_group/small/Background"] = "_control.type_layer.size_group.toggle_group.small.Background",
			["ninth_cia/type_layer/country_group/toggle_group/E_country"] = "_control.type_layer.country_group.toggle_group.E_country",
			["ninth_cia/type_layer/size_group/toggle_group/large/Label"] = "_control.type_layer.size_group.toggle_group.large.Label",
			["ninth_cia/type_layer/type_group/toggle_group/ASDG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.ASDG.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/DD/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.DD.Background.Checkmark",
			["ninth_cia/type_layer/size_group/toggle_group/all/Label"] = "_control.type_layer.size_group.toggle_group.all.Label",
			["ninth_cia/mainpage/scrollview/viewport"] = "_control.mainpage.scrollview.viewport",
			["ninth_cia/type_layer/size_group/toggle_group"] = "_control.type_layer.size_group.toggle_group",
			["ninth_cia/type_layer/type_group/toggle_group/ASDG"] = "_control.type_layer.type_group.toggle_group.ASDG",
			["ninth_cia/type_layer/type_group/toggle_group/KP/Background"] = "_control.type_layer.type_group.toggle_group.KP.Background",
			["ninth_cia/type_layer/type_group/toggle_group/BG/Label"] = "_control.type_layer.type_group.toggle_group.BG.Label",
			["ninth_cia/type_layer/type_group/toggle_group/BG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BG.Background.Checkmark",
			["ninth_cia/top/title_text/desc/desc_text"] = "_control.top.title_text.desc.desc_text",
			["ninth_cia/type_layer/filter_type/sort_title_line"] = "_control.type_layer.filter_type.sort_title_line",
			["ninth_cia/top/line_bg"] = "_control.top.line_bg",
			["ninth_cia/type_layer/type_group/toggle_group/BBG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BBG.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/BG"] = "_control.type_layer.type_group.toggle_group.BG",
			["ninth_cia/type_layer/type_group/toggle_group/CBG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CBG.Background.Checkmark",
			["ninth_cia/type_layer/country_group/toggle_group/G_country/Background"] = "_control.type_layer.country_group.toggle_group.G_country.Background",
			["ninth_cia/type_layer/type_group/toggle_group/CBG/Background"] = "_control.type_layer.type_group.toggle_group.CBG.Background",
			["ninth_cia/type_layer/type_group/toggle_group/BB/Background"] = "_control.type_layer.type_group.toggle_group.BB.Background",
			["ninth_cia/buy_msgbox/main/main_bg"] = "_control.buy_msgbox.main.main_bg",
			["ninth_cia/type_layer/size_group/toggle_group/large/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.large.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/SS"] = "_control.type_layer.type_group.toggle_group.SS",
			["ninth_cia/type_layer/type_group/toggle_group/KP/Label"] = "_control.type_layer.type_group.toggle_group.KP.Label",
			["ninth_cia/type_layer/buff_type_group/toggle_group"] = "_control.type_layer.buff_type_group.toggle_group",
			["ninth_cia/buy_msgbox/main/top_decore"] = "_control.buy_msgbox.main.top_decore",
			["ninth_cia/type_layer/type_group/toggle_group/AADG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.AADG.Background.Checkmark",
			["ninth_cia/type_layer/size_group/toggle_group/protect"] = "_control.type_layer.size_group.toggle_group.protect",
			["ninth_cia/type_layer/type_group/toggle_group/CG"] = "_control.type_layer.type_group.toggle_group.CG",
			["ninth_cia/type_layer/type_group/toggle_group/ASDG/Label"] = "_control.type_layer.type_group.toggle_group.ASDG.Label",
			["ninth_cia/type_layer/size_group/toggle_group/large/Background"] = "_control.type_layer.size_group.toggle_group.large.Background",
			["ninth_cia/type_layer/type_group/toggle_group/ASDG/Background"] = "_control.type_layer.type_group.toggle_group.ASDG.Background",
			["ninth_cia/type_layer/country_group/toggle_group/C_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.C_country.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/AP/Label"] = "_control.type_layer.type_group.toggle_group.AP.Label",
			["ninth_cia/type_layer/type_group/toggle_group/AP"] = "_control.type_layer.type_group.toggle_group.AP",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_hurt/Label"] = "_control.type_layer.buff_type_group.toggle_group.ignore_hurt.Label",
			["ninth_cia/type_layer/size_group/toggle_group/all"] = "_control.type_layer.size_group.toggle_group.all",
			["ninth_cia/type_layer/type_group/toggle_group/SC/Label"] = "_control.type_layer.type_group.toggle_group.SC.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CV/Label"] = "_control.type_layer.type_group.toggle_group.CV.Label",
			["ninth_cia/type_layer/type_group/toggle_group/SC/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.SC.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/SC/Background"] = "_control.type_layer.type_group.toggle_group.SC.Background",
			["ninth_cia/type_layer/type_group/toggle_group/SS/Label"] = "_control.type_layer.type_group.toggle_group.SS.Label",
			["ninth_cia/type_layer/type_group/toggle_group/SS/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.SS.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/SS/Background"] = "_control.type_layer.type_group.toggle_group.SS.Background",
			["ninth_cia/type_layer/size_group/toggle_group/all/Background"] = "_control.type_layer.size_group.toggle_group.all.Background",
			["ninth_cia/type_layer/type_group/toggle_group/CG/Background"] = "_control.type_layer.type_group.toggle_group.CG.Background",
			["ninth_cia/type_layer/type_group/toggle_group/SSG/Label"] = "_control.type_layer.type_group.toggle_group.SSG.Label",
			["ninth_cia/type_layer/type_group/toggle_group/SSG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.SSG.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/SSG/Background"] = "_control.type_layer.type_group.toggle_group.SSG.Background",
			["ninth_cia/top/return_btn"] = "_control.top.return_btn",
			["ninth_cia/type_layer/type_group/toggle_group/DD/Label"] = "_control.type_layer.type_group.toggle_group.DD.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CBG/Label"] = "_control.type_layer.type_group.toggle_group.CBG.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CV"] = "_control.type_layer.type_group.toggle_group.CV",
			["ninth_cia/type_layer/type_group/toggle_group/BM/Label"] = "_control.type_layer.type_group.toggle_group.BM.Label",
			["ninth_cia/type_layer/type_group/toggle_group/BM/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BM.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/BM/Background"] = "_control.type_layer.type_group.toggle_group.BM.Background",
			["ninth_cia/type_layer/type_group/toggle_group/all"] = "_control.type_layer.type_group.toggle_group.all",
			["ninth_cia/type_layer/type_group/toggle_group/CL/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CL.Background.Checkmark",
			["ninth_cia/npc/talk"] = "_control.npc.talk",
			["ninth_cia/type_layer/type_group/toggle_group/CLT/Label"] = "_control.type_layer.type_group.toggle_group.CLT.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CLT/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CLT.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/CLT/Background"] = "_control.type_layer.type_group.toggle_group.CLT.Background",
			["ninth_cia/type_layer/country_group/toggle_group/F_country"] = "_control.type_layer.country_group.toggle_group.F_country",
			["ninth_cia/type_layer/type_group/toggle_group/CAV/Label"] = "_control.type_layer.type_group.toggle_group.CAV.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CAV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CAV.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/CAV/Background"] = "_control.type_layer.type_group.toggle_group.CAV.Background",
			["ninth_cia/type_layer/type_group/toggle_group/CAV"] = "_control.type_layer.type_group.toggle_group.CAV",
			["ninth_cia/type_layer/type_group/toggle_group/CA/Label"] = "_control.type_layer.type_group.toggle_group.CA.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CA/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CA.Background.Checkmark",
			["ninth_cia/top/type_btn/type_text"] = "_control.top.type_btn.type_text",
			["ninth_cia/top/ship_type_btn"] = "_control.top.ship_type_btn",
			["ninth_cia/top"] = "_control.top",
			["ninth_cia/type_layer/buff_type_group/toggle_group/all/Label"] = "_control.type_layer.buff_type_group.toggle_group.all.Label",
			["ninth_cia/type_layer/type_group/toggle_group/BC/Background"] = "_control.type_layer.type_group.toggle_group.BC.Background",
			["ninth_cia/type_layer/type_group/toggle_group/BBV/Label"] = "_control.type_layer.type_group.toggle_group.BBV.Label",
			["ninth_cia/type_layer/type_group/toggle_group/BBV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BBV.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/BBV/Background"] = "_control.type_layer.type_group.toggle_group.BBV.Background",
			["ninth_cia/type_layer/type_group/toggle_group/BB/Label"] = "_control.type_layer.type_group.toggle_group.BB.Label",
			["ninth_cia/type_layer/type_group/toggle_group/BB/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BB.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/BC/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BC.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/BC/Label"] = "_control.type_layer.type_group.toggle_group.BC.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CA/Background"] = "_control.type_layer.type_group.toggle_group.CA.Background",
			["ninth_cia/mainpage"] = "_control.mainpage",
			["ninth_cia/type_layer/type_group/toggle_group/AV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.AV.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/AV/Background"] = "_control.type_layer.type_group.toggle_group.AV.Background",
			["ninth_cia/type_layer/type_group/toggle_group/CVL/Label"] = "_control.type_layer.type_group.toggle_group.CVL.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CVL/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CVL.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/CVL/Background"] = "_control.type_layer.type_group.toggle_group.CVL.Background",
			["ninth_cia/buy_msgbox/main/quitbtn_revert/text"] = "_control.buy_msgbox.main.quitbtn_revert.text",
			["ninth_cia/npc"] = "_control.npc",
			["ninth_cia/type_layer/type_group/toggle_group/CL/Background"] = "_control.type_layer.type_group.toggle_group.CL.Background",
			["ninth_cia/type_layer/type_group/toggle_group/CA"] = "_control.type_layer.type_group.toggle_group.CA",
			["ninth_cia/type_layer/type_group/toggle_group/CL/Label"] = "_control.type_layer.type_group.toggle_group.CL.Label",
			["ninth_cia/type_layer/country_group/toggle_group/all/Label"] = "_control.type_layer.country_group.toggle_group.all.Label",
			["ninth_cia/buy_msgbox/main/confirmbtn/text"] = "_control.buy_msgbox.main.confirmbtn.text",
			["ninth_cia/top/score/icon"] = "_control.top.score.icon",
			["ninth_cia/type/btn_group/brought/text"] = "_control.type.btn_group.brought.text",
			["ninth_cia/type_layer/type_group/toggle_group/all/Label"] = "_control.type_layer.type_group.toggle_group.all.Label",
			["ninth_cia/type_layer/country_group/toggle_group/S_country"] = "_control.type_layer.country_group.toggle_group.S_country",
			["ninth_cia/type_layer/country_group/toggle_group/C_country"] = "_control.type_layer.country_group.toggle_group.C_country",
			["ninth_cia/bg"] = "_control.bg",
			["ninth_cia/type_layer/country_group/toggle_group/J_country"] = "_control.type_layer.country_group.toggle_group.J_country",
			["ninth_cia/type_layer/country_group/toggle_group/I_country/Label"] = "_control.type_layer.country_group.toggle_group.I_country.Label",
			["ninth_cia/type_layer/size_group/toggle_group/maip/Background"] = "_control.type_layer.size_group.toggle_group.maip.Background",
			["ninth_cia/top/type_btn"] = "_control.top.type_btn",
			["ninth_cia/type_layer/type_group/toggle_group/all/Background"] = "_control.type_layer.type_group.toggle_group.all.Background",
			["ninth_cia/top/score/score_num"] = "_control.top.score.score_num",
			["ninth_cia/type_layer/country_group/toggle_group/I_country"] = "_control.type_layer.country_group.toggle_group.I_country",
			["ninth_cia/type_layer/type_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.all.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/CV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CV.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/CG/Label"] = "_control.type_layer.type_group.toggle_group.CG.Label",
			["ninth_cia/type_layer"] = "_control.type_layer",
			["ninth_cia/type_layer/type_group/toggle_group/AP/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.AP.Background.Checkmark",
			["ninth_cia/type/btn_group/disable/text"] = "_control.type.btn_group.disable.text",
			["ninth_cia/top/title_text/dot_image"] = "_control.top.title_text.dot_image",
			["ninth_cia/type_layer/country_group/toggle_group/C_country/Background"] = "_control.type_layer.country_group.toggle_group.C_country.Background",
			["ninth_cia/type_layer/buff_type_group/toggle_group/damage_up"] = "_control.type_layer.buff_type_group.toggle_group.damage_up",
			["ninth_cia/type_layer/country_group/toggle_group/S_country/Background"] = "_control.type_layer.country_group.toggle_group.S_country.Background",
			["ninth_cia/type_layer/type_group/toggle_group/AADG/Background"] = "_control.type_layer.type_group.toggle_group.AADG.Background",
			["ninth_cia/type_layer/type_group/toggle_group/AADG/Label"] = "_control.type_layer.type_group.toggle_group.AADG.Label",
			["ninth_cia/type_layer/type_group/toggle_group/BC"] = "_control.type_layer.type_group.toggle_group.BC",
			["ninth_cia/top/revert_btn"] = "_control.top.revert_btn",
			["ninth_cia/top/score"] = "_control.top.score",
			["ninth_cia/type_layer/type_group/toggle_group/KP/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.KP.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/AV"] = "_control.type_layer.type_group.toggle_group.AV",
			["ninth_cia/type_layer/country_group/toggle_group/E_country/Background"] = "_control.type_layer.country_group.toggle_group.E_country.Background",
			["ninth_cia/type_layer/country_group/toggle_group/other_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.other_country.Background.Checkmark",
			["ninth_cia/type_layer/country_group/toggle_group/E_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.E_country.Background.Checkmark",
			["ninth_cia/type/btn_group/active/text"] = "_control.type.btn_group.active.text",
			["ninth_cia/type_layer/country_group/toggle_group/E_country/Label"] = "_control.type_layer.country_group.toggle_group.E_country.Label",
			["ninth_cia/type_layer/country_group/toggle_group/F_country/Background"] = "_control.type_layer.country_group.toggle_group.F_country.Background",
			["ninth_cia/type_layer/btn_series/confirm_btn/confirm"] = "_control.type_layer.btn_series.confirm_btn.confirm",
			["ninth_cia/shine"] = "_control.shine",
			["ninth_cia/type_layer/country_group/toggle_group/F_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.F_country.Background.Checkmark",
			["ninth_cia/npc/talk/label_txt"] = "_control.npc.talk.label_txt",
			["ninth_cia/type_layer/type_group/toggle_group/BBG/Background"] = "_control.type_layer.type_group.toggle_group.BBG.Background",
			["ninth_cia/type_layer/country_group/toggle_group/G_country"] = "_control.type_layer.country_group.toggle_group.G_country",
			["ninth_cia/type_layer/type_group/toggle_group/BBG/Label"] = "_control.type_layer.type_group.toggle_group.BBG.Label",
			["ninth_cia/type_layer/country_group/toggle_group/F_country/Label"] = "_control.type_layer.country_group.toggle_group.F_country.Label",
			["ninth_cia/type_layer/type_group/toggle_group/BG/Background"] = "_control.type_layer.type_group.toggle_group.BG.Background",
			["ninth_cia/type_layer/country_group/toggle_group/I_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.I_country.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/AV/Label"] = "_control.type_layer.type_group.toggle_group.AV.Label",
			["ninth_cia/mainpage/scrollview/scrollbarvertical/slidingarea"] = "_control.mainpage.scrollview.scrollbarvertical.slidingarea",
			["ninth_cia/type_layer/type_group/toggle_group/CV/Background"] = "_control.type_layer.type_group.toggle_group.CV.Background",
			["ninth_cia/top/ship_type_btn/text"] = "_control.top.ship_type_btn.text",
			["ninth_cia/type_layer/country_group/toggle_group/J_country/Background"] = "_control.type_layer.country_group.toggle_group.J_country.Background",
			["ninth_cia/type_layer/country_group/toggle_group/J_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.J_country.Background.Checkmark",
			["ninth_cia/type_layer/country_group/toggle_group/J_country/Label"] = "_control.type_layer.country_group.toggle_group.J_country.Label",
			["ninth_cia/type_layer/country_group"] = "_control.type_layer.country_group",
			["ninth_cia/type_layer/buff_type_group/toggle_group/all"] = "_control.type_layer.buff_type_group.toggle_group.all",
			["ninth_cia/type/btn_group/active"] = "_control.type.btn_group.active",
			["ninth_cia/type_layer/country_group/toggle_group/S_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.S_country.Background.Checkmark",
			["ninth_cia/type_layer/country_group/toggle_group/S_country/Label"] = "_control.type_layer.country_group.toggle_group.S_country.Label",
			["ninth_cia/type_layer/country_group/toggle_group/U_country"] = "_control.type_layer.country_group.toggle_group.U_country",
			["ninth_cia/type_layer/size_group/toggle_group/maip/Label"] = "_control.type_layer.size_group.toggle_group.maip.Label",
			["ninth_cia/type_layer/size_group/toggle_group/protect/Label"] = "_control.type_layer.size_group.toggle_group.protect.Label",
			["ninth_cia/type_layer/country_group/toggle_group/U_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.U_country.Background.Checkmark",
			["ninth_cia/type_layer/country_group/toggle_group/U_country/Label"] = "_control.type_layer.country_group.toggle_group.U_country.Label",
			["ninth_cia/type_layer/type_group/toggle_group"] = "_control.type_layer.type_group.toggle_group",
			["ninth_cia/npc/talk/bg1"] = "_control.npc.talk.bg1",
			["ninth_cia/type_layer/type_group"] = "_control.type_layer.type_group",
			["ninth_cia/type_layer/country_group/toggle_group/I_country/Background"] = "_control.type_layer.country_group.toggle_group.I_country.Background",
			["ninth_cia/type_layer/country_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.all.Background.Checkmark",
			["ninth_cia/type_layer/size_group/toggle_group/small/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.small.Background.Checkmark",
			["ninth_cia/type_layer/type_group/toggle_group/AP/Background"] = "_control.type_layer.type_group.toggle_group.AP.Background",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_lack_ammu"] = "_control.type_layer.buff_type_group.toggle_group.ignore_lack_ammu",
			["ninth_cia/type_layer/buff_type_group/toggle_group/capacity_up/Background"] = "_control.type_layer.buff_type_group.toggle_group.capacity_up.Background",
			["ninth_cia/type_layer/buff_type_group/toggle_group/capacity_up/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.capacity_up.Background.Checkmark",
			["ninth_cia/type_layer/buff_type_group/toggle_group/capacity_up/Label"] = "_control.type_layer.buff_type_group.toggle_group.capacity_up.Label",
			["ninth_cia/type_layer/buff_type_group/toggle_group/support_atk"] = "_control.type_layer.buff_type_group.toggle_group.support_atk",
			["ninth_cia/type_layer/buff_type_group/toggle_group/support_atk/Background"] = "_control.type_layer.buff_type_group.toggle_group.support_atk.Background",
			["ninth_cia/type_layer/buff_type_group/toggle_group/support_atk/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.support_atk.Background.Checkmark",
			["ninth_cia/type_layer/buff_type_group/toggle_group/support_atk/Label"] = "_control.type_layer.buff_type_group.toggle_group.support_atk.Label",
			["ninth_cia/type_layer/type_group/toggle_group/CLT"] = "_control.type_layer.type_group.toggle_group.CLT",
			["ninth_cia/type_layer/btn_series/cancel_btn"] = "_control.type_layer.btn_series.cancel_btn",
			["ninth_cia/type_layer/type_group/toggle_group/SSG"] = "_control.type_layer.type_group.toggle_group.SSG",
			["ninth_cia/type_layer/type_group/toggle_group/BM"] = "_control.type_layer.type_group.toggle_group.BM",
			["ninth_cia/type_layer/type_group/toggle_group/KP"] = "_control.type_layer.type_group.toggle_group.KP",
			["ninth_cia/type_layer/country_group/toggle_group/G_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.G_country.Background.Checkmark",
			["ninth_cia/type_layer/btn_series/confirm_btn"] = "_control.type_layer.btn_series.confirm_btn",
			["ninth_cia/type/btn_group"] = "_control.type.btn_group",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_hurt/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.ignore_hurt.Background.Checkmark",
			["ninth_cia/type/btn_group/brought"] = "_control.type.btn_group.brought",
			["ninth_cia/buy_msgbox/main/closebtn"] = "_control.buy_msgbox.main.closebtn",
			["ninth_cia/buy_msgbox/main/title_text/gogo"] = "_control.buy_msgbox.main.title_text.gogo",
			["ninth_cia/type_layer/buff_type_group"] = "_control.type_layer.buff_type_group",
			["ninth_cia/top/title_text/desc/desc_text_2"] = "_control.top.title_text.desc.desc_text_2",
			["ninth_cia/type_layer/buff_type_group/toggle_group/attribute_up"] = "_control.type_layer.buff_type_group.toggle_group.attribute_up",
			["ninth_cia/buy_msgbox/maskbg"] = "_control.buy_msgbox.maskbg",
			["ninth_cia/type_layer/buff_type_group/toggle_group/damage_up/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.damage_up.Background.Checkmark",
			["ninth_cia/type_layer/filter_type/type_txt"] = "_control.type_layer.filter_type.type_txt",
			["ninth_cia/type_layer/country_group/toggle_group/other_country/Label"] = "_control.type_layer.country_group.toggle_group.other_country.Label",
			["ninth_cia/type_layer/type_group/toggle_group/AADG"] = "_control.type_layer.type_group.toggle_group.AADG",
			["ninth_cia/type_layer/size_group/toggle_group/maip/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.maip.Background.Checkmark",
			["ninth_cia/type_layer/size_group"] = "_control.type_layer.size_group",
			["ninth_cia/type"] = "_control.type",
			["ninth_cia/mainpage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.mainpage.scrollview.scrollbarvertical.slidingarea.handle",
			["ninth_cia/mainpage/scrollview/viewport/content"] = "_control.mainpage.scrollview.viewport.content",
			["ninth_cia/type_layer/buff_type_group/toggle_group/attribute_up/Label"] = "_control.type_layer.buff_type_group.toggle_group.attribute_up.Label",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_lack_ammu/Label"] = "_control.type_layer.buff_type_group.toggle_group.ignore_lack_ammu.Label",
			["ninth_cia/type_layer/buff_type_group/toggle_group/capacity_up"] = "_control.type_layer.buff_type_group.toggle_group.capacity_up",
			["ninth_cia/mainpage/scrollview"] = "_control.mainpage.scrollview",
			["ninth_cia/type_layer/size_group/toggle_group/protect/Background"] = "_control.type_layer.size_group.toggle_group.protect.Background",
			["ninth_cia/buy_msgbox/main/confirmbtn_revert/text"] = "_control.buy_msgbox.main.confirmbtn_revert.text",
			["ninth_cia/top/ship_type_btn/type_text"] = "_control.top.ship_type_btn.type_text",
			["ninth_cia/type_layer/size_group/toggle_group/middle"] = "_control.type_layer.size_group.toggle_group.middle",
			["ninth_cia/type_layer/type_group/toggle_group/CG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CG.Background.Checkmark",
			["ninth_cia/npc/img"] = "_control.npc.img",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_hurt"] = "_control.type_layer.buff_type_group.toggle_group.ignore_hurt",
			["ninth_cia/type_layer/size_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.all.Background.Checkmark",
			["ninth_cia/type_layer/buff_type_group/toggle_group/attribute_up/Background"] = "_control.type_layer.buff_type_group.toggle_group.attribute_up.Background",
			["ninth_cia/type_layer/size_group/toggle_group/middle/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.middle.Background.Checkmark",
			["ninth_cia/buy_msgbox/main/quitbtn/text"] = "_control.buy_msgbox.main.quitbtn.text",
			["ninth_cia/type_layer/size_group/toggle_group/middle/Background"] = "_control.type_layer.size_group.toggle_group.middle.Background",
			["ninth_cia/type_layer/country_group/toggle_group/other_country/Background"] = "_control.type_layer.country_group.toggle_group.other_country.Background",
			["ninth_cia/type_layer/type_group/toggle_group/DD"] = "_control.type_layer.type_group.toggle_group.DD",
			["ninth_cia/type_layer/type_group/toggle_group/CBG"] = "_control.type_layer.type_group.toggle_group.CBG",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_hurt/Background"] = "_control.type_layer.buff_type_group.toggle_group.ignore_hurt.Background",
			["ninth_cia/buy_msgbox"] = "_control.buy_msgbox",
			["ninth_cia/type_layer/type_group/toggle_group/BB"] = "_control.type_layer.type_group.toggle_group.BB",
			["ninth_cia/type_layer/type_group/toggle_group/CVL"] = "_control.type_layer.type_group.toggle_group.CVL",
			["ninth_cia/buy_msgbox/main"] = "_control.buy_msgbox.main",
			["ninth_cia/type_layer/btn_series"] = "_control.type_layer.btn_series",
			["ninth_cia/top/type_btn/text"] = "_control.top.type_btn.text",
			["ninth_cia/buy_msgbox/main/quitbtn"] = "_control.buy_msgbox.main.quitbtn",
			["ninth_cia/buy_msgbox/main/main_text/text"] = "_control.buy_msgbox.main.main_text.text",
			["ninth_cia/type_layer/type_group/toggle_group/BBG"] = "_control.type_layer.type_group.toggle_group.BBG",
			["ninth_cia/top/revert_btn/revert_text"] = "_control.top.revert_btn.revert_text",
			["ninth_cia/type_layer/type_group/toggle_group/CL"] = "_control.type_layer.type_group.toggle_group.CL",
			["ninth_cia/type_layer/filter_type"] = "_control.type_layer.filter_type",
			["ninth_cia/type_layer/country_group/toggle_group"] = "_control.type_layer.country_group.toggle_group",
			["ninth_cia/type_layer/size_group/toggle_group/protect/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.protect.Background.Checkmark",
			["ninth_cia/npc/talk/bg1/bg2"] = "_control.npc.talk.bg1.bg2",
			["ninth_cia/type_layer/type_group/toggle_group/SC"] = "_control.type_layer.type_group.toggle_group.SC",
			["ninth_cia/type_layer/country_group/toggle_group/all/Background"] = "_control.type_layer.country_group.toggle_group.all.Background",
			["ninth_cia/top/title_text"] = "_control.top.title_text",
			["ninth_cia/buy_msgbox/main/quitbtn_revert"] = "_control.buy_msgbox.main.quitbtn_revert",
			["ninth_cia/type_layer/country_group/toggle_group/other_country"] = "_control.type_layer.country_group.toggle_group.other_country",
			["ninth_cia/type_layer/size_group/toggle_group/large"] = "_control.type_layer.size_group.toggle_group.large",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_lack_ammu/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.ignore_lack_ammu.Background.Checkmark",
			["ninth_cia/type_layer/buff_type_group/toggle_group/ignore_lack_ammu/Background"] = "_control.type_layer.buff_type_group.toggle_group.ignore_lack_ammu.Background",
			["ninth_cia/buy_msgbox/main/confirmbtn"] = "_control.buy_msgbox.main.confirmbtn",
			["ninth_cia/buy_msgbox/main/confirmbtn_revert"] = "_control.buy_msgbox.main.confirmbtn_revert",
			["ninth_cia/type_layer/line_mid"] = "_control.type_layer.line_mid",
			["ninth_cia/type_layer/country_group/toggle_group/U_country/Background"] = "_control.type_layer.country_group.toggle_group.U_country.Background",
			["ninth_cia/type_layer/size_group/toggle_group/middle/Label"] = "_control.type_layer.size_group.toggle_group.middle.Label",
			["ninth_cia/type_layer/btn_series/cancel_btn/cancel"] = "_control.type_layer.btn_series.cancel_btn.cancel",
			["ninth_cia/type_layer/country_group/toggle_group/all"] = "_control.type_layer.country_group.toggle_group.all",
			["ninth_cia/type_layer/type_group/toggle_group/BBV"] = "_control.type_layer.type_group.toggle_group.BBV",
			["ninth_cia/top/title_text/desc"] = "_control.top.title_text.desc",
			["ninth_cia/type_layer/size_group/toggle_group/small/Label"] = "_control.type_layer.size_group.toggle_group.small.Label",
			["ninth_cia/top/score/score_node"] = "_control.top.score.score_node",
			["ninth_cia/buy_msgbox/main/title_text"] = "_control.buy_msgbox.main.title_text",
			["ninth_cia/type_layer/country_group/toggle_group/G_country/Label"] = "_control.type_layer.country_group.toggle_group.G_country.Label",
			["ninth_cia/type/btn_group/disable"] = "_control.type.btn_group.disable",
			["ninth_cia/type/btn_group/all/text"] = "_control.type.btn_group.all.text",
			["ninth_cia/buy_msgbox/main/top"] = "_control.buy_msgbox.main.top",
			["ninth_cia/type_layer/size_group/toggle_group/small"] = "_control.type_layer.size_group.toggle_group.small",
			["ninth_cia/buy_msgbox/main/main_text"] = "_control.buy_msgbox.main.main_text",
			["ninth_cia/mainpage/scrollview/scrollbarvertical"] = "_control.mainpage.scrollview.scrollbarvertical",
			["ninth_cia/type/bg_shadow"] = "_control.type.bg_shadow",
			["ninth_cia/type_layer/buff_type_group/toggle_group/all/Background"] = "_control.type_layer.buff_type_group.toggle_group.all.Background"
		},
		click = {
			["buy_msgbox/main/quitbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buy_msgbox/main/quitbtn_revert"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buy_msgbox/main/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buy_msgbox/main/confirmbtn_revert"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buy_msgbox/main/closebtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			npc = {
				tp = "UnityEngine.UI.Button"
			},
			["top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/revert_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/ship_type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type/bg_shadow"] = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/btn_series/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/btn_series/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["type/btn_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/disable"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/brought"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/active"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/C_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/E_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/F_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/G_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/I_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/J_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/S_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/U_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/country_group/toggle_group/other_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CVL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/AV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/BB"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/BBV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/BC"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CA"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CAV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CLT"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/BM"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/DD"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/SSG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/SS"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/SC"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/AP"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/ASDG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/AADG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/KP"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/CBG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/BBG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/BG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/size_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/size_group/toggle_group/large"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/size_group/toggle_group/middle"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/size_group/toggle_group/small"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/size_group/toggle_group/maip"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/size_group/toggle_group/protect"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/attribute_up"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/damage_up"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/ignore_hurt"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/ignore_lack_ammu"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/capacity_up"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/support_atk"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			buy_msgbox = {
				component = "UnityEngine.Canvas",
				path = "buy_msgbox"
			},
			type = {
				component = "UnityEngine.Canvas",
				path = "type"
			}
		}
	}
}

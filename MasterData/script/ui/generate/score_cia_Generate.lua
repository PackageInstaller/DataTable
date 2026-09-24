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
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					desc = {
						path = "top/desc",
						list = {
							dot_image = {
								path = "top/desc/dot_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							desc_text = {
								path = "top/desc/desc_text",
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
			npc = {
				path = "npc",
				list = {
					img = {
						path = "npc/img",
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
					"UIMoveTweener",
					"UIMoveTweener"
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
									buff_type = {
										path = "type_layer/buff_type_group/toggle_group/buff_type",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/buff_type/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/buff_type/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/buff_type/Label",
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
									nerf_type = {
										path = "type_layer/buff_type_group/toggle_group/nerf_type",
										list = {
											Background = {
												path = "type_layer/buff_type_group/toggle_group/nerf_type/Background",
												list = {
													Checkmark = {
														path = "type_layer/buff_type_group/toggle_group/nerf_type/Background/Checkmark",
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
												path = "type_layer/buff_type_group/toggle_group/nerf_type/Label",
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
			["score_cia/buy_msgbox/main/closebtn"] = "_control.buy_msgbox.main.closebtn",
			["score_cia/top/desc/dot_image"] = "_control.top.desc.dot_image",
			["score_cia/type_layer/country_group/toggle_group/S_country"] = "_control.type_layer.country_group.toggle_group.S_country",
			["score_cia/type_layer/size_group/toggle_group/middle"] = "_control.type_layer.size_group.toggle_group.middle",
			["score_cia/type_layer/type_group/toggle_group/all/Background"] = "_control.type_layer.type_group.toggle_group.all.Background",
			["score_cia/top/line_bg"] = "_control.top.line_bg",
			["score_cia/type_layer/country_group/toggle_group/U_country/Label"] = "_control.type_layer.country_group.toggle_group.U_country.Label",
			["score_cia/mainpage/scrollview"] = "_control.mainpage.scrollview",
			["score_cia/type_layer/country_group/toggle_group/U_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.U_country.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/U_country"] = "_control.type_layer.country_group.toggle_group.U_country",
			["score_cia/type_layer/country_group/toggle_group/S_country/Label"] = "_control.type_layer.country_group.toggle_group.S_country.Label",
			["score_cia/type_layer/country_group/toggle_group/S_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.S_country.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/S_country/Background"] = "_control.type_layer.country_group.toggle_group.S_country.Background",
			["score_cia/type_layer/type_group/toggle_group/CVL/Background"] = "_control.type_layer.type_group.toggle_group.CVL.Background",
			["score_cia/type_layer/country_group/toggle_group/J_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.J_country.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/J_country/Background"] = "_control.type_layer.country_group.toggle_group.J_country.Background",
			["score_cia/type_layer/buff_type_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.all.Background.Checkmark",
			["score_cia/buy_msgbox/main/title_text"] = "_control.buy_msgbox.main.title_text",
			["score_cia/type_layer/type_group/toggle_group/DD"] = "_control.type_layer.type_group.toggle_group.DD",
			["score_cia/type_layer/country_group/toggle_group/I_country"] = "_control.type_layer.country_group.toggle_group.I_country",
			["score_cia/buy_msgbox/main/main_text"] = "_control.buy_msgbox.main.main_text",
			["score_cia/type_layer/country_group/toggle_group/all/Background"] = "_control.type_layer.country_group.toggle_group.all.Background",
			["score_cia/buy_msgbox/main/top_decore"] = "_control.buy_msgbox.main.top_decore",
			["score_cia/type_layer/type_group/toggle_group/BM"] = "_control.type_layer.type_group.toggle_group.BM",
			["score_cia/buy_msgbox/main/quitbtn_revert/text"] = "_control.buy_msgbox.main.quitbtn_revert.text",
			["score_cia/type_layer/size_group/toggle_group/maip"] = "_control.type_layer.size_group.toggle_group.maip",
			["score_cia/top/ship_type_btn/type_text"] = "_control.top.ship_type_btn.type_text",
			["score_cia/type_layer/country_group/toggle_group/F_country/Background"] = "_control.type_layer.country_group.toggle_group.F_country.Background",
			["score_cia/type_layer/country_group/toggle_group/C_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.C_country.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/F_country"] = "_control.type_layer.country_group.toggle_group.F_country",
			["score_cia/type_layer/country_group/toggle_group/E_country/Label"] = "_control.type_layer.country_group.toggle_group.E_country.Label",
			["score_cia/type_layer/country_group/toggle_group/other_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.other_country.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/E_country/Background"] = "_control.type_layer.country_group.toggle_group.E_country.Background",
			["score_cia/type_layer/buff_type_group/toggle_group/all/Label"] = "_control.type_layer.buff_type_group.toggle_group.all.Label",
			["score_cia/type_layer/country_group/toggle_group/C_country/Label"] = "_control.type_layer.country_group.toggle_group.C_country.Label",
			["score_cia/type_layer/country_group"] = "_control.type_layer.country_group",
			["score_cia/top/return_btn"] = "_control.top.return_btn",
			["score_cia/type_layer/btn_series/cancel_btn/cancel"] = "_control.type_layer.btn_series.cancel_btn.cancel",
			["score_cia/type_layer/btn_series/cancel_btn"] = "_control.type_layer.btn_series.cancel_btn",
			["score_cia/type_layer/country_group/toggle_group/other_country/Background"] = "_control.type_layer.country_group.toggle_group.other_country.Background",
			["score_cia/type_layer/buff_type_group/toggle_group/buff_type/Background"] = "_control.type_layer.buff_type_group.toggle_group.buff_type.Background",
			["score_cia/type_layer/btn_series"] = "_control.type_layer.btn_series",
			["score_cia/type_layer/country_group/toggle_group/E_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.E_country.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/F_country/Label"] = "_control.type_layer.country_group.toggle_group.F_country.Label",
			["score_cia/type/btn_group/disable/text"] = "_control.type.btn_group.disable.text",
			["score_cia/top/desc"] = "_control.top.desc",
			["score_cia/top/desc/desc_text"] = "_control.top.desc.desc_text",
			["score_cia/type_layer/country_group/toggle_group/J_country/Label"] = "_control.type_layer.country_group.toggle_group.J_country.Label",
			["score_cia/type_layer/country_group/toggle_group/F_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.F_country.Background.Checkmark",
			["score_cia/top/title_text"] = "_control.top.title_text",
			["score_cia/type_layer/country_group/toggle_group/G_country/Background"] = "_control.type_layer.country_group.toggle_group.G_country.Background",
			["score_cia/type_layer/type_group/toggle_group/SS"] = "_control.type_layer.type_group.toggle_group.SS",
			["score_cia/type_layer/type_group/toggle_group/CV/Label"] = "_control.type_layer.type_group.toggle_group.CV.Label",
			["score_cia/type_layer/type_group/toggle_group/CVL/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CVL.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/G_country/Label"] = "_control.type_layer.country_group.toggle_group.G_country.Label",
			["score_cia/type_layer/country_group/toggle_group/U_country/Background"] = "_control.type_layer.country_group.toggle_group.U_country.Background",
			["score_cia/type_layer/country_group/toggle_group/G_country"] = "_control.type_layer.country_group.toggle_group.G_country",
			["score_cia/mainpage/scrollview/viewport/content"] = "_control.mainpage.scrollview.viewport.content",
			["score_cia/type_layer/type_group/toggle_group/BG"] = "_control.type_layer.type_group.toggle_group.BG",
			["score_cia/buy_msgbox/main/confirmbtn/text"] = "_control.buy_msgbox.main.confirmbtn.text",
			["score_cia/type_layer/size_group/toggle_group/middle/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.middle.Background.Checkmark",
			["score_cia/type/bg_shadow"] = "_control.type.bg_shadow",
			["score_cia/top/revert_btn"] = "_control.top.revert_btn",
			["score_cia/type_layer/type_group/toggle_group/CV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CV.Background.Checkmark",
			["score_cia/top/ship_type_btn"] = "_control.top.ship_type_btn",
			["score_cia/type_layer/type_group/toggle_group/all/Label"] = "_control.type_layer.type_group.toggle_group.all.Label",
			["score_cia/type/btn_group/brought"] = "_control.type.btn_group.brought",
			["score_cia/mainpage/scrollview/scrollbarvertical/slidingarea"] = "_control.mainpage.scrollview.scrollbarvertical.slidingarea",
			["score_cia/top"] = "_control.top",
			["score_cia/type/btn_group/brought/text"] = "_control.type.btn_group.brought.text",
			["score_cia/type_layer/type_group"] = "_control.type_layer.type_group",
			["score_cia/buy_msgbox/main/quitbtn"] = "_control.buy_msgbox.main.quitbtn",
			["score_cia/buy_msgbox/main/confirmbtn"] = "_control.buy_msgbox.main.confirmbtn",
			["score_cia/type_layer/type_group/toggle_group/CG"] = "_control.type_layer.type_group.toggle_group.CG",
			["score_cia/buy_msgbox/main/top"] = "_control.buy_msgbox.main.top",
			["score_cia/type_layer/type_group/toggle_group/AV/Label"] = "_control.type_layer.type_group.toggle_group.AV.Label",
			["score_cia/type_layer/type_group/toggle_group/BB/Background"] = "_control.type_layer.type_group.toggle_group.BB.Background",
			["score_cia/mainpage"] = "_control.mainpage",
			["score_cia/type_layer/type_group/toggle_group/BB/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BB.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/BB/Label"] = "_control.type_layer.type_group.toggle_group.BB.Label",
			["score_cia/buy_msgbox"] = "_control.buy_msgbox",
			["score_cia/type_layer/type_group/toggle_group/BBV/Background"] = "_control.type_layer.type_group.toggle_group.BBV.Background",
			["score_cia/type_layer/type_group/toggle_group/BBV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BBV.Background.Checkmark",
			["score_cia/top/score/score_num"] = "_control.top.score.score_num",
			["score_cia/type_layer/type_group/toggle_group/KP"] = "_control.type_layer.type_group.toggle_group.KP",
			["score_cia/type_layer/buff_type_group/toggle_group/buff_type/Label"] = "_control.type_layer.buff_type_group.toggle_group.buff_type.Label",
			["score_cia/type/btn_group/active/text"] = "_control.type.btn_group.active.text",
			["score_cia/type_layer/type_group/toggle_group/BC/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BC.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/BC/Label"] = "_control.type_layer.type_group.toggle_group.BC.Label",
			["score_cia/type_layer/type_group/toggle_group/CA"] = "_control.type_layer.type_group.toggle_group.CA",
			["score_cia/type_layer/type_group/toggle_group/CA/Background"] = "_control.type_layer.type_group.toggle_group.CA.Background",
			["score_cia/top/score"] = "_control.top.score",
			["score_cia/type_layer/type_group/toggle_group/CA/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CA.Background.Checkmark",
			["score_cia/npc/img"] = "_control.npc.img",
			["score_cia/type_layer/type_group/toggle_group/CA/Label"] = "_control.type_layer.type_group.toggle_group.CA.Label",
			["score_cia/mainpage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.mainpage.scrollview.scrollbarvertical.slidingarea.handle",
			["score_cia/type_layer/type_group/toggle_group/CAV/Background"] = "_control.type_layer.type_group.toggle_group.CAV.Background",
			["score_cia/type_layer/type_group/toggle_group/ASDG/Label"] = "_control.type_layer.type_group.toggle_group.ASDG.Label",
			["score_cia/type_layer/type_group/toggle_group/CAV/Label"] = "_control.type_layer.type_group.toggle_group.CAV.Label",
			["score_cia/type_layer/type_group/toggle_group/CLT/Background"] = "_control.type_layer.type_group.toggle_group.CLT.Background",
			["score_cia/type"] = "_control.type",
			["score_cia/type_layer/type_group/toggle_group/CLT/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CLT.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/CLT/Label"] = "_control.type_layer.type_group.toggle_group.CLT.Label",
			["score_cia/type_layer/size_group/toggle_group/protect"] = "_control.type_layer.size_group.toggle_group.protect",
			["score_cia/type_layer/type_group/toggle_group/CL/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CL.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/CL/Label"] = "_control.type_layer.type_group.toggle_group.CL.Label",
			["score_cia/type_layer/country_group/toggle_group/C_country/Background"] = "_control.type_layer.country_group.toggle_group.C_country.Background",
			["score_cia/type_layer/type_group/toggle_group/CVL/Label"] = "_control.type_layer.type_group.toggle_group.CVL.Label",
			["score_cia/type_layer/type_group/toggle_group/BM/Background"] = "_control.type_layer.type_group.toggle_group.BM.Background",
			["score_cia/type_layer/type_group/toggle_group/BM/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BM.Background.Checkmark",
			["score_cia/type_layer/size_group/toggle_group/protect/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.protect.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/I_country/Background"] = "_control.type_layer.country_group.toggle_group.I_country.Background",
			["score_cia/type_layer/type_group/toggle_group/BBG"] = "_control.type_layer.type_group.toggle_group.BBG",
			["score_cia/type_layer/type_group/toggle_group/BB"] = "_control.type_layer.type_group.toggle_group.BB",
			["score_cia/top/type_btn/text"] = "_control.top.type_btn.text",
			["score_cia/type_layer/type_group/toggle_group/DD/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.DD.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/DD/Label"] = "_control.type_layer.type_group.toggle_group.DD.Label",
			["score_cia/type_layer/type_group/toggle_group/SSG/Background"] = "_control.type_layer.type_group.toggle_group.SSG.Background",
			["score_cia/type_layer/type_group/toggle_group/SSG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.SSG.Background.Checkmark",
			["score_cia/type_layer/country_group/toggle_group/C_country"] = "_control.type_layer.country_group.toggle_group.C_country",
			["score_cia/type_layer/type_group/toggle_group/SSG/Label"] = "_control.type_layer.type_group.toggle_group.SSG.Label",
			["score_cia/type_layer/country_group/toggle_group/G_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.G_country.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/SS/Background"] = "_control.type_layer.type_group.toggle_group.SS.Background",
			["score_cia/type_layer/btn_series/confirm_btn"] = "_control.type_layer.btn_series.confirm_btn",
			["score_cia/buy_msgbox/maskbg"] = "_control.buy_msgbox.maskbg",
			["score_cia/type/btn_group/active"] = "_control.type.btn_group.active",
			["score_cia/type_layer/type_group/toggle_group/SS/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.SS.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group"] = "_control.type_layer.type_group.toggle_group",
			["score_cia/type_layer/type_group/toggle_group/SS/Label"] = "_control.type_layer.type_group.toggle_group.SS.Label",
			["score_cia/shine"] = "_control.shine",
			["score_cia/type_layer/type_group/toggle_group/SC/Background"] = "_control.type_layer.type_group.toggle_group.SC.Background",
			["score_cia/type_layer/type_group/toggle_group/SC/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.SC.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/CVL"] = "_control.type_layer.type_group.toggle_group.CVL",
			["score_cia/type_layer/type_group/toggle_group/all"] = "_control.type_layer.type_group.toggle_group.all",
			["score_cia/type_layer/type_group/toggle_group/SC/Label"] = "_control.type_layer.type_group.toggle_group.SC.Label",
			["score_cia/type_layer/type_group/toggle_group/AP/Background"] = "_control.type_layer.type_group.toggle_group.AP.Background",
			["score_cia/type_layer/type_group/toggle_group/AP/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.AP.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/AP/Label"] = "_control.type_layer.type_group.toggle_group.AP.Label",
			["score_cia/type_layer/type_group/toggle_group/ASDG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.ASDG.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/CAV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CAV.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/AADG"] = "_control.type_layer.type_group.toggle_group.AADG",
			["score_cia/buy_msgbox/main/main_text/text"] = "_control.buy_msgbox.main.main_text.text",
			["score_cia/type_layer/size_group/toggle_group/large/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.large.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/AADG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.AADG.Background.Checkmark",
			["score_cia/top/type_btn/type_text"] = "_control.top.type_btn.type_text",
			["score_cia/buy_msgbox/main/confirmbtn_revert/text"] = "_control.buy_msgbox.main.confirmbtn_revert.text",
			["score_cia/type_layer/type_group/toggle_group/SC"] = "_control.type_layer.type_group.toggle_group.SC",
			["score_cia/type_layer/type_group/toggle_group/BC"] = "_control.type_layer.type_group.toggle_group.BC",
			["score_cia/type_layer/type_group/toggle_group/CL"] = "_control.type_layer.type_group.toggle_group.CL",
			["score_cia/type_layer/type_group/toggle_group/AADG/Label"] = "_control.type_layer.type_group.toggle_group.AADG.Label",
			["score_cia/type_layer/type_group/toggle_group/BBV/Label"] = "_control.type_layer.type_group.toggle_group.BBV.Label",
			["score_cia/type_layer/type_group/toggle_group/KP/Background"] = "_control.type_layer.type_group.toggle_group.KP.Background",
			["score_cia/buy_msgbox/main/quitbtn_revert"] = "_control.buy_msgbox.main.quitbtn_revert",
			["score_cia/type_layer/type_group/toggle_group/KP/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.KP.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/KP/Label"] = "_control.type_layer.type_group.toggle_group.KP.Label",
			["score_cia/type_layer/type_group/toggle_group/AV/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.AV.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/CG/Background"] = "_control.type_layer.type_group.toggle_group.CG.Background",
			["score_cia/type_layer/type_group/toggle_group/CG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CG.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/ASDG/Background"] = "_control.type_layer.type_group.toggle_group.ASDG.Background",
			["score_cia/type_layer/type_group/toggle_group/CG/Label"] = "_control.type_layer.type_group.toggle_group.CG.Label",
			["score_cia/type_layer/type_group/toggle_group/CBG"] = "_control.type_layer.type_group.toggle_group.CBG",
			["score_cia/type_layer/type_group/toggle_group/CBG/Background"] = "_control.type_layer.type_group.toggle_group.CBG.Background",
			["score_cia/type_layer/type_group/toggle_group/CAV"] = "_control.type_layer.type_group.toggle_group.CAV",
			["score_cia/type_layer/type_group/toggle_group/CBG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.CBG.Background.Checkmark",
			["score_cia/type_layer/buff_type_group/toggle_group/buff_type"] = "_control.type_layer.buff_type_group.toggle_group.buff_type",
			["score_cia/type_layer/type_group/toggle_group/DD/Background"] = "_control.type_layer.type_group.toggle_group.DD.Background",
			["score_cia/type_layer/size_group/toggle_group/protect/Label"] = "_control.type_layer.size_group.toggle_group.protect.Label",
			["score_cia/type_layer/type_group/toggle_group/BBG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BBG.Background.Checkmark",
			["score_cia/type_layer/size_group/toggle_group/large/Label"] = "_control.type_layer.size_group.toggle_group.large.Label",
			["score_cia/type/btn_group/all/text"] = "_control.type.btn_group.all.text",
			["score_cia/type_layer/type_group/toggle_group/AV"] = "_control.type_layer.type_group.toggle_group.AV",
			["score_cia/type_layer/country_group/toggle_group/I_country/Label"] = "_control.type_layer.country_group.toggle_group.I_country.Label",
			["score_cia/type_layer/type_group/toggle_group/BG/Background"] = "_control.type_layer.type_group.toggle_group.BG.Background",
			["score_cia/type_layer/type_group/toggle_group/BG/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.BG.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/BG/Label"] = "_control.type_layer.type_group.toggle_group.BG.Label",
			["score_cia/type_layer/size_group"] = "_control.type_layer.size_group",
			["score_cia/type_layer/size_group/toggle_group"] = "_control.type_layer.size_group.toggle_group",
			["score_cia/type_layer/country_group/toggle_group/I_country/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.I_country.Background.Checkmark",
			["score_cia/type_layer/size_group/toggle_group/all/Background"] = "_control.type_layer.size_group.toggle_group.all.Background",
			["score_cia/type_layer/size_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.all.Background.Checkmark",
			["score_cia/top/revert_btn/revert_text"] = "_control.top.revert_btn.revert_text",
			["score_cia/type_layer/size_group/toggle_group/all/Label"] = "_control.type_layer.size_group.toggle_group.all.Label",
			["score_cia/type_layer/size_group/toggle_group/large"] = "_control.type_layer.size_group.toggle_group.large",
			["score_cia/type_layer/country_group/toggle_group/other_country"] = "_control.type_layer.country_group.toggle_group.other_country",
			["score_cia/type_layer/size_group/toggle_group/large/Background"] = "_control.type_layer.size_group.toggle_group.large.Background",
			["score_cia/buy_msgbox/main/title_text/gogo"] = "_control.buy_msgbox.main.title_text.gogo",
			["score_cia/type_layer/type_group/toggle_group/SSG"] = "_control.type_layer.type_group.toggle_group.SSG",
			["score_cia/type_layer/type_group/toggle_group/AADG/Background"] = "_control.type_layer.type_group.toggle_group.AADG.Background",
			["score_cia/top/score/score_node"] = "_control.top.score.score_node",
			["score_cia/type_layer/type_group/toggle_group/BBG/Label"] = "_control.type_layer.type_group.toggle_group.BBG.Label",
			["score_cia/type_layer/type_group/toggle_group/AP"] = "_control.type_layer.type_group.toggle_group.AP",
			["score_cia/type_layer/type_group/toggle_group/CV/Background"] = "_control.type_layer.type_group.toggle_group.CV.Background",
			["score_cia/type_layer/size_group/toggle_group/middle/Background"] = "_control.type_layer.size_group.toggle_group.middle.Background",
			["score_cia/buy_msgbox/main"] = "_control.buy_msgbox.main",
			["score_cia/type/btn_group"] = "_control.type.btn_group",
			["score_cia/type_layer/size_group/toggle_group/middle/Label"] = "_control.type_layer.size_group.toggle_group.middle.Label",
			["score_cia/type_layer/size_group/toggle_group/small"] = "_control.type_layer.size_group.toggle_group.small",
			["score_cia/type_layer/size_group/toggle_group/small/Background"] = "_control.type_layer.size_group.toggle_group.small.Background",
			["score_cia/type_layer/size_group/toggle_group/small/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.small.Background.Checkmark",
			["score_cia/type_layer/size_group/toggle_group/small/Label"] = "_control.type_layer.size_group.toggle_group.small.Label",
			["score_cia/type_layer/type_group/toggle_group/CV"] = "_control.type_layer.type_group.toggle_group.CV",
			["score_cia/type_layer/type_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.all.Background.Checkmark",
			["score_cia/type/btn_group/all"] = "_control.type.btn_group.all",
			["score_cia/mainpage/scrollview/viewport"] = "_control.mainpage.scrollview.viewport",
			["score_cia/type_layer/size_group/toggle_group/maip/Background"] = "_control.type_layer.size_group.toggle_group.maip.Background",
			["score_cia/type_layer/size_group/toggle_group/maip/Background/Checkmark"] = "_control.type_layer.size_group.toggle_group.maip.Background.Checkmark",
			["score_cia/type_layer/line_mid"] = "_control.type_layer.line_mid",
			["score_cia/type_layer/size_group/toggle_group/maip/Label"] = "_control.type_layer.size_group.toggle_group.maip.Label",
			["score_cia/type_layer/buff_type_group"] = "_control.type_layer.buff_type_group",
			["score_cia/type_layer/buff_type_group/toggle_group"] = "_control.type_layer.buff_type_group.toggle_group",
			["score_cia/type_layer/type_group/toggle_group/BM/Label"] = "_control.type_layer.type_group.toggle_group.BM.Label",
			["score_cia/mainpage/scrollview/scrollbarvertical"] = "_control.mainpage.scrollview.scrollbarvertical",
			["score_cia/type_layer/type_group/toggle_group/BBG/Background"] = "_control.type_layer.type_group.toggle_group.BBG.Background",
			["score_cia/type_layer/country_group/toggle_group"] = "_control.type_layer.country_group.toggle_group",
			["score_cia/type_layer/type_group/toggle_group/CL/Background"] = "_control.type_layer.type_group.toggle_group.CL.Background",
			["score_cia/type_layer/country_group/toggle_group/other_country/Label"] = "_control.type_layer.country_group.toggle_group.other_country.Label",
			["score_cia/type_layer/size_group/toggle_group/protect/Background"] = "_control.type_layer.size_group.toggle_group.protect.Background",
			["score_cia/type_layer/buff_type_group/toggle_group/all"] = "_control.type_layer.buff_type_group.toggle_group.all",
			["score_cia/type_layer/filter_type/type_txt"] = "_control.type_layer.filter_type.type_txt",
			["score_cia/type_layer/buff_type_group/toggle_group/all/Background"] = "_control.type_layer.buff_type_group.toggle_group.all.Background",
			["score_cia/bg"] = "_control.bg",
			["score_cia/type_layer/country_group/toggle_group/all"] = "_control.type_layer.country_group.toggle_group.all",
			["score_cia/type_layer/country_group/toggle_group/J_country"] = "_control.type_layer.country_group.toggle_group.J_country",
			["score_cia/type_layer/country_group/toggle_group/E_country"] = "_control.type_layer.country_group.toggle_group.E_country",
			["score_cia/top/score/icon"] = "_control.top.score.icon",
			["score_cia/type_layer/type_group/toggle_group/BBV"] = "_control.type_layer.type_group.toggle_group.BBV",
			["score_cia/type_layer/type_group/toggle_group/CBG/Label"] = "_control.type_layer.type_group.toggle_group.CBG.Label",
			["score_cia/type_layer/btn_series/confirm_btn/confirm"] = "_control.type_layer.btn_series.confirm_btn.confirm",
			["score_cia/buy_msgbox/main/quitbtn/text"] = "_control.buy_msgbox.main.quitbtn.text",
			["score_cia/type_layer/type_group/toggle_group/CLT"] = "_control.type_layer.type_group.toggle_group.CLT",
			["score_cia/type_layer/buff_type_group/toggle_group/buff_type/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.buff_type.Background.Checkmark",
			["score_cia/type_layer/type_group/toggle_group/BC/Background"] = "_control.type_layer.type_group.toggle_group.BC.Background",
			["score_cia/type/btn_group/disable"] = "_control.type.btn_group.disable",
			["score_cia/type_layer/type_group/toggle_group/AV/Background"] = "_control.type_layer.type_group.toggle_group.AV.Background",
			["score_cia/type_layer/buff_type_group/toggle_group/nerf_type"] = "_control.type_layer.buff_type_group.toggle_group.nerf_type",
			["score_cia/npc"] = "_control.npc",
			["score_cia/type_layer/filter_type"] = "_control.type_layer.filter_type",
			["score_cia/type_layer/buff_type_group/toggle_group/nerf_type/Background"] = "_control.type_layer.buff_type_group.toggle_group.nerf_type.Background",
			["score_cia/type_layer/country_group/toggle_group/all/Label"] = "_control.type_layer.country_group.toggle_group.all.Label",
			["score_cia/type_layer"] = "_control.type_layer",
			["score_cia/type_layer/type_group/toggle_group/ASDG"] = "_control.type_layer.type_group.toggle_group.ASDG",
			["score_cia/top/ship_type_btn/text"] = "_control.top.ship_type_btn.text",
			["score_cia/type_layer/buff_type_group/toggle_group/nerf_type/Background/Checkmark"] = "_control.type_layer.buff_type_group.toggle_group.nerf_type.Background.Checkmark",
			["score_cia/type_layer/buff_type_group/toggle_group/nerf_type/Label"] = "_control.type_layer.buff_type_group.toggle_group.nerf_type.Label",
			["score_cia/type_layer/size_group/toggle_group/all"] = "_control.type_layer.size_group.toggle_group.all",
			["score_cia/buy_msgbox/main/main_bg"] = "_control.buy_msgbox.main.main_bg",
			["score_cia/type_layer/country_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.country_group.toggle_group.all.Background.Checkmark",
			["score_cia/type_layer/filter_type/sort_title_line"] = "_control.type_layer.filter_type.sort_title_line",
			["score_cia/top/type_btn"] = "_control.top.type_btn",
			["score_cia/buy_msgbox/main/confirmbtn_revert"] = "_control.buy_msgbox.main.confirmbtn_revert"
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
			["type/btn_group/active"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/disable"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/brought"] = {
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
			["type_layer/buff_type_group/toggle_group/buff_type"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/buff_type_group/toggle_group/nerf_type"] = {
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

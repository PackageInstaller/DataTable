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
							unlock = {
								path = "type/btn_group/unlock",
								list = {
									text = {
										path = "type/btn_group/unlock/text",
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
							lock = {
								path = "type/btn_group/lock",
								list = {
									text = {
										path = "type/btn_group/lock/text",
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
			["type/btn_group/unlock"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/lock"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/active"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type/btn_group/disable"] = {
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

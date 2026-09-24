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
			top = {
				path = "top",
				list = {
					title = {
						path = "top/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line_left = {
						path = "top/line_left",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_1 = {
						path = "top/line_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_2 = {
						path = "top/line_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_3 = {
						path = "top/line_3",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_right = {
						path = "top/line_right",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close_btn = {
						path = "top/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					toggle_control = {
						path = "top/toggle_control",
						list = {
							strengthen = {
								path = "top/toggle_control/strengthen",
								list = {
									unselected = {
										path = "top/toggle_control/strengthen/unselected",
										list = {
											selected = {
												path = "top/toggle_control/strengthen/unselected/selected",
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
									rbtn = {
										path = "top/toggle_control/strengthen/rbtn",
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
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							evo = {
								path = "top/toggle_control/evo",
								list = {
									unselected = {
										path = "top/toggle_control/evo/unselected",
										list = {
											selected = {
												path = "top/toggle_control/evo/unselected/selected",
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
									rbtn = {
										path = "top/toggle_control/evo/rbtn",
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
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							skill = {
								path = "top/toggle_control/skill",
								list = {
									unselected = {
										path = "top/toggle_control/skill/unselected",
										list = {
											selected = {
												path = "top/toggle_control/skill/unselected/selected",
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
									rbtn = {
										path = "top/toggle_control/skill/rbtn",
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
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							remak_event = {
								path = "top/toggle_control/remak_event",
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
							"UnityEngine.UI.ToggleGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			bottom = {
				path = "bottom",
				list = {
					tip = {
						path = "bottom/tip",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					bottom_line = {
						path = "bottom/bottom_line",
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
			left = {
				path = "left",
				list = {
					shipinfo = {
						path = "left/shipinfo",
						list = {
							select_btn = {
								path = "left/shipinfo/select_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							ship = {
								path = "left/shipinfo/ship",
								list = {
									up = {
										path = "left/shipinfo/ship/up",
										list = {
											quality = {
												path = "left/shipinfo/ship/up/quality",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "left/shipinfo/ship/up/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											heart_layer = {
												path = "left/shipinfo/ship/up/heart_layer",
												list = {
													bg = {
														path = "left/shipinfo/ship/up/heart_layer/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													heart = {
														path = "left/shipinfo/ship/up/heart_layer/heart",
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
											"UnityEngine.UI.Mask",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									detail = {
										path = "left/shipinfo/ship/detail",
										list = {
											bg = {
												path = "left/shipinfo/ship/detail/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											line = {
												path = "left/shipinfo/ship/detail/line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lock_tag = {
												path = "left/shipinfo/ship/detail/lock_tag",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											ship_type = {
												path = "left/shipinfo/ship/detail/ship_type",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											level = {
												path = "left/shipinfo/ship/detail/level",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											country = {
												path = "left/shipinfo/ship/detail/country",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											ship_remake = {
												path = "left/shipinfo/ship/detail/ship_remake",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											star_layer = {
												path = "left/shipinfo/ship/detail/star_layer",
												list = {
													star_1 = {
														path = "left/shipinfo/ship/detail/star_layer/star_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "left/shipinfo/ship/detail/star_layer/star_2",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "left/shipinfo/ship/detail/star_layer/star_3",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "left/shipinfo/ship/detail/star_layer/star_4",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "left/shipinfo/ship/detail/star_layer/star_5",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "left/shipinfo/ship/detail/star_layer/star_6",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "left/shipinfo/ship/detail/star_layer/star_7",
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
											name_layer = {
												path = "left/shipinfo/ship/detail/name_layer",
												list = {
													name_bg = {
														path = "left/shipinfo/ship/detail/name_layer/name_bg",
														list = {
															name_txt = {
																path = "left/shipinfo/ship/detail/name_layer/name_bg/name_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															name_txt_1 = {
																path = "left/shipinfo/ship/detail/name_layer/name_bg/name_txt_1",
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
													"UnityEngine.RectTransform"
												}
											},
											hp_layer = {
												path = "left/shipinfo/ship/detail/hp_layer",
												list = {
													blood_bg = {
														path = "left/shipinfo/ship/detail/hp_layer/blood_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													blood_bar = {
														path = "left/shipinfo/ship/detail/hp_layer/blood_bar",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "left/shipinfo/ship/detail/hp_layer/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													count = {
														path = "left/shipinfo/ship/detail/hp_layer/count",
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
									change_btn = {
										path = "left/shipinfo/ship/change_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"ClickAndLongClickEvent"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							effect = {
								path = "left/shipinfo/effect",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							ship_frame = {
								path = "left/shipinfo/ship_frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "left/shipinfo/line",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			right = {
				path = "right",
				list = {
					strengthen = {
						path = "right/strengthen",
						list = {
							scroll = {
								path = "right/strengthen/scroll",
								list = {
									viewport = {
										path = "right/strengthen/scroll/viewport",
										list = {
											content = {
												path = "right/strengthen/scroll/viewport/content",
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
							},
							detail = {
								path = "right/strengthen/detail",
								list = {
									bg = {
										path = "right/strengthen/detail/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									attrib = {
										path = "right/strengthen/detail/attrib",
										list = {
											attrib_1 = {
												path = "right/strengthen/detail/attrib/attrib_1",
												list = {
													line = {
														path = "right/strengthen/detail/attrib/attrib_1/line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon = {
														path = "right/strengthen/detail/attrib/attrib_1/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/strengthen/detail/attrib/attrib_1/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													default = {
														path = "right/strengthen/detail/attrib/attrib_1/default",
														list = {
															default_num = {
																path = "right/strengthen/detail/attrib/attrib_1/default/default_num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															defalut_exp = {
																path = "right/strengthen/detail/attrib/attrib_1/default/defalut_exp",
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
													have_value = {
														path = "right/strengthen/detail/attrib/attrib_1/have_value",
														list = {
															num = {
																path = "right/strengthen/detail/attrib/attrib_1/have_value/num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add_count = {
																path = "right/strengthen/detail/attrib/attrib_1/have_value/add_count",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															max = {
																path = "right/strengthen/detail/attrib/attrib_1/have_value/max",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															level = {
																path = "right/strengthen/detail/attrib/attrib_1/have_value/level",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															exp = {
																path = "right/strengthen/detail/attrib/attrib_1/have_value/exp",
																list = {
																	exp_bg = {
																		path = "right/strengthen/detail/attrib/attrib_1/have_value/exp/exp_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	exp_bar = {
																		path = "right/strengthen/detail/attrib/attrib_1/have_value/exp/exp_bar",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image",
																			"UIFillAmountChangeEffect"
																		}
																	},
																	exp_num = {
																		path = "right/strengthen/detail/attrib/attrib_1/have_value/exp/exp_num",
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
											attrib_2 = {
												path = "right/strengthen/detail/attrib/attrib_2",
												list = {
													line = {
														path = "right/strengthen/detail/attrib/attrib_2/line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon = {
														path = "right/strengthen/detail/attrib/attrib_2/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/strengthen/detail/attrib/attrib_2/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													default = {
														path = "right/strengthen/detail/attrib/attrib_2/default",
														list = {
															default_num = {
																path = "right/strengthen/detail/attrib/attrib_2/default/default_num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															defalut_exp = {
																path = "right/strengthen/detail/attrib/attrib_2/default/defalut_exp",
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
													have_value = {
														path = "right/strengthen/detail/attrib/attrib_2/have_value",
														list = {
															num = {
																path = "right/strengthen/detail/attrib/attrib_2/have_value/num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add_count = {
																path = "right/strengthen/detail/attrib/attrib_2/have_value/add_count",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															max = {
																path = "right/strengthen/detail/attrib/attrib_2/have_value/max",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															level = {
																path = "right/strengthen/detail/attrib/attrib_2/have_value/level",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															exp = {
																path = "right/strengthen/detail/attrib/attrib_2/have_value/exp",
																list = {
																	exp_bg = {
																		path = "right/strengthen/detail/attrib/attrib_2/have_value/exp/exp_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	exp_bar = {
																		path = "right/strengthen/detail/attrib/attrib_2/have_value/exp/exp_bar",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image",
																			"UIFillAmountChangeEffect"
																		}
																	},
																	exp_num = {
																		path = "right/strengthen/detail/attrib/attrib_2/have_value/exp/exp_num",
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
											attrib_3 = {
												path = "right/strengthen/detail/attrib/attrib_3",
												list = {
													line = {
														path = "right/strengthen/detail/attrib/attrib_3/line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon = {
														path = "right/strengthen/detail/attrib/attrib_3/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/strengthen/detail/attrib/attrib_3/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													default = {
														path = "right/strengthen/detail/attrib/attrib_3/default",
														list = {
															default_num = {
																path = "right/strengthen/detail/attrib/attrib_3/default/default_num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															defalut_exp = {
																path = "right/strengthen/detail/attrib/attrib_3/default/defalut_exp",
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
													have_value = {
														path = "right/strengthen/detail/attrib/attrib_3/have_value",
														list = {
															num = {
																path = "right/strengthen/detail/attrib/attrib_3/have_value/num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add_count = {
																path = "right/strengthen/detail/attrib/attrib_3/have_value/add_count",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															max = {
																path = "right/strengthen/detail/attrib/attrib_3/have_value/max",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															level = {
																path = "right/strengthen/detail/attrib/attrib_3/have_value/level",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															exp = {
																path = "right/strengthen/detail/attrib/attrib_3/have_value/exp",
																list = {
																	exp_bg = {
																		path = "right/strengthen/detail/attrib/attrib_3/have_value/exp/exp_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	exp_bar = {
																		path = "right/strengthen/detail/attrib/attrib_3/have_value/exp/exp_bar",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image",
																			"UIFillAmountChangeEffect"
																		}
																	},
																	exp_num = {
																		path = "right/strengthen/detail/attrib/attrib_3/have_value/exp/exp_num",
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
											attrib_4 = {
												path = "right/strengthen/detail/attrib/attrib_4",
												list = {
													line = {
														path = "right/strengthen/detail/attrib/attrib_4/line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon = {
														path = "right/strengthen/detail/attrib/attrib_4/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/strengthen/detail/attrib/attrib_4/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													default = {
														path = "right/strengthen/detail/attrib/attrib_4/default",
														list = {
															default_num = {
																path = "right/strengthen/detail/attrib/attrib_4/default/default_num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															defalut_exp = {
																path = "right/strengthen/detail/attrib/attrib_4/default/defalut_exp",
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
													have_value = {
														path = "right/strengthen/detail/attrib/attrib_4/have_value",
														list = {
															num = {
																path = "right/strengthen/detail/attrib/attrib_4/have_value/num",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															add_count = {
																path = "right/strengthen/detail/attrib/attrib_4/have_value/add_count",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															max = {
																path = "right/strengthen/detail/attrib/attrib_4/have_value/max",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															level = {
																path = "right/strengthen/detail/attrib/attrib_4/have_value/level",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															exp = {
																path = "right/strengthen/detail/attrib/attrib_4/have_value/exp",
																list = {
																	exp_bg = {
																		path = "right/strengthen/detail/attrib/attrib_4/have_value/exp/exp_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	exp_bar = {
																		path = "right/strengthen/detail/attrib/attrib_4/have_value/exp/exp_bar",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image",
																			"UIFillAmountChangeEffect"
																		}
																	},
																	exp_num = {
																		path = "right/strengthen/detail/attrib/attrib_4/have_value/exp/exp_num",
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
									},
									clear_btn = {
										path = "right/strengthen/detail/clear_btn",
										list = {
											title = {
												path = "right/strengthen/detail/clear_btn/title",
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
											"ScaleButton"
										}
									},
									streng_btn = {
										path = "right/strengthen/detail/streng_btn",
										list = {
											title = {
												path = "right/strengthen/detail/streng_btn/title",
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
											"ScaleButton"
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
					evo = {
						path = "right/evo",
						list = {
							remake_bg = {
								path = "right/evo/remake_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							evo_info = {
								path = "right/evo/evo_info",
								list = {
									level_title = {
										path = "right/evo/evo_info/level_title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									level = {
										path = "right/evo/evo_info/level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									effect = {
										path = "right/evo/evo_info/effect",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									left_part = {
										path = "right/evo/evo_info/left_part",
										list = {
											info_bg = {
												path = "right/evo/evo_info/left_part/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											remake_get = {
												path = "right/evo/evo_info/left_part/remake_get",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											arrow_1 = {
												path = "right/evo/evo_info/left_part/arrow_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											no_get = {
												path = "right/evo/evo_info/left_part/no_get",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											have_get = {
												path = "right/evo/evo_info/left_part/have_get",
												list = {
													ship_name = {
														path = "right/evo/evo_info/left_part/have_get/ship_name",
														list = {
															ship_name_1 = {
																path = "right/evo/evo_info/left_part/have_get/ship_name/ship_name_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															ship_name_2 = {
																path = "right/evo/evo_info/left_part/have_get/ship_name/ship_name_2",
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
													ship_stage = {
														path = "right/evo/evo_info/left_part/have_get/ship_stage",
														list = {
															ship_stage_1 = {
																path = "right/evo/evo_info/left_part/have_get/ship_stage/ship_stage_1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															ship_stage_2 = {
																path = "right/evo/evo_info/left_part/have_get/ship_stage/ship_stage_2",
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
													"UnityEngine.CanvasRenderer"
												}
											},
											remake_get_skill = {
												path = "right/evo/evo_info/left_part/remake_get_skill",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											arrow_2 = {
												path = "right/evo/evo_info/left_part/arrow_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											remake_maybe = {
												path = "right/evo/evo_info/left_part/remake_maybe",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											get_skill_1 = {
												path = "right/evo/evo_info/left_part/get_skill_1",
												list = {
													bg = {
														path = "right/evo/evo_info/left_part/get_skill_1/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													skill_name = {
														path = "right/evo/evo_info/left_part/get_skill_1/skill_name",
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
											no_skill_1 = {
												path = "right/evo/evo_info/left_part/no_skill_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											get_skill_2 = {
												path = "right/evo/evo_info/left_part/get_skill_2",
												list = {
													bg = {
														path = "right/evo/evo_info/left_part/get_skill_2/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													skill_name = {
														path = "right/evo/evo_info/left_part/get_skill_2/skill_name",
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
											no_skill_2 = {
												path = "right/evo/evo_info/left_part/no_skill_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											remake_hint = {
												path = "right/evo/evo_info/left_part/remake_hint",
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
									res = {
										path = "right/evo/evo_info/res",
										list = {
											res_1 = {
												path = "right/evo/evo_info/res/res_1",
												list = {
													icon = {
														path = "right/evo/evo_info/res/res_1/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													need_num = {
														path = "right/evo/evo_info/res/res_1/need_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													self_num = {
														path = "right/evo/evo_info/res/res_1/self_num",
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
											res_2 = {
												path = "right/evo/evo_info/res/res_2",
												list = {
													icon = {
														path = "right/evo/evo_info/res/res_2/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													need_num = {
														path = "right/evo/evo_info/res/res_2/need_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													self_num = {
														path = "right/evo/evo_info/res/res_2/self_num",
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
											res_3 = {
												path = "right/evo/evo_info/res/res_3",
												list = {
													icon = {
														path = "right/evo/evo_info/res/res_3/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													need_num = {
														path = "right/evo/evo_info/res/res_3/need_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													self_num = {
														path = "right/evo/evo_info/res/res_3/self_num",
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
											res_4 = {
												path = "right/evo/evo_info/res/res_4",
												list = {
													icon = {
														path = "right/evo/evo_info/res/res_4/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													need_num = {
														path = "right/evo/evo_info/res/res_4/need_num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													self_num = {
														path = "right/evo/evo_info/res/res_4/self_num",
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
									corelist_btn = {
										path = "right/evo/evo_info/corelist_btn",
										list = {
											title = {
												path = "right/evo/evo_info/corelist_btn/title",
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
											"ScaleButton"
										}
									},
									remake_btn = {
										path = "right/evo/evo_info/remake_btn",
										list = {
											title = {
												path = "right/evo/evo_info/remake_btn/title",
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
											"ScaleButton"
										}
									},
									no_info = {
										path = "right/evo/evo_info/no_info",
										list = {
											remake_empty = {
												path = "right/evo/evo_info/no_info/remake_empty",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "right/evo/evo_info/no_info/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											need_num = {
												path = "right/evo/evo_info/no_info/need_num",
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
									have_info = {
										path = "right/evo/evo_info/have_info",
										list = {
											icon_bg = {
												path = "right/evo/evo_info/have_info/icon_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "right/evo/evo_info/have_info/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "right/evo/evo_info/have_info/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											need_num = {
												path = "right/evo/evo_info/have_info/need_num",
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
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					},
					skill = {
						path = "right/skill",
						list = {
							skill_left = {
								path = "right/skill/skill_left",
								list = {
									has_skill_left = {
										path = "right/skill/skill_left/has_skill_left",
										list = {
											white_bg = {
												path = "right/skill/skill_left/has_skill_left/white_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											info_bg = {
												path = "right/skill/skill_left/has_skill_left/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											need_stren_title = {
												path = "right/skill/skill_left/has_skill_left/need_stren_title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attrib_1 = {
												path = "right/skill/skill_left/has_skill_left/attrib_1",
												list = {
													icon = {
														path = "right/skill/skill_left/has_skill_left/attrib_1/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/has_skill_left/attrib_1/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right/skill/skill_left/has_skill_left/attrib_1/num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													max = {
														path = "right/skill/skill_left/has_skill_left/attrib_1/max",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/has_skill_left/attrib_1/progress_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_bar = {
														path = "right/skill/skill_left/has_skill_left/attrib_1/progress_bar",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_full = {
														path = "right/skill/skill_left/has_skill_left/attrib_1/progress_full",
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
											attrib_2 = {
												path = "right/skill/skill_left/has_skill_left/attrib_2",
												list = {
													icon = {
														path = "right/skill/skill_left/has_skill_left/attrib_2/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/has_skill_left/attrib_2/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right/skill/skill_left/has_skill_left/attrib_2/num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													max = {
														path = "right/skill/skill_left/has_skill_left/attrib_2/max",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/has_skill_left/attrib_2/progress_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_bar = {
														path = "right/skill/skill_left/has_skill_left/attrib_2/progress_bar",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_full = {
														path = "right/skill/skill_left/has_skill_left/attrib_2/progress_full",
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
											attrib_3 = {
												path = "right/skill/skill_left/has_skill_left/attrib_3",
												list = {
													icon = {
														path = "right/skill/skill_left/has_skill_left/attrib_3/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/has_skill_left/attrib_3/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right/skill/skill_left/has_skill_left/attrib_3/num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													max = {
														path = "right/skill/skill_left/has_skill_left/attrib_3/max",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/has_skill_left/attrib_3/progress_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_bar = {
														path = "right/skill/skill_left/has_skill_left/attrib_3/progress_bar",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_full = {
														path = "right/skill/skill_left/has_skill_left/attrib_3/progress_full",
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
											attrib_4 = {
												path = "right/skill/skill_left/has_skill_left/attrib_4",
												list = {
													icon = {
														path = "right/skill/skill_left/has_skill_left/attrib_4/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/has_skill_left/attrib_4/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													num = {
														path = "right/skill/skill_left/has_skill_left/attrib_4/num",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													max = {
														path = "right/skill/skill_left/has_skill_left/attrib_4/max",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/has_skill_left/attrib_4/progress_bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_bar = {
														path = "right/skill/skill_left/has_skill_left/attrib_4/progress_bar",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													progress_full = {
														path = "right/skill/skill_left/has_skill_left/attrib_4/progress_full",
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
											awake_btn = {
												path = "right/skill/skill_left/has_skill_left/awake_btn",
												list = {
													title = {
														path = "right/skill/skill_left/has_skill_left/awake_btn/title",
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
													"ScaleButton"
												}
											},
											upgrade_btn = {
												path = "right/skill/skill_left/has_skill_left/upgrade_btn",
												list = {
													title = {
														path = "right/skill/skill_left/has_skill_left/upgrade_btn/title",
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
													"ScaleButton"
												}
											},
											switch_btn = {
												path = "right/skill/skill_left/has_skill_left/switch_btn",
												list = {
													title = {
														path = "right/skill/skill_left/has_skill_left/switch_btn/title",
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
													"ScaleButton"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									no_skill_left = {
										path = "right/skill/skill_left/no_skill_left",
										list = {
											white_bg = {
												path = "right/skill/skill_left/no_skill_left/white_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											info_bg = {
												path = "right/skill/skill_left/no_skill_left/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											need_stren_title = {
												path = "right/skill/skill_left/no_skill_left/need_stren_title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attrib_1 = {
												path = "right/skill/skill_left/no_skill_left/attrib_1",
												list = {
													icon = {
														path = "right/skill/skill_left/no_skill_left/attrib_1/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/no_skill_left/attrib_1/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													add_count = {
														path = "right/skill/skill_left/no_skill_left/attrib_1/add_count",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/no_skill_left/attrib_1/progress_bg",
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
											attrib_2 = {
												path = "right/skill/skill_left/no_skill_left/attrib_2",
												list = {
													icon = {
														path = "right/skill/skill_left/no_skill_left/attrib_2/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/no_skill_left/attrib_2/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													add_count = {
														path = "right/skill/skill_left/no_skill_left/attrib_2/add_count",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/no_skill_left/attrib_2/progress_bg",
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
											attrib_3 = {
												path = "right/skill/skill_left/no_skill_left/attrib_3",
												list = {
													icon = {
														path = "right/skill/skill_left/no_skill_left/attrib_3/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/no_skill_left/attrib_3/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													add_count = {
														path = "right/skill/skill_left/no_skill_left/attrib_3/add_count",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/no_skill_left/attrib_3/progress_bg",
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
											attrib_4 = {
												path = "right/skill/skill_left/no_skill_left/attrib_4",
												list = {
													icon = {
														path = "right/skill/skill_left/no_skill_left/attrib_4/icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right/skill/skill_left/no_skill_left/attrib_4/title",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													add_count = {
														path = "right/skill/skill_left/no_skill_left/attrib_4/add_count",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													progress_bg = {
														path = "right/skill/skill_left/no_skill_left/attrib_4/progress_bg",
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
											skill_hint = {
												path = "right/skill/skill_left/no_skill_left/skill_hint",
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
							has_skill = {
								path = "right/skill/has_skill",
								list = {
									bg = {
										path = "right/skill/has_skill/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_up = {
										path = "right/skill/has_skill/bg_up",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_down = {
										path = "right/skill/has_skill/bg_down",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									full_hint = {
										path = "right/skill/has_skill/full_hint",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									skill_info = {
										path = "right/skill/has_skill/skill_info",
										list = {
											bg = {
												path = "right/skill/has_skill/skill_info/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											skill_icon = {
												path = "right/skill/has_skill/skill_info/skill_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											level_bg = {
												path = "right/skill/has_skill/skill_info/level_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											level_progress = {
												path = "right/skill/has_skill/skill_info/level_progress",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											next_progress = {
												path = "right/skill/has_skill/skill_info/next_progress",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											skill_name = {
												path = "right/skill/has_skill/skill_info/skill_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"TextLength"
												}
											},
											skill_level = {
												path = "right/skill/has_skill/skill_info/skill_level",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											skill_lv = {
												path = "right/skill/has_skill/skill_info/skill_lv",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											skill_stage = {
												path = "right/skill/has_skill/skill_info/skill_stage",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											skill_effect = {
												path = "right/skill/has_skill/skill_info/skill_effect",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											status_title = {
												path = "right/skill/has_skill/skill_info/status_title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											skill_scrollview = {
												path = "right/skill/has_skill/skill_info/skill_scrollview",
												list = {
													content = {
														path = "right/skill/has_skill/skill_info/skill_scrollview/content",
														list = {
															info_txt = {
																path = "right/skill/has_skill/skill_info/skill_scrollview/content/info_txt",
																list = {},
																component = {
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
													"UnityEngine.UI.ScrollRect",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Mask"
												}
											},
											skill_status = {
												path = "right/skill/has_skill/skill_info/skill_status",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											left_btn = {
												path = "right/skill/has_skill/skill_info/left_btn",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											right_btn = {
												path = "right/skill/has_skill/skill_info/right_btn",
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
									skill_up = {
										path = "right/skill/has_skill/skill_up",
										list = {
											skill_icon = {
												path = "right/skill/has_skill/skill_up/skill_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											skill_name = {
												path = "right/skill/has_skill/skill_up/skill_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"TextLength"
												}
											},
											skill_level = {
												path = "right/skill/has_skill/skill_up/skill_level",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											up_btn = {
												path = "right/skill/has_skill/skill_up/up_btn",
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
									skill_down = {
										path = "right/skill/has_skill/skill_down",
										list = {
											skill_icon = {
												path = "right/skill/has_skill/skill_down/skill_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											skill_name = {
												path = "right/skill/has_skill/skill_down/skill_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"TextLength"
												}
											},
											skill_level = {
												path = "right/skill/has_skill/skill_down/skill_level",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											down_btn = {
												path = "right/skill/has_skill/skill_down/down_btn",
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
							no_skill = {
								path = "right/skill/no_skill",
								list = {
									bg = {
										path = "right/skill/no_skill/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									skill_info = {
										path = "right/skill/no_skill/skill_info",
										list = {
											bg = {
												path = "right/skill/no_skill/skill_info/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											level_bg = {
												path = "right/skill/no_skill/skill_info/level_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											skill_empty = {
												path = "right/skill/no_skill/skill_info/skill_empty",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											skill_name = {
												path = "right/skill/no_skill/skill_info/skill_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											status_title = {
												path = "right/skill/no_skill/skill_info/status_title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											skill_status = {
												path = "right/skill/no_skill/skill_info/skill_status",
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
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["remake/top/title"] = "_control.top.title",
			["remake/right/skill/no_skill/skill_info/skill_status"] = "_control.right.skill.no_skill.skill_info.skill_status",
			["remake/right/skill/skill_left/has_skill_left/attrib_4/progress_bg"] = "_control.right.skill.skill_left.has_skill_left.attrib_4.progress_bg",
			["remake/left/shipinfo/ship/up/icon"] = "_control.left.shipinfo.ship.up.icon",
			["remake/right/skill/skill_left/has_skill_left/attrib_1/progress_bar"] = "_control.right.skill.skill_left.has_skill_left.attrib_1.progress_bar",
			["remake/right/skill/skill_left/has_skill_left/attrib_3/progress_full"] = "_control.right.skill.skill_left.has_skill_left.attrib_3.progress_full",
			["remake/right/skill/skill_left/has_skill_left/attrib_3/progress_bar"] = "_control.right.skill.skill_left.has_skill_left.attrib_3.progress_bar",
			["remake/right/skill/skill_left/has_skill_left/attrib_3/progress_bg"] = "_control.right.skill.skill_left.has_skill_left.attrib_3.progress_bg",
			["remake/right/skill/skill_left/has_skill_left/attrib_3/max"] = "_control.right.skill.skill_left.has_skill_left.attrib_3.max",
			["remake/right/skill/skill_left/has_skill_left/attrib_3/num"] = "_control.right.skill.skill_left.has_skill_left.attrib_3.num",
			["remake/top/toggle_control"] = "_control.top.toggle_control",
			["remake/right/skill/skill_left/has_skill_left/attrib_3/icon"] = "_control.right.skill.skill_left.has_skill_left.attrib_3.icon",
			["remake/right/skill/skill_left/has_skill_left/attrib_2/progress_full"] = "_control.right.skill.skill_left.has_skill_left.attrib_2.progress_full",
			["remake/right/skill/skill_left/has_skill_left/attrib_2/progress_bar"] = "_control.right.skill.skill_left.has_skill_left.attrib_2.progress_bar",
			["remake/right/skill/skill_left/has_skill_left/attrib_2/max"] = "_control.right.skill.skill_left.has_skill_left.attrib_2.max",
			["remake/right/skill/skill_left/has_skill_left/attrib_2/num"] = "_control.right.skill.skill_left.has_skill_left.attrib_2.num",
			["remake/right/skill/skill_left/has_skill_left/attrib_2/title"] = "_control.right.skill.skill_left.has_skill_left.attrib_2.title",
			["remake/right/skill/skill_left/has_skill_left/attrib_2/icon"] = "_control.right.skill.skill_left.has_skill_left.attrib_2.icon",
			["remake/top/toggle_control/strengthen/unselected/selected"] = "_control.top.toggle_control.strengthen.unselected.selected",
			["remake/right/evo/evo_info/left_part/no_get"] = "_control.right.evo.evo_info.left_part.no_get",
			["remake/right/evo/evo_info/remake_btn/title"] = "_control.right.evo.evo_info.remake_btn.title",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value",
			["remake/right/skill/skill_left/has_skill_left/attrib_1/max"] = "_control.right.skill.skill_left.has_skill_left.attrib_1.max",
			["remake/right/strengthen/detail/attrib/attrib_1/title"] = "_control.right.strengthen.detail.attrib.attrib_1.title",
			["remake/right/skill/skill_left/has_skill_left/attrib_1/title"] = "_control.right.skill.skill_left.has_skill_left.attrib_1.title",
			["remake/right/skill/skill_left/has_skill_left/need_stren_title"] = "_control.right.skill.skill_left.has_skill_left.need_stren_title",
			["remake/right/evo/evo_info/have_info/need_num"] = "_control.right.evo.evo_info.have_info.need_num",
			["remake/right/evo/evo_info/left_part/arrow_2"] = "_control.right.evo.evo_info.left_part.arrow_2",
			["remake/right/skill/skill_left/has_skill_left/attrib_4/progress_full"] = "_control.right.skill.skill_left.has_skill_left.attrib_4.progress_full",
			["remake/right/evo/evo_info/have_info/icon"] = "_control.right.evo.evo_info.have_info.icon",
			["remake/right/evo/evo_info/res/res_3/self_num"] = "_control.right.evo.evo_info.res.res_3.self_num",
			["remake/right/evo/evo_info/res/res_1/need_num"] = "_control.right.evo.evo_info.res.res_1.need_num",
			["remake/right/strengthen/detail/attrib/attrib_2"] = "_control.right.strengthen.detail.attrib.attrib_2",
			["remake/top/close_btn"] = "_control.top.close_btn",
			["remake/right/evo/evo_info/res/res_4/self_num"] = "_control.right.evo.evo_info.res.res_4.self_num",
			["remake/right/evo/evo_info/res/res_4/icon"] = "_control.right.evo.evo_info.res.res_4.icon",
			["remake/right/strengthen/detail/streng_btn"] = "_control.right.strengthen.detail.streng_btn",
			["remake/right/evo/evo_info/res/res_3/need_num"] = "_control.right.evo.evo_info.res.res_3.need_num",
			["remake/right/skill/skill_left/has_skill_left/attrib_4"] = "_control.right.skill.skill_left.has_skill_left.attrib_4",
			["remake/left/shipinfo/ship/detail/hp_layer/title"] = "_control.left.shipinfo.ship.detail.hp_layer.title",
			["remake/right/evo/evo_info/res/res_2/icon"] = "_control.right.evo.evo_info.res.res_2.icon",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/add_count"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.add_count",
			["remake/top/line_1"] = "_control.top.line_1",
			["remake/right/evo/evo_info/res/res_1/icon"] = "_control.right.evo.evo_info.res.res_1.icon",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/num"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.num",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/add_count"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.add_count",
			["remake/right/strengthen/scroll"] = "_control.right.strengthen.scroll",
			["remake/right/skill/has_skill/skill_info/skill_level"] = "_control.right.skill.has_skill.skill_info.skill_level",
			["remake/right/evo/evo_info/left_part/get_skill_2/skill_name"] = "_control.right.evo.evo_info.left_part.get_skill_2.skill_name",
			["remake/right/evo/evo_info/left_part/have_get/ship_stage"] = "_control.right.evo.evo_info.left_part.have_get.ship_stage",
			["remake/left/shipinfo/ship/detail"] = "_control.left.shipinfo.ship.detail",
			["remake/right/skill/skill_left/no_skill_left/attrib_2/icon"] = "_control.right.skill.skill_left.no_skill_left.attrib_2.icon",
			["remake/right/evo/evo_info/left_part/have_get"] = "_control.right.evo.evo_info.left_part.have_get",
			["remake/right/evo/evo_info/left_part/arrow_1"] = "_control.right.evo.evo_info.left_part.arrow_1",
			["remake/right/evo/evo_info/left_part/info_bg"] = "_control.right.evo.evo_info.left_part.info_bg",
			["remake/left/shipinfo/ship/up/heart_layer"] = "_control.left.shipinfo.ship.up.heart_layer",
			["remake/right/skill/no_skill"] = "_control.right.skill.no_skill",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/exp/exp_num"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.exp.exp_num",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/exp/exp_bar"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.exp.exp_bar",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/exp/exp_bg"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.exp.exp_bg",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/exp"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.exp",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/level"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.level",
			["remake/right/evo/evo_info/have_info"] = "_control.right.evo.evo_info.have_info",
			["remake/top/toggle_control/strengthen/unselected"] = "_control.top.toggle_control.strengthen.unselected",
			["remake/left"] = "_control.left",
			["remake/right/strengthen/detail/attrib/attrib_3/default/default_num"] = "_control.right.strengthen.detail.attrib.attrib_3.default.default_num",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/exp/exp_bg"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.exp.exp_bg",
			["remake/left/shipinfo/ship/detail/ship_remake"] = "_control.left.shipinfo.ship.detail.ship_remake",
			["remake/right/strengthen/detail/attrib/attrib_3/line"] = "_control.right.strengthen.detail.attrib.attrib_3.line",
			["remake/left/shipinfo/ship/detail/hp_layer"] = "_control.left.shipinfo.ship.detail.hp_layer",
			["remake/left/shipinfo/ship"] = "_control.left.shipinfo.ship",
			["remake/right/strengthen/detail/attrib/attrib_4/icon"] = "_control.right.strengthen.detail.attrib.attrib_4.icon",
			["remake/right/evo/evo_info"] = "_control.right.evo.evo_info",
			["remake/left/shipinfo/ship/detail/ship_type"] = "_control.left.shipinfo.ship.detail.ship_type",
			["remake/left/shipinfo/ship/detail/star_layer"] = "_control.left.shipinfo.ship.detail.star_layer",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value",
			["remake/left/shipinfo/ship/detail/star_layer/star_2"] = "_control.left.shipinfo.ship.detail.star_layer.star_2",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/exp/exp_num"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.exp.exp_num",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/exp/exp_num"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.exp.exp_num",
			["remake/left/shipinfo/ship/detail/hp_layer/blood_bg"] = "_control.left.shipinfo.ship.detail.hp_layer.blood_bg",
			["remake/right/strengthen/detail/attrib/attrib_4/title"] = "_control.right.strengthen.detail.attrib.attrib_4.title",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/num"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.num",
			["remake/bottom"] = "_control.bottom",
			["remake/right/evo/evo_info/res/res_1"] = "_control.right.evo.evo_info.res.res_1",
			["remake/right/strengthen/detail/attrib/attrib_2/default/default_num"] = "_control.right.strengthen.detail.attrib.attrib_2.default.default_num",
			["remake/right/evo/evo_info/no_info/need_num"] = "_control.right.evo.evo_info.no_info.need_num",
			["remake/right/evo/evo_info/left_part/remake_get_skill"] = "_control.right.evo.evo_info.left_part.remake_get_skill",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/max"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.max",
			["remake/right/evo/evo_info/left_part/have_get/ship_name/ship_name_1"] = "_control.right.evo.evo_info.left_part.have_get.ship_name.ship_name_1",
			["remake/right"] = "_control.right",
			["remake/right/evo/evo_info/left_part/get_skill_1/skill_name"] = "_control.right.evo.evo_info.left_part.get_skill_1.skill_name",
			["remake/right/strengthen/detail/attrib/attrib_4/line"] = "_control.right.strengthen.detail.attrib.attrib_4.line",
			["remake/top/toggle_control/strengthen"] = "_control.top.toggle_control.strengthen",
			["remake/right/strengthen/scroll/viewport/content"] = "_control.right.strengthen.scroll.viewport.content",
			["remake/right/skill/skill_left/has_skill_left/attrib_1/progress_bg"] = "_control.right.skill.skill_left.has_skill_left.attrib_1.progress_bg",
			["remake/right/strengthen/detail/attrib"] = "_control.right.strengthen.detail.attrib",
			["remake/left/shipinfo/ship/detail/hp_layer/count"] = "_control.left.shipinfo.ship.detail.hp_layer.count",
			["remake/top/toggle_control/evo/unselected"] = "_control.top.toggle_control.evo.unselected",
			["remake/right/strengthen/detail/attrib/attrib_1/line"] = "_control.right.strengthen.detail.attrib.attrib_1.line",
			["remake/right/evo/evo_info/effect"] = "_control.right.evo.evo_info.effect",
			["remake/right/evo/evo_info/res/res_1/self_num"] = "_control.right.evo.evo_info.res.res_1.self_num",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/add_count"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.add_count",
			["remake/right/strengthen/detail/attrib/attrib_1/icon"] = "_control.right.strengthen.detail.attrib.attrib_1.icon",
			["remake/right/evo/evo_info/res/res_3"] = "_control.right.evo.evo_info.res.res_3",
			["remake/right/evo/evo_info/res/res_2/need_num"] = "_control.right.evo.evo_info.res.res_2.need_num",
			["remake/right/skill/skill_left/has_skill_left/attrib_1/num"] = "_control.right.skill.skill_left.has_skill_left.attrib_1.num",
			["remake/right/strengthen/detail/attrib/attrib_1/default/default_num"] = "_control.right.strengthen.detail.attrib.attrib_1.default.default_num",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/num"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.num",
			["remake/right/strengthen/detail/attrib/attrib_1/default"] = "_control.right.strengthen.detail.attrib.attrib_1.default",
			["remake/right/skill/skill_left/has_skill_left/attrib_4/icon"] = "_control.right.skill.skill_left.has_skill_left.attrib_4.icon",
			["remake/right/evo/evo_info/res/res_2/self_num"] = "_control.right.evo.evo_info.res.res_2.self_num",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/level"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.level",
			["remake/right/skill/no_skill/skill_info/level_bg"] = "_control.right.skill.no_skill.skill_info.level_bg",
			["remake/top"] = "_control.top",
			["remake/right/evo"] = "_control.right.evo",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/max"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.max",
			["remake/left/shipinfo/ship/detail/star_layer/star_1"] = "_control.left.shipinfo.ship.detail.star_layer.star_1",
			["remake/right/skill/skill_left/has_skill_left/attrib_1/progress_full"] = "_control.right.skill.skill_left.has_skill_left.attrib_1.progress_full",
			["remake/top/line_3"] = "_control.top.line_3",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value",
			["remake/right/strengthen/detail/attrib/attrib_2/line"] = "_control.right.strengthen.detail.attrib.attrib_2.line",
			["remake/right/strengthen/detail/clear_btn"] = "_control.right.strengthen.detail.clear_btn",
			["remake/right/strengthen/detail/attrib/attrib_2/icon"] = "_control.right.strengthen.detail.attrib.attrib_2.icon",
			["remake/right/skill/no_skill/bg"] = "_control.right.skill.no_skill.bg",
			["remake/right/strengthen/detail/attrib/attrib_2/default"] = "_control.right.strengthen.detail.attrib.attrib_2.default",
			["remake/right/strengthen/detail/attrib/attrib_2/default/defalut_exp"] = "_control.right.strengthen.detail.attrib.attrib_2.default.defalut_exp",
			["remake/top/line_right"] = "_control.top.line_right",
			["remake/top/toggle_control/evo"] = "_control.top.toggle_control.evo",
			["remake/bottom/tip"] = "_control.bottom.tip",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/add_count"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.add_count",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/max"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.max",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/level"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.level",
			["remake/right/strengthen/detail/attrib/attrib_1"] = "_control.right.strengthen.detail.attrib.attrib_1",
			["remake/right/skill/skill_left/no_skill_left/white_bg"] = "_control.right.skill.skill_left.no_skill_left.white_bg",
			["remake/top/toggle_control/remak_event"] = "_control.top.toggle_control.remak_event",
			["remake/right/evo/evo_info/left_part/remake_get"] = "_control.right.evo.evo_info.left_part.remake_get",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/exp"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.exp",
			["remake/right/skill/skill_left/no_skill_left/attrib_1"] = "_control.right.skill.skill_left.no_skill_left.attrib_1",
			["remake/right/skill/has_skill/skill_info"] = "_control.right.skill.has_skill.skill_info",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/exp/exp_bar"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.exp.exp_bar",
			["remake/right/strengthen/detail/attrib/attrib_1/default/defalut_exp"] = "_control.right.strengthen.detail.attrib.attrib_1.default.defalut_exp",
			["remake/right/skill/skill_left/has_skill_left/awake_btn/title"] = "_control.right.skill.skill_left.has_skill_left.awake_btn.title",
			["remake/right/skill/skill_left/has_skill_left/attrib_3/title"] = "_control.right.skill.skill_left.has_skill_left.attrib_3.title",
			["remake/right/strengthen/detail/attrib/attrib_3/title"] = "_control.right.strengthen.detail.attrib.attrib_3.title",
			["remake/right/strengthen/detail/attrib/attrib_3/default"] = "_control.right.strengthen.detail.attrib.attrib_3.default",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/exp/exp_bg"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.exp.exp_bg",
			["remake/right/strengthen/detail/attrib/attrib_3/default/defalut_exp"] = "_control.right.strengthen.detail.attrib.attrib_3.default.defalut_exp",
			["remake/right/strengthen/detail"] = "_control.right.strengthen.detail",
			["remake/right/evo/evo_info/corelist_btn"] = "_control.right.evo.evo_info.corelist_btn",
			["remake/right/evo/remake_bg"] = "_control.right.evo.remake_bg",
			["remake/right/skill/skill_left/no_skill_left/attrib_1/icon"] = "_control.right.skill.skill_left.no_skill_left.attrib_1.icon",
			["remake/left/shipinfo/ship/detail/line"] = "_control.left.shipinfo.ship.detail.line",
			["remake/right/skill/skill_left/no_skill_left/attrib_2/title"] = "_control.right.skill.skill_left.no_skill_left.attrib_2.title",
			["remake/right/skill/skill_left/has_skill_left/white_bg"] = "_control.right.skill.skill_left.has_skill_left.white_bg",
			["remake/right/skill/skill_left/no_skill_left/attrib_2/add_count"] = "_control.right.skill.skill_left.no_skill_left.attrib_2.add_count",
			["remake/right/skill/skill_left/no_skill_left/attrib_2/progress_bg"] = "_control.right.skill.skill_left.no_skill_left.attrib_2.progress_bg",
			["remake/right/skill/skill_left/no_skill_left/attrib_3/icon"] = "_control.right.skill.skill_left.no_skill_left.attrib_3.icon",
			["remake/right/skill/skill_left/has_skill_left/switch_btn/title"] = "_control.right.skill.skill_left.has_skill_left.switch_btn.title",
			["remake/right/evo/evo_info/level"] = "_control.right.evo.evo_info.level",
			["remake/right/skill/skill_left/no_skill_left/attrib_3/title"] = "_control.right.skill.skill_left.no_skill_left.attrib_3.title",
			["remake/right/skill/skill_left/no_skill_left/attrib_3/add_count"] = "_control.right.skill.skill_left.no_skill_left.attrib_3.add_count",
			["remake/right/skill/skill_left/no_skill_left/attrib_3/progress_bg"] = "_control.right.skill.skill_left.no_skill_left.attrib_3.progress_bg",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/level"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.level",
			["remake/right/skill/skill_left/no_skill_left/attrib_4/icon"] = "_control.right.skill.skill_left.no_skill_left.attrib_4.icon",
			["remake/right/evo/evo_info/left_part/have_get/ship_stage/ship_stage_2"] = "_control.right.evo.evo_info.left_part.have_get.ship_stage.ship_stage_2",
			["remake/right/skill/skill_left/no_skill_left/attrib_4/title"] = "_control.right.skill.skill_left.no_skill_left.attrib_4.title",
			["remake/right/skill/has_skill/skill_up/skill_icon"] = "_control.right.skill.has_skill.skill_up.skill_icon",
			["remake/right/skill/skill_left/no_skill_left/attrib_4/progress_bg"] = "_control.right.skill.skill_left.no_skill_left.attrib_4.progress_bg",
			["remake/right/skill/has_skill/bg"] = "_control.right.skill.has_skill.bg",
			["remake/right/skill/skill_left/has_skill_left/attrib_3"] = "_control.right.skill.skill_left.has_skill_left.attrib_3",
			["remake/right/skill/skill_left/has_skill_left/awake_btn"] = "_control.right.skill.skill_left.has_skill_left.awake_btn",
			["remake/right/skill/has_skill/bg_up"] = "_control.right.skill.has_skill.bg_up",
			["remake/bottom/bottom_line"] = "_control.bottom.bottom_line",
			["remake/right/strengthen/detail/attrib/attrib_2/have_value/exp/exp_bg"] = "_control.right.strengthen.detail.attrib.attrib_2.have_value.exp.exp_bg",
			["remake/right/evo/evo_info/level_title"] = "_control.right.evo.evo_info.level_title",
			["remake/right/evo/evo_info/left_part/have_get/ship_name"] = "_control.right.evo.evo_info.left_part.have_get.ship_name",
			["remake/right/strengthen/detail/attrib/attrib_3"] = "_control.right.strengthen.detail.attrib.attrib_3",
			["remake/right/evo/evo_info/left_part"] = "_control.right.evo.evo_info.left_part",
			["remake/right/skill/has_skill/skill_info/bg"] = "_control.right.skill.has_skill.skill_info.bg",
			["remake/right/skill/has_skill/skill_info/level_bg"] = "_control.right.skill.has_skill.skill_info.level_bg",
			["remake/right/skill/skill_left/has_skill_left/attrib_1/icon"] = "_control.right.skill.skill_left.has_skill_left.attrib_1.icon",
			["remake/right/skill/skill_left/has_skill_left/attrib_1"] = "_control.right.skill.skill_left.has_skill_left.attrib_1",
			["remake/right/skill/has_skill/skill_info/skill_stage"] = "_control.right.skill.has_skill.skill_info.skill_stage",
			["remake/right/skill/has_skill/skill_info/skill_effect"] = "_control.right.skill.has_skill.skill_info.skill_effect",
			["remake/right/evo/evo_info/left_part/have_get/ship_name/ship_name_2"] = "_control.right.evo.evo_info.left_part.have_get.ship_name.ship_name_2",
			["remake/top/toggle_control/skill"] = "_control.top.toggle_control.skill",
			["remake/right/skill/has_skill/skill_up"] = "_control.right.skill.has_skill.skill_up",
			["remake/right/skill/skill_left/no_skill_left/attrib_4/add_count"] = "_control.right.skill.skill_left.no_skill_left.attrib_4.add_count",
			["remake/right/skill/has_skill/skill_down/skill_icon"] = "_control.right.skill.has_skill.skill_down.skill_icon",
			["remake/right/skill/skill_left/no_skill_left/attrib_3"] = "_control.right.skill.skill_left.no_skill_left.attrib_3",
			["remake/right/skill/has_skill/skill_down/skill_name"] = "_control.right.skill.has_skill.skill_down.skill_name",
			["remake/right/skill/has_skill/skill_down/skill_level"] = "_control.right.skill.has_skill.skill_down.skill_level",
			["remake/right/skill/has_skill/skill_down/down_btn"] = "_control.right.skill.has_skill.skill_down.down_btn",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/exp/exp_bar"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.exp.exp_bar",
			["remake/right/skill/skill_left/has_skill_left/switch_btn"] = "_control.right.skill.skill_left.has_skill_left.switch_btn",
			["remake/right/evo/evo_info/left_part/no_skill_2"] = "_control.right.evo.evo_info.left_part.no_skill_2",
			["remake/right/strengthen/detail/streng_btn/title"] = "_control.right.strengthen.detail.streng_btn.title",
			["remake/right/skill/skill_left/no_skill_left"] = "_control.right.skill.skill_left.no_skill_left",
			["remake/right/strengthen/detail/attrib/attrib_2/title"] = "_control.right.strengthen.detail.attrib.attrib_2.title",
			["remake/right/skill/no_skill/skill_info"] = "_control.right.skill.no_skill.skill_info",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/exp"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.exp",
			["remake/right/skill/no_skill/skill_info/skill_empty"] = "_control.right.skill.no_skill.skill_info.skill_empty",
			["remake/right/skill/skill_left/has_skill_left/attrib_4/progress_bar"] = "_control.right.skill.skill_left.has_skill_left.attrib_4.progress_bar",
			["remake/right/evo/evo_info/left_part/have_get/ship_stage/ship_stage_1"] = "_control.right.evo.evo_info.left_part.have_get.ship_stage.ship_stage_1",
			["remake/right/skill/has_skill/skill_info/status_title"] = "_control.right.skill.has_skill.skill_info.status_title",
			["remake/left/shipinfo/ship/detail/name_layer/name_bg/name_txt_1"] = "_control.left.shipinfo.ship.detail.name_layer.name_bg.name_txt_1",
			["remake/left/shipinfo/ship/change_btn"] = "_control.left.shipinfo.ship.change_btn",
			["remake/left/shipinfo/ship/detail/name_layer"] = "_control.left.shipinfo.ship.detail.name_layer",
			["remake/right/strengthen/detail/attrib/attrib_4/default/defalut_exp"] = "_control.right.strengthen.detail.attrib.attrib_4.default.defalut_exp",
			["remake/top/toggle_control/skill/unselected/selected"] = "_control.top.toggle_control.skill.unselected.selected",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/exp"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.exp",
			["remake/left/shipinfo/line"] = "_control.left.shipinfo.line",
			["remake/right/evo/evo_info/left_part/remake_hint"] = "_control.right.evo.evo_info.left_part.remake_hint",
			["remake/right/skill/has_skill/skill_info/skill_scrollview"] = "_control.right.skill.has_skill.skill_info.skill_scrollview",
			["remake/right/strengthen/detail/attrib/attrib_4/default/default_num"] = "_control.right.strengthen.detail.attrib.attrib_4.default.default_num",
			["remake/right/strengthen/detail/clear_btn/title"] = "_control.right.strengthen.detail.clear_btn.title",
			["remake/right/evo/evo_info/left_part/get_skill_2"] = "_control.right.evo.evo_info.left_part.get_skill_2",
			["remake/left/shipinfo/ship/detail/star_layer/star_7"] = "_control.left.shipinfo.ship.detail.star_layer.star_7",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/num"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.num",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value/exp/exp_bar"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value.exp.exp_bar",
			["remake/right/skill/skill_left/has_skill_left/upgrade_btn"] = "_control.right.skill.skill_left.has_skill_left.upgrade_btn",
			["remake/left/shipinfo/ship/up/heart_layer/heart"] = "_control.left.shipinfo.ship.up.heart_layer.heart",
			["remake/right/skill/skill_left/no_skill_left/attrib_1/add_count"] = "_control.right.skill.skill_left.no_skill_left.attrib_1.add_count",
			["remake/right/evo/evo_info/corelist_btn/title"] = "_control.right.evo.evo_info.corelist_btn.title",
			["remake/left/shipinfo/ship/detail/star_layer/star_5"] = "_control.left.shipinfo.ship.detail.star_layer.star_5",
			["remake/right/skill/skill_left/has_skill_left/info_bg"] = "_control.right.skill.skill_left.has_skill_left.info_bg",
			["remake/right/evo/evo_info/left_part/get_skill_2/bg"] = "_control.right.evo.evo_info.left_part.get_skill_2.bg",
			["remake/top/line_left"] = "_control.top.line_left",
			["remake/left/shipinfo/ship/detail/bg"] = "_control.left.shipinfo.ship.detail.bg",
			["remake/right/skill/has_skill/skill_info/level_progress"] = "_control.right.skill.has_skill.skill_info.level_progress",
			["remake/right/skill/has_skill/skill_info/skill_name"] = "_control.right.skill.has_skill.skill_info.skill_name",
			["remake/top/line_2"] = "_control.top.line_2",
			["remake/bg"] = "_control.bg",
			["remake/right/skill/has_skill/skill_info/skill_icon"] = "_control.right.skill.has_skill.skill_info.skill_icon",
			["remake/right/skill/skill_left/no_skill_left/skill_hint"] = "_control.right.skill.skill_left.no_skill_left.skill_hint",
			["remake/right/evo/evo_info/left_part/no_skill_1"] = "_control.right.evo.evo_info.left_part.no_skill_1",
			["remake/right/skill/skill_left/has_skill_left/attrib_4/num"] = "_control.right.skill.skill_left.has_skill_left.attrib_4.num",
			["remake/right/skill/has_skill/skill_info/skill_lv"] = "_control.right.skill.has_skill.skill_info.skill_lv",
			["remake/right/skill/skill_left/has_skill_left/attrib_2/progress_bg"] = "_control.right.skill.skill_left.has_skill_left.attrib_2.progress_bg",
			["remake/right/skill/skill_left/no_skill_left/info_bg"] = "_control.right.skill.skill_left.no_skill_left.info_bg",
			["remake/right/strengthen/detail/attrib/attrib_4/have_value/max"] = "_control.right.strengthen.detail.attrib.attrib_4.have_value.max",
			["remake/right/skill/has_skill/skill_up/skill_level"] = "_control.right.skill.has_skill.skill_up.skill_level",
			["remake/left/shipinfo/ship/up"] = "_control.left.shipinfo.ship.up",
			["remake/right/evo/evo_info/res/res_4/need_num"] = "_control.right.evo.evo_info.res.res_4.need_num",
			["remake/right/skill/skill_left/has_skill_left"] = "_control.right.skill.skill_left.has_skill_left",
			["remake/right/skill/no_skill/skill_info/bg"] = "_control.right.skill.no_skill.skill_info.bg",
			["remake/right/evo/evo_info/left_part/get_skill_1/bg"] = "_control.right.evo.evo_info.left_part.get_skill_1.bg",
			["remake/right/skill/skill_left/no_skill_left/attrib_1/progress_bg"] = "_control.right.skill.skill_left.no_skill_left.attrib_1.progress_bg",
			["remake/left/shipinfo/ship/detail/star_layer/star_3"] = "_control.left.shipinfo.ship.detail.star_layer.star_3",
			["remake/right/strengthen/detail/attrib/attrib_3/icon"] = "_control.right.strengthen.detail.attrib.attrib_3.icon",
			["remake/left/shipinfo/ship/detail/name_layer/name_bg/name_txt"] = "_control.left.shipinfo.ship.detail.name_layer.name_bg.name_txt",
			["remake/right/skill/has_skill/skill_info/next_progress"] = "_control.right.skill.has_skill.skill_info.next_progress",
			["remake/right/skill/no_skill/skill_info/skill_name"] = "_control.right.skill.no_skill.skill_info.skill_name",
			["remake/right/strengthen/detail/bg"] = "_control.right.strengthen.detail.bg",
			["remake/right/skill/no_skill/skill_info/status_title"] = "_control.right.skill.no_skill.skill_info.status_title",
			["remake/right/skill/has_skill/skill_info/skill_scrollview/content/info_txt"] = "_control.right.skill.has_skill.skill_info.skill_scrollview.content.info_txt",
			["remake/top/toggle_control/strengthen/rbtn"] = "_control.top.toggle_control.strengthen.rbtn",
			["remake/right/skill/has_skill/skill_up/up_btn"] = "_control.right.skill.has_skill.skill_up.up_btn",
			["remake/right/evo/evo_info/res/res_4"] = "_control.right.evo.evo_info.res.res_4",
			["remake/right/skill/has_skill/skill_info/skill_status"] = "_control.right.skill.has_skill.skill_info.skill_status",
			["remake/left/shipinfo/ship/detail/country"] = "_control.left.shipinfo.ship.detail.country",
			["remake/top/toggle_control/skill/unselected"] = "_control.top.toggle_control.skill.unselected",
			["remake/right/strengthen/detail/attrib/attrib_4/default"] = "_control.right.strengthen.detail.attrib.attrib_4.default",
			["remake/left/shipinfo/ship/detail/lock_tag"] = "_control.left.shipinfo.ship.detail.lock_tag",
			["remake/right/evo/evo_info/no_info/title"] = "_control.right.evo.evo_info.no_info.title",
			["remake/left/shipinfo/ship/up/quality"] = "_control.left.shipinfo.ship.up.quality",
			["remake/right/evo/evo_info/no_info"] = "_control.right.evo.evo_info.no_info",
			["remake/right/strengthen"] = "_control.right.strengthen",
			["remake/right/skill/skill_left/has_skill_left/attrib_4/max"] = "_control.right.skill.skill_left.has_skill_left.attrib_4.max",
			["remake/top/toggle_control/evo/rbtn"] = "_control.top.toggle_control.evo.rbtn",
			["remake/right/skill/skill_left/no_skill_left/attrib_1/title"] = "_control.right.skill.skill_left.no_skill_left.attrib_1.title",
			["remake/right/evo/evo_info/have_info/icon_bg"] = "_control.right.evo.evo_info.have_info.icon_bg",
			["remake/right/skill/has_skill/full_hint"] = "_control.right.skill.has_skill.full_hint",
			["remake/right/strengthen/detail/attrib/attrib_3/have_value/exp/exp_num"] = "_control.right.strengthen.detail.attrib.attrib_3.have_value.exp.exp_num",
			["remake/right/strengthen/detail/attrib/attrib_4"] = "_control.right.strengthen.detail.attrib.attrib_4",
			["remake/right/skill/skill_left/no_skill_left/need_stren_title"] = "_control.right.skill.skill_left.no_skill_left.need_stren_title",
			["remake/left/shipinfo/ship/detail/name_layer/name_bg"] = "_control.left.shipinfo.ship.detail.name_layer.name_bg",
			["remake/right/evo/evo_info/res/res_3/icon"] = "_control.right.evo.evo_info.res.res_3.icon",
			["remake/left/shipinfo"] = "_control.left.shipinfo",
			["remake/right/evo/evo_info/remake_btn"] = "_control.right.evo.evo_info.remake_btn",
			["remake/right/evo/evo_info/res/res_2"] = "_control.right.evo.evo_info.res.res_2",
			["remake/right/skill/has_skill/skill_info/left_btn"] = "_control.right.skill.has_skill.skill_info.left_btn",
			["remake/top/toggle_control/skill/rbtn"] = "_control.top.toggle_control.skill.rbtn",
			["remake/left/shipinfo/ship/detail/level"] = "_control.left.shipinfo.ship.detail.level",
			["remake/left/shipinfo/ship/detail/hp_layer/blood_bar"] = "_control.left.shipinfo.ship.detail.hp_layer.blood_bar",
			["remake/right/evo/evo_info/left_part/remake_maybe"] = "_control.right.evo.evo_info.left_part.remake_maybe",
			["remake/right/skill/has_skill/skill_up/skill_name"] = "_control.right.skill.has_skill.skill_up.skill_name",
			["remake/top/toggle_control/evo/unselected/selected"] = "_control.top.toggle_control.evo.unselected.selected",
			["remake/left/shipinfo/select_btn"] = "_control.left.shipinfo.select_btn",
			["remake/right/skill/skill_left"] = "_control.right.skill.skill_left",
			["remake/right/strengthen/detail/attrib/attrib_1/have_value"] = "_control.right.strengthen.detail.attrib.attrib_1.have_value",
			["remake/right/skill/skill_left/no_skill_left/attrib_2"] = "_control.right.skill.skill_left.no_skill_left.attrib_2",
			["remake/left/shipinfo/effect"] = "_control.left.shipinfo.effect",
			["remake/right/skill/has_skill/skill_down"] = "_control.right.skill.has_skill.skill_down",
			["remake/right/strengthen/scroll/viewport"] = "_control.right.strengthen.scroll.viewport",
			["remake/right/skill"] = "_control.right.skill",
			["remake/right/skill/skill_left/has_skill_left/attrib_4/title"] = "_control.right.skill.skill_left.has_skill_left.attrib_4.title",
			["remake/right/skill/skill_left/has_skill_left/attrib_2"] = "_control.right.skill.skill_left.has_skill_left.attrib_2",
			["remake/right/evo/evo_info/no_info/remake_empty"] = "_control.right.evo.evo_info.no_info.remake_empty",
			["remake/right/skill/has_skill/bg_down"] = "_control.right.skill.has_skill.bg_down",
			["remake/right/skill/has_skill/skill_info/skill_scrollview/content"] = "_control.right.skill.has_skill.skill_info.skill_scrollview.content",
			["remake/right/evo/evo_info/left_part/get_skill_1"] = "_control.right.evo.evo_info.left_part.get_skill_1",
			["remake/right/evo/evo_info/have_info/title"] = "_control.right.evo.evo_info.have_info.title",
			["remake/right/skill/skill_left/has_skill_left/upgrade_btn/title"] = "_control.right.skill.skill_left.has_skill_left.upgrade_btn.title",
			["remake/left/shipinfo/ship_frame"] = "_control.left.shipinfo.ship_frame",
			["remake/right/skill/has_skill"] = "_control.right.skill.has_skill",
			["remake/left/shipinfo/ship/detail/star_layer/star_6"] = "_control.left.shipinfo.ship.detail.star_layer.star_6",
			["remake/right/evo/evo_info/res"] = "_control.right.evo.evo_info.res",
			["remake/right/skill/has_skill/skill_info/right_btn"] = "_control.right.skill.has_skill.skill_info.right_btn",
			["remake/right/skill/skill_left/no_skill_left/attrib_4"] = "_control.right.skill.skill_left.no_skill_left.attrib_4",
			["remake/left/shipinfo/ship/up/heart_layer/bg"] = "_control.left.shipinfo.ship.up.heart_layer.bg",
			["remake/left/shipinfo/ship/detail/star_layer/star_4"] = "_control.left.shipinfo.ship.detail.star_layer.star_4"
		},
		click = {
			["left/shipinfo/select_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/skill/has_skill/skill_info/left_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/skill/has_skill/skill_info/right_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/skill/has_skill/skill_up/up_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/skill/has_skill/skill_down/down_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top/close_btn"] = {
				tp = "ScaleButton"
			},
			["right/strengthen/detail/clear_btn"] = {
				tp = "ScaleButton"
			},
			["right/strengthen/detail/streng_btn"] = {
				tp = "ScaleButton"
			},
			["right/evo/evo_info/corelist_btn"] = {
				tp = "ScaleButton"
			},
			["right/evo/evo_info/remake_btn"] = {
				tp = "ScaleButton"
			},
			["right/skill/skill_left/has_skill_left/awake_btn"] = {
				tp = "ScaleButton"
			},
			["right/skill/skill_left/has_skill_left/upgrade_btn"] = {
				tp = "ScaleButton"
			},
			["right/skill/skill_left/has_skill_left/switch_btn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["top/toggle_control/strengthen"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top/toggle_control/evo"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top/toggle_control/skill"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		click_and_long_click = {
			["left/shipinfo/ship/change_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

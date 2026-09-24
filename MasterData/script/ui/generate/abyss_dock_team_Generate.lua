return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					middle_menu = {
						path = "bg/middle_menu",
						list = {
							team_content_obj = {
								path = "bg/middle_menu/team_content_obj",
								list = {
									fade_content = {
										path = "bg/middle_menu/team_content_obj/fade_content",
										list = {
											team_content = {
												path = "bg/middle_menu/team_content_obj/fade_content/team_content",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"RankableLayoutGroup",
													"UnityEngine.CanvasGroup",
													"UITweenSequence"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UITweenSequence"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener",
									"UIMoveTweener"
								}
							},
							remake_content = {
								path = "bg/middle_menu/remake_content",
								list = {
									left = {
										path = "bg/middle_menu/remake_content/left",
										list = {
											shipinfo = {
												path = "bg/middle_menu/remake_content/left/shipinfo",
												list = {
													select_btn = {
														path = "bg/middle_menu/remake_content/left/shipinfo/select_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button"
														}
													},
													ship = {
														path = "bg/middle_menu/remake_content/left/shipinfo/ship",
														list = {
															up = {
																path = "bg/middle_menu/remake_content/left/shipinfo/ship/up",
																list = {
																	quality = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/up/quality",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/up/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	heart_layer = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/up/heart_layer",
																		list = {
																			bg = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/up/heart_layer/bg",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			heart = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/up/heart_layer/heart",
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
																path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail",
																list = {
																	bg = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	line = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/line",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	lock_tag = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/lock_tag",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	ship_type = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/ship_type",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	level = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/level",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	country = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/country",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	ship_remake = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/ship_remake",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_layer = {
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer",
																		list = {
																			star = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer/star",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer/star",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer/star",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer/star",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer/star",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer/star",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/star_layer/star",
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
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/name_layer",
																		list = {
																			name_bg = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/name_layer/name_bg",
																				list = {
																					name_txt = {
																						path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/name_layer/name_bg/name_txt",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Text"
																						}
																					},
																					name_txt_1 = {
																						path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/name_layer/name_bg/name_txt_1",
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
																		path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/hp_layer",
																		list = {
																			blood_bg = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/hp_layer/blood_bg",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			blood_bar = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/hp_layer/blood_bar",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			title = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/hp_layer/title",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			count = {
																				path = "bg/middle_menu/remake_content/left/shipinfo/ship/detail/hp_layer/count",
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
																path = "bg/middle_menu/remake_content/left/shipinfo/ship/change_btn",
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
														path = "bg/middle_menu/remake_content/left/shipinfo/effect",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													ship_frame = {
														path = "bg/middle_menu/remake_content/left/shipinfo/ship_frame",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													line = {
														path = "bg/middle_menu/remake_content/left/shipinfo/line",
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
											ship_bg = {
												path = "bg/middle_menu/remake_content/left/ship_bg",
												list = {
													ship = {
														path = "bg/middle_menu/remake_content/left/ship_bg/ship",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													cover_sprite = {
														path = "bg/middle_menu/remake_content/left/ship_bg/cover_sprite",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													name_layer = {
														path = "bg/middle_menu/remake_content/left/ship_bg/name_layer",
														list = {
															name_level = {
																path = "bg/middle_menu/remake_content/left/ship_bg/name_layer/name_level",
																list = {
																	name_level_1 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/name_layer/name_level/name_level_1",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	name_level_2 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/name_layer/name_level/name_level_2",
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
															"UnityEngine.RectTransform"
														}
													},
													hp_layer = {
														path = "bg/middle_menu/remake_content/left/ship_bg/hp_layer",
														list = {
															desc = {
																path = "bg/middle_menu/remake_content/left/ship_bg/hp_layer/desc",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															bar = {
																path = "bg/middle_menu/remake_content/left/ship_bg/hp_layer/bar",
																list = {
																	amount = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/hp_layer/bar/amount",
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
															txt = {
																path = "bg/middle_menu/remake_content/left/ship_bg/hp_layer/txt",
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
													info_layer = {
														path = "bg/middle_menu/remake_content/left/ship_bg/info_layer",
														list = {
															info_bg = {
																path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/info_bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															type_txt = {
																path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/type_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															level_txt = {
																path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/level_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															country_txt = {
																path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/country_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															star_layer = {
																path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer",
																list = {
																	star_1 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer/star_1",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_2 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer/star_2",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_3 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer/star_3",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_4 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer/star_4",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_5 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer/star_5",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_6 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer/star_6",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_7 = {
																		path = "bg/middle_menu/remake_content/left/ship_bg/info_layer/star_layer/star_7",
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
													btn = {
														path = "bg/middle_menu/remake_content/left/ship_bg/btn",
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
													"UnityEngine.CanvasGroup"
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
									right = {
										path = "bg/middle_menu/remake_content/right",
										list = {
											right_bg_1 = {
												path = "bg/middle_menu/remake_content/right/right_bg_1",
												list = {
													line_layer = {
														path = "bg/middle_menu/remake_content/right/right_bg_1/line_layer",
														list = {
															top_line = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/line_layer/top_line",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															middle_line = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/line_layer/middle_line",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															floor_line = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/line_layer/floor_line",
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
													text_layer = {
														path = "bg/middle_menu/remake_content/right/right_bg_1/text_layer",
														list = {
															top_text = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/text_layer/top_text",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															middle_text = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/text_layer/middle_text",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															floor_text = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/text_layer/floor_text",
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
													remoud_have_info = {
														path = "bg/middle_menu/remake_content/right/right_bg_1/remoud_have_info",
														list = {
															yellow_img = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/remoud_have_info/yellow_img",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															material_img = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/remoud_have_info/material_img",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															num_text = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/remoud_have_info/num_text",
																list = {
																	need_text = {
																		path = "bg/middle_menu/remake_content/right/right_bg_1/remoud_have_info/num_text/need_text",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	sum_text = {
																		path = "bg/middle_menu/remake_content/right/right_bg_1/remoud_have_info/num_text/sum_text",
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
													num_top_text = {
														path = "bg/middle_menu/remake_content/right/right_bg_1/num_top_text",
														list = {
															text = {
																path = "bg/middle_menu/remake_content/right/right_bg_1/num_top_text/text",
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
													"UnityEngine.UI.Image"
												}
											},
											right_bg_2 = {
												path = "bg/middle_menu/remake_content/right/right_bg_2",
												list = {
													top_line = {
														path = "bg/middle_menu/remake_content/right/right_bg_2/top_line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													vertical_line = {
														path = "bg/middle_menu/remake_content/right/right_bg_2/vertical_line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													floor_line = {
														path = "bg/middle_menu/remake_content/right/right_bg_2/floor_line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													top_text = {
														path = "bg/middle_menu/remake_content/right/right_bg_2/top_text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													detail = {
														path = "bg/middle_menu/remake_content/right/right_bg_2/detail",
														list = {
															attr_hp = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_hp",
																list = {
																	hp = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_hp/hp",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_hp/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_hp/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_hp/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_hp/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_hp/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_atk",
																list = {
																	atk = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_atk/atk",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_atk/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_atk/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_atk/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_atk/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_atk/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_def",
																list = {
																	def = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_def/def",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_def/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_def/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_def/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_def/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_def/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_torpedo",
																list = {
																	torpedo = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_torpedo/torpedo",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_torpedo/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_torpedo/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_torpedo/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_torpedo/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_torpedo/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_miss",
																list = {
																	miss = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_miss/miss",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_miss/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_miss/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_miss/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_miss/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_miss/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_airdef",
																list = {
																	airdef = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_airdef/airdef",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_airdef/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_airdef/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_airdef/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_airdef/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_airdef/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_capacity",
																list = {
																	capacity = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_capacity/capacity",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_capacity/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_capacity/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_capacity/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_capacity/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_capacity/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_antisub",
																list = {
																	antisub = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_antisub/antisub",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_antisub/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_antisub/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_antisub/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_antisub/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_antisub/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_speed",
																list = {
																	speed = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_speed/speed",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_speed/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_speed/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_speed/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_speed/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_speed/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_radar",
																list = {
																	radar = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_radar/radar",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_radar/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_radar/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_radar/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_radar/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_radar/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_range",
																list = {
																	range = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_range/range",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_range/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_range/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_range/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_range/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_range/tip_icon_down",
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
																path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_luck",
																list = {
																	luck = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_luck/luck",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	attr_bg = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_luck/attr_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_bg_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_luck/attr_bg_down",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	attr_num = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_luck/attr_num",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	tip_icon = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_luck/tip_icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	tip_icon_down = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/detail/attr_luck/tip_icon_down",
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
													streng_btn = {
														path = "bg/middle_menu/remake_content/right/right_bg_2/streng_btn",
														list = {
															title = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/streng_btn/title",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															Image = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/streng_btn/Image",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															streng_btn_image = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/streng_btn/streng_btn_image",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															Image = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/streng_btn/Image",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															Image = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/streng_btn/Image",
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
															"ScaleButton"
														}
													},
													skill = {
														path = "bg/middle_menu/remake_content/right/right_bg_2/skill",
														list = {
															skill_stage = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_stage",
																list = {
																	skill_stage_text = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_stage/skill_stage_text",
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
																	"UnityEngine.UI.Text"
																}
															},
															skill_image = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_image",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															skill_level = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_level",
																list = {
																	left_level = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_level/left_level",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	arrow_img = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_level/arrow_img",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	right_level = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_level/right_level",
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
															skill_effect = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_effect",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															scrollview = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/skill/scrollview",
																list = {
																	content = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/skill/scrollview/content",
																		list = {
																			skill_desc = {
																				path = "bg/middle_menu/remake_content/right/right_bg_2/skill/scrollview/content/skill_desc",
																				list = {
																					skill_desc_2 = {
																						path = "bg/middle_menu/remake_content/right/right_bg_2/skill/scrollview/content/skill_desc/skill_desc_2",
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
															skill_name = {
																path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_name",
																list = {
																	title = {
																		path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_name/title",
																		list = {
																			title_1 = {
																				path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_name/title/title_1",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			title_2 = {
																				path = "bg/middle_menu/remake_content/right/right_bg_2/skill/skill_name/title/title_2",
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
							synthesis_interface = {
								path = "bg/middle_menu/synthesis_interface",
								list = {
									bg_1 = {
										path = "bg/middle_menu/synthesis_interface/bg_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_2 = {
										path = "bg/middle_menu/synthesis_interface/bg_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									left_all = {
										path = "bg/middle_menu/synthesis_interface/left_all",
										list = {
											right_material = {
												path = "bg/middle_menu/synthesis_interface/left_all/right_material",
												list = {
													ship_bg = {
														path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg",
														list = {
															mask_image = {
																path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/mask_image",
																list = {
																	ship = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/mask_image/ship",
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
															},
															cover_sprite = {
																path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/cover_sprite",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															name_layer = {
																path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/name_layer",
																list = {
																	name_level = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/name_layer/name_level",
																		list = {
																			name_level_1 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/name_layer/name_level/name_level_1",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			name_level_2 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/name_layer/name_level/name_level_2",
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
																	"UnityEngine.RectTransform"
																}
															},
															hp_layer = {
																path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/hp_layer",
																list = {
																	desc = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/hp_layer/desc",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	bar = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/hp_layer/bar",
																		list = {
																			amount = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/hp_layer/bar/amount",
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
																	txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/hp_layer/txt",
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
															info_layer = {
																path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer",
																list = {
																	info_bg = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/info_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	type_txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/type_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	level_txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/level_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	country_txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/country_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	star_layer = {
																		path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer",
																		list = {
																			star_1 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer/star_1",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_2 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer/star_2",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_3 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer/star_3",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_4 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer/star_4",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_5 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer/star_5",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_6 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer/star_6",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_7 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/info_layer/star_layer/star_7",
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
															btn = {
																path = "bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/btn",
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
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.CanvasGroup"
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
											left_material = {
												path = "bg/middle_menu/synthesis_interface/left_all/left_material",
												list = {
													ship_bg = {
														path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg",
														list = {
															mask_image = {
																path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/mask_image",
																list = {
																	ship = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/mask_image/ship",
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
															},
															cover_sprite = {
																path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/cover_sprite",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															name_layer = {
																path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/name_layer",
																list = {
																	name_level = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/name_layer/name_level",
																		list = {
																			name_level_1 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/name_layer/name_level/name_level_1",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			name_level_2 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/name_layer/name_level/name_level_2",
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
																	"UnityEngine.RectTransform"
																}
															},
															hp_layer = {
																path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/hp_layer",
																list = {
																	desc = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/hp_layer/desc",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	bar = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/hp_layer/bar",
																		list = {
																			amount = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/hp_layer/bar/amount",
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
																	txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/hp_layer/txt",
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
															info_layer = {
																path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer",
																list = {
																	info_bg = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/info_bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	type_txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/type_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	level_txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/level_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	country_txt = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/country_txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	star_layer = {
																		path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer",
																		list = {
																			star_1 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer/star_1",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_2 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer/star_2",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_3 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer/star_3",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_4 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer/star_4",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_5 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer/star_5",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_6 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer/star_6",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			star_7 = {
																				path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/info_layer/star_layer/star_7",
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
															btn = {
																path = "bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/btn",
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
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.CanvasGroup"
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
											bg = {
												path = "bg/middle_menu/synthesis_interface/left_all/bg",
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
									right_all = {
										path = "bg/middle_menu/synthesis_interface/right_all",
										list = {
											bg = {
												path = "bg/middle_menu/synthesis_interface/right_all/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											line_layer = {
												path = "bg/middle_menu/synthesis_interface/right_all/line_layer",
												list = {
													line_1 = {
														path = "bg/middle_menu/synthesis_interface/right_all/line_layer/line_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													line_2 = {
														path = "bg/middle_menu/synthesis_interface/right_all/line_layer/line_2",
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
											text_layer = {
												path = "bg/middle_menu/synthesis_interface/right_all/text_layer",
												list = {
													top_text = {
														path = "bg/middle_menu/synthesis_interface/right_all/text_layer/top_text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													middle_text = {
														path = "bg/middle_menu/synthesis_interface/right_all/text_layer/middle_text",
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
											star_layer_1 = {
												path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1",
												list = {
													bg = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_1 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/star_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/star_2",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/star_3",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/star_4",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/star_5",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/star_6",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_1/star_7",
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
											star_layer_2 = {
												path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2",
												list = {
													bg = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_1 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/star_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/star_2",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/star_3",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/star_4",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/star_5",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/star_6",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_2/star_7",
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
											star_layer_3 = {
												path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3",
												list = {
													bg = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_1 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/star_1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_2 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/star_2",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_3 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/star_3",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_4 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/star_4",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_5 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/star_5",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_6 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/star_6",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													star_7 = {
														path = "bg/middle_menu/synthesis_interface/right_all/star_layer_3/star_7",
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
											Image = {
												path = "bg/middle_menu/synthesis_interface/right_all/Image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											clear_btn = {
												path = "bg/middle_menu/synthesis_interface/right_all/clear_btn",
												list = {
													title = {
														path = "bg/middle_menu/synthesis_interface/right_all/clear_btn/title",
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
												path = "bg/middle_menu/synthesis_interface/right_all/streng_btn",
												list = {
													title = {
														path = "bg/middle_menu/synthesis_interface/right_all/streng_btn/title",
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
											type_layer = {
												path = "bg/middle_menu/synthesis_interface/right_all/type_layer",
												list = {
													type_1 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_1",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_1/Label",
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
													type_2 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_2",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_2/Label",
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
													type_3 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_3",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_3/Label",
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
													type_4 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_4",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_4/Label",
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
													type_5 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_5",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_5/Label",
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
													type_6 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_6",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_6/Label",
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
													type_7 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_7",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_7/Label",
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
													type_8 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_8",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_8/Label",
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
													type_9 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_9",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_9/Label",
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
													type_10 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_10",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_10/Label",
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
													type_11 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_11",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_11/Label",
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
													type_12 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_12",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_12/Label",
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
													type_13 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_13",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_13/Label",
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
													type_14 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_14",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_14/Label",
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
													type_15 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_15",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_15/Label",
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
													type_16 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_16",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_16/Label",
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
													type_17 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_17",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_17/Label",
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
													type_18 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_18",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_18/Label",
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
													type_19 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_19",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_19/Label",
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
													type_20 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_20",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_20/Label",
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
													type_21 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_21",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_21/Label",
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
													type_22 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_22",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_22/Label",
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
													type_23 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_23",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_23/Label",
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
													type_24 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_24",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_24/Label",
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
													type_25 = {
														path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_25",
														list = {
															Label = {
																path = "bg/middle_menu/synthesis_interface/right_all/type_layer/type_25/Label",
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
											button_ship_detail = {
												path = "bg/middle_menu/synthesis_interface/right_all/button_ship_detail",
												list = {
													Image_blue = {
														path = "bg/middle_menu/synthesis_interface/right_all/button_ship_detail/Image_blue",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													detail_icon = {
														path = "bg/middle_menu/synthesis_interface/right_all/button_ship_detail/detail_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													Text = {
														path = "bg/middle_menu/synthesis_interface/right_all/button_ship_detail/Text",
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
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UITweenSequence"
						}
					},
					bot_menu = {
						path = "bg/bot_menu",
						list = {
							tips = {
								path = "bg/bot_menu/tips",
								list = {
									line = {
										path = "bg/bot_menu/tips/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ui_shiphint = {
										path = "bg/bot_menu/tips/ui_shiphint",
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
					top_menu = {
						path = "bg/top_menu",
						list = {
							return_btn = {
								path = "bg/top_menu/return_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							line_left = {
								path = "bg/top_menu/line_left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_right = {
								path = "bg/top_menu/line_right",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_1 = {
								path = "bg/top_menu/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_2 = {
								path = "bg/top_menu/line_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_3 = {
								path = "bg/top_menu/line_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tab_toggle = {
								path = "bg/top_menu/tab_toggle",
								list = {
									tab_1 = {
										path = "bg/top_menu/tab_toggle/tab_1",
										list = {
											bg = {
												path = "bg/top_menu/tab_toggle/tab_1/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/tab_toggle/tab_1/bg/checkmark",
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
											sbt1 = {
												path = "bg/top_menu/tab_toggle/tab_1/sbt1",
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
									tab_3 = {
										path = "bg/top_menu/tab_toggle/tab_3",
										list = {
											bg = {
												path = "bg/top_menu/tab_toggle/tab_3/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/tab_toggle/tab_3/bg/checkmark",
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
											sbt3 = {
												path = "bg/top_menu/tab_toggle/tab_3/sbt3",
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
									tab_4 = {
										path = "bg/top_menu/tab_toggle/tab_4",
										list = {
											bg = {
												path = "bg/top_menu/tab_toggle/tab_4/bg",
												list = {
													checkmark = {
														path = "bg/top_menu/tab_toggle/tab_4/bg/checkmark",
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
											sbt4 = {
												path = "bg/top_menu/tab_toggle/tab_4/sbt4",
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
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					},
					abyss_title = {
						path = "bg/abyss_title",
						list = {
							leftline = {
								path = "bg/abyss_title/leftline",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							abyss_team_img = {
								path = "bg/abyss_title/abyss_team_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							rightline = {
								path = "bg/abyss_title/rightline",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							team_name = {
								path = "bg/abyss_title/team_name",
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
					type_layer = {
						path = "bg/type_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					sort_layer = {
						path = "bg/sort_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			}
		},
		click = {
			["bg/middle_menu/remake_content/left"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/middle_menu/remake_content/left/shipinfo/select_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/middle_menu/remake_content/left/ship_bg/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/middle_menu/synthesis_interface/left_all/right_material"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/middle_menu/synthesis_interface/left_all/left_material"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/middle_menu/synthesis_interface/right_all/button_ship_detail"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bg/middle_menu/remake_content/right/right_bg_2/streng_btn"] = {
				tp = "ScaleButton"
			},
			["bg/middle_menu/synthesis_interface/right_all/clear_btn"] = {
				tp = "ScaleButton"
			},
			["bg/middle_menu/synthesis_interface/right_all/streng_btn"] = {
				tp = "ScaleButton"
			},
			["bg/top_menu/return_btn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["bg/top_menu/tab_toggle/tab_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/tab_toggle/tab_3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/top_menu/tab_toggle/tab_4"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		click_and_long_click = {
			["bg/middle_menu/remake_content/left/shipinfo/ship/change_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["bg/middle_menu/synthesis_interface/left_all/right_material/ship_bg/btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["bg/middle_menu/synthesis_interface/left_all/left_material/ship_bg/btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

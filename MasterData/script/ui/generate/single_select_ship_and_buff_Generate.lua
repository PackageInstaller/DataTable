return {
	_rule_ = {
		none = {
			cover_sprite = {
				path = "cover_sprite",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg = {
				path = "bg",
				list = {
					select_border = {
						path = "bg/select_border",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					all_layer = {
						path = "bg/all_layer",
						list = {
							ship_layer = {
								path = "bg/all_layer/ship_layer",
								list = {
									ship_icon_layer = {
										path = "bg/all_layer/ship_layer/ship_icon_layer",
										list = {
											icon = {
												path = "bg/all_layer/ship_layer/ship_icon_layer/icon",
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
									love_layer = {
										path = "bg/all_layer/ship_layer/love_layer",
										list = {
											love = {
												path = "bg/all_layer/ship_layer/love_layer/love",
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
									ship_formation_type_layer = {
										path = "bg/all_layer/ship_layer/ship_formation_type_layer",
										list = {
											info_bg = {
												path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg",
												list = {
													level_layer = {
														path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer",
														list = {
															type_txt = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/type_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															level_txt = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/level_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															country_txt = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/country_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															lock_tag = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/lock_tag",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															ship_remake = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/ship_remake",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															star_layer = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer",
																list = {
																	star_1 = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer/star_1",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_2 = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer/star_2",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_3 = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer/star_3",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_4 = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer/star_4",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_5 = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer/star_5",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_6 = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer/star_6",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	star_7 = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/star_layer/star_7",
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
															line = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/line",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															hp_layer = {
																path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/hp_layer",
																list = {
																	full_img = {
																		path = "bg/all_layer/ship_layer/ship_formation_type_layer/info_bg/level_layer/hp_layer/full_img",
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
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									team_id_info = {
										path = "bg/all_layer/ship_layer/team_id_info",
										list = {
											team_id = {
												path = "bg/all_layer/ship_layer/team_id_info/team_id",
												list = {},
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
							buff_layer = {
								path = "bg/all_layer/buff_layer",
								list = {
									buff_icon_layer = {
										path = "bg/all_layer/buff_layer/buff_icon_layer",
										list = {
											icon = {
												path = "bg/all_layer/buff_layer/buff_icon_layer/icon",
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
									buff_formation_type_layer = {
										path = "bg/all_layer/buff_layer/buff_formation_type_layer",
										list = {
											info_bg = {
												path = "bg/all_layer/buff_layer/buff_formation_type_layer/info_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_mask = {
												path = "bg/all_layer/buff_layer/buff_formation_type_layer/buff_mask",
												list = {
													buff_txt = {
														path = "bg/all_layer/buff_layer/buff_formation_type_layer/buff_mask/buff_txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													buff_txt_2 = {
														path = "bg/all_layer/buff_layer/buff_formation_type_layer/buff_mask/buff_txt_2",
														list = {},
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
							info_layer = {
								path = "bg/all_layer/info_layer",
								list = {
									name_layer = {
										path = "bg/all_layer/info_layer/name_layer",
										list = {
											name_level_1 = {
												path = "bg/all_layer/info_layer/name_layer/name_level_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											name_level_2 = {
												path = "bg/all_layer/info_layer/name_layer/name_level_2",
												list = {},
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
							cover_layer = {
								path = "bg/all_layer/cover_layer",
								list = {
									cannot_select_sprite = {
										path = "bg/all_layer/cover_layer/cannot_select_sprite",
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
					cost_layer = {
						path = "bg/cost_layer",
						list = {
							coin_bg = {
								path = "bg/cost_layer/coin_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							split_image = {
								path = "bg/cost_layer/split_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							coin_image = {
								path = "bg/cost_layer/coin_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							cost_coin_count = {
								path = "bg/cost_layer/cost_coin_count",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							split_image_end = {
								path = "bg/cost_layer/split_image_end",
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
					select_layer = {
						path = "bg/select_layer",
						list = {
							select_sprite_1 = {
								path = "bg/select_layer/select_sprite_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							select_sprite_2 = {
								path = "bg/select_layer/select_sprite_2",
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
					select_btn = {
						path = "bg/select_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					buff_level_image = {
						path = "bg/buff_level_image",
						list = {
							buff_level_txt = {
								path = "bg/buff_level_image/buff_level_txt",
								list = {},
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
					ship_level_image = {
						path = "bg/ship_level_image",
						list = {
							ship_level_txt = {
								path = "bg/ship_level_image/ship_level_txt",
								list = {},
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
					no_select_mask = {
						path = "bg/no_select_mask",
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
					"UnityEngine.UI.Button"
				}
			}
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/select_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

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
			panel_bg = {
				path = "panel_bg",
				list = {
					title_bg = {
						path = "panel_bg/title_bg",
						list = {
							title_text = {
								path = "panel_bg/title_bg/title_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title_arrow = {
								path = "panel_bg/title_bg/title_arrow",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							close_btn = {
								path = "panel_bg/title_bg/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							line_bg = {
								path = "panel_bg/title_bg/line_bg",
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
					left = {
						path = "panel_bg/left",
						list = {
							team_name_mask = {
								path = "panel_bg/left/team_name_mask",
								list = {
									team_name = {
										path = "panel_bg/left/team_name_mask/team_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									team_name_2 = {
										path = "panel_bg/left/team_name_mask/team_name_2",
										list = {},
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
							team_level = {
								path = "panel_bg/left/team_level",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							team_logo_bg = {
								path = "panel_bg/left/team_logo_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							team_logo = {
								path = "panel_bg/left/team_logo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							win_txt = {
								path = "panel_bg/left/win_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							image_txt = {
								path = "panel_bg/left/image_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							win_rate = {
								path = "panel_bg/left/win_rate",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							image_rate = {
								path = "panel_bg/left/image_rate",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							Image = {
								path = "panel_bg/left/Image",
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
					right_bg = {
						path = "panel_bg/right_bg",
						list = {
							enemy_ship_item1 = {
								path = "panel_bg/right_bg/enemy_ship_item1",
								list = {
									bg = {
										path = "panel_bg/right_bg/enemy_ship_item1/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									show_layer = {
										path = "panel_bg/right_bg/enemy_ship_item1/show_layer",
										list = {
											off_set = {
												path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set",
												list = {
													ship_empty = {
														path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_empty",
														list = {
															bg = {
																path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_empty/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															frame = {
																path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_empty/frame",
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
													ship_item = {
														path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item",
														list = {
															item_icon_mask = {
																path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/item_icon_mask",
																list = {
																	quality = {
																		path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/item_icon_mask/quality",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	item_icon = {
																		path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/item_icon_mask/item_icon",
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
															ship_info = {
																path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info",
																list = {
																	bg = {
																		path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg",
																		list = {
																			type_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/type_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			level_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/level_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			country_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/country_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			star_layer = {
																				path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer",
																				list = {
																					star_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_2",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_3 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_3",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_4 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_4",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_5 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_5",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_6 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_6",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_7 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_7",
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
																				path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/bg/line",
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
																	hp_bar_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/hp_bar_bg",
																		list = {
																			hp_bar = {
																				path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/hp_bar_bg/hp_bar",
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
																	name_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/name_bg",
																		list = {
																			ship_name = {
																				path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/name_bg/ship_name",
																				list = {
																					ship_name_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Text",
																							"UnityEngine.UI.ContentSizeFitter"
																						}
																					},
																					ship_name_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_2",
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
															},
															click_btn = {
																path = "panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/click_btn",
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
															"UnityEngine.CanvasGroup"
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
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_item2 = {
								path = "panel_bg/right_bg/enemy_ship_item2",
								list = {
									bg = {
										path = "panel_bg/right_bg/enemy_ship_item2/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									show_layer = {
										path = "panel_bg/right_bg/enemy_ship_item2/show_layer",
										list = {
											off_set = {
												path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set",
												list = {
													ship_empty = {
														path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_empty",
														list = {
															bg = {
																path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_empty/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															frame = {
																path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_empty/frame",
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
													ship_item = {
														path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item",
														list = {
															item_icon_mask = {
																path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/item_icon_mask",
																list = {
																	quality = {
																		path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/item_icon_mask/quality",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	item_icon = {
																		path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/item_icon_mask/item_icon",
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
															ship_info = {
																path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info",
																list = {
																	bg = {
																		path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg",
																		list = {
																			type_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/type_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			level_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/level_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			country_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/country_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			star_layer = {
																				path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer",
																				list = {
																					star_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_2",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_3 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_3",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_4 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_4",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_5 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_5",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_6 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_6",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_7 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_7",
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
																				path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/bg/line",
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
																	hp_bar_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/hp_bar_bg",
																		list = {
																			hp_bar = {
																				path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/hp_bar_bg/hp_bar",
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
																	name_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/name_bg",
																		list = {
																			ship_name = {
																				path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/name_bg/ship_name",
																				list = {
																					ship_name_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Text",
																							"UnityEngine.UI.ContentSizeFitter"
																						}
																					},
																					ship_name_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_2",
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
															},
															click_btn = {
																path = "panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/click_btn",
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
															"UnityEngine.CanvasGroup"
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
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_item3 = {
								path = "panel_bg/right_bg/enemy_ship_item3",
								list = {
									bg = {
										path = "panel_bg/right_bg/enemy_ship_item3/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									show_layer = {
										path = "panel_bg/right_bg/enemy_ship_item3/show_layer",
										list = {
											off_set = {
												path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set",
												list = {
													ship_empty = {
														path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_empty",
														list = {
															bg = {
																path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_empty/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															frame = {
																path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_empty/frame",
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
													ship_item = {
														path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item",
														list = {
															item_icon_mask = {
																path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/item_icon_mask",
																list = {
																	quality = {
																		path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/item_icon_mask/quality",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	item_icon = {
																		path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/item_icon_mask/item_icon",
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
															ship_info = {
																path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info",
																list = {
																	bg = {
																		path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg",
																		list = {
																			type_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/type_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			level_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/level_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			country_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/country_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			star_layer = {
																				path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer",
																				list = {
																					star_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_2",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_3 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_3",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_4 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_4",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_5 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_5",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_6 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_6",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_7 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_7",
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
																				path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/bg/line",
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
																	hp_bar_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/hp_bar_bg",
																		list = {
																			hp_bar = {
																				path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/hp_bar_bg/hp_bar",
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
																	name_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/name_bg",
																		list = {
																			ship_name = {
																				path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/name_bg/ship_name",
																				list = {
																					ship_name_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Text",
																							"UnityEngine.UI.ContentSizeFitter"
																						}
																					},
																					ship_name_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_2",
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
															},
															click_btn = {
																path = "panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/click_btn",
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
															"UnityEngine.CanvasGroup"
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
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_item4 = {
								path = "panel_bg/right_bg/enemy_ship_item4",
								list = {
									bg = {
										path = "panel_bg/right_bg/enemy_ship_item4/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									show_layer = {
										path = "panel_bg/right_bg/enemy_ship_item4/show_layer",
										list = {
											off_set = {
												path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set",
												list = {
													ship_empty = {
														path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_empty",
														list = {
															bg = {
																path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_empty/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															frame = {
																path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_empty/frame",
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
													ship_item = {
														path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item",
														list = {
															item_icon_mask = {
																path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/item_icon_mask",
																list = {
																	quality = {
																		path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/item_icon_mask/quality",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	item_icon = {
																		path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/item_icon_mask/item_icon",
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
															ship_info = {
																path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info",
																list = {
																	bg = {
																		path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg",
																		list = {
																			type_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/type_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			level_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/level_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			country_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/country_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			star_layer = {
																				path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer",
																				list = {
																					star_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_2",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_3 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_3",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_4 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_4",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_5 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_5",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_6 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_6",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_7 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_7",
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
																				path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/bg/line",
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
																	hp_bar_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/hp_bar_bg",
																		list = {
																			hp_bar = {
																				path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/hp_bar_bg/hp_bar",
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
																	name_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/name_bg",
																		list = {
																			ship_name = {
																				path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/name_bg/ship_name",
																				list = {
																					ship_name_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Text",
																							"UnityEngine.UI.ContentSizeFitter"
																						}
																					},
																					ship_name_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_2",
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
															},
															click_btn = {
																path = "panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/click_btn",
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
															"UnityEngine.CanvasGroup"
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
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_item5 = {
								path = "panel_bg/right_bg/enemy_ship_item5",
								list = {
									bg = {
										path = "panel_bg/right_bg/enemy_ship_item5/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									show_layer = {
										path = "panel_bg/right_bg/enemy_ship_item5/show_layer",
										list = {
											off_set = {
												path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set",
												list = {
													ship_empty = {
														path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_empty",
														list = {
															bg = {
																path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_empty/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															frame = {
																path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_empty/frame",
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
													ship_item = {
														path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item",
														list = {
															item_icon_mask = {
																path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/item_icon_mask",
																list = {
																	quality = {
																		path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/item_icon_mask/quality",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	item_icon = {
																		path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/item_icon_mask/item_icon",
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
															ship_info = {
																path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info",
																list = {
																	bg = {
																		path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg",
																		list = {
																			type_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/type_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			level_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/level_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			country_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/country_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			star_layer = {
																				path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer",
																				list = {
																					star_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_2",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_3 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_3",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_4 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_4",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_5 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_5",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_6 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_6",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_7 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_7",
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
																				path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/bg/line",
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
																	hp_bar_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/hp_bar_bg",
																		list = {
																			hp_bar = {
																				path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/hp_bar_bg/hp_bar",
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
																	name_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/name_bg",
																		list = {
																			ship_name = {
																				path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/name_bg/ship_name",
																				list = {
																					ship_name_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Text",
																							"UnityEngine.UI.ContentSizeFitter"
																						}
																					},
																					ship_name_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_2",
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
															},
															click_btn = {
																path = "panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/click_btn",
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
															"UnityEngine.CanvasGroup"
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
											"UnityEngine.CanvasGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_item6 = {
								path = "panel_bg/right_bg/enemy_ship_item6",
								list = {
									bg = {
										path = "panel_bg/right_bg/enemy_ship_item6/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									show_layer = {
										path = "panel_bg/right_bg/enemy_ship_item6/show_layer",
										list = {
											off_set = {
												path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set",
												list = {
													ship_empty = {
														path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_empty",
														list = {
															bg = {
																path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_empty/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															frame = {
																path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_empty/frame",
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
													ship_item = {
														path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item",
														list = {
															item_icon_mask = {
																path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/item_icon_mask",
																list = {
																	quality = {
																		path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/item_icon_mask/quality",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	item_icon = {
																		path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/item_icon_mask/item_icon",
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
															ship_info = {
																path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info",
																list = {
																	bg = {
																		path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg",
																		list = {
																			type_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/type_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			level_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/level_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			country_txt = {
																				path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/country_txt",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			star_layer = {
																				path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer",
																				list = {
																					star_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_2",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_3 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_3",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_4 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_4",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_5 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_5",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_6 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_6",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Image"
																						}
																					},
																					star_7 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/star_layer/star_7",
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
																				path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/bg/line",
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
																	hp_bar_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/hp_bar_bg",
																		list = {
																			hp_bar = {
																				path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/hp_bar_bg/hp_bar",
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
																	name_bg = {
																		path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/name_bg",
																		list = {
																			ship_name = {
																				path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/name_bg/ship_name",
																				list = {
																					ship_name_1 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_1",
																						list = {},
																						component = {
																							"UnityEngine.RectTransform",
																							"UnityEngine.CanvasRenderer",
																							"UnityEngine.UI.Text",
																							"UnityEngine.UI.ContentSizeFitter"
																						}
																					},
																					ship_name_2 = {
																						path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/ship_info/name_bg/ship_name/ship_name_2",
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
															},
															click_btn = {
																path = "panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/click_btn",
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
															"UnityEngine.CanvasGroup"
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
											"UnityEngine.CanvasGroup"
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
							"UnityEngine.UI.HorizontalLayoutGroup"
						}
					},
					bottom_bg = {
						path = "panel_bg/bottom_bg",
						list = {
							title = {
								path = "panel_bg/bottom_bg/title",
								list = {},
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
					fight_btn = {
						path = "panel_bg/fight_btn",
						list = {
							txt = {
								path = "panel_bg/fight_btn/txt",
								list = {},
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
					update_bg = {
						path = "panel_bg/update_bg",
						list = {
							title = {
								path = "panel_bg/update_bg/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							update_count = {
								path = "panel_bg/update_bg/update_count",
								list = {},
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
					update_btn = {
						path = "panel_bg/update_btn",
						list = {
							updatetext = {
								path = "panel_bg/update_btn/updatetext",
								list = {},
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
					bottom_has_finished = {
						path = "panel_bg/bottom_has_finished",
						list = {
							finished_bg = {
								path = "panel_bg/bottom_has_finished/finished_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "panel_bg/bottom_has_finished/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							score_node = {
								path = "panel_bg/bottom_has_finished/score_node",
								list = {
									score = {
										path = "panel_bg/bottom_has_finished/score_node/score",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									title = {
										path = "panel_bg/bottom_has_finished/score_node/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.Transform"
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
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["panel_bg/fight_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["panel_bg/update_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["panel_bg/title_bg/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		click_and_long_click = {
			["panel_bg/right_bg/enemy_ship_item1/show_layer/off_set/ship_item/click_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["panel_bg/right_bg/enemy_ship_item2/show_layer/off_set/ship_item/click_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["panel_bg/right_bg/enemy_ship_item3/show_layer/off_set/ship_item/click_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["panel_bg/right_bg/enemy_ship_item4/show_layer/off_set/ship_item/click_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["panel_bg/right_bg/enemy_ship_item5/show_layer/off_set/ship_item/click_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["panel_bg/right_bg/enemy_ship_item6/show_layer/off_set/ship_item/click_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

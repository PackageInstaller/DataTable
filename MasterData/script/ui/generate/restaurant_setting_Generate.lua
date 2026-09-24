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
					title_txt = {
						path = "top/title_txt",
						list = {},
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
					black_line = {
						path = "top/black_line",
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
			cooker = {
				path = "cooker",
				list = {
					role = {
						path = "cooker/role",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					black_bg = {
						path = "cooker/black_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					blue_bg = {
						path = "cooker/blue_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					heart_bg = {
						path = "cooker/heart_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					marry_icon = {
						path = "cooker/marry_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					country_txt = {
						path = "cooker/country_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_txt = {
						path = "cooker/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					frame_xl = {
						path = "cooker/frame_xl",
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
					"UnityEngine.UI.Button",
					"UnityEngine.UI.Mask"
				}
			},
			my_menu = {
				path = "my_menu",
				list = {
					single_food_able_1 = {
						path = "my_menu/single_food_able_1",
						list = {
							food_quality = {
								path = "my_menu/single_food_able_1/food_quality",
								list = {
									food_small = {
										path = "my_menu/single_food_able_1/food_quality/food_small",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									food_cover = {
										path = "my_menu/single_food_able_1/food_quality/food_cover",
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
							progress = {
								path = "my_menu/single_food_able_1/progress",
								list = {
									level = {
										path = "my_menu/single_food_able_1/progress/level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "my_menu/single_food_able_1/progress/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_text = {
										path = "my_menu/single_food_able_1/progress/exp_text",
										list = {},
										component = {
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					single_food_able_2 = {
						path = "my_menu/single_food_able_2",
						list = {
							food_quality = {
								path = "my_menu/single_food_able_2/food_quality",
								list = {
									food_small = {
										path = "my_menu/single_food_able_2/food_quality/food_small",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									food_cover = {
										path = "my_menu/single_food_able_2/food_quality/food_cover",
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
							progress = {
								path = "my_menu/single_food_able_2/progress",
								list = {
									level = {
										path = "my_menu/single_food_able_2/progress/level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "my_menu/single_food_able_2/progress/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_text = {
										path = "my_menu/single_food_able_2/progress/exp_text",
										list = {},
										component = {
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					single_food_able_3 = {
						path = "my_menu/single_food_able_3",
						list = {
							food_quality = {
								path = "my_menu/single_food_able_3/food_quality",
								list = {
									food_small = {
										path = "my_menu/single_food_able_3/food_quality/food_small",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									food_cover = {
										path = "my_menu/single_food_able_3/food_quality/food_cover",
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
							progress = {
								path = "my_menu/single_food_able_3/progress",
								list = {
									level = {
										path = "my_menu/single_food_able_3/progress/level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "my_menu/single_food_able_3/progress/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_text = {
										path = "my_menu/single_food_able_3/progress/exp_text",
										list = {},
										component = {
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.GridLayoutGroup"
				}
			},
			menu_list = {
				path = "menu_list",
				list = {
					type_btn = {
						path = "menu_list/type_btn",
						list = {
							txt = {
								path = "menu_list/type_btn/txt",
								list = {},
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
					arrow_down = {
						path = "menu_list/arrow_down",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line = {
						path = "menu_list/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					left_line_bg = {
						path = "menu_list/left_line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					scrollview = {
						path = "menu_list/scrollview",
						list = {
							viewport = {
								path = "menu_list/scrollview/viewport",
								list = {
									content = {
										path = "menu_list/scrollview/viewport/content",
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
								path = "menu_list/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "menu_list/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "menu_list/scrollview/scrollbarvertical/slidingarea/handle",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			country_layer = {
				path = "country_layer",
				list = {
					toggle_group = {
						path = "country_layer/toggle_group",
						list = {
							all = {
								path = "country_layer/toggle_group/all",
								list = {
									Background = {
										path = "country_layer/toggle_group/all/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/all/Background/Checkmark",
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
										path = "country_layer/toggle_group/all/Label",
										list = {},
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
								path = "country_layer/toggle_group/J_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/J_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/J_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/J_country/Label",
										list = {},
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
								path = "country_layer/toggle_group/G_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/G_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/G_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/G_country/Label",
										list = {},
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
								path = "country_layer/toggle_group/E_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/E_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/E_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/E_country/Label",
										list = {},
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
								path = "country_layer/toggle_group/U_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/U_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/U_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/U_country/Label",
										list = {},
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
								path = "country_layer/toggle_group/I_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/I_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/I_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/I_country/Label",
										list = {},
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
								path = "country_layer/toggle_group/F_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/F_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/F_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/F_country/Label",
										list = {},
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
								path = "country_layer/toggle_group/S_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/S_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/S_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/S_country/Label",
										list = {},
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
								path = "country_layer/toggle_group/C_country",
								list = {
									Background = {
										path = "country_layer/toggle_group/C_country/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/C_country/Background/Checkmark",
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
										path = "country_layer/toggle_group/C_country/Label",
										list = {},
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
							general = {
								path = "country_layer/toggle_group/general",
								list = {
									Background = {
										path = "country_layer/toggle_group/general/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/general/Background/Checkmark",
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
										path = "country_layer/toggle_group/general/Label",
										list = {},
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
							get = {
								path = "country_layer/toggle_group/get",
								list = {
									Background = {
										path = "country_layer/toggle_group/get/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/get/Background/Checkmark",
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
										path = "country_layer/toggle_group/get/Label",
										list = {},
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
							not_get = {
								path = "country_layer/toggle_group/not_get",
								list = {
									Background = {
										path = "country_layer/toggle_group/not_get/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/not_get/Background/Checkmark",
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
										path = "country_layer/toggle_group/not_get/Label",
										list = {},
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
							can_set = {
								path = "country_layer/toggle_group/can_set",
								list = {
									Background = {
										path = "country_layer/toggle_group/can_set/Background",
										list = {
											Checkmark = {
												path = "country_layer/toggle_group/can_set/Background/Checkmark",
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
										path = "country_layer/toggle_group/can_set/Label",
										list = {},
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["restaurant_setting/country_layer/toggle_group/J_country/Background"] = "_control.country_layer.toggle_group.J_country.Background",
			["restaurant_setting/menu_list/scrollview/scrollbarvertical"] = "_control.menu_list.scrollview.scrollbarvertical",
			["restaurant_setting/menu_list/scrollview/viewport"] = "_control.menu_list.scrollview.viewport",
			["restaurant_setting/my_menu/single_food_able_1/food_quality/food_cover"] = "_control.my_menu.single_food_able_1.food_quality.food_cover",
			["restaurant_setting/menu_list/scrollview/scrollbarvertical/slidingarea"] = "_control.menu_list.scrollview.scrollbarvertical.slidingarea",
			["restaurant_setting/country_layer/toggle_group/J_country"] = "_control.country_layer.toggle_group.J_country",
			["restaurant_setting/my_menu/single_food_able_1/progress/line"] = "_control.my_menu.single_food_able_1.progress.line",
			["restaurant_setting/menu_list/line"] = "_control.menu_list.line",
			["restaurant_setting/cooker/marry_icon"] = "_control.cooker.marry_icon",
			["restaurant_setting/my_menu/single_food_able_2/food_quality/food_cover"] = "_control.my_menu.single_food_able_2.food_quality.food_cover",
			["restaurant_setting/top/return_btn"] = "_control.top.return_btn",
			["restaurant_setting/my_menu/single_food_able_3/progress/exp_text"] = "_control.my_menu.single_food_able_3.progress.exp_text",
			["restaurant_setting/my_menu/single_food_able_3/progress/line"] = "_control.my_menu.single_food_able_3.progress.line",
			["restaurant_setting/my_menu/single_food_able_3"] = "_control.my_menu.single_food_able_3",
			["restaurant_setting/my_menu/single_food_able_3/food_quality/food_cover"] = "_control.my_menu.single_food_able_3.food_quality.food_cover",
			["restaurant_setting/cooker/frame_xl"] = "_control.cooker.frame_xl",
			["restaurant_setting/my_menu/single_food_able_3/progress"] = "_control.my_menu.single_food_able_3.progress",
			["restaurant_setting/cooker"] = "_control.cooker",
			["restaurant_setting/country_layer/toggle_group/general/Background"] = "_control.country_layer.toggle_group.general.Background",
			["restaurant_setting/my_menu/single_food_able_1/progress"] = "_control.my_menu.single_food_able_1.progress",
			["restaurant_setting/my_menu/single_food_able_1/food_quality/food_small"] = "_control.my_menu.single_food_able_1.food_quality.food_small",
			["restaurant_setting/my_menu/single_food_able_1/progress/level"] = "_control.my_menu.single_food_able_1.progress.level",
			["restaurant_setting/my_menu"] = "_control.my_menu",
			["restaurant_setting/my_menu/single_food_able_2/food_quality/food_small"] = "_control.my_menu.single_food_able_2.food_quality.food_small",
			["restaurant_setting/my_menu/single_food_able_1/progress/exp_text"] = "_control.my_menu.single_food_able_1.progress.exp_text",
			["restaurant_setting/my_menu/single_food_able_2/food_quality"] = "_control.my_menu.single_food_able_2.food_quality",
			["restaurant_setting/menu_list/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.menu_list.scrollview.scrollbarvertical.slidingarea.handle",
			["restaurant_setting/my_menu/single_food_able_3/progress/level"] = "_control.my_menu.single_food_able_3.progress.level",
			["restaurant_setting/country_layer/toggle_group/general/Label"] = "_control.country_layer.toggle_group.general.Label",
			["restaurant_setting/country_layer/toggle_group/G_country/Label"] = "_control.country_layer.toggle_group.G_country.Label",
			["restaurant_setting/country_layer/toggle_group/G_country/Background"] = "_control.country_layer.toggle_group.G_country.Background",
			["restaurant_setting/country_layer/toggle_group/E_country"] = "_control.country_layer.toggle_group.E_country",
			["restaurant_setting/country_layer/toggle_group/E_country/Background"] = "_control.country_layer.toggle_group.E_country.Background",
			["restaurant_setting/country_layer/toggle_group/all/Background"] = "_control.country_layer.toggle_group.all.Background",
			["restaurant_setting/country_layer/toggle_group/E_country/Background/Checkmark"] = "_control.country_layer.toggle_group.E_country.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/E_country/Label"] = "_control.country_layer.toggle_group.E_country.Label",
			["restaurant_setting/country_layer/toggle_group/U_country"] = "_control.country_layer.toggle_group.U_country",
			["restaurant_setting/country_layer/toggle_group/U_country/Background"] = "_control.country_layer.toggle_group.U_country.Background",
			["restaurant_setting/country_layer/toggle_group/U_country/Background/Checkmark"] = "_control.country_layer.toggle_group.U_country.Background.Checkmark",
			["restaurant_setting/cooker/blue_bg"] = "_control.cooker.blue_bg",
			["restaurant_setting/country_layer/toggle_group/U_country/Label"] = "_control.country_layer.toggle_group.U_country.Label",
			["restaurant_setting/menu_list/scrollview/viewport/content"] = "_control.menu_list.scrollview.viewport.content",
			["restaurant_setting/country_layer/toggle_group/I_country"] = "_control.country_layer.toggle_group.I_country",
			["restaurant_setting/top"] = "_control.top",
			["restaurant_setting/country_layer/toggle_group/I_country/Background"] = "_control.country_layer.toggle_group.I_country.Background",
			["restaurant_setting/country_layer/toggle_group/I_country/Background/Checkmark"] = "_control.country_layer.toggle_group.I_country.Background.Checkmark",
			["restaurant_setting/cooker/heart_bg"] = "_control.cooker.heart_bg",
			["restaurant_setting/menu_list/scrollview"] = "_control.menu_list.scrollview",
			["restaurant_setting/menu_list/type_btn/txt"] = "_control.menu_list.type_btn.txt",
			["restaurant_setting/country_layer/toggle_group/I_country/Label"] = "_control.country_layer.toggle_group.I_country.Label",
			["restaurant_setting/country_layer/toggle_group/F_country"] = "_control.country_layer.toggle_group.F_country",
			["restaurant_setting/country_layer/toggle_group/F_country/Background"] = "_control.country_layer.toggle_group.F_country.Background",
			["restaurant_setting/cooker/country_txt"] = "_control.cooker.country_txt",
			["restaurant_setting/country_layer/toggle_group/F_country/Background/Checkmark"] = "_control.country_layer.toggle_group.F_country.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/F_country/Label"] = "_control.country_layer.toggle_group.F_country.Label",
			["restaurant_setting/country_layer/toggle_group/S_country"] = "_control.country_layer.toggle_group.S_country",
			["restaurant_setting/country_layer"] = "_control.country_layer",
			["restaurant_setting/country_layer/toggle_group/S_country/Background"] = "_control.country_layer.toggle_group.S_country.Background",
			["restaurant_setting/country_layer/toggle_group/S_country/Background/Checkmark"] = "_control.country_layer.toggle_group.S_country.Background.Checkmark",
			["restaurant_setting/bg"] = "_control.bg",
			["restaurant_setting/country_layer/toggle_group/S_country/Label"] = "_control.country_layer.toggle_group.S_country.Label",
			["restaurant_setting/top/black_line"] = "_control.top.black_line",
			["restaurant_setting/country_layer/toggle_group/C_country"] = "_control.country_layer.toggle_group.C_country",
			["restaurant_setting/menu_list/arrow_down"] = "_control.menu_list.arrow_down",
			["restaurant_setting/cooker/name_txt"] = "_control.cooker.name_txt",
			["restaurant_setting/my_menu/single_food_able_1"] = "_control.my_menu.single_food_able_1",
			["restaurant_setting/country_layer/toggle_group/C_country/Background"] = "_control.country_layer.toggle_group.C_country.Background",
			["restaurant_setting/country_layer/toggle_group/C_country/Background/Checkmark"] = "_control.country_layer.toggle_group.C_country.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/C_country/Label"] = "_control.country_layer.toggle_group.C_country.Label",
			["restaurant_setting/my_menu/single_food_able_3/food_quality/food_small"] = "_control.my_menu.single_food_able_3.food_quality.food_small",
			["restaurant_setting/country_layer/toggle_group"] = "_control.country_layer.toggle_group",
			["restaurant_setting/my_menu/single_food_able_3/food_quality"] = "_control.my_menu.single_food_able_3.food_quality",
			["restaurant_setting/menu_list"] = "_control.menu_list",
			["restaurant_setting/country_layer/toggle_group/not_get"] = "_control.country_layer.toggle_group.not_get",
			["restaurant_setting/country_layer/toggle_group/G_country/Background/Checkmark"] = "_control.country_layer.toggle_group.G_country.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/get"] = "_control.country_layer.toggle_group.get",
			["restaurant_setting/country_layer/toggle_group/get/Background"] = "_control.country_layer.toggle_group.get.Background",
			["restaurant_setting/country_layer/toggle_group/get/Background/Checkmark"] = "_control.country_layer.toggle_group.get.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/J_country/Background/Checkmark"] = "_control.country_layer.toggle_group.J_country.Background.Checkmark",
			["restaurant_setting/cooker/role"] = "_control.cooker.role",
			["restaurant_setting/country_layer/toggle_group/get/Label"] = "_control.country_layer.toggle_group.get.Label",
			["restaurant_setting/country_layer/toggle_group/general/Background/Checkmark"] = "_control.country_layer.toggle_group.general.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/not_get/Background"] = "_control.country_layer.toggle_group.not_get.Background",
			["restaurant_setting/my_menu/single_food_able_2"] = "_control.my_menu.single_food_able_2",
			["restaurant_setting/country_layer/toggle_group/not_get/Background/Checkmark"] = "_control.country_layer.toggle_group.not_get.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/all/Background/Checkmark"] = "_control.country_layer.toggle_group.all.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/not_get/Label"] = "_control.country_layer.toggle_group.not_get.Label",
			["restaurant_setting/country_layer/toggle_group/can_set"] = "_control.country_layer.toggle_group.can_set",
			["restaurant_setting/country_layer/toggle_group/all/Label"] = "_control.country_layer.toggle_group.all.Label",
			["restaurant_setting/my_menu/single_food_able_1/food_quality"] = "_control.my_menu.single_food_able_1.food_quality",
			["restaurant_setting/country_layer/toggle_group/can_set/Background"] = "_control.country_layer.toggle_group.can_set.Background",
			["restaurant_setting/country_layer/toggle_group/can_set/Background/Checkmark"] = "_control.country_layer.toggle_group.can_set.Background.Checkmark",
			["restaurant_setting/country_layer/toggle_group/can_set/Label"] = "_control.country_layer.toggle_group.can_set.Label",
			["restaurant_setting/country_layer/toggle_group/G_country"] = "_control.country_layer.toggle_group.G_country",
			["restaurant_setting/my_menu/single_food_able_2/progress/level"] = "_control.my_menu.single_food_able_2.progress.level",
			["restaurant_setting/country_layer/toggle_group/general"] = "_control.country_layer.toggle_group.general",
			["restaurant_setting/menu_list/left_line_bg"] = "_control.menu_list.left_line_bg",
			["restaurant_setting/my_menu/single_food_able_2/progress/exp_text"] = "_control.my_menu.single_food_able_2.progress.exp_text",
			["restaurant_setting/cooker/black_bg"] = "_control.cooker.black_bg",
			["restaurant_setting/country_layer/toggle_group/J_country/Label"] = "_control.country_layer.toggle_group.J_country.Label",
			["restaurant_setting/country_layer/toggle_group/all"] = "_control.country_layer.toggle_group.all",
			["restaurant_setting/my_menu/single_food_able_2/progress/line"] = "_control.my_menu.single_food_able_2.progress.line",
			["restaurant_setting/top/title_txt"] = "_control.top.title_txt",
			["restaurant_setting/my_menu/single_food_able_2/progress"] = "_control.my_menu.single_food_able_2.progress",
			["restaurant_setting/top/line_bg"] = "_control.top.line_bg",
			["restaurant_setting/menu_list/type_btn"] = "_control.menu_list.type_btn"
		},
		click = {
			["top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			cooker = {
				tp = "UnityEngine.UI.Button"
			},
			["my_menu/single_food_able_1/food_quality"] = {
				tp = "UnityEngine.UI.Button"
			},
			["my_menu/single_food_able_2/food_quality"] = {
				tp = "UnityEngine.UI.Button"
			},
			["my_menu/single_food_able_3/food_quality"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_list/type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			country_layer = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["country_layer/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/J_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/G_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/E_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/U_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/I_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/F_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/S_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/C_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/general"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/get"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/not_get"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["country_layer/toggle_group/can_set"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

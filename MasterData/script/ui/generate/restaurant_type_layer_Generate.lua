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
			menu_list = {
				path = "menu_list",
				list = {
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
					},
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
			["restaurant_type_layer/country_layer/toggle_group/C_country/Background/Checkmark"] = "_control.country_layer.toggle_group.C_country.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/G_country/Label"] = "_control.country_layer.toggle_group.G_country.Label",
			["restaurant_type_layer/menu_list/type_btn"] = "_control.menu_list.type_btn",
			["restaurant_type_layer/menu_list/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.menu_list.scrollview.scrollbarvertical.slidingarea.handle",
			["restaurant_type_layer/menu_list/arrow_down"] = "_control.menu_list.arrow_down",
			["restaurant_type_layer/country_layer/toggle_group/S_country/Background/Checkmark"] = "_control.country_layer.toggle_group.S_country.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/S_country/Background"] = "_control.country_layer.toggle_group.S_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/S_country"] = "_control.country_layer.toggle_group.S_country",
			["restaurant_type_layer/country_layer/toggle_group/F_country/Label"] = "_control.country_layer.toggle_group.F_country.Label",
			["restaurant_type_layer/country_layer/toggle_group/F_country/Background"] = "_control.country_layer.toggle_group.F_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/F_country"] = "_control.country_layer.toggle_group.F_country",
			["restaurant_type_layer/country_layer/toggle_group/I_country/Label"] = "_control.country_layer.toggle_group.I_country.Label",
			["restaurant_type_layer/country_layer/toggle_group/all/Label"] = "_control.country_layer.toggle_group.all.Label",
			["restaurant_type_layer/country_layer/toggle_group/not_get"] = "_control.country_layer.toggle_group.not_get",
			["restaurant_type_layer/country_layer/toggle_group/G_country/Background/Checkmark"] = "_control.country_layer.toggle_group.G_country.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/I_country/Background"] = "_control.country_layer.toggle_group.I_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/all"] = "_control.country_layer.toggle_group.all",
			["restaurant_type_layer/menu_list/scrollview/scrollbarvertical"] = "_control.menu_list.scrollview.scrollbarvertical",
			["restaurant_type_layer/country_layer/toggle_group/U_country/Label"] = "_control.country_layer.toggle_group.U_country.Label",
			["restaurant_type_layer/country_layer/toggle_group/U_country/Background/Checkmark"] = "_control.country_layer.toggle_group.U_country.Background.Checkmark",
			["restaurant_type_layer/menu_list/scrollview"] = "_control.menu_list.scrollview",
			["restaurant_type_layer/country_layer/toggle_group/all/Background"] = "_control.country_layer.toggle_group.all.Background",
			["restaurant_type_layer/country_layer/toggle_group/I_country"] = "_control.country_layer.toggle_group.I_country",
			["restaurant_type_layer/country_layer/toggle_group/U_country/Background"] = "_control.country_layer.toggle_group.U_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/U_country"] = "_control.country_layer.toggle_group.U_country",
			["restaurant_type_layer/country_layer/toggle_group/E_country/Label"] = "_control.country_layer.toggle_group.E_country.Label",
			["restaurant_type_layer/country_layer/toggle_group/E_country/Background/Checkmark"] = "_control.country_layer.toggle_group.E_country.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/E_country/Background"] = "_control.country_layer.toggle_group.E_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/E_country"] = "_control.country_layer.toggle_group.E_country",
			["restaurant_type_layer/country_layer/toggle_group/J_country/Background/Checkmark"] = "_control.country_layer.toggle_group.J_country.Background.Checkmark",
			["restaurant_type_layer/top/return_btn"] = "_control.top.return_btn",
			["restaurant_type_layer/country_layer/toggle_group/G_country"] = "_control.country_layer.toggle_group.G_country",
			["restaurant_type_layer/country_layer/toggle_group/F_country/Background/Checkmark"] = "_control.country_layer.toggle_group.F_country.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/J_country"] = "_control.country_layer.toggle_group.J_country",
			["restaurant_type_layer/country_layer/toggle_group/get/Label"] = "_control.country_layer.toggle_group.get.Label",
			["restaurant_type_layer/country_layer/toggle_group"] = "_control.country_layer.toggle_group",
			["restaurant_type_layer/menu_list/line"] = "_control.menu_list.line",
			["restaurant_type_layer/country_layer/toggle_group/all/Background/Checkmark"] = "_control.country_layer.toggle_group.all.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/get"] = "_control.country_layer.toggle_group.get",
			["restaurant_type_layer/country_layer/toggle_group/S_country/Label"] = "_control.country_layer.toggle_group.S_country.Label",
			["restaurant_type_layer/bg"] = "_control.bg",
			["restaurant_type_layer/country_layer/toggle_group/general/Label"] = "_control.country_layer.toggle_group.general.Label",
			["restaurant_type_layer/country_layer/toggle_group/G_country/Background"] = "_control.country_layer.toggle_group.G_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/J_country/Label"] = "_control.country_layer.toggle_group.J_country.Label",
			["restaurant_type_layer/country_layer/toggle_group/J_country/Background"] = "_control.country_layer.toggle_group.J_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/I_country/Background/Checkmark"] = "_control.country_layer.toggle_group.I_country.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/get/Background/Checkmark"] = "_control.country_layer.toggle_group.get.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/not_get/Background"] = "_control.country_layer.toggle_group.not_get.Background",
			["restaurant_type_layer/country_layer/toggle_group/not_get/Background/Checkmark"] = "_control.country_layer.toggle_group.not_get.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/not_get/Label"] = "_control.country_layer.toggle_group.not_get.Label",
			["restaurant_type_layer/country_layer/toggle_group/can_set/Background"] = "_control.country_layer.toggle_group.can_set.Background",
			["restaurant_type_layer/country_layer/toggle_group/can_set/Background/Checkmark"] = "_control.country_layer.toggle_group.can_set.Background.Checkmark",
			["restaurant_type_layer/country_layer/toggle_group/can_set/Label"] = "_control.country_layer.toggle_group.can_set.Label",
			["restaurant_type_layer/country_layer/toggle_group/general"] = "_control.country_layer.toggle_group.general",
			["restaurant_type_layer/menu_list/scrollview/viewport"] = "_control.menu_list.scrollview.viewport",
			["restaurant_type_layer/country_layer/toggle_group/C_country"] = "_control.country_layer.toggle_group.C_country",
			["restaurant_type_layer/menu_list"] = "_control.menu_list",
			["restaurant_type_layer/country_layer/toggle_group/get/Background"] = "_control.country_layer.toggle_group.get.Background",
			["restaurant_type_layer/country_layer/toggle_group/can_set"] = "_control.country_layer.toggle_group.can_set",
			["restaurant_type_layer/top/line_bg"] = "_control.top.line_bg",
			["restaurant_type_layer/top/black_line"] = "_control.top.black_line",
			["restaurant_type_layer/country_layer/toggle_group/general/Background"] = "_control.country_layer.toggle_group.general.Background",
			["restaurant_type_layer/top/title_txt"] = "_control.top.title_txt",
			["restaurant_type_layer/menu_list/scrollview/scrollbarvertical/slidingarea"] = "_control.menu_list.scrollview.scrollbarvertical.slidingarea",
			["restaurant_type_layer/menu_list/left_line_bg"] = "_control.menu_list.left_line_bg",
			["restaurant_type_layer/country_layer"] = "_control.country_layer",
			["restaurant_type_layer/country_layer/toggle_group/general/Background/Checkmark"] = "_control.country_layer.toggle_group.general.Background.Checkmark",
			["restaurant_type_layer/menu_list/scrollview/viewport/content"] = "_control.menu_list.scrollview.viewport.content",
			["restaurant_type_layer/menu_list/type_btn/txt"] = "_control.menu_list.type_btn.txt",
			["restaurant_type_layer/country_layer/toggle_group/C_country/Background"] = "_control.country_layer.toggle_group.C_country.Background",
			["restaurant_type_layer/country_layer/toggle_group/C_country/Label"] = "_control.country_layer.toggle_group.C_country.Label",
			["restaurant_type_layer/top"] = "_control.top"
		},
		click = {
			["top/return_btn"] = {
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

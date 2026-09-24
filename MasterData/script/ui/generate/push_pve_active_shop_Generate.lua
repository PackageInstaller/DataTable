return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					bg_container = {
						path = "bg/bg_container",
						list = {
							bg_white = {
								path = "bg/bg_container/bg_white",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mask_bg = {
								path = "bg/bg_container/mask_bg",
								list = {
									bg_blue_top = {
										path = "bg/bg_container/mask_bg/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top2 = {
										path = "bg/bg_container/mask_bg/bg_blue_top2",
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
							bg_blue_top3 = {
								path = "bg/bg_container/bg_blue_top3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_line2 = {
								path = "bg/bg_container/bg_line2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "bg/bg_container/title",
								list = {
									three_point = {
										path = "bg/bg_container/title/three_point",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					close_btn = {
						path = "bg/close_btn",
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
					"UnityEngine.UI.Image"
				}
			},
			buff_content = {
				path = "buff_content",
				list = {
					pve_active_buff_cell_1 = {
						path = "buff_content/pve_active_buff_cell_1",
						list = {
							buff_bg = {
								path = "buff_content/pve_active_buff_cell_1/buff_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buff_image = {
								path = "buff_content/pve_active_buff_cell_1/buff_image",
								list = {
									buff_lv = {
										path = "buff_content/pve_active_buff_cell_1/buff_image/buff_lv",
										list = {},
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
							buff_desc = {
								path = "buff_content/pve_active_buff_cell_1/buff_desc",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							buff_button = {
								path = "buff_content/pve_active_buff_cell_1/buff_button",
								list = {
									coin_image = {
										path = "buff_content/pve_active_buff_cell_1/buff_button/coin_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									cost_num = {
										path = "buff_content/pve_active_buff_cell_1/buff_button/cost_num",
										list = {},
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
							already_buy = {
								path = "buff_content/pve_active_buff_cell_1/already_buy",
								list = {
									already_txt = {
										path = "buff_content/pve_active_buff_cell_1/already_buy/already_txt",
										list = {},
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
					pve_active_buff_cell_2 = {
						path = "buff_content/pve_active_buff_cell_2",
						list = {
							buff_bg = {
								path = "buff_content/pve_active_buff_cell_2/buff_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buff_image = {
								path = "buff_content/pve_active_buff_cell_2/buff_image",
								list = {
									buff_lv = {
										path = "buff_content/pve_active_buff_cell_2/buff_image/buff_lv",
										list = {},
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
							buff_desc = {
								path = "buff_content/pve_active_buff_cell_2/buff_desc",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							buff_button = {
								path = "buff_content/pve_active_buff_cell_2/buff_button",
								list = {
									coin_image = {
										path = "buff_content/pve_active_buff_cell_2/buff_button/coin_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									cost_num = {
										path = "buff_content/pve_active_buff_cell_2/buff_button/cost_num",
										list = {},
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
							already_buy = {
								path = "buff_content/pve_active_buff_cell_2/already_buy",
								list = {
									already_txt = {
										path = "buff_content/pve_active_buff_cell_2/already_buy/already_txt",
										list = {},
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
					pve_active_buff_cell_3 = {
						path = "buff_content/pve_active_buff_cell_3",
						list = {
							buff_bg = {
								path = "buff_content/pve_active_buff_cell_3/buff_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buff_image = {
								path = "buff_content/pve_active_buff_cell_3/buff_image",
								list = {
									buff_lv = {
										path = "buff_content/pve_active_buff_cell_3/buff_image/buff_lv",
										list = {},
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
							buff_desc = {
								path = "buff_content/pve_active_buff_cell_3/buff_desc",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							buff_button = {
								path = "buff_content/pve_active_buff_cell_3/buff_button",
								list = {
									coin_image = {
										path = "buff_content/pve_active_buff_cell_3/buff_button/coin_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									cost_num = {
										path = "buff_content/pve_active_buff_cell_3/buff_button/cost_num",
										list = {},
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
							already_buy = {
								path = "buff_content/pve_active_buff_cell_3/already_buy",
								list = {
									already_txt = {
										path = "buff_content/pve_active_buff_cell_3/already_buy/already_txt",
										list = {},
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
					pve_active_buff_cell_4 = {
						path = "buff_content/pve_active_buff_cell_4",
						list = {
							buff_bg = {
								path = "buff_content/pve_active_buff_cell_4/buff_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buff_image = {
								path = "buff_content/pve_active_buff_cell_4/buff_image",
								list = {
									buff_lv = {
										path = "buff_content/pve_active_buff_cell_4/buff_image/buff_lv",
										list = {},
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
							buff_desc = {
								path = "buff_content/pve_active_buff_cell_4/buff_desc",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							buff_button = {
								path = "buff_content/pve_active_buff_cell_4/buff_button",
								list = {
									coin_image = {
										path = "buff_content/pve_active_buff_cell_4/buff_button/coin_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									cost_num = {
										path = "buff_content/pve_active_buff_cell_4/buff_button/cost_num",
										list = {},
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
							already_buy = {
								path = "buff_content/pve_active_buff_cell_4/already_buy",
								list = {
									already_txt = {
										path = "buff_content/pve_active_buff_cell_4/already_buy/already_txt",
										list = {},
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
					pve_active_buff_cell_5 = {
						path = "buff_content/pve_active_buff_cell_5",
						list = {
							buff_bg = {
								path = "buff_content/pve_active_buff_cell_5/buff_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buff_image = {
								path = "buff_content/pve_active_buff_cell_5/buff_image",
								list = {
									buff_lv = {
										path = "buff_content/pve_active_buff_cell_5/buff_image/buff_lv",
										list = {},
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
							buff_desc = {
								path = "buff_content/pve_active_buff_cell_5/buff_desc",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							buff_button = {
								path = "buff_content/pve_active_buff_cell_5/buff_button",
								list = {
									coin_image = {
										path = "buff_content/pve_active_buff_cell_5/buff_button/coin_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									cost_num = {
										path = "buff_content/pve_active_buff_cell_5/buff_button/cost_num",
										list = {},
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
							already_buy = {
								path = "buff_content/pve_active_buff_cell_5/already_buy",
								list = {
									already_txt = {
										path = "buff_content/pve_active_buff_cell_5/already_buy/already_txt",
										list = {},
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
					pve_active_buff_cell_6 = {
						path = "buff_content/pve_active_buff_cell_6",
						list = {
							buff_bg = {
								path = "buff_content/pve_active_buff_cell_6/buff_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buff_image = {
								path = "buff_content/pve_active_buff_cell_6/buff_image",
								list = {
									buff_lv = {
										path = "buff_content/pve_active_buff_cell_6/buff_image/buff_lv",
										list = {},
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
							buff_desc = {
								path = "buff_content/pve_active_buff_cell_6/buff_desc",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							buff_button = {
								path = "buff_content/pve_active_buff_cell_6/buff_button",
								list = {
									coin_image = {
										path = "buff_content/pve_active_buff_cell_6/buff_button/coin_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									cost_num = {
										path = "buff_content/pve_active_buff_cell_6/buff_button/cost_num",
										list = {},
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
							already_buy = {
								path = "buff_content/pve_active_buff_cell_6/already_buy",
								list = {
									already_txt = {
										path = "buff_content/pve_active_buff_cell_6/already_buy/already_txt",
										list = {},
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
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			point_bg = {
				path = "point_bg",
				list = {
					point_image = {
						path = "point_bg/point_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					point_num = {
						path = "point_bg/point_num",
						list = {},
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
			limit_bg = {
				path = "limit_bg",
				list = {
					limit_desc = {
						path = "limit_bg/limit_desc",
						list = {},
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
		click = {
			["bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_content/pve_active_buff_cell_1/buff_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_content/pve_active_buff_cell_2/buff_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_content/pve_active_buff_cell_3/buff_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_content/pve_active_buff_cell_4/buff_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_content/pve_active_buff_cell_5/buff_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_content/pve_active_buff_cell_6/buff_button"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

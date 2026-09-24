return {
	_rule_ = {
		none = {
			mask = {
				path = "mask",
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
					top_line = {
						path = "bg/top_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top_bule_image = {
						path = "bg/top_bule_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top_piont_image = {
						path = "bg/top_piont_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top_text = {
						path = "bg/top_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					top_button_close = {
						path = "bg/top_button_close",
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
			left_button_layer = {
				path = "left_button_layer",
				list = {
					button_talk = {
						path = "left_button_layer/button_talk",
						list = {
							Text = {
								path = "left_button_layer/button_talk/Text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							button_cover = {
								path = "left_button_layer/button_talk/button_cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							button_select = {
								path = "left_button_layer/button_talk/button_select",
								list = {
									select_frame = {
										path = "left_button_layer/button_talk/button_select/select_frame",
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
							btn = {
								path = "left_button_layer/button_talk/btn",
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
					button_detail = {
						path = "left_button_layer/button_detail",
						list = {
							Text = {
								path = "left_button_layer/button_detail/Text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							button_cover = {
								path = "left_button_layer/button_detail/button_cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							button_select = {
								path = "left_button_layer/button_detail/button_select",
								list = {
									select_frame = {
										path = "left_button_layer/button_detail/button_select/select_frame",
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
							tbn = {
								path = "left_button_layer/button_detail/tbn",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			right_ship_layer = {
				path = "right_ship_layer",
				list = {
					all_ship = {
						path = "right_ship_layer/all_ship",
						list = {
							Scrollbar = {
								path = "right_ship_layer/all_ship/Scrollbar",
								list = {
									["Sliding Area"] = {
										path = "right_ship_layer/all_ship/Scrollbar/Sliding Area",
										list = {
											Handle = {
												path = "right_ship_layer/all_ship/Scrollbar/Sliding Area/Handle",
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
							},
							Viewport = {
								path = "right_ship_layer/all_ship/Viewport",
								list = {
									edge_mask = {
										path = "right_ship_layer/all_ship/Viewport/edge_mask",
										list = {
											Content = {
												path = "right_ship_layer/all_ship/Viewport/edge_mask/Content",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"EndlessScrollView",
													"UnityEngine.CanvasRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Mask"
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
					top_title = {
						path = "right_ship_layer/top_title",
						list = {
							rarity = {
								path = "right_ship_layer/top_title/rarity",
								list = {
									Text = {
										path = "right_ship_layer/top_title/rarity/Text",
										list = {},
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
							flesh = {
								path = "right_ship_layer/top_title/flesh",
								list = {
									Text = {
										path = "right_ship_layer/top_title/flesh/Text",
										list = {},
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
							type = {
								path = "right_ship_layer/top_title/type",
								list = {
									Text = {
										path = "right_ship_layer/top_title/type/Text",
										list = {},
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
							detail = {
								path = "right_ship_layer/top_title/detail",
								list = {
									Text = {
										path = "right_ship_layer/top_title/detail/Text",
										list = {},
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
					talk_text = {
						path = "right_ship_layer/talk_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					top_button_layer = {
						path = "right_ship_layer/top_button_layer",
						list = {
							rarity_button = {
								path = "right_ship_layer/top_button_layer/rarity_button",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							flesh_button = {
								path = "right_ship_layer/top_button_layer/flesh_button",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							type_button = {
								path = "right_ship_layer/top_button_layer/type_button",
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
			["bg/top_button_close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_button_layer/button_talk/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_button_layer/button_detail/tbn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_ship_layer/top_button_layer/rarity_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_ship_layer/top_button_layer/flesh_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_ship_layer/top_button_layer/type_button"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

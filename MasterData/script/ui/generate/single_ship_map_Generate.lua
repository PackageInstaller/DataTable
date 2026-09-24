return {
	_rule_ = {
		none = {
			not_open_bg = {
				path = "not_open_bg",
				list = {
					txt = {
						path = "not_open_bg/txt",
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
			all_layer = {
				path = "all_layer",
				list = {
					icon_layer = {
						path = "all_layer/icon_layer",
						list = {
							icon = {
								path = "all_layer/icon_layer/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_not_get = {
								path = "all_layer/icon_layer/icon_not_get",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							clothes_bg = {
								path = "all_layer/icon_layer/clothes_bg",
								list = {
									clothes = {
										path = "all_layer/icon_layer/clothes_bg/clothes",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									clothes_num_txt = {
										path = "all_layer/icon_layer/clothes_bg/clothes_num_txt",
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
							ship_remake = {
								path = "all_layer/icon_layer/ship_remake",
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
					info_layer = {
						path = "all_layer/info_layer",
						list = {
							info_bg = {
								path = "all_layer/info_layer/info_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_bg = {
								path = "all_layer/info_layer/line_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_txt = {
								path = "all_layer/info_layer/type_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							country_txt = {
								path = "all_layer/info_layer/country_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							name_level = {
								path = "all_layer/info_layer/name_level",
								list = {
									name_level_1 = {
										path = "all_layer/info_layer/name_level/name_level_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									name_level_2 = {
										path = "all_layer/info_layer/name_level/name_level_2",
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
									"TextHorizonScroller",
									"UnityEngine.UI.Mask"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					level_layer = {
						path = "all_layer/level_layer",
						list = {
							level_txt = {
								path = "all_layer/level_layer/level_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							star_layer = {
								path = "all_layer/level_layer/star_layer",
								list = {
									star_7 = {
										path = "all_layer/level_layer/star_layer/star_7",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_6 = {
										path = "all_layer/level_layer/star_layer/star_6",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_5 = {
										path = "all_layer/level_layer/star_layer/star_5",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_4 = {
										path = "all_layer/level_layer/star_layer/star_4",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_3 = {
										path = "all_layer/level_layer/star_layer/star_3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_2 = {
										path = "all_layer/level_layer/star_layer/star_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star_1 = {
										path = "all_layer/level_layer/star_layer/star_1",
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
					cover_sprite = {
						path = "all_layer/cover_sprite",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			not_get_bg = {
				path = "not_get_bg",
				list = {
					txt = {
						path = "not_get_bg/txt",
						list = {},
						component = {
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
		call_node_list = {
			["single_ship_map/all_layer/icon_layer/clothes_bg/clothes"] = "_control.all_layer.icon_layer.clothes_bg.clothes",
			["single_ship_map/all_layer/level_layer/star_layer/star_2"] = "_control.all_layer.level_layer.star_layer.star_2",
			["single_ship_map/not_open_bg/txt"] = "_control.not_open_bg.txt",
			["single_ship_map/all_layer/info_layer"] = "_control.all_layer.info_layer",
			["single_ship_map/all_layer/info_layer/name_level/name_level_1"] = "_control.all_layer.info_layer.name_level.name_level_1",
			["single_ship_map/all_layer/info_layer/name_level/name_level_2"] = "_control.all_layer.info_layer.name_level.name_level_2",
			["single_ship_map/all_layer/level_layer/level_txt"] = "_control.all_layer.level_layer.level_txt",
			["single_ship_map/all_layer/level_layer/star_layer/star_5"] = "_control.all_layer.level_layer.star_layer.star_5",
			["single_ship_map/all_layer/cover_sprite"] = "_control.all_layer.cover_sprite",
			["single_ship_map/all_layer/level_layer/star_layer/star_6"] = "_control.all_layer.level_layer.star_layer.star_6",
			["single_ship_map/all_layer/level_layer/star_layer"] = "_control.all_layer.level_layer.star_layer",
			["single_ship_map/all_layer/info_layer/info_bg"] = "_control.all_layer.info_layer.info_bg",
			["single_ship_map/all_layer"] = "_control.all_layer",
			["single_ship_map/all_layer/level_layer/star_layer/star_4"] = "_control.all_layer.level_layer.star_layer.star_4",
			["single_ship_map/all_layer/icon_layer"] = "_control.all_layer.icon_layer",
			["single_ship_map/all_layer/level_layer"] = "_control.all_layer.level_layer",
			["single_ship_map/all_layer/icon_layer/clothes_bg"] = "_control.all_layer.icon_layer.clothes_bg",
			["single_ship_map/all_layer/info_layer/type_txt"] = "_control.all_layer.info_layer.type_txt",
			["single_ship_map/all_layer/level_layer/star_layer/star_1"] = "_control.all_layer.level_layer.star_layer.star_1",
			["single_ship_map/all_layer/info_layer/country_txt"] = "_control.all_layer.info_layer.country_txt",
			["single_ship_map/all_layer/level_layer/star_layer/star_7"] = "_control.all_layer.level_layer.star_layer.star_7",
			["single_ship_map/all_layer/info_layer/line_bg"] = "_control.all_layer.info_layer.line_bg",
			["single_ship_map/not_get_bg"] = "_control.not_get_bg",
			["single_ship_map/all_layer/icon_layer/icon"] = "_control.all_layer.icon_layer.icon",
			["single_ship_map/all_layer/info_layer/name_level"] = "_control.all_layer.info_layer.name_level",
			["single_ship_map/all_layer/icon_layer/icon_not_get"] = "_control.all_layer.icon_layer.icon_not_get",
			["single_ship_map/not_get_bg/txt"] = "_control.not_get_bg.txt",
			["single_ship_map/all_layer/level_layer/star_layer/star_3"] = "_control.all_layer.level_layer.star_layer.star_3",
			["single_ship_map/not_open_bg"] = "_control.not_open_bg",
			["single_ship_map/all_layer/icon_layer/ship_remake"] = "_control.all_layer.icon_layer.ship_remake",
			["single_ship_map/all_layer/icon_layer/clothes_bg/clothes_num_txt"] = "_control.all_layer.icon_layer.clothes_bg.clothes_num_txt"
		},
		click = {
			all_layer = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

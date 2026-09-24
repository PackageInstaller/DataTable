return {
	_rule_ = {
		none = {
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
					level_layer = {
						path = "all_layer/level_layer",
						list = {
							info_bg = {
								path = "all_layer/level_layer/info_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_txt = {
								path = "all_layer/level_layer/type_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							level_txt = {
								path = "all_layer/level_layer/level_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							country_txt = {
								path = "all_layer/level_layer/country_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							lock_tag = {
								path = "all_layer/level_layer/lock_tag",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_remake = {
								path = "all_layer/level_layer/ship_remake",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
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
					expedition_cover = {
						path = "all_layer/expedition_cover",
						list = {
							ship_on_expedition = {
								path = "all_layer/expedition_cover/ship_on_expedition",
								list = {
									expedition_txt = {
										path = "all_layer/expedition_cover/ship_on_expedition/expedition_txt",
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
					repair_btn = {
						path = "all_layer/repair_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ClickAndLongClickEvent"
						}
					},
					love_layer = {
						path = "all_layer/love_layer",
						list = {
							love = {
								path = "all_layer/love_layer/love",
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
					hp_layer = {
						path = "all_layer/hp_layer",
						list = {
							full_img = {
								path = "all_layer/hp_layer/full_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							hp_num = {
								path = "all_layer/hp_layer/hp_num",
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
					name_layer = {
						path = "all_layer/name_layer",
						list = {
							name_dd = {
								path = "all_layer/name_layer/name_dd",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							name_level = {
								path = "all_layer/name_layer/name_level",
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
					repair_type_layer = {
						path = "all_layer/repair_type_layer",
						list = {
							material_layer = {
								path = "all_layer/repair_type_layer/material_layer",
								list = {
									while_line = {
										path = "all_layer/repair_type_layer/material_layer/while_line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_icon = {
										path = "all_layer/repair_type_layer/material_layer/oil_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil = {
										path = "all_layer/repair_type_layer/material_layer/oil",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									fe_icon = {
										path = "all_layer/repair_type_layer/material_layer/fe_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									fe = {
										path = "all_layer/repair_type_layer/material_layer/fe",
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
							time_layer = {
								path = "all_layer/repair_type_layer/time_layer",
								list = {
									title = {
										path = "all_layer/repair_type_layer/time_layer/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									time = {
										path = "all_layer/repair_type_layer/time_layer/time",
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
			team_id_info = {
				path = "team_id_info",
				list = {
					team_id = {
						path = "team_id_info/team_id",
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
			cover_sprite = {
				path = "cover_sprite",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			["all_layer/icon_layer"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			["all_layer/repair_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

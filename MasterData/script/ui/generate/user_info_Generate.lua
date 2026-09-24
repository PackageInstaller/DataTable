return {
	_rule_ = {
		none = {
			bg_shadw = {
				path = "bg_shadw",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			info_framework = {
				path = "info_framework",
				list = {
					info_bg = {
						path = "info_framework/info_bg",
						list = {
							bg = {
								path = "info_framework/info_bg/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top = {
								path = "info_framework/info_bg/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buttom = {
								path = "info_framework/info_bg/buttom",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							left = {
								path = "info_framework/info_bg/left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							right = {
								path = "info_framework/info_bg/right",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							name_segmentation = {
								path = "info_framework/info_bg/name_segmentation",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							info_data_segmentation = {
								path = "info_framework/info_bg/info_data_segmentation",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							close_button = {
								path = "info_framework/info_bg/close_button",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton",
									"UnityEngine.Canvas",
									"UnityEngine.UI.GraphicRaycaster"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.RawImage"
						}
					},
					user_main_info = {
						path = "info_framework/user_main_info",
						list = {
							lv = {
								path = "info_framework/user_main_info/lv",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							player_name = {
								path = "info_framework/user_main_info/player_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							rank_group = {
								path = "info_framework/user_main_info/rank_group",
								list = {
									rank = {
										path = "info_framework/user_main_info/rank_group/rank",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									img = {
										path = "info_framework/user_main_info/rank_group/img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp = {
										path = "info_framework/user_main_info/rank_group/exp",
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
							main_info_segmentation = {
								path = "info_framework/user_main_info/main_info_segmentation",
								list = {
									background = {
										path = "info_framework/user_main_info/main_info_segmentation/background",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									fillarea = {
										path = "info_framework/user_main_info/main_info_segmentation/fillarea",
										list = {
											fill = {
												path = "info_framework/user_main_info/main_info_segmentation/fillarea/fill",
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
									handleslidearea = {
										path = "info_framework/user_main_info/main_info_segmentation/handleslidearea",
										list = {
											handle = {
												path = "info_framework/user_main_info/main_info_segmentation/handleslidearea/handle",
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
									"UnityEngine.UI.Slider"
								}
							},
							collection_info = {
								path = "info_framework/user_main_info/collection_info",
								list = {
									ship_collection = {
										path = "info_framework/user_main_info/collection_info/ship_collection",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									collection = {
										path = "info_framework/user_main_info/collection_info/collection",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									equipment_collection = {
										path = "info_framework/user_main_info/collection_info/equipment_collection",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									ship_number = {
										path = "info_framework/user_main_info/collection_info/ship_number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									collection_rate = {
										path = "info_framework/user_main_info/collection_info/collection_rate",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									equipment_number = {
										path = "info_framework/user_main_info/collection_info/equipment_number",
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
							user_info_segmentation = {
								path = "info_framework/user_main_info/user_info_segmentation",
								list = {
									three = {
										path = "info_framework/user_main_info/user_info_segmentation/three",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									two = {
										path = "info_framework/user_main_info/user_info_segmentation/two",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									one = {
										path = "info_framework/user_main_info/user_info_segmentation/one",
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
							header_info = {
								path = "info_framework/user_main_info/header_info",
								list = {
									bg = {
										path = "info_framework/user_main_info/header_info/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									img = {
										path = "info_framework/user_main_info/header_info/img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									lv = {
										path = "info_framework/user_main_info/header_info/lv",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									uid = {
										path = "info_framework/user_main_info/header_info/uid",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					fight_info = {
						path = "info_framework/fight_info",
						list = {
							segmentation_line = {
								path = "info_framework/fight_info/segmentation_line",
								list = {
									one = {
										path = "info_framework/fight_info/segmentation_line/one",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									two = {
										path = "info_framework/fight_info/segmentation_line/two",
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
							strike_victory_info = {
								path = "info_framework/fight_info/strike_victory_info",
								list = {
									victory = {
										path = "info_framework/fight_info/strike_victory_info/victory",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/strike_victory_info/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/strike_victory_info/line",
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
							strike_number = {
								path = "info_framework/fight_info/strike_number",
								list = {
									strike = {
										path = "info_framework/fight_info/strike_number/strike",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/strike_number/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/strike_number/line",
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
							strike_fail = {
								path = "info_framework/fight_info/strike_fail",
								list = {
									fail = {
										path = "info_framework/fight_info/strike_fail/fail",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/strike_fail/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/strike_fail/line",
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
							strike_odds = {
								path = "info_framework/fight_info/strike_odds",
								list = {
									odds = {
										path = "info_framework/fight_info/strike_odds/odds",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/strike_odds/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/strike_odds/line",
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
							drill_victory = {
								path = "info_framework/fight_info/drill_victory",
								list = {
									victory = {
										path = "info_framework/fight_info/drill_victory/victory",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/drill_victory/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/drill_victory/line",
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
							drill_number = {
								path = "info_framework/fight_info/drill_number",
								list = {
									numb = {
										path = "info_framework/fight_info/drill_number/numb",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/drill_number/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/drill_number/line",
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
							drill_fail = {
								path = "info_framework/fight_info/drill_fail",
								list = {
									fail = {
										path = "info_framework/fight_info/drill_fail/fail",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/drill_fail/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/drill_fail/line",
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
							drill_odds = {
								path = "info_framework/fight_info/drill_odds",
								list = {
									odds = {
										path = "info_framework/fight_info/drill_odds/odds",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/drill_odds/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/drill_odds/line",
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
							expedition = {
								path = "info_framework/fight_info/expedition",
								list = {
									expedition = {
										path = "info_framework/fight_info/expedition/expedition",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/expedition/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/expedition/line",
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
							expedition_successful = {
								path = "info_framework/fight_info/expedition_successful",
								list = {
									successful = {
										path = "info_framework/fight_info/expedition_successful/successful",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "info_framework/fight_info/expedition_successful/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "info_framework/fight_info/expedition_successful/line",
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
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["info_framework/user_main_info/header_info/img"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["info_framework/info_bg/close_button"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {
			close_button = {
				component = "UnityEngine.Canvas",
				path = "info_framework/info_bg/close_button"
			}
		}
	}
}

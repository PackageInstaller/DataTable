return {
	_rule_ = {
		none = {
			add_layer = {
				path = "add_layer",
				list = {
					add_btn = {
						path = "add_layer/add_btn",
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
					"UnityEngine.RectTransform"
				}
			},
			main_layer = {
				path = "main_layer",
				list = {
					quality = {
						path = "main_layer/quality",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					icon_layer = {
						path = "main_layer/icon_layer",
						list = {
							icon = {
								path = "main_layer/icon_layer/icon",
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
					cover = {
						path = "main_layer/cover",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					heart_bg = {
						path = "main_layer/heart_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					heart = {
						path = "main_layer/heart",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					level_layer = {
						path = "main_layer/level_layer",
						list = {
							ship_type = {
								path = "main_layer/level_layer/ship_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							level = {
								path = "main_layer/level_layer/level",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							skill_level = {
								path = "main_layer/level_layer/skill_level",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "main_layer/level_layer/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							country_txt = {
								path = "main_layer/level_layer/country_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							lock_tag = {
								path = "main_layer/level_layer/lock_tag",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							ship_remake = {
								path = "main_layer/level_layer/ship_remake",
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
						path = "main_layer/name_layer",
						list = {
							name_bg = {
								path = "main_layer/name_layer/name_bg",
								list = {
									name_txt_1 = {
										path = "main_layer/name_layer/name_bg/name_txt_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									name_txt_2 = {
										path = "main_layer/name_layer/name_bg/name_txt_2",
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
						path = "main_layer/hp_layer",
						list = {
							blood_bg = {
								path = "main_layer/hp_layer/blood_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							blood_bar = {
								path = "main_layer/hp_layer/blood_bar",
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
					star_layer = {
						path = "main_layer/star_layer",
						list = {
							star = {
								path = "main_layer/star_layer/star",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							star = {
								path = "main_layer/star_layer/star",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							star = {
								path = "main_layer/star_layer/star",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							star = {
								path = "main_layer/star_layer/star",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							star = {
								path = "main_layer/star_layer/star",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							star = {
								path = "main_layer/star_layer/star",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							star = {
								path = "main_layer/star_layer/star",
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
					cancel_btn = {
						path = "main_layer/cancel_btn",
						list = {
							txt = {
								path = "main_layer/cancel_btn/txt",
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
					ship_btn = {
						path = "main_layer/ship_btn",
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
			}
		},
		click = {
			["add_layer/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main_layer/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			["main_layer/ship_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			background = {
				path = "background",
				list = {
					battle_consume_tip = {
						path = "background/battle_consume_tip",
						list = {
							title = {
								path = "background/battle_consume_tip/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							oil_icon = {
								path = "background/battle_consume_tip/oil_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							oil_consume_txt = {
								path = "background/battle_consume_tip/oil_consume_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							bullet_icon = {
								path = "background/battle_consume_tip/bullet_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bullet_consume_txt = {
								path = "background/battle_consume_tip/bullet_consume_txt",
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
							"UnityEngine.CanvasGroup"
						}
					},
					night_consume_tip = {
						path = "background/night_consume_tip",
						list = {
							night = {
								path = "background/night_consume_tip/night",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title = {
								path = "background/night_consume_tip/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							bullet_icon = {
								path = "background/night_consume_tip/bullet_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bullet_consume_txt = {
								path = "background/night_consume_tip/bullet_consume_txt",
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
							"UnityEngine.CanvasGroup"
						}
					},
					skipsuccess_consume_tip = {
						path = "background/skipsuccess_consume_tip",
						list = {
							title = {
								path = "background/skipsuccess_consume_tip/title",
								list = {
									oil_icon = {
										path = "background/skipsuccess_consume_tip/title/oil_icon",
										list = {
											oil_consume_txt = {
												path = "background/skipsuccess_consume_tip/title/oil_icon/oil_consume_txt",
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
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasGroup"
						}
					},
					seven_active_tip = {
						path = "background/seven_active_tip",
						list = {
							config_icon = {
								path = "background/seven_active_tip/config_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							config_num_txt = {
								path = "background/seven_active_tip/config_num_txt",
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
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			text = {
				path = "text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			}
		},
		canvas_set = {}
	}
}

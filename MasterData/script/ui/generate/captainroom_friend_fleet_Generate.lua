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
							title_node = {
								path = "bg/bg_container/title_node",
								list = {
									title = {
										path = "bg/bg_container/title_node/title",
										list = {
											three_point = {
												path = "bg/bg_container/title_node/title/three_point",
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
					},
					fleet_info = {
						path = "bg/fleet_info",
						list = {
							fleet_name = {
								path = "bg/fleet_info/fleet_name",
								list = {
									fleet_name_txt = {
										path = "bg/fleet_info/fleet_name/fleet_name_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									arraw = {
										path = "bg/fleet_info/fleet_name/arraw",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line = {
										path = "bg/fleet_info/fleet_name/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									garrison_fleet = {
										path = "bg/fleet_info/fleet_name/garrison_fleet",
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
							captain_name = {
								path = "bg/fleet_info/captain_name",
								list = {
									fleet_name_txt = {
										path = "bg/fleet_info/captain_name/fleet_name_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									arraw = {
										path = "bg/fleet_info/captain_name/arraw",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line = {
										path = "bg/fleet_info/captain_name/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									captain_img = {
										path = "bg/fleet_info/captain_name/captain_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									level = {
										path = "bg/fleet_info/captain_name/level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									caprain_name_txt = {
										path = "bg/fleet_info/captain_name/caprain_name_txt",
										list = {
											caprain_name_txt_1 = {
												path = "bg/fleet_info/captain_name/caprain_name_txt/caprain_name_txt_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											caprain_name_txt_2 = {
												path = "bg/fleet_info/captain_name/caprain_name_txt/caprain_name_txt_2",
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
											"UnityEngine.UI.Mask",
											"TextHorizonScroller",
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							drill_odds = {
								path = "bg/fleet_info/drill_odds",
								list = {
									title = {
										path = "bg/fleet_info/drill_odds/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									num = {
										path = "bg/fleet_info/drill_odds/num",
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
							cardbook_collect = {
								path = "bg/fleet_info/cardbook_collect",
								list = {
									title = {
										path = "bg/fleet_info/cardbook_collect/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									num = {
										path = "bg/fleet_info/cardbook_collect/num",
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
					role_list = {
						path = "bg/role_list",
						list = {
							role_1 = {
								path = "bg/role_list/role_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							role_2 = {
								path = "bg/role_list/role_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							role_3 = {
								path = "bg/role_list/role_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							role_4 = {
								path = "bg/role_list/role_4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							role_5 = {
								path = "bg/role_list/role_5",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							role_6 = {
								path = "bg/role_list/role_6",
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
							"UnityEngine.UI.GridLayoutGroup"
						}
					},
					role_list_1 = {
						path = "bg/role_list_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.GridLayoutGroup"
						}
					},
					challenge_btn = {
						path = "bg/challenge_btn",
						list = {
							txt = {
								path = "bg/challenge_btn/txt",
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
					challenge_mask = {
						path = "bg/challenge_mask",
						list = {
							txt = {
								path = "bg/challenge_mask/txt",
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
					challenge_result = {
						path = "bg/challenge_result",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					tip = {
						path = "bg/tip",
						list = {
							tip_1 = {
								path = "bg/tip/tip_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							tip_2 = {
								path = "bg/tip/tip_2",
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
							"UnityEngine.UI.Mask",
							"TextHorizonScroller",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/challenge_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

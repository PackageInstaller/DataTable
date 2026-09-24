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
					bg_container = {
						path = "bg/bg_container",
						list = {
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
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
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
					default_bg = {
						path = "bg/default_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					furniture_root = {
						path = "bg/furniture_root",
						list = {
							node = {
								path = "bg/furniture_root/node",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					share_btn = {
						path = "bg/share_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					point_list = {
						path = "bg/point_list",
						list = {
							hint_1 = {
								path = "bg/point_list/hint_1",
								list = {
									numb = {
										path = "bg/point_list/hint_1/numb",
										list = {
											txt = {
												path = "bg/point_list/hint_1/numb/txt",
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
							hint_2 = {
								path = "bg/point_list/hint_2",
								list = {
									numb = {
										path = "bg/point_list/hint_2/numb",
										list = {
											txt = {
												path = "bg/point_list/hint_2/numb/txt",
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
							hint_3 = {
								path = "bg/point_list/hint_3",
								list = {
									numb = {
										path = "bg/point_list/hint_3/numb",
										list = {
											txt = {
												path = "bg/point_list/hint_3/numb/txt",
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
							hint_4 = {
								path = "bg/point_list/hint_4",
								list = {
									numb = {
										path = "bg/point_list/hint_4/numb",
										list = {
											txt = {
												path = "bg/point_list/hint_4/numb/txt",
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
							hint_5 = {
								path = "bg/point_list/hint_5",
								list = {
									numb = {
										path = "bg/point_list/hint_5/numb",
										list = {
											txt = {
												path = "bg/point_list/hint_5/numb/txt",
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
											"UnityEngine.CanvasGroup"
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
							"UnityEngine.UI.GridLayoutGroup"
						}
					},
					left_btn = {
						path = "bg/left_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					right_btn = {
						path = "bg/right_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					clear_btn = {
						path = "bg/clear_btn",
						list = {
							txt = {
								path = "bg/clear_btn/txt",
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
					save_btn = {
						path = "bg/save_btn",
						list = {
							txt = {
								path = "bg/save_btn/txt",
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
					use_btn = {
						path = "bg/use_btn",
						list = {
							txt = {
								path = "bg/use_btn/txt",
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
					line = {
						path = "bg/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					tip_layer2 = {
						path = "bg/tip_layer2",
						list = {
							bg_container = {
								path = "bg/tip_layer2/bg_container",
								list = {
									mask_bg = {
										path = "bg/tip_layer2/bg_container/mask_bg",
										list = {
											bg_blue_top = {
												path = "bg/tip_layer2/bg_container/mask_bg/bg_blue_top",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg_blue_top2 = {
												path = "bg/tip_layer2/bg_container/mask_bg/bg_blue_top2",
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
										path = "bg/tip_layer2/bg_container/bg_blue_top3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_node = {
										path = "bg/tip_layer2/bg_container/title_node",
										list = {
											title = {
												path = "bg/tip_layer2/bg_container/title_node/title",
												list = {
													three_point = {
														path = "bg/tip_layer2/bg_container/title_node/title/three_point",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip_txt = {
								path = "bg/tip_layer2/tip_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "bg/tip_layer2/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "bg/tip_layer2/confirm_btn",
								list = {
									txt = {
										path = "bg/tip_layer2/confirm_btn/txt",
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
							cancel_btn = {
								path = "bg/tip_layer2/cancel_btn",
								list = {
									txt = {
										path = "bg/tip_layer2/cancel_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup",
							"UITweenSequence",
							"UIScaleTweener"
						}
					},
					share_layer = {
						path = "bg/share_layer",
						list = {
							bg_container = {
								path = "bg/share_layer/bg_container",
								list = {
									mask_bg = {
										path = "bg/share_layer/bg_container/mask_bg",
										list = {
											bg_blue_top = {
												path = "bg/share_layer/bg_container/mask_bg/bg_blue_top",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg_blue_top2 = {
												path = "bg/share_layer/bg_container/mask_bg/bg_blue_top2",
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
										path = "bg/share_layer/bg_container/bg_blue_top3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_node = {
										path = "bg/share_layer/bg_container/title_node",
										list = {
											title = {
												path = "bg/share_layer/bg_container/title_node/title",
												list = {
													three_point = {
														path = "bg/share_layer/bg_container/title_node/title/three_point",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							close_btn = {
								path = "bg/share_layer/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							default_bg = {
								path = "bg/share_layer/default_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							furniture_root = {
								path = "bg/share_layer/furniture_root",
								list = {
									node = {
										path = "bg/share_layer/furniture_root/node",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							white_cover = {
								path = "bg/share_layer/white_cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip_txt = {
								path = "bg/share_layer/tip_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							inputfield = {
								path = "bg/share_layer/inputfield",
								list = {
									placeholder = {
										path = "bg/share_layer/inputfield/placeholder",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt = {
										path = "bg/share_layer/inputfield/txt",
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
									"UnityEngine.UI.InputField"
								}
							},
							room_write = {
								path = "bg/share_layer/room_write",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "bg/share_layer/confirm_btn",
								list = {
									txt = {
										path = "bg/share_layer/confirm_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					tip_layer = {
						path = "bg/tip_layer",
						list = {
							bg_container = {
								path = "bg/tip_layer/bg_container",
								list = {
									mask_bg = {
										path = "bg/tip_layer/bg_container/mask_bg",
										list = {
											bg_blue_top = {
												path = "bg/tip_layer/bg_container/mask_bg/bg_blue_top",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg_blue_top2 = {
												path = "bg/tip_layer/bg_container/mask_bg/bg_blue_top2",
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
										path = "bg/tip_layer/bg_container/bg_blue_top3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_node = {
										path = "bg/tip_layer/bg_container/title_node",
										list = {
											title = {
												path = "bg/tip_layer/bg_container/title_node/title",
												list = {
													three_point = {
														path = "bg/tip_layer/bg_container/title_node/title/three_point",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip_txt_1 = {
								path = "bg/tip_layer/tip_txt_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							tip_txt_2 = {
								path = "bg/tip_layer/tip_txt_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							count_ratio = {
								path = "bg/tip_layer/count_ratio",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							confirm_btn = {
								path = "bg/tip_layer/confirm_btn",
								list = {
									txt = {
										path = "bg/tip_layer/confirm_btn/txt",
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
							cancel_btn = {
								path = "bg/tip_layer/cancel_btn",
								list = {
									txt = {
										path = "bg/tip_layer/cancel_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					obj_pool_root = {
						path = "bg/obj_pool_root",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/share_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/left_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/right_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/clear_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/save_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/use_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/tip_layer2/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/tip_layer2/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/share_layer/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/share_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/tip_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/tip_layer/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

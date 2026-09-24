return {
	_rule_ = {
		none = {
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
							"UnityEngine.UI.Image"
						}
					},
					white_cover = {
						path = "bg/white_cover",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					apply_btn = {
						path = "bg/apply_btn",
						list = {
							txt = {
								path = "bg/apply_btn/txt",
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
					cancel_collect_btn = {
						path = "bg/cancel_collect_btn",
						list = {
							txt = {
								path = "bg/cancel_collect_btn/txt",
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
					collect_btn = {
						path = "bg/collect_btn",
						list = {
							txt = {
								path = "bg/collect_btn/txt",
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
					evaluate_btn = {
						path = "bg/evaluate_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					design_name_txt = {
						path = "bg/design_name_txt",
						list = {
							mark_1 = {
								path = "bg/design_name_txt/mark_1",
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
							"UnityEngine.UI.Text"
						}
					},
					designer_name_txt = {
						path = "bg/designer_name_txt",
						list = {
							mark_2 = {
								path = "bg/designer_name_txt/mark_2",
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
							"UnityEngine.UI.Text"
						}
					},
					used_furniture_txt = {
						path = "bg/used_furniture_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
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
					scrollview = {
						path = "bg/scrollview",
						list = {
							viewport = {
								path = "bg/scrollview/viewport",
								list = {
									content = {
										path = "bg/scrollview/viewport/content",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
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
							close_btn = {
								path = "bg/tip_layer/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							tip_txt = {
								path = "bg/tip_layer/tip_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "bg/tip_layer/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
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
							"UITweenSequence",
							"UIScaleTweener",
							"UIScaleTweener"
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
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			evaluate_layer = {
				path = "evaluate_layer",
				list = {
					bg = {
						path = "evaluate_layer/bg",
						list = {
							bg_container = {
								path = "evaluate_layer/bg/bg_container",
								list = {
									mask_bg = {
										path = "evaluate_layer/bg/bg_container/mask_bg",
										list = {
											bg_blue_top = {
												path = "evaluate_layer/bg/bg_container/mask_bg/bg_blue_top",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg_blue_top2 = {
												path = "evaluate_layer/bg/bg_container/mask_bg/bg_blue_top2",
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
										path = "evaluate_layer/bg/bg_container/bg_blue_top3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_node = {
										path = "evaluate_layer/bg/bg_container/title_node",
										list = {
											title = {
												path = "evaluate_layer/bg/bg_container/title_node/title",
												list = {
													three_point = {
														path = "evaluate_layer/bg/bg_container/title_node/title/three_point",
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
								path = "evaluate_layer/bg/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							tip_txt = {
								path = "evaluate_layer/bg/tip_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							star_btn_1 = {
								path = "evaluate_layer/bg/star_btn_1",
								list = {
									star = {
										path = "evaluate_layer/bg/star_btn_1/star",
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
									"UnityEngine.UI.Button"
								}
							},
							star_btn_2 = {
								path = "evaluate_layer/bg/star_btn_2",
								list = {
									star = {
										path = "evaluate_layer/bg/star_btn_2/star",
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
									"UnityEngine.UI.Button"
								}
							},
							star_btn_3 = {
								path = "evaluate_layer/bg/star_btn_3",
								list = {
									star = {
										path = "evaluate_layer/bg/star_btn_3/star",
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
									"UnityEngine.UI.Button"
								}
							},
							star_btn_4 = {
								path = "evaluate_layer/bg/star_btn_4",
								list = {
									star = {
										path = "evaluate_layer/bg/star_btn_4/star",
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
									"UnityEngine.UI.Button"
								}
							},
							star_btn_5 = {
								path = "evaluate_layer/bg/star_btn_5",
								list = {
									star = {
										path = "evaluate_layer/bg/star_btn_5/star",
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
									"UnityEngine.UI.Button"
								}
							},
							confirm_btn = {
								path = "evaluate_layer/bg/confirm_btn",
								list = {
									txt = {
										path = "evaluate_layer/bg/confirm_btn/txt",
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
							"UITweenSequence",
							"UIScaleTweener",
							"UIScaleTweener"
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
			["bg/apply_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/cancel_collect_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/collect_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/evaluate_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/tip_layer/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/tip_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/tip_layer/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["evaluate_layer/bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["evaluate_layer/bg/star_btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["evaluate_layer/bg/star_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["evaluate_layer/bg/star_btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["evaluate_layer/bg/star_btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["evaluate_layer/bg/star_btn_5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["evaluate_layer/bg/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

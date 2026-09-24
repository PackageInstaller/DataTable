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
			bg_test = {
				path = "bg_test",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg_container = {
				path = "bg_container",
				list = {
					blue_top = {
						path = "bg_container/blue_top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg_cover = {
						path = "bg_container/bg_cover",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					three_point = {
						path = "bg_container/three_point",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					grey = {
						path = "bg_container/grey",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					medal_info_text = {
						path = "bg_container/medal_info_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					medal_icon_bg = {
						path = "bg_container/medal_icon_bg",
						list = {
							medal_icon = {
								path = "bg_container/medal_icon_bg/medal_icon",
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
					medal_name_text = {
						path = "bg_container/medal_name_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					describe_condition = {
						path = "bg_container/describe_condition",
						list = {
							condition_text = {
								path = "bg_container/describe_condition/condition_text",
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
							"UnityEngine.UI.Text"
						}
					},
					describe_medal = {
						path = "bg_container/describe_medal",
						list = {
							describe_text = {
								path = "bg_container/describe_medal/describe_text",
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
							"UnityEngine.UI.Text"
						}
					},
					progress = {
						path = "bg_container/progress",
						list = {
							finish_text = {
								path = "bg_container/progress/finish_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							progress_text = {
								path = "bg_container/progress/progress_text",
								list = {
									medal_progress = {
										path = "bg_container/progress/progress_text/medal_progress",
										list = {
											bg = {
												path = "bg_container/progress/progress_text/medal_progress/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											fill_area = {
												path = "bg_container/progress/progress_text/medal_progress/fill_area",
												list = {
													fill = {
														path = "bg_container/progress/progress_text/medal_progress/fill_area/fill",
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
											handle_slide_area = {
												path = "bg_container/progress/progress_text/medal_progress/handle_slide_area",
												list = {
													handle = {
														path = "bg_container/progress/progress_text/medal_progress/handle_slide_area/handle",
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
							"UnityEngine.RectTransform"
						}
					},
					btn = {
						path = "bg_container/btn",
						list = {
							lv_btn_1 = {
								path = "bg_container/btn/lv_btn_1",
								list = {
									lv_text = {
										path = "bg_container/btn/lv_btn_1/lv_text",
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
							lv_btn_2 = {
								path = "bg_container/btn/lv_btn_2",
								list = {
									lv_text = {
										path = "bg_container/btn/lv_btn_2/lv_text",
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
							lv_btn_3 = {
								path = "bg_container/btn/lv_btn_3",
								list = {
									lv_text = {
										path = "bg_container/btn/lv_btn_3/lv_text",
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
							lv_btn_4 = {
								path = "bg_container/btn/lv_btn_4",
								list = {
									lv_text = {
										path = "bg_container/btn/lv_btn_4/lv_text",
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
							lv_btn_5 = {
								path = "bg_container/btn/lv_btn_5",
								list = {
									lv_text = {
										path = "bg_container/btn/lv_btn_5/lv_text",
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
							lv_btn_6 = {
								path = "bg_container/btn/lv_btn_6",
								list = {
									lv_text = {
										path = "bg_container/btn/lv_btn_6/lv_text",
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
							"UnityEngine.RectTransform"
						}
					},
					line = {
						path = "bg_container/line",
						list = {
							line_1 = {
								path = "bg_container/line/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_2 = {
								path = "bg_container/line/line_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_3 = {
								path = "bg_container/line/line_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_4 = {
								path = "bg_container/line/line_4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_5 = {
								path = "bg_container/line/line_5",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_6 = {
								path = "bg_container/line/line_6",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_7 = {
								path = "bg_container/line/line_7",
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
					close_btn = {
						path = "bg_container/close_btn",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			cover = {
				path = "cover",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			["bg_container/btn/lv_btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_container/btn/lv_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_container/btn/lv_btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_container/btn/lv_btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_container/btn/lv_btn_5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_container/btn/lv_btn_6"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_container/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

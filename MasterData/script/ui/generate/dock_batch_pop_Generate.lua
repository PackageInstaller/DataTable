return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			content = {
				path = "content",
				list = {
					bg = {
						path = "content/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top = {
						path = "content/top",
						list = {
							mask = {
								path = "content/top/mask",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_bg = {
								path = "content/top/top_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							arrow = {
								path = "content/top/arrow",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "content/top/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "content/top/line",
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
					contains = {
						path = "content/contains",
						list = {
							build_title = {
								path = "content/contains/build_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							minus_btn = {
								path = "content/contains/minus_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							num = {
								path = "content/contains/num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							plus_btn = {
								path = "content/contains/plus_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							max_btn = {
								path = "content/contains/max_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							line_up = {
								path = "content/contains/line_up",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							res_need_title = {
								path = "content/contains/res_need_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							build_line = {
								path = "content/contains/build_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							res_need = {
								path = "content/contains/res_need",
								list = {
									need_iten_1 = {
										path = "content/contains/res_need/need_iten_1",
										list = {
											icon = {
												path = "content/contains/res_need/need_iten_1/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "content/contains/res_need/need_iten_1/num",
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
									need_iten_2 = {
										path = "content/contains/res_need/need_iten_2",
										list = {
											icon = {
												path = "content/contains/res_need/need_iten_2/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "content/contains/res_need/need_iten_2/num",
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
									need_iten_3 = {
										path = "content/contains/res_need/need_iten_3",
										list = {
											icon = {
												path = "content/contains/res_need/need_iten_3/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "content/contains/res_need/need_iten_3/num",
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
									need_iten_4 = {
										path = "content/contains/res_need/need_iten_4",
										list = {
											icon = {
												path = "content/contains/res_need/need_iten_4/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "content/contains/res_need/need_iten_4/num",
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
									need_iten_5 = {
										path = "content/contains/res_need/need_iten_5",
										list = {
											icon = {
												path = "content/contains/res_need/need_iten_5/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "content/contains/res_need/need_iten_5/num",
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
									need_iten_6 = {
										path = "content/contains/res_need/need_iten_6",
										list = {
											icon = {
												path = "content/contains/res_need/need_iten_6/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											num = {
												path = "content/contains/res_need/need_iten_6/num",
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
							},
							line_down = {
								path = "content/contains/line_down",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "content/contains/confirm_btn",
								list = {
									text = {
										path = "content/contains/confirm_btn/text",
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
								path = "content/contains/cancel_btn",
								list = {
									text = {
										path = "content/contains/cancel_btn/text",
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
							tips = {
								path = "content/contains/tips",
								list = {
									text = {
										path = "content/contains/tips/text",
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
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			tips = {
				path = "tips",
				list = {
					txt = {
						path = "tips/txt",
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
		click = {
			["content/contains/minus_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/contains/plus_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/contains/max_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/contains/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/contains/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

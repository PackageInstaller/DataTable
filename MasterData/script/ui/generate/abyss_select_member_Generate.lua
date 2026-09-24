return {
	_rule_ = {
		none = {
			cover = {
				path = "cover",
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
					bg = {
						path = "bg_container/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					back_btn = {
						path = "bg_container/back_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster",
							"ScaleButton"
						}
					},
					line_head = {
						path = "bg_container/line_head",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_bottom = {
						path = "bg_container/line_bottom",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					select_team_basic = {
						path = "bg_container/select_team_basic",
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
			fast_btn = {
				path = "fast_btn",
				list = {
					changefleetfast = {
						path = "fast_btn/changefleetfast",
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
			detail_btn = {
				path = "detail_btn",
				list = {
					pvpdetailbtn = {
						path = "detail_btn/pvpdetailbtn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					detail_status = {
						path = "detail_btn/detail_status",
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
			sort_order_btn = {
				path = "sort_order_btn",
				list = {
					sorttype = {
						path = "sort_order_btn/sorttype",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					sort_txt = {
						path = "sort_order_btn/sort_txt",
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
			sort_type_btn = {
				path = "sort_type_btn",
				list = {
					type = {
						path = "sort_type_btn/type",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					sort_txt = {
						path = "sort_type_btn/sort_txt",
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
			confirm_btn = {
				path = "confirm_btn",
				list = {
					confirm = {
						path = "confirm_btn/confirm",
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
			all_ship = {
				path = "all_ship",
				list = {
					Viewport = {
						path = "all_ship/Viewport",
						list = {
							Scrollbar = {
								path = "all_ship/Viewport/Scrollbar",
								list = {
									["Sliding Area"] = {
										path = "all_ship/Viewport/Scrollbar/Sliding Area",
										list = {
											Handle = {
												path = "all_ship/Viewport/Scrollbar/Sliding Area/Handle",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Scrollbar"
								}
							},
							edge_mask = {
								path = "all_ship/Viewport/edge_mask",
								list = {
									Content = {
										path = "all_ship/Viewport/edge_mask/Content",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"EndlessScrollView",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Mask"
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
			sort_layer = {
				path = "sort_layer",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			type_layer = {
				path = "type_layer",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			fast_btn = {
				tp = "UnityEngine.UI.Button"
			},
			detail_btn = {
				tp = "UnityEngine.UI.Button"
			},
			sort_order_btn = {
				tp = "UnityEngine.UI.Button"
			},
			sort_type_btn = {
				tp = "UnityEngine.UI.Button"
			},
			confirm_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bg_container/back_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {
			back_btn = {
				component = "UnityEngine.Canvas",
				path = "bg_container/back_btn"
			}
		}
	}
}

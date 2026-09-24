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
			top_layer = {
				path = "top_layer",
				list = {
					upline = {
						path = "top_layer/upline",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bottomline = {
						path = "top_layer/bottomline",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "top_layer/title",
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
			returnbtn = {
				path = "returnbtn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			scrollview = {
				path = "scrollview",
				list = {
					viewport = {
						path = "scrollview/viewport",
						list = {
							content = {
								path = "scrollview/viewport/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"EndlessScrollView"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Mask",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.ScrollRect"
				}
			},
			search_btn = {
				path = "search_btn",
				list = {
					bg = {
						path = "search_btn/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					search = {
						path = "search_btn/search",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					input_text = {
						path = "search_btn/input_text",
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
			order_layer = {
				path = "order_layer",
				list = {
					txt = {
						path = "order_layer/txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					type_des = {
						path = "order_layer/type_des",
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
			type_layer = {
				path = "type_layer",
				list = {
					txt = {
						path = "type_layer/txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					type_des = {
						path = "type_layer/type_des",
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
			my_favorite_btn = {
				path = "my_favorite_btn",
				list = {
					txt = {
						path = "my_favorite_btn/txt",
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
			order_layer_detail = {
				path = "order_layer_detail",
				list = {
					order1 = {
						path = "order_layer_detail/order1",
						list = {
							txt = {
								path = "order_layer_detail/order1/txt",
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
					order2 = {
						path = "order_layer_detail/order2",
						list = {
							txt = {
								path = "order_layer_detail/order2/txt",
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
					order3 = {
						path = "order_layer_detail/order3",
						list = {
							txt = {
								path = "order_layer_detail/order3/txt",
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
					order4 = {
						path = "order_layer_detail/order4",
						list = {
							txt = {
								path = "order_layer_detail/order4/txt",
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
					"UnityEngine.UI.Button"
				}
			},
			type_layer_detail = {
				path = "type_layer_detail",
				list = {
					type1 = {
						path = "type_layer_detail/type1",
						list = {
							txt = {
								path = "type_layer_detail/type1/txt",
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
					type2 = {
						path = "type_layer_detail/type2",
						list = {
							txt = {
								path = "type_layer_detail/type2/txt",
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
					type3 = {
						path = "type_layer_detail/type3",
						list = {
							txt = {
								path = "type_layer_detail/type3/txt",
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
					type4 = {
						path = "type_layer_detail/type4",
						list = {
							txt = {
								path = "type_layer_detail/type4/txt",
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
					"UnityEngine.UI.Button"
				}
			},
			search_layer = {
				path = "search_layer",
				list = {
					bg = {
						path = "search_layer/bg",
						list = {
							title = {
								path = "search_layer/bg/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							close_btn = {
								path = "search_layer/bg/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							input = {
								path = "search_layer/bg/input",
								list = {
									placeholder = {
										path = "search_layer/bg/input/placeholder",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt = {
										path = "search_layer/bg/input/txt",
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
							confirm_btn = {
								path = "search_layer/bg/confirm_btn",
								list = {
									txt = {
										path = "search_layer/bg/confirm_btn/txt",
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
			obj_pool_root = {
				path = "obj_pool_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
				}
			}
		},
		click = {
			returnbtn = {
				tp = "UnityEngine.UI.Button"
			},
			search_btn = {
				tp = "UnityEngine.UI.Button"
			},
			order_layer = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer = {
				tp = "UnityEngine.UI.Button"
			},
			my_favorite_btn = {
				tp = "UnityEngine.UI.Button"
			},
			order_layer_detail = {
				tp = "UnityEngine.UI.Button"
			},
			["order_layer_detail/order1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["order_layer_detail/order2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["order_layer_detail/order3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["order_layer_detail/order4"] = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer_detail = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer_detail/type1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer_detail/type2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer_detail/type3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer_detail/type4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["search_layer/bg/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["search_layer/bg/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

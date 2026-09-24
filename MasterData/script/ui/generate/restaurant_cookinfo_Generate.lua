return {
	_rule_ = {
		none = {
			cook_info = {
				path = "cook_info",
				list = {
					bg_container = {
						path = "cook_info/bg_container",
						list = {
							bg = {
								path = "cook_info/bg_container/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_left = {
								path = "cook_info/bg_container/bg_left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top = {
								path = "cook_info/bg_container/bg_blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_2 = {
								path = "cook_info/bg_container/bg_blue_top_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_3 = {
								path = "cook_info/bg_container/bg_blue_top_3",
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
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					single_food_able = {
						path = "cook_info/single_food_able",
						list = {
							food_quality = {
								path = "cook_info/single_food_able/food_quality",
								list = {
									food_small = {
										path = "cook_info/single_food_able/food_quality/food_small",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									food_cover = {
										path = "cook_info/single_food_able/food_quality/food_cover",
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
							progress = {
								path = "cook_info/single_food_able/progress",
								list = {
									level = {
										path = "cook_info/single_food_able/progress/level",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "cook_info/single_food_able/progress/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_text = {
										path = "cook_info/single_food_able/progress/exp_text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									scrollview = {
										path = "cook_info/single_food_able/progress/scrollview",
										list = {
											content = {
												path = "cook_info/single_food_able/progress/scrollview/content",
												list = {
													cook_desc = {
														path = "cook_info/single_food_able/progress/scrollview/content/cook_desc",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {
													"UnityEngine.UI.VerticalLayoutGroup"
												}
											}
										},
										component = {
											"UnityEngine.UI.ScrollRect"
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
						path = "cook_info/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					title = {
						path = "cook_info/title",
						list = {
							three_point = {
								path = "cook_info/title/three_point",
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
					},
					name_txt = {
						path = "cook_info/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					black_line = {
						path = "cook_info/black_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					common_mark = {
						path = "cook_info/common_mark",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					desc = {
						path = "cook_info/desc",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					consume = {
						path = "cook_info/consume",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					consume_item_1 = {
						path = "cook_info/consume_item_1",
						list = {
							icon = {
								path = "cook_info/consume_item_1/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_info/consume_item_1/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_info/consume_item_1/count",
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
					consume_item_2 = {
						path = "cook_info/consume_item_2",
						list = {
							icon = {
								path = "cook_info/consume_item_2/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_info/consume_item_2/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_info/consume_item_2/count",
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
					consume_item_3 = {
						path = "cook_info/consume_item_3",
						list = {
							icon = {
								path = "cook_info/consume_item_3/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_info/consume_item_3/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_info/consume_item_3/count",
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
					consume_item_4 = {
						path = "cook_info/consume_item_4",
						list = {
							icon = {
								path = "cook_info/consume_item_4/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_info/consume_item_4/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_info/consume_item_4/count",
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
					set_btn = {
						path = "cook_info/set_btn",
						list = {
							txt = {
								path = "cook_info/set_btn/txt",
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
					no_use = {
						path = "cook_info/no_use",
						list = {
							txt = {
								path = "cook_info/no_use/txt",
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
			new_buff = {
				path = "new_buff",
				list = {
					bg_container = {
						path = "new_buff/bg_container",
						list = {
							bg = {
								path = "new_buff/bg_container/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top = {
								path = "new_buff/bg_container/bg_blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_2 = {
								path = "new_buff/bg_container/bg_blue_top_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							three_point = {
								path = "new_buff/bg_container/three_point",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_3 = {
								path = "new_buff/bg_container/bg_blue_top_3",
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
					tip = {
						path = "new_buff/tip",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					black_line = {
						path = "new_buff/black_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					confirm_btn = {
						path = "new_buff/confirm_btn",
						list = {
							txt = {
								path = "new_buff/confirm_btn/txt",
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
						path = "new_buff/cancel_btn",
						list = {
							txt = {
								path = "new_buff/cancel_btn/txt",
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
			cook_get_info = {
				path = "cook_get_info",
				list = {
					bg_container = {
						path = "cook_get_info/bg_container",
						list = {
							bg = {
								path = "cook_get_info/bg_container/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_left = {
								path = "cook_get_info/bg_container/bg_left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top = {
								path = "cook_get_info/bg_container/bg_blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_2 = {
								path = "cook_get_info/bg_container/bg_blue_top_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_3 = {
								path = "cook_get_info/bg_container/bg_blue_top_3",
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
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					single_food_able = {
						path = "cook_get_info/single_food_able",
						list = {
							food_quality = {
								path = "cook_get_info/single_food_able/food_quality",
								list = {
									food_small = {
										path = "cook_get_info/single_food_able/food_quality/food_small",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									food_cover = {
										path = "cook_get_info/single_food_able/food_quality/food_cover",
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
							progress = {
								path = "cook_get_info/single_food_able/progress",
								list = {
									scrollview = {
										path = "cook_get_info/single_food_able/progress/scrollview",
										list = {
											content = {
												path = "cook_get_info/single_food_able/progress/scrollview/content",
												list = {
													cook_desc = {
														path = "cook_get_info/single_food_able/progress/scrollview/content/cook_desc",
														list = {},
														component = {
															"UnityEngine.UI.Text"
														}
													}
												},
												component = {
													"UnityEngine.UI.VerticalLayoutGroup"
												}
											}
										},
										component = {
											"UnityEngine.UI.ScrollRect"
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
						path = "cook_get_info/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					title = {
						path = "cook_get_info/title",
						list = {
							three_point = {
								path = "cook_get_info/title/three_point",
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
					},
					name_txt = {
						path = "cook_get_info/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					black_line = {
						path = "cook_get_info/black_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					common_mark = {
						path = "cook_get_info/common_mark",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					desc = {
						path = "cook_get_info/desc",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					consume = {
						path = "cook_get_info/consume",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					consume_item_1 = {
						path = "cook_get_info/consume_item_1",
						list = {
							icon = {
								path = "cook_get_info/consume_item_1/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_get_info/consume_item_1/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_get_info/consume_item_1/count",
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
					consume_item_2 = {
						path = "cook_get_info/consume_item_2",
						list = {
							icon = {
								path = "cook_get_info/consume_item_2/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_get_info/consume_item_2/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_get_info/consume_item_2/count",
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
					consume_item_3 = {
						path = "cook_get_info/consume_item_3",
						list = {
							icon = {
								path = "cook_get_info/consume_item_3/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_get_info/consume_item_3/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_get_info/consume_item_3/count",
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
					consume_item_4 = {
						path = "cook_get_info/consume_item_4",
						list = {
							icon = {
								path = "cook_get_info/consume_item_4/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "cook_get_info/consume_item_4/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "cook_get_info/consume_item_4/count",
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
			}
		},
		call_node_list = {
			["restaurant_cookinfo/cook_get_info/bg_container"] = "_control.cook_get_info.bg_container",
			["restaurant_cookinfo/cook_info/black_line"] = "_control.cook_info.black_line",
			["restaurant_cookinfo/cook_info/single_food_able/progress"] = "_control.cook_info.single_food_able.progress",
			["restaurant_cookinfo/cook_info/consume_item_4"] = "_control.cook_info.consume_item_4",
			["restaurant_cookinfo/cook_info/single_food_able/progress/scrollview"] = "_control.cook_info.single_food_able.progress.scrollview",
			["restaurant_cookinfo/cook_get_info/consume_item_2"] = "_control.cook_get_info.consume_item_2",
			["restaurant_cookinfo/cook_info/consume_item_4/count"] = "_control.cook_info.consume_item_4.count",
			["restaurant_cookinfo/new_buff/bg_container/bg_blue_top_2"] = "_control.new_buff.bg_container.bg_blue_top_2",
			["restaurant_cookinfo/cook_get_info/desc"] = "_control.cook_get_info.desc",
			["restaurant_cookinfo/cook_info/single_food_able/food_quality/food_small"] = "_control.cook_info.single_food_able.food_quality.food_small",
			["restaurant_cookinfo/cook_info/consume_item_3/line"] = "_control.cook_info.consume_item_3.line",
			["restaurant_cookinfo/cook_info/consume_item_1/line"] = "_control.cook_info.consume_item_1.line",
			["restaurant_cookinfo/new_buff/confirm_btn/txt"] = "_control.new_buff.confirm_btn.txt",
			["restaurant_cookinfo/cook_info/consume_item_3/icon"] = "_control.cook_info.consume_item_3.icon",
			["restaurant_cookinfo/cook_info/title/three_point"] = "_control.cook_info.title.three_point",
			["restaurant_cookinfo/cook_info/desc"] = "_control.cook_info.desc",
			["restaurant_cookinfo/new_buff/cancel_btn/txt"] = "_control.new_buff.cancel_btn.txt",
			["restaurant_cookinfo/cook_info/set_btn/txt"] = "_control.cook_info.set_btn.txt",
			["restaurant_cookinfo/cook_info/consume_item_2/count"] = "_control.cook_info.consume_item_2.count",
			["restaurant_cookinfo/cook_info/consume_item_3/count"] = "_control.cook_info.consume_item_3.count",
			["restaurant_cookinfo/cook_get_info/title"] = "_control.cook_get_info.title",
			["restaurant_cookinfo/cook_info/consume"] = "_control.cook_info.consume",
			["restaurant_cookinfo/cook_info/bg_container/bg_blue_top_3"] = "_control.cook_info.bg_container.bg_blue_top_3",
			["restaurant_cookinfo/cook_info/bg_container/bg_blue_top_2"] = "_control.cook_info.bg_container.bg_blue_top_2",
			["restaurant_cookinfo/cook_get_info/single_food_able/progress/scrollview/content"] = "_control.cook_get_info.single_food_able.progress.scrollview.content",
			["restaurant_cookinfo/cook_get_info/consume_item_4"] = "_control.cook_get_info.consume_item_4",
			["restaurant_cookinfo/cook_info/consume_item_1/icon"] = "_control.cook_info.consume_item_1.icon",
			["restaurant_cookinfo/cook_get_info/consume_item_1/count"] = "_control.cook_get_info.consume_item_1.count",
			["restaurant_cookinfo/cook_get_info/single_food_able/food_quality"] = "_control.cook_get_info.single_food_able.food_quality",
			["restaurant_cookinfo/new_buff/bg_container"] = "_control.new_buff.bg_container",
			["restaurant_cookinfo/cook_get_info/single_food_able/food_quality/food_small"] = "_control.cook_get_info.single_food_able.food_quality.food_small",
			["restaurant_cookinfo/cook_get_info/single_food_able/food_quality/food_cover"] = "_control.cook_get_info.single_food_able.food_quality.food_cover",
			["restaurant_cookinfo/cook_get_info/bg_container/bg_blue_top"] = "_control.cook_get_info.bg_container.bg_blue_top",
			["restaurant_cookinfo/cook_get_info/single_food_able/progress/scrollview"] = "_control.cook_get_info.single_food_able.progress.scrollview",
			["restaurant_cookinfo/cook_info/bg_container/bg_left"] = "_control.cook_info.bg_container.bg_left",
			["restaurant_cookinfo/cook_info/single_food_able/progress/scrollview/content/cook_desc"] = "_control.cook_info.single_food_able.progress.scrollview.content.cook_desc",
			["restaurant_cookinfo/cook_get_info/close_btn"] = "_control.cook_get_info.close_btn",
			["restaurant_cookinfo/cook_info/single_food_able/food_quality/food_cover"] = "_control.cook_info.single_food_able.food_quality.food_cover",
			["restaurant_cookinfo/cook_info/consume_item_4/line"] = "_control.cook_info.consume_item_4.line",
			["restaurant_cookinfo/cook_get_info/common_mark"] = "_control.cook_get_info.common_mark",
			["restaurant_cookinfo/cook_info/consume_item_2/icon"] = "_control.cook_info.consume_item_2.icon",
			["restaurant_cookinfo/cook_get_info/bg_container/bg_blue_top_3"] = "_control.cook_get_info.bg_container.bg_blue_top_3",
			["restaurant_cookinfo/cook_get_info/title/three_point"] = "_control.cook_get_info.title.three_point",
			["restaurant_cookinfo/cook_info/single_food_able/progress/scrollview/content"] = "_control.cook_info.single_food_able.progress.scrollview.content",
			["restaurant_cookinfo/cook_get_info/consume"] = "_control.cook_get_info.consume",
			["restaurant_cookinfo/new_buff/bg_container/three_point"] = "_control.new_buff.bg_container.three_point",
			["restaurant_cookinfo/cook_get_info/consume_item_1/icon"] = "_control.cook_get_info.consume_item_1.icon",
			["restaurant_cookinfo/cook_get_info/bg_container/bg"] = "_control.cook_get_info.bg_container.bg",
			["restaurant_cookinfo/new_buff/bg_container/bg_blue_top"] = "_control.new_buff.bg_container.bg_blue_top",
			["restaurant_cookinfo/new_buff/tip"] = "_control.new_buff.tip",
			["restaurant_cookinfo/cook_info/single_food_able/progress/level"] = "_control.cook_info.single_food_able.progress.level",
			["restaurant_cookinfo/cook_get_info/bg_container/bg_left"] = "_control.cook_get_info.bg_container.bg_left",
			["restaurant_cookinfo/cook_info/no_use"] = "_control.cook_info.no_use",
			["restaurant_cookinfo/cook_get_info/consume_item_2/icon"] = "_control.cook_get_info.consume_item_2.icon",
			["restaurant_cookinfo/cook_info/bg_container"] = "_control.cook_info.bg_container",
			["restaurant_cookinfo/cook_get_info/consume_item_2/line"] = "_control.cook_get_info.consume_item_2.line",
			["restaurant_cookinfo/cook_get_info/consume_item_2/count"] = "_control.cook_get_info.consume_item_2.count",
			["restaurant_cookinfo/cook_get_info/consume_item_3"] = "_control.cook_get_info.consume_item_3",
			["restaurant_cookinfo/cook_get_info/black_line"] = "_control.cook_get_info.black_line",
			["restaurant_cookinfo/cook_get_info/consume_item_3/icon"] = "_control.cook_get_info.consume_item_3.icon",
			["restaurant_cookinfo/cook_get_info/consume_item_3/line"] = "_control.cook_get_info.consume_item_3.line",
			["restaurant_cookinfo/cook_info/single_food_able"] = "_control.cook_info.single_food_able",
			["restaurant_cookinfo/cook_get_info/consume_item_3/count"] = "_control.cook_get_info.consume_item_3.count",
			["restaurant_cookinfo/cook_info/no_use/txt"] = "_control.cook_info.no_use.txt",
			["restaurant_cookinfo/cook_info/bg_container/bg_blue_top"] = "_control.cook_info.bg_container.bg_blue_top",
			["restaurant_cookinfo/cook_get_info/consume_item_4/icon"] = "_control.cook_get_info.consume_item_4.icon",
			["restaurant_cookinfo/cook_get_info/consume_item_4/line"] = "_control.cook_get_info.consume_item_4.line",
			["restaurant_cookinfo/cook_info/set_btn"] = "_control.cook_info.set_btn",
			["restaurant_cookinfo/cook_get_info/consume_item_4/count"] = "_control.cook_get_info.consume_item_4.count",
			["restaurant_cookinfo/cook_get_info/single_food_able/progress"] = "_control.cook_get_info.single_food_able.progress",
			["restaurant_cookinfo/new_buff/black_line"] = "_control.new_buff.black_line",
			["restaurant_cookinfo/cook_info/close_btn"] = "_control.cook_info.close_btn",
			["restaurant_cookinfo/cook_info/consume_item_2"] = "_control.cook_info.consume_item_2",
			["restaurant_cookinfo/cook_get_info/single_food_able/progress/scrollview/content/cook_desc"] = "_control.cook_get_info.single_food_able.progress.scrollview.content.cook_desc",
			["restaurant_cookinfo/cook_info/consume_item_2/line"] = "_control.cook_info.consume_item_2.line",
			["restaurant_cookinfo/cook_info/single_food_able/progress/line"] = "_control.cook_info.single_food_able.progress.line",
			["restaurant_cookinfo/cook_get_info/bg_container/bg_blue_top_2"] = "_control.cook_get_info.bg_container.bg_blue_top_2",
			["restaurant_cookinfo/cook_info/consume_item_4/icon"] = "_control.cook_info.consume_item_4.icon",
			["restaurant_cookinfo/cook_info/consume_item_3"] = "_control.cook_info.consume_item_3",
			["restaurant_cookinfo/cook_info/common_mark"] = "_control.cook_info.common_mark",
			["restaurant_cookinfo/cook_info"] = "_control.cook_info",
			["restaurant_cookinfo/cook_get_info/consume_item_1/line"] = "_control.cook_get_info.consume_item_1.line",
			["restaurant_cookinfo/new_buff/bg_container/bg_blue_top_3"] = "_control.new_buff.bg_container.bg_blue_top_3",
			["restaurant_cookinfo/cook_info/consume_item_1"] = "_control.cook_info.consume_item_1",
			["restaurant_cookinfo/new_buff"] = "_control.new_buff",
			["restaurant_cookinfo/cook_get_info/name_txt"] = "_control.cook_get_info.name_txt",
			["restaurant_cookinfo/cook_info/single_food_able/progress/exp_text"] = "_control.cook_info.single_food_able.progress.exp_text",
			["restaurant_cookinfo/cook_get_info/single_food_able"] = "_control.cook_get_info.single_food_able",
			["restaurant_cookinfo/new_buff/bg_container/bg"] = "_control.new_buff.bg_container.bg",
			["restaurant_cookinfo/cook_info/name_txt"] = "_control.cook_info.name_txt",
			["restaurant_cookinfo/cook_get_info/consume_item_1"] = "_control.cook_get_info.consume_item_1",
			["restaurant_cookinfo/cook_info/title"] = "_control.cook_info.title",
			["restaurant_cookinfo/new_buff/confirm_btn"] = "_control.new_buff.confirm_btn",
			["restaurant_cookinfo/cook_info/consume_item_1/count"] = "_control.cook_info.consume_item_1.count",
			["restaurant_cookinfo/cook_get_info"] = "_control.cook_get_info",
			["restaurant_cookinfo/cook_info/single_food_able/food_quality"] = "_control.cook_info.single_food_able.food_quality",
			["restaurant_cookinfo/new_buff/cancel_btn"] = "_control.new_buff.cancel_btn",
			["restaurant_cookinfo/cook_info/bg_container/bg"] = "_control.cook_info.bg_container.bg"
		},
		click = {
			["cook_info/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["cook_info/set_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["new_buff/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["new_buff/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["cook_get_info/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

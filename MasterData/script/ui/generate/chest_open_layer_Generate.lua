return {
	_rule_ = {
		none = {
			chest_layer = {
				path = "chest_layer",
				list = {
					bg = {
						path = "chest_layer/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg_top = {
						path = "chest_layer/bg_top",
						list = {
							mask_bg = {
								path = "chest_layer/bg_top/mask_bg",
								list = {
									bg_blue_top = {
										path = "chest_layer/bg_top/mask_bg/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top2 = {
										path = "chest_layer/bg_top/mask_bg/bg_blue_top2",
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
								path = "chest_layer/bg_top/bg_blue_top3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "chest_layer/bg_top/title",
								list = {
									three_point = {
										path = "chest_layer/bg_top/title/three_point",
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
					},
					bg_line_1 = {
						path = "chest_layer/bg_line_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close_btn = {
						path = "chest_layer/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					scrollview = {
						path = "chest_layer/scrollview",
						list = {
							content = {
								path = "chest_layer/scrollview/content",
								list = {
									chest_cell = {
										path = "chest_layer/scrollview/content/chest_cell",
										list = {
											bg = {
												path = "chest_layer/scrollview/content/chest_cell/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Button"
												}
											},
											icon = {
												path = "chest_layer/scrollview/content/chest_cell/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											count_txt = {
												path = "chest_layer/scrollview/content/chest_cell/count_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											name_bg = {
												path = "chest_layer/scrollview/content/chest_cell/name_bg",
												list = {
													name_txt = {
														path = "chest_layer/scrollview/content/chest_cell/name_bg/name_txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													name_txt_2 = {
														path = "chest_layer/scrollview/content/chest_cell/name_bg/name_txt_2",
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
													"TextScroller"
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
									"UnityEngine.UI.GridLayoutGroup",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
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
			chest_info = {
				path = "chest_info",
				list = {
					bg_container = {
						path = "chest_info/bg_container",
						list = {
							bg = {
								path = "chest_info/bg_container/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_cover = {
								path = "chest_info/bg_container/bg_cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top = {
								path = "chest_info/bg_container/bg_blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_2 = {
								path = "chest_info/bg_container/bg_blue_top_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_3 = {
								path = "chest_info/bg_container/bg_blue_top_3",
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
					quality = {
						path = "chest_info/quality",
						list = {
							icon = {
								path = "chest_info/quality/icon",
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
					title = {
						path = "chest_info/title",
						list = {
							three_point = {
								path = "chest_info/title/three_point",
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
					close_btn = {
						path = "chest_info/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					common_line = {
						path = "chest_info/common_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					scrollview = {
						path = "chest_info/scrollview",
						list = {
							content = {
								path = "chest_info/scrollview/content",
								list = {
									info_txt = {
										path = "chest_info/scrollview/content/info_txt",
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
									"UnityEngine.UI.ContentSizeFitter",
									"UnityEngine.UI.VerticalLayoutGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					detail_btn = {
						path = "chest_info/detail_btn",
						list = {
							txt = {
								path = "chest_info/detail_btn/txt",
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
					name_txt = {
						path = "chest_info/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					black_line = {
						path = "chest_info/black_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					open_sum = {
						path = "chest_info/open_sum",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					minus_btn = {
						path = "chest_info/minus_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ClickAndLongClickEvent"
						}
					},
					sum = {
						path = "chest_info/sum",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					plus_btn = {
						path = "chest_info/plus_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ClickAndLongClickEvent"
						}
					},
					have_sum_txt = {
						path = "chest_info/have_sum_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					have_sum = {
						path = "chest_info/have_sum",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					black_line_2 = {
						path = "chest_info/black_line_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					use_btn = {
						path = "chest_info/use_btn",
						list = {
							txt = {
								path = "chest_info/use_btn/txt",
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
					max_can_get_furniture_bg = {
						path = "chest_info/max_can_get_furniture_bg",
						list = {
							txt = {
								path = "chest_info/max_can_get_furniture_bg/txt",
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
					"UITweenSequence",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			jump_warehouse = {
				path = "jump_warehouse",
				list = {
					bg = {
						path = "jump_warehouse/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg_container = {
						path = "jump_warehouse/bg_container",
						list = {
							bg_blue_top = {
								path = "jump_warehouse/bg_container/bg_blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_2 = {
								path = "jump_warehouse/bg_container/bg_blue_top_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_blue_top_3 = {
								path = "jump_warehouse/bg_container/bg_blue_top_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "jump_warehouse/bg_container/line",
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
					title_node = {
						path = "jump_warehouse/title_node",
						list = {
							title = {
								path = "jump_warehouse/title_node/title",
								list = {
									three_point = {
										path = "jump_warehouse/title_node/title/three_point",
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
					},
					tip = {
						path = "jump_warehouse/tip",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					coonfirm_btn = {
						path = "jump_warehouse/coonfirm_btn",
						list = {
							txt = {
								path = "jump_warehouse/coonfirm_btn/txt",
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
						path = "jump_warehouse/cancel_btn",
						list = {
							txt = {
								path = "jump_warehouse/cancel_btn/txt",
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
			chest_open = {
				path = "chest_open",
				list = {
					bg = {
						path = "chest_open/bg",
						list = {
							bg_left = {
								path = "chest_open/bg/bg_left",
								list = {
									bg_left_light = {
										path = "chest_open/bg/bg_left/bg_left_light",
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
							bg_right = {
								path = "chest_open/bg/bg_right",
								list = {
									bg_right_light = {
										path = "chest_open/bg/bg_right/bg_right_light",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UIScaleTweener"
						}
					},
					bg_open_dot = {
						path = "chest_open/bg_open_dot",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					role_ske = {
						path = "chest_open/role_ske",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					chest_ske = {
						path = "chest_open/chest_ske",
						list = {},
						component = {
							"UnityEngine.Transform",
							"UnityEngine.MeshFilter",
							"UnityEngine.MeshRenderer",
							"Spine.Unity.SkeletonAnimation"
						}
					},
					skip_btn = {
						path = "chest_open/skip_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					chest_btn = {
						path = "chest_open/chest_btn",
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
					"UITweenSequence"
				}
			},
			chest_role_skip_btn = {
				path = "chest_role_skip_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			chest_list = {
				path = "chest_list",
				list = {
					bg = {
						path = "chest_list/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIScaleTweener"
						}
					},
					got_line = {
						path = "chest_list/got_line",
						list = {
							title = {
								path = "chest_list/got_line/title",
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
					chest = {
						path = "chest_list/chest",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.GridLayoutGroup"
						}
					},
					cofirm_btn = {
						path = "chest_list/cofirm_btn",
						list = {
							txt = {
								path = "chest_list/cofirm_btn/txt",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UITweenSequence"
				}
			}
		},
		call_node_list = {
			["chest_open_layer/chest_info/black_line"] = "_control.chest_info.black_line",
			["chest_open_layer/chest_info/plus_btn"] = "_control.chest_info.plus_btn",
			["chest_open_layer/chest_info/detail_btn"] = "_control.chest_info.detail_btn",
			["chest_open_layer/jump_warehouse/coonfirm_btn"] = "_control.jump_warehouse.coonfirm_btn",
			["chest_open_layer/chest_info/close_btn"] = "_control.chest_info.close_btn",
			["chest_open_layer/chest_info/black_line_2"] = "_control.chest_info.black_line_2",
			["chest_open_layer/chest_layer/bg_top/mask_bg/bg_blue_top2"] = "_control.chest_layer.bg_top.mask_bg.bg_blue_top2",
			["chest_open_layer/chest_layer/scrollview/content/chest_cell/icon"] = "_control.chest_layer.scrollview.content.chest_cell.icon",
			["chest_open_layer/chest_info/minus_btn"] = "_control.chest_info.minus_btn",
			["chest_open_layer/chest_info/open_sum"] = "_control.chest_info.open_sum",
			["chest_open_layer/chest_layer/scrollview"] = "_control.chest_layer.scrollview",
			["chest_open_layer/chest_open/role_ske"] = "_control.chest_open.role_ske",
			["chest_open_layer/jump_warehouse"] = "_control.jump_warehouse",
			["chest_open_layer/chest_info/detail_btn/txt"] = "_control.chest_info.detail_btn.txt",
			["chest_open_layer/chest_info/have_sum"] = "_control.chest_info.have_sum",
			["chest_open_layer/chest_info/scrollview/content"] = "_control.chest_info.scrollview.content",
			["chest_open_layer/chest_layer/bg_top/mask_bg"] = "_control.chest_layer.bg_top.mask_bg",
			["chest_open_layer/chest_info/scrollview"] = "_control.chest_info.scrollview",
			["chest_open_layer/chest_layer/scrollview/content/chest_cell"] = "_control.chest_layer.scrollview.content.chest_cell",
			["chest_open_layer/chest_info/scrollview/content/info_txt"] = "_control.chest_info.scrollview.content.info_txt",
			["chest_open_layer/chest_info/common_line"] = "_control.chest_info.common_line",
			["chest_open_layer/chest_layer/scrollview/content"] = "_control.chest_layer.scrollview.content",
			["chest_open_layer/chest_info/bg_container"] = "_control.chest_info.bg_container",
			["chest_open_layer/chest_info/title/three_point"] = "_control.chest_info.title.three_point",
			["chest_open_layer/chest_info/bg_container/bg_blue_top_2"] = "_control.chest_info.bg_container.bg_blue_top_2",
			["chest_open_layer/chest_layer/scrollview/content/chest_cell/count_txt"] = "_control.chest_layer.scrollview.content.chest_cell.count_txt",
			["chest_open_layer/chest_layer"] = "_control.chest_layer",
			["chest_open_layer/jump_warehouse/cancel_btn/txt"] = "_control.jump_warehouse.cancel_btn.txt",
			["chest_open_layer/jump_warehouse/bg_container"] = "_control.jump_warehouse.bg_container",
			["chest_open_layer/chest_info/quality/icon"] = "_control.chest_info.quality.icon",
			["chest_open_layer/chest_info/bg_container/bg_cover"] = "_control.chest_info.bg_container.bg_cover",
			["chest_open_layer/chest_layer/scrollview/content/chest_cell/bg"] = "_control.chest_layer.scrollview.content.chest_cell.bg",
			["chest_open_layer/jump_warehouse/bg_container/bg_blue_top"] = "_control.jump_warehouse.bg_container.bg_blue_top",
			["chest_open_layer/chest_layer/close_btn"] = "_control.chest_layer.close_btn",
			["chest_open_layer/chest_info/bg_container/bg_blue_top_3"] = "_control.chest_info.bg_container.bg_blue_top_3",
			["chest_open_layer/chest_layer/bg_top/mask_bg/bg_blue_top"] = "_control.chest_layer.bg_top.mask_bg.bg_blue_top",
			["chest_open_layer/jump_warehouse/bg_container/line"] = "_control.jump_warehouse.bg_container.line",
			["chest_open_layer/chest_layer/bg_top/title"] = "_control.chest_layer.bg_top.title",
			["chest_open_layer/jump_warehouse/bg_container/bg_blue_top_3"] = "_control.jump_warehouse.bg_container.bg_blue_top_3",
			["chest_open_layer/jump_warehouse/title_node/title"] = "_control.jump_warehouse.title_node.title",
			["chest_open_layer/chest_info/bg_container/bg_blue_top"] = "_control.chest_info.bg_container.bg_blue_top",
			["chest_open_layer/chest_open/bg"] = "_control.chest_open.bg",
			["chest_open_layer/chest_open/bg/bg_left"] = "_control.chest_open.bg.bg_left",
			["chest_open_layer/chest_open/bg/bg_left/bg_left_light"] = "_control.chest_open.bg.bg_left.bg_left_light",
			["chest_open_layer/chest_info/sum"] = "_control.chest_info.sum",
			["chest_open_layer/chest_open/bg/bg_right/bg_right_light"] = "_control.chest_open.bg.bg_right.bg_right_light",
			["chest_open_layer/chest_open/bg_open_dot"] = "_control.chest_open.bg_open_dot",
			["chest_open_layer/chest_list/got_line/title"] = "_control.chest_list.got_line.title",
			["chest_open_layer/chest_open/chest_ske"] = "_control.chest_open.chest_ske",
			["chest_open_layer/chest_open/skip_btn"] = "_control.chest_open.skip_btn",
			["chest_open_layer/jump_warehouse/title_node"] = "_control.jump_warehouse.title_node",
			["chest_open_layer/chest_open/chest_btn"] = "_control.chest_open.chest_btn",
			["chest_open_layer/chest_role_skip_btn"] = "_control.chest_role_skip_btn",
			["chest_open_layer/chest_list/bg"] = "_control.chest_list.bg",
			["chest_open_layer/chest_list/got_line"] = "_control.chest_list.got_line",
			["chest_open_layer/chest_layer/bg_top/bg_blue_top3"] = "_control.chest_layer.bg_top.bg_blue_top3",
			["chest_open_layer/chest_info/use_btn"] = "_control.chest_info.use_btn",
			["chest_open_layer/chest_list/chest"] = "_control.chest_list.chest",
			["chest_open_layer/chest_list/cofirm_btn"] = "_control.chest_list.cofirm_btn",
			["chest_open_layer/chest_list/cofirm_btn/txt"] = "_control.chest_list.cofirm_btn.txt",
			["chest_open_layer/chest_info/bg_container/bg"] = "_control.chest_info.bg_container.bg",
			["chest_open_layer/chest_info/max_can_get_furniture_bg/txt"] = "_control.chest_info.max_can_get_furniture_bg.txt",
			["chest_open_layer/chest_layer/scrollview/content/chest_cell/name_bg"] = "_control.chest_layer.scrollview.content.chest_cell.name_bg",
			["chest_open_layer/chest_open/bg/bg_right"] = "_control.chest_open.bg.bg_right",
			["chest_open_layer/chest_layer/bg"] = "_control.chest_layer.bg",
			["chest_open_layer/jump_warehouse/tip"] = "_control.jump_warehouse.tip",
			["chest_open_layer/chest_info/title"] = "_control.chest_info.title",
			["chest_open_layer/jump_warehouse/coonfirm_btn/txt"] = "_control.jump_warehouse.coonfirm_btn.txt",
			["chest_open_layer/chest_open"] = "_control.chest_open",
			["chest_open_layer/jump_warehouse/title_node/title/three_point"] = "_control.jump_warehouse.title_node.title.three_point",
			["chest_open_layer/chest_layer/bg_top/title/three_point"] = "_control.chest_layer.bg_top.title.three_point",
			["chest_open_layer/chest_info/have_sum_txt"] = "_control.chest_info.have_sum_txt",
			["chest_open_layer/chest_layer/scrollview/content/chest_cell/name_bg/name_txt_2"] = "_control.chest_layer.scrollview.content.chest_cell.name_bg.name_txt_2",
			["chest_open_layer/chest_info"] = "_control.chest_info",
			["chest_open_layer/chest_info/max_can_get_furniture_bg"] = "_control.chest_info.max_can_get_furniture_bg",
			["chest_open_layer/jump_warehouse/cancel_btn"] = "_control.jump_warehouse.cancel_btn",
			["chest_open_layer/jump_warehouse/bg"] = "_control.jump_warehouse.bg",
			["chest_open_layer/chest_layer/scrollview/content/chest_cell/name_bg/name_txt"] = "_control.chest_layer.scrollview.content.chest_cell.name_bg.name_txt",
			["chest_open_layer/jump_warehouse/bg_container/bg_blue_top_2"] = "_control.jump_warehouse.bg_container.bg_blue_top_2",
			["chest_open_layer/chest_info/name_txt"] = "_control.chest_info.name_txt",
			["chest_open_layer/chest_layer/bg_top"] = "_control.chest_layer.bg_top",
			["chest_open_layer/chest_list"] = "_control.chest_list",
			["chest_open_layer/chest_info/use_btn/txt"] = "_control.chest_info.use_btn.txt",
			["chest_open_layer/chest_layer/bg_line_1"] = "_control.chest_layer.bg_line_1",
			["chest_open_layer/chest_info/quality"] = "_control.chest_info.quality"
		},
		click = {
			["chest_layer/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["chest_layer/scrollview/content/chest_cell/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["chest_info/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["chest_info/detail_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["chest_info/use_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["jump_warehouse/coonfirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["jump_warehouse/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["chest_open/skip_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["chest_open/chest_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			chest_role_skip_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["chest_list/cofirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			["chest_info/minus_btn"] = {
				tp = "ClickAndLongClickEvent"
			},
			["chest_info/plus_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {
			chest_list = {
				component = "UnityEngine.Canvas",
				path = "chest_list"
			}
		}
	}
}

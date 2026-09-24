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
					tip_title = {
						path = "bg_container/tip_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					desc = {
						path = "bg_container/tip_title/desc",
						list = {
							dot_image = {
								path = "bg_container/tip_title/desc/dot_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							desc_text = {
								path = "bg_container/tip_title/desc/desc_text",
								list = {},
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
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			strengthen_info = {
				path = "strengthen_info",
				list = {
					level_3 = {
						path = "strengthen_info/level_3",
						list = {
							title = {
								path = "strengthen_info/level_3/title",
								list = {
									num = {
										path = "strengthen_info/level_3/title/num",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					level_2 = {
						path = "strengthen_info/level_2",
						list = {
							title = {
								path = "strengthen_info/level_2/title",
								list = {
									num = {
										path = "strengthen_info/level_2/title/num",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					level_1 = {
						path = "strengthen_info/level_1",
						list = {
							title = {
								path = "strengthen_info/level_1/title",
								list = {
									num = {
										path = "strengthen_info/level_1/title/num",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					level_0 = {
						path = "strengthen_info/level_0",
						list = {
							title = {
								path = "strengthen_info/level_0/title",
								list = {
									num = {
										path = "strengthen_info/level_0/title/num",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			all_ship_bg_img = {
				path = "all_ship_bg_img",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			all_ship_bg_img_2 = {
				path = "all_ship_bg_img/all_ship_bg_img_2",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
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
			all_ship = {
				path = "all_ship",
				list = {
					Viewport = {
						path = "all_ship/Viewport",
						list = {
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
									"UnityEngine.CanvasRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.RectMask2D",
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
			Scrollbar = {
				path = "all_ship/Scrollbar",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Scrollbar",
					"UnityEngine.UI.Mask"
				}
			},
			["Sliding Area"] = {
				path = "all_ship/Scrollbar/Sliding Area",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			Handle = {
				path = "all_ship/Scrollbar/Sliding Area/Handle",
				list = {},
				component = {
					"UnityEngine.RectTransform"
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
		call_node_list = {
			["tactics_select_member/sort_order_btn/sort_txt"] = "_control.sort_order_btn.sort_txt",
			["tactics_select_member/all_ship_bg_img"] = "_control.all_ship_bg_img",
			["tactics_select_member/strengthen_info/level_0/title/num"] = "_control.strengthen_info.level_0.title.num",
			["tactics_select_member/strengthen_info/level_1"] = "_control.strengthen_info.level_1",
			["tactics_select_member/strengthen_info/level_0/title"] = "_control.strengthen_info.level_0.title",
			["tactics_select_member/strengthen_info/level_3/title"] = "_control.strengthen_info.level_3.title",
			["tactics_select_member/all_ship/Scrollbar/Sliding Area"] = "_control.Sliding Area",
			["tactics_select_member/strengthen_info/level_1/title"] = "_control.strengthen_info.level_1.title",
			["tactics_select_member/detail_btn"] = "_control.detail_btn",
			["tactics_select_member/bg_container/bg"] = "_control.bg_container.bg",
			["tactics_select_member/all_ship_bg_img/all_ship_bg_img_2"] = "_control.all_ship_bg_img_2",
			["tactics_select_member/strengthen_info/level_2/title"] = "_control.strengthen_info.level_2.title",
			["tactics_select_member/all_ship/Scrollbar"] = "_control.Scrollbar",
			["tactics_select_member/all_ship"] = "_control.all_ship",
			["tactics_select_member/sort_order_btn/sorttype"] = "_control.sort_order_btn.sorttype",
			["tactics_select_member/strengthen_info/level_3"] = "_control.strengthen_info.level_3",
			["tactics_select_member/bg_container/tip_title/desc"] = "_control.bg_container.desc",
			["tactics_select_member/strengthen_info/level_3/title/num"] = "_control.strengthen_info.level_3.title.num",
			["tactics_select_member/all_ship/Viewport/edge_mask"] = "_control.all_ship.Viewport.edge_mask",
			["tactics_select_member/all_ship/Viewport/edge_mask/Content"] = "_control.all_ship.Viewport.edge_mask.Content",
			["tactics_select_member/strengthen_info/level_2/title/num"] = "_control.strengthen_info.level_2.title.num",
			["tactics_select_member/bg_container/tip_title"] = "_control.bg_container.tip_title",
			["tactics_select_member/strengthen_info/level_2"] = "_control.strengthen_info.level_2",
			["tactics_select_member/all_ship/Scrollbar/Sliding Area/Handle"] = "_control.Handle",
			["tactics_select_member/sort_layer"] = "_control.sort_layer",
			["tactics_select_member/type_layer"] = "_control.type_layer",
			["tactics_select_member/bg_container"] = "_control.bg_container",
			["tactics_select_member/cover"] = "_control.cover",
			["tactics_select_member/sort_type_btn/type"] = "_control.sort_type_btn.type",
			["tactics_select_member/bg_container/back_btn"] = "_control.bg_container.back_btn",
			["tactics_select_member/sort_order_btn"] = "_control.sort_order_btn",
			["tactics_select_member/all_ship/Viewport"] = "_control.all_ship.Viewport",
			["tactics_select_member/bg_container/tip_title/desc/desc_text"] = "_control.bg_container.desc.desc_text",
			["tactics_select_member/strengthen_info"] = "_control.strengthen_info",
			["tactics_select_member/detail_btn/detail_status"] = "_control.detail_btn.detail_status",
			["tactics_select_member/sort_type_btn"] = "_control.sort_type_btn",
			["tactics_select_member/detail_btn/pvpdetailbtn"] = "_control.detail_btn.pvpdetailbtn",
			["tactics_select_member/strengthen_info/level_1/title/num"] = "_control.strengthen_info.level_1.title.num",
			["tactics_select_member/bg_container/line_bottom"] = "_control.bg_container.line_bottom",
			["tactics_select_member/bg_container/tip_title/desc/dot_image"] = "_control.bg_container.desc.dot_image",
			["tactics_select_member/sort_type_btn/sort_txt"] = "_control.sort_type_btn.sort_txt",
			["tactics_select_member/strengthen_info/level_0"] = "_control.strengthen_info.level_0",
			["tactics_select_member/bg_container/line_head"] = "_control.bg_container.line_head"
		},
		click = {
			detail_btn = {
				tp = "UnityEngine.UI.Button"
			},
			sort_order_btn = {
				tp = "UnityEngine.UI.Button"
			},
			sort_type_btn = {
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

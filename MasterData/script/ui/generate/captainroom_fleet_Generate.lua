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
							bg_line2 = {
								path = "bg/bg_container/bg_line2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "bg/bg_container/title",
								list = {
									three_point = {
										path = "bg/bg_container/title/three_point",
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
					property = {
						path = "bg/property",
						list = {
							title = {
								path = "bg/property/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							web_img = {
								path = "bg/property/web_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							draw_web = {
								path = "bg/property/draw_web",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Extensions.UIPolygon"
								}
							},
							attr_item_1 = {
								path = "bg/property/attr_item_1",
								list = {
									txt = {
										path = "bg/property/attr_item_1/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									value = {
										path = "bg/property/attr_item_1/value",
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
							attr_item_2 = {
								path = "bg/property/attr_item_2",
								list = {
									txt = {
										path = "bg/property/attr_item_2/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									value = {
										path = "bg/property/attr_item_2/value",
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
							attr_item_3 = {
								path = "bg/property/attr_item_3",
								list = {
									txt = {
										path = "bg/property/attr_item_3/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									value = {
										path = "bg/property/attr_item_3/value",
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
							attr_item_4 = {
								path = "bg/property/attr_item_4",
								list = {
									txt = {
										path = "bg/property/attr_item_4/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									value = {
										path = "bg/property/attr_item_4/value",
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
							attr_item_5 = {
								path = "bg/property/attr_item_5",
								list = {
									txt = {
										path = "bg/property/attr_item_5/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									value = {
										path = "bg/property/attr_item_5/value",
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
							attr_item_6 = {
								path = "bg/property/attr_item_6",
								list = {
									txt = {
										path = "bg/property/attr_item_6/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									value = {
										path = "bg/property/attr_item_6/value",
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
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
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
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							role_2 = {
								path = "bg/role_list/role_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							role_3 = {
								path = "bg/role_list/role_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							role_4 = {
								path = "bg/role_list/role_4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							role_5 = {
								path = "bg/role_list/role_5",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							role_6 = {
								path = "bg/role_list/role_6",
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
					tip = {
						path = "bg/tip",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					func_btn = {
						path = "bg/func_btn",
						list = {
							txt = {
								path = "bg/func_btn/txt",
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
							"UnityEngine.UI.Button",
							"UnityEngine.CanvasRenderer",
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
		call_node_list = {
			["captainroom_fleet/bg/bg_container/bg_line2"] = "_control.bg.bg_container.bg_line2",
			["captainroom_fleet/bg/property/attr_item_5/txt"] = "_control.bg.property.attr_item_5.txt",
			["captainroom_fleet/bg/property/attr_item_5/value"] = "_control.bg.property.attr_item_5.value",
			["captainroom_fleet/bg/property/attr_item_4/value"] = "_control.bg.property.attr_item_4.value",
			["captainroom_fleet/bg/property/attr_item_5"] = "_control.bg.property.attr_item_5",
			["captainroom_fleet/bg/bg_container/bg_white"] = "_control.bg.bg_container.bg_white",
			["captainroom_fleet/bg/property/attr_item_3/value"] = "_control.bg.property.attr_item_3.value",
			["captainroom_fleet/bg/bg_container/mask_bg"] = "_control.bg.bg_container.mask_bg",
			["captainroom_fleet/bg/property/attr_item_2/value"] = "_control.bg.property.attr_item_2.value",
			["captainroom_fleet/bg/property/attr_item_2/txt"] = "_control.bg.property.attr_item_2.txt",
			["captainroom_fleet/bg/close_btn"] = "_control.bg.close_btn",
			["captainroom_fleet/bg/property/attr_item_1/value"] = "_control.bg.property.attr_item_1.value",
			["captainroom_fleet/bg/role_list/role_6"] = "_control.bg.role_list.role_6",
			["captainroom_fleet/bg/property/attr_item_4/txt"] = "_control.bg.property.attr_item_4.txt",
			["captainroom_fleet/bg/role_list/role_3"] = "_control.bg.role_list.role_3",
			["captainroom_fleet/bg/property/draw_web"] = "_control.bg.property.draw_web",
			["captainroom_fleet/bg/property/attr_item_3/txt"] = "_control.bg.property.attr_item_3.txt",
			["captainroom_fleet/bg/property/attr_item_6/value"] = "_control.bg.property.attr_item_6.value",
			["captainroom_fleet/bg/property/attr_item_2"] = "_control.bg.property.attr_item_2",
			["captainroom_fleet/bg/role_list"] = "_control.bg.role_list",
			["captainroom_fleet/bg/role_list/role_2"] = "_control.bg.role_list.role_2",
			["captainroom_fleet/bg/role_list/role_1"] = "_control.bg.role_list.role_1",
			["captainroom_fleet/bg/bg_container/bg_blue_top3"] = "_control.bg.bg_container.bg_blue_top3",
			["captainroom_fleet/bg/property/attr_item_1/txt"] = "_control.bg.property.attr_item_1.txt",
			["captainroom_fleet/bg/property/attr_item_3"] = "_control.bg.property.attr_item_3",
			["captainroom_fleet/bg/func_btn/txt"] = "_control.bg.func_btn.txt",
			["captainroom_fleet/bg/bg_container/title/three_point"] = "_control.bg.bg_container.title.three_point",
			["captainroom_fleet/bg/role_list/role_5"] = "_control.bg.role_list.role_5",
			["captainroom_fleet/bg/property/attr_item_4"] = "_control.bg.property.attr_item_4",
			["captainroom_fleet/bg/tip"] = "_control.bg.tip",
			["captainroom_fleet/bg/role_list/role_4"] = "_control.bg.role_list.role_4",
			["captainroom_fleet/bg/bg_container"] = "_control.bg.bg_container",
			["captainroom_fleet/bg/property/attr_item_6/txt"] = "_control.bg.property.attr_item_6.txt",
			["captainroom_fleet/bg/bg_container/mask_bg/bg_blue_top"] = "_control.bg.bg_container.mask_bg.bg_blue_top",
			["captainroom_fleet/bg"] = "_control.bg",
			["captainroom_fleet/bg/property"] = "_control.bg.property",
			["captainroom_fleet/bg/property/title"] = "_control.bg.property.title",
			["captainroom_fleet/bg/func_btn"] = "_control.bg.func_btn",
			["captainroom_fleet/bg/bg_container/title"] = "_control.bg.bg_container.title",
			["captainroom_fleet/bg/bg_container/mask_bg/bg_blue_top2"] = "_control.bg.bg_container.mask_bg.bg_blue_top2",
			["captainroom_fleet/bg/property/attr_item_6"] = "_control.bg.property.attr_item_6",
			["captainroom_fleet/bg/property/attr_item_1"] = "_control.bg.property.attr_item_1",
			["captainroom_fleet/bg/role_list_1"] = "_control.bg.role_list_1",
			["captainroom_fleet/bg/property/web_img"] = "_control.bg.property.web_img"
		},
		click = {
			["bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/role_list/role_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/role_list/role_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/role_list/role_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/role_list/role_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/role_list/role_5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/role_list/role_6"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/func_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

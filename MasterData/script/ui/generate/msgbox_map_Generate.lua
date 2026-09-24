return {
	_rule_ = {
		none = {
			emptybox = {
				path = "emptybox",
				list = {},
				component = {
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			main = {
				path = "main",
				list = {
					name_dd = {
						path = "main/name_dd",
						list = {
							name_dd_1 = {
								path = "main/name_dd/name_dd_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							name_dd_2 = {
								path = "main/name_dd/name_dd_2",
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
							"UnityEngine.UI.Mask",
							"TextHorizonScroller",
							"UnityEngine.UI.Image"
						}
					},
					confirm = {
						path = "main/confirm",
						list = {
							ship_detail_txt = {
								path = "main/confirm/ship_detail_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			top = {
				path = "main/top",
				list = {
					ship_headpic_area = {
						path = "main/top/ship_headpic_area",
						list = {
							ship_headpic = {
								path = "main/top/ship_headpic_area/ship_headpic",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask"
				}
			},
			reduce_cd = {
				path = "main/reduce_cd",
				list = {
					item_1 = {
						path = "main/reduce_cd/item_1",
						list = {
							title_1 = {
								path = "main/reduce_cd/item_1/title_1",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							next_btn_1 = {
								path = "main/reduce_cd/item_1/next_btn_1",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					item_2 = {
						path = "main/reduce_cd/item_2",
						list = {
							title_2 = {
								path = "main/reduce_cd/item_2/title_2",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							next_btn_2 = {
								path = "main/reduce_cd/item_2/next_btn_2",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					item_3 = {
						path = "main/reduce_cd/item_3",
						list = {
							title_3 = {
								path = "main/reduce_cd/item_3/title_3",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							next_btn_3 = {
								path = "main/reduce_cd/item_3/next_btn_3",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					item_4 = {
						path = "main/reduce_cd/item_4",
						list = {
							title_4 = {
								path = "main/reduce_cd/item_4/title_4",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							next_btn_4 = {
								path = "main/reduce_cd/item_4/next_btn_4",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					}
				},
				component = {}
			},
			txt_1 = {
				path = "main/reduce_cd/item_1/next_btn_1/txt_1",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			txt_2 = {
				path = "main/reduce_cd/item_2/next_btn_2/txt_2",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			txt_3 = {
				path = "main/reduce_cd/item_3/next_btn_3/txt_3",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			txt_4 = {
				path = "main/reduce_cd/item_4/next_btn_4/txt_4",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			return_btn = {
				path = "main/return_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["msgbox_map/main/reduce_cd/item_2/title_2"] = "_control.reduce_cd.item_2.title_2",
			["msgbox_map/main/reduce_cd"] = "_control.reduce_cd",
			["msgbox_map/main/top/ship_headpic_area"] = "_control.top.ship_headpic_area",
			["msgbox_map/main/reduce_cd/item_2"] = "_control.reduce_cd.item_2",
			["msgbox_map/emptybox"] = "_control.emptybox",
			["msgbox_map/main/reduce_cd/item_4/title_4"] = "_control.reduce_cd.item_4.title_4",
			["msgbox_map/main/reduce_cd/item_1/title_1"] = "_control.reduce_cd.item_1.title_1",
			["msgbox_map/main/name_dd"] = "_control.main.name_dd",
			["msgbox_map/main/reduce_cd/item_4/next_btn_4"] = "_control.reduce_cd.item_4.next_btn_4",
			["msgbox_map/main/reduce_cd/item_1"] = "_control.reduce_cd.item_1",
			["msgbox_map/main/reduce_cd/item_3/title_3"] = "_control.reduce_cd.item_3.title_3",
			["msgbox_map/main/top"] = "_control.top",
			["msgbox_map/main/reduce_cd/item_2/next_btn_2"] = "_control.reduce_cd.item_2.next_btn_2",
			["msgbox_map/main/name_dd/name_dd_1"] = "_control.main.name_dd.name_dd_1",
			["msgbox_map/main/reduce_cd/item_3/next_btn_3"] = "_control.reduce_cd.item_3.next_btn_3",
			["msgbox_map/main/reduce_cd/item_4/next_btn_4/txt_4"] = "_control.txt_4",
			["msgbox_map/main/reduce_cd/item_4"] = "_control.reduce_cd.item_4",
			["msgbox_map/main/confirm"] = "_control.main.confirm",
			["msgbox_map/main/reduce_cd/item_1/next_btn_1"] = "_control.reduce_cd.item_1.next_btn_1",
			["msgbox_map/main/reduce_cd/item_2/next_btn_2/txt_2"] = "_control.txt_2",
			["msgbox_map/main/name_dd/name_dd_2"] = "_control.main.name_dd.name_dd_2",
			["msgbox_map/main/confirm/ship_detail_txt"] = "_control.main.confirm.ship_detail_txt",
			["msgbox_map/main/reduce_cd/item_3/next_btn_3/txt_3"] = "_control.txt_3",
			["msgbox_map/main/top/ship_headpic_area/ship_headpic"] = "_control.top.ship_headpic_area.ship_headpic",
			["msgbox_map/main/return_btn"] = "_control.return_btn",
			["msgbox_map/main/reduce_cd/item_1/next_btn_1/txt_1"] = "_control.txt_1",
			["msgbox_map/main"] = "_control.main",
			["msgbox_map/main/reduce_cd/item_3"] = "_control.reduce_cd.item_3"
		},
		click = {
			["main/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/reduce_cd/item_1/next_btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/reduce_cd/item_2/next_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/reduce_cd/item_3/next_btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/reduce_cd/item_4/next_btn_4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

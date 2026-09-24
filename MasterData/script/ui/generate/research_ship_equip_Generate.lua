return {
	_rule_ = {
		none = {
			bg_container = {
				path = "bg_container",
				list = {
					tip_title = {
						path = "bg_container/tip_title",
						list = {
							desc_text = {
								path = "bg_container/tip_title/desc/desc_text",
								list = {},
								component = {
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					back_btn = {
						path = "bg_container/back_btn",
						list = {},
						component = {
							"ScaleButton"
						}
					}
				},
				component = {}
			},
			equip_content = {
				path = "equip_content",
				list = {
					equip_capacity = {
						path = "equip_content/equip_capacity",
						list = {
							dockcapacity = {
								path = "equip_content/equip_capacity/dockcapacity",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							amount_txt = {
								path = "equip_content/equip_capacity/amount_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
					},
					equip_num = {
						path = "equip_content/equip_num",
						list = {
							research_need_txt = {
								path = "equip_content/equip_num/research_need_txt",
								list = {
									need_equip = {
										path = "equip_content/equip_num/research_need_txt/need_equip",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							research_select_txt = {
								path = "equip_content/equip_num/research_select_txt",
								list = {
									select_equip = {
										path = "equip_content/equip_num/research_select_txt/select_equip",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
					},
					type_btn = {
						path = "equip_content/type_btn",
						list = {
							type = {
								path = "equip_content/type_btn/type",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							type_txt = {
								path = "equip_content/type_btn/type_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					ok_btn = {
						path = "equip_content/ok_btn",
						list = {
							title = {
								path = "equip_content/ok_btn/title",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			title = {
				path = "equip_content/title",
				list = {},
				component = {
					"UnityEngine.UI.Text"
				}
			},
			all_equip = {
				path = "equip_content/all_equip",
				list = {
					viewport = {
						path = "equip_content/all_equip/viewport",
						list = {
							content = {
								path = "equip_content/all_equip/viewport/content",
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
					},
					["Scrollbar Vertical"] = {
						path = "equip_content/all_equip/Scrollbar Vertical",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Scrollbar"
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
			["Sliding Area"] = {
				path = "equip_content/all_equip/Scrollbar Vertical/Sliding Area",
				list = {},
				component = {}
			},
			Handle = {
				path = "equip_content/all_equip/Scrollbar Vertical/Sliding Area/Handle",
				list = {},
				component = {}
			},
			tip_layer = {
				path = "tip_layer",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["research_ship_equip/equip_content/equip_capacity/amount_txt"] = "_control.equip_content.equip_capacity.amount_txt",
			["research_ship_equip/equip_content/equip_num/research_need_txt"] = "_control.equip_content.equip_num.research_need_txt",
			["research_ship_equip/equip_content/equip_capacity"] = "_control.equip_content.equip_capacity",
			["research_ship_equip/equip_content/all_equip/viewport"] = "_control.all_equip.viewport",
			["research_ship_equip/equip_content/type_btn/type_txt"] = "_control.equip_content.type_btn.type_txt",
			["research_ship_equip/bg_container/tip_title"] = "_control.bg_container.tip_title",
			["research_ship_equip/equip_content/title"] = "_control.title",
			["research_ship_equip/equip_content/ok_btn"] = "_control.equip_content.ok_btn",
			["research_ship_equip/equip_content/equip_num/research_need_txt/need_equip"] = "_control.equip_content.equip_num.research_need_txt.need_equip",
			["research_ship_equip/equip_content/all_equip/Scrollbar Vertical"] = "_control.all_equip.Scrollbar Vertical",
			["research_ship_equip/bg_container/tip_title/desc/desc_text"] = "_control.bg_container.tip_title.desc_text",
			["research_ship_equip/equip_content/all_equip/Scrollbar Vertical/Sliding Area"] = "_control.Sliding Area",
			["research_ship_equip/equip_content/all_equip/Scrollbar Vertical/Sliding Area/Handle"] = "_control.Handle",
			["research_ship_equip/equip_content/type_btn/type"] = "_control.equip_content.type_btn.type",
			["research_ship_equip/equip_content/equip_num/research_select_txt"] = "_control.equip_content.equip_num.research_select_txt",
			["research_ship_equip/tip_layer"] = "_control.tip_layer",
			["research_ship_equip/equip_content/all_equip/viewport/content"] = "_control.all_equip.viewport.content",
			["research_ship_equip/equip_content/equip_num"] = "_control.equip_content.equip_num",
			["research_ship_equip/equip_content"] = "_control.equip_content",
			["research_ship_equip/bg_container/back_btn"] = "_control.bg_container.back_btn",
			["research_ship_equip/equip_content/equip_num/research_select_txt/select_equip"] = "_control.equip_content.equip_num.research_select_txt.select_equip",
			["research_ship_equip/equip_content/type_btn"] = "_control.equip_content.type_btn",
			["research_ship_equip/bg_container"] = "_control.bg_container",
			["research_ship_equip/equip_content/all_equip"] = "_control.all_equip",
			["research_ship_equip/equip_content/equip_capacity/dockcapacity"] = "_control.equip_content.equip_capacity.dockcapacity",
			["research_ship_equip/equip_content/ok_btn/title"] = "_control.equip_content.ok_btn.title"
		},
		click = {
			["equip_content/type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["equip_content/ok_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			tip_layer = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["bg_container/back_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

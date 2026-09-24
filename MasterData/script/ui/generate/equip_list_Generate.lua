return {
	_rule_ = {
		none = {
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
					tip_title = {
						path = "bg_container/tip_title",
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
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			desc = {
				path = "bg_container/tip_title/desc",
				list = {
					desc_text = {
						path = "bg_container/tip_title/desc/desc_text",
						list = {},
						component = {
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					desc_text_mask = {
						path = "bg_container/tip_title/desc/desc_text_mask",
						list = {
							txt = {
								path = "bg_container/tip_title/desc/desc_text_mask/txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							txt_2 = {
								path = "bg_container/tip_title/desc/desc_text_mask/txt_2",
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
							"TextHorizonScroller"
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
							black_line = {
								path = "equip_content/equip_capacity/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							dockcapacity = {
								path = "equip_content/equip_capacity/dockcapacity",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							amount_txt = {
								path = "equip_content/equip_capacity/amount_txt",
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
					search = {
						path = "equip_content/search",
						list = {
							input_text = {
								path = "equip_content/search/input_text",
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
					show_use_btn = {
						path = "equip_content/show_use_btn",
						list = {
							show_use_btn_btn = {
								path = "equip_content/show_use_btn/show_use_btn_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title_mask = {
								path = "equip_content/show_use_btn/title_mask",
								list = {
									txt = {
										path = "equip_content/show_use_btn/title_mask/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_2 = {
										path = "equip_content/show_use_btn/title_mask/txt_2",
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
									"TextHorizonScroller"
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
						path = "equip_content/sort_type_btn",
						list = {
							type = {
								path = "equip_content/sort_type_btn/type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							type_txt = {
								path = "equip_content/sort_type_btn/type_txt",
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
					type_btn = {
						path = "equip_content/type_btn",
						list = {
							type = {
								path = "equip_content/type_btn/type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							type_txt = {
								path = "equip_content/type_btn/type_txt",
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
					change_lock_btn = {
						path = "equip_content/change_lock_btn",
						list = {
							title = {
								path = "equip_content/change_lock_btn/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							lock = {
								path = "equip_content/change_lock_btn/lock",
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
							"UnityEngine.UI.Button"
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
								list = {
									["Sliding Area"] = {
										path = "equip_content/all_equip/Scrollbar Vertical/Sliding Area",
										list = {
											Handle = {
												path = "equip_content/all_equip/Scrollbar Vertical/Sliding Area/Handle",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					type_layer = {
						path = "equip_content/type_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			tip_layer = {
				path = "tip_layer",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["equip_list/bg_container/tip_title/desc"] = "_control.desc",
			["equip_list/equip_content/type_btn/type_txt"] = "_control.equip_content.type_btn.type_txt",
			["equip_list/equip_content/all_equip/Scrollbar Vertical/Sliding Area/Handle"] = "_control.equip_content.all_equip.Scrollbar Vertical.Sliding Area.Handle",
			["equip_list/bg_container/tip_title/desc/desc_text_mask/txt_2"] = "_control.desc.desc_text_mask.txt_2",
			["equip_list/bg_container/tip_title/desc/desc_text_mask"] = "_control.desc.desc_text_mask",
			["equip_list/bg_container/line_head"] = "_control.bg_container.line_head",
			["equip_list/equip_content/all_equip/Scrollbar Vertical"] = "_control.equip_content.all_equip.Scrollbar Vertical",
			["equip_list/equip_content/sort_type_btn"] = "_control.equip_content.sort_type_btn",
			["equip_list/equip_content/all_equip/viewport"] = "_control.equip_content.all_equip.viewport",
			["equip_list/bg_container/bg"] = "_control.bg_container.bg",
			["equip_list/equip_content/all_equip/Scrollbar Vertical/Sliding Area"] = "_control.equip_content.all_equip.Scrollbar Vertical.Sliding Area",
			["equip_list/equip_content/search/input_text"] = "_control.equip_content.search.input_text",
			["equip_list/tip_layer"] = "_control.tip_layer",
			["equip_list/equip_content/change_lock_btn/title"] = "_control.equip_content.change_lock_btn.title",
			["equip_list/equip_content/all_equip/viewport/content"] = "_control.equip_content.all_equip.viewport.content",
			["equip_list/equip_content/equip_capacity/dockcapacity"] = "_control.equip_content.equip_capacity.dockcapacity",
			["equip_list/equip_content/sort_type_btn/type"] = "_control.equip_content.sort_type_btn.type",
			["equip_list/equip_content/change_lock_btn"] = "_control.equip_content.change_lock_btn",
			["equip_list/equip_content/change_lock_btn/lock"] = "_control.equip_content.change_lock_btn.lock",
			["equip_list/equip_content/equip_capacity/amount_txt"] = "_control.equip_content.equip_capacity.amount_txt",
			["equip_list/equip_content/all_equip"] = "_control.equip_content.all_equip",
			["equip_list/equip_content/type_btn"] = "_control.equip_content.type_btn",
			["equip_list/equip_content/show_use_btn/title_mask/txt_2"] = "_control.equip_content.show_use_btn.title_mask.txt_2",
			["equip_list/bg_container/back_btn"] = "_control.bg_container.back_btn",
			["equip_list/equip_content/show_use_btn/show_use_btn_btn"] = "_control.equip_content.show_use_btn.show_use_btn_btn",
			["equip_list/equip_content/show_use_btn/title_mask/txt"] = "_control.equip_content.show_use_btn.title_mask.txt",
			["equip_list/bg_container/tip_title"] = "_control.bg_container.tip_title",
			["equip_list/equip_content/equip_capacity"] = "_control.equip_content.equip_capacity",
			["equip_list/equip_content/sort_type_btn/type_txt"] = "_control.equip_content.sort_type_btn.type_txt",
			["equip_list/equip_content/equip_capacity/black_line"] = "_control.equip_content.equip_capacity.black_line",
			["equip_list/equip_content"] = "_control.equip_content",
			["equip_list/bg_container/tip_title/desc/desc_text_mask/txt"] = "_control.desc.desc_text_mask.txt",
			["equip_list/equip_content/type_btn/type"] = "_control.equip_content.type_btn.type",
			["equip_list/bg_container/tip_title/desc/desc_text"] = "_control.desc.desc_text",
			["equip_list/equip_content/search"] = "_control.equip_content.search",
			["equip_list/bg_container"] = "_control.bg_container",
			["equip_list/bg_container/line_bottom"] = "_control.bg_container.line_bottom",
			["equip_list/equip_content/type_layer"] = "_control.equip_content.type_layer",
			["equip_list/equip_content/show_use_btn/title_mask"] = "_control.equip_content.show_use_btn.title_mask",
			["equip_list/equip_content/show_use_btn"] = "_control.equip_content.show_use_btn"
		},
		click = {
			["equip_content/show_use_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["equip_content/sort_type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["equip_content/type_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["equip_content/change_lock_btn"] = {
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

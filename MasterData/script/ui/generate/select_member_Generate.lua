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
					mp_npc = {
						path = "bg_container/mp_npc",
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
						list = {
							desc = {
								path = "bg_container/tip_title/desc",
								list = {},
								component = {}
							},
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
					search = {
						path = "bg_container/search",
						list = {
							input_text = {
								path = "bg_container/search/input_text",
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
					ship_capacity = {
						path = "bg_container/ship_capacity",
						list = {
							black_line = {
								path = "bg_container/ship_capacity/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							dockcapacity = {
								path = "bg_container/ship_capacity/dockcapacity",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							amount_txt = {
								path = "bg_container/ship_capacity/amount_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							total_txt = {
								path = "bg_container/ship_capacity/total_txt",
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
			ship_six_info = {
				path = "ship_six_info",
				list = {
					info_bg1 = {
						path = "ship_six_info/info_bg1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					info_bg2 = {
						path = "ship_six_info/info_bg2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					info_bg3 = {
						path = "ship_six_info/info_bg3",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					small_ship = {
						path = "ship_six_info/small_ship",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					small_ship_count = {
						path = "ship_six_info/small_ship_count",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					middle_ship = {
						path = "ship_six_info/middle_ship",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					middle_ship_count = {
						path = "ship_six_info/middle_ship_count",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					big_ship = {
						path = "ship_six_info/big_ship",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					big_ship_count = {
						path = "ship_six_info/big_ship_count",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			full_skill_btn = {
				path = "full_skill_btn",
				list = {
					fullskill = {
						path = "full_skill_btn/fullskill",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					status = {
						path = "full_skill_btn/status",
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
			strengthen_info = {
				path = "strengthen_info",
				list = {
					bg = {
						path = "strengthen_info/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					atk_title = {
						path = "strengthen_info/atk_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					tor_title = {
						path = "strengthen_info/tor_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					def_title = {
						path = "strengthen_info/def_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					airDef_title = {
						path = "strengthen_info/airDef_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					atk = {
						path = "strengthen_info/atk",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					torpedo = {
						path = "strengthen_info/torpedo",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					def = {
						path = "strengthen_info/def",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					air_def = {
						path = "strengthen_info/air_def",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			research_ship_info = {
				path = "research_ship_info",
				list = {
					bg = {
						path = "research_ship_info/bg",
						list = {
							need_text = {
								path = "research_ship_info/bg/need_text",
								list = {
									need_txt = {
										path = "research_ship_info/bg/need_text/need_txt",
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
							have_text = {
								path = "research_ship_info/bg/have_text",
								list = {
									have_txt = {
										path = "research_ship_info/bg/have_text/have_txt",
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
						component = {
							"UnityEngine.UI.Image"
						}
					},
					research_confirm_fast_btn = {
						path = "research_ship_info/research_confirm_fast_btn",
						list = {
							research_confirm_fast_btn_txt = {
								path = "research_ship_info/research_confirm_fast_btn/research_confirm_fast_btn_txt",
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
					research_clearall_fast_btn = {
						path = "research_ship_info/research_clearall_fast_btn",
						list = {
							research_clearall_fast_btn_txt = {
								path = "research_ship_info/research_clearall_fast_btn/research_clearall_fast_btn_txt",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer"
				}
			},
			bg_line = {
				path = "research_ship_info/bg/bg_line",
				list = {},
				component = {
					"UnityEngine.UI.Image"
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
			all_ship_info = {
				path = "all_ship_info",
				list = {
					all_ship_info_txt_2 = {
						path = "all_ship_info/all_ship_info_txt_2",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					all_ship_info_txt = {
						path = "all_ship_info/all_ship_info_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					all_ship_btn_bg = {
						path = "all_ship_info/all_ship_btn_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					custom_ship_btn = {
						path = "all_ship_info/custom_ship_btn",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					all_ship_btn_txt = {
						path = "all_ship_info/all_ship_btn_txt",
						list = {
							all_ship_2_btn = {
								path = "all_ship_info/all_ship_btn_txt/all_ship_2_btn",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.Button"
						}
					},
					custom_ship_2 = {
						path = "all_ship_info/custom_ship_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			},
			custom_ship_info = {
				path = "custom_ship_info",
				list = {
					custom_img = {
						path = "custom_ship_info/custom_img",
						list = {
							custom_num = {
								path = "custom_ship_info/custom_img/custom_num",
								list = {},
								component = {
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
				component = {}
			},
			confirm_fast_btn = {
				path = "confirm_fast_btn",
				list = {
					confirm_fast_btn_txt = {
						path = "confirm_fast_btn/confirm_fast_btn_txt",
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
			clearall_fast_btn = {
				path = "clearall_fast_btn",
				list = {
					clearall_fast_btn_txt = {
						path = "clearall_fast_btn/clearall_fast_btn_txt",
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
			auto_btn = {
				path = "auto_btn",
				list = {
					changefleetfast = {
						path = "auto_btn/changefleetfast",
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
			full_strengthen_btn = {
				path = "full_strengthen_btn",
				list = {
					fullstrengthen = {
						path = "full_strengthen_btn/fullstrengthen",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					status = {
						path = "full_strengthen_btn/status",
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
			custom_editor_btn = {
				path = "custom_editor_btn",
				list = {
					custom_editor = {
						path = "custom_editor_btn/custom_editor",
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
			auto_select_confirm_btn = {
				path = "auto_select_confirm_btn",
				list = {
					auto_select_txt = {
						path = "auto_select_confirm_btn/auto_select_txt",
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
			cancel_editor_btn = {
				path = "cancel_editor_btn",
				list = {
					cancel_editor_txt = {
						path = "cancel_editor_btn/cancel_editor_txt",
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
			},
			comfirm_custom_btn = {
				path = "comfirm_custom_btn",
				list = {
					comfirm_custom_txt = {
						path = "comfirm_custom_btn/comfirm_custom_txt",
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
					},
					Scrollbar = {
						path = "all_ship/Scrollbar",
						list = {
							["Sliding Area"] = {
								path = "all_ship/Scrollbar/Sliding Area",
								list = {
									Handle = {
										path = "all_ship/Scrollbar/Sliding Area/Handle",
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
			bg_pic = {
				path = "bg_pic",
				list = {},
				component = {
					"UnityEngine.RectTransform",
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
		call_node_list = {
			["select_member/bg_container/bg"] = "_control.bg_container.bg",
			["select_member/research_ship_info/research_clearall_fast_btn"] = "_control.research_ship_info.research_clearall_fast_btn",
			["select_member/ship_six_info/info_bg1"] = "_control.ship_six_info.info_bg1",
			["select_member/research_ship_info/bg/need_text/need_txt"] = "_control.research_ship_info.bg.need_text.need_txt",
			["select_member/bg_container/select_team_basic"] = "_control.bg_container.select_team_basic",
			["select_member/bg_container/ship_capacity/dockcapacity"] = "_control.bg_container.ship_capacity.dockcapacity",
			["select_member/ship_six_info/small_ship"] = "_control.ship_six_info.small_ship",
			["select_member/all_ship_info/all_ship_btn_txt"] = "_control.all_ship_info.all_ship_btn_txt",
			["select_member/strengthen_info/airDef_title"] = "_control.strengthen_info.airDef_title",
			["select_member/fast_btn/changefleetfast"] = "_control.fast_btn.changefleetfast",
			["select_member/bg_container/tip_title/desc"] = "_control.bg_container.tip_title.desc",
			["select_member/strengthen_info/tor_title"] = "_control.strengthen_info.tor_title",
			["select_member/strengthen_info/atk_title"] = "_control.strengthen_info.atk_title",
			["select_member/research_ship_info/bg/need_text"] = "_control.research_ship_info.bg.need_text",
			["select_member/comfirm_custom_btn"] = "_control.comfirm_custom_btn",
			["select_member/fast_btn"] = "_control.fast_btn",
			["select_member/strengthen_info/def"] = "_control.strengthen_info.def",
			["select_member/strengthen_info/torpedo"] = "_control.strengthen_info.torpedo",
			["select_member/bg_container/line_bottom"] = "_control.bg_container.line_bottom",
			["select_member/ship_six_info/info_bg3"] = "_control.ship_six_info.info_bg3",
			["select_member/bg_container/ship_capacity/black_line"] = "_control.bg_container.ship_capacity.black_line",
			["select_member/research_ship_info/bg/have_text/have_txt"] = "_control.research_ship_info.bg.have_text.have_txt",
			["select_member/all_ship_info/all_ship_btn_bg"] = "_control.all_ship_info.all_ship_btn_bg",
			["select_member/full_skill_btn"] = "_control.full_skill_btn",
			["select_member/custom_editor_btn"] = "_control.custom_editor_btn",
			["select_member/full_strengthen_btn"] = "_control.full_strengthen_btn",
			["select_member/research_ship_info/research_clearall_fast_btn/research_clearall_fast_btn_txt"] = "_control.research_ship_info.research_clearall_fast_btn.research_clearall_fast_btn_txt",
			["select_member/custom_ship_info"] = "_control.custom_ship_info",
			["select_member/full_strengthen_btn/status"] = "_control.full_strengthen_btn.status",
			["select_member/clearall_fast_btn"] = "_control.clearall_fast_btn",
			["select_member/all_ship_info/all_ship_btn_txt/all_ship_2_btn"] = "_control.all_ship_info.all_ship_btn_txt.all_ship_2_btn",
			["select_member/all_ship/Viewport/edge_mask"] = "_control.all_ship.Viewport.edge_mask",
			["select_member/ship_six_info/info_bg2"] = "_control.ship_six_info.info_bg2",
			["select_member/research_ship_info/bg"] = "_control.research_ship_info.bg",
			["select_member/ship_six_info/middle_ship"] = "_control.ship_six_info.middle_ship",
			["select_member/all_ship_info/custom_ship_2"] = "_control.all_ship_info.custom_ship_2",
			["select_member/bg_container/mp_npc"] = "_control.bg_container.mp_npc",
			["select_member/detail_btn/detail_status"] = "_control.detail_btn.detail_status",
			["select_member/bg_container/tip_title"] = "_control.bg_container.tip_title",
			["select_member/sort_type_btn/sort_txt"] = "_control.sort_type_btn.sort_txt",
			["select_member/auto_btn"] = "_control.auto_btn",
			["select_member/auto_select_confirm_btn"] = "_control.auto_select_confirm_btn",
			["select_member/bg_container/ship_capacity"] = "_control.bg_container.ship_capacity",
			["select_member/auto_select_confirm_btn/auto_select_txt"] = "_control.auto_select_confirm_btn.auto_select_txt",
			["select_member/confirm_btn"] = "_control.confirm_btn",
			["select_member/cancel_editor_btn"] = "_control.cancel_editor_btn",
			["select_member/cancel_editor_btn/cancel_editor_txt"] = "_control.cancel_editor_btn.cancel_editor_txt",
			["select_member/bg_container/tip_title/desc/desc_text"] = "_control.bg_container.tip_title.desc_text",
			["select_member/ship_six_info/small_ship_count"] = "_control.ship_six_info.small_ship_count",
			["select_member/comfirm_custom_btn/comfirm_custom_txt"] = "_control.comfirm_custom_btn.comfirm_custom_txt",
			["select_member/strengthen_info/atk"] = "_control.strengthen_info.atk",
			["select_member/bg_container/search/input_text"] = "_control.bg_container.search.input_text",
			["select_member/ship_six_info"] = "_control.ship_six_info",
			["select_member/bg_container/back_btn"] = "_control.bg_container.back_btn",
			["select_member/sort_type_btn"] = "_control.sort_type_btn",
			["select_member/all_ship"] = "_control.all_ship",
			["select_member/all_ship/Viewport"] = "_control.all_ship.Viewport",
			["select_member/all_ship/Scrollbar/Sliding Area"] = "_control.all_ship.Scrollbar.Sliding Area",
			["select_member/ship_six_info/big_ship_count"] = "_control.ship_six_info.big_ship_count",
			["select_member/all_ship_info/all_ship_info_txt_2"] = "_control.all_ship_info.all_ship_info_txt_2",
			["select_member/all_ship/Viewport/edge_mask/Content"] = "_control.all_ship.Viewport.edge_mask.Content",
			["select_member/bg_container/line_head"] = "_control.bg_container.line_head",
			["select_member/ship_six_info/middle_ship_count"] = "_control.ship_six_info.middle_ship_count",
			["select_member/strengthen_info"] = "_control.strengthen_info",
			["select_member/all_ship/Scrollbar"] = "_control.all_ship.Scrollbar",
			["select_member/detail_btn"] = "_control.detail_btn",
			["select_member/all_ship/Scrollbar/Sliding Area/Handle"] = "_control.all_ship.Scrollbar.Sliding Area.Handle",
			["select_member/bg_pic"] = "_control.bg_pic",
			["select_member/confirm_fast_btn"] = "_control.confirm_fast_btn",
			["select_member/sort_layer"] = "_control.sort_layer",
			["select_member/full_skill_btn/fullskill"] = "_control.full_skill_btn.fullskill",
			["select_member/bg_container/search"] = "_control.bg_container.search",
			["select_member/type_layer"] = "_control.type_layer",
			["select_member/research_ship_info/bg/have_text"] = "_control.research_ship_info.bg.have_text",
			["select_member/custom_editor_btn/custom_editor"] = "_control.custom_editor_btn.custom_editor",
			["select_member/sort_order_btn/sort_txt"] = "_control.sort_order_btn.sort_txt",
			["select_member/strengthen_info/air_def"] = "_control.strengthen_info.air_def",
			["select_member/confirm_btn/confirm"] = "_control.confirm_btn.confirm",
			["select_member/custom_ship_info/custom_img"] = "_control.custom_ship_info.custom_img",
			["select_member/bg_container"] = "_control.bg_container",
			["select_member/full_strengthen_btn/fullstrengthen"] = "_control.full_strengthen_btn.fullstrengthen",
			["select_member/strengthen_info/bg"] = "_control.strengthen_info.bg",
			["select_member/auto_btn/changefleetfast"] = "_control.auto_btn.changefleetfast",
			["select_member/all_ship_info"] = "_control.all_ship_info",
			["select_member/bg_container/ship_capacity/total_txt"] = "_control.bg_container.ship_capacity.total_txt",
			["select_member/sort_order_btn"] = "_control.sort_order_btn",
			["select_member/research_ship_info/research_confirm_fast_btn"] = "_control.research_ship_info.research_confirm_fast_btn",
			["select_member/research_ship_info"] = "_control.research_ship_info",
			["select_member/detail_btn/pvpdetailbtn"] = "_control.detail_btn.pvpdetailbtn",
			["select_member/ship_six_info/big_ship"] = "_control.ship_six_info.big_ship",
			["select_member/cover"] = "_control.cover",
			["select_member/sort_type_btn/type"] = "_control.sort_type_btn.type",
			["select_member/research_ship_info/bg/bg_line"] = "_control.bg_line",
			["select_member/sort_order_btn/sorttype"] = "_control.sort_order_btn.sorttype",
			["select_member/clearall_fast_btn/clearall_fast_btn_txt"] = "_control.clearall_fast_btn.clearall_fast_btn_txt",
			["select_member/all_ship_info/custom_ship_btn"] = "_control.all_ship_info.custom_ship_btn",
			["select_member/bg_container/ship_capacity/amount_txt"] = "_control.bg_container.ship_capacity.amount_txt",
			["select_member/research_ship_info/research_confirm_fast_btn/research_confirm_fast_btn_txt"] = "_control.research_ship_info.research_confirm_fast_btn.research_confirm_fast_btn_txt",
			["select_member/confirm_fast_btn/confirm_fast_btn_txt"] = "_control.confirm_fast_btn.confirm_fast_btn_txt",
			["select_member/all_ship_info/all_ship_info_txt"] = "_control.all_ship_info.all_ship_info_txt",
			["select_member/strengthen_info/def_title"] = "_control.strengthen_info.def_title",
			["select_member/custom_ship_info/custom_img/custom_num"] = "_control.custom_ship_info.custom_img.custom_num",
			["select_member/full_skill_btn/status"] = "_control.full_skill_btn.status"
		},
		click = {
			full_skill_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["research_ship_info/research_confirm_fast_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["research_ship_info/research_clearall_fast_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			fast_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["all_ship_info/custom_ship_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["all_ship_info/all_ship_btn_txt"] = {
				tp = "UnityEngine.UI.Button"
			},
			["all_ship_info/all_ship_btn_txt/all_ship_2_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["all_ship_info/custom_ship_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["custom_ship_info/custom_img"] = {
				tp = "UnityEngine.UI.Button"
			},
			confirm_fast_btn = {
				tp = "UnityEngine.UI.Button"
			},
			clearall_fast_btn = {
				tp = "UnityEngine.UI.Button"
			},
			auto_btn = {
				tp = "UnityEngine.UI.Button"
			},
			full_strengthen_btn = {
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
			custom_editor_btn = {
				tp = "UnityEngine.UI.Button"
			},
			auto_select_confirm_btn = {
				tp = "UnityEngine.UI.Button"
			},
			confirm_btn = {
				tp = "UnityEngine.UI.Button"
			},
			cancel_editor_btn = {
				tp = "UnityEngine.UI.Button"
			},
			comfirm_custom_btn = {
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

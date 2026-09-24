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
			base_panel = {
				path = "base_panel",
				list = {
					vertical_bar = {
						path = "base_panel/vertical_bar",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top_decore = {
						path = "base_panel/top_decore",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top = {
						path = "base_panel/top",
						list = {
							ship_headpic_area = {
								path = "base_panel/top/ship_headpic_area",
								list = {
									ship_headpic = {
										path = "base_panel/top/ship_headpic_area/ship_headpic",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {}
							},
							tactic_bg2 = {
								path = "base_panel/top/tactic_bg2",
								list = {},
								component = {}
							},
							name_bg = {
								path = "base_panel/top/name_bg",
								list = {
									ship_name = {
										path = "base_panel/top/name_bg/ship_name",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									ship_name2 = {
										path = "base_panel/top/name_bg/ship_name2",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"TextHorizonScroller"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					return_btn = {
						path = "base_panel/return_btn",
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
					"UnityEngine.UI.Image"
				}
			},
			item_bg = {
				path = "item_bg",
				list = {
					icon = {
						path = "item_bg/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					point = {
						path = "item_bg/point",
						list = {
							item_des = {
								path = "item_bg/point/item_des",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							item_progress = {
								path = "item_bg/point/item_progress",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "item_bg/point/line",
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
					"UnityEngine.UI.Image"
				}
			},
			detail_panel = {
				path = "detail_panel",
				list = {
					skill_title = {
						path = "detail_panel/skill_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					skill_att_mask = {
						path = "detail_panel/skill_att_mask",
						list = {
							skill_att = {
								path = "detail_panel/skill_att_mask/skill_att",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							skill_att_1 = {
								path = "detail_panel/skill_att_mask/skill_att_1",
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
							"TextHorizonScroller"
						}
					},
					tactics_mask = {
						path = "detail_panel/tactics_mask",
						list = {
							skill_att = {
								path = "detail_panel/tactics_mask/skill_att",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							skill_att_1 = {
								path = "detail_panel/tactics_mask/skill_att_1",
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
							"TextHorizonScroller"
						}
					},
					tactics_level = {
						path = "detail_panel/tactics_level",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					skill_des = {
						path = "detail_panel/skill_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					tuition = {
						path = "detail_panel/tuition",
						list = {
							item_name = {
								path = "detail_panel/tuition/item_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							icon = {
								path = "detail_panel/tuition/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tuition_num = {
								path = "detail_panel/tuition/tuition_num",
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
					},
					point = {
						path = "detail_panel/point",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					study_btn = {
						path = "detail_panel/study_btn",
						list = {
							txt = {
								path = "detail_panel/study_btn/txt",
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
					line = {
						path = "detail_panel/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					left_btn = {
						path = "detail_panel/left_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					right_btn = {
						path = "detail_panel/right_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					show_ship_study_btn = {
						path = "detail_panel/show_ship_study_btn",
						list = {
							show_ship_study_txt = {
								path = "detail_panel/show_ship_study_btn/show_ship_study_txt",
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
			stop_study_layer = {
				path = "stop_study_layer",
				list = {
					main_bg = {
						path = "stop_study_layer/main_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top = {
						path = "stop_study_layer/top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "stop_study_layer/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					gogo = {
						path = "stop_study_layer/gogo",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					quitbtn = {
						path = "stop_study_layer/quitbtn",
						list = {
							text = {
								path = "stop_study_layer/quitbtn/text",
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
					confirmbtn = {
						path = "stop_study_layer/confirmbtn",
						list = {
							text = {
								path = "stop_study_layer/confirmbtn/text",
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
					main_text = {
						path = "stop_study_layer/main_text",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		call_node_list = {
			["class_info_view/detail_panel/tuition/tuition_num"] = "_control.detail_panel.tuition.tuition_num",
			["class_info_view/base_panel/return_btn"] = "_control.base_panel.return_btn",
			["class_info_view/stop_study_layer/top"] = "_control.stop_study_layer.top",
			["class_info_view/detail_panel/skill_des"] = "_control.detail_panel.skill_des",
			["class_info_view/item_bg/point/line"] = "_control.item_bg.point.line",
			["class_info_view/detail_panel/skill_att_mask"] = "_control.detail_panel.skill_att_mask",
			["class_info_view/detail_panel/study_btn/txt"] = "_control.detail_panel.study_btn.txt",
			["class_info_view/item_bg"] = "_control.item_bg",
			["class_info_view/detail_panel/tuition"] = "_control.detail_panel.tuition",
			["class_info_view/stop_study_layer/main_text"] = "_control.stop_study_layer.main_text",
			["class_info_view/detail_panel/tuition/item_name"] = "_control.detail_panel.tuition.item_name",
			["class_info_view/item_bg/point/item_progress"] = "_control.item_bg.point.item_progress",
			["class_info_view/bg"] = "_control.bg",
			["class_info_view/detail_panel/line"] = "_control.detail_panel.line",
			["class_info_view/detail_panel/left_btn"] = "_control.detail_panel.left_btn",
			["class_info_view/detail_panel/tactics_mask"] = "_control.detail_panel.tactics_mask",
			["class_info_view/detail_panel/right_btn"] = "_control.detail_panel.right_btn",
			["class_info_view/detail_panel/show_ship_study_btn"] = "_control.detail_panel.show_ship_study_btn",
			["class_info_view/detail_panel/show_ship_study_btn/show_ship_study_txt"] = "_control.detail_panel.show_ship_study_btn.show_ship_study_txt",
			["class_info_view/stop_study_layer"] = "_control.stop_study_layer",
			["class_info_view/detail_panel/tactics_mask/skill_att"] = "_control.detail_panel.tactics_mask.skill_att",
			["class_info_view/base_panel/top/ship_headpic_area/ship_headpic"] = "_control.base_panel.top.ship_headpic_area.ship_headpic",
			["class_info_view/detail_panel/study_btn"] = "_control.detail_panel.study_btn",
			["class_info_view/stop_study_layer/confirmbtn/text"] = "_control.stop_study_layer.confirmbtn.text",
			["class_info_view/stop_study_layer/quitbtn/text"] = "_control.stop_study_layer.quitbtn.text",
			["class_info_view/item_bg/point"] = "_control.item_bg.point",
			["class_info_view/stop_study_layer/confirmbtn"] = "_control.stop_study_layer.confirmbtn",
			["class_info_view/stop_study_layer/gogo"] = "_control.stop_study_layer.gogo",
			["class_info_view/base_panel/top_decore"] = "_control.base_panel.top_decore",
			["class_info_view/detail_panel/skill_title"] = "_control.detail_panel.skill_title",
			["class_info_view/detail_panel/point"] = "_control.detail_panel.point",
			["class_info_view/item_bg/icon"] = "_control.item_bg.icon",
			["class_info_view/base_panel/top/tactic_bg2"] = "_control.base_panel.top.tactic_bg2",
			["class_info_view/detail_panel/tactics_level"] = "_control.detail_panel.tactics_level",
			["class_info_view/base_panel/top/ship_headpic_area"] = "_control.base_panel.top.ship_headpic_area",
			["class_info_view/stop_study_layer/title"] = "_control.stop_study_layer.title",
			["class_info_view/detail_panel/tactics_mask/skill_att_1"] = "_control.detail_panel.tactics_mask.skill_att_1",
			["class_info_view/base_panel"] = "_control.base_panel",
			["class_info_view/detail_panel/tuition/icon"] = "_control.detail_panel.tuition.icon",
			["class_info_view/detail_panel/skill_att_mask/skill_att"] = "_control.detail_panel.skill_att_mask.skill_att",
			["class_info_view/base_panel/vertical_bar"] = "_control.base_panel.vertical_bar",
			["class_info_view/stop_study_layer/main_bg"] = "_control.stop_study_layer.main_bg",
			["class_info_view/detail_panel"] = "_control.detail_panel",
			["class_info_view/base_panel/top/name_bg/ship_name2"] = "_control.base_panel.top.name_bg.ship_name2",
			["class_info_view/base_panel/top/name_bg/ship_name"] = "_control.base_panel.top.name_bg.ship_name",
			["class_info_view/base_panel/top/name_bg"] = "_control.base_panel.top.name_bg",
			["class_info_view/base_panel/top"] = "_control.base_panel.top",
			["class_info_view/item_bg/point/item_des"] = "_control.item_bg.point.item_des",
			["class_info_view/stop_study_layer/quitbtn"] = "_control.stop_study_layer.quitbtn",
			["class_info_view/detail_panel/skill_att_mask/skill_att_1"] = "_control.detail_panel.skill_att_mask.skill_att_1"
		},
		click = {
			["base_panel/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["detail_panel/study_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["detail_panel/left_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["detail_panel/right_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["detail_panel/show_ship_study_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["stop_study_layer/quitbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["stop_study_layer/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			stop_study_layer = {
				component = "UnityEngine.Canvas",
				path = "stop_study_layer"
			}
		}
	}
}

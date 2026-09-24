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
			medal_name = {
				path = "medal_name",
				list = {
					name_text = {
						path = "medal_name/name_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_text_2 = {
						path = "medal_name/name_text_2",
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
					"UnityEngine.UI.Mask",
					"TextHorizonScroller",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			medal_progress = {
				path = "medal_progress",
				list = {
					bg = {
						path = "medal_progress/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					fill_area = {
						path = "medal_progress/fill_area",
						list = {
							fill = {
								path = "medal_progress/fill_area/fill",
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
					handle_slide_area = {
						path = "medal_progress/handle_slide_area",
						list = {
							handle = {
								path = "medal_progress/handle_slide_area/handle",
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
					"UnityEngine.UI.Slider"
				}
			},
			medal_progress_text = {
				path = "medal_progress_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			medal_icon = {
				path = "medal_icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			lv_text = {
				path = "lv_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			info_btn = {
				path = "info_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			cover = {
				path = "cover",
				list = {
					bg = {
						path = "cover/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					number = {
						path = "cover/number",
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
			in_display = {
				path = "in_display",
				list = {
					txt = {
						path = "in_display/txt",
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
			get_btn = {
				path = "get_btn",
				list = {
					txt = {
						path = "get_btn/txt",
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
		call_node_list = {
			["single_medal_cell_1/in_display/txt"] = "_control.in_display.txt",
			["single_medal_cell_1/info_btn"] = "_control.info_btn",
			["single_medal_cell_1/medal_progress/handle_slide_area/handle"] = "_control.medal_progress.handle_slide_area.handle",
			["single_medal_cell_1/get_btn"] = "_control.get_btn",
			["single_medal_cell_1/in_display"] = "_control.in_display",
			["single_medal_cell_1/medal_name/name_text"] = "_control.medal_name.name_text",
			["single_medal_cell_1/medal_name/name_text_2"] = "_control.medal_name.name_text_2",
			["single_medal_cell_1/medal_progress/fill_area"] = "_control.medal_progress.fill_area",
			["single_medal_cell_1/lv_text"] = "_control.lv_text",
			["single_medal_cell_1/medal_progress/bg"] = "_control.medal_progress.bg",
			["single_medal_cell_1/cover"] = "_control.cover",
			["single_medal_cell_1/bg"] = "_control.bg",
			["single_medal_cell_1/medal_progress"] = "_control.medal_progress",
			["single_medal_cell_1/medal_progress/handle_slide_area"] = "_control.medal_progress.handle_slide_area",
			["single_medal_cell_1/medal_progress/fill_area/fill"] = "_control.medal_progress.fill_area.fill",
			["single_medal_cell_1/cover/number"] = "_control.cover.number",
			["single_medal_cell_1/get_btn/txt"] = "_control.get_btn.txt",
			["single_medal_cell_1/cover/bg"] = "_control.cover.bg",
			["single_medal_cell_1/medal_icon"] = "_control.medal_icon",
			["single_medal_cell_1/medal_progress_text"] = "_control.medal_progress_text",
			["single_medal_cell_1/medal_name"] = "_control.medal_name"
		},
		click = {
			info_btn = {
				tp = "UnityEngine.UI.Button"
			},
			cover = {
				tp = "UnityEngine.UI.Button"
			},
			get_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

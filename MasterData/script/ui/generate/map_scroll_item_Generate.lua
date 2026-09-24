return {
	_rule_ = {
		none = {
			bg_mask = {
				path = "bg_mask",
				list = {
					bg = {
						path = "bg_mask/bg",
						list = {
							map_node_root = {
								path = "bg_mask/bg/map_node_root",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							map_title_bg = {
								path = "bg_mask/bg/map_title_bg",
								list = {
									map_title_text = {
										path = "bg_mask/bg/map_title_bg/map_title_text",
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
							map_pass_tag = {
								path = "bg_mask/bg/map_pass_tag",
								list = {
									tag_text = {
										path = "bg_mask/bg/map_pass_tag/tag_text",
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
									"UnityEngine.CanvasGroup"
								}
							},
							map_click_btn = {
								path = "bg_mask/bg/map_click_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							lock_bg = {
								path = "bg_mask/bg/lock_bg",
								list = {
									lock_icon = {
										path = "bg_mask/bg/lock_bg/lock_icon",
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
							map_lock_panel = {
								path = "bg_mask/bg/map_lock_panel",
								list = {
									map_lock_bg = {
										path = "bg_mask/bg/map_lock_panel/map_lock_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									map_title_bg = {
										path = "bg_mask/bg/map_lock_panel/map_title_bg",
										list = {
											map_title_text = {
												path = "bg_mask/bg/map_lock_panel/map_title_bg/map_title_text",
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
									unlock_need_title_bg = {
										path = "bg_mask/bg/map_lock_panel/unlock_need_title_bg",
										list = {
											lock_icon = {
												path = "bg_mask/bg/map_lock_panel/unlock_need_title_bg/lock_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											unlock_need_text = {
												path = "bg_mask/bg/map_lock_panel/unlock_need_title_bg/unlock_need_text",
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
									"UnityEngine.CanvasGroup"
								}
							},
							map_support = {
								path = "bg_mask/bg/map_support",
								list = {
									icon_bg = {
										path = "bg_mask/bg/map_support/icon_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									support_button = {
										path = "bg_mask/bg/map_support/support_button",
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
									"UnityEngine.RectTransform"
								}
							},
							boss_title = {
								path = "bg_mask/bg/boss_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							boss_slider = {
								path = "bg_mask/bg/boss_slider",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							boss_hp = {
								path = "bg_mask/bg/boss_hp",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							boss_slider_bg = {
								path = "bg_mask/bg/boss_slider_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							info_bg = {
								path = "bg_mask/bg/info_bg",
								list = {
									buff_name = {
										path = "bg_mask/bg/info_bg/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									info_text = {
										path = "bg_mask/bg/info_bg/info_text",
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
							back_button_image = {
								path = "bg_mask/bg/back_button_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							drop_available = {
								path = "bg_mask/bg/drop_available",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask"
				}
			},
			back_image_button = {
				path = "back_image_button",
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
			["map_scroll_item/bg_mask/bg/map_lock_panel/map_lock_bg"] = "_control.bg_mask.bg.map_lock_panel.map_lock_bg",
			["map_scroll_item/bg_mask/bg/map_pass_tag/tag_text"] = "_control.bg_mask.bg.map_pass_tag.tag_text",
			["map_scroll_item/back_image_button"] = "_control.back_image_button",
			["map_scroll_item/bg_mask/bg/lock_bg/lock_icon"] = "_control.bg_mask.bg.lock_bg.lock_icon",
			["map_scroll_item/bg_mask/bg/map_support/support_button"] = "_control.bg_mask.bg.map_support.support_button",
			["map_scroll_item/bg_mask/bg/map_lock_panel/unlock_need_title_bg/unlock_need_text"] = "_control.bg_mask.bg.map_lock_panel.unlock_need_title_bg.unlock_need_text",
			["map_scroll_item/bg_mask/bg/map_lock_panel/map_title_bg/map_title_text"] = "_control.bg_mask.bg.map_lock_panel.map_title_bg.map_title_text",
			["map_scroll_item/bg_mask/bg/map_support"] = "_control.bg_mask.bg.map_support",
			["map_scroll_item/bg_mask/bg/boss_slider_bg"] = "_control.bg_mask.bg.boss_slider_bg",
			["map_scroll_item/bg_mask"] = "_control.bg_mask",
			["map_scroll_item/bg_mask/bg/boss_slider"] = "_control.bg_mask.bg.boss_slider",
			["map_scroll_item/bg_mask/bg/boss_hp"] = "_control.bg_mask.bg.boss_hp",
			["map_scroll_item/bg_mask/bg/map_support/icon_bg"] = "_control.bg_mask.bg.map_support.icon_bg",
			["map_scroll_item/bg_mask/bg/map_lock_panel/map_title_bg"] = "_control.bg_mask.bg.map_lock_panel.map_title_bg",
			["map_scroll_item/bg_mask/bg/info_bg"] = "_control.bg_mask.bg.info_bg",
			["map_scroll_item/bg_mask/bg/info_bg/buff_name"] = "_control.bg_mask.bg.info_bg.buff_name",
			["map_scroll_item/bg_mask/bg/map_title_bg"] = "_control.bg_mask.bg.map_title_bg",
			["map_scroll_item/bg_mask/bg/info_bg/info_text"] = "_control.bg_mask.bg.info_bg.info_text",
			["map_scroll_item/bg_mask/bg/back_button_image"] = "_control.bg_mask.bg.back_button_image",
			["map_scroll_item/bg_mask/bg/map_click_btn"] = "_control.bg_mask.bg.map_click_btn",
			["map_scroll_item/bg_mask/bg/map_title_bg/map_title_text"] = "_control.bg_mask.bg.map_title_bg.map_title_text",
			["map_scroll_item/bg_mask/bg/map_lock_panel"] = "_control.bg_mask.bg.map_lock_panel",
			["map_scroll_item/bg_mask/bg/map_lock_panel/unlock_need_title_bg/lock_icon"] = "_control.bg_mask.bg.map_lock_panel.unlock_need_title_bg.lock_icon",
			["map_scroll_item/bg_mask/bg/map_node_root"] = "_control.bg_mask.bg.map_node_root",
			["map_scroll_item/bg_mask/bg"] = "_control.bg_mask.bg",
			["map_scroll_item/bg_mask/bg/map_lock_panel/unlock_need_title_bg"] = "_control.bg_mask.bg.map_lock_panel.unlock_need_title_bg",
			["map_scroll_item/bg_mask/bg/drop_available"] = "_control.bg_mask.bg.drop_available",
			["map_scroll_item/bg_mask/bg/map_pass_tag"] = "_control.bg_mask.bg.map_pass_tag",
			["map_scroll_item/bg_mask/bg/boss_title"] = "_control.bg_mask.bg.boss_title",
			["map_scroll_item/bg_mask/bg/lock_bg"] = "_control.bg_mask.bg.lock_bg"
		},
		click = {
			["bg_mask/bg/map_click_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mask/bg/lock_bg/lock_icon"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mask/bg/map_support/support_button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mask/bg/back_button_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mask/bg/drop_available"] = {
				tp = "UnityEngine.UI.Button"
			},
			back_image_button = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

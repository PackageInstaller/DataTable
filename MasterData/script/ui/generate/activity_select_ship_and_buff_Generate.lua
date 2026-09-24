return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					bg_frame = {
						path = "bg/bg_frame",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
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
			bg_image = {
				path = "bg_image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup",
					"UnityEngine.UI.Button"
				}
			},
			top = {
				path = "top",
				list = {
					title_image = {
						path = "top/title_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title_txt = {
						path = "top/title_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					coin = {
						path = "top/coin",
						list = {
							coin_image = {
								path = "top/coin/coin_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							coin_image_split = {
								path = "top/coin/coin_image_split",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							coin_count = {
								path = "top/coin/coin_count",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.CanvasGroup"
				}
			},
			select_content = {
				path = "select_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup",
					"UnityEngine.UI.ContentSizeFitter"
				}
			},
			bottom = {
				path = "bottom",
				list = {
					refresh_btn = {
						path = "bottom/refresh_btn",
						list = {
							title = {
								path = "bottom/refresh_btn/title",
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
						path = "bottom/confirm_btn",
						list = {
							title = {
								path = "bottom/confirm_btn/title",
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
					move_target = {
						path = "bottom/move_target",
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
					"UnityEngine.CanvasGroup"
				}
			},
			skill_content = {
				path = "skill_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup",
					"UnityEngine.UI.ContentSizeFitter"
				}
			}
		},
		call_node_list = {
			["activity_select_ship_and_buff/top/coin/coin_image"] = "_control.top.coin.coin_image",
			["activity_select_ship_and_buff/bottom/confirm_btn/title"] = "_control.bottom.confirm_btn.title",
			["activity_select_ship_and_buff/bg_image"] = "_control.bg_image",
			["activity_select_ship_and_buff/top"] = "_control.top",
			["activity_select_ship_and_buff/bottom/refresh_btn"] = "_control.bottom.refresh_btn",
			["activity_select_ship_and_buff/top/title_txt"] = "_control.top.title_txt",
			["activity_select_ship_and_buff/top/title_image"] = "_control.top.title_image",
			["activity_select_ship_and_buff/bottom/refresh_btn/title"] = "_control.bottom.refresh_btn.title",
			["activity_select_ship_and_buff/bg"] = "_control.bg",
			["activity_select_ship_and_buff/skill_content"] = "_control.skill_content",
			["activity_select_ship_and_buff/top/coin/coin_count"] = "_control.top.coin.coin_count",
			["activity_select_ship_and_buff/bottom/move_target"] = "_control.bottom.move_target",
			["activity_select_ship_and_buff/bottom/confirm_btn"] = "_control.bottom.confirm_btn",
			["activity_select_ship_and_buff/bg/bg_frame"] = "_control.bg.bg_frame",
			["activity_select_ship_and_buff/select_content"] = "_control.select_content",
			["activity_select_ship_and_buff/top/coin"] = "_control.top.coin",
			["activity_select_ship_and_buff/top/coin/coin_image_split"] = "_control.top.coin.coin_image_split",
			["activity_select_ship_and_buff/bottom"] = "_control.bottom"
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			},
			bg_image = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/refresh_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

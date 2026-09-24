return {
	_rule_ = {
		none = {
			bg_select = {
				path = "bg_select",
				list = {
					bg_light = {
						path = "bg_select/bg_light",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg = {
						path = "bg_select/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg_top = {
						path = "bg_select/bg_top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					voucher_icon = {
						path = "bg_select/voucher_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					Text = {
						path = "bg_select/Text",
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
			voucher_count = {
				path = "voucher_count",
				list = {
					title = {
						path = "voucher_count/title",
						list = {
							title_text = {
								path = "voucher_count/title/title_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							title_text_2 = {
								path = "voucher_count/title/title_text_2",
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
							"UnityEngine.UI.Mask",
							"TextHorizonScroller",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					count = {
						path = "voucher_count/count",
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
			limit_time = {
				path = "limit_time",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer"
				}
			},
			Text = {
				path = "limit_time/Text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			select_btn = {
				path = "select_btn",
				list = {
					text = {
						path = "select_btn/text",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			bg_empty = {
				path = "bg_empty",
				list = {
					bg = {
						path = "bg_empty/bg",
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
					"UnityEngine.CanvasRenderer"
				}
			}
		},
		call_node_list = {
			["single_voucher_shop_select/bg_select/voucher_icon"] = "_control.bg_select.voucher_icon",
			["single_voucher_shop_select/voucher_count/title/title_text_2"] = "_control.voucher_count.title.title_text_2",
			["single_voucher_shop_select/select_btn/text"] = "_control.select_btn.text",
			["single_voucher_shop_select/bg_select"] = "_control.bg_select",
			["single_voucher_shop_select/voucher_count/title/title_text"] = "_control.voucher_count.title.title_text",
			["single_voucher_shop_select/select_btn"] = "_control.select_btn",
			["single_voucher_shop_select/voucher_count/count"] = "_control.voucher_count.count",
			["single_voucher_shop_select/limit_time/Text"] = "_control.Text",
			["single_voucher_shop_select/voucher_count"] = "_control.voucher_count",
			["single_voucher_shop_select/bg_select/Text"] = "_control.bg_select.Text",
			["single_voucher_shop_select/bg_select/bg"] = "_control.bg_select.bg",
			["single_voucher_shop_select/bg_empty/bg"] = "_control.bg_empty.bg",
			["single_voucher_shop_select/bg_empty"] = "_control.bg_empty",
			["single_voucher_shop_select/limit_time"] = "_control.limit_time",
			["single_voucher_shop_select/bg_select/bg_light"] = "_control.bg_select.bg_light",
			["single_voucher_shop_select/voucher_count/title"] = "_control.voucher_count.title",
			["single_voucher_shop_select/bg_select/bg_top"] = "_control.bg_select.bg_top"
		},
		click = {
			select_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			select_btn = {
				component = "UnityEngine.Canvas",
				path = "select_btn"
			}
		}
	}
}

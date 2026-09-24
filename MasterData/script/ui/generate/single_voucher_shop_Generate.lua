return {
	_rule_ = {
		none = {
			bg_line = {
				path = "bg_line",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			icon_bg = {
				path = "icon_bg",
				list = {
					icon = {
						path = "icon_bg/icon",
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
					"UnityEngine.UI.Image"
				}
			},
			name_text = {
				path = "name_text",
				list = {
					Image = {
						path = "name_text/Image",
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
			},
			title = {
				path = "title",
				list = {
					title_text = {
						path = "title/title_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					title_text_2 = {
						path = "title/title_text_2",
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
			buy_btn = {
				path = "buy_btn",
				list = {
					icon = {
						path = "buy_btn/icon",
						list = {
							Text = {
								path = "buy_btn/icon/Text",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			disable_btn = {
				path = "disable_btn",
				list = {
					icon = {
						path = "disable_btn/icon",
						list = {
							Text = {
								path = "disable_btn/icon/Text",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		call_node_list = {
			["single_voucher_shop/bg_line"] = "_control.bg_line",
			["single_voucher_shop/title"] = "_control.title",
			["single_voucher_shop/name_text/Image"] = "_control.name_text.Image",
			["single_voucher_shop/disable_btn"] = "_control.disable_btn",
			["single_voucher_shop/buy_btn/icon"] = "_control.buy_btn.icon",
			["single_voucher_shop/name_text"] = "_control.name_text",
			["single_voucher_shop/title/title_text"] = "_control.title.title_text",
			["single_voucher_shop/icon_bg"] = "_control.icon_bg",
			["single_voucher_shop/buy_btn/icon/Text"] = "_control.buy_btn.icon.Text",
			["single_voucher_shop/title/title_text_2"] = "_control.title.title_text_2",
			["single_voucher_shop/buy_btn"] = "_control.buy_btn",
			["single_voucher_shop/icon_bg/icon"] = "_control.icon_bg.icon",
			["single_voucher_shop/disable_btn/icon"] = "_control.disable_btn.icon",
			["single_voucher_shop/disable_btn/icon/Text"] = "_control.disable_btn.icon.Text"
		},
		click = {
			buy_btn = {
				tp = "UnityEngine.UI.Button"
			},
			disable_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			buy_btn = {
				component = "UnityEngine.Canvas",
				path = "buy_btn"
			},
			disable_btn = {
				component = "UnityEngine.Canvas",
				path = "disable_btn"
			}
		}
	}
}

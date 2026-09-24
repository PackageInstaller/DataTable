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
			desc_text = {
				path = "desc_text",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			limit_text = {
				path = "limit_text",
				list = {},
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
			btns = {
				path = "btns",
				list = {
					buy_btn = {
						path = "btns/buy_btn",
						list = {
							icon = {
								path = "btns/buy_btn/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							text = {
								path = "btns/buy_btn/text",
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
					active_btn = {
						path = "btns/active_btn",
						list = {
							text = {
								path = "btns/active_btn/text",
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
							"UnityEngine.UI.Image"
						}
					},
					disable_btn = {
						path = "btns/disable_btn",
						list = {
							icon = {
								path = "btns/disable_btn/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							text = {
								path = "btns/disable_btn/text",
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
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			silk_bg = {
				path = "silk_bg",
				list = {
					silk_text = {
						path = "silk_bg/silk_text",
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
		call_node_list = {
			["single_ocean_cia/btns/active_btn"] = "_control.btns.active_btn",
			["single_ocean_cia/btns/buy_btn/text"] = "_control.btns.buy_btn.text",
			["single_ocean_cia/btns/disable_btn"] = "_control.btns.disable_btn",
			["single_ocean_cia/bg"] = "_control.bg",
			["single_ocean_cia/desc_text"] = "_control.desc_text",
			["single_ocean_cia/silk_bg"] = "_control.silk_bg",
			["single_ocean_cia/btns/disable_btn/icon"] = "_control.btns.disable_btn.icon",
			["single_ocean_cia/silk_bg/silk_text"] = "_control.silk_bg.silk_text",
			["single_ocean_cia/icon_bg"] = "_control.icon_bg",
			["single_ocean_cia/icon_bg/icon"] = "_control.icon_bg.icon",
			["single_ocean_cia/bg_line"] = "_control.bg_line",
			["single_ocean_cia/title"] = "_control.title",
			["single_ocean_cia/btns/active_btn/text"] = "_control.btns.active_btn.text",
			["single_ocean_cia/btns/buy_btn/icon"] = "_control.btns.buy_btn.icon",
			["single_ocean_cia/title/title_text_2"] = "_control.title.title_text_2",
			["single_ocean_cia/title/title_text"] = "_control.title.title_text",
			["single_ocean_cia/btns"] = "_control.btns",
			["single_ocean_cia/limit_text"] = "_control.limit_text",
			["single_ocean_cia/btns/disable_btn/text"] = "_control.btns.disable_btn.text",
			["single_ocean_cia/btns/buy_btn"] = "_control.btns.buy_btn"
		},
		click = {
			["btns/buy_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			buy_btn = {
				component = "UnityEngine.Canvas",
				path = "btns/buy_btn"
			}
		}
	}
}

return {
	_rule_ = {
		none = {
			select_bg = {
				path = "select_bg",
				list = {
					select_bg_2 = {
						path = "select_bg/select_bg_2",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					select_bg_1 = {
						path = "select_bg/select_bg_1",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {}
			},
			ship_empty = {
				path = "ship_empty",
				list = {
					add_ship_btn = {
						path = "ship_empty/add_ship_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ClickAndLongClickEvent"
						}
					},
					bg_mask = {
						path = "ship_empty/bg_mask",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {}
			},
			bg = {
				path = "ship_empty/bg",
				list = {},
				component = {}
			},
			campaign_layer = {
				path = "campaign_layer",
				list = {
					static_text = {
						path = "campaign_layer/static_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					limit_type = {
						path = "campaign_layer/limit_type",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			frame = {
				path = "frame",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			ship_item = {
				path = "ship_item",
				list = {
					item_icon_mask = {
						path = "ship_item/item_icon_mask",
						list = {
							quality = {
								path = "ship_item/item_icon_mask/quality",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							item_icon = {
								path = "ship_item/item_icon_mask/item_icon",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							ship_icon = {
								path = "ship_item/item_icon_mask/ship_icon",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							love_bg = {
								path = "ship_item/item_icon_mask/love_bg",
								list = {
									love = {
										path = "ship_item/item_icon_mask/love_bg/love",
										list = {},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							sing_image = {
								path = "ship_item/item_icon_mask/sing_image",
								list = {
									sing_txt = {
										path = "ship_item/item_icon_mask/sing_image/sing_txt",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					info_layer = {
						path = "ship_item/info_layer",
						list = {
							name_level_1 = {
								path = "ship_item/info_layer/name_level_1",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							["name_level _2"] = {
								path = "ship_item/info_layer/name_level _2",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask",
							"TextHorizonScroller"
						}
					}
				},
				component = {}
			},
			level_layer = {
				path = "ship_item/level_layer",
				list = {
					info_bg = {
						path = "ship_item/level_layer/info_bg",
						list = {},
						component = {}
					},
					type_txt = {
						path = "ship_item/level_layer/type_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					level_txt = {
						path = "ship_item/level_layer/level_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					country_txt = {
						path = "ship_item/level_layer/country_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					lock_tag = {
						path = "ship_item/level_layer/lock_tag",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					ship_remake = {
						path = "ship_item/level_layer/ship_remake",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					star_layer = {
						path = "ship_item/level_layer/star_layer",
						list = {},
						component = {}
					}
				},
				component = {}
			},
			star_1 = {
				path = "ship_item/level_layer/star_layer/star_1",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			star_2 = {
				path = "ship_item/level_layer/star_layer/star_2",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			star_3 = {
				path = "ship_item/level_layer/star_layer/star_3",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			star_4 = {
				path = "ship_item/level_layer/star_layer/star_4",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			star_5 = {
				path = "ship_item/level_layer/star_layer/star_5",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			star_6 = {
				path = "ship_item/level_layer/star_layer/star_6",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			star_7 = {
				path = "ship_item/level_layer/star_layer/star_7",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			line = {
				path = "ship_item/level_layer/line",
				list = {},
				component = {}
			}
		},
		call_node_list = {
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer"] = "_control.level_layer.star_layer",
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer/star_5"] = "_control.star_5",
			["ship_clerk_prepare_item/ship_item/item_icon_mask/item_icon"] = "_control.ship_item.item_icon_mask.item_icon",
			["ship_clerk_prepare_item/ship_item/level_layer/lock_tag"] = "_control.level_layer.lock_tag",
			["ship_clerk_prepare_item/select_bg/select_bg_1"] = "_control.select_bg.select_bg_1",
			["ship_clerk_prepare_item/ship_empty/bg_mask"] = "_control.ship_empty.bg_mask",
			["ship_clerk_prepare_item/ship_item/level_layer/country_txt"] = "_control.level_layer.country_txt",
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer/star_4"] = "_control.star_4",
			["ship_clerk_prepare_item/ship_item/item_icon_mask/love_bg"] = "_control.ship_item.item_icon_mask.love_bg",
			["ship_clerk_prepare_item/frame"] = "_control.frame",
			["ship_clerk_prepare_item/ship_item/item_icon_mask"] = "_control.ship_item.item_icon_mask",
			["ship_clerk_prepare_item/ship_item/item_icon_mask/sing_image/sing_txt"] = "_control.ship_item.item_icon_mask.sing_image.sing_txt",
			["ship_clerk_prepare_item/ship_item/level_layer/info_bg"] = "_control.level_layer.info_bg",
			["ship_clerk_prepare_item/ship_empty/bg"] = "_control.bg",
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer/star_2"] = "_control.star_2",
			["ship_clerk_prepare_item/ship_item/level_layer/line"] = "_control.line",
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer/star_6"] = "_control.star_6",
			["ship_clerk_prepare_item/ship_item/level_layer/level_txt"] = "_control.level_layer.level_txt",
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer/star_7"] = "_control.star_7",
			["ship_clerk_prepare_item/ship_item/item_icon_mask/love_bg/love"] = "_control.ship_item.item_icon_mask.love_bg.love",
			["ship_clerk_prepare_item/ship_empty/add_ship_btn"] = "_control.ship_empty.add_ship_btn",
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer/star_3"] = "_control.star_3",
			["ship_clerk_prepare_item/ship_item/item_icon_mask/sing_image"] = "_control.ship_item.item_icon_mask.sing_image",
			["ship_clerk_prepare_item/ship_item/level_layer/star_layer/star_1"] = "_control.star_1",
			["ship_clerk_prepare_item/ship_item/item_icon_mask/ship_icon"] = "_control.ship_item.item_icon_mask.ship_icon",
			["ship_clerk_prepare_item/campaign_layer"] = "_control.campaign_layer",
			["ship_clerk_prepare_item/campaign_layer/limit_type"] = "_control.campaign_layer.limit_type",
			["ship_clerk_prepare_item/ship_empty"] = "_control.ship_empty",
			["ship_clerk_prepare_item/select_bg/select_bg_2"] = "_control.select_bg.select_bg_2",
			["ship_clerk_prepare_item/ship_item/level_layer"] = "_control.level_layer",
			["ship_clerk_prepare_item/ship_item/level_layer/ship_remake"] = "_control.level_layer.ship_remake",
			["ship_clerk_prepare_item/ship_item/item_icon_mask/quality"] = "_control.ship_item.item_icon_mask.quality",
			["ship_clerk_prepare_item/ship_item/info_layer/name_level _2"] = "_control.ship_item.info_layer.name_level _2",
			["ship_clerk_prepare_item/ship_item/level_layer/type_txt"] = "_control.level_layer.type_txt",
			["ship_clerk_prepare_item/ship_item/info_layer/name_level_1"] = "_control.ship_item.info_layer.name_level_1",
			["ship_clerk_prepare_item/select_bg"] = "_control.select_bg",
			["ship_clerk_prepare_item/campaign_layer/static_text"] = "_control.campaign_layer.static_text",
			["ship_clerk_prepare_item/ship_item/info_layer"] = "_control.ship_item.info_layer",
			["ship_clerk_prepare_item/ship_item"] = "_control.ship_item"
		},
		click_and_long_click = {
			["ship_empty/add_ship_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

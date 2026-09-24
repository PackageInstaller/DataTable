return {
	_rule_ = {
		none = {
			mask_img = {
				path = "mask_img",
				list = {
					sea_map_node = {
						path = "mask_img/sea_map_node",
						list = {
							bg = {
								path = "mask_img/sea_map_node/bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							empty_bg = {
								path = "mask_img/sea_map_node/empty_bg",
								list = {
									player_role = {
										path = "mask_img/sea_map_node/empty_bg/player_role",
										list = {
											shadow = {
												path = "mask_img/sea_map_node/empty_bg/player_role/shadow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"Spine.Unity.SkeletonGraphic"
												}
											},
											spray = {
												path = "mask_img/sea_map_node/empty_bg/player_role/spray",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"Spine.Unity.SkeletonGraphic"
												}
											},
											radar = {
												path = "mask_img/sea_map_node/empty_bg/player_role/radar",
												list = {
													find = {
														path = "mask_img/sea_map_node/empty_bg/player_role/radar/find",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"Spine.Unity.SkeletonGraphic"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											sigh = {
												path = "mask_img/sea_map_node/empty_bg/player_role/sigh",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											},
											find_treasure = {
												path = "mask_img/sea_map_node/empty_bg/player_role/find_treasure",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"Spine.Unity.SkeletonGraphic"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask"
				}
			},
			player_role_cover = {
				path = "mask_img/sea_map_node/empty_bg/player_role/player_role_cover",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			map_bg = {
				path = "map_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			title_lab = {
				path = "title_lab",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Text"
				}
			},
			idx_btn = {
				path = "idx_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role/player_role_cover"] = "_control.player_role_cover",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role/radar"] = "_control.mask_img.sea_map_node.empty_bg.player_role.radar",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role"] = "_control.mask_img.sea_map_node.empty_bg.player_role",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role/spray"] = "_control.mask_img.sea_map_node.empty_bg.player_role.spray",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role/radar/find"] = "_control.mask_img.sea_map_node.empty_bg.player_role.radar.find",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role/find_treasure"] = "_control.mask_img.sea_map_node.empty_bg.player_role.find_treasure",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role/shadow"] = "_control.mask_img.sea_map_node.empty_bg.player_role.shadow",
			["eighth_map_point_item/mask_img/sea_map_node/bg"] = "_control.mask_img.sea_map_node.bg",
			["eighth_map_point_item/title_lab"] = "_control.title_lab",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg"] = "_control.mask_img.sea_map_node.empty_bg",
			["eighth_map_point_item/mask_img"] = "_control.mask_img",
			["eighth_map_point_item/mask_img/sea_map_node"] = "_control.mask_img.sea_map_node",
			["eighth_map_point_item/map_bg"] = "_control.map_bg",
			["eighth_map_point_item/idx_btn"] = "_control.idx_btn",
			["eighth_map_point_item/mask_img/sea_map_node/empty_bg/player_role/sigh"] = "_control.mask_img.sea_map_node.empty_bg.player_role.sigh"
		},
		click = {
			idx_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		trigger_2d = {
			["mask_img/sea_map_node/empty_bg/player_role"] = {
				tp = "Trigger2DEvent"
			}
		},
		canvas_set = {}
	}
}

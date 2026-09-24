return {
	_rule_ = {
		none = {
			info_layer = {
				path = "info_layer",
				list = {
					bg = {
						path = "info_layer/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					icon_layer = {
						path = "info_layer/icon_layer",
						list = {
							icon_bg = {
								path = "info_layer/icon_layer/icon_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "info_layer/icon_layer/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							count = {
								path = "info_layer/icon_layer/count",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					detail_layer = {
						path = "info_layer/detail_layer",
						list = {
							attrib_1 = {
								path = "info_layer/detail_layer/attrib_1",
								list = {
									title = {
										path = "info_layer/detail_layer/attrib_1/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "info_layer/detail_layer/attrib_1/count",
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
							attrib_2 = {
								path = "info_layer/detail_layer/attrib_2",
								list = {
									title = {
										path = "info_layer/detail_layer/attrib_2/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "info_layer/detail_layer/attrib_2/count",
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
							dismantle_mark = {
								path = "info_layer/detail_layer/dismantle_mark",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_1 = {
								path = "info_layer/detail_layer/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_2 = {
								path = "info_layer/detail_layer/line_2",
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
					name_layer = {
						path = "info_layer/name_layer",
						list = {
							bg = {
								path = "info_layer/name_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							equip_name = {
								path = "info_layer/name_layer/equip_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"BeyondBoxEllipsis"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					gray_bg = {
						path = "info_layer/gray_bg",
						list = {
							owner_layer = {
								path = "info_layer/gray_bg/owner_layer",
								list = {
									equiped_info = {
										path = "info_layer/gray_bg/owner_layer/equiped_info",
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
							"UnityEngine.UI.Image"
						}
					},
					lock = {
						path = "info_layer/lock",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					lock_effect = {
						path = "info_layer/lock_effect",
						list = {
							title = {
								path = "info_layer/lock_effect/title",
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
					add_btn = {
						path = "info_layer/add_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					research_add_btn = {
						path = "info_layer/research_add_btn",
						list = {},
						component = {
							"PointerDownAndLongClickEvent",
							"UnityEngine.UI.Button"
						}
					},
					take_off_other_btn = {
						path = "info_layer/take_off_other_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					detail_btn = {
						path = "info_layer/detail_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					equip_bg = {
						path = "info_layer/equip_bg",
						list = {
							ship_name = {
								path = "info_layer/equip_bg/ship_name",
								list = {
									shipname = {
										path = "info_layer/equip_bg/ship_name/shipname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									shipname_2 = {
										path = "info_layer/equip_bg/ship_name/shipname_2",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.Image",
									"TextHorizonScroller"
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
			selected_layer = {
				path = "selected_layer",
				list = {
					icon = {
						path = "selected_layer/icon",
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
			dismantle_layer = {
				path = "dismantle_layer",
				list = {
					bg = {
						path = "dismantle_layer/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					num_bg = {
						path = "dismantle_layer/num_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					research_add_equip_btn = {
						path = "dismantle_layer/research_add_equip_btn",
						list = {},
						component = {
							"PointerDownAndLongClickEvent"
						}
					},
					minus_btn = {
						path = "dismantle_layer/minus_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"ClickAndLongClickEvent",
							"PointerDownUpEvent"
						}
					},
					num = {
						path = "dismantle_layer/num",
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
			select_layer = {
				path = "select_layer",
				list = {
					takeoff_btn = {
						path = "select_layer/takeoff_btn",
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
			}
		},
		call_node_list = {
			["single_equip/info_layer/equip_bg"] = "_control.info_layer.equip_bg",
			["single_equip/info_layer/bg"] = "_control.info_layer.bg",
			["single_equip/info_layer/name_layer/equip_name"] = "_control.info_layer.name_layer.equip_name",
			["single_equip/info_layer/name_layer/bg"] = "_control.info_layer.name_layer.bg",
			["single_equip/select_layer/takeoff_btn"] = "_control.select_layer.takeoff_btn",
			["single_equip/info_layer/lock_effect/title"] = "_control.info_layer.lock_effect.title",
			["single_equip/info_layer/detail_layer/dismantle_mark"] = "_control.info_layer.detail_layer.dismantle_mark",
			["single_equip/info_layer/detail_layer/line_1"] = "_control.info_layer.detail_layer.line_1",
			["single_equip/info_layer"] = "_control.info_layer",
			["single_equip/info_layer/detail_layer/attrib_2/title"] = "_control.info_layer.detail_layer.attrib_2.title",
			["single_equip/info_layer/detail_layer/attrib_2/count"] = "_control.info_layer.detail_layer.attrib_2.count",
			["single_equip/info_layer/detail_layer/attrib_1/count"] = "_control.info_layer.detail_layer.attrib_1.count",
			["single_equip/info_layer/detail_layer/attrib_1/title"] = "_control.info_layer.detail_layer.attrib_1.title",
			["single_equip/info_layer/equip_bg/ship_name"] = "_control.info_layer.equip_bg.ship_name",
			["single_equip/info_layer/lock"] = "_control.info_layer.lock",
			["single_equip/info_layer/gray_bg"] = "_control.info_layer.gray_bg",
			["single_equip/info_layer/research_add_btn"] = "_control.info_layer.research_add_btn",
			["single_equip/dismantle_layer/bg"] = "_control.dismantle_layer.bg",
			["single_equip/selected_layer/icon"] = "_control.selected_layer.icon",
			["single_equip/info_layer/gray_bg/owner_layer/equiped_info"] = "_control.info_layer.gray_bg.owner_layer.equiped_info",
			["single_equip/info_layer/equip_bg/ship_name/shipname"] = "_control.info_layer.equip_bg.ship_name.shipname",
			["single_equip/info_layer/icon_layer/count"] = "_control.info_layer.icon_layer.count",
			["single_equip/dismantle_layer"] = "_control.dismantle_layer",
			["single_equip/info_layer/equip_bg/ship_name/shipname_2"] = "_control.info_layer.equip_bg.ship_name.shipname_2",
			["single_equip/dismantle_layer/num_bg"] = "_control.dismantle_layer.num_bg",
			["single_equip/dismantle_layer/research_add_equip_btn"] = "_control.dismantle_layer.research_add_equip_btn",
			["single_equip/dismantle_layer/minus_btn"] = "_control.dismantle_layer.minus_btn",
			["single_equip/info_layer/detail_layer/attrib_2"] = "_control.info_layer.detail_layer.attrib_2",
			["single_equip/selected_layer"] = "_control.selected_layer",
			["single_equip/dismantle_layer/num"] = "_control.dismantle_layer.num",
			["single_equip/select_layer"] = "_control.select_layer",
			["single_equip/info_layer/gray_bg/owner_layer"] = "_control.info_layer.gray_bg.owner_layer",
			["single_equip/info_layer/name_layer"] = "_control.info_layer.name_layer",
			["single_equip/info_layer/add_btn"] = "_control.info_layer.add_btn",
			["single_equip/info_layer/icon_layer/icon"] = "_control.info_layer.icon_layer.icon",
			["single_equip/info_layer/detail_layer/attrib_1"] = "_control.info_layer.detail_layer.attrib_1",
			["single_equip/info_layer/detail_layer"] = "_control.info_layer.detail_layer",
			["single_equip/info_layer/take_off_other_btn"] = "_control.info_layer.take_off_other_btn",
			["single_equip/info_layer/icon_layer"] = "_control.info_layer.icon_layer",
			["single_equip/info_layer/detail_btn"] = "_control.info_layer.detail_btn",
			["single_equip/info_layer/lock_effect"] = "_control.info_layer.lock_effect",
			["single_equip/info_layer/detail_layer/line_2"] = "_control.info_layer.detail_layer.line_2",
			["single_equip/info_layer/icon_layer/icon_bg"] = "_control.info_layer.icon_layer.icon_bg"
		},
		click = {
			["info_layer/add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["info_layer/research_add_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["info_layer/take_off_other_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["info_layer/detail_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["dismantle_layer/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["dismantle_layer/minus_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_layer/takeoff_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		pointer_down_and_long_click = {
			["info_layer/research_add_btn"] = {
				tp = "PointerDownAndLongClickEvent"
			},
			["dismantle_layer/research_add_equip_btn"] = {
				tp = "PointerDownAndLongClickEvent"
			}
		},
		click_and_long_click = {
			["dismantle_layer/minus_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		pointer_down_up = {
			["dismantle_layer/minus_btn"] = {
				tp = "PointerDownUpEvent"
			}
		},
		canvas_set = {}
	}
}

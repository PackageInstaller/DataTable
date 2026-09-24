return {
	_rule_ = {
		none = {
			not_get_bg = {
				path = "not_get_bg",
				list = {
					txt = {
						path = "not_get_bg/txt",
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
			not_open_bg = {
				path = "not_open_bg",
				list = {
					txt = {
						path = "not_open_bg/txt",
						list = {
							line_1 = {
								path = "not_open_bg/txt/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line_2 = {
								path = "not_open_bg/txt/line_2",
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
			all_layer = {
				path = "all_layer",
				list = {
					bg = {
						path = "all_layer/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					icon_layer = {
						path = "all_layer/icon_layer",
						list = {
							icon_bg = {
								path = "all_layer/icon_layer/icon_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "all_layer/icon_layer/icon",
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
						path = "all_layer/name_layer",
						list = {
							bg = {
								path = "all_layer/name_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							equip_name = {
								path = "all_layer/name_layer/equip_name",
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
					detail_layer = {
						path = "all_layer/detail_layer",
						list = {
							attrib_1 = {
								path = "all_layer/detail_layer/attrib_1",
								list = {
									title = {
										path = "all_layer/detail_layer/attrib_1/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "all_layer/detail_layer/attrib_1/count",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line_1 = {
										path = "all_layer/detail_layer/attrib_1/line_1",
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
							attrib_2 = {
								path = "all_layer/detail_layer/attrib_2",
								list = {
									title = {
										path = "all_layer/detail_layer/attrib_2/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "all_layer/detail_layer/attrib_2/count",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line_2 = {
										path = "all_layer/detail_layer/attrib_2/line_2",
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
							dismantle_mark = {
								path = "all_layer/detail_layer/dismantle_mark",
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
					txt2 = {
						path = "all_layer/txt2",
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
					"UnityEngine.RectTransform"
				}
			},
			bg = {
				path = "bg",
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
			["single_equip_map/not_open_bg"] = "_control.not_open_bg",
			["single_equip_map/all_layer/icon_layer"] = "_control.all_layer.icon_layer",
			["single_equip_map/not_get_bg"] = "_control.not_get_bg",
			["single_equip_map/not_open_bg/txt"] = "_control.not_open_bg.txt",
			["single_equip_map/not_get_bg/txt"] = "_control.not_get_bg.txt",
			["single_equip_map/not_open_bg/txt/line_2"] = "_control.not_open_bg.txt.line_2",
			["single_equip_map/all_layer/detail_layer/attrib_1/title"] = "_control.all_layer.detail_layer.attrib_1.title",
			["single_equip_map/all_layer/detail_layer/attrib_2/line_2"] = "_control.all_layer.detail_layer.attrib_2.line_2",
			["single_equip_map/all_layer/detail_layer"] = "_control.all_layer.detail_layer",
			["single_equip_map/all_layer/detail_layer/attrib_1/line_1"] = "_control.all_layer.detail_layer.attrib_1.line_1",
			["single_equip_map/all_layer/detail_layer/attrib_1/count"] = "_control.all_layer.detail_layer.attrib_1.count",
			["single_equip_map/all_layer/name_layer"] = "_control.all_layer.name_layer",
			["single_equip_map/all_layer/icon_layer/icon_bg"] = "_control.all_layer.icon_layer.icon_bg",
			["single_equip_map/bg"] = "_control.bg",
			["single_equip_map/all_layer/detail_layer/attrib_2/title"] = "_control.all_layer.detail_layer.attrib_2.title",
			["single_equip_map/all_layer/detail_layer/dismantle_mark"] = "_control.all_layer.detail_layer.dismantle_mark",
			["single_equip_map/all_layer/name_layer/equip_name"] = "_control.all_layer.name_layer.equip_name",
			["single_equip_map/all_layer/detail_layer/attrib_2"] = "_control.all_layer.detail_layer.attrib_2",
			["single_equip_map/not_open_bg/txt/line_1"] = "_control.not_open_bg.txt.line_1",
			["single_equip_map/all_layer/name_layer/bg"] = "_control.all_layer.name_layer.bg",
			["single_equip_map/all_layer/txt2"] = "_control.all_layer.txt2",
			["single_equip_map/all_layer/detail_layer/attrib_2/count"] = "_control.all_layer.detail_layer.attrib_2.count",
			["single_equip_map/all_layer"] = "_control.all_layer",
			["single_equip_map/all_layer/bg"] = "_control.all_layer.bg",
			["single_equip_map/all_layer/icon_layer/icon"] = "_control.all_layer.icon_layer.icon",
			["single_equip_map/all_layer/detail_layer/attrib_1"] = "_control.all_layer.detail_layer.attrib_1"
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

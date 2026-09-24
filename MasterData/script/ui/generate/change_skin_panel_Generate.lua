return {
	_rule_ = {
		none = {
			title_bg = {
				path = "title_bg",
				list = {
					title_text = {
						path = "title_bg/title_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {}
			},
			left_node = {
				path = "left_node",
				list = {
					next_btn = {
						path = "left_node/next_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					last_btn = {
						path = "left_node/last_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					item_cell_list = {
						path = "left_node/item_cell_list",
						list = {
							item_view_port = {
								path = "left_node/item_cell_list/item_view_port",
								list = {
									item_content = {
										path = "left_node/item_cell_list/item_view_port/item_content",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.ScrollRect"
						}
					}
				},
				component = {}
			},
			right_node = {
				path = "right_node",
				list = {
					mask_bg = {
						path = "right_node/mask_bg",
						list = {
							role_img = {
								path = "right_node/mask_bg/role_img",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {}
					},
					mask_img = {
						path = "right_node/mask_img",
						list = {},
						component = {}
					},
					select_all_tog = {
						path = "right_node/select_all_tog",
						list = {
							label = {
								path = "right_node/select_all_tog/label",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Toggle"
						}
					},
					change_btn = {
						path = "right_node/change_btn",
						list = {
							change_text = {
								path = "right_node/change_btn/change_text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					cancel_btn = {
						path = "right_node/cancel_btn",
						list = {
							cancel_text = {
								path = "right_node/cancel_btn/cancel_text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			}
		},
		call_node_list = {
			["change_skin_panel/title_bg"] = "_control.title_bg",
			["change_skin_panel/right_node/change_btn/change_text"] = "_control.right_node.change_btn.change_text",
			["change_skin_panel/left_node/item_cell_list/item_view_port/item_content"] = "_control.left_node.item_cell_list.item_view_port.item_content",
			["change_skin_panel/right_node/mask_img"] = "_control.right_node.mask_img",
			["change_skin_panel/title_bg/title_text"] = "_control.title_bg.title_text",
			["change_skin_panel/left_node/last_btn"] = "_control.left_node.last_btn",
			["change_skin_panel/left_node/item_cell_list/item_view_port"] = "_control.left_node.item_cell_list.item_view_port",
			["change_skin_panel/right_node"] = "_control.right_node",
			["change_skin_panel/right_node/cancel_btn"] = "_control.right_node.cancel_btn",
			["change_skin_panel/right_node/cancel_btn/cancel_text"] = "_control.right_node.cancel_btn.cancel_text",
			["change_skin_panel/right_node/select_all_tog"] = "_control.right_node.select_all_tog",
			["change_skin_panel/left_node/item_cell_list"] = "_control.left_node.item_cell_list",
			["change_skin_panel/left_node"] = "_control.left_node",
			["change_skin_panel/right_node/select_all_tog/label"] = "_control.right_node.select_all_tog.label",
			["change_skin_panel/right_node/change_btn"] = "_control.right_node.change_btn",
			["change_skin_panel/right_node/mask_bg/role_img"] = "_control.right_node.mask_bg.role_img",
			["change_skin_panel/right_node/mask_bg"] = "_control.right_node.mask_bg",
			["change_skin_panel/left_node/next_btn"] = "_control.left_node.next_btn"
		},
		click = {
			["left_node/next_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["left_node/last_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_node/change_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_node/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["right_node/select_all_tog"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

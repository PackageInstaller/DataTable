return {
	_rule_ = {
		none = {
			get_reward = {
				path = "get_reward",
				list = {
					mail_attach_have = {
						path = "get_reward/mail_attach_have",
						list = {
							lock_have = {
								path = "get_reward/mail_attach_have/lock_have",
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
					blue_angle = {
						path = "get_reward/blue_angle",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					yellow_angle = {
						path = "get_reward/yellow_angle",
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
			bar_status = {
				path = "bar_status",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			tilte = {
				path = "tilte",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			date = {
				path = "date",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			line = {
				path = "line",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			get = {
				path = "get",
				list = {
					get_icon = {
						path = "get/get_icon",
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
					"UnityEngine.UI.Text"
				}
			},
			item_content = {
				path = "item_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup"
				}
			},
			get_reward_btn = {
				path = "get_reward_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Button"
				}
			},
			blind_delete_btn_root = {
				path = "blind_delete_btn_root",
				list = {
					btn_delete = {
						path = "blind_delete_btn_root/btn_delete",
						list = {
							Text = {
								path = "blind_delete_btn_root/btn_delete/Text",
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
					btn_blind = {
						path = "blind_delete_btn_root/btn_blind",
						list = {
							Text = {
								path = "blind_delete_btn_root/btn_blind/Text",
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
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["mail_item/get/get_icon"] = "_control.get.get_icon",
			["mail_item/tilte"] = "_control.tilte",
			["mail_item/bar_status"] = "_control.bar_status",
			["mail_item/get_reward_btn"] = "_control.get_reward_btn",
			["mail_item/blind_delete_btn_root/btn_blind/Text"] = "_control.blind_delete_btn_root.btn_blind.Text",
			["mail_item/get_reward/yellow_angle"] = "_control.get_reward.yellow_angle",
			["mail_item/blind_delete_btn_root/btn_delete"] = "_control.blind_delete_btn_root.btn_delete",
			["mail_item/blind_delete_btn_root/btn_blind"] = "_control.blind_delete_btn_root.btn_blind",
			["mail_item/get_reward/mail_attach_have/lock_have"] = "_control.get_reward.mail_attach_have.lock_have",
			["mail_item/get_reward/mail_attach_have"] = "_control.get_reward.mail_attach_have",
			["mail_item/blind_delete_btn_root"] = "_control.blind_delete_btn_root",
			["mail_item/item_content"] = "_control.item_content",
			["mail_item/blind_delete_btn_root/btn_delete/Text"] = "_control.blind_delete_btn_root.btn_delete.Text",
			["mail_item/line"] = "_control.line",
			["mail_item/get_reward/blue_angle"] = "_control.get_reward.blue_angle",
			["mail_item/get"] = "_control.get",
			["mail_item/date"] = "_control.date",
			["mail_item/get_reward"] = "_control.get_reward"
		},
		click = {
			get_reward_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["blind_delete_btn_root/btn_delete"] = {
				tp = "UnityEngine.UI.Button"
			},
			["blind_delete_btn_root/btn_blind"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

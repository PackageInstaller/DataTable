return {
	_rule_ = {
		none = {
			set_support_bg_4 = {
				path = "set_support_bg_4",
				list = {},
				component = {}
			},
			set_support_bg_3 = {
				path = "set_support_bg_3",
				list = {},
				component = {}
			},
			set_support_bg_2 = {
				path = "set_support_bg_2",
				list = {},
				component = {}
			},
			set_support_bg_1 = {
				path = "set_support_bg_1",
				list = {},
				component = {}
			},
			enemy_role = {
				path = "enemy_role",
				list = {
					shadow = {
						path = "enemy_role/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					spray = {
						path = "enemy_role/spray",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					enemy_role_collider = {
						path = "enemy_role/enemy_role_collider",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Trigger2DEvent",
							"UnityEngine.BoxCollider2D"
						}
					},
					enemy_role_btn = {
						path = "enemy_role/enemy_role_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					boss_sign = {
						path = "enemy_role/boss_sign",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			support_point = {
				path = "support_point",
				list = {
					support_bg = {
						path = "support_point/support_bg",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					support_bg_2 = {
						path = "support_point/support_bg_2",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					set_support_btn = {
						path = "support_point/set_support_btn",
						list = {
							set_support_txt = {
								path = "support_point/set_support_btn/set_support_txt",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					support_role_collider = {
						path = "support_point/support_role_collider",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Trigger2DEvent",
							"UnityEngine.BoxCollider2D"
						}
					},
					clear_support_btn = {
						path = "support_point/clear_support_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					clear_support_txt = {
						path = "support_point/clear_support_btn/clear_support_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					clear_support_btn_2 = {
						path = "support_point/clear_support_btn_2",
						list = {},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					clear_support_txt_2 = {
						path = "support_point/clear_support_btn_2/clear_support_txt_2",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					support_btn = {
						path = "support_point/support_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			gunfire_universal = {
				path = "gunfire_universal",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.MeshFilter",
					"UnityEngine.MeshRenderer",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			shot_universal = {
				path = "shot_universal",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.MeshFilter",
					"UnityEngine.MeshRenderer",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			}
		},
		call_node_list = {
			["eighth_sea_map_support/set_support_bg_4"] = "_control.set_support_bg_4",
			["eighth_sea_map_support/enemy_role/boss_sign"] = "_control.enemy_role.boss_sign",
			["eighth_sea_map_support/shot_universal"] = "_control.shot_universal",
			["eighth_sea_map_support/set_support_bg_2"] = "_control.set_support_bg_2",
			["eighth_sea_map_support/support_point/support_bg_2"] = "_control.support_point.support_bg_2",
			["eighth_sea_map_support/set_support_bg_1"] = "_control.set_support_bg_1",
			["eighth_sea_map_support/support_point/support_btn"] = "_control.support_point.support_btn",
			["eighth_sea_map_support/support_point/support_role_collider"] = "_control.support_point.support_role_collider",
			["eighth_sea_map_support/support_point/clear_support_btn_2"] = "_control.support_point.clear_support_btn_2",
			["eighth_sea_map_support/gunfire_universal"] = "_control.gunfire_universal",
			["eighth_sea_map_support/support_point/clear_support_btn"] = "_control.support_point.clear_support_btn",
			["eighth_sea_map_support/support_point/clear_support_btn_2/clear_support_txt_2"] = "_control.support_point.clear_support_txt_2",
			["eighth_sea_map_support/support_point/clear_support_btn/clear_support_txt"] = "_control.support_point.clear_support_txt",
			["eighth_sea_map_support/support_point/set_support_btn"] = "_control.support_point.set_support_btn",
			["eighth_sea_map_support/enemy_role/shadow"] = "_control.enemy_role.shadow",
			["eighth_sea_map_support/support_point/support_bg"] = "_control.support_point.support_bg",
			["eighth_sea_map_support/support_point"] = "_control.support_point",
			["eighth_sea_map_support/enemy_role/enemy_role_collider"] = "_control.enemy_role.enemy_role_collider",
			["eighth_sea_map_support/support_point/set_support_btn/set_support_txt"] = "_control.support_point.set_support_btn.set_support_txt",
			["eighth_sea_map_support/enemy_role/spray"] = "_control.enemy_role.spray",
			["eighth_sea_map_support/set_support_bg_3"] = "_control.set_support_bg_3",
			["eighth_sea_map_support/enemy_role/enemy_role_btn"] = "_control.enemy_role.enemy_role_btn",
			["eighth_sea_map_support/enemy_role"] = "_control.enemy_role"
		},
		click = {
			["enemy_role/enemy_role_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/set_support_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/clear_support_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/clear_support_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/support_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		trigger_2d = {
			["enemy_role/enemy_role_collider"] = {
				tp = "Trigger2DEvent"
			},
			["support_point/support_role_collider"] = {
				tp = "Trigger2DEvent"
			}
		},
		canvas_set = {
			enemy_role_btn = {
				component = "UnityEngine.Canvas",
				path = "enemy_role/enemy_role_btn"
			},
			set_support_btn = {
				component = "UnityEngine.Canvas",
				path = "support_point/set_support_btn"
			},
			clear_support_btn = {
				component = "UnityEngine.Canvas",
				path = "support_point/clear_support_btn"
			},
			clear_support_btn_2 = {
				component = "UnityEngine.Canvas",
				path = "support_point/clear_support_btn_2"
			},
			support_btn = {
				component = "UnityEngine.Canvas",
				path = "support_point/support_btn"
			}
		}
	}
}

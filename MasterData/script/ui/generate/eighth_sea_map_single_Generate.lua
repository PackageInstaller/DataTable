return {
	_rule_ = {
		none = {
			islands = {
				path = "islands",
				list = {
					islands_collider = {
						path = "islands/islands_collider",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Trigger2DEvent",
							"UnityEngine.BoxCollider2D"
						}
					},
					islands_btn = {
						path = "islands/islands_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image"
				}
			},
			exploration_point = {
				path = "exploration_point",
				list = {
					exploration_point_collider = {
						path = "exploration_point/exploration_point_collider",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Trigger2DEvent",
							"UnityEngine.BoxCollider2D"
						}
					},
					exploration_point_btn = {
						path = "exploration_point/exploration_point_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
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
					},
					monster_hp_bg = {
						path = "enemy_role/monster_hp_bg",
						list = {
							monster_hp = {
								path = "enemy_role/monster_hp_bg/monster_hp",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							progress = {
								path = "enemy_role/monster_hp_bg/progress",
								list = {
									foreground = {
										path = "enemy_role/monster_hp_bg/progress/foreground",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					monster_buff_list = {
						path = "enemy_role/monster_buff_list",
						list = {
							defense = {
								path = "enemy_role/monster_buff_list/defense",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							fast_move = {
								path = "enemy_role/monster_buff_list/fast_move",
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
			operational_plan_point = {
				path = "operational_plan_point",
				list = {
					smoke_yan = {
						path = "operational_plan_point/smoke_yan",
						list = {
							smokes_yan = {
								path = "operational_plan_point/smoke_yan/smokes_yan",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
								}
							}
						},
						component = {}
					},
					smoke_fire = {
						path = "operational_plan_point/smoke_fire",
						list = {
							smokes_fire = {
								path = "operational_plan_point/smoke_fire/smokes_fire",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
								}
							}
						},
						component = {}
					},
					operational_plan_skeleton = {
						path = "operational_plan_point/operational_plan_skeleton",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					operational_plan_collider = {
						path = "operational_plan_point/operational_plan_collider",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Trigger2DEvent",
							"UnityEngine.BoxCollider2D"
						}
					},
					operational_plan_point_btn = {
						path = "operational_plan_point/operational_plan_point_btn",
						list = {},
						component = {
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					plane_sign = {
						path = "operational_plan_point/plane_sign",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer"
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
			cloud_img = {
				path = "cloud_img",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.RawImage",
					"UnityEngine.Canvas"
				}
			}
		},
		call_node_list = {
			["eighth_sea_map_single/islands"] = "_control.islands",
			["eighth_sea_map_single/enemy_role/monster_buff_list"] = "_control.enemy_role.monster_buff_list",
			["eighth_sea_map_single/enemy_role/monster_buff_list/defense"] = "_control.enemy_role.monster_buff_list.defense",
			["eighth_sea_map_single/support_point/support_bg_2"] = "_control.support_point.support_bg_2",
			["eighth_sea_map_single/exploration_point/exploration_point_btn"] = "_control.exploration_point.exploration_point_btn",
			["eighth_sea_map_single/support_point/support_role_collider"] = "_control.support_point.support_role_collider",
			["eighth_sea_map_single/enemy_role/monster_hp_bg/monster_hp"] = "_control.enemy_role.monster_hp_bg.monster_hp",
			["eighth_sea_map_single/operational_plan_point/smoke_yan/smokes_yan"] = "_control.operational_plan_point.smoke_yan.smokes_yan",
			["eighth_sea_map_single/enemy_role/monster_hp_bg/progress/foreground"] = "_control.enemy_role.monster_hp_bg.progress.foreground",
			["eighth_sea_map_single/support_point/clear_support_btn_2"] = "_control.support_point.clear_support_btn_2",
			["eighth_sea_map_single/operational_plan_point/operational_plan_collider"] = "_control.operational_plan_point.operational_plan_collider",
			["eighth_sea_map_single/operational_plan_point/operational_plan_point_btn"] = "_control.operational_plan_point.operational_plan_point_btn",
			["eighth_sea_map_single/enemy_role/enemy_role_collider"] = "_control.enemy_role.enemy_role_collider",
			["eighth_sea_map_single/operational_plan_point/plane_sign"] = "_control.operational_plan_point.plane_sign",
			["eighth_sea_map_single/support_point"] = "_control.support_point",
			["eighth_sea_map_single/support_point/set_support_btn/set_support_txt"] = "_control.support_point.set_support_btn.set_support_txt",
			["eighth_sea_map_single/enemy_role/enemy_role_btn"] = "_control.enemy_role.enemy_role_btn",
			["eighth_sea_map_single/gunfire_universal"] = "_control.gunfire_universal",
			["eighth_sea_map_single/operational_plan_point/smoke_yan"] = "_control.operational_plan_point.smoke_yan",
			["eighth_sea_map_single/enemy_role/monster_hp_bg/progress"] = "_control.enemy_role.monster_hp_bg.progress",
			["eighth_sea_map_single/exploration_point"] = "_control.exploration_point",
			["eighth_sea_map_single/operational_plan_point/operational_plan_skeleton"] = "_control.operational_plan_point.operational_plan_skeleton",
			["eighth_sea_map_single/islands/islands_btn"] = "_control.islands.islands_btn",
			["eighth_sea_map_single/operational_plan_point/smoke_fire/smokes_fire"] = "_control.operational_plan_point.smoke_fire.smokes_fire",
			["eighth_sea_map_single/operational_plan_point"] = "_control.operational_plan_point",
			["eighth_sea_map_single/enemy_role/monster_hp_bg"] = "_control.enemy_role.monster_hp_bg",
			["eighth_sea_map_single/cloud_img"] = "_control.cloud_img",
			["eighth_sea_map_single/support_point/support_bg"] = "_control.support_point.support_bg",
			["eighth_sea_map_single/support_point/clear_support_btn"] = "_control.support_point.clear_support_btn",
			["eighth_sea_map_single/operational_plan_point/smoke_fire"] = "_control.operational_plan_point.smoke_fire",
			["eighth_sea_map_single/enemy_role/monster_buff_list/fast_move"] = "_control.enemy_role.monster_buff_list.fast_move",
			["eighth_sea_map_single/support_point/clear_support_btn/clear_support_txt"] = "_control.support_point.clear_support_txt",
			["eighth_sea_map_single/enemy_role/boss_sign"] = "_control.enemy_role.boss_sign",
			["eighth_sea_map_single/enemy_role/shadow"] = "_control.enemy_role.shadow",
			["eighth_sea_map_single/support_point/set_support_btn"] = "_control.support_point.set_support_btn",
			["eighth_sea_map_single/exploration_point/exploration_point_collider"] = "_control.exploration_point.exploration_point_collider",
			["eighth_sea_map_single/support_point/support_btn"] = "_control.support_point.support_btn",
			["eighth_sea_map_single/islands/islands_collider"] = "_control.islands.islands_collider",
			["eighth_sea_map_single/support_point/clear_support_btn_2/clear_support_txt_2"] = "_control.support_point.clear_support_txt_2",
			["eighth_sea_map_single/enemy_role/spray"] = "_control.enemy_role.spray",
			["eighth_sea_map_single/enemy_role"] = "_control.enemy_role"
		},
		click = {
			["islands/islands_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["exploration_point/exploration_point_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["enemy_role/enemy_role_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/set_support_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/clear_support_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/clear_support_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_point/support_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["operational_plan_point/operational_plan_point_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		trigger_2d = {
			["islands/islands_collider"] = {
				tp = "Trigger2DEvent"
			},
			["exploration_point/exploration_point_collider"] = {
				tp = "Trigger2DEvent"
			},
			["enemy_role/enemy_role_collider"] = {
				tp = "Trigger2DEvent"
			},
			["support_point/support_role_collider"] = {
				tp = "Trigger2DEvent"
			},
			["operational_plan_point/operational_plan_collider"] = {
				tp = "Trigger2DEvent"
			}
		},
		canvas_set = {
			islands_btn = {
				component = "UnityEngine.Canvas",
				path = "islands/islands_btn"
			},
			exploration_point_btn = {
				component = "UnityEngine.Canvas",
				path = "exploration_point/exploration_point_btn"
			},
			enemy_role_btn = {
				component = "UnityEngine.Canvas",
				path = "enemy_role/enemy_role_btn"
			},
			set_support_btn = {
				component = "UnityEngine.Canvas",
				path = "support_point/set_support_btn"
			},
			clear_support_btn_2 = {
				component = "UnityEngine.Canvas",
				path = "support_point/clear_support_btn_2"
			},
			clear_support_btn = {
				component = "UnityEngine.Canvas",
				path = "support_point/clear_support_btn"
			},
			support_btn = {
				component = "UnityEngine.Canvas",
				path = "support_point/support_btn"
			},
			operational_plan_point_btn = {
				component = "UnityEngine.Canvas",
				path = "operational_plan_point/operational_plan_point_btn"
			},
			cloud_img = {
				component = "UnityEngine.Canvas",
				path = "cloud_img"
			}
		}
	}
}

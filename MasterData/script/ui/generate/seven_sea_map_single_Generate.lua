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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			operational_plan_point = {
				path = "operational_plan_point",
				list = {
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
			cloud_img = {
				path = "cloud_img",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.RawImage"
				}
			}
		},
		call_node_list = {
			["seven_sea_map_single/operational_plan_point/operational_plan_point_btn"] = "_control.operational_plan_point.operational_plan_point_btn",
			["seven_sea_map_single/operational_plan_point"] = "_control.operational_plan_point",
			["seven_sea_map_single/islands/islands_collider"] = "_control.islands.islands_collider",
			["seven_sea_map_single/exploration_point"] = "_control.exploration_point",
			["seven_sea_map_single/islands/islands_btn"] = "_control.islands.islands_btn",
			["seven_sea_map_single/enemy_role/enemy_role_collider"] = "_control.enemy_role.enemy_role_collider",
			["seven_sea_map_single/exploration_point/exploration_point_btn"] = "_control.exploration_point.exploration_point_btn",
			["seven_sea_map_single/cloud_img"] = "_control.cloud_img",
			["seven_sea_map_single/enemy_role"] = "_control.enemy_role",
			["seven_sea_map_single/enemy_role/spray"] = "_control.enemy_role.spray",
			["seven_sea_map_single/enemy_role/boss_sign"] = "_control.enemy_role.boss_sign",
			["seven_sea_map_single/operational_plan_point/plane_sign"] = "_control.operational_plan_point.plane_sign",
			["seven_sea_map_single/enemy_role/enemy_role_btn"] = "_control.enemy_role.enemy_role_btn",
			["seven_sea_map_single/enemy_role/shadow"] = "_control.enemy_role.shadow",
			["seven_sea_map_single/islands"] = "_control.islands",
			["seven_sea_map_single/exploration_point/exploration_point_collider"] = "_control.exploration_point.exploration_point_collider",
			["seven_sea_map_single/operational_plan_point/operational_plan_skeleton"] = "_control.operational_plan_point.operational_plan_skeleton",
			["seven_sea_map_single/operational_plan_point/operational_plan_collider"] = "_control.operational_plan_point.operational_plan_collider"
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
			operational_plan_point_btn = {
				component = "UnityEngine.Canvas",
				path = "operational_plan_point/operational_plan_point_btn"
			}
		}
	}
}

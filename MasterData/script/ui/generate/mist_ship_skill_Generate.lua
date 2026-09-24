return {
	_rule_ = {
		none = {
			all_skill = {
				path = "all_skill",
				list = {
					skill_1 = {
						path = "all_skill/skill_1",
						list = {
							bg = {
								path = "all_skill/skill_1/bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							name_mask = {
								path = "all_skill/skill_1/name_mask",
								list = {
									equipname = {
										path = "all_skill/skill_1/name_mask/equipname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									equipname_2 = {
										path = "all_skill/skill_1/name_mask/equipname_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.Image",
									"TextHorizonScroller"
								}
							},
							content = {
								path = "all_skill/skill_1/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					skill_2 = {
						path = "all_skill/skill_2",
						list = {
							bg = {
								path = "all_skill/skill_2/bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							name_mask = {
								path = "all_skill/skill_2/name_mask",
								list = {
									equipname = {
										path = "all_skill/skill_2/name_mask/equipname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									equipname_2 = {
										path = "all_skill/skill_2/name_mask/equipname_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.Image",
									"TextHorizonScroller"
								}
							},
							content = {
								path = "all_skill/skill_2/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					skill_3 = {
						path = "all_skill/skill_3",
						list = {
							bg = {
								path = "all_skill/skill_3/bg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							name_mask = {
								path = "all_skill/skill_3/name_mask",
								list = {
									equipname = {
										path = "all_skill/skill_3/name_mask/equipname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									equipname_2 = {
										path = "all_skill/skill_3/name_mask/equipname_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.Image",
									"TextHorizonScroller"
								}
							},
							content = {
								path = "all_skill/skill_3/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Text"
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
			},
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["mist_ship_skill/all_skill/skill_3/name_mask"] = "_control.all_skill.skill_3.name_mask",
			["mist_ship_skill/all_skill/skill_2/name_mask"] = "_control.all_skill.skill_2.name_mask",
			["mist_ship_skill/all_skill/skill_1/content"] = "_control.all_skill.skill_1.content",
			["mist_ship_skill/all_skill/skill_2/name_mask/equipname_2"] = "_control.all_skill.skill_2.name_mask.equipname_2",
			["mist_ship_skill/all_skill/skill_1"] = "_control.all_skill.skill_1",
			["mist_ship_skill/all_skill/skill_1/name_mask/equipname"] = "_control.all_skill.skill_1.name_mask.equipname",
			["mist_ship_skill/all_skill/skill_2/name_mask/equipname"] = "_control.all_skill.skill_2.name_mask.equipname",
			["mist_ship_skill/all_skill/skill_1/bg"] = "_control.all_skill.skill_1.bg",
			["mist_ship_skill/all_skill/skill_3/name_mask/equipname"] = "_control.all_skill.skill_3.name_mask.equipname",
			["mist_ship_skill/all_skill/skill_1/name_mask/equipname_2"] = "_control.all_skill.skill_1.name_mask.equipname_2",
			["mist_ship_skill/all_skill/skill_3/name_mask/equipname_2"] = "_control.all_skill.skill_3.name_mask.equipname_2",
			["mist_ship_skill/all_skill/skill_3/content"] = "_control.all_skill.skill_3.content",
			["mist_ship_skill/bg"] = "_control.bg",
			["mist_ship_skill/all_skill/skill_1/name_mask"] = "_control.all_skill.skill_1.name_mask",
			["mist_ship_skill/all_skill/skill_3"] = "_control.all_skill.skill_3",
			["mist_ship_skill/all_skill"] = "_control.all_skill",
			["mist_ship_skill/all_skill/skill_3/bg"] = "_control.all_skill.skill_3.bg",
			["mist_ship_skill/all_skill/skill_2/content"] = "_control.all_skill.skill_2.content",
			["mist_ship_skill/all_skill/skill_2/bg"] = "_control.all_skill.skill_2.bg",
			["mist_ship_skill/all_skill/skill_2"] = "_control.all_skill.skill_2"
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

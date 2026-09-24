return {
	_rule_ = {
		none = {
			top_weight = {
				path = "top_weight",
				list = {
					title_bg = {
						path = "top_weight/title_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					team_name = {
						path = "top_weight/team_name",
						list = {
							Button = {
								path = "top_weight/team_name/Button",
								list = {},
								component = {
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					fleet_name = {
						path = "top_weight/fleet_name",
						list = {
							placeholder = {
								path = "top_weight/fleet_name/placeholder",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							text = {
								path = "top_weight/fleet_name/text",
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
							"UnityEngine.UI.InputField"
						}
					},
					close = {
						path = "top_weight/close",
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
			},
			right_weight = {
				path = "right_weight",
				list = {
					right_bg = {
						path = "right_weight/right_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					speed_skeleton_mask = {
						path = "right_weight/speed_skeleton_mask",
						list = {
							speed_skeleton = {
								path = "right_weight/speed_skeleton_mask/speed_skeleton",
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
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					speed_info_panel = {
						path = "right_weight/speed_info_panel",
						list = {
							min_speed = {
								path = "right_weight/speed_info_panel/min_speed",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							max_speed = {
								path = "right_weight/speed_info_panel/max_speed",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							mean_speed = {
								path = "right_weight/speed_info_panel/mean_speed",
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
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer"
						}
					},
					props_panel = {
						path = "right_weight/props_panel",
						list = {
							title = {
								path = "right_weight/props_panel/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							radar_chart_bg = {
								path = "right_weight/props_panel/radar_chart_bg",
								list = {
									web_img = {
										path = "right_weight/props_panel/radar_chart_bg/web_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									draw_web = {
										path = "right_weight/props_panel/radar_chart_bg/draw_web",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Extensions.UIPolygon"
										}
									},
									prop1 = {
										path = "right_weight/props_panel/radar_chart_bg/prop1",
										list = {
											title = {
												path = "right_weight/props_panel/radar_chart_bg/prop1/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "right_weight/props_panel/radar_chart_bg/prop1/num",
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
									prop2 = {
										path = "right_weight/props_panel/radar_chart_bg/prop2",
										list = {
											title = {
												path = "right_weight/props_panel/radar_chart_bg/prop2/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "right_weight/props_panel/radar_chart_bg/prop2/num",
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
									prop3 = {
										path = "right_weight/props_panel/radar_chart_bg/prop3",
										list = {
											title = {
												path = "right_weight/props_panel/radar_chart_bg/prop3/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "right_weight/props_panel/radar_chart_bg/prop3/num",
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
									prop4 = {
										path = "right_weight/props_panel/radar_chart_bg/prop4",
										list = {
											title = {
												path = "right_weight/props_panel/radar_chart_bg/prop4/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "right_weight/props_panel/radar_chart_bg/prop4/num",
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
									prop5 = {
										path = "right_weight/props_panel/radar_chart_bg/prop5",
										list = {
											title = {
												path = "right_weight/props_panel/radar_chart_bg/prop5/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "right_weight/props_panel/radar_chart_bg/prop5/num",
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
									prop6 = {
										path = "right_weight/props_panel/radar_chart_bg/prop6",
										list = {
											title = {
												path = "right_weight/props_panel/radar_chart_bg/prop6/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "right_weight/props_panel/radar_chart_bg/prop6/num",
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
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasGroup"
						}
					},
					record_team = {
						path = "right_weight/record_team",
						list = {
							Text = {
								path = "right_weight/record_team/Text",
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
					confirm_team = {
						path = "right_weight/confirm_team",
						list = {
							Text = {
								path = "right_weight/confirm_team/Text",
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
			},
			left_weight = {
				path = "left_weight",
				list = {
					pre_formation = {
						path = "left_weight/pre_formation",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"RankableLayoutGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop3/title"] = "_control.right_weight.props_panel.radar_chart_bg.prop3.title",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop2/num"] = "_control.right_weight.props_panel.radar_chart_bg.prop2.num",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg"] = "_control.right_weight.props_panel.radar_chart_bg",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop4"] = "_control.right_weight.props_panel.radar_chart_bg.prop4",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop1"] = "_control.right_weight.props_panel.radar_chart_bg.prop1",
			["pre_formation_team_item/top_weight/team_name/Button"] = "_control.top_weight.team_name.Button",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop1/num"] = "_control.right_weight.props_panel.radar_chart_bg.prop1.num",
			["pre_formation_team_item/right_weight/speed_skeleton_mask/speed_skeleton"] = "_control.right_weight.speed_skeleton_mask.speed_skeleton",
			["pre_formation_team_item/right_weight/right_bg"] = "_control.right_weight.right_bg",
			["pre_formation_team_item/top_weight/team_name"] = "_control.top_weight.team_name",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop2/title"] = "_control.right_weight.props_panel.radar_chart_bg.prop2.title",
			["pre_formation_team_item/right_weight/speed_info_panel"] = "_control.right_weight.speed_info_panel",
			["pre_formation_team_item/right_weight/props_panel"] = "_control.right_weight.props_panel",
			["pre_formation_team_item/right_weight/speed_info_panel/max_speed"] = "_control.right_weight.speed_info_panel.max_speed",
			["pre_formation_team_item/top_weight/close"] = "_control.top_weight.close",
			["pre_formation_team_item/top_weight/fleet_name"] = "_control.top_weight.fleet_name",
			["pre_formation_team_item/top_weight/title_bg"] = "_control.top_weight.title_bg",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop1/title"] = "_control.right_weight.props_panel.radar_chart_bg.prop1.title",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop4/num"] = "_control.right_weight.props_panel.radar_chart_bg.prop4.num",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop5/title"] = "_control.right_weight.props_panel.radar_chart_bg.prop5.title",
			["pre_formation_team_item/right_weight/confirm_team/Text"] = "_control.right_weight.confirm_team.Text",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop6/title"] = "_control.right_weight.props_panel.radar_chart_bg.prop6.title",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop6"] = "_control.right_weight.props_panel.radar_chart_bg.prop6",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop6/num"] = "_control.right_weight.props_panel.radar_chart_bg.prop6.num",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop3"] = "_control.right_weight.props_panel.radar_chart_bg.prop3",
			["pre_formation_team_item/right_weight/props_panel/title"] = "_control.right_weight.props_panel.title",
			["pre_formation_team_item/right_weight/record_team"] = "_control.right_weight.record_team",
			["pre_formation_team_item/right_weight/record_team/Text"] = "_control.right_weight.record_team.Text",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop5"] = "_control.right_weight.props_panel.radar_chart_bg.prop5",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop5/num"] = "_control.right_weight.props_panel.radar_chart_bg.prop5.num",
			["pre_formation_team_item/left_weight/pre_formation"] = "_control.left_weight.pre_formation",
			["pre_formation_team_item/right_weight/speed_skeleton_mask"] = "_control.right_weight.speed_skeleton_mask",
			["pre_formation_team_item/right_weight/speed_info_panel/mean_speed"] = "_control.right_weight.speed_info_panel.mean_speed",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/draw_web"] = "_control.right_weight.props_panel.radar_chart_bg.draw_web",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop4/title"] = "_control.right_weight.props_panel.radar_chart_bg.prop4.title",
			["pre_formation_team_item/right_weight"] = "_control.right_weight",
			["pre_formation_team_item/top_weight"] = "_control.top_weight",
			["pre_formation_team_item/top_weight/fleet_name/text"] = "_control.top_weight.fleet_name.text",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/web_img"] = "_control.right_weight.props_panel.radar_chart_bg.web_img",
			["pre_formation_team_item/right_weight/speed_info_panel/min_speed"] = "_control.right_weight.speed_info_panel.min_speed",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop3/num"] = "_control.right_weight.props_panel.radar_chart_bg.prop3.num",
			["pre_formation_team_item/top_weight/fleet_name/placeholder"] = "_control.top_weight.fleet_name.placeholder",
			["pre_formation_team_item/left_weight"] = "_control.left_weight",
			["pre_formation_team_item/right_weight/confirm_team"] = "_control.right_weight.confirm_team",
			["pre_formation_team_item/right_weight/props_panel/radar_chart_bg/prop2"] = "_control.right_weight.props_panel.radar_chart_bg.prop2"
		},
		click = {
			["top_weight/team_name/Button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top_weight/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_weight/record_team"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_weight/confirm_team"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

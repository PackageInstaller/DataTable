return {
	_rule_ = {
		none = {
			all_bg = {
				path = "all_bg",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			bg = {
				path = "bg",
				list = {
					monster_bg = {
						path = "bg/monster_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					monster = {
						path = "bg/monster",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					left_top = {
						path = "bg/left_top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line = {
						path = "bg/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					get_icon = {
						path = "bg/get_icon",
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
			tasktext = {
				path = "tasktext",
				list = {
					task_tittle = {
						path = "tasktext/task_tittle",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					task_text = {
						path = "tasktext/task_text",
						list = {
							task_dot = {
								path = "tasktext/task_text/task_dot",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					task_progress = {
						path = "tasktext/task_progress",
						list = {
							task_num = {
								path = "tasktext/task_progress/task_num",
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
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer"
				}
			},
			taskreward = {
				path = "taskreward",
				list = {
					reward = {
						path = "taskreward/reward",
						list = {
							rewartypeone = {
								path = "taskreward/reward/rewartypeone",
								list = {
									rewardimg = {
										path = "taskreward/reward/rewartypeone/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardname = {
										path = "taskreward/reward/rewartypeone/rewardname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									reward_line = {
										path = "taskreward/reward/rewartypeone/reward_line",
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
							rewartypetwo = {
								path = "taskreward/reward/rewartypetwo",
								list = {
									rewardimg = {
										path = "taskreward/reward/rewartypetwo/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardname = {
										path = "taskreward/reward/rewartypetwo/rewardname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									reward_line = {
										path = "taskreward/reward/rewartypetwo/reward_line",
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
							rewartypethree = {
								path = "taskreward/reward/rewartypethree",
								list = {
									rewardimg = {
										path = "taskreward/reward/rewartypethree/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardname = {
										path = "taskreward/reward/rewartypethree/rewardname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									reward_line = {
										path = "taskreward/reward/rewartypethree/reward_line",
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
							rewartypefour = {
								path = "taskreward/reward/rewartypefour",
								list = {
									rewardimg = {
										path = "taskreward/reward/rewartypefour/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardname = {
										path = "taskreward/reward/rewartypefour/rewardname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									reward_line = {
										path = "taskreward/reward/rewartypefour/reward_line",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					goto_btn = {
						path = "taskreward/goto_btn",
						list = {
							Text = {
								path = "taskreward/goto_btn/Text",
								list = {},
								component = {
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
					reward_btn = {
						path = "taskreward/reward_btn",
						list = {
							Text = {
								path = "taskreward/reward_btn/Text",
								list = {},
								component = {
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
			["single_ninth_task/taskreward/reward/rewartypethree/rewardname"] = "_control.taskreward.reward.rewartypethree.rewardname",
			["single_ninth_task/taskreward/reward/rewartypethree/rewardimg"] = "_control.taskreward.reward.rewartypethree.rewardimg",
			["single_ninth_task/taskreward/reward/rewartypetwo/rewardname"] = "_control.taskreward.reward.rewartypetwo.rewardname",
			["single_ninth_task/bg/line"] = "_control.bg.line",
			["single_ninth_task/taskreward/reward/rewartypeone/rewardname"] = "_control.taskreward.reward.rewartypeone.rewardname",
			["single_ninth_task/taskreward/reward/rewartypeone/rewardimg"] = "_control.taskreward.reward.rewartypeone.rewardimg",
			["single_ninth_task/taskreward/reward/rewartypetwo/rewardimg"] = "_control.taskreward.reward.rewartypetwo.rewardimg",
			["single_ninth_task/bg/monster_bg"] = "_control.bg.monster_bg",
			["single_ninth_task/taskreward/reward/rewartypeone/reward_line"] = "_control.taskreward.reward.rewartypeone.reward_line",
			["single_ninth_task/tasktext/task_progress/task_num"] = "_control.tasktext.task_progress.task_num",
			["single_ninth_task/taskreward/reward_btn"] = "_control.taskreward.reward_btn",
			["single_ninth_task/taskreward/reward_btn/Text"] = "_control.taskreward.reward_btn.Text",
			["single_ninth_task/taskreward/goto_btn"] = "_control.taskreward.goto_btn",
			["single_ninth_task/taskreward/goto_btn/Text"] = "_control.taskreward.goto_btn.Text",
			["single_ninth_task/taskreward/reward/rewartypefour/rewardimg"] = "_control.taskreward.reward.rewartypefour.rewardimg",
			["single_ninth_task/bg/left_top"] = "_control.bg.left_top",
			["single_ninth_task/taskreward/reward/rewartypeone"] = "_control.taskreward.reward.rewartypeone",
			["single_ninth_task/bg/get_icon"] = "_control.bg.get_icon",
			["single_ninth_task/tasktext/task_progress"] = "_control.tasktext.task_progress",
			["single_ninth_task/taskreward/reward/rewartypefour"] = "_control.taskreward.reward.rewartypefour",
			["single_ninth_task/bg"] = "_control.bg",
			["single_ninth_task/tasktext/task_tittle"] = "_control.tasktext.task_tittle",
			["single_ninth_task/all_bg"] = "_control.all_bg",
			["single_ninth_task/taskreward/reward/rewartypetwo/reward_line"] = "_control.taskreward.reward.rewartypetwo.reward_line",
			["single_ninth_task/taskreward/reward/rewartypefour/rewardname"] = "_control.taskreward.reward.rewartypefour.rewardname",
			["single_ninth_task/taskreward/reward"] = "_control.taskreward.reward",
			["single_ninth_task/tasktext/task_text"] = "_control.tasktext.task_text",
			["single_ninth_task/bg/monster"] = "_control.bg.monster",
			["single_ninth_task/tasktext"] = "_control.tasktext",
			["single_ninth_task/taskreward/reward/rewartypetwo"] = "_control.taskreward.reward.rewartypetwo",
			["single_ninth_task/taskreward"] = "_control.taskreward",
			["single_ninth_task/taskreward/reward/rewartypefour/reward_line"] = "_control.taskreward.reward.rewartypefour.reward_line",
			["single_ninth_task/taskreward/reward/rewartypethree/reward_line"] = "_control.taskreward.reward.rewartypethree.reward_line",
			["single_ninth_task/tasktext/task_text/task_dot"] = "_control.tasktext.task_text.task_dot",
			["single_ninth_task/taskreward/reward/rewartypethree"] = "_control.taskreward.reward.rewartypethree"
		},
		click = {
			["taskreward/goto_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["taskreward/reward_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

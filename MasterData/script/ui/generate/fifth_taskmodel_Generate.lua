return {
	_rule_ = {
		none = {
			main = {
				path = "main",
				list = {
					left_bg = {
						path = "main/left_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					maintask = {
						path = "main/maintask",
						list = {
							activity = {
								path = "main/maintask/activity",
								list = {
									content = {
										path = "main/maintask/activity/content",
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
							markone = {
								path = "main/maintask/markone",
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
					line = {
						path = "main/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					finish = {
						path = "main/finish",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					nametimefinish = {
						path = "main/nametimefinish",
						list = {
							namearea = {
								path = "main/nametimefinish/namearea",
								list = {
									taskname = {
										path = "main/nametimefinish/namearea/taskname",
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
							goal = {
								path = "main/nametimefinish/goal",
								list = {
									goalmain = {
										path = "main/nametimefinish/goal/goalmain",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter",
											"UnityEngine.UI.GridLayoutGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.ScrollRect"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					taskreward = {
						path = "main/taskreward",
						list = {
							rewardbg = {
								path = "main/taskreward/rewardbg",
								list = {
									finish = {
										path = "main/taskreward/rewardbg/finish",
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
							reward = {
								path = "main/taskreward/reward",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							rewartypeone = {
								path = "main/taskreward/rewartypeone",
								list = {
									bg = {
										path = "main/taskreward/rewartypeone/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardimg = {
										path = "main/taskreward/rewartypeone/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardname = {
										path = "main/taskreward/rewartypeone/rewardname",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									is_get_img = {
										path = "main/taskreward/rewartypeone/is_get_img",
										list = {
											is_get_txt = {
												path = "main/taskreward/rewartypeone/is_get_img/is_get_txt",
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
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["fifth_taskmodel/main/taskreward/rewartypeone/is_get_img"] = "_control.main.taskreward.rewartypeone.is_get_img",
			["fifth_taskmodel/main/nametimefinish/goal/goalmain"] = "_control.main.nametimefinish.goal.goalmain",
			["fifth_taskmodel/main/maintask/activity/content"] = "_control.main.maintask.activity.content",
			["fifth_taskmodel/main/left_bg"] = "_control.main.left_bg",
			["fifth_taskmodel/main/maintask/markone"] = "_control.main.maintask.markone",
			["fifth_taskmodel/main/nametimefinish/goal"] = "_control.main.nametimefinish.goal",
			["fifth_taskmodel/main"] = "_control.main",
			["fifth_taskmodel/main/taskreward/reward"] = "_control.main.taskreward.reward",
			["fifth_taskmodel/main/taskreward/rewartypeone/rewardimg"] = "_control.main.taskreward.rewartypeone.rewardimg",
			["fifth_taskmodel/main/nametimefinish"] = "_control.main.nametimefinish",
			["fifth_taskmodel/main/maintask"] = "_control.main.maintask",
			["fifth_taskmodel/main/maintask/activity"] = "_control.main.maintask.activity",
			["fifth_taskmodel/main/finish"] = "_control.main.finish",
			["fifth_taskmodel/main/nametimefinish/namearea/taskname"] = "_control.main.nametimefinish.namearea.taskname",
			["fifth_taskmodel/main/taskreward/rewartypeone/rewardname"] = "_control.main.taskreward.rewartypeone.rewardname",
			["fifth_taskmodel/main/taskreward/rewardbg"] = "_control.main.taskreward.rewardbg",
			["fifth_taskmodel/main/nametimefinish/namearea"] = "_control.main.nametimefinish.namearea",
			["fifth_taskmodel/main/taskreward/rewardbg/finish"] = "_control.main.taskreward.rewardbg.finish",
			["fifth_taskmodel/main/taskreward/rewartypeone/is_get_img/is_get_txt"] = "_control.main.taskreward.rewartypeone.is_get_img.is_get_txt",
			["fifth_taskmodel/main/taskreward/rewartypeone"] = "_control.main.taskreward.rewartypeone",
			["fifth_taskmodel/main/line"] = "_control.main.line",
			["fifth_taskmodel/main/taskreward"] = "_control.main.taskreward",
			["fifth_taskmodel/main/taskreward/rewartypeone/bg"] = "_control.main.taskreward.rewartypeone.bg"
		},
		canvas_set = {}
	}
}

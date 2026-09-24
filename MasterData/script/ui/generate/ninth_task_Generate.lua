return {
	_rule_ = {
		none = {
			bg_shadow = {
				path = "bg_shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			task_bg = {
				path = "task_bg",
				list = {
					npc = {
						path = "task_bg/npc",
						list = {
							img = {
								path = "task_bg/npc/img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							talk = {
								path = "task_bg/npc/talk",
								list = {
									bg1 = {
										path = "task_bg/npc/talk/bg1",
										list = {
											bg2 = {
												path = "task_bg/npc/talk/bg1/bg2",
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
									label_txt = {
										path = "task_bg/npc/talk/label_txt",
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
									"UnityEngine.CanvasGroup",
									"PopVerticalAdaptive",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UITweenSequence",
							"UIMoveTweener",
							"UIMoveTweener",
							"UnityEngine.UI.Button"
						}
					},
					top = {
						path = "task_bg/top",
						list = {
							back_btn = {
								path = "task_bg/top/back_btn",
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
					middle = {
						path = "task_bg/middle",
						list = {
							tab_toggle = {
								path = "task_bg/middle/tab_toggle",
								list = {
									tab_1 = {
										path = "task_bg/middle/tab_toggle/tab_1",
										list = {
											line_1 = {
												path = "task_bg/middle/tab_toggle/tab_1/line_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg = {
												path = "task_bg/middle/tab_toggle/tab_1/bg",
												list = {
													checkmark = {
														path = "task_bg/middle/tab_toggle/tab_1/bg/checkmark",
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
											sbt1 = {
												path = "task_bg/middle/tab_toggle/tab_1/sbt1",
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
											"UnityEngine.UI.Toggle"
										}
									},
									tab_2 = {
										path = "task_bg/middle/tab_toggle/tab_2",
										list = {
											line_2 = {
												path = "task_bg/middle/tab_toggle/tab_2/line_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg = {
												path = "task_bg/middle/tab_toggle/tab_2/bg",
												list = {
													checkmark = {
														path = "task_bg/middle/tab_toggle/tab_2/bg/checkmark",
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
											sbt2 = {
												path = "task_bg/middle/tab_toggle/tab_2/sbt2",
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
											"UnityEngine.UI.Toggle"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup"
								}
							},
							taskcontent = {
								path = "task_bg/middle/taskcontent",
								list = {
									scrollview = {
										path = "task_bg/middle/taskcontent/scrollview",
										list = {
											viewport = {
												path = "task_bg/middle/taskcontent/scrollview/viewport",
												list = {
													content = {
														path = "task_bg/middle/taskcontent/scrollview/viewport/content",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"EndlessScrollView"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Mask",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											scrollbarvertical = {
												path = "task_bg/middle/taskcontent/scrollview/scrollbarvertical",
												list = {
													slidingarea = {
														path = "task_bg/middle/taskcontent/scrollview/scrollbarvertical/slidingarea",
														list = {
															handle = {
																path = "task_bg/middle/taskcontent/scrollview/scrollbarvertical/slidingarea/handle",
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
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Scrollbar"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener"
								}
							},
							desc = {
								path = "task_bg/middle/desc",
								list = {
									dot_image = {
										path = "task_bg/middle/desc/dot_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									desc_text = {
										path = "task_bg/middle/desc/desc_text",
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
							line = {
								path = "task_bg/middle/line",
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
					"UnityEngine.UI.Image",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		call_node_list = {
			["ninth_task/task_bg/middle/desc/dot_image"] = "_control.task_bg.middle.desc.dot_image",
			["ninth_task/task_bg/middle/tab_toggle/tab_2/sbt2"] = "_control.task_bg.middle.tab_toggle.tab_2.sbt2",
			["ninth_task/task_bg/middle/tab_toggle/tab_2/bg"] = "_control.task_bg.middle.tab_toggle.tab_2.bg",
			["ninth_task/task_bg/middle/tab_toggle/tab_1/bg/checkmark"] = "_control.task_bg.middle.tab_toggle.tab_1.bg.checkmark",
			["ninth_task/task_bg/top"] = "_control.task_bg.top",
			["ninth_task/task_bg/npc"] = "_control.task_bg.npc",
			["ninth_task/task_bg/middle/taskcontent/scrollview/scrollbarvertical"] = "_control.task_bg.middle.taskcontent.scrollview.scrollbarvertical",
			["ninth_task/task_bg/npc/talk"] = "_control.task_bg.npc.talk",
			["ninth_task/task_bg/middle"] = "_control.task_bg.middle",
			["ninth_task/task_bg/middle/tab_toggle/tab_1/line_1"] = "_control.task_bg.middle.tab_toggle.tab_1.line_1",
			["ninth_task/task_bg/npc/talk/label_txt"] = "_control.task_bg.npc.talk.label_txt",
			["ninth_task/task_bg/middle/line"] = "_control.task_bg.middle.line",
			["ninth_task/task_bg/middle/tab_toggle/tab_2/line_2"] = "_control.task_bg.middle.tab_toggle.tab_2.line_2",
			["ninth_task/task_bg/middle/taskcontent"] = "_control.task_bg.middle.taskcontent",
			["ninth_task/task_bg/middle/tab_toggle/tab_1"] = "_control.task_bg.middle.tab_toggle.tab_1",
			["ninth_task/task_bg"] = "_control.task_bg",
			["ninth_task/bg_shadow"] = "_control.bg_shadow",
			["ninth_task/task_bg/middle/tab_toggle/tab_2"] = "_control.task_bg.middle.tab_toggle.tab_2",
			["ninth_task/task_bg/top/back_btn"] = "_control.task_bg.top.back_btn",
			["ninth_task/task_bg/middle/tab_toggle/tab_2/bg/checkmark"] = "_control.task_bg.middle.tab_toggle.tab_2.bg.checkmark",
			["ninth_task/task_bg/middle/tab_toggle"] = "_control.task_bg.middle.tab_toggle",
			["ninth_task/task_bg/npc/img"] = "_control.task_bg.npc.img",
			["ninth_task/task_bg/middle/desc"] = "_control.task_bg.middle.desc",
			["ninth_task/task_bg/npc/talk/bg1/bg2"] = "_control.task_bg.npc.talk.bg1.bg2",
			["ninth_task/task_bg/middle/tab_toggle/tab_1/sbt1"] = "_control.task_bg.middle.tab_toggle.tab_1.sbt1",
			["ninth_task/task_bg/middle/taskcontent/scrollview"] = "_control.task_bg.middle.taskcontent.scrollview",
			["ninth_task/task_bg/middle/tab_toggle/tab_1/bg"] = "_control.task_bg.middle.tab_toggle.tab_1.bg",
			["ninth_task/task_bg/middle/taskcontent/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.task_bg.middle.taskcontent.scrollview.scrollbarvertical.slidingarea.handle",
			["ninth_task/task_bg/middle/taskcontent/scrollview/viewport"] = "_control.task_bg.middle.taskcontent.scrollview.viewport",
			["ninth_task/task_bg/middle/desc/desc_text"] = "_control.task_bg.middle.desc.desc_text",
			["ninth_task/task_bg/middle/taskcontent/scrollview/viewport/content"] = "_control.task_bg.middle.taskcontent.scrollview.viewport.content",
			["ninth_task/task_bg/middle/taskcontent/scrollview/scrollbarvertical/slidingarea"] = "_control.task_bg.middle.taskcontent.scrollview.scrollbarvertical.slidingarea",
			["ninth_task/task_bg/npc/talk/bg1"] = "_control.task_bg.npc.talk.bg1"
		},
		click = {
			["task_bg/npc"] = {
				tp = "UnityEngine.UI.Button"
			},
			["task_bg/top/back_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["task_bg/middle/tab_toggle/tab_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["task_bg/middle/tab_toggle/tab_2"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

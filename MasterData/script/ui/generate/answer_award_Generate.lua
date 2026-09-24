return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {}
			},
			mian = {
				path = "mian",
				list = {
					top = {
						path = "mian/top",
						list = {
							title = {
								path = "mian/top/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							point = {
								path = "mian/top/point",
								list = {
									desc = {
										path = "mian/top/point/desc",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									bg = {
										path = "mian/top/point/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									img = {
										path = "mian/top/point/img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "mian/top/point/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {}
							},
							line = {
								path = "mian/top/line",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							return_btn = {
								path = "mian/top/return_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					middle = {
						path = "mian/middle",
						list = {
							task = {
								path = "mian/middle/task",
								list = {
									scrollview = {
										path = "mian/middle/task/scrollview",
										list = {
											viewport = {
												path = "mian/middle/task/scrollview/viewport",
												list = {
													content = {
														path = "mian/middle/task/scrollview/viewport/content",
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
											task_scrollbarvertical = {
												path = "mian/middle/task/scrollview/task_scrollbarvertical",
												list = {
													task_slidingarea = {
														path = "mian/middle/task/scrollview/task_scrollbarvertical/task_slidingarea",
														list = {},
														component = {}
													}
												},
												component = {
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
							award = {
								path = "mian/middle/award",
								list = {
									bg = {
										path = "mian/middle/award/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									scrollview = {
										path = "mian/middle/award/scrollview",
										list = {
											viewport = {
												path = "mian/middle/award/scrollview/viewport",
												list = {
													content = {
														path = "mian/middle/award/scrollview/viewport/content",
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
												path = "mian/middle/award/scrollview/scrollbarvertical",
												list = {
													slidingarea = {
														path = "mian/middle/award/scrollview/scrollbarvertical/slidingarea",
														list = {},
														component = {}
													}
												},
												component = {
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
			},
			task_handle = {
				path = "mian/middle/task/scrollview/task_scrollbarvertical/task_slidingarea/task_handle",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			handle = {
				path = "mian/middle/award/scrollview/scrollbarvertical/slidingarea/handle",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			shadow = {
				path = "shadow",
				list = {
					btn = {
						path = "shadow/btn",
						list = {},
						component = {
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup"
				}
			},
			detail_shadow = {
				path = "detail_shadow",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["answer_award/mian/top/point/bg"] = "_control.mian.top.point.bg",
			["answer_award/mian/middle/award/bg"] = "_control.mian.middle.award.bg",
			["answer_award/mian"] = "_control.mian",
			["answer_award/mian/middle/award/scrollview/viewport"] = "_control.mian.middle.award.scrollview.viewport",
			["answer_award/mian/middle/task/scrollview/task_scrollbarvertical"] = "_control.mian.middle.task.scrollview.task_scrollbarvertical",
			["answer_award/mian/top/line"] = "_control.mian.top.line",
			["answer_award/mian/middle/task"] = "_control.mian.middle.task",
			["answer_award/mian/middle/task/scrollview/task_scrollbarvertical/task_slidingarea/task_handle"] = "_control.task_handle",
			["answer_award/mian/top/return_btn"] = "_control.mian.top.return_btn",
			["answer_award/mian/middle/award/scrollview"] = "_control.mian.middle.award.scrollview",
			["answer_award/mian/middle"] = "_control.mian.middle",
			["answer_award/mian/top"] = "_control.mian.top",
			["answer_award/mian/middle/award/scrollview/viewport/content"] = "_control.mian.middle.award.scrollview.viewport.content",
			["answer_award/mian/middle/award/scrollview/scrollbarvertical"] = "_control.mian.middle.award.scrollview.scrollbarvertical",
			["answer_award/mian/middle/award/scrollview/scrollbarvertical/slidingarea"] = "_control.mian.middle.award.scrollview.scrollbarvertical.slidingarea",
			["answer_award/mian/top/point/img"] = "_control.mian.top.point.img",
			["answer_award/mian/top/point"] = "_control.mian.top.point",
			["answer_award/mian/middle/award/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.handle",
			["answer_award/mian/middle/award"] = "_control.mian.middle.award",
			["answer_award/bg"] = "_control.bg",
			["answer_award/shadow"] = "_control.shadow",
			["answer_award/mian/top/point/desc"] = "_control.mian.top.point.desc",
			["answer_award/shadow/btn"] = "_control.shadow.btn",
			["answer_award/detail_shadow"] = "_control.detail_shadow",
			["answer_award/mian/top/point/num"] = "_control.mian.top.point.num",
			["answer_award/mian/middle/task/scrollview/task_scrollbarvertical/task_slidingarea"] = "_control.mian.middle.task.scrollview.task_scrollbarvertical.task_slidingarea",
			["answer_award/mian/top/title"] = "_control.mian.top.title",
			["answer_award/mian/middle/task/scrollview/viewport/content"] = "_control.mian.middle.task.scrollview.viewport.content",
			["answer_award/mian/middle/task/scrollview/viewport"] = "_control.mian.middle.task.scrollview.viewport",
			["answer_award/mian/middle/task/scrollview"] = "_control.mian.middle.task.scrollview"
		},
		click = {
			["mian/top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["shadow/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			detail_shadow = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UITweenSequence"
				}
			},
			btn_group = {
				path = "btn_group",
				list = {
					story_btn_1 = {
						path = "btn_group/story_btn_1",
						list = {
							txt_scroller = {
								path = "btn_group/story_btn_1/txt_scroller",
								list = {
									txt = {
										path = "btn_group/story_btn_1/txt_scroller/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_1 = {
										path = "btn_group/story_btn_1/txt_scroller/txt_1",
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
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
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
					story_btn_2 = {
						path = "btn_group/story_btn_2",
						list = {
							txt_scroller = {
								path = "btn_group/story_btn_2/txt_scroller",
								list = {
									txt = {
										path = "btn_group/story_btn_2/txt_scroller/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_1 = {
										path = "btn_group/story_btn_2/txt_scroller/txt_1",
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
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
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
					story_btn_3 = {
						path = "btn_group/story_btn_3",
						list = {
							txt_scroller = {
								path = "btn_group/story_btn_3/txt_scroller",
								list = {
									txt = {
										path = "btn_group/story_btn_3/txt_scroller/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_1 = {
										path = "btn_group/story_btn_3/txt_scroller/txt_1",
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
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
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
					story_btn_4 = {
						path = "btn_group/story_btn_4",
						list = {
							txt_scroller = {
								path = "btn_group/story_btn_4/txt_scroller",
								list = {
									txt = {
										path = "btn_group/story_btn_4/txt_scroller/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_1 = {
										path = "btn_group/story_btn_4/txt_scroller/txt_1",
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
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
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
					"UnityEngine.RectTransform",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		call_node_list = {
			["story_btn_info/btn_group/story_btn_3/txt_scroller/txt"] = "_control.btn_group.story_btn_3.txt_scroller.txt",
			["story_btn_info/btn_group/story_btn_1"] = "_control.btn_group.story_btn_1",
			["story_btn_info/btn_group/story_btn_2/txt_scroller/txt_1"] = "_control.btn_group.story_btn_2.txt_scroller.txt_1",
			["story_btn_info/btn_group/story_btn_2"] = "_control.btn_group.story_btn_2",
			["story_btn_info/btn_group/story_btn_2/txt_scroller/txt"] = "_control.btn_group.story_btn_2.txt_scroller.txt",
			["story_btn_info/btn_group"] = "_control.btn_group",
			["story_btn_info/btn_group/story_btn_3/txt_scroller/txt_1"] = "_control.btn_group.story_btn_3.txt_scroller.txt_1",
			["story_btn_info/btn_group/story_btn_2/txt_scroller"] = "_control.btn_group.story_btn_2.txt_scroller",
			["story_btn_info/btn_group/story_btn_1/txt_scroller/txt_1"] = "_control.btn_group.story_btn_1.txt_scroller.txt_1",
			["story_btn_info/btn_group/story_btn_3/txt_scroller"] = "_control.btn_group.story_btn_3.txt_scroller",
			["story_btn_info/btn_group/story_btn_1/txt_scroller"] = "_control.btn_group.story_btn_1.txt_scroller",
			["story_btn_info/btn_group/story_btn_4/txt_scroller/txt"] = "_control.btn_group.story_btn_4.txt_scroller.txt",
			["story_btn_info/btn_group/story_btn_4/txt_scroller/txt_1"] = "_control.btn_group.story_btn_4.txt_scroller.txt_1",
			["story_btn_info/btn_group/story_btn_3"] = "_control.btn_group.story_btn_3",
			["story_btn_info/btn_group/story_btn_4/txt_scroller"] = "_control.btn_group.story_btn_4.txt_scroller",
			["story_btn_info/btn_group/story_btn_1/txt_scroller/txt"] = "_control.btn_group.story_btn_1.txt_scroller.txt",
			["story_btn_info/btn_group/story_btn_4"] = "_control.btn_group.story_btn_4",
			["story_btn_info/bg"] = "_control.bg"
		},
		click = {
			bg = {
				tp = "UnityEngine.UI.Button"
			},
			["btn_group/story_btn_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["btn_group/story_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["btn_group/story_btn_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["btn_group/story_btn_4"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

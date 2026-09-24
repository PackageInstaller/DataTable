return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			},
			top_widget = {
				path = "top_widget",
				list = {
					return_btn = {
						path = "top_widget/return_btn",
						list = {},
						component = {
							"ScaleButton"
						}
					},
					top_title_text = {
						path = "top_widget/top_title_text",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					top_title_line = {
						path = "top_widget/top_title_line",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					page_index_one = {
						path = "top_widget/page_index_one",
						list = {
							not_image = {
								path = "top_widget/page_index_one/not_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							selected_image = {
								path = "top_widget/page_index_one/selected_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							number = {
								path = "top_widget/page_index_one/number",
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
					page_index_two = {
						path = "top_widget/page_index_two",
						list = {
							not_image = {
								path = "top_widget/page_index_two/not_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							selected_image = {
								path = "top_widget/page_index_two/selected_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							number = {
								path = "top_widget/page_index_two/number",
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
					page_index_three = {
						path = "top_widget/page_index_three",
						list = {
							not_image = {
								path = "top_widget/page_index_three/not_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							selected_image = {
								path = "top_widget/page_index_three/selected_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							number = {
								path = "top_widget/page_index_three/number",
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
					left_btn = {
						path = "top_widget/left_btn",
						list = {
							SkeletonGraphic = {
								path = "top_widget/left_btn/SkeletonGraphic",
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
							"UnityEngine.UI.Button"
						}
					},
					right_btn = {
						path = "top_widget/right_btn",
						list = {
							SkeletonGraphic = {
								path = "top_widget/right_btn/SkeletonGraphic",
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
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			buttom_weight = {
				path = "buttom_weight",
				list = {
					teams = {
						path = "buttom_weight/teams",
						list = {
							Viewport = {
								path = "buttom_weight/teams/Viewport",
								list = {
									Content = {
										path = "buttom_weight/teams/Viewport/Content",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.VerticalLayoutGroup",
											"UnityEngine.UI.ContentSizeFitter"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							scrollbarvertical = {
								path = "buttom_weight/teams/scrollbarvertical",
								list = {
									slidingarea = {
										path = "buttom_weight/teams/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "buttom_weight/teams/scrollbarvertical/slidingarea/handle",
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
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			cover = {
				path = "cover",
				list = {},
				component = {
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["pre_formation/top_widget/page_index_two/not_image"] = "_control.top_widget.page_index_two.not_image",
			["pre_formation/top_widget/page_index_three"] = "_control.top_widget.page_index_three",
			["pre_formation/top_widget/page_index_two"] = "_control.top_widget.page_index_two",
			["pre_formation/bg"] = "_control.bg",
			["pre_formation/top_widget/top_title_text"] = "_control.top_widget.top_title_text",
			["pre_formation/top_widget/page_index_one/not_image"] = "_control.top_widget.page_index_one.not_image",
			["pre_formation/top_widget/page_index_one/number"] = "_control.top_widget.page_index_one.number",
			["pre_formation/top_widget/page_index_one/selected_image"] = "_control.top_widget.page_index_one.selected_image",
			["pre_formation/top_widget/page_index_two/number"] = "_control.top_widget.page_index_two.number",
			["pre_formation/top_widget/page_index_three/number"] = "_control.top_widget.page_index_three.number",
			["pre_formation/top_widget/left_btn"] = "_control.top_widget.left_btn",
			["pre_formation/buttom_weight/teams/scrollbarvertical/slidingarea/handle"] = "_control.buttom_weight.teams.scrollbarvertical.slidingarea.handle",
			["pre_formation/buttom_weight/teams"] = "_control.buttom_weight.teams",
			["pre_formation/top_widget/page_index_three/selected_image"] = "_control.top_widget.page_index_three.selected_image",
			["pre_formation/top_widget/left_btn/SkeletonGraphic"] = "_control.top_widget.left_btn.SkeletonGraphic",
			["pre_formation/top_widget"] = "_control.top_widget",
			["pre_formation/top_widget/page_index_two/selected_image"] = "_control.top_widget.page_index_two.selected_image",
			["pre_formation/top_widget/page_index_three/not_image"] = "_control.top_widget.page_index_three.not_image",
			["pre_formation/buttom_weight/teams/Viewport"] = "_control.buttom_weight.teams.Viewport",
			["pre_formation/buttom_weight/teams/Viewport/Content"] = "_control.buttom_weight.teams.Viewport.Content",
			["pre_formation/top_widget/page_index_one"] = "_control.top_widget.page_index_one",
			["pre_formation/top_widget/right_btn/SkeletonGraphic"] = "_control.top_widget.right_btn.SkeletonGraphic",
			["pre_formation/top_widget/top_title_line"] = "_control.top_widget.top_title_line",
			["pre_formation/buttom_weight/teams/scrollbarvertical/slidingarea"] = "_control.buttom_weight.teams.scrollbarvertical.slidingarea",
			["pre_formation/buttom_weight"] = "_control.buttom_weight",
			["pre_formation/top_widget/right_btn"] = "_control.top_widget.right_btn",
			["pre_formation/cover"] = "_control.cover",
			["pre_formation/buttom_weight/teams/scrollbarvertical"] = "_control.buttom_weight.teams.scrollbarvertical",
			["pre_formation/top_widget/return_btn"] = "_control.top_widget.return_btn"
		},
		click = {
			["top_widget/page_index_one/not_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top_widget/page_index_two/not_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top_widget/page_index_three/not_image"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top_widget/left_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top_widget/right_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top_widget/return_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

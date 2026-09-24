return {
	_rule_ = {
		none = {
			test = {
				path = "test",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			move_sequence = {
				path = "move_sequence",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			cg = {
				path = "cg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			cg_completely = {
				path = "cg_completely",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			move_group = {
				path = "move_group",
				list = {
					mash_desc = {
						path = "move_group/mash_desc",
						list = {
							sort_txt = {
								path = "move_group/mash_desc/sort_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							desc_txt = {
								path = "move_group/mash_desc/desc_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							number_decoration = {
								path = "move_group/mash_desc/number_decoration",
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
					mash_title = {
						path = "move_group/mash_title",
						list = {
							txt = {
								path = "move_group/mash_title/txt",
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
							"UnityEngine.UI.HorizontalLayoutGroup",
							"UnityEngine.UI.ContentSizeFitter"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			cover = {
				path = "cover",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			get_cover_btn = {
				path = "get_cover_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			next_page_btn = {
				path = "next_page_btn",
				list = {
					next_page_spine = {
						path = "next_page_btn/next_page_spine",
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
					"UnityEngine.UI.Button",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			last_page_btn = {
				path = "last_page_btn",
				list = {
					last_page_spine = {
						path = "last_page_btn/last_page_spine",
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
					"UnityEngine.UI.Button",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			return_btn = {
				path = "return_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			shrink_btn = {
				path = "shrink_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			extend_btn = {
				path = "extend_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			}
		},
		click = {
			cover = {
				tp = "UnityEngine.UI.Button"
			},
			get_cover_btn = {
				tp = "UnityEngine.UI.Button"
			},
			next_page_btn = {
				tp = "UnityEngine.UI.Button"
			},
			last_page_btn = {
				tp = "UnityEngine.UI.Button"
			},
			return_btn = {
				tp = "UnityEngine.UI.Button"
			},
			shrink_btn = {
				tp = "UnityEngine.UI.Button"
			},
			extend_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

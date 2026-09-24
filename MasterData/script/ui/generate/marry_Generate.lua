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
					"UITweenSequence"
				}
			},
			content = {
				path = "content",
				list = {
					bg_container = {
						path = "content/bg_container",
						list = {
							bg = {
								path = "content/bg_container/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_mask = {
								path = "content/bg_container/bg_mask",
								list = {
									bg = {
										path = "content/bg_container/bg_mask/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_cover = {
										path = "content/bg_container/bg_mask/bg_cover",
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
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					title = {
						path = "content/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					point = {
						path = "content/point",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					cur_love = {
						path = "content/cur_love",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					need_love = {
						path = "content/need_love",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					heart = {
						path = "content/heart",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					heart_mask = {
						path = "content/heart_mask",
						list = {
							heart = {
								path = "content/heart_mask/heart",
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
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					close_btn = {
						path = "content/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					select_btn = {
						path = "content/select_btn",
						list = {
							title = {
								path = "content/select_btn/title",
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
					love_info_have = {
						path = "content/love_info_have",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					cur_ring = {
						path = "content/cur_ring",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					need_ring = {
						path = "content/need_ring",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					ceremony_desc = {
						path = "content/ceremony_desc",
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
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		call_node_list = {
			["marry/content/point"] = "_control.content.point",
			["marry/content/bg_container"] = "_control.content.bg_container",
			["marry/content/bg_container/bg_mask"] = "_control.content.bg_container.bg_mask",
			["marry/content/heart_mask/heart"] = "_control.content.heart_mask.heart",
			["marry/content/select_btn"] = "_control.content.select_btn",
			["marry/content"] = "_control.content",
			["marry/content/need_ring"] = "_control.content.need_ring",
			["marry/content/close_btn"] = "_control.content.close_btn",
			["marry/content/ceremony_desc"] = "_control.content.ceremony_desc",
			["marry/content/need_love"] = "_control.content.need_love",
			["marry/bg"] = "_control.bg",
			["marry/content/heart"] = "_control.content.heart",
			["marry/content/bg_container/bg"] = "_control.content.bg_container.bg",
			["marry/content/cur_ring"] = "_control.content.cur_ring",
			["marry/content/bg_container/bg_mask/bg_cover"] = "_control.content.bg_container.bg_mask.bg_cover",
			["marry/content/select_btn/title"] = "_control.content.select_btn.title",
			["marry/content/cur_love"] = "_control.content.cur_love",
			["marry/content/bg_container/bg_mask/bg"] = "_control.content.bg_container.bg_mask.bg",
			["marry/content/title"] = "_control.content.title",
			["marry/content/heart_mask"] = "_control.content.heart_mask",
			["marry/content/love_info_have"] = "_control.content.love_info_have"
		},
		click = {
			["content/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["content/select_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

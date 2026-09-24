return {
	_rule_ = {
		none = {
			bg_content = {
				path = "bg_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			bg_content_back_ground = {
				path = "bg_content_back_ground",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			text_content = {
				path = "text_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			school_content = {
				path = "school_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			medal_content = {
				path = "medal_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			new_head_content = {
				path = "new_head_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			picture_content = {
				path = "picture_content",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup",
					"Matrix.UIGroupFadeTweener",
					"Matrix.UIGroupFadeTweener"
				}
			},
			name_point = {
				path = "name_point",
				list = {
					skin_des = {
						path = "name_point/skin_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					skin_name = {
						path = "name_point/skin_name",
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
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			school_info = {
				path = "school_info",
				list = {
					text_des = {
						path = "school_info/text_des",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			medal_point = {
				path = "medal_point",
				list = {
					medal_des = {
						path = "medal_point/medal_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					medal_name = {
						path = "medal_point/medal_name",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			new_head = {
				path = "new_head",
				list = {
					get_des = {
						path = "new_head/get_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					head_name = {
						path = "new_head/head_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					head_image = {
						path = "new_head/head_image",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			picture_point = {
				path = "picture_point",
				list = {
					skin_des = {
						path = "picture_point/skin_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					skin_name = {
						path = "picture_point/skin_name",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			}
		},
		call_node_list = {
			["reward_tip/medal_content"] = "_control.medal_content",
			["reward_tip/bg_content_back_ground"] = "_control.bg_content_back_ground",
			["reward_tip/picture_content"] = "_control.picture_content",
			["reward_tip/new_head/get_des"] = "_control.new_head.get_des",
			["reward_tip/school_content"] = "_control.school_content",
			["reward_tip/bg"] = "_control.bg",
			["reward_tip/medal_point"] = "_control.medal_point",
			["reward_tip/new_head"] = "_control.new_head",
			["reward_tip/text_content"] = "_control.text_content",
			["reward_tip/picture_point/skin_name"] = "_control.picture_point.skin_name",
			["reward_tip/picture_point/skin_des"] = "_control.picture_point.skin_des",
			["reward_tip/name_point"] = "_control.name_point",
			["reward_tip/new_head/head_name"] = "_control.new_head.head_name",
			["reward_tip/new_head/head_image"] = "_control.new_head.head_image",
			["reward_tip/name_point/skin_des"] = "_control.name_point.skin_des",
			["reward_tip/medal_point/medal_name"] = "_control.medal_point.medal_name",
			["reward_tip/name_point/skin_name"] = "_control.name_point.skin_name",
			["reward_tip/school_info/text_des"] = "_control.school_info.text_des",
			["reward_tip/new_head_content"] = "_control.new_head_content",
			["reward_tip/medal_point/medal_des"] = "_control.medal_point.medal_des",
			["reward_tip/picture_point"] = "_control.picture_point",
			["reward_tip/bg_content"] = "_control.bg_content",
			["reward_tip/school_info"] = "_control.school_info"
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			locked_btn = {
				path = "locked_btn",
				list = {
					lock_bg = {
						path = "locked_btn/lock_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					unget_icon_bg = {
						path = "locked_btn/unget_icon_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					unget_tip_txt = {
						path = "locked_btn/unget_tip_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					point_bg = {
						path = "locked_btn/point_bg",
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
					"UnityEngine.UI.Button"
				}
			},
			stop_btn = {
				path = "stop_btn",
				list = {
					point_bg = {
						path = "stop_btn/point_bg",
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
					"UnityEngine.UI.Button",
					"ClickAndLongClickEvent"
				}
			},
			music_name_txt = {
				path = "music_name_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			progress_bg = {
				path = "progress_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			play_btn = {
				path = "play_btn",
				list = {
					point_bg = {
						path = "play_btn/point_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					["progress_bg "] = {
						path = "play_btn/progress_bg ",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					progress = {
						path = "play_btn/progress",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					time_txt = {
						path = "play_btn/time_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					music_name_txt = {
						path = "play_btn/music_name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					anim = {
						path = "play_btn/anim",
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
					"ClickAndLongClickEvent"
				}
			},
			sort_txt = {
				path = "sort_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			bgm_txt = {
				path = "bgm_txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			GameObject = {
				path = "GameObject",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			locked_btn = {
				tp = "UnityEngine.UI.Button"
			},
			stop_btn = {
				tp = "UnityEngine.UI.Button"
			},
			play_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			stop_btn = {
				tp = "ClickAndLongClickEvent"
			},
			play_btn = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

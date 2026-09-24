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
			teacher = {
				path = "teacher",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIMoveTweener"
				}
			},
			emptyone = {
				path = "emptyone",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			emptytwo = {
				path = "emptytwo",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIMoveTweener",
					"UITweenSequence"
				}
			},
			talkone = {
				path = "talkone",
				list = {
					bg1 = {
						path = "talkone/bg1",
						list = {
							bg2 = {
								path = "talkone/bg1/bg2",
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
						path = "talkone/label_txt",
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
					"Matrix.UIGroupFadeTweener",
					"Matrix.UIGroupFadeTweener",
					"Matrix.UIGroupFadeTweener",
					"PopVerticalAdaptive"
				}
			},
			talktwo = {
				path = "talktwo",
				list = {
					bg1 = {
						path = "talktwo/bg1",
						list = {
							bg2 = {
								path = "talktwo/bg1/bg2",
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
						path = "talktwo/label_txt",
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
					"Matrix.UIGroupFadeTweener",
					"Matrix.UIGroupFadeTweener",
					"Matrix.UIGroupFadeTweener",
					"PopVerticalAdaptive"
				}
			},
			btn = {
				path = "btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		click = {
			btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

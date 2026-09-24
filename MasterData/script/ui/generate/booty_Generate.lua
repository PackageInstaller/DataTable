return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			line = {
				path = "line",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			equipname = {
				path = "equipname",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			typename = {
				path = "typename",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			numberof = {
				path = "numberof",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			equipimg = {
				path = "equipimg",
				list = {
					bg = {
						path = "equipimg/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					img = {
						path = "equipimg/img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					imgbtn = {
						path = "equipimg/imgbtn",
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
			price = {
				path = "price",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"ScaleButton",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			timelimit = {
				path = "timelimit",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			pricenumber = {
				path = "pricenumber",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text",
					"UnityEngine.CanvasGroup"
				}
			},
			priceimg = {
				path = "priceimg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup"
				}
			},
			unknowtwo = {
				path = "unknowtwo",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			btn = {
				path = "btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"ScaleButton"
				}
			},
			activity = {
				path = "activity",
				list = {
					content = {
						path = "activity/content",
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
		click = {
			["equipimg/imgbtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			price = {
				tp = "ScaleButton"
			},
			btn = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {
			price = {
				component = "UnityEngine.Canvas",
				path = "price"
			}
		}
	}
}

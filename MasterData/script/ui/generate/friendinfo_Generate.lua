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
			main = {
				path = "main",
				list = {
					bg = {
						path = "main/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line = {
						path = "main/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					leftimg = {
						path = "main/leftimg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					rankbg = {
						path = "main/rankbg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					rankicon = {
						path = "main/rankicon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					rank = {
						path = "main/rank",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					close = {
						path = "main/close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					uid = {
						path = "main/uid",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					uidnumb = {
						path = "main/uidnumb",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					friendname = {
						path = "main/friendname",
						list = {
							lv = {
								path = "main/friendname/lv",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					visit = {
						path = "main/visit",
						list = {
							text = {
								path = "main/visit/text",
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
					delfriend = {
						path = "main/delfriend",
						list = {
							text = {
								path = "main/delfriend/text",
								list = {},
								component = {
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
					top_stick = {
						path = "main/top_stick",
						list = {
							text = {
								path = "main/top_stick/text",
								list = {},
								component = {
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
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["friendinfo/bg"] = "_control.bg",
			["friendinfo/main/friendname"] = "_control.main.friendname",
			["friendinfo/main/top_stick/text"] = "_control.main.top_stick.text",
			["friendinfo/main/uidnumb"] = "_control.main.uidnumb",
			["friendinfo/main/uid"] = "_control.main.uid",
			["friendinfo/main/close"] = "_control.main.close",
			["friendinfo/main/friendname/lv"] = "_control.main.friendname.lv",
			["friendinfo/main/top_stick"] = "_control.main.top_stick",
			["friendinfo/main/visit"] = "_control.main.visit",
			["friendinfo/main/delfriend/text"] = "_control.main.delfriend.text",
			["friendinfo/main/leftimg"] = "_control.main.leftimg",
			["friendinfo/main/rankicon"] = "_control.main.rankicon",
			["friendinfo/main/visit/text"] = "_control.main.visit.text",
			["friendinfo/main/rank"] = "_control.main.rank",
			["friendinfo/main/bg"] = "_control.main.bg",
			["friendinfo/main/rankbg"] = "_control.main.rankbg",
			["friendinfo/main"] = "_control.main",
			["friendinfo/main/line"] = "_control.main.line",
			["friendinfo/main/delfriend"] = "_control.main.delfriend"
		},
		click = {
			["main/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/visit"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/delfriend"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top_stick"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

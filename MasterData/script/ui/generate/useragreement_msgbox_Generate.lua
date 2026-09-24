return {
	_rule_ = {
		none = {
			btn = {
				path = "btn",
				list = {
					confirm = {
						path = "btn/confirm",
						list = {
							text = {
								path = "btn/confirm/text",
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
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					back = {
						path = "btn/back",
						list = {
							text = {
								path = "btn/back/text",
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
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			btn_back = {
				path = "btn_back",
				list = {
					confirm = {
						path = "btn_back/confirm",
						list = {
							text = {
								path = "btn_back/confirm/text",
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
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			toptitle = {
				path = "toptitle",
				list = {
					icon_two = {
						path = "toptitle/icon_two",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					icon_one = {
						path = "toptitle/icon_one",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					agreetitle = {
						path = "toptitle/agreetitle",
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
			agreecontent = {
				path = "agreecontent",
				list = {
					agreetext = {
						path = "agreecontent/agreetext",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter",
							"UnityEngine.UI.GridLayoutGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask",
					"UnityEngine.UI.ScrollRect"
				}
			},
			double_useragreement = {
				path = "double_useragreement",
				list = {
					text = {
						path = "double_useragreement/text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					user_btn = {
						path = "double_useragreement/user_btn",
						list = {
							text = {
								path = "double_useragreement/user_btn/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							image = {
								path = "double_useragreement/user_btn/image",
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
					privacy_btn = {
						path = "double_useragreement/privacy_btn",
						list = {
							text = {
								path = "double_useragreement/privacy_btn/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							image = {
								path = "double_useragreement/privacy_btn/image",
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
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			button = {
				path = "button",
				list = {
					text = {
						path = "button/text",
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
			}
		},
		click = {
			["btn/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["btn/back"] = {
				tp = "UnityEngine.UI.Button"
			},
			["btn_back/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["double_useragreement/user_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["double_useragreement/privacy_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			button = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

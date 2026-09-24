return {
	_rule_ = {
		none = {
			main = {
				path = "main",
				list = {
					main_bg = {
						path = "main/main_bg",
						list = {},
						component = {}
					},
					title = {
						path = "main/title",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					useragreement = {
						path = "main/useragreement",
						list = {
							content = {
								path = "main/useragreement/content",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.UI.Mask"
						}
					},
					back = {
						path = "main/back",
						list = {
							text = {
								path = "main/back/text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					confirm = {
						path = "main/confirm",
						list = {
							text = {
								path = "main/confirm/text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			},
			webview = {
				path = "webview",
				list = {
					main_bg = {
						path = "webview/main_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image",
							"UniWebView"
						}
					},
					close = {
						path = "webview/close",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			}
		},
		call_node_list = {
			["msgbox_agreement_cn/main/confirm/text"] = "_control.main.confirm.text",
			["msgbox_agreement_cn/webview"] = "_control.webview",
			["msgbox_agreement_cn/main/title"] = "_control.main.title",
			["msgbox_agreement_cn/main"] = "_control.main",
			["msgbox_agreement_cn/webview/main_bg"] = "_control.webview.main_bg",
			["msgbox_agreement_cn/main/confirm"] = "_control.main.confirm",
			["msgbox_agreement_cn/main/main_bg"] = "_control.main.main_bg",
			["msgbox_agreement_cn/main/useragreement/content"] = "_control.main.useragreement.content",
			["msgbox_agreement_cn/webview/close"] = "_control.webview.close",
			["msgbox_agreement_cn/main/back/text"] = "_control.main.back.text",
			["msgbox_agreement_cn/main/back"] = "_control.main.back",
			["msgbox_agreement_cn/main/useragreement"] = "_control.main.useragreement"
		},
		click = {
			["main/back"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["webview/close"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		uni_web_view = {
			["webview/main_bg"] = {
				tp = "UniWebView"
			}
		},
		canvas_set = {}
	}
}

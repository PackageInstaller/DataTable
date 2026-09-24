return {
	_rule_ = {
		none = {
			shadow = {
				path = "shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup",
					"UITweenSequence"
				}
			},
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
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
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
							"UnityEngine.UI.Image"
						}
					},
					icon_one = {
						path = "toptitle/icon_one",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image"
						}
					},
					agreetitle = {
						path = "toptitle/agreetitle",
						list = {},
						component = {
							"UnityEngine.RectTransform",
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
							"UnityEngine.UI.Text",
							"UnityEngine.UI.ContentSizeFitter",
							"UnityEngine.UI.GridLayoutGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Mask",
					"UnityEngine.UI.ScrollRect"
				}
			}
		},
		click = {
			["btn/confirm"] = {
				tp = "UnityEngine.UI.Button"
			}
		}
	}
}

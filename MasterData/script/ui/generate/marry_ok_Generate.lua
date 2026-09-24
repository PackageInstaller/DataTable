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
					"UnityEngine.UI.Button"
				}
			},
			ship_role = {
				path = "ship_role",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			content = {
				path = "content",
				list = {
					type_txt = {
						path = "content/type_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_txt = {
						path = "content/name_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					scrollview = {
						path = "content/scrollview",
						list = {
							content = {
								path = "content/scrollview/content",
								list = {
									info_txt = {
										path = "content/scrollview/content/info_txt",
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
									"UnityEngine.UI.ContentSizeFitter",
									"UnityEngine.UI.VerticalLayoutGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			mask = {
				path = "mask",
				list = {
					marry_anim = {
						path = "mask/marry_anim",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.MeshFilter",
							"UnityEngine.MeshRenderer",
							"Spine.Unity.SkeletonAnimation"
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
			bg = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			iconlayer = {
				path = "iconlayer",
				list = {
					icon_mask = {
						path = "iconlayer/icon_mask",
						list = {
							icon = {
								path = "iconlayer/icon_mask/icon",
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
							"UnityEngine.UI.Mask",
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
			nogetlayer = {
				path = "nogetlayer",
				list = {
					des = {
						path = "nogetlayer/des",
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
			},
			graylayer = {
				path = "graylayer",
				list = {
					grayname = {
						path = "graylayer/grayname",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					grayname_2 = {
						path = "graylayer/grayname_2",
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
					"UnityEngine.UI.Mask",
					"TextHorizonScroller"
				}
			},
			img_layer = {
				path = "img_layer",
				list = {
					imgname = {
						path = "img_layer/imgname",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					imgname_2 = {
						path = "img_layer/imgname_2",
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
					"UnityEngine.UI.Mask",
					"TextHorizonScroller"
				}
			},
			used = {
				path = "used",
				list = {
					imgname = {
						path = "used/imgname",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			pricebtn = {
				path = "pricebtn",
				list = {
					pricenumber = {
						path = "pricebtn/pricenumber",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					priceimg = {
						path = "pricebtn/priceimg",
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
			bought = {
				path = "bought",
				list = {
					desc = {
						path = "bought/desc",
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
			label = {
				path = "label",
				list = {
					label_des = {
						path = "label/label_des",
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
			},
			iconbtn = {
				path = "iconbtn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["single_skin_item/pricebtn/priceimg"] = "_control.pricebtn.priceimg",
			["single_skin_item/pricebtn/pricenumber"] = "_control.pricebtn.pricenumber",
			["single_skin_item/used"] = "_control.used",
			["single_skin_item/img_layer"] = "_control.img_layer",
			["single_skin_item/nogetlayer"] = "_control.nogetlayer",
			["single_skin_item/iconbtn"] = "_control.iconbtn",
			["single_skin_item/graylayer/grayname"] = "_control.graylayer.grayname",
			["single_skin_item/img_layer/imgname_2"] = "_control.img_layer.imgname_2",
			["single_skin_item/bought"] = "_control.bought",
			["single_skin_item/pricebtn"] = "_control.pricebtn",
			["single_skin_item/iconlayer"] = "_control.iconlayer",
			["single_skin_item/label"] = "_control.label",
			["single_skin_item/graylayer/grayname_2"] = "_control.graylayer.grayname_2",
			["single_skin_item/graylayer"] = "_control.graylayer",
			["single_skin_item/label/label_des"] = "_control.label.label_des",
			["single_skin_item/iconlayer/icon_mask"] = "_control.iconlayer.icon_mask",
			["single_skin_item/used/imgname"] = "_control.used.imgname",
			["single_skin_item/img_layer/imgname"] = "_control.img_layer.imgname",
			["single_skin_item/nogetlayer/des"] = "_control.nogetlayer.des",
			["single_skin_item/bought/desc"] = "_control.bought.desc",
			["single_skin_item/iconlayer/icon_mask/icon"] = "_control.iconlayer.icon_mask.icon"
		},
		click = {
			pricebtn = {
				tp = "UnityEngine.UI.Button"
			},
			bought = {
				tp = "UnityEngine.UI.Button"
			},
			iconbtn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					top_image = {
						path = "bg/top_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					down_image = {
						path = "bg/down_image",
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
					"UITweenSequence"
				}
			},
			mainprops = {
				path = "mainprops",
				list = {
					scrollview = {
						path = "mainprops/scrollview",
						list = {
							viewport = {
								path = "mainprops/scrollview/viewport",
								list = {
									content = {
										path = "mainprops/scrollview/viewport/content",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"EndlessScrollView"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							scrollbarvertical = {
								path = "mainprops/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "mainprops/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "mainprops/scrollview/scrollbarvertical/slidingarea/handle",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Scrollbar"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ScrollRect",
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
			maintop = {
				path = "maintop",
				list = {
					topmenu = {
						path = "maintop/topmenu",
						list = {
							combat = {
								path = "maintop/topmenu/combat",
								list = {
									icon = {
										path = "maintop/topmenu/combat/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									combat_node = {
										path = "maintop/topmenu/combat/combat_node",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									combat_num = {
										path = "maintop/topmenu/combat/combat_num",
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
							lineone = {
								path = "maintop/topmenu/lineone",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlineone = {
								path = "maintop/topmenu/btnlineone",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinetwo = {
								path = "maintop/topmenu/btnlinetwo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinethree = {
								path = "maintop/topmenu/btnlinethree",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinefour = {
								path = "maintop/topmenu/btnlinefour",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinefive = {
								path = "maintop/topmenu/btnlinefive",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							linetwo = {
								path = "maintop/topmenu/linetwo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							topbtn = {
								path = "maintop/topmenu/topbtn",
								list = {
									btnone = {
										path = "maintop/topmenu/topbtn/btnone",
										list = {
											btnimg = {
												path = "maintop/topmenu/topbtn/btnone/btnimg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "maintop/topmenu/topbtn/btnone/text",
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
											"UnityEngine.UI.Toggle",
											"UITweenSequence"
										}
									},
									btntwo = {
										path = "maintop/topmenu/topbtn/btntwo",
										list = {
											btnimgtwo = {
												path = "maintop/topmenu/topbtn/btntwo/btnimgtwo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "maintop/topmenu/topbtn/btntwo/text",
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
											"UnityEngine.UI.Toggle",
											"UITweenSequence"
										}
									},
									btnthree = {
										path = "maintop/topmenu/topbtn/btnthree",
										list = {
											btnimgthree = {
												path = "maintop/topmenu/topbtn/btnthree/btnimgthree",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "maintop/topmenu/topbtn/btnthree/text",
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
											"UnityEngine.UI.Toggle",
											"UITweenSequence"
										}
									},
									btnfour = {
										path = "maintop/topmenu/topbtn/btnfour",
										list = {
											btnimgfour = {
												path = "maintop/topmenu/topbtn/btnfour/btnimgfour",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "maintop/topmenu/topbtn/btnfour/text",
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
											"UnityEngine.UI.Toggle",
											"UITweenSequence"
										}
									},
									btnfive = {
										path = "maintop/topmenu/topbtn/btnfive",
										list = {
											btnimgfive = {
												path = "maintop/topmenu/topbtn/btnfive/btnimgfive",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "maintop/topmenu/topbtn/btnfive/text",
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
											"UnityEngine.UI.Toggle",
											"UITweenSequence"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup"
								}
							},
							returnbtn = {
								path = "maintop/topmenu/returnbtn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			bottomline = {
				path = "bottomline",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			bg_shadow = {
				path = "bg_shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			shop_bounced = {
				path = "shop_bounced",
				list = {
					maskbg = {
						path = "shop_bounced/maskbg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					main = {
						path = "shop_bounced/main",
						list = {
							main_bg = {
								path = "shop_bounced/main/main_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_decore = {
								path = "shop_bounced/main/top_decore",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top = {
								path = "shop_bounced/main/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_text = {
								path = "shop_bounced/main/title_text",
								list = {
									gogo = {
										path = "shop_bounced/main/title_text/gogo",
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
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							main = {
								path = "shop_bounced/main/main",
								list = {
									use_text = {
										path = "shop_bounced/main/main/use_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									normal = {
										path = "shop_bounced/main/main/normal",
										list = {
											icon = {
												path = "shop_bounced/main/main/normal/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											former_num = {
												path = "shop_bounced/main/main/normal/former_num",
												list = {
													arrow = {
														path = "shop_bounced/main/main/normal/former_num/arrow",
														list = {
															latter_num = {
																path = "shop_bounced/main/main/normal/former_num/arrow/latter_num",
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
															"UnityEngine.UI.Image"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.ContentSizeFitter"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							confirmbtn = {
								path = "shop_bounced/main/confirmbtn",
								list = {
									text = {
										path = "shop_bounced/main/confirmbtn/text",
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
							quitbtn = {
								path = "shop_bounced/main/quitbtn",
								list = {
									text = {
										path = "shop_bounced/main/quitbtn/text",
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
						component = {
							"UnityEngine.RectTransform",
							"UIScaleTweener",
							"UIScaleTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		click = {
			bg_shadow = {
				tp = "UnityEngine.UI.Button"
			},
			["shop_bounced/main/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["shop_bounced/main/quitbtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["maintop/topmenu/returnbtn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["maintop/topmenu/topbtn/btnone"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["maintop/topmenu/topbtn/btntwo"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["maintop/topmenu/topbtn/btnthree"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["maintop/topmenu/topbtn/btnfour"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["maintop/topmenu/topbtn/btnfive"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			shop_bounced = {
				component = "UnityEngine.Canvas",
				path = "shop_bounced"
			}
		}
	}
}

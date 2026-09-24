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
			content = {
				path = "content",
				list = {
					bg = {
						path = "content/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg_layer = {
						path = "content/bg_layer",
						list = {
							bg_title = {
								path = "content/bg_layer/bg_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							cover = {
								path = "content/bg_layer/cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "content/bg_layer/line",
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
					},
					title = {
						path = "content/title",
						list = {
							point = {
								path = "content/title/point",
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
					record_layer = {
						path = "content/record_layer",
						list = {
							left = {
								path = "content/record_layer/left",
								list = {
									title = {
										path = "content/record_layer/left/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									item_1 = {
										path = "content/record_layer/left/item_1",
										list = {
											star = {
												path = "content/record_layer/left/item_1/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/left/item_1/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/left/item_1/num",
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
									item_2 = {
										path = "content/record_layer/left/item_2",
										list = {
											star = {
												path = "content/record_layer/left/item_2/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/left/item_2/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/left/item_2/num",
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
									item_3 = {
										path = "content/record_layer/left/item_3",
										list = {
											star = {
												path = "content/record_layer/left/item_3/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/left/item_3/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/left/item_3/num",
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
									item_4 = {
										path = "content/record_layer/left/item_4",
										list = {
											star = {
												path = "content/record_layer/left/item_4/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/left/item_4/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/left/item_4/num",
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
									item_5 = {
										path = "content/record_layer/left/item_5",
										list = {
											star = {
												path = "content/record_layer/left/item_5/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/left/item_5/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/left/item_5/num",
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							right = {
								path = "content/record_layer/right",
								list = {
									title = {
										path = "content/record_layer/right/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									item_1 = {
										path = "content/record_layer/right/item_1",
										list = {
											star = {
												path = "content/record_layer/right/item_1/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/right/item_1/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/right/item_1/num",
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
									item_2 = {
										path = "content/record_layer/right/item_2",
										list = {
											star = {
												path = "content/record_layer/right/item_2/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/right/item_2/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/right/item_2/num",
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
									item_3 = {
										path = "content/record_layer/right/item_3",
										list = {
											star = {
												path = "content/record_layer/right/item_3/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/right/item_3/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/right/item_3/num",
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
									item_4 = {
										path = "content/record_layer/right/item_4",
										list = {
											star = {
												path = "content/record_layer/right/item_4/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/right/item_4/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/right/item_4/num",
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
									item_5 = {
										path = "content/record_layer/right/item_5",
										list = {
											star = {
												path = "content/record_layer/right/item_5/star",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "content/record_layer/right/item_5/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											num = {
												path = "content/record_layer/right/item_5/num",
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
							"UnityEngine.RectTransform"
						}
					},
					other_layer = {
						path = "content/other_layer",
						list = {
							bg = {
								path = "content/other_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							left = {
								path = "content/other_layer/left",
								list = {
									title = {
										path = "content/other_layer/left/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									date = {
										path = "content/other_layer/left/date",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									star = {
										path = "content/other_layer/left/star",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									item_title = {
										path = "content/other_layer/left/item_title",
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
							right = {
								path = "content/other_layer/right",
								list = {
									title = {
										path = "content/other_layer/right/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									date = {
										path = "content/other_layer/right/date",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									star = {
										path = "content/other_layer/right/star",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star = {
										path = "content/other_layer/right/star",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									star = {
										path = "content/other_layer/right/star",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							line = {
								path = "content/other_layer/line",
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
					},
					medal_layer = {
						path = "content/medal_layer",
						list = {
							bg = {
								path = "content/medal_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							no_medal = {
								path = "content/medal_layer/no_medal",
								list = {
									title = {
										path = "content/medal_layer/no_medal/title",
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
							scroll = {
								path = "content/medal_layer/scroll",
								list = {
									viewport = {
										path = "content/medal_layer/scroll/viewport",
										list = {
											content = {
												path = "content/medal_layer/scroll/viewport/content",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.GridLayoutGroup",
													"UnityEngine.UI.ContentSizeFitter"
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
									"UnityEngine.UI.ScrollRect",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "content/medal_layer/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "content/medal_layer/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							page_bg = {
								path = "content/medal_layer/page_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							desc = {
								path = "content/medal_layer/desc",
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
					detail_layer = {
						path = "content/detail_layer",
						list = {
							bg = {
								path = "content/detail_layer/bg",
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
					},
					toggle_group = {
						path = "content/toggle_group",
						list = {
							tog_detail = {
								path = "content/toggle_group/tog_detail",
								list = {
									Background = {
										path = "content/toggle_group/tog_detail/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/tog_detail/Background/Checkmark",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									title = {
										path = "content/toggle_group/tog_detail/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									page = {
										path = "content/toggle_group/tog_detail/page",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_1 = {
								path = "content/toggle_group/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tog_record = {
								path = "content/toggle_group/tog_record",
								list = {
									Background = {
										path = "content/toggle_group/tog_record/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/tog_record/Background/Checkmark",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									title = {
										path = "content/toggle_group/tog_record/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									page = {
										path = "content/toggle_group/tog_record/page",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_2 = {
								path = "content/toggle_group/line_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tog_medal = {
								path = "content/toggle_group/tog_medal",
								list = {
									Background = {
										path = "content/toggle_group/tog_medal/Background",
										list = {
											Checkmark = {
												path = "content/toggle_group/tog_medal/Background/Checkmark",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									title = {
										path = "content/toggle_group/tog_medal/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									page = {
										path = "content/toggle_group/tog_medal/page",
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
									"UnityEngine.UI.Toggle",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					},
					close_btn = {
						path = "content/close_btn",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["content/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["content/toggle_group/tog_detail"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/toggle_group/tog_record"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["content/toggle_group/tog_medal"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

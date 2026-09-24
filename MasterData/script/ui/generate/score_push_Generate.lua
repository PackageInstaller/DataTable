return {
	_rule_ = {
		none = {
			bg_shadow = {
				path = "bg_shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			awardbox_bg = {
				path = "awardbox_bg",
				list = {
					top = {
						path = "awardbox_bg/top",
						list = {
							toptitle = {
								path = "awardbox_bg/top/toptitle",
								list = {
									title_txt = {
										path = "awardbox_bg/top/toptitle/title_txt",
										list = {
											title_num = {
												path = "awardbox_bg/top/toptitle/title_txt/title_num",
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
											"UnityEngine.UI.Text"
										}
									},
									back_btn = {
										path = "awardbox_bg/top/toptitle/back_btn",
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
							line = {
								path = "awardbox_bg/top/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							topdescribe = {
								path = "awardbox_bg/top/topdescribe",
								list = {
									prestige_bg = {
										path = "awardbox_bg/top/topdescribe/prestige_bg",
										list = {
											prestigedes_image = {
												path = "awardbox_bg/top/topdescribe/prestige_bg/prestigedes_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											prestigedes_text = {
												path = "awardbox_bg/top/topdescribe/prestige_bg/prestigedes_text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.ContentSizeFitter"
												}
											},
											prestigeimg = {
												path = "awardbox_bg/top/topdescribe/prestige_bg/prestigeimg",
												list = {
													prestigenum_text = {
														path = "awardbox_bg/top/topdescribe/prestige_bg/prestigeimg/prestigenum_text",
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
							"UnityEngine.RectTransform"
						}
					},
					down = {
						path = "awardbox_bg/down",
						list = {
							up_btn = {
								path = "awardbox_bg/down/up_btn",
								list = {
									up_txt = {
										path = "awardbox_bg/down/up_btn/up_txt",
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
									"ClickAndLongClickEvent"
								}
							},
							confirm = {
								path = "awardbox_bg/down/confirm",
								list = {
									confirm_txt = {
										path = "awardbox_bg/down/confirm/confirm_txt",
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
							next_btn = {
								path = "awardbox_bg/down/next_btn",
								list = {
									next_txt = {
										path = "awardbox_bg/down/next_btn/next_txt",
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
							interpretation_btn = {
								path = "awardbox_bg/down/interpretation_btn",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			top_titile = {
				path = "top_titile",
				list = {
					answer_subject_title = {
						path = "top_titile/answer_subject_title",
						list = {
							top_titile_background = {
								path = "top_titile/answer_subject_title/top_titile_background",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							label_txt = {
								path = "top_titile/answer_subject_title/label_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							scrollview = {
								path = "top_titile/answer_subject_title/scrollview",
								list = {
									content = {
										path = "top_titile/answer_subject_title/scrollview/content",
										list = {
											label_desc = {
												path = "top_titile/answer_subject_title/scrollview/content/label_desc",
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
											"UnityEngine.RectTransform"
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
							"UnityEngine.CanvasRenderer"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer"
				}
			},
			awardbox = {
				path = "awardbox",
				list = {
					scrollview = {
						path = "awardbox/scrollview",
						list = {
							viewport = {
								path = "awardbox/scrollview/viewport",
								list = {
									content = {
										path = "awardbox/scrollview/viewport/content",
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
					"UIMoveTweener"
				}
			},
			interpretation = {
				path = "interpretation",
				list = {
					image_1 = {
						path = "interpretation/image_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					image_2 = {
						path = "interpretation/image_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					interpretation_tip = {
						path = "interpretation/interpretation_tip",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					scrollview_2 = {
						path = "interpretation/scrollview_2",
						list = {
							content_2 = {
								path = "interpretation/scrollview_2/content_2",
								list = {
									label_desc_2 = {
										path = "interpretation/scrollview_2/content_2/label_desc_2",
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
									"UnityEngine.RectTransform"
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
					},
					interpretation_txt = {
						path = "interpretation/interpretation_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					interpretation_confirm = {
						path = "interpretation/interpretation_confirm",
						list = {
							interpretation_confirm_txt = {
								path = "interpretation/interpretation_confirm/interpretation_confirm_txt",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			["awardbox_bg/top/toptitle/back_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["awardbox_bg/down/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["awardbox_bg/down/next_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["awardbox_bg/down/interpretation_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["interpretation/interpretation_confirm"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		click_and_long_click = {
			["awardbox_bg/down/up_btn"] = {
				tp = "ClickAndLongClickEvent"
			}
		},
		canvas_set = {}
	}
}

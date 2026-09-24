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
					top = {
						path = "main/top",
						list = {
							["return"] = {
								path = "main/top/return",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							title_bg = {
								path = "main/top/title_bg",
								list = {
									title = {
										path = "main/top/title_bg/title",
										list = {
											left_light = {
												path = "main/top/title_bg/title/left_light",
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
											"UnityEngine.UI.Mask"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.Canvas"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					middle = {
						path = "main/middle",
						list = {
							page_main = {
								path = "main/middle/page_main",
								list = {
									viewport = {
										path = "main/middle/page_main/viewport",
										list = {
											content = {
												path = "main/middle/page_main/viewport/content",
												list = {},
												component = {
													"UnityEngine.RectTransform"
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
									title_bg = {
										path = "main/middle/page_main/title_bg",
										list = {
											title_text1 = {
												path = "main/middle/page_main/title_bg/title_text1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.ContentSizeFitter",
													"UnityEngine.Canvas"
												}
											},
											title_text2 = {
												path = "main/middle/page_main/title_bg/title_text2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.ContentSizeFitter",
													"UnityEngine.Canvas"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.Canvas"
										}
									},
									mode_img = {
										path = "main/middle/page_main/mode_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									lock_img = {
										path = "main/middle/page_main/lock_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									pass_img = {
										path = "main/middle/page_main/pass_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									lock_text = {
										path = "main/middle/page_main/lock_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter",
											"UnityEngine.Canvas",
											"UnityEngine.UI.Outline"
										}
									},
									last_btn = {
										path = "main/middle/page_main/last_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									next_btn = {
										path = "main/middle/page_main/next_btn",
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
									"LatticeScrollRect",
									"UnityEngine.UI.Image"
								}
							},
							page_bg = {
								path = "main/middle/page_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							weather_bg = {
								path = "main/middle/weather_bg",
								list = {
									weather_anim = {
										path = "main/middle/weather_bg/weather_anim",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.Animator",
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
							reward_btn = {
								path = "main/middle/reward_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							reward_btn_2 = {
								path = "main/middle/reward_btn_2",
								list = {},
								component = {
									"UnityEngine.UI.Button",
									"UnityEngine.UI.Image"
								}
							},
							reward_event = {
								path = "main/middle/reward_event",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bottom = {
								path = "main/middle/bottom",
								list = {
									boss_bg = {
										path = "main/middle/bottom/boss_bg",
										list = {
											boss_icon = {
												path = "main/middle/bottom/boss_bg/boss_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											boss_spine = {
												path = "main/middle/bottom/boss_bg/boss_spine",
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
											"UnityEngine.UI.Image"
										}
									},
									introduce = {
										path = "main/middle/bottom/introduce",
										list = {
											icon = {
												path = "main/middle/bottom/introduce/icon",
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
											"UnityEngine.UI.Image"
										}
									},
									allreward = {
										path = "main/middle/bottom/allreward",
										list = {
											icon = {
												path = "main/middle/bottom/allreward/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point_icon = {
												path = "main/middle/bottom/allreward/point_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point_text = {
												path = "main/middle/bottom/allreward/point_text",
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
									},
									warning = {
										path = "main/middle/bottom/warning",
										list = {
											icon = {
												path = "main/middle/bottom/warning/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text = {
												path = "main/middle/bottom/warning/text",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									introducecontent = {
										path = "main/middle/bottom/introducecontent",
										list = {
											introduce_text = {
												path = "main/middle/bottom/introducecontent/introduce_text",
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
					bottom = {
						path = "main/bottom",
						list = {
							btns = {
								path = "main/bottom/btns",
								list = {
									story_btn = {
										path = "main/bottom/btns/story_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									special_buff = {
										path = "main/bottom/btns/special_buff",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									explain_btn = {
										path = "main/bottom/btns/explain_btn",
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
									"UnityEngine.UI.HorizontalLayoutGroup"
								}
							},
							point_bg = {
								path = "main/bottom/point_bg",
								list = {
									point_title = {
										path = "main/bottom/point_bg/point_title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_text = {
										path = "main/bottom/point_bg/title_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									point_icon = {
										path = "main/bottom/point_bg/point_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									point_text = {
										path = "main/bottom/point_bg/point_text",
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
									"UnityEngine.Canvas"
								}
							},
							start_btn = {
								path = "main/bottom/start_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							active_time = {
								path = "main/bottom/active_time",
								list = {
									icon = {
										path = "main/bottom/active_time/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_text = {
										path = "main/bottom/active_time/title_text",
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
									"UnityEngine.Canvas"
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
			strike_guide = {
				path = "strike_guide",
				list = {
					shadow = {
						path = "strike_guide/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "strike_guide/main",
						list = {
							bg = {
								path = "strike_guide/main/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "strike_guide/main/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							close = {
								path = "strike_guide/main/close",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							guidetitle_text = {
								path = "strike_guide/main/guidetitle_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							guidetitle_img = {
								path = "strike_guide/main/guidetitle_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_img = {
								path = "strike_guide/main/line_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							guidecontent = {
								path = "strike_guide/main/guidecontent",
								list = {
									guide_text = {
										path = "strike_guide/main/guidecontent/guide_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter",
											"UnityEngine.UI.GridLayoutGroup"
										}
									},
									dot_img = {
										path = "strike_guide/main/guidecontent/dot_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									scrollbarvertical = {
										path = "strike_guide/main/guidecontent/scrollbarvertical",
										list = {
											slidingarea = {
												path = "strike_guide/main/guidecontent/scrollbarvertical/slidingarea",
												list = {
													handle = {
														path = "strike_guide/main/guidecontent/scrollbarvertical/slidingarea/handle",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.ScrollRect"
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
			},
			strike_detail = {
				path = "strike_detail",
				list = {
					shadow = {
						path = "strike_detail/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "strike_detail/main",
						list = {
							bg = {
								path = "strike_detail/main/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "strike_detail/main/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							close = {
								path = "strike_detail/main/close",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							bg_center = {
								path = "strike_detail/main/bg_center",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							point = {
								path = "strike_detail/main/point",
								list = {
									img1 = {
										path = "strike_detail/main/point/img1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									img2 = {
										path = "strike_detail/main/point/img2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text_scroller = {
										path = "strike_detail/main/point/text_scroller",
										list = {
											text = {
												path = "strike_detail/main/point/text_scroller/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											text2 = {
												path = "strike_detail/main/point/text_scroller/text2",
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
											"TextHorizonScroller",
											"UnityEngine.CanvasRenderer"
										}
									},
									point_icon = {
										path = "strike_detail/main/point/point_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									point_num = {
										path = "strike_detail/main/point/point_num",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							tip = {
								path = "strike_detail/main/tip",
								list = {
									icon = {
										path = "strike_detail/main/tip/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "strike_detail/main/tip/text",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							nodebg = {
								path = "strike_detail/main/nodebg",
								list = {
									titlebg = {
										path = "strike_detail/main/nodebg/titlebg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									scroller = {
										path = "strike_detail/main/nodebg/scroller",
										list = {
											text = {
												path = "strike_detail/main/nodebg/scroller/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											text2 = {
												path = "strike_detail/main/nodebg/scroller/text2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											}
										},
										component = {
											"TextHorizonScroller"
										}
									},
									desc_scroller = {
										path = "strike_detail/main/nodebg/desc_scroller",
										list = {
											desc = {
												path = "strike_detail/main/nodebg/desc_scroller/desc",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											desc_move = {
												path = "strike_detail/main/nodebg/desc_scroller/desc_move",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"TextHorizonScroller"
										}
									},
									buffdesc = {
										path = "strike_detail/main/nodebg/buffdesc",
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
									"UnityEngine.UI.Mask"
								}
							},
							bottom = {
								path = "strike_detail/main/bottom",
								list = {
									import_btn = {
										path = "strike_detail/main/bottom/import_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									export_btn = {
										path = "strike_detail/main/bottom/export_btn",
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
						component = {}
					},
					blockade = {
						path = "strike_detail/blockade",
						list = {
							up = {
								path = "strike_detail/blockade/up",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
								}
							},
							down = {
								path = "strike_detail/blockade/down",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
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
			strike_whole_buff = {
				path = "strike_whole_buff",
				list = {
					shadow = {
						path = "strike_whole_buff/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "strike_whole_buff/main",
						list = {
							bg = {
								path = "strike_whole_buff/main/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "strike_whole_buff/main/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							close = {
								path = "strike_whole_buff/main/close",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							now_buff = {
								path = "strike_whole_buff/main/now_buff",
								list = {
									desc_text = {
										path = "strike_whole_buff/main/now_buff/desc_text",
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
							scrollview = {
								path = "strike_whole_buff/main/scrollview",
								list = {
									viewport = {
										path = "strike_whole_buff/main/scrollview/viewport",
										list = {
											content = {
												path = "strike_whole_buff/main/scrollview/viewport/content",
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
							},
							active_btn = {
								path = "strike_whole_buff/main/active_btn",
								list = {
									open_text = {
										path = "strike_whole_buff/main/active_btn/open_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									close_text = {
										path = "strike_whole_buff/main/active_btn/close_text",
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
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["strike_main/main/middle/bottom/allreward"] = "_control.main.middle.bottom.allreward",
			["strike_main/main/bottom/active_time/title_text"] = "_control.main.bottom.active_time.title_text",
			["strike_main/main/middle/bottom/boss_bg/boss_spine"] = "_control.main.middle.bottom.boss_bg.boss_spine",
			["strike_main/main/bottom/start_btn"] = "_control.main.bottom.start_btn",
			["strike_main/strike_detail/main/tip/text"] = "_control.strike_detail.main.tip.text",
			["strike_main/main/middle/page_main/title_bg/title_text2"] = "_control.main.middle.page_main.title_bg.title_text2",
			["strike_main/main/middle/bottom/allreward/point_icon"] = "_control.main.middle.bottom.allreward.point_icon",
			["strike_main/main/bottom/btns/story_btn"] = "_control.main.bottom.btns.story_btn",
			["strike_main/main/middle/bottom"] = "_control.main.middle.bottom",
			["strike_main/main/middle/bottom/warning"] = "_control.main.middle.bottom.warning",
			["strike_main/main/top/return"] = "_control.main.top.return",
			["strike_main/strike_detail/main"] = "_control.strike_detail.main",
			["strike_main/main/middle/page_main/title_bg"] = "_control.main.middle.page_main.title_bg",
			["strike_main/main/middle/reward_btn_2"] = "_control.main.middle.reward_btn_2",
			["strike_main/strike_detail/main/tip"] = "_control.strike_detail.main.tip",
			["strike_main/main/top/title_bg"] = "_control.main.top.title_bg",
			["strike_main/main/middle/bottom/introduce/icon"] = "_control.main.middle.bottom.introduce.icon",
			["strike_main/main/middle/bottom/allreward/icon"] = "_control.main.middle.bottom.allreward.icon",
			["strike_main/main/middle/reward_btn"] = "_control.main.middle.reward_btn",
			["strike_main/main/middle/page_main"] = "_control.main.middle.page_main",
			["strike_main/main/middle/page_main/mode_img"] = "_control.main.middle.page_main.mode_img",
			["strike_main/main/middle/page_main/pass_img"] = "_control.main.middle.page_main.pass_img",
			["strike_main/strike_detail/main/point/text_scroller/text"] = "_control.strike_detail.main.point.text_scroller.text",
			["strike_main/main/bottom"] = "_control.main.bottom",
			["strike_main/main/middle/page_main/lock_text"] = "_control.main.middle.page_main.lock_text",
			["strike_main/main/bottom/point_bg/point_title"] = "_control.main.bottom.point_bg.point_title",
			["strike_main/main/middle/page_main/next_btn"] = "_control.main.middle.page_main.next_btn",
			["strike_main/strike_whole_buff/main/close"] = "_control.strike_whole_buff.main.close",
			["strike_main/strike_detail/main/nodebg/titlebg"] = "_control.strike_detail.main.nodebg.titlebg",
			["strike_main/main/middle/page_main/last_btn"] = "_control.main.middle.page_main.last_btn",
			["strike_main/strike_guide"] = "_control.strike_guide",
			["strike_main/strike_detail/main/nodebg/scroller/text2"] = "_control.strike_detail.main.nodebg.scroller.text2",
			["strike_main/strike_guide/main/guidecontent/dot_img"] = "_control.strike_guide.main.guidecontent.dot_img",
			["strike_main/strike_guide/main/guidecontent/scrollbarvertical/slidingarea"] = "_control.strike_guide.main.guidecontent.scrollbarvertical.slidingarea",
			["strike_main/strike_detail"] = "_control.strike_detail",
			["strike_main/strike_detail/shadow"] = "_control.strike_detail.shadow",
			["strike_main/strike_guide/main/guidetitle_text"] = "_control.strike_guide.main.guidetitle_text",
			["strike_main/main/middle/bottom/boss_bg/boss_icon"] = "_control.main.middle.bottom.boss_bg.boss_icon",
			["strike_main/strike_detail/main/point/point_num"] = "_control.strike_detail.main.point.point_num",
			["strike_main/main/middle/page_main/title_bg/title_text1"] = "_control.main.middle.page_main.title_bg.title_text1",
			["strike_main/bg"] = "_control.bg",
			["strike_main/main/bottom/btns/special_buff"] = "_control.main.bottom.btns.special_buff",
			["strike_main/main/middle/bottom/introduce"] = "_control.main.middle.bottom.introduce",
			["strike_main/strike_detail/main/bg"] = "_control.strike_detail.main.bg",
			["strike_main/main/middle/weather_bg"] = "_control.main.middle.weather_bg",
			["strike_main/main/middle/weather_bg/weather_anim"] = "_control.main.middle.weather_bg.weather_anim",
			["strike_main/main/middle/reward_event"] = "_control.main.middle.reward_event",
			["strike_main/strike_guide/main"] = "_control.strike_guide.main",
			["strike_main/strike_guide/main/bg"] = "_control.strike_guide.main.bg",
			["strike_main/strike_detail/main/close"] = "_control.strike_detail.main.close",
			["strike_main/strike_detail/main/point"] = "_control.strike_detail.main.point",
			["strike_main/strike_detail/main/point/img1"] = "_control.strike_detail.main.point.img1",
			["strike_main/main/middle/page_main/viewport/content"] = "_control.main.middle.page_main.viewport.content",
			["strike_main/strike_guide/shadow"] = "_control.strike_guide.shadow",
			["strike_main/strike_detail/main/point/text_scroller/text2"] = "_control.strike_detail.main.point.text_scroller.text2",
			["strike_main/strike_detail/main/point/point_icon"] = "_control.strike_detail.main.point.point_icon",
			["strike_main/main/top/title_bg/title/left_light"] = "_control.main.top.title_bg.title.left_light",
			["strike_main/strike_guide/main/guidetitle_img"] = "_control.strike_guide.main.guidetitle_img",
			["strike_main/strike_guide/main/guidecontent/scrollbarvertical"] = "_control.strike_guide.main.guidecontent.scrollbarvertical",
			["strike_main/main/top/title_bg/title"] = "_control.main.top.title_bg.title",
			["strike_main/strike_detail/main/tip/icon"] = "_control.strike_detail.main.tip.icon",
			["strike_main/strike_guide/main/guidecontent/scrollbarvertical/slidingarea/handle"] = "_control.strike_guide.main.guidecontent.scrollbarvertical.slidingarea.handle",
			["strike_main/main/bottom/point_bg/point_text"] = "_control.main.bottom.point_bg.point_text",
			["strike_main/main/middle/page_bg"] = "_control.main.middle.page_bg",
			["strike_main/strike_detail/main/nodebg"] = "_control.strike_detail.main.nodebg",
			["strike_main/strike_detail/main/point/img2"] = "_control.strike_detail.main.point.img2",
			["strike_main/main/middle/page_main/lock_img"] = "_control.main.middle.page_main.lock_img",
			["strike_main/strike_whole_buff/shadow"] = "_control.strike_whole_buff.shadow",
			["strike_main/strike_detail/main/nodebg/scroller"] = "_control.strike_detail.main.nodebg.scroller",
			["strike_main/strike_detail/main/nodebg/scroller/text"] = "_control.strike_detail.main.nodebg.scroller.text",
			["strike_main/strike_detail/main/title"] = "_control.strike_detail.main.title",
			["strike_main/strike_guide/main/guidecontent"] = "_control.strike_guide.main.guidecontent",
			["strike_main/strike_detail/main/nodebg/desc_scroller"] = "_control.strike_detail.main.nodebg.desc_scroller",
			["strike_main/strike_detail/main/nodebg/desc_scroller/desc"] = "_control.strike_detail.main.nodebg.desc_scroller.desc",
			["strike_main/main/middle/bottom/allreward/point_text"] = "_control.main.middle.bottom.allreward.point_text",
			["strike_main/strike_whole_buff/main/bg"] = "_control.strike_whole_buff.main.bg",
			["strike_main/main/middle/bottom/introducecontent/introduce_text"] = "_control.main.middle.bottom.introducecontent.introduce_text",
			["strike_main/strike_detail/main/bg_center"] = "_control.strike_detail.main.bg_center",
			["strike_main/strike_detail/main/point/text_scroller"] = "_control.strike_detail.main.point.text_scroller",
			["strike_main/strike_detail/main/bottom"] = "_control.strike_detail.main.bottom",
			["strike_main/strike_detail/main/bottom/import_btn"] = "_control.strike_detail.main.bottom.import_btn",
			["strike_main/main/bottom/btns"] = "_control.main.bottom.btns",
			["strike_main/strike_whole_buff/main/now_buff/desc_text"] = "_control.strike_whole_buff.main.now_buff.desc_text",
			["strike_main/strike_detail/blockade"] = "_control.strike_detail.blockade",
			["strike_main/strike_detail/blockade/up"] = "_control.strike_detail.blockade.up",
			["strike_main/strike_whole_buff"] = "_control.strike_whole_buff",
			["strike_main/main/bottom/point_bg"] = "_control.main.bottom.point_bg",
			["strike_main/strike_guide/main/title"] = "_control.strike_guide.main.title",
			["strike_main/strike_guide/main/line_img"] = "_control.strike_guide.main.line_img",
			["strike_main/strike_whole_buff/main"] = "_control.strike_whole_buff.main",
			["strike_main/main/middle"] = "_control.main.middle",
			["strike_main/strike_detail/main/nodebg/desc_scroller/desc_move"] = "_control.strike_detail.main.nodebg.desc_scroller.desc_move",
			["strike_main/main/middle/bottom/boss_bg"] = "_control.main.middle.bottom.boss_bg",
			["strike_main/main/top"] = "_control.main.top",
			["strike_main/strike_whole_buff/main/now_buff"] = "_control.strike_whole_buff.main.now_buff",
			["strike_main/strike_detail/main/bottom/export_btn"] = "_control.strike_detail.main.bottom.export_btn",
			["strike_main/main/middle/bottom/warning/text"] = "_control.main.middle.bottom.warning.text",
			["strike_main/main/bottom/point_bg/point_icon"] = "_control.main.bottom.point_bg.point_icon",
			["strike_main/strike_guide/main/guidecontent/guide_text"] = "_control.strike_guide.main.guidecontent.guide_text",
			["strike_main/strike_whole_buff/main/scrollview"] = "_control.strike_whole_buff.main.scrollview",
			["strike_main/main/bottom/active_time/icon"] = "_control.main.bottom.active_time.icon",
			["strike_main/main/middle/bottom/introducecontent"] = "_control.main.middle.bottom.introducecontent",
			["strike_main/strike_whole_buff/main/scrollview/viewport"] = "_control.strike_whole_buff.main.scrollview.viewport",
			["strike_main/strike_whole_buff/main/title"] = "_control.strike_whole_buff.main.title",
			["strike_main/main/middle/bottom/warning/icon"] = "_control.main.middle.bottom.warning.icon",
			["strike_main/strike_whole_buff/main/active_btn/close_text"] = "_control.strike_whole_buff.main.active_btn.close_text",
			["strike_main/strike_guide/main/close"] = "_control.strike_guide.main.close",
			["strike_main/strike_whole_buff/main/active_btn/open_text"] = "_control.strike_whole_buff.main.active_btn.open_text",
			["strike_main/main/bottom/btns/explain_btn"] = "_control.main.bottom.btns.explain_btn",
			["strike_main/main/bottom/point_bg/title_text"] = "_control.main.bottom.point_bg.title_text",
			["strike_main/strike_detail/main/nodebg/buffdesc"] = "_control.strike_detail.main.nodebg.buffdesc",
			["strike_main/main"] = "_control.main",
			["strike_main/strike_whole_buff/main/active_btn"] = "_control.strike_whole_buff.main.active_btn",
			["strike_main/main/middle/page_main/viewport"] = "_control.main.middle.page_main.viewport",
			["strike_main/strike_whole_buff/main/scrollview/viewport/content"] = "_control.strike_whole_buff.main.scrollview.viewport.content",
			["strike_main/main/bottom/active_time"] = "_control.main.bottom.active_time",
			["strike_main/strike_detail/blockade/down"] = "_control.strike_detail.blockade.down"
		},
		click = {
			["main/top/return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/page_main/last_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/page_main/next_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/weather_bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/reward_btn_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/btns/story_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/btns/special_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/btns/explain_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/start_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strike_guide/main/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strike_detail/main/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strike_detail/main/bottom/import_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strike_detail/main/bottom/export_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strike_whole_buff/main/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strike_whole_buff/main/active_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			title_bg = {
				component = "UnityEngine.Canvas",
				path = "main/middle/page_main/title_bg"
			},
			title_text1 = {
				component = "UnityEngine.Canvas",
				path = "main/middle/page_main/title_bg/title_text1"
			},
			title_text2 = {
				component = "UnityEngine.Canvas",
				path = "main/middle/page_main/title_bg/title_text2"
			},
			lock_text = {
				component = "UnityEngine.Canvas",
				path = "main/middle/page_main/lock_text"
			},
			point_bg = {
				component = "UnityEngine.Canvas",
				path = "main/bottom/point_bg"
			},
			active_time = {
				component = "UnityEngine.Canvas",
				path = "main/bottom/active_time"
			}
		}
	}
}

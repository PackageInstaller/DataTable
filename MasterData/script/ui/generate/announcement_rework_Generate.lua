return {
	_rule_ = {
		none = {
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			mask_light = {
				path = "mask_light",
				list = {
					glow = {
						path = "mask_light/glow",
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
			},
			main_info = {
				path = "main_info",
				list = {
					viewport = {
						path = "main_info/viewport",
						list = {
							content = {
								path = "main_info/viewport/content",
								list = {
									activity_pic = {
										path = "main_info/viewport/content/activity_pic",
										list = {
											active_text = {
												path = "main_info/viewport/content/activity_pic/active_text",
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
									single_announcement = {
										path = "main_info/viewport/content/single_announcement",
										list = {
											single_announcement_one = {
												path = "main_info/viewport/content/single_announcement/single_announcement_one",
												list = {
													bg = {
														path = "main_info/viewport/content/single_announcement/single_announcement_one/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													type_text = {
														path = "main_info/viewport/content/single_announcement/single_announcement_one/type_text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													},
													is_new = {
														path = "main_info/viewport/content/single_announcement/single_announcement_one/is_new",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "main_info/viewport/content/single_announcement/single_announcement_one/title",
														list = {
															title_text = {
																path = "main_info/viewport/content/single_announcement/single_announcement_one/title/title_text",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.ContentSizeFitter"
																}
															},
															title_text_2 = {
																path = "main_info/viewport/content/single_announcement/single_announcement_one/title/title_text_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													info_btn = {
														path = "main_info/viewport/content/single_announcement/single_announcement_one/info_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button",
															"UnityEngine.Canvas",
															"UnityEngine.UI.GraphicRaycaster"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											single_announcement_two = {
												path = "main_info/viewport/content/single_announcement/single_announcement_two",
												list = {
													bg = {
														path = "main_info/viewport/content/single_announcement/single_announcement_two/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													type_text = {
														path = "main_info/viewport/content/single_announcement/single_announcement_two/type_text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													},
													is_new = {
														path = "main_info/viewport/content/single_announcement/single_announcement_two/is_new",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "main_info/viewport/content/single_announcement/single_announcement_two/title",
														list = {
															title_text = {
																path = "main_info/viewport/content/single_announcement/single_announcement_two/title/title_text",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.ContentSizeFitter"
																}
															},
															title_text_2 = {
																path = "main_info/viewport/content/single_announcement/single_announcement_two/title/title_text_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													info_btn = {
														path = "main_info/viewport/content/single_announcement/single_announcement_two/info_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button",
															"UnityEngine.Canvas",
															"UnityEngine.UI.GraphicRaycaster"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											single_announcement_three = {
												path = "main_info/viewport/content/single_announcement/single_announcement_three",
												list = {
													bg = {
														path = "main_info/viewport/content/single_announcement/single_announcement_three/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													type_text = {
														path = "main_info/viewport/content/single_announcement/single_announcement_three/type_text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													},
													is_new = {
														path = "main_info/viewport/content/single_announcement/single_announcement_three/is_new",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "main_info/viewport/content/single_announcement/single_announcement_three/title",
														list = {
															title_text = {
																path = "main_info/viewport/content/single_announcement/single_announcement_three/title/title_text",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.ContentSizeFitter"
																}
															},
															title_text_2 = {
																path = "main_info/viewport/content/single_announcement/single_announcement_three/title/title_text_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													info_btn = {
														path = "main_info/viewport/content/single_announcement/single_announcement_three/info_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button",
															"UnityEngine.Canvas",
															"UnityEngine.UI.GraphicRaycaster"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											single_announcement_four = {
												path = "main_info/viewport/content/single_announcement/single_announcement_four",
												list = {
													bg = {
														path = "main_info/viewport/content/single_announcement/single_announcement_four/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													type_text = {
														path = "main_info/viewport/content/single_announcement/single_announcement_four/type_text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													},
													is_new = {
														path = "main_info/viewport/content/single_announcement/single_announcement_four/is_new",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "main_info/viewport/content/single_announcement/single_announcement_four/title",
														list = {
															title_text = {
																path = "main_info/viewport/content/single_announcement/single_announcement_four/title/title_text",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.ContentSizeFitter"
																}
															},
															title_text_2 = {
																path = "main_info/viewport/content/single_announcement/single_announcement_four/title/title_text_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													info_btn = {
														path = "main_info/viewport/content/single_announcement/single_announcement_four/info_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button",
															"UnityEngine.Canvas",
															"UnityEngine.UI.GraphicRaycaster"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform"
												}
											},
											single_announcement_five = {
												path = "main_info/viewport/content/single_announcement/single_announcement_five",
												list = {
													bg = {
														path = "main_info/viewport/content/single_announcement/single_announcement_five/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													type_text = {
														path = "main_info/viewport/content/single_announcement/single_announcement_five/type_text",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text",
															"UnityEngine.UI.ContentSizeFitter"
														}
													},
													is_new = {
														path = "main_info/viewport/content/single_announcement/single_announcement_five/is_new",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "main_info/viewport/content/single_announcement/single_announcement_five/title",
														list = {
															title_text = {
																path = "main_info/viewport/content/single_announcement/single_announcement_five/title/title_text",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.ContentSizeFitter"
																}
															},
															title_text_2 = {
																path = "main_info/viewport/content/single_announcement/single_announcement_five/title/title_text_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													info_btn = {
														path = "main_info/viewport/content/single_announcement/single_announcement_five/info_btn",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Button",
															"UnityEngine.Canvas",
															"UnityEngine.UI.GraphicRaycaster"
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ContentSizeFitter",
									"UnityEngine.UI.GridLayoutGroup"
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
						path = "main_info/scrollbarvertical",
						list = {
							slidingarea = {
								path = "main_info/scrollbarvertical/slidingarea",
								list = {
									handle = {
										path = "main_info/scrollbarvertical/slidingarea/handle",
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
					},
					toggle = {
						path = "main_info/toggle",
						list = {
							bg = {
								path = "main_info/toggle/bg",
								list = {
									checkmark = {
										path = "main_info/toggle/bg/checkmark",
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
							tips = {
								path = "main_info/toggle/tips",
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
							"UnityEngine.UI.Toggle"
						}
					},
					line = {
						path = "main_info/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					returnbtn = {
						path = "main_info/returnbtn",
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
					"UnityEngine.UI.ScrollRect"
				}
			},
			detail_info = {
				path = "detail_info",
				list = {
					detail_announcement = {
						path = "detail_info/detail_announcement",
						list = {
							bg = {
								path = "detail_info/detail_announcement/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_text = {
								path = "detail_info/detail_announcement/type_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							title = {
								path = "detail_info/detail_announcement/title",
								list = {
									title_text = {
										path = "detail_info/detail_announcement/title/title_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									title_text_2 = {
										path = "detail_info/detail_announcement/title/title_text_2",
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
									"UnityEngine.UI.Mask",
									"TextHorizonScroller",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							info_btn = {
								path = "detail_info/detail_announcement/info_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button",
									"UnityEngine.Canvas",
									"UnityEngine.UI.GraphicRaycaster"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					announcement_text = {
						path = "detail_info/announcement_text",
						list = {
							viewport = {
								path = "detail_info/announcement_text/viewport",
								list = {
									content = {
										path = "detail_info/announcement_text/viewport/content",
										list = {
											Text = {
												path = "detail_info/announcement_text/viewport/content/Text",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							scrollbarvertical = {
								path = "detail_info/announcement_text/scrollbarvertical",
								list = {
									slidingarea = {
										path = "detail_info/announcement_text/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "detail_info/announcement_text/scrollbarvertical/slidingarea/handle",
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
							"UnityEngine.UI.ScrollRect"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["announcement_rework/detail_info/detail_announcement/info_btn"] = "_control.detail_info.detail_announcement.info_btn",
			["announcement_rework/mask_light/glow"] = "_control.mask_light.glow",
			["announcement_rework/detail_info/announcement_text"] = "_control.detail_info.announcement_text",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five/title/title_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five.title.title_text",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five/title"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five.title",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five/is_new"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five.is_new",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five/bg"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five.bg",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five",
			["announcement_rework/main_info/toggle/bg"] = "_control.main_info.toggle.bg",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four/title"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four.title",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two/title"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two.title",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four/title/title_text_2"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four.title.title_text_2",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two/bg"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two.bg",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one/info_btn"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one.info_btn",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two",
			["announcement_rework/detail_info/detail_announcement"] = "_control.detail_info.detail_announcement",
			["announcement_rework/main_info/viewport/content/activity_pic"] = "_control.main_info.viewport.content.activity_pic",
			["announcement_rework/main_info/scrollbarvertical"] = "_control.main_info.scrollbarvertical",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four/type_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four.type_text",
			["announcement_rework/detail_info/detail_announcement/type_text"] = "_control.detail_info.detail_announcement.type_text",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one/type_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one.type_text",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one/title/title_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one.title.title_text",
			["announcement_rework/mask_light"] = "_control.mask_light",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one/title/title_text_2"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one.title.title_text_2",
			["announcement_rework/main_info/returnbtn"] = "_control.main_info.returnbtn",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one/title"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one.title",
			["announcement_rework/main_info/scrollbarvertical/slidingarea"] = "_control.main_info.scrollbarvertical.slidingarea",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two/type_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two.type_text",
			["announcement_rework/bg"] = "_control.bg",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two/is_new"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two.is_new",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two/title/title_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two.title.title_text",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two/info_btn"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two.info_btn",
			["announcement_rework/main_info/viewport"] = "_control.main_info.viewport",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_two/title/title_text_2"] = "_control.main_info.viewport.content.single_announcement.single_announcement_two.title.title_text_2",
			["announcement_rework/detail_info"] = "_control.detail_info",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one/is_new"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one.is_new",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three/title/title_text_2"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three.title.title_text_2",
			["announcement_rework/detail_info/detail_announcement/title/title_text"] = "_control.detail_info.detail_announcement.title.title_text",
			["announcement_rework/detail_info/detail_announcement/title/title_text_2"] = "_control.detail_info.detail_announcement.title.title_text_2",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five/info_btn"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five.info_btn",
			["announcement_rework/detail_info/announcement_text/viewport"] = "_control.detail_info.announcement_text.viewport",
			["announcement_rework/detail_info/announcement_text/viewport/content/Text"] = "_control.detail_info.announcement_text.viewport.content.Text",
			["announcement_rework/detail_info/announcement_text/scrollbarvertical/slidingarea/handle"] = "_control.detail_info.announcement_text.scrollbarvertical.slidingarea.handle",
			["announcement_rework/main_info/line"] = "_control.main_info.line",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three/type_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three.type_text",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four/title/title_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four.title.title_text",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three/title/title_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three.title.title_text",
			["announcement_rework/main_info/toggle/bg/checkmark"] = "_control.main_info.toggle.bg.checkmark",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five/type_text"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five.type_text",
			["announcement_rework/detail_info/announcement_text/scrollbarvertical/slidingarea"] = "_control.detail_info.announcement_text.scrollbarvertical.slidingarea",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three/bg"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three.bg",
			["announcement_rework/detail_info/detail_announcement/title"] = "_control.detail_info.detail_announcement.title",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three/info_btn"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three.info_btn",
			["announcement_rework/main_info/toggle"] = "_control.main_info.toggle",
			["announcement_rework/detail_info/detail_announcement/bg"] = "_control.detail_info.detail_announcement.bg",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_five/title/title_text_2"] = "_control.main_info.viewport.content.single_announcement.single_announcement_five.title.title_text_2",
			["announcement_rework/main_info"] = "_control.main_info",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four/info_btn"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four.info_btn",
			["announcement_rework/main_info/toggle/tips"] = "_control.main_info.toggle.tips",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one/bg"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one.bg",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four/bg"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four.bg",
			["announcement_rework/main_info/viewport/content/activity_pic/active_text"] = "_control.main_info.viewport.content.activity_pic.active_text",
			["announcement_rework/detail_info/announcement_text/scrollbarvertical"] = "_control.detail_info.announcement_text.scrollbarvertical",
			["announcement_rework/main_info/viewport/content/single_announcement"] = "_control.main_info.viewport.content.single_announcement",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_four/is_new"] = "_control.main_info.viewport.content.single_announcement.single_announcement_four.is_new",
			["announcement_rework/detail_info/announcement_text/viewport/content"] = "_control.detail_info.announcement_text.viewport.content",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three/is_new"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three.is_new",
			["announcement_rework/mask"] = "_control.mask",
			["announcement_rework/main_info/scrollbarvertical/slidingarea/handle"] = "_control.main_info.scrollbarvertical.slidingarea.handle",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_three/title"] = "_control.main_info.viewport.content.single_announcement.single_announcement_three.title",
			["announcement_rework/main_info/viewport/content"] = "_control.main_info.viewport.content",
			["announcement_rework/main_info/viewport/content/single_announcement/single_announcement_one"] = "_control.main_info.viewport.content.single_announcement.single_announcement_one"
		},
		click = {
			["main_info/viewport/content/activity_pic"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main_info/viewport/content/single_announcement/single_announcement_one/info_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main_info/viewport/content/single_announcement/single_announcement_two/info_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main_info/viewport/content/single_announcement/single_announcement_three/info_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main_info/viewport/content/single_announcement/single_announcement_four/info_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main_info/viewport/content/single_announcement/single_announcement_five/info_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["detail_info/detail_announcement/info_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["main_info/returnbtn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["main_info/toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			info_btn = {
				component = "UnityEngine.Canvas",
				path = "detail_info/detail_announcement/info_btn"
			}
		}
	}
}

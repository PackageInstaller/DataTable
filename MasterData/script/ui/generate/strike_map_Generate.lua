return {
	_rule_ = {
		none = {
			obj_pool_root = {
				path = "obj_pool_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
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
			hard_bg = {
				path = "hard_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.CanvasGroup"
				}
			},
			main = {
				path = "main",
				list = {
					middle = {
						path = "main/middle",
						list = {
							map_panel = {
								path = "main/middle/map_panel",
								list = {
									circle_img = {
										path = "main/middle/map_panel/circle_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.CanvasGroup"
										}
									},
									map_node_root = {
										path = "main/middle/map_panel/map_node_root",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									map_lock = {
										path = "main/middle/map_panel/map_lock",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"Spine.Unity.SkeletonGraphic"
										}
									},
									ship = {
										path = "main/middle/map_panel/ship",
										list = {
											ship_layer = {
												path = "main/middle/map_panel/ship/ship_layer",
												list = {
													ship_icon = {
														path = "main/middle/map_panel/ship/ship_layer/ship_icon",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													encounter_effect = {
														path = "main/middle/map_panel/ship/ship_layer/encounter_effect",
														list = {
															encounter_spine = {
																path = "main/middle/map_panel/ship/ship_layer/encounter_effect/encounter_spine",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"Spine.Unity.SkeletonGraphic"
																}
															}
														},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasGroup"
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
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Mask"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					top = {
						path = "main/top",
						list = {
							return_btn = {
								path = "main/top/return_btn",
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
									title_text = {
										path = "main/top/title_bg/title_text",
										list = {
											top_text = {
												path = "main/top/title_bg/title_text/top_text",
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
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									title_text2 = {
										path = "main/top/title_bg/title_text2",
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
							show_btn = {
								path = "main/top/show_btn",
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
					bottom = {
						path = "main/bottom",
						list = {
							point = {
								path = "main/bottom/point",
								list = {
									point_icon = {
										path = "main/bottom/point/point_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									point_text = {
										path = "main/bottom/point/point_text",
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
							import_btn = {
								path = "main/bottom/import_btn",
								list = {
									text = {
										path = "main/bottom/import_btn/text",
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
							"UnityEngine.RectTransform"
						}
					},
					shadow_circle = {
						path = "main/shadow_circle",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					back_image = {
						path = "main/back_image",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					back_difficult_btn = {
						path = "main/back_difficult_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					back_main_btn = {
						path = "main/back_main_btn",
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
			msgbox = {
				path = "msgbox",
				list = {
					maskbg = {
						path = "msgbox/maskbg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "msgbox/main",
						list = {
							main_bg = {
								path = "msgbox/main/main_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top = {
								path = "msgbox/main/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "msgbox/main/title",
								list = {
									gogo = {
										path = "msgbox/main/title/gogo",
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
									"UnityEngine.UI.Text"
								}
							},
							main_text = {
								path = "msgbox/main/main_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							confirmbtn = {
								path = "msgbox/main/confirmbtn",
								list = {
									text = {
										path = "msgbox/main/confirmbtn/text",
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
							cancelbtn = {
								path = "msgbox/main/cancelbtn",
								list = {
									text = {
										path = "msgbox/main/cancelbtn/text",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			strongattack = {
				path = "strongattack",
				list = {
					bg = {
						path = "strongattack/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					titlebg = {
						path = "strongattack/titlebg",
						list = {
							title = {
								path = "strongattack/titlebg/title",
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
					circle_1 = {
						path = "strongattack/circle_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					circle_2 = {
						path = "strongattack/circle_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"TweenRotation"
						}
					},
					string_node1 = {
						path = "strongattack/string_node1",
						list = {
							float_bg = {
								path = "strongattack/string_node1/float_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							title_bg = {
								path = "strongattack/string_node1/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buffname_scroller = {
								path = "strongattack/string_node1/buffname_scroller",
								list = {
									buff_name = {
										path = "strongattack/string_node1/buffname_scroller/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_name2 = {
										path = "strongattack/string_node1/buffname_scroller/buff_name2",
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
							attr_scroller = {
								path = "strongattack/string_node1/attr_scroller",
								list = {
									attr_info = {
										path = "strongattack/string_node1/attr_scroller/attr_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_info2 = {
										path = "strongattack/string_node1/attr_scroller/attr_info2",
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
									"TextHorizonScroller"
								}
							},
							info_text = {
								path = "strongattack/string_node1/info_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img_replace = {
								path = "strongattack/string_node1/img_replace",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_num = {
								path = "strongattack/string_node1/icon_num",
								list = {
									num = {
										path = "strongattack/string_node1/icon_num/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									point_icon = {
										path = "strongattack/string_node1/icon_num/point_icon",
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
							"UnityEngine.UI.Button"
						}
					},
					string_node2 = {
						path = "strongattack/string_node2",
						list = {
							float_bg = {
								path = "strongattack/string_node2/float_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							title_bg = {
								path = "strongattack/string_node2/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buffname_scroller = {
								path = "strongattack/string_node2/buffname_scroller",
								list = {
									buff_name = {
										path = "strongattack/string_node2/buffname_scroller/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_name2 = {
										path = "strongattack/string_node2/buffname_scroller/buff_name2",
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
							attr_scroller = {
								path = "strongattack/string_node2/attr_scroller",
								list = {
									attr_info = {
										path = "strongattack/string_node2/attr_scroller/attr_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_info2 = {
										path = "strongattack/string_node2/attr_scroller/attr_info2",
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
									"TextHorizonScroller"
								}
							},
							info_text = {
								path = "strongattack/string_node2/info_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img_replace = {
								path = "strongattack/string_node2/img_replace",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_num = {
								path = "strongattack/string_node2/icon_num",
								list = {
									num = {
										path = "strongattack/string_node2/icon_num/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									point_icon = {
										path = "strongattack/string_node2/icon_num/point_icon",
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
							"UnityEngine.UI.Button"
						}
					},
					string_node4 = {
						path = "strongattack/string_node4",
						list = {
							float_bg = {
								path = "strongattack/string_node4/float_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							title_bg = {
								path = "strongattack/string_node4/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buffname_scroller = {
								path = "strongattack/string_node4/buffname_scroller",
								list = {
									buff_name = {
										path = "strongattack/string_node4/buffname_scroller/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_name2 = {
										path = "strongattack/string_node4/buffname_scroller/buff_name2",
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
							attr_scroller = {
								path = "strongattack/string_node4/attr_scroller",
								list = {
									attr_info = {
										path = "strongattack/string_node4/attr_scroller/attr_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_info2 = {
										path = "strongattack/string_node4/attr_scroller/attr_info2",
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
									"TextHorizonScroller"
								}
							},
							info_text = {
								path = "strongattack/string_node4/info_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img_replace = {
								path = "strongattack/string_node4/img_replace",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_num = {
								path = "strongattack/string_node4/icon_num",
								list = {
									num = {
										path = "strongattack/string_node4/icon_num/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									point_icon = {
										path = "strongattack/string_node4/icon_num/point_icon",
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
							"UnityEngine.UI.Button"
						}
					},
					string_node3 = {
						path = "strongattack/string_node3",
						list = {
							float_bg = {
								path = "strongattack/string_node3/float_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							title_bg = {
								path = "strongattack/string_node3/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buffname_scroller = {
								path = "strongattack/string_node3/buffname_scroller",
								list = {
									buff_name = {
										path = "strongattack/string_node3/buffname_scroller/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_name2 = {
										path = "strongattack/string_node3/buffname_scroller/buff_name2",
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
							attr_scroller = {
								path = "strongattack/string_node3/attr_scroller",
								list = {
									attr_info = {
										path = "strongattack/string_node3/attr_scroller/attr_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_info2 = {
										path = "strongattack/string_node3/attr_scroller/attr_info2",
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
									"TextHorizonScroller"
								}
							},
							info_text = {
								path = "strongattack/string_node3/info_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							icon_num = {
								path = "strongattack/string_node3/icon_num",
								list = {
									num = {
										path = "strongattack/string_node3/icon_num/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									point_icon = {
										path = "strongattack/string_node3/icon_num/point_icon",
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
							img_replace = {
								path = "strongattack/string_node3/img_replace",
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
					string_node5 = {
						path = "strongattack/string_node5",
						list = {
							float_bg = {
								path = "strongattack/string_node5/float_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							title_bg = {
								path = "strongattack/string_node5/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buffname_scroller = {
								path = "strongattack/string_node5/buffname_scroller",
								list = {
									buff_name = {
										path = "strongattack/string_node5/buffname_scroller/buff_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff_name2 = {
										path = "strongattack/string_node5/buffname_scroller/buff_name2",
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
							attr_scroller = {
								path = "strongattack/string_node5/attr_scroller",
								list = {
									attr_info = {
										path = "strongattack/string_node5/attr_scroller/attr_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									attr_info2 = {
										path = "strongattack/string_node5/attr_scroller/attr_info2",
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
									"TextHorizonScroller"
								}
							},
							info_text = {
								path = "strongattack/string_node5/info_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img_replace = {
								path = "strongattack/string_node5/img_replace",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon_num = {
								path = "strongattack/string_node5/icon_num",
								list = {
									num = {
										path = "strongattack/string_node5/icon_num/num",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									point_icon = {
										path = "strongattack/string_node5/icon_num/point_icon",
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
							"UnityEngine.UI.Button"
						}
					},
					exit = {
						path = "strongattack/exit",
						list = {
							Text = {
								path = "strongattack/exit/Text",
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
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					replace_bg = {
						path = "strongattack/replace_bg",
						list = {
							replace_dsc = {
								path = "strongattack/replace_bg/replace_dsc",
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
					confirm = {
						path = "strongattack/confirm",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					replace = {
						path = "strongattack/replace",
						list = {
							replace_return = {
								path = "strongattack/replace/replace_return",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							replace_node = {
								path = "strongattack/replace/replace_node",
								list = {
									float_bg = {
										path = "strongattack/replace/replace_node/float_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_bg = {
										path = "strongattack/replace/replace_node/title_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buffname_scroller = {
										path = "strongattack/replace/replace_node/buffname_scroller",
										list = {
											buff_name = {
												path = "strongattack/replace/replace_node/buffname_scroller/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											buff_name2 = {
												path = "strongattack/replace/replace_node/buffname_scroller/buff_name2",
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
											"TextHorizonScroller"
										}
									},
									attr_scroller = {
										path = "strongattack/replace/replace_node/attr_scroller",
										list = {
											attr_info = {
												path = "strongattack/replace/replace_node/attr_scroller/attr_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_info2 = {
												path = "strongattack/replace/replace_node/attr_scroller/attr_info2",
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
											"TextHorizonScroller"
										}
									},
									info_text = {
										path = "strongattack/replace/replace_node/info_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									icon_num = {
										path = "strongattack/replace/replace_node/icon_num",
										list = {
											num = {
												path = "strongattack/replace/replace_node/icon_num/num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											point_icon = {
												path = "strongattack/replace/replace_node/icon_num/point_icon",
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
									"UnityEngine.UI.Image"
								}
							},
							replace_confirm = {
								path = "strongattack/replace/replace_confirm",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							replace_titlebg = {
								path = "strongattack/replace/replace_titlebg",
								list = {
									title = {
										path = "strongattack/replace/replace_titlebg/title",
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
							replace_hint = {
								path = "strongattack/replace/replace_hint",
								list = {
									replace_hint_dsc = {
										path = "strongattack/replace/replace_hint/replace_hint_dsc",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									replace_hint_img = {
										path = "strongattack/replace/replace_hint/replace_hint_img",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					not_selected_all = {
						path = "strongattack/not_selected_all",
						list = {
							replace_return = {
								path = "strongattack/not_selected_all/replace_return",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							replace_node = {
								path = "strongattack/not_selected_all/replace_node",
								list = {
									float_bg = {
										path = "strongattack/not_selected_all/replace_node/float_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_bg = {
										path = "strongattack/not_selected_all/replace_node/title_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buffname_scroller = {
										path = "strongattack/not_selected_all/replace_node/buffname_scroller",
										list = {
											buff_name = {
												path = "strongattack/not_selected_all/replace_node/buffname_scroller/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											buff_name2 = {
												path = "strongattack/not_selected_all/replace_node/buffname_scroller/buff_name2",
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
											"TextHorizonScroller"
										}
									},
									attr_scroller = {
										path = "strongattack/not_selected_all/replace_node/attr_scroller",
										list = {
											attr_info = {
												path = "strongattack/not_selected_all/replace_node/attr_scroller/attr_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_info2 = {
												path = "strongattack/not_selected_all/replace_node/attr_scroller/attr_info2",
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
											"TextHorizonScroller"
										}
									},
									info_text = {
										path = "strongattack/not_selected_all/replace_node/info_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									icon_num = {
										path = "strongattack/not_selected_all/replace_node/icon_num",
										list = {
											num = {
												path = "strongattack/not_selected_all/replace_node/icon_num/num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text",
													"UnityEngine.UI.Outline"
												}
											},
											point_icon = {
												path = "strongattack/not_selected_all/replace_node/icon_num/point_icon",
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
									"UnityEngine.UI.Image"
								}
							},
							replace_confirm = {
								path = "strongattack/not_selected_all/replace_confirm",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							replace_titlebg = {
								path = "strongattack/not_selected_all/replace_titlebg",
								list = {
									title = {
										path = "strongattack/not_selected_all/replace_titlebg/title",
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
							replace_hint = {
								path = "strongattack/not_selected_all/replace_hint",
								list = {
									replace_hint_dsc = {
										path = "strongattack/not_selected_all/replace_hint/replace_hint_dsc",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									replace_hint_img = {
										path = "strongattack/not_selected_all/replace_hint/replace_hint_img",
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
					"UnityEngine.CanvasGroup"
				}
			},
			npc = {
				path = "npc",
				list = {
					painting = {
						path = "npc/painting",
						list = {
							talk = {
								path = "npc/painting/talk",
								list = {
									bg1 = {
										path = "npc/painting/talk/bg1",
										list = {
											bg2 = {
												path = "npc/painting/talk/bg1/bg2",
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
									label_txt = {
										path = "npc/painting/talk/label_txt",
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
									"UnityEngine.CanvasGroup",
									"PopVerticalAdaptive",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					paintingbtn = {
						path = "npc/paintingbtn",
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
					"UITweenSequence",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			strike_difficult = {
				path = "strike_difficult",
				list = {
					difficult_open = {
						path = "strike_difficult/difficult_open",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"Spine.Unity.SkeletonGraphic",
							"UnityEngine.UI.Mask"
						}
					},
					mask_image_2 = {
						path = "strike_difficult/mask_image_2",
						list = {
							difficult_move = {
								path = "strike_difficult/mask_image_2/difficult_move",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
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
					mask_image_1 = {
						path = "strike_difficult/mask_image_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			back_image = {
				path = "strike_difficult/back_image",
				list = {},
				component = {}
			}
		},
		call_node_list = {
			["strike_map/main/back_main_btn"] = "_control.main.back_main_btn",
			["strike_map/strongattack/string_node2"] = "_control.strongattack.string_node2",
			["strike_map/strongattack/string_node5/attr_scroller"] = "_control.strongattack.string_node5.attr_scroller",
			["strike_map/strongattack/string_node3"] = "_control.strongattack.string_node3",
			["strike_map/strongattack/string_node5/float_bg"] = "_control.strongattack.string_node5.float_bg",
			["strike_map/strongattack/string_node5/title_bg"] = "_control.strongattack.string_node5.title_bg",
			["strike_map/strongattack/string_node1/icon_num/point_icon"] = "_control.strongattack.string_node1.icon_num.point_icon",
			["strike_map/strongattack/string_node3/img_replace"] = "_control.strongattack.string_node3.img_replace",
			["strike_map/strongattack/string_node5/buffname_scroller/buff_name2"] = "_control.strongattack.string_node5.buffname_scroller.buff_name2",
			["strike_map/strongattack/string_node1/attr_scroller/attr_info"] = "_control.strongattack.string_node1.attr_scroller.attr_info",
			["strike_map/strongattack/not_selected_all/replace_node/float_bg"] = "_control.strongattack.not_selected_all.replace_node.float_bg",
			["strike_map/strongattack/string_node3/icon_num/num"] = "_control.strongattack.string_node3.icon_num.num",
			["strike_map/strongattack/string_node3/icon_num"] = "_control.strongattack.string_node3.icon_num",
			["strike_map/strongattack/string_node3/info_text"] = "_control.strongattack.string_node3.info_text",
			["strike_map/strongattack/circle_2"] = "_control.strongattack.circle_2",
			["strike_map/msgbox/maskbg"] = "_control.msgbox.maskbg",
			["strike_map/strongattack/string_node3/attr_scroller"] = "_control.strongattack.string_node3.attr_scroller",
			["strike_map/strike_difficult/difficult_open"] = "_control.strike_difficult.difficult_open",
			["strike_map/strongattack/string_node1/img_replace"] = "_control.strongattack.string_node1.img_replace",
			["strike_map/strongattack/string_node3/buffname_scroller/buff_name"] = "_control.strongattack.string_node3.buffname_scroller.buff_name",
			["strike_map/strongattack/string_node2/title_bg"] = "_control.strongattack.string_node2.title_bg",
			["strike_map/strongattack/string_node1/icon_num"] = "_control.strongattack.string_node1.icon_num",
			["strike_map/strongattack/replace_bg"] = "_control.strongattack.replace_bg",
			["strike_map/strongattack/replace/replace_hint"] = "_control.strongattack.replace.replace_hint",
			["strike_map/strongattack/string_node3/title_bg"] = "_control.strongattack.string_node3.title_bg",
			["strike_map/main/bottom/point/point_text"] = "_control.main.bottom.point.point_text",
			["strike_map/main/middle/map_panel/ship/ship_layer/encounter_effect/encounter_spine"] = "_control.main.middle.map_panel.ship.ship_layer.encounter_effect.encounter_spine",
			["strike_map/strongattack/replace/replace_confirm"] = "_control.strongattack.replace.replace_confirm",
			["strike_map/strongattack/string_node5/buffname_scroller"] = "_control.strongattack.string_node5.buffname_scroller",
			["strike_map/strongattack/exit/Text"] = "_control.strongattack.exit.Text",
			["strike_map/strongattack/string_node4/icon_num/point_icon"] = "_control.strongattack.string_node4.icon_num.point_icon",
			["strike_map/msgbox/main/main_text"] = "_control.msgbox.main.main_text",
			["strike_map/strongattack/not_selected_all/replace_return"] = "_control.strongattack.not_selected_all.replace_return",
			["strike_map/strongattack/confirm"] = "_control.strongattack.confirm",
			["strike_map/strongattack/string_node4/icon_num"] = "_control.strongattack.string_node4.icon_num",
			["strike_map/strongattack/string_node4/img_replace"] = "_control.strongattack.string_node4.img_replace",
			["strike_map/strongattack/string_node4/info_text"] = "_control.strongattack.string_node4.info_text",
			["strike_map/strongattack/string_node4/attr_scroller/attr_info2"] = "_control.strongattack.string_node4.attr_scroller.attr_info2",
			["strike_map/main/middle/map_panel/ship"] = "_control.main.middle.map_panel.ship",
			["strike_map/strongattack/string_node4/attr_scroller"] = "_control.strongattack.string_node4.attr_scroller",
			["strike_map/strongattack/not_selected_all/replace_hint/replace_hint_dsc"] = "_control.strongattack.not_selected_all.replace_hint.replace_hint_dsc",
			["strike_map/strongattack/string_node4/buffname_scroller/buff_name"] = "_control.strongattack.string_node4.buffname_scroller.buff_name",
			["strike_map/strongattack/replace/replace_return"] = "_control.strongattack.replace.replace_return",
			["strike_map/strongattack/string_node4/title_bg"] = "_control.strongattack.string_node4.title_bg",
			["strike_map/strongattack/string_node4/float_bg"] = "_control.strongattack.string_node4.float_bg",
			["strike_map/strongattack/replace/replace_hint/replace_hint_img"] = "_control.strongattack.replace.replace_hint.replace_hint_img",
			["strike_map/strongattack/string_node2/icon_num/point_icon"] = "_control.strongattack.string_node2.icon_num.point_icon",
			["strike_map/strongattack/string_node2/icon_num/num"] = "_control.strongattack.string_node2.icon_num.num",
			["strike_map/main/top/return_btn"] = "_control.main.top.return_btn",
			["strike_map/strongattack/string_node2/icon_num"] = "_control.strongattack.string_node2.icon_num",
			["strike_map/strongattack/replace_bg/replace_dsc"] = "_control.strongattack.replace_bg.replace_dsc",
			["strike_map/npc/painting/talk"] = "_control.npc.painting.talk",
			["strike_map/strongattack/string_node2/info_text"] = "_control.strongattack.string_node2.info_text",
			["strike_map/strongattack/not_selected_all/replace_node/icon_num/point_icon"] = "_control.strongattack.not_selected_all.replace_node.icon_num.point_icon",
			["strike_map/strongattack/bg"] = "_control.strongattack.bg",
			["strike_map/strongattack/string_node2/attr_scroller/attr_info"] = "_control.strongattack.string_node2.attr_scroller.attr_info",
			["strike_map/strike_difficult/mask_image_1"] = "_control.strike_difficult.mask_image_1",
			["strike_map/strongattack/string_node2/buffname_scroller/buff_name2"] = "_control.strongattack.string_node2.buffname_scroller.buff_name2",
			["strike_map/main/back_difficult_btn"] = "_control.main.back_difficult_btn",
			["strike_map/strongattack/string_node1/buffname_scroller"] = "_control.strongattack.string_node1.buffname_scroller",
			["strike_map/strongattack/string_node2/buffname_scroller/buff_name"] = "_control.strongattack.string_node2.buffname_scroller.buff_name",
			["strike_map/strongattack/string_node3/float_bg"] = "_control.strongattack.string_node3.float_bg",
			["strike_map/strongattack/replace/replace_node/icon_num"] = "_control.strongattack.replace.replace_node.icon_num",
			["strike_map/strongattack/string_node2/float_bg"] = "_control.strongattack.string_node2.float_bg",
			["strike_map/strongattack/string_node1/title_bg"] = "_control.strongattack.string_node1.title_bg",
			["strike_map/strongattack/string_node2/attr_scroller"] = "_control.strongattack.string_node2.attr_scroller",
			["strike_map/msgbox/main/confirmbtn/text"] = "_control.msgbox.main.confirmbtn.text",
			["strike_map/strongattack/string_node4/attr_scroller/attr_info"] = "_control.strongattack.string_node4.attr_scroller.attr_info",
			["strike_map/msgbox/main/confirmbtn"] = "_control.msgbox.main.confirmbtn",
			["strike_map/main/back_image"] = "_control.main.back_image",
			["strike_map/strongattack/string_node3/attr_scroller/attr_info"] = "_control.strongattack.string_node3.attr_scroller.attr_info",
			["strike_map/strongattack/string_node3/attr_scroller/attr_info2"] = "_control.strongattack.string_node3.attr_scroller.attr_info2",
			["strike_map/strongattack/string_node1/info_text"] = "_control.strongattack.string_node1.info_text",
			["strike_map/strongattack/not_selected_all/replace_node/attr_scroller/attr_info2"] = "_control.strongattack.not_selected_all.replace_node.attr_scroller.attr_info2",
			["strike_map/strongattack/string_node1/buffname_scroller/buff_name2"] = "_control.strongattack.string_node1.buffname_scroller.buff_name2",
			["strike_map/main/middle/map_panel/map_lock"] = "_control.main.middle.map_panel.map_lock",
			["strike_map/msgbox/main/cancelbtn/text"] = "_control.msgbox.main.cancelbtn.text",
			["strike_map/main/top/title_bg/title_text/top_text"] = "_control.main.top.title_bg.title_text.top_text",
			["strike_map/strongattack/string_node1/float_bg"] = "_control.strongattack.string_node1.float_bg",
			["strike_map/strongattack"] = "_control.strongattack",
			["strike_map/strongattack/string_node5/buffname_scroller/buff_name"] = "_control.strongattack.string_node5.buffname_scroller.buff_name",
			["strike_map/main/bottom"] = "_control.main.bottom",
			["strike_map/strongattack/string_node1/attr_scroller/attr_info2"] = "_control.strongattack.string_node1.attr_scroller.attr_info2",
			["strike_map/strongattack/string_node5/icon_num/num"] = "_control.strongattack.string_node5.icon_num.num",
			["strike_map/strongattack/replace/replace_node/title_bg"] = "_control.strongattack.replace.replace_node.title_bg",
			["strike_map/strongattack/string_node5/attr_scroller/attr_info"] = "_control.strongattack.string_node5.attr_scroller.attr_info",
			["strike_map/main/bottom/point"] = "_control.main.bottom.point",
			["strike_map/main/top/title_bg"] = "_control.main.top.title_bg",
			["strike_map/main/middle/map_panel/ship/ship_layer/encounter_effect"] = "_control.main.middle.map_panel.ship.ship_layer.encounter_effect",
			["strike_map/msgbox/main"] = "_control.msgbox.main",
			["strike_map/bg"] = "_control.bg",
			["strike_map/strongattack/replace/replace_node/buffname_scroller/buff_name2"] = "_control.strongattack.replace.replace_node.buffname_scroller.buff_name2",
			["strike_map/strongattack/replace/replace_node/attr_scroller"] = "_control.strongattack.replace.replace_node.attr_scroller",
			["strike_map/strongattack/replace/replace_node/attr_scroller/attr_info"] = "_control.strongattack.replace.replace_node.attr_scroller.attr_info",
			["strike_map/strongattack/replace/replace_node/info_text"] = "_control.strongattack.replace.replace_node.info_text",
			["strike_map/strongattack/string_node2/buffname_scroller"] = "_control.strongattack.string_node2.buffname_scroller",
			["strike_map/msgbox/main/cancelbtn"] = "_control.msgbox.main.cancelbtn",
			["strike_map/strongattack/replace/replace_node/icon_num/num"] = "_control.strongattack.replace.replace_node.icon_num.num",
			["strike_map/strongattack/string_node1/attr_scroller"] = "_control.strongattack.string_node1.attr_scroller",
			["strike_map/strongattack/replace/replace_titlebg"] = "_control.strongattack.replace.replace_titlebg",
			["strike_map/strongattack/string_node3/buffname_scroller"] = "_control.strongattack.string_node3.buffname_scroller",
			["strike_map/strongattack/replace/replace_hint/replace_hint_dsc"] = "_control.strongattack.replace.replace_hint.replace_hint_dsc",
			["strike_map/strongattack/string_node4/buffname_scroller"] = "_control.strongattack.string_node4.buffname_scroller",
			["strike_map/strongattack/string_node4/icon_num/num"] = "_control.strongattack.string_node4.icon_num.num",
			["strike_map/strongattack/not_selected_all/replace_node"] = "_control.strongattack.not_selected_all.replace_node",
			["strike_map/strongattack/string_node3/icon_num/point_icon"] = "_control.strongattack.string_node3.icon_num.point_icon",
			["strike_map/strongattack/not_selected_all/replace_node/buffname_scroller"] = "_control.strongattack.not_selected_all.replace_node.buffname_scroller",
			["strike_map/strongattack/replace/replace_node/float_bg"] = "_control.strongattack.replace.replace_node.float_bg",
			["strike_map/main/bottom/import_btn/text"] = "_control.main.bottom.import_btn.text",
			["strike_map/strongattack/replace/replace_titlebg/title"] = "_control.strongattack.replace.replace_titlebg.title",
			["strike_map/strongattack/not_selected_all/replace_node/attr_scroller"] = "_control.strongattack.not_selected_all.replace_node.attr_scroller",
			["strike_map/strongattack/not_selected_all/replace_node/attr_scroller/attr_info"] = "_control.strongattack.not_selected_all.replace_node.attr_scroller.attr_info",
			["strike_map/strongattack/titlebg"] = "_control.strongattack.titlebg",
			["strike_map/strongattack/not_selected_all/replace_node/info_text"] = "_control.strongattack.not_selected_all.replace_node.info_text",
			["strike_map/strongattack/not_selected_all/replace_node/icon_num"] = "_control.strongattack.not_selected_all.replace_node.icon_num",
			["strike_map/strongattack/string_node1/icon_num/num"] = "_control.strongattack.string_node1.icon_num.num",
			["strike_map/strike_difficult/back_image"] = "_control.back_image",
			["strike_map/strongattack/not_selected_all/replace_titlebg/title"] = "_control.strongattack.not_selected_all.replace_titlebg.title",
			["strike_map/strongattack/not_selected_all/replace_hint"] = "_control.strongattack.not_selected_all.replace_hint",
			["strike_map/strongattack/replace/replace_node/buffname_scroller/buff_name"] = "_control.strongattack.replace.replace_node.buffname_scroller.buff_name",
			["strike_map/strongattack/string_node4/buffname_scroller/buff_name2"] = "_control.strongattack.string_node4.buffname_scroller.buff_name2",
			["strike_map/npc"] = "_control.npc",
			["strike_map/strongattack/string_node2/img_replace"] = "_control.strongattack.string_node2.img_replace",
			["strike_map/npc/painting/talk/bg1"] = "_control.npc.painting.talk.bg1",
			["strike_map/npc/painting/talk/bg1/bg2"] = "_control.npc.painting.talk.bg1.bg2",
			["strike_map/npc/painting/talk/label_txt"] = "_control.npc.painting.talk.label_txt",
			["strike_map/strongattack/not_selected_all/replace_titlebg"] = "_control.strongattack.not_selected_all.replace_titlebg",
			["strike_map/strongattack/string_node1/buffname_scroller/buff_name"] = "_control.strongattack.string_node1.buffname_scroller.buff_name",
			["strike_map/npc/paintingbtn"] = "_control.npc.paintingbtn",
			["strike_map/strike_difficult"] = "_control.strike_difficult",
			["strike_map/strongattack/string_node2/attr_scroller/attr_info2"] = "_control.strongattack.string_node2.attr_scroller.attr_info2",
			["strike_map/strongattack/string_node3/buffname_scroller/buff_name2"] = "_control.strongattack.string_node3.buffname_scroller.buff_name2",
			["strike_map/msgbox/main/top"] = "_control.msgbox.main.top",
			["strike_map/main/middle/map_panel/ship/ship_layer"] = "_control.main.middle.map_panel.ship.ship_layer",
			["strike_map/hard_bg"] = "_control.hard_bg",
			["strike_map/main/middle/map_panel/circle_img"] = "_control.main.middle.map_panel.circle_img",
			["strike_map/strongattack/string_node5/info_text"] = "_control.strongattack.string_node5.info_text",
			["strike_map/main/top/show_btn"] = "_control.main.top.show_btn",
			["strike_map/main/bottom/import_btn"] = "_control.main.bottom.import_btn",
			["strike_map/strike_difficult/mask_image_2/difficult_move"] = "_control.strike_difficult.mask_image_2.difficult_move",
			["strike_map/strongattack/exit"] = "_control.strongattack.exit",
			["strike_map/main/top/title_bg/title_text"] = "_control.main.top.title_bg.title_text",
			["strike_map/main/shadow_circle"] = "_control.main.shadow_circle",
			["strike_map/strongattack/titlebg/title"] = "_control.strongattack.titlebg.title",
			["strike_map/main/middle/map_panel/ship/ship_layer/ship_icon"] = "_control.main.middle.map_panel.ship.ship_layer.ship_icon",
			["strike_map/strongattack/replace/replace_node/buffname_scroller"] = "_control.strongattack.replace.replace_node.buffname_scroller",
			["strike_map/strongattack/not_selected_all/replace_node/buffname_scroller/buff_name"] = "_control.strongattack.not_selected_all.replace_node.buffname_scroller.buff_name",
			["strike_map/strongattack/replace/replace_node/attr_scroller/attr_info2"] = "_control.strongattack.replace.replace_node.attr_scroller.attr_info2",
			["strike_map/main/middle/map_panel"] = "_control.main.middle.map_panel",
			["strike_map/strike_difficult/mask_image_2"] = "_control.strike_difficult.mask_image_2",
			["strike_map/main/middle"] = "_control.main.middle",
			["strike_map/main"] = "_control.main",
			["strike_map/main/bottom/point/point_icon"] = "_control.main.bottom.point.point_icon",
			["strike_map/strongattack/replace/replace_node/icon_num/point_icon"] = "_control.strongattack.replace.replace_node.icon_num.point_icon",
			["strike_map/main/middle/map_panel/map_node_root"] = "_control.main.middle.map_panel.map_node_root",
			["strike_map/msgbox/main/main_bg"] = "_control.msgbox.main.main_bg",
			["strike_map/strongattack/not_selected_all/replace_hint/replace_hint_img"] = "_control.strongattack.not_selected_all.replace_hint.replace_hint_img",
			["strike_map/strongattack/string_node4"] = "_control.strongattack.string_node4",
			["strike_map/strongattack/replace/replace_node"] = "_control.strongattack.replace.replace_node",
			["strike_map/strongattack/not_selected_all"] = "_control.strongattack.not_selected_all",
			["strike_map/strongattack/not_selected_all/replace_node/icon_num/num"] = "_control.strongattack.not_selected_all.replace_node.icon_num.num",
			["strike_map/strongattack/string_node5/icon_num"] = "_control.strongattack.string_node5.icon_num",
			["strike_map/strongattack/string_node5/img_replace"] = "_control.strongattack.string_node5.img_replace",
			["strike_map/msgbox/main/title/gogo"] = "_control.msgbox.main.title.gogo",
			["strike_map/strongattack/not_selected_all/replace_node/buffname_scroller/buff_name2"] = "_control.strongattack.not_selected_all.replace_node.buffname_scroller.buff_name2",
			["strike_map/strongattack/replace"] = "_control.strongattack.replace",
			["strike_map/strongattack/not_selected_all/replace_node/title_bg"] = "_control.strongattack.not_selected_all.replace_node.title_bg",
			["strike_map/strongattack/string_node5/icon_num/point_icon"] = "_control.strongattack.string_node5.icon_num.point_icon",
			["strike_map/strongattack/circle_1"] = "_control.strongattack.circle_1",
			["strike_map/strongattack/string_node5"] = "_control.strongattack.string_node5",
			["strike_map/obj_pool_root"] = "_control.obj_pool_root",
			["strike_map/strongattack/string_node5/attr_scroller/attr_info2"] = "_control.strongattack.string_node5.attr_scroller.attr_info2",
			["strike_map/msgbox/main/title"] = "_control.msgbox.main.title",
			["strike_map/msgbox"] = "_control.msgbox",
			["strike_map/main/top/title_bg/title_text2"] = "_control.main.top.title_bg.title_text2",
			["strike_map/strongattack/string_node1"] = "_control.strongattack.string_node1",
			["strike_map/npc/painting"] = "_control.npc.painting",
			["strike_map/strongattack/not_selected_all/replace_confirm"] = "_control.strongattack.not_selected_all.replace_confirm",
			["strike_map/main/top"] = "_control.main.top"
		},
		click = {
			["main/top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/show_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/import_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/back_difficult_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/back_main_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["msgbox/main/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["msgbox/main/cancelbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/string_node1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/string_node2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/string_node4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/string_node3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/string_node5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/exit"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/replace/replace_return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/replace/replace_confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/not_selected_all/replace_return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strongattack/not_selected_all/replace_confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["npc/paintingbtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			msgbox = {
				component = "UnityEngine.Canvas",
				path = "msgbox"
			},
			exit = {
				component = "UnityEngine.Canvas",
				path = "strongattack/exit"
			},
			painting = {
				component = "UnityEngine.Canvas",
				path = "npc/painting"
			}
		}
	}
}

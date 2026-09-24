return {
	_rule_ = {
		none = {
			show_on_tween = {
				path = "show_on_tween",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			shadw = {
				path = "shadw",
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
					border = {
						path = "main/border",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mask = {
						path = "main/mask",
						list = {
							glow = {
								path = "main/mask/glow",
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
					unknow = {
						path = "main/unknow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "main/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					head_segmentation = {
						path = "main/head_segmentation",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close = {
						path = "main/close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					mailui = {
						path = "main/mailui",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					mail_info_notic = {
						path = "main/mail_info_notic",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					mail_info_notic_mask = {
						path = "main/mail_info_notic_mask",
						list = {
							txt = {
								path = "main/mail_info_notic_mask/txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							txt_2 = {
								path = "main/mail_info_notic_mask/txt_2",
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
					icon_one = {
						path = "main/icon_one",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mail_num_text = {
						path = "main/mail_num_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					sbtn_delet_all = {
						path = "main/sbtn_delet_all",
						list = {
							Text = {
								path = "main/sbtn_delet_all/Text",
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
							"ScaleButton"
						}
					},
					sbtn_read_all = {
						path = "main/sbtn_read_all",
						list = {
							Text = {
								path = "main/sbtn_read_all/Text",
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
							"ScaleButton"
						}
					},
					lock_mail = {
						path = "main/lock_mail",
						list = {
							lock_mail_txt = {
								path = "main/lock_mail/lock_mail_txt",
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
							"ScaleButton"
						}
					},
					mail_scroll_view = {
						path = "main/mail_scroll_view",
						list = {
							mail_scroll_rect = {
								path = "main/mail_scroll_view/mail_scroll_rect",
								list = {
									viewport = {
										path = "main/mail_scroll_view/mail_scroll_rect/viewport",
										list = {
											Scrollbar = {
												path = "main/mail_scroll_view/mail_scroll_rect/viewport/Scrollbar",
												list = {
													sliding_area = {
														path = "main/mail_scroll_view/mail_scroll_rect/viewport/Scrollbar/sliding_area",
														list = {
															Handle = {
																path = "main/mail_scroll_view/mail_scroll_rect/viewport/Scrollbar/sliding_area/Handle",
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
											edge_mask = {
												path = "main/mail_scroll_view/mail_scroll_rect/viewport/edge_mask",
												list = {
													content = {
														path = "main/mail_scroll_view/mail_scroll_rect/viewport/edge_mask/content",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"EndlessScrollView"
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
											"UnityEngine.UI.Mask",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.ScrollRect"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					mask_bg = {
						path = "main/mask_bg",
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
		call_node_list = {
			["mail/main/mail_info_notic_mask/txt_2"] = "_control.main.mail_info_notic_mask.txt_2",
			["mail/main/mail_info_notic_mask"] = "_control.main.mail_info_notic_mask",
			["mail/shadw"] = "_control.shadw",
			["mail/main/mask"] = "_control.main.mask",
			["mail/main"] = "_control.main",
			["mail/main/head_segmentation"] = "_control.main.head_segmentation",
			["mail/main/close"] = "_control.main.close",
			["mail/main/mail_num_text"] = "_control.main.mail_num_text",
			["mail/main/lock_mail/lock_mail_txt"] = "_control.main.lock_mail.lock_mail_txt",
			["mail/main/mail_scroll_view/mail_scroll_rect/viewport"] = "_control.main.mail_scroll_view.mail_scroll_rect.viewport",
			["mail/main/sbtn_read_all/Text"] = "_control.main.sbtn_read_all.Text",
			["mail/show_on_tween"] = "_control.show_on_tween",
			["mail/main/sbtn_delet_all"] = "_control.main.sbtn_delet_all",
			["mail/main/icon_one"] = "_control.main.icon_one",
			["mail/main/sbtn_read_all"] = "_control.main.sbtn_read_all",
			["mail/main/mail_scroll_view"] = "_control.main.mail_scroll_view",
			["mail/main/sbtn_delet_all/Text"] = "_control.main.sbtn_delet_all.Text",
			["mail/main/mail_info_notic"] = "_control.main.mail_info_notic",
			["mail/main/mail_scroll_view/mail_scroll_rect/viewport/Scrollbar/sliding_area"] = "_control.main.mail_scroll_view.mail_scroll_rect.viewport.Scrollbar.sliding_area",
			["mail/main/mail_scroll_view/mail_scroll_rect"] = "_control.main.mail_scroll_view.mail_scroll_rect",
			["mail/main/unknow"] = "_control.main.unknow",
			["mail/main/mail_scroll_view/mail_scroll_rect/viewport/Scrollbar"] = "_control.main.mail_scroll_view.mail_scroll_rect.viewport.Scrollbar",
			["mail/main/border"] = "_control.main.border",
			["mail/main/mail_scroll_view/mail_scroll_rect/viewport/Scrollbar/sliding_area/Handle"] = "_control.main.mail_scroll_view.mail_scroll_rect.viewport.Scrollbar.sliding_area.Handle",
			["mail/main/mask/glow"] = "_control.main.mask.glow",
			["mail/main/mail_scroll_view/mail_scroll_rect/viewport/edge_mask"] = "_control.main.mail_scroll_view.mail_scroll_rect.viewport.edge_mask",
			["mail/main/lock_mail"] = "_control.main.lock_mail",
			["mail/main/mail_scroll_view/mail_scroll_rect/viewport/edge_mask/content"] = "_control.main.mail_scroll_view.mail_scroll_rect.viewport.edge_mask.content",
			["mail/main/mail_info_notic_mask/txt"] = "_control.main.mail_info_notic_mask.txt",
			["mail/main/title"] = "_control.main.title",
			["mail/main/mailui"] = "_control.main.mailui",
			["mail/main/mask_bg"] = "_control.main.mask_bg"
		},
		scale_btn_click = {
			["main/close"] = {
				tp = "ScaleButton"
			},
			["main/sbtn_delet_all"] = {
				tp = "ScaleButton"
			},
			["main/sbtn_read_all"] = {
				tp = "ScaleButton"
			},
			["main/lock_mail"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

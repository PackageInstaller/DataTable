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
			buff_trans = {
				path = "buff_trans",
				list = {
					buff_bg = {
						path = "buff_trans/buff_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					buff_title = {
						path = "buff_trans/buff_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					new_icon = {
						path = "buff_trans/new_icon",
						list = {
							new_text = {
								path = "buff_trans/new_icon/new_text",
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
					buff_name = {
						path = "buff_trans/buff_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					buff_icon = {
						path = "buff_trans/buff_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					buff_info = {
						path = "buff_trans/buff_info",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					giveup_btn = {
						path = "buff_trans/giveup_btn",
						list = {
							giveup_text = {
								path = "buff_trans/giveup_btn/giveup_text",
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
			buff_list = {
				path = "buff_list",
				list = {
					list_bg = {
						path = "buff_list/list_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					all_buff = {
						path = "buff_list/all_buff",
						list = {
							Viewport = {
								path = "buff_list/all_buff/Viewport",
								list = {
									Scrollbar = {
										path = "buff_list/all_buff/Viewport/Scrollbar",
										list = {
											["Sliding Area"] = {
												path = "buff_list/all_buff/Viewport/Scrollbar/Sliding Area",
												list = {
													Handle = {
														path = "buff_list/all_buff/Viewport/Scrollbar/Sliding Area/Handle",
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
										path = "buff_list/all_buff/Viewport/edge_mask",
										list = {
											Content = {
												path = "buff_list/all_buff/Viewport/edge_mask/Content",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"EndlessScrollView",
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
					buff_storage = {
						path = "buff_list/buff_storage",
						list = {
							Viewport = {
								path = "buff_list/buff_storage/Viewport",
								list = {
									temp_bg = {
										path = "buff_list/buff_storage/Viewport/temp_bg",
										list = {
											txt = {
												path = "buff_list/buff_storage/Viewport/temp_bg/txt",
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
							},
							tower_buff_storage0 = {
								path = "buff_list/buff_storage/tower_buff_storage0",
								list = {
									storage_btn = {
										path = "buff_list/buff_storage/tower_buff_storage0/storage_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									extract_buff_btn = {
										path = "buff_list/buff_storage/tower_buff_storage0/extract_buff_btn",
										list = {
											txt_replace = {
												path = "buff_list/buff_storage/tower_buff_storage0/extract_buff_btn/txt_replace",
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
									buff_info_panel = {
										path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel",
										list = {
											buff_top_bg = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/buff_top_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_icon_bg = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/buff_icon_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_icon = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/buff_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_name = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											buff_info = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/buff_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											replace_btn = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/replace_btn",
												list = {
													txt_replace = {
														path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/replace_btn/txt_replace",
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
											decompose_btn = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/decompose_btn",
												list = {
													txt_decompose = {
														path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/decompose_btn/txt_decompose",
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
											selected_halo = {
												path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/selected_halo",
												list = {
													card_select = {
														path = "buff_list/buff_storage/tower_buff_storage0/buff_info_panel/selected_halo/card_select",
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
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							tower_buff_storage1 = {
								path = "buff_list/buff_storage/tower_buff_storage1",
								list = {
									storage_btn = {
										path = "buff_list/buff_storage/tower_buff_storage1/storage_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									extract_buff_btn = {
										path = "buff_list/buff_storage/tower_buff_storage1/extract_buff_btn",
										list = {
											txt_replace = {
												path = "buff_list/buff_storage/tower_buff_storage1/extract_buff_btn/txt_replace",
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
									buff_info_panel = {
										path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel",
										list = {
											buff_top_bg = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/buff_top_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_icon_bg = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/buff_icon_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_icon = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/buff_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_name = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											buff_info = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/buff_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											replace_btn = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/replace_btn",
												list = {
													txt_replace = {
														path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/replace_btn/txt_replace",
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
											decompose_btn = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/decompose_btn",
												list = {
													txt_decompose = {
														path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/decompose_btn/txt_decompose",
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
											selected_halo = {
												path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/selected_halo",
												list = {
													card_select = {
														path = "buff_list/buff_storage/tower_buff_storage1/buff_info_panel/selected_halo/card_select",
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
							"UnityEngine.CanvasRenderer"
						}
					},
					top_title = {
						path = "buff_list/top_title",
						list = {
							bg = {
								path = "buff_list/top_title/bg",
								list = {
									three_point = {
										path = "buff_list/top_title/bg/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									txt = {
										path = "buff_list/top_title/bg/txt",
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
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			return_btn = {
				path = "return_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			msg_box = {
				path = "msg_box",
				list = {
					maskbg = {
						path = "msg_box/maskbg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					main = {
						path = "msg_box/main",
						list = {
							main_bg = {
								path = "msg_box/main/main_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_decore = {
								path = "msg_box/main/top_decore",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top = {
								path = "msg_box/main/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "msg_box/main/title",
								list = {
									gogo = {
										path = "msg_box/main/title/gogo",
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
							quitbtn = {
								path = "msg_box/main/quitbtn",
								list = {
									text = {
										path = "msg_box/main/quitbtn/text",
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
							confirmbtn = {
								path = "msg_box/main/confirmbtn",
								list = {
									text = {
										path = "msg_box/main/confirmbtn/text",
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
							closebtn = {
								path = "msg_box/main/closebtn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							main_text = {
								path = "msg_box/main/main_text",
								list = {
									use = {
										path = "msg_box/main/main_text/use",
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
							diamond_icon = {
								path = "msg_box/main/diamond_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							former_num = {
								path = "msg_box/main/former_num",
								list = {
									arrow = {
										path = "msg_box/main/former_num/arrow",
										list = {
											latter_num = {
												path = "msg_box/main/former_num/arrow/latter_num",
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
							},
							change_user_name = {
								path = "msg_box/main/change_user_name",
								list = {
									user_name = {
										path = "msg_box/main/change_user_name/user_name",
										list = {
											last_text = {
												path = "msg_box/main/change_user_name/user_name/last_text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											next_text = {
												path = "msg_box/main/change_user_name/user_name/next_text",
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
											"UnityEngine.UI.ContentSizeFitter",
											"UnityEngine.UI.Shadow"
										}
									},
									diamond_des = {
										path = "msg_box/main/change_user_name/diamond_des",
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
			bg = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_trans/giveup_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage0/storage_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage0/extract_buff_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage0/buff_info_panel/replace_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage0/buff_info_panel/decompose_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage1/storage_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage1/extract_buff_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage1/buff_info_panel/replace_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_list/buff_storage/tower_buff_storage1/buff_info_panel/decompose_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			return_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["msg_box/main/quitbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["msg_box/main/confirmbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["msg_box/main/closebtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			msg_box = {
				component = "UnityEngine.Canvas",
				path = "msg_box"
			}
		}
	}
}

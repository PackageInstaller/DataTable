return {
	_rule_ = {
		none = {
			bg_mask = {
				path = "bg_mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg = {
				path = "bg",
				list = {
					title_bg = {
						path = "bg/title_bg",
						list = {
							title_txt = {
								path = "bg/title_bg/title_txt",
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
					close_btn = {
						path = "bg/close_btn",
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
					"UnityEngine.UI.Image",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			buff_detail_bg = {
				path = "buff_detail_bg",
				list = {
					info_bg_1 = {
						path = "buff_detail_bg/info_bg_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					info_bg_2 = {
						path = "buff_detail_bg/info_bg_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					info_bg_line = {
						path = "buff_detail_bg/info_bg_line",
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
			buff_detail = {
				path = "buff_detail",
				list = {
					buff_bg = {
						path = "buff_detail/buff_bg",
						list = {
							buff_image = {
								path = "buff_detail/buff_bg/buff_image",
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
					buff_title = {
						path = "buff_detail/buff_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					buff_lv = {
						path = "buff_detail/buff_lv",
						list = {
							buff_lv_num = {
								path = "buff_detail/buff_lv/buff_lv_num",
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
					buff_desc_bg = {
						path = "buff_detail/buff_desc_bg",
						list = {
							buff_desc = {
								path = "buff_detail/buff_desc_bg/buff_desc",
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
					buff_exp_bg = {
						path = "buff_detail/buff_exp_bg",
						list = {
							buff_exp_image = {
								path = "buff_detail/buff_exp_bg/buff_exp_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							buff_exp_num = {
								path = "buff_detail/buff_exp_bg/buff_exp_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							buff_exp_remain = {
								path = "buff_detail/buff_exp_bg/buff_exp_remain",
								list = {
									remain_num = {
										path = "buff_detail/buff_exp_bg/buff_exp_remain/remain_num",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					left_toggle_btn = {
						path = "buff_detail/left_toggle_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					right_toggle_btn = {
						path = "buff_detail/right_toggle_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					equip_state_btn = {
						path = "buff_detail/equip_state_btn",
						list = {
							Text = {
								path = "buff_detail/equip_state_btn/Text",
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
					equip_choose_btn = {
						path = "buff_detail/equip_choose_btn",
						list = {
							Text = {
								path = "buff_detail/equip_choose_btn/Text",
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
			equip_buff_content = {
				path = "equip_buff_content",
				list = {
					equip_buff_cell_1 = {
						path = "equip_buff_content/equip_buff_cell_1",
						list = {
							buff_bg = {
								path = "equip_buff_content/equip_buff_cell_1/buff_bg",
								list = {
									buff_image = {
										path = "equip_buff_content/equip_buff_cell_1/buff_bg/buff_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									select_outline = {
										path = "equip_buff_content/equip_buff_cell_1/buff_bg/select_outline",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_lv_num = {
										path = "equip_buff_content/equip_buff_cell_1/buff_bg/buff_lv_num",
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
					equip_buff_cell_2 = {
						path = "equip_buff_content/equip_buff_cell_2",
						list = {
							buff_bg = {
								path = "equip_buff_content/equip_buff_cell_2/buff_bg",
								list = {
									buff_image = {
										path = "equip_buff_content/equip_buff_cell_2/buff_bg/buff_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									select_outline = {
										path = "equip_buff_content/equip_buff_cell_2/buff_bg/select_outline",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_lv_num = {
										path = "equip_buff_content/equip_buff_cell_2/buff_bg/buff_lv_num",
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
					equip_buff_cell_3 = {
						path = "equip_buff_content/equip_buff_cell_3",
						list = {
							buff_bg = {
								path = "equip_buff_content/equip_buff_cell_3/buff_bg",
								list = {
									buff_image = {
										path = "equip_buff_content/equip_buff_cell_3/buff_bg/buff_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									select_outline = {
										path = "equip_buff_content/equip_buff_cell_3/buff_bg/select_outline",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_lv_num = {
										path = "equip_buff_content/equip_buff_cell_3/buff_bg/buff_lv_num",
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
					equip_buff_cell_4 = {
						path = "equip_buff_content/equip_buff_cell_4",
						list = {
							buff_bg = {
								path = "equip_buff_content/equip_buff_cell_4/buff_bg",
								list = {
									buff_image = {
										path = "equip_buff_content/equip_buff_cell_4/buff_bg/buff_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									select_outline = {
										path = "equip_buff_content/equip_buff_cell_4/buff_bg/select_outline",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_lv_num = {
										path = "equip_buff_content/equip_buff_cell_4/buff_bg/buff_lv_num",
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
					equip_buff_cell_5 = {
						path = "equip_buff_content/equip_buff_cell_5",
						list = {
							buff_bg = {
								path = "equip_buff_content/equip_buff_cell_5/buff_bg",
								list = {
									buff_image = {
										path = "equip_buff_content/equip_buff_cell_5/buff_bg/buff_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									select_outline = {
										path = "equip_buff_content/equip_buff_cell_5/buff_bg/select_outline",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_lv_num = {
										path = "equip_buff_content/equip_buff_cell_5/buff_bg/buff_lv_num",
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
					equip_buff_cell_6 = {
						path = "equip_buff_content/equip_buff_cell_6",
						list = {
							buff_bg = {
								path = "equip_buff_content/equip_buff_cell_6/buff_bg",
								list = {
									buff_image = {
										path = "equip_buff_content/equip_buff_cell_6/buff_bg/buff_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									select_outline = {
										path = "equip_buff_content/equip_buff_cell_6/buff_bg/select_outline",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									buff_lv_num = {
										path = "equip_buff_content/equip_buff_cell_6/buff_bg/buff_lv_num",
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
			},
			store_buff_content = {
				path = "store_buff_content",
				list = {
					store_outline = {
						path = "store_buff_content/store_outline",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					all_store_buff = {
						path = "store_buff_content/all_store_buff",
						list = {
							Viewport = {
								path = "store_buff_content/all_store_buff/Viewport",
								list = {
									Scrollbar = {
										path = "store_buff_content/all_store_buff/Viewport/Scrollbar",
										list = {
											["Sliding Area"] = {
												path = "store_buff_content/all_store_buff/Viewport/Scrollbar/Sliding Area",
												list = {
													Handle = {
														path = "store_buff_content/all_store_buff/Viewport/Scrollbar/Sliding Area/Handle",
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
										path = "store_buff_content/all_store_buff/Viewport/edge_mask",
										list = {
											Content = {
												path = "store_buff_content/all_store_buff/Viewport/edge_mask/Content",
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
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.RectMask2D",
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
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_detail/left_toggle_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_detail/right_toggle_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_detail/equip_state_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_detail/equip_choose_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			bg = {
				component = "UnityEngine.Canvas",
				path = "bg"
			}
		}
	}
}

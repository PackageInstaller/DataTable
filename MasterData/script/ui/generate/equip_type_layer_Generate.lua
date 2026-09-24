return {
	_rule_ = {
		none = {
			type_layer = {
				path = "type_layer",
				list = {
					line_mid = {
						path = "type_layer/line_mid",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					filter_type = {
						path = "type_layer/filter_type",
						list = {
							sort_title_line = {
								path = "type_layer/filter_type/sort_title_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_txt = {
								path = "type_layer/filter_type/type_txt",
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
					btn_series = {
						path = "type_layer/btn_series",
						list = {
							confirm_btn = {
								path = "type_layer/btn_series/confirm_btn",
								list = {
									confirm = {
										path = "type_layer/btn_series/confirm_btn/confirm",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									confirm_mask = {
										path = "type_layer/btn_series/confirm_btn/confirm_mask",
										list = {
											txt = {
												path = "type_layer/btn_series/confirm_btn/confirm_mask/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											txt_2 = {
												path = "type_layer/btn_series/confirm_btn/confirm_mask/txt_2",
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							cancel_btn = {
								path = "type_layer/btn_series/cancel_btn",
								list = {
									cancel = {
										path = "type_layer/btn_series/cancel_btn/cancel",
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
					type_group = {
						path = "type_layer/type_group",
						list = {
							toggle_group = {
								path = "type_layer/type_group/toggle_group",
								list = {
									all = {
										path = "type_layer/type_group/toggle_group/all",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/all/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/all/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/all/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									main_gun = {
										path = "type_layer/type_group/toggle_group/main_gun",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/main_gun/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/main_gun/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/main_gun/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/main_gun/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/main_gun/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/main_gun/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									sub_gun = {
										path = "type_layer/type_group/toggle_group/sub_gun",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/sub_gun/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/sub_gun/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/sub_gun/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/sub_gun/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/sub_gun/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/sub_gun/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									torpedo = {
										path = "type_layer/type_group/toggle_group/torpedo",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/torpedo/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/torpedo/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/torpedo/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/torpedo/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/torpedo/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/torpedo/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									torpedo_plane = {
										path = "type_layer/type_group/toggle_group/torpedo_plane",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/torpedo_plane/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/torpedo_plane/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/torpedo_plane/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/torpedo_plane/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/torpedo_plane/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/torpedo_plane/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									fighter = {
										path = "type_layer/type_group/toggle_group/fighter",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/fighter/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/fighter/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/fighter/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/fighter/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/fighter/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/fighter/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									bomber = {
										path = "type_layer/type_group/toggle_group/bomber",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/bomber/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/bomber/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/bomber/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/bomber/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/bomber/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/bomber/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									spy_plane = {
										path = "type_layer/type_group/toggle_group/spy_plane",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/spy_plane/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/spy_plane/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/spy_plane/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/spy_plane/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/spy_plane/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/spy_plane/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									radar = {
										path = "type_layer/type_group/toggle_group/radar",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/radar/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/radar/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/radar/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/radar/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/radar/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/radar/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									module = {
										path = "type_layer/type_group/toggle_group/module",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/module/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/module/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/module/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/module/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/module/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/module/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									bullet = {
										path = "type_layer/type_group/toggle_group/bullet",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/bullet/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/bullet/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/bullet/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/bullet/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/bullet/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/bullet/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									aagun = {
										path = "type_layer/type_group/toggle_group/aagun",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/aagun/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/aagun/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/aagun/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/aagun/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/aagun/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/aagun/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									repairs = {
										path = "type_layer/type_group/toggle_group/repairs",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/repairs/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/repairs/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/repairs/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/repairs/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/repairs/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/repairs/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									anti_sub = {
										path = "type_layer/type_group/toggle_group/anti_sub",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/anti_sub/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/anti_sub/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/anti_sub/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/anti_sub/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/anti_sub/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/anti_sub/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									missile_launcher = {
										path = "type_layer/type_group/toggle_group/missile_launcher",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/missile_launcher/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/missile_launcher/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/missile_launcher/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/missile_launcher/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/missile_launcher/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/missile_launcher/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
										}
									},
									missile = {
										path = "type_layer/type_group/toggle_group/missile",
										list = {
											Background = {
												path = "type_layer/type_group/toggle_group/missile/Background",
												list = {
													Checkmark = {
														path = "type_layer/type_group/toggle_group/missile/Background/Checkmark",
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
											Label = {
												path = "type_layer/type_group/toggle_group/missile/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_mask = {
												path = "type_layer/type_group/toggle_group/missile/title_mask",
												list = {
													txt = {
														path = "type_layer/type_group/toggle_group/missile/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/type_group/toggle_group/missile/title_mask/txt_2",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Toggle"
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
					effect_group = {
						path = "type_layer/effect_group",
						list = {
							toggle_group = {
								path = "type_layer/effect_group/toggle_group",
								list = {
									all = {
										path = "type_layer/effect_group/toggle_group/all",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/all/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/all/Background/Checkmark",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/all/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									attack = {
										path = "type_layer/effect_group/toggle_group/attack",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/attack/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/attack/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/attack/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/attack/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/attack/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/attack/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									extra_damage = {
										path = "type_layer/effect_group/toggle_group/extra_damage",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/extra_damage/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/extra_damage/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/extra_damage/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/extra_damage/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/extra_damage/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/extra_damage/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									exp_up = {
										path = "type_layer/effect_group/toggle_group/exp_up",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/exp_up/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/exp_up/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/exp_up/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/exp_up/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/exp_up/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/exp_up/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									armor_pene = {
										path = "type_layer/effect_group/toggle_group/armor_pene",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/armor_pene/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/armor_pene/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/armor_pene/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/armor_pene/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/armor_pene/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/armor_pene/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									expedition_resource = {
										path = "type_layer/effect_group/toggle_group/expedition_resource",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/expedition_resource/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/expedition_resource/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/expedition_resource/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/expedition_resource/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/expedition_resource/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/expedition_resource/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									hit_rate = {
										path = "type_layer/effect_group/toggle_group/hit_rate",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/hit_rate/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/hit_rate/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/hit_rate/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/hit_rate/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/hit_rate/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/hit_rate/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									miss = {
										path = "type_layer/effect_group/toggle_group/miss",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/miss/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/miss/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/miss/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/miss/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/miss/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/miss/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									critical_rate = {
										path = "type_layer/effect_group/toggle_group/critical_rate",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/critical_rate/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/critical_rate/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/critical_rate/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/critical_rate/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/critical_rate/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/critical_rate/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									anti_air = {
										path = "type_layer/effect_group/toggle_group/anti_air",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/anti_air/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/anti_air/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/anti_air/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/anti_air/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/anti_air/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/anti_air/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									atk_top = {
										path = "type_layer/effect_group/toggle_group/atk_top",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/atk_top/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/atk_top/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/atk_top/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/atk_top/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/atk_top/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/atk_top/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									other = {
										path = "type_layer/effect_group/toggle_group/other",
										list = {
											Background = {
												path = "type_layer/effect_group/toggle_group/other/Background",
												list = {
													Checkmark = {
														path = "type_layer/effect_group/toggle_group/other/Background/Checkmark",
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
											title_mask = {
												path = "type_layer/effect_group/toggle_group/other/title_mask",
												list = {
													txt = {
														path = "type_layer/effect_group/toggle_group/other/title_mask/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													txt_2 = {
														path = "type_layer/effect_group/toggle_group/other/title_mask/txt_2",
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
											Label = {
												path = "type_layer/effect_group/toggle_group/other/Label",
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
											"UnityEngine.UI.Toggle"
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["equip_type_layer/type_layer/type_group/toggle_group/fighter/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.fighter.title_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group/atk_top/Label"] = "_control.type_layer.effect_group.toggle_group.atk_top.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/aagun/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.aagun.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/module/title_mask"] = "_control.type_layer.type_group.toggle_group.module.title_mask",
			["equip_type_layer/type_layer/line_mid"] = "_control.type_layer.line_mid",
			["equip_type_layer/type_layer/type_group/toggle_group/repairs/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.repairs.Background.Checkmark",
			["equip_type_layer/type_layer/btn_series/confirm_btn/confirm_mask/txt"] = "_control.type_layer.btn_series.confirm_btn.confirm_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/anti_sub/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.anti_sub.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/anti_sub/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.anti_sub.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/atk_top/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.atk_top.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/main_gun/Label"] = "_control.type_layer.type_group.toggle_group.main_gun.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/attack/Label"] = "_control.type_layer.effect_group.toggle_group.attack.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/bullet/Background"] = "_control.type_layer.type_group.toggle_group.bullet.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/anti_sub"] = "_control.type_layer.type_group.toggle_group.anti_sub",
			["equip_type_layer/type_layer/type_group/toggle_group/repairs/title_mask"] = "_control.type_layer.type_group.toggle_group.repairs.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/anti_sub/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.anti_sub.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/missile_launcher/Label"] = "_control.type_layer.type_group.toggle_group.missile_launcher.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/spy_plane/Label"] = "_control.type_layer.type_group.toggle_group.spy_plane.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/repairs"] = "_control.type_layer.type_group.toggle_group.repairs",
			["equip_type_layer/type_layer/type_group/toggle_group/fighter/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.fighter.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/bullet/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.bullet.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/aagun/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.aagun.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/aagun/title_mask"] = "_control.type_layer.type_group.toggle_group.aagun.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/aagun/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.aagun.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/hit_rate/Background"] = "_control.type_layer.effect_group.toggle_group.hit_rate.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/bomber/title_mask"] = "_control.type_layer.type_group.toggle_group.bomber.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/radar/Background"] = "_control.type_layer.type_group.toggle_group.radar.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo/Background"] = "_control.type_layer.type_group.toggle_group.torpedo.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/expedition_resource/title_mask"] = "_control.type_layer.effect_group.toggle_group.expedition_resource.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/sub_gun/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.sub_gun.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/bullet/title_mask"] = "_control.type_layer.type_group.toggle_group.bullet.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/all/Background"] = "_control.type_layer.effect_group.toggle_group.all.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/expedition_resource/Label"] = "_control.type_layer.effect_group.toggle_group.expedition_resource.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/spy_plane/Background"] = "_control.type_layer.type_group.toggle_group.spy_plane.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/repairs/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.repairs.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/sub_gun/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.sub_gun.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/module/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.module.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/module/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.module.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/module/Label"] = "_control.type_layer.type_group.toggle_group.module.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/missile/title_mask"] = "_control.type_layer.type_group.toggle_group.missile.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/module/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.module.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/module/Background"] = "_control.type_layer.type_group.toggle_group.module.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/spy_plane/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.spy_plane.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/sub_gun/Label"] = "_control.type_layer.type_group.toggle_group.sub_gun.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/sub_gun/title_mask"] = "_control.type_layer.type_group.toggle_group.sub_gun.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/miss/Background"] = "_control.type_layer.effect_group.toggle_group.miss.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/extra_damage/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.extra_damage.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/bullet/Label"] = "_control.type_layer.type_group.toggle_group.bullet.Label",
			["equip_type_layer/type_layer/btn_series/cancel_btn/cancel"] = "_control.type_layer.btn_series.cancel_btn.cancel",
			["equip_type_layer/type_layer/type_group/toggle_group/main_gun/title_mask"] = "_control.type_layer.type_group.toggle_group.main_gun.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/bomber/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.bomber.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/radar/Label"] = "_control.type_layer.type_group.toggle_group.radar.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/all"] = "_control.type_layer.effect_group.toggle_group.all",
			["equip_type_layer/type_layer/type_group/toggle_group/anti_sub/title_mask"] = "_control.type_layer.type_group.toggle_group.anti_sub.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo/Label"] = "_control.type_layer.type_group.toggle_group.torpedo.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/missile_launcher"] = "_control.type_layer.type_group.toggle_group.missile_launcher",
			["equip_type_layer/type_layer/type_group/toggle_group/fighter/Label"] = "_control.type_layer.type_group.toggle_group.fighter.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/fighter/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.fighter.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/bullet"] = "_control.type_layer.type_group.toggle_group.bullet",
			["equip_type_layer/type_layer/type_group/toggle_group/sub_gun/Background"] = "_control.type_layer.type_group.toggle_group.sub_gun.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/aagun/Background"] = "_control.type_layer.type_group.toggle_group.aagun.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo_plane"] = "_control.type_layer.type_group.toggle_group.torpedo_plane",
			["equip_type_layer/type_layer/type_group/toggle_group/bomber/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.bomber.title_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group/armor_pene/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.armor_pene.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.torpedo.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/missile"] = "_control.type_layer.type_group.toggle_group.missile",
			["equip_type_layer/type_layer/effect_group/toggle_group/other/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.other.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/repairs/Label"] = "_control.type_layer.type_group.toggle_group.repairs.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/spy_plane"] = "_control.type_layer.type_group.toggle_group.spy_plane",
			["equip_type_layer/type_layer/effect_group/toggle_group/anti_air"] = "_control.type_layer.effect_group.toggle_group.anti_air",
			["equip_type_layer/type_layer/effect_group/toggle_group/critical_rate/title_mask"] = "_control.type_layer.effect_group.toggle_group.critical_rate.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/bomber/Background"] = "_control.type_layer.type_group.toggle_group.bomber.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/atk_top/Background"] = "_control.type_layer.effect_group.toggle_group.atk_top.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/bomber/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.bomber.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/hit_rate/title_mask"] = "_control.type_layer.effect_group.toggle_group.hit_rate.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.torpedo.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/fighter/title_mask"] = "_control.type_layer.type_group.toggle_group.fighter.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/radar/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.radar.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/fighter/Background"] = "_control.type_layer.type_group.toggle_group.fighter.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/radar/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.radar.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/extra_damage/Label"] = "_control.type_layer.effect_group.toggle_group.extra_damage.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/all/Label"] = "_control.type_layer.effect_group.toggle_group.all.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/attack"] = "_control.type_layer.effect_group.toggle_group.attack",
			["equip_type_layer/type_layer/type_group/toggle_group/main_gun/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.main_gun.title_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group/other/Label"] = "_control.type_layer.effect_group.toggle_group.other.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/anti_sub/Label"] = "_control.type_layer.type_group.toggle_group.anti_sub.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/radar/title_mask"] = "_control.type_layer.type_group.toggle_group.radar.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/extra_damage/title_mask"] = "_control.type_layer.effect_group.toggle_group.extra_damage.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.all.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/exp_up/Background"] = "_control.type_layer.effect_group.toggle_group.exp_up.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/bomber"] = "_control.type_layer.type_group.toggle_group.bomber",
			["equip_type_layer/type_layer/effect_group/toggle_group/hit_rate/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.hit_rate.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/spy_plane/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.spy_plane.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/missile/Label"] = "_control.type_layer.type_group.toggle_group.missile.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/exp_up/title_mask"] = "_control.type_layer.effect_group.toggle_group.exp_up.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/missile_launcher/Background"] = "_control.type_layer.type_group.toggle_group.missile_launcher.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/exp_up/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.exp_up.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/aagun"] = "_control.type_layer.type_group.toggle_group.aagun",
			["equip_type_layer/type_layer/effect_group/toggle_group/exp_up/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.exp_up.title_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group/armor_pene/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.armor_pene.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/main_gun/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.main_gun.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/armor_pene/title_mask"] = "_control.type_layer.effect_group.toggle_group.armor_pene.title_mask",
			["equip_type_layer/type_layer/btn_series/confirm_btn/confirm"] = "_control.type_layer.btn_series.confirm_btn.confirm",
			["equip_type_layer/type_layer/effect_group/toggle_group/exp_up/Label"] = "_control.type_layer.effect_group.toggle_group.exp_up.Label",
			["equip_type_layer/type_layer/btn_series/confirm_btn/confirm_mask"] = "_control.type_layer.btn_series.confirm_btn.confirm_mask",
			["equip_type_layer/type_layer/type_group"] = "_control.type_layer.type_group",
			["equip_type_layer/type_layer/type_group/toggle_group/bullet/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.bullet.title_mask.txt",
			["equip_type_layer/type_layer/filter_type"] = "_control.type_layer.filter_type",
			["equip_type_layer/type_layer/effect_group/toggle_group/attack/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.attack.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/fighter"] = "_control.type_layer.type_group.toggle_group.fighter",
			["equip_type_layer/type_layer/effect_group/toggle_group/expedition_resource/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.expedition_resource.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/missile_launcher/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.missile_launcher.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo"] = "_control.type_layer.type_group.toggle_group.torpedo",
			["equip_type_layer/type_layer/effect_group/toggle_group/hit_rate"] = "_control.type_layer.effect_group.toggle_group.hit_rate",
			["equip_type_layer/type_layer/effect_group"] = "_control.type_layer.effect_group",
			["equip_type_layer/type_layer/btn_series/cancel_btn"] = "_control.type_layer.btn_series.cancel_btn",
			["equip_type_layer/type_layer/effect_group/toggle_group/exp_up/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.exp_up.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/miss/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.miss.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/hit_rate/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.hit_rate.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/bomber/Label"] = "_control.type_layer.type_group.toggle_group.bomber.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/hit_rate/Label"] = "_control.type_layer.effect_group.toggle_group.hit_rate.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/main_gun/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.main_gun.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/miss"] = "_control.type_layer.effect_group.toggle_group.miss",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo_plane/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/all/Background"] = "_control.type_layer.type_group.toggle_group.all.Background",
			["equip_type_layer/type_layer/btn_series/confirm_btn/confirm_mask/txt_2"] = "_control.type_layer.btn_series.confirm_btn.confirm_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group/miss/title_mask"] = "_control.type_layer.effect_group.toggle_group.miss.title_mask",
			["equip_type_layer/type_layer/btn_series"] = "_control.type_layer.btn_series",
			["equip_type_layer/type_layer/effect_group/toggle_group/miss/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.miss.title_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group"] = "_control.type_layer.effect_group.toggle_group",
			["equip_type_layer/type_layer/effect_group/toggle_group/other/Background"] = "_control.type_layer.effect_group.toggle_group.other.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/critical_rate/Background"] = "_control.type_layer.effect_group.toggle_group.critical_rate.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/repairs/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.repairs.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo_plane/title_mask"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo_plane/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/module"] = "_control.type_layer.type_group.toggle_group.module",
			["equip_type_layer/type_layer/effect_group/toggle_group/critical_rate/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.critical_rate.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/critical_rate/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.critical_rate.title_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group/attack/Background"] = "_control.type_layer.effect_group.toggle_group.attack.Background",
			["equip_type_layer/type_layer"] = "_control.type_layer",
			["equip_type_layer/type_layer/effect_group/toggle_group/attack/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.attack.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/critical_rate/Label"] = "_control.type_layer.effect_group.toggle_group.critical_rate.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo/title_mask"] = "_control.type_layer.type_group.toggle_group.torpedo.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/anti_air/Background"] = "_control.type_layer.effect_group.toggle_group.anti_air.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/anti_air/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.anti_air.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/anti_air/title_mask"] = "_control.type_layer.effect_group.toggle_group.anti_air.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/anti_air/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.anti_air.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/anti_air/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.anti_air.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.all.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/anti_air/Label"] = "_control.type_layer.effect_group.toggle_group.anti_air.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/atk_top"] = "_control.type_layer.effect_group.toggle_group.atk_top",
			["equip_type_layer/type_layer/type_group/toggle_group"] = "_control.type_layer.type_group.toggle_group",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.torpedo.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/atk_top/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.atk_top.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/atk_top/title_mask"] = "_control.type_layer.effect_group.toggle_group.atk_top.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/expedition_resource/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.expedition_resource.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/bullet/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.bullet.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/anti_sub/Background"] = "_control.type_layer.type_group.toggle_group.anti_sub.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/atk_top/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.atk_top.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/missile/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.missile.title_mask.txt_2",
			["equip_type_layer/type_layer/effect_group/toggle_group/miss/Label"] = "_control.type_layer.effect_group.toggle_group.miss.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/extra_damage/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.extra_damage.title_mask.txt",
			["equip_type_layer/type_layer/filter_type/sort_title_line"] = "_control.type_layer.filter_type.sort_title_line",
			["equip_type_layer/type_layer/effect_group/toggle_group/expedition_resource"] = "_control.type_layer.effect_group.toggle_group.expedition_resource",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo_plane/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/missile_launcher/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.missile_launcher.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/aagun/Label"] = "_control.type_layer.type_group.toggle_group.aagun.Label",
			["equip_type_layer/type_layer/effect_group/toggle_group/other/title_mask"] = "_control.type_layer.effect_group.toggle_group.other.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/other"] = "_control.type_layer.effect_group.toggle_group.other",
			["equip_type_layer/type_layer/effect_group/toggle_group/exp_up"] = "_control.type_layer.effect_group.toggle_group.exp_up",
			["equip_type_layer/type_layer/effect_group/toggle_group/other/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.other.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/miss/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.miss.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/extra_damage/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.extra_damage.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/missile_launcher/title_mask"] = "_control.type_layer.type_group.toggle_group.missile_launcher.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/critical_rate/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.critical_rate.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/expedition_resource/Background"] = "_control.type_layer.effect_group.toggle_group.expedition_resource.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/missile/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.missile.title_mask.txt",
			["equip_type_layer/type_layer/type_group/toggle_group/repairs/Background"] = "_control.type_layer.type_group.toggle_group.repairs.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/other/Background/Checkmark"] = "_control.type_layer.effect_group.toggle_group.other.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/extra_damage/Background"] = "_control.type_layer.effect_group.toggle_group.extra_damage.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/missile/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.missile.Background.Checkmark",
			["equip_type_layer/type_layer/effect_group/toggle_group/armor_pene"] = "_control.type_layer.effect_group.toggle_group.armor_pene",
			["equip_type_layer/type_layer/type_group/toggle_group/radar"] = "_control.type_layer.type_group.toggle_group.radar",
			["equip_type_layer/type_layer/type_group/toggle_group/radar/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.radar.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/missile/Background"] = "_control.type_layer.type_group.toggle_group.missile.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/missile_launcher/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.missile_launcher.Background.Checkmark",
			["equip_type_layer/type_layer/type_group/toggle_group/main_gun"] = "_control.type_layer.type_group.toggle_group.main_gun",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo_plane/Background"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.Background",
			["equip_type_layer/type_layer/type_group/toggle_group/all"] = "_control.type_layer.type_group.toggle_group.all",
			["equip_type_layer/type_layer/effect_group/toggle_group/attack/title_mask"] = "_control.type_layer.effect_group.toggle_group.attack.title_mask",
			["equip_type_layer/type_layer/effect_group/toggle_group/critical_rate"] = "_control.type_layer.effect_group.toggle_group.critical_rate",
			["equip_type_layer/type_layer/type_group/toggle_group/spy_plane/title_mask/txt"] = "_control.type_layer.type_group.toggle_group.spy_plane.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/expedition_resource/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.expedition_resource.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/all/Label"] = "_control.type_layer.type_group.toggle_group.all.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/main_gun/Background"] = "_control.type_layer.type_group.toggle_group.main_gun.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/armor_pene/Background"] = "_control.type_layer.effect_group.toggle_group.armor_pene.Background",
			["equip_type_layer/type_layer/effect_group/toggle_group/armor_pene/Label"] = "_control.type_layer.effect_group.toggle_group.armor_pene.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/torpedo_plane/Label"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.Label",
			["equip_type_layer/type_layer/type_group/toggle_group/sub_gun"] = "_control.type_layer.type_group.toggle_group.sub_gun",
			["equip_type_layer/type_layer/filter_type/type_txt"] = "_control.type_layer.filter_type.type_txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/extra_damage"] = "_control.type_layer.effect_group.toggle_group.extra_damage",
			["equip_type_layer/type_layer/effect_group/toggle_group/hit_rate/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.hit_rate.title_mask.txt",
			["equip_type_layer/type_layer/effect_group/toggle_group/armor_pene/title_mask/txt"] = "_control.type_layer.effect_group.toggle_group.armor_pene.title_mask.txt",
			["equip_type_layer/type_layer/btn_series/confirm_btn"] = "_control.type_layer.btn_series.confirm_btn",
			["equip_type_layer/type_layer/effect_group/toggle_group/attack/title_mask/txt_2"] = "_control.type_layer.effect_group.toggle_group.attack.title_mask.txt_2",
			["equip_type_layer/type_layer/type_group/toggle_group/spy_plane/title_mask"] = "_control.type_layer.type_group.toggle_group.spy_plane.title_mask",
			["equip_type_layer/type_layer/type_group/toggle_group/sub_gun/title_mask/txt_2"] = "_control.type_layer.type_group.toggle_group.sub_gun.title_mask.txt_2"
		},
		click = {
			type_layer = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/btn_series/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/btn_series/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["type_layer/type_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/main_gun"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/sub_gun"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/torpedo"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/torpedo_plane"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/fighter"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/bomber"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/spy_plane"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/radar"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/module"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/bullet"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/aagun"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/repairs"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/anti_sub"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/missile_launcher"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/type_group/toggle_group/missile"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/attack"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/extra_damage"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/exp_up"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/armor_pene"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/expedition_resource"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/hit_rate"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/miss"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/critical_rate"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/anti_air"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/atk_top"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/effect_group/toggle_group/other"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

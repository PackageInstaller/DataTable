return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					bg_container = {
						path = "bg/bg_container",
						list = {
							blue_top = {
								path = "bg/bg_container/blue_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_cover = {
								path = "bg/bg_container/bg_cover",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							three_point = {
								path = "bg/bg_container/three_point",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							blue_top3 = {
								path = "bg/bg_container/blue_top3",
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
					changestyle = {
						path = "bg/changestyle",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
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
					},
					styleselect = {
						path = "bg/styleselect",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					black_line = {
						path = "bg/black_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					use_btn = {
						path = "bg/use_btn",
						list = {
							use = {
								path = "bg/use_btn/use",
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
					not_use = {
						path = "bg/not_use",
						list = {
							use = {
								path = "bg/not_use/use",
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
					restaurant_bg = {
						path = "bg/restaurant_bg",
						list = {
							tips = {
								path = "bg/restaurant_bg/tips",
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
					scrollview = {
						path = "bg/scrollview",
						list = {
							viewport = {
								path = "bg/scrollview/viewport",
								list = {
									content = {
										path = "bg/scrollview/viewport/content",
										list = {
											style_1 = {
												path = "bg/scrollview/viewport/content/style_1",
												list = {
													lv_1 = {
														path = "bg/scrollview/viewport/content/style_1/lv_1",
														list = {
															grade = {
																path = "bg/scrollview/viewport/content/style_1/lv_1/grade",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															normal = {
																path = "bg/scrollview/viewport/content/style_1/lv_1/normal",
																list = {
																	selected = {
																		path = "bg/scrollview/viewport/content/style_1/lv_1/normal/selected",
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
															black_line = {
																path = "bg/scrollview/viewport/content/style_1/lv_1/black_line",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															lock_txt = {
																path = "bg/scrollview/viewport/content/style_1/lv_1/lock_txt",
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
															"UnityEngine.UI.Toggle",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													lv_2 = {
														path = "bg/scrollview/viewport/content/style_1/lv_2",
														list = {
															grade = {
																path = "bg/scrollview/viewport/content/style_1/lv_2/grade",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															normal = {
																path = "bg/scrollview/viewport/content/style_1/lv_2/normal",
																list = {
																	selected = {
																		path = "bg/scrollview/viewport/content/style_1/lv_2/normal/selected",
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
															black_line = {
																path = "bg/scrollview/viewport/content/style_1/lv_2/black_line",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															lock_txt = {
																path = "bg/scrollview/viewport/content/style_1/lv_2/lock_txt",
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
															"UnityEngine.UI.Toggle",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													lv_3 = {
														path = "bg/scrollview/viewport/content/style_1/lv_3",
														list = {
															grade = {
																path = "bg/scrollview/viewport/content/style_1/lv_3/grade",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															normal = {
																path = "bg/scrollview/viewport/content/style_1/lv_3/normal",
																list = {
																	selected = {
																		path = "bg/scrollview/viewport/content/style_1/lv_3/normal/selected",
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
															lock_txt = {
																path = "bg/scrollview/viewport/content/style_1/lv_3/lock_txt",
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
															"UnityEngine.UI.Toggle",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "bg/scrollview/viewport/content/style_1/title",
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
											style_2 = {
												path = "bg/scrollview/viewport/content/style_2",
												list = {
													lv_1 = {
														path = "bg/scrollview/viewport/content/style_2/lv_1",
														list = {
															grade = {
																path = "bg/scrollview/viewport/content/style_2/lv_1/grade",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															normal = {
																path = "bg/scrollview/viewport/content/style_2/lv_1/normal",
																list = {
																	selected = {
																		path = "bg/scrollview/viewport/content/style_2/lv_1/normal/selected",
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
															lock_txt = {
																path = "bg/scrollview/viewport/content/style_2/lv_1/lock_txt",
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
															"UnityEngine.UI.Toggle",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "bg/scrollview/viewport/content/style_2/title",
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
											style_3 = {
												path = "bg/scrollview/viewport/content/style_3",
												list = {
													lv_1 = {
														path = "bg/scrollview/viewport/content/style_3/lv_1",
														list = {
															grade = {
																path = "bg/scrollview/viewport/content/style_3/lv_1/grade",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															normal = {
																path = "bg/scrollview/viewport/content/style_3/lv_1/normal",
																list = {
																	selected = {
																		path = "bg/scrollview/viewport/content/style_3/lv_1/normal/selected",
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
															black_line = {
																path = "bg/scrollview/viewport/content/style_3/lv_1/black_line",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															lock_txt = {
																path = "bg/scrollview/viewport/content/style_3/lv_1/lock_txt",
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
															"UnityEngine.UI.Toggle",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "bg/scrollview/viewport/content/style_3/title",
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
											"UnityEngine.UI.ToggleGroup"
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
							["Scrollbar Vertical"] = {
								path = "bg/scrollview/Scrollbar Vertical",
								list = {
									["Sliding Area"] = {
										path = "bg/scrollview/Scrollbar Vertical/Sliding Area",
										list = {
											Handle = {
												path = "bg/scrollview/Scrollbar Vertical/Sliding Area/Handle",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			}
		},
		click = {
			["bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/use_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["bg/scrollview/viewport/content/style_1/lv_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/scrollview/viewport/content/style_1/lv_2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/scrollview/viewport/content/style_1/lv_3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/scrollview/viewport/content/style_2/lv_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bg/scrollview/viewport/content/style_3/lv_1"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

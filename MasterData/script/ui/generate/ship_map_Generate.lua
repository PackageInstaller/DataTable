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
			shine = {
				path = "shine",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			top = {
				path = "top",
				list = {
					return_btn = {
						path = "top/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					title_txt = {
						path = "top/title_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line_bg = {
						path = "top/line_bg",
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
			search = {
				path = "search",
				list = {
					Placeholder = {
						path = "search/Placeholder",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					search_txt = {
						path = "search/search_txt",
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
					"UnityEngine.UI.InputField"
				}
			},
			remould_btn = {
				path = "remould_btn",
				list = {
					remould = {
						path = "remould_btn/remould",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					remould_txt = {
						path = "remould_btn/remould_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					remould_txt_mask = {
						path = "remould_btn/remould_txt_mask",
						list = {
							txt = {
								path = "remould_btn/remould_txt_mask/txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							txt_2 = {
								path = "remould_btn/remould_txt_mask/txt_2",
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
			type_btn = {
				path = "type_btn",
				list = {
					type_bg = {
						path = "type_btn/type_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					type = {
						path = "type_btn/type",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					type_txt = {
						path = "type_btn/type_txt",
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
			scrollview_1 = {
				path = "scrollview_1",
				list = {
					left_line_bg = {
						path = "scrollview_1/left_line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					viewport = {
						path = "scrollview_1/viewport",
						list = {
							content = {
								path = "scrollview_1/viewport/content",
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
					},
					scrollbarvertical = {
						path = "scrollview_1/scrollbarvertical",
						list = {
							slidingarea = {
								path = "scrollview_1/scrollbarvertical/slidingarea",
								list = {
									handle = {
										path = "scrollview_1/scrollbarvertical/slidingarea/handle",
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
			},
			scrollview_2 = {
				path = "scrollview_2",
				list = {
					left_line_bg = {
						path = "scrollview_2/left_line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					viewport = {
						path = "scrollview_2/viewport",
						list = {
							content = {
								path = "scrollview_2/viewport/content",
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
					},
					scrollbarvertical = {
						path = "scrollview_2/scrollbarvertical",
						list = {
							slidingarea = {
								path = "scrollview_2/scrollbarvertical/slidingarea",
								list = {
									handle = {
										path = "scrollview_2/scrollbarvertical/slidingarea/handle",
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
			},
			type_layer = {
				path = "type_layer",
				list = {
					bg = {
						path = "type_layer/bg",
						list = {
							line_mid = {
								path = "type_layer/bg/line_mid",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							filter_type = {
								path = "type_layer/bg/filter_type",
								list = {
									sort_title_line = {
										path = "type_layer/bg/filter_type/sort_title_line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									type_txt = {
										path = "type_layer/bg/filter_type/type_txt",
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
								path = "type_layer/bg/btn_series",
								list = {
									confirm_btn = {
										path = "type_layer/bg/btn_series/confirm_btn",
										list = {
											confirm = {
												path = "type_layer/bg/btn_series/confirm_btn/confirm",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											confirm_mask = {
												path = "type_layer/bg/btn_series/confirm_btn/confirm_mask",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.Mask",
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
										path = "type_layer/bg/btn_series/cancel_btn",
										list = {
											cancel = {
												path = "type_layer/bg/btn_series/cancel_btn/cancel",
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
							country_group = {
								path = "type_layer/bg/country_group",
								list = {
									toggle_group = {
										path = "type_layer/bg/country_group/toggle_group",
										list = {
											all = {
												path = "type_layer/bg/country_group/toggle_group/all",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/all/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/all/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/all/Label",
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
											C_country = {
												path = "type_layer/bg/country_group/toggle_group/C_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/C_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/C_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/C_country/Label",
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
											E_country = {
												path = "type_layer/bg/country_group/toggle_group/E_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/E_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/E_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/E_country/Label",
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
											F_country = {
												path = "type_layer/bg/country_group/toggle_group/F_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/F_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/F_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/F_country/Label",
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
											G_country = {
												path = "type_layer/bg/country_group/toggle_group/G_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/G_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/G_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/G_country/Label",
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
											I_country = {
												path = "type_layer/bg/country_group/toggle_group/I_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/I_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/I_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/I_country/Label",
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
											J_country = {
												path = "type_layer/bg/country_group/toggle_group/J_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/J_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/J_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/J_country/Label",
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
											S_country = {
												path = "type_layer/bg/country_group/toggle_group/S_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/S_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/S_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/S_country/Label",
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
											U_country = {
												path = "type_layer/bg/country_group/toggle_group/U_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/U_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/U_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/U_country/Label",
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
											other_country = {
												path = "type_layer/bg/country_group/toggle_group/other_country",
												list = {
													Background = {
														path = "type_layer/bg/country_group/toggle_group/other_country/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/country_group/toggle_group/other_country/Background/Checkmark",
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
														path = "type_layer/bg/country_group/toggle_group/other_country/Label",
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
							},
							type_group = {
								path = "type_layer/bg/type_group",
								list = {
									toggle_group = {
										path = "type_layer/bg/type_group/toggle_group",
										list = {
											all = {
												path = "type_layer/bg/type_group/toggle_group/all",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/all/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/all/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/all/Label",
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
											CV = {
												path = "type_layer/bg/type_group/toggle_group/CV",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CV/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CV/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CV/Label",
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
											CVL = {
												path = "type_layer/bg/type_group/toggle_group/CVL",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CVL/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CVL/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CVL/Label",
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
											AV = {
												path = "type_layer/bg/type_group/toggle_group/AV",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/AV/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/AV/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/AV/Label",
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
											BB = {
												path = "type_layer/bg/type_group/toggle_group/BB",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/BB/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/BB/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/BB/Label",
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
											BBV = {
												path = "type_layer/bg/type_group/toggle_group/BBV",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/BBV/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/BBV/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/BBV/Label",
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
											BC = {
												path = "type_layer/bg/type_group/toggle_group/BC",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/BC/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/BC/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/BC/Label",
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
											CA = {
												path = "type_layer/bg/type_group/toggle_group/CA",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CA/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CA/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CA/Label",
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
											CAV = {
												path = "type_layer/bg/type_group/toggle_group/CAV",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CAV/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CAV/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CAV/Label",
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
											CLT = {
												path = "type_layer/bg/type_group/toggle_group/CLT",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CLT/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CLT/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CLT/Label",
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
											CL = {
												path = "type_layer/bg/type_group/toggle_group/CL",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CL/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CL/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CL/Label",
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
											BM = {
												path = "type_layer/bg/type_group/toggle_group/BM",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/BM/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/BM/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/BM/Label",
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
											DD = {
												path = "type_layer/bg/type_group/toggle_group/DD",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/DD/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/DD/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/DD/Label",
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
											SSG = {
												path = "type_layer/bg/type_group/toggle_group/SSG",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/SSG/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/SSG/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/SSG/Label",
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
											SS = {
												path = "type_layer/bg/type_group/toggle_group/SS",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/SS/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/SS/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/SS/Label",
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
											SC = {
												path = "type_layer/bg/type_group/toggle_group/SC",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/SC/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/SC/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/SC/Label",
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
											AP = {
												path = "type_layer/bg/type_group/toggle_group/AP",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/AP/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/AP/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/AP/Label",
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
											ASDG = {
												path = "type_layer/bg/type_group/toggle_group/ASDG",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/ASDG/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/ASDG/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/ASDG/Label",
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
											AADG = {
												path = "type_layer/bg/type_group/toggle_group/AADG",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/AADG/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/AADG/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/AADG/Label",
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
											KP = {
												path = "type_layer/bg/type_group/toggle_group/KP",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/KP/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/KP/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/KP/Label",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													Label_mask = {
														path = "type_layer/bg/type_group/toggle_group/KP/Label_mask",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Mask",
															"TextHorizonScroller"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Toggle"
												}
											},
											CG = {
												path = "type_layer/bg/type_group/toggle_group/CG",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CG/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CG/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CG/Label",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													Label_mask = {
														path = "type_layer/bg/type_group/toggle_group/CG/Label_mask",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Mask",
															"TextHorizonScroller"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Toggle"
												}
											},
											CBG = {
												path = "type_layer/bg/type_group/toggle_group/CBG",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/CBG/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/CBG/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/CBG/Label",
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
											BBG = {
												path = "type_layer/bg/type_group/toggle_group/BBG",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/BBG/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/BBG/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/BBG/Label",
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
											BG = {
												path = "type_layer/bg/type_group/toggle_group/BG",
												list = {
													Background = {
														path = "type_layer/bg/type_group/toggle_group/BG/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/type_group/toggle_group/BG/Background/Checkmark",
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
														path = "type_layer/bg/type_group/toggle_group/BG/Label",
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
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ToggleGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							size_group = {
								path = "type_layer/bg/size_group",
								list = {
									toggle_group = {
										path = "type_layer/bg/size_group/toggle_group",
										list = {
											all = {
												path = "type_layer/bg/size_group/toggle_group/all",
												list = {
													Background = {
														path = "type_layer/bg/size_group/toggle_group/all/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/size_group/toggle_group/all/Background/Checkmark",
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
														path = "type_layer/bg/size_group/toggle_group/all/Label",
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
											large = {
												path = "type_layer/bg/size_group/toggle_group/large",
												list = {
													Background = {
														path = "type_layer/bg/size_group/toggle_group/large/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/size_group/toggle_group/large/Background/Checkmark",
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
														path = "type_layer/bg/size_group/toggle_group/large/Label",
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
											middle = {
												path = "type_layer/bg/size_group/toggle_group/middle",
												list = {
													Background = {
														path = "type_layer/bg/size_group/toggle_group/middle/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/size_group/toggle_group/middle/Background/Checkmark",
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
														path = "type_layer/bg/size_group/toggle_group/middle/Label",
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
											small = {
												path = "type_layer/bg/size_group/toggle_group/small",
												list = {
													Background = {
														path = "type_layer/bg/size_group/toggle_group/small/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/size_group/toggle_group/small/Background/Checkmark",
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
														path = "type_layer/bg/size_group/toggle_group/small/Label",
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
											maip = {
												path = "type_layer/bg/size_group/toggle_group/maip",
												list = {
													Background = {
														path = "type_layer/bg/size_group/toggle_group/maip/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/size_group/toggle_group/maip/Background/Checkmark",
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
														path = "type_layer/bg/size_group/toggle_group/maip/Label",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													Label_mask = {
														path = "type_layer/bg/size_group/toggle_group/maip/Label_mask",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Mask",
															"TextHorizonScroller"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Toggle"
												}
											},
											protect = {
												path = "type_layer/bg/size_group/toggle_group/protect",
												list = {
													Background = {
														path = "type_layer/bg/size_group/toggle_group/protect/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/size_group/toggle_group/protect/Background/Checkmark",
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
														path = "type_layer/bg/size_group/toggle_group/protect/Label",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													Label_mask = {
														path = "type_layer/bg/size_group/toggle_group/protect/Label_mask",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Mask",
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
							own_group = {
								path = "type_layer/bg/own_group",
								list = {
									toggle_group = {
										path = "type_layer/bg/own_group/toggle_group",
										list = {
											all = {
												path = "type_layer/bg/own_group/toggle_group/all",
												list = {
													Background = {
														path = "type_layer/bg/own_group/toggle_group/all/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/own_group/toggle_group/all/Background/Checkmark",
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
														path = "type_layer/bg/own_group/toggle_group/all/Label",
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
											own_type = {
												path = "type_layer/bg/own_group/toggle_group/own_type",
												list = {
													Background = {
														path = "type_layer/bg/own_group/toggle_group/own_type/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/own_group/toggle_group/own_type/Background/Checkmark",
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
														path = "type_layer/bg/own_group/toggle_group/own_type/Label",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													Label_mask = {
														path = "type_layer/bg/own_group/toggle_group/own_type/Label_mask",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image",
															"UnityEngine.UI.Mask",
															"TextHorizonScroller"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.Toggle"
												}
											},
											not_own_type = {
												path = "type_layer/bg/own_group/toggle_group/not_own_type",
												list = {
													Background = {
														path = "type_layer/bg/own_group/toggle_group/not_own_type/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/own_group/toggle_group/not_own_type/Background/Checkmark",
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
														path = "type_layer/bg/own_group/toggle_group/not_own_type/Label",
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
											not_get_type = {
												path = "type_layer/bg/own_group/toggle_group/not_get_type",
												list = {
													Background = {
														path = "type_layer/bg/own_group/toggle_group/not_get_type/Background",
														list = {
															Checkmark = {
																path = "type_layer/bg/own_group/toggle_group/not_get_type/Background/Checkmark",
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
														path = "type_layer/bg/own_group/toggle_group/not_get_type/Label",
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
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ToggleGroup"
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
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["ship_map/type_layer/bg/type_group/toggle_group/BBG"] = "_control.type_layer.bg.type_group.toggle_group.BBG",
			["ship_map/type_layer/bg/type_group/toggle_group/CAV/Background"] = "_control.type_layer.bg.type_group.toggle_group.CAV.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/BC/Label"] = "_control.type_layer.bg.type_group.toggle_group.BC.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/SS"] = "_control.type_layer.bg.type_group.toggle_group.SS",
			["ship_map/type_layer/bg/type_group/toggle_group/CA/Background"] = "_control.type_layer.bg.type_group.toggle_group.CA.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/BC/Background"] = "_control.type_layer.bg.type_group.toggle_group.BC.Background",
			["ship_map/type_layer/bg/size_group/toggle_group/large/Label"] = "_control.type_layer.bg.size_group.toggle_group.large.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/BBV/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.BBV.Background.Checkmark",
			["ship_map/remould_btn"] = "_control.remould_btn",
			["ship_map/type_layer/bg/type_group/toggle_group/BBV/Background"] = "_control.type_layer.bg.type_group.toggle_group.BBV.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/BB/Label"] = "_control.type_layer.bg.type_group.toggle_group.BB.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/BB/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.BB.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/BB/Background"] = "_control.type_layer.bg.type_group.toggle_group.BB.Background",
			["ship_map/type_layer/bg/country_group/toggle_group/S_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.S_country.Background",
			["ship_map/scrollview_2/viewport/content"] = "_control.scrollview_2.viewport.content",
			["ship_map/type_layer/bg/country_group/toggle_group/F_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.F_country.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/AV/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.AV.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/AV/Background"] = "_control.type_layer.bg.type_group.toggle_group.AV.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/CLT/Background"] = "_control.type_layer.bg.type_group.toggle_group.CLT.Background",
			["ship_map/bg"] = "_control.bg",
			["ship_map/type_layer/bg/type_group/toggle_group/CVL/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CVL.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/CVL/Background"] = "_control.type_layer.bg.type_group.toggle_group.CVL.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/CBG"] = "_control.type_layer.bg.type_group.toggle_group.CBG",
			["ship_map/scrollview_1/left_line_bg"] = "_control.scrollview_1.left_line_bg",
			["ship_map/type_layer/bg/country_group/toggle_group/E_country"] = "_control.type_layer.bg.country_group.toggle_group.E_country",
			["ship_map/type_layer/bg/type_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.all.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/all/Background"] = "_control.type_layer.bg.type_group.toggle_group.all.Background",
			["ship_map/type_layer/bg/country_group/toggle_group/F_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.F_country.Label",
			["ship_map/type_layer/bg/own_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.bg.own_group.toggle_group.all.Background.Checkmark",
			["ship_map/type_layer/bg/country_group/toggle_group/U_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.U_country.Label",
			["ship_map/remould_btn/remould"] = "_control.remould_btn.remould",
			["ship_map/type_layer/bg/btn_series/cancel_btn"] = "_control.type_layer.bg.btn_series.cancel_btn",
			["ship_map/type_layer/bg/country_group/toggle_group/U_country"] = "_control.type_layer.bg.country_group.toggle_group.U_country",
			["ship_map/type_layer/bg/own_group/toggle_group/not_own_type/Label"] = "_control.type_layer.bg.own_group.toggle_group.not_own_type.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/S_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.S_country.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/CV/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CV.Background.Checkmark",
			["ship_map/type_btn/type_txt"] = "_control.type_btn.type_txt",
			["ship_map/type_layer/bg/country_group/toggle_group/other_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.other_country.Background",
			["ship_map/type_layer/bg/line_mid"] = "_control.type_layer.bg.line_mid",
			["ship_map/top/line_bg"] = "_control.top.line_bg",
			["ship_map/type_layer/bg/country_group/toggle_group/J_country"] = "_control.type_layer.bg.country_group.toggle_group.J_country",
			["ship_map/type_layer/bg/type_group/toggle_group/CG"] = "_control.type_layer.bg.type_group.toggle_group.CG",
			["ship_map/type_layer/bg/country_group/toggle_group/I_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.I_country.Background",
			["ship_map/type_layer/bg/btn_series/confirm_btn"] = "_control.type_layer.bg.btn_series.confirm_btn",
			["ship_map/type_layer/bg/country_group/toggle_group/J_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.J_country.Background",
			["ship_map/type_layer/bg/country_group/toggle_group/J_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.J_country.Background.Checkmark",
			["ship_map/type_layer/bg/country_group/toggle_group/I_country"] = "_control.type_layer.bg.country_group.toggle_group.I_country",
			["ship_map/top"] = "_control.top",
			["ship_map/type_layer/bg/country_group/toggle_group/G_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.G_country.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/G_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.G_country.Background.Checkmark",
			["ship_map/type_layer/bg/country_group/toggle_group/G_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.G_country.Background",
			["ship_map/remould_btn/remould_txt_mask/txt"] = "_control.remould_btn.remould_txt_mask.txt",
			["ship_map/type_layer/bg/country_group/toggle_group/U_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.U_country.Background",
			["ship_map/type_layer/bg/country_group/toggle_group/U_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.U_country.Background.Checkmark",
			["ship_map/type_layer/bg/country_group/toggle_group/E_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.E_country.Label",
			["ship_map/type_layer"] = "_control.type_layer",
			["ship_map/type_layer/bg/type_group/toggle_group/CAV/Label"] = "_control.type_layer.bg.type_group.toggle_group.CAV.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/I_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.I_country.Background.Checkmark",
			["ship_map/scrollview_1/scrollbarvertical/slidingarea"] = "_control.scrollview_1.scrollbarvertical.slidingarea",
			["ship_map/type_layer/bg/country_group/toggle_group/C_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.C_country.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/all/Background"] = "_control.type_layer.bg.country_group.toggle_group.all.Background",
			["ship_map/scrollview_2/left_line_bg"] = "_control.scrollview_2.left_line_bg",
			["ship_map/type_layer/bg/country_group/toggle_group/S_country"] = "_control.type_layer.bg.country_group.toggle_group.S_country",
			["ship_map/type_layer/bg/size_group/toggle_group/large/Background"] = "_control.type_layer.bg.size_group.toggle_group.large.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/CVL/Label"] = "_control.type_layer.bg.type_group.toggle_group.CVL.Label",
			["ship_map/type_layer/bg/own_group/toggle_group/all/Label"] = "_control.type_layer.bg.own_group.toggle_group.all.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/C_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.C_country.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/ASDG/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.ASDG.Background.Checkmark",
			["ship_map/type_layer/bg/country_group/toggle_group/S_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.S_country.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/F_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.F_country.Background",
			["ship_map/scrollview_1/scrollbarvertical"] = "_control.scrollview_1.scrollbarvertical",
			["ship_map/type_layer/bg/type_group/toggle_group/CLT"] = "_control.type_layer.bg.type_group.toggle_group.CLT",
			["ship_map/type_layer/bg/country_group/toggle_group/C_country"] = "_control.type_layer.bg.country_group.toggle_group.C_country",
			["ship_map/scrollview_2/scrollbarvertical/slidingarea/handle"] = "_control.scrollview_2.scrollbarvertical.slidingarea.handle",
			["ship_map/type_layer/bg/filter_type/sort_title_line"] = "_control.type_layer.bg.filter_type.sort_title_line",
			["ship_map/type_layer/bg/country_group/toggle_group/all/Label"] = "_control.type_layer.bg.country_group.toggle_group.all.Label",
			["ship_map/type_layer/bg/size_group/toggle_group/all"] = "_control.type_layer.bg.size_group.toggle_group.all",
			["ship_map/top/return_btn"] = "_control.top.return_btn",
			["ship_map/type_layer/bg/country_group/toggle_group/other_country"] = "_control.type_layer.bg.country_group.toggle_group.other_country",
			["ship_map/type_layer/bg/type_group/toggle_group/CV/Background"] = "_control.type_layer.bg.type_group.toggle_group.CV.Background",
			["ship_map/type_layer/bg/country_group/toggle_group/E_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.E_country.Background",
			["ship_map/type_layer/bg/country_group/toggle_group/E_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.E_country.Background.Checkmark",
			["ship_map/scrollview_1/viewport"] = "_control.scrollview_1.viewport",
			["ship_map/type_layer/bg/type_group/toggle_group/CLT/Label"] = "_control.type_layer.bg.type_group.toggle_group.CLT.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/CL"] = "_control.type_layer.bg.type_group.toggle_group.CL",
			["ship_map/type_layer/bg/own_group/toggle_group/own_type/Label_mask"] = "_control.type_layer.bg.own_group.toggle_group.own_type.Label_mask",
			["ship_map/type_layer/bg/type_group/toggle_group/CL/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CL.Background.Checkmark",
			["ship_map/remould_btn/remould_txt_mask/txt_2"] = "_control.remould_btn.remould_txt_mask.txt_2",
			["ship_map/type_layer/bg/country_group/toggle_group"] = "_control.type_layer.bg.country_group.toggle_group",
			["ship_map/type_layer/bg/type_group/toggle_group/CL/Label"] = "_control.type_layer.bg.type_group.toggle_group.CL.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/all"] = "_control.type_layer.bg.type_group.toggle_group.all",
			["ship_map/type_layer/bg/own_group/toggle_group/all/Background"] = "_control.type_layer.bg.own_group.toggle_group.all.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/BM/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.BM.Background.Checkmark",
			["ship_map/type_layer/bg/btn_series/confirm_btn/confirm_mask"] = "_control.type_layer.bg.btn_series.confirm_btn.confirm_mask",
			["ship_map/search/search_txt"] = "_control.search.search_txt",
			["ship_map/type_layer/bg/type_group/toggle_group/BM/Label"] = "_control.type_layer.bg.type_group.toggle_group.BM.Label",
			["ship_map/shine"] = "_control.shine",
			["ship_map/type_layer/bg/own_group/toggle_group"] = "_control.type_layer.bg.own_group.toggle_group",
			["ship_map/type_layer/bg/type_group/toggle_group"] = "_control.type_layer.bg.type_group.toggle_group",
			["ship_map/type_layer/bg/type_group/toggle_group/DD/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.DD.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/DD/Label"] = "_control.type_layer.bg.type_group.toggle_group.DD.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/SSG/Background"] = "_control.type_layer.bg.type_group.toggle_group.SSG.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/CLT/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CLT.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/SSG/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.SSG.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/SSG/Label"] = "_control.type_layer.bg.type_group.toggle_group.SSG.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/KP"] = "_control.type_layer.bg.type_group.toggle_group.KP",
			["ship_map/type_layer/bg/own_group/toggle_group/all"] = "_control.type_layer.bg.own_group.toggle_group.all",
			["ship_map/type_layer/bg/type_group/toggle_group/SS/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.SS.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/SS/Label"] = "_control.type_layer.bg.type_group.toggle_group.SS.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/SC/Background"] = "_control.type_layer.bg.type_group.toggle_group.SC.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/SC/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.SC.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/SC/Label"] = "_control.type_layer.bg.type_group.toggle_group.SC.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/AP/Background"] = "_control.type_layer.bg.type_group.toggle_group.AP.Background",
			["ship_map/type_layer/bg/btn_series/confirm_btn/confirm"] = "_control.type_layer.bg.btn_series.confirm_btn.confirm",
			["ship_map/type_layer/bg/type_group/toggle_group/AV"] = "_control.type_layer.bg.type_group.toggle_group.AV",
			["ship_map/type_layer/bg/type_group/toggle_group/AP/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.AP.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/AP/Label"] = "_control.type_layer.bg.type_group.toggle_group.AP.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/ASDG/Background"] = "_control.type_layer.bg.type_group.toggle_group.ASDG.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/AV/Label"] = "_control.type_layer.bg.type_group.toggle_group.AV.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/BBV"] = "_control.type_layer.bg.type_group.toggle_group.BBV",
			["ship_map/type_layer/bg/type_group/toggle_group/AADG/Background"] = "_control.type_layer.bg.type_group.toggle_group.AADG.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/AADG/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.AADG.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/AADG/Label"] = "_control.type_layer.bg.type_group.toggle_group.AADG.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/BC/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.BC.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/CAV"] = "_control.type_layer.bg.type_group.toggle_group.CAV",
			["ship_map/type_layer/bg/own_group/toggle_group/not_own_type/Background"] = "_control.type_layer.bg.own_group.toggle_group.not_own_type.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/KP/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.KP.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/KP/Label"] = "_control.type_layer.bg.type_group.toggle_group.KP.Label",
			["ship_map/scrollview_2/viewport"] = "_control.scrollview_2.viewport",
			["ship_map/scrollview_1/viewport/content"] = "_control.scrollview_1.viewport.content",
			["ship_map/type_layer/bg/country_group/toggle_group/I_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.I_country.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/CG/Background"] = "_control.type_layer.bg.type_group.toggle_group.CG.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/CG/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CG.Background.Checkmark",
			["ship_map/type_layer/bg/country_group"] = "_control.type_layer.bg.country_group",
			["ship_map/type_layer/bg/type_group/toggle_group/CA"] = "_control.type_layer.bg.type_group.toggle_group.CA",
			["ship_map/type_layer/bg/type_group/toggle_group/CG/Label"] = "_control.type_layer.bg.type_group.toggle_group.CG.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/CG/Label_mask"] = "_control.type_layer.bg.type_group.toggle_group.CG.Label_mask",
			["ship_map/type_layer/bg/type_group/toggle_group/CV/Label"] = "_control.type_layer.bg.type_group.toggle_group.CV.Label",
			["ship_map/remould_btn/remould_txt_mask"] = "_control.remould_btn.remould_txt_mask",
			["ship_map/type_layer/bg/type_group/toggle_group/CBG/Background"] = "_control.type_layer.bg.type_group.toggle_group.CBG.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/CBG/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CBG.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/CBG/Label"] = "_control.type_layer.bg.type_group.toggle_group.CBG.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/CAV/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CAV.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/BBG/Background"] = "_control.type_layer.bg.type_group.toggle_group.BBG.Background",
			["ship_map/type_layer/bg/country_group/toggle_group/F_country"] = "_control.type_layer.bg.country_group.toggle_group.F_country",
			["ship_map/type_layer/bg/type_group/toggle_group/BBG/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.BBG.Background.Checkmark",
			["ship_map/type_btn"] = "_control.type_btn",
			["ship_map/type_layer/bg/type_group/toggle_group/BBG/Label"] = "_control.type_layer.bg.type_group.toggle_group.BBG.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/CV"] = "_control.type_layer.bg.type_group.toggle_group.CV",
			["ship_map/type_layer/bg/type_group/toggle_group/BG"] = "_control.type_layer.bg.type_group.toggle_group.BG",
			["ship_map/type_layer/bg/type_group/toggle_group/BG/Background"] = "_control.type_layer.bg.type_group.toggle_group.BG.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/BG/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.BG.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/BG/Label"] = "_control.type_layer.bg.type_group.toggle_group.BG.Label",
			["ship_map/type_layer/bg/size_group"] = "_control.type_layer.bg.size_group",
			["ship_map/type_layer/bg/size_group/toggle_group/protect"] = "_control.type_layer.bg.size_group.toggle_group.protect",
			["ship_map/type_layer/bg/country_group/toggle_group/C_country/Background"] = "_control.type_layer.bg.country_group.toggle_group.C_country.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/BM"] = "_control.type_layer.bg.type_group.toggle_group.BM",
			["ship_map/remould_btn/remould_txt"] = "_control.remould_btn.remould_txt",
			["ship_map/type_layer/bg/type_group"] = "_control.type_layer.bg.type_group",
			["ship_map/type_layer/bg/size_group/toggle_group/all/Background"] = "_control.type_layer.bg.size_group.toggle_group.all.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/BC"] = "_control.type_layer.bg.type_group.toggle_group.BC",
			["ship_map/type_layer/bg/size_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.bg.size_group.toggle_group.all.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/SC"] = "_control.type_layer.bg.type_group.toggle_group.SC",
			["ship_map/type_layer/bg/size_group/toggle_group/all/Label"] = "_control.type_layer.bg.size_group.toggle_group.all.Label",
			["ship_map/type_layer/bg/size_group/toggle_group/large"] = "_control.type_layer.bg.size_group.toggle_group.large",
			["ship_map/type_btn/type"] = "_control.type_btn.type",
			["ship_map/type_layer/bg/size_group/toggle_group/large/Background/Checkmark"] = "_control.type_layer.bg.size_group.toggle_group.large.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/BBV/Label"] = "_control.type_layer.bg.type_group.toggle_group.BBV.Label",
			["ship_map/type_layer/bg"] = "_control.type_layer.bg",
			["ship_map/type_layer/bg/size_group/toggle_group/middle"] = "_control.type_layer.bg.size_group.toggle_group.middle",
			["ship_map/type_layer/bg/type_group/toggle_group/BB"] = "_control.type_layer.bg.type_group.toggle_group.BB",
			["ship_map/type_layer/bg/size_group/toggle_group/middle/Background"] = "_control.type_layer.bg.size_group.toggle_group.middle.Background",
			["ship_map/type_layer/bg/size_group/toggle_group/middle/Background/Checkmark"] = "_control.type_layer.bg.size_group.toggle_group.middle.Background.Checkmark",
			["ship_map/type_layer/bg/size_group/toggle_group/middle/Label"] = "_control.type_layer.bg.size_group.toggle_group.middle.Label",
			["ship_map/type_layer/bg/own_group"] = "_control.type_layer.bg.own_group",
			["ship_map/scrollview_2/scrollbarvertical/slidingarea"] = "_control.scrollview_2.scrollbarvertical.slidingarea",
			["ship_map/type_layer/bg/size_group/toggle_group/small/Background/Checkmark"] = "_control.type_layer.bg.size_group.toggle_group.small.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/CA/Label"] = "_control.type_layer.bg.type_group.toggle_group.CA.Label",
			["ship_map/scrollview_2/scrollbarvertical"] = "_control.scrollview_2.scrollbarvertical",
			["ship_map/type_layer/bg/size_group/toggle_group/small/Label"] = "_control.type_layer.bg.size_group.toggle_group.small.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/CA/Background/Checkmark"] = "_control.type_layer.bg.type_group.toggle_group.CA.Background.Checkmark",
			["ship_map/type_layer/bg/size_group/toggle_group/maip"] = "_control.type_layer.bg.size_group.toggle_group.maip",
			["ship_map/top/title_txt"] = "_control.top.title_txt",
			["ship_map/type_layer/bg/size_group/toggle_group/maip/Background"] = "_control.type_layer.bg.size_group.toggle_group.maip.Background",
			["ship_map/type_layer/bg/own_group/toggle_group/own_type"] = "_control.type_layer.bg.own_group.toggle_group.own_type",
			["ship_map/type_btn/type_bg"] = "_control.type_btn.type_bg",
			["ship_map/type_layer/bg/country_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.all.Background.Checkmark",
			["ship_map/type_layer/bg/size_group/toggle_group/maip/Label"] = "_control.type_layer.bg.size_group.toggle_group.maip.Label",
			["ship_map/type_layer/bg/size_group/toggle_group/maip/Label_mask"] = "_control.type_layer.bg.size_group.toggle_group.maip.Label_mask",
			["ship_map/scrollview_1/scrollbarvertical/slidingarea/handle"] = "_control.scrollview_1.scrollbarvertical.slidingarea.handle",
			["ship_map/type_layer/bg/size_group/toggle_group"] = "_control.type_layer.bg.size_group.toggle_group",
			["ship_map/type_layer/bg/size_group/toggle_group/small"] = "_control.type_layer.bg.size_group.toggle_group.small",
			["ship_map/type_layer/bg/size_group/toggle_group/protect/Background/Checkmark"] = "_control.type_layer.bg.size_group.toggle_group.protect.Background.Checkmark",
			["ship_map/type_layer/bg/size_group/toggle_group/protect/Label"] = "_control.type_layer.bg.size_group.toggle_group.protect.Label",
			["ship_map/type_layer/bg/size_group/toggle_group/protect/Label_mask"] = "_control.type_layer.bg.size_group.toggle_group.protect.Label_mask",
			["ship_map/type_layer/bg/size_group/toggle_group/small/Background"] = "_control.type_layer.bg.size_group.toggle_group.small.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/DD/Background"] = "_control.type_layer.bg.type_group.toggle_group.DD.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/SS/Background"] = "_control.type_layer.bg.type_group.toggle_group.SS.Background",
			["ship_map/type_layer/bg/filter_type"] = "_control.type_layer.bg.filter_type",
			["ship_map/type_layer/bg/type_group/toggle_group/BM/Background"] = "_control.type_layer.bg.type_group.toggle_group.BM.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/DD"] = "_control.type_layer.bg.type_group.toggle_group.DD",
			["ship_map/type_layer/bg/country_group/toggle_group/J_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.J_country.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/G_country"] = "_control.type_layer.bg.country_group.toggle_group.G_country",
			["ship_map/type_layer/bg/size_group/toggle_group/maip/Background/Checkmark"] = "_control.type_layer.bg.size_group.toggle_group.maip.Background.Checkmark",
			["ship_map/type_layer/bg/own_group/toggle_group/own_type/Background"] = "_control.type_layer.bg.own_group.toggle_group.own_type.Background",
			["ship_map/type_layer/bg/own_group/toggle_group/own_type/Background/Checkmark"] = "_control.type_layer.bg.own_group.toggle_group.own_type.Background.Checkmark",
			["ship_map/type_layer/bg/size_group/toggle_group/protect/Background"] = "_control.type_layer.bg.size_group.toggle_group.protect.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/AP"] = "_control.type_layer.bg.type_group.toggle_group.AP",
			["ship_map/type_layer/bg/own_group/toggle_group/own_type/Label"] = "_control.type_layer.bg.own_group.toggle_group.own_type.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/CL/Background"] = "_control.type_layer.bg.type_group.toggle_group.CL.Background",
			["ship_map/scrollview_2"] = "_control.scrollview_2",
			["ship_map/type_layer/bg/own_group/toggle_group/not_own_type"] = "_control.type_layer.bg.own_group.toggle_group.not_own_type",
			["ship_map/scrollview_1"] = "_control.scrollview_1",
			["ship_map/type_layer/bg/type_group/toggle_group/KP/Background"] = "_control.type_layer.bg.type_group.toggle_group.KP.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/all/Label"] = "_control.type_layer.bg.type_group.toggle_group.all.Label",
			["ship_map/type_layer/bg/country_group/toggle_group/other_country/Label"] = "_control.type_layer.bg.country_group.toggle_group.other_country.Label",
			["ship_map/type_layer/bg/type_group/toggle_group/AADG"] = "_control.type_layer.bg.type_group.toggle_group.AADG",
			["ship_map/type_layer/bg/own_group/toggle_group/not_get_type"] = "_control.type_layer.bg.own_group.toggle_group.not_get_type",
			["ship_map/type_layer/bg/own_group/toggle_group/not_get_type/Background"] = "_control.type_layer.bg.own_group.toggle_group.not_get_type.Background",
			["ship_map/type_layer/bg/type_group/toggle_group/ASDG"] = "_control.type_layer.bg.type_group.toggle_group.ASDG",
			["ship_map/type_layer/bg/filter_type/type_txt"] = "_control.type_layer.bg.filter_type.type_txt",
			["ship_map/type_layer/bg/own_group/toggle_group/not_get_type/Background/Checkmark"] = "_control.type_layer.bg.own_group.toggle_group.not_get_type.Background.Checkmark",
			["ship_map/type_layer/bg/own_group/toggle_group/not_get_type/Label"] = "_control.type_layer.bg.own_group.toggle_group.not_get_type.Label",
			["ship_map/search/Placeholder"] = "_control.search.Placeholder",
			["ship_map/type_layer/bg/type_group/toggle_group/ASDG/Label"] = "_control.type_layer.bg.type_group.toggle_group.ASDG.Label",
			["ship_map/type_layer/bg/own_group/toggle_group/not_own_type/Background/Checkmark"] = "_control.type_layer.bg.own_group.toggle_group.not_own_type.Background.Checkmark",
			["ship_map/type_layer/bg/country_group/toggle_group/all"] = "_control.type_layer.bg.country_group.toggle_group.all",
			["ship_map/type_layer/bg/btn_series"] = "_control.type_layer.bg.btn_series",
			["ship_map/type_layer/bg/type_group/toggle_group/CVL"] = "_control.type_layer.bg.type_group.toggle_group.CVL",
			["ship_map/search"] = "_control.search",
			["ship_map/type_layer/bg/country_group/toggle_group/other_country/Background/Checkmark"] = "_control.type_layer.bg.country_group.toggle_group.other_country.Background.Checkmark",
			["ship_map/type_layer/bg/type_group/toggle_group/SSG"] = "_control.type_layer.bg.type_group.toggle_group.SSG",
			["ship_map/type_layer/bg/btn_series/cancel_btn/cancel"] = "_control.type_layer.bg.btn_series.cancel_btn.cancel",
			["ship_map/type_layer/bg/type_group/toggle_group/KP/Label_mask"] = "_control.type_layer.bg.type_group.toggle_group.KP.Label_mask"
		},
		click = {
			["top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			remould_btn = {
				tp = "UnityEngine.UI.Button"
			},
			type_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/bg/btn_series/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["type_layer/bg/btn_series/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["type_layer/bg/country_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/C_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/E_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/F_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/G_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/I_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/J_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/S_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/U_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/country_group/toggle_group/other_country"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CVL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/AV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/BB"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/BBV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/BC"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CA"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CAV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CLT"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/BM"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/DD"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/SSG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/SS"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/SC"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/AP"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/ASDG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/AADG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/KP"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/CBG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/BBG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/type_group/toggle_group/BG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/size_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/size_group/toggle_group/large"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/size_group/toggle_group/middle"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/size_group/toggle_group/small"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/size_group/toggle_group/maip"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/size_group/toggle_group/protect"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/own_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/own_group/toggle_group/own_type"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/own_group/toggle_group/not_own_type"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/bg/own_group/toggle_group/not_get_type"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

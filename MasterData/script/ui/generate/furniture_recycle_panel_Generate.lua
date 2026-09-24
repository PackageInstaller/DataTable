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
			bottomline = {
				path = "bottomline",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			top_layer = {
				path = "top_layer",
				list = {
					upline = {
						path = "top_layer/upline",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					returnbtn = {
						path = "top_layer/returnbtn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					title = {
						path = "top_layer/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					point = {
						path = "top_layer/point",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					des = {
						path = "top_layer/des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					fur_num = {
						path = "top_layer/fur_num",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					upline_corner = {
						path = "top_layer/upline_corner",
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
			scrollview = {
				path = "scrollview",
				list = {
					viewport = {
						path = "scrollview/viewport",
						list = {
							content = {
								path = "scrollview/viewport/content",
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
							"UnityEngine.UI.Mask",
							"UnityEngine.UI.Image"
						}
					},
					scrollbarvertical = {
						path = "scrollview/scrollbarvertical",
						list = {
							slidingarea = {
								path = "scrollview/scrollbarvertical/slidingarea",
								list = {
									handle = {
										path = "scrollview/scrollbarvertical/slidingarea/handle",
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
					"UnityEngine.UI.ScrollRect"
				}
			},
			res_node = {
				path = "res_node",
				list = {
					diamond_num = {
						path = "res_node/diamond_num",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					icon = {
						path = "res_node/icon",
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
			furniture_layer = {
				path = "furniture_layer",
				list = {
					black_line = {
						path = "furniture_layer/black_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					furniture_des = {
						path = "furniture_layer/furniture_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					amount_txt = {
						path = "furniture_layer/amount_txt",
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
			order_layer = {
				path = "order_layer",
				list = {
					des = {
						path = "order_layer/des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					icon = {
						path = "order_layer/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					type_des = {
						path = "order_layer/type_des",
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
			type_layer = {
				path = "type_layer",
				list = {
					des = {
						path = "type_layer/des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					icon = {
						path = "type_layer/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					type_des = {
						path = "type_layer/type_des",
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
			confirm_btn = {
				path = "confirm_btn",
				list = {
					des = {
						path = "confirm_btn/des",
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
			fast_choose_btn = {
				path = "fast_choose_btn",
				list = {
					des = {
						path = "fast_choose_btn/des",
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
			order_layer_detail = {
				path = "order_layer_detail",
				list = {
					parent = {
						path = "order_layer_detail/parent",
						list = {
							toggle_group = {
								path = "order_layer_detail/parent/toggle_group",
								list = {
									to_1 = {
										path = "order_layer_detail/parent/toggle_group/to_1",
										list = {
											Background = {
												path = "order_layer_detail/parent/toggle_group/to_1/Background",
												list = {
													Checkmark = {
														path = "order_layer_detail/parent/toggle_group/to_1/Background/Checkmark",
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
												path = "order_layer_detail/parent/toggle_group/to_1/Label",
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
									to_2 = {
										path = "order_layer_detail/parent/toggle_group/to_2",
										list = {
											Background = {
												path = "order_layer_detail/parent/toggle_group/to_2/Background",
												list = {
													Checkmark = {
														path = "order_layer_detail/parent/toggle_group/to_2/Background/Checkmark",
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
												path = "order_layer_detail/parent/toggle_group/to_2/Label",
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
									to_3 = {
										path = "order_layer_detail/parent/toggle_group/to_3",
										list = {
											Background = {
												path = "order_layer_detail/parent/toggle_group/to_3/Background",
												list = {
													Checkmark = {
														path = "order_layer_detail/parent/toggle_group/to_3/Background/Checkmark",
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
												path = "order_layer_detail/parent/toggle_group/to_3/Label",
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
									to_4 = {
										path = "order_layer_detail/parent/toggle_group/to_4",
										list = {
											Background = {
												path = "order_layer_detail/parent/toggle_group/to_4/Background",
												list = {
													Checkmark = {
														path = "order_layer_detail/parent/toggle_group/to_4/Background/Checkmark",
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
												path = "order_layer_detail/parent/toggle_group/to_4/Label",
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
									to_5 = {
										path = "order_layer_detail/parent/toggle_group/to_5",
										list = {
											Background = {
												path = "order_layer_detail/parent/toggle_group/to_5/Background",
												list = {
													Checkmark = {
														path = "order_layer_detail/parent/toggle_group/to_5/Background/Checkmark",
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
												path = "order_layer_detail/parent/toggle_group/to_5/Label",
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
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UITweenSequence"
				}
			},
			type_layer_detail = {
				path = "type_layer_detail",
				list = {
					parent = {
						path = "type_layer_detail/parent",
						list = {
							toggle_group = {
								path = "type_layer_detail/parent/toggle_group",
								list = {
									ALL = {
										path = "type_layer_detail/parent/toggle_group/ALL",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/ALL/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/ALL/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/ALL/Label",
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
										path = "type_layer_detail/parent/toggle_group/CV",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/CV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/CV/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/CV/Label",
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
										path = "type_layer_detail/parent/toggle_group/CVL",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/CVL/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/CVL/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/CVL/Label",
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
										path = "type_layer_detail/parent/toggle_group/AV",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/AV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/AV/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/AV/Label",
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
										path = "type_layer_detail/parent/toggle_group/BB",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/BB/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/BB/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/BB/Label",
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
										path = "type_layer_detail/parent/toggle_group/BBV",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/BBV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/BBV/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/BBV/Label",
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
										path = "type_layer_detail/parent/toggle_group/BC",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/BC/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/BC/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/BC/Label",
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
										path = "type_layer_detail/parent/toggle_group/CA",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/CA/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/CA/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/CA/Label",
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
										path = "type_layer_detail/parent/toggle_group/CAV",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/CAV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/CAV/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/CAV/Label",
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
										path = "type_layer_detail/parent/toggle_group/CLT",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/CLT/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/CLT/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/CLT/Label",
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
										path = "type_layer_detail/parent/toggle_group/CL",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/CL/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/CL/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/CL/Label",
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
										path = "type_layer_detail/parent/toggle_group/BM",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/BM/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/BM/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/BM/Label",
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
										path = "type_layer_detail/parent/toggle_group/DD",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/DD/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/DD/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/DD/Label",
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
										path = "type_layer_detail/parent/toggle_group/SSG",
										list = {
											Background = {
												path = "type_layer_detail/parent/toggle_group/SSG/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/parent/toggle_group/SSG/Background/Checkmark",
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
												path = "type_layer_detail/parent/toggle_group/SSG/Label",
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
							"UnityEngine.RectTransform",
							"UIMoveTweener",
							"UIMoveTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UITweenSequence"
				}
			}
		},
		call_node_list = {
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_5/Background/Checkmark"] = "_control.order_layer_detail.parent.toggle_group.to_5.Background.Checkmark",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_2"] = "_control.order_layer_detail.parent.toggle_group.to_2",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_1/Label"] = "_control.order_layer_detail.parent.toggle_group.to_1.Label",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_1"] = "_control.order_layer_detail.parent.toggle_group.to_1",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_4/Background/Checkmark"] = "_control.order_layer_detail.parent.toggle_group.to_4.Background.Checkmark",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_3/Label"] = "_control.order_layer_detail.parent.toggle_group.to_3.Label",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_3/Background/Checkmark"] = "_control.order_layer_detail.parent.toggle_group.to_3.Background.Checkmark",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_3/Background"] = "_control.order_layer_detail.parent.toggle_group.to_3.Background",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_4/Background"] = "_control.order_layer_detail.parent.toggle_group.to_4.Background",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_2/Label"] = "_control.order_layer_detail.parent.toggle_group.to_2.Label",
			["furniture_recycle_panel/order_layer"] = "_control.order_layer",
			["furniture_recycle_panel/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.scrollview.scrollbarvertical.slidingarea.handle",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_2/Background"] = "_control.order_layer_detail.parent.toggle_group.to_2.Background",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_5/Label"] = "_control.order_layer_detail.parent.toggle_group.to_5.Label",
			["furniture_recycle_panel/type_layer"] = "_control.type_layer",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_3"] = "_control.order_layer_detail.parent.toggle_group.to_3",
			["furniture_recycle_panel/order_layer_detail/parent"] = "_control.order_layer_detail.parent",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_5/Background"] = "_control.order_layer_detail.parent.toggle_group.to_5.Background",
			["furniture_recycle_panel/fast_choose_btn"] = "_control.fast_choose_btn",
			["furniture_recycle_panel/type_layer_detail/parent"] = "_control.type_layer_detail.parent",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_2/Background/Checkmark"] = "_control.order_layer_detail.parent.toggle_group.to_2.Background.Checkmark",
			["furniture_recycle_panel/top_layer/upline_corner"] = "_control.top_layer.upline_corner",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CL"] = "_control.type_layer_detail.parent.toggle_group.CL",
			["furniture_recycle_panel/confirm_btn/des"] = "_control.confirm_btn.des",
			["furniture_recycle_panel/type_layer/des"] = "_control.type_layer.des",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_1/Background"] = "_control.order_layer_detail.parent.toggle_group.to_1.Background",
			["furniture_recycle_panel/order_layer/icon"] = "_control.order_layer.icon",
			["furniture_recycle_panel/top_layer/returnbtn"] = "_control.top_layer.returnbtn",
			["furniture_recycle_panel/res_node/icon"] = "_control.res_node.icon",
			["furniture_recycle_panel/scrollview/viewport/content"] = "_control.scrollview.viewport.content",
			["furniture_recycle_panel/furniture_layer/furniture_des"] = "_control.furniture_layer.furniture_des",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/ALL/Label"] = "_control.type_layer_detail.parent.toggle_group.ALL.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CV/Background"] = "_control.type_layer_detail.parent.toggle_group.CV.Background",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CV/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.CV.Background.Checkmark",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CV/Label"] = "_control.type_layer_detail.parent.toggle_group.CV.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CVL/Background"] = "_control.type_layer_detail.parent.toggle_group.CVL.Background",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/ALL"] = "_control.type_layer_detail.parent.toggle_group.ALL",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CVL/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.CVL.Background.Checkmark",
			["furniture_recycle_panel/order_layer/type_des"] = "_control.order_layer.type_des",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/ALL/Background"] = "_control.type_layer_detail.parent.toggle_group.ALL.Background",
			["furniture_recycle_panel/order_layer/des"] = "_control.order_layer.des",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CVL/Label"] = "_control.type_layer_detail.parent.toggle_group.CVL.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/AV/Background"] = "_control.type_layer_detail.parent.toggle_group.AV.Background",
			["furniture_recycle_panel/bg"] = "_control.bg",
			["furniture_recycle_panel/top_layer/title"] = "_control.top_layer.title",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/AV/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.AV.Background.Checkmark",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/AV/Label"] = "_control.type_layer_detail.parent.toggle_group.AV.Label",
			["furniture_recycle_panel/type_layer_detail"] = "_control.type_layer_detail",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BB"] = "_control.type_layer_detail.parent.toggle_group.BB",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BB/Background"] = "_control.type_layer_detail.parent.toggle_group.BB.Background",
			["furniture_recycle_panel/top_layer"] = "_control.top_layer",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BB/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.BB.Background.Checkmark",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CAV"] = "_control.type_layer_detail.parent.toggle_group.CAV",
			["furniture_recycle_panel/furniture_layer/amount_txt"] = "_control.furniture_layer.amount_txt",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CVL"] = "_control.type_layer_detail.parent.toggle_group.CVL",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BBV"] = "_control.type_layer_detail.parent.toggle_group.BBV",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BBV/Background"] = "_control.type_layer_detail.parent.toggle_group.BBV.Background",
			["furniture_recycle_panel/top_layer/fur_num"] = "_control.top_layer.fur_num",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BBV/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.BBV.Background.Checkmark",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group"] = "_control.type_layer_detail.parent.toggle_group",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BBV/Label"] = "_control.type_layer_detail.parent.toggle_group.BBV.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BC/Background"] = "_control.type_layer_detail.parent.toggle_group.BC.Background",
			["furniture_recycle_panel/top_layer/upline"] = "_control.top_layer.upline",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BC/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.BC.Background.Checkmark",
			["furniture_recycle_panel/type_layer/icon"] = "_control.type_layer.icon",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BC/Label"] = "_control.type_layer_detail.parent.toggle_group.BC.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CA"] = "_control.type_layer_detail.parent.toggle_group.CA",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CA/Background"] = "_control.type_layer_detail.parent.toggle_group.CA.Background",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CA/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.CA.Background.Checkmark",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CA/Label"] = "_control.type_layer_detail.parent.toggle_group.CA.Label",
			["furniture_recycle_panel/fast_choose_btn/des"] = "_control.fast_choose_btn.des",
			["furniture_recycle_panel/res_node"] = "_control.res_node",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BB/Label"] = "_control.type_layer_detail.parent.toggle_group.BB.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BM"] = "_control.type_layer_detail.parent.toggle_group.BM",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CAV/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.CAV.Background.Checkmark",
			["furniture_recycle_panel/scrollview"] = "_control.scrollview",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CAV/Label"] = "_control.type_layer_detail.parent.toggle_group.CAV.Label",
			["furniture_recycle_panel/type_layer/type_des"] = "_control.type_layer.type_des",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/AV"] = "_control.type_layer_detail.parent.toggle_group.AV",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CLT/Background"] = "_control.type_layer_detail.parent.toggle_group.CLT.Background",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CLT/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.CLT.Background.Checkmark",
			["furniture_recycle_panel/scrollview/scrollbarvertical/slidingarea"] = "_control.scrollview.scrollbarvertical.slidingarea",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CLT/Label"] = "_control.type_layer_detail.parent.toggle_group.CLT.Label",
			["furniture_recycle_panel/scrollview/viewport"] = "_control.scrollview.viewport",
			["furniture_recycle_panel/top_layer/des"] = "_control.top_layer.des",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CL/Background"] = "_control.type_layer_detail.parent.toggle_group.CL.Background",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CL/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.CL.Background.Checkmark",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CL/Label"] = "_control.type_layer_detail.parent.toggle_group.CL.Label",
			["furniture_recycle_panel/res_node/diamond_num"] = "_control.res_node.diamond_num",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CAV/Background"] = "_control.type_layer_detail.parent.toggle_group.CAV.Background",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BM/Background"] = "_control.type_layer_detail.parent.toggle_group.BM.Background",
			["furniture_recycle_panel/bottomline"] = "_control.bottomline",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BM/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.BM.Background.Checkmark",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_4"] = "_control.order_layer_detail.parent.toggle_group.to_4",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BC"] = "_control.type_layer_detail.parent.toggle_group.BC",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/BM/Label"] = "_control.type_layer_detail.parent.toggle_group.BM.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/DD"] = "_control.type_layer_detail.parent.toggle_group.DD",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CLT"] = "_control.type_layer_detail.parent.toggle_group.CLT",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/ALL/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.ALL.Background.Checkmark",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/DD/Background"] = "_control.type_layer_detail.parent.toggle_group.DD.Background",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/DD/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.DD.Background.Checkmark",
			["furniture_recycle_panel/scrollview/scrollbarvertical"] = "_control.scrollview.scrollbarvertical",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/DD/Label"] = "_control.type_layer_detail.parent.toggle_group.DD.Label",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/SSG"] = "_control.type_layer_detail.parent.toggle_group.SSG",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/SSG/Background"] = "_control.type_layer_detail.parent.toggle_group.SSG.Background",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group"] = "_control.order_layer_detail.parent.toggle_group",
			["furniture_recycle_panel/furniture_layer"] = "_control.furniture_layer",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_5"] = "_control.order_layer_detail.parent.toggle_group.to_5",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/SSG/Background/Checkmark"] = "_control.type_layer_detail.parent.toggle_group.SSG.Background.Checkmark",
			["furniture_recycle_panel/order_layer_detail"] = "_control.order_layer_detail",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/SSG/Label"] = "_control.type_layer_detail.parent.toggle_group.SSG.Label",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_4/Label"] = "_control.order_layer_detail.parent.toggle_group.to_4.Label",
			["furniture_recycle_panel/top_layer/point"] = "_control.top_layer.point",
			["furniture_recycle_panel/type_layer_detail/parent/toggle_group/CV"] = "_control.type_layer_detail.parent.toggle_group.CV",
			["furniture_recycle_panel/furniture_layer/black_line"] = "_control.furniture_layer.black_line",
			["furniture_recycle_panel/order_layer_detail/parent/toggle_group/to_1/Background/Checkmark"] = "_control.order_layer_detail.parent.toggle_group.to_1.Background.Checkmark",
			["furniture_recycle_panel/confirm_btn"] = "_control.confirm_btn"
		},
		click = {
			order_layer = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer = {
				tp = "UnityEngine.UI.Button"
			},
			confirm_btn = {
				tp = "UnityEngine.UI.Button"
			},
			fast_choose_btn = {
				tp = "UnityEngine.UI.Button"
			},
			order_layer_detail = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer_detail = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top_layer/returnbtn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["order_layer_detail/parent/toggle_group/to_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/parent/toggle_group/to_2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/parent/toggle_group/to_3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/parent/toggle_group/to_4"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/parent/toggle_group/to_5"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/ALL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/CV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/CVL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/AV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/BB"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/BBV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/BC"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/CA"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/CAV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/CLT"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/CL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/BM"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/DD"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/parent/toggle_group/SSG"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

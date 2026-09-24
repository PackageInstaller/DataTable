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
						list = {
							desc = {
								path = "top_layer/title/desc",
								list = {
									dot_image = {
										path = "top_layer/title/desc/dot_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									desc_text = {
										path = "top_layer/title/desc/desc_text",
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
			exchange_btn = {
				path = "exchange_btn",
				list = {
					des = {
						path = "exchange_btn/des",
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
			recycle_btn = {
				path = "recycle_btn",
				list = {
					des = {
						path = "recycle_btn/des",
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
			lock_btn = {
				path = "lock_btn",
				list = {
					des = {
						path = "lock_btn/des",
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
					toggle_group = {
						path = "order_layer_detail/toggle_group",
						list = {
							to_1 = {
								path = "order_layer_detail/toggle_group/to_1",
								list = {
									Background = {
										path = "order_layer_detail/toggle_group/to_1/Background",
										list = {
											Checkmark = {
												path = "order_layer_detail/toggle_group/to_1/Background/Checkmark",
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
										path = "order_layer_detail/toggle_group/to_1/Label",
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
								path = "order_layer_detail/toggle_group/to_2",
								list = {
									Background = {
										path = "order_layer_detail/toggle_group/to_2/Background",
										list = {
											Checkmark = {
												path = "order_layer_detail/toggle_group/to_2/Background/Checkmark",
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
										path = "order_layer_detail/toggle_group/to_2/Label",
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
								path = "order_layer_detail/toggle_group/to_3",
								list = {
									Background = {
										path = "order_layer_detail/toggle_group/to_3/Background",
										list = {
											Checkmark = {
												path = "order_layer_detail/toggle_group/to_3/Background/Checkmark",
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
										path = "order_layer_detail/toggle_group/to_3/Label",
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
								path = "order_layer_detail/toggle_group/to_4",
								list = {
									Background = {
										path = "order_layer_detail/toggle_group/to_4/Background",
										list = {
											Checkmark = {
												path = "order_layer_detail/toggle_group/to_4/Background/Checkmark",
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
										path = "order_layer_detail/toggle_group/to_4/Label",
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
								path = "order_layer_detail/toggle_group/to_5",
								list = {
									Background = {
										path = "order_layer_detail/toggle_group/to_5/Background",
										list = {
											Checkmark = {
												path = "order_layer_detail/toggle_group/to_5/Background/Checkmark",
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
										path = "order_layer_detail/toggle_group/to_5/Label",
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
					},
					filter_type = {
						path = "order_layer_detail/filter_type",
						list = {
							sort_title_line = {
								path = "order_layer_detail/filter_type/sort_title_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_txt = {
								path = "order_layer_detail/filter_type/type_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title = {
								path = "order_layer_detail/filter_type/title",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			type_layer_detail = {
				path = "type_layer_detail",
				list = {
					toggle_group = {
						path = "type_layer_detail/toggle_group",
						list = {
							ALL = {
								path = "type_layer_detail/toggle_group/ALL",
								list = {
									Background = {
										path = "type_layer_detail/toggle_group/ALL/Background",
										list = {
											Checkmark = {
												path = "type_layer_detail/toggle_group/ALL/Background/Checkmark",
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
										path = "type_layer_detail/toggle_group/ALL/Label",
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
							item_parent = {
								path = "type_layer_detail/toggle_group/item_parent",
								list = {
									CV = {
										path = "type_layer_detail/toggle_group/item_parent/CV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CV/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/CV/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/CVL",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CVL/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CVL/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/CVL/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/AV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/AV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/AV/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/AV/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/BB",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BB/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BB/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/BB/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/BBV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BBV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BBV/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/BBV/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/BC",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BC/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BC/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/BC/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/CA",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CA/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CA/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/CA/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/CAV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CAV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CAV/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/CAV/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/CLT",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CLT/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CLT/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/CLT/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/CL",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CL/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CL/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/CL/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/BM",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BM/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BM/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/BM/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/DD",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/DD/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/DD/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/DD/Label",
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
										path = "type_layer_detail/toggle_group/item_parent/SSG",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/SSG/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/SSG/Background/Checkmark",
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
												path = "type_layer_detail/toggle_group/item_parent/SSG/Label",
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
									"UnityEngine.UI.GridLayoutGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					},
					filter_type = {
						path = "type_layer_detail/filter_type",
						list = {
							sort_title_line = {
								path = "type_layer_detail/filter_type/sort_title_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_txt = {
								path = "type_layer_detail/filter_type/type_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title = {
								path = "type_layer_detail/filter_type/title",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			search = {
				path = "search",
				list = {
					input_text = {
						path = "search/input_text",
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
			}
		},
		call_node_list = {
			["dorm_warehouse/top_layer/title"] = "_control.top_layer.title",
			["dorm_warehouse/exchange_btn"] = "_control.exchange_btn",
			["dorm_warehouse/order_layer_detail/toggle_group/to_5/Label"] = "_control.order_layer_detail.toggle_group.to_5.Label",
			["dorm_warehouse/order_layer_detail/toggle_group/to_5/Background"] = "_control.order_layer_detail.toggle_group.to_5.Background",
			["dorm_warehouse/top_layer/title/desc"] = "_control.top_layer.title.desc",
			["dorm_warehouse/lock_btn"] = "_control.lock_btn",
			["dorm_warehouse/order_layer_detail/toggle_group/to_1/Label"] = "_control.order_layer_detail.toggle_group.to_1.Label",
			["dorm_warehouse/type_layer/des"] = "_control.type_layer.des",
			["dorm_warehouse/order_layer/des_mask"] = "_control.order_layer.des_mask",
			["dorm_warehouse/order_layer_detail/toggle_group/to_4"] = "_control.order_layer_detail.toggle_group.to_4",
			["dorm_warehouse/order_layer_detail/toggle_group/to_3/Label"] = "_control.order_layer_detail.toggle_group.to_3.Label",
			["dorm_warehouse/order_layer_detail/toggle_group/to_3/Background"] = "_control.order_layer_detail.toggle_group.to_3.Background",
			["dorm_warehouse/exchange_btn/des"] = "_control.exchange_btn.des",
			["dorm_warehouse/search"] = "_control.search",
			["dorm_warehouse/order_layer_detail/toggle_group/to_2/Label"] = "_control.order_layer_detail.toggle_group.to_2.Label",
			["dorm_warehouse/order_layer_detail/toggle_group/to_2/Background/Checkmark"] = "_control.order_layer_detail.toggle_group.to_2.Background.Checkmark",
			["dorm_warehouse/order_layer_detail/toggle_group/to_2"] = "_control.order_layer_detail.toggle_group.to_2",
			["dorm_warehouse/order_layer_detail/toggle_group/to_4/Label"] = "_control.order_layer_detail.toggle_group.to_4.Label",
			["dorm_warehouse/order_layer/des_mask/txt_2"] = "_control.order_layer.des_mask.txt_2",
			["dorm_warehouse/order_layer_detail/toggle_group/to_1/Background/Checkmark"] = "_control.order_layer_detail.toggle_group.to_1.Background.Checkmark",
			["dorm_warehouse/order_layer_detail/toggle_group/to_1"] = "_control.order_layer_detail.toggle_group.to_1",
			["dorm_warehouse/furniture_layer/amount_txt"] = "_control.furniture_layer.amount_txt",
			["dorm_warehouse/recycle_btn"] = "_control.recycle_btn",
			["dorm_warehouse/type_layer_detail/toggle_group/ALL/Background"] = "_control.type_layer_detail.toggle_group.ALL.Background",
			["dorm_warehouse/scrollview/scrollbarvertical/slidingarea"] = "_control.scrollview.scrollbarvertical.slidingarea",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent"] = "_control.type_layer_detail.toggle_group.item_parent",
			["dorm_warehouse/furniture_layer/furniture_des"] = "_control.furniture_layer.furniture_des",
			["dorm_warehouse/type_layer_detail"] = "_control.type_layer_detail",
			["dorm_warehouse/scrollview"] = "_control.scrollview",
			["dorm_warehouse/furniture_layer"] = "_control.furniture_layer",
			["dorm_warehouse/order_layer_detail/toggle_group/to_4/Background"] = "_control.order_layer_detail.toggle_group.to_4.Background",
			["dorm_warehouse/scrollview/viewport"] = "_control.scrollview.viewport",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BB"] = "_control.type_layer_detail.toggle_group.item_parent.BB",
			["dorm_warehouse/top_layer/title/desc/dot_image"] = "_control.top_layer.title.desc.dot_image",
			["dorm_warehouse/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.scrollview.scrollbarvertical.slidingarea.handle",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BM"] = "_control.type_layer_detail.toggle_group.item_parent.BM",
			["dorm_warehouse/scrollview/viewport/content"] = "_control.scrollview.viewport.content",
			["dorm_warehouse/type_layer/icon"] = "_control.type_layer.icon",
			["dorm_warehouse/top_layer/upline"] = "_control.top_layer.upline",
			["dorm_warehouse/order_layer_detail/toggle_group/to_1/Background"] = "_control.order_layer_detail.toggle_group.to_1.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/AV"] = "_control.type_layer_detail.toggle_group.item_parent.AV",
			["dorm_warehouse/order_layer/des_mask/txt"] = "_control.order_layer.des_mask.txt",
			["dorm_warehouse/order_layer"] = "_control.order_layer",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CV/Background"] = "_control.type_layer_detail.toggle_group.item_parent.CV.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CV/Label"] = "_control.type_layer_detail.toggle_group.item_parent.CV.Label",
			["dorm_warehouse/type_layer_detail/filter_type"] = "_control.type_layer_detail.filter_type",
			["dorm_warehouse/order_layer_detail/toggle_group"] = "_control.order_layer_detail.toggle_group",
			["dorm_warehouse/order_layer/des"] = "_control.order_layer.des",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/AV/Background"] = "_control.type_layer_detail.toggle_group.item_parent.AV.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CLT"] = "_control.type_layer_detail.toggle_group.item_parent.CLT",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/AV/Label"] = "_control.type_layer_detail.toggle_group.item_parent.AV.Label",
			["dorm_warehouse/order_layer_detail/toggle_group/to_4/Background/Checkmark"] = "_control.order_layer_detail.toggle_group.to_4.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BB/Background"] = "_control.type_layer_detail.toggle_group.item_parent.BB.Background",
			["dorm_warehouse/type_layer_detail/filter_type/type_txt"] = "_control.type_layer_detail.filter_type.type_txt",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BB/Label"] = "_control.type_layer_detail.toggle_group.item_parent.BB.Label",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BBV"] = "_control.type_layer_detail.toggle_group.item_parent.BBV",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CVL/Label"] = "_control.type_layer_detail.toggle_group.item_parent.CVL.Label",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BBV/Background"] = "_control.type_layer_detail.toggle_group.item_parent.BBV.Background",
			["dorm_warehouse/order_layer_detail/filter_type/title"] = "_control.order_layer_detail.filter_type.title",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BBV/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.BBV.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/ALL"] = "_control.type_layer_detail.toggle_group.ALL",
			["dorm_warehouse/top_layer/title/desc/desc_text"] = "_control.top_layer.title.desc.desc_text",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BBV/Label"] = "_control.type_layer_detail.toggle_group.item_parent.BBV.Label",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BC"] = "_control.type_layer_detail.toggle_group.item_parent.BC",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BC/Background"] = "_control.type_layer_detail.toggle_group.item_parent.BC.Background",
			["dorm_warehouse/furniture_layer/black_line"] = "_control.furniture_layer.black_line",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BC/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.BC.Background.Checkmark",
			["dorm_warehouse/bg"] = "_control.bg",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BC/Label"] = "_control.type_layer_detail.toggle_group.item_parent.BC.Label",
			["dorm_warehouse/top_layer/returnbtn"] = "_control.top_layer.returnbtn",
			["dorm_warehouse/order_layer_detail"] = "_control.order_layer_detail",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CVL/Background"] = "_control.type_layer_detail.toggle_group.item_parent.CVL.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CA/Background"] = "_control.type_layer_detail.toggle_group.item_parent.CA.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CA"] = "_control.type_layer_detail.toggle_group.item_parent.CA",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CV"] = "_control.type_layer_detail.toggle_group.item_parent.CV",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CA/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.CA.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CA/Label"] = "_control.type_layer_detail.toggle_group.item_parent.CA.Label",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CAV"] = "_control.type_layer_detail.toggle_group.item_parent.CAV",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CAV/Background"] = "_control.type_layer_detail.toggle_group.item_parent.CAV.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CAV/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.CAV.Background.Checkmark",
			["dorm_warehouse/order_layer_detail/filter_type"] = "_control.order_layer_detail.filter_type",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CV/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.CV.Background.Checkmark",
			["dorm_warehouse/order_layer_detail/filter_type/type_txt"] = "_control.order_layer_detail.filter_type.type_txt",
			["dorm_warehouse/order_layer_detail/toggle_group/to_5/Background/Checkmark"] = "_control.order_layer_detail.toggle_group.to_5.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CAV/Label"] = "_control.type_layer_detail.toggle_group.item_parent.CAV.Label",
			["dorm_warehouse/bottomline"] = "_control.bottomline",
			["dorm_warehouse/recycle_btn/des"] = "_control.recycle_btn.des",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/AV/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.AV.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CLT/Background"] = "_control.type_layer_detail.toggle_group.item_parent.CLT.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CLT/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.CLT.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CLT/Label"] = "_control.type_layer_detail.toggle_group.item_parent.CLT.Label",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CL"] = "_control.type_layer_detail.toggle_group.item_parent.CL",
			["dorm_warehouse/search/input_text"] = "_control.search.input_text",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CL/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.CL.Background.Checkmark",
			["dorm_warehouse/order_layer_detail/filter_type/sort_title_line"] = "_control.order_layer_detail.filter_type.sort_title_line",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CL/Label"] = "_control.type_layer_detail.toggle_group.item_parent.CL.Label",
			["dorm_warehouse/type_layer/type_des"] = "_control.type_layer.type_des",
			["dorm_warehouse/order_layer_detail/toggle_group/to_3/Background/Checkmark"] = "_control.order_layer_detail.toggle_group.to_3.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BM/Background"] = "_control.type_layer_detail.toggle_group.item_parent.BM.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BM/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.BM.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/ALL/Label"] = "_control.type_layer_detail.toggle_group.ALL.Label",
			["dorm_warehouse/order_layer/icon"] = "_control.order_layer.icon",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/DD"] = "_control.type_layer_detail.toggle_group.item_parent.DD",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BM/Label"] = "_control.type_layer_detail.toggle_group.item_parent.BM.Label",
			["dorm_warehouse/order_layer/type_des"] = "_control.order_layer.type_des",
			["dorm_warehouse/order_layer_detail/toggle_group/to_5"] = "_control.order_layer_detail.toggle_group.to_5",
			["dorm_warehouse/top_layer"] = "_control.top_layer",
			["dorm_warehouse/top_layer/upline_corner"] = "_control.top_layer.upline_corner",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/DD/Background"] = "_control.type_layer_detail.toggle_group.item_parent.DD.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/DD/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.DD.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/DD/Label"] = "_control.type_layer_detail.toggle_group.item_parent.DD.Label",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/SSG"] = "_control.type_layer_detail.toggle_group.item_parent.SSG",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/SSG/Background"] = "_control.type_layer_detail.toggle_group.item_parent.SSG.Background",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/SSG/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.SSG.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/SSG/Label"] = "_control.type_layer_detail.toggle_group.item_parent.SSG.Label",
			["dorm_warehouse/type_layer_detail/toggle_group/ALL/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.ALL.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CVL"] = "_control.type_layer_detail.toggle_group.item_parent.CVL",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CVL/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.CVL.Background.Checkmark",
			["dorm_warehouse/order_layer_detail/toggle_group/to_2/Background"] = "_control.order_layer_detail.toggle_group.to_2.Background",
			["dorm_warehouse/type_layer_detail/filter_type/sort_title_line"] = "_control.type_layer_detail.filter_type.sort_title_line",
			["dorm_warehouse/type_layer"] = "_control.type_layer",
			["dorm_warehouse/type_layer_detail/toggle_group"] = "_control.type_layer_detail.toggle_group",
			["dorm_warehouse/lock_btn/des"] = "_control.lock_btn.des",
			["dorm_warehouse/scrollview/scrollbarvertical"] = "_control.scrollview.scrollbarvertical",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/BB/Background/Checkmark"] = "_control.type_layer_detail.toggle_group.item_parent.BB.Background.Checkmark",
			["dorm_warehouse/type_layer_detail/filter_type/title"] = "_control.type_layer_detail.filter_type.title",
			["dorm_warehouse/order_layer_detail/toggle_group/to_3"] = "_control.order_layer_detail.toggle_group.to_3",
			["dorm_warehouse/type_layer_detail/toggle_group/item_parent/CL/Background"] = "_control.type_layer_detail.toggle_group.item_parent.CL.Background"
		},
		click = {
			order_layer = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer = {
				tp = "UnityEngine.UI.Button"
			},
			exchange_btn = {
				tp = "UnityEngine.UI.Button"
			},
			recycle_btn = {
				tp = "UnityEngine.UI.Button"
			},
			lock_btn = {
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
			["order_layer_detail/toggle_group/to_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/toggle_group/to_2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/toggle_group/to_3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/toggle_group/to_4"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["order_layer_detail/toggle_group/to_5"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/ALL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CVL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/AV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BB"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BBV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BC"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CA"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CAV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CLT"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BM"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/DD"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/SSG"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

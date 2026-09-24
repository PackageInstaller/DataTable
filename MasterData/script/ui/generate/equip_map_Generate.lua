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
			type_btn = {
				path = "type_btn",
				list = {
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
			scrollview = {
				path = "scrollview",
				list = {
					left_line_bg = {
						path = "scrollview/left_line_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
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
							"UnityEngine.UI.Mask",
							"UnityEngine.CanvasRenderer",
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
					"UnityEngine.UI.ScrollRect",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/main_gun/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/sub_gun/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/torpedo/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/torpedo_plane/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/fighter/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/bomber/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/spy_plane/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/radar/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/module/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/bullet/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/aagun/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/repairs/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/anti_sub/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/missile_launcher/Label_mask",
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
											Label_mask = {
												path = "type_layer/type_group/toggle_group/missile/Label_mask",
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
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					own_group = {
						path = "type_layer/own_group",
						list = {
							toggle_group = {
								path = "type_layer/own_group/toggle_group",
								list = {
									all = {
										path = "type_layer/own_group/toggle_group/all",
										list = {
											Background = {
												path = "type_layer/own_group/toggle_group/all/Background",
												list = {
													Checkmark = {
														path = "type_layer/own_group/toggle_group/all/Background/Checkmark",
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
												path = "type_layer/own_group/toggle_group/all/Label",
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
										path = "type_layer/own_group/toggle_group/own_type",
										list = {
											Background = {
												path = "type_layer/own_group/toggle_group/own_type/Background",
												list = {
													Checkmark = {
														path = "type_layer/own_group/toggle_group/own_type/Background/Checkmark",
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
												path = "type_layer/own_group/toggle_group/own_type/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											Label_mask = {
												path = "type_layer/own_group/toggle_group/own_type/Label_mask",
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
										path = "type_layer/own_group/toggle_group/not_own_type",
										list = {
											Background = {
												path = "type_layer/own_group/toggle_group/not_own_type/Background",
												list = {
													Checkmark = {
														path = "type_layer/own_group/toggle_group/not_own_type/Background/Checkmark",
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
												path = "type_layer/own_group/toggle_group/not_own_type/Label",
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
		call_node_list = {
			["equip_map/type_layer/type_group/toggle_group/sub_gun/Label"] = "_control.type_layer.type_group.toggle_group.sub_gun.Label",
			["equip_map/scrollview/scrollbarvertical"] = "_control.scrollview.scrollbarvertical",
			["equip_map/type_layer/type_group/toggle_group/fighter/Label"] = "_control.type_layer.type_group.toggle_group.fighter.Label",
			["equip_map/type_layer/type_group/toggle_group/bomber"] = "_control.type_layer.type_group.toggle_group.bomber",
			["equip_map/type_layer/type_group/toggle_group/all/Label"] = "_control.type_layer.type_group.toggle_group.all.Label",
			["equip_map/type_layer/type_group/toggle_group/sub_gun/Background"] = "_control.type_layer.type_group.toggle_group.sub_gun.Background",
			["equip_map/search/search_txt"] = "_control.search.search_txt",
			["equip_map/type_layer/own_group/toggle_group/all/Label"] = "_control.type_layer.own_group.toggle_group.all.Label",
			["equip_map/type_btn/type_txt"] = "_control.type_btn.type_txt",
			["equip_map/type_layer/type_group/toggle_group/torpedo/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.torpedo.Background.Checkmark",
			["equip_map/scrollview/scrollbarvertical/slidingarea"] = "_control.scrollview.scrollbarvertical.slidingarea",
			["equip_map/type_btn/type"] = "_control.type_btn.type",
			["equip_map/type_layer/type_group/toggle_group/torpedo/Background"] = "_control.type_layer.type_group.toggle_group.torpedo.Background",
			["equip_map/type_layer/type_group/toggle_group/missile_launcher/Label_mask"] = "_control.type_layer.type_group.toggle_group.missile_launcher.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/sub_gun/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.sub_gun.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/bomber/Label_mask"] = "_control.type_layer.type_group.toggle_group.bomber.Label_mask",
			["equip_map/top"] = "_control.top",
			["equip_map/type_layer/filter_type"] = "_control.type_layer.filter_type",
			["equip_map/type_layer/type_group/toggle_group/all/Background"] = "_control.type_layer.type_group.toggle_group.all.Background",
			["equip_map/type_layer/type_group/toggle_group/all"] = "_control.type_layer.type_group.toggle_group.all",
			["equip_map/type_layer/type_group/toggle_group/fighter/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.fighter.Background.Checkmark",
			["equip_map/type_layer/own_group/toggle_group/own_type"] = "_control.type_layer.own_group.toggle_group.own_type",
			["equip_map/bg"] = "_control.bg",
			["equip_map/search/Placeholder"] = "_control.search.Placeholder",
			["equip_map/type_layer/type_group/toggle_group/missile_launcher/Background"] = "_control.type_layer.type_group.toggle_group.missile_launcher.Background",
			["equip_map/type_layer/type_group/toggle_group/sub_gun/Label_mask"] = "_control.type_layer.type_group.toggle_group.sub_gun.Label_mask",
			["equip_map/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.scrollview.scrollbarvertical.slidingarea.handle",
			["equip_map/type_layer/type_group/toggle_group/main_gun"] = "_control.type_layer.type_group.toggle_group.main_gun",
			["equip_map/type_layer/type_group/toggle_group/bomber/Background"] = "_control.type_layer.type_group.toggle_group.bomber.Background",
			["equip_map/type_layer/own_group/toggle_group/own_type/Label"] = "_control.type_layer.own_group.toggle_group.own_type.Label",
			["equip_map/type_layer/type_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.all.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/bomber/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.bomber.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/radar"] = "_control.type_layer.type_group.toggle_group.radar",
			["equip_map/type_layer/type_group/toggle_group/spy_plane/Label_mask"] = "_control.type_layer.type_group.toggle_group.spy_plane.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/radar/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.radar.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/bomber/Label"] = "_control.type_layer.type_group.toggle_group.bomber.Label",
			["equip_map/type_layer/type_group/toggle_group/fighter/Background"] = "_control.type_layer.type_group.toggle_group.fighter.Background",
			["equip_map/type_layer/type_group/toggle_group/radar/Label"] = "_control.type_layer.type_group.toggle_group.radar.Label",
			["equip_map/type_layer/type_group/toggle_group/radar/Label_mask"] = "_control.type_layer.type_group.toggle_group.radar.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/module/Background"] = "_control.type_layer.type_group.toggle_group.module.Background",
			["equip_map/type_layer/type_group/toggle_group/module/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.module.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/missile_launcher/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.missile_launcher.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/module/Label_mask"] = "_control.type_layer.type_group.toggle_group.module.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/bullet"] = "_control.type_layer.type_group.toggle_group.bullet",
			["equip_map/scrollview/viewport/content"] = "_control.scrollview.viewport.content",
			["equip_map/type_layer/type_group/toggle_group/bullet/Background"] = "_control.type_layer.type_group.toggle_group.bullet.Background",
			["equip_map/type_layer/type_group/toggle_group/bullet/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.bullet.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/main_gun/Background"] = "_control.type_layer.type_group.toggle_group.main_gun.Background",
			["equip_map/type_layer/type_group/toggle_group/bullet/Label"] = "_control.type_layer.type_group.toggle_group.bullet.Label",
			["equip_map/top/return_btn"] = "_control.top.return_btn",
			["equip_map/type_layer/type_group/toggle_group/bullet/Label_mask"] = "_control.type_layer.type_group.toggle_group.bullet.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/missile_launcher"] = "_control.type_layer.type_group.toggle_group.missile_launcher",
			["equip_map/type_layer/type_group/toggle_group/torpedo_plane/Label_mask"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.Label_mask",
			["equip_map/type_layer/own_group/toggle_group/all/Background"] = "_control.type_layer.own_group.toggle_group.all.Background",
			["equip_map/type_layer/type_group/toggle_group/spy_plane/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.spy_plane.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/main_gun/Label_mask"] = "_control.type_layer.type_group.toggle_group.main_gun.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/spy_plane/Background"] = "_control.type_layer.type_group.toggle_group.spy_plane.Background",
			["equip_map/type_layer/type_group/toggle_group/aagun/Label"] = "_control.type_layer.type_group.toggle_group.aagun.Label",
			["equip_map/type_layer/type_group/toggle_group/spy_plane/Label"] = "_control.type_layer.type_group.toggle_group.spy_plane.Label",
			["equip_map/type_layer/type_group/toggle_group/aagun/Label_mask"] = "_control.type_layer.type_group.toggle_group.aagun.Label_mask",
			["equip_map/scrollview"] = "_control.scrollview",
			["equip_map/type_layer/own_group/toggle_group/not_own_type"] = "_control.type_layer.own_group.toggle_group.not_own_type",
			["equip_map/type_layer/type_group/toggle_group/repairs/Background"] = "_control.type_layer.type_group.toggle_group.repairs.Background",
			["equip_map/type_layer/filter_type/sort_title_line"] = "_control.type_layer.filter_type.sort_title_line",
			["equip_map/type_layer/type_group"] = "_control.type_layer.type_group",
			["equip_map/type_layer/type_group/toggle_group/repairs/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.repairs.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/main_gun/Label"] = "_control.type_layer.type_group.toggle_group.main_gun.Label",
			["equip_map/type_layer/type_group/toggle_group/fighter"] = "_control.type_layer.type_group.toggle_group.fighter",
			["equip_map/type_layer/type_group/toggle_group/main_gun/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.main_gun.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/repairs/Label"] = "_control.type_layer.type_group.toggle_group.repairs.Label",
			["equip_map/type_layer/type_group/toggle_group/torpedo"] = "_control.type_layer.type_group.toggle_group.torpedo",
			["equip_map/type_layer/type_group/toggle_group/repairs/Label_mask"] = "_control.type_layer.type_group.toggle_group.repairs.Label_mask",
			["equip_map/scrollview/left_line_bg"] = "_control.scrollview.left_line_bg",
			["equip_map/type_layer/type_group/toggle_group/anti_sub/Background"] = "_control.type_layer.type_group.toggle_group.anti_sub.Background",
			["equip_map/type_layer/type_group/toggle_group/anti_sub/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.anti_sub.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/anti_sub/Label"] = "_control.type_layer.type_group.toggle_group.anti_sub.Label",
			["equip_map/type_layer/type_group/toggle_group/anti_sub/Label_mask"] = "_control.type_layer.type_group.toggle_group.anti_sub.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/missile_launcher/Label"] = "_control.type_layer.type_group.toggle_group.missile_launcher.Label",
			["equip_map/type_layer/type_group/toggle_group/torpedo_plane/Label"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.Label",
			["equip_map/type_layer/type_group/toggle_group/torpedo/Label"] = "_control.type_layer.type_group.toggle_group.torpedo.Label",
			["equip_map/top/title_txt"] = "_control.top.title_txt",
			["equip_map/type_layer/own_group"] = "_control.type_layer.own_group",
			["equip_map/type_layer/type_group/toggle_group/aagun/Background"] = "_control.type_layer.type_group.toggle_group.aagun.Background",
			["equip_map/type_layer/type_group/toggle_group/sub_gun"] = "_control.type_layer.type_group.toggle_group.sub_gun",
			["equip_map/type_layer/type_group/toggle_group/missile"] = "_control.type_layer.type_group.toggle_group.missile",
			["equip_map/type_layer/type_group/toggle_group/missile/Background"] = "_control.type_layer.type_group.toggle_group.missile.Background",
			["equip_map/type_layer/own_group/toggle_group/own_type/Background/Checkmark"] = "_control.type_layer.own_group.toggle_group.own_type.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/torpedo_plane/Background"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.Background",
			["equip_map/type_layer/filter_type/type_txt"] = "_control.type_layer.filter_type.type_txt",
			["equip_map/type_layer/type_group/toggle_group/missile/Label"] = "_control.type_layer.type_group.toggle_group.missile.Label",
			["equip_map/type_layer/type_group/toggle_group/missile/Label_mask"] = "_control.type_layer.type_group.toggle_group.missile.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/module/Label"] = "_control.type_layer.type_group.toggle_group.module.Label",
			["equip_map/type_layer/type_group/toggle_group/torpedo_plane"] = "_control.type_layer.type_group.toggle_group.torpedo_plane",
			["equip_map/type_layer/type_group/toggle_group/fighter/Label_mask"] = "_control.type_layer.type_group.toggle_group.fighter.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/radar/Background"] = "_control.type_layer.type_group.toggle_group.radar.Background",
			["equip_map/type_layer/type_group/toggle_group/torpedo_plane/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.torpedo_plane.Background.Checkmark",
			["equip_map/type_layer/own_group/toggle_group"] = "_control.type_layer.own_group.toggle_group",
			["equip_map/type_layer/own_group/toggle_group/all"] = "_control.type_layer.own_group.toggle_group.all",
			["equip_map/type_layer/type_group/toggle_group/aagun/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.aagun.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/aagun"] = "_control.type_layer.type_group.toggle_group.aagun",
			["equip_map/type_layer/own_group/toggle_group/all/Background/Checkmark"] = "_control.type_layer.own_group.toggle_group.all.Background.Checkmark",
			["equip_map/type_layer/type_group/toggle_group/anti_sub"] = "_control.type_layer.type_group.toggle_group.anti_sub",
			["equip_map/type_layer/type_group/toggle_group/torpedo/Label_mask"] = "_control.type_layer.type_group.toggle_group.torpedo.Label_mask",
			["equip_map/search"] = "_control.search",
			["equip_map/type_layer/type_group/toggle_group/missile/Background/Checkmark"] = "_control.type_layer.type_group.toggle_group.missile.Background.Checkmark",
			["equip_map/type_layer/line_mid"] = "_control.type_layer.line_mid",
			["equip_map/type_layer"] = "_control.type_layer",
			["equip_map/type_layer/own_group/toggle_group/own_type/Label_mask"] = "_control.type_layer.own_group.toggle_group.own_type.Label_mask",
			["equip_map/type_layer/type_group/toggle_group/repairs"] = "_control.type_layer.type_group.toggle_group.repairs",
			["equip_map/type_layer/own_group/toggle_group/not_own_type/Background"] = "_control.type_layer.own_group.toggle_group.not_own_type.Background",
			["equip_map/type_layer/own_group/toggle_group/not_own_type/Background/Checkmark"] = "_control.type_layer.own_group.toggle_group.not_own_type.Background.Checkmark",
			["equip_map/type_layer/own_group/toggle_group/not_own_type/Label"] = "_control.type_layer.own_group.toggle_group.not_own_type.Label",
			["equip_map/top/line_bg"] = "_control.top.line_bg",
			["equip_map/type_layer/type_group/toggle_group/spy_plane"] = "_control.type_layer.type_group.toggle_group.spy_plane",
			["equip_map/type_layer/type_group/toggle_group/module"] = "_control.type_layer.type_group.toggle_group.module",
			["equip_map/scrollview/viewport"] = "_control.scrollview.viewport",
			["equip_map/type_btn"] = "_control.type_btn",
			["equip_map/type_layer/type_group/toggle_group"] = "_control.type_layer.type_group.toggle_group",
			["equip_map/shine"] = "_control.shine",
			["equip_map/type_layer/own_group/toggle_group/own_type/Background"] = "_control.type_layer.own_group.toggle_group.own_type.Background"
		},
		click = {
			["top/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			type_btn = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer = {
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
			["type_layer/own_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/own_group/toggle_group/own_type"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer/own_group/toggle_group/not_own_type"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

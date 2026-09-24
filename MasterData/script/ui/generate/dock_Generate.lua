return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {
					top_image = {
						path = "bg/top_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					down_image = {
						path = "bg/down_image",
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
					"UITweenSequence"
				}
			},
			top_layer = {
				path = "top_layer",
				list = {
					titlebuild = {
						path = "top_layer/titlebuild",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line_group = {
						path = "top_layer/line_group",
						list = {
							line_1 = {
								path = "top_layer/line_group/line_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_2 = {
								path = "top_layer/line_group/line_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_3 = {
								path = "top_layer/line_group/line_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_4 = {
								path = "top_layer/line_group/line_4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_left = {
								path = "top_layer/line_group/line_left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_right = {
								path = "top_layer/line_group/line_right",
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
					close_btn = {
						path = "top_layer/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					toggle_control = {
						path = "top_layer/toggle_control",
						list = {
							constructure = {
								path = "top_layer/toggle_control/constructure",
								list = {
									unselected = {
										path = "top_layer/toggle_control/constructure/unselected",
										list = {
											selected = {
												path = "top_layer/toggle_control/constructure/unselected/selected",
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
									dbtn1 = {
										path = "top_layer/toggle_control/constructure/dbtn1",
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
									"UITweenSequence"
								}
							},
							disassemble = {
								path = "top_layer/toggle_control/disassemble",
								list = {
									unselected = {
										path = "top_layer/toggle_control/disassemble/unselected",
										list = {
											selected = {
												path = "top_layer/toggle_control/disassemble/unselected/selected",
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
									dbtn1 = {
										path = "top_layer/toggle_control/disassemble/dbtn1",
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
									"UITweenSequence"
								}
							},
							research = {
								path = "top_layer/toggle_control/research",
								list = {
									unselected = {
										path = "top_layer/toggle_control/research/unselected",
										list = {
											selected = {
												path = "top_layer/toggle_control/research/unselected/selected",
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
									dbtn1 = {
										path = "top_layer/toggle_control/research/dbtn1",
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
									"UITweenSequence"
								}
							},
							dispose = {
								path = "top_layer/toggle_control/dispose",
								list = {
									unselected = {
										path = "top_layer/toggle_control/dispose/unselected",
										list = {
											selected = {
												path = "top_layer/toggle_control/dispose/unselected/selected",
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
									dbtn1 = {
										path = "top_layer/toggle_control/dispose/dbtn1",
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
									"UITweenSequence"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					},
					finish_tag_1 = {
						path = "top_layer/finish_tag_1",
						list = {
							bg = {
								path = "top_layer/finish_tag_1/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							finish_txt = {
								path = "top_layer/finish_tag_1/finish_txt",
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
					finish_tag_2 = {
						path = "top_layer/finish_tag_2",
						list = {
							bg = {
								path = "top_layer/finish_tag_2/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							finish_txt = {
								path = "top_layer/finish_tag_2/finish_txt",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			left_layer = {
				path = "left_layer",
				list = {
					user_res_1 = {
						path = "left_layer/user_res_1",
						list = {
							bg = {
								path = "left_layer/user_res_1/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							oil_image = {
								path = "left_layer/user_res_1/oil_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bullet_image = {
								path = "left_layer/user_res_1/bullet_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							iron_image = {
								path = "left_layer/user_res_1/iron_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mineral_inmage = {
								path = "left_layer/user_res_1/mineral_inmage",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							oil_num = {
								path = "left_layer/user_res_1/oil_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							bullet_num = {
								path = "left_layer/user_res_1/bullet_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							iron_num = {
								path = "left_layer/user_res_1/iron_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							mineral_num = {
								path = "left_layer/user_res_1/mineral_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump"
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
			},
			bottom_layer = {
				path = "bottom_layer",
				list = {
					bottom_line = {
						path = "bottom_layer/bottom_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					ui_buildship = {
						path = "bottom_layer/ui_buildship",
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
			right_layer = {
				path = "right_layer",
				list = {
					container = {
						path = "right_layer/container",
						list = {
							constructure_layer = {
								path = "right_layer/container/constructure_layer",
								list = {
									build = {
										path = "right_layer/container/constructure_layer/build",
										list = {
											scroll = {
												path = "right_layer/container/constructure_layer/build/scroll",
												list = {
													viewport = {
														path = "right_layer/container/constructure_layer/build/scroll/viewport",
														list = {
															content = {
																path = "right_layer/container/constructure_layer/build/scroll/viewport/content",
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
											"UIMoveTweener",
											"UIMoveTweener"
										}
									},
									disassemble = {
										path = "right_layer/container/constructure_layer/disassemble",
										list = {
											disassemble_layer = {
												path = "right_layer/container/constructure_layer/disassemble/disassemble_layer",
												list = {
													content = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/content",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													scroll = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/scroll",
														list = {
															viewport = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/scroll/viewport",
																list = {
																	content = {
																		path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/scroll/viewport/content",
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
															["Scrollbar Vertical"] = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/scroll/Scrollbar Vertical",
																list = {
																	["Sliding Area"] = {
																		path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/scroll/Scrollbar Vertical/Sliding Area",
																		list = {
																			Handle = {
																				path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/scroll/Scrollbar Vertical/Sliding Area/Handle",
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
													bg = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													disaasemble_down = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/disaasemble_down",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													destroyship_getresource = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/destroyship_getresource",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													clear_btn = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/clear_btn",
														list = {
															clearlist = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/clear_btn/clearlist",
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
													disaasemble_btn = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/disaasemble_btn",
														list = {
															dbtn = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/disaasemble_btn/dbtn",
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
													line = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													checkbox_layer = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/checkbox_layer",
														list = {
															bg = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/checkbox_layer/bg",
																list = {
																	checkbox = {
																		path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/checkbox_layer/bg/checkbox",
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
															save_equip = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/checkbox_layer/save_equip",
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
													oil = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/oil",
														list = {
															icon = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/oil/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															txt = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/oil/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															line = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/oil/line",
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
													bullet = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/bullet",
														list = {
															icon = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/bullet/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															txt = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/bullet/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															line = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/bullet/line",
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
													steel = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/steel",
														list = {
															icon = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/steel/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															txt = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/steel/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															line = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/steel/line",
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
													aluminium = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/aluminium",
														list = {
															icon = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/aluminium/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															txt = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/aluminium/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															line = {
																path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/aluminium/line",
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
													down_line = {
														path = "right_layer/container/constructure_layer/disassemble/disassemble_layer/down_line",
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
											"UIMoveTweener",
											"UIMoveTweener"
										}
									},
									develop = {
										path = "right_layer/container/constructure_layer/develop",
										list = {
											scroll = {
												path = "right_layer/container/constructure_layer/develop/scroll",
												list = {
													viewport = {
														path = "right_layer/container/constructure_layer/develop/scroll/viewport",
														list = {
															content = {
																path = "right_layer/container/constructure_layer/develop/scroll/viewport/content",
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
											"UIMoveTweener",
											"UIMoveTweener"
										}
									},
									dispose = {
										path = "right_layer/container/constructure_layer/dispose",
										list = {
											bottom = {
												path = "right_layer/container/constructure_layer/dispose/bottom",
												list = {
													bottom_line = {
														path = "right_layer/container/constructure_layer/dispose/bottom/bottom_line",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													title = {
														path = "right_layer/container/constructure_layer/dispose/bottom/title",
														list = {
															txt = {
																path = "right_layer/container/constructure_layer/dispose/bottom/title/txt",
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
													scroll = {
														path = "right_layer/container/constructure_layer/dispose/bottom/scroll",
														list = {
															viewport = {
																path = "right_layer/container/constructure_layer/dispose/bottom/scroll/viewport",
																list = {
																	content = {
																		path = "right_layer/container/constructure_layer/dispose/bottom/scroll/viewport/content",
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
															["Scrollbar Vertical"] = {
																path = "right_layer/container/constructure_layer/dispose/bottom/scroll/Scrollbar Vertical",
																list = {
																	["Sliding Area"] = {
																		path = "right_layer/container/constructure_layer/dispose/bottom/scroll/Scrollbar Vertical/Sliding Area",
																		list = {
																			Handle = {
																				path = "right_layer/container/constructure_layer/dispose/bottom/scroll/Scrollbar Vertical/Sliding Area/Handle",
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
													confirm_btn = {
														path = "right_layer/container/constructure_layer/dispose/bottom/confirm_btn",
														list = {
															confirm = {
																path = "right_layer/container/constructure_layer/dispose/bottom/confirm_btn/confirm",
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
													cancel_btn = {
														path = "right_layer/container/constructure_layer/dispose/bottom/cancel_btn",
														list = {
															cancel = {
																path = "right_layer/container/constructure_layer/dispose/bottom/cancel_btn/cancel",
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
													fast_confirm_btn = {
														path = "right_layer/container/constructure_layer/dispose/bottom/fast_confirm_btn",
														list = {
															confirm = {
																path = "right_layer/container/constructure_layer/dispose/bottom/fast_confirm_btn/confirm",
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
							"UnityEngine.RectTransform"
						}
					},
					equip_amount_layer = {
						path = "right_layer/equip_amount_layer",
						list = {
							dock_bord = {
								path = "right_layer/equip_amount_layer/dock_bord",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							equip_amount = {
								path = "right_layer/equip_amount_layer/equip_amount",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							equip_filter_btn = {
								path = "right_layer/equip_amount_layer/equip_filter_btn",
								list = {
									ui_dockequipscreen = {
										path = "right_layer/equip_amount_layer/equip_filter_btn/ui_dockequipscreen",
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
							"UIMoveTweener",
							"UIMoveTweener"
						}
					},
					user_res_2 = {
						path = "right_layer/user_res_2",
						list = {
							item_1 = {
								path = "right_layer/user_res_2/item_1",
								list = {
									icon = {
										path = "right_layer/user_res_2/item_1/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "right_layer/user_res_2/item_1/num",
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
							item_2 = {
								path = "right_layer/user_res_2/item_2",
								list = {
									icon = {
										path = "right_layer/user_res_2/item_2/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "right_layer/user_res_2/item_2/num",
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
							item_3 = {
								path = "right_layer/user_res_2/item_3",
								list = {
									icon = {
										path = "right_layer/user_res_2/item_3/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									num = {
										path = "right_layer/user_res_2/item_3/num",
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
							"UIMoveTweener",
							"UIMoveTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			tip_layer = {
				path = "tip_layer",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			test = {
				path = "test",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			level_tips = {
				path = "level_tips",
				list = {
					base_panel = {
						path = "level_tips/base_panel",
						list = {
							top = {
								path = "level_tips/base_panel/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							gogo = {
								path = "level_tips/base_panel/gogo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "level_tips/base_panel/title",
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
					line = {
						path = "level_tips/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					expand_des = {
						path = "level_tips/expand_des",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					cover = {
						path = "level_tips/cover",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					supplement_btn = {
						path = "level_tips/supplement_btn",
						list = {
							txt = {
								path = "level_tips/supplement_btn/txt",
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
					collection_describe_test = {
						path = "level_tips/collection_describe_test",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_grey = {
						path = "level_tips/line_grey",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		click = {
			["right_layer/container/constructure_layer/disassemble/disassemble_layer/clear_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_layer/container/constructure_layer/disassemble/disassemble_layer/disaasemble_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_layer/container/constructure_layer/dispose/bottom/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_layer/container/constructure_layer/dispose/bottom/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_layer/container/constructure_layer/dispose/bottom/fast_confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_layer/equip_amount_layer/equip_filter_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			tip_layer = {
				tp = "UnityEngine.UI.Button"
			},
			["level_tips/supplement_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top_layer/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["top_layer/toggle_control/constructure"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/toggle_control/disassemble"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/toggle_control/research"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/toggle_control/dispose"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["right_layer/container/constructure_layer/disassemble/disassemble_layer/checkbox_layer"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			level_tips = {
				component = "UnityEngine.Canvas",
				path = "level_tips"
			}
		}
	}
}

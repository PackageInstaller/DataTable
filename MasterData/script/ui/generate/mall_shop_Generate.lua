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
			diamonpage = {
				path = "diamonpage",
				list = {
					scrollview = {
						path = "diamonpage/scrollview",
						list = {
							viewport = {
								path = "diamonpage/scrollview/viewport",
								list = {
									content = {
										path = "diamonpage/scrollview/viewport/content",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.GridLayoutGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Mask"
								}
							},
							scrollbarvertical = {
								path = "diamonpage/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "diamonpage/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "diamonpage/scrollview/scrollbarvertical/slidingarea/handle",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			itempage = {
				path = "itempage",
				list = {
					scrollview = {
						path = "itempage/scrollview",
						list = {
							viewport = {
								path = "itempage/scrollview/viewport",
								list = {
									content = {
										path = "itempage/scrollview/viewport/content",
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
									"UnityEngine.UI.RectMask2D"
								}
							},
							scrollbarvertical = {
								path = "itempage/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "itempage/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "itempage/scrollview/scrollbarvertical/slidingarea/handle",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			functionpage = {
				path = "functionpage",
				list = {
					scrollview = {
						path = "functionpage/scrollview",
						list = {
							viewport = {
								path = "functionpage/scrollview/viewport",
								list = {
									content = {
										path = "functionpage/scrollview/viewport/content",
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
									"UnityEngine.UI.RectMask2D"
								}
							},
							scrollbarvertical = {
								path = "functionpage/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "functionpage/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "functionpage/scrollview/scrollbarvertical/slidingarea/handle",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			otherpage = {
				path = "otherpage",
				list = {
					scrollview = {
						path = "otherpage/scrollview",
						list = {
							viewport = {
								path = "otherpage/scrollview/viewport",
								list = {
									content = {
										path = "otherpage/scrollview/viewport/content",
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
									"UnityEngine.UI.RectMask2D"
								}
							},
							scrollbarvertical = {
								path = "otherpage/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "otherpage/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "otherpage/scrollview/scrollbarvertical/slidingarea/handle",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			changepage = {
				path = "changepage",
				list = {
					scrollview = {
						path = "changepage/scrollview",
						list = {
							viewport = {
								path = "changepage/scrollview/viewport",
								list = {
									content = {
										path = "changepage/scrollview/viewport/content",
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
									"UnityEngine.UI.RectMask2D"
								}
							},
							scrollbarvertical = {
								path = "changepage/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "changepage/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "changepage/scrollview/scrollbarvertical/slidingarea/handle",
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
						path = "changepage/type_layer",
						list = {
							bg = {
								path = "changepage/type_layer/bg",
								list = {
									line_mid = {
										path = "changepage/type_layer/bg/line_mid",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									filter_type = {
										path = "changepage/type_layer/bg/filter_type",
										list = {
											sort_title_line = {
												path = "changepage/type_layer/bg/filter_type/sort_title_line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											type_txt = {
												path = "changepage/type_layer/bg/filter_type/type_txt",
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
										path = "changepage/type_layer/bg/btn_series",
										list = {
											confirm_btn = {
												path = "changepage/type_layer/bg/btn_series/confirm_btn",
												list = {
													confirm = {
														path = "changepage/type_layer/bg/btn_series/confirm_btn/confirm",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													confirm_mask = {
														path = "changepage/type_layer/bg/btn_series/confirm_btn/confirm_mask",
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
												path = "changepage/type_layer/bg/btn_series/cancel_btn",
												list = {
													cancel = {
														path = "changepage/type_layer/bg/btn_series/cancel_btn/cancel",
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
									effect_group = {
										path = "changepage/type_layer/bg/effect_group",
										list = {
											toggle_group = {
												path = "changepage/type_layer/bg/effect_group/toggle_group",
												list = {
													all = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/all",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/all/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/all/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/all/Label",
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
													shell_effect = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/shell_effect",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/shell_effect/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/shell_effect/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/shell_effect/title_mask",
																list = {
																	txt = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/shell_effect/title_mask/txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	txt_2 = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/shell_effect/title_mask/txt_2",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/shell_effect/Label",
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
													live = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/live",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/live/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/live/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/live/title_mask",
																list = {
																	txt = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/live/title_mask/txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	txt_2 = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/live/title_mask/txt_2",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/live/Label",
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
													sp_music = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/sp_music",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_music/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_music/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_music/title_mask",
																list = {
																	txt = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_music/title_mask/txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	txt_2 = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_music/title_mask/txt_2",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_music/Label",
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
													sp_dialogue = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/title_mask",
																list = {
																	txt = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/title_mask/txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	txt_2 = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/title_mask/txt_2",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/Label",
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
													sp_menu = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/sp_menu",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_menu/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_menu/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_menu/title_mask",
																list = {
																	txt = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_menu/title_mask/txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	txt_2 = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/sp_menu/title_mask/txt_2",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/sp_menu/Label",
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
													airplane = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/airplane",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/airplane/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/airplane/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/airplane/title_mask",
																list = {
																	txt = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/airplane/title_mask/txt",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	txt_2 = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/airplane/title_mask/txt_2",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/airplane/Label",
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
													voice = {
														path = "changepage/type_layer/bg/effect_group/toggle_group/voice",
														list = {
															Background = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/voice/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/effect_group/toggle_group/voice/Background/Checkmark",
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
																path = "changepage/type_layer/bg/effect_group/toggle_group/voice/title_mask",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image",
																	"UnityEngine.UI.Mask",
																	"TextHorizonScroller"
																}
															},
															Label = {
																path = "changepage/type_layer/bg/effect_group/toggle_group/voice/Label",
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
									using_group = {
										path = "changepage/type_layer/bg/using_group",
										list = {
											toggle_group = {
												path = "changepage/type_layer/bg/using_group/toggle_group",
												list = {
													all = {
														path = "changepage/type_layer/bg/using_group/toggle_group/all",
														list = {
															Background = {
																path = "changepage/type_layer/bg/using_group/toggle_group/all/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/using_group/toggle_group/all/Background/Checkmark",
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
																path = "changepage/type_layer/bg/using_group/toggle_group/all/Label",
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
													bought = {
														path = "changepage/type_layer/bg/using_group/toggle_group/bought",
														list = {
															Background = {
																path = "changepage/type_layer/bg/using_group/toggle_group/bought/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/using_group/toggle_group/bought/Background/Checkmark",
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
																path = "changepage/type_layer/bg/using_group/toggle_group/bought/Label",
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
													not_bought = {
														path = "changepage/type_layer/bg/using_group/toggle_group/not_bought",
														list = {
															Background = {
																path = "changepage/type_layer/bg/using_group/toggle_group/not_bought/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/using_group/toggle_group/not_bought/Background/Checkmark",
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
																path = "changepage/type_layer/bg/using_group/toggle_group/not_bought/Label",
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
													using = {
														path = "changepage/type_layer/bg/using_group/toggle_group/using",
														list = {
															Background = {
																path = "changepage/type_layer/bg/using_group/toggle_group/using/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/using_group/toggle_group/using/Background/Checkmark",
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
																path = "changepage/type_layer/bg/using_group/toggle_group/using/Label",
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
													not_using = {
														path = "changepage/type_layer/bg/using_group/toggle_group/not_using",
														list = {
															Background = {
																path = "changepage/type_layer/bg/using_group/toggle_group/not_using/Background",
																list = {
																	Checkmark = {
																		path = "changepage/type_layer/bg/using_group/toggle_group/not_using/Background/Checkmark",
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
																path = "changepage/type_layer/bg/using_group/toggle_group/not_using/Label",
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
			txt = {
				path = "changepage/type_layer/bg/btn_series/confirm_btn/confirm_mask/txt",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			txt_2 = {
				path = "changepage/type_layer/bg/btn_series/confirm_btn/confirm_mask/txt_2",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Text"
				}
			},
			top_layer = {
				path = "top_layer",
				list = {
					line_group = {
						path = "top_layer/line_group",
						list = {
							leftline = {
								path = "top_layer/line_group/leftline",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlineone = {
								path = "top_layer/line_group/btnlineone",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinetwo = {
								path = "top_layer/line_group/btnlinetwo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinethree = {
								path = "top_layer/line_group/btnlinethree",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinefour = {
								path = "top_layer/line_group/btnlinefour",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btnlinefive = {
								path = "top_layer/line_group/btnlinefive",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							rightline = {
								path = "top_layer/line_group/rightline",
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
					top_btn = {
						path = "top_layer/top_btn",
						list = {
							btnone = {
								path = "top_layer/top_btn/btnone",
								list = {
									btnimg = {
										path = "top_layer/top_btn/btnone/btnimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "top_layer/top_btn/btnone/text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									title_mask = {
										path = "top_layer/top_btn/btnone/title_mask",
										list = {},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							btntwo = {
								path = "top_layer/top_btn/btntwo",
								list = {
									btnimgtwo = {
										path = "top_layer/top_btn/btntwo/btnimgtwo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "top_layer/top_btn/btntwo/text",
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
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							btnthree = {
								path = "top_layer/top_btn/btnthree",
								list = {
									btnimgthree = {
										path = "top_layer/top_btn/btnthree/btnimgthree",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "top_layer/top_btn/btnthree/text",
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
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							btnfour = {
								path = "top_layer/top_btn/btnfour",
								list = {
									btnimgfour = {
										path = "top_layer/top_btn/btnfour/btnimgfour",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "top_layer/top_btn/btnfour/text",
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
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							btnfive = {
								path = "top_layer/top_btn/btnfive",
								list = {
									btnimgfive = {
										path = "top_layer/top_btn/btnfive/btnimgfive",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "top_layer/top_btn/btnfive/text",
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
									"UnityEngine.UI.Toggle",
									"UITweenSequence"
								}
							},
							btnvoucher = {
								path = "top_layer/top_btn/btnvoucher",
								list = {
									Text = {
										path = "top_layer/top_btn/btnvoucher/Text",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
						}
					},
					sprite = {
						path = "top_layer/sprite",
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
					user_res = {
						path = "top_layer/user_res",
						list = {
							bg = {
								path = "top_layer/user_res/bg",
								list = {},
								component = {}
							},
							oil_image = {
								path = "top_layer/user_res/oil_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bullet_image = {
								path = "top_layer/user_res/bullet_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							iron_image = {
								path = "top_layer/user_res/iron_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mineral_inmage = {
								path = "top_layer/user_res/mineral_inmage",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							oil_num = {
								path = "top_layer/user_res/oil_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump",
									"UnityEngine.UI.Outline"
								}
							},
							bullet_num = {
								path = "top_layer/user_res/bullet_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump",
									"UnityEngine.UI.Outline"
								}
							},
							iron_num = {
								path = "top_layer/user_res/iron_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump",
									"UnityEngine.UI.Outline"
								}
							},
							mineral_num = {
								path = "top_layer/user_res/mineral_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"FontJump",
									"UnityEngine.UI.Outline"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					diamon_node = {
						path = "top_layer/diamon_node",
						list = {
							diamond_num = {
								path = "top_layer/diamon_node/diamond_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							icon = {
								path = "top_layer/diamon_node/icon",
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
					search_btn = {
						path = "top_layer/search_btn",
						list = {
							search = {
								path = "top_layer/search_btn/search",
								list = {
									input_text = {
										path = "top_layer/search_btn/search/input_text",
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
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					type_btn = {
						path = "top_layer/type_btn",
						list = {
							type_bg = {
								path = "top_layer/type_btn/type_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type = {
								path = "top_layer/type_btn/type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							type_txt = {
								path = "top_layer/type_btn/type_txt",
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
			bottomline = {
				path = "bottomline",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			}
		},
		call_node_list = {
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_music"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_music",
			["mall_shop/changepage/type_layer/bg/filter_type"] = "_control.changepage.type_layer.bg.filter_type",
			["mall_shop/otherpage/scrollview/scrollbarvertical/slidingarea"] = "_control.otherpage.scrollview.scrollbarvertical.slidingarea",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/live/title_mask/txt"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.live.title_mask.txt",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/voice/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.voice.Background.Checkmark",
			["mall_shop/changepage/type_layer/bg/filter_type/type_txt"] = "_control.changepage.type_layer.bg.filter_type.type_txt",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/live/title_mask"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.live.title_mask",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_menu/title_mask"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu.title_mask",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/title_mask/txt_2"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue.title_mask.txt_2",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/airplane/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.airplane.Background",
			["mall_shop/top_layer/top_btn/btnone/text"] = "_control.top_layer.top_btn.btnone.text",
			["mall_shop/top_layer/top_btn/btnthree/btnimgthree"] = "_control.top_layer.top_btn.btnthree.btnimgthree",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_music/title_mask/txt_2"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_music.title_mask.txt_2",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_music/title_mask"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_music.title_mask",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_bought"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_bought",
			["mall_shop/top_layer/returnbtn"] = "_control.top_layer.returnbtn",
			["mall_shop/top_layer/line_group/btnlineone"] = "_control.top_layer.line_group.btnlineone",
			["mall_shop/otherpage/scrollview/viewport"] = "_control.otherpage.scrollview.viewport",
			["mall_shop/top_layer/line_group/btnlinefive"] = "_control.top_layer.line_group.btnlinefive",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_using/Label"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_using.Label",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_menu/title_mask/txt"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu.title_mask.txt",
			["mall_shop/diamonpage/scrollview/scrollbarvertical/slidingarea"] = "_control.diamonpage.scrollview.scrollbarvertical.slidingarea",
			["mall_shop/functionpage/scrollview"] = "_control.functionpage.scrollview",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/airplane/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.airplane.Background.Checkmark",
			["mall_shop/functionpage/scrollview/scrollbarvertical"] = "_control.functionpage.scrollview.scrollbarvertical",
			["mall_shop/functionpage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.functionpage.scrollview.scrollbarvertical.slidingarea.handle",
			["mall_shop/changepage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.changepage.scrollview.scrollbarvertical.slidingarea.handle",
			["mall_shop/changepage/type_layer/bg/btn_series/confirm_btn/confirm_mask"] = "_control.changepage.type_layer.bg.btn_series.confirm_btn.confirm_mask",
			["mall_shop/top_layer/top_btn/btnone"] = "_control.top_layer.top_btn.btnone",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/all"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.all",
			["mall_shop/bg"] = "_control.bg",
			["mall_shop/itempage"] = "_control.itempage",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/airplane/title_mask/txt_2"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.airplane.title_mask.txt_2",
			["mall_shop/changepage/scrollview/scrollbarvertical/slidingarea"] = "_control.changepage.scrollview.scrollbarvertical.slidingarea",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/using"] = "_control.changepage.type_layer.bg.using_group.toggle_group.using",
			["mall_shop/changepage/type_layer/bg"] = "_control.changepage.type_layer.bg",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/all"] = "_control.changepage.type_layer.bg.using_group.toggle_group.all",
			["mall_shop/itempage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.itempage.scrollview.scrollbarvertical.slidingarea.handle",
			["mall_shop/functionpage/scrollview/viewport"] = "_control.functionpage.scrollview.viewport",
			["mall_shop/diamonpage/scrollview"] = "_control.diamonpage.scrollview",
			["mall_shop/top_layer"] = "_control.top_layer",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/airplane"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.airplane",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_menu/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu.Background",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/live"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.live",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/title_mask"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue.title_mask",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_menu/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu.Background.Checkmark",
			["mall_shop/otherpage/scrollview"] = "_control.otherpage.scrollview",
			["mall_shop/bg/top_image"] = "_control.bg.top_image",
			["mall_shop/itempage/scrollview/viewport"] = "_control.itempage.scrollview.viewport",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/all/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.all.Background.Checkmark",
			["mall_shop/top_layer/top_btn/btnfour/btnimgfour"] = "_control.top_layer.top_btn.btnfour.btnimgfour",
			["mall_shop/top_layer/line_group"] = "_control.top_layer.line_group",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_music/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_music.Background",
			["mall_shop/top_layer/line_group/btnlinetwo"] = "_control.top_layer.line_group.btnlinetwo",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/live/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.live.Background.Checkmark",
			["mall_shop/top_layer/user_res/bg"] = "_control.top_layer.user_res.bg",
			["mall_shop/diamonpage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.diamonpage.scrollview.scrollbarvertical.slidingarea.handle",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/using/Label"] = "_control.changepage.type_layer.bg.using_group.toggle_group.using.Label",
			["mall_shop/top_layer/top_btn/btnone/btnimg"] = "_control.top_layer.top_btn.btnone.btnimg",
			["mall_shop/bg/down_image"] = "_control.bg.down_image",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_music/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_music.Label",
			["mall_shop/top_layer/top_btn/btntwo"] = "_control.top_layer.top_btn.btntwo",
			["mall_shop/otherpage/scrollview/scrollbarvertical"] = "_control.otherpage.scrollview.scrollbarvertical",
			["mall_shop/top_layer/line_group/btnlinethree"] = "_control.top_layer.line_group.btnlinethree",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/shell_effect/title_mask"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect.title_mask",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/all/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.all.Background",
			["mall_shop/top_layer/top_btn/btnone/title_mask"] = "_control.top_layer.top_btn.btnone.title_mask",
			["mall_shop/changepage/type_layer/bg/btn_series"] = "_control.changepage.type_layer.bg.btn_series",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/bought/Background/Checkmark"] = "_control.changepage.type_layer.bg.using_group.toggle_group.bought.Background.Checkmark",
			["mall_shop/otherpage/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.otherpage.scrollview.scrollbarvertical.slidingarea.handle",
			["mall_shop/top_layer/top_btn/btntwo/text"] = "_control.top_layer.top_btn.btntwo.text",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_music/title_mask/txt"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_music.title_mask.txt",
			["mall_shop/top_layer/top_btn/btnvoucher"] = "_control.top_layer.top_btn.btnvoucher",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/airplane/title_mask/txt"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.airplane.title_mask.txt",
			["mall_shop/top_layer/top_btn/btnfive"] = "_control.top_layer.top_btn.btnfive",
			["mall_shop/otherpage/scrollview/viewport/content"] = "_control.otherpage.scrollview.viewport.content",
			["mall_shop/top_layer/top_btn/btnfive/btnimgfive"] = "_control.top_layer.top_btn.btnfive.btnimgfive",
			["mall_shop/top_layer/top_btn/btnfive/text"] = "_control.top_layer.top_btn.btnfive.text",
			["mall_shop/top_layer/top_btn/btnfour"] = "_control.top_layer.top_btn.btnfour",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_music/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_music.Background.Checkmark",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/using/Background/Checkmark"] = "_control.changepage.type_layer.bg.using_group.toggle_group.using.Background.Checkmark",
			["mall_shop/changepage/type_layer/bg/effect_group"] = "_control.changepage.type_layer.bg.effect_group",
			["mall_shop/itempage/scrollview"] = "_control.itempage.scrollview",
			["mall_shop/top_layer/line_group/leftline"] = "_control.top_layer.line_group.leftline",
			["mall_shop/top_layer/top_btn"] = "_control.top_layer.top_btn",
			["mall_shop/functionpage/scrollview/viewport/content"] = "_control.functionpage.scrollview.viewport.content",
			["mall_shop/top_layer/user_res/mineral_num"] = "_control.top_layer.user_res.mineral_num",
			["mall_shop/top_layer/user_res/iron_image"] = "_control.top_layer.user_res.iron_image",
			["mall_shop/top_layer/user_res/oil_num"] = "_control.top_layer.user_res.oil_num",
			["mall_shop/top_layer/user_res/bullet_num"] = "_control.top_layer.user_res.bullet_num",
			["mall_shop/top_layer/user_res/iron_num"] = "_control.top_layer.user_res.iron_num",
			["mall_shop/top_layer/sprite"] = "_control.top_layer.sprite",
			["mall_shop/diamonpage"] = "_control.diamonpage",
			["mall_shop/top_layer/user_res/oil_image"] = "_control.top_layer.user_res.oil_image",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/all/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.all.Label",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/live/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.live.Label",
			["mall_shop/top_layer/top_btn/btnvoucher/Text"] = "_control.top_layer.top_btn.btnvoucher.Text",
			["mall_shop/changepage/type_layer/bg/using_group"] = "_control.changepage.type_layer.bg.using_group",
			["mall_shop/top_layer/diamon_node"] = "_control.top_layer.diamon_node",
			["mall_shop/top_layer/diamon_node/diamond_num"] = "_control.top_layer.diamon_node.diamond_num",
			["mall_shop/changepage/type_layer/bg/btn_series/cancel_btn/cancel"] = "_control.changepage.type_layer.bg.btn_series.cancel_btn.cancel",
			["mall_shop/top_layer/diamon_node/icon"] = "_control.top_layer.diamon_node.icon",
			["mall_shop/changepage/type_layer/bg/filter_type/sort_title_line"] = "_control.changepage.type_layer.bg.filter_type.sort_title_line",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_using/Background/Checkmark"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_using.Background.Checkmark",
			["mall_shop/top_layer/search_btn/search"] = "_control.top_layer.search_btn.search",
			["mall_shop/top_layer/search_btn/search/input_text"] = "_control.top_layer.search_btn.search.input_text",
			["mall_shop/bottomline"] = "_control.bottomline",
			["mall_shop/changepage/type_layer/bg/line_mid"] = "_control.changepage.type_layer.bg.line_mid",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue.Background.Checkmark",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_bought/Background"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_bought.Background",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_bought/Background/Checkmark"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_bought.Background.Checkmark",
			["mall_shop/functionpage/scrollview/scrollbarvertical/slidingarea"] = "_control.functionpage.scrollview.scrollbarvertical.slidingarea",
			["mall_shop/top_layer/line_group/btnlinefour"] = "_control.top_layer.line_group.btnlinefour",
			["mall_shop/diamonpage/scrollview/viewport/content"] = "_control.diamonpage.scrollview.viewport.content",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/bought"] = "_control.changepage.type_layer.bg.using_group.toggle_group.bought",
			["mall_shop/changepage/scrollview/viewport/content"] = "_control.changepage.scrollview.viewport.content",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/shell_effect/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect.Label",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/bought/Label"] = "_control.changepage.type_layer.bg.using_group.toggle_group.bought.Label",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_using/Background"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_using.Background",
			["mall_shop/itempage/scrollview/scrollbarvertical/slidingarea"] = "_control.itempage.scrollview.scrollbarvertical.slidingarea",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue.Label",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/shell_effect/title_mask/txt_2"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect.title_mask.txt_2",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/all/Background"] = "_control.changepage.type_layer.bg.using_group.toggle_group.all.Background",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/airplane/title_mask"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.airplane.title_mask",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_bought/Label"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_bought.Label",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_menu/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu.Label",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/live/title_mask/txt_2"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.live.title_mask.txt_2",
			["mall_shop/top_layer/type_btn"] = "_control.top_layer.type_btn",
			["mall_shop/changepage/type_layer/bg/btn_series/confirm_btn"] = "_control.changepage.type_layer.bg.btn_series.confirm_btn",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/voice/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.voice.Label",
			["mall_shop/changepage/type_layer/bg/btn_series/cancel_btn"] = "_control.changepage.type_layer.bg.btn_series.cancel_btn",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_menu/title_mask/txt_2"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu.title_mask.txt_2",
			["mall_shop/functionpage"] = "_control.functionpage",
			["mall_shop/top_layer/top_btn/btnthree"] = "_control.top_layer.top_btn.btnthree",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_menu"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu",
			["mall_shop/changepage/scrollview/viewport"] = "_control.changepage.scrollview.viewport",
			["mall_shop/top_layer/type_btn/type_txt"] = "_control.top_layer.type_btn.type_txt",
			["mall_shop/diamonpage/scrollview/viewport"] = "_control.diamonpage.scrollview.viewport",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group"] = "_control.changepage.type_layer.bg.effect_group.toggle_group",
			["mall_shop/top_layer/top_btn/btnthree/text"] = "_control.top_layer.top_btn.btnthree.text",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/all/Label"] = "_control.changepage.type_layer.bg.using_group.toggle_group.all.Label",
			["mall_shop/top_layer/user_res"] = "_control.top_layer.user_res",
			["mall_shop/changepage/scrollview"] = "_control.changepage.scrollview",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/airplane/Label"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.airplane.Label",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/voice/title_mask"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.voice.title_mask",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/title_mask/txt"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue.title_mask.txt",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/shell_effect/title_mask/txt"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect.title_mask.txt",
			["mall_shop/top_layer/line_group/rightline"] = "_control.top_layer.line_group.rightline",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/voice/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.voice.Background",
			["mall_shop/changepage/type_layer/bg/btn_series/confirm_btn/confirm_mask/txt_2"] = "_control.txt_2",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group"] = "_control.changepage.type_layer.bg.using_group.toggle_group",
			["mall_shop/top_layer/type_btn/type_bg"] = "_control.top_layer.type_btn.type_bg",
			["mall_shop/top_layer/search_btn"] = "_control.top_layer.search_btn",
			["mall_shop/changepage/type_layer/bg/btn_series/confirm_btn/confirm_mask/txt"] = "_control.txt",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/all/Background/Checkmark"] = "_control.changepage.type_layer.bg.using_group.toggle_group.all.Background.Checkmark",
			["mall_shop/top_layer/user_res/mineral_inmage"] = "_control.top_layer.user_res.mineral_inmage",
			["mall_shop/itempage/scrollview/viewport/content"] = "_control.itempage.scrollview.viewport.content",
			["mall_shop/changepage/type_layer/bg/btn_series/confirm_btn/confirm"] = "_control.changepage.type_layer.bg.btn_series.confirm_btn.confirm",
			["mall_shop/top_layer/user_res/bullet_image"] = "_control.top_layer.user_res.bullet_image",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/live/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.live.Background",
			["mall_shop/itempage/scrollview/scrollbarvertical"] = "_control.itempage.scrollview.scrollbarvertical",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/shell_effect/Background/Checkmark"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect.Background.Checkmark",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/not_using"] = "_control.changepage.type_layer.bg.using_group.toggle_group.not_using",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue.Background",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/using/Background"] = "_control.changepage.type_layer.bg.using_group.toggle_group.using.Background",
			["mall_shop/top_layer/top_btn/btnfour/text"] = "_control.top_layer.top_btn.btnfour.text",
			["mall_shop/top_layer/type_btn/type"] = "_control.top_layer.type_btn.type",
			["mall_shop/otherpage"] = "_control.otherpage",
			["mall_shop/top_layer/top_btn/btntwo/btnimgtwo"] = "_control.top_layer.top_btn.btntwo.btnimgtwo",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/shell_effect/Background"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect.Background",
			["mall_shop/changepage/type_layer"] = "_control.changepage.type_layer",
			["mall_shop/changepage/type_layer/bg/using_group/toggle_group/bought/Background"] = "_control.changepage.type_layer.bg.using_group.toggle_group.bought.Background",
			["mall_shop/diamonpage/scrollview/scrollbarvertical"] = "_control.diamonpage.scrollview.scrollbarvertical",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/shell_effect"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect",
			["mall_shop/changepage/type_layer/bg/effect_group/toggle_group/voice"] = "_control.changepage.type_layer.bg.effect_group.toggle_group.voice",
			["mall_shop/changepage/scrollview/scrollbarvertical"] = "_control.changepage.scrollview.scrollbarvertical",
			["mall_shop/changepage"] = "_control.changepage"
		},
		click = {
			["changepage/type_layer/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["changepage/type_layer/bg/btn_series/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["changepage/type_layer/bg/btn_series/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top_layer/search_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top_layer/type_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["top_layer/top_btn/btnvoucher"] = {
				tp = "ScaleButton"
			},
			["top_layer/returnbtn"] = {
				tp = "ScaleButton"
			}
		},
		toggle = {
			["changepage/type_layer/bg/effect_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/effect_group/toggle_group/shell_effect"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/effect_group/toggle_group/live"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/effect_group/toggle_group/sp_music"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/effect_group/toggle_group/sp_dialogue"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/effect_group/toggle_group/sp_menu"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/effect_group/toggle_group/airplane"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/effect_group/toggle_group/voice"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/using_group/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/using_group/toggle_group/bought"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/using_group/toggle_group/not_bought"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/using_group/toggle_group/using"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["changepage/type_layer/bg/using_group/toggle_group/not_using"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/top_btn/btnone"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/top_btn/btntwo"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/top_btn/btnthree"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/top_btn/btnfour"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["top_layer/top_btn/btnfive"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

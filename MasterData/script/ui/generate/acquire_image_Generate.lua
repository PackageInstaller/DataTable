return {
	_rule_ = {
		none = {
			emptybox = {
				path = "emptybox",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			black = {
				path = "black",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			main = {
				path = "main",
				list = {
					main_bg_1 = {
						path = "main/main_bg_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main_bg_2 = {
						path = "main/main_bg_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main_bg_3 = {
						path = "main/main_bg_3",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top = {
						path = "main/top",
						list = {
							title = {
								path = "main/top/title",
								list = {
									three_point = {
										path = "main/top/title/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.ContentSizeFitter"
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
							top_decore = {
								path = "main/top/top_decore",
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
					reduce_cd = {
						path = "main/reduce_cd",
						list = {
							rewards = {
								path = "main/reduce_cd/rewards",
								list = {
									scrollview = {
										path = "main/reduce_cd/rewards/scrollview",
										list = {
											content = {
												path = "main/reduce_cd/rewards/scrollview/content",
												list = {
													reward_1 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_1",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_1/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_1/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_1/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_1/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_1/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_1/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_2 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_2",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_2/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_2/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_2/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_2/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_2/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_2/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_3 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_3",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_3/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_3/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_3/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_3/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_3/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_3/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_4 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_4",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_4/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_4/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_4/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_4/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_4/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_4/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_5 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_5",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_5/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_5/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_5/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_5/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_5/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_5/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_6 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_6",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_6/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_6/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_6/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_6/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_6/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_6/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_7 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_7",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_7/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_7/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_7/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_7/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_7/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_7/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_8 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_8",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_8/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_8/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_8/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_8/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_8/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_8/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_9 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_9",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_9/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_9/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_9/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_9/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_9/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_9/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_10 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_10",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_10/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_10/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_10/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_10/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_10/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_10/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_11 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_11",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_11/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_11/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_11/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_11/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_11/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_11/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_12 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_12",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_12/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_12/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_12/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_12/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_12/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_12/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_13 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_13",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_13/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_13/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_13/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_13/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_13/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_13/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_14 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_14",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_14/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_14/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_14/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_14/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_14/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_14/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_15 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_15",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_15/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_15/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_15/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_15/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_15/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_15/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_16 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_16",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_16/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_16/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_16/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_16/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_16/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_16/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_17 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_17",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_17/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_17/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_17/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_17/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_17/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_17/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_18 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_18",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_18/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_18/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_18/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_18/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_18/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_18/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_19 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_19",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_19/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_19/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_19/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_19/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_19/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_19/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_20 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_20",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_20/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_20/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_20/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_20/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_20/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_20/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_21 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_21",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_21/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_21/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_21/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_21/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_21/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_21/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_22 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_22",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_22/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_22/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_22/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_22/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_22/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_22/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_23 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_23",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_23/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_23/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_23/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_23/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_23/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_23/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_24 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_24",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_24/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_24/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_24/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_24/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_24/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_24/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													reward_25 = {
														path = "main/reduce_cd/rewards/scrollview/content/reward_25",
														list = {
															bg = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_25/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_25/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_25/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/reduce_cd/rewards/scrollview/content/reward_25/title_mask",
																list = {
																	reward_name = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_25/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/reduce_cd/rewards/scrollview/content/reward_25/title_mask/reward_name_two",
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
															}
														},
														component = {
															"UnityEngine.RectTransform"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.UI.ContentSizeFitter"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ScrollRect",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Mask"
										}
									},
									Scrollbar = {
										path = "main/reduce_cd/rewards/Scrollbar",
										list = {
											["Sliding Area"] = {
												path = "main/reduce_cd/rewards/Scrollbar/Sliding Area",
												list = {
													Handle = {
														path = "main/reduce_cd/rewards/Scrollbar/Sliding Area/Handle",
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
									"UnityEngine.RectTransform"
								}
							},
							awardcontent = {
								path = "main/reduce_cd/awardcontent",
								list = {
									scrollview = {
										path = "main/reduce_cd/awardcontent/scrollview",
										list = {
											viewport = {
												path = "main/reduce_cd/awardcontent/scrollview/viewport",
												list = {
													content = {
														path = "main/reduce_cd/awardcontent/scrollview/viewport/content",
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
												path = "main/reduce_cd/awardcontent/scrollview/scrollbarvertical",
												list = {
													slidingarea = {
														path = "main/reduce_cd/awardcontent/scrollview/scrollbarvertical/slidingarea",
														list = {
															handle = {
																path = "main/reduce_cd/awardcontent/scrollview/scrollbarvertical/slidingarea/handle",
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
									"UIMoveTweener"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					confirm = {
						path = "main/confirm",
						list = {
							text = {
								path = "main/confirm/text",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		click = {
			["main/confirm"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

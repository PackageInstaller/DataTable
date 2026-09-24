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
					main_bg = {
						path = "main/main_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top_decore = {
						path = "main/top_decore",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top = {
						path = "main/top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "main/title",
						list = {
							three_point = {
								path = "main/title/three_point",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							three_point_get = {
								path = "main/title/three_point_get",
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
					back = {
						path = "main/back",
						list = {
							text = {
								path = "main/back/text",
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
					},
					one = {
						path = "main/one",
						list = {
							text = {
								path = "main/one/text",
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
					close = {
						path = "main/close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					tip = {
						path = "main/tip",
						list = {
							text = {
								path = "main/tip/text",
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
					reduce_cd = {
						path = "main/reduce_cd",
						list = {
							title = {
								path = "main/reduce_cd/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							item_1 = {
								path = "main/reduce_cd/item_1",
								list = {
									arrow = {
										path = "main/reduce_cd/item_1/arrow",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "main/reduce_cd/item_1/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									cur = {
										path = "main/reduce_cd/item_1/cur",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									next = {
										path = "main/reduce_cd/item_1/next",
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
							item_2 = {
								path = "main/reduce_cd/item_2",
								list = {
									arrow = {
										path = "main/reduce_cd/item_2/arrow",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "main/reduce_cd/item_2/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									cur = {
										path = "main/reduce_cd/item_2/cur",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									next = {
										path = "main/reduce_cd/item_2/next",
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
							"UnityEngine.RectTransform"
						}
					},
					get_res = {
						path = "main/get_res",
						list = {
							line = {
								path = "main/get_res/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							source_1 = {
								path = "main/get_res/source_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							source_2 = {
								path = "main/get_res/source_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							source_3 = {
								path = "main/get_res/source_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							source_4 = {
								path = "main/get_res/source_4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							number_1 = {
								path = "main/get_res/number_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							number_2 = {
								path = "main/get_res/number_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							number_3 = {
								path = "main/get_res/number_3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							number_4 = {
								path = "main/get_res/number_4",
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
					rewards = {
						path = "main/rewards",
						list = {
							scrollview = {
								path = "main/rewards/scrollview",
								list = {
									viewport = {
										path = "main/rewards/scrollview/viewport",
										list = {
											content = {
												path = "main/rewards/scrollview/viewport/content",
												list = {
													rewardone = {
														path = "main/rewards/scrollview/viewport/content/rewardone",
														list = {
															bg = {
																path = "main/rewards/scrollview/viewport/content/rewardone/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/rewards/scrollview/viewport/content/rewardone/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/rewards/scrollview/viewport/content/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/rewards/scrollview/viewport/content/rewardone/title_mask",
																list = {
																	reward_name = {
																		path = "main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name_two",
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
													rewardtwo = {
														path = "main/rewards/scrollview/viewport/content/rewardtwo",
														list = {
															bg = {
																path = "main/rewards/scrollview/viewport/content/rewardtwo/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/rewards/scrollview/viewport/content/rewardtwo/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/rewards/scrollview/viewport/content/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/rewards/scrollview/viewport/content/rewardtwo/title_mask",
																list = {
																	reward_name = {
																		path = "main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name_two",
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
													rewardthree = {
														path = "main/rewards/scrollview/viewport/content/rewardthree",
														list = {
															bg = {
																path = "main/rewards/scrollview/viewport/content/rewardthree/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/rewards/scrollview/viewport/content/rewardthree/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/rewards/scrollview/viewport/content/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/rewards/scrollview/viewport/content/rewardthree/title_mask",
																list = {
																	reward_name = {
																		path = "main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name_two",
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
													rewardfour = {
														path = "main/rewards/scrollview/viewport/content/rewardfour",
														list = {
															bg = {
																path = "main/rewards/scrollview/viewport/content/rewardfour/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/rewards/scrollview/viewport/content/rewardfour/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/rewards/scrollview/viewport/content/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/rewards/scrollview/viewport/content/rewardfour/title_mask",
																list = {
																	reward_name = {
																		path = "main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name_two",
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
													rewardfive = {
														path = "main/rewards/scrollview/viewport/content/rewardfive",
														list = {
															bg = {
																path = "main/rewards/scrollview/viewport/content/rewardfive/bg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															icon = {
																path = "main/rewards/scrollview/viewport/content/rewardfive/icon",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "main/rewards/scrollview/viewport/content/rewardfive/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															title_mask = {
																path = "main/rewards/scrollview/viewport/content/rewardfive/title_mask",
																list = {
																	reward_name = {
																		path = "main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text"
																		}
																	},
																	reward_name_two = {
																		path = "main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name_two",
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
													"UnityEngine.UI.HorizontalLayoutGroup",
													"UnityEngine.UI.ContentSizeFitter"
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
							"UnityEngine.RectTransform"
						}
					},
					reward = {
						path = "main/reward",
						list = {
							bg = {
								path = "main/reward/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "main/reward/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							number = {
								path = "main/reward/number",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.Outline"
								}
							},
							reward_mask = {
								path = "main/reward/reward_mask",
								list = {
									reward_name = {
										path = "main/reward/reward_mask/reward_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									reward_name_two = {
										path = "main/reward/reward_mask/reward_name_two",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			Image = {
				path = "Image",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		click = {
			["main/back"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/one"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/close"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

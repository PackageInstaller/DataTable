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
					three = {
						path = "main/three",
						list = {
							text = {
								path = "main/three/text",
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
		call_node_list = {
			["msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name"] = "_control.main.rewards.scrollview.viewport.content.rewardtwo.title_mask.reward_name",
			["msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name_two"] = "_control.main.rewards.scrollview.viewport.content.rewardtwo.title_mask.reward_name_two",
			["msgbox/main/back"] = "_control.main.back",
			["msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name_two"] = "_control.main.rewards.scrollview.viewport.content.rewardone.title_mask.reward_name_two",
			["msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask"] = "_control.main.rewards.scrollview.viewport.content.rewardone.title_mask",
			["msgbox/main/rewards/scrollview/viewport/content/rewardone/icon"] = "_control.main.rewards.scrollview.viewport.content.rewardone.icon",
			["msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask"] = "_control.main.rewards.scrollview.viewport.content.rewardthree.title_mask",
			["msgbox/main/rewards/scrollview/viewport"] = "_control.main.rewards.scrollview.viewport",
			["msgbox/main/reduce_cd/item_2/next"] = "_control.main.reduce_cd.item_2.next",
			["msgbox/main/rewards/scrollview/viewport/content/rewardthree/number"] = "_control.main.rewards.scrollview.viewport.content.rewardthree.number",
			["msgbox/main/reduce_cd/item_2/title"] = "_control.main.reduce_cd.item_2.title",
			["msgbox/main/get_res/source_3"] = "_control.main.get_res.source_3",
			["msgbox/main/get_res"] = "_control.main.get_res",
			["msgbox/main/reward"] = "_control.main.reward",
			["msgbox/main/reduce_cd/item_2/arrow"] = "_control.main.reduce_cd.item_2.arrow",
			["msgbox/main/rewards/scrollview/viewport/content/rewardone/bg"] = "_control.main.rewards.scrollview.viewport.content.rewardone.bg",
			["msgbox/main/reduce_cd/title"] = "_control.main.reduce_cd.title",
			["msgbox/main/reward/reward_mask/reward_name_two"] = "_control.main.reward.reward_mask.reward_name_two",
			["msgbox/main/tip"] = "_control.main.tip",
			["msgbox/main/tip/text"] = "_control.main.tip.text",
			["msgbox/main/reduce_cd/item_1/cur"] = "_control.main.reduce_cd.item_1.cur",
			["msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name"] = "_control.main.rewards.scrollview.viewport.content.rewardone.title_mask.reward_name",
			["msgbox/main/rewards/scrollview/viewport/content/rewardone/number"] = "_control.main.rewards.scrollview.viewport.content.rewardone.number",
			["msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name"] = "_control.main.rewards.scrollview.viewport.content.rewardthree.title_mask.reward_name",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfour/icon"] = "_control.main.rewards.scrollview.viewport.content.rewardfour.icon",
			["msgbox/main/three/text"] = "_control.main.three.text",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name_two"] = "_control.main.rewards.scrollview.viewport.content.rewardfour.title_mask.reward_name_two",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfive/icon"] = "_control.main.rewards.scrollview.viewport.content.rewardfive.icon",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfive/number"] = "_control.main.rewards.scrollview.viewport.content.rewardfive.number",
			["msgbox/main/confirm"] = "_control.main.confirm",
			["msgbox/main/confirm/text"] = "_control.main.confirm.text",
			["msgbox/main/one/text"] = "_control.main.one.text",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask"] = "_control.main.rewards.scrollview.viewport.content.rewardfive.title_mask",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfive/bg"] = "_control.main.rewards.scrollview.viewport.content.rewardfive.bg",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name"] = "_control.main.rewards.scrollview.viewport.content.rewardfive.title_mask.reward_name",
			["msgbox/main/title/three_point"] = "_control.main.title.three_point",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name_two"] = "_control.main.rewards.scrollview.viewport.content.rewardfive.title_mask.reward_name_two",
			["msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name_two"] = "_control.main.rewards.scrollview.viewport.content.rewardthree.title_mask.reward_name_two",
			["msgbox/main/top"] = "_control.main.top",
			["msgbox/main/get_res/source_1"] = "_control.main.get_res.source_1",
			["msgbox/main/reward/icon"] = "_control.main.reward.icon",
			["msgbox/main/reward/bg"] = "_control.main.reward.bg",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name"] = "_control.main.rewards.scrollview.viewport.content.rewardfour.title_mask.reward_name",
			["msgbox/main/reward/number"] = "_control.main.reward.number",
			["msgbox/black"] = "_control.black",
			["msgbox/main/back/text"] = "_control.main.back.text",
			["msgbox/Image"] = "_control.Image",
			["msgbox/main/reward/reward_mask"] = "_control.main.reward.reward_mask",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfour"] = "_control.main.rewards.scrollview.viewport.content.rewardfour",
			["msgbox/main/get_res/source_2"] = "_control.main.get_res.source_2",
			["msgbox/main/reduce_cd"] = "_control.main.reduce_cd",
			["msgbox/main"] = "_control.main",
			["msgbox/main/rewards/scrollview/viewport/content"] = "_control.main.rewards.scrollview.viewport.content",
			["msgbox/main/one"] = "_control.main.one",
			["msgbox/emptybox"] = "_control.emptybox",
			["msgbox/main/get_res/number_1"] = "_control.main.get_res.number_1",
			["msgbox/main/title/three_point_get"] = "_control.main.title.three_point_get",
			["msgbox/main/get_res/number_2"] = "_control.main.get_res.number_2",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfour/bg"] = "_control.main.rewards.scrollview.viewport.content.rewardfour.bg",
			["msgbox/main/rewards/scrollview/viewport/content/rewardthree/icon"] = "_control.main.rewards.scrollview.viewport.content.rewardthree.icon",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfour/number"] = "_control.main.rewards.scrollview.viewport.content.rewardfour.number",
			["msgbox/main/rewards/scrollview/viewport/content/rewardone"] = "_control.main.rewards.scrollview.viewport.content.rewardone",
			["msgbox/main/get_res/number_4"] = "_control.main.get_res.number_4",
			["msgbox/main/reduce_cd/item_1/title"] = "_control.main.reduce_cd.item_1.title",
			["msgbox/main/reduce_cd/item_1/next"] = "_control.main.reduce_cd.item_1.next",
			["msgbox/main/reduce_cd/item_1"] = "_control.main.reduce_cd.item_1",
			["msgbox/main/rewards/scrollview/viewport/content/rewardtwo"] = "_control.main.rewards.scrollview.viewport.content.rewardtwo",
			["msgbox/main/main_bg"] = "_control.main.main_bg",
			["msgbox/main/get_res/line"] = "_control.main.get_res.line",
			["msgbox/main/get_res/number_3"] = "_control.main.get_res.number_3",
			["msgbox/main/rewards/scrollview/viewport/content/rewardtwo/number"] = "_control.main.rewards.scrollview.viewport.content.rewardtwo.number",
			["msgbox/main/reward/reward_mask/reward_name"] = "_control.main.reward.reward_mask.reward_name",
			["msgbox/main/title"] = "_control.main.title",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfive"] = "_control.main.rewards.scrollview.viewport.content.rewardfive",
			["msgbox/main/get_res/source_4"] = "_control.main.get_res.source_4",
			["msgbox/main/rewards/scrollview/viewport/content/rewardthree/bg"] = "_control.main.rewards.scrollview.viewport.content.rewardthree.bg",
			["msgbox/main/three"] = "_control.main.three",
			["msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask"] = "_control.main.rewards.scrollview.viewport.content.rewardfour.title_mask",
			["msgbox/main/rewards/scrollview"] = "_control.main.rewards.scrollview",
			["msgbox/main/top_decore"] = "_control.main.top_decore",
			["msgbox/main/rewards"] = "_control.main.rewards",
			["msgbox/main/reduce_cd/item_1/arrow"] = "_control.main.reduce_cd.item_1.arrow",
			["msgbox/main/reduce_cd/item_2/cur"] = "_control.main.reduce_cd.item_2.cur",
			["msgbox/main/rewards/scrollview/viewport/content/rewardthree"] = "_control.main.rewards.scrollview.viewport.content.rewardthree",
			["msgbox/main/reduce_cd/item_2"] = "_control.main.reduce_cd.item_2",
			["msgbox/main/rewards/scrollview/viewport/content/rewardtwo/icon"] = "_control.main.rewards.scrollview.viewport.content.rewardtwo.icon",
			["msgbox/main/close"] = "_control.main.close",
			["msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask"] = "_control.main.rewards.scrollview.viewport.content.rewardtwo.title_mask",
			["msgbox/main/rewards/scrollview/viewport/content/rewardtwo/bg"] = "_control.main.rewards.scrollview.viewport.content.rewardtwo.bg"
		},
		click = {
			["main/back"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/three"] = {
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

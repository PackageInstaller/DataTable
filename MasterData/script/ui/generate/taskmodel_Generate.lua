return {
	_rule_ = {
		none = {
			main = {
				path = "main",
				list = {
					maintask = {
						path = "main/maintask",
						list = {
							typebg = {
								path = "main/maintask/typebg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							typeimg = {
								path = "main/maintask/typeimg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							activity = {
								path = "main/maintask/activity",
								list = {
									content = {
										path = "main/maintask/activity/content",
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
							markone = {
								path = "main/maintask/markone",
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
					line = {
						path = "main/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					progress = {
						path = "main/progress",
						list = {
							text = {
								path = "main/progress/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							number = {
								path = "main/progress/number",
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
					finish = {
						path = "main/finish",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					nametimefinish = {
						path = "main/nametimefinish",
						list = {
							namearea = {
								path = "main/nametimefinish/namearea",
								list = {
									taskname = {
										path = "main/nametimefinish/namearea/taskname",
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
							goal = {
								path = "main/nametimefinish/goal",
								list = {
									taskgoal = {
										path = "main/nametimefinish/goal/taskgoal",
										list = {
											goalmain_move = {
												path = "main/nametimefinish/goal/taskgoal/goalmain_move",
												list = {
													goalmain = {
														path = "main/nametimefinish/goal/taskgoal/goalmain_move/goalmain",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													goalmain_two = {
														path = "main/nametimefinish/goal/taskgoal/goalmain_move/goalmain_two",
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
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									goalmain = {
										path = "main/nametimefinish/goal/goalmain",
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
							tasktime = {
								path = "main/nametimefinish/tasktime",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							gobtn = {
								path = "main/nametimefinish/gobtn",
								list = {
									text = {
										path = "main/nametimefinish/gobtn/text",
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
							finishbtn = {
								path = "main/nametimefinish/finishbtn",
								list = {
									text = {
										path = "main/nametimefinish/finishbtn/text",
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
							unknowtwo = {
								path = "main/nametimefinish/unknowtwo",
								list = {
									img = {
										path = "main/nametimefinish/unknowtwo/img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "main/nametimefinish/unknowtwo/text",
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
					taskreward = {
						path = "main/taskreward",
						list = {
							rewardbg = {
								path = "main/taskreward/rewardbg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							reward = {
								path = "main/taskreward/reward",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							rewartypeone = {
								path = "main/taskreward/rewartypeone",
								list = {
									bg = {
										path = "main/taskreward/rewartypeone/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardimg = {
										path = "main/taskreward/rewartypeone/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_move_text = {
										path = "main/taskreward/rewartypeone/reward_move_text",
										list = {
											rewardname = {
												path = "main/taskreward/rewartypeone/reward_move_text/rewardname",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											rewardname_two = {
												path = "main/taskreward/rewartypeone/reward_move_text/rewardname_two",
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
							rewartypetwo = {
								path = "main/taskreward/rewartypetwo",
								list = {
									bg = {
										path = "main/taskreward/rewartypetwo/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardimg = {
										path = "main/taskreward/rewartypetwo/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_move_text = {
										path = "main/taskreward/rewartypetwo/reward_move_text",
										list = {
											rewardname = {
												path = "main/taskreward/rewartypetwo/reward_move_text/rewardname",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											rewardname_two = {
												path = "main/taskreward/rewartypetwo/reward_move_text/rewardname_two",
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
							rewartypethree = {
								path = "main/taskreward/rewartypethree",
								list = {
									bg = {
										path = "main/taskreward/rewartypethree/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardimg = {
										path = "main/taskreward/rewartypethree/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_move_text = {
										path = "main/taskreward/rewartypethree/reward_move_text",
										list = {
											rewardname = {
												path = "main/taskreward/rewartypethree/reward_move_text/rewardname",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											rewardname_two = {
												path = "main/taskreward/rewartypethree/reward_move_text/rewardname_two",
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
							rewartypefour = {
								path = "main/taskreward/rewartypefour",
								list = {
									bg = {
										path = "main/taskreward/rewartypefour/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardimg = {
										path = "main/taskreward/rewartypefour/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_move_text = {
										path = "main/taskreward/rewartypefour/reward_move_text",
										list = {
											rewardname = {
												path = "main/taskreward/rewartypefour/reward_move_text/rewardname",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											rewardname_two = {
												path = "main/taskreward/rewartypefour/reward_move_text/rewardname_two",
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
							rewartypefive = {
								path = "main/taskreward/rewartypefive",
								list = {
									bg = {
										path = "main/taskreward/rewartypefive/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardimg = {
										path = "main/taskreward/rewartypefive/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_move_text = {
										path = "main/taskreward/rewartypefive/reward_move_text",
										list = {
											rewardname = {
												path = "main/taskreward/rewartypefive/reward_move_text/rewardname",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											rewardname_two = {
												path = "main/taskreward/rewartypefive/reward_move_text/rewardname_two",
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
							rewartypesix = {
								path = "main/taskreward/rewartypesix",
								list = {
									bg = {
										path = "main/taskreward/rewartypesix/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									rewardimg = {
										path = "main/taskreward/rewartypesix/rewardimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_move_text = {
										path = "main/taskreward/rewartypesix/reward_move_text",
										list = {
											rewardname = {
												path = "main/taskreward/rewartypesix/reward_move_text/rewardname",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											rewardname_two = {
												path = "main/taskreward/rewartypesix/reward_move_text/rewardname_two",
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
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["main/nametimefinish/gobtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/nametimefinish/finishbtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

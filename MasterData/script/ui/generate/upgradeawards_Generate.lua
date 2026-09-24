return {
	_rule_ = {
		none = {
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			mainfragment = {
				path = "mainfragment",
				list = {
					bg = {
						path = "mainfragment/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					mask = {
						path = "mainfragment/mask",
						list = {
							glow = {
								path = "mainfragment/mask/glow",
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
							"UnityEngine.UI.Mask"
						}
					},
					titlebg = {
						path = "mainfragment/titlebg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close = {
						path = "mainfragment/close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					point = {
						path = "mainfragment/point",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "mainfragment/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line = {
						path = "mainfragment/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					scrollview = {
						path = "mainfragment/scrollview",
						list = {
							viewport = {
								path = "mainfragment/scrollview/viewport",
								list = {
									content = {
										path = "mainfragment/scrollview/viewport/content",
										list = {
											upgraderewardsone = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardsone",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/get/text",
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
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/btn",
																list = {},
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
													rewardfive = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/btn",
																list = {},
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
													rewardsix = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardstwo = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardstwo",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardsthree = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardsthree",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/btn",
																list = {},
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
													rewardfive = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/btn",
																list = {},
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
													rewardsix = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardsfour = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardsfour",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/btn",
																list = {},
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
													rewardfive = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardsfive = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardsfive",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardssix = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardssix",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardsseven = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardsseven",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardseight = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardseight",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardsnine = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardsnine",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/btn",
																list = {},
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
													"UnityEngine.RectTransform"
												}
											},
											upgraderewardsten = {
												path = "mainfragment/scrollview/viewport/content/upgraderewardsten",
												list = {
													bg = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													nowlv = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/nowlv",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													get = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/get",
														list = {
															text = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/get/text",
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
													unknow = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/unknow",
														list = {},
														component = {
															"UnityEngine.RectTransform"
														}
													},
													rewardone = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/btn",
																list = {},
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
													rewardtwo = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/btn",
																list = {},
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
													rewardthree = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/btn",
																list = {},
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
													rewardfour = {
														path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour",
														list = {
															rewardbg = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/rewardbg",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															reward = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/reward",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															number = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/number",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text",
																	"UnityEngine.UI.Outline"
																}
															},
															finish = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/finish",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															btn = {
																path = "mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/btn",
																list = {},
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							scrollbarvertical = {
								path = "mainfragment/scrollview/scrollbarvertical",
								list = {
									slidingarea = {
										path = "mainfragment/scrollview/scrollbarvertical/slidingarea",
										list = {
											handle = {
												path = "mainfragment/scrollview/scrollbarvertical/slidingarea/handle",
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
					"UIScaleTweener",
					"UIScaleTweener"
				}
			}
		},
		call_node_list = {
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardsix.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardsix.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardone.number",
			["upgradeawards/mainfragment/line"] = "_control.mainfragment.line",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfive.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.get",
			["upgradeawards/mask"] = "_control.mask",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.bg",
			["upgradeawards/mainfragment/mask/glow"] = "_control.mainfragment.mask.glow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardsix.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfive.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfive.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfive.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfive.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfive.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfive.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardsix.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardsix.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardsix.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfive.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardsix.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardsix.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfive.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfive.reward",
			["upgradeawards/mainfragment/point"] = "_control.mainfragment.point",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfive",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardsix.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardthree.finish",
			["upgradeawards/mainfragment/title"] = "_control.mainfragment.title",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfive.finish",
			["upgradeawards/mainfragment/scrollview/viewport"] = "_control.mainfragment.scrollview.viewport",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfive.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardsix.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfive.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfive.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/scrollbarvertical"] = "_control.mainfragment.scrollview.scrollbarvertical",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.bg",
			["upgradeawards/mainfragment/titlebg"] = "_control.mainfragment.titlebg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.unknow",
			["upgradeawards/mainfragment/scrollview/scrollbarvertical/slidingarea"] = "_control.mainfragment.scrollview.scrollbarvertical.slidingarea",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content"] = "_control.mainfragment.scrollview.viewport.content",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardthree.btn",
			["upgradeawards/mainfragment/mask"] = "_control.mainfragment.mask",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/nowlv"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.nowlv",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/unknow"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.unknow",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardone",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardone.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardone.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardone.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardtwo",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardtwo.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardtwo.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardthree.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardthree.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardthree.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardfour",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardfour.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardfour.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsnine.rewardone",
			["upgradeawards/mainfragment/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.mainfragment.scrollview.scrollbarvertical.slidingarea.handle",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardtwo",
			["upgradeawards/mainfragment/scrollview"] = "_control.mainfragment.scrollview",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/rewardbg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardtwo.rewardbg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.rewardthree",
			["upgradeawards/mainfragment"] = "_control.mainfragment",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardthree",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfive/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfive.get.text",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardthree.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardthree.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardtwo.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/reward"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardfour.reward",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardone.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardone.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/get"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.get",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/btn"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsseven.rewardfour.btn",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardsix",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/finish"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix.rewardfour.finish",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardsix",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsthree.rewardfive",
			["upgradeawards/mainfragment/bg"] = "_control.mainfragment.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.rewardfive",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.rewardfive.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/number"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardtwo.number",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsfour/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsfour.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsten/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsten.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardsone/bg"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardsone.bg",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardseight.rewardone",
			["upgradeawards/mainfragment/close"] = "_control.mainfragment.close",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardssix"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardssix",
			["upgradeawards/mainfragment/scrollview/viewport/content/upgraderewardstwo/get/text"] = "_control.mainfragment.scrollview.viewport.content.upgraderewardstwo.get.text"
		},
		click = {
			["mainfragment/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsone/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsone/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsone/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsone/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsone/rewardfive/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsone/rewardsix/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardstwo/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardstwo/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsthree/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardfive/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsthree/rewardsix/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfour/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfour/rewardfive/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfive/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsfive/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardssix/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardssix/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardssix/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardssix/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardssix/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsseven/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsseven/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardseight/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardseight/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardseight/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardseight/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardseight/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsnine/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsnine/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsten/get"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsten/rewardone/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsten/rewardtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsten/rewardthree/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mainfragment/scrollview/viewport/content/upgraderewardsten/rewardfour/btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

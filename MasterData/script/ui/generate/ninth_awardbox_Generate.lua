return {
	_rule_ = {
		none = {
			bg_shadow = {
				path = "bg_shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			awardbox_bg = {
				path = "awardbox_bg",
				list = {
					top = {
						path = "awardbox_bg/top",
						list = {
							toptitle = {
								path = "awardbox_bg/top/toptitle",
								list = {
									title = {
										path = "awardbox_bg/top/toptitle/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UITweenSequence"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							topdescribe = {
								path = "awardbox_bg/top/topdescribe",
								list = {
									des_text = {
										path = "awardbox_bg/top/topdescribe/des_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									point_icon = {
										path = "awardbox_bg/top/topdescribe/point_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									point_text = {
										path = "awardbox_bg/top/topdescribe/point_text",
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
							close = {
								path = "awardbox_bg/top/close",
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
					middle = {
						path = "awardbox_bg/middle",
						list = {
							awardcontent = {
								path = "awardbox_bg/middle/awardcontent",
								list = {
									scrollview = {
										path = "awardbox_bg/middle/awardcontent/scrollview",
										list = {
											viewport = {
												path = "awardbox_bg/middle/awardcontent/scrollview/viewport",
												list = {
													content = {
														path = "awardbox_bg/middle/awardcontent/scrollview/viewport/content",
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
												path = "awardbox_bg/middle/awardcontent/scrollview/scrollbarvertical",
												list = {
													slidingarea = {
														path = "awardbox_bg/middle/awardcontent/scrollview/scrollbarvertical/slidingarea",
														list = {
															handle = {
																path = "awardbox_bg/middle/awardcontent/scrollview/scrollbarvertical/slidingarea/handle",
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
			detail_shadow = {
				path = "detail_shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence",
					"UnityEngine.UI.Button"
				}
			},
			award_msgbox = {
				path = "award_msgbox",
				list = {
					emptybox = {
						path = "award_msgbox/emptybox",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					black = {
						path = "award_msgbox/black",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					main = {
						path = "award_msgbox/main",
						list = {
							main_bg = {
								path = "award_msgbox/main/main_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_decore = {
								path = "award_msgbox/main/top_decore",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top = {
								path = "award_msgbox/main/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_text = {
								path = "award_msgbox/main/title_text",
								list = {
									three_point = {
										path = "award_msgbox/main/title_text/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									three_point_get = {
										path = "award_msgbox/main/title_text/three_point_get",
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
							confirm = {
								path = "award_msgbox/main/confirm",
								list = {
									text = {
										path = "award_msgbox/main/confirm/text",
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
								path = "award_msgbox/main/close",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							rewards = {
								path = "award_msgbox/main/rewards",
								list = {
									scrollview = {
										path = "award_msgbox/main/rewards/scrollview",
										list = {
											viewport = {
												path = "award_msgbox/main/rewards/scrollview/viewport",
												list = {
													content = {
														path = "award_msgbox/main/rewards/scrollview/viewport/content",
														list = {
															rewardone = {
																path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardone",
																list = {
																	bg = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardone/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardone/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardone/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask",
																		list = {
																			reward_name = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name_two",
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
																path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo",
																list = {
																	bg = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask",
																		list = {
																			reward_name = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name_two",
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
																path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardthree",
																list = {
																	bg = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask",
																		list = {
																			reward_name = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name_two",
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
																path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfour",
																list = {
																	bg = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask",
																		list = {
																			reward_name = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name_two",
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
																path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfive",
																list = {
																	bg = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask",
																		list = {
																			reward_name = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name_two",
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
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		call_node_list = {
			["ninth_awardbox/awardbox_bg/top"] = "_control.awardbox_bg.top",
			["ninth_awardbox/award_msgbox/emptybox"] = "_control.award_msgbox.emptybox",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name_two"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour.title_mask.reward_name_two",
			["ninth_awardbox/detail_shadow"] = "_control.detail_shadow",
			["ninth_awardbox/awardbox_bg/middle/awardcontent/scrollview/scrollbarvertical/slidingarea/handle"] = "_control.awardbox_bg.middle.awardcontent.scrollview.scrollbarvertical.slidingarea.handle",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/number"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour.number",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/number"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo.number",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content",
			["ninth_awardbox/awardbox_bg/middle/awardcontent"] = "_control.awardbox_bg.middle.awardcontent",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardone/icon"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone.icon",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardone/number"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone.number",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone.title_mask",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name_two"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone.title_mask.reward_name_two",
			["ninth_awardbox/award_msgbox/main/title_text/three_point"] = "_control.award_msgbox.main.title_text.three_point",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour.title_mask",
			["ninth_awardbox/awardbox_bg/top/topdescribe/point_icon"] = "_control.awardbox_bg.top.topdescribe.point_icon",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport"] = "_control.award_msgbox.main.rewards.scrollview.viewport",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/icon"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo.icon",
			["ninth_awardbox/awardbox_bg/middle/awardcontent/scrollview/viewport"] = "_control.awardbox_bg.middle.awardcontent.scrollview.viewport",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo.title_mask",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo.title_mask.reward_name",
			["ninth_awardbox/award_msgbox/main/title_text/three_point_get"] = "_control.award_msgbox.main.title_text.three_point_get",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/bg"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour.bg",
			["ninth_awardbox/awardbox_bg/top/topdescribe/point_text"] = "_control.awardbox_bg.top.topdescribe.point_text",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/bg"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo.bg",
			["ninth_awardbox/awardbox_bg/top/toptitle"] = "_control.awardbox_bg.top.toptitle",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/bg"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive.bg",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/icon"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive.icon",
			["ninth_awardbox/awardbox_bg/top/topdescribe"] = "_control.awardbox_bg.top.topdescribe",
			["ninth_awardbox/award_msgbox/main/rewards"] = "_control.award_msgbox.main.rewards",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/number"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive.number",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive.title_mask",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive.title_mask.reward_name",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name_two"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive.title_mask.reward_name_two",
			["ninth_awardbox/awardbox_bg/middle"] = "_control.awardbox_bg.middle",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardone/bg"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone.bg",
			["ninth_awardbox/awardbox_bg/middle/awardcontent/scrollview"] = "_control.awardbox_bg.middle.awardcontent.scrollview",
			["ninth_awardbox/award_msgbox/main/main_bg"] = "_control.award_msgbox.main.main_bg",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardone"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree.title_mask.reward_name",
			["ninth_awardbox/award_msgbox/main/title_text"] = "_control.award_msgbox.main.title_text",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/icon"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour.icon",
			["ninth_awardbox/awardbox_bg"] = "_control.awardbox_bg",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo",
			["ninth_awardbox/award_msgbox/main/close"] = "_control.award_msgbox.main.close",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfive"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfive",
			["ninth_awardbox/award_msgbox/black"] = "_control.award_msgbox.black",
			["ninth_awardbox/award_msgbox/main/confirm/text"] = "_control.award_msgbox.main.confirm.text",
			["ninth_awardbox/awardbox_bg/middle/awardcontent/scrollview/scrollbarvertical"] = "_control.awardbox_bg.middle.awardcontent.scrollview.scrollbarvertical",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/icon"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree.icon",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/bg"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree.bg",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name_two"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardtwo.title_mask.reward_name_two",
			["ninth_awardbox/award_msgbox/main"] = "_control.award_msgbox.main",
			["ninth_awardbox/award_msgbox/main/confirm"] = "_control.award_msgbox.main.confirm",
			["ninth_awardbox/awardbox_bg/top/toptitle/title"] = "_control.awardbox_bg.top.toptitle.title",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour.title_mask.reward_name",
			["ninth_awardbox/awardbox_bg/middle/awardcontent/scrollview/viewport/content"] = "_control.awardbox_bg.middle.awardcontent.scrollview.viewport.content",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview"] = "_control.award_msgbox.main.rewards.scrollview",
			["ninth_awardbox/award_msgbox/main/top"] = "_control.award_msgbox.main.top",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardfour"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardfour",
			["ninth_awardbox/awardbox_bg/top/topdescribe/des_text"] = "_control.awardbox_bg.top.topdescribe.des_text",
			["ninth_awardbox/award_msgbox"] = "_control.award_msgbox",
			["ninth_awardbox/awardbox_bg/middle/awardcontent/scrollview/scrollbarvertical/slidingarea"] = "_control.awardbox_bg.middle.awardcontent.scrollview.scrollbarvertical.slidingarea",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardone.title_mask.reward_name",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/number"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree.number",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name_two"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree.title_mask.reward_name_two",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardthree"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree",
			["ninth_awardbox/award_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask"] = "_control.award_msgbox.main.rewards.scrollview.viewport.content.rewardthree.title_mask",
			["ninth_awardbox/award_msgbox/main/top_decore"] = "_control.award_msgbox.main.top_decore",
			["ninth_awardbox/awardbox_bg/top/close"] = "_control.awardbox_bg.top.close",
			["ninth_awardbox/bg_shadow"] = "_control.bg_shadow"
		},
		click = {
			["awardbox_bg/top/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			detail_shadow = {
				tp = "UnityEngine.UI.Button"
			},
			["award_msgbox/main/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["award_msgbox/main/close"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			award_msgbox = {
				component = "UnityEngine.Canvas",
				path = "award_msgbox"
			}
		}
	}
}

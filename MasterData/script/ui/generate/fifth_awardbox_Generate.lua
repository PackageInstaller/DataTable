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
									text = {
										path = "awardbox_bg/top/toptitle/text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									back_btn = {
										path = "awardbox_bg/top/toptitle/back_btn",
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
							line = {
								path = "awardbox_bg/top/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							topdescribe = {
								path = "awardbox_bg/top/topdescribe",
								list = {
									prestigedes_text = {
										path = "awardbox_bg/top/topdescribe/prestigedes_text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									prestige_bg = {
										path = "awardbox_bg/top/topdescribe/prestige_bg",
										list = {
											prestigenum_text = {
												path = "awardbox_bg/top/topdescribe/prestige_bg/prestigenum_text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											prestigeimg = {
												path = "awardbox_bg/top/topdescribe/prestige_bg/prestigeimg",
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
					middle = {
						path = "awardbox_bg/middle",
						list = {
							taskcontent = {
								path = "awardbox_bg/middle/taskcontent",
								list = {
									scrollview = {
										path = "awardbox_bg/middle/taskcontent/scrollview",
										list = {
											viewport = {
												path = "awardbox_bg/middle/taskcontent/scrollview/viewport",
												list = {
													content = {
														path = "awardbox_bg/middle/taskcontent/scrollview/viewport/content",
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
												path = "awardbox_bg/middle/taskcontent/scrollview/scrollbarvertical",
												list = {
													slidingarea = {
														path = "awardbox_bg/middle/taskcontent/scrollview/scrollbarvertical/slidingarea",
														list = {
															handle = {
																path = "awardbox_bg/middle/taskcontent/scrollview/scrollbarvertical/slidingarea/handle",
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
							},
							awardcontent = {
								path = "awardbox_bg/middle/awardcontent",
								list = {
									award_bg = {
										path = "awardbox_bg/middle/awardcontent/award_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
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
							},
							lefthandle = {
								path = "awardbox_bg/middle/lefthandle",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button",
									"UITweenSequence"
								}
							},
							righthandle = {
								path = "awardbox_bg/middle/righthandle",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button",
									"UITweenSequence"
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
					"UnityEngine.RectTransform"
				}
			},
			detail_shadow = {
				path = "detail_shadow",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		click = {
			["awardbox_bg/top/toptitle/back_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["awardbox_bg/middle/lefthandle"] = {
				tp = "UnityEngine.UI.Button"
			},
			["awardbox_bg/middle/righthandle"] = {
				tp = "UnityEngine.UI.Button"
			},
			["award_msgbox/main/confirm"] = {
				tp = "UnityEngine.UI.Button"
			},
			["award_msgbox/main/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			detail_shadow = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

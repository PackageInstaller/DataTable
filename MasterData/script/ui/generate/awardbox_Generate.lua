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
									}
								},
								component = {
									"UnityEngine.RectTransform"
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
											"UnityEngine.UI.Text"
										}
									},
									prestigeimg = {
										path = "awardbox_bg/top/topdescribe/prestigeimg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									prestigenum_text = {
										path = "awardbox_bg/top/topdescribe/prestigenum_text",
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
					},
					bottom = {
						path = "awardbox_bg/bottom",
						list = {
							tip1 = {
								path = "awardbox_bg/bottom/tip1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip2 = {
								path = "awardbox_bg/bottom/tip2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip3 = {
								path = "awardbox_bg/bottom/tip3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip4 = {
								path = "awardbox_bg/bottom/tip4",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip5 = {
								path = "awardbox_bg/bottom/tip5",
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
							"UnityEngine.UI.HorizontalLayoutGroup"
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
		click = {
			["awardbox_bg/top/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["awardbox_bg/middle/lefthandle"] = {
				tp = "UnityEngine.UI.Button"
			},
			["awardbox_bg/middle/righthandle"] = {
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

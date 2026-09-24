return {
	_rule_ = {
		none = {
			map = {
				path = "map",
				list = {
					node_root = {
						path = "map/node_root",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			npc = {
				path = "npc",
				list = {
					bubble = {
						path = "npc/bubble",
						list = {
							bg1 = {
								path = "npc/bubble/bg1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg2 = {
								path = "npc/bubble/bg2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							label_txt = {
								path = "npc/bubble/label_txt",
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
							"UnityEngine.CanvasGroup",
							"PopVerticalAdaptive"
						}
					},
					npc_btn = {
						path = "npc/npc_btn",
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
					"UnityEngine.UI.Button"
				}
			},
			top = {
				path = "top",
				list = {
					["return"] = {
						path = "top/return",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					main_title = {
						path = "top/main_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line = {
						path = "top/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					rank = {
						path = "top/rank",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					reward = {
						path = "top/reward",
						list = {
							hint = {
								path = "top/reward/hint",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
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
					spec = {
						path = "top/spec",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					story = {
						path = "top/story",
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
			bottom = {
				path = "bottom",
				list = {
					dock = {
						path = "bottom/dock",
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
			desc_panel = {
				path = "desc_panel",
				list = {
					bg = {
						path = "desc_panel/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "desc_panel/main",
						list = {
							title = {
								path = "desc_panel/main/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title_left = {
								path = "desc_panel/main/title_left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_right = {
								path = "desc_panel/main/title_right",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_line = {
								path = "desc_panel/main/top_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							main_tip = {
								path = "desc_panel/main/main_tip",
								list = {
									main_pic = {
										path = "desc_panel/main/main_tip/main_pic",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									main_frame = {
										path = "desc_panel/main/main_tip/main_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									tip_word = {
										path = "desc_panel/main/main_tip/tip_word",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup"
								}
							},
							floor = {
								path = "desc_panel/main/floor",
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
					colse = {
						path = "desc_panel/colse",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					colse_mask = {
						path = "desc_panel/colse_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					prev = {
						path = "desc_panel/prev",
						list = {
							text = {
								path = "desc_panel/prev/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img = {
								path = "desc_panel/prev/img",
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
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					next = {
						path = "desc_panel/next",
						list = {
							text = {
								path = "desc_panel/next/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img = {
								path = "desc_panel/next/img",
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
							"UnityEngine.UI.Button",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					page = {
						path = "desc_panel/page",
						list = {
							bg = {
								path = "desc_panel/page/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							txt = {
								path = "desc_panel/page/txt",
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
					"UnityEngine.CanvasGroup"
				}
			},
			abyss_msgbox = {
				path = "abyss_msgbox",
				list = {
					emptybox = {
						path = "abyss_msgbox/emptybox",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					black = {
						path = "abyss_msgbox/black",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					main = {
						path = "abyss_msgbox/main",
						list = {
							main_bg = {
								path = "abyss_msgbox/main/main_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_decore = {
								path = "abyss_msgbox/main/top_decore",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top = {
								path = "abyss_msgbox/main/top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "abyss_msgbox/main/title",
								list = {
									three_point = {
										path = "abyss_msgbox/main/title/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									three_point_get = {
										path = "abyss_msgbox/main/title/three_point_get",
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
							one = {
								path = "abyss_msgbox/main/one",
								list = {
									text = {
										path = "abyss_msgbox/main/one/text",
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
							rewards = {
								path = "abyss_msgbox/main/rewards",
								list = {
									scrollview = {
										path = "abyss_msgbox/main/rewards/scrollview",
										list = {
											viewport = {
												path = "abyss_msgbox/main/rewards/scrollview/viewport",
												list = {
													content = {
														path = "abyss_msgbox/main/rewards/scrollview/viewport/content",
														list = {
															rewardone = {
																path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardone",
																list = {
																	bg = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardone/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardone/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardone/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask",
																		list = {
																			reward_name = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardone/title_mask/reward_name_two",
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
																path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardtwo",
																list = {
																	bg = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask",
																		list = {
																			reward_name = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardtwo/title_mask/reward_name_two",
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
																path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardthree",
																list = {
																	bg = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardthree/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardthree/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardthree/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask",
																		list = {
																			reward_name = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardthree/title_mask/reward_name_two",
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
																path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfour",
																list = {
																	bg = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfour/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfour/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfour/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask",
																		list = {
																			reward_name = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfour/title_mask/reward_name_two",
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
																path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfive",
																list = {
																	bg = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfive/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfive/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfive/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask",
																		list = {
																			reward_name = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardfive/title_mask/reward_name_two",
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
															rewardsix = {
																path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardsix",
																list = {
																	bg = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardsix/bg",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	icon = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardsix/icon",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Image"
																		}
																	},
																	number = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardsix/number",
																		list = {},
																		component = {
																			"UnityEngine.RectTransform",
																			"UnityEngine.CanvasRenderer",
																			"UnityEngine.UI.Text",
																			"UnityEngine.UI.Outline"
																		}
																	},
																	title_mask = {
																		path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardsix/title_mask",
																		list = {
																			reward_name = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardsix/title_mask/reward_name",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Text"
																				}
																			},
																			reward_name_two = {
																				path = "abyss_msgbox/main/rewards/scrollview/viewport/content/rewardsix/title_mask/reward_name_two",
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
			npc = {
				tp = "UnityEngine.UI.Button"
			},
			["top/return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/rank"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/reward"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/spec"] = {
				tp = "UnityEngine.UI.Button"
			},
			["top/story"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/dock"] = {
				tp = "UnityEngine.UI.Button"
			},
			["desc_panel/colse"] = {
				tp = "UnityEngine.UI.Button"
			},
			["desc_panel/prev"] = {
				tp = "UnityEngine.UI.Button"
			},
			["desc_panel/next"] = {
				tp = "UnityEngine.UI.Button"
			},
			["abyss_msgbox/main/one"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			colse = {
				component = "UnityEngine.Canvas",
				path = "desc_panel/colse"
			},
			prev = {
				component = "UnityEngine.Canvas",
				path = "desc_panel/prev"
			},
			next = {
				component = "UnityEngine.Canvas",
				path = "desc_panel/next"
			},
			abyss_msgbox = {
				component = "UnityEngine.Canvas",
				path = "abyss_msgbox"
			}
		}
	}
}

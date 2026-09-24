return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			spine = {
				path = "spine",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic"
				}
			},
			main = {
				path = "main",
				list = {
					top = {
						path = "main/top",
						list = {
							["return"] = {
								path = "main/top/return",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							title = {
								path = "main/top/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							line = {
								path = "main/top/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							btns = {
								path = "main/top/btns",
								list = {
									rank = {
										path = "main/top/btns/rank",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									explain = {
										path = "main/top/btns/explain",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									analysis_room = {
										path = "main/top/btns/analysis_room",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									award = {
										path = "main/top/btns/award",
										list = {
											tips = {
												path = "main/top/btns/award/tips",
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.HorizontalLayoutGroup"
								}
							},
							res_bg = {
								path = "main/top/res_bg",
								list = {
									title = {
										path = "main/top/res_bg/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									count = {
										path = "main/top/res_bg/count",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					middle = {
						path = "main/middle",
						list = {
							item_1 = {
								path = "main/middle/item_1",
								list = {
									bg = {
										path = "main/middle/item_1/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIRotateTweener",
											"UITweenSequence"
										}
									},
									monster = {
										path = "main/middle/item_1/monster",
										list = {
											bg = {
												path = "main/middle/item_1/monster/bg",
												list = {
													icon = {
														path = "main/middle/item_1/monster/bg/icon",
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
													"UnityEngine.UI.Mask",
													"UnityEngine.UI.Button"
												}
											},
											spine_bg = {
												path = "main/middle/item_1/monster/spine_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UIRotateTweener"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener",
									"UIMoveTweener",
									"UITweenSequence"
								}
							},
							item_2 = {
								path = "main/middle/item_2",
								list = {
									bg = {
										path = "main/middle/item_2/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIRotateTweener",
											"UITweenSequence"
										}
									},
									monster = {
										path = "main/middle/item_2/monster",
										list = {
											bg = {
												path = "main/middle/item_2/monster/bg",
												list = {
													icon = {
														path = "main/middle/item_2/monster/bg/icon",
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
													"UnityEngine.UI.Mask",
													"UnityEngine.UI.Button"
												}
											},
											spine_bg = {
												path = "main/middle/item_2/monster/spine_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UIRotateTweener"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener",
									"UIMoveTweener",
									"UITweenSequence"
								}
							},
							item_3 = {
								path = "main/middle/item_3",
								list = {
									bg = {
										path = "main/middle/item_3/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIRotateTweener",
											"UITweenSequence"
										}
									},
									monster = {
										path = "main/middle/item_3/monster",
										list = {
											bg = {
												path = "main/middle/item_3/monster/bg",
												list = {
													icon = {
														path = "main/middle/item_3/monster/bg/icon",
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
													"UnityEngine.UI.Mask",
													"UnityEngine.UI.Button"
												}
											},
											spine_bg = {
												path = "main/middle/item_3/monster/spine_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UIRotateTweener"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener",
									"UIMoveTweener",
									"UITweenSequence"
								}
							},
							item_4 = {
								path = "main/middle/item_4",
								list = {
									bg = {
										path = "main/middle/item_4/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIRotateTweener",
											"UITweenSequence"
										}
									},
									monster = {
										path = "main/middle/item_4/monster",
										list = {
											bg = {
												path = "main/middle/item_4/monster/bg",
												list = {
													icon = {
														path = "main/middle/item_4/monster/bg/icon",
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
													"UnityEngine.UI.Mask",
													"UnityEngine.UI.Button"
												}
											},
											spine_bg = {
												path = "main/middle/item_4/monster/spine_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UIRotateTweener"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener",
									"UIMoveTweener",
									"UITweenSequence"
								}
							},
							item_5 = {
								path = "main/middle/item_5",
								list = {
									bg = {
										path = "main/middle/item_5/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UIRotateTweener",
											"UITweenSequence"
										}
									},
									monster = {
										path = "main/middle/item_5/monster",
										list = {
											bg = {
												path = "main/middle/item_5/monster/bg",
												list = {
													icon = {
														path = "main/middle/item_5/monster/bg/icon",
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
													"UnityEngine.UI.Mask",
													"UnityEngine.UI.Button"
												}
											},
											spine_bg = {
												path = "main/middle/item_5/monster/spine_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UIRotateTweener"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UIMoveTweener",
									"UIMoveTweener",
									"UITweenSequence"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					bottom = {
						path = "main/bottom",
						list = {
							last_fast = {
								path = "main/bottom/last_fast",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							last_layer = {
								path = "main/bottom/last_layer",
								list = {
									txt = {
										path = "main/bottom/last_layer/txt",
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
							reset = {
								path = "main/bottom/reset",
								list = {
									txt = {
										path = "main/bottom/reset/txt",
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
							next_layer = {
								path = "main/bottom/next_layer",
								list = {
									txt = {
										path = "main/bottom/next_layer/txt",
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
							next_fast = {
								path = "main/bottom/next_fast",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							layer_info = {
								path = "main/bottom/layer_info",
								list = {
									txt = {
										path = "main/bottom/layer_info/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									num = {
										path = "main/bottom/layer_info/num",
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
							spine = {
								path = "main/bottom/spine",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic",
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					situation_buff = {
						path = "main/situation_buff",
						list = {
							info_panel = {
								path = "main/situation_buff/info_panel",
								list = {
									buff_bg = {
										path = "main/situation_buff/info_panel/buff_bg",
										list = {
											title = {
												path = "main/situation_buff/info_panel/buff_bg/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											line = {
												path = "main/situation_buff/info_panel/buff_bg/line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											info_txt = {
												path = "main/situation_buff/info_panel/buff_bg/info_txt",
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
									}
								},
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
			instructions = {
				path = "instructions",
				list = {
					bg = {
						path = "instructions/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "instructions/main",
						list = {
							title = {
								path = "instructions/main/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title_left = {
								path = "instructions/main/title_left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_right = {
								path = "instructions/main/title_right",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							top_line = {
								path = "instructions/main/top_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							main_tip = {
								path = "instructions/main/main_tip",
								list = {
									main_pic = {
										path = "instructions/main/main_tip/main_pic",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									main_frame = {
										path = "instructions/main/main_tip/main_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									tip_word = {
										path = "instructions/main/main_tip/tip_word",
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
							floor = {
								path = "instructions/main/floor",
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
						path = "instructions/colse",
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
					prev = {
						path = "instructions/prev",
						list = {
							text = {
								path = "instructions/prev/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img = {
								path = "instructions/prev/img",
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
						path = "instructions/next",
						list = {
							text = {
								path = "instructions/next/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							img = {
								path = "instructions/next/img",
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
						path = "instructions/page",
						list = {
							bg = {
								path = "instructions/page/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							page_1 = {
								path = "instructions/page/page_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							xie = {
								path = "instructions/page/xie",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							page_2 = {
								path = "instructions/page/page_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							page = {
								path = "instructions/page/page",
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
			}
		},
		click = {
			["main/top/return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/rank"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/explain"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/analysis_room"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/award"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/item_1/monster/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/item_2/monster/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/item_3/monster/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/item_4/monster/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/middle/item_5/monster/bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/last_fast"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/last_layer"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/reset"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/next_layer"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/next_fast"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/spine"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/situation_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["instructions/colse"] = {
				tp = "UnityEngine.UI.Button"
			},
			["instructions/prev"] = {
				tp = "UnityEngine.UI.Button"
			},
			["instructions/next"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			colse = {
				component = "UnityEngine.Canvas",
				path = "instructions/colse"
			},
			prev = {
				component = "UnityEngine.Canvas",
				path = "instructions/prev"
			},
			next = {
				component = "UnityEngine.Canvas",
				path = "instructions/next"
			}
		}
	}
}

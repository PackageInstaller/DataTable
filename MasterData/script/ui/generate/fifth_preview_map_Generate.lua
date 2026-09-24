return {
	_rule_ = {
		none = {
			obj_pool_root = {
				path = "obj_pool_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
				}
			},
			main = {
				path = "main",
				list = {
					mask = {
						path = "main/mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					content = {
						path = "main/content",
						list = {
							main_side1 = {
								path = "main/content/main_side1",
								list = {
									title = {
										path = "main/content/main_side1/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									detail_btn = {
										path = "main/content/main_side1/detail_btn",
										list = {
											txt = {
												path = "main/content/main_side1/detail_btn/txt",
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
									buff = {
										path = "main/content/main_side1/buff",
										list = {
											item = {
												path = "main/content/main_side1/buff/item",
												list = {
													txt = {
														path = "main/content/main_side1/buff/item/txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													ban = {
														path = "main/content/main_side1/buff/item/ban",
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
											"UnityEngine.RectTransform",
											"UnityEngine.UI.GridLayoutGroup"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							main_side2 = {
								path = "main/content/main_side2",
								list = {
									title = {
										path = "main/content/main_side2/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff = {
										path = "main/content/main_side2/buff",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									desc = {
										path = "main/content/main_side2/desc",
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
									"UnityEngine.CanvasGroup"
								}
							},
							joy_side = {
								path = "main/content/joy_side",
								list = {
									title = {
										path = "main/content/joy_side/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									num1 = {
										path = "main/content/joy_side/num1",
										list = {
											num = {
												path = "main/content/joy_side/num1/num",
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
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									tip_txt = {
										path = "main/content/joy_side/tip_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									num2 = {
										path = "main/content/joy_side/num2",
										list = {
											num = {
												path = "main/content/joy_side/num2/num",
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
											"UnityEngine.UI.Text",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									icon = {
										path = "main/content/joy_side/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									icon2 = {
										path = "main/content/joy_side/icon2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									progress_bg = {
										path = "main/content/joy_side/progress_bg",
										list = {
											progress = {
												path = "main/content/joy_side/progress_bg/progress",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.CanvasGroup"
								}
							},
							map = {
								path = "main/content/map",
								list = {
									map_bg = {
										path = "main/content/map/map_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									map_root = {
										path = "main/content/map/map_root",
										list = {},
										component = {
											"UnityEngine.RectTransform"
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
							boss_bg = {
								path = "main/content/boss_bg",
								list = {
									icon = {
										path = "main/content/boss_bg/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									boss_hp = {
										path = "main/content/boss_bg/boss_hp",
										list = {
											hp_icon = {
												path = "main/content/boss_bg/boss_hp/hp_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_bg = {
												path = "main/content/boss_bg/boss_hp/hp_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp = {
												path = "main/content/boss_bg/boss_hp/hp",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											txt = {
												path = "main/content/boss_bg/boss_hp/txt",
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
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_bg = {
								path = "main/content/title_bg",
								list = {
									title = {
										path = "main/content/title_bg/title",
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
							tip_txt = {
								path = "main/content/tip_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							["return"] = {
								path = "main/content/return",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							fight_btn = {
								path = "main/content/fight_btn",
								list = {
									txt = {
										path = "main/content/fight_btn/txt",
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
							"UnityEngine.UI.Image"
						}
					},
					detail_layer = {
						path = "main/detail_layer",
						list = {
							bg = {
								path = "main/detail_layer/bg",
								list = {
									bg_top = {
										path = "main/detail_layer/bg/bg_top",
										list = {
											mask_bg = {
												path = "main/detail_layer/bg/bg_top/mask_bg",
												list = {
													bg_blue_top = {
														path = "main/detail_layer/bg/bg_top/mask_bg/bg_blue_top",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													bg_blue_top2 = {
														path = "main/detail_layer/bg/bg_top/mask_bg/bg_blue_top2",
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
											bg_blue_top3 = {
												path = "main/detail_layer/bg/bg_top/bg_blue_top3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											title = {
												path = "main/detail_layer/bg/bg_top/title",
												list = {
													three_point = {
														path = "main/detail_layer/bg/bg_top/title/three_point",
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
													"UnityEngine.UI.Text",
													"UnityEngine.UI.ContentSizeFitter"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									content = {
										path = "main/detail_layer/bg/content",
										list = {
											item = {
												path = "main/detail_layer/bg/content/item",
												list = {
													suppress_bg = {
														path = "main/detail_layer/bg/content/item/suppress_bg",
														list = {
															txt = {
																path = "main/detail_layer/bg/content/item/suppress_bg/txt",
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
													desc = {
														path = "main/detail_layer/bg/content/item/desc",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													arrow = {
														path = "main/detail_layer/bg/content/item/arrow",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													condition = {
														path = "main/detail_layer/bg/content/item/condition",
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
											"UnityEngine.UI.GridLayoutGroup"
										}
									},
									close_btn = {
										path = "main/detail_layer/bg/close_btn",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UITweenSequence",
									"UIScaleTweener",
									"UIScaleTweener"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		click = {
			["main/content/main_side1/detail_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/content/return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/content/fight_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/detail_layer/bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

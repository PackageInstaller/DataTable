return {
	_rule_ = {
		none = {
			play_video = {
				path = "play_video",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.Video.VideoPlayer",
					"UnityEngine.AudioSource"
				}
			},
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
					desc_panel = {
						path = "main/desc_panel",
						list = {
							bg = {
								path = "main/desc_panel/bg",
								list = {
									line = {
										path = "main/desc_panel/bg/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title_bg = {
										path = "main/desc_panel/bg/title_bg",
										list = {
											title_txt = {
												path = "main/desc_panel/bg/title_bg/title_txt",
												list = {
													title_image = {
														path = "main/desc_panel/bg/title_bg/title_txt/title_image",
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
							scroll_view = {
								path = "main/desc_panel/scroll_view",
								list = {
									viewport = {
										path = "main/desc_panel/scroll_view/viewport",
										list = {
											content = {
												path = "main/desc_panel/scroll_view/viewport/content",
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
							},
							close_btn = {
								path = "main/desc_panel/close_btn",
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
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster",
							"UnityEngine.CanvasRenderer"
						}
					},
					bg = {
						path = "main/bg",
						list = {
							main = {
								path = "main/bg/main",
								list = {
									scrollview = {
										path = "main/bg/main/scrollview",
										list = {
											viewport = {
												path = "main/bg/main/scrollview/viewport",
												list = {
													content = {
														path = "main/bg/main/scrollview/viewport/content",
														list = {
															map_content = {
																path = "main/bg/main/scrollview/viewport/content/map_content",
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
											},
											scrollbar_horizontal = {
												path = "main/bg/main/scrollview/scrollbar_horizontal",
												list = {
													["Sliding Area"] = {
														path = "main/bg/main/scrollview/scrollbar_horizontal/Sliding Area",
														list = {
															Handle = {
																path = "main/bg/main/scrollview/scrollbar_horizontal/Sliding Area/Handle",
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
									},
									left = {
										path = "main/bg/main/left",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									right = {
										path = "main/bg/main/right",
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
									"UnityEngine.CanvasGroup"
								}
							},
							joy = {
								path = "main/bg/joy",
								list = {
									joy_map = {
										path = "main/bg/joy/joy_map",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									joy_spine = {
										path = "main/bg/joy/joy_spine",
										list = {
											up_spine = {
												path = "main/bg/joy/joy_spine/up_spine",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											},
											down_spine = {
												path = "main/bg/joy/joy_spine/down_spine",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
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
							money_bg = {
								path = "main/top/money_bg",
								list = {
									icon = {
										path = "main/top/money_bg/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									count = {
										path = "main/top/money_bg/count",
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
							title_bg = {
								path = "main/top/title_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "main/top/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							btns = {
								path = "main/top/btns",
								list = {
									replay = {
										path = "main/top/btns/replay",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									plot = {
										path = "main/top/btns/plot",
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
									award = {
										path = "main/top/btns/award",
										list = {
											tip = {
												path = "main/top/btns/award/tip",
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
									"UnityEngine.UI.HorizontalLayoutGroup",
									"UnityEngine.UI.ContentSizeFitter"
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
							main = {
								path = "main/bottom/main",
								list = {
									bg = {
										path = "main/bottom/main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									node_left = {
										path = "main/bottom/main/node_left",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									node_right = {
										path = "main/bottom/main/node_right",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									node = {
										path = "main/bottom/main/node",
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
									"UnityEngine.CanvasGroup"
								}
							},
							joy = {
								path = "main/bottom/joy",
								list = {
									rebuild = {
										path = "main/bottom/joy/rebuild",
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
									"UnityEngine.CanvasGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					btn = {
						path = "main/btn",
						list = {
							joy_bg = {
								path = "main/btn/joy_bg",
								list = {
									desc = {
										path = "main/btn/joy_bg/desc",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UIScaleTweener"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							joy_btn = {
								path = "main/btn/joy_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button",
									"UIScaleTweener",
									"UIMoveTweener",
									"UITweenSequence"
								}
							},
							main_btn = {
								path = "main/btn/main_btn",
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
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			task = {
				path = "task",
				list = {
					content = {
						path = "task/content",
						list = {
							bg = {
								path = "task/content/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							desc = {
								path = "task/content/desc",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "task/content/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							point = {
								path = "task/content/point",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title = {
								path = "task/content/title",
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
							"UITweenSequence",
							"UIScaleTweener"
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
		click = {
			["main/desc_panel/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/replay"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/plot"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/explain"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/top/btns/award"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/bottom/joy/rebuild"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/btn/joy_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/btn/main_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			desc_panel = {
				component = "UnityEngine.Canvas",
				path = "main/desc_panel"
			}
		}
	}
}

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
					title = {
						path = "top/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					chap_title = {
						path = "top/chap_title",
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
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			middle = {
				path = "middle",
				list = {
					page_view = {
						path = "middle/page_view",
						list = {
							content = {
								path = "middle/page_view/content",
								list = {
									page1 = {
										path = "middle/page_view/content/page1",
										list = {
											root = {
												path = "middle/page_view/content/page1/root",
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
									page2 = {
										path = "middle/page_view/content/page2",
										list = {
											root = {
												path = "middle/page_view/content/page2/root",
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
							"LatticeScrollRect",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					},
					window = {
						path = "middle/window",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					last_btn = {
						path = "middle/last_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					next_btn = {
						path = "middle/next_btn",
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
					boss_frame = {
						path = "bottom/boss_frame",
						list = {
							pic = {
								path = "bottom/boss_frame/pic",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							icon = {
								path = "bottom/boss_frame/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							hp = {
								path = "bottom/boss_frame/hp",
								list = {
									rest = {
										path = "bottom/boss_frame/hp/rest",
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
							hp_perc = {
								path = "bottom/boss_frame/hp_perc",
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
					item_preview = {
						path = "bottom/item_preview",
						list = {
							title = {
								path = "bottom/item_preview/title",
								list = {
									txt = {
										path = "bottom/item_preview/title/txt",
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
							list = {
								path = "bottom/item_preview/list",
								list = {
									content = {
										path = "bottom/item_preview/list/content",
										list = {
											item = {
												path = "bottom/item_preview/list/content/item",
												list = {
													pic = {
														path = "bottom/item_preview/list/content/item/pic",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													num = {
														path = "bottom/item_preview/list/content/item/num",
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
											"UnityEngine.UI.HorizontalLayoutGroup",
											"UnityEngine.UI.ContentSizeFitter"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ScrollRect",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					team_select = {
						path = "bottom/team_select",
						list = {
							player_team = {
								path = "bottom/team_select/player_team",
								list = {
									selected = {
										path = "bottom/team_select/player_team/selected",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									name_bg = {
										path = "bottom/team_select/player_team/name_bg",
										list = {
											team_name = {
												path = "bottom/team_select/player_team/name_bg/team_name",
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
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							abyss_team = {
								path = "bottom/team_select/abyss_team",
								list = {
									selected = {
										path = "bottom/team_select/abyss_team/selected",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									name_bg = {
										path = "bottom/team_select/abyss_team/name_bg",
										list = {
											team_name = {
												path = "bottom/team_select/abyss_team/name_bg/team_name",
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
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							gm = {
								path = "bottom/team_select/gm",
								list = {
									gm_1 = {
										path = "bottom/team_select/gm/gm_1",
										list = {
											Label = {
												path = "bottom/team_select/gm/gm_1/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											Arrow = {
												path = "bottom/team_select/gm/gm_1/Arrow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											Template = {
												path = "bottom/team_select/gm/gm_1/Template",
												list = {
													Viewport = {
														path = "bottom/team_select/gm/gm_1/Template/Viewport",
														list = {
															Content = {
																path = "bottom/team_select/gm/gm_1/Template/Viewport/Content",
																list = {
																	Item = {
																		path = "bottom/team_select/gm/gm_1/Template/Viewport/Content/Item",
																		list = {
																			["Item Background"] = {
																				path = "bottom/team_select/gm/gm_1/Template/Viewport/Content/Item/Item Background",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			["Item Checkmark"] = {
																				path = "bottom/team_select/gm/gm_1/Template/Viewport/Content/Item/Item Checkmark",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			["Item Label"] = {
																				path = "bottom/team_select/gm/gm_1/Template/Viewport/Content/Item/Item Label",
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
																			"UnityEngine.UI.Toggle"
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
													Scrollbar = {
														path = "bottom/team_select/gm/gm_1/Template/Scrollbar",
														list = {
															["Sliding Area"] = {
																path = "bottom/team_select/gm/gm_1/Template/Scrollbar/Sliding Area",
																list = {
																	Handle = {
																		path = "bottom/team_select/gm/gm_1/Template/Scrollbar/Sliding Area/Handle",
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
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.ScrollRect"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Dropdown",
											"UnityEngine.CanvasGroup"
										}
									},
									gm_2 = {
										path = "bottom/team_select/gm/gm_2",
										list = {
											Label = {
												path = "bottom/team_select/gm/gm_2/Label",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											Arrow = {
												path = "bottom/team_select/gm/gm_2/Arrow",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											Template = {
												path = "bottom/team_select/gm/gm_2/Template",
												list = {
													Viewport = {
														path = "bottom/team_select/gm/gm_2/Template/Viewport",
														list = {
															Content = {
																path = "bottom/team_select/gm/gm_2/Template/Viewport/Content",
																list = {
																	Item = {
																		path = "bottom/team_select/gm/gm_2/Template/Viewport/Content/Item",
																		list = {
																			["Item Background"] = {
																				path = "bottom/team_select/gm/gm_2/Template/Viewport/Content/Item/Item Background",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			["Item Checkmark"] = {
																				path = "bottom/team_select/gm/gm_2/Template/Viewport/Content/Item/Item Checkmark",
																				list = {},
																				component = {
																					"UnityEngine.RectTransform",
																					"UnityEngine.CanvasRenderer",
																					"UnityEngine.UI.Image"
																				}
																			},
																			["Item Label"] = {
																				path = "bottom/team_select/gm/gm_2/Template/Viewport/Content/Item/Item Label",
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
																			"UnityEngine.UI.Toggle"
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
													Scrollbar = {
														path = "bottom/team_select/gm/gm_2/Template/Scrollbar",
														list = {
															["Sliding Area"] = {
																path = "bottom/team_select/gm/gm_2/Template/Scrollbar/Sliding Area",
																list = {
																	Handle = {
																		path = "bottom/team_select/gm/gm_2/Template/Scrollbar/Sliding Area/Handle",
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
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.ScrollRect"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Dropdown",
											"UnityEngine.CanvasGroup"
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
					fight_btn = {
						path = "bottom/fight_btn",
						list = {
							txt = {
								path = "bottom/fight_btn/txt",
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
					remain_time = {
						path = "bottom/remain_time",
						list = {
							time_num = {
								path = "bottom/remain_time/time_num",
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
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			screen_block = {
				path = "screen_block",
				list = {
					block_top = {
						path = "screen_block/block_top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					block_bottom = {
						path = "screen_block/block_bottom",
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
		click = {
			["top/return"] = {
				tp = "UnityEngine.UI.Button"
			},
			["middle/last_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["middle/next_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/item_preview/list/content/item"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/team_select/player_team"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/team_select/abyss_team"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bottom/fight_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["bottom/team_select/gm/gm_1/Template/Viewport/Content/Item"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["bottom/team_select/gm/gm_2/Template/Viewport/Content/Item"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		dropdown = {
			["bottom/team_select/gm/gm_1"] = {
				tp = "UnityEngine.UI.Dropdown"
			},
			["bottom/team_select/gm/gm_2"] = {
				tp = "UnityEngine.UI.Dropdown"
			}
		},
		canvas_set = {}
	}
}

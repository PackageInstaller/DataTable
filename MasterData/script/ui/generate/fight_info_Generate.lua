return {
	_rule_ = {
		none = {
			bg_r = {
				path = "bg_r",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.ContentSizeFitter"
				}
			},
			bg = {
				path = "bg",
				list = {
					map_bg = {
						path = "bg/map_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					boss_title = {
						path = "bg/boss_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					boss_slider = {
						path = "bg/boss_slider",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					boss_hp = {
						path = "bg/boss_hp",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					boss_slider_bg = {
						path = "bg/boss_slider_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					big_bg = {
						path = "bg/big_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					map_path = {
						path = "bg/map_path",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					ship_layer = {
						path = "bg/ship_layer",
						list = {
							ship_icon = {
								path = "bg/ship_layer/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							encounter_effect = {
								path = "bg/ship_layer/encounter_effect",
								list = {
									encounter_spine = {
										path = "bg/ship_layer/encounter_effect/encounter_spine",
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
									"UnityEngine.CanvasGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					left_people = {
						path = "bg/left_people",
						list = {
							talk = {
								path = "bg/left_people/talk",
								list = {
									bg1 = {
										path = "bg/left_people/talk/bg1",
										list = {
											bg2 = {
												path = "bg/left_people/talk/bg1/bg2",
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
									label_txt = {
										path = "bg/left_people/talk/label_txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					return_btn = {
						path = "bg/return_btn",
						list = {
							return_text = {
								path = "bg/return_btn/return_text",
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
					map_mask = {
						path = "bg/map_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					campaign_bg = {
						path = "bg/campaign_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title_bg = {
						path = "bg/title_bg",
						list = {
							content = {
								path = "bg/title_bg/content",
								list = {
									title_txt = {
										path = "bg/title_bg/content/title_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									title_txt_2 = {
										path = "bg/title_bg/content/title_txt_2",
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
									"UnityEngine.UI.Mask",
									"TextHorizonScroller",
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
					info_bg = {
						path = "bg/info_bg",
						list = {
							mask = {
								path = "bg/info_bg/mask",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.LayoutElement",
									"UnityEngine.CanvasGroup"
								}
							},
							condition_bg = {
								path = "bg/info_bg/condition_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup",
									"UnityEngine.UI.HorizontalLayoutGroup"
								}
							},
							random_bg = {
								path = "bg/info_bg/random_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup",
									"UnityEngine.UI.HorizontalLayoutGroup"
								}
							},
							encounter_bg = {
								path = "bg/info_bg/encounter_bg",
								list = {
									encounter_spine = {
										path = "bg/info_bg/encounter_bg/encounter_spine",
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
									"UnityEngine.CanvasGroup"
								}
							},
							lock_enemy_bg = {
								path = "bg/info_bg/lock_enemy_bg",
								list = {
									lock_enemy_spine = {
										path = "bg/info_bg/lock_enemy_bg/lock_enemy_spine",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"Spine.Unity.SkeletonGraphic"
										}
									},
									rate_bg = {
										path = "bg/info_bg/lock_enemy_bg/rate_bg",
										list = {
											rate = {
												path = "bg/info_bg/lock_enemy_bg/rate_bg/rate",
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
									round_about = {
										path = "bg/info_bg/lock_enemy_bg/round_about",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									round_about_spine = {
										path = "bg/info_bg/lock_enemy_bg/round_about_spine",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"Spine.Unity.SkeletonGraphic"
										}
									},
									radar_frame = {
										path = "bg/info_bg/lock_enemy_bg/radar_frame",
										list = {
											radar_effect1 = {
												path = "bg/info_bg/lock_enemy_bg/radar_frame/radar_effect1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"DG.Tweening.DOTweenAnimation"
												}
											},
											radar_effect2 = {
												path = "bg/info_bg/lock_enemy_bg/radar_frame/radar_effect2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"DG.Tweening.DOTweenAnimation"
												}
											},
											monster_formation = {
												path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation",
												list = {
													formation1 = {
														path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1",
														list = {
															num1 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num6 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation2 = {
														path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2",
														list = {
															num6 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation3 = {
														path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3",
														list = {
															num6 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation4 = {
														path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4",
														list = {
															num6 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation5 = {
														path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5",
														list = {
															num6 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster",
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
							lost_enemy_bg = {
								path = "bg/info_bg/lost_enemy_bg",
								list = {
									radar_frame = {
										path = "bg/info_bg/lost_enemy_bg/radar_frame",
										list = {
											radar_effect1 = {
												path = "bg/info_bg/lost_enemy_bg/radar_frame/radar_effect1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"DG.Tweening.DOTweenAnimation"
												}
											},
											radar_effect2 = {
												path = "bg/info_bg/lost_enemy_bg/radar_frame/radar_effect2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"DG.Tweening.DOTweenAnimation"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "bg/info_bg/lost_enemy_bg/title",
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
									"UnityEngine.CanvasGroup"
								}
							},
							skip_btn = {
								path = "bg/info_bg/skip_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							round_about_lock_enemy_txt = {
								path = "bg/info_bg/round_about_lock_enemy_txt",
								list = {
									lock_enemy_info_bg = {
										path = "bg/info_bg/round_about_lock_enemy_txt/lock_enemy_info_bg",
										list = {
											lock_enemy_info_txt = {
												path = "bg/info_bg/round_about_lock_enemy_txt/lock_enemy_info_bg/lock_enemy_info_txt",
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
									"UnityEngine.UI.Text"
								}
							},
							enemy_info_bg = {
								path = "bg/info_bg/enemy_info_bg",
								list = {
									bg = {
										path = "bg/info_bg/enemy_info_bg/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									enemy_info_txt = {
										path = "bg/info_bg/enemy_info_bg/enemy_info_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									s_enemy_info = {
										path = "bg/info_bg/enemy_info_bg/s_enemy_info",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line_top = {
										path = "bg/info_bg/enemy_info_bg/line_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_medium = {
										path = "bg/info_bg/enemy_info_bg/line_medium",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									line_bottom = {
										path = "bg/info_bg/enemy_info_bg/line_bottom",
										list = {
											random_tip_Text = {
												path = "bg/info_bg/enemy_info_bg/line_bottom/random_tip_Text",
												list = {
													Text = {
														path = "bg/info_bg/enemy_info_bg/line_bottom/random_tip_Text/Text",
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
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									radar_frame = {
										path = "bg/info_bg/enemy_info_bg/radar_frame",
										list = {
											radar_effect1 = {
												path = "bg/info_bg/enemy_info_bg/radar_frame/radar_effect1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"DG.Tweening.DOTweenAnimation"
												}
											},
											radar_effect2 = {
												path = "bg/info_bg/enemy_info_bg/radar_frame/radar_effect2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"DG.Tweening.DOTweenAnimation"
												}
											},
											monster_formation = {
												path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation",
												list = {
													formation1 = {
														path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1",
														list = {
															num1 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num6 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation2 = {
														path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2",
														list = {
															num6 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation3 = {
														path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3",
														list = {
															num6 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation4 = {
														path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4",
														list = {
															num6 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster",
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
															"UnityEngine.CanvasGroup"
														}
													},
													formation5 = {
														path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5",
														list = {
															num6 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster",
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
																			pos6 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num5 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster",
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
																			pos5 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num4 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster",
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
																			pos4 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num3 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster",
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
																			pos3 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num2 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster",
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
																			pos2 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster",
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
																			"UnityEngine.RectTransform"
																		}
																	}
																},
																component = {
																	"UnityEngine.RectTransform"
																}
															},
															num1 = {
																path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1",
																list = {
																	offset = {
																		path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset",
																		list = {
																			pos1 = {
																				path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1",
																				list = {
																					monster = {
																						path = "bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster",
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
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									enemy_list = {
										path = "bg/info_bg/enemy_info_bg/enemy_list",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.GridLayoutGroup"
										}
									},
									back_btn = {
										path = "bg/info_bg/enemy_info_bg/back_btn",
										list = {
											text = {
												path = "bg/info_bg/enemy_info_bg/back_btn/text",
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
									fight_btn = {
										path = "bg/info_bg/enemy_info_bg/fight_btn",
										list = {
											text = {
												path = "bg/info_bg/enemy_info_bg/fight_btn/text",
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
									bvr_btn = {
										path = "bg/info_bg/enemy_info_bg/bvr_btn",
										list = {
											spine_effect = {
												path = "bg/info_bg/enemy_info_bg/bvr_btn/spine_effect",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"Spine.Unity.SkeletonGraphic"
												}
											},
											text = {
												path = "bg/info_bg/enemy_info_bg/bvr_btn/text",
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
									circuity_btn = {
										path = "bg/info_bg/enemy_info_bg/circuity_btn",
										list = {
											text = {
												path = "bg/info_bg/enemy_info_bg/circuity_btn/text",
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
									circuity_img = {
										path = "bg/info_bg/enemy_info_bg/circuity_img",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									circuity_random = {
										path = "bg/info_bg/enemy_info_bg/circuity_random",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									s_circuity = {
										path = "bg/info_bg/enemy_info_bg/s_circuity",
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
									"UnityEngine.CanvasGroup",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							select_formation = {
								path = "bg/info_bg/select_formation",
								list = {
									mask = {
										path = "bg/info_bg/select_formation/mask",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									left_widget = {
										path = "bg/info_bg/select_formation/left_widget",
										list = {
											first_ship_pic = {
												path = "bg/info_bg/select_formation/left_widget/first_ship_pic",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"UnityEngine.UI.ContentSizeFitter"
												}
											},
											word_bg = {
												path = "bg/info_bg/select_formation/left_widget/word_bg",
												list = {
													first_ship_name = {
														path = "bg/info_bg/select_formation/left_widget/word_bg/first_ship_name",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													first_ship_word = {
														path = "bg/info_bg/select_formation/left_widget/word_bg/first_ship_word",
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
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									right_widget = {
										path = "bg/info_bg/select_formation/right_widget",
										list = {
											title_txt = {
												path = "bg/info_bg/select_formation/right_widget/title_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											title_line = {
												path = "bg/info_bg/select_formation/right_widget/title_line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											select1 = {
												path = "bg/info_bg/select_formation/right_widget/select1",
												list = {
													formation6 = {
														path = "bg/info_bg/select_formation/right_widget/select1/formation6",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation6/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation6/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation6/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation6/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation6/point5",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point6 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation6/point6",
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
													name_txt = {
														path = "bg/info_bg/select_formation/right_widget/select1/name_txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													title_mask = {
														path = "bg/info_bg/select_formation/right_widget/select1/title_mask",
														list = {
															txt = {
																path = "bg/info_bg/select_formation/right_widget/select1/title_mask/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															txt_2 = {
																path = "bg/info_bg/select_formation/right_widget/select1/title_mask/txt_2",
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
															"TextHorizonScroller"
														}
													},
													desc_mask = {
														path = "bg/info_bg/select_formation/right_widget/select1/desc_mask",
														list = {
															desc_txt = {
																path = "bg/info_bg/select_formation/right_widget/select1/desc_mask/desc_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															desc_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select1/desc_mask/desc_txt2",
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
															"TextScroller"
														}
													},
													detail_mask = {
														path = "bg/info_bg/select_formation/right_widget/select1/detail_mask",
														list = {
															detail_txt = {
																path = "bg/info_bg/select_formation/right_widget/select1/detail_mask/detail_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															detail_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select1/detail_mask/detail_txt2",
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
															"TextScroller"
														}
													},
													formation5 = {
														path = "bg/info_bg/select_formation/right_widget/select1/formation5",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation5/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation5/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation5/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation5/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation5/point5",
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
													formation4 = {
														path = "bg/info_bg/select_formation/right_widget/select1/formation4",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation4/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation4/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation4/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select1/formation4/point4",
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
													"UnityEngine.UI.Button"
												}
											},
											select2 = {
												path = "bg/info_bg/select_formation/right_widget/select2",
												list = {
													formation6 = {
														path = "bg/info_bg/select_formation/right_widget/select2/formation6",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation6/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation6/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation6/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation6/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation6/point5",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point6 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation6/point6",
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
													name_txt = {
														path = "bg/info_bg/select_formation/right_widget/select2/name_txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													title_mask = {
														path = "bg/info_bg/select_formation/right_widget/select2/title_mask",
														list = {
															txt = {
																path = "bg/info_bg/select_formation/right_widget/select2/title_mask/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															txt_2 = {
																path = "bg/info_bg/select_formation/right_widget/select2/title_mask/txt_2",
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
															"TextHorizonScroller"
														}
													},
													desc_mask = {
														path = "bg/info_bg/select_formation/right_widget/select2/desc_mask",
														list = {
															desc_txt = {
																path = "bg/info_bg/select_formation/right_widget/select2/desc_mask/desc_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															desc_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select2/desc_mask/desc_txt2",
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
															"TextScroller"
														}
													},
													detail_mask = {
														path = "bg/info_bg/select_formation/right_widget/select2/detail_mask",
														list = {
															detail_txt = {
																path = "bg/info_bg/select_formation/right_widget/select2/detail_mask/detail_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															detail_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select2/detail_mask/detail_txt2",
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
															"TextScroller"
														}
													},
													formation5 = {
														path = "bg/info_bg/select_formation/right_widget/select2/formation5",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation5/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation5/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation5/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation5/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation5/point5",
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
													formation4 = {
														path = "bg/info_bg/select_formation/right_widget/select2/formation4",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation4/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation4/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation4/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select2/formation4/point4",
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
													"UnityEngine.UI.Button"
												}
											},
											select3 = {
												path = "bg/info_bg/select_formation/right_widget/select3",
												list = {
													formation6 = {
														path = "bg/info_bg/select_formation/right_widget/select3/formation6",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation6/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation6/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation6/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation6/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation6/point5",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point6 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation6/point6",
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
													name_txt = {
														path = "bg/info_bg/select_formation/right_widget/select3/name_txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													title_mask = {
														path = "bg/info_bg/select_formation/right_widget/select3/title_mask",
														list = {
															txt = {
																path = "bg/info_bg/select_formation/right_widget/select3/title_mask/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															txt_2 = {
																path = "bg/info_bg/select_formation/right_widget/select3/title_mask/txt_2",
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
															"TextHorizonScroller"
														}
													},
													desc_mask = {
														path = "bg/info_bg/select_formation/right_widget/select3/desc_mask",
														list = {
															desc_txt = {
																path = "bg/info_bg/select_formation/right_widget/select3/desc_mask/desc_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															desc_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select3/desc_mask/desc_txt2",
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
															"TextScroller"
														}
													},
													detail_mask = {
														path = "bg/info_bg/select_formation/right_widget/select3/detail_mask",
														list = {
															detail_txt = {
																path = "bg/info_bg/select_formation/right_widget/select3/detail_mask/detail_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															detail_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select3/detail_mask/detail_txt2",
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
															"TextScroller"
														}
													},
													formation5 = {
														path = "bg/info_bg/select_formation/right_widget/select3/formation5",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation5/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation5/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation5/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation5/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation5/point5",
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
													formation4 = {
														path = "bg/info_bg/select_formation/right_widget/select3/formation4",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation4/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation4/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation4/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select3/formation4/point4",
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
													"UnityEngine.UI.Button"
												}
											},
											select4 = {
												path = "bg/info_bg/select_formation/right_widget/select4",
												list = {
													formation6 = {
														path = "bg/info_bg/select_formation/right_widget/select4/formation6",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation6/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation6/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation6/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation6/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation6/point5",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point6 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation6/point6",
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
													name_txt = {
														path = "bg/info_bg/select_formation/right_widget/select4/name_txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													title_mask = {
														path = "bg/info_bg/select_formation/right_widget/select4/title_mask",
														list = {
															txt = {
																path = "bg/info_bg/select_formation/right_widget/select4/title_mask/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															txt_2 = {
																path = "bg/info_bg/select_formation/right_widget/select4/title_mask/txt_2",
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
															"TextHorizonScroller"
														}
													},
													desc_mask = {
														path = "bg/info_bg/select_formation/right_widget/select4/desc_mask",
														list = {
															desc_txt = {
																path = "bg/info_bg/select_formation/right_widget/select4/desc_mask/desc_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															desc_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select4/desc_mask/desc_txt2",
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
															"TextScroller"
														}
													},
													detail_mask = {
														path = "bg/info_bg/select_formation/right_widget/select4/detail_mask",
														list = {
															detail_txt = {
																path = "bg/info_bg/select_formation/right_widget/select4/detail_mask/detail_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															detail_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select4/detail_mask/detail_txt2",
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
															"TextScroller"
														}
													},
													formation5 = {
														path = "bg/info_bg/select_formation/right_widget/select4/formation5",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation5/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation5/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation5/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation5/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation5/point5",
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
													formation4 = {
														path = "bg/info_bg/select_formation/right_widget/select4/formation4",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation4/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation4/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation4/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select4/formation4/point4",
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
													"UnityEngine.UI.Button"
												}
											},
											select5 = {
												path = "bg/info_bg/select_formation/right_widget/select5",
												list = {
													formation6 = {
														path = "bg/info_bg/select_formation/right_widget/select5/formation6",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation6/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation6/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation6/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation6/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation6/point5",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point6 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation6/point6",
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
													name_txt = {
														path = "bg/info_bg/select_formation/right_widget/select5/name_txt",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													title_mask = {
														path = "bg/info_bg/select_formation/right_widget/select5/title_mask",
														list = {
															txt = {
																path = "bg/info_bg/select_formation/right_widget/select5/title_mask/txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															txt_2 = {
																path = "bg/info_bg/select_formation/right_widget/select5/title_mask/txt_2",
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
															"TextHorizonScroller"
														}
													},
													desc_mask = {
														path = "bg/info_bg/select_formation/right_widget/select5/desc_mask",
														list = {
															desc_txt = {
																path = "bg/info_bg/select_formation/right_widget/select5/desc_mask/desc_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															desc_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select5/desc_mask/desc_txt2",
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
															"TextScroller"
														}
													},
													detail_mask = {
														path = "bg/info_bg/select_formation/right_widget/select5/detail_mask",
														list = {
															detail_txt = {
																path = "bg/info_bg/select_formation/right_widget/select5/detail_mask/detail_txt",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															detail_txt2 = {
																path = "bg/info_bg/select_formation/right_widget/select5/detail_mask/detail_txt2",
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
															"TextScroller"
														}
													},
													formation5 = {
														path = "bg/info_bg/select_formation/right_widget/select5/formation5",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation5/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation5/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation5/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation5/point4",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point5 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation5/point5",
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
													formation4 = {
														path = "bg/info_bg/select_formation/right_widget/select5/formation4",
														list = {
															point1 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation4/point1",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point2 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation4/point2",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point3 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation4/point3",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															point4 = {
																path = "bg/info_bg/select_formation/right_widget/select5/formation4/point4",
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
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasGroup",
									"UnityEngine.CanvasRenderer"
								}
							},
							consume_bg = {
								path = "bg/info_bg/consume_bg",
								list = {
									bg = {
										path = "bg/info_bg/consume_bg/bg",
										list = {
											title = {
												path = "bg/info_bg/consume_bg/bg/title",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											oil_icon = {
												path = "bg/info_bg/consume_bg/bg/oil_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_consume_txt = {
												path = "bg/info_bg/consume_bg/bg/oil_consume_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											bullet_icon = {
												path = "bg/info_bg/consume_bg/bg/bullet_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_consume_txt = {
												path = "bg/info_bg/consume_bg/bg/bullet_consume_txt",
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
									"UnityEngine.CanvasGroup"
								}
							},
							strongattack = {
								path = "bg/info_bg/strongattack",
								list = {
									bg = {
										path = "bg/info_bg/strongattack/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									titlebg = {
										path = "bg/info_bg/strongattack/titlebg",
										list = {
											title = {
												path = "bg/info_bg/strongattack/titlebg/title",
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
									circle_1 = {
										path = "bg/info_bg/strongattack/circle_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									circle_2 = {
										path = "bg/info_bg/strongattack/circle_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"TweenRotation"
										}
									},
									string_node1 = {
										path = "bg/info_bg/strongattack/string_node1",
										list = {
											title_bg = {
												path = "bg/info_bg/strongattack/string_node1/title_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_name = {
												path = "bg/info_bg/strongattack/string_node1/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_info = {
												path = "bg/info_bg/strongattack/string_node1/attr_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											info_text = {
												path = "bg/info_bg/strongattack/string_node1/info_text",
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
									string_node2 = {
										path = "bg/info_bg/strongattack/string_node2",
										list = {
											title_bg = {
												path = "bg/info_bg/strongattack/string_node2/title_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_name = {
												path = "bg/info_bg/strongattack/string_node2/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_info = {
												path = "bg/info_bg/strongattack/string_node2/attr_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											info_text = {
												path = "bg/info_bg/strongattack/string_node2/info_text",
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
									string_node4 = {
										path = "bg/info_bg/strongattack/string_node4",
										list = {
											title_bg = {
												path = "bg/info_bg/strongattack/string_node4/title_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_name = {
												path = "bg/info_bg/strongattack/string_node4/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_info = {
												path = "bg/info_bg/strongattack/string_node4/attr_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											info_text = {
												path = "bg/info_bg/strongattack/string_node4/info_text",
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
									string_node3 = {
										path = "bg/info_bg/strongattack/string_node3",
										list = {
											title_bg = {
												path = "bg/info_bg/strongattack/string_node3/title_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_name = {
												path = "bg/info_bg/strongattack/string_node3/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_info = {
												path = "bg/info_bg/strongattack/string_node3/attr_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											info_text = {
												path = "bg/info_bg/strongattack/string_node3/info_text",
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
									string_node5 = {
										path = "bg/info_bg/strongattack/string_node5",
										list = {
											title_bg = {
												path = "bg/info_bg/strongattack/string_node5/title_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_name = {
												path = "bg/info_bg/strongattack/string_node5/buff_name",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											attr_info = {
												path = "bg/info_bg/strongattack/string_node5/attr_info",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											info_text = {
												path = "bg/info_bg/strongattack/string_node5/info_text",
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
									"UnityEngine.CanvasGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					select_node_layer = {
						path = "bg/select_node_layer",
						list = {
							static_text = {
								path = "bg/select_node_layer/static_text",
								list = {
									back = {
										path = "bg/select_node_layer/static_text/back",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			select_1 = {
				path = "bg/select_1",
				list = {
					point = {
						path = "bg/select_1/point",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					point_text = {
						path = "bg/select_1/point_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					point_img = {
						path = "bg/select_1/point_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "bg/select_1/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					info_text = {
						path = "bg/select_1/info_text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					select_bg = {
						path = "bg/select_1/select_bg",
						list = {
							select_bg2 = {
								path = "bg/select_1/select_bg/select_bg2",
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
					"UnityEngine.UI.Button"
				}
			},
			mask = {
				path = "mask",
				list = {
					frame = {
						path = "mask/frame",
						list = {
							line = {
								path = "mask/frame/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							continue = {
								path = "mask/frame/continue",
								list = {
									pvecontinue = {
										path = "mask/frame/continue/pvecontinue",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									pvecontinue_mask = {
										path = "mask/frame/continue/pvecontinue_mask",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"TextHorizonScroller"
										}
									},
									txt = {
										path = "mask/frame/continue/pvecontinue_mask/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_2 = {
										path = "mask/frame/continue/pvecontinue_mask/txt_2",
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
							quit = {
								path = "mask/frame/quit",
								list = {
									pvequit = {
										path = "mask/frame/quit/pvequit",
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
							ui_combatcontinuetip = {
								path = "mask/frame/ui_combatcontinuetip",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							ui_tip_mid = {
								path = "mask/frame/ui_tip_mid",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							oil = {
								path = "mask/frame/oil",
								list = {
									icon = {
										path = "mask/frame/oil/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									lineleft = {
										path = "mask/frame/oil/lineleft",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									linelright = {
										path = "mask/frame/oil/linelright",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil = {
										path = "mask/frame/oil/oil",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									percent = {
										path = "mask/frame/oil/percent",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									oil_1 = {
										path = "mask/frame/oil/oil_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_2 = {
										path = "mask/frame/oil/oil_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_3 = {
										path = "mask/frame/oil/oil_3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_4 = {
										path = "mask/frame/oil/oil_4",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_5 = {
										path = "mask/frame/oil/oil_5",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_6 = {
										path = "mask/frame/oil/oil_6",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_7 = {
										path = "mask/frame/oil/oil_7",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_8 = {
										path = "mask/frame/oil/oil_8",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_9 = {
										path = "mask/frame/oil/oil_9",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_10 = {
										path = "mask/frame/oil/oil_10",
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
							bullet = {
								path = "mask/frame/bullet",
								list = {
									icon = {
										path = "mask/frame/bullet/icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									lineleft = {
										path = "mask/frame/bullet/lineleft",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									linelright = {
										path = "mask/frame/bullet/linelright",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet = {
										path = "mask/frame/bullet/bullet",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									percent = {
										path = "mask/frame/bullet/percent",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									bullet_1 = {
										path = "mask/frame/bullet/bullet_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_2 = {
										path = "mask/frame/bullet/bullet_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_3 = {
										path = "mask/frame/bullet/bullet_3",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_4 = {
										path = "mask/frame/bullet/bullet_4",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_5 = {
										path = "mask/frame/bullet/bullet_5",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_6 = {
										path = "mask/frame/bullet/bullet_6",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_7 = {
										path = "mask/frame/bullet/bullet_7",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_8 = {
										path = "mask/frame/bullet/bullet_8",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_9 = {
										path = "mask/frame/bullet/bullet_9",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_10 = {
										path = "mask/frame/bullet/bullet_10",
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
							supply = {
								path = "mask/frame/supply",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							damagecontrol = {
								path = "mask/frame/damagecontrol",
								list = {
									gross = {
										path = "mask/frame/damagecontrol/gross",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									icon = {
										path = "mask/frame/damagecontrol/icon",
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
							buy = {
								path = "mask/frame/buy",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							battlereport = {
								path = "mask/frame/battlereport",
								list = {
									reportbtn = {
										path = "mask/frame/battlereport/reportbtn",
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
							tip = {
								path = "mask/frame/tip",
								list = {
									text = {
										path = "mask/frame/tip/text",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									icon = {
										path = "mask/frame/tip/icon",
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
							danger_layer = {
								path = "mask/frame/danger_layer",
								list = {
									danger_tips = {
										path = "mask/frame/danger_layer/danger_tips",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									infotext = {
										path = "mask/frame/danger_layer/infotext",
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
									"UnityEngine.UI.Button"
								}
							},
							abyss_power = {
								path = "mask/frame/abyss_power",
								list = {
									fill = {
										path = "mask/frame/abyss_power/fill",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									tip = {
										path = "mask/frame/abyss_power/tip",
										list = {
											num = {
												path = "mask/frame/abyss_power/tip/num",
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
					broken_btn = {
						path = "mask/broken_btn",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			broken_info = {
				path = "mask/broken_info",
				list = {
					broken_info_img = {
						path = "mask/broken_info/broken_info_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					top_blue = {
						path = "mask/broken_info/top_blue",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					broken_info_name = {
						path = "mask/broken_info/broken_info_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					middle_white = {
						path = "mask/broken_info/middle_white",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					broken_content = {
						path = "mask/broken_info/broken_content",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			return_home = {
				path = "return_home",
				list = {
					bg = {
						path = "return_home/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					left_layer = {
						path = "return_home/left_layer",
						list = {
							people_icon = {
								path = "return_home/left_layer/people_icon",
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
							"UnityEngine.RectTransform"
						}
					},
					right_layer = {
						path = "return_home/right_layer",
						list = {
							language_image = {
								path = "return_home/right_layer/language_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							return_btn = {
								path = "return_home/right_layer/return_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							return_text = {
								path = "return_home/right_layer/return_text",
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
			boss_new_root = {
				path = "boss_new_root",
				list = {
					boss_new = {
						path = "boss_new_root/boss_new",
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
					"UnityEngine.CanvasGroup"
				}
			},
			abyss_msgbox = {
				path = "abyss_msgbox",
				list = {
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
							select_node_layer = {
								path = "abyss_msgbox/main/select_node_layer",
								list = {
									select_1 = {
										path = "abyss_msgbox/main/select_node_layer/select_1",
										list = {
											dot_image = {
												path = "abyss_msgbox/main/select_node_layer/select_1/dot_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text_one = {
												path = "abyss_msgbox/main/select_node_layer/select_1/text_one",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											text_two = {
												path = "abyss_msgbox/main/select_node_layer/select_1/text_two",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											line = {
												path = "abyss_msgbox/main/select_node_layer/select_1/line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											light = {
												path = "abyss_msgbox/main/select_node_layer/select_1/light",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mask_image = {
												path = "abyss_msgbox/main/select_node_layer/select_1/mask_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											select = {
												path = "abyss_msgbox/main/select_node_layer/select_1/select",
												list = {
													["1"] = {
														path = "abyss_msgbox/main/select_node_layer/select_1/select/1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													background_image = {
														path = "abyss_msgbox/main/select_node_layer/select_1/select/background_image",
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
											buff_image = {
												path = "abyss_msgbox/main/select_node_layer/select_1/buff_image",
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
									select_2 = {
										path = "abyss_msgbox/main/select_node_layer/select_2",
										list = {
											dot_image = {
												path = "abyss_msgbox/main/select_node_layer/select_2/dot_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text_one = {
												path = "abyss_msgbox/main/select_node_layer/select_2/text_one",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											text_two = {
												path = "abyss_msgbox/main/select_node_layer/select_2/text_two",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											line = {
												path = "abyss_msgbox/main/select_node_layer/select_2/line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											light = {
												path = "abyss_msgbox/main/select_node_layer/select_2/light",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mask_image = {
												path = "abyss_msgbox/main/select_node_layer/select_2/mask_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											select = {
												path = "abyss_msgbox/main/select_node_layer/select_2/select",
												list = {
													["1"] = {
														path = "abyss_msgbox/main/select_node_layer/select_2/select/1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													background_image = {
														path = "abyss_msgbox/main/select_node_layer/select_2/select/background_image",
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
											buff_image = {
												path = "abyss_msgbox/main/select_node_layer/select_2/buff_image",
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
									select_3 = {
										path = "abyss_msgbox/main/select_node_layer/select_3",
										list = {
											dot_image = {
												path = "abyss_msgbox/main/select_node_layer/select_3/dot_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											text_one = {
												path = "abyss_msgbox/main/select_node_layer/select_3/text_one",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											text_two = {
												path = "abyss_msgbox/main/select_node_layer/select_3/text_two",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											line = {
												path = "abyss_msgbox/main/select_node_layer/select_3/line",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											light = {
												path = "abyss_msgbox/main/select_node_layer/select_3/light",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											mask_image = {
												path = "abyss_msgbox/main/select_node_layer/select_3/mask_image",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											select = {
												path = "abyss_msgbox/main/select_node_layer/select_3/select",
												list = {
													["1"] = {
														path = "abyss_msgbox/main/select_node_layer/select_3/select/1",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													background_image = {
														path = "abyss_msgbox/main/select_node_layer/select_3/select/background_image",
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
											buff_image = {
												path = "abyss_msgbox/main/select_node_layer/select_3/buff_image",
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
									"UnityEngine.RectTransform"
								}
							},
							line = {
								path = "abyss_msgbox/main/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							text_dot = {
								path = "abyss_msgbox/main/text_dot",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							text_image = {
								path = "abyss_msgbox/main/text_image",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIScaleTweener",
							"UIScaleTweener"
						}
					},
					select_msg_btn = {
						path = "abyss_msgbox/select_msg_btn",
						list = {
							text = {
								path = "abyss_msgbox/select_msg_btn/text",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			abyss_combat_node = {
				path = "abyss_combat_node",
				list = {
					black = {
						path = "abyss_combat_node/black",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					node_image = {
						path = "abyss_combat_node/node_image",
						list = {
							tip_text = {
								path = "abyss_combat_node/node_image/tip_text",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UIScaleTweener"
				}
			},
			fearlessness_buff_msgbox = {
				path = "fearlessness_buff_msgbox",
				list = {
					black = {
						path = "fearlessness_buff_msgbox/black",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UITweenSequence"
						}
					},
					line = {
						path = "fearlessness_buff_msgbox/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "fearlessness_buff_msgbox/main",
						list = {
							select_node_layer = {
								path = "fearlessness_buff_msgbox/main/select_node_layer",
								list = {
									select_buff_1 = {
										path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_1",
										list = {
											buff = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_1/buff",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_mask = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_1/buff_mask",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											Text = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_1/Text",
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
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									select_buff_2 = {
										path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_2",
										list = {
											buff = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_2/buff",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_mask = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_2/buff_mask",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											Text = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_2/Text",
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
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									select_buff_3 = {
										path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_3",
										list = {
											buff = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_3/buff",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buff_mask = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_3/buff_mask",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											Text = {
												path = "fearlessness_buff_msgbox/main/select_node_layer/select_buff_3/Text",
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
							text_image = {
								path = "fearlessness_buff_msgbox/main/text_image",
								list = {
									Text = {
										path = "fearlessness_buff_msgbox/main/text_image/Text",
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
					select_mask = {
						path = "fearlessness_buff_msgbox/select_mask",
						list = {
							left = {
								path = "fearlessness_buff_msgbox/select_mask/left",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							right = {
								path = "fearlessness_buff_msgbox/select_mask/right",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip = {
								path = "fearlessness_buff_msgbox/select_mask/tip",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			msg_panel = {
				path = "msg_panel",
				list = {
					finish_special_mission = {
						path = "msg_panel/finish_special_mission",
						list = {
							finish_title = {
								path = "msg_panel/finish_special_mission/finish_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							award_icon = {
								path = "msg_panel/finish_special_mission/award_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							coin_num = {
								path = "msg_panel/finish_special_mission/coin_num",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							map_title = {
								path = "msg_panel/finish_special_mission/map_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							task_title = {
								path = "msg_panel/finish_special_mission/task_title",
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
					finish_special_mission_btn = {
						path = "msg_panel/finish_special_mission_btn",
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
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1.monster",
			["fight_info/fearlessness_buff_msgbox/line"] = "_control.fearlessness_buff_msgbox.line",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3",
			["fight_info/bg/select_node_layer"] = "_control.bg.select_node_layer",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos6",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/title_mask/txt_2"] = "_control.bg.info_bg.select_formation.right_widget.select1.title_mask.txt_2",
			["fight_info/bg/info_bg/select_formation/right_widget/select1"] = "_control.bg.info_bg.select_formation.right_widget.select1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6.monster",
			["fight_info/mask/frame/bullet/bullet_9"] = "_control.mask.frame.bullet.bullet_9",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation6/point1"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation6.point1",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/select"] = "_control.abyss_msgbox.main.select_node_layer.select_1.select",
			["fight_info/bg/info_bg/enemy_info_bg/line_medium"] = "_control.bg.info_bg.enemy_info_bg.line_medium",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3",
			["fight_info/bg/info_bg/consume_bg/bg/oil_consume_txt"] = "_control.bg.info_bg.consume_bg.bg.oil_consume_txt",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1",
			["fight_info/bg/info_bg/select_formation/right_widget/select5"] = "_control.bg.info_bg.select_formation.right_widget.select5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3",
			["fight_info/bg/select_1"] = "_control.bg.info_bg.strongattack.bg.select_1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2",
			["fight_info/bg/info_bg/mask"] = "_control.bg.info_bg.mask",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1",
			["fight_info/bg/left_people/talk"] = "_control.bg.left_people.talk",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4.monster",
			["fight_info/bg/left_people/talk/label_txt"] = "_control.bg.left_people.talk.label_txt",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/select/background_image"] = "_control.abyss_msgbox.main.select_node_layer.select_1.select.background_image",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2",
			["fight_info/mask/frame/bullet/icon"] = "_control.mask.frame.bullet.icon",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4",
			["fight_info/bg/ship_layer"] = "_control.bg.ship_layer",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/enemy_list"] = "_control.bg.info_bg.enemy_info_bg.enemy_list",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1",
			["fight_info/abyss_msgbox/black"] = "_control.abyss_msgbox.black",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6.monster",
			["fight_info/mask/frame/bullet/lineleft"] = "_control.mask.frame.bullet.lineleft",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2.monster",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_1"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6",
			["fight_info/mask/frame/oil/oil_4"] = "_control.mask.frame.oil.oil_4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1",
			["fight_info/mask/frame/bullet/bullet_1"] = "_control.mask.frame.bullet.bullet_1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6",
			["fight_info/bg/info_bg/lost_enemy_bg/radar_frame/radar_effect1"] = "_control.bg.info_bg.lost_enemy_bg.radar_frame.radar_effect1",
			["fight_info/bg/info_bg/select_formation/right_widget/title_txt"] = "_control.bg.info_bg.select_formation.right_widget.title_txt",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset",
			["fight_info/bg/info_bg/consume_bg/bg"] = "_control.bg.info_bg.consume_bg.bg",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/circuity_btn"] = "_control.bg.info_bg.enemy_info_bg.circuity_btn",
			["fight_info/return_home/bg"] = "_control.return_home.bg",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3.monster",
			["fight_info/bg/boss_hp"] = "_control.bg.boss_hp",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos3.monster",
			["fight_info/mask/frame/oil/icon"] = "_control.mask.frame.oil.icon",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2",
			["fight_info/mask/frame/bullet/bullet"] = "_control.mask.frame.bullet.bullet",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/bvr_btn/spine_effect"] = "_control.bg.info_bg.enemy_info_bg.bvr_btn.spine_effect",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos2",
			["fight_info/mask/frame/oil/oil_1"] = "_control.mask.frame.oil.oil_1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5.monster",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_1/Text"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.Text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num1.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num1.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num2",
			["fight_info/bg/info_bg/strongattack/string_node3"] = "_control.bg.info_bg.strongattack.string_node3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/select_formation/left_widget/word_bg/first_ship_word"] = "_control.bg.info_bg.select_formation.left_widget.word_bg.first_ship_word",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3",
			["fight_info/bg/info_bg/strongattack/titlebg/title"] = "_control.bg.info_bg.strongattack.titlebg.title",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/fight_btn/text"] = "_control.bg.info_bg.enemy_info_bg.fight_btn.text",
			["fight_info/bg/title_bg/content"] = "_control.bg.title_bg.content",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6",
			["fight_info/bg/info_bg/lost_enemy_bg/title"] = "_control.bg.info_bg.lost_enemy_bg.title",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos1.monster",
			["fight_info/msg_panel"] = "_control.msg_panel",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos6.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos4",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/title_mask/txt"] = "_control.bg.info_bg.select_formation.right_widget.select1.title_mask.txt",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/select_formation/left_widget/first_ship_pic"] = "_control.bg.info_bg.select_formation.left_widget.first_ship_pic",
			["fight_info/bg/info_bg/enemy_info_bg"] = "_control.bg.info_bg.enemy_info_bg",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/consume_bg/bg/bullet_icon"] = "_control.bg.info_bg.consume_bg.bg.bullet_icon",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num1.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/condition_bg"] = "_control.bg.info_bg.condition_bg",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos5",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/detail_mask"] = "_control.bg.info_bg.select_formation.right_widget.select1.detail_mask",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset",
			["fight_info/mask/frame/oil/oil_8"] = "_control.mask.frame.oil.oil_8",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos6.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos6",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos2",
			["fight_info/mask/frame/ui_combatcontinuetip"] = "_control.mask.frame.ui_combatcontinuetip",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6",
			["fight_info/bg/info_bg/strongattack/string_node4"] = "_control.bg.info_bg.strongattack.string_node4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos6.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/lost_enemy_bg/radar_frame"] = "_control.bg.info_bg.lost_enemy_bg.radar_frame",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos3",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer"] = "_control.fearlessness_buff_msgbox.main.select_node_layer",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos3",
			["fight_info/mask/frame/abyss_power/tip/num"] = "_control.mask.frame.abyss_power.tip.num",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation4"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4",
			["fight_info/mask/frame/damagecontrol/icon"] = "_control.mask.frame.damagecontrol.icon",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3"] = "_control.abyss_msgbox.main.select_node_layer.select_3",
			["fight_info/return_home/right_layer"] = "_control.return_home.right_layer",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos2",
			["fight_info/abyss_msgbox/select_msg_btn"] = "_control.abyss_msgbox.select_msg_btn",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/enemy_info_txt"] = "_control.bg.info_bg.enemy_info_bg.enemy_info_txt",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos3",
			["fight_info/mask/frame/continue/pvecontinue"] = "_control.mask.frame.continue.pvecontinue",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos1.monster",
			["fight_info/bg/info_bg/select_formation/right_widget/select2"] = "_control.bg.info_bg.select_formation.right_widget.select2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/round_about"] = "_control.bg.info_bg.lock_enemy_bg.round_about",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos6",
			["fight_info/bg/left_people/talk/bg1"] = "_control.bg.left_people.talk.bg1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2",
			["fight_info/mask/frame/oil/oil_9"] = "_control.mask.frame.oil.oil_9",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num1.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset",
			["fight_info/mask/frame/tip/text"] = "_control.mask.frame.tip.text",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_1/buff"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.buff",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos2",
			["fight_info/abyss_msgbox/main/line"] = "_control.abyss_msgbox.main.line",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation6/point4"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation6.point4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num1.offset.pos1",
			["fight_info/mask/frame/bullet/bullet_8"] = "_control.mask.frame.bullet.bullet_8",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos3.monster",
			["fight_info/bg/select_node_layer/static_text/back"] = "_control.bg.select_node_layer.static_text.back",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/radar_effect1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.radar_effect1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3",
			["fight_info/bg/info_bg/enemy_info_bg/bg"] = "_control.bg.info_bg.enemy_info_bg.bg",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos3.monster",
			["fight_info/mask/frame/oil/oil_3"] = "_control.mask.frame.oil.oil_3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/strongattack/string_node2"] = "_control.bg.info_bg.strongattack.string_node2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num1",
			["fight_info/mask/frame/oil/oil_7"] = "_control.mask.frame.oil.oil_7",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num1.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num1.offset.pos1.monster",
			["fight_info/fearlessness_buff_msgbox/select_mask"] = "_control.fearlessness_buff_msgbox.select_mask",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos2.monster",
			["fight_info/mask/frame/oil/oil"] = "_control.mask.frame.oil.oil",
			["fight_info/bg/info_bg/select_formation/right_widget"] = "_control.bg.info_bg.select_formation.right_widget",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos6",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos6.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos1",
			["fight_info/bg/boss_title"] = "_control.bg.boss_title",
			["fight_info/bg/return_btn"] = "_control.bg.return_btn",
			["fight_info/mask/frame/battlereport/reportbtn"] = "_control.mask.frame.battlereport.reportbtn",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos3",
			["fight_info/bg/select_1/point_text"] = "_control.bg.info_bg.strongattack.bg.select_1.point_text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/rate_bg/rate"] = "_control.bg.info_bg.lock_enemy_bg.rate_bg.rate",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/radar_effect2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.radar_effect2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/detail_mask/detail_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select1.detail_mask.detail_txt2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos2",
			["fight_info/bg/return_btn/return_text"] = "_control.bg.return_btn.return_text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num1.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num1.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/text_two"] = "_control.abyss_msgbox.main.select_node_layer.select_1.text_two",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/desc_mask"] = "_control.bg.info_bg.select_formation.right_widget.select1.desc_mask",
			["fight_info/bg/info_bg/strongattack/circle_2"] = "_control.bg.info_bg.strongattack.circle_2",
			["fight_info/bg/ship_layer/encounter_effect"] = "_control.bg.ship_layer.encounter_effect",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos4.monster",
			["fight_info/mask/frame/abyss_power/fill"] = "_control.mask.frame.abyss_power.fill",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos6",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos6.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset",
			["fight_info/bg/info_bg/lock_enemy_bg"] = "_control.bg.info_bg.lock_enemy_bg",
			["fight_info/bg/info_bg/enemy_info_bg/bvr_btn/text"] = "_control.bg.info_bg.enemy_info_bg.bvr_btn.text",
			["fight_info/bg/map_path"] = "_control.bg.map_path",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos3",
			["fight_info/bg/info_bg/strongattack/bg"] = "_control.bg.info_bg.strongattack.bg",
			["fight_info/bg/info_bg/strongattack/titlebg"] = "_control.bg.info_bg.strongattack.titlebg",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/line_bottom/random_tip_Text"] = "_control.bg.info_bg.enemy_info_bg.line_bottom.random_tip_Text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos1.monster",
			["fight_info/fearlessness_buff_msgbox"] = "_control.fearlessness_buff_msgbox",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3",
			["fight_info/mask"] = "_control.mask",
			["fight_info/bg/select_1/point_img"] = "_control.bg.info_bg.strongattack.bg.select_1.point_img",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos1.monster",
			["fight_info/mask/frame/continue/pvecontinue_mask/txt_2"] = "_control.mask.frame.continue.txt_2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6.monster",
			["fight_info/bg/info_bg/enemy_info_bg/line_bottom/random_tip_Text/Text"] = "_control.bg.info_bg.enemy_info_bg.line_bottom.random_tip_Text.Text",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1.monster",
			["fight_info/mask/frame/bullet/bullet_5"] = "_control.mask.frame.bullet.bullet_5",
			["fight_info/fearlessness_buff_msgbox/black"] = "_control.fearlessness_buff_msgbox.black",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1.monster",
			["fight_info/mask/frame/oil/lineleft"] = "_control.mask.frame.oil.lineleft",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3",
			["fight_info/bg/info_bg/skip_btn"] = "_control.bg.info_bg.skip_btn",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset",
			["fight_info/mask/frame/danger_layer/infotext"] = "_control.mask.frame.danger_layer.infotext",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3",
			["fight_info/bg/info_bg/encounter_bg/encounter_spine"] = "_control.bg.info_bg.encounter_bg.encounter_spine",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2.monster",
			["fight_info/mask/frame/bullet"] = "_control.mask.frame.bullet",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset",
			["fight_info/bg/boss_slider"] = "_control.bg.boss_slider",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6",
			["fight_info/fearlessness_buff_msgbox/main/text_image/Text"] = "_control.fearlessness_buff_msgbox.main.text_image.Text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5",
			["fight_info/mask/frame/supply"] = "_control.mask.frame.supply",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation6/point3"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation6.point3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation5"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation5",
			["fight_info/bg/info_bg/select_formation/right_widget/select3"] = "_control.bg.info_bg.select_formation.right_widget.select3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1.monster",
			["fight_info/bg/campaign_bg"] = "_control.bg.campaign_bg",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4",
			["fight_info/bg/select_node_layer/static_text"] = "_control.bg.select_node_layer.static_text",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2",
			["fight_info/mask/broken_info/broken_info_name"] = "_control.broken_info.broken_info_name",
			["fight_info/bg/info_bg/enemy_info_bg/bvr_btn"] = "_control.bg.info_bg.enemy_info_bg.bvr_btn",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num1",
			["fight_info/mask/frame/quit/pvequit"] = "_control.mask.frame.quit.pvequit",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/back_btn/text"] = "_control.bg.info_bg.enemy_info_bg.back_btn.text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos4",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2"] = "_control.abyss_msgbox.main.select_node_layer.select_2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/mask_image"] = "_control.abyss_msgbox.main.select_node_layer.select_1.mask_image",
			["fight_info/bg/info_bg/enemy_info_bg/circuity_img"] = "_control.bg.info_bg.enemy_info_bg.circuity_img",
			["fight_info/bg/info_bg/select_formation"] = "_control.bg.info_bg.select_formation",
			["fight_info/mask/frame/oil/oil_10"] = "_control.mask.frame.oil.oil_10",
			["fight_info/fearlessness_buff_msgbox/select_mask/tip"] = "_control.fearlessness_buff_msgbox.select_mask.tip",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_3"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3",
			["fight_info/mask/frame/continue/pvecontinue_mask/txt"] = "_control.mask.frame.continue.txt",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos1",
			["fight_info/mask/frame/oil/oil_2"] = "_control.mask.frame.oil.oil_2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset",
			["fight_info/bg/info_bg/enemy_info_bg/line_top"] = "_control.bg.info_bg.enemy_info_bg.line_top",
			["fight_info/return_home/right_layer/language_image"] = "_control.return_home.right_layer.language_image",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation5/point2"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation5.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation5/point3"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation5.point3",
			["fight_info/bg/info_bg"] = "_control.bg.info_bg",
			["fight_info/bg/info_bg/strongattack/string_node1/attr_info"] = "_control.bg.info_bg.strongattack.string_node1.attr_info",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation5/point5"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation5.point5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2",
			["fight_info/bg/ship_layer/ship_icon"] = "_control.bg.ship_layer.ship_icon",
			["fight_info/bg/info_bg/strongattack/string_node1/title_bg"] = "_control.bg.info_bg.strongattack.string_node1.title_bg",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation4/point2"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation4.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation4/point3"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation4.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation4/point4"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation4.point4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation6"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation6",
			["fight_info/mask/frame/bullet/bullet_7"] = "_control.mask.frame.bullet.bullet_7",
			["fight_info/bg/info_bg/select_formation/right_widget/title_line"] = "_control.bg.info_bg.select_formation.right_widget.title_line",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation6/point2"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation6.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation6/point3"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation6.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation6/point4"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation6.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation6/point5"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation6.point5",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_1/buff_mask"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_1.buff_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/name_txt"] = "_control.bg.info_bg.select_formation.right_widget.select2.name_txt",
			["fight_info/mask/frame/bullet/bullet_3"] = "_control.mask.frame.bullet.bullet_3",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/title_mask/txt"] = "_control.bg.info_bg.select_formation.right_widget.select2.title_mask.txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/title_mask/txt_2"] = "_control.bg.info_bg.select_formation.right_widget.select2.title_mask.txt_2",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/desc_mask"] = "_control.bg.info_bg.select_formation.right_widget.select2.desc_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/desc_mask/desc_txt"] = "_control.bg.info_bg.select_formation.right_widget.select2.desc_mask.desc_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/desc_mask/desc_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select2.desc_mask.desc_txt2",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/detail_mask"] = "_control.bg.info_bg.select_formation.right_widget.select2.detail_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/detail_mask/detail_txt"] = "_control.bg.info_bg.select_formation.right_widget.select2.detail_mask.detail_txt",
			["fight_info/msg_panel/finish_special_mission/finish_title"] = "_control.msg_panel.finish_special_mission.finish_title",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation5"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation5",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation5/point1"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation5.point1",
			["fight_info/bg/title_bg"] = "_control.bg.title_bg",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation5/point2"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation5.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation5/point3"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation5.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation5/point4"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation5.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation5/point5"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation5.point5",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation4"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation4",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation4/point1"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation4.point1",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation4/point2"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation4.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation4/point3"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation4.point3",
			["fight_info/mask/broken_info/middle_white"] = "_control.broken_info.middle_white",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation6"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation6",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation6/point1"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation6.point1",
			["fight_info/bg/title_bg/content/title_txt"] = "_control.bg.title_bg.content.title_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation6/point2"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation6.point2",
			["fight_info/mask/frame"] = "_control.mask.frame",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation6/point4"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation6.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation6/point5"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation6.point5",
			["fight_info/bg/info_bg/random_bg"] = "_control.bg.info_bg.random_bg",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation6/point6"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation6.point6",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/name_txt"] = "_control.bg.info_bg.select_formation.right_widget.select3.name_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/title_mask"] = "_control.bg.info_bg.select_formation.right_widget.select3.title_mask",
			["fight_info/bg/title_bg/content/title_txt_2"] = "_control.bg.title_bg.content.title_txt_2",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/title_mask/txt"] = "_control.bg.info_bg.select_formation.right_widget.select3.title_mask.txt",
			["fight_info/bg/map_bg"] = "_control.bg.map_bg",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/title_mask/txt_2"] = "_control.bg.info_bg.select_formation.right_widget.select3.title_mask.txt_2",
			["fight_info/mask/broken_btn"] = "_control.mask.broken_btn",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/desc_mask/desc_txt"] = "_control.bg.info_bg.select_formation.right_widget.select3.desc_mask.desc_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/desc_mask/desc_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select3.desc_mask.desc_txt2",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/detail_mask"] = "_control.bg.info_bg.select_formation.right_widget.select3.detail_mask",
			["fight_info/bg/info_bg/lock_enemy_bg/rate_bg"] = "_control.bg.info_bg.lock_enemy_bg.rate_bg",
			["fight_info/bg/info_bg/enemy_info_bg/s_enemy_info"] = "_control.bg.info_bg.enemy_info_bg.s_enemy_info",
			["fight_info/bg/select_1/select_bg"] = "_control.bg.info_bg.strongattack.bg.select_1.select_bg",
			["fight_info/abyss_msgbox/main/text_image"] = "_control.abyss_msgbox.main.text_image",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation5"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation5",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation5/point1"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation5.point1",
			["fight_info/mask/frame/oil"] = "_control.mask.frame.oil",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation5/point3"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation5.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation5/point4"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation5.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation5/point5"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation5.point5",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation4"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation4",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation4/point1"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation4.point1",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation4/point2"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation4.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation4/point3"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation4.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation4/point4"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation4.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation6"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation6",
			["fight_info/abyss_combat_node/black"] = "_control.abyss_combat_node.black",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation6/point2"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation6.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation6/point3"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation6.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation6/point4"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation6.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation6/point5"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation6.point5",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation6/point6"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation6.point6",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/name_txt"] = "_control.bg.info_bg.select_formation.right_widget.select4.name_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/title_mask"] = "_control.bg.info_bg.select_formation.right_widget.select4.title_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/title_mask/txt"] = "_control.bg.info_bg.select_formation.right_widget.select4.title_mask.txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/title_mask/txt_2"] = "_control.bg.info_bg.select_formation.right_widget.select4.title_mask.txt_2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame"] = "_control.bg.info_bg.enemy_info_bg.radar_frame",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/desc_mask"] = "_control.bg.info_bg.select_formation.right_widget.select4.desc_mask",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/desc_mask/desc_txt"] = "_control.bg.info_bg.select_formation.right_widget.select4.desc_mask.desc_txt",
			["fight_info/bg/info_bg/consume_bg/bg/oil_icon"] = "_control.bg.info_bg.consume_bg.bg.oil_icon",
			["fight_info/bg/info_bg/enemy_info_bg/line_bottom"] = "_control.bg.info_bg.enemy_info_bg.line_bottom",
			["fight_info/bg/info_bg/enemy_info_bg/back_btn"] = "_control.bg.info_bg.enemy_info_bg.back_btn",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/detail_mask"] = "_control.bg.info_bg.select_formation.right_widget.select4.detail_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/detail_mask/detail_txt"] = "_control.bg.info_bg.select_formation.right_widget.select4.detail_mask.detail_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/detail_mask/detail_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select4.detail_mask.detail_txt2",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation5"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation5",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation5/point1"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation5.point1",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation5/point2"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation5.point2",
			["fight_info/bg/info_bg/strongattack"] = "_control.bg.info_bg.strongattack",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation5/point4"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation5.point4",
			["fight_info/bg"] = "_control.bg",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation5/point5"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation5.point5",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation4"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation4",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation4/point1"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation4.point1",
			["fight_info/abyss_combat_node/node_image"] = "_control.abyss_combat_node.node_image",
			["fight_info/bg/info_bg/round_about_lock_enemy_txt/lock_enemy_info_bg/lock_enemy_info_txt"] = "_control.bg.info_bg.round_about_lock_enemy_txt.lock_enemy_info_bg.lock_enemy_info_txt",
			["fight_info/bg/info_bg/select_formation/left_widget/word_bg/first_ship_name"] = "_control.bg.info_bg.select_formation.left_widget.word_bg.first_ship_name",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation4/point3"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation4.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation4/point4"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation4.point4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation6"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation6",
			["fight_info/msg_panel/finish_special_mission/map_title"] = "_control.msg_panel.finish_special_mission.map_title",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation6/point2"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation6.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation6/point3"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation6.point3",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation6/point4"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation6.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation6/point5"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation6.point5",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation6/point6"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation6.point6",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/name_txt"] = "_control.bg.info_bg.select_formation.right_widget.select5.name_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/title_mask"] = "_control.bg.info_bg.select_formation.right_widget.select5.title_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/title_mask/txt"] = "_control.bg.info_bg.select_formation.right_widget.select5.title_mask.txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/title_mask/txt_2"] = "_control.bg.info_bg.select_formation.right_widget.select5.title_mask.txt_2",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/desc_mask"] = "_control.bg.info_bg.select_formation.right_widget.select5.desc_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/desc_mask/desc_txt"] = "_control.bg.info_bg.select_formation.right_widget.select5.desc_mask.desc_txt",
			["fight_info/abyss_combat_node/node_image/tip_text"] = "_control.abyss_combat_node.node_image.tip_text",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/title_mask"] = "_control.bg.info_bg.select_formation.right_widget.select1.title_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/detail_mask"] = "_control.bg.info_bg.select_formation.right_widget.select5.detail_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/detail_mask/detail_txt"] = "_control.bg.info_bg.select_formation.right_widget.select5.detail_mask.detail_txt",
			["fight_info/mask/frame/danger_layer/danger_tips"] = "_control.mask.frame.danger_layer.danger_tips",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation5"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation5",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation5/point1"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation5.point1",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation5/point2"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation5.point2",
			["fight_info/mask/frame/bullet/bullet_4"] = "_control.mask.frame.bullet.bullet_4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/radar_effect1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.radar_effect1",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation5/point4"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation5.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation5/point5"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation5.point5",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation4"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation4",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation4/point1"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation4.point1",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation4/point2"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation4.point2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation4/point3"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation4.point3",
			["fight_info/bg/select_1/select_bg/select_bg2"] = "_control.bg.info_bg.strongattack.bg.select_1.select_bg.select_bg2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos4",
			["fight_info/bg/info_bg/consume_bg/bg/title"] = "_control.bg.info_bg.consume_bg.bg.title",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/desc_mask/desc_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select4.desc_mask.desc_txt2",
			["fight_info/bg/info_bg/strongattack/string_node1/info_text"] = "_control.bg.info_bg.strongattack.string_node1.info_text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num1.offset.pos1",
			["fight_info/bg/info_bg/consume_bg/bg/bullet_consume_txt"] = "_control.bg.info_bg.consume_bg.bg.bullet_consume_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation5/point3"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation5.point3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos4",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos4.monster",
			["fight_info/bg/left_people"] = "_control.bg.left_people",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/desc_mask/desc_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select1.desc_mask.desc_txt2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/strongattack/string_node1"] = "_control.bg.info_bg.strongattack.string_node1",
			["fight_info/bg/info_bg/strongattack/string_node1/buff_name"] = "_control.bg.info_bg.strongattack.string_node1.buff_name",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation4/point1"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation4.point1",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation5/point4"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation5.point4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos1.monster",
			["fight_info/bg/info_bg/strongattack/string_node2/title_bg"] = "_control.bg.info_bg.strongattack.string_node2.title_bg",
			["fight_info/bg/info_bg/strongattack/string_node2/buff_name"] = "_control.bg.info_bg.strongattack.string_node2.buff_name",
			["fight_info/abyss_msgbox"] = "_control.abyss_msgbox",
			["fight_info/bg/info_bg/lock_enemy_bg/lock_enemy_spine"] = "_control.bg.info_bg.lock_enemy_bg.lock_enemy_spine",
			["fight_info/bg/info_bg/strongattack/string_node2/info_text"] = "_control.bg.info_bg.strongattack.string_node2.info_text",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation6/point2"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation6.point2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos3.monster",
			["fight_info/bg/info_bg/strongattack/string_node4/title_bg"] = "_control.bg.info_bg.strongattack.string_node4.title_bg",
			["fight_info/mask/frame/continue"] = "_control.mask.frame.continue",
			["fight_info/bg/info_bg/strongattack/string_node4/attr_info"] = "_control.bg.info_bg.strongattack.string_node4.attr_info",
			["fight_info/bg/info_bg/strongattack/string_node4/info_text"] = "_control.bg.info_bg.strongattack.string_node4.info_text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos3.monster",
			["fight_info/bg/info_bg/strongattack/string_node3/title_bg"] = "_control.bg.info_bg.strongattack.string_node3.title_bg",
			["fight_info/bg/info_bg/strongattack/string_node3/buff_name"] = "_control.bg.info_bg.strongattack.string_node3.buff_name",
			["fight_info/bg/info_bg/strongattack/string_node3/attr_info"] = "_control.bg.info_bg.strongattack.string_node3.attr_info",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num2",
			["fight_info/mask/frame/battlereport"] = "_control.mask.frame.battlereport",
			["fight_info/bg/info_bg/strongattack/string_node5/title_bg"] = "_control.bg.info_bg.strongattack.string_node5.title_bg",
			["fight_info/bg/info_bg/strongattack/string_node5/buff_name"] = "_control.bg.info_bg.strongattack.string_node5.buff_name",
			["fight_info/bg/info_bg/strongattack/string_node5/attr_info"] = "_control.bg.info_bg.strongattack.string_node5.attr_info",
			["fight_info/bg/info_bg/strongattack/string_node5/info_text"] = "_control.bg.info_bg.strongattack.string_node5.info_text",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2.monster",
			["fight_info/mask/frame/bullet/linelright"] = "_control.mask.frame.bullet.linelright",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3",
			["fight_info/bg/info_bg/select_formation/mask"] = "_control.bg.info_bg.select_formation.mask",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num1",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/detail_mask/detail_txt"] = "_control.bg.info_bg.select_formation.right_widget.select3.detail_mask.detail_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation4/point4"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation4.point4",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation6"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation6",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/detail_mask/detail_txt"] = "_control.bg.info_bg.select_formation.right_widget.select1.detail_mask.detail_txt",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation6/point3"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation6.point3",
			["fight_info/bg/info_bg/strongattack/string_node4/buff_name"] = "_control.bg.info_bg.strongattack.string_node4.buff_name",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num5"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num5",
			["fight_info/mask/frame/continue/pvecontinue_mask"] = "_control.mask.frame.continue.pvecontinue_mask",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos1.monster",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/formation5/point2"] = "_control.bg.info_bg.select_formation.right_widget.select3.formation5.point2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2",
			["fight_info/bg/info_bg/lock_enemy_bg/round_about_spine"] = "_control.bg.info_bg.lock_enemy_bg.round_about_spine",
			["fight_info/mask/frame/oil/linelright"] = "_control.mask.frame.oil.linelright",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos3",
			["fight_info/bg/info_bg/lost_enemy_bg/radar_frame/radar_effect2"] = "_control.bg.info_bg.lost_enemy_bg.radar_frame.radar_effect2",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/desc_mask/desc_txt"] = "_control.bg.info_bg.select_formation.right_widget.select1.desc_mask.desc_txt",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6.monster",
			["fight_info/bg_r"] = "_control.bg_r",
			["fight_info/mask/frame/oil/oil_5"] = "_control.mask.frame.oil.oil_5",
			["fight_info/mask/frame/oil/oil_6"] = "_control.mask.frame.oil.oil_6",
			["fight_info/mask/frame/abyss_power"] = "_control.mask.frame.abyss_power",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos3",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1"] = "_control.abyss_msgbox.main.select_node_layer.select_1",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation6/point6"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation6.point6",
			["fight_info/mask/broken_info/broken_content"] = "_control.broken_info.broken_content",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos5.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/title_mask"] = "_control.bg.info_bg.select_formation.right_widget.select2.title_mask",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation5/point3"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation5.point3",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2",
			["fight_info/bg/select_1/title"] = "_control.bg.info_bg.strongattack.bg.select_1.title",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation6/point1"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation6.point1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5.monster",
			["fight_info/fearlessness_buff_msgbox/select_mask/right"] = "_control.fearlessness_buff_msgbox.select_mask.right",
			["fight_info/mask/frame/damagecontrol/gross"] = "_control.mask.frame.damagecontrol.gross",
			["fight_info/msg_panel/finish_special_mission"] = "_control.msg_panel.finish_special_mission",
			["fight_info/mask/frame/buy"] = "_control.mask.frame.buy",
			["fight_info/bg/info_bg/strongattack/string_node3/info_text"] = "_control.bg.info_bg.strongattack.string_node3.info_text",
			["fight_info/mask/frame/line"] = "_control.mask.frame.line",
			["fight_info/mask/frame/oil/percent"] = "_control.mask.frame.oil.percent",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos3",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos1.monster",
			["fight_info/mask/broken_info/top_blue"] = "_control.broken_info.top_blue",
			["fight_info/mask/frame/damagecontrol"] = "_control.mask.frame.damagecontrol",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1.monster",
			["fight_info/mask/frame/tip/icon"] = "_control.mask.frame.tip.icon",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_2"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation2.num1.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos5",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos2.monster",
			["fight_info/mask/frame/tip"] = "_control.mask.frame.tip",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/round_about_lock_enemy_txt/lock_enemy_info_bg"] = "_control.bg.info_bg.round_about_lock_enemy_txt.lock_enemy_info_bg",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation4/point4"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation4.point4",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num1",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/desc_mask"] = "_control.bg.info_bg.select_formation.right_widget.select3.desc_mask",
			["fight_info/return_home"] = "_control.return_home",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset",
			["fight_info/return_home/left_layer"] = "_control.return_home.left_layer",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos1",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation5/point1"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation5.point1",
			["fight_info/return_home/right_layer/return_btn"] = "_control.return_home.right_layer.return_btn",
			["fight_info/bg/left_people/talk/bg1/bg2"] = "_control.bg.left_people.talk.bg1.bg2",
			["fight_info/return_home/right_layer/return_text"] = "_control.return_home.right_layer.return_text",
			["fight_info/boss_new_root"] = "_control.boss_new_root",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/line"] = "_control.abyss_msgbox.main.select_node_layer.select_1.line",
			["fight_info/bg/info_bg/encounter_bg"] = "_control.bg.info_bg.encounter_bg",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset",
			["fight_info/abyss_msgbox/main/select_node_layer"] = "_control.abyss_msgbox.main.select_node_layer",
			["fight_info/mask/frame/bullet/bullet_6"] = "_control.mask.frame.bullet.bullet_6",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos1",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/text_one"] = "_control.abyss_msgbox.main.select_node_layer.select_1.text_one",
			["fight_info/return_home/left_layer/people_icon"] = "_control.return_home.left_layer.people_icon",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num1.offset.pos1.monster",
			["fight_info/bg/info_bg/strongattack/string_node2/attr_info"] = "_control.bg.info_bg.strongattack.string_node2.attr_info",
			["fight_info/bg/info_bg/select_formation/left_widget"] = "_control.bg.info_bg.select_formation.left_widget",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1",
			["fight_info/mask/frame/bullet/bullet_2"] = "_control.mask.frame.bullet.bullet_2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2.monster",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/buff_image"] = "_control.abyss_msgbox.main.select_node_layer.select_1.buff_image",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/dot_image"] = "_control.abyss_msgbox.main.select_node_layer.select_1.dot_image",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/dot_image"] = "_control.abyss_msgbox.main.select_node_layer.select_2.dot_image",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/text_one"] = "_control.abyss_msgbox.main.select_node_layer.select_2.text_one",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/text_two"] = "_control.abyss_msgbox.main.select_node_layer.select_2.text_two",
			["fight_info/bg/info_bg/select_formation/right_widget/select4"] = "_control.bg.info_bg.select_formation.right_widget.select4",
			["fight_info/bg/info_bg/enemy_info_bg/circuity_random"] = "_control.bg.info_bg.enemy_info_bg.circuity_random",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/line"] = "_control.abyss_msgbox.main.select_node_layer.select_2.line",
			["fight_info/bg/select_1/info_text"] = "_control.bg.info_bg.strongattack.bg.select_1.info_text",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/light"] = "_control.abyss_msgbox.main.select_node_layer.select_2.light",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/mask_image"] = "_control.abyss_msgbox.main.select_node_layer.select_2.mask_image",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/select"] = "_control.abyss_msgbox.main.select_node_layer.select_2.select",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/select/1"] = "_control.abyss_msgbox.main.select_node_layer.select_2.select.1",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/select/1"] = "_control.abyss_msgbox.main.select_node_layer.select_1.select.1",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/select/background_image"] = "_control.abyss_msgbox.main.select_node_layer.select_2.select.background_image",
			["fight_info/mask/frame/quit"] = "_control.mask.frame.quit",
			["fight_info/abyss_msgbox/main/select_node_layer/select_2/buff_image"] = "_control.abyss_msgbox.main.select_node_layer.select_2.buff_image",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos1.monster",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/dot_image"] = "_control.abyss_msgbox.main.select_node_layer.select_3.dot_image",
			["fight_info/bg/map_mask"] = "_control.bg.map_mask",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/text_one"] = "_control.abyss_msgbox.main.select_node_layer.select_3.text_one",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/text_two"] = "_control.abyss_msgbox.main.select_node_layer.select_3.text_two",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/line"] = "_control.abyss_msgbox.main.select_node_layer.select_3.line",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/light"] = "_control.abyss_msgbox.main.select_node_layer.select_3.light",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/mask_image"] = "_control.abyss_msgbox.main.select_node_layer.select_3.mask_image",
			["fight_info/mask/frame/bullet/percent"] = "_control.mask.frame.bullet.percent",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/select"] = "_control.abyss_msgbox.main.select_node_layer.select_3.select",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/select/1"] = "_control.abyss_msgbox.main.select_node_layer.select_3.select.1",
			["fight_info/abyss_msgbox/main/select_node_layer/select_1/light"] = "_control.abyss_msgbox.main.select_node_layer.select_1.light",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/select/background_image"] = "_control.abyss_msgbox.main.select_node_layer.select_3.select.background_image",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/radar_effect2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.radar_effect2",
			["fight_info/abyss_msgbox/main/select_node_layer/select_3/buff_image"] = "_control.abyss_msgbox.main.select_node_layer.select_3.buff_image",
			["fight_info/bg/info_bg/enemy_info_bg/circuity_btn/text"] = "_control.bg.info_bg.enemy_info_bg.circuity_btn.text",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset",
			["fight_info/abyss_msgbox/main/text_dot"] = "_control.abyss_msgbox.main.text_dot",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1",
			["fight_info/bg/info_bg/select_formation/right_widget/select3/detail_mask/detail_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select3.detail_mask.detail_txt2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6",
			["fight_info/abyss_msgbox/select_msg_btn/text"] = "_control.abyss_msgbox.select_msg_btn.text",
			["fight_info/abyss_combat_node"] = "_control.abyss_combat_node",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation6/point1"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation6.point1",
			["fight_info/bg/info_bg/select_formation/right_widget/select4/formation4/point2"] = "_control.bg.info_bg.select_formation.right_widget.select4.formation4.point2",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/desc_mask/desc_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select5.desc_mask.desc_txt2",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos2",
			["fight_info/mask/frame/ui_tip_mid"] = "_control.mask.frame.ui_tip_mid",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2.monster",
			["fight_info/abyss_msgbox/main"] = "_control.abyss_msgbox.main",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1",
			["fight_info/fearlessness_buff_msgbox/main"] = "_control.fearlessness_buff_msgbox.main",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos3.monster",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2.monster",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/formation6/point6"] = "_control.bg.info_bg.select_formation.right_widget.select2.formation6.point6",
			["fight_info/bg/info_bg/consume_bg"] = "_control.bg.info_bg.consume_bg",
			["fight_info/bg/info_bg/lost_enemy_bg"] = "_control.bg.info_bg.lost_enemy_bg",
			["fight_info/mask/broken_info"] = "_control.broken_info",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/detail_mask/detail_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select5.detail_mask.detail_txt2",
			["fight_info/bg/boss_slider_bg"] = "_control.bg.boss_slider_bg",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_2/buff"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.buff",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation4/num6"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation4.num6",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_2/buff_mask"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.buff_mask",
			["fight_info/mask/frame/abyss_power/tip"] = "_control.mask.frame.abyss_power.tip",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_2/Text"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_2.Text",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1",
			["fight_info/bg/ship_layer/encounter_effect/encounter_spine"] = "_control.bg.ship_layer.encounter_effect.encounter_spine",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_3/buff"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.buff",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_3/buff_mask"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.buff_mask",
			["fight_info/fearlessness_buff_msgbox/main/select_node_layer/select_buff_3/Text"] = "_control.fearlessness_buff_msgbox.main.select_node_layer.select_buff_3.Text",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset",
			["fight_info/fearlessness_buff_msgbox/select_mask/left"] = "_control.fearlessness_buff_msgbox.select_mask.left",
			["fight_info/bg/info_bg/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset"] = "_control.bg.info_bg.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos1.monster",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos1",
			["fight_info/bg/info_bg/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2"] = "_control.bg.info_bg.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos2",
			["fight_info/bg/info_bg/select_formation/left_widget/word_bg"] = "_control.bg.info_bg.select_formation.left_widget.word_bg",
			["fight_info/bg/info_bg/select_formation/right_widget/select2/detail_mask/detail_txt2"] = "_control.bg.info_bg.select_formation.right_widget.select2.detail_mask.detail_txt2",
			["fight_info/msg_panel/finish_special_mission/award_icon"] = "_control.msg_panel.finish_special_mission.award_icon",
			["fight_info/mask/broken_info/broken_info_img"] = "_control.broken_info.broken_info_img",
			["fight_info/msg_panel/finish_special_mission/coin_num"] = "_control.msg_panel.finish_special_mission.coin_num",
			["fight_info/bg/info_bg/select_formation/right_widget/select5/formation6/point1"] = "_control.bg.info_bg.select_formation.right_widget.select5.formation6.point1",
			["fight_info/msg_panel/finish_special_mission/task_title"] = "_control.msg_panel.finish_special_mission.task_title",
			["fight_info/bg/big_bg"] = "_control.bg.big_bg",
			["fight_info/msg_panel/finish_special_mission_btn"] = "_control.msg_panel.finish_special_mission_btn",
			["fight_info/bg/info_bg/enemy_info_bg/fight_btn"] = "_control.bg.info_bg.enemy_info_bg.fight_btn",
			["fight_info/bg/info_bg/enemy_info_bg/s_circuity"] = "_control.bg.info_bg.enemy_info_bg.s_circuity",
			["fight_info/fearlessness_buff_msgbox/main/text_image"] = "_control.fearlessness_buff_msgbox.main.text_image",
			["fight_info/mask/frame/bullet/bullet_10"] = "_control.mask.frame.bullet.bullet_10",
			["fight_info/boss_new_root/boss_new"] = "_control.boss_new_root.boss_new",
			["fight_info/bg/info_bg/round_about_lock_enemy_txt"] = "_control.bg.info_bg.round_about_lock_enemy_txt",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/formation6/point5"] = "_control.bg.info_bg.select_formation.right_widget.select1.formation6.point5",
			["fight_info/bg/select_1/point"] = "_control.bg.info_bg.strongattack.bg.select_1.point",
			["fight_info/bg/info_bg/strongattack/circle_1"] = "_control.bg.info_bg.strongattack.circle_1",
			["fight_info/mask/frame/danger_layer"] = "_control.mask.frame.danger_layer",
			["fight_info/bg/info_bg/select_formation/right_widget/select1/name_txt"] = "_control.bg.info_bg.select_formation.right_widget.select1.name_txt",
			["fight_info/bg/info_bg/strongattack/string_node5"] = "_control.bg.info_bg.strongattack.string_node5"
		},
		click = {
			["bg/left_people"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/skip_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/enemy_info_bg/back_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/enemy_info_bg/fight_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/enemy_info_bg/bvr_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/enemy_info_bg/circuity_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/select_formation/right_widget/select1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/select_formation/right_widget/select2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/select_formation/right_widget/select3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/select_formation/right_widget/select4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/select_formation/right_widget/select5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/strongattack/string_node1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/strongattack/string_node2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/strongattack/string_node4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/strongattack/string_node3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/info_bg/strongattack/string_node5"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/select_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mask/frame/continue"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mask/frame/quit"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mask/frame/buy"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mask/frame/battlereport"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mask/frame/danger_layer"] = {
				tp = "UnityEngine.UI.Button"
			},
			["mask/broken_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["return_home/right_layer/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["abyss_msgbox/main/select_node_layer/select_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["abyss_msgbox/main/select_node_layer/select_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["abyss_msgbox/main/select_node_layer/select_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["abyss_msgbox/select_msg_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["fearlessness_buff_msgbox/main/select_node_layer/select_buff_1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["fearlessness_buff_msgbox/main/select_node_layer/select_buff_2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["fearlessness_buff_msgbox/main/select_node_layer/select_buff_3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["msg_panel/finish_special_mission_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			abyss_msgbox = {
				component = "UnityEngine.Canvas",
				path = "abyss_msgbox"
			},
			abyss_combat_node = {
				component = "UnityEngine.Canvas",
				path = "abyss_combat_node"
			},
			fearlessness_buff_msgbox = {
				component = "UnityEngine.Canvas",
				path = "fearlessness_buff_msgbox"
			}
		}
	}
}

return {
	_rule_ = {
		none = {
			campaign_bg = {
				path = "campaign_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			exercise_bg = {
				path = "exercise_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			title_bg = {
				path = "title_bg",
				list = {
					title_txt = {
						path = "title_bg/title_txt",
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
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			skip_btn = {
				path = "skip_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			encounter_bg = {
				path = "encounter_bg",
				list = {
					encounter_spine = {
						path = "encounter_bg/encounter_spine",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					round_about_lock_enemy_txt = {
						path = "encounter_bg/round_about_lock_enemy_txt",
						list = {
							lock_enemy_info_bg = {
								path = "encounter_bg/round_about_lock_enemy_txt/lock_enemy_info_bg",
								list = {
									lock_enemy_info_txt = {
										path = "encounter_bg/round_about_lock_enemy_txt/lock_enemy_info_bg/lock_enemy_info_txt",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
				}
			},
			lock_enemy_bg = {
				path = "lock_enemy_bg",
				list = {
					lock_enemy_spine = {
						path = "lock_enemy_bg/lock_enemy_spine",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					radar_frame = {
						path = "lock_enemy_bg/radar_frame",
						list = {
							radar_effect1 = {
								path = "lock_enemy_bg/radar_frame/radar_effect1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"DG.Tweening.DOTweenAnimation"
								}
							},
							radar_effect2 = {
								path = "lock_enemy_bg/radar_frame/radar_effect2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"DG.Tweening.DOTweenAnimation"
								}
							},
							monster_formation = {
								path = "lock_enemy_bg/radar_frame/monster_formation",
								list = {
									formation1 = {
										path = "lock_enemy_bg/radar_frame/monster_formation/formation1",
										list = {
											num1 = {
												path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num1",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num2",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster",
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
										path = "lock_enemy_bg/radar_frame/monster_formation/formation2",
										list = {
											num6 = {
												path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num2",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num1",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster",
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
										path = "lock_enemy_bg/radar_frame/monster_formation/formation3",
										list = {
											num6 = {
												path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num2",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num1",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster",
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
										path = "lock_enemy_bg/radar_frame/monster_formation/formation4",
										list = {
											num6 = {
												path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num2",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num1",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster",
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
										path = "lock_enemy_bg/radar_frame/monster_formation/formation5",
										list = {
											num6 = {
												path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num2",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster",
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
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster",
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
												path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num1",
												list = {
													offset = {
														path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset",
														list = {
															pos1 = {
																path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1",
																list = {
																	monster = {
																		path = "lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster",
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
				path = "lost_enemy_bg",
				list = {
					radar_frame = {
						path = "lost_enemy_bg/radar_frame",
						list = {
							radar_effect1 = {
								path = "lost_enemy_bg/radar_frame/radar_effect1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"DG.Tweening.DOTweenAnimation"
								}
							},
							radar_effect2 = {
								path = "lost_enemy_bg/radar_frame/radar_effect2",
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
						path = "lost_enemy_bg/title",
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
			enemy_info_bg = {
				path = "enemy_info_bg",
				list = {
					bg = {
						path = "enemy_info_bg/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					enemy_info_txt = {
						path = "enemy_info_bg/enemy_info_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line_top = {
						path = "enemy_info_bg/line_top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_medium = {
						path = "enemy_info_bg/line_medium",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line_bottom = {
						path = "enemy_info_bg/line_bottom",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					radar_frame = {
						path = "enemy_info_bg/radar_frame",
						list = {
							radar_effect1 = {
								path = "enemy_info_bg/radar_frame/radar_effect1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"DG.Tweening.DOTweenAnimation"
								}
							},
							radar_effect2 = {
								path = "enemy_info_bg/radar_frame/radar_effect2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"DG.Tweening.DOTweenAnimation"
								}
							},
							monster_formation = {
								path = "enemy_info_bg/radar_frame/monster_formation",
								list = {
									formation1 = {
										path = "enemy_info_bg/radar_frame/monster_formation/formation1",
										list = {
											num1 = {
												path = "enemy_info_bg/radar_frame/monster_formation/formation1/num1",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation1/num2",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster",
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
										path = "enemy_info_bg/radar_frame/monster_formation/formation2",
										list = {
											num6 = {
												path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation2/num2",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation2/num1",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster",
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
										path = "enemy_info_bg/radar_frame/monster_formation/formation3",
										list = {
											num6 = {
												path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation3/num2",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation3/num1",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster",
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
										path = "enemy_info_bg/radar_frame/monster_formation/formation4",
										list = {
											num6 = {
												path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation4/num2",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation4/num1",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster",
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
										path = "enemy_info_bg/radar_frame/monster_formation/formation5",
										list = {
											num6 = {
												path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation5/num2",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster",
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
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster",
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
												path = "enemy_info_bg/radar_frame/monster_formation/formation5/num1",
												list = {
													offset = {
														path = "enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset",
														list = {
															pos1 = {
																path = "enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1",
																list = {
																	monster = {
																		path = "enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster",
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
						path = "enemy_info_bg/enemy_list",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.GridLayoutGroup"
						}
					},
					back_btn = {
						path = "enemy_info_bg/back_btn",
						list = {
							text = {
								path = "enemy_info_bg/back_btn/text",
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
						path = "enemy_info_bg/fight_btn",
						list = {
							text = {
								path = "enemy_info_bg/fight_btn/text",
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
						path = "enemy_info_bg/bvr_btn",
						list = {
							spine_effect = {
								path = "enemy_info_bg/bvr_btn/spine_effect",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic"
								}
							},
							text = {
								path = "enemy_info_bg/bvr_btn/text",
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
						path = "enemy_info_bg/circuity_btn",
						list = {
							text = {
								path = "enemy_info_bg/circuity_btn/text",
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
						path = "enemy_info_bg/circuity_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					circuity_random = {
						path = "enemy_info_bg/circuity_random",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					s_circuity = {
						path = "enemy_info_bg/s_circuity",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			select_formation = {
				path = "select_formation",
				list = {
					left_widget = {
						path = "select_formation/left_widget",
						list = {
							first_ship_pic = {
								path = "select_formation/left_widget/first_ship_pic",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							word_bg = {
								path = "select_formation/left_widget/word_bg",
								list = {
									first_ship_name = {
										path = "select_formation/left_widget/word_bg/first_ship_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									first_ship_word = {
										path = "select_formation/left_widget/word_bg/first_ship_word",
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
					right_widget = {
						path = "select_formation/right_widget",
						list = {
							title_txt = {
								path = "select_formation/right_widget/title_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							title_line = {
								path = "select_formation/right_widget/title_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							select1 = {
								path = "select_formation/right_widget/select1",
								list = {
									name_txt = {
										path = "select_formation/right_widget/select1/name_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									desc_mask = {
										path = "select_formation/right_widget/select1/desc_mask",
										list = {
											desc_txt = {
												path = "select_formation/right_widget/select1/desc_mask/desc_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											desc_txt2 = {
												path = "select_formation/right_widget/select1/desc_mask/desc_txt2",
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
										path = "select_formation/right_widget/select1/detail_mask",
										list = {
											detail_txt = {
												path = "select_formation/right_widget/select1/detail_mask/detail_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											detail_txt2 = {
												path = "select_formation/right_widget/select1/detail_mask/detail_txt2",
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
									formation4 = {
										path = "select_formation/right_widget/select1/formation4",
										list = {
											point1 = {
												path = "select_formation/right_widget/select1/formation4/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select1/formation4/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select1/formation4/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select1/formation4/point4",
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
									formation5 = {
										path = "select_formation/right_widget/select1/formation5",
										list = {
											point1 = {
												path = "select_formation/right_widget/select1/formation5/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select1/formation5/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select1/formation5/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select1/formation5/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select1/formation5/point5",
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
									formation6 = {
										path = "select_formation/right_widget/select1/formation6",
										list = {
											point1 = {
												path = "select_formation/right_widget/select1/formation6/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select1/formation6/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select1/formation6/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select1/formation6/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select1/formation6/point5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point6 = {
												path = "select_formation/right_widget/select1/formation6/point6",
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
								path = "select_formation/right_widget/select2",
								list = {
									name_txt = {
										path = "select_formation/right_widget/select2/name_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									desc_mask = {
										path = "select_formation/right_widget/select2/desc_mask",
										list = {
											desc_txt = {
												path = "select_formation/right_widget/select2/desc_mask/desc_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											desc_txt2 = {
												path = "select_formation/right_widget/select2/desc_mask/desc_txt2",
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
										path = "select_formation/right_widget/select2/detail_mask",
										list = {
											detail_txt = {
												path = "select_formation/right_widget/select2/detail_mask/detail_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											detail_txt2 = {
												path = "select_formation/right_widget/select2/detail_mask/detail_txt2",
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
									formation4 = {
										path = "select_formation/right_widget/select2/formation4",
										list = {
											point1 = {
												path = "select_formation/right_widget/select2/formation4/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select2/formation4/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select2/formation4/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select2/formation4/point4",
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
									formation5 = {
										path = "select_formation/right_widget/select2/formation5",
										list = {
											point1 = {
												path = "select_formation/right_widget/select2/formation5/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select2/formation5/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select2/formation5/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select2/formation5/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select2/formation5/point5",
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
									formation6 = {
										path = "select_formation/right_widget/select2/formation6",
										list = {
											point1 = {
												path = "select_formation/right_widget/select2/formation6/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select2/formation6/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select2/formation6/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select2/formation6/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select2/formation6/point5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point6 = {
												path = "select_formation/right_widget/select2/formation6/point6",
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
								path = "select_formation/right_widget/select3",
								list = {
									name_txt = {
										path = "select_formation/right_widget/select3/name_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									desc_mask = {
										path = "select_formation/right_widget/select3/desc_mask",
										list = {
											desc_txt = {
												path = "select_formation/right_widget/select3/desc_mask/desc_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											desc_txt2 = {
												path = "select_formation/right_widget/select3/desc_mask/desc_txt2",
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
										path = "select_formation/right_widget/select3/detail_mask",
										list = {
											detail_txt = {
												path = "select_formation/right_widget/select3/detail_mask/detail_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											detail_txt2 = {
												path = "select_formation/right_widget/select3/detail_mask/detail_txt2",
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
									formation6 = {
										path = "select_formation/right_widget/select3/formation6",
										list = {
											point1 = {
												path = "select_formation/right_widget/select3/formation6/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select3/formation6/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select3/formation6/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select3/formation6/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select3/formation6/point5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point6 = {
												path = "select_formation/right_widget/select3/formation6/point6",
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
									formation5 = {
										path = "select_formation/right_widget/select3/formation5",
										list = {
											point1 = {
												path = "select_formation/right_widget/select3/formation5/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select3/formation5/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select3/formation5/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select3/formation5/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select3/formation5/point5",
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
										path = "select_formation/right_widget/select3/formation4",
										list = {
											point1 = {
												path = "select_formation/right_widget/select3/formation4/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select3/formation4/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select3/formation4/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select3/formation4/point4",
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
								path = "select_formation/right_widget/select4",
								list = {
									name_txt = {
										path = "select_formation/right_widget/select4/name_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									desc_mask = {
										path = "select_formation/right_widget/select4/desc_mask",
										list = {
											desc_txt = {
												path = "select_formation/right_widget/select4/desc_mask/desc_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											desc_txt2 = {
												path = "select_formation/right_widget/select4/desc_mask/desc_txt2",
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
										path = "select_formation/right_widget/select4/detail_mask",
										list = {
											detail_txt = {
												path = "select_formation/right_widget/select4/detail_mask/detail_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											detail_txt2 = {
												path = "select_formation/right_widget/select4/detail_mask/detail_txt2",
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
									formation6 = {
										path = "select_formation/right_widget/select4/formation6",
										list = {
											point1 = {
												path = "select_formation/right_widget/select4/formation6/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select4/formation6/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select4/formation6/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select4/formation6/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select4/formation6/point5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point6 = {
												path = "select_formation/right_widget/select4/formation6/point6",
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
									formation5 = {
										path = "select_formation/right_widget/select4/formation5",
										list = {
											point1 = {
												path = "select_formation/right_widget/select4/formation5/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select4/formation5/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select4/formation5/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select4/formation5/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select4/formation5/point5",
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
										path = "select_formation/right_widget/select4/formation4",
										list = {
											point1 = {
												path = "select_formation/right_widget/select4/formation4/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select4/formation4/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select4/formation4/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select4/formation4/point4",
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
								path = "select_formation/right_widget/select5",
								list = {
									name_txt = {
										path = "select_formation/right_widget/select5/name_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									desc_mask = {
										path = "select_formation/right_widget/select5/desc_mask",
										list = {
											desc_txt = {
												path = "select_formation/right_widget/select5/desc_mask/desc_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											desc_txt2 = {
												path = "select_formation/right_widget/select5/desc_mask/desc_txt2",
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
										path = "select_formation/right_widget/select5/detail_mask",
										list = {
											detail_txt = {
												path = "select_formation/right_widget/select5/detail_mask/detail_txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											detail_txt2 = {
												path = "select_formation/right_widget/select5/detail_mask/detail_txt2",
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
									formation6 = {
										path = "select_formation/right_widget/select5/formation6",
										list = {
											point1 = {
												path = "select_formation/right_widget/select5/formation6/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select5/formation6/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select5/formation6/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select5/formation6/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select5/formation6/point5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point6 = {
												path = "select_formation/right_widget/select5/formation6/point6",
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
									formation5 = {
										path = "select_formation/right_widget/select5/formation5",
										list = {
											point1 = {
												path = "select_formation/right_widget/select5/formation5/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select5/formation5/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select5/formation5/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select5/formation5/point4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point5 = {
												path = "select_formation/right_widget/select5/formation5/point5",
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
										path = "select_formation/right_widget/select5/formation4",
										list = {
											point1 = {
												path = "select_formation/right_widget/select5/formation4/point1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point2 = {
												path = "select_formation/right_widget/select5/formation4/point2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point3 = {
												path = "select_formation/right_widget/select5/formation4/point3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											point4 = {
												path = "select_formation/right_widget/select5/formation4/point4",
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
			}
		},
		call_node_list = {
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2.monster",
			["campaign_select/select_formation/right_widget/select1/detail_mask"] = "_control.select_formation.right_widget.select1.detail_mask",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2",
			["campaign_select/select_formation/right_widget/select4"] = "_control.select_formation.right_widget.select4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3.monster",
			["campaign_select/select_formation/right_widget/select1/formation4"] = "_control.select_formation.right_widget.select1.formation4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation"] = "_control.enemy_info_bg.radar_frame.monster_formation",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2",
			["campaign_select/select_formation/left_widget/first_ship_pic"] = "_control.select_formation.left_widget.first_ship_pic",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset",
			["campaign_select/select_formation/right_widget/select1/desc_mask/desc_txt2"] = "_control.select_formation.right_widget.select1.desc_mask.desc_txt2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1",
			["campaign_select/select_formation/left_widget/word_bg/first_ship_word"] = "_control.select_formation.left_widget.word_bg.first_ship_word",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1",
			["campaign_select/select_formation/right_widget/select1/formation5"] = "_control.select_formation.right_widget.select1.formation5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos4",
			["campaign_select/select_formation/left_widget"] = "_control.select_formation.left_widget",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos2.monster",
			["campaign_select/encounter_bg/round_about_lock_enemy_txt"] = "_control.encounter_bg.round_about_lock_enemy_txt",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos6.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame"] = "_control.enemy_info_bg.radar_frame",
			["campaign_select/enemy_info_bg/line_medium"] = "_control.enemy_info_bg.line_medium",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos2",
			["campaign_select/lost_enemy_bg/radar_frame/radar_effect1"] = "_control.lost_enemy_bg.radar_frame.radar_effect1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num1.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num1.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num1/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num1.offset",
			["campaign_select/lock_enemy_bg"] = "_control.lock_enemy_bg",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos1.monster",
			["campaign_select/select_formation/right_widget/select1/formation4/point4"] = "_control.select_formation.right_widget.select1.formation4.point4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos2",
			["campaign_select/lost_enemy_bg/radar_frame/radar_effect2"] = "_control.lost_enemy_bg.radar_frame.radar_effect2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos3",
			["campaign_select/enemy_info_bg/enemy_info_txt"] = "_control.enemy_info_bg.enemy_info_txt",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/radar_effect2"] = "_control.lock_enemy_bg.radar_frame.radar_effect2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos4.monster",
			["campaign_select/enemy_info_bg/bvr_btn/text"] = "_control.enemy_info_bg.bvr_btn.text",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos6.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset",
			["campaign_select/enemy_info_bg/fight_btn"] = "_control.enemy_info_bg.fight_btn",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num1.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/radar_effect1"] = "_control.lock_enemy_bg.radar_frame.radar_effect1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos6.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos2.monster",
			["campaign_select/select_formation/right_widget/select3"] = "_control.select_formation.right_widget.select3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5",
			["campaign_select/select_formation/right_widget/select1/name_txt"] = "_control.select_formation.right_widget.select1.name_txt",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num1.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num1/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num1.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos2.monster",
			["campaign_select/select_formation/left_widget/word_bg/first_ship_name"] = "_control.select_formation.left_widget.word_bg.first_ship_name",
			["campaign_select/lost_enemy_bg/title"] = "_control.lost_enemy_bg.title",
			["campaign_select/select_formation/right_widget/select1/formation4/point2"] = "_control.select_formation.right_widget.select1.formation4.point2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos2",
			["campaign_select/enemy_info_bg/s_circuity"] = "_control.enemy_info_bg.s_circuity",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num3/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num3.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset",
			["campaign_select/enemy_info_bg/circuity_btn"] = "_control.enemy_info_bg.circuity_btn",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num5.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num6.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos1",
			["campaign_select/title_bg/title_txt"] = "_control.title_bg.title_txt",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num6.offset.pos6.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num4.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num1.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num6/offset/pos6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num6.offset.pos6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num2.offset.pos2.monster",
			["campaign_select/enemy_info_bg"] = "_control.enemy_info_bg",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num1.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num1.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num1.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num1.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num4/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num4.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos1",
			["campaign_select/enemy_info_bg/line_top"] = "_control.enemy_info_bg.line_top",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos5.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num2/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num2.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num6.offset.pos6.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num5/offset/pos5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num5.offset.pos5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num1/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num1.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos2.monster",
			["campaign_select/enemy_info_bg/bg"] = "_control.enemy_info_bg.bg",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num4/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num4.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num5/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num5.offset.pos1",
			["campaign_select/select_formation/right_widget/select1/formation4/point3"] = "_control.select_formation.right_widget.select1.formation4.point3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num2.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num1.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num1.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num1.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos4.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2",
			["campaign_select/select_formation/right_widget/select2"] = "_control.select_formation.right_widget.select2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset",
			["campaign_select/enemy_info_bg/line_bottom"] = "_control.enemy_info_bg.line_bottom",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2",
			["campaign_select/encounter_bg/round_about_lock_enemy_txt/lock_enemy_info_bg"] = "_control.encounter_bg.round_about_lock_enemy_txt.lock_enemy_info_bg",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset",
			["campaign_select/skip_btn"] = "_control.skip_btn",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1.monster",
			["campaign_select/encounter_bg"] = "_control.encounter_bg",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1.monster",
			["campaign_select/enemy_info_bg/radar_frame/radar_effect2"] = "_control.enemy_info_bg.radar_frame.radar_effect2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1.monster",
			["campaign_select/select_formation"] = "_control.select_formation",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1.monster",
			["campaign_select/enemy_info_bg/fight_btn/text"] = "_control.enemy_info_bg.fight_btn.text",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos2.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos4"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos4",
			["campaign_select/enemy_info_bg/circuity_btn/text"] = "_control.enemy_info_bg.circuity_btn.text",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num4/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num4.offset.pos3",
			["campaign_select/enemy_info_bg/back_btn/text"] = "_control.enemy_info_bg.back_btn.text",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos3.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1/num2/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5.monster",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1.monster",
			["campaign_select/select_formation/right_widget/select1/detail_mask/detail_txt"] = "_control.select_formation.right_widget.select1.detail_mask.detail_txt",
			["campaign_select/select_formation/right_widget/select1/detail_mask/detail_txt2"] = "_control.select_formation.right_widget.select1.detail_mask.detail_txt2",
			["campaign_select/select_formation/right_widget/select1/formation4/point1"] = "_control.select_formation.right_widget.select1.formation4.point1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num3.offset.pos3.monster",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3.offset.pos2",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num2/offset/pos1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num2.offset.pos1",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4.monster",
			["campaign_select/select_formation/right_widget/select1/formation5/point1"] = "_control.select_formation.right_widget.select1.formation5.point1",
			["campaign_select/select_formation/right_widget/select1/formation5/point2"] = "_control.select_formation.right_widget.select1.formation5.point2",
			["campaign_select/select_formation/right_widget/select1/formation5/point3"] = "_control.select_formation.right_widget.select1.formation5.point3",
			["campaign_select/select_formation/right_widget/select1/formation5/point4"] = "_control.select_formation.right_widget.select1.formation5.point4",
			["campaign_select/select_formation/right_widget/select1/formation6/point1"] = "_control.select_formation.right_widget.select1.formation6.point1",
			["campaign_select/title_bg"] = "_control.title_bg",
			["campaign_select/select_formation/right_widget/select1/formation6/point2"] = "_control.select_formation.right_widget.select1.formation6.point2",
			["campaign_select/select_formation/right_widget/select1/formation6/point3"] = "_control.select_formation.right_widget.select1.formation6.point3",
			["campaign_select/select_formation/right_widget/select1/formation6/point4"] = "_control.select_formation.right_widget.select1.formation6.point4",
			["campaign_select/select_formation/right_widget/select1/formation6/point5"] = "_control.select_formation.right_widget.select1.formation6.point5",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2.monster",
			["campaign_select/select_formation/right_widget/select2/name_txt"] = "_control.select_formation.right_widget.select2.name_txt",
			["campaign_select/lock_enemy_bg/lock_enemy_spine"] = "_control.lock_enemy_bg.lock_enemy_spine",
			["campaign_select/select_formation/right_widget/select2/desc_mask"] = "_control.select_formation.right_widget.select2.desc_mask",
			["campaign_select/select_formation/right_widget/select2/desc_mask/desc_txt"] = "_control.select_formation.right_widget.select2.desc_mask.desc_txt",
			["campaign_select/select_formation/right_widget/select2/desc_mask/desc_txt2"] = "_control.select_formation.right_widget.select2.desc_mask.desc_txt2",
			["campaign_select/select_formation/right_widget/select2/detail_mask"] = "_control.select_formation.right_widget.select2.detail_mask",
			["campaign_select/select_formation/right_widget/select2/detail_mask/detail_txt"] = "_control.select_formation.right_widget.select2.detail_mask.detail_txt",
			["campaign_select/select_formation/right_widget/select2/detail_mask/detail_txt2"] = "_control.select_formation.right_widget.select2.detail_mask.detail_txt2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4.monster",
			["campaign_select/select_formation/right_widget/select2/formation4"] = "_control.select_formation.right_widget.select2.formation4",
			["campaign_select/select_formation/right_widget/select2/formation4/point1"] = "_control.select_formation.right_widget.select2.formation4.point1",
			["campaign_select/select_formation/right_widget/select2/formation4/point2"] = "_control.select_formation.right_widget.select2.formation4.point2",
			["campaign_select/select_formation/right_widget/select2/formation4/point3"] = "_control.select_formation.right_widget.select2.formation4.point3",
			["campaign_select/select_formation/right_widget/select2/formation4/point4"] = "_control.select_formation.right_widget.select2.formation4.point4",
			["campaign_select/select_formation/right_widget/select2/formation5"] = "_control.select_formation.right_widget.select2.formation5",
			["campaign_select/select_formation/right_widget/select2/formation5/point1"] = "_control.select_formation.right_widget.select2.formation5.point1",
			["campaign_select/select_formation/right_widget/select2/formation5/point2"] = "_control.select_formation.right_widget.select2.formation5.point2",
			["campaign_select/select_formation/right_widget/select2/formation5/point3"] = "_control.select_formation.right_widget.select2.formation5.point3",
			["campaign_select/select_formation/right_widget/select2/formation5/point4"] = "_control.select_formation.right_widget.select2.formation5.point4",
			["campaign_select/select_formation/right_widget/select2/formation5/point5"] = "_control.select_formation.right_widget.select2.formation5.point5",
			["campaign_select/select_formation/right_widget/select2/formation6"] = "_control.select_formation.right_widget.select2.formation6",
			["campaign_select/select_formation/right_widget/select2/formation6/point1"] = "_control.select_formation.right_widget.select2.formation6.point1",
			["campaign_select/select_formation/right_widget/select2/formation6/point2"] = "_control.select_formation.right_widget.select2.formation6.point2",
			["campaign_select/select_formation/right_widget/select2/formation6/point3"] = "_control.select_formation.right_widget.select2.formation6.point3",
			["campaign_select/select_formation/right_widget/select2/formation6/point4"] = "_control.select_formation.right_widget.select2.formation6.point4",
			["campaign_select/select_formation/right_widget/title_txt"] = "_control.select_formation.right_widget.title_txt",
			["campaign_select/select_formation/right_widget/select2/formation6/point5"] = "_control.select_formation.right_widget.select2.formation6.point5",
			["campaign_select/select_formation/right_widget/select2/formation6/point6"] = "_control.select_formation.right_widget.select2.formation6.point6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2/num5/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2.num5.offset.pos2",
			["campaign_select/select_formation/right_widget/select3/name_txt"] = "_control.select_formation.right_widget.select3.name_txt",
			["campaign_select/select_formation/right_widget/select3/desc_mask"] = "_control.select_formation.right_widget.select3.desc_mask",
			["campaign_select/select_formation/right_widget/select3/desc_mask/desc_txt"] = "_control.select_formation.right_widget.select3.desc_mask.desc_txt",
			["campaign_select/select_formation/right_widget/select3/desc_mask/desc_txt2"] = "_control.select_formation.right_widget.select3.desc_mask.desc_txt2",
			["campaign_select/select_formation/right_widget/select3/detail_mask"] = "_control.select_formation.right_widget.select3.detail_mask",
			["campaign_select/select_formation/right_widget/select3/detail_mask/detail_txt"] = "_control.select_formation.right_widget.select3.detail_mask.detail_txt",
			["campaign_select/select_formation/right_widget/select3/detail_mask/detail_txt2"] = "_control.select_formation.right_widget.select3.detail_mask.detail_txt2",
			["campaign_select/select_formation/right_widget/select3/formation6"] = "_control.select_formation.right_widget.select3.formation6",
			["campaign_select/select_formation/right_widget/select3/formation6/point1"] = "_control.select_formation.right_widget.select3.formation6.point1",
			["campaign_select/select_formation/right_widget/select3/formation6/point2"] = "_control.select_formation.right_widget.select3.formation6.point2",
			["campaign_select/select_formation/right_widget/select3/formation6/point3"] = "_control.select_formation.right_widget.select3.formation6.point3",
			["campaign_select/select_formation/right_widget/select3/formation6/point4"] = "_control.select_formation.right_widget.select3.formation6.point4",
			["campaign_select/select_formation/right_widget/select3/formation6/point5"] = "_control.select_formation.right_widget.select3.formation6.point5",
			["campaign_select/select_formation/right_widget/select3/formation6/point6"] = "_control.select_formation.right_widget.select3.formation6.point6",
			["campaign_select/select_formation/right_widget/select3/formation5"] = "_control.select_formation.right_widget.select3.formation5",
			["campaign_select/select_formation/right_widget/select3/formation5/point1"] = "_control.select_formation.right_widget.select3.formation5.point1",
			["campaign_select/select_formation/right_widget/select3/formation5/point2"] = "_control.select_formation.right_widget.select3.formation5.point2",
			["campaign_select/select_formation/right_widget/select3/formation5/point3"] = "_control.select_formation.right_widget.select3.formation5.point3",
			["campaign_select/select_formation/right_widget/select3/formation5/point4"] = "_control.select_formation.right_widget.select3.formation5.point4",
			["campaign_select/select_formation/right_widget/select3/formation5/point5"] = "_control.select_formation.right_widget.select3.formation5.point5",
			["campaign_select/select_formation/right_widget/select3/formation4"] = "_control.select_formation.right_widget.select3.formation4",
			["campaign_select/select_formation/right_widget/select3/formation4/point1"] = "_control.select_formation.right_widget.select3.formation4.point1",
			["campaign_select/select_formation/right_widget/select3/formation4/point2"] = "_control.select_formation.right_widget.select3.formation4.point2",
			["campaign_select/select_formation/right_widget/select3/formation4/point3"] = "_control.select_formation.right_widget.select3.formation4.point3",
			["campaign_select/select_formation/right_widget/select3/formation4/point4"] = "_control.select_formation.right_widget.select3.formation4.point4",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1.monster",
			["campaign_select/select_formation/right_widget/select4/name_txt"] = "_control.select_formation.right_widget.select4.name_txt",
			["campaign_select/select_formation/right_widget/select4/desc_mask"] = "_control.select_formation.right_widget.select4.desc_mask",
			["campaign_select/select_formation/right_widget/select4/desc_mask/desc_txt"] = "_control.select_formation.right_widget.select4.desc_mask.desc_txt",
			["campaign_select/select_formation/right_widget/select4/desc_mask/desc_txt2"] = "_control.select_formation.right_widget.select4.desc_mask.desc_txt2",
			["campaign_select/select_formation/right_widget/select4/detail_mask"] = "_control.select_formation.right_widget.select4.detail_mask",
			["campaign_select/select_formation/right_widget/select4/detail_mask/detail_txt"] = "_control.select_formation.right_widget.select4.detail_mask.detail_txt",
			["campaign_select/select_formation/right_widget/select4/detail_mask/detail_txt2"] = "_control.select_formation.right_widget.select4.detail_mask.detail_txt2",
			["campaign_select/select_formation/right_widget/select4/formation6"] = "_control.select_formation.right_widget.select4.formation6",
			["campaign_select/select_formation/right_widget/select4/formation6/point1"] = "_control.select_formation.right_widget.select4.formation6.point1",
			["campaign_select/select_formation/right_widget/select4/formation6/point2"] = "_control.select_formation.right_widget.select4.formation6.point2",
			["campaign_select/select_formation/right_widget/select4/formation6/point3"] = "_control.select_formation.right_widget.select4.formation6.point3",
			["campaign_select/select_formation/right_widget/select4/formation6/point4"] = "_control.select_formation.right_widget.select4.formation6.point4",
			["campaign_select/select_formation/right_widget/select4/formation6/point5"] = "_control.select_formation.right_widget.select4.formation6.point5",
			["campaign_select/select_formation/right_widget/select4/formation6/point6"] = "_control.select_formation.right_widget.select4.formation6.point6",
			["campaign_select/select_formation/right_widget/select4/formation5"] = "_control.select_formation.right_widget.select4.formation5",
			["campaign_select/select_formation/right_widget/select4/formation5/point1"] = "_control.select_formation.right_widget.select4.formation5.point1",
			["campaign_select/select_formation/right_widget/select4/formation5/point2"] = "_control.select_formation.right_widget.select4.formation5.point2",
			["campaign_select/select_formation/right_widget/select4/formation5/point3"] = "_control.select_formation.right_widget.select4.formation5.point3",
			["campaign_select/select_formation/right_widget/select4/formation5/point4"] = "_control.select_formation.right_widget.select4.formation5.point4",
			["campaign_select/select_formation/right_widget/select4/formation5/point5"] = "_control.select_formation.right_widget.select4.formation5.point5",
			["campaign_select/select_formation/right_widget/select4/formation4"] = "_control.select_formation.right_widget.select4.formation4",
			["campaign_select/select_formation/right_widget/select4/formation4/point1"] = "_control.select_formation.right_widget.select4.formation4.point1",
			["campaign_select/select_formation/right_widget/select4/formation4/point2"] = "_control.select_formation.right_widget.select4.formation4.point2",
			["campaign_select/select_formation/right_widget/select4/formation4/point3"] = "_control.select_formation.right_widget.select4.formation4.point3",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4",
			["campaign_select/select_formation/right_widget/select4/formation4/point4"] = "_control.select_formation.right_widget.select4.formation4.point4",
			["campaign_select/select_formation/right_widget/select5/name_txt"] = "_control.select_formation.right_widget.select5.name_txt",
			["campaign_select/select_formation/right_widget/select5/desc_mask"] = "_control.select_formation.right_widget.select5.desc_mask",
			["campaign_select/select_formation/right_widget/select5/desc_mask/desc_txt"] = "_control.select_formation.right_widget.select5.desc_mask.desc_txt",
			["campaign_select/select_formation/right_widget/select5/desc_mask/desc_txt2"] = "_control.select_formation.right_widget.select5.desc_mask.desc_txt2",
			["campaign_select/select_formation/right_widget/select5/detail_mask"] = "_control.select_formation.right_widget.select5.detail_mask",
			["campaign_select/campaign_bg"] = "_control.campaign_bg",
			["campaign_select/select_formation/right_widget/select5/detail_mask/detail_txt"] = "_control.select_formation.right_widget.select5.detail_mask.detail_txt",
			["campaign_select/select_formation/right_widget/select5/detail_mask/detail_txt2"] = "_control.select_formation.right_widget.select5.detail_mask.detail_txt2",
			["campaign_select/select_formation/right_widget/select5/formation6"] = "_control.select_formation.right_widget.select5.formation6",
			["campaign_select/select_formation/right_widget/select5/formation6/point1"] = "_control.select_formation.right_widget.select5.formation6.point1",
			["campaign_select/select_formation/right_widget/select5/formation6/point2"] = "_control.select_formation.right_widget.select5.formation6.point2",
			["campaign_select/select_formation/right_widget/select5/formation6/point3"] = "_control.select_formation.right_widget.select5.formation6.point3",
			["campaign_select/select_formation/right_widget/select5/formation6/point4"] = "_control.select_formation.right_widget.select5.formation6.point4",
			["campaign_select/select_formation/right_widget/select5/formation6/point5"] = "_control.select_formation.right_widget.select5.formation6.point5",
			["campaign_select/select_formation/right_widget/select5/formation6/point6"] = "_control.select_formation.right_widget.select5.formation6.point6",
			["campaign_select/select_formation/right_widget/select5/formation5"] = "_control.select_formation.right_widget.select5.formation5",
			["campaign_select/select_formation/right_widget/select5/formation5/point1"] = "_control.select_formation.right_widget.select5.formation5.point1",
			["campaign_select/select_formation/right_widget/select5/formation5/point2"] = "_control.select_formation.right_widget.select5.formation5.point2",
			["campaign_select/select_formation/right_widget/select5/formation5/point3"] = "_control.select_formation.right_widget.select5.formation5.point3",
			["campaign_select/select_formation/right_widget/select5/formation5/point4"] = "_control.select_formation.right_widget.select5.formation5.point4",
			["campaign_select/select_formation/right_widget/select5/formation5/point5"] = "_control.select_formation.right_widget.select5.formation5.point5",
			["campaign_select/select_formation/right_widget/title_line"] = "_control.select_formation.right_widget.title_line",
			["campaign_select/select_formation/right_widget/select5/formation4"] = "_control.select_formation.right_widget.select5.formation4",
			["campaign_select/select_formation/right_widget/select5/formation4/point1"] = "_control.select_formation.right_widget.select5.formation4.point1",
			["campaign_select/select_formation/right_widget/select5/formation4/point2"] = "_control.select_formation.right_widget.select5.formation4.point2",
			["campaign_select/select_formation/right_widget/select1/desc_mask/desc_txt"] = "_control.select_formation.right_widget.select1.desc_mask.desc_txt",
			["campaign_select/select_formation/right_widget/select5/formation4/point3"] = "_control.select_formation.right_widget.select5.formation4.point3",
			["campaign_select/select_formation/right_widget/select5/formation4/point4"] = "_control.select_formation.right_widget.select5.formation4.point4",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation3/num5/offset/pos3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation3.num5.offset.pos3",
			["campaign_select/select_formation/right_widget"] = "_control.select_formation.right_widget",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5",
			["campaign_select/enemy_info_bg/enemy_list"] = "_control.enemy_info_bg.enemy_list",
			["campaign_select/select_formation/right_widget/select1/formation6"] = "_control.select_formation.right_widget.select1.formation6",
			["campaign_select/select_formation/right_widget/select1/formation6/point6"] = "_control.select_formation.right_widget.select1.formation6.point6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation2",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5",
			["campaign_select/select_formation/left_widget/word_bg"] = "_control.select_formation.left_widget.word_bg",
			["campaign_select/lost_enemy_bg/radar_frame"] = "_control.lost_enemy_bg.radar_frame",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation4/num3"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation4.num3",
			["campaign_select/lost_enemy_bg"] = "_control.lost_enemy_bg",
			["campaign_select/select_formation/right_widget/select5"] = "_control.select_formation.right_widget.select5",
			["campaign_select/enemy_info_bg/radar_frame/radar_effect1"] = "_control.enemy_info_bg.radar_frame.radar_effect1",
			["campaign_select/lock_enemy_bg/radar_frame"] = "_control.lock_enemy_bg.radar_frame",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation1"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation1",
			["campaign_select/select_formation/right_widget/select1"] = "_control.select_formation.right_widget.select1",
			["campaign_select/enemy_info_bg/back_btn"] = "_control.enemy_info_bg.back_btn",
			["campaign_select/enemy_info_bg/circuity_random"] = "_control.enemy_info_bg.circuity_random",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation"] = "_control.lock_enemy_bg.radar_frame.monster_formation",
			["campaign_select/enemy_info_bg/bvr_btn"] = "_control.enemy_info_bg.bvr_btn",
			["campaign_select/mask"] = "_control.mask",
			["campaign_select/enemy_info_bg/circuity_img"] = "_control.enemy_info_bg.circuity_img",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos6"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos6",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5/num6/offset/pos2"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5.num6.offset.pos2",
			["campaign_select/enemy_info_bg/bvr_btn/spine_effect"] = "_control.enemy_info_bg.bvr_btn.spine_effect",
			["campaign_select/exercise_bg"] = "_control.exercise_bg",
			["campaign_select/encounter_bg/round_about_lock_enemy_txt/lock_enemy_info_bg/lock_enemy_info_txt"] = "_control.encounter_bg.round_about_lock_enemy_txt.lock_enemy_info_bg.lock_enemy_info_txt",
			["campaign_select/encounter_bg/encounter_spine"] = "_control.encounter_bg.encounter_spine",
			["campaign_select/select_formation/right_widget/select1/formation5/point5"] = "_control.select_formation.right_widget.select1.formation5.point5",
			["campaign_select/lock_enemy_bg/radar_frame/monster_formation/formation5"] = "_control.lock_enemy_bg.radar_frame.monster_formation.formation5",
			["campaign_select/select_formation/right_widget/select1/desc_mask"] = "_control.select_formation.right_widget.select1.desc_mask",
			["campaign_select/enemy_info_bg/radar_frame/monster_formation/formation4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4"
		},
		click = {
			skip_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["enemy_info_bg/back_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["enemy_info_bg/fight_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["enemy_info_bg/bvr_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["enemy_info_bg/circuity_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_formation/right_widget/select1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_formation/right_widget/select2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_formation/right_widget/select3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_formation/right_widget/select4"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_formation/right_widget/select5"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

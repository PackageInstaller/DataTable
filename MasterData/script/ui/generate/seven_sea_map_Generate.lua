return {
	_rule_ = {
		none = {
			empty_bg = {
				path = "empty_bg",
				list = {
					treasure = {
						path = "empty_bg/treasure",
						list = {
							get_img = {
								path = "empty_bg/treasure/get_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							get_light = {
								path = "empty_bg/treasure/get_light",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							get_txt = {
								path = "empty_bg/treasure/get_txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							get_btn = {
								path = "empty_bg/treasure/get_btn",
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
					treasure_spiral = {
						path = "empty_bg/treasure_spiral",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"PointerDownUpEvent"
				}
			},
			cloud_shadow_list_1 = {
				path = "empty_bg/cloud_shadow_list/cloud_shadow_list_1",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			cloud_shadow_list_2 = {
				path = "empty_bg/cloud_shadow_list/cloud_shadow_list_2",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			move_point = {
				path = "empty_bg/move_point",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			islands_list = {
				path = "empty_bg/islands_list",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			exploration_list = {
				path = "empty_bg/exploration_list",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			operational_list = {
				path = "empty_bg/operational_list",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			enemy_list = {
				path = "empty_bg/enemy_list",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			cloud_list = {
				path = "empty_bg/cloud_list",
				list = {},
				component = {
					"UnityEngine.Canvas"
				}
			},
			cloud_list_1 = {
				path = "empty_bg/cloud_list/cloud_list_1",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			cloud_list_2 = {
				path = "empty_bg/cloud_list/cloud_list_2",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			top_find_ani = {
				path = "top_find_ani",
				list = {
					chassis_radar = {
						path = "top_find_ani/chassis_radar",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					chassis_radar_outside = {
						path = "top_find_ani/chassis_radar_outside",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					chassis_radar_inside = {
						path = "top_find_ani/chassis_radar_inside",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					chassis_top = {
						path = "top_find_ani/chassis_top",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup"
						}
					},
					scattering = {
						path = "top_find_ani/scattering",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.CanvasGroup",
							"UIFillAmountChangeEffect"
						}
					},
					find_ani = {
						path = "top_find_ani/find_ani",
						list = {
							line_top = {
								path = "top_find_ani/find_ani/line_top",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_botton = {
								path = "top_find_ani/find_ani/line_botton",
								list = {},
								component = {
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
			player_role = {
				path = "player_role",
				list = {
					shadow = {
						path = "player_role/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					spray = {
						path = "player_role/spray",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					radar = {
						path = "player_role/radar",
						list = {
							find = {
								path = "player_role/radar/find",
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
					},
					sigh = {
						path = "player_role/sigh",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					find_treasure = {
						path = "player_role/find_treasure",
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
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic",
					"UnityEngine.BoxCollider2D",
					"Trigger2DEvent"
				}
			},
			cover = {
				path = "player_role/cover",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			plane_sign = {
				path = "plane_sign",
				list = {
					icon = {
						path = "plane_sign/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
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
			boss_sign = {
				path = "boss_sign",
				list = {
					icon = {
						path = "boss_sign/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
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
			return_btn = {
				path = "return_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			enemy_info_bg = {
				path = "enemy_info_bg",
				list = {
					enemy_info_txt = {
						path = "enemy_info_bg/enemy_info_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					s_enemy_info = {
						path = "enemy_info_bg/s_enemy_info",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					random_tip_text = {
						path = "enemy_info_bg/line_bottom/random_tip_text",
						list = {
							txt = {
								path = "enemy_info_bg/line_bottom/random_tip_text/txt",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.Canvas"
				}
			},
			map_preview = {
				path = "map_preview",
				list = {
					map_bg = {
						path = "map_preview/map_bg",
						list = {
							map_panel = {
								path = "map_preview/map_bg/map_panel",
								list = {
									map_image = {
										path = "map_preview/map_bg/map_panel/map_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									pass_icon = {
										path = "map_preview/map_bg/map_panel/pass_icon",
										list = {
											pass_txt = {
												path = "map_preview/map_bg/map_panel/pass_icon/pass_txt",
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
									},
									map_node_root = {
										path = "map_preview/map_bg/map_panel/map_node_root",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.Image"
								}
							},
							title_bg = {
								path = "map_preview/map_bg/title_bg",
								list = {
									title_txt = {
										path = "map_preview/map_bg/title_bg/title_txt",
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
							close_btn = {
								path = "map_preview/map_bg/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							boss_panel = {
								path = "map_preview/map_bg/boss_panel",
								list = {
									boss_bg = {
										path = "map_preview/map_bg/boss_panel/boss_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									boss_image = {
										path = "map_preview/map_bg/boss_panel/boss_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									boss_head = {
										path = "map_preview/map_bg/boss_panel/boss_head",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									boss_hp_black = {
										path = "map_preview/map_bg/boss_panel/boss_hp_black",
										list = {
											boss_hp_bar = {
												path = "map_preview/map_bg/boss_panel/boss_hp_black/boss_hp_bar",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											hp_percent_num = {
												path = "map_preview/map_bg/boss_panel/boss_hp_black/hp_percent_num",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											percent = {
												path = "map_preview/map_bg/boss_panel/boss_hp_black/percent",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							reward_panel = {
								path = "map_preview/map_bg/reward_panel",
								list = {
									reward_title = {
										path = "map_preview/map_bg/reward_panel/reward_title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									reward_line = {
										path = "map_preview/map_bg/reward_panel/reward_line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_icon_bg = {
										path = "map_preview/map_bg/reward_panel/reward_icon_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									reward_icon = {
										path = "map_preview/map_bg/reward_panel/reward_icon",
										list = {
											get_icon = {
												path = "map_preview/map_bg/reward_panel/reward_icon/get_icon",
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
									reward_line_2 = {
										path = "map_preview/map_bg/reward_panel/reward_line_2",
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
									"UnityEngine.CanvasRenderer"
								}
							},
							confirm_btn = {
								path = "map_preview/map_bg/confirm_btn",
								list = {
									title = {
										path = "map_preview/map_bg/confirm_btn/title",
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
							bottom_tips = {
								path = "map_preview/map_bg/bottom_tips",
								list = {
									dot_image = {
										path = "map_preview/map_bg/bottom_tips/dot_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									tips_txt = {
										path = "map_preview/map_bg/bottom_tips/tips_txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					map_tips_panel = {
						path = "map_preview/map_tips_panel",
						list = {
							tips_txt = {
								path = "map_preview/map_tips_panel/tips_txt",
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
					"UnityEngine.CanvasRenderer"
				}
			},
			equip_mask = {
				path = "map_preview/map_bg/equip_mask",
				list = {},
				component = {
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Button"
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
							icon = {
								path = "msg_panel/finish_special_mission/icon",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			point_coin = {
				path = "point_coin",
				list = {
					num = {
						path = "point_coin/num",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			icon = {
				path = "point_coin/icon",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			cover_2 = {
				path = "cover_2",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			finish_special_mission_btn = {
				path = "finish_special_mission_btn",
				list = {},
				component = {
					"UnityEngine.UI.Button",
					"UnityEngine.Canvas"
				}
			},
			explore = {
				path = "explore",
				list = {
					btn = {
						path = "explore/btn",
						list = {
							text = {
								path = "explore/btn/text",
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
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["seven_sea_map/top_find_ani/find_ani"] = "_control.top_find_ani.find_ani",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset",
			["seven_sea_map/map_preview/map_bg"] = "_control.map_preview.map_bg",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2.monster",
			["seven_sea_map/empty_bg/cloud_list/cloud_list_2"] = "_control.cloud_list_2",
			["seven_sea_map/empty_bg/treasure/get_btn"] = "_control.empty_bg.treasure.get_btn",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1",
			["seven_sea_map/top_find_ani/chassis_radar_inside"] = "_control.top_find_ani.chassis_radar_inside",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3",
			["seven_sea_map/map_preview/map_bg/boss_panel/boss_head"] = "_control.map_preview.map_bg.boss_panel.boss_head",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2",
			["seven_sea_map/map_preview/map_bg/map_panel/map_node_root"] = "_control.map_preview.map_bg.map_panel.map_node_root",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1",
			["seven_sea_map/explore/btn/text"] = "_control.explore.btn.text",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1",
			["seven_sea_map/top_find_ani/chassis_radar_outside"] = "_control.top_find_ani.chassis_radar_outside",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1",
			["seven_sea_map/map_preview/map_bg/reward_panel"] = "_control.map_preview.map_bg.reward_panel",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2.monster",
			["seven_sea_map/cover_2"] = "_control.cover_2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5",
			["seven_sea_map/empty_bg/treasure/get_light"] = "_control.empty_bg.treasure.get_light",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4",
			["seven_sea_map/map_preview/map_bg/confirm_btn/title"] = "_control.map_preview.map_bg.confirm_btn.title",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2",
			["seven_sea_map/msg_panel/finish_special_mission/map_title"] = "_control.msg_panel.finish_special_mission.map_title",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6",
			["seven_sea_map/point_coin/icon"] = "_control.icon",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1",
			["seven_sea_map/empty_bg/treasure"] = "_control.empty_bg.treasure",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2",
			["seven_sea_map/map_preview/map_bg/boss_panel/boss_bg"] = "_control.map_preview.map_bg.boss_panel.boss_bg",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1.monster",
			["seven_sea_map/point_coin/num"] = "_control.point_coin.num",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4.monster",
			["seven_sea_map/finish_special_mission_btn"] = "_control.finish_special_mission_btn",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4",
			["seven_sea_map/plane_sign"] = "_control.plane_sign",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2.monster",
			["seven_sea_map/map_preview/map_bg/boss_panel/boss_hp_black/hp_percent_num"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black.hp_percent_num",
			["seven_sea_map/enemy_info_bg/enemy_info_txt"] = "_control.enemy_info_bg.enemy_info_txt",
			["seven_sea_map/empty_bg"] = "_control.empty_bg",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset",
			["seven_sea_map/map_preview/map_bg/boss_panel/boss_hp_black"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg"] = "_control.enemy_info_bg",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1.monster",
			["seven_sea_map/player_role/spray"] = "_control.player_role.spray",
			["seven_sea_map/map_preview/map_bg/map_panel/pass_icon"] = "_control.map_preview.map_bg.map_panel.pass_icon",
			["seven_sea_map/map_preview/map_bg/reward_panel/reward_icon_bg"] = "_control.map_preview.map_bg.reward_panel.reward_icon_bg",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6.monster",
			["seven_sea_map/empty_bg/move_point"] = "_control.move_point",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/radar_effect2"] = "_control.enemy_info_bg.radar_frame.radar_effect2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3.monster",
			["seven_sea_map/msg_panel/finish_special_mission/finish_title"] = "_control.msg_panel.finish_special_mission.finish_title",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3.monster",
			["seven_sea_map/empty_bg/cloud_shadow_list/cloud_shadow_list_2"] = "_control.cloud_shadow_list_2",
			["seven_sea_map/return_btn"] = "_control.return_btn",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1.monster",
			["seven_sea_map/top_find_ani/chassis_radar"] = "_control.top_find_ani.chassis_radar",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4",
			["seven_sea_map/enemy_info_bg/line_bottom/random_tip_text/txt"] = "_control.enemy_info_bg.random_tip_text.txt",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4.monster",
			["seven_sea_map/msg_panel"] = "_control.msg_panel",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2.monster",
			["seven_sea_map/empty_bg/cloud_list"] = "_control.cloud_list",
			["seven_sea_map/map_preview/map_bg/map_panel/pass_icon/pass_txt"] = "_control.map_preview.map_bg.map_panel.pass_icon.pass_txt",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset",
			["seven_sea_map/map_preview"] = "_control.map_preview",
			["seven_sea_map/map_preview/map_bg/boss_panel/boss_hp_black/boss_hp_bar"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black.boss_hp_bar",
			["seven_sea_map/empty_bg/islands_list"] = "_control.islands_list",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/fight_btn"] = "_control.enemy_info_bg.fight_btn",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4",
			["seven_sea_map/msg_panel/finish_special_mission"] = "_control.msg_panel.finish_special_mission",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/back_btn"] = "_control.enemy_info_bg.back_btn",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1.monster",
			["seven_sea_map/top_find_ani"] = "_control.top_find_ani",
			["seven_sea_map/player_role/find_treasure"] = "_control.player_role.find_treasure",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3.monster",
			["seven_sea_map/empty_bg/exploration_list"] = "_control.exploration_list",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4.monster",
			["seven_sea_map/map_preview/map_bg/close_btn"] = "_control.map_preview.map_bg.close_btn",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1",
			["seven_sea_map/player_role/sigh"] = "_control.player_role.sigh",
			["seven_sea_map/player_role/radar/find"] = "_control.player_role.radar.find",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1.monster",
			["seven_sea_map/empty_bg/treasure/get_txt"] = "_control.empty_bg.treasure.get_txt",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2.monster",
			["seven_sea_map/map_preview/map_tips_panel"] = "_control.map_preview.map_tips_panel",
			["seven_sea_map/boss_sign"] = "_control.boss_sign",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1",
			["seven_sea_map/msg_panel/finish_special_mission/coin_num"] = "_control.msg_panel.finish_special_mission.coin_num",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4.monster",
			["seven_sea_map/empty_bg/enemy_list"] = "_control.enemy_list",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5.monster",
			["seven_sea_map/map_preview/map_bg/map_panel"] = "_control.map_preview.map_bg.map_panel",
			["seven_sea_map/enemy_info_bg/s_enemy_info"] = "_control.enemy_info_bg.s_enemy_info",
			["seven_sea_map/map_preview/map_bg/boss_panel/boss_image"] = "_control.map_preview.map_bg.boss_panel.boss_image",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6",
			["seven_sea_map/empty_bg/operational_list"] = "_control.operational_list",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4",
			["seven_sea_map/map_preview/map_bg/boss_panel"] = "_control.map_preview.map_bg.boss_panel",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1.monster",
			["seven_sea_map/map_preview/map_bg/reward_panel/reward_line_2"] = "_control.map_preview.map_bg.reward_panel.reward_line_2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3.monster",
			["seven_sea_map/map_preview/map_bg/bottom_tips"] = "_control.map_preview.map_bg.bottom_tips",
			["seven_sea_map/map_preview/map_bg/bottom_tips/dot_image"] = "_control.map_preview.map_bg.bottom_tips.dot_image",
			["seven_sea_map/top_find_ani/scattering"] = "_control.top_find_ani.scattering",
			["seven_sea_map/empty_bg/treasure_spiral"] = "_control.empty_bg.treasure_spiral",
			["seven_sea_map/map_preview/map_bg/equip_mask"] = "_control.equip_mask",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3",
			["seven_sea_map/map_preview/map_bg/boss_panel/boss_hp_black/percent"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black.percent",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4.monster",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2.monster",
			["seven_sea_map/boss_sign/icon"] = "_control.boss_sign.icon",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset",
			["seven_sea_map/top_find_ani/find_ani/line_top"] = "_control.top_find_ani.find_ani.line_top",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1.monster",
			["seven_sea_map/map_preview/map_bg/reward_panel/reward_title"] = "_control.map_preview.map_bg.reward_panel.reward_title",
			["seven_sea_map/msg_panel/finish_special_mission/task_title"] = "_control.msg_panel.finish_special_mission.task_title",
			["seven_sea_map/top_find_ani/find_ani/line_botton"] = "_control.top_find_ani.find_ani.line_botton",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset",
			["seven_sea_map/player_role"] = "_control.player_role",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2.monster",
			["seven_sea_map/player_role/cover"] = "_control.cover",
			["seven_sea_map/map_preview/map_bg/reward_panel/reward_icon/get_icon"] = "_control.map_preview.map_bg.reward_panel.reward_icon.get_icon",
			["seven_sea_map/msg_panel/finish_special_mission/icon"] = "_control.msg_panel.finish_special_mission.icon",
			["seven_sea_map/map_preview/map_bg/confirm_btn"] = "_control.map_preview.map_bg.confirm_btn",
			["seven_sea_map/enemy_info_bg/enemy_list"] = "_control.enemy_info_bg.enemy_list",
			["seven_sea_map/enemy_info_bg/radar_frame/radar_effect1"] = "_control.enemy_info_bg.radar_frame.radar_effect1",
			["seven_sea_map/player_role/radar"] = "_control.player_role.radar",
			["seven_sea_map/enemy_info_bg/line_bottom/random_tip_text"] = "_control.enemy_info_bg.random_tip_text",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3",
			["seven_sea_map/map_preview/map_bg/title_bg/title_txt"] = "_control.map_preview.map_bg.title_bg.title_txt",
			["seven_sea_map/plane_sign/icon"] = "_control.plane_sign.icon",
			["seven_sea_map/point_coin"] = "_control.point_coin",
			["seven_sea_map/top_find_ani/chassis_top"] = "_control.top_find_ani.chassis_top",
			["seven_sea_map/map_preview/map_bg/title_bg"] = "_control.map_preview.map_bg.title_bg",
			["seven_sea_map/enemy_info_bg/back_btn/text"] = "_control.enemy_info_bg.back_btn.text",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2",
			["seven_sea_map/empty_bg/cloud_shadow_list/cloud_shadow_list_1"] = "_control.cloud_shadow_list_1",
			["seven_sea_map/enemy_info_bg/radar_frame"] = "_control.enemy_info_bg.radar_frame",
			["seven_sea_map/empty_bg/cloud_list/cloud_list_1"] = "_control.cloud_list_1",
			["seven_sea_map/empty_bg/treasure/get_img"] = "_control.empty_bg.treasure.get_img",
			["seven_sea_map/explore/btn"] = "_control.explore.btn",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset",
			["seven_sea_map/explore"] = "_control.explore",
			["seven_sea_map/map_preview/map_bg/reward_panel/reward_icon"] = "_control.map_preview.map_bg.reward_panel.reward_icon",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation"] = "_control.enemy_info_bg.radar_frame.monster_formation",
			["seven_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5",
			["seven_sea_map/player_role/shadow"] = "_control.player_role.shadow",
			["seven_sea_map/map_preview/map_bg/bottom_tips/tips_txt"] = "_control.map_preview.map_bg.bottom_tips.tips_txt",
			["seven_sea_map/enemy_info_bg/fight_btn/text"] = "_control.enemy_info_bg.fight_btn.text",
			["seven_sea_map/map_preview/map_bg/reward_panel/reward_line"] = "_control.map_preview.map_bg.reward_panel.reward_line",
			["seven_sea_map/map_preview/map_bg/map_panel/map_image"] = "_control.map_preview.map_bg.map_panel.map_image",
			["seven_sea_map/map_preview/map_tips_panel/tips_txt"] = "_control.map_preview.map_tips_panel.tips_txt"
		},
		click = {
			["empty_bg/treasure/get_img"] = {
				tp = "UnityEngine.UI.Button"
			},
			["empty_bg/treasure/get_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			return_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["enemy_info_bg/back_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["enemy_info_bg/fight_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/reward_panel/reward_icon"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["map_preview/map_bg/equip_mask"] = {
				tp = "UnityEngine.UI.Button"
			},
			finish_special_mission_btn = {
				tp = "UnityEngine.UI.Button"
			},
			explore = {
				tp = "UnityEngine.UI.Button"
			},
			["explore/btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		pointer_down_up = {
			empty_bg = {
				tp = "PointerDownUpEvent"
			}
		},
		trigger_2d = {
			player_role = {
				tp = "Trigger2DEvent"
			}
		},
		canvas_set = {
			cloud_list = {
				component = "UnityEngine.Canvas",
				path = "empty_bg/cloud_list"
			},
			enemy_info_bg = {
				component = "UnityEngine.Canvas",
				path = "enemy_info_bg"
			},
			map_bg = {
				component = "UnityEngine.Canvas",
				path = "map_preview/map_bg"
			},
			finish_special_mission_btn = {
				component = "UnityEngine.Canvas",
				path = "finish_special_mission_btn"
			}
		}
	}
}

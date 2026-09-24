return {
	_rule_ = {
		none = {
			empty_bg = {
				path = "empty_bg",
				list = {
					treasure_spiral = {
						path = "empty_bg/treasure_spiral",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"Spine.Unity.SkeletonGraphic"
						}
					},
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
			support_list = {
				path = "empty_bg/support_list",
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
			operational_list = {
				path = "empty_bg/operational_list",
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
			player_role_cover = {
				path = "player_role/player_role_cover",
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
			line_top = {
				path = "enemy_info_bg/line_top",
				list = {},
				component = {}
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
			cover = {
				path = "map_preview/cover",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
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
							"UnityEngine.UI.Image",
							"UnityEngine.Canvas"
						}
					}
				},
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
					"UnityEngine.UI.Image"
				}
			},
			enemy_buff_level = {
				path = "enemy_buff_level",
				list = {
					enemy_buff_level_txt = {
						path = "enemy_buff_level/enemy_buff_level_txt",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					enemy_buff_level_txt_2 = {
						path = "enemy_buff_level/enemy_buff_level_txt_2",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					}
				},
				component = {
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
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
			point_coin_icon = {
				path = "point_coin/point_coin_icon",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		call_node_list = {
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos2",
			["eighth_sea_map/msg_panel/finish_special_mission/award_icon"] = "_control.award_icon",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/back_btn"] = "_control.enemy_info_bg.back_btn",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2.monster",
			["eighth_sea_map/player_role/spray"] = "_control.player_role.spray",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame"] = "_control.enemy_info_bg.radar_frame",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2",
			["eighth_sea_map/enemy_info_bg/s_enemy_info"] = "_control.enemy_info_bg.s_enemy_info",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1.offset",
			["eighth_sea_map/return_btn"] = "_control.return_btn",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2",
			["eighth_sea_map/map_preview/map_bg/reward_panel/reward_line_2"] = "_control.map_preview.map_bg.reward_panel.reward_line_2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/enemy_info_txt"] = "_control.enemy_info_bg.enemy_info_txt",
			["eighth_sea_map/empty_bg/move_point"] = "_control.move_point",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1.monster",
			["eighth_sea_map/map_preview/map_bg/title_bg"] = "_control.map_preview.map_bg.title_bg",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset",
			["eighth_sea_map/map_preview/map_bg/boss_panel/boss_head"] = "_control.map_preview.map_bg.boss_panel.boss_head",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos3",
			["eighth_sea_map/map_preview/map_bg/boss_panel/boss_hp_black"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos4",
			["eighth_sea_map/point_coin"] = "_control.point_coin",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset",
			["eighth_sea_map/cover_2"] = "_control.cover_2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos5",
			["eighth_sea_map/player_role"] = "_control.player_role",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4",
			["eighth_sea_map/map_preview/map_bg/title_bg/title_txt"] = "_control.map_preview.map_bg.title_bg.title_txt",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3",
			["eighth_sea_map/map_preview/map_bg/reward_panel"] = "_control.map_preview.map_bg.reward_panel",
			["eighth_sea_map/empty_bg/treasure_spiral"] = "_control.empty_bg.treasure_spiral",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos1",
			["eighth_sea_map/map_preview/map_bg/reward_panel/reward_icon_bg"] = "_control.map_preview.map_bg.reward_panel.reward_icon_bg",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1.monster",
			["eighth_sea_map/empty_bg/treasure/get_txt"] = "_control.empty_bg.treasure.get_txt",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5",
			["eighth_sea_map/top_find_ani/chassis_radar"] = "_control.top_find_ani.chassis_radar",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3.monster",
			["eighth_sea_map/plane_sign/icon"] = "_control.plane_sign.icon",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos5",
			["eighth_sea_map/empty_bg/exploration_list"] = "_control.exploration_list",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num2.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1.monster",
			["eighth_sea_map/enemy_buff_level/enemy_buff_level_txt_2"] = "_control.enemy_buff_level.enemy_buff_level_txt_2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos4",
			["eighth_sea_map/top_find_ani/find_ani/line_top"] = "_control.top_find_ani.find_ani.line_top",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3.monster",
			["eighth_sea_map/empty_bg/islands_list"] = "_control.islands_list",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1",
			["eighth_sea_map/top_find_ani/chassis_radar_inside"] = "_control.top_find_ani.chassis_radar_inside",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset",
			["eighth_sea_map/empty_bg/operational_list"] = "_control.operational_list",
			["eighth_sea_map/map_preview/map_bg/confirm_btn/title"] = "_control.map_preview.map_bg.confirm_btn.title",
			["eighth_sea_map/player_role/find_treasure"] = "_control.player_role.find_treasure",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset",
			["eighth_sea_map/enemy_info_bg/line_top"] = "_control.line_top",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/line_bottom/random_tip_text/txt"] = "_control.enemy_info_bg.random_tip_text.txt",
			["eighth_sea_map/player_role/sigh"] = "_control.player_role.sigh",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num1.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1.monster",
			["eighth_sea_map/empty_bg/cloud_list"] = "_control.cloud_list",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos2.monster",
			["eighth_sea_map/top_find_ani/chassis_radar_outside"] = "_control.top_find_ani.chassis_radar_outside",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2.monster",
			["eighth_sea_map/player_role/radar/find"] = "_control.player_role.radar.find",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4",
			["eighth_sea_map/msg_panel/finish_special_mission/map_title"] = "_control.msg_panel.finish_special_mission.map_title",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num4.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num5.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset",
			["eighth_sea_map/enemy_info_bg/enemy_list"] = "_control.enemy_info_bg.enemy_list",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos1",
			["eighth_sea_map/map_preview/map_bg/map_panel/map_image"] = "_control.map_preview.map_bg.map_panel.map_image",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos4.monster",
			["eighth_sea_map/map_preview/map_bg/map_panel/pass_icon/pass_txt"] = "_control.map_preview.map_bg.map_panel.pass_icon.pass_txt",
			["eighth_sea_map/map_preview/map_bg/bottom_tips"] = "_control.map_preview.map_bg.bottom_tips",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos6.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1",
			["eighth_sea_map/map_preview/map_bg/boss_panel/boss_hp_black/boss_hp_bar"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black.boss_hp_bar",
			["eighth_sea_map/empty_bg/treasure/get_light"] = "_control.empty_bg.treasure.get_light",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num2.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos6.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos1",
			["eighth_sea_map/empty_bg/cloud_shadow_list/cloud_shadow_list_2"] = "_control.cloud_shadow_list_2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2",
			["eighth_sea_map/empty_bg/treasure"] = "_control.empty_bg.treasure",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/radar_effect1"] = "_control.enemy_info_bg.radar_frame.radar_effect1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num2.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num1.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6",
			["eighth_sea_map/map_preview/map_bg/boss_panel"] = "_control.map_preview.map_bg.boss_panel",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4",
			["eighth_sea_map/boss_sign"] = "_control.boss_sign",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset/pos6/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset.pos6.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos1.monster",
			["eighth_sea_map/player_role/shadow"] = "_control.player_role.shadow",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2",
			["eighth_sea_map/map_preview/map_bg/reward_panel/reward_icon/get_icon"] = "_control.map_preview.map_bg.reward_panel.reward_icon.get_icon",
			["eighth_sea_map/empty_bg/treasure/get_img"] = "_control.empty_bg.treasure.get_img",
			["eighth_sea_map/plane_sign"] = "_control.plane_sign",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos4.monster",
			["eighth_sea_map/empty_bg/cloud_list/cloud_list_1"] = "_control.cloud_list_1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos5.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num4/offset/pos4/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num4.offset.pos4.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos1.monster",
			["eighth_sea_map/enemy_buff_level/enemy_buff_level_txt"] = "_control.enemy_buff_level.enemy_buff_level_txt",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2.monster",
			["eighth_sea_map/map_preview/map_bg/map_panel"] = "_control.map_preview.map_bg.map_panel",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2",
			["eighth_sea_map/top_find_ani/find_ani/line_botton"] = "_control.top_find_ani.find_ani.line_botton",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num2/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num2.offset.pos2.monster",
			["eighth_sea_map/map_preview/map_bg/reward_panel/reward_line"] = "_control.map_preview.map_bg.reward_panel.reward_line",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos1",
			["eighth_sea_map/map_preview/map_bg/map_panel/pass_icon"] = "_control.map_preview.map_bg.map_panel.pass_icon",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num6/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num6.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num6.offset",
			["eighth_sea_map/map_preview/map_bg/boss_panel/boss_image"] = "_control.map_preview.map_bg.boss_panel.boss_image",
			["eighth_sea_map/msg_panel/finish_special_mission/coin_num"] = "_control.msg_panel.finish_special_mission.coin_num",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num5",
			["eighth_sea_map/msg_panel/finish_special_mission/finish_title"] = "_control.msg_panel.finish_special_mission.finish_title",
			["eighth_sea_map/map_preview/map_bg/boss_panel/boss_hp_black/hp_percent_num"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black.hp_percent_num",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset.pos2.monster",
			["eighth_sea_map/map_preview/map_bg/boss_panel/boss_hp_black/percent"] = "_control.map_preview.map_bg.boss_panel.boss_hp_black.percent",
			["eighth_sea_map/map_preview/map_bg/reward_panel/reward_title"] = "_control.map_preview.map_bg.reward_panel.reward_title",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num6/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num6.offset",
			["eighth_sea_map/map_preview/map_bg/boss_panel/boss_bg"] = "_control.map_preview.map_bg.boss_panel.boss_bg",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num5/offset/pos2/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num5.offset.pos2.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num2/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num2.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num3/offset/pos3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num3.offset.pos3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num6/offset/pos5/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num6.offset.pos5.monster",
			["eighth_sea_map/map_preview/map_bg/bottom_tips/dot_image"] = "_control.map_preview.map_bg.bottom_tips.dot_image",
			["eighth_sea_map/map_preview/map_tips_panel"] = "_control.map_preview.map_tips_panel",
			["eighth_sea_map/msg_panel/finish_special_mission"] = "_control.msg_panel.finish_special_mission",
			["eighth_sea_map/top_find_ani/chassis_top"] = "_control.top_find_ani.chassis_top",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num6/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num6.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5/offset/pos1/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5.offset.pos1.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num3",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1/num4/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1.num4.offset",
			["eighth_sea_map/point_coin/point_coin_icon"] = "_control.point_coin_icon",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation2/num4/offset/pos1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation2.num4.offset.pos1",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5/offset/pos3/monster"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5.offset.pos3.monster",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation5/num3/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation5.num3.offset.pos2",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num5",
			["eighth_sea_map/finish_special_mission_btn"] = "_control.finish_special_mission_btn",
			["eighth_sea_map/empty_bg/treasure/get_btn"] = "_control.empty_bg.treasure.get_btn",
			["eighth_sea_map/msg_panel/finish_special_mission/task_title"] = "_control.msg_panel.finish_special_mission.task_title",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos2"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos2",
			["eighth_sea_map/enemy_info_bg"] = "_control.enemy_info_bg",
			["eighth_sea_map/map_preview/map_bg/map_panel/map_node_root"] = "_control.map_preview.map_bg.map_panel.map_node_root",
			["eighth_sea_map/player_role/radar"] = "_control.player_role.radar",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation3/num1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation3.num1",
			["eighth_sea_map/map_preview/map_bg/reward_panel/reward_icon"] = "_control.map_preview.map_bg.reward_panel.reward_icon",
			["eighth_sea_map/top_find_ani/find_ani"] = "_control.top_find_ani.find_ani",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3/offset"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3.offset",
			["eighth_sea_map/map_preview/map_bg"] = "_control.map_preview.map_bg",
			["eighth_sea_map/enemy_info_bg/back_btn/text"] = "_control.enemy_info_bg.back_btn.text",
			["eighth_sea_map/map_preview/cover"] = "_control.cover",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation1"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation1",
			["eighth_sea_map/map_preview/map_tips_panel/tips_txt"] = "_control.map_preview.map_tips_panel.tips_txt",
			["eighth_sea_map/boss_sign/icon"] = "_control.boss_sign.icon",
			["eighth_sea_map/map_preview"] = "_control.map_preview",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num5"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num5",
			["eighth_sea_map/map_preview/map_bg/bottom_tips/tips_txt"] = "_control.map_preview.map_bg.bottom_tips.tips_txt",
			["eighth_sea_map/msg_panel"] = "_control.msg_panel",
			["eighth_sea_map/top_find_ani"] = "_control.top_find_ani",
			["eighth_sea_map/player_role/player_role_cover"] = "_control.player_role_cover",
			["eighth_sea_map/enemy_info_bg/fight_btn/text"] = "_control.enemy_info_bg.fight_btn.text",
			["eighth_sea_map/map_preview/map_bg/confirm_btn"] = "_control.map_preview.map_bg.confirm_btn",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num3"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num3",
			["eighth_sea_map/empty_bg/cloud_shadow_list/cloud_shadow_list_1"] = "_control.cloud_shadow_list_1",
			["eighth_sea_map/enemy_info_bg/line_bottom/random_tip_text"] = "_control.enemy_info_bg.random_tip_text",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation/formation4/num4/offset/pos4"] = "_control.enemy_info_bg.radar_frame.monster_formation.formation4.num4.offset.pos4",
			["eighth_sea_map/enemy_buff_level"] = "_control.enemy_buff_level",
			["eighth_sea_map/enemy_info_bg/fight_btn"] = "_control.enemy_info_bg.fight_btn",
			["eighth_sea_map/empty_bg/enemy_list"] = "_control.enemy_list",
			["eighth_sea_map/empty_bg/support_list"] = "_control.support_list",
			["eighth_sea_map/enemy_info_bg/radar_frame/monster_formation"] = "_control.enemy_info_bg.radar_frame.monster_formation",
			["eighth_sea_map/empty_bg"] = "_control.empty_bg",
			["eighth_sea_map/enemy_info_bg/radar_frame/radar_effect2"] = "_control.enemy_info_bg.radar_frame.radar_effect2",
			["eighth_sea_map/empty_bg/cloud_list/cloud_list_2"] = "_control.cloud_list_2",
			["eighth_sea_map/map_preview/map_bg/equip_mask"] = "_control.equip_mask",
			["eighth_sea_map/point_coin/num"] = "_control.point_coin.num",
			["eighth_sea_map/map_preview/map_bg/close_btn"] = "_control.map_preview.map_bg.close_btn",
			["eighth_sea_map/top_find_ani/scattering"] = "_control.top_find_ani.scattering"
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
			enemy_buff_level = {
				tp = "UnityEngine.UI.Button"
			},
			finish_special_mission_btn = {
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
			cover = {
				component = "UnityEngine.Canvas",
				path = "map_preview/cover"
			},
			map_bg = {
				component = "UnityEngine.Canvas",
				path = "map_preview/map_bg"
			},
			finish_special_mission = {
				component = "UnityEngine.Canvas",
				path = "msg_panel/finish_special_mission"
			},
			finish_special_mission_btn = {
				component = "UnityEngine.Canvas",
				path = "finish_special_mission_btn"
			}
		}
	}
}

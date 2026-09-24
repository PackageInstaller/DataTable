return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.Animator"
				}
			},
			player_ship_team = {
				path = "player_ship_team",
				list = {
					band_1 = {
						path = "player_ship_team/band_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.Animation"
						}
					},
					band_2 = {
						path = "player_ship_team/band_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					radar = {
						path = "player_ship_team/radar",
						list = {
							radar_inside = {
								path = "player_ship_team/radar/radar_inside",
								list = {
									radar_wave = {
										path = "player_ship_team/radar/radar_inside/radar_wave",
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
									"UnityEngine.Animation"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					light = {
						path = "player_ship_team/light",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					player_ship_1 = {
						path = "player_ship_team/player_ship_1",
						list = {
							ship_icon = {
								path = "player_ship_team/player_ship_1/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "player_ship_team/player_ship_1/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_arsenal = {
								path = "player_ship_team/player_ship_1/missile_arsenal",
								list = {
									missile_1 = {
										path = "player_ship_team/player_ship_1/missile_arsenal/missile_1",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_1/missile_arsenal/missile_1/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_1/missile_arsenal/missile_1/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_2 = {
										path = "player_ship_team/player_ship_1/missile_arsenal/missile_2",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_1/missile_arsenal/missile_2/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_1/missile_arsenal/missile_2/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_3 = {
										path = "player_ship_team/player_ship_1/missile_arsenal/missile_3",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_1/missile_arsenal/missile_3/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_1/missile_arsenal/missile_3/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.Animation"
						}
					},
					player_ship_2 = {
						path = "player_ship_team/player_ship_2",
						list = {
							ship_icon = {
								path = "player_ship_team/player_ship_2/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "player_ship_team/player_ship_2/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_arsenal = {
								path = "player_ship_team/player_ship_2/missile_arsenal",
								list = {
									missile_4 = {
										path = "player_ship_team/player_ship_2/missile_arsenal/missile_4",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_2/missile_arsenal/missile_4/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_2/missile_arsenal/missile_4/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_5 = {
										path = "player_ship_team/player_ship_2/missile_arsenal/missile_5",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_2/missile_arsenal/missile_5/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_2/missile_arsenal/missile_5/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_6 = {
										path = "player_ship_team/player_ship_2/missile_arsenal/missile_6",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_2/missile_arsenal/missile_6/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_2/missile_arsenal/missile_6/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.Animation"
						}
					},
					player_ship_3 = {
						path = "player_ship_team/player_ship_3",
						list = {
							ship_icon = {
								path = "player_ship_team/player_ship_3/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "player_ship_team/player_ship_3/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_arsenal = {
								path = "player_ship_team/player_ship_3/missile_arsenal",
								list = {
									missile_7 = {
										path = "player_ship_team/player_ship_3/missile_arsenal/missile_7",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_3/missile_arsenal/missile_7/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_3/missile_arsenal/missile_7/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_8 = {
										path = "player_ship_team/player_ship_3/missile_arsenal/missile_8",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_3/missile_arsenal/missile_8/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_3/missile_arsenal/missile_8/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_9 = {
										path = "player_ship_team/player_ship_3/missile_arsenal/missile_9",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_3/missile_arsenal/missile_9/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_3/missile_arsenal/missile_9/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.Animation"
						}
					},
					player_ship_4 = {
						path = "player_ship_team/player_ship_4",
						list = {
							ship_icon = {
								path = "player_ship_team/player_ship_4/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "player_ship_team/player_ship_4/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_arsenal = {
								path = "player_ship_team/player_ship_4/missile_arsenal",
								list = {
									missile_10 = {
										path = "player_ship_team/player_ship_4/missile_arsenal/missile_10",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_4/missile_arsenal/missile_10/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_4/missile_arsenal/missile_10/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_11 = {
										path = "player_ship_team/player_ship_4/missile_arsenal/missile_11",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_4/missile_arsenal/missile_11/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_4/missile_arsenal/missile_11/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_12 = {
										path = "player_ship_team/player_ship_4/missile_arsenal/missile_12",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_4/missile_arsenal/missile_12/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_4/missile_arsenal/missile_12/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.Animation"
						}
					},
					player_ship_5 = {
						path = "player_ship_team/player_ship_5",
						list = {
							ship_icon = {
								path = "player_ship_team/player_ship_5/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "player_ship_team/player_ship_5/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_arsenal = {
								path = "player_ship_team/player_ship_5/missile_arsenal",
								list = {
									missile_13 = {
										path = "player_ship_team/player_ship_5/missile_arsenal/missile_13",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_5/missile_arsenal/missile_13/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_5/missile_arsenal/missile_13/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_14 = {
										path = "player_ship_team/player_ship_5/missile_arsenal/missile_14",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_5/missile_arsenal/missile_14/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_5/missile_arsenal/missile_14/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_15 = {
										path = "player_ship_team/player_ship_5/missile_arsenal/missile_15",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_5/missile_arsenal/missile_15/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_5/missile_arsenal/missile_15/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.Animation"
						}
					},
					player_ship_6 = {
						path = "player_ship_team/player_ship_6",
						list = {
							ship_icon = {
								path = "player_ship_team/player_ship_6/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "player_ship_team/player_ship_6/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_arsenal = {
								path = "player_ship_team/player_ship_6/missile_arsenal",
								list = {
									missile_16 = {
										path = "player_ship_team/player_ship_6/missile_arsenal/missile_16",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_6/missile_arsenal/missile_16/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_6/missile_arsenal/missile_16/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_17 = {
										path = "player_ship_team/player_ship_6/missile_arsenal/missile_17",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_6/missile_arsenal/missile_17/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_6/missile_arsenal/missile_17/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									},
									missile_18 = {
										path = "player_ship_team/player_ship_6/missile_arsenal/missile_18",
										list = {
											missile_shape = {
												path = "player_ship_team/player_ship_6/missile_arsenal/missile_18/missile_shape",
												list = {
													trail = {
														path = "player_ship_team/player_ship_6/missile_arsenal/missile_18/missile_shape/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.MeshFilter",
													"UnityEngine.MeshRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer"
										}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.Animation"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer"
				}
			},
			enemy_ship_team = {
				path = "enemy_ship_team",
				list = {
					light = {
						path = "enemy_ship_team/light",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					find_ani = {
						path = "enemy_ship_team/find_ani",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"Spine.Unity.SkeletonGraphic"
						}
					},
					radar_reflect = {
						path = "enemy_ship_team/radar_reflect",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					enemy_ship_1 = {
						path = "enemy_ship_team/enemy_ship_1",
						list = {
							ship_icon = {
								path = "enemy_ship_team/enemy_ship_1/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							aim = {
								path = "enemy_ship_team/enemy_ship_1/aim",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "enemy_ship_team/enemy_ship_1/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							halo = {
								path = "enemy_ship_team/enemy_ship_1/halo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_intercept = {
								path = "enemy_ship_team/enemy_ship_1/missile_intercept",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_1/missile_intercept/missile_1",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_1/missile_intercept/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_1/missile_intercept/missile_2",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_1/missile_intercept/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_1/missile_intercept/missile_3",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_1/missile_intercept/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							missile_player_attack = {
								path = "enemy_ship_team/enemy_ship_1/missile_player_attack",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_1",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_1/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_2",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_2/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_3",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_3/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_1/missile_player_attack/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					enemy_ship_2 = {
						path = "enemy_ship_team/enemy_ship_2",
						list = {
							ship_icon = {
								path = "enemy_ship_team/enemy_ship_2/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							aim = {
								path = "enemy_ship_team/enemy_ship_2/aim",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "enemy_ship_team/enemy_ship_2/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							halo = {
								path = "enemy_ship_team/enemy_ship_2/halo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_intercept = {
								path = "enemy_ship_team/enemy_ship_2/missile_intercept",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_2/missile_intercept/missile_1",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_2/missile_intercept/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_2/missile_intercept/missile_2",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_2/missile_intercept/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_2/missile_intercept/missile_3",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_2/missile_intercept/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							missile_player_attack = {
								path = "enemy_ship_team/enemy_ship_2/missile_player_attack",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_1",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_1/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_2",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_2/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_3",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_3/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_2/missile_player_attack/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					enemy_ship_3 = {
						path = "enemy_ship_team/enemy_ship_3",
						list = {
							ship_icon = {
								path = "enemy_ship_team/enemy_ship_3/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							aim = {
								path = "enemy_ship_team/enemy_ship_3/aim",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "enemy_ship_team/enemy_ship_3/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							halo = {
								path = "enemy_ship_team/enemy_ship_3/halo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_intercept = {
								path = "enemy_ship_team/enemy_ship_3/missile_intercept",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_3/missile_intercept/missile_1",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_3/missile_intercept/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_3/missile_intercept/missile_2",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_3/missile_intercept/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_3/missile_intercept/missile_3",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_3/missile_intercept/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							missile_player_attack = {
								path = "enemy_ship_team/enemy_ship_3/missile_player_attack",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_1",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_1/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_2",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_2/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_3",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_3/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_3/missile_player_attack/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					enemy_ship_4 = {
						path = "enemy_ship_team/enemy_ship_4",
						list = {
							ship_icon = {
								path = "enemy_ship_team/enemy_ship_4/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							aim = {
								path = "enemy_ship_team/enemy_ship_4/aim",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "enemy_ship_team/enemy_ship_4/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							halo = {
								path = "enemy_ship_team/enemy_ship_4/halo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_intercept = {
								path = "enemy_ship_team/enemy_ship_4/missile_intercept",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_4/missile_intercept/missile_1",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_4/missile_intercept/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_4/missile_intercept/missile_2",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_4/missile_intercept/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_4/missile_intercept/missile_3",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_4/missile_intercept/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							missile_player_attack = {
								path = "enemy_ship_team/enemy_ship_4/missile_player_attack",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_1",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_1/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_2",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_2/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_3",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_3/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_4/missile_player_attack/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					enemy_ship_5 = {
						path = "enemy_ship_team/enemy_ship_5",
						list = {
							ship_icon = {
								path = "enemy_ship_team/enemy_ship_5/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							aim = {
								path = "enemy_ship_team/enemy_ship_5/aim",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "enemy_ship_team/enemy_ship_5/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							halo = {
								path = "enemy_ship_team/enemy_ship_5/halo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_intercept = {
								path = "enemy_ship_team/enemy_ship_5/missile_intercept",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_5/missile_intercept/missile_1",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_5/missile_intercept/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_5/missile_intercept/missile_2",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_5/missile_intercept/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_5/missile_intercept/missile_3",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_5/missile_intercept/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							missile_player_attack = {
								path = "enemy_ship_team/enemy_ship_5/missile_player_attack",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_1",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_1/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_2",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_2/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_3",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_3/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_5/missile_player_attack/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer"
						}
					},
					enemy_ship_6 = {
						path = "enemy_ship_team/enemy_ship_6",
						list = {
							ship_icon = {
								path = "enemy_ship_team/enemy_ship_6/ship_icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							aim = {
								path = "enemy_ship_team/enemy_ship_6/aim",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							change = {
								path = "enemy_ship_team/enemy_ship_6/change",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							halo = {
								path = "enemy_ship_team/enemy_ship_6/halo",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_intercept = {
								path = "enemy_ship_team/enemy_ship_6/missile_intercept",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_6/missile_intercept/missile_1",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_6/missile_intercept/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_6/missile_intercept/missile_2",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_6/missile_intercept/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_6/missile_intercept/missile_3",
										list = {
											trail = {
												path = "enemy_ship_team/enemy_ship_6/missile_intercept/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							missile_player_attack = {
								path = "enemy_ship_team/enemy_ship_6/missile_player_attack",
								list = {
									missile_1 = {
										path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_1",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_1/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_2",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_2/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_3",
										list = {
											halo = {
												path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_3/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "enemy_ship_team/enemy_ship_6/missile_player_attack/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
					"UnityEngine.Animator"
				}
			},
			intercpet_attack_video = {
				path = "intercpet_attack_video",
				list = {
					bg = {
						path = "intercpet_attack_video/bg",
						list = {
							enemy_ship_1 = {
								path = "intercpet_attack_video/bg/enemy_ship_1",
								list = {
									missile_intercept = {
										path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_1",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_1/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_2",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_2/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_3",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_3/success",
														list = {},
														component = {}
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
									missile_player_attack = {
										path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_1",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_1/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_2",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_2/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_3",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_3/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_2 = {
								path = "intercpet_attack_video/bg/enemy_ship_2",
								list = {
									missile_intercept = {
										path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_1",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_1/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_2",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_2/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_3",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_3/success",
														list = {},
														component = {}
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
									missile_player_attack = {
										path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_1",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_1/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_2",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_2/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_3",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_3/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_3 = {
								path = "intercpet_attack_video/bg/enemy_ship_3",
								list = {
									missile_intercept = {
										path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_1",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_1/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_2",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_2/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_3",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_3/success",
														list = {},
														component = {}
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
									missile_player_attack = {
										path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_1",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_1/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_2",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_2/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_3",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_3/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_4 = {
								path = "intercpet_attack_video/bg/enemy_ship_4",
								list = {
									missile_intercept = {
										path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_1",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_1/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_2",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_2/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_3",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_3/success",
														list = {},
														component = {}
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
									missile_player_attack = {
										path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_1",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_1/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_2",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_2/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_3",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_3/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_5 = {
								path = "intercpet_attack_video/bg/enemy_ship_5",
								list = {
									missile_intercept = {
										path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_1",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_1/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_2",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_2/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_3",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_3/success",
														list = {},
														component = {}
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
									missile_player_attack = {
										path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_1",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_1/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_2",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_2/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_3",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_3/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_6 = {
								path = "intercpet_attack_video/bg/enemy_ship_6",
								list = {
									missile_intercept = {
										path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_1",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_1/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_2",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_2/success",
														list = {},
														component = {}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_3",
												list = {
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													},
													success = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_3/success",
														list = {},
														component = {}
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
									missile_player_attack = {
										path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack",
										list = {
											missile_1 = {
												path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_1",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_1/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_1/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_2 = {
												path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_2",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_2/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_2/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
														}
													}
												},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_3 = {
												path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_3",
												list = {
													halo = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_3/halo",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													trail = {
														path = "intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_3/trail",
														list = {},
														component = {
															"UnityEngine.Transform",
															"UnityEngine.TrailRenderer"
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
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							missile_player_radar = {
								path = "intercpet_attack_video/bg/missile_player_radar",
								list = {
									missile_1 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_1",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_2",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_3",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_4 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_4",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_4/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_5 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_5",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_5/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_6 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_6",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_6/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_7 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_7",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_7/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_8 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_8",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_8/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_9 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_9",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_9/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_10 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_10",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_10/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_11 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_11",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_11/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_12 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_12",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_12/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_13 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_13",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_13/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_14 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_14",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_14/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_15 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_15",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_15/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_16 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_16",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_16/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_17 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_17",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_17/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_18 = {
										path = "intercpet_attack_video/bg/missile_player_radar/missile_18",
										list = {
											trail = {
												path = "intercpet_attack_video/bg/missile_player_radar/missile_18/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Mask"
						}
					}
				},
				component = {}
			},
			bvr_camera = {
				path = "bvr_camera",
				list = {
					shadow = {
						path = "bvr_camera/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					player_bvr_list = {
						path = "bvr_camera/player_bvr_list",
						list = {
							attack_header_6 = {
								path = "bvr_camera/player_bvr_list/attack_header_6",
								list = {
									header = {
										path = "bvr_camera/player_bvr_list/attack_header_6/header",
										list = {
											header_bg = {
												path = "bvr_camera/player_bvr_list/attack_header_6/header/header_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_img = {
												path = "bvr_camera/player_bvr_list/attack_header_6/header/header_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_color = {
												path = "bvr_camera/player_bvr_list/attack_header_6/header/header_color",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									missile = {
										path = "bvr_camera/player_bvr_list/attack_header_6/missile",
										list = {
											missile_icon = {
												path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_use_info = {
												path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info",
												list = {
													missile_1 = {
														path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_1",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_1/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_1/attackend",
																list = {},
																component = {
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
													missile_2 = {
														path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_2",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_2/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_2/attackend",
																list = {},
																component = {
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
													missile_3 = {
														path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_3",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_3/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_3/attackend",
																list = {},
																component = {
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
													"UnityEngine.RectTransform"
												}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							attack_header_5 = {
								path = "bvr_camera/player_bvr_list/attack_header_5",
								list = {
									header = {
										path = "bvr_camera/player_bvr_list/attack_header_5/header",
										list = {
											header_bg = {
												path = "bvr_camera/player_bvr_list/attack_header_5/header/header_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_img = {
												path = "bvr_camera/player_bvr_list/attack_header_5/header/header_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_color = {
												path = "bvr_camera/player_bvr_list/attack_header_5/header/header_color",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									missile = {
										path = "bvr_camera/player_bvr_list/attack_header_5/missile",
										list = {
											missile_icon = {
												path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_use_info = {
												path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info",
												list = {
													missile_1 = {
														path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_1",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_1/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_1/attackend",
																list = {},
																component = {
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
													missile_2 = {
														path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_2",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_2/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_2/attackend",
																list = {},
																component = {
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
													missile_3 = {
														path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_3",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_3/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_3/attackend",
																list = {},
																component = {
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
													"UnityEngine.RectTransform"
												}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							attack_header_4 = {
								path = "bvr_camera/player_bvr_list/attack_header_4",
								list = {
									header = {
										path = "bvr_camera/player_bvr_list/attack_header_4/header",
										list = {
											header_bg = {
												path = "bvr_camera/player_bvr_list/attack_header_4/header/header_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_img = {
												path = "bvr_camera/player_bvr_list/attack_header_4/header/header_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_color = {
												path = "bvr_camera/player_bvr_list/attack_header_4/header/header_color",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									missile = {
										path = "bvr_camera/player_bvr_list/attack_header_4/missile",
										list = {
											missile_icon = {
												path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_use_info = {
												path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info",
												list = {
													missile_1 = {
														path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_1",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_1/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_1/attackend",
																list = {},
																component = {
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
													missile_2 = {
														path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_2",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_2/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_2/attackend",
																list = {},
																component = {
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
													missile_3 = {
														path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_3",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_3/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_3/attackend",
																list = {},
																component = {
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
													"UnityEngine.RectTransform"
												}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							attack_header_3 = {
								path = "bvr_camera/player_bvr_list/attack_header_3",
								list = {
									header = {
										path = "bvr_camera/player_bvr_list/attack_header_3/header",
										list = {
											header_bg = {
												path = "bvr_camera/player_bvr_list/attack_header_3/header/header_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_img = {
												path = "bvr_camera/player_bvr_list/attack_header_3/header/header_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_color = {
												path = "bvr_camera/player_bvr_list/attack_header_3/header/header_color",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									missile = {
										path = "bvr_camera/player_bvr_list/attack_header_3/missile",
										list = {
											missile_icon = {
												path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_use_info = {
												path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info",
												list = {
													missile_1 = {
														path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_1",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_1/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_1/attackend",
																list = {},
																component = {
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
													missile_2 = {
														path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_2",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_2/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_2/attackend",
																list = {},
																component = {
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
													missile_3 = {
														path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_3",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_3/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_3/attackend",
																list = {},
																component = {
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
													"UnityEngine.RectTransform"
												}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							attack_header_2 = {
								path = "bvr_camera/player_bvr_list/attack_header_2",
								list = {
									header = {
										path = "bvr_camera/player_bvr_list/attack_header_2/header",
										list = {
											header_bg = {
												path = "bvr_camera/player_bvr_list/attack_header_2/header/header_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_img = {
												path = "bvr_camera/player_bvr_list/attack_header_2/header/header_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_color = {
												path = "bvr_camera/player_bvr_list/attack_header_2/header/header_color",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									missile = {
										path = "bvr_camera/player_bvr_list/attack_header_2/missile",
										list = {
											missile_icon = {
												path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_use_info = {
												path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info",
												list = {
													missile_1 = {
														path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_1",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_1/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_1/attackend",
																list = {},
																component = {
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
													missile_2 = {
														path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_2",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_2/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_2/attackend",
																list = {},
																component = {
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
													missile_3 = {
														path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_3",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_3/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_3/attackend",
																list = {},
																component = {
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
													"UnityEngine.RectTransform"
												}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							attack_header_1 = {
								path = "bvr_camera/player_bvr_list/attack_header_1",
								list = {
									header = {
										path = "bvr_camera/player_bvr_list/attack_header_1/header",
										list = {
											header_bg = {
												path = "bvr_camera/player_bvr_list/attack_header_1/header/header_bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_img = {
												path = "bvr_camera/player_bvr_list/attack_header_1/header/header_img",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											header_color = {
												path = "bvr_camera/player_bvr_list/attack_header_1/header/header_color",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform"
										}
									},
									missile = {
										path = "bvr_camera/player_bvr_list/attack_header_1/missile",
										list = {
											missile_icon = {
												path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											missile_use_info = {
												path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info",
												list = {
													missile_1 = {
														path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_1",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_1/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_1/attackend",
																list = {},
																component = {
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
													missile_2 = {
														path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_2",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_2/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_2/attackend",
																list = {},
																component = {
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
													missile_3 = {
														path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_3",
														list = {
															attacking = {
																path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_3/attacking",
																list = {},
																component = {
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Image"
																}
															},
															attackend = {
																path = "bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_3/attackend",
																list = {},
																component = {
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
													"UnityEngine.RectTransform"
												}
											}
										},
										component = {}
									}
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
					sea_info = {
						path = "bvr_camera/sea_info",
						list = {
							player = {
								path = "bvr_camera/sea_info/player",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							enemy = {
								path = "bvr_camera/sea_info/enemy",
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
					waring = {
						path = "bvr_camera/waring",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					open = {
						path = "bvr_camera/open",
						list = {},
						component = {
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					transition_1 = {
						path = "bvr_camera/transition_1",
						list = {
							transition_child = {
								path = "bvr_camera/transition_1/transition_child",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.ParticleSystem",
									"UnityEngine.ParticleSystemRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					transition_2 = {
						path = "bvr_camera/transition_2",
						list = {
							transition_child = {
								path = "bvr_camera/transition_2/transition_child",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.ParticleSystem",
									"UnityEngine.ParticleSystemRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					enemy_hp_list = {
						path = "bvr_camera/enemy_hp_list",
						list = {
							enemy_hp_1 = {
								path = "bvr_camera/enemy_hp_list/enemy_hp_1",
								list = {
									hp = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_1/hp",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									hp_color_bg = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_1/hp_color_bg",
										list = {
											hp_color_1 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_1/hp_color_bg/hp_color_1",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											},
											hp_color_2 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_1/hp_color_bg/hp_color_2",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Image"
								}
							},
							enemy_hp_2 = {
								path = "bvr_camera/enemy_hp_list/enemy_hp_2",
								list = {
									hp = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_2/hp",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									hp_color_bg = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_2/hp_color_bg",
										list = {
											hp_color_1 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_2/hp_color_bg/hp_color_1",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											},
											hp_color_2 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_2/hp_color_bg/hp_color_2",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Image"
								}
							},
							enemy_hp_3 = {
								path = "bvr_camera/enemy_hp_list/enemy_hp_3",
								list = {
									hp = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_3/hp",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									hp_color_bg = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_3/hp_color_bg",
										list = {
											hp_color_1 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_3/hp_color_bg/hp_color_1",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											},
											hp_color_2 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_3/hp_color_bg/hp_color_2",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Image"
								}
							},
							enemy_hp_4 = {
								path = "bvr_camera/enemy_hp_list/enemy_hp_4",
								list = {
									hp = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_4/hp",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									hp_color_bg = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_4/hp_color_bg",
										list = {
											hp_color_1 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_4/hp_color_bg/hp_color_1",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											},
											hp_color_2 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_4/hp_color_bg/hp_color_2",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Image"
								}
							},
							enemy_hp_5 = {
								path = "bvr_camera/enemy_hp_list/enemy_hp_5",
								list = {
									hp = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_5/hp",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									hp_color_bg = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_5/hp_color_bg",
										list = {
											hp_color_1 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_5/hp_color_bg/hp_color_1",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											},
											hp_color_2 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_5/hp_color_bg/hp_color_2",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Image"
								}
							},
							enemy_hp_6 = {
								path = "bvr_camera/enemy_hp_list/enemy_hp_6",
								list = {
									hp = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_6/hp",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									hp_color_bg = {
										path = "bvr_camera/enemy_hp_list/enemy_hp_6/hp_color_bg",
										list = {
											hp_color_1 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_6/hp_color_bg/hp_color_1",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											},
											hp_color_2 = {
												path = "bvr_camera/enemy_hp_list/enemy_hp_6/hp_color_bg/hp_color_2",
												list = {},
												component = {
													"UnityEngine.UI.Image",
													"UIFillAmountChangeEffect"
												}
											}
										},
										component = {
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					find_enemy_radar = {
						path = "bvr_camera/find_enemy_radar",
						list = {
							mask = {
								path = "bvr_camera/find_enemy_radar/mask",
								list = {
									wave_mask = {
										path = "bvr_camera/find_enemy_radar/mask/wave_mask",
										list = {
											wave = {
												path = "bvr_camera/find_enemy_radar/mask/wave_mask/wave",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.UI.Mask"
										}
									},
									radar_scan = {
										path = "bvr_camera/find_enemy_radar/mask/radar_scan",
										list = {},
										component = {}
									}
								},
								component = {
									"UnityEngine.UI.Mask"
								}
							},
							radar = {
								path = "bvr_camera/find_enemy_radar/radar",
								list = {
									radar_reflect = {
										path = "bvr_camera/find_enemy_radar/radar/radar_reflect",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_1 = {
										path = "bvr_camera/find_enemy_radar/radar/ship_1",
										list = {
											ship_lock = {
												path = "bvr_camera/find_enemy_radar/radar/ship_1/ship_lock",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "bvr_camera/find_enemy_radar/radar/ship_1/icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											lock_now = {
												path = "bvr_camera/find_enemy_radar/radar/ship_1/lock_now",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_2 = {
										path = "bvr_camera/find_enemy_radar/radar/ship_2",
										list = {
											ship_lock = {
												path = "bvr_camera/find_enemy_radar/radar/ship_2/ship_lock",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "bvr_camera/find_enemy_radar/radar/ship_2/icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											lock_now = {
												path = "bvr_camera/find_enemy_radar/radar/ship_2/lock_now",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_3 = {
										path = "bvr_camera/find_enemy_radar/radar/ship_3",
										list = {
											ship_lock = {
												path = "bvr_camera/find_enemy_radar/radar/ship_3/ship_lock",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "bvr_camera/find_enemy_radar/radar/ship_3/icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											lock_now = {
												path = "bvr_camera/find_enemy_radar/radar/ship_3/lock_now",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_4 = {
										path = "bvr_camera/find_enemy_radar/radar/ship_4",
										list = {
											ship_lock = {
												path = "bvr_camera/find_enemy_radar/radar/ship_4/ship_lock",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "bvr_camera/find_enemy_radar/radar/ship_4/icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											lock_now = {
												path = "bvr_camera/find_enemy_radar/radar/ship_4/lock_now",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_5 = {
										path = "bvr_camera/find_enemy_radar/radar/ship_5",
										list = {
											ship_lock = {
												path = "bvr_camera/find_enemy_radar/radar/ship_5/ship_lock",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "bvr_camera/find_enemy_radar/radar/ship_5/icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											lock_now = {
												path = "bvr_camera/find_enemy_radar/radar/ship_5/lock_now",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									ship_6 = {
										path = "bvr_camera/find_enemy_radar/radar/ship_6",
										list = {
											ship_lock = {
												path = "bvr_camera/find_enemy_radar/radar/ship_6/ship_lock",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icon = {
												path = "bvr_camera/find_enemy_radar/radar/ship_6/icon",
												list = {},
												component = {
													"UnityEngine.UI.Image"
												}
											},
											lock_now = {
												path = "bvr_camera/find_enemy_radar/radar/ship_6/lock_now",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {}
							},
							radar_1 = {
								path = "bvr_camera/find_enemy_radar/radar_1",
								list = {
									radar_1_1 = {
										path = "bvr_camera/find_enemy_radar/radar_1/radar_1_1",
										list = {},
										component = {
											"UnityEngine.RectTransform"
										}
									}
								},
								component = {}
							},
							radar_4 = {
								path = "bvr_camera/find_enemy_radar/radar_4",
								list = {
									radar_1 = {
										path = "bvr_camera/find_enemy_radar/radar_4/radar_1",
										list = {},
										component = {}
									},
									radar_1_1 = {
										path = "bvr_camera/find_enemy_radar/radar_4/radar_1/radar_1_1",
										list = {},
										component = {}
									}
								},
								component = {}
							},
							radar_2 = {
								path = "bvr_camera/find_enemy_radar/radar_2",
								list = {
									radar_1 = {
										path = "bvr_camera/find_enemy_radar/radar_2/radar_1",
										list = {
											radar_1_1 = {
												path = "bvr_camera/find_enemy_radar/radar_2/radar_1/radar_1_1",
												list = {},
												component = {}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							radar_3 = {
								path = "bvr_camera/find_enemy_radar/radar_3",
								list = {
									radar_1 = {
										path = "bvr_camera/find_enemy_radar/radar_3/radar_1",
										list = {},
										component = {}
									}
								},
								component = {}
							},
							radar_5 = {
								path = "bvr_camera/find_enemy_radar/radar_5",
								list = {
									radar_1 = {
										path = "bvr_camera/find_enemy_radar/radar_5/radar_1",
										list = {
											radar_1_1 = {
												path = "bvr_camera/find_enemy_radar/radar_5/radar_1/radar_1_1",
												list = {},
												component = {}
											}
										},
										component = {}
									}
								},
								component = {}
							}
						},
						component = {
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Camera",
					"UnityEngine.FlareLayer",
					"UnityEngine.Animation"
				}
			},
			missile_player_one = {
				path = "missile_player_one",
				list = {
					missile_1 = {
						path = "missile_player_one/missile_1",
						list = {
							trail = {
								path = "missile_player_one/missile_1/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_2 = {
						path = "missile_player_one/missile_2",
						list = {
							trail = {
								path = "missile_player_one/missile_2/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_3 = {
						path = "missile_player_one/missile_3",
						list = {
							trail = {
								path = "missile_player_one/missile_3/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_4 = {
						path = "missile_player_one/missile_4",
						list = {
							trail = {
								path = "missile_player_one/missile_4/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_5 = {
						path = "missile_player_one/missile_5",
						list = {
							trail = {
								path = "missile_player_one/missile_5/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_6 = {
						path = "missile_player_one/missile_6",
						list = {
							trail = {
								path = "missile_player_one/missile_6/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_7 = {
						path = "missile_player_one/missile_7",
						list = {
							trail = {
								path = "missile_player_one/missile_7/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_8 = {
						path = "missile_player_one/missile_8",
						list = {
							trail = {
								path = "missile_player_one/missile_8/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_9 = {
						path = "missile_player_one/missile_9",
						list = {
							trail = {
								path = "missile_player_one/missile_9/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_10 = {
						path = "missile_player_one/missile_10",
						list = {
							trail = {
								path = "missile_player_one/missile_10/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_11 = {
						path = "missile_player_one/missile_11",
						list = {
							trail = {
								path = "missile_player_one/missile_11/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_12 = {
						path = "missile_player_one/missile_12",
						list = {
							trail = {
								path = "missile_player_one/missile_12/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_13 = {
						path = "missile_player_one/missile_13",
						list = {
							trail = {
								path = "missile_player_one/missile_13/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_14 = {
						path = "missile_player_one/missile_14",
						list = {
							trail = {
								path = "missile_player_one/missile_14/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_15 = {
						path = "missile_player_one/missile_15",
						list = {
							trail = {
								path = "missile_player_one/missile_15/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_16 = {
						path = "missile_player_one/missile_16",
						list = {
							trail = {
								path = "missile_player_one/missile_16/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_17 = {
						path = "missile_player_one/missile_17",
						list = {
							trail = {
								path = "missile_player_one/missile_17/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					missile_18 = {
						path = "missile_player_one/missile_18",
						list = {
							trail = {
								path = "missile_player_one/missile_18/trail",
								list = {},
								component = {
									"UnityEngine.Transform",
									"UnityEngine.TrailRenderer"
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
					"UnityEngine.Animator"
				}
			},
			back = {
				path = "back",
				list = {
					text = {
						path = "back/text",
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
			bvr_camera_two = {
				path = "bvr_camera_two",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Camera",
					"UnityEngine.FlareLayer"
				}
			},
			intercept_attack_pro = {
				path = "intercept_attack_pro",
				list = {
					missile_player = {
						path = "intercept_attack_pro/missile_player",
						list = {
							missile_1 = {
								path = "intercept_attack_pro/missile_player/missile_1",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_1/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_2 = {
								path = "intercept_attack_pro/missile_player/missile_2",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_2/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_3 = {
								path = "intercept_attack_pro/missile_player/missile_3",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_3/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_4 = {
								path = "intercept_attack_pro/missile_player/missile_4",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_4/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_5 = {
								path = "intercept_attack_pro/missile_player/missile_5",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_5/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_6 = {
								path = "intercept_attack_pro/missile_player/missile_6",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_6/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_7 = {
								path = "intercept_attack_pro/missile_player/missile_7",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_7/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_8 = {
								path = "intercept_attack_pro/missile_player/missile_8",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_8/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_9 = {
								path = "intercept_attack_pro/missile_player/missile_9",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_9/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_10 = {
								path = "intercept_attack_pro/missile_player/missile_10",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_10/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_11 = {
								path = "intercept_attack_pro/missile_player/missile_11",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_11/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_12 = {
								path = "intercept_attack_pro/missile_player/missile_12",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_12/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_13 = {
								path = "intercept_attack_pro/missile_player/missile_13",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_13/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_14 = {
								path = "intercept_attack_pro/missile_player/missile_14",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_14/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_15 = {
								path = "intercept_attack_pro/missile_player/missile_15",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_15/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_16 = {
								path = "intercept_attack_pro/missile_player/missile_16",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_16/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_17 = {
								path = "intercept_attack_pro/missile_player/missile_17",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_17/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							missile_18 = {
								path = "intercept_attack_pro/missile_player/missile_18",
								list = {
									trail = {
										path = "intercept_attack_pro/missile_player/missile_18/trail",
										list = {},
										component = {
											"UnityEngine.Transform",
											"UnityEngine.TrailRenderer"
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
					enemy_intercept_ships = {
						path = "intercept_attack_pro/enemy_intercept_ships",
						list = {
							missile_player_intercepted_ani = {
								path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani",
								list = {
									missile_1 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_1",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_1/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_1/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_2 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_2",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_2/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_2/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_3 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_3",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_3/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_3/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_4 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_4",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_4/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_4/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_5 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_5",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_5/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_5/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_6 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_6",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_6/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_6/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_7 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_7",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_7/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_7/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_8 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_8",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_8/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_8/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_9 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_9",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_9/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_9/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_10 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_10",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_10/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_10/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_11 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_11",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_11/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_11/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_12 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_12",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_12/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_12/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_13 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_13",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_13/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_13/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_14 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_14",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_14/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_14/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_15 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_15",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_15/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_15/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_16 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_16",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_16/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_16/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_17 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_17",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_17/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_17/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
												}
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									missile_18 = {
										path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_18",
										list = {
											halo = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_18/halo",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											trail = {
												path = "intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_18/trail",
												list = {},
												component = {
													"UnityEngine.Transform",
													"UnityEngine.TrailRenderer"
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
							enemy_ship_1 = {
								path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1",
								list = {
									ship_icon = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/ship_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									aim = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/aim",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									change = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/change",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp",
										list = {
											hp_bg = {
												path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp/hp_bg",
												list = {
													hp_1 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp/hp_bg/hp_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													hp_2 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp/hp_bg/hp_2",
														list = {},
														component = {
															"UnityEngine.UI.Image",
															"UIFillAmountChangeEffect"
														}
													}
												},
												component = {}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_2 = {
								path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2",
								list = {
									ship_icon = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/ship_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									aim = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/aim",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									change = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/change",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp",
										list = {
											hp_bg = {
												path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp/hp_bg",
												list = {
													hp_1 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp/hp_bg/hp_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													hp_2 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp/hp_bg/hp_2",
														list = {},
														component = {
															"UnityEngine.UI.Image",
															"UIFillAmountChangeEffect"
														}
													}
												},
												component = {}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_3 = {
								path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3",
								list = {
									ship_icon = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/ship_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									aim = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/aim",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									change = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/change",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp",
										list = {
											hp_bg = {
												path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp/hp_bg",
												list = {
													hp_1 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp/hp_bg/hp_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													hp_2 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp/hp_bg/hp_2",
														list = {},
														component = {
															"UnityEngine.UI.Image",
															"UIFillAmountChangeEffect"
														}
													}
												},
												component = {}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_4 = {
								path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4",
								list = {
									ship_icon = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/ship_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									aim = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/aim",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									change = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/change",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp",
										list = {
											hp_bg = {
												path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp/hp_bg",
												list = {
													hp_1 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp/hp_bg/hp_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													hp_2 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp/hp_bg/hp_2",
														list = {},
														component = {
															"UnityEngine.UI.Image",
															"UIFillAmountChangeEffect"
														}
													}
												},
												component = {}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_5 = {
								path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5",
								list = {
									ship_icon = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/ship_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									aim = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/aim",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									change = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/change",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp",
										list = {
											hp_bg = {
												path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp/hp_bg",
												list = {
													hp_1 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp/hp_bg/hp_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													hp_2 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp/hp_bg/hp_2",
														list = {},
														component = {
															"UnityEngine.UI.Image",
															"UIFillAmountChangeEffect"
														}
													}
												},
												component = {}
											}
										},
										component = {}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer"
								}
							},
							enemy_ship_6 = {
								path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6",
								list = {
									ship_icon = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/ship_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									aim = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/aim",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									change = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/change",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									halo = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/halo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									hp = {
										path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp",
										list = {
											hp_bg = {
												path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp/hp_bg",
												list = {
													hp_1 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp/hp_bg/hp_1",
														list = {},
														component = {
															"UnityEngine.UI.Image"
														}
													},
													hp_2 = {
														path = "intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp/hp_bg/hp_2",
														list = {},
														component = {
															"UnityEngine.UI.Image",
															"UIFillAmountChangeEffect"
														}
													}
												},
												component = {}
											}
										},
										component = {}
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
							"UnityEngine.Animation"
						}
					}
				},
				component = {
					"UnityEngine.CanvasRenderer"
				}
			},
			back_btn = {
				path = "back_btn",
				list = {
					text = {
						path = "back_btn/text",
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
		call_node_list = {
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_1/hp_color_bg/hp_color_1"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_1.hp_color_bg.hp_color_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_3/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_3.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_2/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_2.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_2/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_2.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_1/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_1.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_1/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_1.attacking",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_11"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_11",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_1"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_9"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_9",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_3/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_3.attacking",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_1/halo"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_1.halo",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_5/hp"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_5.hp",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_icon"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_2/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_2.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_2/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_2.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_2"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_1/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_1.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_1/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_1.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_1"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_icon"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/header/header_color"] = "_control.bvr_camera.player_bvr_list.attack_header_2.header.header_color",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.hp",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/header/header_img"] = "_control.bvr_camera.player_bvr_list.attack_header_2.header.header_img",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/header/header_bg"] = "_control.bvr_camera.player_bvr_list.attack_header_2.header.header_bg",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_1"] = "_control.intercept_attack_pro.missile_player.missile_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_3/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_3.attackend",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_1/halo"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_1.halo",
			["bvr_info_pro/player_ship_team/player_ship_5/change"] = "_control.player_ship_team.player_ship_5.change",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_3/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_3.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_3"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_3",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp/hp_bg"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.hp.hp_bg",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_2/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_2.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_2"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_1/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_1.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_1/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_1.attacking",
			["bvr_info_pro/player_ship_team/player_ship_6/ship_icon"] = "_control.player_ship_team.player_ship_6.ship_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_1"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_icon"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/header/header_color"] = "_control.bvr_camera.player_bvr_list.attack_header_3.header.header_color",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/header/header_img"] = "_control.bvr_camera.player_bvr_list.attack_header_3.header.header_img",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_1"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/header/header_bg"] = "_control.bvr_camera.player_bvr_list.attack_header_3.header.header_bg",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/header"] = "_control.bvr_camera.player_bvr_list.attack_header_3.header",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_3"] = "_control.bvr_camera.find_enemy_radar.radar_3",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_3/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_3.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_3/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_3.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_3"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_3",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_1/hp"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_1.hp",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_2/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_2.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_2/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_2.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_2"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_1/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_1.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info/missile_1/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info.missile_1.attacking",
			["bvr_info_pro/intercept_attack_pro"] = "_control.intercept_attack_pro",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_icon"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile",
			["bvr_info_pro/player_ship_team/light"] = "_control.player_ship_team.light",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/header/header_img"] = "_control.bvr_camera.player_bvr_list.attack_header_4.header.header_img",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/header/header_bg"] = "_control.bvr_camera.player_bvr_list.attack_header_4.header.header_bg",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_18/missile_shape"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_18.missile_shape",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_10/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_10.halo",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_3"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_3",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_2/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_2.attackend",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_7/missile_shape/trail"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_7.missile_shape.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_2"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_1.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_1/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_1.attacking",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_16"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_16",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal"] = "_control.player_ship_team.player_ship_6.missile_arsenal",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_icon"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/header/header_color"] = "_control.bvr_camera.player_bvr_list.attack_header_5.header.header_color",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_3"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_3",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/header/header_img"] = "_control.bvr_camera.player_bvr_list.attack_header_5.header.header_img",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/header/header_bg"] = "_control.bvr_camera.player_bvr_list.attack_header_5.header.header_bg",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/header"] = "_control.bvr_camera.player_bvr_list.attack_header_5.header",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_3/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_3.attackend",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_3/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_3.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_2/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_2.attackend",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_2/hp_color_bg/hp_color_2"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_2.hp_color_bg.hp_color_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_2/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_2.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/header"] = "_control.bvr_camera.player_bvr_list.attack_header_4.header",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_1/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_1.attacking",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_2/success"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_2.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_3.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/header/header_color"] = "_control.bvr_camera.player_bvr_list.attack_header_6.header.header_color",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1"] = "_control.intercpet_attack_video.bg.enemy_ship_1",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_18/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_18.trail",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_17/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_17.trail",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_16/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_16.trail",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_15/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_15.trail",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_14/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_14.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships"] = "_control.intercept_attack_pro.enemy_intercept_ships",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_2/success"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_2.success",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_12/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_12.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_2/success"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_2.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_3/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_3.halo",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_17"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_17",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_3"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_3",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp/hp_bg/hp_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.hp.hp_bg.hp_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_4"] = "_control.bvr_camera.find_enemy_radar.radar.ship_4",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_3.trail",
			["bvr_info_pro/missile_player_one/missile_2"] = "_control.missile_player_one.missile_2",
			["bvr_info_pro/bvr_camera/transition_2/transition_child"] = "_control.bvr_camera.transition_2.transition_child",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_12"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_12",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_6/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_6.trail",
			["bvr_info_pro/back_btn"] = "_control.back_btn",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_4/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_4.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_3.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_2/halo"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_2.halo",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_2/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_3.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_10/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_10.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_3/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_3.halo",
			["bvr_info_pro/intercpet_attack_video/bg"] = "_control.intercpet_attack_video.bg",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_2/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_2.halo",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_1.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_3/success"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_3.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_2/success"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_2.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/header"] = "_control.bvr_camera.player_bvr_list.attack_header_1.header",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_1/success"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_1.success",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2"] = "_control.bvr_camera.player_bvr_list.attack_header_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2"] = "_control.enemy_ship_team.enemy_ship_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_3/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_3.halo",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_1/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_1.halo",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_1",
			["bvr_info_pro/missile_player_one/missile_6"] = "_control.missile_player_one.missile_6",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_3/success"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_3.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_3.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_7"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_7",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_2",
			["bvr_info_pro/player_ship_team/player_ship_1"] = "_control.player_ship_team.player_ship_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_3.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6"] = "_control.bvr_camera.player_bvr_list.attack_header_6",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_2/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_2.halo",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_1/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_1.halo",
			["bvr_info_pro/missile_player_one/missile_17"] = "_control.missile_player_one.missile_17",
			["bvr_info_pro/player_ship_team/radar/radar_inside/radar_wave"] = "_control.player_ship_team.radar.radar_inside.radar_wave",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_3/success"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_3.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_2/success"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_2.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4"] = "_control.intercpet_attack_video.bg.enemy_ship_4",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_2"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_1/success"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_1.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_15/missile_shape"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_15.missile_shape",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_10/missile_shape/trail"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_10.missile_shape.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_3/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_3.halo",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_2/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_2.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/aim"] = "_control.enemy_ship_team.enemy_ship_1.aim",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_intercept/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_3.missile_intercept.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_1/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_1.halo",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_4/missile_shape"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_4.missile_shape",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_intercept/missile_3"] = "_control.enemy_ship_team.enemy_ship_2.missile_intercept.missile_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_1"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_2/success"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_2.success",
			["bvr_info_pro/player_ship_team"] = "_control.player_ship_team",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_15"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_15",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_1/success"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_1.success",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_1/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_1.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_6"] = "_control.intercept_attack_pro.missile_player.missile_6",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_2/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_2.halo",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_7"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_7",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_1"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_16"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_16",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_3/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_1/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_1.halo",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_9/missile_shape"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_9.missile_shape",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_1",
			["bvr_info_pro/back/text"] = "_control.back.text",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_intercept/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_2.missile_intercept.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_intercept/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_2.missile_intercept.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_2",
			["bvr_info_pro/player_ship_team/player_ship_4"] = "_control.player_ship_team.player_ship_4",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/aim"] = "_control.enemy_ship_team.enemy_ship_2.aim",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_1"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_intercept/missile_3/success"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_intercept.missile_3.success",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/change"] = "_control.enemy_ship_team.enemy_ship_1.change",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_2.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_1/hp_color_bg"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_1.hp_color_bg",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_8/missile_shape"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_8.missile_shape",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_16/missile_shape/trail"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_16.missile_shape.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_intercept/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_2.missile_intercept.missile_3.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_13"] = "_control.intercept_attack_pro.missile_player.missile_13",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_1"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_4/radar_1"] = "_control.bvr_camera.find_enemy_radar.radar_4.radar_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/aim"] = "_control.enemy_ship_team.enemy_ship_4.aim",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/halo"] = "_control.enemy_ship_team.enemy_ship_1.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_intercept/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_1.missile_intercept.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_1",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_14/missile_shape"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_14.missile_shape",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/ship_icon"] = "_control.enemy_ship_team.enemy_ship_1.ship_icon",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_intercept/missile_3"] = "_control.enemy_ship_team.enemy_ship_1.missile_intercept.missile_3",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_16/missile_shape"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_16.missile_shape",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_2/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_2.attacking",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_2"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_intercept/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_intercept.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_intercept/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_1.missile_intercept.missile_1.trail",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_17/missile_shape/trail"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_17.missile_shape.trail",
			["bvr_info_pro/enemy_ship_team/find_ani"] = "_control.enemy_ship_team.find_ani",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_12"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_12",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1"] = "_control.enemy_ship_team.enemy_ship_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3"] = "_control.intercpet_attack_video.bg.enemy_ship_3",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_12/missile_shape"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_12.missile_shape",
			["bvr_info_pro/player_ship_team/player_ship_6/change"] = "_control.player_ship_team.player_ship_6.change",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_8"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_8",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_13/missile_shape"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_13.missile_shape",
			["bvr_info_pro/player_ship_team/player_ship_3"] = "_control.player_ship_team.player_ship_3",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_15/missile_shape/trail"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_15.missile_shape.trail",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_14/missile_shape/trail"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_14.missile_shape.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_3/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_3.halo",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_13"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_13",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_2/missile_shape/trail"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_2.missile_shape.trail",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_10"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_10",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_intercept/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_6.missile_intercept.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_1/success"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_1.success",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal"] = "_control.player_ship_team.player_ship_2.missile_arsenal",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_11/missile_shape/trail"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_11.missile_shape.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/header/header_bg"] = "_control.bvr_camera.player_bvr_list.attack_header_6.header.header_bg",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_2"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_2",
			["bvr_info_pro/player_ship_team/player_ship_5/ship_icon"] = "_control.player_ship_team.player_ship_5.ship_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_3/missile_shape/trail"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_3.missile_shape.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_1/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_1.halo",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_2/missile_shape"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_2.missile_shape",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_intercept/missile_2"] = "_control.enemy_ship_team.enemy_ship_2.missile_intercept.missile_2",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_1/missile_shape/trail"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_1.missile_shape.trail",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_11/missile_shape"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_11.missile_shape",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_3/missile_shape"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_3.missile_shape",
			["bvr_info_pro/player_ship_team/player_ship_1/ship_icon"] = "_control.player_ship_team.player_ship_1.ship_icon",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_intercept"] = "_control.enemy_ship_team.enemy_ship_2.missile_intercept",
			["bvr_info_pro/player_ship_team/player_ship_3/ship_icon"] = "_control.player_ship_team.player_ship_3.ship_icon",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_intercept/missile_1"] = "_control.enemy_ship_team.enemy_ship_1.missile_intercept.missile_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_intercept/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_5.missile_intercept.missile_2.trail",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal"] = "_control.player_ship_team.player_ship_3.missile_arsenal",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_5/missile_shape/trail"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_5.missile_shape.trail",
			["bvr_info_pro/bvr_camera/sea_info/player"] = "_control.bvr_camera.sea_info.player",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_intercept/missile_1"] = "_control.enemy_ship_team.enemy_ship_2.missile_intercept.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_intercept/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_intercept.missile_1.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_2"] = "_control.intercept_attack_pro.missile_player.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5"] = "_control.enemy_ship_team.enemy_ship_5",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_6/missile_shape/trail"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_6.missile_shape.trail",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_7/missile_shape"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_7.missile_shape",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_3/halo"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_3.halo",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_10/missile_shape"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_10.missile_shape",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_2/halo"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_2.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_intercept"] = "_control.enemy_ship_team.enemy_ship_1.missile_intercept",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_9/missile_shape/trail"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_9.missile_shape.trail",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_17"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_17",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_3",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_1/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_1.attackend",
			["bvr_info_pro/player_ship_team/player_ship_2/ship_icon"] = "_control.player_ship_team.player_ship_2.ship_icon",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_intercept/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_4.missile_intercept.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_1.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/aim"] = "_control.enemy_ship_team.enemy_ship_6.aim",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_intercept/missile_1"] = "_control.enemy_ship_team.enemy_ship_4.missile_intercept.missile_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_intercept/missile_1"] = "_control.enemy_ship_team.enemy_ship_6.missile_intercept.missile_1",
			["bvr_info_pro/player_ship_team/radar/radar_inside"] = "_control.player_ship_team.radar.radar_inside",
			["bvr_info_pro/player_ship_team/player_ship_4/change"] = "_control.player_ship_team.player_ship_4.change",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/change"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.change",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal"] = "_control.player_ship_team.player_ship_5.missile_arsenal",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_3/success"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_3.success",
			["bvr_info_pro/bvr_camera/transition_1/transition_child"] = "_control.bvr_camera.transition_1.transition_child",
			["bvr_info_pro/player_ship_team/player_ship_1/change"] = "_control.player_ship_team.player_ship_1.change",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_2"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_2.trail",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_11/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_11.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_3"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_3.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_intercept/missile_2"] = "_control.enemy_ship_team.enemy_ship_3.missile_intercept.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/ship_icon"] = "_control.enemy_ship_team.enemy_ship_3.ship_icon",
			["bvr_info_pro/player_ship_team/player_ship_5"] = "_control.player_ship_team.player_ship_5",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/aim"] = "_control.enemy_ship_team.enemy_ship_3.aim",
			["bvr_info_pro/bvr_camera/waring"] = "_control.bvr_camera.waring",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/change"] = "_control.enemy_ship_team.enemy_ship_3.change",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_3/missile_player_attack/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_3.missile_player_attack.missile_3.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/halo"] = "_control.enemy_ship_team.enemy_ship_3.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_17"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_17",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_intercept/missile_1"] = "_control.enemy_ship_team.enemy_ship_3.missile_intercept.missile_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_intercept/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_3.missile_intercept.missile_1.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_1/halo"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_1.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_intercept/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_3.missile_intercept.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_intercept/missile_3"] = "_control.enemy_ship_team.enemy_ship_3.missile_intercept.missile_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_1"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_2"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_2",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_1/hp_color_bg/hp_color_2"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_1.hp_color_bg.hp_color_2",
			["bvr_info_pro/missile_player_one/missile_12"] = "_control.missile_player_one.missile_12",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_1/missile_shape"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_1.missile_shape",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_3"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack/missile_2/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack.missile_2.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_3/halo"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_3.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_3.trail",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_13/missile_shape/trail"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_13.missile_shape.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/ship_icon"] = "_control.enemy_ship_team.enemy_ship_4.ship_icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_3"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/change"] = "_control.enemy_ship_team.enemy_ship_4.change",
			["bvr_info_pro/bvr_camera/sea_info/enemy"] = "_control.bvr_camera.sea_info.enemy",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_intercept"] = "_control.enemy_ship_team.enemy_ship_4.missile_intercept",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_intercept/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_4.missile_intercept.missile_1.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_intercept/missile_2"] = "_control.enemy_ship_team.enemy_ship_4.missile_intercept.missile_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_1"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp/hp_bg/hp_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.hp.hp_bg.hp_2",
			["bvr_info_pro/bg"] = "_control.bg",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_intercept/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_4.missile_intercept.missile_3.trail",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_8/missile_shape/trail"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_8.missile_shape.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_1.trail",
			["bvr_info_pro/bvr_camera/sea_info"] = "_control.bvr_camera.sea_info",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_2"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_2",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_17/missile_shape"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_17.missile_shape",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_2.trail",
			["bvr_info_pro/bvr_camera/find_enemy_radar/mask"] = "_control.bvr_camera.find_enemy_radar.mask",
			["bvr_info_pro/missile_player_one/missile_7"] = "_control.missile_player_one.missile_7",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_5"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_5",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_3/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_3.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/aim"] = "_control.enemy_ship_team.enemy_ship_5.aim",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/change"] = "_control.enemy_ship_team.enemy_ship_5.change",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_intercept"] = "_control.enemy_ship_team.enemy_ship_5.missile_intercept",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_intercept/missile_1"] = "_control.enemy_ship_team.enemy_ship_5.missile_intercept.missile_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_intercept/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_5.missile_intercept.missile_1.trail",
			["bvr_info_pro/missile_player_one/missile_14"] = "_control.missile_player_one.missile_14",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_2"] = "_control.bvr_camera.find_enemy_radar.radar_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_intercept/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_5.missile_intercept.missile_3.trail",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar"] = "_control.bvr_camera.find_enemy_radar.radar",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_1"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_1",
			["bvr_info_pro/player_ship_team/player_ship_2/change"] = "_control.player_ship_team.player_ship_2.change",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_2"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_2/halo"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_2.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_intercept/missile_2"] = "_control.enemy_ship_team.enemy_ship_6.missile_intercept.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_3"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_3/halo"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_3.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/ship_icon"] = "_control.enemy_ship_team.enemy_ship_6.ship_icon",
			["bvr_info_pro/player_ship_team/player_ship_4/ship_icon"] = "_control.player_ship_team.player_ship_4.ship_icon",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/change"] = "_control.enemy_ship_team.enemy_ship_6.change",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/halo"] = "_control.enemy_ship_team.enemy_ship_6.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_intercept/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_6.missile_intercept.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_intercept/missile_3"] = "_control.enemy_ship_team.enemy_ship_6.missile_intercept.missile_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_intercept/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_6.missile_intercept.missile_3.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_3/halo"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_3.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_1"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_4/radar_1/radar_1_1"] = "_control.bvr_camera.find_enemy_radar.radar_4.radar_1_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_1.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_1.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3"] = "_control.enemy_ship_team.enemy_ship_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_2"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_2/halo"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_2.halo",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_2.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_3"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_3",
			["bvr_info_pro/enemy_ship_team/radar_reflect"] = "_control.enemy_ship_team.radar_reflect",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_3/halo"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_3.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/halo"] = "_control.enemy_ship_team.enemy_ship_5.halo",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1"] = "_control.bvr_camera.player_bvr_list.attack_header_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/halo"] = "_control.enemy_ship_team.enemy_ship_4.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/ship_icon"] = "_control.enemy_ship_team.enemy_ship_5.ship_icon",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_2.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_8"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_8",
			["bvr_info_pro/missile_player_one/missile_10"] = "_control.missile_player_one.missile_10",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_5/missile_shape"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_5.missile_shape",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_3/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_3.attackend",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_2/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_2.halo",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_2.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_5"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_5",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_1"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_1/success"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_1.success",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_18"] = "_control.intercept_attack_pro.missile_player.missile_18",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_3/hp"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_3.hp",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_3/hp_color_bg"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_3.hp_color_bg",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_3/hp_color_bg/hp_color_1"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_3.hp_color_bg.hp_color_1",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_3/hp_color_bg/hp_color_2"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_3.hp_color_bg.hp_color_2",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_4/hp_color_bg"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_4.hp_color_bg",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_4/hp_color_bg/hp_color_1"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_4.hp_color_bg.hp_color_1",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_4/hp_color_bg/hp_color_2"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_4.hp_color_bg.hp_color_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5"] = "_control.bvr_camera.player_bvr_list.attack_header_5",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_3"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_3",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/missile/missile_use_info/missile_3"] = "_control.bvr_camera.player_bvr_list.attack_header_2.missile.missile_use_info.missile_3",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_5/hp_color_bg"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_5.hp_color_bg",
			["bvr_info_pro/player_ship_team/player_ship_3/change"] = "_control.player_ship_team.player_ship_3.change",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_2/halo"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_2.halo",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_5/hp_color_bg/hp_color_1"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_5.hp_color_bg.hp_color_1",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_10/trail"] = "_control.intercept_attack_pro.missile_player.missile_10.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_6"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_6",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_6/hp_color_bg"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_6.hp_color_bg",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_6/hp_color_bg/hp_color_1"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_6.hp_color_bg.hp_color_1",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_6/hp_color_bg/hp_color_2"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_6.hp_color_bg.hp_color_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_2/halo"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_2.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_3"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_3",
			["bvr_info_pro/bvr_camera/find_enemy_radar/mask/wave_mask"] = "_control.bvr_camera.find_enemy_radar.mask.wave_mask",
			["bvr_info_pro/bvr_camera/find_enemy_radar/mask/radar_scan"] = "_control.bvr_camera.find_enemy_radar.mask.radar_scan",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_14"] = "_control.intercept_attack_pro.missile_player.missile_14",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_1/lock_now"] = "_control.bvr_camera.find_enemy_radar.radar.ship_1.lock_now",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_2/ship_lock"] = "_control.bvr_camera.find_enemy_radar.radar.ship_2.ship_lock",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_2/icon"] = "_control.bvr_camera.find_enemy_radar.radar.ship_2.icon",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_2/lock_now"] = "_control.bvr_camera.find_enemy_radar.radar.ship_2.lock_now",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_3/ship_lock"] = "_control.bvr_camera.find_enemy_radar.radar.ship_3.ship_lock",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_3/icon"] = "_control.bvr_camera.find_enemy_radar.radar.ship_3.icon",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_3/lock_now"] = "_control.bvr_camera.find_enemy_radar.radar.ship_3.lock_now",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_8/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_8.trail",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_4/ship_lock"] = "_control.bvr_camera.find_enemy_radar.radar.ship_4.ship_lock",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_4/icon"] = "_control.bvr_camera.find_enemy_radar.radar.ship_4.icon",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_4/lock_now"] = "_control.bvr_camera.find_enemy_radar.radar.ship_4.lock_now",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar"] = "_control.intercpet_attack_video.bg.missile_player_radar",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_5/ship_lock"] = "_control.bvr_camera.find_enemy_radar.radar.ship_5.ship_lock",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_5/icon"] = "_control.bvr_camera.find_enemy_radar.radar.ship_5.icon",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/header/header_img"] = "_control.bvr_camera.player_bvr_list.attack_header_1.header.header_img",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_5/lock_now"] = "_control.bvr_camera.find_enemy_radar.radar.ship_5.lock_now",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_6/ship_lock"] = "_control.bvr_camera.find_enemy_radar.radar.ship_6.ship_lock",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_6/icon"] = "_control.bvr_camera.find_enemy_radar.radar.ship_6.icon",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_6/lock_now"] = "_control.bvr_camera.find_enemy_radar.radar.ship_6.lock_now",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_1"] = "_control.bvr_camera.find_enemy_radar.radar_1",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_intercept/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_1.missile_intercept.missile_3.trail",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_18/missile_shape/trail"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_18.missile_shape.trail",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_4"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_4",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_10"] = "_control.intercept_attack_pro.missile_player.missile_10",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_2/radar_1"] = "_control.bvr_camera.find_enemy_radar.radar_2.radar_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_2/radar_1/radar_1_1"] = "_control.bvr_camera.find_enemy_radar.radar_2.radar_1.radar_1_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_3/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_3.attackend",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_3/radar_1"] = "_control.bvr_camera.find_enemy_radar.radar_3.radar_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_3"] = "_control.bvr_camera.find_enemy_radar.radar.ship_3",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_1/radar_1_1"] = "_control.bvr_camera.find_enemy_radar.radar_1.radar_1_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_5/radar_1"] = "_control.bvr_camera.find_enemy_radar.radar_5.radar_1",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_5/radar_1/radar_1_1"] = "_control.bvr_camera.find_enemy_radar.radar_5.radar_1.radar_1_1",
			["bvr_info_pro/missile_player_one/missile_1"] = "_control.missile_player_one.missile_1",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_7/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_7.trail",
			["bvr_info_pro/missile_player_one/missile_2/trail"] = "_control.missile_player_one.missile_2.trail",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_1/icon"] = "_control.bvr_camera.find_enemy_radar.radar.ship_1.icon",
			["bvr_info_pro/missile_player_one/missile_3"] = "_control.missile_player_one.missile_3",
			["bvr_info_pro/missile_player_one/missile_3/trail"] = "_control.missile_player_one.missile_3.trail",
			["bvr_info_pro/missile_player_one/missile_4/trail"] = "_control.missile_player_one.missile_4.trail",
			["bvr_info_pro/missile_player_one/missile_5/trail"] = "_control.missile_player_one.missile_5.trail",
			["bvr_info_pro/bvr_camera/transition_1"] = "_control.bvr_camera.transition_1",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_player_attack"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_player_attack",
			["bvr_info_pro/missile_player_one/missile_6/trail"] = "_control.missile_player_one.missile_6.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/header/header_color"] = "_control.bvr_camera.player_bvr_list.attack_header_4.header.header_color",
			["bvr_info_pro/missile_player_one/missile_7/trail"] = "_control.missile_player_one.missile_7.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_13"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_13",
			["bvr_info_pro/missile_player_one/missile_8/trail"] = "_control.missile_player_one.missile_8.trail",
			["bvr_info_pro/missile_player_one/missile_9/trail"] = "_control.missile_player_one.missile_9.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_3/success"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_3.success",
			["bvr_info_pro/missile_player_one/missile_10/trail"] = "_control.missile_player_one.missile_10.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_6/hp"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_6.hp",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_7"] = "_control.intercept_attack_pro.missile_player.missile_7",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_1.trail",
			["bvr_info_pro/missile_player_one/missile_12/trail"] = "_control.missile_player_one.missile_12.trail",
			["bvr_info_pro/missile_player_one/missile_13/trail"] = "_control.missile_player_one.missile_13.trail",
			["bvr_info_pro/player_ship_team/radar"] = "_control.player_ship_team.radar",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_intercept/missile_2"] = "_control.enemy_ship_team.enemy_ship_5.missile_intercept.missile_2",
			["bvr_info_pro/missile_player_one/missile_14/trail"] = "_control.missile_player_one.missile_14.trail",
			["bvr_info_pro/missile_player_one/missile_15"] = "_control.missile_player_one.missile_15",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_13"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_13",
			["bvr_info_pro/missile_player_one/missile_15/trail"] = "_control.missile_player_one.missile_15.trail",
			["bvr_info_pro/missile_player_one/missile_16/trail"] = "_control.missile_player_one.missile_16.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_4/missile_player_attack/missile_1"] = "_control.intercpet_attack_video.bg.enemy_ship_4.missile_player_attack.missile_1",
			["bvr_info_pro/missile_player_one/missile_17/trail"] = "_control.missile_player_one.missile_17.trail",
			["bvr_info_pro/missile_player_one/missile_18"] = "_control.missile_player_one.missile_18",
			["bvr_info_pro/missile_player_one/missile_18/trail"] = "_control.missile_player_one.missile_18.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack",
			["bvr_info_pro/bvr_camera_two"] = "_control.bvr_camera_two",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4/missile/missile_use_info"] = "_control.bvr_camera.player_bvr_list.attack_header_4.missile.missile_use_info",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_2/header"] = "_control.bvr_camera.player_bvr_list.attack_header_2.header",
			["bvr_info_pro/bvr_camera/transition_2"] = "_control.bvr_camera.transition_2",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/header"] = "_control.bvr_camera.player_bvr_list.attack_header_6.header",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_2/trail"] = "_control.intercept_attack_pro.missile_player.missile_2.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_1"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_1",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_3"] = "_control.intercept_attack_pro.missile_player.missile_3",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.hp",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_4/trail"] = "_control.intercept_attack_pro.missile_player.missile_4.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_5/trail"] = "_control.intercept_attack_pro.missile_player.missile_5.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_4/hp"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_4.hp",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_3/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_3.halo",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_6/trail"] = "_control.intercept_attack_pro.missile_player.missile_6.trail",
			["bvr_info_pro/missile_player_one/missile_11/trail"] = "_control.missile_player_one.missile_11.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_7/trail"] = "_control.intercept_attack_pro.missile_player.missile_7.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_8/trail"] = "_control.intercept_attack_pro.missile_player.missile_8.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_1/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_1.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_intercept/missile_3"] = "_control.enemy_ship_team.enemy_ship_5.missile_intercept.missile_3",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_5/hp_color_bg/hp_color_2"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_5.hp_color_bg.hp_color_2",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_11"] = "_control.intercept_attack_pro.missile_player.missile_11",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_11/trail"] = "_control.intercept_attack_pro.missile_player.missile_11.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_12"] = "_control.intercept_attack_pro.missile_player.missile_12",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_12/trail"] = "_control.intercept_attack_pro.missile_player.missile_12.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_1/trail"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_1.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_13/trail"] = "_control.intercept_attack_pro.missile_player.missile_13.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack",
			["bvr_info_pro/enemy_ship_team"] = "_control.enemy_ship_team",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_14/trail"] = "_control.intercept_attack_pro.missile_player.missile_14.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_15"] = "_control.intercept_attack_pro.missile_player.missile_15",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_15/trail"] = "_control.intercept_attack_pro.missile_player.missile_15.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_16/trail"] = "_control.intercept_attack_pro.missile_player.missile_16.trail",
			["bvr_info_pro/player_ship_team/band_1"] = "_control.player_ship_team.band_1",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_17"] = "_control.intercept_attack_pro.missile_player.missile_17",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_17/trail"] = "_control.intercept_attack_pro.missile_player.missile_17.trail",
			["bvr_info_pro/bvr_camera/find_enemy_radar/mask/wave_mask/wave"] = "_control.bvr_camera.find_enemy_radar.mask.wave_mask.wave",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_intercept/missile_2"] = "_control.enemy_ship_team.enemy_ship_1.missile_intercept.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept/missile_2/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept.missile_2.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_18/trail"] = "_control.intercept_attack_pro.missile_player.missile_18.trail",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_13/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_13.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.hp",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_9/trail"] = "_control.intercept_attack_pro.missile_player.missile_9.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_3/halo"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_3.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_2/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_2.halo",
			["bvr_info_pro/player_ship_team/player_ship_6/missile_arsenal/missile_18"] = "_control.player_ship_team.player_ship_6.missile_arsenal.missile_18",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_2/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_2.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_3/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_3.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_3/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_3.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_4"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_4",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_4/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_4.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_4/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_4.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_5/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_5.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_5/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_5.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_6/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_6.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_6/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_6.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5/missile_intercept/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_5.missile_intercept.missile_3",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_18"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_18",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_7/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_7.trail",
			["bvr_info_pro/bvr_camera/shadow"] = "_control.bvr_camera.shadow",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_icon"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_icon",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_8/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_8.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_8/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_8.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_2/hp"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_2.hp",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_9"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_9",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_9/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_9.halo",
			["bvr_info_pro/player_ship_team/player_ship_2"] = "_control.player_ship_team.player_ship_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_9/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_9.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_5/missile/missile_use_info/missile_3/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_5.missile.missile_use_info.missile_3.attacking",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_3",
			["bvr_info_pro/missile_player_one/missile_13"] = "_control.missile_player_one.missile_13",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/header/header_img"] = "_control.bvr_camera.player_bvr_list.attack_header_6.header.header_img",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_11/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_11.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_11/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_11.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_12/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_12.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_12/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_12.trail",
			["bvr_info_pro/missile_player_one/missile_8"] = "_control.missile_player_one.missile_8",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_13/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_13.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_13/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_13.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2"] = "_control.intercpet_attack_video.bg.enemy_ship_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_14/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_14.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_14/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_14.trail",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_14"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_14",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_15"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_15",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_15/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_15.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_15/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_15.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_player_attack/missile_1/trail"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_player_attack.missile_1.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_16/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_16.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_intercept"] = "_control.enemy_ship_team.enemy_ship_3.missile_intercept",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_8"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_8",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_17/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_17.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_17/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_17.trail",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_7/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_7.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_18/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_18.halo",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_4"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_4",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_18/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_18.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_4"] = "_control.bvr_camera.player_bvr_list.attack_header_4",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/ship_icon"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.ship_icon",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal"] = "_control.player_ship_team.player_ship_4.missile_arsenal",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_16/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_16.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/hp"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.hp",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3/missile/missile_use_info/missile_2/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_3.missile.missile_use_info.missile_2.attackend",
			["bvr_info_pro/player_ship_team/player_ship_6"] = "_control.player_ship_team.player_ship_6",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_9/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_9.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_intercept/missile_3"] = "_control.enemy_ship_team.enemy_ship_4.missile_intercept.missile_3",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/ship_icon"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.ship_icon",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/aim"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.aim",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/change"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.change",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.hp",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp/hp_bg"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.hp.hp_bg",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp/hp_bg/hp_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.hp.hp_bg.hp_1",
			["bvr_info_pro/enemy_ship_team/light"] = "_control.enemy_ship_team.light",
			["bvr_info_pro/missile_player_one"] = "_control.missile_player_one",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2/hp/hp_bg/hp_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.hp.hp_bg.hp_2",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6"] = "_control.intercpet_attack_video.bg.enemy_ship_6",
			["bvr_info_pro/missile_player_one/missile_4"] = "_control.missile_player_one.missile_4",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_1/halo"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_1.halo",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_10"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_10",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_5"] = "_control.bvr_camera.find_enemy_radar.radar_5",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_5"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_5",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/ship_icon"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.ship_icon",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/aim"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.aim",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/change"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.change",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_1/trail"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_1.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp/hp_bg/hp_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.hp.hp_bg.hp_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp/hp_bg/hp_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.hp.hp_bg.hp_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_3.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/ship_icon"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.ship_icon",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/aim"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.aim",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/change"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.change",
			["bvr_info_pro/bvr_camera/find_enemy_radar"] = "_control.bvr_camera.find_enemy_radar",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp/hp_bg"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.hp.hp_bg",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/radar_reflect"] = "_control.bvr_camera.find_enemy_radar.radar.radar_reflect",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp/hp_bg/hp_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.hp.hp_bg.hp_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_4/hp/hp_bg/hp_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.hp.hp_bg.hp_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp/hp_bg"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.hp.hp_bg",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/ship_icon"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.ship_icon",
			["bvr_info_pro/missile_player_one/missile_11"] = "_control.missile_player_one.missile_11",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_4"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_4",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_1"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/aim"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.aim",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/change"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.change",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_3/missile_player_attack/missile_1/halo"] = "_control.enemy_ship_team.enemy_ship_3.missile_player_attack.missile_1.halo",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp/hp_bg"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.hp.hp_bg",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp/hp_bg/hp_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.hp.hp_bg.hp_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_5/hp/hp_bg/hp_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.hp.hp_bg.hp_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/ship_icon"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.ship_icon",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/aim"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.aim",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/change"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.change",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/halo"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.halo",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_3/trail"] = "_control.intercept_attack_pro.missile_player.missile_3.trail",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp/hp_bg"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.hp.hp_bg",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp/hp_bg/hp_1"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.hp.hp_bg.hp_1",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6/hp/hp_bg/hp_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.hp.hp_bg.hp_2",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_5/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_5.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6"] = "_control.enemy_ship_team.enemy_ship_6",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_1/aim"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.aim",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_12/missile_shape/trail"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_12.missile_shape.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack/missile_2/trail"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack.missile_2.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_2/hp_color_bg"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_2.hp_color_bg",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_6"] = "_control.bvr_camera.find_enemy_radar.radar.ship_6",
			["bvr_info_pro/missile_player_one/missile_1/trail"] = "_control.missile_player_one.missile_1.trail",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_6/missile_player_attack/missile_2"] = "_control.intercpet_attack_video.bg.enemy_ship_6.missile_player_attack.missile_2",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/halo"] = "_control.enemy_ship_team.enemy_ship_2.halo",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_4/missile_shape/trail"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_4.missile_shape.trail",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_1/ship_lock"] = "_control.bvr_camera.find_enemy_radar.radar.ship_1.ship_lock",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_4"] = "_control.intercept_attack_pro.missile_player.missile_4",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/missile/missile_use_info/missile_3/attacking"] = "_control.bvr_camera.player_bvr_list.attack_header_1.missile.missile_use_info.missile_3.attacking",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_3"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_3",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_player_attack/missile_1/halo"] = "_control.enemy_ship_team.enemy_ship_6.missile_player_attack.missile_1.halo",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4/missile_player_attack/missile_1/halo"] = "_control.enemy_ship_team.enemy_ship_4.missile_player_attack.missile_1.halo",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_2"] = "_control.bvr_camera.find_enemy_radar.radar.ship_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_14"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_14",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_6/missile_shape"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_6.missile_shape",
			["bvr_info_pro/back"] = "_control.back",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_14"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_14",
			["bvr_info_pro/enemy_ship_team/enemy_ship_5/missile_player_attack/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_5.missile_player_attack.missile_3.trail",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_3"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_3",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_7"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_7",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_16"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_16",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/ship_icon"] = "_control.enemy_ship_team.enemy_ship_2.ship_icon",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_8"] = "_control.intercept_attack_pro.missile_player.missile_8",
			["bvr_info_pro/player_ship_team/band_2"] = "_control.player_ship_team.band_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_10"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_10",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_5"] = "_control.intercpet_attack_video.bg.enemy_ship_5",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_12"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_12",
			["bvr_info_pro/enemy_ship_team/enemy_ship_4"] = "_control.enemy_ship_team.enemy_ship_4",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_2"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_5"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_5",
			["bvr_info_pro/enemy_ship_team/enemy_ship_6/missile_intercept"] = "_control.enemy_ship_team.enemy_ship_6.missile_intercept",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_6"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6",
			["bvr_info_pro/player_ship_team/player_ship_5/missile_arsenal/missile_15"] = "_control.player_ship_team.player_ship_5.missile_arsenal.missile_15",
			["bvr_info_pro/missile_player_one/missile_9"] = "_control.missile_player_one.missile_9",
			["bvr_info_pro/bvr_camera/enemy_hp_list"] = "_control.bvr_camera.enemy_hp_list",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_intercept/missile_1/success"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_intercept.missile_1.success",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_3/trail"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_3.trail",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_3"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_3",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_5"] = "_control.bvr_camera.find_enemy_radar.radar.ship_5",
			["bvr_info_pro/back_btn/text"] = "_control.back_btn.text",
			["bvr_info_pro/player_ship_team/player_ship_4/missile_arsenal/missile_11"] = "_control.player_ship_team.player_ship_4.missile_arsenal.missile_11",
			["bvr_info_pro/bvr_camera/enemy_hp_list/enemy_hp_2/hp_color_bg/hp_color_1"] = "_control.bvr_camera.enemy_hp_list.enemy_hp_2.hp_color_bg.hp_color_1",
			["bvr_info_pro/player_ship_team/player_ship_3/missile_arsenal/missile_9"] = "_control.player_ship_team.player_ship_3.missile_arsenal.missile_9",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_10/trail"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_10.trail",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal/missile_2"] = "_control.player_ship_team.player_ship_1.missile_arsenal.missile_2",
			["bvr_info_pro/player_ship_team/player_ship_1/missile_arsenal"] = "_control.player_ship_team.player_ship_1.missile_arsenal",
			["bvr_info_pro/bvr_camera/player_bvr_list"] = "_control.bvr_camera.player_bvr_list",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar/ship_1"] = "_control.bvr_camera.find_enemy_radar.radar.ship_1",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_3"] = "_control.bvr_camera.player_bvr_list.attack_header_3",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_2/missile_intercept"] = "_control.intercpet_attack_video.bg.enemy_ship_2.missile_intercept",
			["bvr_info_pro/intercpet_attack_video"] = "_control.intercpet_attack_video",
			["bvr_info_pro/missile_player_one/missile_5"] = "_control.missile_player_one.missile_5",
			["bvr_info_pro/missile_player_one/missile_16"] = "_control.missile_player_one.missile_16",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/header/header_bg"] = "_control.bvr_camera.player_bvr_list.attack_header_1.header.header_bg",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/missile_player_intercepted_ani/missile_6"] = "_control.intercept_attack_pro.enemy_intercept_ships.missile_player_intercepted_ani.missile_6",
			["bvr_info_pro/intercpet_attack_video/bg/enemy_ship_1/missile_player_attack/missile_3"] = "_control.intercpet_attack_video.bg.enemy_ship_1.missile_player_attack.missile_3",
			["bvr_info_pro/intercept_attack_pro/missile_player"] = "_control.intercept_attack_pro.missile_player",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_1/trail"] = "_control.intercept_attack_pro.missile_player.missile_1.trail",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_5"] = "_control.intercept_attack_pro.missile_player.missile_5",
			["bvr_info_pro/bvr_camera"] = "_control.bvr_camera",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_1/header/header_color"] = "_control.bvr_camera.player_bvr_list.attack_header_1.header.header_color",
			["bvr_info_pro/bvr_camera/find_enemy_radar/radar_4"] = "_control.bvr_camera.find_enemy_radar.radar_4",
			["bvr_info_pro/bvr_camera/open"] = "_control.bvr_camera.open",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_16"] = "_control.intercept_attack_pro.missile_player.missile_16",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_2"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_18"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_18",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/change"] = "_control.enemy_ship_team.enemy_ship_2.change",
			["bvr_info_pro/enemy_ship_team/enemy_ship_2/missile_player_attack"] = "_control.enemy_ship_team.enemy_ship_2.missile_player_attack",
			["bvr_info_pro/intercept_attack_pro/enemy_intercept_ships/enemy_ship_3/hp"] = "_control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.hp",
			["bvr_info_pro/player_ship_team/player_ship_2/missile_arsenal/missile_6"] = "_control.player_ship_team.player_ship_2.missile_arsenal.missile_6",
			["bvr_info_pro/intercept_attack_pro/missile_player/missile_9"] = "_control.intercept_attack_pro.missile_player.missile_9",
			["bvr_info_pro/enemy_ship_team/enemy_ship_1/missile_player_attack/missile_2"] = "_control.enemy_ship_team.enemy_ship_1.missile_player_attack.missile_2",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_11"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_11",
			["bvr_info_pro/intercpet_attack_video/bg/missile_player_radar/missile_6"] = "_control.intercpet_attack_video.bg.missile_player_radar.missile_6",
			["bvr_info_pro/bvr_camera/player_bvr_list/attack_header_6/missile/missile_use_info/missile_1/attackend"] = "_control.bvr_camera.player_bvr_list.attack_header_6.missile.missile_use_info.missile_1.attackend"
		},
		click = {
			back = {
				tp = "UnityEngine.UI.Button"
			},
			back_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

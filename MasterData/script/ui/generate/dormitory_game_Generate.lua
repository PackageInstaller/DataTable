return {
	_rule_ = {
		none = {
			game_layer = {
				path = "game_layer",
				list = {
					team_3 = {
						path = "game_layer/team_3",
						list = {
							role = {
								path = "game_layer/team_3/role",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic",
									"UnityEngine.Canvas"
								}
							},
							car = {
								path = "game_layer/team_3/car",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					team_2 = {
						path = "game_layer/team_2",
						list = {
							role = {
								path = "game_layer/team_2/role",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic",
									"UnityEngine.Canvas"
								}
							},
							car = {
								path = "game_layer/team_2/car",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					team_1 = {
						path = "game_layer/team_1",
						list = {
							role = {
								path = "game_layer/team_1/role",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"Spine.Unity.SkeletonGraphic",
									"UnityEngine.Canvas"
								}
							},
							car = {
								path = "game_layer/team_1/car",
								list = {},
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas"
				}
			},
			race_unlock_layer = {
				path = "race_unlock_layer",
				list = {
					bg_container = {
						path = "race_unlock_layer/bg_container",
						list = {
							mask_bg = {
								path = "race_unlock_layer/bg_container/mask_bg",
								list = {
									bg_blue_top = {
										path = "race_unlock_layer/bg_container/mask_bg/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top2 = {
										path = "race_unlock_layer/bg_container/mask_bg/bg_blue_top2",
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
								path = "race_unlock_layer/bg_container/bg_blue_top3",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title_node = {
								path = "race_unlock_layer/bg_container/title_node",
								list = {
									title = {
										path = "race_unlock_layer/bg_container/title_node/title",
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
					close_btn = {
						path = "race_unlock_layer/close_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					case = {
						path = "race_unlock_layer/case",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					race_title = {
						path = "race_unlock_layer/race_title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					race_condition_1 = {
						path = "race_unlock_layer/race_condition_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					room_cha_1 = {
						path = "race_unlock_layer/room_cha_1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					race_condition_2 = {
						path = "race_unlock_layer/race_condition_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					room_cha_2 = {
						path = "race_unlock_layer/room_cha_2",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					confirm_btn = {
						path = "race_unlock_layer/confirm_btn",
						list = {
							txt = {
								path = "race_unlock_layer/confirm_btn/txt",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			race_select_layer = {
				path = "race_select_layer",
				list = {
					f1_select_bg = {
						path = "race_select_layer/f1_select_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "race_select_layer/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					team_1 = {
						path = "race_select_layer/team_1",
						list = {
							bg = {
								path = "race_select_layer/team_1/bg",
								list = {
									car = {
										path = "race_select_layer/team_1/bg/car",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									role = {
										path = "race_select_layer/team_1/bg/role",
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
									"UnityEngine.UI.Mask"
								}
							},
							team_bar = {
								path = "race_select_layer/team_1/team_bar",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							race_title = {
								path = "race_select_layer/team_1/race_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							selected_btn = {
								path = "race_select_layer/team_1/selected_btn",
								list = {
									txt = {
										path = "race_select_layer/team_1/selected_btn/txt",
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
							car_name_image = {
								path = "race_select_layer/team_1/car_name_image",
								list = {
									car_name_1 = {
										path = "race_select_layer/team_1/car_name_image/car_name_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									car_name_2 = {
										path = "race_select_layer/team_1/car_name_image/car_name_2",
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
					team_2 = {
						path = "race_select_layer/team_2",
						list = {
							bg = {
								path = "race_select_layer/team_2/bg",
								list = {
									car = {
										path = "race_select_layer/team_2/bg/car",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									role = {
										path = "race_select_layer/team_2/bg/role",
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
									"UnityEngine.UI.Mask"
								}
							},
							team_bar = {
								path = "race_select_layer/team_2/team_bar",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							race_title = {
								path = "race_select_layer/team_2/race_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							selected_btn = {
								path = "race_select_layer/team_2/selected_btn",
								list = {
									txt = {
										path = "race_select_layer/team_2/selected_btn/txt",
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
							car_name_image = {
								path = "race_select_layer/team_2/car_name_image",
								list = {
									car_name_1 = {
										path = "race_select_layer/team_2/car_name_image/car_name_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									car_name_2 = {
										path = "race_select_layer/team_2/car_name_image/car_name_2",
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
					team_3 = {
						path = "race_select_layer/team_3",
						list = {
							bg = {
								path = "race_select_layer/team_3/bg",
								list = {
									car = {
										path = "race_select_layer/team_3/bg/car",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									role = {
										path = "race_select_layer/team_3/bg/role",
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
									"UnityEngine.UI.Mask"
								}
							},
							team_bar = {
								path = "race_select_layer/team_3/team_bar",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							race_title = {
								path = "race_select_layer/team_3/race_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							selected_btn = {
								path = "race_select_layer/team_3/selected_btn",
								list = {
									txt = {
										path = "race_select_layer/team_3/selected_btn/txt",
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
							car_name_image = {
								path = "race_select_layer/team_3/car_name_image",
								list = {
									car_name_1 = {
										path = "race_select_layer/team_3/car_name_image/car_name_1",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									car_name_2 = {
										path = "race_select_layer/team_3/car_name_image/car_name_2",
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
					return_btn = {
						path = "race_select_layer/return_btn",
						list = {
							txt = {
								path = "race_select_layer/return_btn/txt",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			race_result_layer = {
				path = "race_result_layer",
				list = {
					f1_select_bg = {
						path = "race_result_layer/f1_select_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					team = {
						path = "race_result_layer/team",
						list = {
							bg = {
								path = "race_result_layer/team/bg",
								list = {
									car = {
										path = "race_result_layer/team/bg/car",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									role = {
										path = "race_result_layer/team/bg/role",
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
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask"
								}
							},
							team_bar = {
								path = "race_result_layer/team/team_bar",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							race_title = {
								path = "race_result_layer/team/race_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							car_name_image = {
								path = "race_result_layer/team/car_name_image",
								list = {
									car_name_2 = {
										path = "race_result_layer/team/car_name_image/car_name_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									car_name_1 = {
										path = "race_result_layer/team/car_name_image/car_name_1",
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
							},
							interact = {
								path = "race_result_layer/team/interact",
								list = {
									interact_txt = {
										path = "race_result_layer/team/interact/interact_txt",
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
					race_result = {
						path = "race_result_layer/race_result",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					win_buff_desc = {
						path = "race_result_layer/win_buff_desc",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					lose_buff_desc = {
						path = "race_result_layer/lose_buff_desc",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					restart_btn = {
						path = "race_result_layer/restart_btn",
						list = {
							txt = {
								path = "race_result_layer/restart_btn/txt",
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
					return_btn = {
						path = "race_result_layer/return_btn",
						list = {
							txt = {
								path = "race_result_layer/return_btn/txt",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		click = {
			["race_unlock_layer/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["race_unlock_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["race_select_layer/team_1/selected_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["race_select_layer/team_2/selected_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["race_select_layer/team_3/selected_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["race_select_layer/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["race_result_layer/restart_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["race_result_layer/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			game_layer = {
				component = "UnityEngine.Canvas",
				path = "game_layer"
			},
			role = {
				component = "UnityEngine.Canvas",
				path = "game_layer/team_1/role"
			},
			race_unlock_layer = {
				component = "UnityEngine.Canvas",
				path = "race_unlock_layer"
			},
			race_select_layer = {
				component = "UnityEngine.Canvas",
				path = "race_select_layer"
			},
			race_result_layer = {
				component = "UnityEngine.Canvas",
				path = "race_result_layer"
			}
		}
	}
}

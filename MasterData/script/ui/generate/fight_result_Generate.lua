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
					"UITweenSequence"
				}
			},
			close_btn = {
				path = "close_btn",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			top = {
				path = "top",
				list = {
					top_line = {
						path = "top/top_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title_txt = {
						path = "top/title_txt",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					name_head_image = {
						path = "top/name_head_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					player_name = {
						path = "top/player_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					player_level = {
						path = "top/player_level",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					fight_results = {
						path = "top/fight_results",
						list = {
							expimg = {
								path = "top/fight_results/expimg",
								list = {},
								component = {
									"UnityEngine.UI.Image"
								}
							},
							addexp = {
								path = "top/fight_results/addexp",
								list = {},
								component = {
									"UnityEngine.UI.Text",
									"FontJump"
								}
							},
							exp = {
								path = "top/fight_results/exp",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			left = {
				path = "left",
				list = {
					fleet_name = {
						path = "left/fleet_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					fleet_bg = {
						path = "left/fleet_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					every_exp = {
						path = "left/every_exp",
						list = {
							main_one = {
								path = "left/every_exp/main_one",
								list = {
									frame = {
										path = "left/every_exp/main_one/frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_frame = {
										path = "left/every_exp/main_one/exp_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									addexp = {
										path = "left/every_exp/main_one/addexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"FontJump"
										}
									},
									exp = {
										path = "left/every_exp/main_one/exp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									extra = {
										path = "left/every_exp/main_one/extra",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									remainword = {
										path = "left/every_exp/main_one/remainword",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									remainexp = {
										path = "left/every_exp/main_one/remainexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							main_two = {
								path = "left/every_exp/main_two",
								list = {
									frame = {
										path = "left/every_exp/main_two/frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_frame = {
										path = "left/every_exp/main_two/exp_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									addexp = {
										path = "left/every_exp/main_two/addexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"FontJump"
										}
									},
									exp = {
										path = "left/every_exp/main_two/exp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									extra = {
										path = "left/every_exp/main_two/extra",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									remainword = {
										path = "left/every_exp/main_two/remainword",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									remainexp = {
										path = "left/every_exp/main_two/remainexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							main_three = {
								path = "left/every_exp/main_three",
								list = {
									frame = {
										path = "left/every_exp/main_three/frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_frame = {
										path = "left/every_exp/main_three/exp_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									addexp = {
										path = "left/every_exp/main_three/addexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"FontJump"
										}
									},
									exp = {
										path = "left/every_exp/main_three/exp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									extra = {
										path = "left/every_exp/main_three/extra",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									remainword = {
										path = "left/every_exp/main_three/remainword",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									remainexp = {
										path = "left/every_exp/main_three/remainexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							main_four = {
								path = "left/every_exp/main_four",
								list = {
									frame = {
										path = "left/every_exp/main_four/frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_frame = {
										path = "left/every_exp/main_four/exp_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									addexp = {
										path = "left/every_exp/main_four/addexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"FontJump"
										}
									},
									exp = {
										path = "left/every_exp/main_four/exp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									extra = {
										path = "left/every_exp/main_four/extra",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									remainword = {
										path = "left/every_exp/main_four/remainword",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									remainexp = {
										path = "left/every_exp/main_four/remainexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							main_five = {
								path = "left/every_exp/main_five",
								list = {
									frame = {
										path = "left/every_exp/main_five/frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_frame = {
										path = "left/every_exp/main_five/exp_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									addexp = {
										path = "left/every_exp/main_five/addexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"FontJump"
										}
									},
									exp = {
										path = "left/every_exp/main_five/exp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									extra = {
										path = "left/every_exp/main_five/extra",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									remainword = {
										path = "left/every_exp/main_five/remainword",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									remainexp = {
										path = "left/every_exp/main_five/remainexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							main_six = {
								path = "left/every_exp/main_six",
								list = {
									frame = {
										path = "left/every_exp/main_six/frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									exp_frame = {
										path = "left/every_exp/main_six/exp_frame",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									addexp = {
										path = "left/every_exp/main_six/addexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"FontJump"
										}
									},
									exp = {
										path = "left/every_exp/main_six/exp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									extra = {
										path = "left/every_exp/main_six/extra",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									remainword = {
										path = "left/every_exp/main_six/remainword",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									remainexp = {
										path = "left/every_exp/main_six/remainexp",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
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
					ship_list = {
						path = "left/ship_list",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.VerticalLayoutGroup",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					award = {
						path = "left/award",
						list = {
							res_title = {
								path = "left/award/res_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							oil = {
								path = "left/award/oil",
								list = {
									oil_icon = {
										path = "left/award/oil/oil_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									oil_txt = {
										path = "left/award/oil/oil_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bullet = {
								path = "left/award/bullet",
								list = {
									bullet_icon = {
										path = "left/award/bullet/bullet_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bullet_txt = {
										path = "left/award/bullet/bullet_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							steel = {
								path = "left/award/steel",
								list = {
									steel_icon = {
										path = "left/award/steel/steel_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									steel_txt = {
										path = "left/award/steel/steel_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							alum = {
								path = "left/award/alum",
								list = {
									alum_icon = {
										path = "left/award/alum/alum_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									alum_txt = {
										path = "left/award/alum/alum_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							item_title = {
								path = "left/award/item_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							award_good = {
								path = "left/award/award_good",
								list = {
									good_icon_background = {
										path = "left/award/award_good/good_icon_background",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									good_icon = {
										path = "left/award/award_good/good_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									good_num_txt = {
										path = "left/award/award_good/good_num_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text",
											"UnityEngine.UI.Outline"
										}
									},
									good_name_txt_back = {
										path = "left/award/award_good/good_name_txt_back",
										list = {
											good_name_txt = {
												path = "left/award/award_good/good_name_txt_back/good_name_txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UIMoveTweener",
					"UIMoveTweener"
				}
			},
			right = {
				path = "right",
				list = {
					success_img = {
						path = "right/success_img",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					continue_txt = {
						path = "right/continue_txt",
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
					"UIMoveTweener",
					"UIMoveTweener"
				}
			}
		},
		call_node_list = {
			["fight_result/left/every_exp/main_six/frame"] = "_control.left.every_exp.main_six.frame",
			["fight_result/left/every_exp/main_five"] = "_control.left.every_exp.main_five",
			["fight_result/left/every_exp/main_six"] = "_control.left.every_exp.main_six",
			["fight_result/left/every_exp/main_two/exp"] = "_control.left.every_exp.main_two.exp",
			["fight_result/left/every_exp/main_three/remainword"] = "_control.left.every_exp.main_three.remainword",
			["fight_result/left/fleet_bg"] = "_control.left.fleet_bg",
			["fight_result/left/every_exp/main_three"] = "_control.left.every_exp.main_three",
			["fight_result/left/every_exp/main_four/exp"] = "_control.left.every_exp.main_four.exp",
			["fight_result/left/every_exp/main_four/exp_frame"] = "_control.left.every_exp.main_four.exp_frame",
			["fight_result/top"] = "_control.top",
			["fight_result/left/every_exp/main_two/frame"] = "_control.left.every_exp.main_two.frame",
			["fight_result/left/every_exp/main_four/extra"] = "_control.left.every_exp.main_four.extra",
			["fight_result/left/award/oil/oil_icon"] = "_control.left.award.oil.oil_icon",
			["fight_result/top/title_txt"] = "_control.top.title_txt",
			["fight_result/left/award"] = "_control.left.award",
			["fight_result/left/every_exp/main_three/exp"] = "_control.left.every_exp.main_three.exp",
			["fight_result/left/every_exp/main_two/remainexp"] = "_control.left.every_exp.main_two.remainexp",
			["fight_result/left/every_exp/main_five/frame"] = "_control.left.every_exp.main_five.frame",
			["fight_result/left/every_exp/main_one/addexp"] = "_control.left.every_exp.main_one.addexp",
			["fight_result/left"] = "_control.left",
			["fight_result/left/every_exp/main_four/frame"] = "_control.left.every_exp.main_four.frame",
			["fight_result/left/every_exp/main_six/remainexp"] = "_control.left.every_exp.main_six.remainexp",
			["fight_result/left/every_exp/main_one/exp_frame"] = "_control.left.every_exp.main_one.exp_frame",
			["fight_result/left/every_exp/main_one/remainexp"] = "_control.left.every_exp.main_one.remainexp",
			["fight_result/left/every_exp/main_four"] = "_control.left.every_exp.main_four",
			["fight_result/left/every_exp/main_one/extra"] = "_control.left.every_exp.main_one.extra",
			["fight_result/left/every_exp/main_two/addexp"] = "_control.left.every_exp.main_two.addexp",
			["fight_result/left/every_exp/main_four/addexp"] = "_control.left.every_exp.main_four.addexp",
			["fight_result/left/every_exp/main_three/extra"] = "_control.left.every_exp.main_three.extra",
			["fight_result/left/every_exp/main_one/exp"] = "_control.left.every_exp.main_one.exp",
			["fight_result/top/fight_results"] = "_control.top.fight_results",
			["fight_result/left/every_exp/main_two/exp_frame"] = "_control.left.every_exp.main_two.exp_frame",
			["fight_result/left/every_exp"] = "_control.left.every_exp",
			["fight_result/left/every_exp/main_five/exp"] = "_control.left.every_exp.main_five.exp",
			["fight_result/close_btn"] = "_control.close_btn",
			["fight_result/left/every_exp/main_four/remainword"] = "_control.left.every_exp.main_four.remainword",
			["fight_result/left/every_exp/main_two/remainword"] = "_control.left.every_exp.main_two.remainword",
			["fight_result/left/every_exp/main_two/extra"] = "_control.left.every_exp.main_two.extra",
			["fight_result/left/ship_list"] = "_control.left.ship_list",
			["fight_result/left/every_exp/main_four/remainexp"] = "_control.left.every_exp.main_four.remainexp",
			["fight_result/left/every_exp/main_one/remainword"] = "_control.left.every_exp.main_one.remainword",
			["fight_result/left/award/oil/oil_txt"] = "_control.left.award.oil.oil_txt",
			["fight_result/left/award/bullet"] = "_control.left.award.bullet",
			["fight_result/left/award/bullet/bullet_icon"] = "_control.left.award.bullet.bullet_icon",
			["fight_result/left/fleet_name"] = "_control.left.fleet_name",
			["fight_result/left/every_exp/main_three/exp_frame"] = "_control.left.every_exp.main_three.exp_frame",
			["fight_result/left/award/bullet/bullet_txt"] = "_control.left.award.bullet.bullet_txt",
			["fight_result/left/award/steel"] = "_control.left.award.steel",
			["fight_result/left/award/alum"] = "_control.left.award.alum",
			["fight_result/left/award/oil"] = "_control.left.award.oil",
			["fight_result/left/award/alum/alum_icon"] = "_control.left.award.alum.alum_icon",
			["fight_result/left/every_exp/main_six/exp"] = "_control.left.every_exp.main_six.exp",
			["fight_result/left/every_exp/main_six/remainword"] = "_control.left.every_exp.main_six.remainword",
			["fight_result/left/award/award_good"] = "_control.left.award.award_good",
			["fight_result/left/award/award_good/good_icon"] = "_control.left.award.award_good.good_icon",
			["fight_result/right"] = "_control.right",
			["fight_result/right/continue_txt"] = "_control.right.continue_txt",
			["fight_result/left/award/alum/alum_txt"] = "_control.left.award.alum.alum_txt",
			["fight_result/left/award/item_title"] = "_control.left.award.item_title",
			["fight_result/right/success_img"] = "_control.right.success_img",
			["fight_result/top/player_name"] = "_control.top.player_name",
			["fight_result/left/every_exp/main_five/remainword"] = "_control.left.every_exp.main_five.remainword",
			["fight_result/bg"] = "_control.bg",
			["fight_result/left/every_exp/main_three/frame"] = "_control.left.every_exp.main_three.frame",
			["fight_result/left/every_exp/main_five/extra"] = "_control.left.every_exp.main_five.extra",
			["fight_result/left/every_exp/main_six/addexp"] = "_control.left.every_exp.main_six.addexp",
			["fight_result/left/every_exp/main_two"] = "_control.left.every_exp.main_two",
			["fight_result/left/every_exp/main_six/extra"] = "_control.left.every_exp.main_six.extra",
			["fight_result/top/fight_results/exp"] = "_control.top.fight_results.exp",
			["fight_result/left/award/award_good/good_name_txt_back/good_name_txt"] = "_control.left.award.award_good.good_name_txt_back.good_name_txt",
			["fight_result/left/every_exp/main_five/addexp"] = "_control.left.every_exp.main_five.addexp",
			["fight_result/left/every_exp/main_three/remainexp"] = "_control.left.every_exp.main_three.remainexp",
			["fight_result/left/every_exp/main_five/exp_frame"] = "_control.left.every_exp.main_five.exp_frame",
			["fight_result/left/every_exp/main_six/exp_frame"] = "_control.left.every_exp.main_six.exp_frame",
			["fight_result/top/player_level"] = "_control.top.player_level",
			["fight_result/top/top_line"] = "_control.top.top_line",
			["fight_result/left/every_exp/main_five/remainexp"] = "_control.left.every_exp.main_five.remainexp",
			["fight_result/left/every_exp/main_three/addexp"] = "_control.left.every_exp.main_three.addexp",
			["fight_result/top/fight_results/expimg"] = "_control.top.fight_results.expimg",
			["fight_result/top/fight_results/addexp"] = "_control.top.fight_results.addexp",
			["fight_result/left/award/award_good/good_num_txt"] = "_control.left.award.award_good.good_num_txt",
			["fight_result/left/award/steel/steel_txt"] = "_control.left.award.steel.steel_txt",
			["fight_result/left/award/award_good/good_name_txt_back"] = "_control.left.award.award_good.good_name_txt_back",
			["fight_result/left/every_exp/main_one"] = "_control.left.every_exp.main_one",
			["fight_result/left/award/award_good/good_icon_background"] = "_control.left.award.award_good.good_icon_background",
			["fight_result/left/every_exp/main_one/frame"] = "_control.left.every_exp.main_one.frame",
			["fight_result/left/award/res_title"] = "_control.left.award.res_title",
			["fight_result/top/name_head_image"] = "_control.top.name_head_image",
			["fight_result/left/award/steel/steel_icon"] = "_control.left.award.steel.steel_icon"
		},
		click = {
			close_btn = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			left = {
				path = "left",
				list = {
					title_line = {
						path = "left/title_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					formation = {
						path = "left/formation",
						list = {
							info = {
								path = "left/formation/info",
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
					course = {
						path = "left/course",
						list = {
							info = {
								path = "left/course/info",
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
			middle = {
				path = "middle",
				list = {
					stage_bg = {
						path = "middle/stage_bg",
						list = {
							stage1 = {
								path = "middle/stage_bg/stage1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							stage2 = {
								path = "middle/stage_bg/stage2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							clip = {
								path = "middle/stage_bg/clip",
								list = {
									stage = {
										path = "middle/stage_bg/clip/stage",
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
									"UnityEngine.UI.RectMask2D"
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
			right = {
				path = "right",
				list = {
					title_line = {
						path = "right/title_line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					formation = {
						path = "right/formation",
						list = {
							info = {
								path = "right/formation/info",
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
					course = {
						path = "right/course",
						list = {
							info = {
								path = "right/course/info",
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
			border_root = {
				path = "border_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas"
				}
			},
			hp_bar_root = {
				path = "hp_bar_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			damage_text_root = {
				path = "damage_text_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas"
				}
			},
			periscope_root = {
				path = "periscope_root",
				list = {
					periscope = {
						path = "periscope_root/periscope",
						list = {
							bg = {
								path = "periscope_root/periscope/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mask = {
								path = "periscope_root/periscope/mask",
								list = {
									clip = {
										path = "periscope_root/periscope/mask/clip",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									texture = {
										path = "periscope_root/periscope/mask/texture",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.RawImage"
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
							periscope = {
								path = "periscope_root/periscope/periscope",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas"
				}
			},
			cutin_root = {
				path = "cutin_root",
				list = {
					aircraft_mask = {
						path = "cutin_root/aircraft_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					airfight_actor = {
						path = "cutin_root/airfight_actor",
						list = {},
						component = {
							"UnityEngine.Transform",
							"UnityEngine.MeshFilter",
							"UnityEngine.MeshRenderer",
							"Spine.Unity.SkeletonAnimation",
							"ChangeSpineSlot"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas"
				}
			},
			buff_root = {
				path = "buff_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			strong_buff_root = {
				path = "strong_buff_root",
				list = {
					info_bg = {
						path = "strong_buff_root/info_bg",
						list = {
							close_btn = {
								path = "strong_buff_root/info_bg/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							buff_name = {
								path = "strong_buff_root/info_bg/buff_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							info_text = {
								path = "strong_buff_root/info_bg/info_text",
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
					buff_bg = {
						path = "strong_buff_root/buff_bg",
						list = {
							buff_icon = {
								path = "strong_buff_root/buff_bg/buff_icon",
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
					},
					lock_bg = {
						path = "strong_buff_root/lock_bg",
						list = {
							lock_icon = {
								path = "strong_buff_root/lock_bg/lock_icon",
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
					},
					lock_info = {
						path = "strong_buff_root/lock_info",
						list = {
							lock_close = {
								path = "strong_buff_root/lock_info/lock_close",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							buff_name = {
								path = "strong_buff_root/lock_info/buff_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							info_text = {
								path = "strong_buff_root/lock_info/info_text",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			enemy_buff_root = {
				path = "enemy_buff_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			fight_buff_root = {
				path = "fight_buff_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.UI.GridLayoutGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			aircontrol_root = {
				path = "aircontrol_root",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			dialogue_root = {
				path = "dialogue_root",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas"
				}
			},
			boss_hp_root = {
				path = "boss_hp_root",
				list = {
					boss_icon = {
						path = "boss_hp_root/boss_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bg = {
						path = "boss_hp_root/bg",
						list = {
							progress = {
								path = "boss_hp_root/bg/progress",
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
					hp_text = {
						path = "boss_hp_root/hp_text",
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
			support_root = {
				path = "support_root",
				list = {
					bg = {
						path = "support_root/bg",
						list = {
							frame = {
								path = "support_root/bg/frame",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "support_root/bg/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_effect = {
								path = "support_root/bg/line_effect",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_down = {
								path = "support_root/bg/line_down",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line_effect_down = {
								path = "support_root/bg/line_effect_down",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							mask = {
								path = "support_root/bg/mask",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Mask",
									"UnityEngine.UI.Button"
								}
							},
							skip = {
								path = "support_root/bg/skip",
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
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			skip = {
				path = "skip",
				list = {
					Text = {
						path = "skip/Text",
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
					"UnityEngine.UI.Button",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			popup = {
				path = "popup",
				list = {
					combat_continue = {
						path = "popup/combat_continue",
						list = {
							frame = {
								path = "popup/combat_continue/frame",
								list = {
									line = {
										path = "popup/combat_continue/frame/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									nightwarleft = {
										path = "popup/combat_continue/frame/nightwarleft",
										list = {
											nightwarcontinue = {
												path = "popup/combat_continue/frame/nightwarleft/nightwarcontinue",
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
									nightwarright = {
										path = "popup/combat_continue/frame/nightwarright",
										list = {
											nightwarcancel = {
												path = "popup/combat_continue/frame/nightwarright/nightwarcancel",
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
										path = "popup/combat_continue/frame/ui_combatcontinuetip",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									ui_tip_mid = {
										path = "popup/combat_continue/frame/ui_tip_mid",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									oil = {
										path = "popup/combat_continue/frame/oil",
										list = {
											icon = {
												path = "popup/combat_continue/frame/oil/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lineleft = {
												path = "popup/combat_continue/frame/oil/lineleft",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											linelright = {
												path = "popup/combat_continue/frame/oil/linelright",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil = {
												path = "popup/combat_continue/frame/oil/oil",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											percent = {
												path = "popup/combat_continue/frame/oil/percent",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											oil_1 = {
												path = "popup/combat_continue/frame/oil/oil_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_2 = {
												path = "popup/combat_continue/frame/oil/oil_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_3 = {
												path = "popup/combat_continue/frame/oil/oil_3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_4 = {
												path = "popup/combat_continue/frame/oil/oil_4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_5 = {
												path = "popup/combat_continue/frame/oil/oil_5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_6 = {
												path = "popup/combat_continue/frame/oil/oil_6",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_7 = {
												path = "popup/combat_continue/frame/oil/oil_7",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_8 = {
												path = "popup/combat_continue/frame/oil/oil_8",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_9 = {
												path = "popup/combat_continue/frame/oil/oil_9",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											oil_10 = {
												path = "popup/combat_continue/frame/oil/oil_10",
												list = {},
												component = {
													"UnityEngine.RectTransform",
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
										path = "popup/combat_continue/frame/bullet",
										list = {
											icon = {
												path = "popup/combat_continue/frame/bullet/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											lineleft = {
												path = "popup/combat_continue/frame/bullet/lineleft",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											linelright = {
												path = "popup/combat_continue/frame/bullet/linelright",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet = {
												path = "popup/combat_continue/frame/bullet/bullet",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											percent = {
												path = "popup/combat_continue/frame/bullet/percent",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											bullet_1 = {
												path = "popup/combat_continue/frame/bullet/bullet_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_2 = {
												path = "popup/combat_continue/frame/bullet/bullet_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_3 = {
												path = "popup/combat_continue/frame/bullet/bullet_3",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_4 = {
												path = "popup/combat_continue/frame/bullet/bullet_4",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_5 = {
												path = "popup/combat_continue/frame/bullet/bullet_5",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_6 = {
												path = "popup/combat_continue/frame/bullet/bullet_6",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_7 = {
												path = "popup/combat_continue/frame/bullet/bullet_7",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_8 = {
												path = "popup/combat_continue/frame/bullet/bullet_8",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_9 = {
												path = "popup/combat_continue/frame/bullet/bullet_9",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bullet_10 = {
												path = "popup/combat_continue/frame/bullet/bullet_10",
												list = {},
												component = {
													"UnityEngine.RectTransform",
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
										path = "popup/combat_continue/frame/supply",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									abyss_power = {
										path = "popup/combat_continue/frame/abyss_power",
										list = {
											fill = {
												path = "popup/combat_continue/frame/abyss_power/fill",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											tip = {
												path = "popup/combat_continue/frame/abyss_power/tip",
												list = {
													num = {
														path = "popup/combat_continue/frame/abyss_power/tip/num",
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
									damagecontrol = {
										path = "popup/combat_continue/frame/damagecontrol",
										list = {
											gross = {
												path = "popup/combat_continue/frame/damagecontrol/gross",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											icon = {
												path = "popup/combat_continue/frame/damagecontrol/icon",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											buy = {
												path = "popup/combat_continue/frame/damagecontrol/buy",
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
									tip = {
										path = "popup/combat_continue/frame/tip",
										list = {
											text = {
												path = "popup/combat_continue/frame/tip/text",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											icon = {
												path = "popup/combat_continue/frame/tip/icon",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		click = {
			mask = {
				tp = "UnityEngine.UI.Button"
			},
			["left/course"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right/course"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strong_buff_root/info_bg/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strong_buff_root/buff_bg/buff_icon"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strong_buff_root/lock_bg/lock_icon"] = {
				tp = "UnityEngine.UI.Button"
			},
			["strong_buff_root/lock_info/lock_close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_root/bg/mask"] = {
				tp = "UnityEngine.UI.Button"
			},
			["support_root/bg/skip"] = {
				tp = "UnityEngine.UI.Button"
			},
			skip = {
				tp = "UnityEngine.UI.Button"
			},
			["popup/combat_continue/frame/nightwarleft"] = {
				tp = "UnityEngine.UI.Button"
			},
			["popup/combat_continue/frame/nightwarright"] = {
				tp = "UnityEngine.UI.Button"
			},
			["popup/combat_continue/frame/damagecontrol/buy"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			mask = {
				component = "UnityEngine.Canvas",
				path = "mask"
			},
			left = {
				component = "UnityEngine.Canvas",
				path = "left"
			},
			right = {
				component = "UnityEngine.Canvas",
				path = "right"
			},
			border_root = {
				component = "UnityEngine.Canvas",
				path = "border_root"
			},
			hp_bar_root = {
				component = "UnityEngine.Canvas",
				path = "hp_bar_root"
			},
			damage_text_root = {
				component = "UnityEngine.Canvas",
				path = "damage_text_root"
			},
			periscope_root = {
				component = "UnityEngine.Canvas",
				path = "periscope_root"
			},
			cutin_root = {
				component = "UnityEngine.Canvas",
				path = "cutin_root"
			},
			buff_root = {
				component = "UnityEngine.Canvas",
				path = "buff_root"
			},
			strong_buff_root = {
				component = "UnityEngine.Canvas",
				path = "strong_buff_root"
			},
			enemy_buff_root = {
				component = "UnityEngine.Canvas",
				path = "enemy_buff_root"
			},
			fight_buff_root = {
				component = "UnityEngine.Canvas",
				path = "fight_buff_root"
			},
			dialogue_root = {
				component = "UnityEngine.Canvas",
				path = "dialogue_root"
			},
			support_root = {
				component = "UnityEngine.Canvas",
				path = "support_root"
			},
			skip = {
				component = "UnityEngine.Canvas",
				path = "skip"
			},
			popup = {
				component = "UnityEngine.Canvas",
				path = "popup"
			},
			combat_continue = {
				component = "UnityEngine.Canvas",
				path = "popup/combat_continue"
			}
		}
	}
}

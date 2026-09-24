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
							},
							title_mask = {
								path = "left/formation/title_mask",
								list = {
									txt = {
										path = "left/formation/title_mask/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_2 = {
										path = "left/formation/title_mask/txt_2",
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
							},
							title_mask = {
								path = "left/course/title_mask",
								list = {
									txt = {
										path = "left/course/title_mask/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_2 = {
										path = "left/course/title_mask/txt_2",
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
									},
									title_mask = {
										path = "middle/stage_bg/clip/title_mask",
										list = {
											txt = {
												path = "middle/stage_bg/clip/title_mask/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											txt_2 = {
												path = "middle/stage_bg/clip/title_mask/txt_2",
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
							},
							title_mask = {
								path = "right/formation/title_mask",
								list = {
									txt = {
										path = "right/formation/title_mask/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_2 = {
										path = "right/formation/title_mask/txt_2",
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
							},
							title_mask = {
								path = "right/course/title_mask",
								list = {
									txt = {
										path = "right/course/title_mask/txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt_2 = {
										path = "right/course/title_mask/txt_2",
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
			periscope = {
				path = "periscope_root/periscope/periscope",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
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
									toggle_control = {
										path = "popup/combat_continue/frame/toggle_control",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.ToggleGroup"
										}
									},
									nightwarleft = {
										path = "popup/combat_continue/frame/toggle_control/nightwarleft",
										list = {
											nightwarcontinue = {
												path = "popup/combat_continue/frame/toggle_control/nightwarleft/nightwarcontinue",
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
											"UnityEngine.UI.Toggle"
										}
									},
									nightwarright = {
										path = "popup/combat_continue/frame/toggle_control/nightwarright",
										list = {
											nightwarcancel = {
												path = "popup/combat_continue/frame/toggle_control/nightwarright/nightwarcancel",
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
											"UnityEngine.UI.Toggle"
										}
									},
									nightwarleft_btn = {
										path = "popup/combat_continue/frame/toggle_control/nightwarleft_btn",
										list = {
											nightwarcontinue = {
												path = "popup/combat_continue/frame/toggle_control/nightwarleft_btn/nightwarcontinue",
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
									nightwarright_btn = {
										path = "popup/combat_continue/frame/toggle_control/nightwarright_btn",
										list = {
											nightwarcancel = {
												path = "popup/combat_continue/frame/toggle_control/nightwarright_btn/nightwarcancel",
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
		call_node_list = {
			["battle/cutin_root/airfight_actor"] = "_control.cutin_root.airfight_actor",
			["battle/popup/combat_continue/frame/bullet/percent"] = "_control.popup.combat_continue.frame.bullet.percent",
			["battle/middle/stage_bg/clip/title_mask"] = "_control.middle.stage_bg.clip.title_mask",
			["battle/popup/combat_continue/frame/oil/oil_10"] = "_control.popup.combat_continue.frame.oil.oil_10",
			["battle/popup/combat_continue/frame/oil/oil_8"] = "_control.popup.combat_continue.frame.oil.oil_8",
			["battle/right/course/title_mask/txt"] = "_control.right.course.title_mask.txt",
			["battle/popup/combat_continue/frame/toggle_control"] = "_control.popup.combat_continue.frame.toggle_control",
			["battle/right/formation/info"] = "_control.right.formation.info",
			["battle/popup/combat_continue/frame/oil/linelright"] = "_control.popup.combat_continue.frame.oil.linelright",
			["battle/border_root"] = "_control.border_root",
			["battle/left/formation/title_mask/txt_2"] = "_control.left.formation.title_mask.txt_2",
			["battle/popup/combat_continue/frame/toggle_control/nightwarright"] = "_control.popup.combat_continue.frame.nightwarright",
			["battle/boss_hp_root/bg/progress"] = "_control.boss_hp_root.bg.progress",
			["battle/popup/combat_continue/frame/toggle_control/nightwarright_btn"] = "_control.popup.combat_continue.frame.nightwarright_btn",
			["battle/middle/stage_bg/clip/stage"] = "_control.middle.stage_bg.clip.stage",
			["battle/popup/combat_continue/frame/line"] = "_control.popup.combat_continue.frame.line",
			["battle/strong_buff_root/lock_info/buff_name"] = "_control.strong_buff_root.lock_info.buff_name",
			["battle/buff_root"] = "_control.buff_root",
			["battle/strong_buff_root/buff_bg"] = "_control.strong_buff_root.buff_bg",
			["battle/support_root/bg"] = "_control.support_root.bg",
			["battle/popup/combat_continue/frame/oil/oil_7"] = "_control.popup.combat_continue.frame.oil.oil_7",
			["battle/popup/combat_continue/frame/toggle_control/nightwarleft/nightwarcontinue"] = "_control.popup.combat_continue.frame.nightwarleft.nightwarcontinue",
			["battle/support_root/bg/line"] = "_control.support_root.bg.line",
			["battle/boss_hp_root/hp_text"] = "_control.boss_hp_root.hp_text",
			["battle/hp_bar_root"] = "_control.hp_bar_root",
			["battle/popup/combat_continue/frame/bullet/bullet_10"] = "_control.popup.combat_continue.frame.bullet.bullet_10",
			["battle/popup/combat_continue/frame/tip/text"] = "_control.popup.combat_continue.frame.tip.text",
			["battle/popup/combat_continue/frame"] = "_control.popup.combat_continue.frame",
			["battle/right/course/title_mask"] = "_control.right.course.title_mask",
			["battle/popup/combat_continue/frame/oil/oil"] = "_control.popup.combat_continue.frame.oil.oil",
			["battle/popup/combat_continue/frame/oil/oil_9"] = "_control.popup.combat_continue.frame.oil.oil_9",
			["battle/left/course/info"] = "_control.left.course.info",
			["battle/damage_text_root"] = "_control.damage_text_root",
			["battle/popup/combat_continue/frame/oil/oil_3"] = "_control.popup.combat_continue.frame.oil.oil_3",
			["battle/popup/combat_continue/frame/oil/lineleft"] = "_control.popup.combat_continue.frame.oil.lineleft",
			["battle/periscope_root/periscope"] = "_control.periscope_root.periscope",
			["battle/mask"] = "_control.mask",
			["battle/middle"] = "_control.middle",
			["battle/cutin_root"] = "_control.cutin_root",
			["battle/support_root/bg/line_down"] = "_control.support_root.bg.line_down",
			["battle/right/formation"] = "_control.right.formation",
			["battle/left"] = "_control.left",
			["battle/middle/stage_bg/clip/title_mask/txt"] = "_control.middle.stage_bg.clip.title_mask.txt",
			["battle/strong_buff_root"] = "_control.strong_buff_root",
			["battle/popup/combat_continue/frame/toggle_control/nightwarleft_btn"] = "_control.popup.combat_continue.frame.nightwarleft_btn",
			["battle/popup/combat_continue/frame/oil/oil_5"] = "_control.popup.combat_continue.frame.oil.oil_5",
			["battle/popup/combat_continue/frame/bullet/bullet_1"] = "_control.popup.combat_continue.frame.bullet.bullet_1",
			["battle/strong_buff_root/buff_bg/buff_icon"] = "_control.strong_buff_root.buff_bg.buff_icon",
			["battle/popup/combat_continue/frame/bullet/bullet_6"] = "_control.popup.combat_continue.frame.bullet.bullet_6",
			["battle/right/course"] = "_control.right.course",
			["battle/popup/combat_continue/frame/abyss_power/fill"] = "_control.popup.combat_continue.frame.abyss_power.fill",
			["battle/popup/combat_continue/frame/oil/oil_6"] = "_control.popup.combat_continue.frame.oil.oil_6",
			["battle/popup/combat_continue/frame/bullet/bullet_8"] = "_control.popup.combat_continue.frame.bullet.bullet_8",
			["battle/popup/combat_continue/frame/oil/oil_1"] = "_control.popup.combat_continue.frame.oil.oil_1",
			["battle/support_root/bg/line_effect"] = "_control.support_root.bg.line_effect",
			["battle/popup/combat_continue/frame/abyss_power/tip/num"] = "_control.popup.combat_continue.frame.abyss_power.tip.num",
			["battle/strong_buff_root/info_bg/buff_name"] = "_control.strong_buff_root.info_bg.buff_name",
			["battle/left/course/title_mask/txt"] = "_control.left.course.title_mask.txt",
			["battle/right/course/info"] = "_control.right.course.info",
			["battle/popup/combat_continue/frame/oil/oil_2"] = "_control.popup.combat_continue.frame.oil.oil_2",
			["battle/popup/combat_continue/frame/damagecontrol/gross"] = "_control.popup.combat_continue.frame.damagecontrol.gross",
			["battle/popup/combat_continue/frame/damagecontrol/icon"] = "_control.popup.combat_continue.frame.damagecontrol.icon",
			["battle/strong_buff_root/info_bg/close_btn"] = "_control.strong_buff_root.info_bg.close_btn",
			["battle/popup/combat_continue/frame/oil/percent"] = "_control.popup.combat_continue.frame.oil.percent",
			["battle/popup/combat_continue/frame/tip/icon"] = "_control.popup.combat_continue.frame.tip.icon",
			["battle/popup/combat_continue/frame/bullet/bullet"] = "_control.popup.combat_continue.frame.bullet.bullet",
			["battle/popup/combat_continue/frame/oil/icon"] = "_control.popup.combat_continue.frame.oil.icon",
			["battle/skip"] = "_control.skip",
			["battle/boss_hp_root/boss_icon"] = "_control.boss_hp_root.boss_icon",
			["battle/strong_buff_root/lock_info"] = "_control.strong_buff_root.lock_info",
			["battle/skip/Text"] = "_control.skip.Text",
			["battle/dialogue_root"] = "_control.dialogue_root",
			["battle/popup/combat_continue/frame/abyss_power/tip"] = "_control.popup.combat_continue.frame.abyss_power.tip",
			["battle/periscope_root"] = "_control.periscope_root",
			["battle/popup/combat_continue/frame/bullet"] = "_control.popup.combat_continue.frame.bullet",
			["battle/left/course/title_mask/txt_2"] = "_control.left.course.title_mask.txt_2",
			["battle/left/course/title_mask"] = "_control.left.course.title_mask",
			["battle/support_root/bg/skip"] = "_control.support_root.bg.skip",
			["battle/strong_buff_root/lock_bg/lock_icon"] = "_control.strong_buff_root.lock_bg.lock_icon",
			["battle/strong_buff_root/info_bg"] = "_control.strong_buff_root.info_bg",
			["battle/popup/combat_continue"] = "_control.popup.combat_continue",
			["battle/support_root"] = "_control.support_root",
			["battle/popup/combat_continue/frame/abyss_power"] = "_control.popup.combat_continue.frame.abyss_power",
			["battle/left/formation/info"] = "_control.left.formation.info",
			["battle/right/title_line"] = "_control.right.title_line",
			["battle/popup/combat_continue/frame/bullet/icon"] = "_control.popup.combat_continue.frame.bullet.icon",
			["battle/popup/combat_continue/frame/bullet/lineleft"] = "_control.popup.combat_continue.frame.bullet.lineleft",
			["battle/popup/combat_continue/frame/oil/oil_4"] = "_control.popup.combat_continue.frame.oil.oil_4",
			["battle/popup/combat_continue/frame/bullet/linelright"] = "_control.popup.combat_continue.frame.bullet.linelright",
			["battle/popup/combat_continue/frame/ui_tip_mid"] = "_control.popup.combat_continue.frame.ui_tip_mid",
			["battle/enemy_buff_root"] = "_control.enemy_buff_root",
			["battle/fight_buff_root"] = "_control.fight_buff_root",
			["battle/strong_buff_root/lock_info/info_text"] = "_control.strong_buff_root.lock_info.info_text",
			["battle/popup/combat_continue/frame/toggle_control/nightwarright/nightwarcancel"] = "_control.popup.combat_continue.frame.nightwarright.nightwarcancel",
			["battle/popup/combat_continue/frame/bullet/bullet_9"] = "_control.popup.combat_continue.frame.bullet.bullet_9",
			["battle/right/formation/title_mask/txt_2"] = "_control.right.formation.title_mask.txt_2",
			["battle/periscope_root/periscope/mask/texture"] = "_control.periscope_root.periscope.mask.texture",
			["battle/middle/stage_bg/clip/title_mask/txt_2"] = "_control.middle.stage_bg.clip.title_mask.txt_2",
			["battle/periscope_root/periscope/mask"] = "_control.periscope_root.periscope.mask",
			["battle/right"] = "_control.right",
			["battle/support_root/bg/frame"] = "_control.support_root.bg.frame",
			["battle/right/course/title_mask/txt_2"] = "_control.right.course.title_mask.txt_2",
			["battle/boss_hp_root"] = "_control.boss_hp_root",
			["battle/periscope_root/periscope/periscope"] = "_control.periscope",
			["battle/popup/combat_continue/frame/bullet/bullet_3"] = "_control.popup.combat_continue.frame.bullet.bullet_3",
			["battle/popup/combat_continue/frame/supply"] = "_control.popup.combat_continue.frame.supply",
			["battle/popup"] = "_control.popup",
			["battle/periscope_root/periscope/mask/clip"] = "_control.periscope_root.periscope.mask.clip",
			["battle/boss_hp_root/bg"] = "_control.boss_hp_root.bg",
			["battle/strong_buff_root/lock_bg"] = "_control.strong_buff_root.lock_bg",
			["battle/left/title_line"] = "_control.left.title_line",
			["battle/middle/stage_bg/clip"] = "_control.middle.stage_bg.clip",
			["battle/popup/combat_continue/frame/tip"] = "_control.popup.combat_continue.frame.tip",
			["battle/popup/combat_continue/frame/toggle_control/nightwarleft"] = "_control.popup.combat_continue.frame.nightwarleft",
			["battle/cutin_root/aircraft_mask"] = "_control.cutin_root.aircraft_mask",
			["battle/right/formation/title_mask/txt"] = "_control.right.formation.title_mask.txt",
			["battle/left/formation"] = "_control.left.formation",
			["battle/popup/combat_continue/frame/ui_combatcontinuetip"] = "_control.popup.combat_continue.frame.ui_combatcontinuetip",
			["battle/left/formation/title_mask/txt"] = "_control.left.formation.title_mask.txt",
			["battle/support_root/bg/mask"] = "_control.support_root.bg.mask",
			["battle/middle/stage_bg"] = "_control.middle.stage_bg",
			["battle/strong_buff_root/lock_info/lock_close"] = "_control.strong_buff_root.lock_info.lock_close",
			["battle/support_root/bg/line_effect_down"] = "_control.support_root.bg.line_effect_down",
			["battle/popup/combat_continue/frame/damagecontrol/buy"] = "_control.popup.combat_continue.frame.damagecontrol.buy",
			["battle/popup/combat_continue/frame/bullet/bullet_2"] = "_control.popup.combat_continue.frame.bullet.bullet_2",
			["battle/middle/stage_bg/stage1"] = "_control.middle.stage_bg.stage1",
			["battle/popup/combat_continue/frame/oil"] = "_control.popup.combat_continue.frame.oil",
			["battle/popup/combat_continue/frame/bullet/bullet_5"] = "_control.popup.combat_continue.frame.bullet.bullet_5",
			["battle/right/formation/title_mask"] = "_control.right.formation.title_mask",
			["battle/strong_buff_root/info_bg/info_text"] = "_control.strong_buff_root.info_bg.info_text",
			["battle/popup/combat_continue/frame/toggle_control/nightwarleft_btn/nightwarcontinue"] = "_control.popup.combat_continue.frame.nightwarleft_btn.nightwarcontinue",
			["battle/popup/combat_continue/frame/damagecontrol"] = "_control.popup.combat_continue.frame.damagecontrol",
			["battle/popup/combat_continue/frame/bullet/bullet_7"] = "_control.popup.combat_continue.frame.bullet.bullet_7",
			["battle/left/course"] = "_control.left.course",
			["battle/left/formation/title_mask"] = "_control.left.formation.title_mask",
			["battle/middle/stage_bg/stage2"] = "_control.middle.stage_bg.stage2",
			["battle/periscope_root/periscope/bg"] = "_control.periscope_root.periscope.bg",
			["battle/popup/combat_continue/frame/bullet/bullet_4"] = "_control.popup.combat_continue.frame.bullet.bullet_4",
			["battle/aircontrol_root"] = "_control.aircontrol_root",
			["battle/popup/combat_continue/frame/toggle_control/nightwarright_btn/nightwarcancel"] = "_control.popup.combat_continue.frame.nightwarright_btn.nightwarcancel"
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
			["popup/combat_continue/frame/toggle_control/nightwarleft_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["popup/combat_continue/frame/toggle_control/nightwarright_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["popup/combat_continue/frame/damagecontrol/buy"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["popup/combat_continue/frame/toggle_control/nightwarleft"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["popup/combat_continue/frame/toggle_control/nightwarright"] = {
				tp = "UnityEngine.UI.Toggle"
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

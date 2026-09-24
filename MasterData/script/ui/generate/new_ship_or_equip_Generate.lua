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
			back_btn = {
				path = "back_btn",
				list = {
					top_image = {
						path = "back_btn/top_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					down_image = {
						path = "back_btn/down_image",
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
			role_bg_anim = {
				path = "role_bg_anim",
				list = {},
				component = {
					"UnityEngine.Transform",
					"UnityEngine.MeshFilter",
					"UnityEngine.MeshRenderer",
					"Spine.Unity.SkeletonAnimation"
				}
			},
			new_ship = {
				path = "new_ship",
				list = {
					ship_role = {
						path = "new_ship/ship_role",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIScaleTweener",
							"UnityEngine.Canvas",
							"UnityEngine.UI.ContentSizeFitter"
						}
					},
					new_icon = {
						path = "new_ship/new_icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					ship_info = {
						path = "new_ship/ship_info",
						list = {
							ship_name = {
								path = "new_ship/ship_info/ship_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UIScaleTweener",
									"UnityEngine.UI.Shadow"
								}
							},
							ship_type = {
								path = "new_ship/ship_info/ship_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UIScaleTweener",
									"UnityEngine.UI.Shadow"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.Canvas"
						}
					},
					ship_dialog = {
						path = "new_ship/ship_dialog",
						list = {
							ship_ordinary_dialog = {
								path = "new_ship/ship_dialog/ship_ordinary_dialog",
								list = {},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							ship_skin_dialog = {
								path = "new_ship/ship_dialog/ship_skin_dialog",
								list = {
									dialog_bg = {
										path = "new_ship/ship_dialog/ship_skin_dialog/dialog_bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									text = {
										path = "new_ship/ship_dialog/ship_skin_dialog/text",
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
							"UIMoveTweener",
							"UnityEngine.Canvas"
						}
					},
					switch_layer = {
						path = "new_ship/switch_layer",
						list = {
							switch_title = {
								path = "new_ship/switch_layer/switch_title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UnityEngine.UI.ContentSizeFitter"
								}
							},
							switch_tip = {
								path = "new_ship/switch_layer/switch_tip",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							tip_dot = {
								path = "new_ship/switch_layer/tip_dot",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							line = {
								path = "new_ship/switch_layer/line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							toggle_group = {
								path = "new_ship/switch_layer/toggle_group",
								list = {
									tog_rs_1 = {
										path = "new_ship/switch_layer/toggle_group/tog_rs_1",
										list = {
											Background = {
												path = "new_ship/switch_layer/toggle_group/tog_rs_1/Background",
												list = {
													Checkmark = {
														path = "new_ship/switch_layer/toggle_group/tog_rs_1/Background/Checkmark",
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
											"UnityEngine.UI.Toggle"
										}
									},
									tog_rs_2 = {
										path = "new_ship/switch_layer/toggle_group/tog_rs_2",
										list = {
											Background = {
												path = "new_ship/switch_layer/toggle_group/tog_rs_2/Background",
												list = {
													Checkmark = {
														path = "new_ship/switch_layer/toggle_group/tog_rs_2/Background/Checkmark",
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
											"UnityEngine.UI.Toggle"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.ToggleGroup"
								}
							},
							confirm_btn = {
								path = "new_ship/switch_layer/confirm_btn",
								list = {
									title = {
										path = "new_ship/switch_layer/confirm_btn/title",
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
							rs_1 = {
								path = "new_ship/switch_layer/rs_1",
								list = {
									skill_icon = {
										path = "new_ship/switch_layer/rs_1/skill_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									skill_name = {
										path = "new_ship/switch_layer/rs_1/skill_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									active = {
										path = "new_ship/switch_layer/rs_1/active",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									skill_phase = {
										path = "new_ship/switch_layer/rs_1/skill_phase",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff = {
										path = "new_ship/switch_layer/rs_1/buff",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									scrollview = {
										path = "new_ship/switch_layer/rs_1/scrollview",
										list = {
											content = {
												path = "new_ship/switch_layer/rs_1/scrollview/content",
												list = {
													info_txt = {
														path = "new_ship/switch_layer/rs_1/scrollview/content/info_txt",
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
													"UnityEngine.UI.ContentSizeFitter",
													"UnityEngine.UI.VerticalLayoutGroup"
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
							rs_2 = {
								path = "new_ship/switch_layer/rs_2",
								list = {
									skill_name = {
										path = "new_ship/switch_layer/rs_2/skill_name",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									active = {
										path = "new_ship/switch_layer/rs_2/active",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									scrollview = {
										path = "new_ship/switch_layer/rs_2/scrollview",
										list = {
											content = {
												path = "new_ship/switch_layer/rs_2/scrollview/content",
												list = {
													info_txt = {
														path = "new_ship/switch_layer/rs_2/scrollview/content/info_txt",
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
													"UnityEngine.UI.ContentSizeFitter",
													"UnityEngine.UI.VerticalLayoutGroup"
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
									},
									skill_icon = {
										path = "new_ship/switch_layer/rs_2/skill_icon",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									skill_phase = {
										path = "new_ship/switch_layer/rs_2/skill_phase",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									buff = {
										path = "new_ship/switch_layer/rs_2/buff",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			new_equip = {
				path = "new_equip",
				list = {
					icon = {
						path = "new_equip/icon",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UIScaleTweener",
							"UnityEngine.Canvas"
						}
					},
					equip_info = {
						path = "new_equip/equip_info",
						list = {
							equip_name = {
								path = "new_equip/equip_info/equip_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UIScaleTweener",
									"UnityEngine.UI.Shadow"
								}
							},
							equip_type = {
								path = "new_equip/equip_info/equip_type",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text",
									"UIScaleTweener",
									"UnityEngine.UI.Shadow"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.Canvas"
						}
					},
					lock_toggle = {
						path = "new_equip/lock_toggle",
						list = {
							lock_state = {
								path = "new_equip/lock_toggle/lock_state",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Button"
								}
							},
							unlocklock_state = {
								path = "new_equip/lock_toggle/unlocklock_state",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence"
				}
			},
			star_anim = {
				path = "star_anim",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"Spine.Unity.SkeletonGraphic",
					"UnityEngine.Canvas"
				}
			},
			lock_toggle = {
				path = "lock_toggle",
				list = {
					lock_state = {
						path = "lock_toggle/lock_state",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Button"
						}
					},
					unlocklock_state = {
						path = "lock_toggle/unlocklock_state",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Button"
						}
					},
					ship_detail_btn = {
						path = "lock_toggle/ship_detail_btn",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UnityEngine.CanvasGroup"
				}
			},
			dialog_bg = {
				path = "dialog_bg",
				list = {
					scrollview = {
						path = "dialog_bg/scrollview",
						list = {
							content = {
								path = "dialog_bg/scrollview/content",
								list = {
									text = {
										path = "dialog_bg/scrollview/content/text",
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
									"UnityEngine.UI.ContentSizeFitter",
									"UnityEngine.UI.VerticalLayoutGroup"
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UnityEngine.CanvasGroup",
					"UnityEngine.UI.Image"
				}
			},
			new_anim = {
				path = "new_anim",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.MeshFilter",
					"UnityEngine.MeshRenderer",
					"Spine.Unity.SkeletonAnimation",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.Canvas"
				}
			}
		},
		call_node_list = {
			["new_ship_or_equip/lock_toggle/unlocklock_state"] = "_control.lock_toggle.unlocklock_state",
			["new_ship_or_equip/new_ship/switch_layer/rs_1"] = "_control.new_ship.switch_layer.rs_1",
			["new_ship_or_equip/new_ship/ship_info/ship_name"] = "_control.new_ship.ship_info.ship_name",
			["new_ship_or_equip/new_equip/equip_info/equip_type"] = "_control.new_equip.equip_info.equip_type",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/active"] = "_control.new_ship.switch_layer.rs_2.active",
			["new_ship_or_equip/new_ship/switch_layer"] = "_control.new_ship.switch_layer",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/skill_name"] = "_control.new_ship.switch_layer.rs_2.skill_name",
			["new_ship_or_equip/new_equip"] = "_control.new_equip",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/buff"] = "_control.new_ship.switch_layer.rs_2.buff",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/skill_phase"] = "_control.new_ship.switch_layer.rs_1.skill_phase",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/scrollview/content/info_txt"] = "_control.new_ship.switch_layer.rs_1.scrollview.content.info_txt",
			["new_ship_or_equip/new_ship/switch_layer/toggle_group/tog_rs_2/Background"] = "_control.new_ship.switch_layer.toggle_group.tog_rs_2.Background",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/scrollview"] = "_control.new_ship.switch_layer.rs_1.scrollview",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/scrollview/content"] = "_control.new_ship.switch_layer.rs_1.scrollview.content",
			["new_ship_or_equip/back_btn/top_image"] = "_control.back_btn.top_image",
			["new_ship_or_equip/new_ship/ship_dialog/ship_ordinary_dialog"] = "_control.new_ship.ship_dialog.ship_ordinary_dialog",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/buff"] = "_control.new_ship.switch_layer.rs_1.buff",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/skill_name"] = "_control.new_ship.switch_layer.rs_1.skill_name",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/skill_phase"] = "_control.new_ship.switch_layer.rs_2.skill_phase",
			["new_ship_or_equip/new_ship/switch_layer/tip_dot"] = "_control.new_ship.switch_layer.tip_dot",
			["new_ship_or_equip/new_equip/equip_info/equip_name"] = "_control.new_equip.equip_info.equip_name",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/skill_icon"] = "_control.new_ship.switch_layer.rs_1.skill_icon",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/scrollview/content/info_txt"] = "_control.new_ship.switch_layer.rs_2.scrollview.content.info_txt",
			["new_ship_or_equip/new_ship/ship_dialog"] = "_control.new_ship.ship_dialog",
			["new_ship_or_equip/back_btn"] = "_control.back_btn",
			["new_ship_or_equip/bg"] = "_control.bg",
			["new_ship_or_equip/new_ship/switch_layer/confirm_btn/title"] = "_control.new_ship.switch_layer.confirm_btn.title",
			["new_ship_or_equip/new_ship/switch_layer/toggle_group/tog_rs_1/Background"] = "_control.new_ship.switch_layer.toggle_group.tog_rs_1.Background",
			["new_ship_or_equip/new_ship/switch_layer/toggle_group/tog_rs_1/Background/Checkmark"] = "_control.new_ship.switch_layer.toggle_group.tog_rs_1.Background.Checkmark",
			["new_ship_or_equip/new_equip/lock_toggle/lock_state"] = "_control.new_equip.lock_toggle.lock_state",
			["new_ship_or_equip/dialog_bg/scrollview/content/text"] = "_control.dialog_bg.scrollview.content.text",
			["new_ship_or_equip/star_anim"] = "_control.star_anim",
			["new_ship_or_equip/new_ship/ship_dialog/ship_skin_dialog/dialog_bg"] = "_control.new_ship.ship_dialog.ship_skin_dialog.dialog_bg",
			["new_ship_or_equip/new_ship/switch_layer/confirm_btn"] = "_control.new_ship.switch_layer.confirm_btn",
			["new_ship_or_equip/new_ship/ship_info/ship_type"] = "_control.new_ship.ship_info.ship_type",
			["new_ship_or_equip/new_ship/switch_layer/toggle_group/tog_rs_2"] = "_control.new_ship.switch_layer.toggle_group.tog_rs_2",
			["new_ship_or_equip/new_ship/switch_layer/toggle_group"] = "_control.new_ship.switch_layer.toggle_group",
			["new_ship_or_equip/new_anim"] = "_control.new_anim",
			["new_ship_or_equip/new_ship/ship_dialog/ship_skin_dialog"] = "_control.new_ship.ship_dialog.ship_skin_dialog",
			["new_ship_or_equip/back_btn/down_image"] = "_control.back_btn.down_image",
			["new_ship_or_equip/lock_toggle/ship_detail_btn"] = "_control.lock_toggle.ship_detail_btn",
			["new_ship_or_equip/new_ship/switch_layer/toggle_group/tog_rs_2/Background/Checkmark"] = "_control.new_ship.switch_layer.toggle_group.tog_rs_2.Background.Checkmark",
			["new_ship_or_equip/new_ship/ship_dialog/ship_skin_dialog/text"] = "_control.new_ship.ship_dialog.ship_skin_dialog.text",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/skill_icon"] = "_control.new_ship.switch_layer.rs_2.skill_icon",
			["new_ship_or_equip/dialog_bg/scrollview"] = "_control.dialog_bg.scrollview",
			["new_ship_or_equip/lock_toggle/lock_state"] = "_control.lock_toggle.lock_state",
			["new_ship_or_equip/lock_toggle"] = "_control.lock_toggle",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/scrollview/content"] = "_control.new_ship.switch_layer.rs_2.scrollview.content",
			["new_ship_or_equip/new_ship/switch_layer/rs_2/scrollview"] = "_control.new_ship.switch_layer.rs_2.scrollview",
			["new_ship_or_equip/new_ship/ship_role"] = "_control.new_ship.ship_role",
			["new_ship_or_equip/new_equip/icon"] = "_control.new_equip.icon",
			["new_ship_or_equip/new_equip/lock_toggle/unlocklock_state"] = "_control.new_equip.lock_toggle.unlocklock_state",
			["new_ship_or_equip/new_ship/switch_layer/switch_title"] = "_control.new_ship.switch_layer.switch_title",
			["new_ship_or_equip/new_ship/switch_layer/switch_tip"] = "_control.new_ship.switch_layer.switch_tip",
			["new_ship_or_equip/new_ship/switch_layer/line"] = "_control.new_ship.switch_layer.line",
			["new_ship_or_equip/new_ship/ship_info"] = "_control.new_ship.ship_info",
			["new_ship_or_equip/role_bg_anim"] = "_control.role_bg_anim",
			["new_ship_or_equip/new_ship/switch_layer/rs_1/active"] = "_control.new_ship.switch_layer.rs_1.active",
			["new_ship_or_equip/new_equip/lock_toggle"] = "_control.new_equip.lock_toggle",
			["new_ship_or_equip/new_ship/switch_layer/rs_2"] = "_control.new_ship.switch_layer.rs_2",
			["new_ship_or_equip/new_ship/switch_layer/toggle_group/tog_rs_1"] = "_control.new_ship.switch_layer.toggle_group.tog_rs_1",
			["new_ship_or_equip/dialog_bg/scrollview/content"] = "_control.dialog_bg.scrollview.content",
			["new_ship_or_equip/new_equip/equip_info"] = "_control.new_equip.equip_info",
			["new_ship_or_equip/new_ship"] = "_control.new_ship",
			["new_ship_or_equip/new_ship/new_icon"] = "_control.new_ship.new_icon",
			["new_ship_or_equip/dialog_bg"] = "_control.dialog_bg"
		},
		click = {
			back_btn = {
				tp = "UnityEngine.UI.Button"
			},
			["new_ship/switch_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["new_equip/lock_toggle/lock_state"] = {
				tp = "UnityEngine.UI.Button"
			},
			["new_equip/lock_toggle/unlocklock_state"] = {
				tp = "UnityEngine.UI.Button"
			},
			["lock_toggle/lock_state"] = {
				tp = "UnityEngine.UI.Button"
			},
			["lock_toggle/unlocklock_state"] = {
				tp = "UnityEngine.UI.Button"
			},
			["lock_toggle/ship_detail_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["new_ship/switch_layer/toggle_group/tog_rs_1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["new_ship/switch_layer/toggle_group/tog_rs_2"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {
			ship_role = {
				component = "UnityEngine.Canvas",
				path = "new_ship/ship_role"
			},
			ship_info = {
				component = "UnityEngine.Canvas",
				path = "new_ship/ship_info"
			},
			ship_dialog = {
				component = "UnityEngine.Canvas",
				path = "new_ship/ship_dialog"
			},
			switch_layer = {
				component = "UnityEngine.Canvas",
				path = "new_ship/switch_layer"
			},
			icon = {
				component = "UnityEngine.Canvas",
				path = "new_equip/icon"
			},
			equip_info = {
				component = "UnityEngine.Canvas",
				path = "new_equip/equip_info"
			},
			star_anim = {
				component = "UnityEngine.Canvas",
				path = "star_anim"
			},
			lock_toggle = {
				component = "UnityEngine.Canvas",
				path = "lock_toggle"
			},
			dialog_bg = {
				component = "UnityEngine.Canvas",
				path = "dialog_bg"
			},
			new_anim = {
				component = "UnityEngine.Canvas",
				path = "new_anim"
			}
		}
	}
}

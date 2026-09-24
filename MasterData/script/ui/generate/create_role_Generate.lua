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
			ship_type_detail = {
				path = "ship_type_detail",
				list = {
					ship_type_bg = {
						path = "ship_type_detail/ship_type_bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					ship_type_name = {
						path = "ship_type_detail/ship_type_name",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					ship_role_name = {
						path = "ship_type_detail/ship_role_name",
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
			},
			title = {
				path = "title",
				list = {
					signinselectshipconfirm = {
						path = "title/signinselectshipconfirm",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					inputnickname = {
						path = "title/inputnickname",
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
			role = {
				path = "role",
				list = {
					role_image = {
						path = "role/role_image",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					desc_bg = {
						path = "role/desc_bg",
						list = {
							text = {
								path = "role/desc_bg/text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							signinselectnametitle = {
								path = "role/desc_bg/signinselectnametitle",
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
			select_role = {
				path = "select_role",
				list = {
					select_role_toggle = {
						path = "select_role/select_role_toggle",
						list = {
							createrolename1 = {
								path = "select_role/select_role_toggle/createrolename1",
								list = {
									initshipdesc1 = {
										path = "select_role/select_role_toggle/createrolename1/initshipdesc1",
										list = {
											Checkmark = {
												path = "select_role/select_role_toggle/createrolename1/initshipdesc1/Checkmark",
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
							createrolename2 = {
								path = "select_role/select_role_toggle/createrolename2",
								list = {
									initshipdesc2 = {
										path = "select_role/select_role_toggle/createrolename2/initshipdesc2",
										list = {
											Checkmark = {
												path = "select_role/select_role_toggle/createrolename2/initshipdesc2/Checkmark",
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
							createrolename3 = {
								path = "select_role/select_role_toggle/createrolename3",
								list = {
									initshipdesc3 = {
										path = "select_role/select_role_toggle/createrolename3/initshipdesc3",
										list = {
											Checkmark = {
												path = "select_role/select_role_toggle/createrolename3/initshipdesc3/Checkmark",
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
							createrolename4 = {
								path = "select_role/select_role_toggle/createrolename4",
								list = {
									initshipdesc4 = {
										path = "select_role/select_role_toggle/createrolename4/initshipdesc4",
										list = {
											Checkmark = {
												path = "select_role/select_role_toggle/createrolename4/initshipdesc4/Checkmark",
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
					create_next_btn = {
						path = "select_role/create_next_btn",
						list = {
							ui_create_next = {
								path = "select_role/create_next_btn/ui_create_next",
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
					account_merge_btn = {
						path = "select_role/account_merge_btn",
						list = {
							ui_aaccount_merge = {
								path = "select_role/account_merge_btn/ui_aaccount_merge",
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
					"UIMoveTweener",
					"UITweenSequence"
				}
			},
			input_name = {
				path = "input_name",
				list = {
					random_btn = {
						path = "input_name/random_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					InputField = {
						path = "input_name/InputField",
						list = {
							Placeholder = {
								path = "input_name/InputField/Placeholder",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							Text = {
								path = "input_name/InputField/Text",
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
							"UnityEngine.UI.InputField"
						}
					},
					start_game_btn = {
						path = "input_name/start_game_btn",
						list = {
							startgame = {
								path = "input_name/start_game_btn/startgame",
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
					"UIMoveTweener",
					"UITweenSequence"
				}
			},
			account_merge = {
				path = "account_merge",
				list = {
					merge_frame = {
						path = "account_merge/merge_frame",
						list = {
							content = {
								path = "account_merge/merge_frame/content",
								list = {
									close_btn = {
										path = "account_merge/merge_frame/content/close_btn",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image",
											"UnityEngine.UI.Button"
										}
									},
									arrow_image = {
										path = "account_merge/merge_frame/content/arrow_image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									enterrolecode = {
										path = "account_merge/merge_frame/content/enterrolecode",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									line = {
										path = "account_merge/merge_frame/content/line",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									InputField = {
										path = "account_merge/merge_frame/content/InputField",
										list = {
											enteryourrolecode = {
												path = "account_merge/merge_frame/content/InputField/enteryourrolecode",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											Text = {
												path = "account_merge/merge_frame/content/InputField/Text",
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
											"UnityEngine.UI.InputField"
										}
									},
									enterrolecodeinfo = {
										path = "account_merge/merge_frame/content/enterrolecodeinfo",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									confirm_btn = {
										path = "account_merge/merge_frame/content/confirm_btn",
										list = {
											confirm = {
												path = "account_merge/merge_frame/content/confirm_btn/confirm",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["create_role/select_role/account_merge_btn"] = "_control.select_role.account_merge_btn",
			["create_role/select_role/select_role_toggle/createrolename3/initshipdesc3"] = "_control.select_role.select_role_toggle.createrolename3.initshipdesc3",
			["create_role/select_role/select_role_toggle/createrolename4/initshipdesc4"] = "_control.select_role.select_role_toggle.createrolename4.initshipdesc4",
			["create_role/select_role/select_role_toggle/createrolename4/initshipdesc4/Checkmark"] = "_control.select_role.select_role_toggle.createrolename4.initshipdesc4.Checkmark",
			["create_role/account_merge"] = "_control.account_merge",
			["create_role/ship_type_detail/ship_type_name"] = "_control.ship_type_detail.ship_type_name",
			["create_role/select_role/select_role_toggle/createrolename2/initshipdesc2/Checkmark"] = "_control.select_role.select_role_toggle.createrolename2.initshipdesc2.Checkmark",
			["create_role/select_role/select_role_toggle/createrolename1/initshipdesc1/Checkmark"] = "_control.select_role.select_role_toggle.createrolename1.initshipdesc1.Checkmark",
			["create_role/ship_type_detail/ship_type_bg"] = "_control.ship_type_detail.ship_type_bg",
			["create_role/input_name/start_game_btn/startgame"] = "_control.input_name.start_game_btn.startgame",
			["create_role/ship_type_detail/ship_role_name"] = "_control.ship_type_detail.ship_role_name",
			["create_role/input_name/InputField/Text"] = "_control.input_name.InputField.Text",
			["create_role/select_role/select_role_toggle/createrolename3"] = "_control.select_role.select_role_toggle.createrolename3",
			["create_role/input_name/InputField/Placeholder"] = "_control.input_name.InputField.Placeholder",
			["create_role/role/desc_bg/signinselectnametitle"] = "_control.role.desc_bg.signinselectnametitle",
			["create_role/input_name/random_btn"] = "_control.input_name.random_btn",
			["create_role/select_role/create_next_btn/ui_create_next"] = "_control.select_role.create_next_btn.ui_create_next",
			["create_role/select_role/create_next_btn"] = "_control.select_role.create_next_btn",
			["create_role/select_role/select_role_toggle/createrolename3/initshipdesc3/Checkmark"] = "_control.select_role.select_role_toggle.createrolename3.initshipdesc3.Checkmark",
			["create_role/title/signinselectshipconfirm"] = "_control.title.signinselectshipconfirm",
			["create_role/account_merge/merge_frame/content/enterrolecode"] = "_control.account_merge.merge_frame.content.enterrolecode",
			["create_role/account_merge/merge_frame/content/line"] = "_control.account_merge.merge_frame.content.line",
			["create_role/select_role/select_role_toggle"] = "_control.select_role.select_role_toggle",
			["create_role/select_role"] = "_control.select_role",
			["create_role/select_role/select_role_toggle/createrolename1"] = "_control.select_role.select_role_toggle.createrolename1",
			["create_role/ship_type_detail"] = "_control.ship_type_detail",
			["create_role/account_merge/merge_frame/content/InputField"] = "_control.account_merge.merge_frame.content.InputField",
			["create_role/role/role_image"] = "_control.role.role_image",
			["create_role/bg"] = "_control.bg",
			["create_role/account_merge/merge_frame/content/InputField/enteryourrolecode"] = "_control.account_merge.merge_frame.content.InputField.enteryourrolecode",
			["create_role/account_merge/merge_frame/content/InputField/Text"] = "_control.account_merge.merge_frame.content.InputField.Text",
			["create_role/account_merge/merge_frame"] = "_control.account_merge.merge_frame",
			["create_role/account_merge/merge_frame/content/confirm_btn"] = "_control.account_merge.merge_frame.content.confirm_btn",
			["create_role/account_merge/merge_frame/content/arrow_image"] = "_control.account_merge.merge_frame.content.arrow_image",
			["create_role/account_merge/merge_frame/content/confirm_btn/confirm"] = "_control.account_merge.merge_frame.content.confirm_btn.confirm",
			["create_role/input_name/InputField"] = "_control.input_name.InputField",
			["create_role/account_merge/merge_frame/content/close_btn"] = "_control.account_merge.merge_frame.content.close_btn",
			["create_role/role/desc_bg"] = "_control.role.desc_bg",
			["create_role/role/desc_bg/text"] = "_control.role.desc_bg.text",
			["create_role/title"] = "_control.title",
			["create_role/select_role/select_role_toggle/createrolename2/initshipdesc2"] = "_control.select_role.select_role_toggle.createrolename2.initshipdesc2",
			["create_role/select_role/select_role_toggle/createrolename1/initshipdesc1"] = "_control.select_role.select_role_toggle.createrolename1.initshipdesc1",
			["create_role/account_merge/merge_frame/content"] = "_control.account_merge.merge_frame.content",
			["create_role/select_role/select_role_toggle/createrolename4"] = "_control.select_role.select_role_toggle.createrolename4",
			["create_role/account_merge/merge_frame/content/enterrolecodeinfo"] = "_control.account_merge.merge_frame.content.enterrolecodeinfo",
			["create_role/input_name/start_game_btn"] = "_control.input_name.start_game_btn",
			["create_role/title/inputnickname"] = "_control.title.inputnickname",
			["create_role/select_role/account_merge_btn/ui_aaccount_merge"] = "_control.select_role.account_merge_btn.ui_aaccount_merge",
			["create_role/input_name"] = "_control.input_name",
			["create_role/select_role/select_role_toggle/createrolename2"] = "_control.select_role.select_role_toggle.createrolename2",
			["create_role/role"] = "_control.role"
		},
		click = {
			["select_role/create_next_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["select_role/account_merge_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["input_name/random_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["input_name/start_game_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["account_merge/merge_frame/content/close_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["account_merge/merge_frame/content/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["select_role/select_role_toggle/createrolename1"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["select_role/select_role_toggle/createrolename2"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["select_role/select_role_toggle/createrolename3"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["select_role/select_role_toggle/createrolename4"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

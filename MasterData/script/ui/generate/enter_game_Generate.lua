return {
	_rule_ = {
		none = {
			wait = {
				path = "wait",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"TweenRotation"
				}
			},
			all_object = {
				path = "all_object",
				list = {
					logo = {
						path = "all_object/logo",
						list = {
							logo_image = {
								path = "all_object/logo/logo_image",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					uid = {
						path = "all_object/uid",
						list = {
							bg = {
								path = "all_object/uid/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							uuid = {
								path = "all_object/uid/uuid",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							versioncode = {
								path = "all_object/uid/versioncode",
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
					account_btn = {
						path = "all_object/account_btn",
						list = {
							ui_account_manager = {
								path = "all_object/account_btn/ui_account_manager",
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
							"UnityEngine.CanvasGroup"
						}
					},
					enter_btn = {
						path = "all_object/enter_btn",
						list = {
							signinselectserverstart = {
								path = "all_object/enter_btn/signinselectserverstart",
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
							"UnityEngine.CanvasGroup"
						}
					},
					single_server_bar = {
						path = "all_object/single_server_bar",
						list = {
							bar_bg = {
								path = "all_object/single_server_bar/bar_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							server_name = {
								path = "all_object/single_server_bar/server_name",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							m_proleflag = {
								path = "all_object/single_server_bar/m_proleflag",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							status_tip = {
								path = "all_object/single_server_bar/status_tip",
								list = {
									red = {
										path = "all_object/single_server_bar/status_tip/red",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									green = {
										path = "all_object/single_server_bar/status_tip/green",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									gery = {
										path = "all_object/single_server_bar/status_tip/gery",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									yellow = {
										path = "all_object/single_server_bar/status_tip/yellow",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							signiinselctserverchangeserver = {
								path = "all_object/single_server_bar/signiinselctserverchangeserver",
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
					common_mark_btn = {
						path = "all_object/common_mark_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					common_mark_txt = {
						path = "all_object/common_mark_txt",
						list = {
							tip = {
								path = "all_object/common_mark_txt/tip",
								list = {
									image = {
										path = "all_object/common_mark_txt/tip/image",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									image_1 = {
										path = "all_object/common_mark_txt/tip/image_1",
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
									"UnityEngine.UI.Text"
								}
							},
							txt = {
								path = "all_object/common_mark_txt/txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							confim_btn = {
								path = "all_object/common_mark_txt/confim_btn",
								list = {
									Text = {
										path = "all_object/common_mark_txt/confim_btn/Text",
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
							"UnityEngine.UI.Image"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			hoolai_need = {
				path = "hoolai_need",
				list = {},
				component = {}
			},
			yyb_agreement = {
				path = "yyb_agreement",
				list = {
					text = {
						path = "yyb_agreement/text",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					text1 = {
						path = "yyb_agreement/text1",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					text2 = {
						path = "yyb_agreement/text2",
						list = {},
						component = {}
					},
					text3 = {
						path = "yyb_agreement/text3",
						list = {},
						component = {}
					},
					button = {
						path = "yyb_agreement/button",
						list = {
							text = {
								path = "yyb_agreement/button/text",
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
					button1 = {
						path = "yyb_agreement/button1",
						list = {
							text = {
								path = "yyb_agreement/button1/text",
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
					button2 = {
						path = "yyb_agreement/button2",
						list = {
							text = {
								path = "yyb_agreement/button2/text",
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
					button3 = {
						path = "yyb_agreement/button3",
						list = {
							text = {
								path = "yyb_agreement/button3/text",
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
					toggle = {
						path = "yyb_agreement/toggle",
						list = {
							bg = {
								path = "yyb_agreement/toggle/bg",
								list = {
									checkmark = {
										path = "yyb_agreement/toggle/bg/checkmark",
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
					button4 = {
						path = "yyb_agreement/button4",
						list = {
							text = {
								path = "yyb_agreement/button4/text",
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
			},
			test_btn = {
				path = "test_btn",
				list = {
					text = {
						path = "test_btn/text",
						list = {},
						component = {}
					}
				},
				component = {
					"UnityEngine.UI.Button"
				}
			},
			test_btn_two = {
				path = "test_btn_two",
				list = {
					text = {
						path = "test_btn_two/text",
						list = {},
						component = {}
					}
				},
				component = {
					"UnityEngine.UI.Button"
				}
			}
		},
		call_node_list = {
			["enter_game/yyb_agreement/text3"] = "_control.yyb_agreement.text3",
			["enter_game/all_object/single_server_bar"] = "_control.all_object.single_server_bar",
			["enter_game/yyb_agreement/button1/text"] = "_control.yyb_agreement.button1.text",
			["enter_game/all_object/enter_btn"] = "_control.all_object.enter_btn",
			["enter_game/all_object/single_server_bar/status_tip/gery"] = "_control.all_object.single_server_bar.status_tip.gery",
			["enter_game/all_object/common_mark_txt"] = "_control.all_object.common_mark_txt",
			["enter_game/all_object/single_server_bar/server_name"] = "_control.all_object.single_server_bar.server_name",
			["enter_game/all_object/uid"] = "_control.all_object.uid",
			["enter_game/all_object/uid/uuid"] = "_control.all_object.uid.uuid",
			["enter_game/all_object/single_server_bar/status_tip/yellow"] = "_control.all_object.single_server_bar.status_tip.yellow",
			["enter_game/yyb_agreement/text1"] = "_control.yyb_agreement.text1",
			["enter_game/all_object/common_mark_txt/confim_btn/Text"] = "_control.all_object.common_mark_txt.confim_btn.Text",
			["enter_game/all_object/single_server_bar/status_tip/red"] = "_control.all_object.single_server_bar.status_tip.red",
			["enter_game/yyb_agreement/button"] = "_control.yyb_agreement.button",
			["enter_game/yyb_agreement/text"] = "_control.yyb_agreement.text",
			["enter_game/test_btn_two/text"] = "_control.test_btn_two.text",
			["enter_game/yyb_agreement"] = "_control.yyb_agreement",
			["enter_game/yyb_agreement/button1"] = "_control.yyb_agreement.button1",
			["enter_game/all_object/logo"] = "_control.all_object.logo",
			["enter_game/all_object/single_server_bar/status_tip"] = "_control.all_object.single_server_bar.status_tip",
			["enter_game/yyb_agreement/button4"] = "_control.yyb_agreement.button4",
			["enter_game/yyb_agreement/button2/text"] = "_control.yyb_agreement.button2.text",
			["enter_game/yyb_agreement/button3"] = "_control.yyb_agreement.button3",
			["enter_game/yyb_agreement/button3/text"] = "_control.yyb_agreement.button3.text",
			["enter_game/all_object/enter_btn/signinselectserverstart"] = "_control.all_object.enter_btn.signinselectserverstart",
			["enter_game/all_object/single_server_bar/m_proleflag"] = "_control.all_object.single_server_bar.m_proleflag",
			["enter_game/yyb_agreement/text2"] = "_control.yyb_agreement.text2",
			["enter_game/yyb_agreement/toggle"] = "_control.yyb_agreement.toggle",
			["enter_game/yyb_agreement/toggle/bg"] = "_control.yyb_agreement.toggle.bg",
			["enter_game/all_object/single_server_bar/status_tip/green"] = "_control.all_object.single_server_bar.status_tip.green",
			["enter_game/all_object/common_mark_txt/tip/image"] = "_control.all_object.common_mark_txt.tip.image",
			["enter_game/all_object/account_btn/ui_account_manager"] = "_control.all_object.account_btn.ui_account_manager",
			["enter_game/all_object/common_mark_btn"] = "_control.all_object.common_mark_btn",
			["enter_game/all_object/uid/bg"] = "_control.all_object.uid.bg",
			["enter_game/all_object"] = "_control.all_object",
			["enter_game/yyb_agreement/toggle/bg/checkmark"] = "_control.yyb_agreement.toggle.bg.checkmark",
			["enter_game/yyb_agreement/button2"] = "_control.yyb_agreement.button2",
			["enter_game/yyb_agreement/button4/text"] = "_control.yyb_agreement.button4.text",
			["enter_game/all_object/common_mark_txt/txt"] = "_control.all_object.common_mark_txt.txt",
			["enter_game/all_object/single_server_bar/signiinselctserverchangeserver"] = "_control.all_object.single_server_bar.signiinselctserverchangeserver",
			["enter_game/test_btn_two"] = "_control.test_btn_two",
			["enter_game/test_btn"] = "_control.test_btn",
			["enter_game/yyb_agreement/button/text"] = "_control.yyb_agreement.button.text",
			["enter_game/hoolai_need"] = "_control.hoolai_need",
			["enter_game/all_object/logo/logo_image"] = "_control.all_object.logo.logo_image",
			["enter_game/wait"] = "_control.wait",
			["enter_game/all_object/common_mark_txt/tip"] = "_control.all_object.common_mark_txt.tip",
			["enter_game/all_object/common_mark_txt/confim_btn"] = "_control.all_object.common_mark_txt.confim_btn",
			["enter_game/all_object/common_mark_txt/tip/image_1"] = "_control.all_object.common_mark_txt.tip.image_1",
			["enter_game/test_btn/text"] = "_control.test_btn.text",
			["enter_game/all_object/account_btn"] = "_control.all_object.account_btn",
			["enter_game/all_object/single_server_bar/bar_bg"] = "_control.all_object.single_server_bar.bar_bg",
			["enter_game/all_object/uid/versioncode"] = "_control.all_object.uid.versioncode"
		},
		click = {
			["all_object/account_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["all_object/enter_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["all_object/single_server_bar/bar_bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["all_object/common_mark_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["all_object/common_mark_txt/confim_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["yyb_agreement/button"] = {
				tp = "UnityEngine.UI.Button"
			},
			["yyb_agreement/button1"] = {
				tp = "UnityEngine.UI.Button"
			},
			["yyb_agreement/button2"] = {
				tp = "UnityEngine.UI.Button"
			},
			["yyb_agreement/button3"] = {
				tp = "UnityEngine.UI.Button"
			},
			["yyb_agreement/button4"] = {
				tp = "UnityEngine.UI.Button"
			},
			test_btn = {
				tp = "UnityEngine.UI.Button"
			},
			test_btn_two = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["yyb_agreement/toggle"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

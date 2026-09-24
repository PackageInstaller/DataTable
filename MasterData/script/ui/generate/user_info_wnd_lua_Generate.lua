return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {}
			},
			OrderBox = {
				path = "OrderBox",
				list = {
					Left = {
						path = "OrderBox/Left",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					Close = {
						path = "OrderBox/Close",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			},
			ButtonBox = {
				path = "ButtonBox",
				list = {
					OutButton = {
						path = "ButtonBox/OutButton",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					BindButton = {
						path = "ButtonBox/BindButton",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {}
			},
			UserInfoBox = {
				path = "UserInfoBox",
				list = {
					Head = {
						path = "UserInfoBox/Head",
						list = {},
						component = {
							"UnityEngine.UI.Image"
						}
					},
					UserName = {
						path = "UserInfoBox/UserName",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					ChangShow = {
						path = "UserInfoBox/ChangShow",
						list = {
							ChangePass = {
								path = "UserInfoBox/ChangShow/ChangePass",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							},
							bindmailinfo = {
								path = "UserInfoBox/ChangShow/bindmailinfo",
								list = {
									BindMail = {
										path = "UserInfoBox/ChangShow/bindmailinfo/BindMail",
										list = {},
										component = {
											"UnityEngine.UI.Button"
										}
									},
									BindMailsuccess = {
										path = "UserInfoBox/ChangShow/bindmailinfo/BindMailsuccess",
										list = {},
										component = {}
									}
								},
								component = {}
							},
							bindphoneinfo = {
								path = "UserInfoBox/ChangShow/bindphoneinfo",
								list = {
									BindPhone = {
										path = "UserInfoBox/ChangShow/bindphoneinfo/BindPhone",
										list = {},
										component = {
											"UnityEngine.UI.Button"
										}
									},
									BindPhoneSuccess = {
										path = "UserInfoBox/ChangShow/bindphoneinfo/BindPhoneSuccess",
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
				component = {}
			},
			resetpasswordWnd = {
				path = "resetpasswordWnd",
				list = {
					OrderBox = {
						path = "resetpasswordWnd/OrderBox",
						list = {
							Left = {
								path = "resetpasswordWnd/OrderBox/Left",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							},
							Close = {
								path = "resetpasswordWnd/OrderBox/Close",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					verifyButton = {
						path = "resetpasswordWnd/verifyButton",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					RegiesterAll = {
						path = "resetpasswordWnd/RegiesterAll",
						list = {
							oldpass = {
								path = "resetpasswordWnd/RegiesterAll/oldpass",
								list = {
									password = {
										path = "resetpasswordWnd/RegiesterAll/oldpass/password",
										list = {
											Text = {
												path = "resetpasswordWnd/RegiesterAll/oldpass/password/Text",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.InputField"
										}
									}
								},
								component = {}
							},
							newpass = {
								path = "resetpasswordWnd/RegiesterAll/newpass",
								list = {
									password = {
										path = "resetpasswordWnd/RegiesterAll/newpass/password",
										list = {
											Text = {
												path = "resetpasswordWnd/RegiesterAll/newpass/password/Text",
												list = {},
												component = {}
											}
										},
										component = {
											"UnityEngine.UI.InputField"
										}
									}
								},
								component = {}
							},
							againpass = {
								path = "resetpasswordWnd/RegiesterAll/againpass",
								list = {
									againword = {
										path = "resetpasswordWnd/RegiesterAll/againpass/againword",
										list = {
											Text = {
												path = "resetpasswordWnd/RegiesterAll/againpass/againword/Text",
												list = {},
												component = {
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {
											"UnityEngine.UI.InputField"
										}
									}
								},
								component = {}
							}
						},
						component = {}
					}
				},
				component = {}
			},
			bindmail = {
				path = "bindmail",
				list = {
					OrderBox = {
						path = "bindmail/OrderBox",
						list = {
							Left = {
								path = "bindmail/OrderBox/Left",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							},
							Close = {
								path = "bindmail/OrderBox/Close",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					},
					RegBox = {
						path = "bindmail/RegBox",
						list = {
							UserName = {
								path = "bindmail/RegBox/UserName",
								list = {
									Placeholder = {
										path = "bindmail/RegBox/UserName/Placeholder",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									Text = {
										path = "bindmail/RegBox/UserName/Text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.InputField"
								}
							}
						},
						component = {}
					},
					FindButton = {
						path = "bindmail/FindButton",
						list = {},
						component = {
							"UnityEngine.UI.Button"
						}
					},
					Tips = {
						path = "bindmail/Tips",
						list = {},
						component = {
							"UnityEngine.UI.Text"
						}
					},
					FinishFind = {
						path = "bindmail/FinishFind",
						list = {
							Text = {
								path = "bindmail/FinishFind/Text",
								list = {},
								component = {
									"UnityEngine.UI.Text"
								}
							},
							BackBtn = {
								path = "bindmail/FinishFind/BackBtn",
								list = {},
								component = {
									"UnityEngine.UI.Button"
								}
							}
						},
						component = {}
					}
				},
				component = {}
			}
		},
		call_node_list = {
			["user_info_wnd_lua/bindmail/OrderBox/Close"] = "_control.bindmail.OrderBox.Close",
			["user_info_wnd_lua/OrderBox/Left"] = "_control.OrderBox.Left",
			["user_info_wnd_lua/bindmail/OrderBox"] = "_control.bindmail.OrderBox",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/againpass/againword"] = "_control.resetpasswordWnd.RegiesterAll.againpass.againword",
			["user_info_wnd_lua/UserInfoBox/UserName"] = "_control.UserInfoBox.UserName",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/newpass"] = "_control.resetpasswordWnd.RegiesterAll.newpass",
			["user_info_wnd_lua/bindmail/OrderBox/Left"] = "_control.bindmail.OrderBox.Left",
			["user_info_wnd_lua/resetpasswordWnd/OrderBox/Left"] = "_control.resetpasswordWnd.OrderBox.Left",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/newpass/password"] = "_control.resetpasswordWnd.RegiesterAll.newpass.password",
			["user_info_wnd_lua/resetpasswordWnd"] = "_control.resetpasswordWnd",
			["user_info_wnd_lua/UserInfoBox/ChangShow/bindphoneinfo/BindPhoneSuccess"] = "_control.UserInfoBox.ChangShow.bindphoneinfo.BindPhoneSuccess",
			["user_info_wnd_lua/resetpasswordWnd/verifyButton"] = "_control.resetpasswordWnd.verifyButton",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/oldpass/password/Text"] = "_control.resetpasswordWnd.RegiesterAll.oldpass.password.Text",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll"] = "_control.resetpasswordWnd.RegiesterAll",
			["user_info_wnd_lua/UserInfoBox/ChangShow/bindphoneinfo"] = "_control.UserInfoBox.ChangShow.bindphoneinfo",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/againpass/againword/Text"] = "_control.resetpasswordWnd.RegiesterAll.againpass.againword.Text",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/oldpass"] = "_control.resetpasswordWnd.RegiesterAll.oldpass",
			["user_info_wnd_lua/UserInfoBox/ChangShow/bindmailinfo/BindMail"] = "_control.UserInfoBox.ChangShow.bindmailinfo.BindMail",
			["user_info_wnd_lua/bindmail"] = "_control.bindmail",
			["user_info_wnd_lua/resetpasswordWnd/OrderBox"] = "_control.resetpasswordWnd.OrderBox",
			["user_info_wnd_lua/UserInfoBox/ChangShow/bindmailinfo"] = "_control.UserInfoBox.ChangShow.bindmailinfo",
			["user_info_wnd_lua/resetpasswordWnd/OrderBox/Close"] = "_control.resetpasswordWnd.OrderBox.Close",
			["user_info_wnd_lua/ButtonBox/BindButton"] = "_control.ButtonBox.BindButton",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/oldpass/password"] = "_control.resetpasswordWnd.RegiesterAll.oldpass.password",
			["user_info_wnd_lua/bindmail/RegBox/UserName"] = "_control.bindmail.RegBox.UserName",
			["user_info_wnd_lua/bindmail/RegBox/UserName/Text"] = "_control.bindmail.RegBox.UserName.Text",
			["user_info_wnd_lua/bindmail/Tips"] = "_control.bindmail.Tips",
			["user_info_wnd_lua/OrderBox"] = "_control.OrderBox",
			["user_info_wnd_lua/bindmail/FindButton"] = "_control.bindmail.FindButton",
			["user_info_wnd_lua/bindmail/FinishFind/BackBtn"] = "_control.bindmail.FinishFind.BackBtn",
			["user_info_wnd_lua/bindmail/FinishFind"] = "_control.bindmail.FinishFind",
			["user_info_wnd_lua/bg"] = "_control.bg",
			["user_info_wnd_lua/UserInfoBox/ChangShow/bindphoneinfo/BindPhone"] = "_control.UserInfoBox.ChangShow.bindphoneinfo.BindPhone",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/newpass/password/Text"] = "_control.resetpasswordWnd.RegiesterAll.newpass.password.Text",
			["user_info_wnd_lua/UserInfoBox/ChangShow/ChangePass"] = "_control.UserInfoBox.ChangShow.ChangePass",
			["user_info_wnd_lua/ButtonBox"] = "_control.ButtonBox",
			["user_info_wnd_lua/UserInfoBox/Head"] = "_control.UserInfoBox.Head",
			["user_info_wnd_lua/bindmail/RegBox/UserName/Placeholder"] = "_control.bindmail.RegBox.UserName.Placeholder",
			["user_info_wnd_lua/UserInfoBox/ChangShow"] = "_control.UserInfoBox.ChangShow",
			["user_info_wnd_lua/UserInfoBox/ChangShow/bindmailinfo/BindMailsuccess"] = "_control.UserInfoBox.ChangShow.bindmailinfo.BindMailsuccess",
			["user_info_wnd_lua/ButtonBox/OutButton"] = "_control.ButtonBox.OutButton",
			["user_info_wnd_lua/resetpasswordWnd/RegiesterAll/againpass"] = "_control.resetpasswordWnd.RegiesterAll.againpass",
			["user_info_wnd_lua/bindmail/RegBox"] = "_control.bindmail.RegBox",
			["user_info_wnd_lua/OrderBox/Close"] = "_control.OrderBox.Close",
			["user_info_wnd_lua/bindmail/FinishFind/Text"] = "_control.bindmail.FinishFind.Text",
			["user_info_wnd_lua/UserInfoBox"] = "_control.UserInfoBox"
		},
		click = {
			["OrderBox/Left"] = {
				tp = "UnityEngine.UI.Button"
			},
			["OrderBox/Close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ButtonBox/OutButton"] = {
				tp = "UnityEngine.UI.Button"
			},
			["ButtonBox/BindButton"] = {
				tp = "UnityEngine.UI.Button"
			},
			["UserInfoBox/ChangShow/ChangePass"] = {
				tp = "UnityEngine.UI.Button"
			},
			["UserInfoBox/ChangShow/bindmailinfo/BindMail"] = {
				tp = "UnityEngine.UI.Button"
			},
			["UserInfoBox/ChangShow/bindphoneinfo/BindPhone"] = {
				tp = "UnityEngine.UI.Button"
			},
			["resetpasswordWnd/OrderBox/Left"] = {
				tp = "UnityEngine.UI.Button"
			},
			["resetpasswordWnd/OrderBox/Close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["resetpasswordWnd/verifyButton"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bindmail/OrderBox/Left"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bindmail/OrderBox/Close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bindmail/FindButton"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bindmail/FinishFind/BackBtn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

return {
	_rule_ = {
		none = {
			main = {
				path = "main",
				list = {
					bg = {
						path = "main/bg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					line = {
						path = "main/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					shadow = {
						path = "main/shadow",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					introduction = {
						path = "main/introduction",
						list = {
							text = {
								path = "main/introduction/text",
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
					logintime = {
						path = "main/logintime",
						list = {
							time = {
								path = "main/logintime/time",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							recently = {
								path = "main/logintime/recently",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							btn = {
								path = "main/logintime/btn",
								list = {
									text = {
										path = "main/logintime/btn/text",
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
					lv = {
						path = "main/lv",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					playername = {
						path = "main/playername",
						list = {
							playername_1 = {
								path = "main/playername/playername_1",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							playername_2 = {
								path = "main/playername/playername_2",
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
							"UnityEngine.UI.Mask",
							"TextHorizonScroller",
							"UnityEngine.UI.Image"
						}
					},
					head = {
						path = "main/head",
						list = {
							img = {
								path = "main/head/img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							newimg = {
								path = "main/head/newimg",
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
					rankimg = {
						path = "main/rankimg",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					info = {
						path = "main/info",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					unknowtwo = {
						path = "main/unknowtwo",
						list = {
							btn = {
								path = "main/unknowtwo/btn",
								list = {
									text = {
										path = "main/unknowtwo/btn/text",
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
					acceptorrefuse = {
						path = "main/acceptorrefuse",
						list = {
							accept = {
								path = "main/acceptorrefuse/accept",
								list = {
									text = {
										path = "main/acceptorrefuse/accept/text",
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
							refuse = {
								path = "main/acceptorrefuse/refuse",
								list = {
									text = {
										path = "main/acceptorrefuse/refuse/text",
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
					unknow = {
						path = "main/unknow",
						list = {
							btnone = {
								path = "main/unknow/btnone",
								list = {
									text = {
										path = "main/unknow/btnone/text",
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
							guard = {
								path = "main/unknow/guard",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							btntwo = {
								path = "main/unknow/btntwo",
								list = {
									text = {
										path = "main/unknow/btntwo/text",
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
					top_img = {
						path = "main/top_img",
						list = {},
						component = {}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			}
		},
		call_node_list = {
			["friendcell/main/unknow"] = "_control.main.unknow",
			["friendcell/main/unknowtwo"] = "_control.main.unknowtwo",
			["friendcell/main/logintime/btn/text"] = "_control.main.logintime.btn.text",
			["friendcell/main/logintime/time_mask/txt_2"] = "_control.main.logintime.time_mask.txt_2",
			["friendcell/main/info"] = "_control.main.info",
			["friendcell/main/logintime/btn"] = "_control.main.logintime.btn",
			["friendcell/main/bg"] = "_control.main.bg",
			["friendcell/main/logintime/time"] = "_control.main.logintime.time",
			["friendcell/main/line"] = "_control.main.line",
			["friendcell/main/shadow"] = "_control.main.shadow",
			["friendcell/main"] = "_control.main",
			["friendcell/main/acceptorrefuse/accept/text"] = "_control.main.acceptorrefuse.accept.text",
			["friendcell/main/unknow/btnone"] = "_control.main.unknow.btnone",
			["friendcell/main/unknow/btnone/text"] = "_control.main.unknow.btnone.text",
			["friendcell/main/unknow/guard"] = "_control.main.unknow.guard",
			["friendcell/main/unknow/btntwo/text"] = "_control.main.unknow.btntwo.text",
			["friendcell/main/logintime"] = "_control.main.logintime",
			["friendcell/main/playername"] = "_control.main.playername",
			["friendcell/main/acceptorrefuse/refuse"] = "_control.main.acceptorrefuse.refuse",
			["friendcell/main/head/img"] = "_control.main.head.img",
			["friendcell/main/acceptorrefuse/accept"] = "_control.main.acceptorrefuse.accept",
			["friendcell/main/head"] = "_control.main.head",
			["friendcell/main/rankimg"] = "_control.main.rankimg",
			["friendcell/main/head/newimg/text"] = "_control.main.head.newimg.text",
			["friendcell/main/introduction"] = "_control.main.introduction",
			["friendcell/main/unknow/btntwo"] = "_control.main.unknow.btntwo",
			["friendcell/main/head/newimg"] = "_control.main.head.newimg",
			["friendcell/main/playername/playername_2"] = "_control.main.playername.playername_2",
			["friendcell/main/unknowtwo/btn"] = "_control.main.unknowtwo.btn",
			["friendcell/main/playername/playername_1"] = "_control.main.playername.playername_1",
			["friendcell/main/acceptorrefuse"] = "_control.main.acceptorrefuse",
			["friendcell/main/introduction/text"] = "_control.main.introduction.text",
			["friendcell/main/logintime/recently"] = "_control.main.logintime.recently",
			["friendcell/main/acceptorrefuse/refuse/text"] = "_control.main.acceptorrefuse.refuse.text",
			["friendcell/main/logintime/time_mask"] = "_control.main.logintime.time_mask",
			["friendcell/main/top_img"] = "_control.main.top_img",
			["friendcell/main/unknowtwo/btn/text"] = "_control.main.unknowtwo.btn.text",
			["friendcell/main/logintime/time_mask/txt"] = "_control.main.logintime.time_mask.txt",
			["friendcell/main/lv"] = "_control.main.lv"
		},
		click = {
			["main/logintime/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/info"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/unknowtwo/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/acceptorrefuse/accept"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/acceptorrefuse/refuse"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/unknow/btnone"] = {
				tp = "UnityEngine.UI.Button"
			},
			["main/unknow/btntwo"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

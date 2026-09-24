return {
	_rule_ = {
		none = {
			mask = {
				path = "mask",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg = {
				path = "bg",
				list = {
					title = {
						path = "bg/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					introduce = {
						path = "bg/introduce",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line = {
						path = "bg/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "bg/main",
						list = {
							main_text = {
								path = "bg/main/main_text",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							input_main = {
								path = "bg/main/input_main",
								list = {
									phone = {
										path = "bg/main/input_main/phone",
										list = {
											bg_1 = {
												path = "bg/main/input_main/phone/bg_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											inputfield_1 = {
												path = "bg/main/input_main/phone/inputfield_1",
												list = {
													Placeholder = {
														path = "bg/main/input_main/phone/inputfield_1/Placeholder",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													text = {
														path = "bg/main/input_main/phone/inputfield_1/text",
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
											}
										},
										component = {}
									},
									code = {
										path = "bg/main/input_main/code",
										list = {
											bg_2 = {
												path = "bg/main/input_main/code/bg_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											inputfield_2 = {
												path = "bg/main/input_main/code/inputfield_2",
												list = {
													Placeholder = {
														path = "bg/main/input_main/code/inputfield_2/Placeholder",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													text = {
														path = "bg/main/input_main/code/inputfield_2/text",
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
											btn = {
												path = "bg/main/input_main/code/btn",
												list = {
													text = {
														path = "bg/main/input_main/code/btn/text",
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
										component = {}
									},
									btn = {
										path = "bg/main/input_main/btn",
										list = {
											text = {
												path = "bg/main/input_main/btn/text",
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
							"UnityEngine.RectTransform"
						}
					},
					close = {
						path = "bg/close",
						list = {},
						component = {
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					bind_finish = {
						path = "bg/bind_finish",
						list = {
							phone_text = {
								path = "bg/bind_finish/phone_text",
								list = {},
								component = {
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							}
						},
						component = {}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			bg_mail = {
				path = "bg_mail",
				list = {
					title = {
						path = "bg_mail/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					introduce = {
						path = "bg_mail/introduce",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					line = {
						path = "bg_mail/line",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					main = {
						path = "bg_mail/main",
						list = {
							input_main = {
								path = "bg_mail/main/input_main",
								list = {
									phone = {
										path = "bg_mail/main/input_main/phone",
										list = {
											bg_1 = {
												path = "bg_mail/main/input_main/phone/bg_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											inputfield_1 = {
												path = "bg_mail/main/input_main/phone/inputfield_1",
												list = {
													Placeholder = {
														path = "bg_mail/main/input_main/phone/inputfield_1/Placeholder",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													text = {
														path = "bg_mail/main/input_main/phone/inputfield_1/text",
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
											}
										},
										component = {}
									},
									code = {
										path = "bg_mail/main/input_main/code",
										list = {
											bg_2 = {
												path = "bg_mail/main/input_main/code/bg_2",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											inputfield_2 = {
												path = "bg_mail/main/input_main/code/inputfield_2",
												list = {
													Placeholder = {
														path = "bg_mail/main/input_main/code/inputfield_2/Placeholder",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Text"
														}
													},
													text = {
														path = "bg_mail/main/input_main/code/inputfield_2/text",
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
											btn = {
												path = "bg_mail/main/input_main/code/btn",
												list = {
													text = {
														path = "bg_mail/main/input_main/code/btn/text",
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
										component = {}
									},
									btn = {
										path = "bg_mail/main/input_main/btn",
										list = {
											text = {
												path = "bg_mail/main/input_main/btn/text",
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
							"UnityEngine.RectTransform"
						}
					},
					close = {
						path = "bg_mail/close",
						list = {},
						component = {
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					need_bind_mail = {
						path = "bg_mail/need_bind_mail",
						list = {
							btn = {
								path = "bg_mail/need_bind_mail/btn",
								list = {
									text = {
										path = "bg_mail/need_bind_mail/btn/text",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									}
								},
								component = {
									"UnityEngine.UI.Button"
								}
							},
							phone_text = {
								path = "bg_mail/need_bind_mail/phone_text",
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
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			}
		},
		call_node_list = {
			["phone_binding/bg/line"] = "_control.bg.line",
			["phone_binding/bg/bind_finish/phone_text"] = "_control.bg.bind_finish.phone_text",
			["phone_binding/bg/main/input_main/phone/inputfield_1/text"] = "_control.bg.main.input_main.phone.inputfield_1.text",
			["phone_binding/bg/main/input_main/btn/text"] = "_control.bg.main.input_main.btn.text",
			["phone_binding/bg/main/input_main/phone"] = "_control.bg.main.input_main.phone",
			["phone_binding/bg/main/main_text"] = "_control.bg.main.main_text",
			["phone_binding/bg_mail/need_bind_mail/phone_text"] = "_control.bg_mail.need_bind_mail.phone_text",
			["phone_binding/bg/main/input_main/code"] = "_control.bg.main.input_main.code",
			["phone_binding/mask"] = "_control.mask",
			["phone_binding/bg/main/input_main"] = "_control.bg.main.input_main",
			["phone_binding/bg_mail"] = "_control.bg_mail",
			["phone_binding/bg/main/input_main/btn"] = "_control.bg.main.input_main.btn",
			["phone_binding/bg/main/input_main/phone/bg_1"] = "_control.bg.main.input_main.phone.bg_1",
			["phone_binding/bg/title"] = "_control.bg.title",
			["phone_binding/bg/main/input_main/code/inputfield_2"] = "_control.bg.main.input_main.code.inputfield_2",
			["phone_binding/bg_mail/main/input_main/code"] = "_control.bg_mail.main.input_main.code",
			["phone_binding/bg_mail/main/input_main/phone/bg_1"] = "_control.bg_mail.main.input_main.phone.bg_1",
			["phone_binding/bg_mail/introduce"] = "_control.bg_mail.introduce",
			["phone_binding/bg_mail/main/input_main/phone/inputfield_1/Placeholder"] = "_control.bg_mail.main.input_main.phone.inputfield_1.Placeholder",
			["phone_binding/bg/bind_finish"] = "_control.bg.bind_finish",
			["phone_binding/bg_mail/main/input_main/code/bg_2"] = "_control.bg_mail.main.input_main.code.bg_2",
			["phone_binding/bg_mail/main/input_main/code/inputfield_2"] = "_control.bg_mail.main.input_main.code.inputfield_2",
			["phone_binding/bg_mail/main/input_main/code/btn/text"] = "_control.bg_mail.main.input_main.code.btn.text",
			["phone_binding/bg/introduce"] = "_control.bg.introduce",
			["phone_binding/bg/main/input_main/code/inputfield_2/text"] = "_control.bg.main.input_main.code.inputfield_2.text",
			["phone_binding/bg_mail/main/input_main"] = "_control.bg_mail.main.input_main",
			["phone_binding/bg_mail/line"] = "_control.bg_mail.line",
			["phone_binding/bg_mail/need_bind_mail"] = "_control.bg_mail.need_bind_mail",
			["phone_binding/bg"] = "_control.bg",
			["phone_binding/bg/close"] = "_control.bg.close",
			["phone_binding/bg_mail/main/input_main/btn"] = "_control.bg_mail.main.input_main.btn",
			["phone_binding/bg_mail/need_bind_mail/btn"] = "_control.bg_mail.need_bind_mail.btn",
			["phone_binding/bg/main/input_main/phone/inputfield_1"] = "_control.bg.main.input_main.phone.inputfield_1",
			["phone_binding/bg_mail/need_bind_mail/btn/text"] = "_control.bg_mail.need_bind_mail.btn.text",
			["phone_binding/bg_mail/main/input_main/btn/text"] = "_control.bg_mail.main.input_main.btn.text",
			["phone_binding/bg_mail/title"] = "_control.bg_mail.title",
			["phone_binding/bg/main/input_main/code/inputfield_2/Placeholder"] = "_control.bg.main.input_main.code.inputfield_2.Placeholder",
			["phone_binding/bg_mail/main/input_main/phone/inputfield_1/text"] = "_control.bg_mail.main.input_main.phone.inputfield_1.text",
			["phone_binding/bg/main/input_main/code/btn"] = "_control.bg.main.input_main.code.btn",
			["phone_binding/bg/main/input_main/code/btn/text"] = "_control.bg.main.input_main.code.btn.text",
			["phone_binding/bg_mail/main/input_main/code/btn"] = "_control.bg_mail.main.input_main.code.btn",
			["phone_binding/bg_mail/main/input_main/phone/inputfield_1"] = "_control.bg_mail.main.input_main.phone.inputfield_1",
			["phone_binding/bg_mail/close"] = "_control.bg_mail.close",
			["phone_binding/bg/main/input_main/phone/inputfield_1/Placeholder"] = "_control.bg.main.input_main.phone.inputfield_1.Placeholder",
			["phone_binding/bg/main"] = "_control.bg.main",
			["phone_binding/bg_mail/main/input_main/code/inputfield_2/text"] = "_control.bg_mail.main.input_main.code.inputfield_2.text",
			["phone_binding/bg_mail/main/input_main/phone"] = "_control.bg_mail.main.input_main.phone",
			["phone_binding/bg/main/input_main/code/bg_2"] = "_control.bg.main.input_main.code.bg_2",
			["phone_binding/bg_mail/main/input_main/code/inputfield_2/Placeholder"] = "_control.bg_mail.main.input_main.code.inputfield_2.Placeholder",
			["phone_binding/bg_mail/main"] = "_control.bg_mail.main"
		},
		click = {
			["bg/main/input_main/code/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/main/input_main/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mail/main/input_main/code/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mail/main/input_main/btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mail/close"] = {
				tp = "UnityEngine.UI.Button"
			},
			["bg_mail/need_bind_mail/btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {}
	}
}

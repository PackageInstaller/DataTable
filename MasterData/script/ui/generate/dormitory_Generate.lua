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
			ceiling_mask = {
				path = "ceiling_mask",
				list = {
					ceiling_bg = {
						path = "ceiling_mask/ceiling_bg",
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
					"UnityEngine.Canvas",
					"UnityEngine.UI.Mask",
					"UnityEngine.CanvasGroup"
				}
			},
			room_bg = {
				path = "room_bg",
				list = {},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			foot_grid_pool = {
				path = "foot_grid_pool",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup"
				}
			},
			foot_grid_layer = {
				path = "foot_grid_layer",
				list = {
					foot_grid_root = {
						path = "foot_grid_layer/foot_grid_root",
						list = {},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					pre_mover = {
						path = "foot_grid_layer/pre_mover",
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
			room = {
				path = "room",
				list = {
					back_grid = {
						path = "room/back_grid",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.Canvas"
						}
					},
					back_layer = {
						path = "room/back_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					front_grid = {
						path = "room/front_grid",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.Canvas"
						}
					},
					front_layer = {
						path = "room/front_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster"
						}
					},
					ship_layer = {
						path = "room/ship_layer",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.Canvas",
							"UnityEngine.UI.GraphicRaycaster",
							"UnityEngine.CanvasGroup"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform"
				}
			},
			furniture_menu_bg = {
				path = "furniture_menu_bg",
				list = {
					show_root = {
						path = "furniture_menu_bg/show_root",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasGroup"
						}
					},
					hide_root = {
						path = "furniture_menu_bg/hide_root",
						list = {
							rotate_btn = {
								path = "furniture_menu_bg/hide_root/rotate_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"UnityEngine.UI.Button"
								}
							},
							deposit_btn = {
								path = "furniture_menu_bg/hide_root/deposit_btn",
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
							"UnityEngine.CanvasGroup"
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
			edit_menu_bg = {
				path = "edit_menu_bg",
				list = {
					warehouse_btn = {
						path = "edit_menu_bg/warehouse_btn",
						list = {
							txt = {
								path = "edit_menu_bg/warehouse_btn/txt",
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
					clear_btn = {
						path = "edit_menu_bg/clear_btn",
						list = {
							txt = {
								path = "edit_menu_bg/clear_btn/txt",
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
					cancel_btn = {
						path = "edit_menu_bg/cancel_btn",
						list = {
							txt = {
								path = "edit_menu_bg/cancel_btn/txt",
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
					ok_btn = {
						path = "edit_menu_bg/ok_btn",
						list = {
							txt = {
								path = "edit_menu_bg/ok_btn/txt",
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
			menu_bg = {
				path = "menu_bg",
				list = {
					bg_btn = {
						path = "menu_bg/bg_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					top_mask = {
						path = "menu_bg/top_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					bottom_mask = {
						path = "menu_bg/bottom_mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close_menu_btn = {
						path = "menu_bg/close_menu_btn",
						list = {
							Text = {
								path = "menu_bg/close_menu_btn/Text",
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
					race_btn = {
						path = "menu_bg/race_btn",
						list = {
							txt = {
								path = "menu_bg/race_btn/txt",
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
					room_btn = {
						path = "menu_bg/room_btn",
						list = {
							txt = {
								path = "menu_bg/room_btn/txt",
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
					role_btn = {
						path = "menu_bg/role_btn",
						list = {
							txt = {
								path = "menu_bg/role_btn/txt",
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
					warehouse_btn = {
						path = "menu_bg/warehouse_btn",
						list = {
							txt = {
								path = "menu_bg/warehouse_btn/txt",
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
					record_btn = {
						path = "menu_bg/record_btn",
						list = {
							txt = {
								path = "menu_bg/record_btn/txt",
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
					collection_btn = {
						path = "menu_bg/collection_btn",
						list = {
							txt = {
								path = "menu_bg/collection_btn/txt",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							red = {
								path = "menu_bg/collection_btn/red",
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
					exhibition_btn = {
						path = "menu_bg/exhibition_btn",
						list = {
							txt = {
								path = "menu_bg/exhibition_btn/txt",
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
					edit_btn = {
						path = "menu_bg/edit_btn",
						list = {
							txt = {
								path = "menu_bg/edit_btn/txt",
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
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			open_btn_mask = {
				path = "open_btn_mask",
				list = {
					open_menu_btn = {
						path = "open_btn_mask/open_menu_btn",
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
					"UnityEngine.UI.Mask",
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			room_select_bg = {
				path = "room_select_bg",
				list = {
					room1 = {
						path = "room_select_bg/room1",
						list = {
							lock_img = {
								path = "room_select_bg/room1/lock_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							room_btn = {
								path = "room_select_bg/room1/room_btn",
								list = {
									txt = {
										path = "room_select_bg/room1/room_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					room2 = {
						path = "room_select_bg/room2",
						list = {
							lock_img = {
								path = "room_select_bg/room2/lock_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							room_btn = {
								path = "room_select_bg/room2/room_btn",
								list = {
									txt = {
										path = "room_select_bg/room2/room_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					room3 = {
						path = "room_select_bg/room3",
						list = {
							lock_img = {
								path = "room_select_bg/room3/lock_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							room_btn = {
								path = "room_select_bg/room3/room_btn",
								list = {
									txt = {
										path = "room_select_bg/room3/room_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					room4 = {
						path = "room_select_bg/room4",
						list = {
							lock_img = {
								path = "room_select_bg/room4/lock_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							room_btn = {
								path = "room_select_bg/room4/room_btn",
								list = {
									txt = {
										path = "room_select_bg/room4/room_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					room5 = {
						path = "room_select_bg/room5",
						list = {
							lock_img = {
								path = "room_select_bg/room5/lock_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							room_btn = {
								path = "room_select_bg/room5/room_btn",
								list = {
									txt = {
										path = "room_select_bg/room5/room_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					room6 = {
						path = "room_select_bg/room6",
						list = {
							lock_img = {
								path = "room_select_bg/room6/lock_img",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							room_btn = {
								path = "room_select_bg/room6/room_btn",
								list = {
									txt = {
										path = "room_select_bg/room6/room_btn/txt",
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
							}
						},
						component = {
							"UnityEngine.RectTransform"
						}
					},
					expand_btn = {
						path = "room_select_bg/expand_btn",
						list = {
							txt = {
								path = "room_select_bg/expand_btn/txt",
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
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			},
			buff_layer = {
				path = "buff_layer",
				list = {
					tip_bg = {
						path = "buff_layer/tip_bg",
						list = {
							tip_bg = {
								path = "buff_layer/tip_bg/tip_bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "buff_layer/tip_bg/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							content = {
								path = "buff_layer/tip_bg/content",
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
							"UnityEngine.CanvasGroup",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button",
							"UIScaleTweener"
						}
					},
					on_furniture_button_buff = {
						path = "buff_layer/on_furniture_button_buff",
						list = {
							buff_time = {
								path = "buff_layer/on_furniture_button_buff/buff_time",
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
							"UnityEngine.CanvasGroup",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster",
					"UITweenSequence"
				}
			},
			close_btn_bg = {
				path = "close_btn_bg",
				list = {
					tip_image = {
						path = "close_btn_bg/tip_image",
						list = {
							image = {
								path = "close_btn_bg/tip_image/image",
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
					return_btn = {
						path = "close_btn_bg/return_btn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					home_btn = {
						path = "close_btn_bg/home_btn",
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
					"UnityEngine.CanvasGroup",
					"UnityEngine.Canvas",
					"UnityEngine.UI.GraphicRaycaster"
				}
			}
		},
		click = {
			["furniture_menu_bg/hide_root/rotate_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["furniture_menu_bg/hide_root/deposit_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["edit_menu_bg/warehouse_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["edit_menu_bg/clear_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["edit_menu_bg/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["edit_menu_bg/ok_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/bg_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/close_menu_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/race_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/room_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/role_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/warehouse_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/record_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/collection_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/exhibition_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["menu_bg/edit_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["open_btn_mask/open_menu_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["room_select_bg/room1/room_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["room_select_bg/room2/room_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["room_select_bg/room3/room_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["room_select_bg/room4/room_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["room_select_bg/room5/room_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["room_select_bg/room6/room_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["room_select_bg/expand_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_layer/tip_bg"] = {
				tp = "UnityEngine.UI.Button"
			},
			["buff_layer/on_furniture_button_buff"] = {
				tp = "UnityEngine.UI.Button"
			},
			["close_btn_bg/return_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["close_btn_bg/home_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		canvas_set = {
			ceiling_mask = {
				component = "UnityEngine.Canvas",
				path = "ceiling_mask"
			},
			back_grid = {
				component = "UnityEngine.Canvas",
				path = "room/back_grid"
			},
			back_layer = {
				component = "UnityEngine.Canvas",
				path = "room/back_layer"
			},
			front_grid = {
				component = "UnityEngine.Canvas",
				path = "room/front_grid"
			},
			front_layer = {
				component = "UnityEngine.Canvas",
				path = "room/front_layer"
			},
			ship_layer = {
				component = "UnityEngine.Canvas",
				path = "room/ship_layer"
			},
			furniture_menu_bg = {
				component = "UnityEngine.Canvas",
				path = "furniture_menu_bg"
			},
			edit_menu_bg = {
				component = "UnityEngine.Canvas",
				path = "edit_menu_bg"
			},
			menu_bg = {
				component = "UnityEngine.Canvas",
				path = "menu_bg"
			},
			open_btn_mask = {
				component = "UnityEngine.Canvas",
				path = "open_btn_mask"
			},
			room_select_bg = {
				component = "UnityEngine.Canvas",
				path = "room_select_bg"
			},
			buff_layer = {
				component = "UnityEngine.Canvas",
				path = "buff_layer"
			},
			close_btn_bg = {
				component = "UnityEngine.Canvas",
				path = "close_btn_bg"
			}
		}
	}
}

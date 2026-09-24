return {
	_rule_ = {
		none = {
			shadw = {
				path = "shadw",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.Button"
				}
			},
			main = {
				path = "main",
				list = {
					mask_bg = {
						path = "main/mask_bg",
						list = {
							glow_img = {
								path = "main/mask_bg/glow_img",
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
					mask = {
						path = "main/mask",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					title = {
						path = "main/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					head_segmentation = {
						path = "main/head_segmentation",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					close = {
						path = "main/close",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"ScaleButton"
						}
					},
					settext = {
						path = "main/settext",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					set_main = {
						path = "main/set_main",
						list = {
							hd_picture_main = {
								path = "main/set_main/hd_picture_main",
								list = {
									bg = {
										path = "main/set_main/hd_picture_main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									picture_select = {
										path = "main/set_main/hd_picture_main/picture_select",
										list = {
											picture = {
												path = "main/set_main/hd_picture_main/picture_select/picture",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											normal = {
												path = "main/set_main/hd_picture_main/picture_select/normal",
												list = {
													txt = {
														path = "main/set_main/hd_picture_main/picture_select/normal/txt",
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
													"ScaleButton"
												}
											},
											hd = {
												path = "main/set_main/hd_picture_main/picture_select/hd",
												list = {
													txt = {
														path = "main/set_main/hd_picture_main/picture_select/hd/txt",
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
													"ScaleButton"
												}
											},
											line = {
												path = "main/set_main/hd_picture_main/picture_select/line",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									picture_ok = {
										path = "main/set_main/hd_picture_main/picture_ok",
										list = {
											hd_picture = {
												path = "main/set_main/hd_picture_main/picture_ok/hd_picture",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											uibm = {
												path = "main/set_main/hd_picture_main/picture_ok/uibm",
												list = {
													txt = {
														path = "main/set_main/hd_picture_main/picture_ok/uibm/txt",
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
													"ScaleButton"
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
							cv_main = {
								path = "main/set_main/cv_main",
								list = {
									bg = {
										path = "main/set_main/cv_main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									cv_select = {
										path = "main/set_main/cv_main/cv_select",
										list = {
											cv = {
												path = "main/set_main/cv_main/cv_select/cv",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											japanesecv = {
												path = "main/set_main/cv_main/cv_select/japanesecv",
												list = {
													txt = {
														path = "main/set_main/cv_main/cv_select/japanesecv/txt",
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
													"ScaleButton"
												}
											},
											chinese = {
												path = "main/set_main/cv_main/cv_select/chinese",
												list = {
													txt = {
														path = "main/set_main/cv_main/cv_select/chinese/txt",
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
													"ScaleButton"
												}
											},
											line = {
												path = "main/set_main/cv_main/cv_select/line",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									cv_ok = {
										path = "main/set_main/cv_main/cv_ok",
										list = {
											good = {
												path = "main/set_main/cv_main/cv_ok/good",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											uibm = {
												path = "main/set_main/cv_main/cv_ok/uibm",
												list = {
													txt = {
														path = "main/set_main/cv_main/cv_ok/uibm/txt",
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
													"ScaleButton"
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
							cvvol_main = {
								path = "main/set_main/cvvol_main",
								list = {
									bg = {
										path = "main/set_main/cvvol_main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "main/set_main/cvvol_main/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "main/set_main/cvvol_main/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									slider = {
										path = "main/set_main/cvvol_main/slider",
										list = {
											Background = {
												path = "main/set_main/cvvol_main/slider/Background",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											["Fill Area"] = {
												path = "main/set_main/cvvol_main/slider/Fill Area",
												list = {
													Fill = {
														path = "main/set_main/cvvol_main/slider/Fill Area/Fill",
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
											["Handle Slide Area"] = {
												path = "main/set_main/cvvol_main/slider/Handle Slide Area",
												list = {
													Handle = {
														path = "main/set_main/cvvol_main/slider/Handle Slide Area/Handle",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Slider"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							bgm_main = {
								path = "main/set_main/bgm_main",
								list = {
									bg = {
										path = "main/set_main/bgm_main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "main/set_main/bgm_main/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "main/set_main/bgm_main/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									slider = {
										path = "main/set_main/bgm_main/slider",
										list = {
											Background = {
												path = "main/set_main/bgm_main/slider/Background",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											["Fill Area"] = {
												path = "main/set_main/bgm_main/slider/Fill Area",
												list = {
													Fill = {
														path = "main/set_main/bgm_main/slider/Fill Area/Fill",
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
											["Handle Slide Area"] = {
												path = "main/set_main/bgm_main/slider/Handle Slide Area",
												list = {
													Handle = {
														path = "main/set_main/bgm_main/slider/Handle Slide Area/Handle",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Slider"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							sound_main = {
								path = "main/set_main/sound_main",
								list = {
									bg = {
										path = "main/set_main/sound_main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "main/set_main/sound_main/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									number = {
										path = "main/set_main/sound_main/number",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									slider = {
										path = "main/set_main/sound_main/slider",
										list = {
											Background = {
												path = "main/set_main/sound_main/slider/Background",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											["Fill Area"] = {
												path = "main/set_main/sound_main/slider/Fill Area",
												list = {
													Fill = {
														path = "main/set_main/sound_main/slider/Fill Area/Fill",
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
											["Handle Slide Area"] = {
												path = "main/set_main/sound_main/slider/Handle Slide Area",
												list = {
													Handle = {
														path = "main/set_main/sound_main/slider/Handle Slide Area/Handle",
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
											}
										},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.UI.Slider"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							always_light_scene_change_main = {
								path = "main/set_main/always_light_scene_change_main",
								list = {
									bg = {
										path = "main/set_main/always_light_scene_change_main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									always_light = {
										path = "main/set_main/always_light_scene_change_main/always_light",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									title_mask = {
										path = "main/set_main/always_light_scene_change_main/title_mask",
										list = {
											txt = {
												path = "main/set_main/always_light_scene_change_main/title_mask/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											txt_2 = {
												path = "main/set_main/always_light_scene_change_main/title_mask/txt_2",
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
									},
									always_light_control = {
										path = "main/set_main/always_light_scene_change_main/always_light_control",
										list = {
											left = {
												path = "main/set_main/always_light_scene_change_main/always_light_control/left",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											right = {
												path = "main/set_main/always_light_scene_change_main/always_light_control/right",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											txt = {
												path = "main/set_main/always_light_scene_change_main/always_light_control/txt",
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
									scene_change = {
										path = "main/set_main/always_light_scene_change_main/scene_change",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									scene_change_control = {
										path = "main/set_main/always_light_scene_change_main/scene_change_control",
										list = {
											left = {
												path = "main/set_main/always_light_scene_change_main/scene_change_control/left",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											right = {
												path = "main/set_main/always_light_scene_change_main/scene_change_control/right",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											txt = {
												path = "main/set_main/always_light_scene_change_main/scene_change_control/txt",
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
									"UnityEngine.RectTransform"
								}
							},
							live2d_framerate_main = {
								path = "main/set_main/live2d_framerate_main",
								list = {
									bg = {
										path = "main/set_main/live2d_framerate_main/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									live2d = {
										path = "main/set_main/live2d_framerate_main/live2d",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									live2d_control = {
										path = "main/set_main/live2d_framerate_main/live2d_control",
										list = {
											left = {
												path = "main/set_main/live2d_framerate_main/live2d_control/left",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											right = {
												path = "main/set_main/live2d_framerate_main/live2d_control/right",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											txt = {
												path = "main/set_main/live2d_framerate_main/live2d_control/txt",
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
									framerate = {
										path = "main/set_main/live2d_framerate_main/framerate",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									framerate_control = {
										path = "main/set_main/live2d_framerate_main/framerate_control",
										list = {
											left = {
												path = "main/set_main/live2d_framerate_main/framerate_control/left",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											right = {
												path = "main/set_main/live2d_framerate_main/framerate_control/right",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											txt = {
												path = "main/set_main/live2d_framerate_main/framerate_control/txt",
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
									"UnityEngine.RectTransform"
								}
							},
							bind_email_address = {
								path = "main/set_main/bind_email_address",
								list = {
									bg = {
										path = "main/set_main/bind_email_address/bg",
										list = {
											tip = {
												path = "main/set_main/bind_email_address/bg/tip",
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
									live2d = {
										path = "main/set_main/bind_email_address/live2d",
										list = {
											name_level_1 = {
												path = "main/set_main/bind_email_address/live2d/name_level_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											name_level_2 = {
												path = "main/set_main/bind_email_address/live2d/name_level_2",
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
									email_address = {
										path = "main/set_main/bind_email_address/email_address",
										list = {
											txt = {
												path = "main/set_main/bind_email_address/email_address/txt",
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
											"ScaleButton"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform"
								}
							},
							battle_scene = {
								path = "main/set_main/battle_scene",
								list = {
									bg = {
										path = "main/set_main/battle_scene/bg",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									battle_scene_txt = {
										path = "main/set_main/battle_scene/battle_scene_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									battle_scene_control = {
										path = "main/set_main/battle_scene/battle_scene_control",
										list = {
											left = {
												path = "main/set_main/battle_scene/battle_scene_control/left",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											right = {
												path = "main/set_main/battle_scene/battle_scene_control/right",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											txt = {
												path = "main/set_main/battle_scene/battle_scene_control/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									},
									broken_txt = {
										path = "main/set_main/battle_scene/broken_txt",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									broken_control = {
										path = "main/set_main/battle_scene/broken_control",
										list = {
											left = {
												path = "main/set_main/battle_scene/broken_control/left",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											right = {
												path = "main/set_main/battle_scene/broken_control/right",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image",
													"ScaleButton"
												}
											},
											txt = {
												path = "main/set_main/battle_scene/broken_control/txt",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											}
										},
										component = {}
									}
								},
								component = {}
							},
							app_inquire_main = {
								path = "main/set_main/app_inquire_main",
								list = {
									app_inquire = {
										path = "main/set_main/app_inquire_main/app_inquire",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									app_inquire_btn = {
										path = "main/set_main/app_inquire_main/app_inquire_btn",
										list = {
											inquire = {
												path = "main/set_main/app_inquire_main/app_inquire_btn/inquire",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									app_user = {
										path = "main/set_main/app_inquire_main/app_user",
										list = {
											inquire = {
												path = "main/set_main/app_inquire_main/app_user/inquire",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									app_privacy = {
										path = "main/set_main/app_inquire_main/app_privacy",
										list = {
											inquire = {
												path = "main/set_main/app_inquire_main/app_privacy/inquire",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									app_three = {
										path = "main/set_main/app_inquire_main/app_three",
										list = {
											inquire = {
												path = "main/set_main/app_inquire_main/app_three/inquire",
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
											"UnityEngine.CanvasRenderer"
										}
									},
									app_child = {
										path = "main/set_main/app_inquire_main/app_child",
										list = {
											inquire = {
												path = "main/set_main/app_inquire_main/app_child/inquire",
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
											"UnityEngine.CanvasRenderer"
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
					uid_number = {
						path = "main/uid_number",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					version = {
						path = "main/version",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					iconone = {
						path = "main/iconone",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					icontwo = {
						path = "main/icontwo",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					sbtnback = {
						path = "main/sbtnback",
						list = {
							txt = {
								path = "main/sbtnback/txt",
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
							"ScaleButton"
						}
					},
					srescheck = {
						path = "main/srescheck",
						list = {
							txt = {
								path = "main/srescheck/txt",
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
							"ScaleButton"
						}
					},
					exchange = {
						path = "main/exchange",
						list = {
							txt = {
								path = "main/exchange/txt",
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
							"ScaleButton"
						}
					},
					settingrule_btn = {
						path = "main/settingrule_btn",
						list = {
							txt = {
								path = "main/settingrule_btn/txt",
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
							"ScaleButton"
						}
					},
					contact_us = {
						path = "main/contact_us",
						list = {
							txt = {
								path = "main/contact_us/txt",
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
							"ScaleButton"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UITweenSequence",
					"UIScaleTweener",
					"UIScaleTweener"
				}
			},
			tip = {
				path = "tip",
				list = {
					tip_layer = {
						path = "tip/tip_layer",
						list = {
							bg = {
								path = "tip/tip_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_container = {
								path = "tip/tip_layer/bg_container",
								list = {
									bg_blue_top = {
										path = "tip/tip_layer/bg_container/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_2 = {
										path = "tip/tip_layer/bg_container/bg_blue_top_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									three_point = {
										path = "tip/tip_layer/bg_container/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "tip/tip_layer/bg_container/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									bg_blue_top_3 = {
										path = "tip/tip_layer/bg_container/bg_blue_top_3",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip = {
								path = "tip/tip_layer/tip",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							black_line = {
								path = "tip/tip_layer/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "tip/tip_layer/confirm_btn",
								list = {
									txt = {
										path = "tip/tip_layer/confirm_btn/txt",
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
								path = "tip/tip_layer/cancel_btn",
								list = {
									txt = {
										path = "tip/tip_layer/cancel_btn/txt",
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
							"UIScaleTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UITweenSequence"
				}
			},
			exchange = {
				path = "exchange",
				list = {
					bg_container = {
						path = "exchange/bg_container",
						list = {
							bg = {
								path = "exchange/bg_container/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							title = {
								path = "exchange/bg_container/title",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							close_btn = {
								path = "exchange/bg_container/close_btn",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image",
									"ScaleButton"
								}
							},
							black_line = {
								path = "exchange/bg_container/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							input = {
								path = "exchange/bg_container/input",
								list = {
									placeholder = {
										path = "exchange/bg_container/input/placeholder",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									txt = {
										path = "exchange/bg_container/input/txt",
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
							black_line_2 = {
								path = "exchange/bg_container/black_line_2",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "exchange/bg_container/confirm_btn",
								list = {
									txt = {
										path = "exchange/bg_container/confirm_btn/txt",
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
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			tip1 = {
				path = "tip1",
				list = {
					tip_layer = {
						path = "tip1/tip_layer",
						list = {
							bg = {
								path = "tip1/tip_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_container = {
								path = "tip1/tip_layer/bg_container",
								list = {
									bg_blue_top = {
										path = "tip1/tip_layer/bg_container/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_2 = {
										path = "tip1/tip_layer/bg_container/bg_blue_top_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									three_point = {
										path = "tip1/tip_layer/bg_container/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "tip1/tip_layer/bg_container/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									bg_blue_top_3 = {
										path = "tip1/tip_layer/bg_container/bg_blue_top_3",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip = {
								path = "tip1/tip_layer/tip",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							black_line = {
								path = "tip1/tip_layer/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "tip1/tip_layer/confirm_btn",
								list = {
									txt = {
										path = "tip1/tip_layer/confirm_btn/txt",
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
								path = "tip1/tip_layer/cancel_btn",
								list = {
									txt = {
										path = "tip1/tip_layer/cancel_btn/txt",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			tip2 = {
				path = "tip2",
				list = {
					tip_layer = {
						path = "tip2/tip_layer",
						list = {
							bg = {
								path = "tip2/tip_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_container = {
								path = "tip2/tip_layer/bg_container",
								list = {
									bg_blue_top = {
										path = "tip2/tip_layer/bg_container/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_2 = {
										path = "tip2/tip_layer/bg_container/bg_blue_top_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									three_point = {
										path = "tip2/tip_layer/bg_container/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_3 = {
										path = "tip2/tip_layer/bg_container/bg_blue_top_3",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							black_line = {
								path = "tip2/tip_layer/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "tip2/tip_layer/confirm_btn",
								list = {
									txt = {
										path = "tip2/tip_layer/confirm_btn/txt",
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
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			tip3 = {
				path = "tip3",
				list = {
					tip_layer = {
						path = "tip3/tip_layer",
						list = {
							bg = {
								path = "tip3/tip_layer/bg",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							bg_container = {
								path = "tip3/tip_layer/bg_container",
								list = {
									bg_blue_top = {
										path = "tip3/tip_layer/bg_container/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_2 = {
										path = "tip3/tip_layer/bg_container/bg_blue_top_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									three_point = {
										path = "tip3/tip_layer/bg_container/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "tip3/tip_layer/bg_container/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									bg_blue_top_3 = {
										path = "tip3/tip_layer/bg_container/bg_blue_top_3",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							tip = {
								path = "tip3/tip_layer/tip",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							black_line = {
								path = "tip3/tip_layer/black_line",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							all_btn = {
								path = "tip3/tip_layer/all_btn",
								list = {
									repair_data_btn = {
										path = "tip3/tip_layer/all_btn/repair_data_btn",
										list = {
											txt = {
												path = "tip3/tip_layer/all_btn/repair_data_btn/txt",
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
									repair_data2_btn = {
										path = "tip3/tip_layer/all_btn/repair_data2_btn",
										list = {
											txt = {
												path = "tip3/tip_layer/all_btn/repair_data2_btn/txt",
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
									repair_datahd_btn = {
										path = "tip3/tip_layer/all_btn/repair_datahd_btn",
										list = {
											txt = {
												path = "tip3/tip_layer/all_btn/repair_datahd_btn/txt",
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
									repair_datacv_btn = {
										path = "tip3/tip_layer/all_btn/repair_datacv_btn",
										list = {
											txt = {
												path = "tip3/tip_layer/all_btn/repair_datacv_btn/txt",
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
									repair_datacv_jp_btn = {
										path = "tip3/tip_layer/all_btn/repair_datacv_jp_btn",
										list = {
											txt = {
												path = "tip3/tip_layer/all_btn/repair_datacv_jp_btn/txt",
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
										path = "tip3/tip_layer/all_btn/cancel_btn",
										list = {
											txt = {
												path = "tip3/tip_layer/all_btn/cancel_btn/txt",
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
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			email_tip = {
				path = "email_tip",
				list = {
					tip_layer = {
						path = "email_tip/tip_layer",
						list = {
							tip_name = {
								path = "email_tip/tip_layer/tip_name",
								list = {
									tip = {
										path = "email_tip/tip_layer/tip_name/tip",
										list = {},
										component = {
											"UnityEngine.UI.Text"
										}
									},
									fleet_name = {
										path = "email_tip/tip_layer/tip_name/fleet_name",
										list = {
											placeholder = {
												path = "email_tip/tip_layer/tip_name/fleet_name/placeholder",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											text = {
												path = "email_tip/tip_layer/tip_name/fleet_name/text",
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
									tip_1 = {
										path = "email_tip/tip_layer/tip_name/tip_1",
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
							bg_container = {
								path = "email_tip/tip_layer/bg_container",
								list = {
									bg_blue_top = {
										path = "email_tip/tip_layer/bg_container/bg_blue_top",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									bg_blue_top_2 = {
										path = "email_tip/tip_layer/bg_container/bg_blue_top_2",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									three_point = {
										path = "email_tip/tip_layer/bg_container/three_point",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Image"
										}
									},
									title = {
										path = "email_tip/tip_layer/bg_container/title",
										list = {},
										component = {
											"UnityEngine.RectTransform",
											"UnityEngine.CanvasRenderer",
											"UnityEngine.UI.Text"
										}
									},
									bg_blue_top_3 = {
										path = "email_tip/tip_layer/bg_container/bg_blue_top_3",
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
									"UnityEngine.UI.Mask",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							confirm_btn = {
								path = "email_tip/tip_layer/confirm_btn",
								list = {
									txt = {
										path = "email_tip/tip_layer/confirm_btn/txt",
										list = {},
										component = {
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
								path = "email_tip/tip_layer/cancel_btn",
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
							"UIScaleTweener"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			bg = {
				path = "email_tip/tip_layer/bg",
				list = {},
				component = {}
			}
		},
		call_node_list = {
			["setting/main/set_main/live2d_framerate_main/framerate"] = "_control.main.set_main.live2d_framerate_main.framerate",
			["setting/tip3/tip_layer/all_btn/repair_data_btn/txt"] = "_control.tip3.tip_layer.all_btn.repair_data_btn.txt",
			["setting/main/settext"] = "_control.main.settext",
			["setting/main/set_main/battle_scene/bg"] = "_control.main.set_main.battle_scene.bg",
			["setting/main/set_main/bgm_main/title"] = "_control.main.set_main.bgm_main.title",
			["setting/main/set_main/live2d_framerate_main/framerate_control/txt"] = "_control.main.set_main.live2d_framerate_main.framerate_control.txt",
			["setting/main/set_main/bind_email_address/live2d/name_level_1"] = "_control.main.set_main.bind_email_address.live2d.name_level_1",
			["setting/main/set_main/hd_picture_main/picture_select/picture"] = "_control.main.set_main.hd_picture_main.picture_select.picture",
			["setting/main/set_main/hd_picture_main/picture_select/hd/txt"] = "_control.main.set_main.hd_picture_main.picture_select.hd.txt",
			["setting/exchange/bg_container/bg"] = "_control.exchange.bg_container.bg",
			["setting/main/set_main/bind_email_address/email_address"] = "_control.main.set_main.bind_email_address.email_address",
			["setting/main/set_main/live2d_framerate_main"] = "_control.main.set_main.live2d_framerate_main",
			["setting/main/set_main/app_inquire_main/app_three/inquire"] = "_control.main.set_main.app_inquire_main.app_three.inquire",
			["setting/exchange/bg_container/input/placeholder"] = "_control.exchange.bg_container.input.placeholder",
			["setting/main/set_main/bind_email_address/live2d"] = "_control.main.set_main.bind_email_address.live2d",
			["setting/main/set_main/cv_main/cv_select/chinese"] = "_control.main.set_main.cv_main.cv_select.chinese",
			["setting/main/set_main/live2d_framerate_main/live2d_control/left"] = "_control.main.set_main.live2d_framerate_main.live2d_control.left",
			["setting/main/set_main/sound_main/slider/Handle Slide Area/Handle"] = "_control.main.set_main.sound_main.slider.Handle Slide Area.Handle",
			["setting/main/set_main/bgm_main/slider/Fill Area"] = "_control.main.set_main.bgm_main.slider.Fill Area",
			["setting/tip2/tip_layer"] = "_control.tip2.tip_layer",
			["setting/main/sbtnback/txt"] = "_control.main.sbtnback.txt",
			["setting/main/set_main/app_inquire_main/app_child"] = "_control.main.set_main.app_inquire_main.app_child",
			["setting/email_tip/tip_layer/confirm_btn/txt"] = "_control.email_tip.tip_layer.confirm_btn.txt",
			["setting/main/set_main/live2d_framerate_main/bg"] = "_control.main.set_main.live2d_framerate_main.bg",
			["setting/main/set_main/cv_main/cv_ok/uibm"] = "_control.main.set_main.cv_main.cv_ok.uibm",
			["setting/main/set_main/always_light_scene_change_main/always_light_control/txt"] = "_control.main.set_main.always_light_scene_change_main.always_light_control.txt",
			["setting/tip/tip_layer/bg_container"] = "_control.tip.tip_layer.bg_container",
			["setting/email_tip/tip_layer/tip_name/fleet_name"] = "_control.email_tip.tip_layer.tip_name.fleet_name",
			["setting/main/mask_bg"] = "_control.main.mask_bg",
			["setting/main/set_main/cvvol_main/title"] = "_control.main.set_main.cvvol_main.title",
			["setting/main/set_main/battle_scene/broken_txt"] = "_control.main.set_main.battle_scene.broken_txt",
			["setting/main/set_main/hd_picture_main/picture_select"] = "_control.main.set_main.hd_picture_main.picture_select",
			["setting/main/set_main/battle_scene/broken_control"] = "_control.main.set_main.battle_scene.broken_control",
			["setting/main/set_main/cvvol_main"] = "_control.main.set_main.cvvol_main",
			["setting/main/set_main/cvvol_main/bg"] = "_control.main.set_main.cvvol_main.bg",
			["setting/email_tip/tip_layer/tip_name"] = "_control.email_tip.tip_layer.tip_name",
			["setting/email_tip/tip_layer/cancel_btn"] = "_control.email_tip.tip_layer.cancel_btn",
			["setting/main/set_main/battle_scene/battle_scene_control/txt"] = "_control.main.set_main.battle_scene.battle_scene_control.txt",
			["setting/tip/tip_layer/cancel_btn/txt"] = "_control.tip.tip_layer.cancel_btn.txt",
			["setting/main/iconone"] = "_control.main.iconone",
			["setting/main/set_main/bgm_main"] = "_control.main.set_main.bgm_main",
			["setting/main/set_main/sound_main/slider/Fill Area/Fill"] = "_control.main.set_main.sound_main.slider.Fill Area.Fill",
			["setting/main/set_main/cv_main/cv_select/japanesecv/txt"] = "_control.main.set_main.cv_main.cv_select.japanesecv.txt",
			["setting/main/set_main/cv_main/cv_select/cv"] = "_control.main.set_main.cv_main.cv_select.cv",
			["setting/main/set_main/sound_main"] = "_control.main.set_main.sound_main",
			["setting/main/set_main/live2d_framerate_main/framerate_control/right"] = "_control.main.set_main.live2d_framerate_main.framerate_control.right",
			["setting/tip3/tip_layer/all_btn"] = "_control.tip3.tip_layer.all_btn",
			["setting/main/set_main/bgm_main/slider/Handle Slide Area"] = "_control.main.set_main.bgm_main.slider.Handle Slide Area",
			["setting/main/sbtnback"] = "_control.main.sbtnback",
			["setting/main/set_main/always_light_scene_change_main/scene_change_control/left"] = "_control.main.set_main.always_light_scene_change_main.scene_change_control.left",
			["setting/main/srescheck/txt"] = "_control.main.srescheck.txt",
			["setting/main/exchange"] = "_control.main.exchange",
			["setting/email_tip/tip_layer/confirm_btn"] = "_control.email_tip.tip_layer.confirm_btn",
			["setting/main/set_main/cv_main/cv_ok/uibm/txt"] = "_control.main.set_main.cv_main.cv_ok.uibm.txt",
			["setting/tip/tip_layer/confirm_btn/txt"] = "_control.tip.tip_layer.confirm_btn.txt",
			["setting/main/set_main/app_inquire_main/app_inquire_btn"] = "_control.main.set_main.app_inquire_main.app_inquire_btn",
			["setting/tip"] = "_control.tip",
			["setting/tip/tip_layer"] = "_control.tip.tip_layer",
			["setting/main/set_main/always_light_scene_change_main/scene_change_control"] = "_control.main.set_main.always_light_scene_change_main.scene_change_control",
			["setting/main/set_main/bgm_main/slider"] = "_control.main.set_main.bgm_main.slider",
			["setting/main/set_main/always_light_scene_change_main/always_light_control/right"] = "_control.main.set_main.always_light_scene_change_main.always_light_control.right",
			["setting/main/set_main/bgm_main/slider/Background"] = "_control.main.set_main.bgm_main.slider.Background",
			["setting/tip1/tip_layer/confirm_btn/txt"] = "_control.tip1.tip_layer.confirm_btn.txt",
			["setting/main/set_main/bind_email_address/bg/tip"] = "_control.main.set_main.bind_email_address.bg.tip",
			["setting/main/set_main/bgm_main/number"] = "_control.main.set_main.bgm_main.number",
			["setting/tip/tip_layer/confirm_btn"] = "_control.tip.tip_layer.confirm_btn",
			["setting/main/set_main/app_inquire_main/app_privacy"] = "_control.main.set_main.app_inquire_main.app_privacy",
			["setting/tip1/tip_layer"] = "_control.tip1.tip_layer",
			["setting/main/set_main/battle_scene/broken_control/txt"] = "_control.main.set_main.battle_scene.broken_control.txt",
			["setting/main/set_main/always_light_scene_change_main/scene_change_control/right"] = "_control.main.set_main.always_light_scene_change_main.scene_change_control.right",
			["setting/main/mask"] = "_control.main.mask",
			["setting/main/set_main/battle_scene/broken_control/left"] = "_control.main.set_main.battle_scene.broken_control.left",
			["setting/exchange/bg_container/close_btn"] = "_control.exchange.bg_container.close_btn",
			["setting/exchange/bg_container/input"] = "_control.exchange.bg_container.input",
			["setting/main/set_main/always_light_scene_change_main/always_light"] = "_control.main.set_main.always_light_scene_change_main.always_light",
			["setting/tip3/tip_layer/all_btn/repair_data2_btn"] = "_control.tip3.tip_layer.all_btn.repair_data2_btn",
			["setting/exchange/bg_container/input/txt"] = "_control.exchange.bg_container.input.txt",
			["setting/main/set_main/app_inquire_main"] = "_control.main.set_main.app_inquire_main",
			["setting/main/settingrule_btn/txt"] = "_control.main.settingrule_btn.txt",
			["setting/tip/tip_layer/bg_container/bg_blue_top"] = "_control.tip.tip_layer.bg_container.bg_blue_top",
			["setting/main/set_main/bind_email_address/email_address/txt"] = "_control.main.set_main.bind_email_address.email_address.txt",
			["setting/main/close"] = "_control.main.close",
			["setting/main/set_main/cv_main/cv_ok/good"] = "_control.main.set_main.cv_main.cv_ok.good",
			["setting/exchange/bg_container/confirm_btn"] = "_control.exchange.bg_container.confirm_btn",
			["setting/main/set_main/app_inquire_main/app_three"] = "_control.main.set_main.app_inquire_main.app_three",
			["setting/tip1"] = "_control.tip1",
			["setting/main/set_main/always_light_scene_change_main/bg"] = "_control.main.set_main.always_light_scene_change_main.bg",
			["setting/main/set_main/live2d_framerate_main/live2d_control/right"] = "_control.main.set_main.live2d_framerate_main.live2d_control.right",
			["setting/main/settingrule_btn"] = "_control.main.settingrule_btn",
			["setting/tip3/tip_layer/all_btn/repair_datahd_btn/txt"] = "_control.tip3.tip_layer.all_btn.repair_datahd_btn.txt",
			["setting/tip1/tip_layer/bg_container/bg_blue_top_2"] = "_control.tip1.tip_layer.bg_container.bg_blue_top_2",
			["setting/tip1/tip_layer/bg_container/three_point"] = "_control.tip1.tip_layer.bg_container.three_point",
			["setting/tip/tip_layer/bg_container/three_point"] = "_control.tip.tip_layer.bg_container.three_point",
			["setting/main/set_main/always_light_scene_change_main/title_mask/txt"] = "_control.main.set_main.always_light_scene_change_main.title_mask.txt",
			["setting/email_tip/tip_layer"] = "_control.email_tip.tip_layer",
			["setting/main/set_main/bind_email_address/bg"] = "_control.main.set_main.bind_email_address.bg",
			["setting/main/set_main/hd_picture_main/picture_ok/uibm/txt"] = "_control.main.set_main.hd_picture_main.picture_ok.uibm.txt",
			["setting/exchange/bg_container"] = "_control.exchange.bg_container",
			["setting/tip1/tip_layer/black_line"] = "_control.tip1.tip_layer.black_line",
			["setting/main/set_main/always_light_scene_change_main/scene_change_control/txt"] = "_control.main.set_main.always_light_scene_change_main.scene_change_control.txt",
			["setting/tip1/tip_layer/tip"] = "_control.tip1.tip_layer.tip",
			["setting/tip1/tip_layer/confirm_btn"] = "_control.tip1.tip_layer.confirm_btn",
			["setting/tip/tip_layer/bg_container/title"] = "_control.tip.tip_layer.bg_container.title",
			["setting/main/set_main/bind_email_address"] = "_control.main.set_main.bind_email_address",
			["setting/main/set_main/cvvol_main/slider/Fill Area/Fill"] = "_control.main.set_main.cvvol_main.slider.Fill Area.Fill",
			["setting/main/set_main/always_light_scene_change_main/title_mask/txt_2"] = "_control.main.set_main.always_light_scene_change_main.title_mask.txt_2",
			["setting/main/uid_number"] = "_control.main.uid_number",
			["setting/tip1/tip_layer/bg_container"] = "_control.tip1.tip_layer.bg_container",
			["setting/tip1/tip_layer/cancel_btn/txt"] = "_control.tip1.tip_layer.cancel_btn.txt",
			["setting/main/set_main/sound_main/slider/Handle Slide Area"] = "_control.main.set_main.sound_main.slider.Handle Slide Area",
			["setting/tip/tip_layer/bg_container/bg_blue_top_2"] = "_control.tip.tip_layer.bg_container.bg_blue_top_2",
			["setting/main/icontwo"] = "_control.main.icontwo",
			["setting/tip2/tip_layer/bg_container/bg_blue_top_2"] = "_control.tip2.tip_layer.bg_container.bg_blue_top_2",
			["setting/main/set_main/cvvol_main/slider/Handle Slide Area/Handle"] = "_control.main.set_main.cvvol_main.slider.Handle Slide Area.Handle",
			["setting/main/set_main/cv_main/cv_ok"] = "_control.main.set_main.cv_main.cv_ok",
			["setting/main/set_main/hd_picture_main/picture_ok/uibm"] = "_control.main.set_main.hd_picture_main.picture_ok.uibm",
			["setting/main/set_main/cv_main/cv_select/line"] = "_control.main.set_main.cv_main.cv_select.line",
			["setting/main/set_main/sound_main/slider"] = "_control.main.set_main.sound_main.slider",
			["setting/exchange/bg_container/title"] = "_control.exchange.bg_container.title",
			["setting/tip2/tip_layer/bg"] = "_control.tip2.tip_layer.bg",
			["setting/tip2/tip_layer/bg_container"] = "_control.tip2.tip_layer.bg_container",
			["setting/tip2/tip_layer/bg_container/bg_blue_top"] = "_control.tip2.tip_layer.bg_container.bg_blue_top",
			["setting/main/set_main/live2d_framerate_main/framerate_control/left"] = "_control.main.set_main.live2d_framerate_main.framerate_control.left",
			["setting/tip2"] = "_control.tip2",
			["setting/tip2/tip_layer/bg_container/three_point"] = "_control.tip2.tip_layer.bg_container.three_point",
			["setting/tip2/tip_layer/bg_container/bg_blue_top_3"] = "_control.tip2.tip_layer.bg_container.bg_blue_top_3",
			["setting/main/set_main/live2d_framerate_main/live2d_control"] = "_control.main.set_main.live2d_framerate_main.live2d_control",
			["setting/tip2/tip_layer/black_line"] = "_control.tip2.tip_layer.black_line",
			["setting/exchange"] = "_control.exchange",
			["setting/exchange/bg_container/black_line"] = "_control.exchange.bg_container.black_line",
			["setting/tip2/tip_layer/confirm_btn"] = "_control.tip2.tip_layer.confirm_btn",
			["setting/tip2/tip_layer/confirm_btn/txt"] = "_control.tip2.tip_layer.confirm_btn.txt",
			["setting/tip3/tip_layer/bg"] = "_control.tip3.tip_layer.bg",
			["setting/email_tip/tip_layer/tip_name/fleet_name/text"] = "_control.email_tip.tip_layer.tip_name.fleet_name.text",
			["setting/tip3/tip_layer/bg_container/bg_blue_top"] = "_control.tip3.tip_layer.bg_container.bg_blue_top",
			["setting/exchange/bg_container/confirm_btn/txt"] = "_control.exchange.bg_container.confirm_btn.txt",
			["setting/main/set_main/app_inquire_main/app_user"] = "_control.main.set_main.app_inquire_main.app_user",
			["setting/main/set_main/battle_scene/battle_scene_control"] = "_control.main.set_main.battle_scene.battle_scene_control",
			["setting/tip3/tip_layer/bg_container/bg_blue_top_2"] = "_control.tip3.tip_layer.bg_container.bg_blue_top_2",
			["setting/main/set_main/hd_picture_main/picture_ok"] = "_control.main.set_main.hd_picture_main.picture_ok",
			["setting/tip3/tip_layer/bg_container/three_point"] = "_control.tip3.tip_layer.bg_container.three_point",
			["setting/tip3/tip_layer/bg_container/bg_blue_top_3"] = "_control.tip3.tip_layer.bg_container.bg_blue_top_3",
			["setting/tip1/tip_layer/bg"] = "_control.tip1.tip_layer.bg",
			["setting/tip3/tip_layer/black_line"] = "_control.tip3.tip_layer.black_line",
			["setting/tip1/tip_layer/cancel_btn"] = "_control.tip1.tip_layer.cancel_btn",
			["setting/main/set_main/sound_main/slider/Background"] = "_control.main.set_main.sound_main.slider.Background",
			["setting/tip3/tip_layer/tip"] = "_control.tip3.tip_layer.tip",
			["setting/tip3/tip_layer/all_btn/repair_data_btn"] = "_control.tip3.tip_layer.all_btn.repair_data_btn",
			["setting/main/set_main/live2d_framerate_main/live2d"] = "_control.main.set_main.live2d_framerate_main.live2d",
			["setting/main/set_main/battle_scene"] = "_control.main.set_main.battle_scene",
			["setting/main/srescheck"] = "_control.main.srescheck",
			["setting/main/set_main/bgm_main/bg"] = "_control.main.set_main.bgm_main.bg",
			["setting/main/set_main/app_inquire_main/app_inquire_btn/inquire"] = "_control.main.set_main.app_inquire_main.app_inquire_btn.inquire",
			["setting/main/set_main/always_light_scene_change_main/title_mask"] = "_control.main.set_main.always_light_scene_change_main.title_mask",
			["setting/main/set_main/live2d_framerate_main/live2d_control/txt"] = "_control.main.set_main.live2d_framerate_main.live2d_control.txt",
			["setting/tip3/tip_layer/all_btn/repair_data2_btn/txt"] = "_control.tip3.tip_layer.all_btn.repair_data2_btn.txt",
			["setting/main/set_main/live2d_framerate_main/framerate_control"] = "_control.main.set_main.live2d_framerate_main.framerate_control",
			["setting/main/set_main/app_inquire_main/app_user/inquire"] = "_control.main.set_main.app_inquire_main.app_user.inquire",
			["setting/main"] = "_control.main",
			["setting/tip3/tip_layer/all_btn/repair_datahd_btn"] = "_control.tip3.tip_layer.all_btn.repair_datahd_btn",
			["setting/tip1/tip_layer/bg_container/bg_blue_top"] = "_control.tip1.tip_layer.bg_container.bg_blue_top",
			["setting/tip3/tip_layer/all_btn/repair_datacv_btn"] = "_control.tip3.tip_layer.all_btn.repair_datacv_btn",
			["setting/tip3/tip_layer/all_btn/repair_datacv_btn/txt"] = "_control.tip3.tip_layer.all_btn.repair_datacv_btn.txt",
			["setting/main/set_main/battle_scene/battle_scene_txt"] = "_control.main.set_main.battle_scene.battle_scene_txt",
			["setting/main/set_main/hd_picture_main/picture_select/hd"] = "_control.main.set_main.hd_picture_main.picture_select.hd",
			["setting/main/contact_us"] = "_control.main.contact_us",
			["setting/tip3/tip_layer/all_btn/repair_datacv_jp_btn"] = "_control.tip3.tip_layer.all_btn.repair_datacv_jp_btn",
			["setting/tip3/tip_layer/all_btn/repair_datacv_jp_btn/txt"] = "_control.tip3.tip_layer.all_btn.repair_datacv_jp_btn.txt",
			["setting/main/set_main/cv_main/cv_select/chinese/txt"] = "_control.main.set_main.cv_main.cv_select.chinese.txt",
			["setting/tip/tip_layer/black_line"] = "_control.tip.tip_layer.black_line",
			["setting/main/set_main/always_light_scene_change_main/always_light_control/left"] = "_control.main.set_main.always_light_scene_change_main.always_light_control.left",
			["setting/exchange/bg_container/black_line_2"] = "_control.exchange.bg_container.black_line_2",
			["setting/main/set_main/always_light_scene_change_main"] = "_control.main.set_main.always_light_scene_change_main",
			["setting/tip3/tip_layer/all_btn/cancel_btn"] = "_control.tip3.tip_layer.all_btn.cancel_btn",
			["setting/email_tip/tip_layer/bg_container/bg_blue_top"] = "_control.email_tip.tip_layer.bg_container.bg_blue_top",
			["setting/email_tip"] = "_control.email_tip",
			["setting/tip1/tip_layer/bg_container/bg_blue_top_3"] = "_control.tip1.tip_layer.bg_container.bg_blue_top_3",
			["setting/email_tip/tip_layer/bg"] = "_control.bg",
			["setting/main/set_main/battle_scene/broken_control/right"] = "_control.main.set_main.battle_scene.broken_control.right",
			["setting/main/set_main/always_light_scene_change_main/scene_change"] = "_control.main.set_main.always_light_scene_change_main.scene_change",
			["setting/main/version"] = "_control.main.version",
			["setting/main/set_main/cvvol_main/slider/Handle Slide Area"] = "_control.main.set_main.cvvol_main.slider.Handle Slide Area",
			["setting/main/set_main/app_inquire_main/app_child/inquire"] = "_control.main.set_main.app_inquire_main.app_child.inquire",
			["setting/email_tip/tip_layer/tip_name/tip"] = "_control.email_tip.tip_layer.tip_name.tip",
			["setting/main/set_main/cv_main/bg"] = "_control.main.set_main.cv_main.bg",
			["setting/main/set_main/battle_scene/battle_scene_control/right"] = "_control.main.set_main.battle_scene.battle_scene_control.right",
			["setting/main/title"] = "_control.main.title",
			["setting/tip3/tip_layer/bg_container"] = "_control.tip3.tip_layer.bg_container",
			["setting/main/set_main/hd_picture_main/picture_select/line"] = "_control.main.set_main.hd_picture_main.picture_select.line",
			["setting/email_tip/tip_layer/tip_name/tip_1"] = "_control.email_tip.tip_layer.tip_name.tip_1",
			["setting/main/set_main/sound_main/bg"] = "_control.main.set_main.sound_main.bg",
			["setting/tip3/tip_layer"] = "_control.tip3.tip_layer",
			["setting/email_tip/tip_layer/bg_container"] = "_control.email_tip.tip_layer.bg_container",
			["setting/main/set_main/cvvol_main/slider"] = "_control.main.set_main.cvvol_main.slider",
			["setting/tip3/tip_layer/all_btn/cancel_btn/txt"] = "_control.tip3.tip_layer.all_btn.cancel_btn.txt",
			["setting/email_tip/tip_layer/bg_container/bg_blue_top_2"] = "_control.email_tip.tip_layer.bg_container.bg_blue_top_2",
			["setting/email_tip/tip_layer/bg_container/three_point"] = "_control.email_tip.tip_layer.bg_container.three_point",
			["setting/main/set_main/hd_picture_main/picture_select/normal"] = "_control.main.set_main.hd_picture_main.picture_select.normal",
			["setting/email_tip/tip_layer/bg_container/bg_blue_top_3"] = "_control.email_tip.tip_layer.bg_container.bg_blue_top_3",
			["setting/main/exchange/txt"] = "_control.main.exchange.txt",
			["setting/tip/tip_layer/bg_container/bg_blue_top_3"] = "_control.tip.tip_layer.bg_container.bg_blue_top_3",
			["setting/tip/tip_layer/cancel_btn"] = "_control.tip.tip_layer.cancel_btn",
			["setting/main/set_main/sound_main/title"] = "_control.main.set_main.sound_main.title",
			["setting/main/contact_us/txt"] = "_control.main.contact_us.txt",
			["setting/main/set_main/app_inquire_main/app_inquire"] = "_control.main.set_main.app_inquire_main.app_inquire",
			["setting/main/set_main/cvvol_main/number"] = "_control.main.set_main.cvvol_main.number",
			["setting/main/mask_bg/glow_img"] = "_control.main.mask_bg.glow_img",
			["setting/main/set_main/sound_main/slider/Fill Area"] = "_control.main.set_main.sound_main.slider.Fill Area",
			["setting/tip/tip_layer/tip"] = "_control.tip.tip_layer.tip",
			["setting/main/set_main/hd_picture_main/picture_select/normal/txt"] = "_control.main.set_main.hd_picture_main.picture_select.normal.txt",
			["setting/main/set_main/sound_main/number"] = "_control.main.set_main.sound_main.number",
			["setting/email_tip/tip_layer/tip_name/fleet_name/placeholder"] = "_control.email_tip.tip_layer.tip_name.fleet_name.placeholder",
			["setting/main/set_main/cv_main"] = "_control.main.set_main.cv_main",
			["setting/main/set_main/bind_email_address/live2d/name_level_2"] = "_control.main.set_main.bind_email_address.live2d.name_level_2",
			["setting/tip/tip_layer/bg"] = "_control.tip.tip_layer.bg",
			["setting/main/set_main/cvvol_main/slider/Background"] = "_control.main.set_main.cvvol_main.slider.Background",
			["setting/main/set_main/bgm_main/slider/Fill Area/Fill"] = "_control.main.set_main.bgm_main.slider.Fill Area.Fill",
			["setting/main/set_main/hd_picture_main/bg"] = "_control.main.set_main.hd_picture_main.bg",
			["setting/main/set_main/hd_picture_main/picture_ok/hd_picture"] = "_control.main.set_main.hd_picture_main.picture_ok.hd_picture",
			["setting/main/set_main/app_inquire_main/app_privacy/inquire"] = "_control.main.set_main.app_inquire_main.app_privacy.inquire",
			["setting/main/set_main/cvvol_main/slider/Fill Area"] = "_control.main.set_main.cvvol_main.slider.Fill Area",
			["setting/email_tip/tip_layer/bg_container/title"] = "_control.email_tip.tip_layer.bg_container.title",
			["setting/main/set_main/cv_main/cv_select"] = "_control.main.set_main.cv_main.cv_select",
			["setting/main/set_main/always_light_scene_change_main/always_light_control"] = "_control.main.set_main.always_light_scene_change_main.always_light_control",
			["setting/shadw"] = "_control.shadw",
			["setting/main/set_main"] = "_control.main.set_main",
			["setting/tip1/tip_layer/bg_container/title"] = "_control.tip1.tip_layer.bg_container.title",
			["setting/main/set_main/battle_scene/battle_scene_control/left"] = "_control.main.set_main.battle_scene.battle_scene_control.left",
			["setting/tip3/tip_layer/bg_container/title"] = "_control.tip3.tip_layer.bg_container.title",
			["setting/main/set_main/hd_picture_main"] = "_control.main.set_main.hd_picture_main",
			["setting/main/head_segmentation"] = "_control.main.head_segmentation",
			["setting/tip3"] = "_control.tip3",
			["setting/main/set_main/cv_main/cv_select/japanesecv"] = "_control.main.set_main.cv_main.cv_select.japanesecv",
			["setting/main/set_main/bgm_main/slider/Handle Slide Area/Handle"] = "_control.main.set_main.bgm_main.slider.Handle Slide Area.Handle"
		},
		click = {
			shadw = {
				tp = "UnityEngine.UI.Button"
			},
			["tip/tip_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip/tip_layer/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["exchange/bg_container/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip1/tip_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip1/tip_layer/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip2/tip_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip3/tip_layer/all_btn/repair_data_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip3/tip_layer/all_btn/repair_data2_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip3/tip_layer/all_btn/repair_datahd_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip3/tip_layer/all_btn/repair_datacv_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip3/tip_layer/all_btn/repair_datacv_jp_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["tip3/tip_layer/all_btn/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["email_tip/tip_layer/confirm_btn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["email_tip/tip_layer/cancel_btn"] = {
				tp = "UnityEngine.UI.Button"
			}
		},
		scale_btn_click = {
			["main/close"] = {
				tp = "ScaleButton"
			},
			["main/set_main/hd_picture_main/picture_select/normal"] = {
				tp = "ScaleButton"
			},
			["main/set_main/hd_picture_main/picture_select/hd"] = {
				tp = "ScaleButton"
			},
			["main/set_main/hd_picture_main/picture_ok/uibm"] = {
				tp = "ScaleButton"
			},
			["main/set_main/cv_main/cv_select/japanesecv"] = {
				tp = "ScaleButton"
			},
			["main/set_main/cv_main/cv_select/chinese"] = {
				tp = "ScaleButton"
			},
			["main/set_main/cv_main/cv_ok/uibm"] = {
				tp = "ScaleButton"
			},
			["main/set_main/always_light_scene_change_main/always_light_control/left"] = {
				tp = "ScaleButton"
			},
			["main/set_main/always_light_scene_change_main/always_light_control/right"] = {
				tp = "ScaleButton"
			},
			["main/set_main/always_light_scene_change_main/scene_change_control/left"] = {
				tp = "ScaleButton"
			},
			["main/set_main/always_light_scene_change_main/scene_change_control/right"] = {
				tp = "ScaleButton"
			},
			["main/set_main/live2d_framerate_main/live2d_control/left"] = {
				tp = "ScaleButton"
			},
			["main/set_main/live2d_framerate_main/live2d_control/right"] = {
				tp = "ScaleButton"
			},
			["main/set_main/live2d_framerate_main/framerate_control/left"] = {
				tp = "ScaleButton"
			},
			["main/set_main/live2d_framerate_main/framerate_control/right"] = {
				tp = "ScaleButton"
			},
			["main/set_main/bind_email_address/email_address"] = {
				tp = "ScaleButton"
			},
			["main/set_main/battle_scene/battle_scene_control/left"] = {
				tp = "ScaleButton"
			},
			["main/set_main/battle_scene/battle_scene_control/right"] = {
				tp = "ScaleButton"
			},
			["main/set_main/battle_scene/broken_control/left"] = {
				tp = "ScaleButton"
			},
			["main/set_main/battle_scene/broken_control/right"] = {
				tp = "ScaleButton"
			},
			["main/set_main/app_inquire_main/app_inquire_btn"] = {
				tp = "ScaleButton"
			},
			["main/set_main/app_inquire_main/app_user"] = {
				tp = "ScaleButton"
			},
			["main/set_main/app_inquire_main/app_privacy"] = {
				tp = "ScaleButton"
			},
			["main/set_main/app_inquire_main/app_three"] = {
				tp = "ScaleButton"
			},
			["main/set_main/app_inquire_main/app_child"] = {
				tp = "ScaleButton"
			},
			["main/sbtnback"] = {
				tp = "ScaleButton"
			},
			["main/srescheck"] = {
				tp = "ScaleButton"
			},
			["main/exchange"] = {
				tp = "ScaleButton"
			},
			["main/settingrule_btn"] = {
				tp = "ScaleButton"
			},
			["main/contact_us"] = {
				tp = "ScaleButton"
			},
			["exchange/bg_container/close_btn"] = {
				tp = "ScaleButton"
			}
		},
		canvas_set = {}
	}
}

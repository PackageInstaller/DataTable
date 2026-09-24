return {
	_rule_ = {
		none = {
			bg = {
				path = "bg",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UITweenSequence"
				}
			},
			scrollview = {
				path = "scrollview",
				list = {
					viewport = {
						path = "scrollview/viewport",
						list = {
							content = {
								path = "scrollview/viewport/content",
								list = {
									cook_panel = {
										path = "scrollview/viewport/content/cook_panel",
										list = {
											bg = {
												path = "scrollview/viewport/content/cook_panel/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg_1 = {
												path = "scrollview/viewport/content/cook_panel/bg_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icondes = {
												path = "scrollview/viewport/content/cook_panel/icondes",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											line = {
												path = "scrollview/viewport/content/cook_panel/line",
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
									cook_content = {
										path = "scrollview/viewport/content/cook_content",
										list = {
											itemone = {
												path = "scrollview/viewport/content/cook_content/itemone",
												list = {
													bg = {
														path = "scrollview/viewport/content/cook_content/itemone/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													mask = {
														path = "scrollview/viewport/content/cook_content/itemone/mask",
														list = {
															icon = {
																path = "scrollview/viewport/content/cook_content/itemone/mask/icon",
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
													namebg = {
														path = "scrollview/viewport/content/cook_content/itemone/namebg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon_mask = {
														path = "scrollview/viewport/content/cook_content/itemone/icon_mask",
														list = {
															icondes = {
																path = "scrollview/viewport/content/cook_content/itemone/icon_mask/icondes",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															icondes_2 = {
																path = "scrollview/viewport/content/cook_content/itemone/icon_mask/icondes_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
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
											"UnityEngine.UI.GridLayoutGroup",
											"UnityEngine.UI.ContentSizeFitter"
										}
									},
									furniture_panel = {
										path = "scrollview/viewport/content/furniture_panel",
										list = {
											bg = {
												path = "scrollview/viewport/content/furniture_panel/bg",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											bg_1 = {
												path = "scrollview/viewport/content/furniture_panel/bg_1",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Image"
												}
											},
											icondes = {
												path = "scrollview/viewport/content/furniture_panel/icondes",
												list = {},
												component = {
													"UnityEngine.RectTransform",
													"UnityEngine.CanvasRenderer",
													"UnityEngine.UI.Text"
												}
											},
											line = {
												path = "scrollview/viewport/content/furniture_panel/line",
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
									furniture_content = {
										path = "scrollview/viewport/content/furniture_content",
										list = {
											itemone = {
												path = "scrollview/viewport/content/furniture_content/itemone",
												list = {
													bg = {
														path = "scrollview/viewport/content/furniture_content/itemone/bg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													mask = {
														path = "scrollview/viewport/content/furniture_content/itemone/mask",
														list = {
															icon = {
																path = "scrollview/viewport/content/furniture_content/itemone/mask/icon",
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
													namebg = {
														path = "scrollview/viewport/content/furniture_content/itemone/namebg",
														list = {},
														component = {
															"UnityEngine.RectTransform",
															"UnityEngine.CanvasRenderer",
															"UnityEngine.UI.Image"
														}
													},
													icon_mask = {
														path = "scrollview/viewport/content/furniture_content/itemone/icon_mask",
														list = {
															icondes = {
																path = "scrollview/viewport/content/furniture_content/itemone/icon_mask/icondes",
																list = {},
																component = {
																	"UnityEngine.RectTransform",
																	"UnityEngine.CanvasRenderer",
																	"UnityEngine.UI.Text"
																}
															},
															icondes_2 = {
																path = "scrollview/viewport/content/furniture_content/itemone/icon_mask/icondes_2",
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
															"UnityEngine.UI.Mask",
															"TextHorizonScroller",
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
											"UnityEngine.UI.GridLayoutGroup",
											"UnityEngine.UI.ContentSizeFitter"
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Mask",
							"UnityEngine.UI.Image"
						}
					},
					scrollbarvertical = {
						path = "scrollview/scrollbarvertical",
						list = {
							slidingarea = {
								path = "scrollview/scrollbarvertical/slidingarea",
								list = {
									handle = {
										path = "scrollview/scrollbarvertical/slidingarea/handle",
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
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Scrollbar"
						}
					}
				},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image",
					"UnityEngine.UI.ScrollRect"
				}
			},
			bottomline = {
				path = "bottomline",
				list = {},
				component = {
					"UnityEngine.RectTransform",
					"UnityEngine.CanvasRenderer",
					"UnityEngine.UI.Image"
				}
			},
			top_layer = {
				path = "top_layer",
				list = {
					upline = {
						path = "top_layer/upline",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image"
						}
					},
					returnbtn = {
						path = "top_layer/returnbtn",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Image",
							"UnityEngine.UI.Button"
						}
					},
					title = {
						path = "top_layer/title",
						list = {},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.CanvasRenderer",
							"UnityEngine.UI.Text"
						}
					},
					upline_corner = {
						path = "top_layer/upline_corner",
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
			right_layer = {
				path = "right_layer",
				list = {
					type_layer = {
						path = "right_layer/type_layer",
						list = {
							des = {
								path = "right_layer/type_layer/des",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Text"
								}
							},
							icon = {
								path = "right_layer/type_layer/icon",
								list = {},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.CanvasRenderer",
									"UnityEngine.UI.Image"
								}
							},
							type_des = {
								path = "right_layer/type_layer/type_des",
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
			type_layer_detail = {
				path = "type_layer_detail",
				list = {
					toggle_group = {
						path = "type_layer_detail/toggle_group",
						list = {
							all = {
								path = "type_layer_detail/toggle_group/all",
								list = {
									Background = {
										path = "type_layer_detail/toggle_group/all/Background",
										list = {
											Checkmark = {
												path = "type_layer_detail/toggle_group/all/Background/Checkmark",
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
									Label = {
										path = "type_layer_detail/toggle_group/all/Label",
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
									"UnityEngine.UI.Toggle"
								}
							},
							item_parent = {
								path = "type_layer_detail/toggle_group/item_parent",
								list = {
									CV = {
										path = "type_layer_detail/toggle_group/item_parent/CV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CV/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/CV/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									CVL = {
										path = "type_layer_detail/toggle_group/item_parent/CVL",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CVL/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CVL/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/CVL/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									AV = {
										path = "type_layer_detail/toggle_group/item_parent/AV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/AV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/AV/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/AV/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									BB = {
										path = "type_layer_detail/toggle_group/item_parent/BB",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BB/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BB/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/BB/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									BBV = {
										path = "type_layer_detail/toggle_group/item_parent/BBV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BBV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BBV/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/BBV/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									BC = {
										path = "type_layer_detail/toggle_group/item_parent/BC",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BC/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BC/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/BC/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									CA = {
										path = "type_layer_detail/toggle_group/item_parent/CA",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CA/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CA/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/CA/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									CAV = {
										path = "type_layer_detail/toggle_group/item_parent/CAV",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CAV/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CAV/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/CAV/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									CLT = {
										path = "type_layer_detail/toggle_group/item_parent/CLT",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CLT/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CLT/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/CLT/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									CL = {
										path = "type_layer_detail/toggle_group/item_parent/CL",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/CL/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/CL/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/CL/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									BM = {
										path = "type_layer_detail/toggle_group/item_parent/BM",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/BM/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/BM/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/BM/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									DD = {
										path = "type_layer_detail/toggle_group/item_parent/DD",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/DD/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/DD/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/DD/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									SSG = {
										path = "type_layer_detail/toggle_group/item_parent/SSG",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/SSG/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/SSG/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/SSG/Label",
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
											"UnityEngine.UI.Toggle"
										}
									},
									SS = {
										path = "type_layer_detail/toggle_group/item_parent/SS",
										list = {
											Background = {
												path = "type_layer_detail/toggle_group/item_parent/SS/Background",
												list = {
													Checkmark = {
														path = "type_layer_detail/toggle_group/item_parent/SS/Background/Checkmark",
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
											Label = {
												path = "type_layer_detail/toggle_group/item_parent/SS/Label",
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
											"UnityEngine.UI.Toggle"
										}
									}
								},
								component = {
									"UnityEngine.RectTransform",
									"UnityEngine.UI.GridLayoutGroup"
								}
							}
						},
						component = {
							"UnityEngine.RectTransform",
							"UnityEngine.UI.ToggleGroup"
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
		click = {
			["top_layer/returnbtn"] = {
				tp = "UnityEngine.UI.Button"
			},
			["right_layer/type_layer"] = {
				tp = "UnityEngine.UI.Button"
			},
			type_layer_detail = {
				tp = "UnityEngine.UI.Button"
			}
		},
		toggle = {
			["type_layer_detail/toggle_group/all"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CVL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/AV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BB"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BBV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BC"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CA"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CAV"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CLT"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/CL"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/BM"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/DD"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/SSG"] = {
				tp = "UnityEngine.UI.Toggle"
			},
			["type_layer_detail/toggle_group/item_parent/SS"] = {
				tp = "UnityEngine.UI.Toggle"
			}
		},
		canvas_set = {}
	}
}

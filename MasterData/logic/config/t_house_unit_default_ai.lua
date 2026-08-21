-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_unit_default_ai.lua

module("logic.config.t_house_unit_default_ai", package.seeall)

aiConfigData = {
	root = {
		repeatForever = true,
		returnSuccess = false,
		count = 1,
		type = "Repeater",
		endOnFailure = false,
		aiTag = "Repeater_1",
		children = {
			{
				aiTag = "Selector_2",
				type = "Selector",
				children = {
					{
						aiTag = "Sequence_3",
						type = "Sequence",
						children = {
							{
								behaviorType = 0,
								aiTag = "SelectedByBehaviorType_4",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "EndAndNewBehavior_5",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_6",
						type = "Sequence",
						children = {
							{
								behaviorType = 10001,
								aiTag = "SelectedByBehaviorType_7",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "EndAndNewBehavior_8",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_9",
						type = "Sequence",
						children = {
							{
								behaviorType = 10002,
								aiTag = "SelectedByBehaviorType_10",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Selector_11",
								type = "Selector",
								children = {
									{
										aiTag = "Sequence_12",
										type = "Sequence",
										children = {
											{
												findBath = false,
												aiTag = "FindMyBed_13",
												type = "FindMyBed"
											},
											{
												aiTag = "SubTree_14",
												treeName = "sub_goto_target_room_ai",
												type = "SubTree"
											},
											{
												minTime = 45,
												aiTag = "Sleep_15",
												maxTime = 60,
												type = "Sleep"
											}
										}
									},
									{
										isSucc = true,
										aiTag = "ReturnResult_16",
										type = "ReturnResult"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_17",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_18",
						type = "Sequence",
						children = {
							{
								behaviorType = 10003,
								aiTag = "SelectedByBehaviorType_19",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Selector_20",
								type = "Selector",
								children = {
									{
										aiTag = "Sequence_21",
										type = "Sequence",
										children = {
											{
												findBath = true,
												aiTag = "FindMyBed_22",
												type = "FindMyBed"
											},
											{
												aiTag = "SubTree_23",
												treeName = "sub_goto_target_room_ai",
												type = "SubTree"
											},
											{
												minTime = 10,
												aiTag = "GotoBath_24",
												maxTime = 20,
												type = "GotoBath"
											},
											{
												maxWaitTime = 1,
												minWaitTime = 1,
												type = "Wait",
												aiTag = "Wait_25",
												isReset = false
											}
										}
									},
									{
										isSucc = true,
										aiTag = "ReturnResult_26",
										type = "ReturnResult"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_27",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_28",
						type = "Sequence",
						children = {
							{
								behaviorType = 10004,
								aiTag = "SelectedByBehaviorType_29",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_30",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_31",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_32",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_33",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 300,
												minWaitTime = 180,
												type = "Wait",
												aiTag = "Wait_34",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_35",
												children = {
													{
														aiTag = "SubTree_36",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_37",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_38",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_39",
						type = "Sequence",
						children = {
							{
								behaviorType = 20001,
								aiTag = "SelectedByBehaviorType_40",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_41",
								type = "Sequence",
								children = {
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_42",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_43",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 30,
												minWaitTime = 10,
												type = "Wait",
												aiTag = "Wait_44",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_45",
												children = {
													{
														aiTag = "SubTree_46",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_47",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_48",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_49",
						type = "Sequence",
						children = {
							{
								behaviorType = 20002,
								aiTag = "SelectedByBehaviorType_50",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Selector_51",
								type = "Selector",
								children = {
									{
										aiTag = "Sequence_52",
										type = "Sequence",
										children = {
											{
												aiTag = "FindNearestChair_53",
												type = "FindNearestChair"
											},
											{
												aiTag = "SubTree_54",
												treeName = "sub_goto_target_room_ai",
												type = "SubTree"
											},
											{
												minTime = 45,
												aiTag = "EatFood_55",
												maxTime = 60,
												type = "EatFood"
											}
										}
									},
									{
										isSucc = true,
										aiTag = "ReturnResult_56",
										type = "ReturnResult"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_57",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_58",
						type = "Sequence",
						children = {
							{
								behaviorType = 20003,
								aiTag = "SelectedByBehaviorType_59",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_60",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_61",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_62",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_63",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 300,
												minWaitTime = 180,
												type = "Wait",
												aiTag = "Wait_64",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_65",
												children = {
													{
														aiTag = "SubTree_66",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_67",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_68",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_69",
						type = "Sequence",
						children = {
							{
								behaviorType = 31001,
								aiTag = "SelectedByBehaviorType_70",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_71",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_72",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_73",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_74",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 20,
												minWaitTime = 10,
												type = "Wait",
												aiTag = "Wait_75",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_76",
												children = {
													{
														aiTag = "SubTree_77",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_78",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_79",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_80",
						type = "Sequence",
						children = {
							{
								behaviorType = 31002,
								aiTag = "SelectedByBehaviorType_81",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_82",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_83",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_84",
										behaviorStatus = 2,
										type = "ChangeBehaviorStatus"
									},
									{
										minTime = 30,
										aiTag = "PlayWorkToolAction_85",
										maxTime = 45,
										type = "PlayWorkToolAction"
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_86",
										behaviorStatus = 2,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_87",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_88",
						type = "Sequence",
						children = {
							{
								behaviorType = 32001,
								aiTag = "SelectedByBehaviorType_89",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_90",
								type = "Sequence",
								children = {
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_91",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_92",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 20,
												minWaitTime = 10,
												type = "Wait",
												aiTag = "Wait_93",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_94",
												children = {
													{
														aiTag = "SubTree_95",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_96",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_97",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_98",
						type = "Sequence",
						children = {
							{
								behaviorType = 32002,
								aiTag = "SelectedByBehaviorType_99",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_100",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_101",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_102",
										behaviorStatus = 2,
										type = "ChangeBehaviorStatus"
									},
									{
										minTime = 30,
										aiTag = "PlayWorkToolAction_103",
										maxTime = 45,
										type = "PlayWorkToolAction"
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_104",
										behaviorStatus = 2,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_105",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_106",
						type = "Sequence",
						children = {
							{
								behaviorType = 32003,
								aiTag = "SelectedByBehaviorType_107",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_108",
								type = "Sequence",
								children = {
									{
										aiTag = "Selector_109",
										type = "Selector",
										children = {
											{
												aiTag = "Sequence_110",
												type = "Sequence",
												children = {
													{
														step = 1,
														aiTag = "SelectedByStep_111",
														type = "SelectedByStep"
													},
													{
														roomId = 1211,
														aiTag = "SetTargetRoomId_112",
														type = "SetTargetRoomId"
													},
													{
														aiTag = "SubTree_113",
														treeName = "sub_goto_target_room_ai",
														type = "SubTree"
													},
													{
														isClear = false,
														aiTag = "ChangeBehaviorStatus_114",
														behaviorStatus = 2,
														type = "ChangeBehaviorStatus"
													},
													{
														actionNames = "idle",
														aiTag = "PlayRandomAction_115",
														isLoop = true,
														type = "PlayRandomAction"
													},
													{
														maxWaitTime = 20,
														minWaitTime = 20,
														type = "Wait",
														aiTag = "Wait_116",
														isReset = true
													},
													{
														step = 2,
														aiTag = "SetStep_117",
														type = "SetStep"
													},
													{
														isClear = true,
														aiTag = "ChangeBehaviorStatus_118",
														behaviorStatus = 2,
														type = "ChangeBehaviorStatus"
													}
												}
											},
											{
												isSucc = true,
												aiTag = "ReturnResult_119",
												type = "ReturnResult"
											}
										}
									},
									{
										aiTag = "Sequence_120",
										type = "Sequence",
										children = {
											{
												step = 2,
												aiTag = "SelectedByStep_121",
												type = "SelectedByStep"
											},
											{
												roomId = 1203,
												aiTag = "SetTargetRoomId_122",
												type = "SetTargetRoomId"
											},
											{
												aiTag = "SubTree_123",
												treeName = "sub_goto_target_room_ai",
												type = "SubTree"
											}
										}
									},
									{
										aiTag = "EndAndNewBehavior_124",
										type = "EndAndNewBehavior"
									}
								}
							}
						}
					},
					{
						aiTag = "Sequence_125",
						type = "Sequence",
						children = {
							{
								behaviorType = 32004,
								aiTag = "SelectedByBehaviorType_126",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_127",
								type = "Sequence",
								children = {
									{
										aiTag = "Selector_128",
										type = "Selector",
										children = {
											{
												aiTag = "Sequence_129",
												type = "Sequence",
												children = {
													{
														step = 1,
														aiTag = "SelectedByStep_130",
														type = "SelectedByStep"
													},
													{
														roomId = 1207,
														aiTag = "SetTargetRoomId_131",
														type = "SetTargetRoomId"
													},
													{
														aiTag = "SubTree_132",
														treeName = "sub_goto_target_room_ai",
														type = "SubTree"
													},
													{
														isClear = false,
														aiTag = "ChangeBehaviorStatus_133",
														behaviorStatus = 2,
														type = "ChangeBehaviorStatus"
													},
													{
														actionNames = "idle",
														aiTag = "PlayRandomAction_134",
														isLoop = true,
														type = "PlayRandomAction"
													},
													{
														maxWaitTime = 20,
														minWaitTime = 20,
														type = "Wait",
														aiTag = "Wait_135",
														isReset = true
													},
													{
														step = 2,
														aiTag = "SetStep_136",
														type = "SetStep"
													},
													{
														isClear = true,
														aiTag = "ChangeBehaviorStatus_137",
														behaviorStatus = 2,
														type = "ChangeBehaviorStatus"
													}
												}
											},
											{
												isSucc = true,
												aiTag = "ReturnResult_138",
												type = "ReturnResult"
											}
										}
									},
									{
										aiTag = "Sequence_139",
										type = "Sequence",
										children = {
											{
												step = 2,
												aiTag = "SelectedByStep_140",
												type = "SelectedByStep"
											},
											{
												roomId = 1203,
												aiTag = "SetTargetRoomId_141",
												type = "SetTargetRoomId"
											},
											{
												aiTag = "SubTree_142",
												treeName = "sub_goto_target_room_ai",
												type = "SubTree"
											}
										}
									},
									{
										aiTag = "EndAndNewBehavior_143",
										type = "EndAndNewBehavior"
									}
								}
							}
						}
					},
					{
						aiTag = "Sequence_144",
						type = "Sequence",
						children = {
							{
								behaviorType = 33001,
								aiTag = "SelectedByBehaviorType_145",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_146",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_147",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_148",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_149",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 20,
												minWaitTime = 10,
												type = "Wait",
												aiTag = "Wait_150",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_151",
												children = {
													{
														aiTag = "SubTree_152",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_153",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_154",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_155",
						type = "Sequence",
						children = {
							{
								behaviorType = 33002,
								aiTag = "SelectedByBehaviorType_156",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_157",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_158",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_159",
										behaviorStatus = 2,
										type = "ChangeBehaviorStatus"
									},
									{
										minTime = 30,
										aiTag = "PlayWorkToolAction_160",
										maxTime = 45,
										type = "PlayWorkToolAction"
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_161",
										behaviorStatus = 2,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_162",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_163",
						type = "Sequence",
						children = {
							{
								behaviorType = 34001,
								aiTag = "SelectedByBehaviorType_164",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_165",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_166",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_167",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_168",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 20,
												minWaitTime = 10,
												type = "Wait",
												aiTag = "Wait_169",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_170",
												children = {
													{
														aiTag = "SubTree_171",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_172",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_173",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_174",
						type = "Sequence",
						children = {
							{
								behaviorType = 34002,
								aiTag = "SelectedByBehaviorType_175",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_176",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_177",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										minTime = 30,
										aiTag = "PlayWorkToolAction_178",
										maxTime = 45,
										type = "PlayWorkToolAction"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_179",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_180",
						type = "Sequence",
						children = {
							{
								behaviorType = 34003,
								aiTag = "SelectedByBehaviorType_181",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_182",
								type = "Sequence",
								children = {
									{
										aiTag = "Selector_183",
										type = "Selector",
										children = {
											{
												aiTag = "Sequence_184",
												type = "Sequence",
												children = {
													{
														step = 1,
														aiTag = "SelectedByStep_185",
														type = "SelectedByStep"
													},
													{
														aiTag = "SubTree_186",
														treeName = "sub_goto_target_room_ai",
														type = "SubTree"
													},
													{
														aiTag = "TakeGoodsFromShelter_187",
														type = "TakeGoodsFromShelter"
													},
													{
														step = 2,
														aiTag = "SetStep_188",
														type = "SetStep"
													},
													{
														maxWaitTime = 1,
														minWaitTime = 1,
														type = "Wait",
														aiTag = "Wait_189",
														isReset = false
													}
												}
											},
											{
												isSucc = true,
												aiTag = "ReturnResult_190",
												type = "ReturnResult"
											}
										}
									},
									{
										aiTag = "Selector_191",
										type = "Selector",
										children = {
											{
												aiTag = "Sequence_192",
												type = "Sequence",
												children = {
													{
														step = 2,
														aiTag = "SelectedByStep_193",
														type = "SelectedByStep"
													},
													{
														aiTag = "SubTree_194",
														treeName = "sub_goto_target_room_ai",
														type = "SubTree"
													},
													{
														aiTag = "ReturnGoodsToTrading_195",
														type = "ReturnGoodsToTrading"
													},
													{
														step = 3,
														aiTag = "SetStep_196",
														type = "SetStep"
													},
													{
														maxWaitTime = 2,
														minWaitTime = 2,
														type = "Wait",
														aiTag = "Wait_197",
														isReset = false
													}
												}
											},
											{
												isSucc = true,
												aiTag = "ReturnResult_198",
												type = "ReturnResult"
											}
										}
									},
									{
										aiTag = "Sequence_199",
										type = "Sequence",
										children = {
											{
												step = 3,
												aiTag = "SelectedByStep_200",
												type = "SelectedByStep"
											},
											{
												aiTag = "SetScheduleRoomId_201",
												type = "SetScheduleRoomId"
											},
											{
												aiTag = "SubTree_202",
												treeName = "sub_goto_target_room_ai",
												type = "SubTree"
											}
										}
									},
									{
										aiTag = "EndAndNewBehavior_203",
										type = "EndAndNewBehavior"
									}
								}
							}
						}
					},
					{
						aiTag = "Sequence_204",
						type = "Sequence",
						children = {
							{
								behaviorType = 40001,
								aiTag = "SelectedByBehaviorType_205",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_206",
								type = "Sequence",
								children = {
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_207",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_208",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 30,
												minWaitTime = 10,
												type = "Wait",
												aiTag = "Wait_209",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_210",
												children = {
													{
														aiTag = "SubTree_211",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_212",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_213",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_214",
						type = "Sequence",
						children = {
							{
								behaviorType = 40002,
								aiTag = "SelectedByBehaviorType_215",
								type = "SelectedByBehaviorType"
							},
							{
								aiTag = "Sequence_216",
								type = "Sequence",
								children = {
									{
										aiTag = "SubTree_217",
										treeName = "sub_goto_target_room_ai",
										type = "SubTree"
									},
									{
										isClear = false,
										aiTag = "ChangeBehaviorStatus_218",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									},
									{
										aiTag = "ParallelSelector_219",
										type = "ParallelSelector",
										children = {
											{
												maxWaitTime = 300,
												minWaitTime = 180,
												type = "Wait",
												aiTag = "Wait_220",
												isReset = true
											},
											{
												repeatForever = true,
												returnSuccess = false,
												count = 1,
												type = "Repeater",
												endOnFailure = false,
												aiTag = "Repeater_221",
												children = {
													{
														aiTag = "SubTree_222",
														treeName = "sub_unit_base_ai",
														type = "SubTree"
													}
												}
											}
										}
									},
									{
										isClear = true,
										aiTag = "ChangeBehaviorStatus_223",
										behaviorStatus = 1,
										type = "ChangeBehaviorStatus"
									}
								}
							},
							{
								aiTag = "EndAndNewBehavior_224",
								type = "EndAndNewBehavior"
							}
						}
					},
					{
						aiTag = "Sequence_225",
						type = "Sequence",
						children = {
							{
								behaviorType = 90002,
								aiTag = "SelectedByBehaviorType_226",
								type = "SelectedByBehaviorType"
							},
							{
								repeatForever = true,
								returnSuccess = false,
								count = 1,
								type = "Repeater",
								endOnFailure = false,
								aiTag = "Repeater_227",
								children = {
									{
										aiTag = "Sequence_228",
										type = "Sequence",
										children = {
											{
												aiTag = "ParallelSelector_229",
												type = "ParallelSelector",
												children = {
													{
														maxWaitTime = 7,
														minWaitTime = 5,
														type = "Wait",
														aiTag = "Wait_230",
														isReset = false
													},
													{
														repeatForever = true,
														returnSuccess = false,
														count = 1,
														type = "Repeater",
														endOnFailure = false,
														aiTag = "Repeater_231",
														children = {
															{
																aiTag = "RandomWalk_232",
																type = "RandomWalk"
															}
														}
													}
												}
											},
											{
												aiTag = "SelectedByWorkType_233",
												workType = 4,
												type = "SelectedByWorkType"
											},
											{
												aiTag = "OperateShelterDevice_234",
												minOperateTime = 8,
												maxPanicTime = 5,
												type = "OperateShelterDevice",
												minPanicTime = 3,
												maxOperateTime = 15
											}
										}
									}
								}
							}
						}
					},
					{
						aiTag = "Sequence_235",
						type = "Sequence",
						children = {
							{
								behaviorType = 90003,
								aiTag = "SelectedByBehaviorType_236",
								type = "SelectedByBehaviorType"
							},
							{
								repeatForever = true,
								returnSuccess = false,
								count = 1,
								type = "Repeater",
								endOnFailure = false,
								aiTag = "Repeater_237",
								children = {
									{
										aiTag = "Sequence_238",
										type = "Sequence",
										children = {
											{
												aiTag = "RandomWalk_239",
												type = "RandomWalk"
											},
											{
												maxWaitTime = 7,
												minWaitTime = 4,
												type = "Wait",
												aiTag = "Wait_240",
												isReset = false
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}



-- tags

-- 113501:格子4战斗
-- 113502:格子8战斗
-- 113503:格子8战斗
-- 113504:格子8战斗
-- 113505:格子8战斗
-- 113506:格子8战斗
-- 113507:格子8战斗

-- 113510:格子9金疮药
-- 113511:格子12金疮药

-- 113500:章节结束



local scene_013501 = {
	name = "序章1",
	id = 13501,
	enter = {13501,1001},

	points = {
		[1001] = {
			name = "殿门",
			pos = {68,-225},
			id = 1001,
			grids = {[1]=1002,},
			desc = "大殿前的白石台阶染了血渍，玉石兽头成了碎块，殿门大开，一片狼藉。",
			triggerDesc = "一行人匆匆赶到，便瞧见了殿门已经失守了。",
		},

		[1002] = {
			name = "空地",
			pos = {68,-121},
			id = 1002,
			grids = {[2]=1001,[1]=1003,},
			desc = "前殿桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1003] = {
			name = "空地",
			pos = {68,-17},
			id = 1003,
			grids = {[2]=1002,[1]=1004,},
			desc = "前殿桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1004] = {
			name = "空地",
			pos = {68,87},
			id = 1004,
			grids = {[2]=1003,[1]=1005,},
			desc = "两排高大威严的立柱，将大殿隔成了左殿、中殿、右殿",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",

			npcs = {
				{
					npcName = "洪水旗弟子",
					desc = "一身青色短衫，带着青色面具，兵刃也泛着青光。",
					visibleConditions = {noTags = {113501}},
					[1] = {
						
						talks = {
							{npc = "制住他们！",player = "小心。",npcName = "洪水旗弟子"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 1, id = 1413501, level = 200 },
								{ index = 2, id = 1413501, level = 200 },
								{ index = 3, id = 1413501, level = 200 },
								{ index = 4, id = 1413501, level = 200 },
								{ index = 7, id = 1413501, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {113501},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113501}},
					failMsg = "几名明教弟子朝这里冲来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1005] = {
			name = "空地",
			pos = {68,191},
			id = 1005,
			grids = {[2]=1004,[1]=1006,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1006] = {
			name = "岔口",
			pos = {68,295},
			id = 1006,
			grids = {[2]=1005,[3]=1007,[4]=1010,[1]=1015,},
			desc = "两排立柱的拐角处，雕花窗格也已经被砍的支离破碎。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1007] = {
			name = "空地",
			pos = {-165,295},
			id = 1007,
			grids = {[4]=1006,[3]=1008,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1008] = {
			name = "岔口",
			pos = {-398,295},
			id = 1008,
			grids = {[4]=1007,[3]=1009,[1]=1013,},
			desc = "两排立柱的拐角处，雕花窗格也已经被砍的支离破碎。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",

			npcs = {
				{
					npcName = "厚土旗弟子",
					desc = "一身土色劲装，土色头巾裹住面庞和发髻，只露出一双眼睛，机敏迅捷。",
					visibleConditions = {noTags = {113502}},
					[1] = {
						
						talks = {
							{npc = "制住他们！",player = "小心。",npcName = "厚土旗弟子"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 8, id = 1413502, level = 200 },
								{ index = 5, id = 1413502, level = 200 },
								{ index = 3, id = 1413502, level = 200 },
								{ index = 4, id = 1413502, level = 200 },
								{ index = 7, id = 1413502, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {113502},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113502}},
					failMsg = "几名明教弟子朝这里冲来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1009] = {
			name = "殿墙",
			pos = {-631,295},
			id = 1009,
			grids = {[4]=1008,},
			desc = "大殿的侧墙，墙面上刻画着峨眉的武功招式。",
			triggerDesc = "年幼的峨眉弟子正躲在侧殿边为师姐们送来金疮药。",

			npcs = {
				{
					npcName = "年幼的弟子",
					desc = "面容清冷，一身白衣，右肩布着绿色云纹，背负青色剑鞘。",
					[1] = {
						conditions = {noTags = {113510}},
						talks = {
							{npc = "快些来，这边有金疮药，几位少侠稍作调整。",player = "多谢",npcName = "年幼的弟子"},
						},
						next = 5,
					},
					[2] = {
						talks = {
							{npc = "几位加油！把这些魔道妖人给打回去！",player = "嗯，一定的！",npcName = "年幼的弟子"},
						},
					},
					[5] = {
						res = {
							tags = 113510,
							items = {{110301,5}}
						}
					},
				},
			},
		},

		[1010] = {
			name = "空地",
			pos = {301,295},
			id = 1010,
			grids = {[3]=1006,[4]=1011,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1011] = {
			name = "岔口",
			pos = {534,295},
			id = 1011,
			grids = {[3]=1010,[4]=1012,[1]=1017,},
			desc = "两排立柱的拐角处，雕花窗格也已经被砍的支离破碎。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",

			npcs = {
				{
					npcName = "烈火旗弟子",
					desc = "一身火红色上衣，兵刃上绑着红色绸带，攻势如火。",
					visibleConditions = {noTags = {113503}},
					[1] = {
						
						talks = {
							{npc = "制住他们！",player = "小心。",npcName = "厚土旗弟子"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 9, id = 1413503, level = 200 },
								{ index = 6, id = 1413503, level = 200 },
								{ index = 3, id = 1413503, level = 200 },
								{ index = 4, id = 1413503, level = 200 },
								{ index = 7, id = 1413503, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {113503},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113503}},
					failMsg = "几名明教弟子朝这里冲来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1012] = {
			name = "殿墙",
			pos = {767,295},
			id = 1012,
			grids = {[3]=1011,},
			desc = "大殿的侧墙，墙面上刻画着峨眉的武功招式。",
			triggerDesc = "年幼的峨眉弟子正躲在侧殿边为师姐们送来金疮药。",

			npcs = {
				{
					npcName = "年幼的弟子",
					desc = "面容清冷，一身白衣，右肩布着绿色云纹，背负青色剑鞘。",
					[1] = {
						conditions = {noTags = {113511}},
						talks = {
							{npc = "快些来，这边有金疮药，几位少侠稍作调整。",player = "多谢",npcName = "年幼的弟子"},
						},
						next = 5,
					},
					[2] = {
						talks = {
							{npc = "几位加油！把这些魔道妖人给打回去！",player = "嗯，一定的！",npcName = "年幼的弟子"},
						},
					},
					[5] = {
						res = {
							tags = 113511,
							items = {{110301,5}}
						}
					},
				},
			},
		},

		[1013] = {
			name = "殿墙",
			pos = {-398,399},
			id = 1013,
			grids = {[2]=1008,[4]=1014,},
			desc = "大殿的侧墙，墙面上刻画着峨眉的武功招式。",
			triggerDesc = "峨眉弟子虽坚韧不屈，但武技尚未大成，不多久便落了下风。",
		},

		[1014] = {
			name = "空地",
			pos = {-165,399},
			id = 1014,
			grids = {[3]=1013,[1]=1018,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1015] = {
			name = "中殿",
			pos = {68,399},
			id = 1015,
			grids = {[2]=1006,[1]=1019,},
			desc = "中殿的两侧各是一排高大威严的立柱，金戈之声隔着柱子震荡回响。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1016] = {
			name = "空地",
			pos = {301,399},
			id = 1016,
			grids = {[4]=1017,[1]=1020,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1017] = {
			name = "殿墙",
			pos = {534,399},
			id = 1017,
			grids = {[3]=1016,[2]=1011,},
			desc = "大殿的侧墙，墙面上刻画着峨眉的武功招式。",
			triggerDesc = "峨眉弟子虽坚韧不屈，但武技尚未大成，不多久便落了下风。",
		},

		[1018] = {
			name = "立柱",
			pos = {-165,503},
			id = 1018,
			grids = {[2]=1014,[1]=1021,},
			desc = "两排高大威严的立柱，将大殿隔成了左殿、中殿、右殿。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",

			npcs = {
				{
					npcName = "明教弟子",
					desc = "一大群明教弟子围在这里，堵住了前来增援的峨眉弟子",
					visibleConditions = {noTags = {113504}},
					[1] = {
						
						talks = {
							{npc = "制住他们！",player = "小心。",npcName = "明教弟子"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 8, id = 1413501, level = 200 },
								{ index = 5, id = 1413501, level = 200 },
								{ index = 1, id = 1413502, level = 200 },
								{ index = 4, id = 1413502, level = 200 },
								{ index = 3, id = 1413503, level = 200 },
								{ index = 6, id = 1413503, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {113504},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113504}},
					failMsg = "几名明教弟子朝这里冲来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1019] = {
			name = "立柱",
			pos = {68,503},
			id = 1019,
			grids = {[2]=1015,[1]=1022,},
			desc = "两排高大威严的立柱，将大殿隔成了左殿、中殿、右殿。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",

			npcs = {
				{
					npcName = "明教弟子",
					desc = "一大群明教弟子围在这里，堵住了前来增援的峨眉弟子",
					visibleConditions = {noTags = {113505}},
					[1] = {
						
						talks = {
							{npc = "制住他们！",player = "小心。",npcName = "明教弟子"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 8, id = 1413501, level = 200 },
								{ index = 5, id = 1413501, level = 200 },
								{ index = 1, id = 1413502, level = 200 },
								{ index = 4, id = 1413502, level = 200 },
								{ index = 3, id = 1413503, level = 200 },
								{ index = 6, id = 1413503, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {113505},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113505}},
					failMsg = "几名明教弟子朝这里冲来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1020] = {
			name = "立柱",
			pos = {301,503},
			id = 1020,
			grids = {[2]=1016,[1]=1023,},
			desc = "两排高大威严的立柱，将大殿隔成了左殿、中殿、右殿。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",

			npcs = {
				{
					npcName = "明教弟子",
					desc = "一大群明教弟子围在这里，堵住了前来增援的峨眉弟子",
					visibleConditions = {noTags = {113506}},
					[1] = {
						
						talks = {
							{npc = "制住他们！",player = "小心。",npcName = "明教弟子"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 
							},
							enemies = {
								{ index = 4, id = 1413501, level = 200 },
								{ index = 5, id = 1413501, level = 200 },
								{ index = 6, id = 1413502, level = 200 },
								{ index = 7, id = 1413502, level = 200 },
								{ index = 8, id = 1413503, level = 200 },
								{ index = 9, id = 1413503, level = 200 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						res = {
							tags = {113506},
						},
					},
				},
			},
			leaveParts = {
				{
					conditions = {tags = {113506}},
					failMsg = "几名明教弟子朝这里冲来。",	-- 打算离开本格子但是conditions不满足时弹出的信息
				},
			}
		},

		[1021] = {
			name = "空地",
			pos = {-165,607},
			id = 1021,
			grids = {[2]=1018,[1]=1024,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1022] = {
			name = "中殿",
			pos = {68,607},
			id = 1022,
			grids = {[2]=1019,[1]=1025,},
			desc = "中殿的两侧各是一排高大威严的立柱，金戈之声隔着柱子震荡回响。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1023] = {
			name = "空地",
			pos = {301,607},
			id = 1023,
			grids = {[2]=1020,[1]=1026,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1024] = {
			name = "空地",
			pos = {-165,711},
			id = 1024,
			grids = {[2]=1021,[4]=1025,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1025] = {
			name = "岔口",
			pos = {68,711},
			id = 1025,
			grids = {[2]=1022,[1]=1027,[3]=1024,[4]=1026,},
			desc = "两排立柱的拐角处，雕花窗格也已经被砍的支离破碎。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1026] = {
			name = "空地",
			pos = {301,711},
			id = 1026,
			grids = {[2]=1023,[3]=1025,},
			desc = "恢弘的大殿已然一片狼藉，前殿更是桌倒椅翻，处处刀砍剑挑的痕迹。",
			triggerDesc = "殿内乱成一团，峨嵋弟子与明教弟子正奋力地缠斗厮杀。",
		},

		[1027] = {
			name = "祖师像",
			pos = {68,815},
			id = 1027,
			grids = {[2]=1025,},
			desc = "大殿中央供着峨眉祖师，那是郭襄年轻时的样子，右手掐着剑诀，左手持剑于身后。",
			triggerDesc = "峨眉弟子退拢在灭绝师太的身旁，与紫衫龙王为首的明教弟子对峙着。",

			npcs = {
				{
					npcName = "紫衫龙王",
					desc = "是碧水潭畔的凌波仙子，也是明教圣女紫衫龙王，来如流水兮逝似风，不知何来兮何所终。",
					visibleConditions = {noTags = {113507}},
					[1] = {
						
						talks = {
							{player = "师太，你伤势如何？"},
							{npc = "小家伙，一边去，峨眉的事还不着尔等小辈来管",npcName = "灭绝师太"},
							{npc = "哦哟，好大的口气，灭绝灭绝，不过尔尔。",npcName = "紫衫龙王"},
							{npc = "紫衫女子与灭绝师太再次倾力以搏，犹如襟带朔风，足踏寒冰。",npcName = ""},
							{npc = "二人武技皆如火纯青，几番过招之后，一记猛烈的对掌，灭绝师太连退三步，嘴角印出鲜血，已然受了内伤。",npcName = ""},
							{npc = "灭绝，还是交出九阳功的心法吧！否则，便要火烧峨眉了！",npcName = "紫衫龙王"},
							{npc = "峨眉弟子就是战死，也绝不做辱没师祖的事，动手吧！",player = "且慢。",npcName = "灭绝师太"},
							{npc = "小家伙，就你？也想螳臂挡车？",player = "同为武林正道，自然义不容辞，请前辈赐教！",npcName = "紫衫龙王"},
							{npc = "哈哈，不自量力！便看你能挡接我几招！能接我五招便算饶你一命！",npcName = "紫衫龙王"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							winCond = {
							-- {id = 1},	-- 默认选项，击败所有敌人
							-- {id = 2, npc = 12345},{id = 2, npc = 54321}, -- 击杀指定敌人
							-- {id = 3, round = 4}, -- 4回合内击杀敌人
							{id = 4, round = 5}, -- 坚持4回合
						},
							friends = { 

							},
							enemies = {
								{ index = 8, id = 1413504, level = 500 },
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						talks = {
							{npc = "不错不错，竟能接我五招!",player = "咳，不知前辈可否。。",npcName = "紫衫龙王"},
							{npc = "行，看你小家伙顺眼，就留着峨嵋弟子的性命了（一抬手，指向大殿中央的峨眉祖师像）毁了！",npcName = "紫衫龙王"},
							{npc = "烈火旗弟子催动火器机关直接炸毁了祖师像。",npcName = ""},
							{npc = "刹那间整座大殿中的长青灯全部熄灭。",npcName = ""},
							{npc = "只听一声剑鸣，如龙吟般清亮，又见白光，一柄如裹着银月的长剑飞向殿外。",npcName = ""},
							{npc = "倚天剑！！原来祖师将倚天剑封存于像中！",npcName = "灭绝师太"},
							{npc = "竟然是倚天剑！",npcName = "紫衫龙王"},
							{npc = "快追！天意啊，倚天剑是我的了！",npcName = "紫衫龙王"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {113507,113500},
						},
					},
				},
			},
			npcs = {
				{
					npcName = "灭绝师太",
					desc = "约莫四十五岁的年纪，样貌原本不俗，但面若寒霜，眉尖斜斜下垂，瞧着极是严厉。",
					visibleConditions = {noTags = {113507}},
					[1] = {
						
						talks = {
							{player = "师太，你伤势如何？"},
							{npc = "小家伙，一边去，峨眉的事还不着尔等小辈来管",npcName = "灭绝师太"},
							{npc = "哦哟，好大的口气，灭绝灭绝，不过尔尔。",npcName = "紫衫龙王"},
							{npc = "紫衫女子与灭绝师太再次倾力以搏，犹如襟带朔风，足踏寒冰。",npcName = ""},
							{npc = "二人武技皆如火纯青，几番过招之后，一记猛烈的对掌，灭绝师太连退三步，嘴角印出鲜血，已然受了内伤。",npcName = ""},
							{npc = "灭绝，还是交出九阳功的心法吧！否则，便要火烧峨眉了！",npcName = "紫衫龙王"},
							{npc = "峨眉弟子就是战死，也绝不做辱没师祖的事，动手吧！",player = "且慢。",npcName = "灭绝师太"},
							{npc = "小家伙，就你？也想螳臂挡车？",player = "同为武林正道，自然义不容辞，请前辈赐教！",npcName = "紫衫龙王"},
							{npc = "哈哈，不自量力！便看你能挡接我几招！",npcName = "紫衫龙王"},
						},
						next = 5,
					},

					[5] = {
						battle = {
							friends = { 

							},
							enemies = {
								{ index = 8, id = 1413504, level = 300 },
								
							},
							battleRes = {
								-- 平局
								[1] = {
									conditions = { battleWin = 0, },
									levelFinished = -1
								},
								-- 胜利
								[2] = {
									conditions = { battleWin = 1, },
									next = 6,
								},
								-- 失败
								[3] = {
									conditions = { battleWin = 2, },
									levelFinished = -1
								},
							},
						},
					},
					[6] = {
						talks = {
							{npc = "不错不错，竟能接我八招!",player = "咳，不知前辈可否。。",npcName = "紫衫龙王"},
							{npc = "行，看你小家伙顺眼，就留着峨嵋弟子的性命了（一抬手，指向大殿中央的峨眉祖师像）毁了！",npcName = "紫衫龙王"},
							{npc = "烈火旗弟子催动火器机关直接炸毁了祖师像。",npcName = ""},
							{npc = "刹那间整座大殿中的长青灯全部熄灭。",npcName = ""},
							{npc = "只听一声剑鸣，如龙吟般清亮，又见白光，一柄如裹着银月的长剑飞向殿外。",npcName = ""},
							{npc = "倚天剑！！原来祖师将倚天剑封存于像中！",npcName = "灭绝师太"},
							{npc = "竟然是倚天剑！",npcName = "紫衫龙王"},
							{npc = "快追！天意啊，倚天剑是我的了！",npcName = "紫衫龙王"},
						},
						next = 8,
					},
					[8] = {
						res = {
							tags = {113507,113500},
						},
					},
				},
			},
		},
	}
}

return scene_013501

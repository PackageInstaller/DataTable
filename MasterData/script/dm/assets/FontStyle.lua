-- chunkname: @/tmp/or_script/lua_compile/dm/assets/FontStyle.lua

FontStyle = FontStyle or {}
TEXT_LINEBREAKWITH_SPACE = true
NUMBER_BM_FONT = "asset/bmfont/number_bmfont.fnt"
FontStyleColor = {
	kWhite = cc.c3b(255, 255, 255),
	kRed = cc.c3b(254, 251, 228),
	kYellow = cc.c3b(253, 202, 91),
	kBlack = cc.c3b(0, 0, 0)
}

function FontStyle:getStyleConfigByType(style)
	return FontStyleType[style]
end

function FontStyle:setStyleConfig()
	FontStyleType = {
		FontTipsText = {
			fontName = TTF_FONT_BOLD,
			color = FontStyleColor.kWhite
		},
		FontSubTitle = {
			color = FontStyleColor.kRed
		},
		FontNumberText = {
			color = FontStyleColor.kYellow
		},
		FontWBBZText = {
			color = cc.c3b(129, 92, 45)
		},
		FontGeDangText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(66, 12, 3, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 190, 71, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 246, 189, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontFanShangText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(49, 0, 20, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 56, 17, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(196, 24, 1, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontBaoJiText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(66, 12, 3, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 190, 71, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 246, 189, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontKeZhiText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(93, 0, 4, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 69, 69, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 221, 213, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontMianYiText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(16, 22, 35, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(49, 190, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(198, 236, 255, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontShangHaiText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(93, 0, 4, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 69, 69, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 221, 213, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontXiShouText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(16, 22, 35, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(49, 190, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(198, 236, 255, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontZhiLiaoText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(1, 32, 20, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(32, 207, 110, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(181, 255, 204, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontZhiLiaoBaoJiText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(1, 32, 20, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(32, 207, 110, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(181, 255, 204, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontZhongDuText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 3,
				outline = cc.c4b(59, 27, 60, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(143, 86, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(203, 178, 255, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontJianSheText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(93, 0, 4, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 69, 69, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 221, 213, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontZhuoShaoText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 3,
				outline = cc.c4b(28, 2, 1, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 43, 25, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 145, 42, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontXiXueLvJiangDiText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 1,
				outline = cc.c4b(49, 0, 4, 20)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 56, 17, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(196, 24, 1, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontXiXueLvShangShengText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 1,
				outline = cc.c4b(130, 37, 0, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 228, 0, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 142, 9, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontBattleWinExpText = {
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(247, 255, 23, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(254, 203, 2, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			},
			outline = {
				size = 1,
				outline = cc.c4b(136, 25, 7, 255)
			}
		},
		FontBattleTimerWhiteText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(16, 22, 35, 255)
			}
		},
		FontBattleHpWhiteText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontDianShuText = {
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(101, 47, 224, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			},
			outline = {
				size = 4,
				outline = cc.c4b(28, 0, 66, 255)
			}
		},
		FontBattleWinTitleText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(213, 74, 47, 255)
			}
		},
		FontBattleWinMvpText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontBattleLoseTitleText = {
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(147, 144, 169, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			},
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontBattleWinLvText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 1,
				outline = cc.c4b(37, 22, 11, 255)
			}
		},
		FontWhite1Text = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(16, 22, 35, 255)
			}
		},
		FontWhite2Text = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontBiaoTiZongText = {
			color = cc.c3b(84, 63, 36)
		},
		FontZHText = {
			color = cc.c3b(198, 198, 198),
			outline = {
				size = 2,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontJLText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 1,
				outline = cc.c4b(106, 2, 1, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(251, 250, 158, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(242, 112, 56, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontTCText = {
			color = cc.c3b(224, 192, 105),
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontLSFDText = {
			color = cc.c3b(177, 232, 255)
		},
		FontZWMBText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontZWMBDisText = {
			color = cc.c3b(100, 100, 100),
			outline = {
				size = 2,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontMCText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(236, 184, 93, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 243, 206, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontZDLIText = {
			color = cc.c3b(253, 202, 91)
		},
		FontSZMBText = {
			color = cc.c3b(64, 43, 21)
		},
		FontHSMBText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(177, 46, 81, 255)
			}
		},
		FontHSJBMBText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(230, 32, 105, 255)
			}
		},
		FontGCText = {
			color = cc.c3b(254, 251, 228)
		},
		FontFWBAIText = {
			color = cc.c3b(217, 217, 217),
			outline = {
				size = 2,
				outline = cc.c4b(96, 96, 96, 255)
			}
		},
		FontFWLVText = {
			color = cc.c3b(188, 253, 180),
			outline = {
				size = 2,
				outline = cc.c4b(54, 108, 43, 255)
			}
		},
		FontFWLANText = {
			color = cc.c3b(180, 216, 253),
			outline = {
				size = 2,
				outline = cc.c4b(31, 36, 132, 255)
			}
		},
		FontFWZIText = {
			color = cc.c3b(254, 197, 255),
			outline = {
				size = 2,
				outline = cc.c4b(112, 31, 132, 255)
			}
		},
		FontFWCHENGText = {
			color = cc.c3b(253, 182, 91),
			outline = {
				size = 2,
				outline = cc.c4b(130, 33, 33, 255)
			}
		},
		FontFWHONGText = {
			color = cc.c3b(255, 14, 116),
			outline = {
				size = 2,
				outline = cc.c4b(63, 0, 36, 255)
			}
		},
		FontFWHUANGText = {
			color = cc.c3b(255, 225, 21),
			outline = {
				size = 2,
				outline = cc.c4b(77, 49, 0, 255)
			}
		},
		FontFWCAIText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 25, 242, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(0, 255, 168, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			},
			outline = {
				size = 2,
				outline = cc.c4b(51, 0, 103, 255)
			}
		},
		FontDBHText = {
			color = cc.c3b(145, 146, 147)
		},
		FontPTTBText = {
			outline = {
				size = 1,
				outline = cc.c4b(53, 37, 69, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(129, 116, 158, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontLSTCHText = {
			color = cc.c3b(60, 255, 0)
		},
		FontLSTCHLineText = {
			color = cc.c3b(60, 255, 0),
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontSHDText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(255, 0, 0, 255)
			}
		},
		FontSHJText = {
			color = cc.c3b(255, 0, 0)
		},
		FontCHText = {
			color = cc.c3b(0, 0, 0)
		},
		FontLSMBText = {
			outline = {
				size = 1,
				outline = cc.c4b(49, 28, 119, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 244, 171, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontLSJBText = {
			outline = {
				size = 2,
				outline = cc.c4b(47, 40, 83, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(143, 163, 222, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontJSSText = {
			color = cc.c3b(255, 109, 98),
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontSHText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 1,
				outline = cc.c4b(79, 49, 20, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(246, 165, 144, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(153, 84, 68, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontQSWBText = {
			color = cc.c3b(183, 185, 196)
		},
		FontGCLSJBText = {
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(176, 213, 255, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontGCHSJBText = {
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 242, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(254, 255, 175, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontZJSJBText = {
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(234, 216, 138, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(125, 98, 87, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			},
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontQZSText = {
			color = cc.c3b(158, 138, 104)
		},
		FontSZText = {
			color = cc.c3b(240, 202, 136)
		},
		FontSZHText = {
			color = cc.c3b(35, 1, 0)
		},
		FontBZJMSTBLext = {
			color = cc.c3b(41, 54, 77)
		},
		FontBZJMSZText = {
			color = cc.c3b(220, 243, 245)
		},
		FontHBBTText = {
			color = cc.c3b(219, 172, 98),
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontHBMPZWText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 2,
				outline = cc.c4b(0, 0, 0, 255)
			},
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(151, 151, 151, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 255, 255, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontZJSJSDText = {
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(32, 207, 110, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(181, 255, 204, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			},
			outline = {
				size = 2,
				outline = cc.c4b(1, 32, 20, 255)
			}
		},
		FontHDJText = {
			color = cc.c3b(203, 151, 76)
		},
		FontZJSJSZText = {
			color = cc.c3b(233, 185, 95)
		},
		FontHBMBText = {
			color = cc.c3b(186, 184, 198),
			outline = {
				size = 2,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontJJCZPText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(210, 150, 107, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(251, 225, 187, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontJJCZPGText = {
			color = cc.c3b(38, 21, 9)
		},
		FontJJCSText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 238, 145, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 255, 255, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			},
			outline = {
				size = 2,
				outline = cc.c4b(213, 74, 47, 255)
			}
		},
		FontJJCFText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(145, 189, 255, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 255, 255, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			},
			outline = {
				size = 2,
				outline = cc.c4b(87, 96, 119, 255)
			}
		},
		FontJJCHText = {
			color = cc.c3b(173, 172, 185)
		},
		FontJJCPMText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(119, 123, 132, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(185, 197, 221, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontJJCPHText = {
			color = cc.c3b(191, 191, 191)
		},
		FontJJCMZText = {
			color = cc.c3b(69, 70, 79)
		},
		FontBDZLText = {
			color = cc.c3b(186, 23, 62)
		},
		FontQHText = {
			color = cc.c3b(146, 141, 131),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(255, 126, 0, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 231, 173, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontJJCPMJText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(132, 96, 65, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(203, 173, 131, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontJJCPMYText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(182, 192, 221, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(251, 253, 255, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			}
		},
		FontJJCPMGText = {
			color = cc.c3b(255, 255, 255),
			gradientColor = {
				color1 = {
					ratio = 0.3,
					color = cc.c4b(242, 200, 123, 255)
				},
				color2 = {
					ratio = 0.7,
					color = cc.c4b(255, 244, 223, 255)
				},
				factor = {
					x = 0,
					y = 1
				}
			},
			outline = {
				size = 2,
				outline = cc.c4b(38, 26, 1, 255)
			}
		},
		FontHBYQLText = {
			color = cc.c3b(255, 242, 220)
		},
		FontLPSXText = {
			outline = {
				size = 1,
				outline = cc.c4b(255, 113, 63, 255)
			},
			gradientColor = {
				color2 = {
					ratio = 0.3,
					color = cc.c4b(255, 255, 252, 255)
				},
				color1 = {
					ratio = 0.7,
					color = cc.c4b(255, 243, 189, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontLXHText = {
			outline = {
				size = 1,
				outline = cc.c4b(28, 0, 0, 255)
			},
			gradientColor = {
				color2 = {
					ratio = 0.3,
					color = cc.c4b(210, 0, 0, 255)
				},
				color1 = {
					ratio = 0.7,
					color = cc.c4b(241, 50, 100, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontBZJMTBText = {
			color = cc.c3b(217, 228, 255)
		},
		FontSSBTText = {
			color = cc.c3b(255, 255, 255),
			outline = {
				size = 1,
				outline = cc.c4b(255, 231, 158, 255)
			}
		},
		FontBDYQEText = {
			color = cc.c3b(189, 154, 90),
			outline = {
				size = 1,
				outline = cc.c4b(55, 44, 22, 255)
			}
		},
		FontBDYQFText = {
			color = cc.c3b(26, 17, 11),
			outline = {
				size = 1,
				outline = cc.c4b(142, 112, 59, 255)
			}
		},
		FontOPENSTAGETText = {
			outline = {
				size = 1,
				outline = cc.c4b(1, 1, 1, 255)
			},
			gradientColor = {
				color2 = {
					ratio = 0.3,
					color = cc.c4b(65, 8, 98, 255)
				},
				color1 = {
					ratio = 0.7,
					color = cc.c4b(0, 63, 128, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			},
			glowColor = {
				color = cc.c4b(255, 255, 255, 255)
			}
		},
		FontCLOSESTAGETText = {
			color = cc.c3b(0, 0, 0),
			outline = {
				size = 1,
				outline = cc.c4b(166, 4, 72, 255)
			}
		},
		FontBLOCKText = {
			color = cc.c3b(0, 0, 0)
		},
		FontZLText = {
			color = cc.c3b(253, 202, 107),
			outline = {
				size = 1,
				outline = cc.c4b(0, 0, 0, 255)
			}
		},
		FontZBSHIJIANLText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(0, 102, 255, 255)
			}
		},
		FontZBSHIJIANZText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(144, 0, 255, 255)
			}
		},
		FontZBSHIJIANHText = {
			color = FontStyleColor.kWhite,
			outline = {
				size = 2,
				outline = cc.c4b(242, 159, 0, 255)
			}
		},
		FontLPXHText = {
			outline = {
				size = 1,
				outline = cc.c4b(77, 0, 0, 255)
			},
			gradientColor = {
				color2 = {
					ratio = 0.8,
					color = cc.c4b(221, 29, 29, 255)
				},
				color1 = {
					ratio = 0.2,
					color = cc.c4b(255, 160, 160, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		},
		FontZJTFText = {
			outline = {
				size = 1,
				outline = cc.c4b(80, 42, 8, 255)
			},
			gradientColor = {
				color2 = {
					ratio = 0.3,
					color = cc.c4b(255, 235, 0, 255)
				},
				color1 = {
					ratio = 0.7,
					color = cc.c4b(255, 250, 159, 255)
				},
				factor = {
					x = 0,
					y = -1
				}
			}
		}
	}
end

FontStyle:setStyleConfig()

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/model/HomeViewConfig.lua

local totalOffSetX = 787
local totalOffSetY = 290

return {
	mLeftFuncLayout = {
		mLeadNode = {
			mLabelName = "Home_Leader",
			mTempName = "Home_En_Leader",
			mFunc = "onLeadBtn",
			redPointFunc = "masterRedPoint",
			mBtn = {
				press = "main_zj.png",
				normal = "main_zj.png"
			}
		},
		mServantNode = {
			mLabelName = "Home_Hero",
			mTempName = "Home_En_Friend",
			mFunc = "onDigimonBtn",
			redPointFunc = "heroRedPoint",
			mBtn = {
				press = "main_hb.png",
				normal = "main_hb.png"
			}
		},
		mPhotoNode = {
			mLabelName = "Home_Photo",
			mTempName = "Home_En_Xiangce",
			mFunc = "onGalleryBtn",
			redPointFunc = "galleryRedPoint",
			mBtn = {
				press = "main_xc.png",
				normal = "main_xc.png"
			}
		},
		mShopNode = {
			mLabelName = "Home_Shop",
			mTempName = "Home_En_Shop",
			mFunc = "onShopBtn",
			redPointFunc = "shopRedPoint",
			mBtn = {
				press = "main_sd.png",
				normal = "main_sd.png"
			}
		},
		mTaskNode = {
			mLabelName = "Home_Task",
			mTempName = "Home_En_Task",
			mFunc = "onTaskBtn",
			redPointFunc = "taskRedPoint",
			mBtn = {
				press = "main_rw.png",
				normal = "main_rw.png"
			}
		}
	},
	mTopFuncLayout = {
		mChatNode = {
			mFunc = "onChatBtn",
			mTempName = "Home_Chat",
			redPointFunc = "chatRedPoint",
			mBtn = {
				press = "zhujiemian_btn_liantian.png",
				normal = "zhujiemian_btn_liantian.png"
			}
		},
		mFriendNode = {
			mFunc = "onFriendBtn",
			mTempName = "Home_Friend",
			redPointFunc = "friendRedPoint",
			mBtn = {
				press = "zhujiemian_btn_haoyou.png",
				normal = "zhujiemian_btn_haoyou.png"
			}
		},
		mMailNode = {
			mFunc = "onMailBtn",
			mTempName = "Home_Mail",
			redPointFunc = "mailRedPoint",
			mBtn = {
				press = "zhujiemian_btn_youxiang.png",
				normal = "zhujiemian_btn_youxiang.png"
			}
		},
		mBagNode = {
			mFunc = "onPackageBtn",
			mTempName = "Home_Bag",
			redPointFunc = "bagRedPoint",
			mBtn = {
				press = "main_bb.png",
				normal = "main_bb.png"
			}
		},
		mRankNode = {
			mFunc = "onRankBtn",
			mTempName = "Home_Rank",
			redPointFunc = "rankRedPoint",
			mBtn = {
				press = "main_rk.png",
				normal = "main_rk.png"
			}
		},
		mDownNode = {
			mFunc = "onDownloadBtn",
			mTempName = "Home_Download",
			mBtn = {
				press = "main_xz_1.png",
				normal = "main_xz_1.png"
			}
		},
		mAnnounceNode = {
			mFunc = "onClickGameAnnounce",
			mTempName = "BoardTitle",
			mBtn = {
				press = "zhujiemian_btn_gonggao.png",
				normal = "zhujiemian_btn_gonggao.png"
			}
		},
		mPassNode = {
			mFunc = "onPassBtn",
			redPointFunc = "passRedPoint",
			mTempName = "Home_Pass"
		},
		mYxqNode = {
			mFunc = "onYxqBtn",
			mTempName = "Home_Youxiquan",
			mBtn = {
				press = "zhujiemian_btn_yxq.png",
				normal = "zhujiemian_btn_yxq.png"
			}
		}
	},
	mRightFuncLayout = {
		mExploreNode = {
			mFunc = "onExploreBtn",
			redPointFunc = "onMainChapterRedPoint",
			mMovieClip = {
				name = "m_xinzhujiemian",
				pos = cc.p(228.45 + totalOffSetX, 10.25 + totalOffSetY)
			}
		},
		mChallengeNode = {
			mFunc = "onChallengeBtn",
			redPointFunc = "challengeRedPoint",
			mMovieClip = {
				name = "s_xinzhujiemian",
				pos = cc.p(14.1 + totalOffSetX, 10.2 + totalOffSetY)
			},
			mLabel = {
				mLabelNames = "Home_Adventure",
				autoImageH = 60,
				mTempName = "Home_En_Adventure",
				fontSize = 30
			},
			redPointPos = cc.p(62, 10)
		},
		mActivity2Node = {
			mFunc = "onActivity2Btn",
			redPointFunc = "activityRedPoint",
			mMovieClip = {
				name = "huodong_xinzhujiemian",
				pos = cc.p(285.1 + totalOffSetX, 136.25 + totalOffSetY)
			},
			mLabel = {
				mLabelNames = "Home_Activity",
				fontSize = 24,
				mTempName = "UITitle_EN_Fuli",
				autoImageW = 81,
				autoImageH = 40
			},
			redPointPos = cc.p(40, 10)
		},
		mArena1Node = {
			mFunc = "onArena1Btn",
			redPointFunc = "arenaRedPoint",
			mMovieClip = {
				name = "j_xinzhujiemian",
				pos = cc.p(91.5 + totalOffSetX, 126.15 + totalOffSetY)
			},
			mLabel = {
				mLabelNames = "Home_Pvp",
				autoImageH = 60,
				mTempName = "Home_En_Pvp",
				fontSize = 30
			},
			redPointPos = cc.p(70, -20)
		},
		mRecruitEquipNode = {
			mFunc = "onRecruitHeroBtn",
			redPointFunc = "recruitRedPoint",
			mMovieClip = {
				name = "t_xinzhujiemian",
				pos = cc.p(124.95 + totalOffSetX, -95.25 + totalOffSetY)
			},
			mLabel = {
				mLabelNames = "Home_Call",
				autoImageH = 0,
				mTempName = "Home_En_Call",
				fontSize = 30
			},
			redPointPos = cc.p(36, 4),
			drawNodePos = {
				cc.p(40, 15),
				cc.p(116, 89),
				cc.p(41, 161),
				cc.p(-26, 87)
			}
		},
		mCardsGroupNode = {
			mFunc = "onCardsGroupBtn",
			redPointFunc = "teamRedPoint",
			mMovieClip = {
				name = "b_xinzhujiemian",
				pos = cc.p(28.8 + totalOffSetX, -165.6 + totalOffSetY)
			},
			mLabel = {
				mLabelNames = "Home_Team",
				autoImageH = 35,
				mTempName = "Home_En_Biandui",
				fontSize = 26
			},
			redPointPos = cc.p(60, 6),
			drawNodePos = {
				cc.p(64, 0),
				cc.p(130, 74),
				cc.p(65, 136),
				cc.p(0, 76)
			}
		},
		mGuildNode = {
			mFunc = "onGuildBtn",
			redPointFunc = "onClubRedPoint",
			mMovieClip = {
				name = "x_xinzhujiemian",
				pos = cc.p(170.6 + totalOffSetX, -171.7 + totalOffSetY)
			},
			mLabel = {
				mLabelNames = "Home_Club",
				autoImageH = 35,
				mTempName = "Home_En_Jieshe",
				fontSize = 26
			},
			redPointPos = cc.p(60, 6),
			drawNodePos = {
				cc.p(64, 34),
				cc.p(116, 80),
				cc.p(65, 130),
				cc.p(16, 78)
			}
		},
		mBackFlowNode = {
			mFunc = "onBackFlowBtn",
			redPointFunc = "onBackFlowRedPoint",
			mMovieClip = {
				name = "guimeng_xinzhujiemian",
				pos = cc.p(280 + totalOffSetX, -130.7 + totalOffSetY)
			},
			mLabel = {
				mLabelNames = "Home_Return",
				autoImageH = 35,
				mTempName = "Home_Return_En",
				fontSize = 26
			},
			redPointPos = cc.p(60, 6)
		}
	},
	mBottomFuncLayout = {}
}

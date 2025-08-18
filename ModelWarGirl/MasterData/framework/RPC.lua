-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Framework\\RPC.lua

local UIConst = require("UI/UIConst")

require("Network/protobuf")

local tfcapi = require("libconapi")
local EventConst = require("EventConst")
local RPC = {}

RPC._agent = false

function RPC.setAgent(agent)
	RPC._agent = agent
end

RPC.CONNECT_BACKEND_ZONE = 1
RPC.CONNECT_BACKEND_CHAT = 2
RPC.CONNECT_BACKEND_RELAY = 3
RPC._connectService = {}
RPC._connectHandle = {}

function RPC.setConnectService(backend, service)
	RPC._connectService[backend] = service
end

function RPC.getConnectService(backend)
	return RPC._connectService[backend]
end

function RPC.setConnectHandle(backend, connect)
	RPC._connectHandle[backend] = connect
end

function RPC.getConnectHandle(backend)
	return RPC._connectHandle[backend]
end

function RPC._getConnectHandleByCmd(cmd)
	local backend = RPC._msgReqBackend[cmd]

	if backend then
		return RPC.getConnectHandle(backend)
	else
		return -1
	end
end

local protoFrameCache = {
	kCSMsgRoleLeaveLoginQueue = {
		head = {
			cmd = "kCSMsgRoleLeaveLoginQueue"
		},
		["csp.role_leave_login_queue_req"] = {}
	},
	kCSMsgRoleLogin = {
		head = {
			cmd = "kCSMsgRoleLogin"
		},
		["csp.role_login_c"] = {}
	},
	kCSMsgRoleRandName = {
		head = {
			cmd = "kCSMsgRoleRandName"
		},
		["csp.role_rand_name_c"] = {}
	},
	kCSMsgRoleRename = {
		head = {
			cmd = "kCSMsgRoleRename"
		},
		["csp.role_rename_c"] = {}
	},
	kCSMsgRoleCreate = {
		head = {
			cmd = "kCSMsgRoleCreate"
		},
		["csp.role_create_c"] = {}
	},
	kCSMsgRoleInfo = {
		head = {
			cmd = "kCSMsgRoleInfo"
		},
		["csp.role_info_c"] = {}
	},
	kCSMsgRoleLogout = {
		head = {
			cmd = "kCSMsgRoleLogout"
		},
		["csp.role_logout_c"] = {}
	},
	kCSMsgExecuteGM = {
		head = {
			cmd = "kCSMsgExecuteGM"
		},
		["csp.gm_c"] = {}
	},
	kCSMsgMailUpdate = {
		head = {
			cmd = "kCSMsgMailUpdate"
		},
		["csp.mail_update_c"] = {}
	},
	kCSMsgMailGetAttach = {
		head = {
			cmd = "kCSMsgMailGetAttach"
		},
		["csp.mail_get_attach_c"] = {}
	},
	kCSMsgMailReport = {
		head = {
			cmd = "kCSMsgMailReport"
		},
		["csp.mail_report_c"] = {}
	},
	kCSMsgBuddyAdd = {
		head = {
			cmd = "kCSMsgBuddyAdd"
		},
		["csp.buddy_add_c"] = {}
	},
	kCSMsgBuddyDel = {
		head = {
			cmd = "kCSMsgBuddyDel"
		},
		["csp.buddy_del_c"] = {}
	},
	kCSMsgBuddyInviteOp = {
		head = {
			cmd = "kCSMsgBuddyInviteOp"
		},
		["csp.buddy_invite_op_c"] = {}
	},
	kCSMsgBuddySearch = {
		head = {
			cmd = "kCSMsgBuddySearch"
		},
		["csp.buddy_search_c"] = {}
	},
	kCSMsgBuddyBlackListAdd = {
		head = {
			cmd = "kCSMsgBuddyBlackListAdd"
		},
		["csp.buddy_black_add_c"] = {}
	},
	kCSMsgBuddyBlackListDel = {
		head = {
			cmd = "kCSMsgBuddyBlackListDel"
		},
		["csp.buddy_black_del_c"] = {}
	},
	kCSMsgBuddyRecommend = {
		head = {
			cmd = "kCSMsgBuddyRecommend"
		},
		["csp.buddy_recommend_c"] = {}
	},
	kCSMsgBuddyGiftOp = {
		head = {
			cmd = "kCSMsgBuddyGiftOp"
		},
		["csp.buddy_gift_op_c"] = {}
	},
	kCSMsgBuddyOnline = {
		head = {
			cmd = "kCSMsgBuddyOnline"
		},
		["csp.buddy_online_c"] = {}
	},
	kCSMsgBuddyBondSet = {
		head = {
			cmd = "kCSMsgBuddyBondSet"
		},
		["csp.buddy_bond_set_c"] = {}
	},
	kCSMsgOpActivityData = {
		head = {
			cmd = "kCSMsgOpActivityData"
		},
		["csp.opactivity_data_c"] = {}
	},
	kCSMsgGagGSSetGag = {
		head = {
			cmd = "kCSMsgGagGSSetGag"
		},
		["csp.gag_gs_set_gag_c"] = {}
	},
	kCSMsgOpActGetAward = {
		head = {
			cmd = "kCSMsgOpActGetAward"
		},
		["csp.opact_get_award_c"] = {}
	},
	kCSMsgMonopolyRoll = {
		head = {
			cmd = "kCSMsgMonopolyRoll"
		},
		["csp.monopoly_roll_c"] = {}
	},
	kCSMsgMonopolyExchange = {
		head = {
			cmd = "kCSMsgMonopolyExchange"
		},
		["csp.monopoly_exchange_c"] = {}
	},
	kCSMsgOpActDepositRefresh = {
		head = {
			cmd = "kCSMsgOpActDepositRefresh"
		},
		["csp.opact_deposit_refresh_c"] = {}
	},
	kCSMsgOpActDepositGetAward = {
		head = {
			cmd = "kCSMsgOpActDepositGetAward"
		},
		["csp.opact_deposit_get_award_c"] = {}
	},
	kCSMsgOpActPlotPassCurStage = {
		head = {
			cmd = "kCSMsgOpActPlotPassCurStage"
		},
		["csp.opact_plot_pass_cur_stage_c"] = {}
	},
	kCSMsgOpActPlotGetAchieveAward = {
		head = {
			cmd = "kCSMsgOpActPlotGetAchieveAward"
		},
		["csp.opact_plot_get_achieve_award_c"] = {}
	},
	kCSMsgBingoDraw = {
		head = {
			cmd = "kCSMsgBingoDraw"
		},
		["csp.bingo_draw_c"] = {}
	},
	kCSMsgBingoSetBigReward = {
		head = {
			cmd = "kCSMsgBingoSetBigReward"
		},
		["csp.bingo_set_big_reward_c"] = {}
	},
	kCSMsgOpActDraw = {
		head = {
			cmd = "kCSMsgOpActDraw"
		},
		["csp.opact_draw_c"] = {}
	},
	kCSMsgOpActSetFocus = {
		head = {
			cmd = "kCSMsgOpActSetFocus"
		},
		["csp.opact_set_focus_c"] = {}
	},
	kCSMsgOpActShopRefresh = {
		head = {
			cmd = "kCSMsgOpActShopRefresh"
		},
		["csp.opact_shop_refresh_c"] = {}
	},
	kCSMsgOpActAchieveFinalAward = {
		head = {
			cmd = "kCSMsgOpActAchieveFinalAward"
		},
		["csp.opact_achieve_final_award_c"] = {}
	},
	kCSMsgOpActPlotSweep = {
		head = {
			cmd = "kCSMsgOpActPlotSweep"
		},
		["csp.opact_plot_sweep_stage_c"] = {}
	},
	kCSMsgOpActPlotGetRank = {
		head = {
			cmd = "kCSMsgOpActPlotGetRank"
		},
		["csp.opact_plot_get_rank_c"] = {}
	},
	kCSMsgOpActLotteryGetRank = {
		head = {
			cmd = "kCSMsgOpActLotteryGetRank"
		},
		["csp.opact_lottery_get_rank_c"] = {}
	},
	kCSMsgOpActShopLevelUp = {
		head = {
			cmd = "kCSMsgOpActShopLevelUp"
		},
		["csp.opact_shop_level_up_c"] = {}
	},
	kCSMsgOpActDrawReplaceSetDisable = {
		head = {
			cmd = "kCSMsgOpActDrawReplaceSetDisable"
		},
		["csp.opact_draw_replace_disable"] = {}
	},
	kCSMsgOpactWishChoose = {
		head = {
			cmd = "kCSMsgOpactWishChoose"
		},
		["csp.opact_wish_choose_c"] = {}
	},
	kCSMsgOpactWishGetAward = {
		head = {
			cmd = "kCSMsgOpactWishGetAward"
		},
		["csp.opact_wish_get_award_c"] = {}
	},
	kCSMsgOpactFirePlaceGetAward = {
		head = {
			cmd = "kCSMsgOpactFirePlaceGetAward"
		},
		["csp.opact_fire_place_c"] = {}
	},
	kCSMsgOpActDrawReplaceChangeIndex = {
		head = {
			cmd = "kCSMsgOpActDrawReplaceChangeIndex"
		},
		["csp.opact_draw_replace_change_index"] = {}
	},
	kCSMsgOpActOnHookRoleFirstIn = {
		head = {
			cmd = "kCSMsgOpActOnHookRoleFirstIn"
		},
		["csp.opact_onhook_first_in"] = {}
	},
	kCSMsgOpActOnHookRoleOnCook = {
		head = {
			cmd = "kCSMsgOpActOnHookRoleOnCook"
		},
		["csp.opact_onhook_on_cook"] = {}
	},
	kCSMsgOpActOnHookRoleDeliver = {
		head = {
			cmd = "kCSMsgOpActOnHookRoleDeliver"
		},
		["csp.opact_onhook_deliver"] = {}
	},
	kCSMsgOpActOnHookRoleCancelCook = {
		head = {
			cmd = "kCSMsgOpActOnHookRoleCancelCook"
		},
		["csp.opact_onhook_cancal_cook"] = {}
	},
	kCSMsgOpActOnHookRoleSpeedUp = {
		head = {
			cmd = "kCSMsgOpActOnHookRoleSpeedUp"
		},
		["csp.opact_onhook_speed_up"] = {}
	},
	kCSMsgOpActDrawGetShareAward = {
		head = {
			cmd = "kCSMsgOpActDrawGetShareAward"
		},
		["csp.opact_draw_get_share_award"] = {}
	},
	kCSMsgOpActDrawReplaceShareAward = {
		head = {
			cmd = "kCSMsgOpActDrawReplaceShareAward"
		},
		["csp.opact_draw_replace_share_award"] = {}
	},
	kCSMsgOpActHatsuneGetNodeAward = {
		head = {
			cmd = "kCSMsgOpActHatsuneGetNodeAward"
		},
		["csp.opact_hatsune_get_node_award"] = {}
	},
	kCSMsgOpActMonopolySetLibAward = {
		head = {
			cmd = "kCSMsgOpActMonopolySetLibAward"
		},
		["csp.opact_Monopoly_set_lib_award"] = {}
	},
	kCSMsgOpActMonopolyUseItem = {
		head = {
			cmd = "kCSMsgOpActMonopolyUseItem"
		},
		["csp.opact_Monopoly_use_item"] = {}
	},
	kCSMsgOpActClanBossDispatch = {
		head = {
			cmd = "kCSMsgOpActClanBossDispatch"
		},
		["csp.opact_clan_boss_dispatch_c"] = {}
	},
	kCSMsgOpActClanBossGetStageAward = {
		head = {
			cmd = "kCSMsgOpActClanBossGetStageAward"
		},
		["csp.opact_clan_boss_get_stage_award_c"] = {}
	},
	kCSMsgOpActClanBossGetAchieveAward = {
		head = {
			cmd = "kCSMsgOpActClanBossGetAchieveAward"
		},
		["csp.opact_clan_boss_get_achieve_award_c"] = {}
	},
	kCSMsgOpActFlottoryDraw = {
		head = {
			cmd = "kCSMsgOpActFlottoryDraw"
		},
		["csp.opact_flottory_draw_c"] = {}
	},
	kCSMsgOpActFlottorySetSelIndex = {
		head = {
			cmd = "kCSMsgOpActFlottorySetSelIndex"
		},
		["csp.opact_flottory_set_sel_index_c"] = {}
	},
	kCSMsgOpActCatRaceGetAward = {
		head = {
			cmd = "kCSMsgOpActCatRaceGetAward"
		},
		["csp.opact_cat_race_get_award_c"] = {}
	},
	kCSMsgOpActCatRaceSelectTask = {
		head = {
			cmd = "kCSMsgOpActCatRaceSelectTask"
		},
		["csp.opact_cat_race_select_task_c"] = {}
	},
	kCSMsgOpActCatRaceSelectFriendTask = {
		head = {
			cmd = "kCSMsgOpActCatRaceSelectFriendTask"
		},
		["csp.opact_cat_race_select_friend_task_c"] = {}
	},
	kCSMsgOpActCatRaceSetFriend = {
		head = {
			cmd = "kCSMsgOpActCatRaceSetFriend"
		},
		["csp.opact_cat_race_set_frient_c"] = {}
	},
	kCSMsgOpActCatRaceSetCatInfo = {
		head = {
			cmd = "kCSMsgOpActCatRaceSetCatInfo"
		},
		["csp.opact_cat_race_set_cat_info_c"] = {}
	},
	kCSMsgOpActCatRaceSendFriend = {
		head = {
			cmd = "kCSMsgOpActCatRaceSendFriend"
		},
		["csp.opact_cat_race_send_friend_c"] = {}
	},
	kCSMsgOpActCatRaceGetPublishAward = {
		head = {
			cmd = "kCSMsgOpActCatRaceGetPublishAward"
		},
		["csp.opact_cat_race_get_publish_award_c"] = {}
	},
	kCSMsgOpActCatRaceGetTaskAward = {
		head = {
			cmd = "kCSMsgOpActCatRaceGetTaskAward"
		},
		["csp.opact_cat_race_get_task_award_c"] = {}
	},
	kCSMsgOpActCatRaceGetFriendGift = {
		head = {
			cmd = "kCSMsgOpActCatRaceGetFriendGift"
		},
		["csp.opact_cat_race_get_friend_gift_c"] = {}
	},
	kCSMsgOpActCollectWordsRefreshDeposit = {
		head = {
			cmd = "kCSMsgOpActCollectWordsRefreshDeposit"
		},
		["csp.opact_collectwords_refresh_deposit_c"] = {}
	},
	kCSMsgOpActCollectWordsGetDeposit = {
		head = {
			cmd = "kCSMsgOpActCollectWordsGetDeposit"
		},
		["csp.opact_collectwords_get_deposit_c"] = {}
	},
	kCSMsgOpActCollectWordsRecvWord = {
		head = {
			cmd = "kCSMsgOpActCollectWordsRecvWord"
		},
		["csp.opact_collectwords_recv_word_c"] = {}
	},
	kCSMsgOpActCollectWordsGivingWord = {
		head = {
			cmd = "kCSMsgOpActCollectWordsGivingWord"
		},
		["csp.opact_collectwords_giving_word_c"] = {}
	},
	kCSMsgOpActCollectWordsDestroyWord = {
		head = {
			cmd = "kCSMsgOpActCollectWordsDestroyWord"
		},
		["csp.opact_collectwords_destroy_word_c"] = {}
	},
	kCSMsgOpActCollectWordsComposeWord = {
		head = {
			cmd = "kCSMsgOpActCollectWordsComposeWord"
		},
		["csp.opact_collectwords_compose_word_c"] = {}
	},
	kCSMsgOpActCollectWordsGetBuddyWord = {
		head = {
			cmd = "kCSMsgOpActCollectWordsGetBuddyWord"
		},
		["csp.opact_collectwords_get_buddy_word_c"] = {}
	},
	kCSMsgOpActCollectWordsUseItem = {
		head = {
			cmd = "kCSMsgOpActCollectWordsUseItem"
		},
		["csp.opact_collectwords_use_item_c"] = {}
	},
	kCSMsgOpActAchieveSetClientTriggerFlag = {
		head = {
			cmd = "kCSMsgOpActAchieveSetClientTriggerFlag"
		},
		["csp.opact_achieve_set_client_trigger_c"] = {}
	},
	kCSMsgOpActAchieveExchangeItem = {
		head = {
			cmd = "kCSMsgOpActAchieveExchangeItem"
		},
		["csp.opact_achieve_exchange_item_c"] = {}
	},
	kCSMsgOpActChatGameMakeChocolete = {
		head = {
			cmd = "kCSMsgOpActChatGameMakeChocolete"
		},
		["csp.opact_chatgame_make_chocolete_c"] = {}
	},
	kCSMsgOpActChatGameChooseBranch = {
		head = {
			cmd = "kCSMsgOpActChatGameChooseBranch"
		},
		["csp.opact_chatgame_choose_branch_c"] = {}
	},
	kCSMsgOpActChatGameChatEnd = {
		head = {
			cmd = "kCSMsgOpActChatGameChatEnd"
		},
		["csp.opact_chatgame_chat_end_c"] = {}
	},
	kCSMsgOpActChatGameResetChat = {
		head = {
			cmd = "kCSMsgOpActChatGameResetChat"
		},
		["csp.opact_chatgame_reset_chat_c"] = {}
	},
	kCSMsgOpActChatGameFormulaShare = {
		head = {
			cmd = "kCSMsgOpActChatGameFormulaShare"
		},
		["csp.opact_chatgame_share_formula_c"] = {}
	},
	kCSMsgOpActChatGameGivingGift = {
		head = {
			cmd = "kCSMsgOpActChatGameGivingGift"
		},
		["csp.opact_chatgame_giving_gift_c"] = {}
	},
	kCSMsgOpActHomeDispatch = {
		head = {
			cmd = "kCSMsgOpActHomeDispatch"
		},
		["csp.opact_homedispatch_c"] = {}
	},
	kCSMsgOpActHomeDispatchGetAward = {
		head = {
			cmd = "kCSMsgOpActHomeDispatchGetAward"
		},
		["csp.opact_homedispatch_get_award_c"] = {}
	},
	kCSMsgOpActHomeDispatchSpeedUp = {
		head = {
			cmd = "kCSMsgOpActHomeDispatchSpeedUp"
		},
		["csp.opact_homedispatch_speed_up_c"] = {}
	},
	kCSMsgOpActHomeDispatchBuild = {
		head = {
			cmd = "kCSMsgOpActHomeDispatchBuild"
		},
		["csp.opact_homedispatch_build_c"] = {}
	},
	kCSMsgOpActGuessChooseAnswer = {
		head = {
			cmd = "kCSMsgOpActGuessChooseAnswer"
		},
		["csp.opact_guess_choose_answer_c"] = {}
	},
	kCSMsgOpActGuessAwardInfuse = {
		head = {
			cmd = "kCSMsgOpActGuessAwardInfuse"
		},
		["csp.opact_guess_award_infuse_c"] = {}
	},
	kCSMsgOpActGuessGetRank = {
		head = {
			cmd = "kCSMsgOpActGuessGetRank"
		},
		["csp.opact_guess_get_rank_c"] = {}
	},
	kCSMsgOpActGuessGetTotalAward = {
		head = {
			cmd = "kCSMsgOpActGuessGetTotalAward"
		},
		["csp.opact_guess_get_total_award_c"] = {}
	},
	kCSMsgOpActGuessWatch = {
		head = {
			cmd = "kCSMsgOpActGuessWatch"
		},
		["csp.opact_guess_watch_c"] = {}
	},
	kCSMsgOpActGuessIsRight = {
		head = {
			cmd = "kCSMsgOpActGuessIsRight"
		},
		["csp.opact_guess_is_right_c"] = {}
	},
	kCSMsgOpActBusinessMaterialProduct = {
		head = {
			cmd = "kCSMsgOpActBusinessMaterialProduct"
		},
		["csp.opact_business_material_product_c"] = {}
	},
	kCSMsgOpActBusinessMaterialCompose = {
		head = {
			cmd = "kCSMsgOpActBusinessMaterialCompose"
		},
		["csp.opact_business_material_compose_c"] = {}
	},
	kCSMsgOpActBusinessStaminaReceive = {
		head = {
			cmd = "kCSMsgOpActBusinessStaminaReceive"
		},
		["csp.opact_business_stamina_receive_c"] = {}
	},
	kCSMsgOpActBusinessStaminaDonated = {
		head = {
			cmd = "kCSMsgOpActBusinessStaminaDonated"
		},
		["csp.opact_business_stamina_donated_c"] = {}
	},
	kCSMsgOpActBusinessOrderCommit = {
		head = {
			cmd = "kCSMsgOpActBusinessOrderCommit"
		},
		["csp.opact_business_order_commit_c"] = {}
	},
	kCSMsgOpActBusinessOrderUpdate = {
		head = {
			cmd = "kCSMsgOpActBusinessOrderUpdate"
		},
		["csp.opact_business_order_update_c"] = {}
	},
	kCSMsgOpActBusinessMaterialUpgrade = {
		head = {
			cmd = "kCSMsgOpActBusinessMaterialUpgrade"
		},
		["csp.opact_business_material_upgrade_c"] = {}
	},
	kCSMsgOpActBusinessMaterialDelete = {
		head = {
			cmd = "kCSMsgOpActBusinessMaterialDelete"
		},
		["csp.opact_business_material_delete_c"] = {}
	},
	kCSMsgOpActTurnTableDraw = {
		head = {
			cmd = "kCSMsgOpActTurnTableDraw"
		},
		["csp.opact_turntable_draw_c"] = {}
	},
	kCSMsgGiftDrawWinnersListGet = {
		head = {
			cmd = "kCSMsgGiftDrawWinnersListGet"
		},
		["csp.giftdraw_winner_list_c"] = {}
	},
	kCSMsgGiftDrawGiftShare = {
		head = {
			cmd = "kCSMsgGiftDrawGiftShare"
		},
		["csp.giftdraw_share_c"] = {}
	},
	kCSMsgOpActEquipMakeChoose = {
		head = {
			cmd = "kCSMsgOpActEquipMakeChoose"
		},
		["csp.opact_equip_make_choose_c"] = {}
	},
	kCSMsgOpActEquipMakeRand = {
		head = {
			cmd = "kCSMsgOpActEquipMakeRand"
		},
		["csp.opact_equip_make_rand_c"] = {}
	},
	kCSMsgOpActEquipBaptizeChoose = {
		head = {
			cmd = "kCSMsgOpActEquipBaptizeChoose"
		},
		["csp.opact_equip_baptize_choose_c"] = {}
	},
	kCSMsgOpActEquipBaptizeInit = {
		head = {
			cmd = "kCSMsgOpActEquipBaptizeInit"
		},
		["csp.opact_equip_baptize_init_c"] = {}
	},
	kCSMsgOpActEquipBaptizeRandAttr = {
		head = {
			cmd = "kCSMsgOpActEquipBaptizeRandAttr"
		},
		["csp.opact_equip_baptize_rand_attr_c"] = {}
	},
	kCSMsgOpActEquipBaptizeDone = {
		head = {
			cmd = "kCSMsgOpActEquipBaptizeDone"
		},
		["csp.opact_equip_baptize_done_c"] = {}
	},
	kCSMsgOpActEquipBaptizeAttrLock = {
		head = {
			cmd = "kCSMsgOpActEquipBaptizeAttrLock"
		},
		["csp.opact_equip_baptize_attr_lock_c"] = {}
	},
	kCSMsgOpActDrawNewbieUpDraw = {
		head = {
			cmd = "kCSMsgOpActDrawNewbieUpDraw"
		},
		["csp.opact_drawnewbieup_draw_c"] = {}
	},
	kCSMsgOpActDrawNewbieUpNewCycle = {
		head = {
			cmd = "kCSMsgOpActDrawNewbieUpNewCycle"
		},
		["csp.opact_drawnewbieup_new_cycle_c"] = {}
	},
	kCSMsgOpActRandReplaceSet = {
		head = {
			cmd = "kCSMsgOpActRandReplaceSet"
		},
		["csp.opact_rand_replace_set_c"] = {}
	},
	kCSMsgOpActDrawNewbieCampDraw = {
		head = {
			cmd = "kCSMsgOpActDrawNewbieCampDraw"
		},
		["csp.opact_drawnewbiecamp_draw_c"] = {}
	},
	kCSMsgOpActDrawSeasonDraw = {
		head = {
			cmd = "kCSMsgOpActDrawSeasonDraw"
		},
		["csp.opact_drawseason_draw_c"] = {}
	},
	kCSMsgOpActEquipRecycleChoose = {
		head = {
			cmd = "kCSMsgOpActEquipRecycleChoose"
		},
		["csp.opact_equip_recycle_choose_c"] = {}
	},
	kCSMsgOpActEquipRecycleStart = {
		head = {
			cmd = "kCSMsgOpActEquipRecycleStart"
		},
		["csp.opact_equip_recycle_start_c"] = {}
	},
	kCSMsgOpActEquipRecycleStop = {
		head = {
			cmd = "kCSMsgOpActEquipRecycleStop"
		},
		["csp.opact_equip_recycle_stop_c"] = {}
	},
	kCSMsgOpActEquipRecycleGetAward = {
		head = {
			cmd = "kCSMsgOpActEquipRecycleGetAward"
		},
		["csp.opact_equip_recycle_get_award_c"] = {}
	},
	kCSMsgOpActEquipRecycleUnlockWorkShop = {
		head = {
			cmd = "kCSMsgOpActEquipRecycleUnlockWorkShop"
		},
		["csp.opact_equip_recycle_unlock_workshop_c"] = {}
	},
	kCSMsgOpActAchieveGetAllAward = {
		head = {
			cmd = "kCSMsgOpActAchieveGetAllAward"
		},
		["csp.opact_achieve_get_all_award_c"] = {}
	},
	kCSMsgRechargeGenerateOrderID = {
		head = {
			cmd = "kCSMsgRechargeGenerateOrderID"
		},
		["csp.recharge_generate_orderid_c"] = {}
	},
	kCSMsgRechargeCancelOrder = {
		head = {
			cmd = "kCSMsgRechargeCancelOrder"
		},
		["csp.recharge_cancel_order_c"] = {}
	},
	kCSMsgRechargeListGet = {
		head = {
			cmd = "kCSMsgRechargeListGet"
		},
		["csp.recharge_list_get_c"] = {}
	},
	kCSMsgRechargeGetFirstAward = {
		head = {
			cmd = "kCSMsgRechargeGetFirstAward"
		},
		["csp.recharge_get_first_award_c"] = {}
	},
	kCSMsgRechargeGetMulityAward = {
		head = {
			cmd = "kCSMsgRechargeGetMulityAward"
		},
		["csp.recharge_get_mulity_award_c"] = {}
	},
	kCSMsgSubscribeGetAward = {
		head = {
			cmd = "kCSMsgSubscribeGetAward"
		},
		["csp.sub_data_nget_award_c"] = {}
	},
	kCSMsgDraw = {
		head = {
			cmd = "kCSMsgDraw"
		},
		["csp.draw_c"] = {}
	},
	kCSMsgDrawNewbie = {
		head = {
			cmd = "kCSMsgDrawNewbie"
		},
		["csp.draw_newbie_c"] = {}
	},
	kCSMsgDrawUnlockCamp = {
		head = {
			cmd = "kCSMsgDrawUnlockCamp"
		},
		["csp.draw_unlock_c"] = {}
	},
	kCSMsgDrawNebieBestChange = {
		head = {
			cmd = "kCSMsgDrawNebieBestChange"
		},
		["csp.draw_best_change_c"] = {}
	},
	kCSMsgDrawRecord = {
		head = {
			cmd = "kCSMsgDrawRecord"
		},
		["csp.draw_record_c"] = {}
	},
	kCSMsgDrawSetDesire = {
		head = {
			cmd = "kCSMsgDrawSetDesire"
		},
		["csp.draw_set_desire_c"] = {}
	},
	kCSMsgPetDrawRest = {
		head = {
			cmd = "kCSMsgPetDrawRest"
		},
		["csp.pet_draw_reset_c"] = {}
	},
	kCSMsgPetDrawSelect = {
		head = {
			cmd = "kCSMsgPetDrawSelect"
		},
		["csp.pet_draw_select_c"] = {}
	},
	kCSMsgDrawNewbieReset = {
		head = {
			cmd = "kCSMsgDrawNewbieReset"
		},
		["csp.draw_newbie_reset_c"] = {}
	},
	kCSMsgPVEStart = {
		head = {
			cmd = "kCSMsgPVEStart"
		},
		["csp.pve_start_c"] = {}
	},
	kCSMsgPVEFinish = {
		head = {
			cmd = "kCSMsgPVEFinish"
		},
		["csp.pve_finish_c"] = {}
	},
	kCSMsgPVEQuit = {
		head = {
			cmd = "kCSMsgPVEQuit"
		},
		["csp.pve_quit_c"] = {}
	},
	kCSMsgPVEBattleReplay = {
		head = {
			cmd = "kCSMsgPVEBattleReplay"
		},
		["csp.pve_battle_replay_c"] = {}
	},
	kCSMsgPVEShare = {
		head = {
			cmd = "kCSMsgPVEShare"
		},
		["csp.pve_battle_share_c"] = {}
	},
	kCSMsgPVEAutoBattle = {
		head = {
			cmd = "kCSMsgPVEAutoBattle"
		},
		["csp.pve_auto_battle_c"] = {}
	},
	kCSMsgFormationUpdate = {
		head = {
			cmd = "kCSMsgFormationUpdate"
		},
		["csp.formation_update_c"] = {}
	},
	kCSMsgFormationSelect = {
		head = {
			cmd = "kCSMsgFormationSelect"
		},
		["csp.formation_select_c"] = {}
	},
	kCSMsgFormationsUpdateByType = {
		head = {
			cmd = "kCSMsgFormationsUpdateByType"
		},
		["csp.formation_update_by_type_c"] = {}
	},
	kCSMsgFormationSnapshot = {
		head = {
			cmd = "kCSMsgFormationSnapshot"
		},
		["csp.formation_snapshot_c"] = {}
	},
	kCSMsgFormationSnapshotSwapIdx = {
		head = {
			cmd = "kCSMsgFormationSnapshotSwapIdx"
		},
		["csp.formation_snapshot_swap_idx_c"] = {}
	},
	kCSMsgFormationSnapshotGet = {
		head = {
			cmd = "kCSMsgFormationSnapshotGet"
		},
		["csp.formation_snapshot_get_c"] = {}
	},
	kCSMsgFormationsUpdateByPos = {
		head = {
			cmd = "kCSMsgFormationsUpdateByPos"
		},
		["csp.formation_update_by_pos_c"] = {}
	},
	kCSMsgStageUnlockNext = {
		head = {
			cmd = "kCSMsgStageUnlockNext"
		},
		["csp.stage_unlock_next_c"] = {}
	},
	kCSMsgStageRecord = {
		head = {
			cmd = "kCSMsgStageRecord"
		},
		["csp.stage_record_c"] = {}
	},
	kCSMsgStageSkip = {
		head = {
			cmd = "kCSMsgStageSkip"
		},
		["csp.stage_skip_c"] = {}
	},
	kCSMsgDepositAwardRefresh = {
		head = {
			cmd = "kCSMsgDepositAwardRefresh"
		},
		["csp.deposit_refresh_c"] = {}
	},
	kCSMsgDepositAwardGet = {
		head = {
			cmd = "kCSMsgDepositAwardGet"
		},
		["csp.deposit_get_c"] = {}
	},
	kCSMsgDepositAwardStart = {
		head = {
			cmd = "kCSMsgDepositAwardStart"
		},
		["csp.deposit_start_c"] = {}
	},
	kCSMsgTowerStarAwardGet = {
		head = {
			cmd = "kCSMsgTowerStarAwardGet"
		},
		["csp.tower_star_award_get_c"] = {}
	},
	kCSMsgTowerSweep = {
		head = {
			cmd = "kCSMsgTowerSweep"
		},
		["csp.tower_sweep_c"] = {}
	},
	kCSMsgEquipWear = {
		head = {
			cmd = "kCSMsgEquipWear"
		},
		["csp.equip_wear_c"] = {}
	},
	kCSMsgEquipOff = {
		head = {
			cmd = "kCSMsgEquipOff"
		},
		["csp.equip_off_c"] = {}
	},
	kCSMsgEquipSell = {
		head = {
			cmd = "kCSMsgEquipSell"
		},
		["csp.equip_sell_c"] = {}
	},
	kCSMsgEquipLevelUp = {
		head = {
			cmd = "kCSMsgEquipLevelUp"
		},
		["csp.equip_levelup_c"] = {}
	},
	kCSMsgEquipSwap = {
		head = {
			cmd = "kCSMsgEquipSwap"
		},
		["csp.equip_swap_c"] = {}
	},
	kCSMsgEquipEvolve = {
		head = {
			cmd = "kCSMsgEquipEvolve"
		},
		["csp.equip_evolve_c"] = {}
	},
	kCSMsgEquipBuild = {
		head = {
			cmd = "kCSMsgEquipBuild"
		},
		["csp.equip_build_c"] = {}
	},
	kCSMsgEquipBuildLevelUp = {
		head = {
			cmd = "kCSMsgEquipBuildLevelUp"
		},
		["csp.equip_build_levelup_c"] = {}
	},
	kCSMsgEquipLock = {
		head = {
			cmd = "kCSMsgEquipLock"
		},
		["csp.equip_lock_c"] = {}
	},
	kCSMsgArtifactWear = {
		head = {
			cmd = "kCSMsgArtifactWear"
		},
		["csp.artifact_wear_c"] = {}
	},
	kCSMsgArtifactOff = {
		head = {
			cmd = "kCSMsgArtifactOff"
		},
		["csp.artifact_off_c"] = {}
	},
	kCSMsgArtifactSell = {
		head = {
			cmd = "kCSMsgArtifactSell"
		},
		["csp.artifact_sell_c"] = {}
	},
	kCSMsgArtifactLevelUp = {
		head = {
			cmd = "kCSMsgArtifactLevelUp"
		},
		["csp.artifact_levelup_c"] = {}
	},
	kCSMsgArtifactLock = {
		head = {
			cmd = "kCSMsgArtifactLock"
		},
		["csp.artifact_lock_c"] = {}
	},
	kCSMsgShopExchange = {
		head = {
			cmd = "kCSMsgShopExchange"
		},
		["csp.shop_exchange_c"] = {}
	},
	kCSMsgShopEnter = {
		head = {
			cmd = "kCSMsgShopEnter"
		},
		["csp.shop_enter_c"] = {}
	},
	kCSMsgCurrencyExchange = {
		head = {
			cmd = "kCSMsgCurrencyExchange"
		},
		["csp.currency_exchange_c"] = {}
	},
	kCSMsgShopRefresh = {
		head = {
			cmd = "kCSMsgShopRefresh"
		},
		["csp.shop_refresh_c"] = {}
	},
	kCSMsgAchieveGetAward = {
		head = {
			cmd = "kCSMsgAchieveGetAward"
		},
		["csp.achieve_get_award_c"] = {}
	},
	kCSMsgAchieveProgressUpdateClient = {
		head = {
			cmd = "kCSMsgAchieveProgressUpdateClient"
		},
		["csp.achieve_progress_update_client_c"] = {}
	},
	kCSMsgRoleMiscIDCard = {
		head = {
			cmd = "kCSMsgRoleMiscIDCard"
		},
		["csp.role_misc_idcard_c"] = {}
	},
	kCSMsgRoleMiscYD = {
		head = {
			cmd = "kCSMsgRoleMiscYD"
		},
		["csp.role_misc_yd_c"] = {}
	},
	kCSMsgRoleMiscConsignee = {
		head = {
			cmd = "kCSMsgRoleMiscConsignee"
		},
		["csp.role_misc_consignee_c"] = {}
	},
	kCSMsgEquipTowerSweep = {
		head = {
			cmd = "kCSMsgEquipTowerSweep"
		},
		["csp.equip_tower_sweep_c"] = {}
	},
	kCSMsgEquipTowerReplayRecord = {
		head = {
			cmd = "kCSMsgEquipTowerReplayRecord"
		},
		["csp.equip_tower_replay_record_c"] = {}
	},
	kCSMsgEquipTowerChooseHero = {
		head = {
			cmd = "kCSMsgEquipTowerChooseHero"
		},
		["csp.equip_tower_choose_hero_c"] = {}
	},
	kCSMsgBagSizeExtend = {
		head = {
			cmd = "kCSMsgBagSizeExtend"
		},
		["csp.bag_size_extend_c"] = {}
	},
	kCSMsgAsyncPVPFormation = {
		head = {
			cmd = "kCSMsgAsyncPVPFormation"
		},
		["csp.async_pvp_formation_c"] = {}
	},
	kCSMsgAsyncPVPMatch = {
		head = {
			cmd = "kCSMsgAsyncPVPMatch"
		},
		["csp.async_pvp_match_c"] = {}
	},
	kCSMsgAsyncPVPChallege = {
		head = {
			cmd = "kCSMsgAsyncPVPChallege"
		},
		["csp.async_pvp_challege_c"] = {}
	},
	kCSMsgAsyncPVPReportGet = {
		head = {
			cmd = "kCSMsgAsyncPVPReportGet"
		},
		["csp.async_pvp_report_get_c"] = {}
	},
	kCSMsgAsyncPVPSweep = {
		head = {
			cmd = "kCSMsgAsyncPVPSweep"
		},
		["csp.async_pvp_sweep_c"] = {}
	},
	kCSMsgAsyncPVPGetDetail = {
		head = {
			cmd = "kCSMsgAsyncPVPGetDetail"
		},
		["csp.async_pvp_get_detail_c"] = {}
	},
	kCSMsgAsyncPVPTargetCache = {
		head = {
			cmd = "kCSMsgAsyncPVPTargetCache"
		},
		["csp.async_pvp_target_cache_c"] = {}
	},
	kCSMsgAsyncPVPScore = {
		head = {
			cmd = "kCSMsgAsyncPVPScore"
		},
		["csp.async_pvp_score_c"] = {}
	},
	kCSMsgCDKey = {
		head = {
			cmd = "kCSMsgCDKey"
		},
		["csp.cdkey_c"] = {}
	},
	kCSMsgBossTowerAwardGet = {
		head = {
			cmd = "kCSMsgBossTowerAwardGet"
		},
		["csp.boss_tower_award_get_c"] = {}
	},
	kCSMsgBossTowerReplayRecord = {
		head = {
			cmd = "kCSMsgBossTowerReplayRecord"
		},
		["csp.boss_tower_replay_record_c"] = {}
	},
	kCSMsgOnceTowerReplayRecord = {
		head = {
			cmd = "kCSMsgOnceTowerReplayRecord"
		},
		["csp.once_tower_replay_record_c"] = {}
	},
	kCSMsgNewbieReport = {
		head = {
			cmd = "kCSMsgNewbieReport"
		},
		["csp.newbie_report_c"] = {}
	},
	kCSMsgTaskGetAward = {
		head = {
			cmd = "kCSMsgTaskGetAward"
		},
		["csp.task_get_award_c"] = {}
	},
	kCSMsgTaskGetAllDailyAward = {
		head = {
			cmd = "kCSMsgTaskGetAllDailyAward"
		},
		["csp.task_get_all_daily_award_c"] = {}
	},
	kCSMsgHouseUpdate = {
		head = {
			cmd = "kCSMsgHouseUpdate"
		},
		["csp.house_update_c"] = {}
	},
	kCSMsgHouseVisit = {
		head = {
			cmd = "kCSMsgHouseVisit"
		},
		["csp.house_visit_c"] = {}
	},
	kCSMsgHouseLevelUp = {
		head = {
			cmd = "kCSMsgHouseLevelUp"
		},
		["csp.house_level_up_c"] = {}
	},
	kCSMsgHouseUnlockAwardGet = {
		head = {
			cmd = "kCSMsgHouseUnlockAwardGet"
		},
		["csp.house_unlock_award_get_c"] = {}
	},
	kCSMsgHouseComfortAwardGet = {
		head = {
			cmd = "kCSMsgHouseComfortAwardGet"
		},
		["csp.house_comfort_award_get_c"] = {}
	},
	kCSMsgHouseSweep = {
		head = {
			cmd = "kCSMsgHouseSweep"
		},
		["csp.house_sweep_c"] = {}
	},
	kCSMsgHouseVisitHistoryGet = {
		head = {
			cmd = "kCSMsgHouseVisitHistoryGet"
		},
		["csp.house_visit_history_c"] = {}
	},
	kCSMsgHouseFavor = {
		head = {
			cmd = "kCSMsgHouseFavor"
		},
		["csp.house_favor_c"] = {}
	},
	kCSMsgHouseFavorHistory = {
		head = {
			cmd = "kCSMsgHouseFavorHistory"
		},
		["csp.house_favor_history_c"] = {}
	},
	kCSMsgHouseFavorRank = {
		head = {
			cmd = "kCSMsgHouseFavorRank"
		},
		["csp.house_favor_rank_c"] = {}
	},
	kCSMsgHouseVisitRandom = {
		head = {
			cmd = "kCSMsgHouseVisitRandom"
		},
		["csp.house_visit_random_c"] = {}
	},
	kCSMsgHouseShare = {
		head = {
			cmd = "kCSMsgHouseShare"
		},
		["csp.house_share_c"] = {}
	},
	kCSMsgHouseMainRoomSet = {
		head = {
			cmd = "kCSMsgHouseMainRoomSet"
		},
		["csp.house_main_room_c"] = {}
	},
	kCSMsgHouseCommentSwitchSet = {
		head = {
			cmd = "kCSMsgHouseCommentSwitchSet"
		},
		["csp.house_comment_switch_c"] = {}
	},
	kCSMsgMazeSelectBranch = {
		head = {
			cmd = "kCSMsgMazeSelectBranch"
		},
		["csp.maze_select_branch_c"] = {}
	},
	kCSMsgMazeSelectRelics = {
		head = {
			cmd = "kCSMsgMazeSelectRelics"
		},
		["csp.maze_select_relics_c"] = {}
	},
	kCSMsgMazeSelect = {
		head = {
			cmd = "kCSMsgMazeSelect"
		},
		["csp.maze_select_c"] = {}
	},
	kCSMsgMazeRelive = {
		head = {
			cmd = "kCSMsgMazeRelive"
		},
		["csp.maze_relive_c"] = {}
	},
	kCSMsgMazeSelectSweepRelics = {
		head = {
			cmd = "kCSMsgMazeSelectSweepRelics"
		},
		["csp.maze_select_sweep_relics_c"] = {}
	},
	kCSMsgMazeSweep = {
		head = {
			cmd = "kCSMsgMazeSweep"
		},
		["csp.maze_sweep_c"] = {}
	},
	kCSMsgRankIndexGet = {
		head = {
			cmd = "kCSMsgRankIndexGet"
		},
		["csp.rank_index_get_c"] = {}
	},
	kCSMsgRankGet = {
		head = {
			cmd = "kCSMsgRankGet"
		},
		["csp.rank_get_c"] = {}
	},
	kCSMsgRankTopGet = {
		head = {
			cmd = "kCSMsgRankTopGet"
		},
		["csp.rank_top_get_c"] = {}
	},
	kCSMsgBookTaskGetAward = {
		head = {
			cmd = "kCSMsgBookTaskGetAward"
		},
		["csp.book_task_get_award_c"] = {}
	},
	kCSMsgWelfareGetAward = {
		head = {
			cmd = "kCSMsgWelfareGetAward"
		},
		["csp.welfare_activity_get_c"] = {}
	},
	kCSMsgWelfarePushGiftPopupSet = {
		head = {
			cmd = "kCSMsgWelfarePushGiftPopupSet"
		},
		["csp.push_gift_popup_set_c"] = {}
	},
	kCSMsgBattlePassGetTaskAward = {
		head = {
			cmd = "kCSMsgBattlePassGetTaskAward"
		},
		["csp.battle_pass_get_task_award_c"] = {}
	},
	kCSMsgBattlePassGetAward = {
		head = {
			cmd = "kCSMsgBattlePassGetAward"
		},
		["csp.battle_pass_get_bp_award_c"] = {}
	},
	kCSMsgBattlePassBuyBpCount = {
		head = {
			cmd = "kCSMsgBattlePassBuyBpCount"
		},
		["csp.battle_pass_buy_bp_c"] = {}
	},
	kCSMsgBattlePassBpGetSystemData = {
		head = {
			cmd = "kCSMsgBattlePassBpGetSystemData"
		},
		["csp.battle_pass_get_sys_data_c"] = {}
	},
	kCSMsgBattlePassReset = {
		head = {
			cmd = "kCSMsgBattlePassReset"
		},
		["csp.battle_pass_reset_c"] = {}
	},
	kCSMsgSurveyFinish = {
		head = {
			cmd = "kCSMsgSurveyFinish"
		},
		["csp.survey_finish_c"] = {}
	},
	kCSMsgRoleCommGet = {
		head = {
			cmd = "kCSMsgRoleCommGet"
		},
		["csp.role_comm_get_c"] = {}
	},
	kCSMsgRoleCommEditFormation = {
		head = {
			cmd = "kCSMsgRoleCommEditFormation"
		},
		["csp.role_comm_edit_formation_c"] = {}
	},
	kCSMsgRoleCommEditSignature = {
		head = {
			cmd = "kCSMsgRoleCommEditSignature"
		},
		["csp.role_comm_edit_signature_c"] = {}
	},
	kCSMsgRoleCommChangeGender = {
		head = {
			cmd = "kCSMsgRoleCommChangeGender"
		},
		["csp.role_comm_change_gender_c"] = {}
	},
	kCSMsgRoleCommChangeHead = {
		head = {
			cmd = "kCSMsgRoleCommChangeHead"
		},
		["csp.role_comm_change_head_c"] = {}
	},
	kCSMsgRoleCommChangeHeadFrame = {
		head = {
			cmd = "kCSMsgRoleCommChangeHeadFrame"
		},
		["csp.role_comm_change_head_frame_c"] = {}
	},
	kCSMsgRoleCommEditVowHero = {
		head = {
			cmd = "kCSMsgRoleCommEditVowHero"
		},
		["csp.role_comm_edit_vow_hero_c"] = {}
	},
	kCSMsgRoleCommChangeHeadPendant = {
		head = {
			cmd = "kCSMsgRoleCommChangeHeadPendant"
		},
		["csp.role_comm_change_head_pendant_c"] = {}
	},
	kCSMsgRoleCommEditSignet = {
		head = {
			cmd = "kCSMsgRoleCommEditSignet"
		},
		["csp.role_comm_edit_signet_c"] = {}
	},
	kCSMsgRoleCommChangeBubble = {
		head = {
			cmd = "kCSMsgRoleCommChangeBubble"
		},
		["csp.role_comm_change_bubble_c"] = {}
	},
	kCSMsgMonumentMsgGetAward = {
		head = {
			cmd = "kCSMsgMonumentMsgGetAward"
		},
		["csp.monument_get_award_c"] = {}
	},
	kCSMsgCrystalMsgLevelUp = {
		head = {
			cmd = "kCSMsgCrystalMsgLevelUp"
		},
		["csp.crystal_level_up_c"] = {}
	},
	kCSMsgCrystalMsgSetSympathizer = {
		head = {
			cmd = "kCSMsgCrystalMsgSetSympathizer"
		},
		["csp.crystal_set_sympathizer_c"] = {}
	},
	kCSMsgCrystalMsgUnsetSympathizer = {
		head = {
			cmd = "kCSMsgCrystalMsgUnsetSympathizer"
		},
		["csp.crystal_unset_sympathizer_c"] = {}
	},
	kCSMsgCrystalMsgSaveSympathizer = {
		head = {
			cmd = "kCSMsgCrystalMsgSaveSympathizer"
		},
		["csp.crystal_save_sympathizer_c"] = {}
	},
	kCSMsgCrystalMsgGetAward = {
		head = {
			cmd = "kCSMsgCrystalMsgGetAward"
		},
		["csp.crystal_get_award_c"] = {}
	},
	kCSMsgPowerExchange = {
		head = {
			cmd = "kCSMsgPowerExchange"
		},
		["csp.power_exchange_c"] = {}
	},
	kCSMsgVIPGetAward = {
		head = {
			cmd = "kCSMsgVIPGetAward"
		},
		["csp.vip_get_award_c"] = {}
	},
	kCSMsgVIPSetHide = {
		head = {
			cmd = "kCSMsgVIPSetHide"
		},
		["csp.vip_set_hide_c"] = {}
	},
	kCSMsgClanCreate = {
		head = {
			cmd = "kCSMsgClanCreate"
		},
		["csp.clan_create_c"] = {}
	},
	kCSMsgClanGet = {
		head = {
			cmd = "kCSMsgClanGet"
		},
		["csp.clan_get_c"] = {}
	},
	kCSMsgClanJoin = {
		head = {
			cmd = "kCSMsgClanJoin"
		},
		["csp.clan_join_c"] = {}
	},
	kCSMsgClanAcceptApply = {
		head = {
			cmd = "kCSMsgClanAcceptApply"
		},
		["csp.clan_accept_apply_c"] = {}
	},
	kCSMsgClanRefuseApply = {
		head = {
			cmd = "kCSMsgClanRefuseApply"
		},
		["csp.clan_refuse_apply_c"] = {}
	},
	kCSMsgClanExit = {
		head = {
			cmd = "kCSMsgClanExit"
		},
		["csp.clan_exit_c"] = {}
	},
	kCSMsgClanDismiss = {
		head = {
			cmd = "kCSMsgClanDismiss"
		},
		["csp.clan_dismiss_c"] = {}
	},
	kCSMsgClanKick = {
		head = {
			cmd = "kCSMsgClanKick"
		},
		["csp.clan_kick_c"] = {}
	},
	kCSMsgClanAppoint = {
		head = {
			cmd = "kCSMsgClanAppoint"
		},
		["csp.clan_appoint_c"] = {}
	},
	kCSMsgClanRename = {
		head = {
			cmd = "kCSMsgClanRename"
		},
		["csp.clan_rename_c"] = {}
	},
	kCSMsgClanRenotice = {
		head = {
			cmd = "kCSMsgClanRenotice"
		},
		["csp.clan_renotice_c"] = {}
	},
	kCSMsgClanSearch = {
		head = {
			cmd = "kCSMsgClanSearch"
		},
		["csp.clan_search_c"] = {}
	},
	kCSMsgClanRecommend = {
		head = {
			cmd = "kCSMsgClanRecommend"
		},
		["csp.clan_recommend_c"] = {}
	},
	kCSMsgClanCheckin = {
		head = {
			cmd = "kCSMsgClanCheckin"
		},
		["csp.clan_checkin_c"] = {}
	},
	kCSMsgClanTransfer = {
		head = {
			cmd = "kCSMsgClanTransfer"
		},
		["csp.clan_transfer_c"] = {}
	},
	kCSMsgClanSendMail = {
		head = {
			cmd = "kCSMsgClanSendMail"
		},
		["csp.clan_mail_c"] = {}
	},
	kCSMsgClanRehead = {
		head = {
			cmd = "kCSMsgClanRehead"
		},
		["csp.clan_rehead_c"] = {}
	},
	kCSMsgClanSetAutoAccept = {
		head = {
			cmd = "kCSMsgClanSetAutoAccept"
		},
		["csp.clan_set_auto_accept_c"] = {}
	},
	kCSMsgClanReHeadFrame = {
		head = {
			cmd = "kCSMsgClanReHeadFrame"
		},
		["csp.clan_re_head_frame_c"] = {}
	},
	kCSMsgFamiliarLevelChange = {
		head = {
			cmd = "kCSMsgFamiliarLevelChange"
		},
		["csp.familiar_up_level_c"] = {}
	},
	kCSMsgHouseDispatchStart = {
		head = {
			cmd = "kCSMsgHouseDispatchStart"
		},
		["csp.house_dispatch_start_c"] = {}
	},
	kCSMsgHouseDispatchDone = {
		head = {
			cmd = "kCSMsgHouseDispatchDone"
		},
		["csp.house_dispatch_done_c"] = {}
	},
	kCSMsgHouseDispatchLock = {
		head = {
			cmd = "kCSMsgHouseDispatchLock"
		},
		["csp.house_dispatch_lock_c"] = {}
	},
	kCSMsgHouseDispatchRefresh = {
		head = {
			cmd = "kCSMsgHouseDispatchRefresh"
		},
		["csp.house_dispatch_refresh_c"] = {}
	},
	kCSMsgHouseDispatchAllDone = {
		head = {
			cmd = "kCSMsgHouseDispatchAllDone"
		},
		["csp.house_dispatch_all_done_c"] = {}
	},
	kCSMsgMultiPVPMatch = {
		head = {
			cmd = "kCSMsgMultiPVPMatch"
		},
		["csp.multipvp_match_c"] = {}
	},
	kCSMsgMultiPVPTargetCache = {
		head = {
			cmd = "kCSMsgMultiPVPTargetCache"
		},
		["csp.multipvp_target_cache_c"] = {}
	},
	kCSMsgMultiPVPRank = {
		head = {
			cmd = "kCSMsgMultiPVPRank"
		},
		["csp.multipvp_rank_c"] = {}
	},
	kCSMsgMultiPVPAwardGet = {
		head = {
			cmd = "kCSMsgMultiPVPAwardGet"
		},
		["csp.multipvp_award_get_c"] = {}
	},
	kCSMsgMultiPVPReportGet = {
		head = {
			cmd = "kCSMsgMultiPVPReportGet"
		},
		["csp.multipvp_report_get_c"] = {}
	},
	kCSMsgRelicWear = {
		head = {
			cmd = "kCSMsgRelicWear"
		},
		["csp.relic_wear_c"] = {}
	},
	kCSMsgRelicOff = {
		head = {
			cmd = "kCSMsgRelicOff"
		},
		["csp.relic_off_c"] = {}
	},
	kCSMsgRelicLevelUp = {
		head = {
			cmd = "kCSMsgRelicLevelUp"
		},
		["csp.relic_level_up_c"] = {}
	},
	kCSMsgSeasonRelicOp = {
		head = {
			cmd = "kCSMsgSeasonRelicOp"
		},
		["csp.season_relic_op_c"] = {}
	},
	kCSMsgSkinWear = {
		head = {
			cmd = "kCSMsgSkinWear"
		},
		["csp.skin_wear_c"] = {}
	},
	kCSMsgSkinExchange = {
		head = {
			cmd = "kCSMsgSkinExchange"
		},
		["csp.skin_exchange_c"] = {}
	},
	kCSMsgSkinUnlock = {
		head = {
			cmd = "kCSMsgSkinUnlock"
		},
		["csp.skin_unlock_c"] = {}
	},
	kCSMsgRechargeRebateAward = {
		head = {
			cmd = "kCSMsgRechargeRebateAward"
		},
		["csp.recharge_rebate_award_c"] = {}
	},
	kCSMsgOpactArenaRoleOpen = {
		head = {
			cmd = "kCSMsgOpactArenaRoleOpen"
		},
		["csp.opact_arena_role_open_c"] = {}
	},
	kCSMsgOpactArenaEnroll = {
		head = {
			cmd = "kCSMsgOpactArenaEnroll"
		},
		["csp.opact_arena_enroll_c"] = {}
	},
	kCSMsgOpactArenaUpgradeLeague = {
		head = {
			cmd = "kCSMsgOpactArenaUpgradeLeague"
		},
		["csp.opact_arena_upgrade_league_c"] = {}
	},
	kCSMsgOpactArenaMatch = {
		head = {
			cmd = "kCSMsgOpactArenaMatch"
		},
		["csp.opact_arena_match_c"] = {}
	},
	kCSMsgOpactArenaDetailGet = {
		head = {
			cmd = "kCSMsgOpactArenaDetailGet"
		},
		["csp.opact_arena_detail_get_c"] = {}
	},
	kCSMsgOpactArenaReportGet = {
		head = {
			cmd = "kCSMsgOpactArenaReportGet"
		},
		["csp.opact_arena_report_get_c"] = {}
	},
	kCSMsgOpactArenaRankGet = {
		head = {
			cmd = "kCSMsgOpactArenaRankGet"
		},
		["csp.opact_arena_rank_get_c"] = {}
	},
	kCSMsgOpactArenaRankTopGet = {
		head = {
			cmd = "kCSMsgOpactArenaRankTopGet"
		},
		["csp.opact_arena_rank_top_get_c"] = {}
	},
	kCSMsgOpactArenaRoleInfoRefresh = {
		head = {
			cmd = "kCSMsgOpactArenaRoleInfoRefresh"
		},
		["csp.opact_arena_role_info_refresh_c"] = {}
	},
	kCSMsgOpactArenaRoleGetNearRank = {
		head = {
			cmd = "kCSMsgOpactArenaRoleGetNearRank"
		},
		["csp.opact_arena_role_get_near_rank_c"] = {}
	},
	kCSMsgOpactArenaSetRandFormaion = {
		head = {
			cmd = "kCSMsgOpactArenaSetRandFormaion"
		},
		["csp.opact_arena_set_rand_formation_c"] = {}
	},
	kCSMsgOpActTowerSweep = {
		head = {
			cmd = "kCSMsgOpActTowerSweep"
		},
		["csp.opact_tower_sweep_c"] = {}
	},
	kCSMsgOpActTowerGetScoreAward = {
		head = {
			cmd = "kCSMsgOpActTowerGetScoreAward"
		},
		["csp.opact_tower_get_score_c"] = {}
	},
	kCSMsgOpActTowerSetBuff = {
		head = {
			cmd = "kCSMsgOpActTowerSetBuff"
		},
		["csp.opact_tower_set_buff_c"] = {}
	},
	kCSMsgOpActTowerGetBuff = {
		head = {
			cmd = "kCSMsgOpActTowerGetBuff"
		},
		["csp.opact_tower_get_buff_c"] = {}
	},
	kCSMsgOpActTowerRefreshDeposite = {
		head = {
			cmd = "kCSMsgOpActTowerRefreshDeposite"
		},
		["csp.opact_tower_refresh_deposit_c"] = {}
	},
	kCSMsgOpActTowerGetDepositAward = {
		head = {
			cmd = "kCSMsgOpActTowerGetDepositAward"
		},
		["csp.opact_tower_get_deposit_award_c"] = {}
	},
	kCSMsgOpActTowerReplayRecord = {
		head = {
			cmd = "kCSMsgOpActTowerReplayRecord"
		},
		["csp.opact_tower_replay_record_c"] = {}
	},
	kCSMsgOpActTowerEnter = {
		head = {
			cmd = "kCSMsgOpActTowerEnter"
		},
		["csp.opact_tower_enter_c"] = {}
	},
	kCSMsgRentTaskRefresh = {
		head = {
			cmd = "kCSMsgRentTaskRefresh"
		},
		["csp.rent_task_refresh_c"] = {}
	},
	kCSMsgRentTaskSelect = {
		head = {
			cmd = "kCSMsgRentTaskSelect"
		},
		["csp.rent_task_select_c"] = {}
	},
	kCSMsgRentMatch = {
		head = {
			cmd = "kCSMsgRentMatch"
		},
		["csp.rent_match_c"] = {}
	},
	kCSMsgRentSetAutoAccept = {
		head = {
			cmd = "kCSMsgRentSetAutoAccept"
		},
		["csp.rent_set_auto_accept_c"] = {}
	},
	kCSMsgRentSendLetter = {
		head = {
			cmd = "kCSMsgRentSendLetter"
		},
		["csp.rent_send_letter_c"] = {}
	},
	kCSMsgRentRenterRent = {
		head = {
			cmd = "kCSMsgRentRenterRent"
		},
		["csp.rent_renter_rent_c"] = {}
	},
	kCSMsgRentRenterCancel = {
		head = {
			cmd = "kCSMsgRentRenterCancel"
		},
		["csp.rent_renter_cancel_c"] = {}
	},
	kCSMsgRentOwnerAccept = {
		head = {
			cmd = "kCSMsgRentOwnerAccept"
		},
		["csp.rent_owner_accept_c"] = {}
	},
	kCSMsgRentOwnerRefuse = {
		head = {
			cmd = "kCSMsgRentOwnerRefuse"
		},
		["csp.rent_owner_refuse_c"] = {}
	},
	kCSMsgRentOwnerCancel = {
		head = {
			cmd = "kCSMsgRentOwnerCancel"
		},
		["csp.rent_owner_cancel_c"] = {}
	},
	kCSMsgRentGetRentedFormation = {
		head = {
			cmd = "kCSMsgRentGetRentedFormation"
		},
		["csp.rent_get_rented_formation_c"] = {}
	},
	kCSMsgRentGetOwnerFormation = {
		head = {
			cmd = "kCSMsgRentGetOwnerFormation"
		},
		["csp.rent_get_owner_formation_c"] = {}
	},
	kCSMsgRentGetLetter = {
		head = {
			cmd = "kCSMsgRentGetLetter"
		},
		["csp.rent_get_letter_c"] = {}
	},
	kCSMsgRentUpdateFormation = {
		head = {
			cmd = "kCSMsgRentUpdateFormation"
		},
		["csp.rent_update_formation_c"] = {}
	},
	kCSMsgRentGetSendLetter = {
		head = {
			cmd = "kCSMsgRentGetSendLetter"
		},
		["csp.rent_get_send_letter_c"] = {}
	},
	kCSMsgRankCacheGetPage = {
		head = {
			cmd = "kCSMsgRankCacheGetPage"
		},
		["csp.rank_cache_get_page_c"] = {}
	},
	kCSMsgRankCacheGetRealRanking = {
		head = {
			cmd = "kCSMsgRankCacheGetRealRanking"
		},
		["csp.rank_cache_get_real_ranking_c"] = {}
	},
	kCSMsgProficentLevelUp = {
		head = {
			cmd = "kCSMsgProficentLevelUp"
		},
		["csp.proficent_level_up_c"] = {}
	},
	kCSMsgProficentGetScore = {
		head = {
			cmd = "kCSMsgProficentGetScore"
		},
		["csp.proficent_get_score_c"] = {}
	},
	kCSMsgProficentGetOtherScore = {
		head = {
			cmd = "kCSMsgProficentGetOtherScore"
		},
		["csp.proficent_get_other_score_c"] = {}
	},
	kCSMsgProficentBookGemUse = {
		head = {
			cmd = "kCSMsgProficentBookGemUse"
		},
		["csp.proficent_book_gem_use_c"] = {}
	},
	kCSMsgQQBlueGetForeverAward = {
		head = {
			cmd = "kCSMsgQQBlueGetForeverAward"
		},
		["csp.qq_blue_get_forever_award_c"] = {}
	},
	kCSMsgQQBlueGetDayAward = {
		head = {
			cmd = "kCSMsgQQBlueGetDayAward"
		},
		["csp.qq_blue_get_day_award_c"] = {}
	},
	kCSMsgRedPacketGetAward = {
		head = {
			cmd = "kCSMsgRedPacketGetAward"
		},
		["csp.red_packet_get_award_c"] = {}
	},
	kCSMsgAdvanceGetTaskAward = {
		head = {
			cmd = "kCSMsgAdvanceGetTaskAward"
		},
		["csp.advance_get_task_award_c"] = {}
	},
	kCSMsgAdvanceGetStepAward = {
		head = {
			cmd = "kCSMsgAdvanceGetStepAward"
		},
		["csp.advance_get_step_award_c"] = {}
	},
	kCSMsgClanBattleEnter = {
		head = {
			cmd = "kCSMsgClanBattleEnter"
		},
		["csp.clan_battle_enter_c"] = {}
	},
	kCSMsgClanBattleExit = {
		head = {
			cmd = "kCSMsgClanBattleExit"
		},
		["csp.clan_battle_exit_c"] = {}
	},
	kCSMsgClanBattleOccupyGrid = {
		head = {
			cmd = "kCSMsgClanBattleOccupyGrid"
		},
		["csp.clan_battle_occupy_grid_c"] = {}
	},
	kCSMsgClanBattleCancelGrid = {
		head = {
			cmd = "kCSMsgClanBattleCancelGrid"
		},
		["csp.clan_battle_cancel_grid_c"] = {}
	},
	kCSMsgClanBattleOccupyMonster = {
		head = {
			cmd = "kCSMsgClanBattleOccupyMonster"
		},
		["csp.clan_battle_occupy_monster_c"] = {}
	},
	kCSMsgClanBattleCancelMonster = {
		head = {
			cmd = "kCSMsgClanBattleCancelMonster"
		},
		["csp.clan_battle_cancel_monster_c"] = {}
	},
	kCSMsgClanBattleOpenGrid = {
		head = {
			cmd = "kCSMsgClanBattleOpenGrid"
		},
		["csp.clan_battle_open_grid_c"] = {}
	},
	kCSMsgClanBattleNextLayer = {
		head = {
			cmd = "kCSMsgClanBattleNextLayer"
		},
		["csp.clan_battle_next_layer_c"] = {}
	},
	kCSMsgClanBattleBuySkill = {
		head = {
			cmd = "kCSMsgClanBattleBuySkill"
		},
		["csp.clan_battle_buy_skill_c"] = {}
	},
	kCSMsgClanBattleUseSkill = {
		head = {
			cmd = "kCSMsgClanBattleUseSkill"
		},
		["csp.clan_battle_use_skill_c"] = {}
	},
	kCSMsgClanBattleSetModel = {
		head = {
			cmd = "kCSMsgClanBattleSetModel"
		},
		["csp.clan_battle_set_model_c"] = {}
	},
	kCSMsgClanBattleGiveOrder = {
		head = {
			cmd = "kCSMsgClanBattleGiveOrder"
		},
		["csp.clan_battle_give_order_c"] = {}
	},
	kCSMsgClanBattleSetRelic = {
		head = {
			cmd = "kCSMsgClanBattleSetRelic"
		},
		["csp.clan_battle_set_relic_c"] = {}
	},
	kCSMsgClanBattleScoreInfuse = {
		head = {
			cmd = "kCSMsgClanBattleScoreInfuse"
		},
		["csp.clan_battle_score_infuse_c"] = {}
	},
	kCSMsgClanBattleGetScoreLog = {
		head = {
			cmd = "kCSMsgClanBattleGetScoreLog"
		},
		["csp.clan_battle_get_score_log_c"] = {}
	},
	kCSMsgClanBattleGetLog = {
		head = {
			cmd = "kCSMsgClanBattleGetLog"
		},
		["csp.clan_battle_get_log_c"] = {}
	},
	kCSMsgClanBattleGetClanAchieveAward = {
		head = {
			cmd = "kCSMsgClanBattleGetClanAchieveAward"
		},
		["csp.clan_battle_get_clan_achieve_award_c"] = {}
	},
	kCSMsgClanBattleGetMemberAchieveAward = {
		head = {
			cmd = "kCSMsgClanBattleGetMemberAchieveAward"
		},
		["csp.clan_battle_get_member_achieve_award_c"] = {}
	},
	kCSMsgClanBattleGetHonor = {
		head = {
			cmd = "kCSMsgClanBattleGetHonor"
		},
		["csp.clan_battle_get_honor_c"] = {}
	},
	kCSMsgClanBattleMarkMember = {
		head = {
			cmd = "kCSMsgClanBattleMarkMember"
		},
		["csp.clan_battle_mark_member_c"] = {}
	},
	kCSMsgClanBattleUnmarkMember = {
		head = {
			cmd = "kCSMsgClanBattleUnmarkMember"
		},
		["csp.clan_battle_unmark_member_c"] = {}
	},
	kCSMsgClanBattleOpGridMark = {
		head = {
			cmd = "kCSMsgClanBattleOpGridMark"
		},
		["csp.clan_battle_op_grid_mark_c"] = {}
	},
	kCSMsgClanFuncInvite = {
		head = {
			cmd = "kCSMsgClanFuncInvite"
		},
		["csp.clan_func_invite_c"] = {}
	},
	kCSMsgClanFuncRefuseInvite = {
		head = {
			cmd = "kCSMsgClanFuncRefuseInvite"
		},
		["csp.clan_func_refuse_invite_c"] = {}
	},
	kCSMsgClanFuncShare = {
		head = {
			cmd = "kCSMsgClanFuncShare"
		},
		["csp.clan_func_share_c"] = {}
	},
	kCSMsgCampTowerSweep = {
		head = {
			cmd = "kCSMsgCampTowerSweep"
		},
		["csp.camp_tower_sweep_c"] = {}
	},
	kCSMsgCampTowerReplayRecord = {
		head = {
			cmd = "kCSMsgCampTowerReplayRecord"
		},
		["csp.camp_tower_replay_record_c"] = {}
	},
	kCSMsgCampTowerUpdateStage = {
		head = {
			cmd = "kCSMsgCampTowerUpdateStage"
		},
		["csp.camp_tower_update_stage_c"] = {}
	},
	KCSMsgDynamicExpressionUse = {
		head = {
			cmd = "KCSMsgDynamicExpressionUse"
		},
		["csp.dynamic_expression_use_c"] = {}
	},
	KCSMsgRefluxGetOnceAward = {
		head = {
			cmd = "KCSMsgRefluxGetOnceAward"
		},
		["csp.reflux_get_once_award_c"] = {}
	},
	KCSMsgRefluxNewSetFlag = {
		head = {
			cmd = "KCSMsgRefluxNewSetFlag"
		},
		["csp.reflux_new_set_flag_c"] = {}
	},
	kCSMsgRoleOpActSimpleGet = {
		head = {
			cmd = "kCSMsgRoleOpActSimpleGet"
		},
		["csp.role_opact_simple_get_c"] = {}
	},
	kCSMsgCollectAchieveGetAward = {
		head = {
			cmd = "kCSMsgCollectAchieveGetAward"
		},
		["csp.collect_achieve_get_award_c"] = {}
	},
	kCSMsgNewMazeOpen = {
		head = {
			cmd = "kCSMsgNewMazeOpen"
		},
		["csp.newmaze_open_c"] = {}
	},
	kCSMsgNewMazeLevelEnter = {
		head = {
			cmd = "kCSMsgNewMazeLevelEnter"
		},
		["csp.newmaze_level_enter_c"] = {}
	},
	kCSMsgNewMazeNodeSelect = {
		head = {
			cmd = "kCSMsgNewMazeNodeSelect"
		},
		["csp.newmaze_node_select_c"] = {}
	},
	kCSMsgNewMazeHaloEquip = {
		head = {
			cmd = "kCSMsgNewMazeHaloEquip"
		},
		["csp.newmaze_halo_equip_c"] = {}
	},
	kCSMsgNewMazeHaloUnEquip = {
		head = {
			cmd = "kCSMsgNewMazeHaloUnEquip"
		},
		["csp.newmaze_halo_unequip_c"] = {}
	},
	kCSMsgNewMazeMultiAwardSelect = {
		head = {
			cmd = "kCSMsgNewMazeMultiAwardSelect"
		},
		["csp.newmaze_multi_award_select_c"] = {}
	},
	kCSMsgNewMazeLayerNextReq = {
		head = {
			cmd = "kCSMsgNewMazeLayerNextReq"
		},
		["csp.newmaze_layer_next_c"] = {}
	},
	kCSMsgNewMazeFormationUpdate = {
		head = {
			cmd = "kCSMsgNewMazeFormationUpdate"
		},
		["csp.newmaze_formation_update_c"] = {}
	},
	kCSMsgNewMazeBattleLoseExit = {
		head = {
			cmd = "kCSMsgNewMazeBattleLoseExit"
		},
		["csp.newmaze_battle_lose_exit_c"] = {}
	},
	kCSMsgNewMazeLevelExit = {
		head = {
			cmd = "kCSMsgNewMazeLevelExit"
		},
		["csp.newmaze_level_exit_c"] = {}
	},
	kCSMsgNewMazeRandPoolCheck = {
		head = {
			cmd = "kCSMsgNewMazeRandPoolCheck"
		},
		["csp.newmaze_randpool_check_c"] = {}
	},
	kCSMsgNewMazeShopRefresh = {
		head = {
			cmd = "kCSMsgNewMazeShopRefresh"
		},
		["csp.newmaze_shop_refresh_c"] = {}
	},
	kCSMsgNewMazeShopPurchase = {
		head = {
			cmd = "kCSMsgNewMazeShopPurchase"
		},
		["csp.newmaze_shop_purchase_c"] = {}
	},
	kCSMsgNewMazeShopSell = {
		head = {
			cmd = "kCSMsgNewMazeShopSell"
		},
		["csp.newmaze_shop_sell_c"] = {}
	},
	kCSMsgNewMazeRandomEventSelect = {
		head = {
			cmd = "kCSMsgNewMazeRandomEventSelect"
		},
		["csp.newmaze_random_event_select_c"] = {}
	},
	kCSMsgNewMazeRandomEventOptionSelect = {
		head = {
			cmd = "kCSMsgNewMazeRandomEventOptionSelect"
		},
		["csp.newmaze_random_event_option_select_c"] = {}
	},
	kCSMsgNewMazeFeatureUse = {
		head = {
			cmd = "kCSMsgNewMazeFeatureUse"
		},
		["csp.newmaze_feature_use_c"] = {}
	},
	kCSMsgNewMazeSetOutsideRelic = {
		head = {
			cmd = "kCSMsgNewMazeSetOutsideRelic"
		},
		["csp.newmaze_set_outside_relic_c"] = {}
	},
	kCSMsgNewMazeModifyInherit = {
		head = {
			cmd = "kCSMsgNewMazeModifyInherit"
		},
		["csp.newmaze_modify_inherit_c"] = {}
	},
	kCSMsgNewMazeSelectInherit = {
		head = {
			cmd = "kCSMsgNewMazeSelectInherit"
		},
		["csp.newmaze_select_inherit_c"] = {}
	},
	kCSMsgNewMazeEnchanterUse = {
		head = {
			cmd = "kCSMsgNewMazeEnchanterUse"
		},
		["csp.newmaze_enchanter_use_c"] = {}
	},
	kCSMsgNewMazeTalentSet = {
		head = {
			cmd = "kCSMsgNewMazeTalentSet"
		},
		["csp.newmaze_talent_set_c"] = {}
	},
	kCSMsgPetPossess = {
		head = {
			cmd = "kCSMsgPetPossess"
		},
		["csp.pet_possess_c"] = {}
	},
	kCSMsgPetPossessReplace = {
		head = {
			cmd = "kCSMsgPetPossessReplace"
		},
		["csp.pet_possess_replace_c"] = {}
	},
	kCSMsgPetDevelopIntelligence = {
		head = {
			cmd = "kCSMsgPetDevelopIntelligence"
		},
		["csp.pet_develop_intelligence_c"] = {}
	},
	kCSMsgPetChooseIntelligence = {
		head = {
			cmd = "kCSMsgPetChooseIntelligence"
		},
		["csp.pet_choose_intelligence_c"] = {}
	},
	kCSMsgPetDevelopGift = {
		head = {
			cmd = "kCSMsgPetDevelopGift"
		},
		["csp.pet_develop_gift_c"] = {}
	},
	kCSMsgPetChooseGift = {
		head = {
			cmd = "kCSMsgPetChooseGift"
		},
		["csp.pet_choose_gift_c"] = {}
	},
	kCSMsgPetDegreeLevelUp = {
		head = {
			cmd = "kCSMsgPetDegreeLevelUp"
		},
		["csp.pet_degree_level_up_c"] = {}
	},
	kCSMsgPetDegreeRuneActive = {
		head = {
			cmd = "kCSMsgPetDegreeRuneActive"
		},
		["csp.pet_degree_rune_active_c"] = {}
	},
	kCSMsgPetStarUp = {
		head = {
			cmd = "kCSMsgPetStarUp"
		},
		["csp.pet_starup_c"] = {}
	},
	kCSMsgPetRecycle = {
		head = {
			cmd = "kCSMsgPetRecycle"
		},
		["csp.pet_recycle_c"] = {}
	},
	kCSMsgPetExchange = {
		head = {
			cmd = "kCSMsgPetExchange"
		},
		["csp.pet_exchange_c"] = {}
	},
	kCSMsgPetRuneActive = {
		head = {
			cmd = "kCSMsgPetRuneActive"
		},
		["csp.pet_rune_active_c"] = {}
	},
	kCSMsgPetGemLevelUp = {
		head = {
			cmd = "kCSMsgPetGemLevelUp"
		},
		["csp.pet_gem_levelup_c"] = {}
	},
	kCSMsgPetGemRerandAttribute = {
		head = {
			cmd = "kCSMsgPetGemRerandAttribute"
		},
		["csp.pet_gem_rerand_attribute_c"] = {}
	},
	kCSMsgPetGemInset = {
		head = {
			cmd = "kCSMsgPetGemInset"
		},
		["csp.pet_gem_inset_c"] = {}
	},
	kCSMsgPetAmuletSet = {
		head = {
			cmd = "kCSMsgPetAmuletSet"
		},
		["csp.pet_amulet_set_c"] = {}
	},
	kCSMsgPetAmuletStarUp = {
		head = {
			cmd = "kCSMsgPetAmuletStarUp"
		},
		["csp.pet_amulet_starup_c"] = {}
	},
	kCSMsgPetRuneUp = {
		head = {
			cmd = "kCSMsgPetRuneUp"
		},
		["csp.pet_rune_up_c"] = {}
	},
	kCSMsgPetRuneHeroBind = {
		head = {
			cmd = "kCSMsgPetRuneHeroBind"
		},
		["csp.pet_rune_hero_bind_c"] = {}
	},
	kCSMsgPetGemSaveAttribute = {
		head = {
			cmd = "kCSMsgPetGemSaveAttribute"
		},
		["csp.pet_gem_save_attribute_c"] = {}
	},
	kCSMsgPetOffWears = {
		head = {
			cmd = "kCSMsgPetOffWears"
		},
		["csp.pet_off_wears_c"] = {}
	},
	kCSMsgMysteryShopEnter = {
		head = {
			cmd = "kCSMsgMysteryShopEnter"
		},
		["csp.mystery_shop_enter_c"] = {}
	},
	kCSMsgMysteryShopExit = {
		head = {
			cmd = "kCSMsgMysteryShopExit"
		},
		["csp.mystery_shop_exit_c"] = {}
	},
	kCSMsgBPPvpGroupEnterRoom = {
		head = {
			cmd = "kCSMsgBPPvpGroupEnterRoom"
		},
		["csp.bppvp_group_enter_room_c"] = {}
	},
	kCSMsgBPPvpGroupDetailGet = {
		head = {
			cmd = "kCSMsgBPPvpGroupDetailGet"
		},
		["csp.bppvp_detail_get_c"] = {}
	},
	kCSMsgBPPvpGroupReportGet = {
		head = {
			cmd = "kCSMsgBPPvpGroupReportGet"
		},
		["csp.bppvp_report_get_c"] = {}
	},
	kCSMsgBPPvpKnockoutGetHallData = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutGetHallData"
		},
		["csp.bppvp_knockout_get_hall_data_c"] = {}
	},
	kCSMsgBPPvpKnockoutEnterRoom = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutEnterRoom"
		},
		["csp.bppvp_knockout_enter_room_c"] = {}
	},
	kCSMsgBPPvpKnockoutSetBPPool = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutSetBPPool"
		},
		["csp.bppvp_knockout_set_bppool_c"] = {}
	},
	kCSMsgBPPvpKnockoutBP = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutBP"
		},
		["csp.bppvp_knockout_bp_c"] = {}
	},
	kCSMsgBPPvpKnockoutFormation = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutFormation"
		},
		["csp.bppvp_knockout_formation_c"] = {}
	},
	kCSMsgBPPvpKnockoutBPPoolGet = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutBPPoolGet"
		},
		["csp.bppvp_knockout_get_bppool_c"] = {}
	},
	kCSMsgBPPvpKnockoutFormationGet = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutFormationGet"
		},
		["csp.bppvp_knockout_get_formation_c"] = {}
	},
	kCSMsgBPPvpKnockoutRoomInfoGet = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutRoomInfoGet"
		},
		["csp.bppvp_knockout_room_info_c"] = {}
	},
	kCSMsgBPPvpKnockoutReportGet = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutReportGet"
		},
		["csp.bppvp_knockout_report_get_c"] = {}
	},
	kCSMsgBPPvpKnockoutBet = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutBet"
		},
		["csp.bppvp_knockout_bet_c"] = {}
	},
	kCSMsgBPPvpKnockoutBetInfoGet = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutBetInfoGet"
		},
		["csp.bppvp_knockout_bet_info_c"] = {}
	},
	kCSMsgBPPvpKnockoutBetHistoryGet = {
		head = {
			cmd = "kCSMsgBPPvpKnockoutBetHistoryGet"
		},
		["csp.bppvp_knockout_bet_his_c"] = {}
	},
	kCSMsgBPPvpActivityStateGet = {
		head = {
			cmd = "kCSMsgBPPvpActivityStateGet"
		},
		["csp.bppvp_activity_state_get_c"] = {}
	},
	kCSMsgBPPvpKnockouotChatReq = {
		head = {
			cmd = "kCSMsgBPPvpKnockouotChatReq"
		},
		["csp.bppvp_knockout_chat_c"] = {}
	},
	kCSMsgBPPvpKnockouotBanRuleSet = {
		head = {
			cmd = "kCSMsgBPPvpKnockouotBanRuleSet"
		},
		["csp.bppvp_knockout_ban_rule_c"] = {}
	},
	kCSMsgPetMazeSaveFormation = {
		head = {
			cmd = "kCSMsgPetMazeSaveFormation"
		},
		["csp.petmaze_save_formation_c"] = {}
	},
	kCSMsgPetMazeSaveSupportFormation = {
		head = {
			cmd = "kCSMsgPetMazeSaveSupportFormation"
		},
		["csp.petmaze_save_support_formation_c"] = {}
	},
	kCSMsgPetMazeReset = {
		head = {
			cmd = "kCSMsgPetMazeReset"
		},
		["csp.petmaze_reset_c"] = {}
	},
	kCSMsgPetMazeGetStepAward = {
		head = {
			cmd = "kCSMsgPetMazeGetStepAward"
		},
		["csp.petmaze_get_step_award_c"] = {}
	},
	kCSMsgPetMazeSweep = {
		head = {
			cmd = "kCSMsgPetMazeSweep"
		},
		["csp.petmaze_sweep_c"] = {}
	},
	kCSMsgNewPveChooseLevel = {
		head = {
			cmd = "kCSMsgNewPveChooseLevel"
		},
		["csp.newpve_choose_level_c"] = {}
	},
	kCSMsgNewPveChooseLimits = {
		head = {
			cmd = "kCSMsgNewPveChooseLimits"
		},
		["csp.newpve_choose_limits_c"] = {}
	},
	kCSMsgNewPveReset = {
		head = {
			cmd = "kCSMsgNewPveReset"
		},
		["csp.newpve_reset_c"] = {}
	},
	kCSMsgNewPveSaveFormation = {
		head = {
			cmd = "kCSMsgNewPveSaveFormation"
		},
		["csp.newpve_save_formation_c"] = {}
	},
	kCSMsgNewPveGetAward = {
		head = {
			cmd = "kCSMsgNewPveGetAward"
		},
		["csp.newpve_get_award_c"] = {}
	},
	kCSMsgNewPveGetFormation = {
		head = {
			cmd = "kCSMsgNewPveGetFormation"
		},
		["csp.newpve_get_formation_c"] = {}
	},
	kCSMsgNewPveGetCurFormation = {
		head = {
			cmd = "kCSMsgNewPveGetCurFormation"
		},
		["csp.newpve_get_cur_formation_c"] = {}
	},
	kCSMsgNewPveWearRelic = {
		head = {
			cmd = "kCSMsgNewPveWearRelic"
		},
		["csp.newpve_wear_relic_c"] = {}
	},
	kCSMsgNewPveResetProgress = {
		head = {
			cmd = "kCSMsgNewPveResetProgress"
		},
		["csp.newpve_reset_progress_c"] = {}
	},
	kCSMsgNewPveResetStage = {
		head = {
			cmd = "kCSMsgNewPveResetStage"
		},
		["csp.newpve_reset_stage_c"] = {}
	},
	kCSMsgNewPvePopUp = {
		head = {
			cmd = "kCSMsgNewPvePopUp"
		},
		["csp.newpve_pop_up_c"] = {}
	},
	kCSMsgRelaxingGamePass = {
		head = {
			cmd = "kCSMsgRelaxingGamePass"
		},
		["csp.relaxing_game_pass_c"] = {}
	},
	kCSMsgRelaxingGameGetBigAward = {
		head = {
			cmd = "kCSMsgRelaxingGameGetBigAward"
		},
		["csp.relaxing_game_get_big_award_c"] = {}
	},
	kCSMsgRelaxingGameChooseFirstGame = {
		head = {
			cmd = "kCSMsgRelaxingGameChooseFirstGame"
		},
		["csp.relaxing_game_choose_first_game_c"] = {}
	},
	kCSMsgFormationRecommendRankGet = {
		head = {
			cmd = "kCSMsgFormationRecommendRankGet"
		},
		["csp.formation_recommend_rank_get_c"] = {}
	},
	kCSMsgMasterApprenticeAdd = {
		head = {
			cmd = "kCSMsgMasterApprenticeAdd"
		},
		["csp.master_apprentice_add_c"] = {}
	},
	kCSMsgMasterApprenticeDel = {
		head = {
			cmd = "kCSMsgMasterApprenticeDel"
		},
		["csp.master_apprentice_del_c"] = {}
	},
	kCSMsgMasterApprenticeGraduation = {
		head = {
			cmd = "kCSMsgMasterApprenticeGraduation"
		},
		["csp.master_apprentice_graduation_c"] = {}
	},
	kCSMsgMasterApprenticeInviteOp = {
		head = {
			cmd = "kCSMsgMasterApprenticeInviteOp"
		},
		["csp.master_apprentice_invite_op_c"] = {}
	},
	kCSMsgMasterApprenticeSearch = {
		head = {
			cmd = "kCSMsgMasterApprenticeSearch"
		},
		["csp.master_apprentice_search_c"] = {}
	},
	kCSMsgMasterApprenticeRecommend = {
		head = {
			cmd = "kCSMsgMasterApprenticeRecommend"
		},
		["csp.master_apprentice_recommend_c"] = {}
	},
	kCSMsgMasterApprenticeEnroll = {
		head = {
			cmd = "kCSMsgMasterApprenticeEnroll"
		},
		["csp.master_apprentice_enroll_c"] = {}
	},
	kCSMsgMasterApprenticeQualificationUpdate = {
		head = {
			cmd = "kCSMsgMasterApprenticeQualificationUpdate"
		},
		["csp.master_apprentice_qualification_update_c"] = {}
	},
	kCSMsgMasterApprenticeGetTaskAward = {
		head = {
			cmd = "kCSMsgMasterApprenticeGetTaskAward"
		},
		["csp.master_apprentice_get_task_award_c"] = {}
	},
	kCSMsgMasterGetLevelAward = {
		head = {
			cmd = "kCSMsgMasterGetLevelAward"
		},
		["csp.master_get_level_award_c"] = {}
	},
	kCSMsgApprenticeRequestDevelopGuide = {
		head = {
			cmd = "kCSMsgApprenticeRequestDevelopGuide"
		},
		["csp.apprentice_request_develop_guide_c"] = {}
	},
	kCSMsgMasterSetDevelopGuide = {
		head = {
			cmd = "kCSMsgMasterSetDevelopGuide"
		},
		["csp.master_set_develop_guide_c"] = {}
	},
	kCSMsgMasterGetApprenticeAllHero = {
		head = {
			cmd = "kCSMsgMasterGetApprenticeAllHero"
		},
		["csp.master_get_apprentice_all_hero_c"] = {}
	},
	kCSMsgApprenticeRequestBattleGuide = {
		head = {
			cmd = "kCSMsgApprenticeRequestBattleGuide"
		},
		["csp.apprentice_request_battle_guide_c"] = {}
	},
	kCSMsgMasterSetBattleGuide = {
		head = {
			cmd = "kCSMsgMasterSetBattleGuide"
		},
		["csp.master_set_battle_guide_c"] = {}
	},
	kCSMsgMasterOpenDevelopGuide = {
		head = {
			cmd = "kCSMsgMasterOpenDevelopGuide"
		},
		["csp.master_open_develop_guide_c"] = {}
	},
	kCSMsgApprenticeAddRentCnt = {
		head = {
			cmd = "kCSMsgApprenticeAddRentCnt"
		},
		["csp.apprentice_add_rent_cnt_c"] = {}
	},
	kCSMsgApprenticeAddGuideCnt = {
		head = {
			cmd = "kCSMsgApprenticeAddGuideCnt"
		},
		["csp.apprentice_add_guide_cnt_c"] = {}
	},
	kCSMsgMasterClientUpdateProgress = {
		head = {
			cmd = "kCSMsgMasterClientUpdateProgress"
		},
		["csp.master_client_update_progress_c"] = {}
	},
	kCSMsgItemSell = {
		head = {
			cmd = "kCSMsgItemSell"
		},
		["csp.item_sell_c"] = {}
	},
	kCSMsgItemUse = {
		head = {
			cmd = "kCSMsgItemUse"
		},
		["csp.item_use_c"] = {}
	},
	kCSMsgItemCompound = {
		head = {
			cmd = "kCSMsgItemCompound"
		},
		["csp.item_compound_c"] = {}
	},
	kCSMsgHeroLevelUp = {
		head = {
			cmd = "kCSMsgHeroLevelUp"
		},
		["csp.hero_level_up_c"] = {}
	},
	kCSMsgHeroStepUp = {
		head = {
			cmd = "kCSMsgHeroStepUp"
		},
		["csp.hero_step_up_c"] = {}
	},
	kCSMsgHeroStarUp = {
		head = {
			cmd = "kCSMsgHeroStarUp"
		},
		["csp.hero_star_up_c"] = {}
	},
	kCSMsgHeroRecycle = {
		head = {
			cmd = "kCSMsgHeroRecycle"
		},
		["csp.hero_recycle_c"] = {}
	},
	kCSMsgHeroRecharge = {
		head = {
			cmd = "kCSMsgHeroRecharge"
		},
		["csp.hero_recharge_c"] = {}
	},
	kCSMsgHeroReset = {
		head = {
			cmd = "kCSMsgHeroReset"
		},
		["csp.hero_reset_c"] = {}
	},
	kCSMsgHeroLevelReset = {
		head = {
			cmd = "kCSMsgHeroLevelReset"
		},
		["csp.hero_level_reset_c"] = {}
	},
	kCSMsgHeroStepReset = {
		head = {
			cmd = "kCSMsgHeroStepReset"
		},
		["csp.hero_step_reset_c"] = {}
	},
	kCSMsgHeroLock = {
		head = {
			cmd = "kCSMsgHeroLock"
		},
		["csp.hero_lock_c"] = {}
	},
	kCSMsgHeroUnlock = {
		head = {
			cmd = "kCSMsgHeroUnlock"
		},
		["csp.hero_unlock_c"] = {}
	},
	kCSMsgHeroStarUpBatch = {
		head = {
			cmd = "kCSMsgHeroStarUpBatch"
		},
		["csp.hero_star_up_batch_c"] = {}
	},
	kCSMsgHeroExchange = {
		head = {
			cmd = "kCSMsgHeroExchange"
		},
		["csp.hero_exchange_c"] = {}
	},
	kCSMsgHeroOffWears = {
		head = {
			cmd = "kCSMsgHeroOffWears"
		},
		["csp.hero_off_wears_c"] = {}
	},
	kCSMsgHeroStarBack = {
		head = {
			cmd = "kCSMsgHeroStarBack"
		},
		["csp.hero_star_back_c"] = {}
	},
	kCSMsgHeroPaint = {
		head = {
			cmd = "kCSMsgHeroPaint"
		},
		["csp.hero_paint_c"] = {}
	},
	kCSMsgHeroPaintAbility = {
		head = {
			cmd = "kCSMsgHeroPaintAbility"
		},
		["csp.hero_paint_ability_c"] = {}
	},
	kCSMsgHeroDevelop = {
		head = {
			cmd = "kCSMsgHeroDevelop"
		},
		["csp.hero_develop_c"] = {}
	},
	kCSMsgHeroDevelopUpdateRedPoint = {
		head = {
			cmd = "kCSMsgHeroDevelopUpdateRedPoint"
		},
		["csp.hero_develop_open_c"] = {}
	},
	kCSMsgHeroPaintItemConvert = {
		head = {
			cmd = "kCSMsgHeroPaintItemConvert"
		},
		["csp.hero_paint_item_convert_c"] = {}
	},
	kCSMsgHeroCrystalStoryUnlock = {
		head = {
			cmd = "kCSMsgHeroCrystalStoryUnlock"
		},
		["csp.hero_crystal_story_unlock_c"] = {}
	},
	kCSMsgHeroPaintRelateUnlock = {
		head = {
			cmd = "kCSMsgHeroPaintRelateUnlock"
		},
		["csp.hero_paint_relate_unlock_c"] = {}
	},
	kCSMsgHeroNewPaint = {
		head = {
			cmd = "kCSMsgHeroNewPaint"
		},
		["csp.hero_new_paint_c"] = {}
	},
	kCSMsgEquipSchemeUpdate = {
		head = {
			cmd = "kCSMsgEquipSchemeUpdate"
		},
		["csp.equip_scheme_update_c"] = {}
	},
	kCSMsgEquipSchemeApply = {
		head = {
			cmd = "kCSMsgEquipSchemeApply"
		},
		["csp.equip_scheme_apply_c"] = {}
	},
	kCSMsgEquipSchemeRename = {
		head = {
			cmd = "kCSMsgEquipSchemeRename"
		},
		["csp.equip_scheme_rename_c"] = {}
	},
	kCSMsgEquipSchemeDelete = {
		head = {
			cmd = "kCSMsgEquipSchemeDelete"
		},
		["csp.equip_scheme_delete_c"] = {}
	},
	kCSMsgEquipTeamWear = {
		head = {
			cmd = "kCSMsgEquipTeamWear"
		},
		["csp.equip_team_wear_c"] = {}
	},
	kCSMsgHeartBeat = {
		head = {
			cmd = "kCSMsgHeartBeat"
		},
		["csp.heart_beat_c"] = {}
	},
	kCSMsgNetDelay = {
		head = {
			cmd = "kCSMsgNetDelay"
		},
		["csp.net_delay_c"] = {}
	},
	kCSMsgChatHeartBeat = {
		head = {
			cmd = "kCSMsgChatHeartBeat"
		},
		["csp.chat_heartbeat_c"] = {}
	},
	kCSMsgChatChannelList = {
		head = {
			cmd = "kCSMsgChatChannelList"
		},
		["csp.chat_channel_c"] = {}
	},
	kCSMsgZChatRegister = {
		head = {
			cmd = "kCSMsgZChatRegister"
		},
		["csp.zchat_register_c"] = {}
	},
	kCSMsgZChatSend = {
		head = {
			cmd = "kCSMsgZChatSend"
		},
		["csp.zchat_send_c"] = {}
	},
	kCSMsgChatPull = {
		head = {
			cmd = "kCSMsgChatPull"
		},
		["csp.chat_pull_c"] = {}
	},
	kCSMsgZChatReport = {
		head = {
			cmd = "kCSMsgZChatReport"
		},
		["csp.zchat_report_c"] = {}
	},
	kCSMsgWChatRegister = {
		head = {
			cmd = "kCSMsgWChatRegister"
		},
		["csp.chat_register_c"] = {}
	},
	kCSMsgWChatChannelChange = {
		head = {
			cmd = "kCSMsgWChatChannelChange"
		},
		["csp.chat_channel_change_c"] = {}
	}
}

RPC.SEND_TIME_INTERVAL = 1
RPC.SEND_TIME_MAX = 15
RPC.SendTimePackConfig = {}
RPC.SendTimes = {}

function RPC.SendPacksInLimit(msgID)
	if RPC.SendTimePackConfig[msgID] then
		local respMsgID = RPC.SendTimePackConfig[msgID]

		if RPC.SendTimes[respMsgID] then
			local passedTime = os.time() - RPC.SendTimes[respMsgID]

			if passedTime > RPC.SEND_TIME_INTERVAL and passedTime < RPC.SEND_TIME_MAX then
				return true
			end
		end

		RPC.SendTimes[respMsgID] = os.time()
	end
end

function RPC._packAndSend(clientPkg)
	if RPC.SendPacksInLimit(clientPkg.head.cmd) then
		return
	end

	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_SEND, clientPkg)

	local connect = RPC._getConnectHandleByCmd(clientPkg.head.cmd)

	if connect == nil then
		return
	end

	if connect >= 0 then
		local buffer = protobuf.encode("csp.ClientPkg", clientPkg)

		tfcapi.sendMsg(connect, buffer, string.len(buffer))
	end
end

function RPC.roleLeaveLoginQueue()
	local clientPkg = protoFrameCache.kCSMsgRoleLeaveLoginQueue
	local specEntry = clientPkg["csp.role_leave_login_queue_req"]

	RPC._packAndSend(clientPkg)
end

function RPC.roleLogin()
	local clientPkg = protoFrameCache.kCSMsgRoleLogin
	local specEntry = clientPkg["csp.role_login_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.roleRandName(gender)
	local clientPkg = protoFrameCache.kCSMsgRoleRandName
	local specEntry = clientPkg["csp.role_rand_name_c"]

	specEntry.gender = gender

	RPC._packAndSend(clientPkg)
end

function RPC.roleRename(name, type)
	local clientPkg = protoFrameCache.kCSMsgRoleRename
	local specEntry = clientPkg["csp.role_rename_c"]

	specEntry.name = name
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.roleCreate(name, gender)
	local clientPkg = protoFrameCache.kCSMsgRoleCreate
	local specEntry = clientPkg["csp.role_create_c"]

	specEntry.name = name
	specEntry.gender = gender

	RPC._packAndSend(clientPkg)
end

function RPC.roleInfo(name, gender, head)
	local clientPkg = protoFrameCache.kCSMsgRoleInfo
	local specEntry = clientPkg["csp.role_info_c"]

	specEntry.name = name
	specEntry.gender = gender
	specEntry.head = head

	RPC._packAndSend(clientPkg)
end

function RPC.roleLogout()
	local clientPkg = protoFrameCache.kCSMsgRoleLogout
	local specEntry = clientPkg["csp.role_logout_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.executeGM(gmstr, server)
	local clientPkg = protoFrameCache.kCSMsgExecuteGM
	local specEntry = clientPkg["csp.gm_c"]

	specEntry.gmstr = gmstr
	specEntry.server = server

	RPC._packAndSend(clientPkg)
end

function RPC.mailUpdate(read, del)
	local clientPkg = protoFrameCache.kCSMsgMailUpdate
	local specEntry = clientPkg["csp.mail_update_c"]

	specEntry.read = read
	specEntry.del = del

	RPC._packAndSend(clientPkg)
end

function RPC.mailGetAttach(mailid)
	local clientPkg = protoFrameCache.kCSMsgMailGetAttach
	local specEntry = clientPkg["csp.mail_get_attach_c"]

	specEntry.mailid = mailid

	RPC._packAndSend(clientPkg)
end

function RPC.mailReport(reason, uid, name, content)
	local clientPkg = protoFrameCache.kCSMsgMailReport
	local specEntry = clientPkg["csp.mail_report_c"]

	specEntry.reason = reason
	specEntry.uid = uid
	specEntry.name = name
	specEntry.content = content

	RPC._packAndSend(clientPkg)
end

function RPC.buddyAdd(uid)
	local clientPkg = protoFrameCache.kCSMsgBuddyAdd
	local specEntry = clientPkg["csp.buddy_add_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.buddyDel(uid)
	local clientPkg = protoFrameCache.kCSMsgBuddyDel
	local specEntry = clientPkg["csp.buddy_del_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.buddyInviteOp(uid, optype)
	local clientPkg = protoFrameCache.kCSMsgBuddyInviteOp
	local specEntry = clientPkg["csp.buddy_invite_op_c"]

	specEntry.uid = uid
	specEntry.optype = optype

	RPC._packAndSend(clientPkg)
end

function RPC.buddySearch(type, search_name, obj_gid)
	local clientPkg = protoFrameCache.kCSMsgBuddySearch
	local specEntry = clientPkg["csp.buddy_search_c"]

	specEntry.type = type
	specEntry.search_name = search_name
	specEntry.obj_gid = obj_gid

	RPC._packAndSend(clientPkg)
end

function RPC.buddyBlackListAdd(uid)
	local clientPkg = protoFrameCache.kCSMsgBuddyBlackListAdd
	local specEntry = clientPkg["csp.buddy_black_add_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.buddyBlackListDel(uid)
	local clientPkg = protoFrameCache.kCSMsgBuddyBlackListDel
	local specEntry = clientPkg["csp.buddy_black_del_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.buddyRecommend()
	local clientPkg = protoFrameCache.kCSMsgBuddyRecommend
	local specEntry = clientPkg["csp.buddy_recommend_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.buddyGiftOp(get_uids, give_uids)
	local clientPkg = protoFrameCache.kCSMsgBuddyGiftOp
	local specEntry = clientPkg["csp.buddy_gift_op_c"]

	specEntry.get_uids = get_uids
	specEntry.give_uids = give_uids

	RPC._packAndSend(clientPkg)
end

function RPC.buddyOnline(status)
	local clientPkg = protoFrameCache.kCSMsgBuddyOnline
	local specEntry = clientPkg["csp.buddy_online_c"]

	specEntry.status = status

	RPC._packAndSend(clientPkg)
end

function RPC.buddyBondSet(uid, bond)
	local clientPkg = protoFrameCache.kCSMsgBuddyBondSet
	local specEntry = clientPkg["csp.buddy_bond_set_c"]

	specEntry.uid = uid
	specEntry.bond = bond

	RPC._packAndSend(clientPkg)
end

function RPC.opActivityData(datatype, isall, activity_id)
	local clientPkg = protoFrameCache.kCSMsgOpActivityData
	local specEntry = clientPkg["csp.opactivity_data_c"]

	specEntry.datatype = datatype
	specEntry.isall = isall
	specEntry.activity_id = activity_id

	RPC._packAndSend(clientPkg)
end

function RPC.gagGSSetGag(type, hour, uid)
	local clientPkg = protoFrameCache.kCSMsgGagGSSetGag
	local specEntry = clientPkg["csp.gag_gs_set_gag_c"]

	specEntry.type = type
	specEntry.hour = hour
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.opActGetAward(act_id, index, param)
	local clientPkg = protoFrameCache.kCSMsgOpActGetAward
	local specEntry = clientPkg["csp.opact_get_award_c"]

	specEntry.act_id = act_id
	specEntry.index = index
	specEntry.param = param

	RPC._packAndSend(clientPkg)
end

function RPC.monopolyRoll(activity_id, type, point)
	local clientPkg = protoFrameCache.kCSMsgMonopolyRoll
	local specEntry = clientPkg["csp.monopoly_roll_c"]

	specEntry.activity_id = activity_id
	specEntry.type = type
	specEntry.point = point

	RPC._packAndSend(clientPkg)
end

function RPC.monopolyExchange(activity_id, type, count)
	local clientPkg = protoFrameCache.kCSMsgMonopolyExchange
	local specEntry = clientPkg["csp.monopoly_exchange_c"]

	specEntry.activity_id = activity_id
	specEntry.type = type
	specEntry.count = count

	RPC._packAndSend(clientPkg)
end

function RPC.opActDepositRefresh(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActDepositRefresh
	local specEntry = clientPkg["csp.opact_deposit_refresh_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActDepositGetAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActDepositGetAward
	local specEntry = clientPkg["csp.opact_deposit_get_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActPlotPassCurStage(act_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpActPlotPassCurStage
	local specEntry = clientPkg["csp.opact_plot_pass_cur_stage_c"]

	specEntry.act_id = act_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActPlotGetAchieveAward(act_id, achieve_id)
	local clientPkg = protoFrameCache.kCSMsgOpActPlotGetAchieveAward
	local specEntry = clientPkg["csp.opact_plot_get_achieve_award_c"]

	specEntry.act_id = act_id
	specEntry.achieve_id = achieve_id

	RPC._packAndSend(clientPkg)
end

function RPC.bingoDraw(activity_id, index, item_type, item_num)
	local clientPkg = protoFrameCache.kCSMsgBingoDraw
	local specEntry = clientPkg["csp.bingo_draw_c"]

	specEntry.activity_id = activity_id
	specEntry.index = index
	specEntry.item_type = item_type
	specEntry.item_num = item_num

	RPC._packAndSend(clientPkg)
end

function RPC.bingoSetBigReward(activity_id, reward_id)
	local clientPkg = protoFrameCache.kCSMsgBingoSetBigReward
	local specEntry = clientPkg["csp.bingo_set_big_reward_c"]

	specEntry.activity_id = activity_id
	specEntry.reward_id = reward_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActDraw(act_id, count, cost_type, total_count)
	local clientPkg = protoFrameCache.kCSMsgOpActDraw
	local specEntry = clientPkg["csp.opact_draw_c"]

	specEntry.act_id = act_id
	specEntry.count = count
	specEntry.cost_type = cost_type
	specEntry.total_count = total_count

	RPC._packAndSend(clientPkg)
end

function RPC.opActSetFocus(act_id, miss_focus)
	local clientPkg = protoFrameCache.kCSMsgOpActSetFocus
	local specEntry = clientPkg["csp.opact_set_focus_c"]

	specEntry.act_id = act_id
	specEntry.miss_focus = miss_focus

	RPC._packAndSend(clientPkg)
end

function RPC.opActShopRefresh(act_id, cur_round)
	local clientPkg = protoFrameCache.kCSMsgOpActShopRefresh
	local specEntry = clientPkg["csp.opact_shop_refresh_c"]

	specEntry.act_id = act_id
	specEntry.cur_round = cur_round

	RPC._packAndSend(clientPkg)
end

function RPC.opActAchieveFinalAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActAchieveFinalAward
	local specEntry = clientPkg["csp.opact_achieve_final_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActPlotSweep(act_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpActPlotSweep
	local specEntry = clientPkg["csp.opact_plot_sweep_stage_c"]

	specEntry.act_id = act_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActPlotGetRank(act_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpActPlotGetRank
	local specEntry = clientPkg["csp.opact_plot_get_rank_c"]

	specEntry.act_id = act_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActLotteryGetRank(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActLotteryGetRank
	local specEntry = clientPkg["csp.opact_lottery_get_rank_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActShopLevelUp(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgOpActShopLevelUp
	local specEntry = clientPkg["csp.opact_shop_level_up_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawReplaceSetDisable(act_id, disable, lib_id)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawReplaceSetDisable
	local specEntry = clientPkg["csp.opact_draw_replace_disable"]

	specEntry.act_id = act_id
	specEntry.disable = disable
	specEntry.lib_id = lib_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactWishChoose(act_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpactWishChoose
	local specEntry = clientPkg["csp.opact_wish_choose_c"]

	specEntry.act_id = act_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opactWishGetAward(act_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpactWishGetAward
	local specEntry = clientPkg["csp.opact_wish_get_award_c"]

	specEntry.act_id = act_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opactFirePlaceGetAward(act_id, sock_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpactFirePlaceGetAward
	local specEntry = clientPkg["csp.opact_fire_place_c"]

	specEntry.act_id = act_id
	specEntry.sock_id = sock_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawReplaceChangeIndex(act_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawReplaceChangeIndex
	local specEntry = clientPkg["csp.opact_draw_replace_change_index"]

	specEntry.act_id = act_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActOnHookRoleFirstIn(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActOnHookRoleFirstIn
	local specEntry = clientPkg["csp.opact_onhook_first_in"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActOnHookRoleOnCook(act_id, item_index, food_id)
	local clientPkg = protoFrameCache.kCSMsgOpActOnHookRoleOnCook
	local specEntry = clientPkg["csp.opact_onhook_on_cook"]

	specEntry.act_id = act_id
	specEntry.item_index = item_index
	specEntry.food_id = food_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActOnHookRoleDeliver(act_id, item_index)
	local clientPkg = protoFrameCache.kCSMsgOpActOnHookRoleDeliver
	local specEntry = clientPkg["csp.opact_onhook_deliver"]

	specEntry.act_id = act_id
	specEntry.item_index = item_index

	RPC._packAndSend(clientPkg)
end

function RPC.opActOnHookRoleCancelCook(act_id, item_index)
	local clientPkg = protoFrameCache.kCSMsgOpActOnHookRoleCancelCook
	local specEntry = clientPkg["csp.opact_onhook_cancal_cook"]

	specEntry.act_id = act_id
	specEntry.item_index = item_index

	RPC._packAndSend(clientPkg)
end

function RPC.opActOnHookRoleSpeedUp(act_id, item_index, item_id)
	local clientPkg = protoFrameCache.kCSMsgOpActOnHookRoleSpeedUp
	local specEntry = clientPkg["csp.opact_onhook_speed_up"]

	specEntry.act_id = act_id
	specEntry.item_index = item_index
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawGetShareAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawGetShareAward
	local specEntry = clientPkg["csp.opact_draw_get_share_award"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawReplaceShareAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawReplaceShareAward
	local specEntry = clientPkg["csp.opact_draw_replace_share_award"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActHatsuneGetNodeAward(act_id, node_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpActHatsuneGetNodeAward
	local specEntry = clientPkg["csp.opact_hatsune_get_node_award"]

	specEntry.act_id = act_id
	specEntry.node_id = node_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActMonopolySetLibAward(act_id, lib_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpActMonopolySetLibAward
	local specEntry = clientPkg["csp.opact_Monopoly_set_lib_award"]

	specEntry.act_id = act_id
	specEntry.lib_id = lib_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActMonopolyUseItem(act_id, item_id)
	local clientPkg = protoFrameCache.kCSMsgOpActMonopolyUseItem
	local specEntry = clientPkg["csp.opact_Monopoly_use_item"]

	specEntry.act_id = act_id
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActClanBossDispatch(act_id, boss_id, layer, gid)
	local clientPkg = protoFrameCache.kCSMsgOpActClanBossDispatch
	local specEntry = clientPkg["csp.opact_clan_boss_dispatch_c"]

	specEntry.act_id = act_id
	specEntry.boss_id = boss_id
	specEntry.layer = layer
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.opActClanBossGetStageAward(act_id, boss_id, layer, index, round)
	local clientPkg = protoFrameCache.kCSMsgOpActClanBossGetStageAward
	local specEntry = clientPkg["csp.opact_clan_boss_get_stage_award_c"]

	specEntry.act_id = act_id
	specEntry.boss_id = boss_id
	specEntry.layer = layer
	specEntry.index = index
	specEntry.round = round

	RPC._packAndSend(clientPkg)
end

function RPC.opActClanBossGetAchieveAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActClanBossGetAchieveAward
	local specEntry = clientPkg["csp.opact_clan_boss_get_achieve_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActFlottoryDraw(act_id, count)
	local clientPkg = protoFrameCache.kCSMsgOpActFlottoryDraw
	local specEntry = clientPkg["csp.opact_flottory_draw_c"]

	specEntry.act_id = act_id
	specEntry.count = count

	RPC._packAndSend(clientPkg)
end

function RPC.opActFlottorySetSelIndex(act_id, sel_index)
	local clientPkg = protoFrameCache.kCSMsgOpActFlottorySetSelIndex
	local specEntry = clientPkg["csp.opact_flottory_set_sel_index_c"]

	specEntry.act_id = act_id
	specEntry.sel_index = sel_index

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceGetAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceGetAward
	local specEntry = clientPkg["csp.opact_cat_race_get_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceSelectTask(act_id, task_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceSelectTask
	local specEntry = clientPkg["csp.opact_cat_race_select_task_c"]

	specEntry.act_id = act_id
	specEntry.task_id = task_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceSelectFriendTask(act_id, uid)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceSelectFriendTask
	local specEntry = clientPkg["csp.opact_cat_race_select_friend_task_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceSetFriend(act_id, uid)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceSetFriend
	local specEntry = clientPkg["csp.opact_cat_race_set_frient_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceSetCatInfo(act_id, color_id, hero_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceSetCatInfo
	local specEntry = clientPkg["csp.opact_cat_race_set_cat_info_c"]

	specEntry.act_id = act_id
	specEntry.color_id = color_id
	specEntry.hero_id = hero_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceSendFriend(act_id, uid)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceSendFriend
	local specEntry = clientPkg["csp.opact_cat_race_send_friend_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceGetPublishAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceGetPublishAward
	local specEntry = clientPkg["csp.opact_cat_race_get_publish_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceGetTaskAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceGetTaskAward
	local specEntry = clientPkg["csp.opact_cat_race_get_task_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCatRaceGetFriendGift(act_id, uid)
	local clientPkg = protoFrameCache.kCSMsgOpActCatRaceGetFriendGift
	local specEntry = clientPkg["csp.opact_cat_race_get_friend_gift_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsRefreshDeposit(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsRefreshDeposit
	local specEntry = clientPkg["csp.opact_collectwords_refresh_deposit_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsGetDeposit(act_id, item_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsGetDeposit
	local specEntry = clientPkg["csp.opact_collectwords_get_deposit_c"]

	specEntry.act_id = act_id
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsRecvWord(act_id, uid, item_id, tick)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsRecvWord
	local specEntry = clientPkg["csp.opact_collectwords_recv_word_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid
	specEntry.item_id = item_id
	specEntry.tick = tick

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsGivingWord(act_id, uid, item_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsGivingWord
	local specEntry = clientPkg["csp.opact_collectwords_giving_word_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsDestroyWord(act_id, pos, item_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsDestroyWord
	local specEntry = clientPkg["csp.opact_collectwords_destroy_word_c"]

	specEntry.act_id = act_id
	specEntry.pos = pos
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsComposeWord(act_id, times)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsComposeWord
	local specEntry = clientPkg["csp.opact_collectwords_compose_word_c"]

	specEntry.act_id = act_id
	specEntry.times = times

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsGetBuddyWord(act_id, item_id)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsGetBuddyWord
	local specEntry = clientPkg["csp.opact_collectwords_get_buddy_word_c"]

	specEntry.act_id = act_id
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActCollectWordsUseItem(act_id, item_id, item_num, param)
	local clientPkg = protoFrameCache.kCSMsgOpActCollectWordsUseItem
	local specEntry = clientPkg["csp.opact_collectwords_use_item_c"]

	specEntry.act_id = act_id
	specEntry.item_id = item_id
	specEntry.item_num = item_num
	specEntry.param = param

	RPC._packAndSend(clientPkg)
end

function RPC.opActAchieveSetClientTriggerFlag(act_id, type, index)
	local clientPkg = protoFrameCache.kCSMsgOpActAchieveSetClientTriggerFlag
	local specEntry = clientPkg["csp.opact_achieve_set_client_trigger_c"]

	specEntry.act_id = act_id
	specEntry.type = type
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActAchieveExchangeItem(act_id, exchange_id, num)
	local clientPkg = protoFrameCache.kCSMsgOpActAchieveExchangeItem
	local specEntry = clientPkg["csp.opact_achieve_exchange_item_c"]

	specEntry.act_id = act_id
	specEntry.exchange_id = exchange_id
	specEntry.num = num

	RPC._packAndSend(clientPkg)
end

function RPC.opActChatGameMakeChocolete(act_id, material_num)
	local clientPkg = protoFrameCache.kCSMsgOpActChatGameMakeChocolete
	local specEntry = clientPkg["csp.opact_chatgame_make_chocolete_c"]

	specEntry.act_id = act_id
	specEntry.material_num = material_num

	RPC._packAndSend(clientPkg)
end

function RPC.opActChatGameChooseBranch(act_id, node_id)
	local clientPkg = protoFrameCache.kCSMsgOpActChatGameChooseBranch
	local specEntry = clientPkg["csp.opact_chatgame_choose_branch_c"]

	specEntry.act_id = act_id
	specEntry.node_id = node_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActChatGameChatEnd(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActChatGameChatEnd
	local specEntry = clientPkg["csp.opact_chatgame_chat_end_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActChatGameResetChat(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActChatGameResetChat
	local specEntry = clientPkg["csp.opact_chatgame_reset_chat_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActChatGameFormulaShare(act_id, gift_id)
	local clientPkg = protoFrameCache.kCSMsgOpActChatGameFormulaShare
	local specEntry = clientPkg["csp.opact_chatgame_share_formula_c"]

	specEntry.act_id = act_id
	specEntry.gift_id = gift_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActChatGameGivingGift(act_id, item_id, item_num)
	local clientPkg = protoFrameCache.kCSMsgOpActChatGameGivingGift
	local specEntry = clientPkg["csp.opact_chatgame_giving_gift_c"]

	specEntry.act_id = act_id
	specEntry.item_id = item_id
	specEntry.item_num = item_num

	RPC._packAndSend(clientPkg)
end

function RPC.opActHomeDispatch(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActHomeDispatch
	local specEntry = clientPkg["csp.opact_homedispatch_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActHomeDispatchGetAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActHomeDispatchGetAward
	local specEntry = clientPkg["csp.opact_homedispatch_get_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActHomeDispatchSpeedUp(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActHomeDispatchSpeedUp
	local specEntry = clientPkg["csp.opact_homedispatch_speed_up_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActHomeDispatchBuild(act_id, building_id)
	local clientPkg = protoFrameCache.kCSMsgOpActHomeDispatchBuild
	local specEntry = clientPkg["csp.opact_homedispatch_build_c"]

	specEntry.act_id = act_id
	specEntry.building_id = building_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActGuessChooseAnswer(act_id, stage_id, answer_id, award_id)
	local clientPkg = protoFrameCache.kCSMsgOpActGuessChooseAnswer
	local specEntry = clientPkg["csp.opact_guess_choose_answer_c"]

	specEntry.act_id = act_id
	specEntry.stage_id = stage_id
	specEntry.answer_id = answer_id
	specEntry.award_id = award_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActGuessAwardInfuse(act_id, stage_id)
	local clientPkg = protoFrameCache.kCSMsgOpActGuessAwardInfuse
	local specEntry = clientPkg["csp.opact_guess_award_infuse_c"]

	specEntry.act_id = act_id
	specEntry.stage_id = stage_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActGuessGetRank()
	local clientPkg = protoFrameCache.kCSMsgOpActGuessGetRank
	local specEntry = clientPkg["csp.opact_guess_get_rank_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.opActGuessGetTotalAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActGuessGetTotalAward
	local specEntry = clientPkg["csp.opact_guess_get_total_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActGuessWatch(act_id, stage_id)
	local clientPkg = protoFrameCache.kCSMsgOpActGuessWatch
	local specEntry = clientPkg["csp.opact_guess_watch_c"]

	specEntry.act_id = act_id
	specEntry.stage_id = stage_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActGuessIsRight(act_id, stage_id, is_right)
	local clientPkg = protoFrameCache.kCSMsgOpActGuessIsRight
	local specEntry = clientPkg["csp.opact_guess_is_right_c"]

	specEntry.act_id = act_id
	specEntry.stage_id = stage_id
	specEntry.is_right = is_right

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessMaterialProduct(act_id, privilege_type, privilege_param, is_bulk_product)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessMaterialProduct
	local specEntry = clientPkg["csp.opact_business_material_product_c"]

	specEntry.act_id = act_id
	specEntry.privilege_type = privilege_type
	specEntry.privilege_param = privilege_param
	specEntry.is_bulk_product = is_bulk_product

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessMaterialCompose(act_id, compose_info, is_bulk_compose)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessMaterialCompose
	local specEntry = clientPkg["csp.opact_business_material_compose_c"]

	specEntry.act_id = act_id
	specEntry.compose_info = compose_info
	specEntry.is_bulk_compose = is_bulk_compose

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessStaminaReceive(act_id, buddy_uid)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessStaminaReceive
	local specEntry = clientPkg["csp.opact_business_stamina_receive_c"]

	specEntry.act_id = act_id
	specEntry.buddy_uid = buddy_uid

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessStaminaDonated(act_id, buddy_uid)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessStaminaDonated
	local specEntry = clientPkg["csp.opact_business_stamina_donated_c"]

	specEntry.act_id = act_id
	specEntry.buddy_uid = buddy_uid

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessOrderCommit(act_id, order_gid, grid_pos)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessOrderCommit
	local specEntry = clientPkg["csp.opact_business_order_commit_c"]

	specEntry.act_id = act_id
	specEntry.order_gid = order_gid
	specEntry.grid_pos = grid_pos

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessOrderUpdate(act_id, order_gid)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessOrderUpdate
	local specEntry = clientPkg["csp.opact_business_order_update_c"]

	specEntry.act_id = act_id
	specEntry.order_gid = order_gid

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessMaterialUpgrade(act_id, grid_pos, privilege_type, privilege_param)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessMaterialUpgrade
	local specEntry = clientPkg["csp.opact_business_material_upgrade_c"]

	specEntry.act_id = act_id
	specEntry.grid_pos = grid_pos
	specEntry.privilege_type = privilege_type
	specEntry.privilege_param = privilege_param

	RPC._packAndSend(clientPkg)
end

function RPC.opActBusinessMaterialDelete(act_id, grid_pos)
	local clientPkg = protoFrameCache.kCSMsgOpActBusinessMaterialDelete
	local specEntry = clientPkg["csp.opact_business_material_delete_c"]

	specEntry.act_id = act_id
	specEntry.grid_pos = grid_pos

	RPC._packAndSend(clientPkg)
end

function RPC.opActTurnTableDraw(act_id, count, cost_type, total_count)
	local clientPkg = protoFrameCache.kCSMsgOpActTurnTableDraw
	local specEntry = clientPkg["csp.opact_turntable_draw_c"]

	specEntry.act_id = act_id
	specEntry.count = count
	specEntry.cost_type = cost_type
	specEntry.total_count = total_count

	RPC._packAndSend(clientPkg)
end

function RPC.giftDrawWinnersListGet(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgGiftDrawWinnersListGet
	local specEntry = clientPkg["csp.giftdraw_winner_list_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.giftDrawGiftShare(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgGiftDrawGiftShare
	local specEntry = clientPkg["csp.giftdraw_share_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipMakeChoose(act_id, type, value)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipMakeChoose
	local specEntry = clientPkg["csp.opact_equip_make_choose_c"]

	specEntry.act_id = act_id
	specEntry.type = type
	specEntry.value = value

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipMakeRand(act_id, type)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipMakeRand
	local specEntry = clientPkg["csp.opact_equip_make_rand_c"]

	specEntry.act_id = act_id
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipBaptizeChoose(act_id, equip_gid)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipBaptizeChoose
	local specEntry = clientPkg["csp.opact_equip_baptize_choose_c"]

	specEntry.act_id = act_id
	specEntry.equip_gid = equip_gid

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipBaptizeInit(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipBaptizeInit
	local specEntry = clientPkg["csp.opact_equip_baptize_init_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipBaptizeRandAttr(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipBaptizeRandAttr
	local specEntry = clientPkg["csp.opact_equip_baptize_rand_attr_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipBaptizeDone(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipBaptizeDone
	local specEntry = clientPkg["csp.opact_equip_baptize_done_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipBaptizeAttrLock(act_id, pos, type)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipBaptizeAttrLock
	local specEntry = clientPkg["csp.opact_equip_baptize_attr_lock_c"]

	specEntry.act_id = act_id
	specEntry.pos = pos
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawNewbieUpDraw(act_id, career, count, cost_type, total_count)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawNewbieUpDraw
	local specEntry = clientPkg["csp.opact_drawnewbieup_draw_c"]

	specEntry.act_id = act_id
	specEntry.career = career
	specEntry.count = count
	specEntry.cost_type = cost_type
	specEntry.total_count = total_count

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawNewbieUpNewCycle(act_id, new_cycle)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawNewbieUpNewCycle
	local specEntry = clientPkg["csp.opact_drawnewbieup_new_cycle_c"]

	specEntry.act_id = act_id
	specEntry.new_cycle = new_cycle

	RPC._packAndSend(clientPkg)
end

function RPC.opActRandReplaceSet(act_id, group_id, index)
	local clientPkg = protoFrameCache.kCSMsgOpActRandReplaceSet
	local specEntry = clientPkg["csp.opact_rand_replace_set_c"]

	specEntry.act_id = act_id
	specEntry.group_id = group_id
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawNewbieCampDraw(act_id, count, cost_type, total_count)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawNewbieCampDraw
	local specEntry = clientPkg["csp.opact_drawnewbiecamp_draw_c"]

	specEntry.act_id = act_id
	specEntry.count = count
	specEntry.cost_type = cost_type
	specEntry.total_count = total_count

	RPC._packAndSend(clientPkg)
end

function RPC.opActDrawSeasonDraw(act_id, count, cost_type, total_count)
	local clientPkg = protoFrameCache.kCSMsgOpActDrawSeasonDraw
	local specEntry = clientPkg["csp.opact_drawseason_draw_c"]

	specEntry.act_id = act_id
	specEntry.count = count
	specEntry.cost_type = cost_type
	specEntry.total_count = total_count

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipRecycleChoose(act_id, op_type, equip_gid, workshop)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipRecycleChoose
	local specEntry = clientPkg["csp.opact_equip_recycle_choose_c"]

	specEntry.act_id = act_id
	specEntry.op_type = op_type
	specEntry.equip_gid = equip_gid
	specEntry.workshop = workshop

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipRecycleStart(act_id, workshop)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipRecycleStart
	local specEntry = clientPkg["csp.opact_equip_recycle_start_c"]

	specEntry.act_id = act_id
	specEntry.workshop = workshop

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipRecycleStop(act_id, workshop, need_clear)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipRecycleStop
	local specEntry = clientPkg["csp.opact_equip_recycle_stop_c"]

	specEntry.act_id = act_id
	specEntry.workshop = workshop
	specEntry.need_clear = need_clear

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipRecycleGetAward(act_id, equip, workshop)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipRecycleGetAward
	local specEntry = clientPkg["csp.opact_equip_recycle_get_award_c"]

	specEntry.act_id = act_id
	specEntry.equip = equip
	specEntry.workshop = workshop

	RPC._packAndSend(clientPkg)
end

function RPC.opActEquipRecycleUnlockWorkShop(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActEquipRecycleUnlockWorkShop
	local specEntry = clientPkg["csp.opact_equip_recycle_unlock_workshop_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActAchieveGetAllAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActAchieveGetAllAward
	local specEntry = clientPkg["csp.opact_achieve_get_all_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.rechargeGenerateOrderID(channel_account, recharge_id, product_id, amount, first_bonus, normal_bonus, use_type, sel_id, special)
	local clientPkg = protoFrameCache.kCSMsgRechargeGenerateOrderID
	local specEntry = clientPkg["csp.recharge_generate_orderid_c"]

	specEntry.channel_account = channel_account
	specEntry.recharge_id = recharge_id
	specEntry.product_id = product_id
	specEntry.amount = amount
	specEntry.first_bonus = first_bonus
	specEntry.normal_bonus = normal_bonus
	specEntry.use_type = use_type
	specEntry.sel_id = sel_id
	specEntry.special = special

	RPC._packAndSend(clientPkg)
end

function RPC.rechargeCancelOrder(recharge_id, orderid)
	local clientPkg = protoFrameCache.kCSMsgRechargeCancelOrder
	local specEntry = clientPkg["csp.recharge_cancel_order_c"]

	specEntry.recharge_id = recharge_id
	specEntry.orderid = orderid

	RPC._packAndSend(clientPkg)
end

function RPC.rechargeListGet(rechargedata)
	local clientPkg = protoFrameCache.kCSMsgRechargeListGet
	local specEntry = clientPkg["csp.recharge_list_get_c"]

	specEntry.rechargedata = rechargedata

	RPC._packAndSend(clientPkg)
end

function RPC.rechargeGetFirstAward(level, index)
	local clientPkg = protoFrameCache.kCSMsgRechargeGetFirstAward
	local specEntry = clientPkg["csp.recharge_get_first_award_c"]

	specEntry.level = level
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.rechargeGetMulityAward(recharge_id, award_recharge_id)
	local clientPkg = protoFrameCache.kCSMsgRechargeGetMulityAward
	local specEntry = clientPkg["csp.recharge_get_mulity_award_c"]

	specEntry.recharge_id = recharge_id
	specEntry.award_recharge_id = award_recharge_id

	RPC._packAndSend(clientPkg)
end

function RPC.subscribeGetAward()
	local clientPkg = protoFrameCache.kCSMsgSubscribeGetAward
	local specEntry = clientPkg["csp.sub_data_nget_award_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.draw(type, count, cost_type, camp_type, total_count)
	local clientPkg = protoFrameCache.kCSMsgDraw
	local specEntry = clientPkg["csp.draw_c"]

	specEntry.type = type
	specEntry.count = count
	specEntry.cost_type = cost_type
	specEntry.camp_type = camp_type
	specEntry.total_count = total_count

	RPC._packAndSend(clientPkg)
end

function RPC.drawNewbie(record_index)
	local clientPkg = protoFrameCache.kCSMsgDrawNewbie
	local specEntry = clientPkg["csp.draw_newbie_c"]

	specEntry.record_index = record_index

	RPC._packAndSend(clientPkg)
end

function RPC.drawUnlockCamp()
	local clientPkg = protoFrameCache.kCSMsgDrawUnlockCamp
	local specEntry = clientPkg["csp.draw_unlock_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.drawNebieBestChange()
	local clientPkg = protoFrameCache.kCSMsgDrawNebieBestChange
	local specEntry = clientPkg["csp.draw_best_change_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.drawRecord(type, act_id, seq, param)
	local clientPkg = protoFrameCache.kCSMsgDrawRecord
	local specEntry = clientPkg["csp.draw_record_c"]

	specEntry.type = type
	specEntry.act_id = act_id
	specEntry.seq = seq
	specEntry.param = param

	RPC._packAndSend(clientPkg)
end

function RPC.drawSetDesire(desire_list)
	local clientPkg = protoFrameCache.kCSMsgDrawSetDesire
	local specEntry = clientPkg["csp.draw_set_desire_c"]

	specEntry.desire_list = desire_list

	RPC._packAndSend(clientPkg)
end

function RPC.petDrawRest()
	local clientPkg = protoFrameCache.kCSMsgPetDrawRest
	local specEntry = clientPkg["csp.pet_draw_reset_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.petDrawSelect(gashapon_id, select_item_id)
	local clientPkg = protoFrameCache.kCSMsgPetDrawSelect
	local specEntry = clientPkg["csp.pet_draw_select_c"]

	specEntry.gashapon_id = gashapon_id
	specEntry.select_item_id = select_item_id

	RPC._packAndSend(clientPkg)
end

function RPC.drawNewbieReset()
	local clientPkg = protoFrameCache.kCSMsgDrawNewbieReset
	local specEntry = clientPkg["csp.draw_newbie_reset_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.pVEStart(type, spec)
	local clientPkg = protoFrameCache.kCSMsgPVEStart
	local specEntry = clientPkg["csp.pve_start_c"]

	specEntry.type = type
	specEntry.spec = spec

	RPC._packAndSend(clientPkg)
end

function RPC.pVEFinish(type, result, common, spec, gm)
	local clientPkg = protoFrameCache.kCSMsgPVEFinish
	local specEntry = clientPkg["csp.pve_finish_c"]

	specEntry.type = type
	specEntry.result = result
	specEntry.common = common
	specEntry.spec = spec
	specEntry.gm = gm

	RPC._packAndSend(clientPkg)
end

function RPC.pVEQuit(type, reason)
	local clientPkg = protoFrameCache.kCSMsgPVEQuit
	local specEntry = clientPkg["csp.pve_quit_c"]

	specEntry.type = type
	specEntry.reason = reason

	RPC._packAndSend(clientPkg)
end

function RPC.pVEBattleReplay(battle_id, battle_type)
	local clientPkg = protoFrameCache.kCSMsgPVEBattleReplay
	local specEntry = clientPkg["csp.pve_battle_replay_c"]

	specEntry.battle_id = battle_id
	specEntry.battle_type = battle_type

	RPC._packAndSend(clientPkg)
end

function RPC.pVEShare(channel_type, msg, target_uid)
	local clientPkg = protoFrameCache.kCSMsgPVEShare
	local specEntry = clientPkg["csp.pve_battle_share_c"]

	specEntry.channel_type = channel_type
	specEntry.msg = msg
	specEntry.target_uid = target_uid

	RPC._packAndSend(clientPkg)
end

function RPC.pVEAutoBattle(type, spec)
	local clientPkg = protoFrameCache.kCSMsgPVEAutoBattle
	local specEntry = clientPkg["csp.pve_auto_battle_c"]

	specEntry.type = type
	specEntry.spec = spec

	RPC._packAndSend(clientPkg)
end

function RPC.formationUpdate(pos, item, pet)
	local clientPkg = protoFrameCache.kCSMsgFormationUpdate
	local specEntry = clientPkg["csp.formation_update_c"]

	specEntry.pos = pos
	specEntry.item = item
	specEntry.pet = pet

	RPC._packAndSend(clientPkg)
end

function RPC.formationSelect(pos)
	local clientPkg = protoFrameCache.kCSMsgFormationSelect
	local specEntry = clientPkg["csp.formation_select_c"]

	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.formationsUpdateByType(type, item)
	local clientPkg = protoFrameCache.kCSMsgFormationsUpdateByType
	local specEntry = clientPkg["csp.formation_update_by_type_c"]

	specEntry.type = type
	specEntry.item = item

	RPC._packAndSend(clientPkg)
end

function RPC.formationSnapshot(pos, snapshot)
	local clientPkg = protoFrameCache.kCSMsgFormationSnapshot
	local specEntry = clientPkg["csp.formation_snapshot_c"]

	specEntry.pos = pos
	specEntry.snapshot = snapshot

	RPC._packAndSend(clientPkg)
end

function RPC.formationSnapshotSwapIdx(pos, idx)
	local clientPkg = protoFrameCache.kCSMsgFormationSnapshotSwapIdx
	local specEntry = clientPkg["csp.formation_snapshot_swap_idx_c"]

	specEntry.pos = pos
	specEntry.idx = idx

	RPC._packAndSend(clientPkg)
end

function RPC.formationSnapshotGet(pos)
	local clientPkg = protoFrameCache.kCSMsgFormationSnapshotGet
	local specEntry = clientPkg["csp.formation_snapshot_get_c"]

	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.formationsUpdateByPos(item)
	local clientPkg = protoFrameCache.kCSMsgFormationsUpdateByPos
	local specEntry = clientPkg["csp.formation_update_by_pos_c"]

	specEntry.item = item

	RPC._packAndSend(clientPkg)
end

function RPC.stageUnlockNext()
	local clientPkg = protoFrameCache.kCSMsgStageUnlockNext
	local specEntry = clientPkg["csp.stage_unlock_next_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.stageRecord(season, chapter, level)
	local clientPkg = protoFrameCache.kCSMsgStageRecord
	local specEntry = clientPkg["csp.stage_record_c"]

	specEntry.season = season
	specEntry.chapter = chapter
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.stageSkip(season, chapter, level)
	local clientPkg = protoFrameCache.kCSMsgStageSkip
	local specEntry = clientPkg["csp.stage_skip_c"]

	specEntry.season = season
	specEntry.chapter = chapter
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.depositAwardRefresh()
	local clientPkg = protoFrameCache.kCSMsgDepositAwardRefresh
	local specEntry = clientPkg["csp.deposit_refresh_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.depositAwardGet()
	local clientPkg = protoFrameCache.kCSMsgDepositAwardGet
	local specEntry = clientPkg["csp.deposit_get_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.depositAwardStart(level, season, chapter)
	local clientPkg = protoFrameCache.kCSMsgDepositAwardStart
	local specEntry = clientPkg["csp.deposit_start_c"]

	specEntry.level = level
	specEntry.season = season
	specEntry.chapter = chapter

	RPC._packAndSend(clientPkg)
end

function RPC.towerStarAwardGet(layer, award)
	local clientPkg = protoFrameCache.kCSMsgTowerStarAwardGet
	local specEntry = clientPkg["csp.tower_star_award_get_c"]

	specEntry.layer = layer
	specEntry.award = award

	RPC._packAndSend(clientPkg)
end

function RPC.towerSweep(data)
	local clientPkg = protoFrameCache.kCSMsgTowerSweep
	local specEntry = clientPkg["csp.tower_sweep_c"]

	specEntry.data = data

	RPC._packAndSend(clientPkg)
end

function RPC.equipWear(hero, equip_id)
	local clientPkg = protoFrameCache.kCSMsgEquipWear
	local specEntry = clientPkg["csp.equip_wear_c"]

	specEntry.hero = hero
	specEntry.equip_id = equip_id

	RPC._packAndSend(clientPkg)
end

function RPC.equipOff(hero, pos)
	local clientPkg = protoFrameCache.kCSMsgEquipOff
	local specEntry = clientPkg["csp.equip_off_c"]

	specEntry.hero = hero
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.equipSell(equip_id)
	local clientPkg = protoFrameCache.kCSMsgEquipSell
	local specEntry = clientPkg["csp.equip_sell_c"]

	specEntry.equip_id = equip_id

	RPC._packAndSend(clientPkg)
end

function RPC.equipLevelUp(gid, cost_gid, item_id, item_num, cur_exp)
	local clientPkg = protoFrameCache.kCSMsgEquipLevelUp
	local specEntry = clientPkg["csp.equip_levelup_c"]

	specEntry.gid = gid
	specEntry.cost_gid = cost_gid
	specEntry.item_id = item_id
	specEntry.item_num = item_num
	specEntry.cur_exp = cur_exp

	RPC._packAndSend(clientPkg)
end

function RPC.equipSwap(hero_gids)
	local clientPkg = protoFrameCache.kCSMsgEquipSwap
	local specEntry = clientPkg["csp.equip_swap_c"]

	specEntry.hero_gids = hero_gids

	RPC._packAndSend(clientPkg)
end

function RPC.equipEvolve(gid, evolve)
	local clientPkg = protoFrameCache.kCSMsgEquipEvolve
	local specEntry = clientPkg["csp.equip_evolve_c"]

	specEntry.gid = gid
	specEntry.evolve = evolve

	RPC._packAndSend(clientPkg)
end

function RPC.equipBuild(gid, item_id)
	local clientPkg = protoFrameCache.kCSMsgEquipBuild
	local specEntry = clientPkg["csp.equip_build_c"]

	specEntry.gid = gid
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.equipBuildLevelUp(gid, item_id)
	local clientPkg = protoFrameCache.kCSMsgEquipBuildLevelUp
	local specEntry = clientPkg["csp.equip_build_levelup_c"]

	specEntry.gid = gid
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.equipLock(gid, lock)
	local clientPkg = protoFrameCache.kCSMsgEquipLock
	local specEntry = clientPkg["csp.equip_lock_c"]

	specEntry.gid = gid
	specEntry.lock = lock

	RPC._packAndSend(clientPkg)
end

function RPC.artifactWear(hero, artifact_id)
	local clientPkg = protoFrameCache.kCSMsgArtifactWear
	local specEntry = clientPkg["csp.artifact_wear_c"]

	specEntry.hero = hero
	specEntry.artifact_id = artifact_id

	RPC._packAndSend(clientPkg)
end

function RPC.artifactOff(hero, off_artifact_id)
	local clientPkg = protoFrameCache.kCSMsgArtifactOff
	local specEntry = clientPkg["csp.artifact_off_c"]

	specEntry.hero = hero
	specEntry.off_artifact_id = off_artifact_id

	RPC._packAndSend(clientPkg)
end

function RPC.artifactSell(artifact_id)
	local clientPkg = protoFrameCache.kCSMsgArtifactSell
	local specEntry = clientPkg["csp.artifact_sell_c"]

	specEntry.artifact_id = artifact_id

	RPC._packAndSend(clientPkg)
end

function RPC.artifactLevelUp(gid, cost_gid, item_id, item_num, cur_exp)
	local clientPkg = protoFrameCache.kCSMsgArtifactLevelUp
	local specEntry = clientPkg["csp.artifact_levelup_c"]

	specEntry.gid = gid
	specEntry.cost_gid = cost_gid
	specEntry.item_id = item_id
	specEntry.item_num = item_num
	specEntry.cur_exp = cur_exp

	RPC._packAndSend(clientPkg)
end

function RPC.artifactLock(gid, lock)
	local clientPkg = protoFrameCache.kCSMsgArtifactLock
	local specEntry = clientPkg["csp.artifact_lock_c"]

	specEntry.gid = gid
	specEntry.lock = lock

	RPC._packAndSend(clientPkg)
end

function RPC.shopExchange(shopid, exchgid, num, slot, shop_type, mystery_shop_sub_type, discount_item)
	local clientPkg = protoFrameCache.kCSMsgShopExchange
	local specEntry = clientPkg["csp.shop_exchange_c"]

	specEntry.shopid = shopid
	specEntry.exchgid = exchgid
	specEntry.num = num
	specEntry.slot = slot
	specEntry.shop_type = shop_type
	specEntry.mystery_shop_sub_type = mystery_shop_sub_type
	specEntry.discount_item = discount_item

	RPC._packAndSend(clientPkg)
end

function RPC.shopEnter(shopid)
	local clientPkg = protoFrameCache.kCSMsgShopEnter
	local specEntry = clientPkg["csp.shop_enter_c"]

	specEntry.shopid = shopid

	RPC._packAndSend(clientPkg)
end

function RPC.currencyExchange(id, num)
	local clientPkg = protoFrameCache.kCSMsgCurrencyExchange
	local specEntry = clientPkg["csp.currency_exchange_c"]

	specEntry.id = id
	specEntry.num = num

	RPC._packAndSend(clientPkg)
end

function RPC.shopRefresh(shop_id, refresh_count)
	local clientPkg = protoFrameCache.kCSMsgShopRefresh
	local specEntry = clientPkg["csp.shop_refresh_c"]

	specEntry.shop_id = shop_id
	specEntry.refresh_count = refresh_count

	RPC._packAndSend(clientPkg)
end

function RPC.achieveGetAward(achieve_id)
	local clientPkg = protoFrameCache.kCSMsgAchieveGetAward
	local specEntry = clientPkg["csp.achieve_get_award_c"]

	specEntry.achieve_id = achieve_id

	RPC._packAndSend(clientPkg)
end

function RPC.achieveProgressUpdateClient(achieve_type, progress)
	local clientPkg = protoFrameCache.kCSMsgAchieveProgressUpdateClient
	local specEntry = clientPkg["csp.achieve_progress_update_client_c"]

	specEntry.achieve_type = achieve_type
	specEntry.progress = progress

	RPC._packAndSend(clientPkg)
end

function RPC.roleMiscIDCard(id_card)
	local clientPkg = protoFrameCache.kCSMsgRoleMiscIDCard
	local specEntry = clientPkg["csp.role_misc_idcard_c"]

	specEntry.id_card = id_card

	RPC._packAndSend(clientPkg)
end

function RPC.roleMiscYD(data, type)
	local clientPkg = protoFrameCache.kCSMsgRoleMiscYD
	local specEntry = clientPkg["csp.role_misc_yd_c"]

	specEntry.data = data
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.roleMiscConsignee(name, phone, address)
	local clientPkg = protoFrameCache.kCSMsgRoleMiscConsignee
	local specEntry = clientPkg["csp.role_misc_consignee_c"]

	specEntry.name = name
	specEntry.phone = phone
	specEntry.address = address

	RPC._packAndSend(clientPkg)
end

function RPC.equipTowerSweep(type, layer, times)
	local clientPkg = protoFrameCache.kCSMsgEquipTowerSweep
	local specEntry = clientPkg["csp.equip_tower_sweep_c"]

	specEntry.type = type
	specEntry.layer = layer
	specEntry.times = times

	RPC._packAndSend(clientPkg)
end

function RPC.equipTowerReplayRecord(type, layer)
	local clientPkg = protoFrameCache.kCSMsgEquipTowerReplayRecord
	local specEntry = clientPkg["csp.equip_tower_replay_record_c"]

	specEntry.type = type
	specEntry.layer = layer

	RPC._packAndSend(clientPkg)
end

function RPC.equipTowerChooseHero(type, layer, hero_id, gid)
	local clientPkg = protoFrameCache.kCSMsgEquipTowerChooseHero
	local specEntry = clientPkg["csp.equip_tower_choose_hero_c"]

	specEntry.type = type
	specEntry.layer = layer
	specEntry.hero_id = hero_id
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.bagSizeExtend(bag_type, times)
	local clientPkg = protoFrameCache.kCSMsgBagSizeExtend
	local specEntry = clientPkg["csp.bag_size_extend_c"]

	specEntry.bag_type = bag_type
	specEntry.times = times

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPFormation(item, pet)
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPFormation
	local specEntry = clientPkg["csp.async_pvp_formation_c"]

	specEntry.item = item
	specEntry.pet = pet

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPMatch()
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPMatch
	local specEntry = clientPkg["csp.async_pvp_match_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPChallege(uid)
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPChallege
	local specEntry = clientPkg["csp.async_pvp_challege_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPReportGet()
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPReportGet
	local specEntry = clientPkg["csp.async_pvp_report_get_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPSweep(uid)
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPSweep
	local specEntry = clientPkg["csp.async_pvp_sweep_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPGetDetail(uid)
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPGetDetail
	local specEntry = clientPkg["csp.async_pvp_get_detail_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPTargetCache(uid)
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPTargetCache
	local specEntry = clientPkg["csp.async_pvp_target_cache_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.asyncPVPScore(uids)
	local clientPkg = protoFrameCache.kCSMsgAsyncPVPScore
	local specEntry = clientPkg["csp.async_pvp_score_c"]

	specEntry.uids = uids

	RPC._packAndSend(clientPkg)
end

function RPC.cDKey(cdkey)
	local clientPkg = protoFrameCache.kCSMsgCDKey
	local specEntry = clientPkg["csp.cdkey_c"]

	specEntry.cdkey = cdkey

	RPC._packAndSend(clientPkg)
end

function RPC.bossTowerAwardGet(award_ids, type)
	local clientPkg = protoFrameCache.kCSMsgBossTowerAwardGet
	local specEntry = clientPkg["csp.boss_tower_award_get_c"]

	specEntry.award_ids = award_ids
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.bossTowerReplayRecord(type, layer)
	local clientPkg = protoFrameCache.kCSMsgBossTowerReplayRecord
	local specEntry = clientPkg["csp.boss_tower_replay_record_c"]

	specEntry.type = type
	specEntry.layer = layer

	RPC._packAndSend(clientPkg)
end

function RPC.onceTowerReplayRecord(layer)
	local clientPkg = protoFrameCache.kCSMsgOnceTowerReplayRecord
	local specEntry = clientPkg["csp.once_tower_replay_record_c"]

	specEntry.layer = layer

	RPC._packAndSend(clientPkg)
end

function RPC.newbieReport(id)
	local clientPkg = protoFrameCache.kCSMsgNewbieReport
	local specEntry = clientPkg["csp.newbie_report_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.taskGetAward(type, index)
	local clientPkg = protoFrameCache.kCSMsgTaskGetAward
	local specEntry = clientPkg["csp.task_get_award_c"]

	specEntry.type = type
	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.taskGetAllDailyAward(index)
	local clientPkg = protoFrameCache.kCSMsgTaskGetAllDailyAward
	local specEntry = clientPkg["csp.task_get_all_daily_award_c"]

	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.houseUpdate(hero, part)
	local clientPkg = protoFrameCache.kCSMsgHouseUpdate
	local specEntry = clientPkg["csp.house_update_c"]

	specEntry.hero = hero
	specEntry.part = part

	RPC._packAndSend(clientPkg)
end

function RPC.houseVisit(uid)
	local clientPkg = protoFrameCache.kCSMsgHouseVisit
	local specEntry = clientPkg["csp.house_visit_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.houseLevelUp()
	local clientPkg = protoFrameCache.kCSMsgHouseLevelUp
	local specEntry = clientPkg["csp.house_level_up_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.houseUnlockAwardGet()
	local clientPkg = protoFrameCache.kCSMsgHouseUnlockAwardGet
	local specEntry = clientPkg["csp.house_unlock_award_get_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.houseComfortAwardGet(id)
	local clientPkg = protoFrameCache.kCSMsgHouseComfortAwardGet
	local specEntry = clientPkg["csp.house_comfort_award_get_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.houseSweep(isall)
	local clientPkg = protoFrameCache.kCSMsgHouseSweep
	local specEntry = clientPkg["csp.house_sweep_c"]

	specEntry.isall = isall

	RPC._packAndSend(clientPkg)
end

function RPC.houseVisitHistoryGet()
	local clientPkg = protoFrameCache.kCSMsgHouseVisitHistoryGet
	local specEntry = clientPkg["csp.house_visit_history_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.houseFavor(uid)
	local clientPkg = protoFrameCache.kCSMsgHouseFavor
	local specEntry = clientPkg["csp.house_favor_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.houseFavorHistory()
	local clientPkg = protoFrameCache.kCSMsgHouseFavorHistory
	local specEntry = clientPkg["csp.house_favor_history_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.houseFavorRank(start, stop)
	local clientPkg = protoFrameCache.kCSMsgHouseFavorRank
	local specEntry = clientPkg["csp.house_favor_rank_c"]

	specEntry.start = start
	specEntry.stop = stop

	RPC._packAndSend(clientPkg)
end

function RPC.houseVisitRandom()
	local clientPkg = protoFrameCache.kCSMsgHouseVisitRandom
	local specEntry = clientPkg["csp.house_visit_random_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.houseShare(channel, target_uid, msg_id)
	local clientPkg = protoFrameCache.kCSMsgHouseShare
	local specEntry = clientPkg["csp.house_share_c"]

	specEntry.channel = channel
	specEntry.target_uid = target_uid
	specEntry.msg_id = msg_id

	RPC._packAndSend(clientPkg)
end

function RPC.houseMainRoomSet(room_id)
	local clientPkg = protoFrameCache.kCSMsgHouseMainRoomSet
	local specEntry = clientPkg["csp.house_main_room_c"]

	specEntry.room_id = room_id

	RPC._packAndSend(clientPkg)
end

function RPC.houseCommentSwitchSet(comment_switch)
	local clientPkg = protoFrameCache.kCSMsgHouseCommentSwitchSet
	local specEntry = clientPkg["csp.house_comment_switch_c"]

	specEntry.comment_switch = comment_switch

	RPC._packAndSend(clientPkg)
end

function RPC.mazeSelectBranch(branch_index, gid)
	local clientPkg = protoFrameCache.kCSMsgMazeSelectBranch
	local specEntry = clientPkg["csp.maze_select_branch_c"]

	specEntry.branch_index = branch_index
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.mazeSelectRelics(relics_index)
	local clientPkg = protoFrameCache.kCSMsgMazeSelectRelics
	local specEntry = clientPkg["csp.maze_select_relics_c"]

	specEntry.relics_index = relics_index

	RPC._packAndSend(clientPkg)
end

function RPC.mazeSelect(maze_id)
	local clientPkg = protoFrameCache.kCSMsgMazeSelect
	local specEntry = clientPkg["csp.maze_select_c"]

	specEntry.maze_id = maze_id

	RPC._packAndSend(clientPkg)
end

function RPC.mazeRelive(maze_id)
	local clientPkg = protoFrameCache.kCSMsgMazeRelive
	local specEntry = clientPkg["csp.maze_relive_c"]

	specEntry.maze_id = maze_id

	RPC._packAndSend(clientPkg)
end

function RPC.mazeSelectSweepRelics(layer, node, relics_index)
	local clientPkg = protoFrameCache.kCSMsgMazeSelectSweepRelics
	local specEntry = clientPkg["csp.maze_select_sweep_relics_c"]

	specEntry.layer = layer
	specEntry.node = node
	specEntry.relics_index = relics_index

	RPC._packAndSend(clientPkg)
end

function RPC.mazeSweep(maze_id)
	local clientPkg = protoFrameCache.kCSMsgMazeSweep
	local specEntry = clientPkg["csp.maze_sweep_c"]

	specEntry.maze_id = maze_id

	RPC._packAndSend(clientPkg)
end

function RPC.rankIndexGet(rank_type)
	local clientPkg = protoFrameCache.kCSMsgRankIndexGet
	local specEntry = clientPkg["csp.rank_index_get_c"]

	specEntry.rank_type = rank_type

	RPC._packAndSend(clientPkg)
end

function RPC.rankGet(rank_type, page)
	local clientPkg = protoFrameCache.kCSMsgRankGet
	local specEntry = clientPkg["csp.rank_get_c"]

	specEntry.rank_type = rank_type
	specEntry.page = page

	RPC._packAndSend(clientPkg)
end

function RPC.rankTopGet(rank_type)
	local clientPkg = protoFrameCache.kCSMsgRankTopGet
	local specEntry = clientPkg["csp.rank_top_get_c"]

	specEntry.rank_type = rank_type

	RPC._packAndSend(clientPkg)
end

function RPC.bookTaskGetAward(id)
	local clientPkg = protoFrameCache.kCSMsgBookTaskGetAward
	local specEntry = clientPkg["csp.book_task_get_award_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.welfareGetAward(type, resid)
	local clientPkg = protoFrameCache.kCSMsgWelfareGetAward
	local specEntry = clientPkg["csp.welfare_activity_get_c"]

	specEntry.type = type
	specEntry.resid = resid

	RPC._packAndSend(clientPkg)
end

function RPC.welfarePushGiftPopupSet(gift_id)
	local clientPkg = protoFrameCache.kCSMsgWelfarePushGiftPopupSet
	local specEntry = clientPkg["csp.push_gift_popup_set_c"]

	specEntry.gift_id = gift_id

	RPC._packAndSend(clientPkg)
end

function RPC.battlePassGetTaskAward(task_id)
	local clientPkg = protoFrameCache.kCSMsgBattlePassGetTaskAward
	local specEntry = clientPkg["csp.battle_pass_get_task_award_c"]

	specEntry.task_id = task_id

	RPC._packAndSend(clientPkg)
end

function RPC.battlePassGetAward(level)
	local clientPkg = protoFrameCache.kCSMsgBattlePassGetAward
	local specEntry = clientPkg["csp.battle_pass_get_bp_award_c"]

	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.battlePassBuyBpCount(buy_count)
	local clientPkg = protoFrameCache.kCSMsgBattlePassBuyBpCount
	local specEntry = clientPkg["csp.battle_pass_buy_bp_c"]

	specEntry.buy_count = buy_count

	RPC._packAndSend(clientPkg)
end

function RPC.battlePassBpGetSystemData()
	local clientPkg = protoFrameCache.kCSMsgBattlePassBpGetSystemData
	local specEntry = clientPkg["csp.battle_pass_get_sys_data_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.battlePassReset()
	local clientPkg = protoFrameCache.kCSMsgBattlePassReset
	local specEntry = clientPkg["csp.battle_pass_reset_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.surveyFinish()
	local clientPkg = protoFrameCache.kCSMsgSurveyFinish
	local specEntry = clientPkg["csp.survey_finish_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommGet(uid, mask)
	local clientPkg = protoFrameCache.kCSMsgRoleCommGet
	local specEntry = clientPkg["csp.role_comm_get_c"]

	specEntry.uid = uid
	specEntry.mask = mask

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommEditFormation(gid)
	local clientPkg = protoFrameCache.kCSMsgRoleCommEditFormation
	local specEntry = clientPkg["csp.role_comm_edit_formation_c"]

	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommEditSignature(signature)
	local clientPkg = protoFrameCache.kCSMsgRoleCommEditSignature
	local specEntry = clientPkg["csp.role_comm_edit_signature_c"]

	specEntry.signature = signature

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommChangeGender()
	local clientPkg = protoFrameCache.kCSMsgRoleCommChangeGender
	local specEntry = clientPkg["csp.role_comm_change_gender_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommChangeHead(head)
	local clientPkg = protoFrameCache.kCSMsgRoleCommChangeHead
	local specEntry = clientPkg["csp.role_comm_change_head_c"]

	specEntry.head = head

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommChangeHeadFrame(head_frame)
	local clientPkg = protoFrameCache.kCSMsgRoleCommChangeHeadFrame
	local specEntry = clientPkg["csp.role_comm_change_head_frame_c"]

	specEntry.head_frame = head_frame

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommEditVowHero(vow)
	local clientPkg = protoFrameCache.kCSMsgRoleCommEditVowHero
	local specEntry = clientPkg["csp.role_comm_edit_vow_hero_c"]

	specEntry.vow = vow

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommChangeHeadPendant(head_pendant)
	local clientPkg = protoFrameCache.kCSMsgRoleCommChangeHeadPendant
	local specEntry = clientPkg["csp.role_comm_change_head_pendant_c"]

	specEntry.head_pendant = head_pendant

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommEditSignet(signetId)
	local clientPkg = protoFrameCache.kCSMsgRoleCommEditSignet
	local specEntry = clientPkg["csp.role_comm_edit_signet_c"]

	specEntry.signetId = signetId

	RPC._packAndSend(clientPkg)
end

function RPC.roleCommChangeBubble(id)
	local clientPkg = protoFrameCache.kCSMsgRoleCommChangeBubble
	local specEntry = clientPkg["csp.role_comm_change_bubble_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.monumentMsgGetAward(id)
	local clientPkg = protoFrameCache.kCSMsgMonumentMsgGetAward
	local specEntry = clientPkg["csp.monument_get_award_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.crystalMsgLevelUp()
	local clientPkg = protoFrameCache.kCSMsgCrystalMsgLevelUp
	local specEntry = clientPkg["csp.crystal_level_up_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.crystalMsgSetSympathizer(gid)
	local clientPkg = protoFrameCache.kCSMsgCrystalMsgSetSympathizer
	local specEntry = clientPkg["csp.crystal_set_sympathizer_c"]

	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.crystalMsgUnsetSympathizer(gid)
	local clientPkg = protoFrameCache.kCSMsgCrystalMsgUnsetSympathizer
	local specEntry = clientPkg["csp.crystal_unset_sympathizer_c"]

	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.crystalMsgSaveSympathizer(gid_list)
	local clientPkg = protoFrameCache.kCSMsgCrystalMsgSaveSympathizer
	local specEntry = clientPkg["csp.crystal_save_sympathizer_c"]

	specEntry.gid_list = gid_list

	RPC._packAndSend(clientPkg)
end

function RPC.crystalMsgGetAward(id)
	local clientPkg = protoFrameCache.kCSMsgCrystalMsgGetAward
	local specEntry = clientPkg["csp.crystal_get_award_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.powerExchange()
	local clientPkg = protoFrameCache.kCSMsgPowerExchange
	local specEntry = clientPkg["csp.power_exchange_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.vIPGetAward(level)
	local clientPkg = protoFrameCache.kCSMsgVIPGetAward
	local specEntry = clientPkg["csp.vip_get_award_c"]

	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.vIPSetHide(is_hide)
	local clientPkg = protoFrameCache.kCSMsgVIPSetHide
	local specEntry = clientPkg["csp.vip_set_hide_c"]

	specEntry.is_hide = is_hide

	RPC._packAndSend(clientPkg)
end

function RPC.clanCreate(name, title, content, auto_accept, head)
	local clientPkg = protoFrameCache.kCSMsgClanCreate
	local specEntry = clientPkg["csp.clan_create_c"]

	specEntry.name = name
	specEntry.title = title
	specEntry.content = content
	specEntry.auto_accept = auto_accept
	specEntry.head = head

	RPC._packAndSend(clientPkg)
end

function RPC.clanGet()
	local clientPkg = protoFrameCache.kCSMsgClanGet
	local specEntry = clientPkg["csp.clan_get_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.clanJoin(clangid, param)
	local clientPkg = protoFrameCache.kCSMsgClanJoin
	local specEntry = clientPkg["csp.clan_join_c"]

	specEntry.clangid = clangid
	specEntry.param = param

	RPC._packAndSend(clientPkg)
end

function RPC.clanAcceptApply(uid)
	local clientPkg = protoFrameCache.kCSMsgClanAcceptApply
	local specEntry = clientPkg["csp.clan_accept_apply_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.clanRefuseApply(uid)
	local clientPkg = protoFrameCache.kCSMsgClanRefuseApply
	local specEntry = clientPkg["csp.clan_refuse_apply_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.clanExit()
	local clientPkg = protoFrameCache.kCSMsgClanExit
	local specEntry = clientPkg["csp.clan_exit_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.clanDismiss()
	local clientPkg = protoFrameCache.kCSMsgClanDismiss
	local specEntry = clientPkg["csp.clan_dismiss_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.clanKick(uid)
	local clientPkg = protoFrameCache.kCSMsgClanKick
	local specEntry = clientPkg["csp.clan_kick_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.clanAppoint(uid, duty)
	local clientPkg = protoFrameCache.kCSMsgClanAppoint
	local specEntry = clientPkg["csp.clan_appoint_c"]

	specEntry.uid = uid
	specEntry.duty = duty

	RPC._packAndSend(clientPkg)
end

function RPC.clanRename(name)
	local clientPkg = protoFrameCache.kCSMsgClanRename
	local specEntry = clientPkg["csp.clan_rename_c"]

	specEntry.name = name

	RPC._packAndSend(clientPkg)
end

function RPC.clanRenotice(title, notice)
	local clientPkg = protoFrameCache.kCSMsgClanRenotice
	local specEntry = clientPkg["csp.clan_renotice_c"]

	specEntry.title = title
	specEntry.notice = notice

	RPC._packAndSend(clientPkg)
end

function RPC.clanSearch(clangid, clanname, param)
	local clientPkg = protoFrameCache.kCSMsgClanSearch
	local specEntry = clientPkg["csp.clan_search_c"]

	specEntry.clangid = clangid
	specEntry.clanname = clanname
	specEntry.param = param

	RPC._packAndSend(clientPkg)
end

function RPC.clanRecommend(page)
	local clientPkg = protoFrameCache.kCSMsgClanRecommend
	local specEntry = clientPkg["csp.clan_recommend_c"]

	specEntry.page = page

	RPC._packAndSend(clientPkg)
end

function RPC.clanCheckin()
	local clientPkg = protoFrameCache.kCSMsgClanCheckin
	local specEntry = clientPkg["csp.clan_checkin_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.clanTransfer(uid)
	local clientPkg = protoFrameCache.kCSMsgClanTransfer
	local specEntry = clientPkg["csp.clan_transfer_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.clanSendMail(title, content)
	local clientPkg = protoFrameCache.kCSMsgClanSendMail
	local specEntry = clientPkg["csp.clan_mail_c"]

	specEntry.title = title
	specEntry.content = content

	RPC._packAndSend(clientPkg)
end

function RPC.clanRehead(head)
	local clientPkg = protoFrameCache.kCSMsgClanRehead
	local specEntry = clientPkg["csp.clan_rehead_c"]

	specEntry.head = head

	RPC._packAndSend(clientPkg)
end

function RPC.clanSetAutoAccept(switch)
	local clientPkg = protoFrameCache.kCSMsgClanSetAutoAccept
	local specEntry = clientPkg["csp.clan_set_auto_accept_c"]

	specEntry.switch = switch

	RPC._packAndSend(clientPkg)
end

function RPC.clanReHeadFrame(head_frame)
	local clientPkg = protoFrameCache.kCSMsgClanReHeadFrame
	local specEntry = clientPkg["csp.clan_re_head_frame_c"]

	specEntry.head_frame = head_frame

	RPC._packAndSend(clientPkg)
end

function RPC.familiarLevelChange(hero_resid, next_level)
	local clientPkg = protoFrameCache.kCSMsgFamiliarLevelChange
	local specEntry = clientPkg["csp.familiar_up_level_c"]

	specEntry.hero_resid = hero_resid
	specEntry.next_level = next_level

	RPC._packAndSend(clientPkg)
end

function RPC.houseDispatchStart(start_dispatch)
	local clientPkg = protoFrameCache.kCSMsgHouseDispatchStart
	local specEntry = clientPkg["csp.house_dispatch_start_c"]

	specEntry.start_dispatch = start_dispatch

	RPC._packAndSend(clientPkg)
end

function RPC.houseDispatchDone(id)
	local clientPkg = protoFrameCache.kCSMsgHouseDispatchDone
	local specEntry = clientPkg["csp.house_dispatch_done_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.houseDispatchLock(id, lock)
	local clientPkg = protoFrameCache.kCSMsgHouseDispatchLock
	local specEntry = clientPkg["csp.house_dispatch_lock_c"]

	specEntry.id = id
	specEntry.lock = lock

	RPC._packAndSend(clientPkg)
end

function RPC.houseDispatchRefresh(use_refresh_today, remain_diamond)
	local clientPkg = protoFrameCache.kCSMsgHouseDispatchRefresh
	local specEntry = clientPkg["csp.house_dispatch_refresh_c"]

	specEntry.use_refresh_today = use_refresh_today
	specEntry.remain_diamond = remain_diamond

	RPC._packAndSend(clientPkg)
end

function RPC.houseDispatchAllDone(id)
	local clientPkg = protoFrameCache.kCSMsgHouseDispatchAllDone
	local specEntry = clientPkg["csp.house_dispatch_all_done_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.multiPVPMatch()
	local clientPkg = protoFrameCache.kCSMsgMultiPVPMatch
	local specEntry = clientPkg["csp.multipvp_match_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.multiPVPTargetCache(uid)
	local clientPkg = protoFrameCache.kCSMsgMultiPVPTargetCache
	local specEntry = clientPkg["csp.multipvp_target_cache_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.multiPVPRank(page)
	local clientPkg = protoFrameCache.kCSMsgMultiPVPRank
	local specEntry = clientPkg["csp.multipvp_rank_c"]

	specEntry.page = page

	RPC._packAndSend(clientPkg)
end

function RPC.multiPVPAwardGet()
	local clientPkg = protoFrameCache.kCSMsgMultiPVPAwardGet
	local specEntry = clientPkg["csp.multipvp_award_get_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.multiPVPReportGet()
	local clientPkg = protoFrameCache.kCSMsgMultiPVPReportGet
	local specEntry = clientPkg["csp.multipvp_report_get_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.relicWear(hero_id, relic_id)
	local clientPkg = protoFrameCache.kCSMsgRelicWear
	local specEntry = clientPkg["csp.relic_wear_c"]

	specEntry.hero_id = hero_id
	specEntry.relic_id = relic_id

	RPC._packAndSend(clientPkg)
end

function RPC.relicOff(hero_id)
	local clientPkg = protoFrameCache.kCSMsgRelicOff
	local specEntry = clientPkg["csp.relic_off_c"]

	specEntry.hero_id = hero_id

	RPC._packAndSend(clientPkg)
end

function RPC.relicLevelUp(relic_id, target_level)
	local clientPkg = protoFrameCache.kCSMsgRelicLevelUp
	local specEntry = clientPkg["csp.relic_level_up_c"]

	specEntry.relic_id = relic_id
	specEntry.target_level = target_level

	RPC._packAndSend(clientPkg)
end

function RPC.seasonRelicOp(relic_id, op_type, param)
	local clientPkg = protoFrameCache.kCSMsgSeasonRelicOp
	local specEntry = clientPkg["csp.season_relic_op_c"]

	specEntry.relic_id = relic_id
	specEntry.op_type = op_type
	specEntry.param = param

	RPC._packAndSend(clientPkg)
end

function RPC.skinWear(hero_gid, id, type)
	local clientPkg = protoFrameCache.kCSMsgSkinWear
	local specEntry = clientPkg["csp.skin_wear_c"]

	specEntry.hero_gid = hero_gid
	specEntry.id = id
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.skinExchange(resid, id, type)
	local clientPkg = protoFrameCache.kCSMsgSkinExchange
	local specEntry = clientPkg["csp.skin_exchange_c"]

	specEntry.resid = resid
	specEntry.id = id
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.skinUnlock(hero_gid, id, type)
	local clientPkg = protoFrameCache.kCSMsgSkinUnlock
	local specEntry = clientPkg["csp.skin_unlock_c"]

	specEntry.hero_gid = hero_gid
	specEntry.id = id
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.rechargeRebateAward()
	local clientPkg = protoFrameCache.kCSMsgRechargeRebateAward
	local specEntry = clientPkg["csp.recharge_rebate_award_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaRoleOpen(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaRoleOpen
	local specEntry = clientPkg["csp.opact_arena_role_open_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaEnroll(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaEnroll
	local specEntry = clientPkg["csp.opact_arena_enroll_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaUpgradeLeague(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaUpgradeLeague
	local specEntry = clientPkg["csp.opact_arena_upgrade_league_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaMatch(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaMatch
	local specEntry = clientPkg["csp.opact_arena_match_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaDetailGet(act_id, uid)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaDetailGet
	local specEntry = clientPkg["csp.opact_arena_detail_get_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaReportGet(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaReportGet
	local specEntry = clientPkg["csp.opact_arena_report_get_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaRankGet(act_id, league, page)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaRankGet
	local specEntry = clientPkg["csp.opact_arena_rank_get_c"]

	specEntry.act_id = act_id
	specEntry.league = league
	specEntry.page = page

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaRankTopGet()
	local clientPkg = protoFrameCache.kCSMsgOpactArenaRankTopGet
	local specEntry = clientPkg["csp.opact_arena_rank_top_get_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaRoleInfoRefresh(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaRoleInfoRefresh
	local specEntry = clientPkg["csp.opact_arena_role_info_refresh_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaRoleGetNearRank(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaRoleGetNearRank
	local specEntry = clientPkg["csp.opact_arena_role_get_near_rank_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opactArenaSetRandFormaion(act_id, rand)
	local clientPkg = protoFrameCache.kCSMsgOpactArenaSetRandFormaion
	local specEntry = clientPkg["csp.opact_arena_set_rand_formation_c"]

	specEntry.act_id = act_id
	specEntry.rand = rand

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerSweep(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerSweep
	local specEntry = clientPkg["csp.opact_tower_sweep_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerGetScoreAward(act_id, id)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerGetScoreAward
	local specEntry = clientPkg["csp.opact_tower_get_score_c"]

	specEntry.act_id = act_id
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerSetBuff(act_id, tower_id, layer, buff_id)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerSetBuff
	local specEntry = clientPkg["csp.opact_tower_set_buff_c"]

	specEntry.act_id = act_id
	specEntry.tower_id = tower_id
	specEntry.layer = layer
	specEntry.buff_id = buff_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerGetBuff(act_id, tower_id, sys_buff, tower_buff)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerGetBuff
	local specEntry = clientPkg["csp.opact_tower_get_buff_c"]

	specEntry.act_id = act_id
	specEntry.tower_id = tower_id
	specEntry.sys_buff = sys_buff
	specEntry.tower_buff = tower_buff

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerRefreshDeposite(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerRefreshDeposite
	local specEntry = clientPkg["csp.opact_tower_refresh_deposit_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerGetDepositAward(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerGetDepositAward
	local specEntry = clientPkg["csp.opact_tower_get_deposit_award_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerReplayRecord(tower_id, layer)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerReplayRecord
	local specEntry = clientPkg["csp.opact_tower_replay_record_c"]

	specEntry.tower_id = tower_id
	specEntry.layer = layer

	RPC._packAndSend(clientPkg)
end

function RPC.opActTowerEnter(act_id)
	local clientPkg = protoFrameCache.kCSMsgOpActTowerEnter
	local specEntry = clientPkg["csp.opact_tower_enter_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.rentTaskRefresh()
	local clientPkg = protoFrameCache.kCSMsgRentTaskRefresh
	local specEntry = clientPkg["csp.rent_task_refresh_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.rentTaskSelect(gtid, taskid)
	local clientPkg = protoFrameCache.kCSMsgRentTaskSelect
	local specEntry = clientPkg["csp.rent_task_select_c"]

	specEntry.gtid = gtid
	specEntry.taskid = taskid

	RPC._packAndSend(clientPkg)
end

function RPC.rentMatch(gtid, refresh_only)
	local clientPkg = protoFrameCache.kCSMsgRentMatch
	local specEntry = clientPkg["csp.rent_match_c"]

	specEntry.gtid = gtid
	specEntry.refresh_only = refresh_only

	RPC._packAndSend(clientPkg)
end

function RPC.rentSetAutoAccept(auto_accept)
	local clientPkg = protoFrameCache.kCSMsgRentSetAutoAccept
	local specEntry = clientPkg["csp.rent_set_auto_accept_c"]

	specEntry.auto_accept = auto_accept

	RPC._packAndSend(clientPkg)
end

function RPC.rentSendLetter(uid, content, teamid, mvpid, textid)
	local clientPkg = protoFrameCache.kCSMsgRentSendLetter
	local specEntry = clientPkg["csp.rent_send_letter_c"]

	specEntry.uid = uid
	specEntry.content = content
	specEntry.teamid = teamid
	specEntry.mvpid = mvpid
	specEntry.textid = textid

	RPC._packAndSend(clientPkg)
end

function RPC.rentRenterRent(gtid, uid, teamid)
	local clientPkg = protoFrameCache.kCSMsgRentRenterRent
	local specEntry = clientPkg["csp.rent_renter_rent_c"]

	specEntry.gtid = gtid
	specEntry.uid = uid
	specEntry.teamid = teamid

	RPC._packAndSend(clientPkg)
end

function RPC.rentRenterCancel(gtid, uid, teamid)
	local clientPkg = protoFrameCache.kCSMsgRentRenterCancel
	local specEntry = clientPkg["csp.rent_renter_cancel_c"]

	specEntry.gtid = gtid
	specEntry.uid = uid
	specEntry.teamid = teamid

	RPC._packAndSend(clientPkg)
end

function RPC.rentOwnerAccept(gtid, uid, teamid, refuse_other)
	local clientPkg = protoFrameCache.kCSMsgRentOwnerAccept
	local specEntry = clientPkg["csp.rent_owner_accept_c"]

	specEntry.gtid = gtid
	specEntry.uid = uid
	specEntry.teamid = teamid
	specEntry.refuse_other = refuse_other

	RPC._packAndSend(clientPkg)
end

function RPC.rentOwnerRefuse(gtid, uid, teamid)
	local clientPkg = protoFrameCache.kCSMsgRentOwnerRefuse
	local specEntry = clientPkg["csp.rent_owner_refuse_c"]

	specEntry.gtid = gtid
	specEntry.uid = uid
	specEntry.teamid = teamid

	RPC._packAndSend(clientPkg)
end

function RPC.rentOwnerCancel(gtid, uid, teamid)
	local clientPkg = protoFrameCache.kCSMsgRentOwnerCancel
	local specEntry = clientPkg["csp.rent_owner_cancel_c"]

	specEntry.gtid = gtid
	specEntry.uid = uid
	specEntry.teamid = teamid

	RPC._packAndSend(clientPkg)
end

function RPC.rentGetRentedFormation(gtid)
	local clientPkg = protoFrameCache.kCSMsgRentGetRentedFormation
	local specEntry = clientPkg["csp.rent_get_rented_formation_c"]

	specEntry.gtid = gtid

	RPC._packAndSend(clientPkg)
end

function RPC.rentGetOwnerFormation(uid, teamid)
	local clientPkg = protoFrameCache.kCSMsgRentGetOwnerFormation
	local specEntry = clientPkg["csp.rent_get_owner_formation_c"]

	specEntry.uid = uid
	specEntry.teamid = teamid

	RPC._packAndSend(clientPkg)
end

function RPC.rentGetLetter()
	local clientPkg = protoFrameCache.kCSMsgRentGetLetter
	local specEntry = clientPkg["csp.rent_get_letter_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.rentUpdateFormation(gtid, uid, teamid, pos)
	local clientPkg = protoFrameCache.kCSMsgRentUpdateFormation
	local specEntry = clientPkg["csp.rent_update_formation_c"]

	specEntry.gtid = gtid
	specEntry.uid = uid
	specEntry.teamid = teamid
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.rentGetSendLetter()
	local clientPkg = protoFrameCache.kCSMsgRentGetSendLetter
	local specEntry = clientPkg["csp.rent_get_send_letter_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.rankCacheGetPage(cache_type, sub_type, start_page, page_count)
	local clientPkg = protoFrameCache.kCSMsgRankCacheGetPage
	local specEntry = clientPkg["csp.rank_cache_get_page_c"]

	specEntry.cache_type = cache_type
	specEntry.sub_type = sub_type
	specEntry.start_page = start_page
	specEntry.page_count = page_count

	RPC._packAndSend(clientPkg)
end

function RPC.rankCacheGetRealRanking(cache_type, sub_type, actid, season, uniqueid)
	local clientPkg = protoFrameCache.kCSMsgRankCacheGetRealRanking
	local specEntry = clientPkg["csp.rank_cache_get_real_ranking_c"]

	specEntry.cache_type = cache_type
	specEntry.sub_type = sub_type
	specEntry.actid = actid
	specEntry.season = season
	specEntry.uniqueid = uniqueid

	RPC._packAndSend(clientPkg)
end

function RPC.proficentLevelUp(group_id, level, is_ur)
	local clientPkg = protoFrameCache.kCSMsgProficentLevelUp
	local specEntry = clientPkg["csp.proficent_level_up_c"]

	specEntry.group_id = group_id
	specEntry.level = level
	specEntry.is_ur = is_ur

	RPC._packAndSend(clientPkg)
end

function RPC.proficentGetScore(resid, index, all_get, group_id, is_ur)
	local clientPkg = protoFrameCache.kCSMsgProficentGetScore
	local specEntry = clientPkg["csp.proficent_get_score_c"]

	specEntry.resid = resid
	specEntry.index = index
	specEntry.all_get = all_get
	specEntry.group_id = group_id
	specEntry.is_ur = is_ur

	RPC._packAndSend(clientPkg)
end

function RPC.proficentGetOtherScore(resid, index, all_get)
	local clientPkg = protoFrameCache.kCSMsgProficentGetOtherScore
	local specEntry = clientPkg["csp.proficent_get_other_score_c"]

	specEntry.resid = resid
	specEntry.index = index
	specEntry.all_get = all_get

	RPC._packAndSend(clientPkg)
end

function RPC.proficentBookGemUse(group_id, item)
	local clientPkg = protoFrameCache.kCSMsgProficentBookGemUse
	local specEntry = clientPkg["csp.proficent_book_gem_use_c"]

	specEntry.group_id = group_id
	specEntry.item = item

	RPC._packAndSend(clientPkg)
end

function RPC.qQBlueGetForeverAward(get_all, id)
	local clientPkg = protoFrameCache.kCSMsgQQBlueGetForeverAward
	local specEntry = clientPkg["csp.qq_blue_get_forever_award_c"]

	specEntry.get_all = get_all
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.qQBlueGetDayAward(get_all, id)
	local clientPkg = protoFrameCache.kCSMsgQQBlueGetDayAward
	local specEntry = clientPkg["csp.qq_blue_get_day_award_c"]

	specEntry.get_all = get_all
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.redPacketGetAward(item_id, seq_id, cur_limit_count)
	local clientPkg = protoFrameCache.kCSMsgRedPacketGetAward
	local specEntry = clientPkg["csp.red_packet_get_award_c"]

	specEntry.item_id = item_id
	specEntry.seq_id = seq_id
	specEntry.cur_limit_count = cur_limit_count

	RPC._packAndSend(clientPkg)
end

function RPC.advanceGetTaskAward(group_id, task_id)
	local clientPkg = protoFrameCache.kCSMsgAdvanceGetTaskAward
	local specEntry = clientPkg["csp.advance_get_task_award_c"]

	specEntry.group_id = group_id
	specEntry.task_id = task_id

	RPC._packAndSend(clientPkg)
end

function RPC.advanceGetStepAward(group_id, step, is_super)
	local clientPkg = protoFrameCache.kCSMsgAdvanceGetStepAward
	local specEntry = clientPkg["csp.advance_get_step_award_c"]

	specEntry.group_id = group_id
	specEntry.step = step
	specEntry.is_super = is_super

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleEnter(activity_id, hero_gid, model)
	local clientPkg = protoFrameCache.kCSMsgClanBattleEnter
	local specEntry = clientPkg["csp.clan_battle_enter_c"]

	specEntry.activity_id = activity_id
	specEntry.hero_gid = hero_gid
	specEntry.model = model

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleExit(activity_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleExit
	local specEntry = clientPkg["csp.clan_battle_exit_c"]

	specEntry.activity_id = activity_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleOccupyGrid(activity_id, layer, grid_pos, path)
	local clientPkg = protoFrameCache.kCSMsgClanBattleOccupyGrid
	local specEntry = clientPkg["csp.clan_battle_occupy_grid_c"]

	specEntry.activity_id = activity_id
	specEntry.layer = layer
	specEntry.grid_pos = grid_pos
	specEntry.path = path

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleCancelGrid(activity_id, layer, grid_pos)
	local clientPkg = protoFrameCache.kCSMsgClanBattleCancelGrid
	local specEntry = clientPkg["csp.clan_battle_cancel_grid_c"]

	specEntry.activity_id = activity_id
	specEntry.layer = layer
	specEntry.grid_pos = grid_pos

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleOccupyMonster(activity_id, layer, grid_pos, path)
	local clientPkg = protoFrameCache.kCSMsgClanBattleOccupyMonster
	local specEntry = clientPkg["csp.clan_battle_occupy_monster_c"]

	specEntry.activity_id = activity_id
	specEntry.layer = layer
	specEntry.grid_pos = grid_pos
	specEntry.path = path

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleCancelMonster(activity_id, layer, grid_pos)
	local clientPkg = protoFrameCache.kCSMsgClanBattleCancelMonster
	local specEntry = clientPkg["csp.clan_battle_cancel_monster_c"]

	specEntry.activity_id = activity_id
	specEntry.layer = layer
	specEntry.grid_pos = grid_pos

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleOpenGrid(activity_id, layer, grid_pos)
	local clientPkg = protoFrameCache.kCSMsgClanBattleOpenGrid
	local specEntry = clientPkg["csp.clan_battle_open_grid_c"]

	specEntry.activity_id = activity_id
	specEntry.layer = layer
	specEntry.grid_pos = grid_pos

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleNextLayer(activity_id, grid_pos, path)
	local clientPkg = protoFrameCache.kCSMsgClanBattleNextLayer
	local specEntry = clientPkg["csp.clan_battle_next_layer_c"]

	specEntry.activity_id = activity_id
	specEntry.grid_pos = grid_pos
	specEntry.path = path

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleBuySkill(activity_id, skill_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleBuySkill
	local specEntry = clientPkg["csp.clan_battle_buy_skill_c"]

	specEntry.activity_id = activity_id
	specEntry.skill_id = skill_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleUseSkill(activity_id, layer, skill_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleUseSkill
	local specEntry = clientPkg["csp.clan_battle_use_skill_c"]

	specEntry.activity_id = activity_id
	specEntry.layer = layer
	specEntry.skill_id = skill_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleSetModel(activity_id, hero_gid, model)
	local clientPkg = protoFrameCache.kCSMsgClanBattleSetModel
	local specEntry = clientPkg["csp.clan_battle_set_model_c"]

	specEntry.activity_id = activity_id
	specEntry.hero_gid = hero_gid
	specEntry.model = model

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleGiveOrder(activity_id, layer, order, target)
	local clientPkg = protoFrameCache.kCSMsgClanBattleGiveOrder
	local specEntry = clientPkg["csp.clan_battle_give_order_c"]

	specEntry.activity_id = activity_id
	specEntry.layer = layer
	specEntry.order = order
	specEntry.target = target

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleSetRelic(resid, relic)
	local clientPkg = protoFrameCache.kCSMsgClanBattleSetRelic
	local specEntry = clientPkg["csp.clan_battle_set_relic_c"]

	specEntry.resid = resid
	specEntry.relic = relic

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleScoreInfuse(activity_id, infuse_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleScoreInfuse
	local specEntry = clientPkg["csp.clan_battle_score_infuse_c"]

	specEntry.activity_id = activity_id
	specEntry.infuse_id = infuse_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleGetScoreLog(activity_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleGetScoreLog
	local specEntry = clientPkg["csp.clan_battle_get_score_log_c"]

	specEntry.activity_id = activity_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleGetLog(activity_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleGetLog
	local specEntry = clientPkg["csp.clan_battle_get_log_c"]

	specEntry.activity_id = activity_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleGetClanAchieveAward(activity_id, achieve_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleGetClanAchieveAward
	local specEntry = clientPkg["csp.clan_battle_get_clan_achieve_award_c"]

	specEntry.activity_id = activity_id
	specEntry.achieve_id = achieve_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleGetMemberAchieveAward(activity_id, achieve_id)
	local clientPkg = protoFrameCache.kCSMsgClanBattleGetMemberAchieveAward
	local specEntry = clientPkg["csp.clan_battle_get_member_achieve_award_c"]

	specEntry.activity_id = activity_id
	specEntry.achieve_id = achieve_id

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleGetHonor()
	local clientPkg = protoFrameCache.kCSMsgClanBattleGetHonor
	local specEntry = clientPkg["csp.clan_battle_get_honor_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleMarkMember(uid)
	local clientPkg = protoFrameCache.kCSMsgClanBattleMarkMember
	local specEntry = clientPkg["csp.clan_battle_mark_member_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleUnmarkMember(uid)
	local clientPkg = protoFrameCache.kCSMsgClanBattleUnmarkMember
	local specEntry = clientPkg["csp.clan_battle_unmark_member_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.clanBattleOpGridMark(layer, mark_grid_pos, unmark_grid_pos)
	local clientPkg = protoFrameCache.kCSMsgClanBattleOpGridMark
	local specEntry = clientPkg["csp.clan_battle_op_grid_mark_c"]

	specEntry.layer = layer
	specEntry.mark_grid_pos = mark_grid_pos
	specEntry.unmark_grid_pos = unmark_grid_pos

	RPC._packAndSend(clientPkg)
end

function RPC.clanFuncInvite(uid)
	local clientPkg = protoFrameCache.kCSMsgClanFuncInvite
	local specEntry = clientPkg["csp.clan_func_invite_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.clanFuncRefuseInvite(clangid)
	local clientPkg = protoFrameCache.kCSMsgClanFuncRefuseInvite
	local specEntry = clientPkg["csp.clan_func_refuse_invite_c"]

	specEntry.clangid = clangid

	RPC._packAndSend(clientPkg)
end

function RPC.clanFuncShare(clangid, content)
	local clientPkg = protoFrameCache.kCSMsgClanFuncShare
	local specEntry = clientPkg["csp.clan_func_share_c"]

	specEntry.clangid = clangid
	specEntry.content = content

	RPC._packAndSend(clientPkg)
end

function RPC.campTowerSweep(data)
	local clientPkg = protoFrameCache.kCSMsgCampTowerSweep
	local specEntry = clientPkg["csp.camp_tower_sweep_c"]

	specEntry.data = data

	RPC._packAndSend(clientPkg)
end

function RPC.campTowerReplayRecord(tower, layer, level)
	local clientPkg = protoFrameCache.kCSMsgCampTowerReplayRecord
	local specEntry = clientPkg["csp.camp_tower_replay_record_c"]

	specEntry.tower = tower
	specEntry.layer = layer
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.campTowerUpdateStage()
	local clientPkg = protoFrameCache.kCSMsgCampTowerUpdateStage
	local specEntry = clientPkg["csp.camp_tower_update_stage_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.dynamicExpressionUse(id, channel_type, uid)
	local clientPkg = protoFrameCache.KCSMsgDynamicExpressionUse
	local specEntry = clientPkg["csp.dynamic_expression_use_c"]

	specEntry.id = id
	specEntry.channel_type = channel_type
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.refluxGetOnceAward(index)
	local clientPkg = protoFrameCache.KCSMsgRefluxGetOnceAward
	local specEntry = clientPkg["csp.reflux_get_once_award_c"]

	specEntry.index = index

	RPC._packAndSend(clientPkg)
end

function RPC.refluxNewSetFlag()
	local clientPkg = protoFrameCache.KCSMsgRefluxNewSetFlag
	local specEntry = clientPkg["csp.reflux_new_set_flag_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.roleOpActSimpleGet(uid, act_id)
	local clientPkg = protoFrameCache.kCSMsgRoleOpActSimpleGet
	local specEntry = clientPkg["csp.role_opact_simple_get_c"]

	specEntry.uid = uid
	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.collectAchieveGetAward(data)
	local clientPkg = protoFrameCache.kCSMsgCollectAchieveGetAward
	local specEntry = clientPkg["csp.collect_achieve_get_award_c"]

	specEntry.data = data

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeOpen(actid)
	local clientPkg = protoFrameCache.kCSMsgNewMazeOpen
	local specEntry = clientPkg["csp.newmaze_open_c"]

	specEntry.actid = actid

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeLevelEnter(actid, op_type)
	local clientPkg = protoFrameCache.kCSMsgNewMazeLevelEnter
	local specEntry = clientPkg["csp.newmaze_level_enter_c"]

	specEntry.actid = actid
	specEntry.op_type = op_type

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeNodeSelect(actid, layer, node_id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeNodeSelect
	local specEntry = clientPkg["csp.newmaze_node_select_c"]

	specEntry.actid = actid
	specEntry.layer = layer
	specEntry.node_id = node_id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeHaloEquip(actid, id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeHaloEquip
	local specEntry = clientPkg["csp.newmaze_halo_equip_c"]

	specEntry.actid = actid
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeHaloUnEquip(actid, id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeHaloUnEquip
	local specEntry = clientPkg["csp.newmaze_halo_unequip_c"]

	specEntry.actid = actid
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeMultiAwardSelect(actid, award_index)
	local clientPkg = protoFrameCache.kCSMsgNewMazeMultiAwardSelect
	local specEntry = clientPkg["csp.newmaze_multi_award_select_c"]

	specEntry.actid = actid
	specEntry.award_index = award_index

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeLayerNextReq(actid)
	local clientPkg = protoFrameCache.kCSMsgNewMazeLayerNextReq
	local specEntry = clientPkg["csp.newmaze_layer_next_c"]

	specEntry.actid = actid

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeFormationUpdate(actid, formation)
	local clientPkg = protoFrameCache.kCSMsgNewMazeFormationUpdate
	local specEntry = clientPkg["csp.newmaze_formation_update_c"]

	specEntry.actid = actid
	specEntry.formation = formation

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeBattleLoseExit(actid)
	local clientPkg = protoFrameCache.kCSMsgNewMazeBattleLoseExit
	local specEntry = clientPkg["csp.newmaze_battle_lose_exit_c"]

	specEntry.actid = actid

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeLevelExit(actid, op_type)
	local clientPkg = protoFrameCache.kCSMsgNewMazeLevelExit
	local specEntry = clientPkg["csp.newmaze_level_exit_c"]

	specEntry.actid = actid
	specEntry.op_type = op_type

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeRandPoolCheck(actid, checkid, randpool, checkType)
	local clientPkg = protoFrameCache.kCSMsgNewMazeRandPoolCheck
	local specEntry = clientPkg["csp.newmaze_randpool_check_c"]

	specEntry.actid = actid
	specEntry.checkid = checkid
	specEntry.randpool = randpool
	specEntry.checkType = checkType

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeShopRefresh(actid, node_id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeShopRefresh
	local specEntry = clientPkg["csp.newmaze_shop_refresh_c"]

	specEntry.actid = actid
	specEntry.node_id = node_id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeShopPurchase(actid, node_id, item_type, item_id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeShopPurchase
	local specEntry = clientPkg["csp.newmaze_shop_purchase_c"]

	specEntry.actid = actid
	specEntry.node_id = node_id
	specEntry.item_type = item_type
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeShopSell(actid, node_id, item_type, item_id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeShopSell
	local specEntry = clientPkg["csp.newmaze_shop_sell_c"]

	specEntry.actid = actid
	specEntry.node_id = node_id
	specEntry.item_type = item_type
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeRandomEventSelect(actid, id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeRandomEventSelect
	local specEntry = clientPkg["csp.newmaze_random_event_select_c"]

	specEntry.actid = actid
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeRandomEventOptionSelect(actid, index, extra)
	local clientPkg = protoFrameCache.kCSMsgNewMazeRandomEventOptionSelect
	local specEntry = clientPkg["csp.newmaze_random_event_option_select_c"]

	specEntry.actid = actid
	specEntry.index = index
	specEntry.extra = extra

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeFeatureUse(actid, id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeFeatureUse
	local specEntry = clientPkg["csp.newmaze_feature_use_c"]

	specEntry.actid = actid
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeSetOutsideRelic(actid, hero_id, outside_relic_id)
	local clientPkg = protoFrameCache.kCSMsgNewMazeSetOutsideRelic
	local specEntry = clientPkg["csp.newmaze_set_outside_relic_c"]

	specEntry.actid = actid
	specEntry.hero_id = hero_id
	specEntry.outside_relic_id = outside_relic_id

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeModifyInherit(actid, type, add_item, del_item)
	local clientPkg = protoFrameCache.kCSMsgNewMazeModifyInherit
	local specEntry = clientPkg["csp.newmaze_modify_inherit_c"]

	specEntry.actid = actid
	specEntry.type = type
	specEntry.add_item = add_item
	specEntry.del_item = del_item

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeSelectInherit(actid, type, itemid)
	local clientPkg = protoFrameCache.kCSMsgNewMazeSelectInherit
	local specEntry = clientPkg["csp.newmaze_select_inherit_c"]

	specEntry.actid = actid
	specEntry.type = type
	specEntry.itemid = itemid

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeEnchanterUse(actid, hero_id, enchanter_id, pos)
	local clientPkg = protoFrameCache.kCSMsgNewMazeEnchanterUse
	local specEntry = clientPkg["csp.newmaze_enchanter_use_c"]

	specEntry.actid = actid
	specEntry.hero_id = hero_id
	specEntry.enchanter_id = enchanter_id
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.newMazeTalentSet(actid, talent_item)
	local clientPkg = protoFrameCache.kCSMsgNewMazeTalentSet
	local specEntry = clientPkg["csp.newmaze_talent_set_c"]

	specEntry.actid = actid
	specEntry.talent_item = talent_item

	RPC._packAndSend(clientPkg)
end

function RPC.petPossess(resid, career, op_type)
	local clientPkg = protoFrameCache.kCSMsgPetPossess
	local specEntry = clientPkg["csp.pet_possess_c"]

	specEntry.resid = resid
	specEntry.career = career
	specEntry.op_type = op_type

	RPC._packAndSend(clientPkg)
end

function RPC.petPossessReplace(op_type, src_resid, dst_resid, src_career, dst_career)
	local clientPkg = protoFrameCache.kCSMsgPetPossessReplace
	local specEntry = clientPkg["csp.pet_possess_replace_c"]

	specEntry.op_type = op_type
	specEntry.src_resid = src_resid
	specEntry.dst_resid = dst_resid
	specEntry.src_career = src_career
	specEntry.dst_career = dst_career

	RPC._packAndSend(clientPkg)
end

function RPC.petDevelopIntelligence(resid, develop_type, multiple)
	local clientPkg = protoFrameCache.kCSMsgPetDevelopIntelligence
	local specEntry = clientPkg["csp.pet_develop_intelligence_c"]

	specEntry.resid = resid
	specEntry.develop_type = develop_type
	specEntry.multiple = multiple

	RPC._packAndSend(clientPkg)
end

function RPC.petChooseIntelligence(resid, op_type)
	local clientPkg = protoFrameCache.kCSMsgPetChooseIntelligence
	local specEntry = clientPkg["csp.pet_choose_intelligence_c"]

	specEntry.resid = resid
	specEntry.op_type = op_type

	RPC._packAndSend(clientPkg)
end

function RPC.petDevelopGift(resid, item_id)
	local clientPkg = protoFrameCache.kCSMsgPetDevelopGift
	local specEntry = clientPkg["csp.pet_develop_gift_c"]

	specEntry.resid = resid
	specEntry.item_id = item_id

	RPC._packAndSend(clientPkg)
end

function RPC.petChooseGift(resid, op_type)
	local clientPkg = protoFrameCache.kCSMsgPetChooseGift
	local specEntry = clientPkg["csp.pet_choose_gift_c"]

	specEntry.resid = resid
	specEntry.op_type = op_type

	RPC._packAndSend(clientPkg)
end

function RPC.petDegreeLevelUp()
	local clientPkg = protoFrameCache.kCSMsgPetDegreeLevelUp
	local specEntry = clientPkg["csp.pet_degree_level_up_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.petDegreeRuneActive(type, pos)
	local clientPkg = protoFrameCache.kCSMsgPetDegreeRuneActive
	local specEntry = clientPkg["csp.pet_degree_rune_active_c"]

	specEntry.type = type
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.petStarUp(id)
	local clientPkg = protoFrameCache.kCSMsgPetStarUp
	local specEntry = clientPkg["csp.pet_starup_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.petRecycle(list)
	local clientPkg = protoFrameCache.kCSMsgPetRecycle
	local specEntry = clientPkg["csp.pet_recycle_c"]

	specEntry.list = list

	RPC._packAndSend(clientPkg)
end

function RPC.petExchange(id)
	local clientPkg = protoFrameCache.kCSMsgPetExchange
	local specEntry = clientPkg["csp.pet_exchange_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.petRuneActive(type, pos)
	local clientPkg = protoFrameCache.kCSMsgPetRuneActive
	local specEntry = clientPkg["csp.pet_rune_active_c"]

	specEntry.type = type
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.petGemLevelUp(data, gem_num)
	local clientPkg = protoFrameCache.kCSMsgPetGemLevelUp
	local specEntry = clientPkg["csp.pet_gem_levelup_c"]

	specEntry.data = data
	specEntry.gem_num = gem_num

	RPC._packAndSend(clientPkg)
end

function RPC.petGemRerandAttribute(type, gid)
	local clientPkg = protoFrameCache.kCSMsgPetGemRerandAttribute
	local specEntry = clientPkg["csp.pet_gem_rerand_attribute_c"]

	specEntry.type = type
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.petGemInset(type, pet_gid, on_gem_gid, off_gem_gid)
	local clientPkg = protoFrameCache.kCSMsgPetGemInset
	local specEntry = clientPkg["csp.pet_gem_inset_c"]

	specEntry.type = type
	specEntry.pet_gid = pet_gid
	specEntry.on_gem_gid = on_gem_gid
	specEntry.off_gem_gid = off_gem_gid

	RPC._packAndSend(clientPkg)
end

function RPC.petAmuletSet(type, pos, pet_id, amulet_id)
	local clientPkg = protoFrameCache.kCSMsgPetAmuletSet
	local specEntry = clientPkg["csp.pet_amulet_set_c"]

	specEntry.type = type
	specEntry.pos = pos
	specEntry.pet_id = pet_id
	specEntry.amulet_id = amulet_id

	RPC._packAndSend(clientPkg)
end

function RPC.petAmuletStarUp(id)
	local clientPkg = protoFrameCache.kCSMsgPetAmuletStarUp
	local specEntry = clientPkg["csp.pet_amulet_starup_c"]

	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.petRuneUp(resid)
	local clientPkg = protoFrameCache.kCSMsgPetRuneUp
	local specEntry = clientPkg["csp.pet_rune_up_c"]

	specEntry.resid = resid

	RPC._packAndSend(clientPkg)
end

function RPC.petRuneHeroBind(resid, hero_on, hero_off)
	local clientPkg = protoFrameCache.kCSMsgPetRuneHeroBind
	local specEntry = clientPkg["csp.pet_rune_hero_bind_c"]

	specEntry.resid = resid
	specEntry.hero_on = hero_on
	specEntry.hero_off = hero_off

	RPC._packAndSend(clientPkg)
end

function RPC.petGemSaveAttribute(type, gid, save)
	local clientPkg = protoFrameCache.kCSMsgPetGemSaveAttribute
	local specEntry = clientPkg["csp.pet_gem_save_attribute_c"]

	specEntry.type = type
	specEntry.gid = gid
	specEntry.save = save

	RPC._packAndSend(clientPkg)
end

function RPC.petOffWears(petid)
	local clientPkg = protoFrameCache.kCSMsgPetOffWears
	local specEntry = clientPkg["csp.pet_off_wears_c"]

	specEntry.petid = petid

	RPC._packAndSend(clientPkg)
end

function RPC.mysteryShopEnter(shop_sub_type)
	local clientPkg = protoFrameCache.kCSMsgMysteryShopEnter
	local specEntry = clientPkg["csp.mystery_shop_enter_c"]

	specEntry.shop_sub_type = shop_sub_type

	RPC._packAndSend(clientPkg)
end

function RPC.mysteryShopExit(shop_sub_type)
	local clientPkg = protoFrameCache.kCSMsgMysteryShopExit
	local specEntry = clientPkg["csp.mystery_shop_exit_c"]

	specEntry.shop_sub_type = shop_sub_type

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpGroupEnterRoom(act_id, room_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpGroupEnterRoom
	local specEntry = clientPkg["csp.bppvp_group_enter_room_c"]

	specEntry.act_id = act_id
	specEntry.room_id = room_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpGroupDetailGet(act_id, uid, show_detail)
	local clientPkg = protoFrameCache.kCSMsgBPPvpGroupDetailGet
	local specEntry = clientPkg["csp.bppvp_detail_get_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid
	specEntry.show_detail = show_detail

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpGroupReportGet(act_id, type)
	local clientPkg = protoFrameCache.kCSMsgBPPvpGroupReportGet
	local specEntry = clientPkg["csp.bppvp_report_get_c"]

	specEntry.act_id = act_id
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutGetHallData(act_id, area_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutGetHallData
	local specEntry = clientPkg["csp.bppvp_knockout_get_hall_data_c"]

	specEntry.act_id = act_id
	specEntry.area_id = area_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutEnterRoom(act_id, area_id, room_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutEnterRoom
	local specEntry = clientPkg["csp.bppvp_knockout_enter_room_c"]

	specEntry.act_id = act_id
	specEntry.area_id = area_id
	specEntry.room_id = room_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutSetBPPool(act_id, area_id, room_id, gid)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutSetBPPool
	local specEntry = clientPkg["csp.bppvp_knockout_set_bppool_c"]

	specEntry.act_id = act_id
	specEntry.area_id = area_id
	specEntry.room_id = room_id
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutBP(act_id, area_id, room_id, bp_id, hero_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutBP
	local specEntry = clientPkg["csp.bppvp_knockout_bp_c"]

	specEntry.act_id = act_id
	specEntry.area_id = area_id
	specEntry.room_id = room_id
	specEntry.bp_id = bp_id
	specEntry.hero_id = hero_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutFormation(act_id, area_id, room_id, item, pos)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutFormation
	local specEntry = clientPkg["csp.bppvp_knockout_formation_c"]

	specEntry.act_id = act_id
	specEntry.area_id = area_id
	specEntry.room_id = room_id
	specEntry.item = item
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutBPPoolGet(act_id, uid)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutBPPoolGet
	local specEntry = clientPkg["csp.bppvp_knockout_get_bppool_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutFormationGet(act_id, uid, room_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutFormationGet
	local specEntry = clientPkg["csp.bppvp_knockout_get_formation_c"]

	specEntry.act_id = act_id
	specEntry.uid = uid
	specEntry.room_id = room_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutRoomInfoGet(act_id, area_id, room_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutRoomInfoGet
	local specEntry = clientPkg["csp.bppvp_knockout_room_info_c"]

	specEntry.act_id = act_id
	specEntry.area_id = area_id
	specEntry.room_id = room_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutReportGet(act_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutReportGet
	local specEntry = clientPkg["csp.bppvp_knockout_report_get_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutBet(act_id, room_id, bet_pos)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutBet
	local specEntry = clientPkg["csp.bppvp_knockout_bet_c"]

	specEntry.act_id = act_id
	specEntry.room_id = room_id
	specEntry.bet_pos = bet_pos

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutBetInfoGet(act_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutBetInfoGet
	local specEntry = clientPkg["csp.bppvp_knockout_bet_info_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockoutBetHistoryGet(act_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockoutBetHistoryGet
	local specEntry = clientPkg["csp.bppvp_knockout_bet_his_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpActivityStateGet(act_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpActivityStateGet
	local specEntry = clientPkg["csp.bppvp_activity_state_get_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockouotChatReq(act_id, chat_req)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockouotChatReq
	local specEntry = clientPkg["csp.bppvp_knockout_chat_c"]

	specEntry.act_id = act_id
	specEntry.chat_req = chat_req

	RPC._packAndSend(clientPkg)
end

function RPC.bPPvpKnockouotBanRuleSet(act_id, room_id, rule_id)
	local clientPkg = protoFrameCache.kCSMsgBPPvpKnockouotBanRuleSet
	local specEntry = clientPkg["csp.bppvp_knockout_ban_rule_c"]

	specEntry.act_id = act_id
	specEntry.room_id = room_id
	specEntry.rule_id = rule_id

	RPC._packAndSend(clientPkg)
end

function RPC.petMazeSaveFormation(act_id, level, gid)
	local clientPkg = protoFrameCache.kCSMsgPetMazeSaveFormation
	local specEntry = clientPkg["csp.petmaze_save_formation_c"]

	specEntry.act_id = act_id
	specEntry.level = level
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.petMazeSaveSupportFormation(act_id, level, stage_id, gid)
	local clientPkg = protoFrameCache.kCSMsgPetMazeSaveSupportFormation
	local specEntry = clientPkg["csp.petmaze_save_support_formation_c"]

	specEntry.act_id = act_id
	specEntry.level = level
	specEntry.stage_id = stage_id
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.petMazeReset(act_id, level, stage_id)
	local clientPkg = protoFrameCache.kCSMsgPetMazeReset
	local specEntry = clientPkg["csp.petmaze_reset_c"]

	specEntry.act_id = act_id
	specEntry.level = level
	specEntry.stage_id = stage_id

	RPC._packAndSend(clientPkg)
end

function RPC.petMazeGetStepAward(item)
	local clientPkg = protoFrameCache.kCSMsgPetMazeGetStepAward
	local specEntry = clientPkg["csp.petmaze_get_step_award_c"]

	specEntry.item = item

	RPC._packAndSend(clientPkg)
end

function RPC.petMazeSweep(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgPetMazeSweep
	local specEntry = clientPkg["csp.petmaze_sweep_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.newPveChooseLevel(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgNewPveChooseLevel
	local specEntry = clientPkg["csp.newpve_choose_level_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.newPveChooseLimits(act_id, limits)
	local clientPkg = protoFrameCache.kCSMsgNewPveChooseLimits
	local specEntry = clientPkg["csp.newpve_choose_limits_c"]

	specEntry.act_id = act_id
	specEntry.limits = limits

	RPC._packAndSend(clientPkg)
end

function RPC.newPveReset(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgNewPveReset
	local specEntry = clientPkg["csp.newpve_reset_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.newPveSaveFormation(act_id, formation)
	local clientPkg = protoFrameCache.kCSMsgNewPveSaveFormation
	local specEntry = clientPkg["csp.newpve_save_formation_c"]

	specEntry.act_id = act_id
	specEntry.formation = formation

	RPC._packAndSend(clientPkg)
end

function RPC.newPveGetAward(act_id, battlefield_type, id)
	local clientPkg = protoFrameCache.kCSMsgNewPveGetAward
	local specEntry = clientPkg["csp.newpve_get_award_c"]

	specEntry.act_id = act_id
	specEntry.battlefield_type = battlefield_type
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.newPveGetFormation(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgNewPveGetFormation
	local specEntry = clientPkg["csp.newpve_get_formation_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.newPveGetCurFormation()
	local clientPkg = protoFrameCache.kCSMsgNewPveGetCurFormation
	local specEntry = clientPkg["csp.newpve_get_cur_formation_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.newPveWearRelic(act_id, hero_id, relic_id)
	local clientPkg = protoFrameCache.kCSMsgNewPveWearRelic
	local specEntry = clientPkg["csp.newpve_wear_relic_c"]

	specEntry.act_id = act_id
	specEntry.hero_id = hero_id
	specEntry.relic_id = relic_id

	RPC._packAndSend(clientPkg)
end

function RPC.newPveResetProgress(act_id, level)
	local clientPkg = protoFrameCache.kCSMsgNewPveResetProgress
	local specEntry = clientPkg["csp.newpve_reset_progress_c"]

	specEntry.act_id = act_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.newPveResetStage(act_id, level, stage)
	local clientPkg = protoFrameCache.kCSMsgNewPveResetStage
	local specEntry = clientPkg["csp.newpve_reset_stage_c"]

	specEntry.act_id = act_id
	specEntry.level = level
	specEntry.stage = stage

	RPC._packAndSend(clientPkg)
end

function RPC.newPvePopUp(act_id)
	local clientPkg = protoFrameCache.kCSMsgNewPvePopUp
	local specEntry = clientPkg["csp.newpve_pop_up_c"]

	specEntry.act_id = act_id

	RPC._packAndSend(clientPkg)
end

function RPC.relaxingGamePass(type, chapter, stage)
	local clientPkg = protoFrameCache.kCSMsgRelaxingGamePass
	local specEntry = clientPkg["csp.relaxing_game_pass_c"]

	specEntry.type = type
	specEntry.chapter = chapter
	specEntry.stage = stage

	RPC._packAndSend(clientPkg)
end

function RPC.relaxingGameGetBigAward(id, type)
	local clientPkg = protoFrameCache.kCSMsgRelaxingGameGetBigAward
	local specEntry = clientPkg["csp.relaxing_game_get_big_award_c"]

	specEntry.id = id
	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.relaxingGameChooseFirstGame(type)
	local clientPkg = protoFrameCache.kCSMsgRelaxingGameChooseFirstGame
	local specEntry = clientPkg["csp.relaxing_game_choose_first_game_c"]

	specEntry.type = type

	RPC._packAndSend(clientPkg)
end

function RPC.formationRecommendRankGet(type, level)
	local clientPkg = protoFrameCache.kCSMsgFormationRecommendRankGet
	local specEntry = clientPkg["csp.formation_recommend_rank_get_c"]

	specEntry.type = type
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeAdd(target_type, uid)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeAdd
	local specEntry = clientPkg["csp.master_apprentice_add_c"]

	specEntry.target_type = target_type
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeDel(target_type, uid)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeDel
	local specEntry = clientPkg["csp.master_apprentice_del_c"]

	specEntry.target_type = target_type
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeGraduation(uid)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeGraduation
	local specEntry = clientPkg["csp.master_apprentice_graduation_c"]

	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeInviteOp(target_type, op_type, uid)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeInviteOp
	local specEntry = clientPkg["csp.master_apprentice_invite_op_c"]

	specEntry.target_type = target_type
	specEntry.op_type = op_type
	specEntry.uid = uid

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeSearch(type, search_name, obj_gid)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeSearch
	local specEntry = clientPkg["csp.master_apprentice_search_c"]

	specEntry.type = type
	specEntry.search_name = search_name
	specEntry.obj_gid = obj_gid

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeRecommend(target_type)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeRecommend
	local specEntry = clientPkg["csp.master_apprentice_recommend_c"]

	specEntry.target_type = target_type

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeEnroll(enroll_type)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeEnroll
	local specEntry = clientPkg["csp.master_apprentice_enroll_c"]

	specEntry.enroll_type = enroll_type

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeQualificationUpdate(master_qualification, apprentice_qualification)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeQualificationUpdate
	local specEntry = clientPkg["csp.master_apprentice_qualification_update_c"]

	specEntry.master_qualification = master_qualification
	specEntry.apprentice_qualification = apprentice_qualification

	RPC._packAndSend(clientPkg)
end

function RPC.masterApprenticeGetTaskAward(type, id)
	local clientPkg = protoFrameCache.kCSMsgMasterApprenticeGetTaskAward
	local specEntry = clientPkg["csp.master_apprentice_get_task_award_c"]

	specEntry.type = type
	specEntry.id = id

	RPC._packAndSend(clientPkg)
end

function RPC.masterGetLevelAward(level)
	local clientPkg = protoFrameCache.kCSMsgMasterGetLevelAward
	local specEntry = clientPkg["csp.master_get_level_award_c"]

	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.apprenticeRequestDevelopGuide(master_uid)
	local clientPkg = protoFrameCache.kCSMsgApprenticeRequestDevelopGuide
	local specEntry = clientPkg["csp.apprentice_request_develop_guide_c"]

	specEntry.master_uid = master_uid

	RPC._packAndSend(clientPkg)
end

function RPC.masterSetDevelopGuide(apprentice_uid, hero_gid)
	local clientPkg = protoFrameCache.kCSMsgMasterSetDevelopGuide
	local specEntry = clientPkg["csp.master_set_develop_guide_c"]

	specEntry.apprentice_uid = apprentice_uid
	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.masterGetApprenticeAllHero(apprentice_uid)
	local clientPkg = protoFrameCache.kCSMsgMasterGetApprenticeAllHero
	local specEntry = clientPkg["csp.master_get_apprentice_all_hero_c"]

	specEntry.apprentice_uid = apprentice_uid

	RPC._packAndSend(clientPkg)
end

function RPC.apprenticeRequestBattleGuide(master_uid, stage)
	local clientPkg = protoFrameCache.kCSMsgApprenticeRequestBattleGuide
	local specEntry = clientPkg["csp.apprentice_request_battle_guide_c"]

	specEntry.master_uid = master_uid
	specEntry.stage = stage

	RPC._packAndSend(clientPkg)
end

function RPC.masterSetBattleGuide(apprentice_uid, stage, item)
	local clientPkg = protoFrameCache.kCSMsgMasterSetBattleGuide
	local specEntry = clientPkg["csp.master_set_battle_guide_c"]

	specEntry.apprentice_uid = apprentice_uid
	specEntry.stage = stage
	specEntry.item = item

	RPC._packAndSend(clientPkg)
end

function RPC.masterOpenDevelopGuide(apprentice_uid)
	local clientPkg = protoFrameCache.kCSMsgMasterOpenDevelopGuide
	local specEntry = clientPkg["csp.master_open_develop_guide_c"]

	specEntry.apprentice_uid = apprentice_uid

	RPC._packAndSend(clientPkg)
end

function RPC.apprenticeAddRentCnt(master_uid)
	local clientPkg = protoFrameCache.kCSMsgApprenticeAddRentCnt
	local specEntry = clientPkg["csp.apprentice_add_rent_cnt_c"]

	specEntry.master_uid = master_uid

	RPC._packAndSend(clientPkg)
end

function RPC.apprenticeAddGuideCnt(master_uid)
	local clientPkg = protoFrameCache.kCSMsgApprenticeAddGuideCnt
	local specEntry = clientPkg["csp.apprentice_add_guide_cnt_c"]

	specEntry.master_uid = master_uid

	RPC._packAndSend(clientPkg)
end

function RPC.masterClientUpdateProgress(action, param, replace)
	local clientPkg = protoFrameCache.kCSMsgMasterClientUpdateProgress
	local specEntry = clientPkg["csp.master_client_update_progress_c"]

	specEntry.action = action
	specEntry.param = param
	specEntry.replace = replace

	RPC._packAndSend(clientPkg)
end

function RPC.itemSell(sell_list)
	local clientPkg = protoFrameCache.kCSMsgItemSell
	local specEntry = clientPkg["csp.item_sell_c"]

	specEntry.sell_list = sell_list

	RPC._packAndSend(clientPkg)
end

function RPC.itemUse(use_list)
	local clientPkg = protoFrameCache.kCSMsgItemUse
	local specEntry = clientPkg["csp.item_use_c"]

	specEntry.use_list = use_list

	RPC._packAndSend(clientPkg)
end

function RPC.itemCompound(compound)
	local clientPkg = protoFrameCache.kCSMsgItemCompound
	local specEntry = clientPkg["csp.item_compound_c"]

	specEntry.compound = compound

	RPC._packAndSend(clientPkg)
end

function RPC.heroLevelUp(hero_gid, next_lv)
	local clientPkg = protoFrameCache.kCSMsgHeroLevelUp
	local specEntry = clientPkg["csp.hero_level_up_c"]

	specEntry.hero_gid = hero_gid
	specEntry.next_lv = next_lv

	RPC._packAndSend(clientPkg)
end

function RPC.heroStepUp(hero_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroStepUp
	local specEntry = clientPkg["csp.hero_step_up_c"]

	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroStarUp(hero_gid, same_gid, any_gid, special_gid, same_camp_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroStarUp
	local specEntry = clientPkg["csp.hero_star_up_c"]

	specEntry.hero_gid = hero_gid
	specEntry.same_gid = same_gid
	specEntry.any_gid = any_gid
	specEntry.special_gid = special_gid
	specEntry.same_camp_gid = same_camp_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroRecycle(hero_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroRecycle
	local specEntry = clientPkg["csp.hero_recycle_c"]

	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroRecharge(hero_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroRecharge
	local specEntry = clientPkg["csp.hero_recharge_c"]

	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroReset(hero_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroReset
	local specEntry = clientPkg["csp.hero_reset_c"]

	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroLevelReset(hero_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroLevelReset
	local specEntry = clientPkg["csp.hero_level_reset_c"]

	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroStepReset(hero_gid, pos)
	local clientPkg = protoFrameCache.kCSMsgHeroStepReset
	local specEntry = clientPkg["csp.hero_step_reset_c"]

	specEntry.hero_gid = hero_gid
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.heroLock(hero_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroLock
	local specEntry = clientPkg["csp.hero_lock_c"]

	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroUnlock(hero_gid)
	local clientPkg = protoFrameCache.kCSMsgHeroUnlock
	local specEntry = clientPkg["csp.hero_unlock_c"]

	specEntry.hero_gid = hero_gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroStarUpBatch(data)
	local clientPkg = protoFrameCache.kCSMsgHeroStarUpBatch
	local specEntry = clientPkg["csp.hero_star_up_batch_c"]

	specEntry.data = data

	RPC._packAndSend(clientPkg)
end

function RPC.heroExchange(source_gid, target_gid, exchange_equip, exchange_artifact, exchange_step)
	local clientPkg = protoFrameCache.kCSMsgHeroExchange
	local specEntry = clientPkg["csp.hero_exchange_c"]

	specEntry.source_gid = source_gid
	specEntry.target_gid = target_gid
	specEntry.exchange_equip = exchange_equip
	specEntry.exchange_artifact = exchange_artifact
	specEntry.exchange_step = exchange_step

	RPC._packAndSend(clientPkg)
end

function RPC.heroOffWears(op_type, gid)
	local clientPkg = protoFrameCache.kCSMsgHeroOffWears
	local specEntry = clientPkg["csp.hero_off_wears_c"]

	specEntry.op_type = op_type
	specEntry.gid = gid

	RPC._packAndSend(clientPkg)
end

function RPC.heroStarBack(gid, star)
	local clientPkg = protoFrameCache.kCSMsgHeroStarBack
	local specEntry = clientPkg["csp.hero_star_back_c"]

	specEntry.gid = gid
	specEntry.star = star

	RPC._packAndSend(clientPkg)
end

function RPC.heroPaint(res_id, paint_level)
	local clientPkg = protoFrameCache.kCSMsgHeroPaint
	local specEntry = clientPkg["csp.hero_paint_c"]

	specEntry.res_id = res_id
	specEntry.paint_level = paint_level

	RPC._packAndSend(clientPkg)
end

function RPC.heroPaintAbility(res_id, ability)
	local clientPkg = protoFrameCache.kCSMsgHeroPaintAbility
	local specEntry = clientPkg["csp.hero_paint_ability_c"]

	specEntry.res_id = res_id
	specEntry.ability = ability

	RPC._packAndSend(clientPkg)
end

function RPC.heroDevelop(res_id, develop_id, level)
	local clientPkg = protoFrameCache.kCSMsgHeroDevelop
	local specEntry = clientPkg["csp.hero_develop_c"]

	specEntry.res_id = res_id
	specEntry.develop_id = develop_id
	specEntry.level = level

	RPC._packAndSend(clientPkg)
end

function RPC.heroDevelopUpdateRedPoint(op_type, pos)
	local clientPkg = protoFrameCache.kCSMsgHeroDevelopUpdateRedPoint
	local specEntry = clientPkg["csp.hero_develop_open_c"]

	specEntry.op_type = op_type
	specEntry.pos = pos

	RPC._packAndSend(clientPkg)
end

function RPC.heroPaintItemConvert(same_paint_item, paint_item_id, resid)
	local clientPkg = protoFrameCache.kCSMsgHeroPaintItemConvert
	local specEntry = clientPkg["csp.hero_paint_item_convert_c"]

	specEntry.same_paint_item = same_paint_item
	specEntry.paint_item_id = paint_item_id
	specEntry.resid = resid

	RPC._packAndSend(clientPkg)
end

function RPC.heroCrystalStoryUnlock(res_id, story_id)
	local clientPkg = protoFrameCache.kCSMsgHeroCrystalStoryUnlock
	local specEntry = clientPkg["csp.hero_crystal_story_unlock_c"]

	specEntry.res_id = res_id
	specEntry.story_id = story_id

	RPC._packAndSend(clientPkg)
end

function RPC.heroPaintRelateUnlock(res_id, relate_level)
	local clientPkg = protoFrameCache.kCSMsgHeroPaintRelateUnlock
	local specEntry = clientPkg["csp.hero_paint_relate_unlock_c"]

	specEntry.res_id = res_id
	specEntry.relate_level = relate_level

	RPC._packAndSend(clientPkg)
end

function RPC.heroNewPaint(res_id, paint_level)
	local clientPkg = protoFrameCache.kCSMsgHeroNewPaint
	local specEntry = clientPkg["csp.hero_new_paint_c"]

	specEntry.res_id = res_id
	specEntry.paint_level = paint_level

	RPC._packAndSend(clientPkg)
end

function RPC.equipSchemeUpdate(data, version, update)
	local clientPkg = protoFrameCache.kCSMsgEquipSchemeUpdate
	local specEntry = clientPkg["csp.equip_scheme_update_c"]

	specEntry.data = data
	specEntry.version = version
	specEntry.update = update

	RPC._packAndSend(clientPkg)
end

function RPC.equipSchemeApply(sel_id, version)
	local clientPkg = protoFrameCache.kCSMsgEquipSchemeApply
	local specEntry = clientPkg["csp.equip_scheme_apply_c"]

	specEntry.sel_id = sel_id
	specEntry.version = version

	RPC._packAndSend(clientPkg)
end

function RPC.equipSchemeRename(sel_id, name, version)
	local clientPkg = protoFrameCache.kCSMsgEquipSchemeRename
	local specEntry = clientPkg["csp.equip_scheme_rename_c"]

	specEntry.sel_id = sel_id
	specEntry.name = name
	specEntry.version = version

	RPC._packAndSend(clientPkg)
end

function RPC.equipSchemeDelete(sel_id, version)
	local clientPkg = protoFrameCache.kCSMsgEquipSchemeDelete
	local specEntry = clientPkg["csp.equip_scheme_delete_c"]

	specEntry.sel_id = sel_id
	specEntry.version = version

	RPC._packAndSend(clientPkg)
end

function RPC.equipTeamWear(wear_list)
	local clientPkg = protoFrameCache.kCSMsgEquipTeamWear
	local specEntry = clientPkg["csp.equip_team_wear_c"]

	specEntry.wear_list = wear_list

	RPC._packAndSend(clientPkg)
end

function RPC.heartBeat(count, data)
	local clientPkg = protoFrameCache.kCSMsgHeartBeat
	local specEntry = clientPkg["csp.heart_beat_c"]

	specEntry.count = count
	specEntry.data = data

	RPC._packAndSend(clientPkg)
end

function RPC.netDelay(ms)
	local clientPkg = protoFrameCache.kCSMsgNetDelay
	local specEntry = clientPkg["csp.net_delay_c"]

	specEntry.ms = ms

	RPC._packAndSend(clientPkg)
end

function RPC.chatHeartBeat()
	local clientPkg = protoFrameCache.kCSMsgChatHeartBeat
	local specEntry = clientPkg["csp.chat_heartbeat_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.chatChannelList()
	local clientPkg = protoFrameCache.kCSMsgChatChannelList
	local specEntry = clientPkg["csp.chat_channel_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.zChatRegister()
	local clientPkg = protoFrameCache.kCSMsgZChatRegister
	local specEntry = clientPkg["csp.zchat_register_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.zChatSend(channel, ruid, rname, content, voice_id, voice_time, curr_uids, sub_channel)
	local clientPkg = protoFrameCache.kCSMsgZChatSend
	local specEntry = clientPkg["csp.zchat_send_c"]

	specEntry.channel = channel
	specEntry.ruid = ruid
	specEntry.rname = rname
	specEntry.content = content
	specEntry.voice_id = voice_id
	specEntry.voice_time = voice_time
	specEntry.curr_uids = curr_uids
	specEntry.sub_channel = sub_channel

	RPC._packAndSend(clientPkg)
end

function RPC.chatPull(channel, seq)
	local clientPkg = protoFrameCache.kCSMsgChatPull
	local specEntry = clientPkg["csp.chat_pull_c"]

	specEntry.channel = channel
	specEntry.seq = seq

	RPC._packAndSend(clientPkg)
end

function RPC.zChatReport(msg, channel, sub_channel, reason)
	local clientPkg = protoFrameCache.kCSMsgZChatReport
	local specEntry = clientPkg["csp.zchat_report_c"]

	specEntry.msg = msg
	specEntry.channel = channel
	specEntry.sub_channel = sub_channel
	specEntry.reason = reason

	RPC._packAndSend(clientPkg)
end

function RPC.wChatRegister()
	local clientPkg = protoFrameCache.kCSMsgWChatRegister
	local specEntry = clientPkg["csp.chat_register_c"]

	RPC._packAndSend(clientPkg)
end

function RPC.wChatChannelChange(data)
	local clientPkg = protoFrameCache.kCSMsgWChatChannelChange
	local specEntry = clientPkg["csp.chat_channel_change_c"]

	specEntry.data = data

	RPC._packAndSend(clientPkg)
end

function RPC.dispatch(msgTable)
	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_RECV, msgTable)

	local agent = RPC._agent

	if agent == false then
		return
	end

	local msgID = msgTable.head.cmd
	local ecode = msgTable.head.ecode

	if RPC.SendTimes[msgID] then
		RPC.SendTimes[msgID] = nil
	end

	if ecode ~= "kCSErrorNone" and ecode ~= "kCSErrorDefault" then
		local funcName = agent.onErrorCodeResp

		if not funcName or not funcName(agent, msgID, ecode) then
			local msgTitle = Lang.get(29942)
			local msgContent = "RPC.dispatch kCSError, ecode = " .. ecode .. ", msgID = " .. msgID

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, msgTitle, msgContent)
		end

		local dict2ListFuncName = RPC._msgRespDict2ListMap[msgID]

		if RPC[dict2ListFuncName] then
			local msgList = RPC[dict2ListFuncName](msgTable)
			local msgCBFuncName = RPC._msgRespCBMap[msgID]

			msgCBFuncName = msgCBFuncName .. "Error"

			local funcName = agent[msgCBFuncName]

			if funcName then
				funcName(agent, ecode, unpack(msgList))
			end
		end

		return
	end

	local dict2ListFuncName = RPC._msgRespDict2ListMap[msgID]

	if RPC[dict2ListFuncName] then
		local msgList = RPC[dict2ListFuncName](msgTable)
		local msgCBFuncName = RPC._msgRespCBMap[msgID]
		local funcName = agent[msgCBFuncName]

		if funcName then
			funcName(agent, unpack(msgList))
		end
	end
end

RPC._CachedList0 = {}
RPC._CachedList1 = {}
RPC._CachedList2 = {}
RPC._CachedList3 = {}
RPC._CachedList4 = {}
RPC._CachedList5 = {}
RPC._CachedList6 = {}
RPC._CachedList7 = {}
RPC._CachedList8 = {}
RPC._CachedList10 = {}
RPC._CachedList13 = {}
RPC._CachedList18 = {}

function RPC._dict2ListForRoleLoginQueueNotify(msgTable)
	local msgBodyTable = msgTable["csp.role_login_queue_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.estimate_time or 0
	msgList[2] = msgBodyTable.seat_no or 0
	msgList[3] = msgBodyTable.total_lineup or 0

	return msgList
end

function RPC._dict2ListForRoleLeaveLoginQueue(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForRoleLogin(msgTable)
	local msgBodyTable = msgTable["csp.role_login_s"]
	local msgList = RPC._CachedList18

	msgList[1] = msgBodyTable.respid or "kRoleLoginNoError"
	msgList[2] = msgBodyTable.enter_game or {}
	msgList[3] = msgBodyTable.deprecate_reconnect or 0
	msgList[4] = msgBodyTable.roomid or ""
	msgList[5] = msgBodyTable.freeze_info or {}
	msgList[6] = msgBodyTable.open_zone_time or 0
	msgList[7] = msgBodyTable.cur_tick or 0
	msgList[8] = msgBodyTable.svrmark_info or {}
	msgList[9] = msgBodyTable.all_data_num or 0
	msgList[10] = msgBodyTable.create_tick or 0
	msgList[11] = msgBodyTable.res_version or 0
	msgList[12] = msgBodyTable.notice or ""
	msgList[13] = msgBodyTable.switch or {}
	msgList[14] = msgBodyTable.objgid or ""
	msgList[15] = msgBodyTable.zone_first_nid or 0
	msgList[16] = msgBodyTable.time_zone or 0
	msgList[17] = msgBodyTable.antiaddiction_data or {}
	msgList[18] = msgBodyTable.country or ""

	return msgList
end

function RPC._dict2ListForRoleRandName(msgTable)
	local msgBodyTable = msgTable["csp.role_rand_name_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gender or 0
	msgList[2] = msgBodyTable.name or ""

	return msgList
end

function RPC._dict2ListForRoleRename(msgTable)
	local msgBodyTable = msgTable["csp.role_rename_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.resp_code or "kRoleRenameNoError"
	msgList[2] = msgBodyTable.next_rename_tick or 0
	msgList[3] = msgBodyTable.name or ""
	msgList[4] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForRoleCreate(msgTable)
	local msgBodyTable = msgTable["csp.role_create_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.resp_code or "kRoleCreateNoError"
	msgList[2] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForRoleInfo(msgTable)
	local msgBodyTable = msgTable["csp.role_info_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.resp_code or "kRoleCreateNoError"
	msgList[2] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForRoleLogoutNotify(msgTable)
	local msgBodyTable = msgTable["csp.role_logout_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.reason or "kRoleLogoutReasonUnknown"

	return msgList
end

function RPC._dict2ListForRoleLoginDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.role_login_data_notify"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.idx or 0
	msgList[2] = msgBodyTable.type or "kRoleLoginDataTypeNone"
	msgList[3] = msgBodyTable.bag or {}
	msgList[4] = msgBodyTable.other or {}
	msgList[5] = msgBodyTable.equip_scheme or {}
	msgList[6] = msgBodyTable.other_bag or {}

	return msgList
end

function RPC._dict2ListForGeneralAttrNotify(msgTable)
	local msgBodyTable = msgTable["csp.general_attr_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.attr32 or {}
	msgList[2] = msgBodyTable.attr64 or {}

	return msgList
end

function RPC._dict2ListForExecuteGM(msgTable)
	local msgBodyTable = msgTable["csp.gm_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.respid or "kGMExecuteNoError"
	msgList[2] = msgBodyTable.gmres or ""

	return msgList
end

function RPC._dict2ListForGMMsgNotify(msgTable)
	local msgBodyTable = msgTable["csp.gm_msg_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.cmd or ""
	msgList[2] = msgBodyTable.result or ""

	return msgList
end

function RPC._dict2ListForErrorPromptNotify(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForSystemSwitchNotify(msgTable)
	local msgBodyTable = msgTable["csp.system_switch_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.sys_switch or {}

	return msgList
end

function RPC._dict2ListForErrorBagFullNotify(msgTable)
	local msgBodyTable = msgTable["csp.bag_full_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item_id or 0

	return msgList
end

function RPC._dict2ListForDayCounterResetNotify(msgTable)
	local msgBodyTable = msgTable["csp.day_counter_reset_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.dayend or 0

	return msgList
end

function RPC._dict2ListForWeekCounterResetNotify(msgTable)
	local msgBodyTable = msgTable["csp.week_counter_reset_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.weekend or 0

	return msgList
end

function RPC._dict2ListForDayICounterNotify(msgTable)
	local msgBodyTable = msgTable["csp.day_icounter_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or "kDayICounterIDNone"
	msgList[2] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForWeekICounterNotify(msgTable)
	local msgBodyTable = msgTable["csp.week_icounter_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or "kWeekICounterIDNone"
	msgList[2] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForDayTICounterNotify(msgTable)
	local msgBodyTable = msgTable["csp.day_ticounter_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForWeekTICounterNotify(msgTable)
	local msgBodyTable = msgTable["csp.week_ticounter_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForMonthTICounterNotify(msgTable)
	local msgBodyTable = msgTable["csp.month_ticounter_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForMonthCounterResetNotify(msgTable)
	local msgBodyTable = msgTable["csp.month_counter_reset_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.monthend or 0

	return msgList
end

function RPC._dict2ListForTimeCounterNotify(msgTable)
	local msgBodyTable = msgTable["csp.time_counter_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.counter or {}

	return msgList
end

function RPC._dict2ListForForeverTICounterNotify(msgTable)
	local msgBodyTable = msgTable["csp.forever_ticounter_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForMailNotify(msgTable)
	local msgBodyTable = msgTable["csp.mail_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.mail or {}

	return msgList
end

function RPC._dict2ListForMailUpdate(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForMailGetAttach(msgTable)
	local msgBodyTable = msgTable["csp.mail_get_attach_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.mailid or ""
	msgList[2] = msgBodyTable.code or 0

	return msgList
end

function RPC._dict2ListForMailReport(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForMailRecallNotify(msgTable)
	local msgBodyTable = msgTable["csp.mail_recall_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.pmailid or ""

	return msgList
end

function RPC._dict2ListForBuddyAdd(msgTable)
	local msgBodyTable = msgTable["csp.buddy_add_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForBuddyDel(msgTable)
	local msgBodyTable = msgTable["csp.buddy_del_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForBuddyInfoNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_info_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.buddy or {}
	msgList[2] = msgBodyTable.gift_info or {}

	return msgList
end

function RPC._dict2ListForBuddyAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_add_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.buddy or {}

	return msgList
end

function RPC._dict2ListForBuddyDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_del_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForBuddyInviteOp(msgTable)
	local msgBodyTable = msgTable["csp.buddy_invite_op_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.optype or "kBuddyInviteNone"
	msgList[3] = msgBodyTable.fail or {}
	msgList[4] = msgBodyTable.has_more or 0

	return msgList
end

function RPC._dict2ListForBuddyInviteNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_invite_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.invite or {}

	return msgList
end

function RPC._dict2ListForBuddyInviteAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_invite_add_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.invite or {}

	return msgList
end

function RPC._dict2ListForBuddyInviteDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_invite_del_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForBuddySearch(msgTable)
	local msgBodyTable = msgTable["csp.buddy_search_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.result or {}
	msgList[2] = msgBodyTable.resp_code or "kBuddySearchCodeSuccess"

	return msgList
end

function RPC._dict2ListForBuddyBlackListAdd(msgTable)
	local msgBodyTable = msgTable["csp.buddy_black_add_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForBuddyBlackListDel(msgTable)
	local msgBodyTable = msgTable["csp.buddy_black_del_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForBuddyBlackListNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_black_list_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.black or {}

	return msgList
end

function RPC._dict2ListForBuddyRecommend(msgTable)
	local msgBodyTable = msgTable["csp.buddy_recommend_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.recommend or {}

	return msgList
end

function RPC._dict2ListForBuddyUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.buddys or {}

	return msgList
end

function RPC._dict2ListForBuddyGiftOp(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForBuddyOnline(msgTable)
	local msgBodyTable = msgTable["csp.buddy_online_s"]
	local msgList = RPC._CachedList8

	msgList[1] = msgBodyTable.info or {}
	msgList[2] = msgBodyTable.black or "[]"
	msgList[3] = msgBodyTable.invite or "[]"
	msgList[4] = msgBodyTable.gift or {}
	msgList[5] = msgBodyTable.master or {}
	msgList[6] = msgBodyTable.apprentice or {}
	msgList[7] = msgBodyTable.master_invite or "[]"
	msgList[8] = msgBodyTable.apprentice_invite or "[]"

	return msgList
end

function RPC._dict2ListForBuddyOp(msgTable)
	local msgBodyTable = msgTable["csp.buddy_op_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.op or {}
	msgList[2] = msgBodyTable.gift_change or {}
	msgList[3] = msgBodyTable.gift or {}

	return msgList
end

function RPC._dict2ListForBuddySocialNotify(msgTable)
	local msgBodyTable = msgTable["csp.buddy_social_info_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.info or {}
	msgList[2] = msgBodyTable.gift or {}

	return msgList
end

function RPC._dict2ListForBuddyBondSet(msgTable)
	local msgBodyTable = msgTable["csp.buddy_bond_set_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.bond or 0

	return msgList
end

function RPC._dict2ListForOperateEventNotify(msgTable)
	local msgBodyTable = msgTable["csp.opreate_event_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.notify or {}

	return msgList
end

function RPC._dict2ListForOperateEventCompleteNotify(msgTable)
	local msgBodyTable = msgTable["csp.opreate_event_complete_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForOpActivityStateNotify(msgTable)
	local msgBodyTable = msgTable["csp.opactivity_state_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.isall or 0
	msgList[2] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForOpActivityData(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForOpActivityMgrDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.opactivity_mgr_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.item or {}
	msgList[2] = msgBodyTable.isall or 0

	return msgList
end

function RPC._dict2ListForOpActivitySysDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.opactivity_sys_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.data or {}
	msgList[2] = msgBodyTable.opened_bit or ""

	return msgList
end

function RPC._dict2ListForOpActivityRoleDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.opactivity_role_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.data or {}
	msgList[2] = msgBodyTable.isall or 0

	return msgList
end

function RPC._dict2ListForClanOpActClanDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_opact_clan_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.clangid or 0
	msgList[2] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForClanOpActMemberDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_opact_member_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForResidentOpActivityMgrDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.resident_opactivity_mgr_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForResidentOpActivitySysDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.resident_opactivity_sys_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.data or {}
	msgList[2] = msgBodyTable.opened_bit or ""

	return msgList
end

function RPC._dict2ListForResidentOpActivityRoleDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.resident_opactivity_role_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForHotfixVersionNotify(msgTable)
	local msgBodyTable = msgTable["csp.hotfix_version_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hostfix or {}
	msgList[2] = msgBodyTable.total or 0
	msgList[3] = msgBodyTable.current or 0

	return msgList
end

function RPC._dict2ListForGagInfoNotify(msgTable)
	local msgBodyTable = msgTable["csp.gag_info_noitfy"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.gagflag or 0
	msgList[2] = msgBodyTable.gagfreetime or 0
	msgList[3] = msgBodyTable.gagreason or 0

	return msgList
end

function RPC._dict2ListForGagGSInfoNotify(msgTable)
	local msgBodyTable = msgTable["csp.gag_gs_info_noitfy"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.isgs or 0

	return msgList
end

function RPC._dict2ListForGagGSSetGag(msgTable)
	local msgBodyTable = msgTable["csp.gag_gs_set_gag_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.status or 0
	msgList[2] = msgBodyTable.end_time or 0

	return msgList
end

function RPC._dict2ListForOpActGetAward(msgTable)
	local msgBodyTable = msgTable["csp.opact_get_award_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.index or 0
	msgList[3] = msgBodyTable.param or 0

	return msgList
end

function RPC._dict2ListForMonopolyRoll(msgTable)
	local msgBodyTable = msgTable["csp.monopoly_roll_s"]
	local msgList = RPC._CachedList10

	msgList[1] = msgBodyTable.type or "kDiceTypeNone"
	msgList[2] = msgBodyTable.point or 0
	msgList[3] = msgBodyTable.move_to or {}
	msgList[4] = msgBodyTable.pass_award or {}
	msgList[5] = msgBodyTable.index or 0
	msgList[6] = msgBodyTable.activity_id or 0
	msgList[7] = msgBodyTable.event_id or 0
	msgList[8] = msgBodyTable.item_event or {}
	msgList[9] = msgBodyTable.lib_data or {}
	msgList[10] = msgBodyTable.item_count or {}

	return msgList
end

function RPC._dict2ListForMonopolyExchange(msgTable)
	local msgBodyTable = msgTable["csp.monopoly_exchange_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.activity_id or 0
	msgList[2] = msgBodyTable.type or "kDiceTypeNone"
	msgList[3] = msgBodyTable.count or 0
	msgList[4] = msgBodyTable.num or 0

	return msgList
end

function RPC._dict2ListForBingoDraw(msgTable)
	local msgBodyTable = msgTable["csp.bingo_draw_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.activity_id or 0
	msgList[2] = msgBodyTable.index or {}

	return msgList
end

function RPC._dict2ListForBingoNextRound(msgTable)
	local msgBodyTable = msgTable["csp.bingo_next_round_notify"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.activity_id or 0
	msgList[2] = msgBodyTable.round or 0
	msgList[3] = msgBodyTable.big_reward_id or 0
	msgList[4] = msgBodyTable.big_reward_times or 0
	msgList[5] = msgBodyTable.new_big_reward_id or 0

	return msgList
end

function RPC._dict2ListForBingoSetBigReward(msgTable)
	local msgBodyTable = msgTable["csp.bingo_set_big_reward_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.activity_id or 0
	msgList[2] = msgBodyTable.reward_id or 0

	return msgList
end

function RPC._dict2ListForOpActDraw(msgTable)
	local msgBodyTable = msgTable["csp.opact_draw_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForOpActSetFocus(msgTable)
	local msgBodyTable = msgTable["csp.opact_set_focus_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.miss_focus or 0

	return msgList
end

function RPC._dict2ListForOpActPlotGetRank(msgTable)
	local msgBodyTable = msgTable["csp.opact_plot_get_rank_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.index or 0
	msgList[3] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForOpActLotteryAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_lottery_add_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.cdkey or {}

	return msgList
end

function RPC._dict2ListForOpActOnHookRoleDeliver(msgTable)
	local msgBodyTable = msgTable["csp.opact_onhook_deliver_resp"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.item_index or 0
	msgList[3] = msgBodyTable.food_id or 0

	return msgList
end

function RPC._dict2ListForOpActMonopolySetLibAward(msgTable)
	local msgBodyTable = msgTable["csp.opact_Monopoly_set_lib_award_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.lib_id or 0
	msgList[3] = msgBodyTable.index or 0

	return msgList
end

function RPC._dict2ListForOpActMonopolyUseItem(msgTable)
	local msgBodyTable = msgTable["csp.opact_Monopoly_use_item_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.item_event or {}

	return msgList
end

function RPC._dict2ListForOpActHatsuneCheerConvertNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_hatsune_cheer_convert_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.convert_cheer or 0
	msgList[3] = msgBodyTable.award_id or 0
	msgList[4] = msgBodyTable.num or 0

	return msgList
end

function RPC._dict2ListForOpActClanBossDispatch(msgTable)
	local msgBodyTable = msgTable["csp.opact_clan_boss_dispatch_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.boss_id or 0
	msgList[3] = msgBodyTable.layer or 0
	msgList[4] = msgBodyTable.gid or "[]"
	msgList[5] = msgBodyTable.tick or 0
	msgList[6] = msgBodyTable.score or 0

	return msgList
end

function RPC._dict2ListForOpActClanBossGetStageAward(msgTable)
	local msgBodyTable = msgTable["csp.opact_clan_boss_get_stage_award_s"]
	local msgList = RPC._CachedList7

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.boss_id or 0
	msgList[3] = msgBodyTable.layer or 0
	msgList[4] = msgBodyTable.index or 0
	msgList[5] = msgBodyTable.award_id or 0
	msgList[6] = msgBodyTable.score or 0
	msgList[7] = msgBodyTable.round or 0

	return msgList
end

function RPC._dict2ListForOpActFlottoryDraw(msgTable)
	local msgBodyTable = msgTable["csp.opact_flottory_draw_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.award or {}

	return msgList
end

function RPC._dict2ListForOpActFlottorySetSelIndex(msgTable)
	local msgBodyTable = msgTable["csp.opact_flottory_set_sel_index_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActCollectWordsGetDeposit(msgTable)
	local msgBodyTable = msgTable["csp.opact_collectwords_get_deposit_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.item_id or 0

	return msgList
end

function RPC._dict2ListForOpActCollectWordsRecvWord(msgTable)
	local msgBodyTable = msgTable["csp.opact_collectwords_recv_word_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.item_id or 0

	return msgList
end

function RPC._dict2ListForOpActCollectWordsComposeWord(msgTable)
	local msgBodyTable = msgTable["csp.opact_collectwords_compose_word_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.times or 0

	return msgList
end

function RPC._dict2ListForOpActCollectWordsGetBuddyWord(msgTable)
	local msgBodyTable = msgTable["csp.opact_collectwords_get_buddy_info_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.uid or {}

	return msgList
end

function RPC._dict2ListForOpActAchieveExchangeItem(msgTable)
	local msgBodyTable = msgTable["csp.opact_achieve_exchange_item_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.exchange_id or 0
	msgList[3] = msgBodyTable.num or 0

	return msgList
end

function RPC._dict2ListForOpActChatGameMakeChocolete(msgTable)
	local msgBodyTable = msgTable["csp.opact_chatgame_make_chocolete_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.gift_id or 0
	msgList[3] = msgBodyTable.material_num or {}

	return msgList
end

function RPC._dict2ListForOpActChatGameChooseBranch(msgTable)
	local msgBodyTable = msgTable["csp.opact_chatgame_choose_branch_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.node_id or 0

	return msgList
end

function RPC._dict2ListForOpActChatGameChatEnd(msgTable)
	local msgBodyTable = msgTable["csp.opact_chatgame_chat_end_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.result or 0

	return msgList
end

function RPC._dict2ListForOpActChatGameResetChat(msgTable)
	local msgBodyTable = msgTable["csp.opact_chatgame_reset_chat_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActGuessChooseAnswer(msgTable)
	local msgBodyTable = msgTable["csp.opact_guess_choose_answer_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.stage_id or 0
	msgList[3] = msgBodyTable.answer_id or 0
	msgList[4] = msgBodyTable.award_id or 0
	msgList[5] = msgBodyTable.right_number or 0
	msgList[6] = msgBodyTable.wrong_number or 0

	return msgList
end

function RPC._dict2ListForOpActGuessAwardInfuse(msgTable)
	local msgBodyTable = msgTable["csp.opact_guess_award_infuse_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.stage_id or 0
	msgList[3] = msgBodyTable.award or 0
	msgList[4] = msgBodyTable.right_number or 0
	msgList[5] = msgBodyTable.wrong_number or 0

	return msgList
end

function RPC._dict2ListForOpActGuessGetRank(msgTable)
	local msgBodyTable = msgTable["csp.opact_guess_get_rank_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.member or {}

	return msgList
end

function RPC._dict2ListForOpActGuessGetTotalAward(msgTable)
	local msgBodyTable = msgTable["csp.opact_guess_get_total_award_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.personal_award or 0
	msgList[2] = msgBodyTable.clan_award or 0

	return msgList
end

function RPC._dict2ListForOpActGuessSettleNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_guess_settle_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.settle or {}

	return msgList
end

function RPC._dict2ListForOpActGuessIsRight(msgTable)
	local msgBodyTable = msgTable["csp.opact_guess_is_right_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.stage_id or 0
	msgList[3] = msgBodyTable.clan_gid or 0

	return msgList
end

function RPC._dict2ListForOpActBusinessMaterialProduct(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_material_product_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.product_info or {}

	return msgList
end

function RPC._dict2ListForOpActBusinessMaterialCompose(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_material_compose_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.compose_info or {}
	msgList[3] = msgBodyTable.move or {}

	return msgList
end

function RPC._dict2ListForOpActBusinessStaminaReceive(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_stamina_receive_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.buddy_uid or "[]"

	return msgList
end

function RPC._dict2ListForOpActBusinessStaminaDonated(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_stamina_donated_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.buddy_uid or "[]"

	return msgList
end

function RPC._dict2ListForOpActBusinessOrderCommit(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_order_commit_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.order_gid or 0
	msgList[3] = msgBodyTable.grid_pos or {}
	msgList[4] = msgBodyTable.move or {}

	return msgList
end

function RPC._dict2ListForOpActBusinessOrderUpdate(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_order_update_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.order_gid or 0
	msgList[3] = msgBodyTable.order or {}

	return msgList
end

function RPC._dict2ListForOpActBusinessMaterialUpgrade(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_material_upgrade_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.grid_pos or 0
	msgList[3] = msgBodyTable.grid or {}

	return msgList
end

function RPC._dict2ListForOpActBusinessMaterialDelete(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_material_delete_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.grid_pos or 0
	msgList[3] = msgBodyTable.move or {}

	return msgList
end

function RPC._dict2ListForOpActBusinessPermissionAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_business_permission_add_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.permission_type or 0
	msgList[3] = msgBodyTable.param or {}

	return msgList
end

function RPC._dict2ListForOpActTurnTableDraw(msgTable)
	local msgBodyTable = msgTable["csp.opact_turntable_draw_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForGiftDrawWinnersListGet(msgTable)
	local msgBodyTable = msgTable["csp.giftdraw_winner_list_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.level_list or {}

	return msgList
end

function RPC._dict2ListForGiftDrawResultNotify(msgTable)
	local msgBodyTable = msgTable["csp.giftdraw_result_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.round or 0
	msgList[4] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForGiftDrawGiftShare(msgTable)
	local msgBodyTable = msgTable["csp.giftdraw_share_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForOpActEquipMakeChoose(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_make_choose_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.type or "kEquipMakeChooseTypePos"
	msgList[3] = msgBodyTable.equip or {}

	return msgList
end

function RPC._dict2ListForOpActEquipMakeRand(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_make_rand_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.type or "kEquipMakeChooseTypePos"

	return msgList
end

function RPC._dict2ListForOpActEquipBaptizeChoose(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_baptize_choose_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActEquipBaptizeInit(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_baptize_init_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActEquipBaptizeRandAttr(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_baptize_rand_attr_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActEquipBaptizeDone(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_baptize_done_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.equip or {}

	return msgList
end

function RPC._dict2ListForOpActEquipBaptizeAttrLock(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_baptize_attr_lock_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.pos or 0

	return msgList
end

function RPC._dict2ListForOpActDrawNewbieUpDraw(msgTable)
	local msgBodyTable = msgTable["csp.opact_drawnewbieup_draw_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.career_id or 0
	msgList[3] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForOpActDrawNewbieUpNewCycle(msgTable)
	local msgBodyTable = msgTable["csp.opact_drawnewbieup_new_cycle_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.new_cycle or 0

	return msgList
end

function RPC._dict2ListForOpActRandReplaceSet(msgTable)
	local msgBodyTable = msgTable["csp.opact_rand_replace_set_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.group_id or 0
	msgList[3] = msgBodyTable.index or 0

	return msgList
end

function RPC._dict2ListForOpActDrawNewbieCampDraw(msgTable)
	local msgBodyTable = msgTable["csp.opact_drawnewbiecamp_draw_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForOpActDrawSeasonDraw(msgTable)
	local msgBodyTable = msgTable["csp.opact_drawseason_draw_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.pair or {}

	return msgList
end

function RPC._dict2ListForOpActEquipRecycleChoose(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_recycle_choose_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.op_type or "kEquipRecycleOpTypeNone"
	msgList[3] = msgBodyTable.equip_gid or ""
	msgList[4] = msgBodyTable.workshop or 0

	return msgList
end

function RPC._dict2ListForOpActEquipRecycleStart(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_recycle_start_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.workshop or 0

	return msgList
end

function RPC._dict2ListForOpActEquipRecycleStop(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_recycle_stop_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.workshop or 0
	msgList[3] = msgBodyTable.need_clear or 0

	return msgList
end

function RPC._dict2ListForOpActEquipRecycleGetAward(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_recycle_get_award_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.equip or {}
	msgList[3] = msgBodyTable.workshop or 0

	return msgList
end

function RPC._dict2ListForOpActEquipRecycleUnlockWorkShop(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_recycle_unlock_workshop_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActEquipRecycleNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_equip_recycle_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.equip or {}

	return msgList
end

function RPC._dict2ListForOpActSeasonBPPointGet(msgTable)
	local msgBodyTable = msgTable["csp.opact_seasonbp_point_get_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.count or 0
	msgList[3] = msgBodyTable.reason or 0
	msgList[4] = msgBodyTable.param or 0

	return msgList
end

function RPC._dict2ListForHeroStickLevelNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_stick_level_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_id or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForRechargeGenerateOrderID(msgTable)
	local msgBodyTable = msgTable["csp.recharge_generate_orderid_s"]
	local msgList = RPC._CachedList10

	msgList[1] = msgBodyTable.resp_code or "kGenOrderIDCodeDefault"
	msgList[2] = msgBodyTable.svr_nodeid or 0
	msgList[3] = msgBodyTable.channel_account or ""
	msgList[4] = msgBodyTable.recharge_id or 0
	msgList[5] = msgBodyTable.product_id or ""
	msgList[6] = msgBodyTable.orderid or ""
	msgList[7] = msgBodyTable.extend_info or ""
	msgList[8] = msgBodyTable.opensvr_code or 0
	msgList[9] = msgBodyTable.anti_data or {}
	msgList[10] = msgBodyTable.gift_type or 0

	return msgList
end

function RPC._dict2ListForRechargeCancelOrder(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForRechargeListGet(msgTable)
	local msgBodyTable = msgTable["csp.recharge_list_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.recharge_info or {}

	return msgList
end

function RPC._dict2ListForRechargeDeliverNotify(msgTable)
	local msgBodyTable = msgTable["csp.recharge_deliver_notify"]
	local msgList = RPC._CachedList10

	msgList[1] = msgBodyTable.recharge_id or 0
	msgList[2] = msgBodyTable.order_id or ""
	msgList[3] = msgBodyTable.deliver_num or 0
	msgList[4] = msgBodyTable.deliver_online or 0
	msgList[5] = msgBodyTable.item_id or 0
	msgList[6] = msgBodyTable.normal_item or {}
	msgList[7] = msgBodyTable.expect_item or {}
	msgList[8] = msgBodyTable.deliver_free_num or 0
	msgList[9] = msgBodyTable.pay_currency or ""
	msgList[10] = msgBodyTable.use_refund or 0

	return msgList
end

function RPC._dict2ListForRechargeRoleFirstAwardNotify(msgTable)
	local msgBodyTable = msgTable["csp.recharge_first_award_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.recharge or {}

	return msgList
end

function RPC._dict2ListForRechargeMulityNotify(msgTable)
	local msgBodyTable = msgTable["csp.recharge_mulity_award_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForRechargeCanBuyCountNotify(msgTable)
	local msgBodyTable = msgTable["csp.recharge_can_buy_count_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForRechargeListNotify(msgTable)
	local msgBodyTable = msgTable["csp.recharge_list_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.recharge_info or {}

	return msgList
end

function RPC._dict2ListForRechargeFirstNotify(msgTable)
	local msgBodyTable = msgTable["csp.recharge_first_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.recharge_info or {}

	return msgList
end

function RPC._dict2ListForSubscribeDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.sub_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForSubscribeGetAward(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForListAttrNotify(msgTable)
	local msgBodyTable = msgTable["csp.list_attr_notify"]
	local msgList = RPC._CachedList13

	msgList[1] = msgBodyTable.type or "kListAttrUseTypeNone"
	msgList[2] = msgBodyTable.attr or {}
	msgList[3] = msgBodyTable.item or {}
	msgList[4] = msgBodyTable.hero or {}
	msgList[5] = msgBodyTable.equip or {}
	msgList[6] = msgBodyTable.artifact or {}
	msgList[7] = msgBodyTable.special or {}
	msgList[8] = msgBodyTable.param or 0
	msgList[9] = msgBodyTable.relic or {}
	msgList[10] = msgBodyTable.info or {}
	msgList[11] = msgBodyTable.pet or {}
	msgList[12] = msgBodyTable.pet_amulet or {}
	msgList[13] = msgBodyTable.pet_gem or {}

	return msgList
end

function RPC._dict2ListForDraw(msgTable)
	local msgBodyTable = msgTable["csp.draw_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForDrawNewbie(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForDrawDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.draw_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.draw or {}

	return msgList
end

function RPC._dict2ListForDrawDayCampNotify(msgTable)
	local msgBodyTable = msgTable["csp.draw_day_camp_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.day_camp or 0

	return msgList
end

function RPC._dict2ListForDrawNebieBestChange(msgTable)
	local msgBodyTable = msgTable["csp.draw_best_change_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.is_succ or 0

	return msgList
end

function RPC._dict2ListForDrawRecord(msgTable)
	local msgBodyTable = msgTable["csp.draw_record_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.act_id or 0
	msgList[3] = msgBodyTable.seq or 0
	msgList[4] = msgBodyTable.record or {}
	msgList[5] = msgBodyTable.param or 0

	return msgList
end

function RPC._dict2ListForDrawSetDesire(msgTable)
	local msgBodyTable = msgTable["csp.draw_set_desire_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.desire_list or {}

	return msgList
end

function RPC._dict2ListForPetDrawRest(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForPetDrawSelect(msgTable)
	local msgBodyTable = msgTable["csp.pet_draw_select_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gashapon_id or 0
	msgList[2] = msgBodyTable.select_item_id or 0

	return msgList
end

function RPC._dict2ListForDesireRecommendNotify(msgTable)
	local msgBodyTable = msgTable["csp.desire_recommend_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.desire_recommend or {}

	return msgList
end

function RPC._dict2ListForDrawNewbieReset(msgTable)
	local msgBodyTable = msgTable["csp.draw_newbie_reset_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.reset_count or 0

	return msgList
end

function RPC._dict2ListForPVEStart(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForPVEStartNotify(msgTable)
	local msgBodyTable = msgTable["csp.pve_start_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.start or {}

	return msgList
end

function RPC._dict2ListForPVEFinish(msgTable)
	local msgBodyTable = msgTable["csp.pve_finish_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.type or "kBattleTypeNone"
	msgList[2] = msgBodyTable.result or "kPVEResultResultTypeWin"
	msgList[3] = msgBodyTable.finish or {}
	msgList[4] = msgBodyTable.can_share or 0

	return msgList
end

function RPC._dict2ListForPVEQuit(msgTable)
	local msgBodyTable = msgTable["csp.pve_quit_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kBattleTypeNone"
	msgList[2] = msgBodyTable.finish or {}

	return msgList
end

function RPC._dict2ListForPVEBattleReplay(msgTable)
	local msgBodyTable = msgTable["csp.pve_battle_replay_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForPVEShare(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForPVEAutoBattle(msgTable)
	local msgBodyTable = msgTable["csp.pve_auto_battle_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or "kBattleTypeNone"
	msgList[2] = msgBodyTable.result or "kPVEResultResultTypeWin"
	msgList[3] = msgBodyTable.finish or {}

	return msgList
end

function RPC._dict2ListForPVEAutoBattlePowerNotify(msgTable)
	local msgBodyTable = msgTable["csp.pve_auto_battle_power_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.power or {}

	return msgList
end

function RPC._dict2ListForFormationUpdate(msgTable)
	local msgBodyTable = msgTable["csp.formation_update_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.pos or 0
	msgList[2] = msgBodyTable.item or {}
	msgList[3] = msgBodyTable.pet or 0

	return msgList
end

function RPC._dict2ListForFormationDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.formation_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.item or {}
	msgList[2] = msgBodyTable.use_pos or 0

	return msgList
end

function RPC._dict2ListForFormationSelect(msgTable)
	local msgBodyTable = msgTable["csp.formation_select_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.pos or 0

	return msgList
end

function RPC._dict2ListForFormationsUpdateByType(msgTable)
	local msgBodyTable = msgTable["csp.formation_update_by_type_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSFormationsTypeNone"
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForFormationSnapshot(msgTable)
	local msgBodyTable = msgTable["csp.formation_snapshot_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.pos or 0
	msgList[2] = msgBodyTable.snapshot or 0

	return msgList
end

function RPC._dict2ListForFormationSnapshotSwapIdx(msgTable)
	local msgBodyTable = msgTable["csp.formation_snapshot_swap_idx_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.pos or 0
	msgList[2] = msgBodyTable.idx or {}

	return msgList
end

function RPC._dict2ListForFormationSnapshotGet(msgTable)
	local msgBodyTable = msgTable["csp.formation_snapshot_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForFormationsUpdateByPos(msgTable)
	local msgBodyTable = msgTable["csp.formation_update_by_pos_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForStageDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.stage_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.stage or {}

	return msgList
end

function RPC._dict2ListForStageUnlockNext(msgTable)
	local msgBodyTable = msgTable["csp.stage_unlock_next_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.succ or 0

	return msgList
end

function RPC._dict2ListForEnergyUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.energy_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.time or 0

	return msgList
end

function RPC._dict2ListForStageRecord(msgTable)
	local msgBodyTable = msgTable["csp.stage_record_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.season or 0
	msgList[2] = msgBodyTable.chapter or 0
	msgList[3] = msgBodyTable.level or 0
	msgList[4] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForStageSkip(msgTable)
	local msgBodyTable = msgTable["csp.stage_skip_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.season or 0
	msgList[2] = msgBodyTable.chapter or 0
	msgList[3] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForDepositAwardRefresh(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForDepositAwardGet(msgTable)
	local msgBodyTable = msgTable["csp.deposit_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForDepositAwardNotify(msgTable)
	local msgBodyTable = msgTable["csp.deposit_award_notify"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.assgin_tick or 0
	msgList[2] = msgBodyTable.type or "kDepositTypeNone"
	msgList[3] = msgBodyTable.award or {}
	msgList[4] = msgBodyTable.get_tick or 0
	msgList[5] = msgBodyTable.fix_award or {}

	return msgList
end

function RPC._dict2ListForDepositAwardStart(msgTable)
	local msgBodyTable = msgTable["csp.deposit_start_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.level or 0
	msgList[2] = msgBodyTable.season or 0
	msgList[3] = msgBodyTable.chapter or 0

	return msgList
end

function RPC._dict2ListForTowerDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.tower_data_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.tower or {}
	msgList[2] = msgBodyTable.record or 0
	msgList[3] = msgBodyTable.layer_star_count or 0

	return msgList
end

function RPC._dict2ListForTowerStarAwardGet(msgTable)
	local msgBodyTable = msgTable["csp.tower_star_award_get_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.award or 0

	return msgList
end

function RPC._dict2ListForTowerSweep(msgTable)
	local msgBodyTable = msgTable["csp.tower_sweep_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForPowerUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.power_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.time or 0

	return msgList
end

function RPC._dict2ListForTowerPlayClearNotify(msgTable)
	local msgBodyTable = msgTable["csp.tower_play_clear_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.time or 0

	return msgList
end

function RPC._dict2ListForEquipGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.equip_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.new_list or {}

	return msgList
end

function RPC._dict2ListForEquipDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.equip_del_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.gid_list or "[]"

	return msgList
end

function RPC._dict2ListForEquipWear(msgTable)
	local msgBodyTable = msgTable["csp.equip_wear_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero or ""
	msgList[2] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForEquipOff(msgTable)
	local msgBodyTable = msgTable["csp.equip_off_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero or ""
	msgList[2] = msgBodyTable.off_equip_id or "[]"

	return msgList
end

function RPC._dict2ListForEquipLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.equip_levelup_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.gid or ""
	msgList[2] = msgBodyTable.cost_gid or "[]"
	msgList[3] = msgBodyTable.item_id or {}
	msgList[4] = msgBodyTable.item_num or {}
	msgList[5] = msgBodyTable.prop or {}
	msgList[6] = msgBodyTable.total_xp or 0

	return msgList
end

function RPC._dict2ListForEquipUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.equip_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.equip or {}

	return msgList
end

function RPC._dict2ListForEquipSwap(msgTable)
	local msgBodyTable = msgTable["csp.equip_swap_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.hero or {}

	return msgList
end

function RPC._dict2ListForEquipEvolve(msgTable)
	local msgBodyTable = msgTable["csp.equip_evolve_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gid or ""
	msgList[2] = msgBodyTable.evolve or 0

	return msgList
end

function RPC._dict2ListForEquipBuild(msgTable)
	local msgBodyTable = msgTable["csp.equip_build_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.gid or ""
	msgList[2] = msgBodyTable.build_exp or 0
	msgList[3] = msgBodyTable.effect_id or 0

	return msgList
end

function RPC._dict2ListForEquipBuildLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.equip_build_levelup_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gid or ""
	msgList[2] = msgBodyTable.build_exp or 0

	return msgList
end

function RPC._dict2ListForEquipLock(msgTable)
	local msgBodyTable = msgTable["csp.equip_lock_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gid or ""
	msgList[2] = msgBodyTable.lock or 0

	return msgList
end

function RPC._dict2ListForArtifactGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.artifact_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.new_list or {}

	return msgList
end

function RPC._dict2ListForArtifactDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.artifact_del_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.gid_list or "[]"

	return msgList
end

function RPC._dict2ListForArtifactWear(msgTable)
	local msgBodyTable = msgTable["csp.artifact_wear_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hero or ""
	msgList[2] = msgBodyTable.artifact_id or ""
	msgList[3] = msgBodyTable.off_artifact_id or ""

	return msgList
end

function RPC._dict2ListForArtifactOff(msgTable)
	local msgBodyTable = msgTable["csp.artifact_off_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero or ""
	msgList[2] = msgBodyTable.off_artifact_id or ""

	return msgList
end

function RPC._dict2ListForArtifactLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.artifact_levelup_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.gid or ""
	msgList[2] = msgBodyTable.cost_gid or "[]"
	msgList[3] = msgBodyTable.item_id or {}
	msgList[4] = msgBodyTable.item_num or {}
	msgList[5] = msgBodyTable.total_xp or 0

	return msgList
end

function RPC._dict2ListForArtifactUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.artifact_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.artifact or {}

	return msgList
end

function RPC._dict2ListForArtifactLock(msgTable)
	local msgBodyTable = msgTable["csp.artifact_lock_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gid or ""
	msgList[2] = msgBodyTable.lock or 0

	return msgList
end

function RPC._dict2ListForShopRangeBeg(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForShopEnter(msgTable)
	local msgBodyTable = msgTable["csp.shop_enter_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.shopid or 0
	msgList[2] = msgBodyTable.idnum or {}

	return msgList
end

function RPC._dict2ListForShopRecordUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.shop_record_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.idnum or {}

	return msgList
end

function RPC._dict2ListForCurrencyExchange(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForShopRandDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.shop_rand_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForRoleShopRefreshItemNotify(msgTable)
	local msgBodyTable = msgTable["csp.role_shop_refresh_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForAchieveGetAward(msgTable)
	local msgBodyTable = msgTable["csp.achieve_get_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.achieve_id or 0

	return msgList
end

function RPC._dict2ListForAchieveActionProgressNotify(msgTable)
	local msgBodyTable = msgTable["csp.achieve_action_progress_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.action or 0
	msgList[2] = msgBodyTable.progress or 0

	return msgList
end

function RPC._dict2ListForAchieveQualifyNotify(msgTable)
	local msgBodyTable = msgTable["csp.achieve_qualify_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.achieve_id or 0

	return msgList
end

function RPC._dict2ListForRoleMiscIDCard(msgTable)
	local msgBodyTable = msgTable["csp.role_misc_idcard_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id_card or ""

	return msgList
end

function RPC._dict2ListForRoleMiscAddicationNotify(msgTable)
	local msgBodyTable = msgTable["csp.role_misc_addication_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.addiction or {}

	return msgList
end

function RPC._dict2ListForRoleMiscConsignee(msgTable)
	local msgBodyTable = msgTable["csp.role_misc_consignee_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.name or ""
	msgList[2] = msgBodyTable.phone or ""
	msgList[3] = msgBodyTable.address or ""

	return msgList
end

function RPC._dict2ListForEquipTowerSweep(msgTable)
	local msgBodyTable = msgTable["csp.equip_tower_sweep_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.times or 0

	return msgList
end

function RPC._dict2ListForEquipTowerDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.equip_tower_data_notify"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.top_layer or 0
	msgList[4] = msgBodyTable.last_time or 0
	msgList[5] = msgBodyTable.award or 0

	return msgList
end

function RPC._dict2ListForEquipTowerSuperSweepDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.equip_tower_super_sweep_data_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.refresh_time or 0
	msgList[2] = msgBodyTable.super_count or 0
	msgList[3] = msgBodyTable.type or 0

	return msgList
end

function RPC._dict2ListForEquipTowerReplayRecord(msgTable)
	local msgBodyTable = msgTable["csp.equip_tower_replay_record_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForEquipTowerChooseHero(msgTable)
	local msgBodyTable = msgTable["csp.equip_tower_choose_hero_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.hero_id or 0
	msgList[4] = msgBodyTable.gid or ""

	return msgList
end

function RPC._dict2ListForBagSizeExtend(msgTable)
	local msgBodyTable = msgTable["csp.bag_size_extend_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.bag_type or "kCSBagTypeCodeNone"
	msgList[2] = msgBodyTable.bag_size or 0

	return msgList
end

function RPC._dict2ListForAsyncPVPFormation(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_formation_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.item or {}
	msgList[2] = msgBodyTable.pet or 0

	return msgList
end

function RPC._dict2ListForAsyncPVPMatch(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_match_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForAsyncPVPChallege(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_challege_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForAsyncPVPDetailNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_detail_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.opponent or {}
	msgList[2] = msgBodyTable.type or "kCSAsyncPVPDetailTypeNone"

	return msgList
end

function RPC._dict2ListForAsyncPVPReportGet(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_report_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForAsyncPVPReportNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_report_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.report or {}

	return msgList
end

function RPC._dict2ListForAsyncPVPSweep(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_sweep_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForAsyncPVPUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForAsyncPVPSettleNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_settle_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.attack or {}
	msgList[2] = msgBodyTable.defend or {}

	return msgList
end

function RPC._dict2ListForAsyncPVPReportStatusNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_report_status_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.report_status or 0

	return msgList
end

function RPC._dict2ListForAsyncPVPTargetCache(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_target_cache_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForAsyncPVPScore(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_score_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.scores or {}

	return msgList
end

function RPC._dict2ListForAsyncPVPAttackTimesNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_attack_times_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.times or 0
	msgList[2] = msgBodyTable.need_refresh or 0

	return msgList
end

function RPC._dict2ListForAsyncPVPBriefNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_brief_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.base or {}

	return msgList
end

function RPC._dict2ListForAsyncPVPSysDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.async_pvp_sys_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.season or 0
	msgList[2] = msgBodyTable.start_time or 0

	return msgList
end

function RPC._dict2ListForCDKey(msgTable)
	local msgBodyTable = msgTable["csp.cdkey_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.free_tick or 0

	return msgList
end

function RPC._dict2ListForBossTowerAwardGet(msgTable)
	local msgBodyTable = msgTable["csp.boss_tower_award_get_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.award_ids or {}
	msgList[2] = msgBodyTable.type or 0
	msgList[3] = msgBodyTable.sweep_tick or 0

	return msgList
end

function RPC._dict2ListForBossTowerDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.boss_tower_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForBossTowerReplayRecord(msgTable)
	local msgBodyTable = msgTable["csp.boss_tower_replay_record_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForOnceTowerDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.once_tower_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.layer or 0

	return msgList
end

function RPC._dict2ListForOnceTowerReplayRecord(msgTable)
	local msgBodyTable = msgTable["csp.once_tower_replay_record_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForNewbieReport(msgTable)
	local msgBodyTable = msgTable["csp.newbie_report_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForTaskGetAward(msgTable)
	local msgBodyTable = msgTable["csp.task_get_award_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSTaskTypeCodeNone"
	msgList[2] = msgBodyTable.index or 0

	return msgList
end

function RPC._dict2ListForTaskUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.task_upate_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSTaskTypeCodeNone"
	msgList[2] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForTaskRefreshNotify(msgTable)
	local msgBodyTable = msgTable["csp.task_refresh_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSTaskTypeCodeNone"
	msgList[2] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForTaskAcceptNotify(msgTable)
	local msgBodyTable = msgTable["csp.task_accept_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSTaskTypeCodeNone"
	msgList[2] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForHouseUpdate(msgTable)
	local msgBodyTable = msgTable["csp.house_update_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.succ or 0

	return msgList
end

function RPC._dict2ListForHouseVisit(msgTable)
	local msgBodyTable = msgTable["csp.house_visit_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.favor_num or 0

	return msgList
end

function RPC._dict2ListForHouseVisitNotify(msgTable)
	local msgBodyTable = msgTable["csp.house_visit_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.house or {}
	msgList[2] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForHouseLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.house_level_up_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForHouseUnlockAwardGet(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForHouseComfortAwardGet(msgTable)
	local msgBodyTable = msgTable["csp.house_comfort_award_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.comfort or 0

	return msgList
end

function RPC._dict2ListForHouseSweep(msgTable)
	local msgBodyTable = msgTable["csp.house_sweep_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.times or 0

	return msgList
end

function RPC._dict2ListForHouseVisitHistoryGet(msgTable)
	local msgBodyTable = msgTable["csp.house_visit_history_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or "[]"

	return msgList
end

function RPC._dict2ListForHouseFavor(msgTable)
	local msgBodyTable = msgTable["csp.house_favor_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.succ or 0
	msgList[2] = msgBodyTable.award or 0

	return msgList
end

function RPC._dict2ListForHouseFavorHistory(msgTable)
	local msgBodyTable = msgTable["csp.house_favor_history_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.favored_num or 0
	msgList[2] = msgBodyTable.favor_uid or "[]"
	msgList[3] = msgBodyTable.favored_uid or "[]"
	msgList[4] = msgBodyTable.favor_today or "[]"

	return msgList
end

function RPC._dict2ListForHouseFavorRank(msgTable)
	local msgBodyTable = msgTable["csp.house_favor_rank_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForHouseVisitRandom(msgTable)
	local msgBodyTable = msgTable["csp.house_visit_random_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForHouseShare(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForHouseMainRoomSet(msgTable)
	local msgBodyTable = msgTable["csp.house_main_room_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.room_id or 0

	return msgList
end

function RPC._dict2ListForHouseCommentSwitchSet(msgTable)
	local msgBodyTable = msgTable["csp.house_comment_switch_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.comment_switch or 0

	return msgList
end

function RPC._dict2ListForMazeUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.maze_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.maze or {}

	return msgList
end

function RPC._dict2ListForMazeHeroRecordUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.maze_hero_record_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.hero or {}

	return msgList
end

function RPC._dict2ListForMazeSelectBranch(msgTable)
	local msgBodyTable = msgTable["csp.maze_select_branch_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.branch_index or 0

	return msgList
end

function RPC._dict2ListForMazeRelicsRandNotify(msgTable)
	local msgBodyTable = msgTable["csp.maze_relics_rand_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.relics or {}

	return msgList
end

function RPC._dict2ListForMazeSelectRelics(msgTable)
	local msgBodyTable = msgTable["csp.maze_select_relics_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.relics_index or 0

	return msgList
end

function RPC._dict2ListForMazeRelicsNotify(msgTable)
	local msgBodyTable = msgTable["csp.maze_relics_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.relics or {}

	return msgList
end

function RPC._dict2ListForMazeSelect(msgTable)
	local msgBodyTable = msgTable["csp.maze_select_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.maze_id or 0

	return msgList
end

function RPC._dict2ListForMazeSelectSweepRelics(msgTable)
	local msgBodyTable = msgTable["csp.maze_select_sweep_relics_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.node or 0
	msgList[3] = msgBodyTable.relics_index or 0

	return msgList
end

function RPC._dict2ListForMazeSysDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.maze_sys_data_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.season or 0
	msgList[2] = msgBodyTable.end_time or 0

	return msgList
end

function RPC._dict2ListForMazeSweep(msgTable)
	local msgBodyTable = msgTable["csp.maze_sweep_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.maze_id or 0

	return msgList
end

function RPC._dict2ListForRankIndexGet(msgTable)
	local msgBodyTable = msgTable["csp.rank_index_get_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.rank or {}
	msgList[2] = msgBodyTable.rank_type or "kRankTypeNone"

	return msgList
end

function RPC._dict2ListForRankGet(msgTable)
	local msgBodyTable = msgTable["csp.rank_get_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.rank_type or "kRankTypeNone"
	msgList[2] = msgBodyTable.page or 0
	msgList[3] = msgBodyTable.page_rank or {}
	msgList[4] = msgBodyTable.self_rank or {}
	msgList[5] = msgBodyTable.total_count or 0

	return msgList
end

function RPC._dict2ListForRankTopGet(msgTable)
	local msgBodyTable = msgTable["csp.rank_top_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.rank or {}

	return msgList
end

function RPC._dict2ListForBookTaskGetAward(msgTable)
	local msgBodyTable = msgTable["csp.book_task_get_award_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.status or 0

	return msgList
end

function RPC._dict2ListForBookTaskProgressNotify(msgTable)
	local msgBodyTable = msgTable["csp.book_task_progress_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or {}
	msgList[2] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForWelfareGetAward(msgTable)
	local msgBodyTable = msgTable["csp.welfare_activity_get_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSWelfareTypeNone"
	msgList[2] = msgBodyTable.resid or {}

	return msgList
end

function RPC._dict2ListForWelfareFundNotify(msgTable)
	local msgBodyTable = msgTable["csp.welfare_fund_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.fund or {}

	return msgList
end

function RPC._dict2ListForWelfarePushGiftTriggerNotify(msgTable)
	local msgBodyTable = msgTable["csp.push_gift_trigger_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.triggers or {}

	return msgList
end

function RPC._dict2ListForWelfareCardInfoNotify(msgTable)
	local msgBodyTable = msgTable["csp.welfare_card_info_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForWelfarePushGiftPopupSet(msgTable)
	local msgBodyTable = msgTable["csp.push_gift_popup_set_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.gift_id or {}

	return msgList
end

function RPC._dict2ListForBattlePassDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.battle_pass_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.bp_data or {}

	return msgList
end

function RPC._dict2ListForBattlePassRoleDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.battle_pass_role_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.bp_data or {}

	return msgList
end

function RPC._dict2ListForBattlePassRoleTaskNotify(msgTable)
	local msgBodyTable = msgTable["csp.battle_pass_role_task_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.task_id or 0
	msgList[2] = msgBodyTable.get_count or 0

	return msgList
end

function RPC._dict2ListForBattlePassRoleSuperNotify(msgTable)
	local msgBodyTable = msgTable["csp.battle_pass_role_super_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.is_super or 0

	return msgList
end

function RPC._dict2ListForBattlePassActionProgressNotify(msgTable)
	local msgBodyTable = msgTable["csp.battle_pass_action_progress_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.action or 0
	msgList[2] = msgBodyTable.progress or 0

	return msgList
end

function RPC._dict2ListForBattlePassBpAwardNotify(msgTable)
	local msgBodyTable = msgTable["csp.battle_pass_bp_award_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.level or 0
	msgList[2] = msgBodyTable.normal_get or 0
	msgList[3] = msgBodyTable.super_get or 0

	return msgList
end

function RPC._dict2ListForRoleCommGet(msgTable)
	local msgBodyTable = msgTable["csp.role_comm_get_notify"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.role_comm or {}
	msgList[2] = msgBodyTable.personal or {}
	msgList[3] = msgBodyTable.power or {}
	msgList[4] = msgBodyTable.mask or 0
	msgList[5] = msgBodyTable.signet or {}
	msgList[6] = msgBodyTable.new_vow or {}

	return msgList
end

function RPC._dict2ListForRoleCommEditFormation(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForRoleCommEditSignature(msgTable)
	local msgBodyTable = msgTable["csp.role_comm_edit_signature_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.reason or 0
	msgList[2] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForRoleCommChangeGender(msgTable)
	local msgBodyTable = msgTable["csp.role_comm_change_gender_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.next_change_tick or 0

	return msgList
end

function RPC._dict2ListForRoleCommChangeHead(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForRoleCommChangeHeadFrame(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForRoleCommEditVowHero(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForRoleCommChangeHeadPendant(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForRoleCommEditSignet(msgTable)
	local msgBodyTable = msgTable["csp.role_comm_edit_signet_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.signetId or {}

	return msgList
end

function RPC._dict2ListForRoleCommChangeBubble(msgTable)
	local msgBodyTable = msgTable["csp.role_comm_change_bubble_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForNoticeMsgNotify(msgTable)
	local msgBodyTable = msgTable["csp.notice_msg_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForMonumentMsgGetAward(msgTable)
	local msgBodyTable = msgTable["csp.monument_get_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or {}

	return msgList
end

function RPC._dict2ListForMonumentMsgNotify(msgTable)
	local msgBodyTable = msgTable["csp.monument_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.record or {}

	return msgList
end

function RPC._dict2ListForMonumentMsgCompleteNotify(msgTable)
	local msgBodyTable = msgTable["csp.monument_complete_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.record or {}

	return msgList
end

function RPC._dict2ListForCrystalMsgSlotNotify(msgTable)
	local msgBodyTable = msgTable["csp.crystal_slot_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.slot_data or {}

	return msgList
end

function RPC._dict2ListForCrystalMsgNotify(msgTable)
	local msgBodyTable = msgTable["csp.crystal_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.crystal_data or {}

	return msgList
end

function RPC._dict2ListForCrystalMsgLevelNotify(msgTable)
	local msgBodyTable = msgTable["csp.crystal_level_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.level or 0
	msgList[2] = msgBodyTable.max_level or 0
	msgList[3] = msgBodyTable.crystal_level or 0

	return msgList
end

function RPC._dict2ListForCrystalMsgGetAward(msgTable)
	local msgBodyTable = msgTable["csp.crystal_get_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or {}

	return msgList
end

function RPC._dict2ListForDressHeadGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.dress_head_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForDressHeadFrameGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.dress_head_frame_get_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.end_time or 0

	return msgList
end

function RPC._dict2ListForDressHeadFrameSetNotify(msgTable)
	local msgBodyTable = msgTable["csp.dress_head_frame_set_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForDressHeadPendantGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.dress_head_pendant_get_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.end_time or 0

	return msgList
end

function RPC._dict2ListForDressChatBubbleGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.dress_chat_bubble_get_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.end_time or 0

	return msgList
end

function RPC._dict2ListForPowerExchange(msgTable)
	local msgBodyTable = msgTable["csp.power_exchange_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.power or 0

	return msgList
end

function RPC._dict2ListForPrivilegeItemChangeNotify(msgTable)
	local msgBodyTable = msgTable["csp.privilege_item_change_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.end_time or 0
	msgList[3] = msgBodyTable.reason or 0

	return msgList
end

function RPC._dict2ListForVIPGetAward(msgTable)
	local msgBodyTable = msgTable["csp.vip_get_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForVIPLevelNotify(msgTable)
	local msgBodyTable = msgTable["csp.vip_level_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForVIPSetHide(msgTable)
	local msgBodyTable = msgTable["csp.vip_set_hide_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.is_hide or 0

	return msgList
end

function RPC._dict2ListForSignetNotify(msgTable)
	local msgBodyTable = msgTable["csp.signet_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.signet or {}

	return msgList
end

function RPC._dict2ListForRoleCountNotify(msgTable)
	local msgBodyTable = msgTable["csp.role_count_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.number or 0

	return msgList
end

function RPC._dict2ListForClanCreate(msgTable)
	local msgBodyTable = msgTable["csp.clan_create_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.clan or {}
	msgList[2] = msgBodyTable.next_tick or 0
	msgList[3] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForClanGet(msgTable)
	local msgBodyTable = msgTable["csp.clan_get_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.clangid or 0
	msgList[2] = msgBodyTable.next_tick or 0
	msgList[3] = msgBodyTable.clan or {}

	return msgList
end

function RPC._dict2ListForClanJoin(msgTable)
	local msgBodyTable = msgTable["csp.clan_join_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.clangid or 0
	msgList[2] = msgBodyTable.param or 0

	return msgList
end

function RPC._dict2ListForClanAcceptApply(msgTable)
	local msgBodyTable = msgTable["csp.clan_accept_apply_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.applycnt or 0
	msgList[2] = msgBodyTable.succcnt or 0
	msgList[3] = msgBodyTable.apply or {}

	return msgList
end

function RPC._dict2ListForClanRefuseApply(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForClanExit(msgTable)
	local msgBodyTable = msgTable["csp.clan_exit_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.next_tick or 0

	return msgList
end

function RPC._dict2ListForClanDismiss(msgTable)
	local msgBodyTable = msgTable["csp.clan_dismiss_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.next_tick or 0

	return msgList
end

function RPC._dict2ListForClanKick(msgTable)
	local msgBodyTable = msgTable["csp.clan_kick_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForClanAppoint(msgTable)
	local msgBodyTable = msgTable["csp.clan_appoint_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.duty or 0

	return msgList
end

function RPC._dict2ListForClanRename(msgTable)
	local msgBodyTable = msgTable["csp.clan_rename_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.tick or 0
	msgList[2] = msgBodyTable.name or ""
	msgList[3] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForClanRenotice(msgTable)
	local msgBodyTable = msgTable["csp.clan_renotice_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.title or ""
	msgList[2] = msgBodyTable.notice or ""
	msgList[3] = msgBodyTable.tick or 0
	msgList[4] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForClanSearch(msgTable)
	local msgBodyTable = msgTable["csp.clan_search_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.clan or {}
	msgList[2] = msgBodyTable.param or 0

	return msgList
end

function RPC._dict2ListForClanRecommend(msgTable)
	local msgBodyTable = msgTable["csp.clan_recommend_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.reclan or {}
	msgList[2] = msgBodyTable.count or 0

	return msgList
end

function RPC._dict2ListForClanCheckin(msgTable)
	local msgBodyTable = msgTable["csp.clan_checkin_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanTransfer(msgTable)
	local msgBodyTable = msgTable["csp.clan_transfer_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForClanSendMail(msgTable)
	local msgBodyTable = msgTable["csp.clan_mail_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.tick or 0
	msgList[2] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForClanDutyNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_duty_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.duty or 0

	return msgList
end

function RPC._dict2ListForClanKickNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_kick_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.next_tick or 0

	return msgList
end

function RPC._dict2ListForClanEnterNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_enter_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.clan or {}

	return msgList
end

function RPC._dict2ListForClanMailNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_mail_notify"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.name or ""
	msgList[2] = msgBodyTable.title or ""
	msgList[3] = msgBodyTable.content or ""
	msgList[4] = msgBodyTable.suid or 0
	msgList[5] = msgBodyTable.mail_type or 0
	msgList[6] = msgBodyTable.mailid or 0

	return msgList
end

function RPC._dict2ListForClanRehead(msgTable)
	local msgBodyTable = msgTable["csp.clan_rehead_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.tick or 0
	msgList[2] = msgBodyTable.head or 0

	return msgList
end

function RPC._dict2ListForClanSetAutoAccept(msgTable)
	local msgBodyTable = msgTable["csp.clan_set_auto_accept_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.switch or 0

	return msgList
end

function RPC._dict2ListForClanLeaveNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_leave_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForClanJoinNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_join_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.member or {}

	return msgList
end

function RPC._dict2ListForClanLevelNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_level_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForClanCheckinTickNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_checkin_tick_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanReHeadFrame(msgTable)
	local msgBodyTable = msgTable["csp.clan_re_head_frame_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.tick or 0
	msgList[2] = msgBodyTable.head_frame or 0

	return msgList
end

function RPC._dict2ListForFamiliarLevelChange(msgTable)
	local msgBodyTable = msgTable["csp.familiar_up_level_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_resid or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForHouseDispatchStart(msgTable)
	local msgBodyTable = msgTable["csp.house_dispatch_start_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.started_house_dispatch or {}

	return msgList
end

function RPC._dict2ListForHouseDispatchDone(msgTable)
	local msgBodyTable = msgTable["csp.house_dispatch_done_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.crit or 0

	return msgList
end

function RPC._dict2ListForHouseDispatchLock(msgTable)
	local msgBodyTable = msgTable["csp.house_dispatch_lock_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.lock or 0

	return msgList
end

function RPC._dict2ListForHouseDispatchRefresh(msgTable)
	local msgBodyTable = msgTable["csp.house_dispatch_refresh_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.house_dispatch or {}

	return msgList
end

function RPC._dict2ListForHouseDispatchDayRefreshNotify(msgTable)
	local msgBodyTable = msgTable["csp.house_dispatch_day_refresh_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.house_dispatch or {}

	return msgList
end

function RPC._dict2ListForHouseDispatchAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.house_dispatch_add_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.add_dispatch or {}

	return msgList
end

function RPC._dict2ListForHouseDispatchAllDone(msgTable)
	local msgBodyTable = msgTable["csp.house_dispatch_all_done_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.dispatch_done or {}

	return msgList
end

function RPC._dict2ListForMultiPVPMatch(msgTable)
	local msgBodyTable = msgTable["csp.multipvp_match_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.next_tick or 0
	msgList[2] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForMultiPVPTargetCache(msgTable)
	local msgBodyTable = msgTable["csp.multipvp_target_cache_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.formation or {}
	msgList[2] = msgBodyTable.robot_id or 0

	return msgList
end

function RPC._dict2ListForMultiPVPRank(msgTable)
	local msgBodyTable = msgTable["csp.multipvp_rank_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.data or {}
	msgList[2] = msgBodyTable.score or 0
	msgList[3] = msgBodyTable.rank or 0
	msgList[4] = msgBodyTable.tick or 0
	msgList[5] = msgBodyTable.page or 0

	return msgList
end

function RPC._dict2ListForMultiPVPAwardGet(msgTable)
	local msgBodyTable = msgTable["csp.multipvp_award_get_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.awards or 0
	msgList[2] = msgBodyTable.award_tick or 0

	return msgList
end

function RPC._dict2ListForMultiPVPReportGet(msgTable)
	local msgBodyTable = msgTable["csp.multipvp_report_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForMultiPVPReportGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.multipvp_report_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.report or {}

	return msgList
end

function RPC._dict2ListForMultiPVPUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.multipvp_update_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForRelicGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.relic_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.new_list or {}

	return msgList
end

function RPC._dict2ListForRelicWear(msgTable)
	local msgBodyTable = msgTable["csp.relic_wear_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hero_id or ""
	msgList[2] = msgBodyTable.relic_id or 0
	msgList[3] = msgBodyTable.off_relic_id or 0

	return msgList
end

function RPC._dict2ListForRelicOff(msgTable)
	local msgBodyTable = msgTable["csp.relic_off_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_id or ""
	msgList[2] = msgBodyTable.off_relic_id or 0

	return msgList
end

function RPC._dict2ListForRelicLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.relic_level_up_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.relic_id or 0
	msgList[2] = msgBodyTable.cur_level or 0

	return msgList
end

function RPC._dict2ListForSeasonRelicOp(msgTable)
	local msgBodyTable = msgTable["csp.season_relic_op_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.relic_id or 0
	msgList[2] = msgBodyTable.op_type or 0
	msgList[3] = msgBodyTable.param or 0

	return msgList
end

function RPC._dict2ListForSkinAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.skin_add_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hero_id or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.type or "kSkinTypeNone"

	return msgList
end

function RPC._dict2ListForSkinWear(msgTable)
	local msgBodyTable = msgTable["csp.skin_wear_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.type or "kSkinTypeNone"

	return msgList
end

function RPC._dict2ListForSkinExchange(msgTable)
	local msgBodyTable = msgTable["csp.skin_exchange_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.type or "kSkinTypeNone"

	return msgList
end

function RPC._dict2ListForSkinUnlock(msgTable)
	local msgBodyTable = msgTable["csp.skin_unlock_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.type or "kSkinTypeNone"

	return msgList
end

function RPC._dict2ListForSkinRepeatNotify(msgTable)
	local msgBodyTable = msgTable["csp.skin_repeat_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.type or "kSkinTypeNone"

	return msgList
end

function RPC._dict2ListForRoleWorldBossNotify(msgTable)
	local msgBodyTable = msgTable["csp.world_boss_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForRechargeRebateAward(msgTable)
	local msgBodyTable = msgTable["csp.recharge_rebate_award_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.code or "kCSRechargeRebateGetNone"
	msgList[2] = msgBodyTable.cash or 0
	msgList[3] = msgBodyTable.diamond or 0
	msgList[4] = msgBodyTable.recharge_id or {}

	return msgList
end

function RPC._dict2ListForRechargeRebateNotify(msgTable)
	local msgBodyTable = msgTable["csp.recharge_rebate_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.get_flag or 0
	msgList[2] = msgBodyTable.gem or 0

	return msgList
end

function RPC._dict2ListForOpactArenaRoleOpen(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_role_open_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.score or 0
	msgList[2] = msgBodyTable.league or 0
	msgList[3] = msgBodyTable.award_dan or 0

	return msgList
end

function RPC._dict2ListForOpactArenaEnroll(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_enroll_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.power or 0

	return msgList
end

function RPC._dict2ListForOpactArenaUpgradeLeague(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_upgrade_league_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.league or 0
	msgList[2] = msgBodyTable.score or 0
	msgList[3] = msgBodyTable.ranking or 0

	return msgList
end

function RPC._dict2ListForOpactArenaMatch(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_match_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.tick or 0
	msgList[2] = msgBodyTable.result or {}
	msgList[3] = msgBodyTable.match_times or 0

	return msgList
end

function RPC._dict2ListForOpactArenaDetailGet(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForOpactArenaReportGet(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_report_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.report or {}
	msgList[2] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForOpactArenaRankGet(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_rank_get_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.rank_data or {}
	msgList[2] = msgBodyTable.page or 0
	msgList[3] = msgBodyTable.rank_num or 0

	return msgList
end

function RPC._dict2ListForOpactArenaRankTopGet(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_rank_top_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.rank_data or {}

	return msgList
end

function RPC._dict2ListForOpactArenaRoleInfoRefresh(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForOpactArenaOpponentDetailNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_opponent_detail_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.opponent_detail or {}

	return msgList
end

function RPC._dict2ListForOpactArenaSettleNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_settle_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.self_score or 0
	msgList[2] = msgBodyTable.target_uid or ""
	msgList[3] = msgBodyTable.target_score or 0
	msgList[4] = msgBodyTable.self_ranking or 0

	return msgList
end

function RPC._dict2ListForOpactArenaRoleInfoNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_role_info_notify"]
	local msgList = RPC._CachedList7

	msgList[1] = msgBodyTable.activity_id or 0
	msgList[2] = msgBodyTable.ranking or 0
	msgList[3] = msgBodyTable.score or 0
	msgList[4] = msgBodyTable.league or 0
	msgList[5] = msgBodyTable.battle_cnt or 0
	msgList[6] = msgBodyTable.defence_tick or 0
	msgList[7] = msgBodyTable.attack_item or {}

	return msgList
end

function RPC._dict2ListForOpactArenaRoleMatchNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_role_match_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.tick or 0
	msgList[2] = msgBodyTable.result or {}

	return msgList
end

function RPC._dict2ListForOpactArenaRoleDefendNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_role_defend_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.tick or 0
	msgList[2] = msgBodyTable.score or 0
	msgList[3] = msgBodyTable.ranking or 0

	return msgList
end

function RPC._dict2ListForOpactArenaRoleDanAwardNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_role_dan_award_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.award_dan or 0

	return msgList
end

function RPC._dict2ListForOpactArenaRoleGetNearRank(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_role_get_near_rank_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.rank_item or {}

	return msgList
end

function RPC._dict2ListForOpactArenaSetRandFormaion(msgTable)
	local msgBodyTable = msgTable["csp.opact_arena_set_rand_formation_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.rand or 0

	return msgList
end

function RPC._dict2ListForOpActTowerSweep(msgTable)
	local msgBodyTable = msgTable["csp.opact_tower_sweep_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.score_add or 0
	msgList[2] = msgBodyTable.drop_add or 0

	return msgList
end

function RPC._dict2ListForOpActTowerGetScoreAward(msgTable)
	local msgBodyTable = msgTable["csp.opact_tower_get_score_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.speed_add or 0

	return msgList
end

function RPC._dict2ListForOpActTowerGetBuff(msgTable)
	local msgBodyTable = msgTable["csp.opact_tower_get_buff_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.item or {}
	msgList[2] = msgBodyTable.sys_buff_id or {}
	msgList[3] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActTowerUpdateBuffNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_tower_update_buff_notify_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.item or {}
	msgList[2] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForOpActTowerRoleAchieveNotify(msgTable)
	local msgBodyTable = msgTable["csp.opact_tower_role_achieve_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.bits or ""

	return msgList
end

function RPC._dict2ListForOpActTowerReplayRecord(msgTable)
	local msgBodyTable = msgTable["csp.opact_tower_replay_record_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.tower_id or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForRentTaskRefresh(msgTable)
	local msgBodyTable = msgTable["csp.rent_task_refresh_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForRentTaskSelect(msgTable)
	local msgBodyTable = msgTable["csp.rent_task_select_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gtid or 0
	msgList[2] = msgBodyTable.taskid or 0

	return msgList
end

function RPC._dict2ListForRentMatch(msgTable)
	local msgBodyTable = msgTable["csp.rent_match_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.match_result or {}
	msgList[2] = msgBodyTable.gtid or 0
	msgList[3] = msgBodyTable.tick or 0
	msgList[4] = msgBodyTable.refresh_only or 0

	return msgList
end

function RPC._dict2ListForRentSetAutoAccept(msgTable)
	local msgBodyTable = msgTable["csp.rent_set_auto_accept_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.auto_accept or 0

	return msgList
end

function RPC._dict2ListForRentSendLetter(msgTable)
	local msgBodyTable = msgTable["csp.rent_send_letter_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.hint or "[]"

	return msgList
end

function RPC._dict2ListForRentRenterRent(msgTable)
	local msgBodyTable = msgTable["csp.rent_renter_rent_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gtid or 0
	msgList[2] = msgBodyTable.record or {}

	return msgList
end

function RPC._dict2ListForRentRenterCancel(msgTable)
	local msgBodyTable = msgTable["csp.rent_renter_cancel_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gtid or 0
	msgList[2] = msgBodyTable.record or {}

	return msgList
end

function RPC._dict2ListForRentOwnerAccept(msgTable)
	local msgBodyTable = msgTable["csp.rent_owner_accept_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.record or {}
	msgList[2] = msgBodyTable.refuse_other or 0

	return msgList
end

function RPC._dict2ListForRentOwnerRefuse(msgTable)
	local msgBodyTable = msgTable["csp.rent_owner_refuse_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.record or {}

	return msgList
end

function RPC._dict2ListForRentOwnerCancel(msgTable)
	local msgBodyTable = msgTable["csp.rent_owner_cancel_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.record or {}

	return msgList
end

function RPC._dict2ListForRentGetRentedFormation(msgTable)
	local msgBodyTable = msgTable["csp.rent_get_rented_formation_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.formation or {}
	msgList[2] = msgBodyTable.gtid or 0

	return msgList
end

function RPC._dict2ListForRentGetOwnerFormation(msgTable)
	local msgBodyTable = msgTable["csp.rent_get_owner_formation_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForRentGetLetter(msgTable)
	local msgBodyTable = msgTable["csp.rent_get_letter_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.letter or {}

	return msgList
end

function RPC._dict2ListForRentUpdateFormation(msgTable)
	local msgBodyTable = msgTable["csp.rent_update_formation_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForRentRenterNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_renter_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.record or {}
	msgList[2] = msgBodyTable.comm or {}
	msgList[3] = msgBodyTable.gtid or 0

	return msgList
end

function RPC._dict2ListForRentOwnerNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_owner_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.record or {}
	msgList[2] = msgBodyTable.comm or {}

	return msgList
end

function RPC._dict2ListForRentDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForRentLetterNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_letter_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.letter or {}
	msgList[2] = msgBodyTable.gitf_num or 0

	return msgList
end

function RPC._dict2ListForRentTaskDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_task_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.gtid or 0
	msgList[2] = msgBodyTable.task or {}
	msgList[3] = msgBodyTable.status or 0

	return msgList
end

function RPC._dict2ListForRentTaskRefreshNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_task_refresh_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForRentTeamNumNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_team_num_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.team_num or 0

	return msgList
end

function RPC._dict2ListForRentTMiscNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_misc_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gitf_num or 0
	msgList[2] = msgBodyTable.team_num or 0

	return msgList
end

function RPC._dict2ListForRentWaitLetterNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_wait_letter_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.letter or {}

	return msgList
end

function RPC._dict2ListForRentGetSendLetter(msgTable)
	local msgBodyTable = msgTable["csp.rent_get_send_letter_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.letter or {}

	return msgList
end

function RPC._dict2ListForRentSendLetterNotify(msgTable)
	local msgBodyTable = msgTable["csp.rent_send_letter_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.letter or {}

	return msgList
end

function RPC._dict2ListForRankCacheGetPage(msgTable)
	local msgBodyTable = msgTable["csp.rank_cache_get_page_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.rank_data or {}
	msgList[2] = msgBodyTable.page or 0
	msgList[3] = msgBodyTable.rank_num or 0
	msgList[4] = msgBodyTable.is_end or 0
	msgList[5] = msgBodyTable.cache_type or 0

	return msgList
end

function RPC._dict2ListForRankCacheGetRealRanking(msgTable)
	local msgBodyTable = msgTable["csp.rank_cache_get_real_ranking_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.cache_type or 0
	msgList[2] = msgBodyTable.sub_type or 0
	msgList[3] = msgBodyTable.actid or 0
	msgList[4] = msgBodyTable.season or 0
	msgList[5] = msgBodyTable.uniqueid or ""
	msgList[6] = msgBodyTable.ranking or 0

	return msgList
end

function RPC._dict2ListForProficentLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.proficent_level_up_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.group_id or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.is_ur or 0

	return msgList
end

function RPC._dict2ListForProficentGetScore(msgTable)
	local msgBodyTable = msgTable["csp.proficent_get_score_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.item or {}
	msgList[2] = msgBodyTable.score or 0
	msgList[3] = msgBodyTable.group_id or 0
	msgList[4] = msgBodyTable.is_ur or 0

	return msgList
end

function RPC._dict2ListForProficentItemNotify(msgTable)
	local msgBodyTable = msgTable["csp.proficent_item_change_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForProficentGetOtherScore(msgTable)
	local msgBodyTable = msgTable["csp.proficent_get_other_score_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.item or {}
	msgList[2] = msgBodyTable.score or 0

	return msgList
end

function RPC._dict2ListForProficentOtherItemNotify(msgTable)
	local msgBodyTable = msgTable["csp.proficent_other_item_change_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForProficentBookGemUse(msgTable)
	local msgBodyTable = msgTable["csp.proficent_book_gem_use_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.group_id or 0
	msgList[2] = msgBodyTable.attr_data or {}

	return msgList
end

function RPC._dict2ListForQQBlueDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.qq_blue_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.update_data or {}

	return msgList
end

function RPC._dict2ListForQQBlueInfoNotify(msgTable)
	local msgBodyTable = msgTable["csp.qq_blue_info_notify"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.vip_valid_time or 0
	msgList[2] = msgBodyTable.year_vip_valid_time or 0
	msgList[3] = msgBodyTable.super_vip_valid_time or 0
	msgList[4] = msgBodyTable.expand_vip_valid_time or 0
	msgList[5] = msgBodyTable.blue_vip_level or 0

	return msgList
end

function RPC._dict2ListForRedPacketGetAward(msgTable)
	local msgBodyTable = msgTable["csp.red_packet_get_award_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.item_id or 0
	msgList[2] = msgBodyTable.seq_id or ""
	msgList[3] = msgBodyTable.cur_limit_count or 0
	msgList[4] = msgBodyTable.refresh_time or 0

	return msgList
end

function RPC._dict2ListForAdvanceGetTaskAward(msgTable)
	local msgBodyTable = msgTable["csp.advance_get_task_award_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.group_id or 0
	msgList[2] = msgBodyTable.task_id or 0
	msgList[3] = msgBodyTable.finish or 0

	return msgList
end

function RPC._dict2ListForAdvanceGetStepAward(msgTable)
	local msgBodyTable = msgTable["csp.advance_get_step_award_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.group_id or 0
	msgList[2] = msgBodyTable.step or 0
	msgList[3] = msgBodyTable.is_super or 0

	return msgList
end

function RPC._dict2ListForAdvanceRechargeNotify(msgTable)
	local msgBodyTable = msgTable["csp.advance_recharge_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.group_id or 0
	msgList[2] = msgBodyTable.is_super or 0

	return msgList
end

function RPC._dict2ListForClanBattleEnter(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_enter_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.clan or {}

	return msgList
end

function RPC._dict2ListForClanBattleExit(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForClanBattleOccupyGrid(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_occupy_grid_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.grid_pos or 0
	msgList[3] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleCancelGrid(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_cancel_grid_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.grid_pos or 0
	msgList[3] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleOccupyMonster(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_occupy_monster_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.grid_pos or 0
	msgList[3] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleCancelMonster(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_cancel_monster_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.grid_pos or 0
	msgList[3] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleOpenGrid(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_open_grid_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.grid_pos or 0
	msgList[3] = msgBodyTable.grid or {}
	msgList[4] = msgBodyTable.optick or 0
	msgList[5] = msgBodyTable.score or 0
	msgList[6] = msgBodyTable.talent or {}

	return msgList
end

function RPC._dict2ListForClanBattleNextLayer(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_next_layer_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.clan or {}

	return msgList
end

function RPC._dict2ListForClanBattleBuySkill(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_buy_skill_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.skill or {}
	msgList[2] = msgBodyTable.contribution or 0

	return msgList
end

function RPC._dict2ListForClanBattleUseSkill(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_use_skill_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.skill or {}
	msgList[2] = msgBodyTable.grid or {}

	return msgList
end

function RPC._dict2ListForClanBattleSetModel(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_set_model_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.model or {}

	return msgList
end

function RPC._dict2ListForClanBattleGiveOrder(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_give_order_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.order or 0
	msgList[2] = msgBodyTable.target or 0
	msgList[3] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleSetRelic(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_set_relic_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.relic or 0

	return msgList
end

function RPC._dict2ListForClanBattleScoreInfuse(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_score_infuse_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.infuse_bytes or ""
	msgList[2] = msgBodyTable.infuse_id or 0

	return msgList
end

function RPC._dict2ListForClanBattleGetScoreLog(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_get_score_log_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.log or {}
	msgList[2] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleGetLog(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_get_log_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.log or {}
	msgList[2] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleGetClanAchieveAward(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_get_clan_achieve_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.achieve_id or 0

	return msgList
end

function RPC._dict2ListForClanBattleGetMemberAchieveAward(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_get_member_achieve_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.achieve_id or 0

	return msgList
end

function RPC._dict2ListForClanBattleLoginNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_login_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForClanBattleLogoutNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_logout_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForClanBattleEnterNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_enter_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.model or {}

	return msgList
end

function RPC._dict2ListForClanBattleExitNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_exit_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForClanBattleOccupyGridNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_occupy_grid_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.grid_pos or 0
	msgList[4] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleCancelGridNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_cancel_grid_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.grid_pos or 0
	msgList[4] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleOccupyMonsterNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_occupy_monster_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.grid_pos or 0
	msgList[4] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleCancelMonsterNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_cancel_monster_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.grid_pos or 0
	msgList[4] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleOpenGridNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_open_grid_notify"]
	local msgList = RPC._CachedList7

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.grid_pos or 0
	msgList[4] = msgBodyTable.grid or {}
	msgList[5] = msgBodyTable.optick or 0
	msgList[6] = msgBodyTable.score or 0
	msgList[7] = msgBodyTable.talent or {}

	return msgList
end

function RPC._dict2ListForClanBattleNextLayerNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_next_layer_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.clan or {}

	return msgList
end

function RPC._dict2ListForClanBattlePVEStartNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_pve_start_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.grid_pos or 0
	msgList[4] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattlePVEQuitNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_pve_quit_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.finish or {}

	return msgList
end

function RPC._dict2ListForClanBattlePVEFinishNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_pve_finish_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.finish or {}

	return msgList
end

function RPC._dict2ListForClanBattleBuySkillNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_buy_skill_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.skill or {}
	msgList[3] = msgBodyTable.contribution or 0

	return msgList
end

function RPC._dict2ListForClanBattleUseSkillNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_use_skill_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.skill or {}
	msgList[3] = msgBodyTable.grid or {}

	return msgList
end

function RPC._dict2ListForClanBattleSetModelNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_set_model_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.model or {}

	return msgList
end

function RPC._dict2ListForClanBattleRankNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_rank_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.ranking or 0

	return msgList
end

function RPC._dict2ListForClanBattleGiveOrderNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_give_order_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.ordef or 0
	msgList[3] = msgBodyTable.target or 0
	msgList[4] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleSettleNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_settle_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.settle or {}
	msgList[2] = msgBodyTable.close_tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleGetClanAchieveAwardNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_get_clan_achieve_award_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.achieve_id or 0

	return msgList
end

function RPC._dict2ListForClanBattleGetMemberAchieveAwardNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_get_member_achieve_award_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.achieve_id or 0

	return msgList
end

function RPC._dict2ListForClanBattleChatMsgNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_chat_msg_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.chat or {}

	return msgList
end

function RPC._dict2ListForClanBattleGetHonor(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_get_honor_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.honor or {}

	return msgList
end

function RPC._dict2ListForClanBattleExitClanNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_exit_clan_notify"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.clan_name or ""
	msgList[3] = msgBodyTable.member_name or ""
	msgList[4] = msgBodyTable.del_contribution or 0
	msgList[5] = msgBodyTable.left_contribution or 0

	return msgList
end

function RPC._dict2ListForClanBattleMarkMember(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_mark_member_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleUnmarkMember(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_unmark_member_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanBattleOpGridMark(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_op_grid_mark_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.tick or 0
	msgList[3] = msgBodyTable.mark_grid_pos or 0
	msgList[4] = msgBodyTable.unmark_grid_pos or 0

	return msgList
end

function RPC._dict2ListForClanBattleMarkedGridListNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_marked_grid_list_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.marked_grid or {}

	return msgList
end

function RPC._dict2ListForClanBattleBoxMarkAwardNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_battle_boxmark_award_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.layer or 0
	msgList[2] = msgBodyTable.grid or {}

	return msgList
end

function RPC._dict2ListForClanFuncInvite(msgTable)
	local msgBodyTable = msgTable["csp.clan_func_invite_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.tick or 0

	return msgList
end

function RPC._dict2ListForClanFuncRefuseInvite(msgTable)
	local msgBodyTable = msgTable["csp.clan_func_refuse_invite_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.clangid or 0

	return msgList
end

function RPC._dict2ListForClanFuncShare(msgTable)
	local msgBodyTable = msgTable["csp.clan_func_share_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.hint or "[]"
	msgList[2] = msgBodyTable.base or {}
	msgList[3] = msgBodyTable.content or ""
	msgList[4] = msgBodyTable.share_tick or 0

	return msgList
end

function RPC._dict2ListForClanFuncInviteNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_func_invite_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.inviter or {}
	msgList[2] = msgBodyTable.invitee or ""

	return msgList
end

function RPC._dict2ListForClanFuncInviterListNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_func_inviter_list_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForClanFuncRefuseInviteNotify(msgTable)
	local msgBodyTable = msgTable["csp.clan_func_refuse_invite_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.clangid or 0
	msgList[2] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForCampTowerSweep(msgTable)
	local msgBodyTable = msgTable["csp.camp_tower_sweep_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForCampTowerDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.camp_tower_data_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.tower or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForCampTowerReplayRecord(msgTable)
	local msgBodyTable = msgTable["csp.camp_tower_replay_record_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.tower or 0
	msgList[2] = msgBodyTable.layer or 0
	msgList[3] = msgBodyTable.level or 0
	msgList[4] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForCampTowerUpdateStage(msgTable)
	local msgBodyTable = msgTable["csp.camp_tower_update_stage_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.stage or 0

	return msgList
end

function RPC._dict2ListForDynamicExpressionUse(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForDynamicExpressionGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.dynamic_expression_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.new_list or {}

	return msgList
end

function RPC._dict2ListForRefluxGetOnceAward(msgTable)
	local msgBodyTable = msgTable["csp.reflux_get_once_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.index or 0

	return msgList
end

function RPC._dict2ListForRefluxNewSetFlag(msgTable)
	local msgBodyTable = msgTable["csp.reflux_new_set_flag_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.reflux_data or {}
	msgList[2] = msgBodyTable.code or "kCSRefluxSetFlagNone"

	return msgList
end

function RPC._dict2ListForRefluxNewGroupNotify(msgTable)
	local msgBodyTable = msgTable["csp.reflux_new_group_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.group_id or 0

	return msgList
end

function RPC._dict2ListForRefluxDataFreshNotify(msgTable)
	local msgBodyTable = msgTable["csp.reflux_fresh_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.reflux_data or {}

	return msgList
end

function RPC._dict2ListForRoleOweItemNotify(msgTable)
	local msgBodyTable = msgTable["csp.owe_item_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForRoleOpActSimpleGet(msgTable)
	local msgBodyTable = msgTable["csp.role_opact_simple_get_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.simple_data or {}

	return msgList
end

function RPC._dict2ListForCollectAchieveGetAward(msgTable)
	local msgBodyTable = msgTable["csp.collect_achieve_get_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForCollectAchieveProgressNotify(msgTable)
	local msgBodyTable = msgTable["csp.collect_achieve_precess_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.item_id or 0
	msgList[3] = msgBodyTable.process or 0

	return msgList
end

function RPC._dict2ListForNewMazeOpen(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_open_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actID or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForNewMazeLevelEnter(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_level_enter_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actID or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.op_type or "kNewMazeLevelEnterTypeNone"

	return msgList
end

function RPC._dict2ListForNewMazeNodeSelect(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_node_select_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForNewMazeHaloEquip(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_halo_equip_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForNewMazeHaloUnEquip(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_halo_unequip_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForNewMazeMultiAwardListNotify(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_multi_award_list_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.actID or 0
	msgList[2] = msgBodyTable.type or "kNewMazeMultiAwardTypeNone"
	msgList[3] = msgBodyTable.items or {}
	msgList[4] = msgBodyTable.notify_type or "kNewMazeMultiAwardListTypeNone"

	return msgList
end

function RPC._dict2ListForNewMazeItemChangeNotify(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_item_change_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.type or "kNewMazeItemChangeTypeNone"
	msgList[3] = msgBodyTable.items or {}

	return msgList
end

function RPC._dict2ListForNewMazeLayerNextNotify(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_layer_next_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.actid or 0

	return msgList
end

function RPC._dict2ListForNewMazeLevelCycleResetNotify(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_level_cycle_reset_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.actid or 0

	return msgList
end

function RPC._dict2ListForNewMazeLevelExit(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_level_exit_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actID or 0
	msgList[2] = msgBodyTable.op_type or "kNewMazeLevelExitTypeNone"
	msgList[3] = msgBodyTable.inherit_flag or 0

	return msgList
end

function RPC._dict2ListForNewMazeRandPoolCheck(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_randpool_check_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.checkid or 0
	msgList[3] = msgBodyTable.randpool or 0
	msgList[4] = msgBodyTable.checkType or "kNewMazeRandPoolCheckTypeNone"
	msgList[5] = msgBodyTable.param or {}

	return msgList
end

function RPC._dict2ListForNewMazeShopPurchase(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_shop_purchase_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.item or {}
	msgList[3] = msgBodyTable.cur_coin_num or 0

	return msgList
end

function RPC._dict2ListForNewMazeShopSell(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_shop_sell_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.item or {}
	msgList[3] = msgBodyTable.cur_coin_num or 0

	return msgList
end

function RPC._dict2ListForNewMazeShopItemUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_shop_item_update_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actID or 0
	msgList[2] = msgBodyTable.items or {}
	msgList[3] = msgBodyTable.cur_coin or 0

	return msgList
end

function RPC._dict2ListForNewMazeShopLevelUpNotify(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_shop_level_up_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.actid or 0

	return msgList
end

function RPC._dict2ListForNewMazeRandomEventOptionSelect(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_random_event_option_select_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.index or 0
	msgList[3] = msgBodyTable.sub_event or {}

	return msgList
end

function RPC._dict2ListForNewMazeFeatureUse(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_feature_use_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.id or 0
	msgList[3] = msgBodyTable.layer or 0

	return msgList
end

function RPC._dict2ListForNewMazeSetOutsideRelic(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_set_outside_relic_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.hero_id or 0
	msgList[3] = msgBodyTable.outside_relic_id or 0

	return msgList
end

function RPC._dict2ListForNewMazeModifyInherit(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_modify_inherit_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.type or "kNewMazeInheritTypeNone"

	return msgList
end

function RPC._dict2ListForNewMazeSelectInherit(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_select_inherit_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.type or "kNewMazeInheritTypeNone"

	return msgList
end

function RPC._dict2ListForNewMazeEnchanterUse(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_enchanter_use_s"]
	local msgList = RPC._CachedList7

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.hero_id or 0
	msgList[3] = msgBodyTable.enchanter_id or 0
	msgList[4] = msgBodyTable.pos or 0
	msgList[5] = msgBodyTable.old_fetter or 0
	msgList[6] = msgBodyTable.new_fetter or 0
	msgList[7] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForNewMazeTalentSet(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_talent_set_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.talent_item or {}

	return msgList
end

function RPC._dict2ListForNewMazeTalentWorkNotify(msgTable)
	local msgBodyTable = msgTable["csp.newmaze_talent_work_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.actid or 0
	msgList[2] = msgBodyTable.talent_type or "kNewMazeTalentTypeNone"

	return msgList
end

function RPC._dict2ListForPetPossess(msgTable)
	local msgBodyTable = msgTable["csp.pet_possess_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.op_type or "kPetPossessTypeUp"
	msgList[3] = msgBodyTable.career_data or {}
	msgList[4] = msgBodyTable.possess_tick or 0

	return msgList
end

function RPC._dict2ListForPetPossessReplace(msgTable)
	local msgBodyTable = msgTable["csp.pet_possess_replace_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.op_type or "kPetPossessReplaceTypeNor"
	msgList[2] = msgBodyTable.src_resid or 0
	msgList[3] = msgBodyTable.dst_resid or 0
	msgList[4] = msgBodyTable.src_tick or 0
	msgList[5] = msgBodyTable.dst_tick or 0
	msgList[6] = msgBodyTable.possess_data or {}

	return msgList
end

function RPC._dict2ListForPetDevelopIntelligence(msgTable)
	local msgBodyTable = msgTable["csp.pet_develop_intelligence_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.intelligence or {}
	msgList[3] = msgBodyTable.develop_type or "kPetAttrDevelopTypeNor"

	return msgList
end

function RPC._dict2ListForPetChooseIntelligence(msgTable)
	local msgBodyTable = msgTable["csp.pet_choose_intelligence_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.intelligence or {}
	msgList[3] = msgBodyTable.op_type or "kPettPossessChooseTypePick"

	return msgList
end

function RPC._dict2ListForPetDevelopGift(msgTable)
	local msgBodyTable = msgTable["csp.pet_develop_gift_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.gift or {}
	msgList[3] = msgBodyTable.item_id or 0

	return msgList
end

function RPC._dict2ListForPetChooseGift(msgTable)
	local msgBodyTable = msgTable["csp.pet_choose_gift_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.op_type or "kPettPossessChooseTypePick"
	msgList[3] = msgBodyTable.gift or {}

	return msgList
end

function RPC._dict2ListForPetItemGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.pet_item_get_notify"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.type or "kPetItemTypeNone"
	msgList[2] = msgBodyTable.pet or {}
	msgList[3] = msgBodyTable.pet_amulet or {}
	msgList[4] = msgBodyTable.pet_gem or {}
	msgList[5] = msgBodyTable.change_list or {}
	msgList[6] = msgBodyTable.reason or "kPetItemReasonNone"

	return msgList
end

function RPC._dict2ListForPetItemDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.pet_item_del_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kPetItemTypeNone"
	msgList[2] = msgBodyTable.gid or "[]"

	return msgList
end

function RPC._dict2ListForPetItemUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.pet_item_update_notify"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.type or "kPetItemTypeNone"
	msgList[2] = msgBodyTable.pet or {}
	msgList[3] = msgBodyTable.pet_amulet or {}
	msgList[4] = msgBodyTable.pet_gem or {}
	msgList[5] = msgBodyTable.pet_degree or {}

	return msgList
end

function RPC._dict2ListForPetDegreeLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.pet_degree_level_up_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.origin_level or 0
	msgList[2] = msgBodyTable.final_level or 0

	return msgList
end

function RPC._dict2ListForPetDegreeRuneActive(msgTable)
	local msgBodyTable = msgTable["csp.pet_degree_rune_active_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.pos or 0
	msgList[3] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForPetStarUp(msgTable)
	local msgBodyTable = msgTable["csp.pet_starup_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.star or 0
	msgList[3] = msgBodyTable.gift or {}

	return msgList
end

function RPC._dict2ListForPetRecycle(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForPetExchange(msgTable)
	local msgBodyTable = msgTable["csp.pet_exchange_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.id or {}

	return msgList
end

function RPC._dict2ListForPetRuneActive(msgTable)
	local msgBodyTable = msgTable["csp.pet_rune_active_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.pos or 0
	msgList[3] = msgBodyTable.value or 0

	return msgList
end

function RPC._dict2ListForPetGemLevelUp(msgTable)
	local msgBodyTable = msgTable["csp.pet_gem_levelup_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.add or {}
	msgList[2] = msgBodyTable.del_gem_gid or "[]"

	return msgList
end

function RPC._dict2ListForPetGemRerandAttribute(msgTable)
	local msgBodyTable = msgTable["csp.pet_gem_rerand_attribute_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or "kPetGemRerandAttrTypeNone"
	msgList[2] = msgBodyTable.gid or ""
	msgList[3] = msgBodyTable.attrs or {}

	return msgList
end

function RPC._dict2ListForPetGemInset(msgTable)
	local msgBodyTable = msgTable["csp.pet_gem_inset_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.type or "kPetItemOpTypeNone"
	msgList[2] = msgBodyTable.pet_gid or ""
	msgList[3] = msgBodyTable.on_gem_gid or ""
	msgList[4] = msgBodyTable.off_gem_gid or ""

	return msgList
end

function RPC._dict2ListForPetAmuletSet(msgTable)
	local msgBodyTable = msgTable["csp.pet_amulet_set_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.type or "kPetItemOpTypeNone"
	msgList[2] = msgBodyTable.pos or "kPetAmuletPosNone"
	msgList[3] = msgBodyTable.pet_id or 0
	msgList[4] = msgBodyTable.on_amulet_id or 0
	msgList[5] = msgBodyTable.off_amulet_id or 0

	return msgList
end

function RPC._dict2ListForPetAmuletStarUp(msgTable)
	local msgBodyTable = msgTable["csp.pet_amulet_starup_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.star or 0

	return msgList
end

function RPC._dict2ListForPetRuneUp(msgTable)
	local msgBodyTable = msgTable["csp.pet_rune_up_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.hero_on or ""

	return msgList
end

function RPC._dict2ListForPetRuneHeroBind(msgTable)
	local msgBodyTable = msgTable["csp.pet_rune_hero_bind_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.resid or 0
	msgList[2] = msgBodyTable.hero_on or ""
	msgList[3] = msgBodyTable.hero_off or ""

	return msgList
end

function RPC._dict2ListForPetGemSaveAttribute(msgTable)
	local msgBodyTable = msgTable["csp.pet_gem_save_attribute_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or "kPetGemRerandAttrTypeNone"
	msgList[2] = msgBodyTable.gid or ""
	msgList[3] = msgBodyTable.attrs or {}

	return msgList
end

function RPC._dict2ListForPetOffWears(msgTable)
	local msgBodyTable = msgTable["csp.pet_off_wears_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.petid or {}

	return msgList
end

function RPC._dict2ListForMysteryShopEnter(msgTable)
	local msgBodyTable = msgTable["csp.mystery_shop_enter_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.shop_sub_type or "kMysteryShopSubTypeNone"

	return msgList
end

function RPC._dict2ListForMysteryShopExit(msgTable)
	local msgBodyTable = msgTable["csp.mystery_shop_exit_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.shop_sub_type or "kMysteryShopSubTypeNone"

	return msgList
end

function RPC._dict2ListForMysteryShopUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.mystery_shop_update_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.shop_sub_type or "kMysteryShopSubTypeNone"
	msgList[2] = msgBodyTable.goods_item or {}

	return msgList
end

function RPC._dict2ListForBPPvpGroupEnterRoom(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_group_enter_room_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.state or {}
	msgList[2] = msgBodyTable.group_room or {}

	return msgList
end

function RPC._dict2ListForBPPvpGroupDetailGet(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForBPPvpOpponentDetailNotify(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_opponent_detail_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.bppvp_detail or {}

	return msgList
end

function RPC._dict2ListForBPPvpGroupReportGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_report_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.report or {}

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutGetHallData(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_get_hall_data_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.area_id or 0
	msgList[3] = msgBodyTable.state or {}
	msgList[4] = msgBodyTable.detail or {}

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutEnterRoom(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_enter_room_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.room_info or {}
	msgList[2] = msgBodyTable.comm or {}
	msgList[3] = msgBodyTable.is_end or 0

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutSetBPPool(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_set_bppool_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.result or "kCSOpActBPPvpOpSucc"

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutBP(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_bp_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.result or "kCSOpActBPPvpOpSucc"

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutFormation(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForBPPvpKnockoutBPPoolGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_get_bppool_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.bppvp_detail or {}

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutFormationGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_get_formation_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutRoomInfoGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_room_info_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.room_info or {}

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutReportGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_report_get_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.report or {}

	return msgList
end

function RPC._dict2ListForBPPvpGameDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_game_data_notify"]
	local msgList = RPC._CachedList8

	msgList[1] = msgBodyTable.pvp_state or {}
	msgList[2] = msgBodyTable.group_room or {}
	msgList[3] = msgBodyTable.knockout_room or {}
	msgList[4] = msgBodyTable.room_id or 0
	msgList[5] = msgBodyTable.type or "kCSActBPPvpNotifyTypeNone"
	msgList[6] = msgBodyTable.room_state or {}
	msgList[7] = msgBodyTable.bp_data or {}
	msgList[8] = msgBodyTable.knockout_fight or {}

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutBet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_bet_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.room_id or 0
	msgList[3] = msgBodyTable.bet_pos or 0
	msgList[4] = msgBodyTable.over_time or 0
	msgList[5] = msgBodyTable.blue_bet_num or 0
	msgList[6] = msgBodyTable.red_bet_num or 0

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutBetInfoGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_bet_info_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.room_info or {}
	msgList[2] = msgBodyTable.blue_bet_num or 0
	msgList[3] = msgBodyTable.red_bet_num or 0
	msgList[4] = msgBodyTable.right_count or 0

	return msgList
end

function RPC._dict2ListForBPPvpKnockoutBetHistoryGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_bet_his_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.bet_his or {}

	return msgList
end

function RPC._dict2ListForBPPvpActivityStateGet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_activity_state_get_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.state or {}
	msgList[2] = msgBodyTable.knockout_room or 0
	msgList[3] = msgBodyTable.bet_room or 0

	return msgList
end

function RPC._dict2ListForBPPvpKnockouotBanRuleSet(msgTable)
	local msgBodyTable = msgTable["csp.bppvp_knockout_ban_rule_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.room_id or 0
	msgList[3] = msgBodyTable.rule_id or 0

	return msgList
end

function RPC._dict2ListForPetMazeSaveFormation(msgTable)
	local msgBodyTable = msgTable["csp.petmaze_save_formation_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForPetMazeSaveSupportFormation(msgTable)
	local msgBodyTable = msgTable["csp.petmaze_save_support_formation_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.stage_id or 0

	return msgList
end

function RPC._dict2ListForPetMazeReset(msgTable)
	local msgBodyTable = msgTable["csp.petmaze_reset_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.stage_id or 0

	return msgList
end

function RPC._dict2ListForPetMazeGetStepAward(msgTable)
	local msgBodyTable = msgTable["csp.petmaze_get_step_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForPetMazeRoleDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.petmaze_role_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForPetMazeSweep(msgTable)
	local msgBodyTable = msgTable["csp.petmaze_sweep_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForNewPveChooseLevel(msgTable)
	local msgBodyTable = msgTable["csp.newpve_choose_level_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForNewPveChooseLimits(msgTable)
	local msgBodyTable = msgTable["csp.newpve_choose_limits_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.limits or {}

	return msgList
end

function RPC._dict2ListForNewPveReset(msgTable)
	local msgBodyTable = msgTable["csp.newpve_reset_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForNewPveSaveFormation(msgTable)
	local msgBodyTable = msgTable["csp.newpve_save_formation_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForNewPveGetAward(msgTable)
	local msgBodyTable = msgTable["csp.newpve_get_award_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.battlefield_type or 0
	msgList[3] = msgBodyTable.id or 0

	return msgList
end

function RPC._dict2ListForNewPveRoleDataNotify(msgTable)
	local msgBodyTable = msgTable["csp.newpve_role_data_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForNewPveGetFormation(msgTable)
	local msgBodyTable = msgTable["csp.newpve_get_formation_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForNewPveGetCurFormation(msgTable)
	local msgBodyTable = msgTable["csp.newpve_get_cur_formation_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForNewPveWearRelic(msgTable)
	local msgBodyTable = msgTable["csp.newpve_wear_relic_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.hero_id or 0
	msgList[3] = msgBodyTable.relic_id or 0

	return msgList
end

function RPC._dict2ListForNewPveResetProgress(msgTable)
	local msgBodyTable = msgTable["csp.newpve_reset_progress_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForNewPveResetStage(msgTable)
	local msgBodyTable = msgTable["csp.newpve_reset_stage_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.act_id or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.stage or 0

	return msgList
end

function RPC._dict2ListForNewPvePopUp(msgTable)
	local msgBodyTable = msgTable["csp.newpve_pop_up_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.act_id or 0

	return msgList
end

function RPC._dict2ListForRelaxingGamePass(msgTable)
	local msgBodyTable = msgTable["csp.relaxing_game_pass_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or "kRelaxingGameTypeNone"
	msgList[2] = msgBodyTable.chapter or 0
	msgList[3] = msgBodyTable.stage or 0

	return msgList
end

function RPC._dict2ListForRelaxingGameGetBigAward(msgTable)
	local msgBodyTable = msgTable["csp.relaxing_game_get_big_award_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.id or 0
	msgList[2] = msgBodyTable.type or "kRelaxingGameTypeNone"

	return msgList
end

function RPC._dict2ListForRelaxingGameChooseFirstGame(msgTable)
	local msgBodyTable = msgTable["csp.relaxing_game_choose_first_game_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.type or "kRelaxingGameTypeNone"

	return msgList
end

function RPC._dict2ListForFormationRecommendRankGet(msgTable)
	local msgBodyTable = msgTable["csp.formation_recommend_rank_get_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.type or 0
	msgList[2] = msgBodyTable.level or 0
	msgList[3] = msgBodyTable.hero or {}
	msgList[4] = msgBodyTable.formation or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeAdd(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_add_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.target_type or "kMasterApprenticeTypeTypeMaster"
	msgList[2] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForMasterApprenticeDel(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_del_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.target_type or "kMasterApprenticeTypeTypeMaster"
	msgList[2] = msgBodyTable.uid or ""
	msgList[3] = msgBodyTable.del_time or 0

	return msgList
end

function RPC._dict2ListForMasterApprenticeAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_add_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.target_type or "kMasterApprenticeTypeTypeMaster"
	msgList[2] = msgBodyTable.info or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_del_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.target_type or "kMasterApprenticeTypeTypeMaster"
	msgList[2] = msgBodyTable.uid or ""
	msgList[3] = msgBodyTable.is_graduate or 0

	return msgList
end

function RPC._dict2ListForMasterApprenticeGraduation(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_graduation_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.uid or ""

	return msgList
end

function RPC._dict2ListForMasterApprenticeNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.type or "kMasterApprenticeTypeTypeMaster"
	msgList[2] = msgBodyTable.master or {}
	msgList[3] = msgBodyTable.apprentice or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeInviteOp(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_invite_op_s"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.target_type or "kMasterApprenticeTypeTypeMaster"
	msgList[2] = msgBodyTable.op_type or "kMasterApprenticeInviteNone"
	msgList[3] = msgBodyTable.uid or ""
	msgList[4] = msgBodyTable.fail or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeInviteNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_invite_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.master_invite or {}
	msgList[2] = msgBodyTable.apprentice_invite or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeInviteAddNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_invite_add_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.master_invite or {}
	msgList[2] = msgBodyTable.apprentice_invite or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeInviteDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_invite_del_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.master_invite or ""
	msgList[2] = msgBodyTable.apprentice_invite or ""

	return msgList
end

function RPC._dict2ListForMasterApprenticeSearch(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_search_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.result or {}
	msgList[2] = msgBodyTable.resp_code or "kBuddySearchCodeSuccess"

	return msgList
end

function RPC._dict2ListForMasterApprenticeRecommend(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_recommend_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.target_type or "kMasterApprenticeTypeTypeMaster"
	msgList[2] = msgBodyTable.recommend or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeEnroll(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_enroll_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.enroll_type or "kMasterApprenticeTypeTypeMaster"

	return msgList
end

function RPC._dict2ListForMasterApprenticeQualificationUpdate(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_qualification_update_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.master_qualification or 0
	msgList[2] = msgBodyTable.apprentice_qualification or 0

	return msgList
end

function RPC._dict2ListForMasterApprenticeTaskUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_task_update_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSTaskTypeNone"
	msgList[2] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeGetTaskAward(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_get_task_award_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSTaskTypeNone"
	msgList[2] = msgBodyTable.id or {}

	return msgList
end

function RPC._dict2ListForMasterGetLevelAward(msgTable)
	local msgBodyTable = msgTable["csp.master_get_level_award_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForApprenticeRequestDevelopGuide(msgTable)
	local msgBodyTable = msgTable["csp.apprentice_request_develop_guide_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.master_uid or ""

	return msgList
end

function RPC._dict2ListForMasterSetDevelopGuide(msgTable)
	local msgBodyTable = msgTable["csp.master_set_develop_guide_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.apprentice_uid or ""
	msgList[2] = msgBodyTable.hero_gid or "[]"

	return msgList
end

function RPC._dict2ListForMasterGetApprenticeAllHero(msgTable)
	local msgBodyTable = msgTable["csp.master_get_apprentice_all_hero_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.apprentice_uid or ""
	msgList[2] = msgBodyTable.hero or {}
	msgList[3] = msgBodyTable.crystal_hero or "[]"

	return msgList
end

function RPC._dict2ListForApprenticeRequestBattleGuide(msgTable)
	local msgBodyTable = msgTable["csp.apprentice_request_battle_guide_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.master_uid or ""
	msgList[2] = msgBodyTable.stage or 0

	return msgList
end

function RPC._dict2ListForMasterSetBattleGuide(msgTable)
	local msgBodyTable = msgTable["csp.master_set_battle_guide_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.apprentice_uid or ""
	msgList[2] = msgBodyTable.stage or 0
	msgList[3] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForMasterApprenticeTaskRefreshNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_apprentice_task_refresh_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.type or "kCSTaskTypeNone"
	msgList[2] = msgBodyTable.task or {}

	return msgList
end

function RPC._dict2ListForMasterExperienceNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_exprerience_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.experience or 0

	return msgList
end

function RPC._dict2ListForMasterRecieveDevelopGuideNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_recieve_develop_guide_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.apprentice_uid or ""

	return msgList
end

function RPC._dict2ListForMasterRecieveBattleGuideNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_recieve_battle_guide_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.apprentice_uid or ""
	msgList[2] = msgBodyTable.stage or 0

	return msgList
end

function RPC._dict2ListForApprenticeRecieveDevelopGuideNotify(msgTable)
	local msgBodyTable = msgTable["csp.apprentice_recieve_develop_guide_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.hero_gid or "[]"

	return msgList
end

function RPC._dict2ListForApprenticeRecieveBattleGuideNotify(msgTable)
	local msgBodyTable = msgTable["csp.apprentice_recieve_battle_guide_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.stage or 0
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForMasterOpenDevelopGuide(msgTable)
	local msgBodyTable = msgTable["csp.master_open_develop_guide_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.apprentice_uid or ""

	return msgList
end

function RPC._dict2ListForApprenticeAddRentCnt(msgTable)
	local msgBodyTable = msgTable["csp.apprentice_add_rent_cnt_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.master_uid or ""

	return msgList
end

function RPC._dict2ListForApprenticeAddGuideCnt(msgTable)
	local msgBodyTable = msgTable["csp.apprentice_add_guide_cnt_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.master_uid or ""

	return msgList
end

function RPC._dict2ListForMasterRecieveProgressNotify(msgTable)
	local msgBodyTable = msgTable["csp.master_recieve_progress_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.action or 0
	msgList[2] = msgBodyTable.param or 0
	msgList[3] = msgBodyTable.is_replace or 0

	return msgList
end

function RPC._dict2ListForMasterClientUpdateProgress(msgTable)
	local msgBodyTable = msgTable["csp.master_client_update_progress_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.action or "kResMasterApprenticeTaskActionNone"
	msgList[2] = msgBodyTable.param or 0
	msgList[3] = msgBodyTable.replace or 0

	return msgList
end

function RPC._dict2ListForItemUpdateNotify(msgTable)
	local msgBodyTable = msgTable["csp.item_update_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.reason or "kItemUpdateOpTypeNone"
	msgList[2] = msgBodyTable.new_list or {}
	msgList[3] = msgBodyTable.change_list or {}

	return msgList
end

function RPC._dict2ListForHeroGetNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_get_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.new_list or {}
	msgList[2] = msgBodyTable.type or 0

	return msgList
end

function RPC._dict2ListForHeroDelNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_del_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.gid_list or "[]"
	msgList[2] = msgBodyTable.type or 0

	return msgList
end

function RPC._dict2ListForHeroLevelUpNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_level_up_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForHeroStepUpNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_step_up_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.step or 0

	return msgList
end

function RPC._dict2ListForHeroStarUpNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_star_up_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.star or 0

	return msgList
end

function RPC._dict2ListForHeroRecycle(msgTable)
	local msgBodyTable = msgTable["csp.hero_recycle_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.level_gold or 0
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForHeroRecharge(msgTable)
	local msgBodyTable = msgTable["csp.hero_recharge_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.recharge or 0
	msgList[3] = msgBodyTable.skill_index or 0

	return msgList
end

function RPC._dict2ListForHeroReset(msgTable)
	local msgBodyTable = msgTable["csp.hero_reset_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForHeroLevelReset(msgTable)
	local msgBodyTable = msgTable["csp.hero_level_reset_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.hero_gid or ""

	return msgList
end

function RPC._dict2ListForHeroStepReset(msgTable)
	local msgBodyTable = msgTable["csp.hero_step_reset_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.next_tick or 0
	msgList[3] = msgBodyTable.pos or 0

	return msgList
end

function RPC._dict2ListForHeroLock(msgTable)
	local msgBodyTable = msgTable["csp.hero_lock_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.hero_gid or ""

	return msgList
end

function RPC._dict2ListForHeroUnlock(msgTable)
	local msgBodyTable = msgTable["csp.hero_unlock_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.hero_gid or ""

	return msgList
end

function RPC._dict2ListForHeroStarUpBatch(msgTable)
	local msgBodyTable = msgTable["csp.hero_star_up_batch_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.data or {}

	return msgList
end

function RPC._dict2ListForHeroExchange(msgTable)
	local msgBodyTable = msgTable["csp.hero_exchange_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.source_hero or {}
	msgList[2] = msgBodyTable.target_hero or {}
	msgList[3] = msgBodyTable.is_sympathizer or 0

	return msgList
end

function RPC._dict2ListForHeroOffWears(msgTable)
	local msgBodyTable = msgTable["csp.hero_off_wears_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.op_type or "kCSHeroOPOffWearsTypeNone"
	msgList[2] = msgBodyTable.gid or "[]"

	return msgList
end

function RPC._dict2ListForHeroResetNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_reset_step_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.next_tick or 0
	msgList[2] = msgBodyTable.pos or 0

	return msgList
end

function RPC._dict2ListForHeroStarBack(msgTable)
	local msgBodyTable = msgTable["csp.hero_star_back_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.reset_hero or {}
	msgList[2] = msgBodyTable.op_tick or 0

	return msgList
end

function RPC._dict2ListForHeroPaintNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_paint_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.res_id or 0
	msgList[2] = msgBodyTable.paint_level or 0
	msgList[3] = msgBodyTable.change_time or 0

	return msgList
end

function RPC._dict2ListForHeroPaintAbilityNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_paint_ability_notify"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.res_id or 0
	msgList[2] = msgBodyTable.ability or {}
	msgList[3] = msgBodyTable.change_time or 0

	return msgList
end

function RPC._dict2ListForHeroDevelop(msgTable)
	local msgBodyTable = msgTable["csp.hero_develop_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.res_id or 0
	msgList[2] = msgBodyTable.develop_id or 0
	msgList[3] = msgBodyTable.level or 0

	return msgList
end

function RPC._dict2ListForHeroDevelopOpenNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_develop_open_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.team_status or {}
	msgList[2] = msgBodyTable.stage_status or 0

	return msgList
end

function RPC._dict2ListForHeroDevelopUpdateRedPoint(msgTable)
	local msgBodyTable = msgTable["csp.hero_develop_open_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.op_type or "kCSHeroDevelopOpenTypeNone"
	msgList[2] = msgBodyTable.pos or 0

	return msgList
end

function RPC._dict2ListForHeroPaintItemConvert(msgTable)
	local msgBodyTable = msgTable["csp.hero_paint_item_convert_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.paint_item or {}

	return msgList
end

function RPC._dict2ListForHeroVoidStarChangeNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_void_star_change_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.hero_gid or ""
	msgList[2] = msgBodyTable.new_star or 0

	return msgList
end

function RPC._dict2ListForHeroCrystalStoryUnlock(msgTable)
	local msgBodyTable = msgTable["csp.hero_crystal_story_unlock_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.res_id or 0
	msgList[2] = msgBodyTable.crystal_unlock or ""

	return msgList
end

function RPC._dict2ListForHeroPaintRelateUnlockNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_paint_relate_unlock_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.res_id or 0
	msgList[2] = msgBodyTable.relate_level or 0

	return msgList
end

function RPC._dict2ListForHeroNewPaintNotify(msgTable)
	local msgBodyTable = msgTable["csp.hero_new_paint_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.res_id or 0
	msgList[2] = msgBodyTable.paint_level or 0

	return msgList
end

function RPC._dict2ListForEquipSchemeUpdate(msgTable)
	local msgBodyTable = msgTable["csp.equip_scheme_update_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.sel_id or 0
	msgList[2] = msgBodyTable.item or {}
	msgList[3] = msgBodyTable.version or 0
	msgList[4] = msgBodyTable.name or ""
	msgList[5] = msgBodyTable.update or 0

	return msgList
end

function RPC._dict2ListForEquipSchemeApply(msgTable)
	local msgBodyTable = msgTable["csp.equip_scheme_apply_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.sel_id or 0
	msgList[2] = msgBodyTable.version or 0

	return msgList
end

function RPC._dict2ListForEquipSchemeRename(msgTable)
	local msgBodyTable = msgTable["csp.equip_scheme_rename_s"]
	local msgList = RPC._CachedList3

	msgList[1] = msgBodyTable.sel_id or 0
	msgList[2] = msgBodyTable.name or ""
	msgList[3] = msgBodyTable.version or 0

	return msgList
end

function RPC._dict2ListForEquipSchemeDelete(msgTable)
	local msgBodyTable = msgTable["csp.equip_scheme_delete_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.sel_id or 0
	msgList[2] = msgBodyTable.version or 0

	return msgList
end

function RPC._dict2ListForEquipSchemeItemNotify(msgTable)
	local msgBodyTable = msgTable["csp.equip_scheme_item_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.item_id or 0
	msgList[2] = msgBodyTable.item or {}

	return msgList
end

function RPC._dict2ListForEquipTeamWear(msgTable)
	local msgBodyTable = msgTable["csp.equip_team_wear_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.wear_list or {}

	return msgList
end

function RPC._dict2ListForHeartBeat(msgTable)
	local msgBodyTable = msgTable["csp.heart_beat_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.time or 0
	msgList[2] = msgBodyTable.count or 0

	return msgList
end

function RPC._dict2ListForNetDelay(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForNewDayNotify(msgTable)
	local msgBodyTable = msgTable["csp.new_day_notify"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.curtick or 0
	msgList[2] = msgBodyTable.today_camp_type or 0

	return msgList
end

function RPC._dict2ListForChatHeartBeat(msgTable)
	local msgBodyTable = msgTable["csp.chat_heartbeat_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.time or 0

	return msgList
end

function RPC._dict2ListForChatChannelList(msgTable)
	local msgBodyTable = msgTable["csp.chat_channel_s"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.channel or {}

	return msgList
end

function RPC._dict2ListForZChatRegister(msgTable)
	local msgBodyTable = msgTable["csp.zchat_register_s"]
	local msgList = RPC._CachedList6

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.pos or 0
	msgList[3] = msgBodyTable.identity or ""
	msgList[4] = msgBodyTable.connkey or ""
	msgList[5] = msgBodyTable.connip or ""
	msgList[6] = msgBodyTable.connport or 0

	return msgList
end

function RPC._dict2ListForZChatSend(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForChatPull(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForChatSystemNotify(msgTable)
	local msgBodyTable = msgTable["csp.chat_notify"]
	local msgList = RPC._CachedList4

	msgList[1] = msgBodyTable.channel or "kMsgChannelTypeNone"
	msgList[2] = msgBodyTable.msg or {}
	msgList[3] = msgBodyTable.history or 0
	msgList[4] = msgBodyTable.sub_channel or "kMsgSubChannelTypeNone"

	return msgList
end

function RPC._dict2ListForZChatReport(msgTable)
	return RPC._CachedList0
end

function RPC._dict2ListForBroadcastSvrPkgNotify(msgTable)
	local msgBodyTable = msgTable["csp.chat_broadcast_notify"]
	local msgList = RPC._CachedList1

	msgList[1] = msgBodyTable.type or "kCSBroadcastSvrPkgNone"

	return msgList
end

function RPC._dict2ListForWChatRegister(msgTable)
	local msgBodyTable = msgTable["csp.chat_register_s"]
	local msgList = RPC._CachedList5

	msgList[1] = msgBodyTable.uid or ""
	msgList[2] = msgBodyTable.token or ""
	msgList[3] = msgBodyTable.world_channel_gid or ""
	msgList[4] = msgBodyTable.zone_channel_gid or ""
	msgList[5] = msgBodyTable.clan_gid or ""

	return msgList
end

function RPC._dict2ListForWChatChannelUpdate(msgTable)
	local msgBodyTable = msgTable["csp.chat_channel_update_s"]
	local msgList = RPC._CachedList2

	msgList[1] = msgBodyTable.channels or {}
	msgList[2] = msgBodyTable.code or "kCSChanneNone"

	return msgList
end

RPC._msgRespCBMap = {
	KCSMsgDynamicExpressionUse = "onDynamicExpressionUseResp",
	kCSMsgCampTowerUpdateStage = "onCampTowerUpdateStageResp",
	kCSMsgClanFuncRefuseInviteNotify = "onClanFuncRefuseInviteNotify",
	kCSMsgOpActChatGameChooseBranch = "onOpActChatGameChooseBranchResp",
	kCSMsgMasterApprenticeAddNotify = "onMasterApprenticeAddNotify",
	kCSMsgBPPvpKnockoutFormation = "onBPPvpKnockoutFormationResp",
	kCSMsgClanBattleGetMemberAchieveAwardNotify = "onClanBattleGetMemberAchieveAwardNotify",
	kCSMsgClanBattleSettleNotify = "onClanBattleSettleNotify",
	kCSMsgClanRefuseApply = "onClanRefuseApplyResp",
	kCSMsgClanBattlePVEFinishNotify = "onClanBattlePVEFinishNotify",
	kCSMsgClanBattleMarkMember = "onClanBattleMarkMemberResp",
	kCSMsgClanBattleEnterNotify = "onClanBattleEnterNotify",
	kCSMsgHouseDispatchLock = "onHouseDispatchLockResp",
	kCSMsgClanBattleExitNotify = "onClanBattleExitNotify",
	kCSMsgOpActEquipRecycleGetAward = "onOpActEquipRecycleGetAwardResp",
	kCSMsgClanBattleLogoutNotify = "onClanBattleLogoutNotify",
	kCSMsgClanBattleBuySkill = "onClanBattleBuySkillResp",
	kCSMsgClanBattleOpenGrid = "onClanBattleOpenGridResp",
	kCSMsgCampTowerReplayRecord = "onCampTowerReplayRecordResp",
	kCSMsgClanBattleOccupyMonster = "onClanBattleOccupyMonsterResp",
	kCSMsgBattlePassBpAwardNotify = "onBattlePassBpAwardNotify",
	kCSMsgListAttrNotify = "onListAttrNotify",
	kCSMsgQQBlueInfoNotify = "onQQBlueInfoNotify",
	kCSMsgOpactArenaOpponentDetailNotify = "onOpactArenaOpponentDetailNotify",
	kCSMsgProficentGetScore = "onProficentGetScoreResp",
	kCSMsgProficentLevelUp = "onProficentLevelUpResp",
	kCSMsgCrystalMsgLevelNotify = "onCrystalMsgLevelNotify",
	kCSMsgClanDutyNotify = "onClanDutyNotify",
	kCSMsgRentTaskRefreshNotify = "onRentTaskRefreshNotify",
	kCSMsgRechargeGenerateOrderID = "onRechargeGenerateOrderIDResp",
	kCSMsgBPPvpGameDataNotify = "onBPPvpGameDataNotify",
	kCSMsgRentMatch = "onRentMatchResp",
	kCSMsgOpActTowerReplayRecord = "onOpActTowerReplayRecordResp",
	kCSMsgEquipWear = "onEquipWearResp",
	kCSMsgArtifactOff = "onArtifactOffResp",
	kCSMsgRoleShopRefreshItemNotify = "onRoleShopRefreshItemNotify",
	kCSMsgHouseDispatchDone = "onHouseDispatchDoneResp",
	kCSMsgResidentOpActivityRoleDataNotify = "onResidentOpActivityRoleDataNotify",
	kCSMsgMazeUpdateNotify = "onMazeUpdateNotify",
	kCSMsgRoleCountNotify = "onRoleCountNotify",
	kCSMsgOpActEquipRecycleChoose = "onOpActEquipRecycleChooseResp",
	kCSMsgMazeRelicsNotify = "onMazeRelicsNotify",
	kCSMsgOpactArenaEnroll = "onOpactArenaEnrollResp",
	kCSMsgClanRename = "onClanRenameResp",
	kCSMsgAsyncPVPMatch = "onAsyncPVPMatchResp",
	kCSMsgOpActDrawNewbieUpDraw = "onOpActDrawNewbieUpDrawResp",
	kCSMsgFormationSelect = "onFormationSelectResp",
	kCSMsgBuddySearch = "onBuddySearchResp",
	kCSMsgBossTowerAwardGet = "onBossTowerAwardGetResp",
	kCSMsgRoleMiscIDCard = "onRoleMiscIDCardResp",
	kCSMsgWelfareFundNotify = "onWelfareFundNotify",
	kCSMsgClanReHeadFrame = "onClanReHeadFrameResp",
	kCSMsgClanCheckinTickNotify = "onClanCheckinTickNotify",
	kCSMsgClanLevelNotify = "onClanLevelNotify",
	kCSMsgHouseUnlockAwardGet = "onHouseUnlockAwardGetResp",
	kCSMsgRoleWorldBossNotify = "onRoleWorldBossNotify",
	kCSMsgEquipLock = "onEquipLockResp",
	kCSMsgClanRehead = "onClanReheadResp",
	kCSMsgOpActivityStateNotify = "onOpActivityStateNotify",
	kCSMsgOpActBusinessOrderCommit = "onOpActBusinessOrderCommitResp",
	kCSMsgWelfarePushGiftTriggerNotify = "onWelfarePushGiftTriggerNotify",
	kCSMsgClanBattleCancelGrid = "onClanBattleCancelGridResp",
	kCSMsgBPPvpKnockoutSetBPPool = "onBPPvpKnockoutSetBPPoolResp",
	kCSMsgOpActBusinessMaterialUpgrade = "onOpActBusinessMaterialUpgradeResp",
	kCSMsgBuddyAddNotify = "onBuddyAddNotify",
	kCSMsgClanCreate = "onClanCreateResp",
	kCSMsgOpActTowerSweep = "onOpActTowerSweepResp",
	kCSMsgSignetNotify = "onSignetNotify",
	kCSMsgPetRuneUp = "onPetRuneUpResp",
	kCSMsgClanBattleSetModel = "onClanBattleSetModelResp",
	kCSMsgRentTMiscNotify = "onRentTMiscNotify",
	kCSMsgRentGetRentedFormation = "onRentGetRentedFormationResp",
	kCSMsgDayICounterNotify = "onDayICounterNotify",
	kCSMsgRentSendLetterNotify = "onRentSendLetterNotify",
	kCSMsgMonumentMsgCompleteNotify = "onMonumentMsgCompleteNotify",
	kCSMsgOpActEquipRecycleStart = "onOpActEquipRecycleStartResp",
	kCSMsgMazeHeroRecordUpdateNotify = "onMazeHeroRecordUpdateNotify",
	kCSMsgCDKey = "onCDKeyResp",
	kCSMsgRoleCommChangeBubble = "onRoleCommChangeBubbleResp",
	kCSMsgPetMazeSweep = "onPetMazeSweepResp",
	kCSMsgResidentOpActivitySysDataNotify = "onResidentOpActivitySysDataNotify",
	kCSMsgOpactArenaDetailGet = "onOpactArenaDetailGetResp",
	kCSMsgClanBattleCancelMonsterNotify = "onClanBattleCancelMonsterNotify",
	kCSMsgAdvanceGetTaskAward = "onAdvanceGetTaskAwardResp",
	kCSMsgClanCheckin = "onClanCheckinResp",
	kCSMsgBattlePassRoleTaskNotify = "onBattlePassRoleTaskNotify",
	kCSMsgRentOwnerRefuse = "onRentOwnerRefuseResp",
	kCSMsgRoleCommChangeHead = "onRoleCommChangeHeadResp",
	kCSMsgRankCacheGetRealRanking = "onRankCacheGetRealRankingResp",
	kCSMsgClanBattleGetClanAchieveAwardNotify = "onClanBattleGetClanAchieveAwardNotify",
	kCSMsgNewMazeItemChangeNotify = "onNewMazeItemChangeNotify",
	kCSMsgOpActCollectWordsGetDeposit = "onOpActCollectWordsGetDepositResp",
	kCSMsgRentRenterNotify = "onRentRenterNotify",
	kCSMsgWelfareGetAward = "onWelfareGetAwardResp",
	kCSMsgOpActChatGameResetChat = "onOpActChatGameResetChatResp",
	kCSMsgRoleCommEditVowHero = "onRoleCommEditVowHeroResp",
	kCSMsgDayCounterResetNotify = "onDayCounterResetNotify",
	kCSMsgOpActChatGameChatEnd = "onOpActChatGameChatEndResp",
	kCSMsgRankGet = "onRankGetResp",
	kCSMsgBookTaskProgressNotify = "onBookTaskProgressNotify",
	kCSMsgBattlePassDataNotify = "onBattlePassDataNotify",
	kCSMsgOpActMonopolySetLibAward = "onOpActMonopolySetLibAwardResp",
	kCSMsgNewMazeHaloUnEquip = "onNewMazeHaloUnEquipResp",
	kCSMsgResidentOpActivityMgrDataNotify = "onResidentOpActivityMgrDataNotify",
	kCSMsgOpActEquipBaptizeInit = "onOpActEquipBaptizeInitResp",
	kCSMsgShopRandDataNotify = "onShopRandDataNotify",
	kCSMsgAsyncPVPFormation = "onAsyncPVPFormationResp",
	kCSMsgTaskUpdateNotify = "onTaskUpdateNotify",
	kCSMsgNoticeMsgNotify = "onNoticeMsgNotify",
	kCSMsgPetDevelopGift = "onPetDevelopGiftResp",
	kCSMsgZChatRegister = "onZChatRegisterResp",
	kCSMsgFormationSnapshotSwapIdx = "onFormationSnapshotSwapIdxResp",
	kCSMsgMultiPVPAwardGet = "onMultiPVPAwardGetResp",
	kCSMsgRoleMiscConsignee = "onRoleMiscConsigneeResp",
	kCSMsgMazeSelect = "onMazeSelectResp",
	kCSMsgDressChatBubbleGetNotify = "onDressChatBubbleGetNotify",
	kCSMsgAdvanceGetStepAward = "onAdvanceGetStepAwardResp",
	kCSMsgShopEnter = "onShopEnterResp",
	kCSMsgRechargeFirstNotify = "onRechargeFirstNotify",
	kCSMsgDayTICounterNotify = "onDayTICounterNotify",
	kCSMsgTimeCounterNotify = "onTimeCounterNotify",
	kCSMsgGiftDrawGiftShare = "onGiftDrawGiftShareResp",
	kCSMsgBingoSetBigReward = "onBingoSetBigRewardResp",
	kCSMsgArtifactLock = "onArtifactLockResp",
	kCSMsgDressHeadFrameSetNotify = "onDressHeadFrameSetNotify",
	kCSMsgOpActEquipRecycleUnlockWorkShop = "onOpActEquipRecycleUnlockWorkShopResp",
	kCSMsgPetPossessReplace = "onPetPossessReplaceResp",
	kCSMsgVIPLevelNotify = "onVIPLevelNotify",
	kCSMsgBuddyBlackListNotify = "onBuddyBlackListNotify",
	kCSMsgErrorBagFullNotify = "onErrorBagFullNotify",
	kCSMsgClanSetAutoAccept = "onClanSetAutoAcceptResp",
	kCSMsgPetDrawRest = "onPetDrawRestResp",
	kCSMsgHotfixVersionNotify = "onHotfixVersionNotify",
	kCSMsgFormationSnapshotGet = "onFormationSnapshotGetResp",
	kCSMsgDrawDayCampNotify = "onDrawDayCampNotify",
	kCSMsgRentWaitLetterNotify = "onRentWaitLetterNotify",
	kCSMsgHouseDispatchRefresh = "onHouseDispatchRefreshResp",
	kCSMsgClanTransfer = "onClanTransferResp",
	KCSMsgRefluxNewGroupNotify = "onRefluxNewGroupNotify",
	kCSMsgClanRecommend = "onClanRecommendResp",
	kCSMsgMasterGetApprenticeAllHero = "onMasterGetApprenticeAllHeroResp",
	kCSMsgSeasonRelicOp = "onSeasonRelicOpResp",
	kCSMsgSkinUnlock = "onSkinUnlockResp",
	kCSMsgDepositAwardGet = "onDepositAwardGetResp",
	kCSMsgOpActDrawNewbieCampDraw = "onOpActDrawNewbieCampDrawResp",
	kCSMsgDrawNewbie = "onDrawNewbieResp",
	kCSMsgOpActBusinessStaminaReceive = "onOpActBusinessStaminaReceiveResp",
	kCSMsgAsyncPVPUpdateNotify = "onAsyncPVPUpdateNotify",
	kCSMsgOpActivitySysDataNotify = "onOpActivitySysDataNotify",
	kCSMsgOpActSeasonBPPointGet = "onOpActSeasonBPPointGetResp",
	kCSMsgClanBattleSetModelNotify = "onClanBattleSetModelNotify",
	kCSMsgEquipTowerChooseHero = "onEquipTowerChooseHeroResp",
	kCSMsgRechargeDeliverNotify = "onRechargeDeliverNotify",
	kCSMsgAsyncPVPSysDataNotify = "onAsyncPVPSysDataNotify",
	kCSMsgRankCacheGetPage = "onRankCacheGetPageResp",
	kCSMsgClanKickNotify = "onClanKickNotify",
	kCSMsgOpActTowerUpdateBuffNotify = "onOpActTowerUpdateBuffNotify",
	kCSMsgNewPveGetCurFormation = "onNewPveGetCurFormationResp",
	kCSMsgSystemSwitchNotify = "onSystemSwitchNotify",
	kCSMsgDrawNewbieReset = "onDrawNewbieResetResp",
	kCSMsgPVEBattleReplay = "onPVEBattleReplayResp",
	kCSMsgAsyncPVPSweep = "onAsyncPVPSweepResp",
	kCSMsgClanBattleEnter = "onClanBattleEnterResp",
	kCSMsgStageUnlockNext = "onStageUnlockNextResp",
	kCSMsgOpactArenaRoleDanAwardNotify = "onOpactArenaRoleDanAwardNotify",
	kCSMsgOpActEquipBaptizeRandAttr = "onOpActEquipBaptizeRandAttrResp",
	kCSMsgProficentGetOtherScore = "onProficentGetOtherScoreResp",
	kCSMsgOpActGuessIsRight = "onOpActGuessIsRightResp",
	kCSMsgTowerStarAwardGet = "onTowerStarAwardGetResp",
	kCSMsgBuddyInviteAddNotify = "onBuddyInviteAddNotify",
	kCSMsgRentLetterNotify = "onRentLetterNotify",
	kCSMsgEquipTowerReplayRecord = "onEquipTowerReplayRecordResp",
	kCSMsgArtifactGetNotify = "onArtifactGetNotify",
	kCSMsgClanBattlePVEQuitNotify = "onClanBattlePVEQuitNotify",
	kCSMsgPetMazeSaveFormation = "onPetMazeSaveFormationResp",
	kCSMsgMazeSweep = "onMazeSweepResp",
	kCSMsgHouseSweep = "onHouseSweepResp",
	kCSMsgHeroPaintRelateUnlockNotify = "onHeroPaintRelateUnlockNotify",
	kCSMsgPetExchange = "onPetExchangeResp",
	kCSMsgOpactArenaRankTopGet = "onOpactArenaRankTopGetResp",
	kCSMsgApprenticeAddGuideCnt = "onApprenticeAddGuideCntResp",
	kCSMsgBuddyUpdateNotify = "onBuddyUpdateNotify",
	kCSMsgMonopolyExchange = "onMonopolyExchangeResp",
	kCSMsgBuddyBondSet = "onBuddyBondSetResp",
	kCSMsgEquipDelNotify = "onEquipDelNotify",
	kCSMsgOpActBusinessMaterialDelete = "onOpActBusinessMaterialDeleteResp",
	kCSMsgOpActBusinessPermissionAddNotify = "onOpActBusinessPermissionAddNotify",
	kCSMsgRechargeCanBuyCountNotify = "onRechargeCanBuyCountNotify",
	kCSMsgNewbieReport = "onNewbieReportResp",
	kCSMsgHeroStarUpBatch = "onHeroStarUpBatchResp",
	kCSMsgNewMazeShopSell = "onNewMazeShopSellResp",
	kCSMsgOpActGuessChooseAnswer = "onOpActGuessChooseAnswerResp",
	kCSMsgNewMazeShopLevelUpNotify = "onNewMazeShopLevelUpNotify",
	kCSMsgMonumentMsgNotify = "onMonumentMsgNotify",
	kCSMsgRentGetLetter = "onRentGetLetterResp",
	kCSMsgNewPveChooseLevel = "onNewPveChooseLevelResp",
	kCSMsgNewMazeSetOutsideRelic = "onNewMazeSetOutsideRelicResp",
	kCSMsgNewMazeModifyInherit = "onNewMazeModifyInheritResp",
	kCSMsgMailGetAttach = "onMailGetAttachResp",
	kCSMsgNewMazeSelectInherit = "onNewMazeSelectInheritResp",
	kCSMsgBuddyOnline = "onBuddyOnlineResp",
	kCSMsgNewMazeTalentSet = "onNewMazeTalentSetResp",
	kCSMsgClanRenotice = "onClanRenoticeResp",
	kCSMsgClanSendMail = "onClanSendMailResp",
	kCSMsgPetChooseIntelligence = "onPetChooseIntelligenceResp",
	kCSMsgArtifactDelNotify = "onArtifactDelNotify",
	kCSMsgCampTowerDataNotify = "onCampTowerDataNotify",
	kCSMsgDressHeadGetNotify = "onDressHeadGetNotify",
	kCSMsgClanBattleUseSkillNotify = "onClanBattleUseSkillNotify",
	kCSMsgClanBattleRankNotify = "onClanBattleRankNotify",
	kCSMsgHouseDispatchAddNotify = "onHouseDispatchAddNotify",
	kCSMsgPetItemDelNotify = "onPetItemDelNotify",
	kCSMsgPetDegreeLevelUp = "onPetDegreeLevelUpResp",
	kCSMsgPetRecycle = "onPetRecycleResp",
	kCSMsgClanBattleNextLayerNotify = "onClanBattleNextLayerNotify",
	kCSMsgOpActOnHookRoleDeliver = "onOpActOnHookRoleDeliverResp",
	kCSMsgEquipSchemeUpdate = "onEquipSchemeUpdateResp",
	kCSMsgDressHeadPendantGetNotify = "onDressHeadPendantGetNotify",
	kCSMsgPetGemInset = "onPetGemInsetResp",
	kCSMsgPetAmuletSet = "onPetAmuletSetResp",
	kCSMsgHouseDispatchStart = "onHouseDispatchStartResp",
	kCSMsgNewPveRoleDataNotify = "onNewPveRoleDataNotify",
	kCSMsgOpactArenaRoleOpen = "onOpactArenaRoleOpenResp",
	kCSMsgProficentBookGemUse = "onProficentBookGemUseResp",
	kCSMsgOpactArenaMatch = "onOpactArenaMatchResp",
	kCSMsgPetGemSaveAttribute = "onPetGemSaveAttributeResp",
	kCSMsgMasterApprenticeGetTaskAward = "onMasterApprenticeGetTaskAwardResp",
	kCSMsgOpActEquipMakeRand = "onOpActEquipMakeRandResp",
	kCSMsgMysteryShopExit = "onMysteryShopExitResp",
	kCSMsgBPPvpGroupEnterRoom = "onBPPvpGroupEnterRoomResp",
	kCSMsgOpActClanBossGetStageAward = "onOpActClanBossGetStageAwardResp",
	kCSMsgBPPvpGroupDetailGet = "onBPPvpGroupDetailGetResp",
	kCSMsgBPPvpGroupReportGet = "onBPPvpGroupReportGetResp",
	kCSMsgRoleCreate = "onRoleCreateResp",
	kCSMsgBattlePassRoleSuperNotify = "onBattlePassRoleSuperNotify",
	kCSMsgOpActivityRoleDataNotify = "onOpActivityRoleDataNotify",
	kCSMsgRentUpdateFormation = "onRentUpdateFormationResp",
	kCSMsgOpActEquipBaptizeChoose = "onOpActEquipBaptizeChooseResp",
	kCSMsgRentRenterRent = "onRentRenterRentResp",
	kCSMsgBPPvpKnockoutBP = "onBPPvpKnockoutBPResp",
	kCSMsgClanBattleGiveOrderNotify = "onClanBattleGiveOrderNotify",
	kCSMsgArtifactLevelUp = "onArtifactLevelUpResp",
	kCSMsgBPPvpKnockoutRoomInfoGet = "onBPPvpKnockoutRoomInfoGetResp",
	kCSMsgVIPGetAward = "onVIPGetAwardResp",
	kCSMsgCrystalMsgSlotNotify = "onCrystalMsgSlotNotify",
	kCSMsgBPPvpKnockoutReportGet = "onBPPvpKnockoutReportGetResp",
	kCSMsgRentSendLetter = "onRentSendLetterResp",
	kCSMsgBPPvpKnockoutBetInfoGet = "onBPPvpKnockoutBetInfoGetResp",
	kCSMsgBPPvpKnockoutBetHistoryGet = "onBPPvpKnockoutBetHistoryGetResp",
	kCSMsgBPPvpKnockouotBanRuleSet = "onBPPvpKnockouotBanRuleSetResp",
	kCSMsgOpActGuessSettleNotify = "onOpActGuessSettleNotify",
	kCSMsgAsyncPVPScore = "onAsyncPVPScoreResp",
	kCSMsgOpActBusinessMaterialCompose = "onOpActBusinessMaterialComposeResp",
	kCSMsgTowerPlayClearNotify = "onTowerPlayClearNotify",
	kCSMsgPetMazeSaveSupportFormation = "onPetMazeSaveSupportFormationResp",
	kCSMsgPetItemGetNotify = "onPetItemGetNotify",
	kCSMsgPetMazeReset = "onPetMazeResetResp",
	kCSMsgMultiPVPReportGet = "onMultiPVPReportGetResp",
	kCSMsgPetMazeGetStepAward = "onPetMazeGetStepAwardResp",
	kCSMsgRoleCommEditSignet = "onRoleCommEditSignetResp",
	kCSMsgNewMazeFeatureUse = "onNewMazeFeatureUseResp",
	kCSMsgNewPveSaveFormation = "onNewPveSaveFormationResp",
	kCSMsgNewPveGetAward = "onNewPveGetAwardResp",
	kCSMsgRentOwnerAccept = "onRentOwnerAcceptResp",
	kCSMsgMonopolyRoll = "onMonopolyRollResp",
	kCSMsgEquipSchemeRename = "onEquipSchemeRenameResp",
	kCSMsgFamiliarLevelChange = "onFamiliarLevelChangeResp",
	kCSMsgNewPveWearRelic = "onNewPveWearRelicResp",
	kCSMsgBuddyInviteOp = "onBuddyInviteOpResp",
	KCSMsgRefluxDataFreshNotify = "onRefluxDataFreshNotify",
	kCSMsgNewPvePopUp = "onNewPvePopUpResp",
	kCSMsgDepositAwardStart = "onDepositAwardStartResp",
	kCSMsgRelaxingGamePass = "onRelaxingGamePassResp",
	kCSMsgClanBattleOpGridMark = "onClanBattleOpGridMarkResp",
	kCSMsgRoleCommGet = "onRoleCommGetResp",
	kCSMsgBuddyBlackListAdd = "onBuddyBlackListAddResp",
	kCSMsgPetRuneHeroBind = "onPetRuneHeroBindResp",
	kCSMsgRelaxingGameGetBigAward = "onRelaxingGameGetBigAwardResp",
	kCSMsgPVEFinish = "onPVEFinishResp",
	kCSMsgRelaxingGameChooseFirstGame = "onRelaxingGameChooseFirstGameResp",
	kCSMsgFormationRecommendRankGet = "onFormationRecommendRankGetResp",
	kCSMsgClanBattleMarkedGridListNotify = "onClanBattleMarkedGridListNotify",
	kCSMsgEquipLevelUp = "onEquipLevelUpResp",
	kCSMsgHouseDispatchAllDone = "onHouseDispatchAllDoneResp",
	kCSMsgMasterApprenticeDelNotify = "onMasterApprenticeDelNotify",
	kCSMsgBPPvpKnockoutBPPoolGet = "onBPPvpKnockoutBPPoolGetResp",
	kCSMsgMasterApprenticeNotify = "onMasterApprenticeNotify",
	kCSMsgMasterApprenticeRecommend = "onMasterApprenticeRecommendResp",
	kCSMsgBossTowerReplayRecord = "onBossTowerReplayRecordResp",
	kCSMsgMasterApprenticeInviteDelNotify = "onMasterApprenticeInviteDelNotify",
	kCSMsgMasterApprenticeInviteNotify = "onMasterApprenticeInviteNotify",
	kCSMsgMasterApprenticeEnroll = "onMasterApprenticeEnrollResp",
	kCSMsgMasterApprenticeQualificationUpdate = "onMasterApprenticeQualificationUpdateResp",
	kCSMsgHeroLevelReset = "onHeroLevelResetResp",
	kCSMsgMysteryShopEnter = "onMysteryShopEnterResp",
	kCSMsgGagGSSetGag = "onGagGSSetGagResp",
	kCSMsgMasterGetLevelAward = "onMasterGetLevelAwardResp",
	kCSMsgOperateEventNotify = "onOperateEventNotify",
	kCSMsgRelicLevelUp = "onRelicLevelUpResp",
	kCSMsgMasterApprenticeTaskRefreshNotify = "onMasterApprenticeTaskRefreshNotify",
	kCSMsgMasterExperienceNotify = "onMasterExperienceNotify",
	kCSMsgMasterRecieveBattleGuideNotify = "onMasterRecieveBattleGuideNotify",
	kCSMsgEquipTowerDataNotify = "onEquipTowerDataNotify",
	kCSMsgApprenticeRecieveDevelopGuideNotify = "onApprenticeRecieveDevelopGuideNotify",
	kCSMsgApprenticeRecieveBattleGuideNotify = "onApprenticeRecieveBattleGuideNotify",
	kCSMsgOpActGuessGetTotalAward = "onOpActGuessGetTotalAwardResp",
	kCSMsgDrawSetDesire = "onDrawSetDesireResp",
	kCSMsgHouseVisitHistoryGet = "onHouseVisitHistoryGetResp",
	kCSMsgAsyncPVPBriefNotify = "onAsyncPVPBriefNotify",
	kCSMsgMasterRecieveProgressNotify = "onMasterRecieveProgressNotify",
	kCSMsgItemUpdateNotify = "onItemUpdateNotify",
	kCSMsgHeroGetNotify = "onHeroGetNotify",
	kCSMsgHeroDelNotify = "onHeroDelNotify",
	kCSMsgClanBattleScoreInfuse = "onClanBattleScoreInfuseResp",
	kCSMsgHeroRecharge = "onHeroRechargeResp",
	kCSMsgMasterApprenticeTaskUpdateNotify = "onMasterApprenticeTaskUpdateNotify",
	kCSMsgRoleCommEditSignature = "onRoleCommEditSignatureResp",
	kCSMsgRechargeRebateAward = "onRechargeRebateAwardResp",
	kCSMsgHeroStepReset = "onHeroStepResetResp",
	kCSMsgHeroLock = "onHeroLockResp",
	kCSMsgNewMazeShopPurchase = "onNewMazeShopPurchaseResp",
	kCSMsgBPPvpActivityStateGet = "onBPPvpActivityStateGetResp",
	kCSMsgHeroPaintAbilityNotify = "onHeroPaintAbilityNotify",
	kCSMsgClanFuncRefuseInvite = "onClanFuncRefuseInviteResp",
	kCSMsgFormationsUpdateByType = "onFormationsUpdateByTypeResp",
	kCSMsgEquipTowerSuperSweepDataNotify = "onEquipTowerSuperSweepDataNotify",
	kCSMsgMultiPVPReportGetNotify = "onMultiPVPReportGetNotify",
	kCSMsgOpActTowerGetScoreAward = "onOpActTowerGetScoreAwardResp",
	kCSMsgRentSetAutoAccept = "onRentSetAutoAcceptResp",
	KCSMsgDynamicExpressionGetNotify = "onDynamicExpressionGetNotify",
	kCSMsgAsyncPVPTargetCache = "onAsyncPVPTargetCacheResp",
	kCSMsgClanBattleBuySkillNotify = "onClanBattleBuySkillNotify",
	kCSMsgClanDismiss = "onClanDismissResp",
	kCSMsgPetGemLevelUp = "onPetGemLevelUpResp",
	kCSMsgGMMsgNotify = "onGMMsgNotify",
	kCSMsgHeartBeat = "onHeartBeatResp",
	kCSMsgChatHeartBeat = "onChatHeartBeatResp",
	kCSMsgMasterApprenticeSearch = "onMasterApprenticeSearchResp",
	kCSMsgChatChannelList = "onChatChannelListResp",
	kCSMsgOpActCollectWordsComposeWord = "onOpActCollectWordsComposeWordResp",
	kCSMsgZChatSend = "onZChatSendResp",
	kCSMsgChatPull = "onChatPullResp",
	kCSMsgHouseMainRoomSet = "onHouseMainRoomSetResp",
	kCSMsgEquipOff = "onEquipOffResp",
	kCSMsgChatSystemNotify = "onChatSystemNotify",
	kCSMsgCampTowerSweep = "onCampTowerSweepResp",
	kCSMsgNewMazeHaloEquip = "onNewMazeHaloEquipResp",
	kCSMsgDrawNebieBestChange = "onDrawNebieBestChangeResp",
	kCSMsgOpActClanBossDispatch = "onOpActClanBossDispatchResp",
	kCSMsgZChatReport = "onZChatReportResp",
	kCSMsgClanSearch = "onClanSearchResp",
	kCSMsgWChatRegister = "onWChatRegisterResp",
	kCSMsgWChatChannelUpdate = "onWChatChannelUpdateResp",
	kCSMsgOpactArenaRoleMatchNotify = "onOpactArenaRoleMatchNotify",
	kCSMsgRoleLeaveLoginQueue = "onRoleLeaveLoginQueueResp",
	kCSMsgOpactArenaRoleInfoRefresh = "onOpactArenaRoleInfoRefreshResp",
	kCSMsgGiftDrawResultNotify = "onGiftDrawResultNotify",
	kCSMsgApprenticeAddRentCnt = "onApprenticeAddRentCntResp",
	kCSMsgClanBattleGetMemberAchieveAward = "onClanBattleGetMemberAchieveAwardResp",
	kCSMsgApprenticeRequestDevelopGuide = "onApprenticeRequestDevelopGuideResp",
	kCSMsgPowerExchange = "onPowerExchangeResp",
	kCSMsgAsyncPVPAttackTimesNotify = "onAsyncPVPAttackTimesNotify",
	kCSMsgBuddyDelNotify = "onBuddyDelNotify",
	kCSMsgDrawRecord = "onDrawRecordResp",
	kCSMsgHeroDevelop = "onHeroDevelopResp",
	kCSMsgBingoDraw = "onBingoDrawResp",
	kCSMsgMultiPVPRank = "onMultiPVPRankResp",
	kCSMsgCrystalMsgNotify = "onCrystalMsgNotify",
	kCSMsgPVEAutoBattlePowerNotify = "onPVEAutoBattlePowerNotify",
	kCSMsgFormationsUpdateByPos = "onFormationsUpdateByPosResp",
	kCSMsgPVEAutoBattle = "onPVEAutoBattleResp",
	kCSMsgPVEStartNotify = "onPVEStartNotify",
	kCSMsgOpActEquipRecycleNotify = "onOpActEquipRecycleNotify",
	kCSMsgPetItemUpdateNotify = "onPetItemUpdateNotify",
	kCSMsgHeroPaintItemConvert = "onHeroPaintItemConvertResp",
	kCSMsgClanBattleUnmarkMember = "onClanBattleUnmarkMemberResp",
	kCSMsgHeroDevelopOpenNotify = "onHeroDevelopOpenNotify",
	kCSMsgClanFuncInvite = "onClanFuncInviteResp",
	kCSMsgEquipSwap = "onEquipSwapResp",
	kCSMsgOpActRandReplaceSet = "onOpActRandReplaceSetResp",
	kCSMsgRoleLogoutNotify = "onRoleLogoutNotify",
	kCSMsgAchieveActionProgressNotify = "onAchieveActionProgressNotify",
	kCSMsgTaskGetAward = "onTaskGetAwardResp",
	kCSMsgOpActDrawNewbieUpNewCycle = "onOpActDrawNewbieUpNewCycleResp",
	kCSMsgGeneralAttrNotify = "onGeneralAttrNotify",
	kCSMsgHeroVoidStarChangeNotify = "onHeroVoidStarChangeNotify",
	kCSMsgPetGemRerandAttribute = "onPetGemRerandAttributeResp",
	kCSMsgSkinExchange = "onSkinExchangeResp",
	kCSMsgRoleInfo = "onRoleInfoResp",
	kCSMsgClanFuncInviteNotify = "onClanFuncInviteNotify",
	kCSMsgOpActEquipMakeChoose = "onOpActEquipMakeChooseResp",
	kCSMsgAdvanceRechargeNotify = "onAdvanceRechargeNotify",
	kCSMsgEquipSchemeApply = "onEquipSchemeApplyResp",
	kCSMsgRoleLoginDataNotify = "onRoleLoginDataNotify",
	kCSMsgClanBattleUseSkill = "onClanBattleUseSkillResp",
	kCSMsgRoleLogin = "onRoleLoginResp",
	kCSMsgAsyncPVPReportStatusNotify = "onAsyncPVPReportStatusNotify",
	kCSMsgPetStarUp = "onPetStarUpResp",
	kCSMsgMonthCounterResetNotify = "onMonthCounterResetNotify",
	kCSMsgOpActivityData = "onOpActivityDataResp",
	kCSMsgWeekCounterResetNotify = "onWeekCounterResetNotify",
	kCSMsgRoleMiscAddicationNotify = "onRoleMiscAddicationNotify",
	kCSMsgWeekTICounterNotify = "onWeekTICounterNotify",
	kCSMsgStageSkip = "onStageSkipResp",
	kCSMsgEquipBuild = "onEquipBuildResp",
	kCSMsgRoleRandName = "onRoleRandNameResp",
	kCSMsgHouseFavorRank = "onHouseFavorRankResp",
	kCSMsgMasterSetDevelopGuide = "onMasterSetDevelopGuideResp",
	kCSMsgWelfarePushGiftPopupSet = "onWelfarePushGiftPopupSetResp",
	kCSMsgShopRangeBeg = "onShopRangeBegResp",
	kCSMsgHouseCommentSwitchSet = "onHouseCommentSwitchSetResp",
	kCSMsgOpActGuessAwardInfuse = "onOpActGuessAwardInfuseResp",
	kCSMsgOpActHatsuneCheerConvertNotify = "onOpActHatsuneCheerConvertNotify",
	kCSMsgOpactArenaSettleNotify = "onOpactArenaSettleNotify",
	kCSMsgGagInfoNotify = "onGagInfoNotify",
	kCSMsgBossTowerDataNotify = "onBossTowerDataNotify",
	kCSMsgOpActGuessGetRank = "onOpActGuessGetRankResp",
	kCSMsgHeroLevelUpNotify = "onHeroLevelUpNotify",
	kCSMsgDepositAwardRefresh = "onDepositAwardRefreshResp",
	kCSMsgCrystalMsgGetAward = "onCrystalMsgGetAwardResp",
	kCSMsgRentTaskRefresh = "onRentTaskRefreshResp",
	kCSMsgRechargeListGet = "onRechargeListGetResp",
	kCSMsgRechargeRoleFirstAwardNotify = "onRechargeRoleFirstAwardNotify",
	kCSMsgNewPveResetStage = "onNewPveResetStageResp",
	kCSMsgHeroDevelopUpdateRedPoint = "onHeroDevelopUpdateRedPointResp",
	kCSMsgShopRecordUpdateNotify = "onShopRecordUpdateNotify",
	kCSMsgPVEShare = "onPVEShareResp",
	kCSMsgMazeSelectRelics = "onMazeSelectRelicsResp",
	kCSMsgNewMazeLevelCycleResetNotify = "onNewMazeLevelCycleResetNotify",
	kCSMsgMazeSelectBranch = "onMazeSelectBranchResp",
	kCSMsgRentRenterCancel = "onRentRenterCancelResp",
	kCSMsgNewMazeEnchanterUse = "onNewMazeEnchanterUseResp",
	kCSMsgAsyncPVPSettleNotify = "onAsyncPVPSettleNotify",
	kCSMsgRentTaskSelect = "onRentTaskSelectResp",
	kCSMsgBookTaskGetAward = "onBookTaskGetAwardResp",
	kCSMsgClanBattleOccupyGrid = "onClanBattleOccupyGridResp",
	kCSMsgEquipTowerSweep = "onEquipTowerSweepResp",
	kCSMsgClanBattlePVEStartNotify = "onClanBattlePVEStartNotify",
	kCSMsgMultiPVPMatch = "onMultiPVPMatchResp",
	kCSMsgEnergyUpdateNotify = "onEnergyUpdateNotify",
	kCSMsgRentTaskDataNotify = "onRentTaskDataNotify",
	kCSMsgOpactArenaRoleDefendNotify = "onOpactArenaRoleDefendNotify",
	kCSMsgCurrencyExchange = "onCurrencyExchangeResp",
	kCSMsgAsyncPVPChallege = "onAsyncPVPChallegeResp",
	kCSMsgClanBattleNextLayer = "onClanBattleNextLayerResp",
	kCSMsgOpActPlotGetRank = "onOpActPlotGetRankResp",
	kCSMsgFormationDataNotify = "onFormationDataNotify",
	kCSMsgOpActDrawSeasonDraw = "onOpActDrawSeasonDrawResp",
	kCSMsgEquipUpdateNotify = "onEquipUpdateNotify",
	kCSMsgBPPvpKnockoutBet = "onBPPvpKnockoutBetResp",
	kCSMsgClanBattleGetClanAchieveAward = "onClanBattleGetClanAchieveAwardResp",
	kCSMsgOpActChatGameMakeChocolete = "onOpActChatGameMakeChocoleteResp",
	kCSMsgBuddySocialNotify = "onBuddySocialNotify",
	kCSMsgMailNotify = "onMailNotify",
	kCSMsgCollectAchieveProgressNotify = "onCollectAchieveProgressNotify",
	kCSMsgEquipEvolve = "onEquipEvolveResp",
	kCSMsgHeroUnlock = "onHeroUnlockResp",
	kCSMsgDrawDataNotify = "onDrawDataNotify",
	kCSMsgOnceTowerReplayRecord = "onOnceTowerReplayRecordResp",
	kCSMsgPetOffWears = "onPetOffWearsResp",
	kCSMsgNewPveGetFormation = "onNewPveGetFormationResp",
	kCSMsgSkinWear = "onSkinWearResp",
	kCSMsgErrorPromptNotify = "onErrorPromptNotify",
	kCSMsgHeroCrystalStoryUnlock = "onHeroCrystalStoryUnlockResp",
	kCSMsgEquipBuildLevelUp = "onEquipBuildLevelUpResp",
	kCSMsgOpActFlottorySetSelIndex = "onOpActFlottorySetSelIndexResp",
	kCSMsgClanAppoint = "onClanAppointResp",
	kCSMsgNewMazeNodeSelect = "onNewMazeNodeSelectResp",
	kCSMsgAsyncPVPDetailNotify = "onAsyncPVPDetailNotify",
	kCSMsgPetDrawSelect = "onPetDrawSelectResp",
	kCSMsgPetPossess = "onPetPossessResp",
	kCSMsgHouseDispatchDayRefreshNotify = "onHouseDispatchDayRefreshNotify",
	kCSMsgNewMazeShopItemUpdateNotify = "onNewMazeShopItemUpdateNotify",
	kCSMsgPowerUpdateNotify = "onPowerUpdateNotify",
	kCSMsgMazeSelectSweepRelics = "onMazeSelectSweepRelicsResp",
	kCSMsgMasterApprenticeDel = "onMasterApprenticeDelResp",
	kCSMsgRankTopGet = "onRankTopGetResp",
	kCSMsgNewPveResetProgress = "onNewPveResetProgressResp",
	kCSMsgOpActBusinessStaminaDonated = "onOpActBusinessStaminaDonatedResp",
	kCSMsgOpActTowerGetBuff = "onOpActTowerGetBuffResp",
	kCSMsgSkinAddNotify = "onSkinAddNotify",
	kCSMsgEquipSchemeDelete = "onEquipSchemeDeleteResp",
	kCSMsgTaskAcceptNotify = "onTaskAcceptNotify",
	kCSMsgRentOwnerCancel = "onRentOwnerCancelResp",
	kCSMsgBingoNextRound = "onBingoNextRoundResp",
	kCSMsgClanEnterNotify = "onClanEnterNotify",
	kCSMsgHeroResetNotify = "onHeroResetNotify",
	kCSMsgRechargeMulityNotify = "onRechargeMulityNotify",
	kCSMsgMasterApprenticeAdd = "onMasterApprenticeAddResp",
	kCSMsgArtifactWear = "onArtifactWearResp",
	kCSMsgMasterApprenticeInviteOp = "onMasterApprenticeInviteOpResp",
	kCSMsgRoleLoginQueueNotify = "onRoleLoginQueueNotify",
	kCSMsgNewMazeTalentWorkNotify = "onNewMazeTalentWorkNotify",
	kCSMsgMailUpdate = "onMailUpdateResp",
	kCSMsgClanFuncInviterListNotify = "onClanFuncInviterListNotify",
	kCSMsgOpActEquipBaptizeAttrLock = "onOpActEquipBaptizeAttrLockResp",
	kCSMsgBuddyDel = "onBuddyDelResp",
	kCSMsgClanBattleGetHonor = "onClanBattleGetHonorResp",
	kCSMsgRoleCommChangeHeadFrame = "onRoleCommChangeHeadFrameResp",
	kCSMsgPetMazeRoleDataNotify = "onPetMazeRoleDataNotify",
	kCSMsgMailReport = "onMailReportResp",
	kCSMsgBuddyBlackListDel = "onBuddyBlackListDelResp",
	kCSMsgPetChooseGift = "onPetChooseGiftResp",
	kCSMsgTowerSweep = "onTowerSweepResp",
	kCSMsgHeroNewPaintNotify = "onHeroNewPaintNotify",
	kCSMsgClanOpActMemberDataNotify = "onClanOpActMemberDataNotify",
	kCSMsgTowerDataNotify = "onTowerDataNotify",
	kCSMsgSkinRepeatNotify = "onSkinRepeatNotify",
	kCSMsgRechargeListNotify = "onRechargeListNotify",
	kCSMsgBuddyInviteDelNotify = "onBuddyInviteDelNotify",
	kCSMsgOpActCollectWordsGetBuddyWord = "onOpActCollectWordsGetBuddyWordResp",
	kCSMsgClanAcceptApply = "onClanAcceptApplyResp",
	kCSMsgQQBlueDataNotify = "onQQBlueDataNotify",
	kCSMsgClanLeaveNotify = "onClanLeaveNotify",
	kCSMsgMasterOpenDevelopGuide = "onMasterOpenDevelopGuideResp",
	kCSMsgAsyncPVPReportGet = "onAsyncPVPReportGetResp",
	kCSMsgGagGSInfoNotify = "onGagGSInfoNotify",
	kCSMsgRelicGetNotify = "onRelicGetNotify",
	kCSMsgNewMazeLevelExit = "onNewMazeLevelExitResp",
	kCSMsgClanBattleLoginNotify = "onClanBattleLoginNotify",
	kCSMsgOpActLotteryAddNotify = "onOpActLotteryAddNotify",
	kCSMsgClanOpActClanDataNotify = "onClanOpActClanDataNotify",
	kCSMsgTaskRefreshNotify = "onTaskRefreshNotify",
	kCSMsgAchieveQualifyNotify = "onAchieveQualifyNotify",
	kCSMsgNewPveReset = "onNewPveResetResp",
	kCSMsgMonthTICounterNotify = "onMonthTICounterNotify",
	kCSMsgBPPvpOpponentDetailNotify = "onBPPvpOpponentDetailNotify",
	kCSMsgClanJoinNotify = "onClanJoinNotify",
	kCSMsgBuddyInviteNotify = "onBuddyInviteNotify",
	kCSMsgMonumentMsgGetAward = "onMonumentMsgGetAwardResp",
	kCSMsgProficentItemNotify = "onProficentItemNotify",
	kCSMsgOnceTowerDataNotify = "onOnceTowerDataNotify",
	kCSMsgOpActGetAward = "onOpActGetAwardResp",
	kCSMsgRoleOpActSimpleGet = "onRoleOpActSimpleGetResp",
	kCSMsgWelfareCardInfoNotify = "onWelfareCardInfoNotify",
	kCSMsgRentDataNotify = "onRentDataNotify",
	kCSMsgFormationUpdate = "onFormationUpdateResp",
	kCSMsgHeroExchange = "onHeroExchangeResp",
	KCSMsgRefluxGetOnceAward = "onRefluxGetOnceAwardResp",
	kCSMsgBPPvpKnockoutEnterRoom = "onBPPvpKnockoutEnterRoomResp",
	kCSMsgAchieveGetAward = "onAchieveGetAwardResp",
	kCSMsgBattlePassRoleDataNotify = "onBattlePassRoleDataNotify",
	kCSMsgAsyncPVPReportNotify = "onAsyncPVPReportNotify",
	kCSMsgDepositAwardNotify = "onDepositAwardNotify",
	kCSMsgHouseUpdate = "onHouseUpdateResp",
	kCSMsgRelicOff = "onRelicOffResp",
	kCSMsgNewPveChooseLimits = "onNewPveChooseLimitsResp",
	kCSMsgPVEStart = "onPVEStartResp",
	kCSMsgOpactArenaSetRandFormaion = "onOpactArenaSetRandFormaionResp",
	kCSMsgMasterClientUpdateProgress = "onMasterClientUpdateProgressResp",
	kCSMsgMultiPVPTargetCache = "onMultiPVPTargetCacheResp",
	kCSMsgSubscribeDataNotify = "onSubscribeDataNotify",
	kCSMsgRentGetSendLetter = "onRentGetSendLetterResp",
	kCSMsgRoleCommChangeHeadPendant = "onRoleCommChangeHeadPendantResp",
	kCSMsgNewMazeOpen = "onNewMazeOpenResp",
	kCSMsgBPPvpKnockoutFormationGet = "onBPPvpKnockoutFormationGetResp",
	kCSMsgHouseVisitNotify = "onHouseVisitNotify",
	kCSMsgOpActMonopolyUseItem = "onOpActMonopolyUseItemResp",
	kCSMsgClanBattleExitClanNotify = "onClanBattleExitClanNotify",
	kCSMsgRoleRename = "onRoleRenameResp",
	kCSMsgHouseLevelUp = "onHouseLevelUpResp",
	kCSMsgNewMazeLevelEnter = "onNewMazeLevelEnterResp",
	kCSMsgPrivilegeItemChangeNotify = "onPrivilegeItemChangeNotify",
	kCSMsgMazeRelicsRandNotify = "onMazeRelicsRandNotify",
	kCSMsgMysteryShopUpdateNotify = "onMysteryShopUpdateNotify",
	kCSMsgOpActEquipRecycleStop = "onOpActEquipRecycleStopResp",
	kCSMsgOpactArenaReportGet = "onOpactArenaReportGetResp",
	kCSMsgBPPvpKnockoutGetHallData = "onBPPvpKnockoutGetHallDataResp",
	kCSMsgNetDelay = "onNetDelayResp",
	kCSMsgHeroStarBack = "onHeroStarBackResp",
	kCSMsgMultiPVPUpdateNotify = "onMultiPVPUpdateNotify",
	kCSMsgMasterRecieveDevelopGuideNotify = "onMasterRecieveDevelopGuideNotify",
	kCSMsgHeroPaintNotify = "onHeroPaintNotify",
	kCSMsgBagSizeExtend = "onBagSizeExtendResp",
	kCSMsgOpActCollectWordsRecvWord = "onOpActCollectWordsRecvWordResp",
	kCSMsgOperateEventCompleteNotify = "onOperateEventCompleteNotify",
	kCSMsgClanGet = "onClanGetResp",
	kCSMsgClanMailNotify = "onClanMailNotify",
	kCSMsgRoleOweItemNotify = "onRoleOweItemNotify",
	kCSMsgHeroReset = "onHeroResetResp",
	kCSMsgExecuteGM = "onExecuteGMResp",
	kCSMsgHeroStarUpNotify = "onHeroStarUpNotify",
	kCSMsgClanBattleGetScoreLog = "onClanBattleGetScoreLogResp",
	kCSMsgEquipSchemeItemNotify = "onEquipSchemeItemNotify",
	kCSMsgPetAmuletStarUp = "onPetAmuletStarUpResp",
	kCSMsgHouseComfortAwardGet = "onHouseComfortAwardGetResp",
	kCSMsgOpActDraw = "onOpActDrawResp",
	kCSMsgDressHeadFrameGetNotify = "onDressHeadFrameGetNotify",
	kCSMsgRentGetOwnerFormation = "onRentGetOwnerFormationResp",
	kCSMsgOpactArenaUpgradeLeague = "onOpactArenaUpgradeLeagueResp",
	kCSMsgMailRecallNotify = "onMailRecallNotify",
	kCSMsgPetDevelopIntelligence = "onPetDevelopIntelligenceResp",
	kCSMsgRentOwnerNotify = "onRentOwnerNotify",
	kCSMsgClanBattleChatMsgNotify = "onClanBattleChatMsgNotify",
	kCSMsgDraw = "onDrawResp",
	kCSMsgApprenticeRequestBattleGuide = "onApprenticeRequestBattleGuideResp",
	kCSMsgBattlePassActionProgressNotify = "onBattlePassActionProgressNotify",
	kCSMsgHeroStepUpNotify = "onHeroStepUpNotify",
	kCSMsgRelicWear = "onRelicWearResp",
	kCSMsgHeroRecycle = "onHeroRecycleResp",
	kCSMsgClanBattleCancelGridNotify = "onClanBattleCancelGridNotify",
	kCSMsgWeekICounterNotify = "onWeekICounterNotify",
	kCSMsgRoleCommEditFormation = "onRoleCommEditFormationResp",
	kCSMsgClanBattleSetRelic = "onClanBattleSetRelicResp",
	kCSMsgOpactArenaRoleInfoNotify = "onOpactArenaRoleInfoNotify",
	kCSMsgSubscribeGetAward = "onSubscribeGetAwardResp",
	kCSMsgClanBattleOpenGridNotify = "onClanBattleOpenGridNotify",
	kCSMsgClanBattleOccupyMonsterNotify = "onClanBattleOccupyMonsterNotify",
	kCSMsgMasterApprenticeInviteAddNotify = "onMasterApprenticeInviteAddNotify",
	kCSMsgClanBattleBoxMarkAwardNotify = "onClanBattleBoxMarkAwardNotify",
	kCSMsgClanKick = "onClanKickResp",
	kCSMsgForeverTICounterNotify = "onForeverTICounterNotify",
	kCSMsgClanBattleExit = "onClanBattleExitResp",
	kCSMsgOpactArenaRankGet = "onOpactArenaRankGetResp",
	kCSMsgOpActBusinessOrderUpdate = "onOpActBusinessOrderUpdateResp",
	kCSMsgHouseFavorHistory = "onHouseFavorHistoryResp",
	kCSMsgOpActBusinessMaterialProduct = "onOpActBusinessMaterialProductResp",
	kCSMsgClanJoin = "onClanJoinResp",
	kCSMsgEquipTeamWear = "onEquipTeamWearResp",
	kCSMsgRedPacketGetAward = "onRedPacketGetAwardResp",
	kCSMsgNewMazeRandPoolCheck = "onNewMazeRandPoolCheckResp",
	kCSMsgOpactArenaRoleGetNearRank = "onOpactArenaRoleGetNearRankResp",
	kCSMsgClanBattleGetLog = "onClanBattleGetLogResp",
	kCSMsgPVEQuit = "onPVEQuitResp",
	kCSMsgMazeSysDataNotify = "onMazeSysDataNotify",
	kCSMsgBroadcastSvrPkgNotify = "onBroadcastSvrPkgNotify",
	kCSMsgCollectAchieveGetAward = "onCollectAchieveGetAwardResp",
	kCSMsgOpActFlottoryDraw = "onOpActFlottoryDrawResp",
	kCSMsgFormationSnapshot = "onFormationSnapshotResp",
	kCSMsgRankIndexGet = "onRankIndexGetResp",
	kCSMsgClanFuncShare = "onClanFuncShareResp",
	kCSMsgHeroOffWears = "onHeroOffWearsResp",
	kCSMsgClanBattleGiveOrder = "onClanBattleGiveOrderResp",
	kCSMsgRentTeamNumNotify = "onRentTeamNumNotify",
	kCSMsgStageDataNotify = "onStageDataNotify",
	kCSMsgHouseVisit = "onHouseVisitResp",
	kCSMsgPetDegreeRuneActive = "onPetDegreeRuneActiveResp",
	kCSMsgOpActSetFocus = "onOpActSetFocusResp",
	kCSMsgBuddyOp = "onBuddyOpResp",
	kCSMsgHeroStickLevelNotify = "onHeroStickLevelNotify",
	kCSMsgClanExit = "onClanExitResp",
	kCSMsgMasterApprenticeGraduation = "onMasterApprenticeGraduationResp",
	kCSMsgRechargeRebateNotify = "onRechargeRebateNotify",
	kCSMsgBuddyRecommend = "onBuddyRecommendResp",
	kCSMsgNewMazeLayerNextNotify = "onNewMazeLayerNextNotify",
	kCSMsgHouseShare = "onHouseShareResp",
	kCSMsgGiftDrawWinnersListGet = "onGiftDrawWinnersListGetResp",
	kCSMsgClanBattleCancelMonster = "onClanBattleCancelMonsterResp",
	kCSMsgMasterSetBattleGuide = "onMasterSetBattleGuideResp",
	kCSMsgOpActAchieveExchangeItem = "onOpActAchieveExchangeItemResp",
	kCSMsgEquipGetNotify = "onEquipGetNotify",
	kCSMsgBuddyGiftOp = "onBuddyGiftOpResp",
	kCSMsgStageRecord = "onStageRecordResp",
	kCSMsgClanBattleOccupyGridNotify = "onClanBattleOccupyGridNotify",
	kCSMsgNewMazeMultiAwardListNotify = "onNewMazeMultiAwardListNotify",
	kCSMsgHouseFavor = "onHouseFavorResp",
	kCSMsgDesireRecommendNotify = "onDesireRecommendNotify",
	kCSMsgOpActTowerRoleAchieveNotify = "onOpActTowerRoleAchieveNotify",
	kCSMsgBuddyAdd = "onBuddyAddResp",
	kCSMsgNewMazeRandomEventOptionSelect = "onNewMazeRandomEventOptionSelectResp",
	kCSMsgProficentOtherItemNotify = "onProficentOtherItemNotify",
	kCSMsgHouseVisitRandom = "onHouseVisitRandomResp",
	kCSMsgPetRuneActive = "onPetRuneActiveResp",
	kCSMsgOpActTurnTableDraw = "onOpActTurnTableDrawResp",
	kCSMsgRoleCommChangeGender = "onRoleCommChangeGenderResp",
	kCSMsgRechargeCancelOrder = "onRechargeCancelOrderResp",
	kCSMsgVIPSetHide = "onVIPSetHideResp",
	KCSMsgRefluxNewSetFlag = "onRefluxNewSetFlagResp",
	kCSMsgArtifactUpdateNotify = "onArtifactUpdateNotify",
	kCSMsgBuddyInfoNotify = "onBuddyInfoNotify",
	kCSMsgOpActEquipBaptizeDone = "onOpActEquipBaptizeDoneResp",
	kCSMsgNewDayNotify = "onNewDayNotify",
	kCSMsgOpActivityMgrDataNotify = "onOpActivityMgrDataNotify"
}
RPC._msgRespDict2ListMap = {
	KCSMsgDynamicExpressionUse = "_dict2ListForDynamicExpressionUse",
	kCSMsgCampTowerUpdateStage = "_dict2ListForCampTowerUpdateStage",
	kCSMsgClanFuncRefuseInviteNotify = "_dict2ListForClanFuncRefuseInviteNotify",
	kCSMsgOpActChatGameChooseBranch = "_dict2ListForOpActChatGameChooseBranch",
	kCSMsgMasterApprenticeAddNotify = "_dict2ListForMasterApprenticeAddNotify",
	kCSMsgBPPvpKnockoutFormation = "_dict2ListForBPPvpKnockoutFormation",
	kCSMsgClanBattleGetMemberAchieveAwardNotify = "_dict2ListForClanBattleGetMemberAchieveAwardNotify",
	kCSMsgClanBattleSettleNotify = "_dict2ListForClanBattleSettleNotify",
	kCSMsgClanRefuseApply = "_dict2ListForClanRefuseApply",
	kCSMsgClanBattlePVEFinishNotify = "_dict2ListForClanBattlePVEFinishNotify",
	kCSMsgClanBattleMarkMember = "_dict2ListForClanBattleMarkMember",
	kCSMsgClanBattleEnterNotify = "_dict2ListForClanBattleEnterNotify",
	kCSMsgHouseDispatchLock = "_dict2ListForHouseDispatchLock",
	kCSMsgClanBattleExitNotify = "_dict2ListForClanBattleExitNotify",
	kCSMsgOpActEquipRecycleGetAward = "_dict2ListForOpActEquipRecycleGetAward",
	kCSMsgClanBattleLogoutNotify = "_dict2ListForClanBattleLogoutNotify",
	kCSMsgClanBattleBuySkill = "_dict2ListForClanBattleBuySkill",
	kCSMsgClanBattleOpenGrid = "_dict2ListForClanBattleOpenGrid",
	kCSMsgCampTowerReplayRecord = "_dict2ListForCampTowerReplayRecord",
	kCSMsgClanBattleOccupyMonster = "_dict2ListForClanBattleOccupyMonster",
	kCSMsgBattlePassBpAwardNotify = "_dict2ListForBattlePassBpAwardNotify",
	kCSMsgListAttrNotify = "_dict2ListForListAttrNotify",
	kCSMsgQQBlueInfoNotify = "_dict2ListForQQBlueInfoNotify",
	kCSMsgOpactArenaOpponentDetailNotify = "_dict2ListForOpactArenaOpponentDetailNotify",
	kCSMsgProficentGetScore = "_dict2ListForProficentGetScore",
	kCSMsgProficentLevelUp = "_dict2ListForProficentLevelUp",
	kCSMsgCrystalMsgLevelNotify = "_dict2ListForCrystalMsgLevelNotify",
	kCSMsgClanDutyNotify = "_dict2ListForClanDutyNotify",
	kCSMsgRentTaskRefreshNotify = "_dict2ListForRentTaskRefreshNotify",
	kCSMsgRechargeGenerateOrderID = "_dict2ListForRechargeGenerateOrderID",
	kCSMsgBPPvpGameDataNotify = "_dict2ListForBPPvpGameDataNotify",
	kCSMsgRentMatch = "_dict2ListForRentMatch",
	kCSMsgOpActTowerReplayRecord = "_dict2ListForOpActTowerReplayRecord",
	kCSMsgEquipWear = "_dict2ListForEquipWear",
	kCSMsgArtifactOff = "_dict2ListForArtifactOff",
	kCSMsgRoleShopRefreshItemNotify = "_dict2ListForRoleShopRefreshItemNotify",
	kCSMsgHouseDispatchDone = "_dict2ListForHouseDispatchDone",
	kCSMsgResidentOpActivityRoleDataNotify = "_dict2ListForResidentOpActivityRoleDataNotify",
	kCSMsgMazeUpdateNotify = "_dict2ListForMazeUpdateNotify",
	kCSMsgRoleCountNotify = "_dict2ListForRoleCountNotify",
	kCSMsgOpActEquipRecycleChoose = "_dict2ListForOpActEquipRecycleChoose",
	kCSMsgMazeRelicsNotify = "_dict2ListForMazeRelicsNotify",
	kCSMsgOpactArenaEnroll = "_dict2ListForOpactArenaEnroll",
	kCSMsgClanRename = "_dict2ListForClanRename",
	kCSMsgAsyncPVPMatch = "_dict2ListForAsyncPVPMatch",
	kCSMsgOpActDrawNewbieUpDraw = "_dict2ListForOpActDrawNewbieUpDraw",
	kCSMsgFormationSelect = "_dict2ListForFormationSelect",
	kCSMsgBuddySearch = "_dict2ListForBuddySearch",
	kCSMsgBossTowerAwardGet = "_dict2ListForBossTowerAwardGet",
	kCSMsgRoleMiscIDCard = "_dict2ListForRoleMiscIDCard",
	kCSMsgWelfareFundNotify = "_dict2ListForWelfareFundNotify",
	kCSMsgClanReHeadFrame = "_dict2ListForClanReHeadFrame",
	kCSMsgClanCheckinTickNotify = "_dict2ListForClanCheckinTickNotify",
	kCSMsgClanLevelNotify = "_dict2ListForClanLevelNotify",
	kCSMsgHouseUnlockAwardGet = "_dict2ListForHouseUnlockAwardGet",
	kCSMsgRoleWorldBossNotify = "_dict2ListForRoleWorldBossNotify",
	kCSMsgEquipLock = "_dict2ListForEquipLock",
	kCSMsgClanRehead = "_dict2ListForClanRehead",
	kCSMsgOpActivityStateNotify = "_dict2ListForOpActivityStateNotify",
	kCSMsgOpActBusinessOrderCommit = "_dict2ListForOpActBusinessOrderCommit",
	kCSMsgWelfarePushGiftTriggerNotify = "_dict2ListForWelfarePushGiftTriggerNotify",
	kCSMsgClanBattleCancelGrid = "_dict2ListForClanBattleCancelGrid",
	kCSMsgBPPvpKnockoutSetBPPool = "_dict2ListForBPPvpKnockoutSetBPPool",
	kCSMsgOpActBusinessMaterialUpgrade = "_dict2ListForOpActBusinessMaterialUpgrade",
	kCSMsgBuddyAddNotify = "_dict2ListForBuddyAddNotify",
	kCSMsgClanCreate = "_dict2ListForClanCreate",
	kCSMsgOpActTowerSweep = "_dict2ListForOpActTowerSweep",
	kCSMsgSignetNotify = "_dict2ListForSignetNotify",
	kCSMsgPetRuneUp = "_dict2ListForPetRuneUp",
	kCSMsgClanBattleSetModel = "_dict2ListForClanBattleSetModel",
	kCSMsgRentTMiscNotify = "_dict2ListForRentTMiscNotify",
	kCSMsgRentGetRentedFormation = "_dict2ListForRentGetRentedFormation",
	kCSMsgDayICounterNotify = "_dict2ListForDayICounterNotify",
	kCSMsgRentSendLetterNotify = "_dict2ListForRentSendLetterNotify",
	kCSMsgMonumentMsgCompleteNotify = "_dict2ListForMonumentMsgCompleteNotify",
	kCSMsgOpActEquipRecycleStart = "_dict2ListForOpActEquipRecycleStart",
	kCSMsgMazeHeroRecordUpdateNotify = "_dict2ListForMazeHeroRecordUpdateNotify",
	kCSMsgCDKey = "_dict2ListForCDKey",
	kCSMsgRoleCommChangeBubble = "_dict2ListForRoleCommChangeBubble",
	kCSMsgPetMazeSweep = "_dict2ListForPetMazeSweep",
	kCSMsgResidentOpActivitySysDataNotify = "_dict2ListForResidentOpActivitySysDataNotify",
	kCSMsgOpactArenaDetailGet = "_dict2ListForOpactArenaDetailGet",
	kCSMsgClanBattleCancelMonsterNotify = "_dict2ListForClanBattleCancelMonsterNotify",
	kCSMsgAdvanceGetTaskAward = "_dict2ListForAdvanceGetTaskAward",
	kCSMsgClanCheckin = "_dict2ListForClanCheckin",
	kCSMsgBattlePassRoleTaskNotify = "_dict2ListForBattlePassRoleTaskNotify",
	kCSMsgRentOwnerRefuse = "_dict2ListForRentOwnerRefuse",
	kCSMsgRoleCommChangeHead = "_dict2ListForRoleCommChangeHead",
	kCSMsgRankCacheGetRealRanking = "_dict2ListForRankCacheGetRealRanking",
	kCSMsgClanBattleGetClanAchieveAwardNotify = "_dict2ListForClanBattleGetClanAchieveAwardNotify",
	kCSMsgNewMazeItemChangeNotify = "_dict2ListForNewMazeItemChangeNotify",
	kCSMsgOpActCollectWordsGetDeposit = "_dict2ListForOpActCollectWordsGetDeposit",
	kCSMsgRentRenterNotify = "_dict2ListForRentRenterNotify",
	kCSMsgWelfareGetAward = "_dict2ListForWelfareGetAward",
	kCSMsgOpActChatGameResetChat = "_dict2ListForOpActChatGameResetChat",
	kCSMsgRoleCommEditVowHero = "_dict2ListForRoleCommEditVowHero",
	kCSMsgDayCounterResetNotify = "_dict2ListForDayCounterResetNotify",
	kCSMsgOpActChatGameChatEnd = "_dict2ListForOpActChatGameChatEnd",
	kCSMsgRankGet = "_dict2ListForRankGet",
	kCSMsgBookTaskProgressNotify = "_dict2ListForBookTaskProgressNotify",
	kCSMsgBattlePassDataNotify = "_dict2ListForBattlePassDataNotify",
	kCSMsgOpActMonopolySetLibAward = "_dict2ListForOpActMonopolySetLibAward",
	kCSMsgNewMazeHaloUnEquip = "_dict2ListForNewMazeHaloUnEquip",
	kCSMsgResidentOpActivityMgrDataNotify = "_dict2ListForResidentOpActivityMgrDataNotify",
	kCSMsgOpActEquipBaptizeInit = "_dict2ListForOpActEquipBaptizeInit",
	kCSMsgShopRandDataNotify = "_dict2ListForShopRandDataNotify",
	kCSMsgAsyncPVPFormation = "_dict2ListForAsyncPVPFormation",
	kCSMsgTaskUpdateNotify = "_dict2ListForTaskUpdateNotify",
	kCSMsgNoticeMsgNotify = "_dict2ListForNoticeMsgNotify",
	kCSMsgPetDevelopGift = "_dict2ListForPetDevelopGift",
	kCSMsgZChatRegister = "_dict2ListForZChatRegister",
	kCSMsgFormationSnapshotSwapIdx = "_dict2ListForFormationSnapshotSwapIdx",
	kCSMsgMultiPVPAwardGet = "_dict2ListForMultiPVPAwardGet",
	kCSMsgRoleMiscConsignee = "_dict2ListForRoleMiscConsignee",
	kCSMsgMazeSelect = "_dict2ListForMazeSelect",
	kCSMsgDressChatBubbleGetNotify = "_dict2ListForDressChatBubbleGetNotify",
	kCSMsgAdvanceGetStepAward = "_dict2ListForAdvanceGetStepAward",
	kCSMsgShopEnter = "_dict2ListForShopEnter",
	kCSMsgRechargeFirstNotify = "_dict2ListForRechargeFirstNotify",
	kCSMsgDayTICounterNotify = "_dict2ListForDayTICounterNotify",
	kCSMsgTimeCounterNotify = "_dict2ListForTimeCounterNotify",
	kCSMsgGiftDrawGiftShare = "_dict2ListForGiftDrawGiftShare",
	kCSMsgBingoSetBigReward = "_dict2ListForBingoSetBigReward",
	kCSMsgArtifactLock = "_dict2ListForArtifactLock",
	kCSMsgDressHeadFrameSetNotify = "_dict2ListForDressHeadFrameSetNotify",
	kCSMsgOpActEquipRecycleUnlockWorkShop = "_dict2ListForOpActEquipRecycleUnlockWorkShop",
	kCSMsgPetPossessReplace = "_dict2ListForPetPossessReplace",
	kCSMsgVIPLevelNotify = "_dict2ListForVIPLevelNotify",
	kCSMsgBuddyBlackListNotify = "_dict2ListForBuddyBlackListNotify",
	kCSMsgErrorBagFullNotify = "_dict2ListForErrorBagFullNotify",
	kCSMsgClanSetAutoAccept = "_dict2ListForClanSetAutoAccept",
	kCSMsgPetDrawRest = "_dict2ListForPetDrawRest",
	kCSMsgHotfixVersionNotify = "_dict2ListForHotfixVersionNotify",
	kCSMsgFormationSnapshotGet = "_dict2ListForFormationSnapshotGet",
	kCSMsgDrawDayCampNotify = "_dict2ListForDrawDayCampNotify",
	kCSMsgRentWaitLetterNotify = "_dict2ListForRentWaitLetterNotify",
	kCSMsgHouseDispatchRefresh = "_dict2ListForHouseDispatchRefresh",
	kCSMsgClanTransfer = "_dict2ListForClanTransfer",
	KCSMsgRefluxNewGroupNotify = "_dict2ListForRefluxNewGroupNotify",
	kCSMsgClanRecommend = "_dict2ListForClanRecommend",
	kCSMsgMasterGetApprenticeAllHero = "_dict2ListForMasterGetApprenticeAllHero",
	kCSMsgSeasonRelicOp = "_dict2ListForSeasonRelicOp",
	kCSMsgSkinUnlock = "_dict2ListForSkinUnlock",
	kCSMsgDepositAwardGet = "_dict2ListForDepositAwardGet",
	kCSMsgOpActDrawNewbieCampDraw = "_dict2ListForOpActDrawNewbieCampDraw",
	kCSMsgDrawNewbie = "_dict2ListForDrawNewbie",
	kCSMsgOpActBusinessStaminaReceive = "_dict2ListForOpActBusinessStaminaReceive",
	kCSMsgAsyncPVPUpdateNotify = "_dict2ListForAsyncPVPUpdateNotify",
	kCSMsgOpActivitySysDataNotify = "_dict2ListForOpActivitySysDataNotify",
	kCSMsgOpActSeasonBPPointGet = "_dict2ListForOpActSeasonBPPointGet",
	kCSMsgClanBattleSetModelNotify = "_dict2ListForClanBattleSetModelNotify",
	kCSMsgEquipTowerChooseHero = "_dict2ListForEquipTowerChooseHero",
	kCSMsgRechargeDeliverNotify = "_dict2ListForRechargeDeliverNotify",
	kCSMsgAsyncPVPSysDataNotify = "_dict2ListForAsyncPVPSysDataNotify",
	kCSMsgRankCacheGetPage = "_dict2ListForRankCacheGetPage",
	kCSMsgClanKickNotify = "_dict2ListForClanKickNotify",
	kCSMsgOpActTowerUpdateBuffNotify = "_dict2ListForOpActTowerUpdateBuffNotify",
	kCSMsgNewPveGetCurFormation = "_dict2ListForNewPveGetCurFormation",
	kCSMsgSystemSwitchNotify = "_dict2ListForSystemSwitchNotify",
	kCSMsgDrawNewbieReset = "_dict2ListForDrawNewbieReset",
	kCSMsgPVEBattleReplay = "_dict2ListForPVEBattleReplay",
	kCSMsgAsyncPVPSweep = "_dict2ListForAsyncPVPSweep",
	kCSMsgClanBattleEnter = "_dict2ListForClanBattleEnter",
	kCSMsgStageUnlockNext = "_dict2ListForStageUnlockNext",
	kCSMsgOpactArenaRoleDanAwardNotify = "_dict2ListForOpactArenaRoleDanAwardNotify",
	kCSMsgOpActEquipBaptizeRandAttr = "_dict2ListForOpActEquipBaptizeRandAttr",
	kCSMsgProficentGetOtherScore = "_dict2ListForProficentGetOtherScore",
	kCSMsgOpActGuessIsRight = "_dict2ListForOpActGuessIsRight",
	kCSMsgTowerStarAwardGet = "_dict2ListForTowerStarAwardGet",
	kCSMsgBuddyInviteAddNotify = "_dict2ListForBuddyInviteAddNotify",
	kCSMsgRentLetterNotify = "_dict2ListForRentLetterNotify",
	kCSMsgEquipTowerReplayRecord = "_dict2ListForEquipTowerReplayRecord",
	kCSMsgArtifactGetNotify = "_dict2ListForArtifactGetNotify",
	kCSMsgClanBattlePVEQuitNotify = "_dict2ListForClanBattlePVEQuitNotify",
	kCSMsgPetMazeSaveFormation = "_dict2ListForPetMazeSaveFormation",
	kCSMsgMazeSweep = "_dict2ListForMazeSweep",
	kCSMsgHouseSweep = "_dict2ListForHouseSweep",
	kCSMsgHeroPaintRelateUnlockNotify = "_dict2ListForHeroPaintRelateUnlockNotify",
	kCSMsgPetExchange = "_dict2ListForPetExchange",
	kCSMsgOpactArenaRankTopGet = "_dict2ListForOpactArenaRankTopGet",
	kCSMsgApprenticeAddGuideCnt = "_dict2ListForApprenticeAddGuideCnt",
	kCSMsgBuddyUpdateNotify = "_dict2ListForBuddyUpdateNotify",
	kCSMsgMonopolyExchange = "_dict2ListForMonopolyExchange",
	kCSMsgBuddyBondSet = "_dict2ListForBuddyBondSet",
	kCSMsgEquipDelNotify = "_dict2ListForEquipDelNotify",
	kCSMsgOpActBusinessMaterialDelete = "_dict2ListForOpActBusinessMaterialDelete",
	kCSMsgOpActBusinessPermissionAddNotify = "_dict2ListForOpActBusinessPermissionAddNotify",
	kCSMsgRechargeCanBuyCountNotify = "_dict2ListForRechargeCanBuyCountNotify",
	kCSMsgNewbieReport = "_dict2ListForNewbieReport",
	kCSMsgHeroStarUpBatch = "_dict2ListForHeroStarUpBatch",
	kCSMsgNewMazeShopSell = "_dict2ListForNewMazeShopSell",
	kCSMsgOpActGuessChooseAnswer = "_dict2ListForOpActGuessChooseAnswer",
	kCSMsgNewMazeShopLevelUpNotify = "_dict2ListForNewMazeShopLevelUpNotify",
	kCSMsgMonumentMsgNotify = "_dict2ListForMonumentMsgNotify",
	kCSMsgRentGetLetter = "_dict2ListForRentGetLetter",
	kCSMsgNewPveChooseLevel = "_dict2ListForNewPveChooseLevel",
	kCSMsgNewMazeSetOutsideRelic = "_dict2ListForNewMazeSetOutsideRelic",
	kCSMsgNewMazeModifyInherit = "_dict2ListForNewMazeModifyInherit",
	kCSMsgMailGetAttach = "_dict2ListForMailGetAttach",
	kCSMsgNewMazeSelectInherit = "_dict2ListForNewMazeSelectInherit",
	kCSMsgBuddyOnline = "_dict2ListForBuddyOnline",
	kCSMsgNewMazeTalentSet = "_dict2ListForNewMazeTalentSet",
	kCSMsgClanRenotice = "_dict2ListForClanRenotice",
	kCSMsgClanSendMail = "_dict2ListForClanSendMail",
	kCSMsgPetChooseIntelligence = "_dict2ListForPetChooseIntelligence",
	kCSMsgArtifactDelNotify = "_dict2ListForArtifactDelNotify",
	kCSMsgCampTowerDataNotify = "_dict2ListForCampTowerDataNotify",
	kCSMsgDressHeadGetNotify = "_dict2ListForDressHeadGetNotify",
	kCSMsgClanBattleUseSkillNotify = "_dict2ListForClanBattleUseSkillNotify",
	kCSMsgClanBattleRankNotify = "_dict2ListForClanBattleRankNotify",
	kCSMsgHouseDispatchAddNotify = "_dict2ListForHouseDispatchAddNotify",
	kCSMsgPetItemDelNotify = "_dict2ListForPetItemDelNotify",
	kCSMsgPetDegreeLevelUp = "_dict2ListForPetDegreeLevelUp",
	kCSMsgPetRecycle = "_dict2ListForPetRecycle",
	kCSMsgClanBattleNextLayerNotify = "_dict2ListForClanBattleNextLayerNotify",
	kCSMsgOpActOnHookRoleDeliver = "_dict2ListForOpActOnHookRoleDeliver",
	kCSMsgEquipSchemeUpdate = "_dict2ListForEquipSchemeUpdate",
	kCSMsgDressHeadPendantGetNotify = "_dict2ListForDressHeadPendantGetNotify",
	kCSMsgPetGemInset = "_dict2ListForPetGemInset",
	kCSMsgPetAmuletSet = "_dict2ListForPetAmuletSet",
	kCSMsgHouseDispatchStart = "_dict2ListForHouseDispatchStart",
	kCSMsgNewPveRoleDataNotify = "_dict2ListForNewPveRoleDataNotify",
	kCSMsgOpactArenaRoleOpen = "_dict2ListForOpactArenaRoleOpen",
	kCSMsgProficentBookGemUse = "_dict2ListForProficentBookGemUse",
	kCSMsgOpactArenaMatch = "_dict2ListForOpactArenaMatch",
	kCSMsgPetGemSaveAttribute = "_dict2ListForPetGemSaveAttribute",
	kCSMsgMasterApprenticeGetTaskAward = "_dict2ListForMasterApprenticeGetTaskAward",
	kCSMsgOpActEquipMakeRand = "_dict2ListForOpActEquipMakeRand",
	kCSMsgMysteryShopExit = "_dict2ListForMysteryShopExit",
	kCSMsgBPPvpGroupEnterRoom = "_dict2ListForBPPvpGroupEnterRoom",
	kCSMsgOpActClanBossGetStageAward = "_dict2ListForOpActClanBossGetStageAward",
	kCSMsgBPPvpGroupDetailGet = "_dict2ListForBPPvpGroupDetailGet",
	kCSMsgBPPvpGroupReportGet = "_dict2ListForBPPvpGroupReportGet",
	kCSMsgRoleCreate = "_dict2ListForRoleCreate",
	kCSMsgBattlePassRoleSuperNotify = "_dict2ListForBattlePassRoleSuperNotify",
	kCSMsgOpActivityRoleDataNotify = "_dict2ListForOpActivityRoleDataNotify",
	kCSMsgRentUpdateFormation = "_dict2ListForRentUpdateFormation",
	kCSMsgOpActEquipBaptizeChoose = "_dict2ListForOpActEquipBaptizeChoose",
	kCSMsgRentRenterRent = "_dict2ListForRentRenterRent",
	kCSMsgBPPvpKnockoutBP = "_dict2ListForBPPvpKnockoutBP",
	kCSMsgClanBattleGiveOrderNotify = "_dict2ListForClanBattleGiveOrderNotify",
	kCSMsgArtifactLevelUp = "_dict2ListForArtifactLevelUp",
	kCSMsgBPPvpKnockoutRoomInfoGet = "_dict2ListForBPPvpKnockoutRoomInfoGet",
	kCSMsgVIPGetAward = "_dict2ListForVIPGetAward",
	kCSMsgCrystalMsgSlotNotify = "_dict2ListForCrystalMsgSlotNotify",
	kCSMsgBPPvpKnockoutReportGet = "_dict2ListForBPPvpKnockoutReportGet",
	kCSMsgRentSendLetter = "_dict2ListForRentSendLetter",
	kCSMsgBPPvpKnockoutBetInfoGet = "_dict2ListForBPPvpKnockoutBetInfoGet",
	kCSMsgBPPvpKnockoutBetHistoryGet = "_dict2ListForBPPvpKnockoutBetHistoryGet",
	kCSMsgBPPvpKnockouotBanRuleSet = "_dict2ListForBPPvpKnockouotBanRuleSet",
	kCSMsgOpActGuessSettleNotify = "_dict2ListForOpActGuessSettleNotify",
	kCSMsgAsyncPVPScore = "_dict2ListForAsyncPVPScore",
	kCSMsgOpActBusinessMaterialCompose = "_dict2ListForOpActBusinessMaterialCompose",
	kCSMsgTowerPlayClearNotify = "_dict2ListForTowerPlayClearNotify",
	kCSMsgPetMazeSaveSupportFormation = "_dict2ListForPetMazeSaveSupportFormation",
	kCSMsgPetItemGetNotify = "_dict2ListForPetItemGetNotify",
	kCSMsgPetMazeReset = "_dict2ListForPetMazeReset",
	kCSMsgMultiPVPReportGet = "_dict2ListForMultiPVPReportGet",
	kCSMsgPetMazeGetStepAward = "_dict2ListForPetMazeGetStepAward",
	kCSMsgRoleCommEditSignet = "_dict2ListForRoleCommEditSignet",
	kCSMsgNewMazeFeatureUse = "_dict2ListForNewMazeFeatureUse",
	kCSMsgNewPveSaveFormation = "_dict2ListForNewPveSaveFormation",
	kCSMsgNewPveGetAward = "_dict2ListForNewPveGetAward",
	kCSMsgRentOwnerAccept = "_dict2ListForRentOwnerAccept",
	kCSMsgMonopolyRoll = "_dict2ListForMonopolyRoll",
	kCSMsgEquipSchemeRename = "_dict2ListForEquipSchemeRename",
	kCSMsgFamiliarLevelChange = "_dict2ListForFamiliarLevelChange",
	kCSMsgNewPveWearRelic = "_dict2ListForNewPveWearRelic",
	kCSMsgBuddyInviteOp = "_dict2ListForBuddyInviteOp",
	KCSMsgRefluxDataFreshNotify = "_dict2ListForRefluxDataFreshNotify",
	kCSMsgNewPvePopUp = "_dict2ListForNewPvePopUp",
	kCSMsgDepositAwardStart = "_dict2ListForDepositAwardStart",
	kCSMsgRelaxingGamePass = "_dict2ListForRelaxingGamePass",
	kCSMsgClanBattleOpGridMark = "_dict2ListForClanBattleOpGridMark",
	kCSMsgRoleCommGet = "_dict2ListForRoleCommGet",
	kCSMsgBuddyBlackListAdd = "_dict2ListForBuddyBlackListAdd",
	kCSMsgPetRuneHeroBind = "_dict2ListForPetRuneHeroBind",
	kCSMsgRelaxingGameGetBigAward = "_dict2ListForRelaxingGameGetBigAward",
	kCSMsgPVEFinish = "_dict2ListForPVEFinish",
	kCSMsgRelaxingGameChooseFirstGame = "_dict2ListForRelaxingGameChooseFirstGame",
	kCSMsgFormationRecommendRankGet = "_dict2ListForFormationRecommendRankGet",
	kCSMsgClanBattleMarkedGridListNotify = "_dict2ListForClanBattleMarkedGridListNotify",
	kCSMsgEquipLevelUp = "_dict2ListForEquipLevelUp",
	kCSMsgHouseDispatchAllDone = "_dict2ListForHouseDispatchAllDone",
	kCSMsgMasterApprenticeDelNotify = "_dict2ListForMasterApprenticeDelNotify",
	kCSMsgBPPvpKnockoutBPPoolGet = "_dict2ListForBPPvpKnockoutBPPoolGet",
	kCSMsgMasterApprenticeNotify = "_dict2ListForMasterApprenticeNotify",
	kCSMsgMasterApprenticeRecommend = "_dict2ListForMasterApprenticeRecommend",
	kCSMsgBossTowerReplayRecord = "_dict2ListForBossTowerReplayRecord",
	kCSMsgMasterApprenticeInviteDelNotify = "_dict2ListForMasterApprenticeInviteDelNotify",
	kCSMsgMasterApprenticeInviteNotify = "_dict2ListForMasterApprenticeInviteNotify",
	kCSMsgMasterApprenticeEnroll = "_dict2ListForMasterApprenticeEnroll",
	kCSMsgMasterApprenticeQualificationUpdate = "_dict2ListForMasterApprenticeQualificationUpdate",
	kCSMsgHeroLevelReset = "_dict2ListForHeroLevelReset",
	kCSMsgMysteryShopEnter = "_dict2ListForMysteryShopEnter",
	kCSMsgGagGSSetGag = "_dict2ListForGagGSSetGag",
	kCSMsgMasterGetLevelAward = "_dict2ListForMasterGetLevelAward",
	kCSMsgOperateEventNotify = "_dict2ListForOperateEventNotify",
	kCSMsgRelicLevelUp = "_dict2ListForRelicLevelUp",
	kCSMsgMasterApprenticeTaskRefreshNotify = "_dict2ListForMasterApprenticeTaskRefreshNotify",
	kCSMsgMasterExperienceNotify = "_dict2ListForMasterExperienceNotify",
	kCSMsgMasterRecieveBattleGuideNotify = "_dict2ListForMasterRecieveBattleGuideNotify",
	kCSMsgEquipTowerDataNotify = "_dict2ListForEquipTowerDataNotify",
	kCSMsgApprenticeRecieveDevelopGuideNotify = "_dict2ListForApprenticeRecieveDevelopGuideNotify",
	kCSMsgApprenticeRecieveBattleGuideNotify = "_dict2ListForApprenticeRecieveBattleGuideNotify",
	kCSMsgOpActGuessGetTotalAward = "_dict2ListForOpActGuessGetTotalAward",
	kCSMsgDrawSetDesire = "_dict2ListForDrawSetDesire",
	kCSMsgHouseVisitHistoryGet = "_dict2ListForHouseVisitHistoryGet",
	kCSMsgAsyncPVPBriefNotify = "_dict2ListForAsyncPVPBriefNotify",
	kCSMsgMasterRecieveProgressNotify = "_dict2ListForMasterRecieveProgressNotify",
	kCSMsgItemUpdateNotify = "_dict2ListForItemUpdateNotify",
	kCSMsgHeroGetNotify = "_dict2ListForHeroGetNotify",
	kCSMsgHeroDelNotify = "_dict2ListForHeroDelNotify",
	kCSMsgClanBattleScoreInfuse = "_dict2ListForClanBattleScoreInfuse",
	kCSMsgHeroRecharge = "_dict2ListForHeroRecharge",
	kCSMsgMasterApprenticeTaskUpdateNotify = "_dict2ListForMasterApprenticeTaskUpdateNotify",
	kCSMsgRoleCommEditSignature = "_dict2ListForRoleCommEditSignature",
	kCSMsgRechargeRebateAward = "_dict2ListForRechargeRebateAward",
	kCSMsgHeroStepReset = "_dict2ListForHeroStepReset",
	kCSMsgHeroLock = "_dict2ListForHeroLock",
	kCSMsgNewMazeShopPurchase = "_dict2ListForNewMazeShopPurchase",
	kCSMsgBPPvpActivityStateGet = "_dict2ListForBPPvpActivityStateGet",
	kCSMsgHeroPaintAbilityNotify = "_dict2ListForHeroPaintAbilityNotify",
	kCSMsgClanFuncRefuseInvite = "_dict2ListForClanFuncRefuseInvite",
	kCSMsgFormationsUpdateByType = "_dict2ListForFormationsUpdateByType",
	kCSMsgEquipTowerSuperSweepDataNotify = "_dict2ListForEquipTowerSuperSweepDataNotify",
	kCSMsgMultiPVPReportGetNotify = "_dict2ListForMultiPVPReportGetNotify",
	kCSMsgOpActTowerGetScoreAward = "_dict2ListForOpActTowerGetScoreAward",
	kCSMsgRentSetAutoAccept = "_dict2ListForRentSetAutoAccept",
	KCSMsgDynamicExpressionGetNotify = "_dict2ListForDynamicExpressionGetNotify",
	kCSMsgAsyncPVPTargetCache = "_dict2ListForAsyncPVPTargetCache",
	kCSMsgClanBattleBuySkillNotify = "_dict2ListForClanBattleBuySkillNotify",
	kCSMsgClanDismiss = "_dict2ListForClanDismiss",
	kCSMsgPetGemLevelUp = "_dict2ListForPetGemLevelUp",
	kCSMsgGMMsgNotify = "_dict2ListForGMMsgNotify",
	kCSMsgHeartBeat = "_dict2ListForHeartBeat",
	kCSMsgChatHeartBeat = "_dict2ListForChatHeartBeat",
	kCSMsgMasterApprenticeSearch = "_dict2ListForMasterApprenticeSearch",
	kCSMsgChatChannelList = "_dict2ListForChatChannelList",
	kCSMsgOpActCollectWordsComposeWord = "_dict2ListForOpActCollectWordsComposeWord",
	kCSMsgZChatSend = "_dict2ListForZChatSend",
	kCSMsgChatPull = "_dict2ListForChatPull",
	kCSMsgHouseMainRoomSet = "_dict2ListForHouseMainRoomSet",
	kCSMsgEquipOff = "_dict2ListForEquipOff",
	kCSMsgChatSystemNotify = "_dict2ListForChatSystemNotify",
	kCSMsgCampTowerSweep = "_dict2ListForCampTowerSweep",
	kCSMsgNewMazeHaloEquip = "_dict2ListForNewMazeHaloEquip",
	kCSMsgDrawNebieBestChange = "_dict2ListForDrawNebieBestChange",
	kCSMsgOpActClanBossDispatch = "_dict2ListForOpActClanBossDispatch",
	kCSMsgZChatReport = "_dict2ListForZChatReport",
	kCSMsgClanSearch = "_dict2ListForClanSearch",
	kCSMsgWChatRegister = "_dict2ListForWChatRegister",
	kCSMsgWChatChannelUpdate = "_dict2ListForWChatChannelUpdate",
	kCSMsgOpactArenaRoleMatchNotify = "_dict2ListForOpactArenaRoleMatchNotify",
	kCSMsgRoleLeaveLoginQueue = "_dict2ListForRoleLeaveLoginQueue",
	kCSMsgOpactArenaRoleInfoRefresh = "_dict2ListForOpactArenaRoleInfoRefresh",
	kCSMsgGiftDrawResultNotify = "_dict2ListForGiftDrawResultNotify",
	kCSMsgApprenticeAddRentCnt = "_dict2ListForApprenticeAddRentCnt",
	kCSMsgClanBattleGetMemberAchieveAward = "_dict2ListForClanBattleGetMemberAchieveAward",
	kCSMsgApprenticeRequestDevelopGuide = "_dict2ListForApprenticeRequestDevelopGuide",
	kCSMsgPowerExchange = "_dict2ListForPowerExchange",
	kCSMsgAsyncPVPAttackTimesNotify = "_dict2ListForAsyncPVPAttackTimesNotify",
	kCSMsgBuddyDelNotify = "_dict2ListForBuddyDelNotify",
	kCSMsgDrawRecord = "_dict2ListForDrawRecord",
	kCSMsgHeroDevelop = "_dict2ListForHeroDevelop",
	kCSMsgBingoDraw = "_dict2ListForBingoDraw",
	kCSMsgMultiPVPRank = "_dict2ListForMultiPVPRank",
	kCSMsgCrystalMsgNotify = "_dict2ListForCrystalMsgNotify",
	kCSMsgPVEAutoBattlePowerNotify = "_dict2ListForPVEAutoBattlePowerNotify",
	kCSMsgFormationsUpdateByPos = "_dict2ListForFormationsUpdateByPos",
	kCSMsgPVEAutoBattle = "_dict2ListForPVEAutoBattle",
	kCSMsgPVEStartNotify = "_dict2ListForPVEStartNotify",
	kCSMsgOpActEquipRecycleNotify = "_dict2ListForOpActEquipRecycleNotify",
	kCSMsgPetItemUpdateNotify = "_dict2ListForPetItemUpdateNotify",
	kCSMsgHeroPaintItemConvert = "_dict2ListForHeroPaintItemConvert",
	kCSMsgClanBattleUnmarkMember = "_dict2ListForClanBattleUnmarkMember",
	kCSMsgHeroDevelopOpenNotify = "_dict2ListForHeroDevelopOpenNotify",
	kCSMsgClanFuncInvite = "_dict2ListForClanFuncInvite",
	kCSMsgEquipSwap = "_dict2ListForEquipSwap",
	kCSMsgOpActRandReplaceSet = "_dict2ListForOpActRandReplaceSet",
	kCSMsgRoleLogoutNotify = "_dict2ListForRoleLogoutNotify",
	kCSMsgAchieveActionProgressNotify = "_dict2ListForAchieveActionProgressNotify",
	kCSMsgTaskGetAward = "_dict2ListForTaskGetAward",
	kCSMsgOpActDrawNewbieUpNewCycle = "_dict2ListForOpActDrawNewbieUpNewCycle",
	kCSMsgGeneralAttrNotify = "_dict2ListForGeneralAttrNotify",
	kCSMsgHeroVoidStarChangeNotify = "_dict2ListForHeroVoidStarChangeNotify",
	kCSMsgPetGemRerandAttribute = "_dict2ListForPetGemRerandAttribute",
	kCSMsgSkinExchange = "_dict2ListForSkinExchange",
	kCSMsgRoleInfo = "_dict2ListForRoleInfo",
	kCSMsgClanFuncInviteNotify = "_dict2ListForClanFuncInviteNotify",
	kCSMsgOpActEquipMakeChoose = "_dict2ListForOpActEquipMakeChoose",
	kCSMsgAdvanceRechargeNotify = "_dict2ListForAdvanceRechargeNotify",
	kCSMsgEquipSchemeApply = "_dict2ListForEquipSchemeApply",
	kCSMsgRoleLoginDataNotify = "_dict2ListForRoleLoginDataNotify",
	kCSMsgClanBattleUseSkill = "_dict2ListForClanBattleUseSkill",
	kCSMsgRoleLogin = "_dict2ListForRoleLogin",
	kCSMsgAsyncPVPReportStatusNotify = "_dict2ListForAsyncPVPReportStatusNotify",
	kCSMsgPetStarUp = "_dict2ListForPetStarUp",
	kCSMsgMonthCounterResetNotify = "_dict2ListForMonthCounterResetNotify",
	kCSMsgOpActivityData = "_dict2ListForOpActivityData",
	kCSMsgWeekCounterResetNotify = "_dict2ListForWeekCounterResetNotify",
	kCSMsgRoleMiscAddicationNotify = "_dict2ListForRoleMiscAddicationNotify",
	kCSMsgWeekTICounterNotify = "_dict2ListForWeekTICounterNotify",
	kCSMsgStageSkip = "_dict2ListForStageSkip",
	kCSMsgEquipBuild = "_dict2ListForEquipBuild",
	kCSMsgRoleRandName = "_dict2ListForRoleRandName",
	kCSMsgHouseFavorRank = "_dict2ListForHouseFavorRank",
	kCSMsgMasterSetDevelopGuide = "_dict2ListForMasterSetDevelopGuide",
	kCSMsgWelfarePushGiftPopupSet = "_dict2ListForWelfarePushGiftPopupSet",
	kCSMsgShopRangeBeg = "_dict2ListForShopRangeBeg",
	kCSMsgHouseCommentSwitchSet = "_dict2ListForHouseCommentSwitchSet",
	kCSMsgOpActGuessAwardInfuse = "_dict2ListForOpActGuessAwardInfuse",
	kCSMsgOpActHatsuneCheerConvertNotify = "_dict2ListForOpActHatsuneCheerConvertNotify",
	kCSMsgOpactArenaSettleNotify = "_dict2ListForOpactArenaSettleNotify",
	kCSMsgGagInfoNotify = "_dict2ListForGagInfoNotify",
	kCSMsgBossTowerDataNotify = "_dict2ListForBossTowerDataNotify",
	kCSMsgOpActGuessGetRank = "_dict2ListForOpActGuessGetRank",
	kCSMsgHeroLevelUpNotify = "_dict2ListForHeroLevelUpNotify",
	kCSMsgDepositAwardRefresh = "_dict2ListForDepositAwardRefresh",
	kCSMsgCrystalMsgGetAward = "_dict2ListForCrystalMsgGetAward",
	kCSMsgRentTaskRefresh = "_dict2ListForRentTaskRefresh",
	kCSMsgRechargeListGet = "_dict2ListForRechargeListGet",
	kCSMsgRechargeRoleFirstAwardNotify = "_dict2ListForRechargeRoleFirstAwardNotify",
	kCSMsgNewPveResetStage = "_dict2ListForNewPveResetStage",
	kCSMsgHeroDevelopUpdateRedPoint = "_dict2ListForHeroDevelopUpdateRedPoint",
	kCSMsgShopRecordUpdateNotify = "_dict2ListForShopRecordUpdateNotify",
	kCSMsgPVEShare = "_dict2ListForPVEShare",
	kCSMsgMazeSelectRelics = "_dict2ListForMazeSelectRelics",
	kCSMsgNewMazeLevelCycleResetNotify = "_dict2ListForNewMazeLevelCycleResetNotify",
	kCSMsgMazeSelectBranch = "_dict2ListForMazeSelectBranch",
	kCSMsgRentRenterCancel = "_dict2ListForRentRenterCancel",
	kCSMsgNewMazeEnchanterUse = "_dict2ListForNewMazeEnchanterUse",
	kCSMsgAsyncPVPSettleNotify = "_dict2ListForAsyncPVPSettleNotify",
	kCSMsgRentTaskSelect = "_dict2ListForRentTaskSelect",
	kCSMsgBookTaskGetAward = "_dict2ListForBookTaskGetAward",
	kCSMsgClanBattleOccupyGrid = "_dict2ListForClanBattleOccupyGrid",
	kCSMsgEquipTowerSweep = "_dict2ListForEquipTowerSweep",
	kCSMsgClanBattlePVEStartNotify = "_dict2ListForClanBattlePVEStartNotify",
	kCSMsgMultiPVPMatch = "_dict2ListForMultiPVPMatch",
	kCSMsgEnergyUpdateNotify = "_dict2ListForEnergyUpdateNotify",
	kCSMsgRentTaskDataNotify = "_dict2ListForRentTaskDataNotify",
	kCSMsgOpactArenaRoleDefendNotify = "_dict2ListForOpactArenaRoleDefendNotify",
	kCSMsgCurrencyExchange = "_dict2ListForCurrencyExchange",
	kCSMsgAsyncPVPChallege = "_dict2ListForAsyncPVPChallege",
	kCSMsgClanBattleNextLayer = "_dict2ListForClanBattleNextLayer",
	kCSMsgOpActPlotGetRank = "_dict2ListForOpActPlotGetRank",
	kCSMsgFormationDataNotify = "_dict2ListForFormationDataNotify",
	kCSMsgOpActDrawSeasonDraw = "_dict2ListForOpActDrawSeasonDraw",
	kCSMsgEquipUpdateNotify = "_dict2ListForEquipUpdateNotify",
	kCSMsgBPPvpKnockoutBet = "_dict2ListForBPPvpKnockoutBet",
	kCSMsgClanBattleGetClanAchieveAward = "_dict2ListForClanBattleGetClanAchieveAward",
	kCSMsgOpActChatGameMakeChocolete = "_dict2ListForOpActChatGameMakeChocolete",
	kCSMsgBuddySocialNotify = "_dict2ListForBuddySocialNotify",
	kCSMsgMailNotify = "_dict2ListForMailNotify",
	kCSMsgCollectAchieveProgressNotify = "_dict2ListForCollectAchieveProgressNotify",
	kCSMsgEquipEvolve = "_dict2ListForEquipEvolve",
	kCSMsgHeroUnlock = "_dict2ListForHeroUnlock",
	kCSMsgDrawDataNotify = "_dict2ListForDrawDataNotify",
	kCSMsgOnceTowerReplayRecord = "_dict2ListForOnceTowerReplayRecord",
	kCSMsgPetOffWears = "_dict2ListForPetOffWears",
	kCSMsgNewPveGetFormation = "_dict2ListForNewPveGetFormation",
	kCSMsgSkinWear = "_dict2ListForSkinWear",
	kCSMsgErrorPromptNotify = "_dict2ListForErrorPromptNotify",
	kCSMsgHeroCrystalStoryUnlock = "_dict2ListForHeroCrystalStoryUnlock",
	kCSMsgEquipBuildLevelUp = "_dict2ListForEquipBuildLevelUp",
	kCSMsgOpActFlottorySetSelIndex = "_dict2ListForOpActFlottorySetSelIndex",
	kCSMsgClanAppoint = "_dict2ListForClanAppoint",
	kCSMsgNewMazeNodeSelect = "_dict2ListForNewMazeNodeSelect",
	kCSMsgAsyncPVPDetailNotify = "_dict2ListForAsyncPVPDetailNotify",
	kCSMsgPetDrawSelect = "_dict2ListForPetDrawSelect",
	kCSMsgPetPossess = "_dict2ListForPetPossess",
	kCSMsgHouseDispatchDayRefreshNotify = "_dict2ListForHouseDispatchDayRefreshNotify",
	kCSMsgNewMazeShopItemUpdateNotify = "_dict2ListForNewMazeShopItemUpdateNotify",
	kCSMsgPowerUpdateNotify = "_dict2ListForPowerUpdateNotify",
	kCSMsgMazeSelectSweepRelics = "_dict2ListForMazeSelectSweepRelics",
	kCSMsgMasterApprenticeDel = "_dict2ListForMasterApprenticeDel",
	kCSMsgRankTopGet = "_dict2ListForRankTopGet",
	kCSMsgNewPveResetProgress = "_dict2ListForNewPveResetProgress",
	kCSMsgOpActBusinessStaminaDonated = "_dict2ListForOpActBusinessStaminaDonated",
	kCSMsgOpActTowerGetBuff = "_dict2ListForOpActTowerGetBuff",
	kCSMsgSkinAddNotify = "_dict2ListForSkinAddNotify",
	kCSMsgEquipSchemeDelete = "_dict2ListForEquipSchemeDelete",
	kCSMsgTaskAcceptNotify = "_dict2ListForTaskAcceptNotify",
	kCSMsgRentOwnerCancel = "_dict2ListForRentOwnerCancel",
	kCSMsgBingoNextRound = "_dict2ListForBingoNextRound",
	kCSMsgClanEnterNotify = "_dict2ListForClanEnterNotify",
	kCSMsgHeroResetNotify = "_dict2ListForHeroResetNotify",
	kCSMsgRechargeMulityNotify = "_dict2ListForRechargeMulityNotify",
	kCSMsgMasterApprenticeAdd = "_dict2ListForMasterApprenticeAdd",
	kCSMsgArtifactWear = "_dict2ListForArtifactWear",
	kCSMsgMasterApprenticeInviteOp = "_dict2ListForMasterApprenticeInviteOp",
	kCSMsgRoleLoginQueueNotify = "_dict2ListForRoleLoginQueueNotify",
	kCSMsgNewMazeTalentWorkNotify = "_dict2ListForNewMazeTalentWorkNotify",
	kCSMsgMailUpdate = "_dict2ListForMailUpdate",
	kCSMsgClanFuncInviterListNotify = "_dict2ListForClanFuncInviterListNotify",
	kCSMsgOpActEquipBaptizeAttrLock = "_dict2ListForOpActEquipBaptizeAttrLock",
	kCSMsgBuddyDel = "_dict2ListForBuddyDel",
	kCSMsgClanBattleGetHonor = "_dict2ListForClanBattleGetHonor",
	kCSMsgRoleCommChangeHeadFrame = "_dict2ListForRoleCommChangeHeadFrame",
	kCSMsgPetMazeRoleDataNotify = "_dict2ListForPetMazeRoleDataNotify",
	kCSMsgMailReport = "_dict2ListForMailReport",
	kCSMsgBuddyBlackListDel = "_dict2ListForBuddyBlackListDel",
	kCSMsgPetChooseGift = "_dict2ListForPetChooseGift",
	kCSMsgTowerSweep = "_dict2ListForTowerSweep",
	kCSMsgHeroNewPaintNotify = "_dict2ListForHeroNewPaintNotify",
	kCSMsgClanOpActMemberDataNotify = "_dict2ListForClanOpActMemberDataNotify",
	kCSMsgTowerDataNotify = "_dict2ListForTowerDataNotify",
	kCSMsgSkinRepeatNotify = "_dict2ListForSkinRepeatNotify",
	kCSMsgRechargeListNotify = "_dict2ListForRechargeListNotify",
	kCSMsgBuddyInviteDelNotify = "_dict2ListForBuddyInviteDelNotify",
	kCSMsgOpActCollectWordsGetBuddyWord = "_dict2ListForOpActCollectWordsGetBuddyWord",
	kCSMsgClanAcceptApply = "_dict2ListForClanAcceptApply",
	kCSMsgQQBlueDataNotify = "_dict2ListForQQBlueDataNotify",
	kCSMsgClanLeaveNotify = "_dict2ListForClanLeaveNotify",
	kCSMsgMasterOpenDevelopGuide = "_dict2ListForMasterOpenDevelopGuide",
	kCSMsgAsyncPVPReportGet = "_dict2ListForAsyncPVPReportGet",
	kCSMsgGagGSInfoNotify = "_dict2ListForGagGSInfoNotify",
	kCSMsgRelicGetNotify = "_dict2ListForRelicGetNotify",
	kCSMsgNewMazeLevelExit = "_dict2ListForNewMazeLevelExit",
	kCSMsgClanBattleLoginNotify = "_dict2ListForClanBattleLoginNotify",
	kCSMsgOpActLotteryAddNotify = "_dict2ListForOpActLotteryAddNotify",
	kCSMsgClanOpActClanDataNotify = "_dict2ListForClanOpActClanDataNotify",
	kCSMsgTaskRefreshNotify = "_dict2ListForTaskRefreshNotify",
	kCSMsgAchieveQualifyNotify = "_dict2ListForAchieveQualifyNotify",
	kCSMsgNewPveReset = "_dict2ListForNewPveReset",
	kCSMsgMonthTICounterNotify = "_dict2ListForMonthTICounterNotify",
	kCSMsgBPPvpOpponentDetailNotify = "_dict2ListForBPPvpOpponentDetailNotify",
	kCSMsgClanJoinNotify = "_dict2ListForClanJoinNotify",
	kCSMsgBuddyInviteNotify = "_dict2ListForBuddyInviteNotify",
	kCSMsgMonumentMsgGetAward = "_dict2ListForMonumentMsgGetAward",
	kCSMsgProficentItemNotify = "_dict2ListForProficentItemNotify",
	kCSMsgOnceTowerDataNotify = "_dict2ListForOnceTowerDataNotify",
	kCSMsgOpActGetAward = "_dict2ListForOpActGetAward",
	kCSMsgRoleOpActSimpleGet = "_dict2ListForRoleOpActSimpleGet",
	kCSMsgWelfareCardInfoNotify = "_dict2ListForWelfareCardInfoNotify",
	kCSMsgRentDataNotify = "_dict2ListForRentDataNotify",
	kCSMsgFormationUpdate = "_dict2ListForFormationUpdate",
	kCSMsgHeroExchange = "_dict2ListForHeroExchange",
	KCSMsgRefluxGetOnceAward = "_dict2ListForRefluxGetOnceAward",
	kCSMsgBPPvpKnockoutEnterRoom = "_dict2ListForBPPvpKnockoutEnterRoom",
	kCSMsgAchieveGetAward = "_dict2ListForAchieveGetAward",
	kCSMsgBattlePassRoleDataNotify = "_dict2ListForBattlePassRoleDataNotify",
	kCSMsgAsyncPVPReportNotify = "_dict2ListForAsyncPVPReportNotify",
	kCSMsgDepositAwardNotify = "_dict2ListForDepositAwardNotify",
	kCSMsgHouseUpdate = "_dict2ListForHouseUpdate",
	kCSMsgRelicOff = "_dict2ListForRelicOff",
	kCSMsgNewPveChooseLimits = "_dict2ListForNewPveChooseLimits",
	kCSMsgPVEStart = "_dict2ListForPVEStart",
	kCSMsgOpactArenaSetRandFormaion = "_dict2ListForOpactArenaSetRandFormaion",
	kCSMsgMasterClientUpdateProgress = "_dict2ListForMasterClientUpdateProgress",
	kCSMsgMultiPVPTargetCache = "_dict2ListForMultiPVPTargetCache",
	kCSMsgSubscribeDataNotify = "_dict2ListForSubscribeDataNotify",
	kCSMsgRentGetSendLetter = "_dict2ListForRentGetSendLetter",
	kCSMsgRoleCommChangeHeadPendant = "_dict2ListForRoleCommChangeHeadPendant",
	kCSMsgNewMazeOpen = "_dict2ListForNewMazeOpen",
	kCSMsgBPPvpKnockoutFormationGet = "_dict2ListForBPPvpKnockoutFormationGet",
	kCSMsgHouseVisitNotify = "_dict2ListForHouseVisitNotify",
	kCSMsgOpActMonopolyUseItem = "_dict2ListForOpActMonopolyUseItem",
	kCSMsgClanBattleExitClanNotify = "_dict2ListForClanBattleExitClanNotify",
	kCSMsgRoleRename = "_dict2ListForRoleRename",
	kCSMsgHouseLevelUp = "_dict2ListForHouseLevelUp",
	kCSMsgNewMazeLevelEnter = "_dict2ListForNewMazeLevelEnter",
	kCSMsgPrivilegeItemChangeNotify = "_dict2ListForPrivilegeItemChangeNotify",
	kCSMsgMazeRelicsRandNotify = "_dict2ListForMazeRelicsRandNotify",
	kCSMsgMysteryShopUpdateNotify = "_dict2ListForMysteryShopUpdateNotify",
	kCSMsgOpActEquipRecycleStop = "_dict2ListForOpActEquipRecycleStop",
	kCSMsgOpactArenaReportGet = "_dict2ListForOpactArenaReportGet",
	kCSMsgBPPvpKnockoutGetHallData = "_dict2ListForBPPvpKnockoutGetHallData",
	kCSMsgNetDelay = "_dict2ListForNetDelay",
	kCSMsgHeroStarBack = "_dict2ListForHeroStarBack",
	kCSMsgMultiPVPUpdateNotify = "_dict2ListForMultiPVPUpdateNotify",
	kCSMsgMasterRecieveDevelopGuideNotify = "_dict2ListForMasterRecieveDevelopGuideNotify",
	kCSMsgHeroPaintNotify = "_dict2ListForHeroPaintNotify",
	kCSMsgBagSizeExtend = "_dict2ListForBagSizeExtend",
	kCSMsgOpActCollectWordsRecvWord = "_dict2ListForOpActCollectWordsRecvWord",
	kCSMsgOperateEventCompleteNotify = "_dict2ListForOperateEventCompleteNotify",
	kCSMsgClanGet = "_dict2ListForClanGet",
	kCSMsgClanMailNotify = "_dict2ListForClanMailNotify",
	kCSMsgRoleOweItemNotify = "_dict2ListForRoleOweItemNotify",
	kCSMsgHeroReset = "_dict2ListForHeroReset",
	kCSMsgExecuteGM = "_dict2ListForExecuteGM",
	kCSMsgHeroStarUpNotify = "_dict2ListForHeroStarUpNotify",
	kCSMsgClanBattleGetScoreLog = "_dict2ListForClanBattleGetScoreLog",
	kCSMsgEquipSchemeItemNotify = "_dict2ListForEquipSchemeItemNotify",
	kCSMsgPetAmuletStarUp = "_dict2ListForPetAmuletStarUp",
	kCSMsgHouseComfortAwardGet = "_dict2ListForHouseComfortAwardGet",
	kCSMsgOpActDraw = "_dict2ListForOpActDraw",
	kCSMsgDressHeadFrameGetNotify = "_dict2ListForDressHeadFrameGetNotify",
	kCSMsgRentGetOwnerFormation = "_dict2ListForRentGetOwnerFormation",
	kCSMsgOpactArenaUpgradeLeague = "_dict2ListForOpactArenaUpgradeLeague",
	kCSMsgMailRecallNotify = "_dict2ListForMailRecallNotify",
	kCSMsgPetDevelopIntelligence = "_dict2ListForPetDevelopIntelligence",
	kCSMsgRentOwnerNotify = "_dict2ListForRentOwnerNotify",
	kCSMsgClanBattleChatMsgNotify = "_dict2ListForClanBattleChatMsgNotify",
	kCSMsgDraw = "_dict2ListForDraw",
	kCSMsgApprenticeRequestBattleGuide = "_dict2ListForApprenticeRequestBattleGuide",
	kCSMsgBattlePassActionProgressNotify = "_dict2ListForBattlePassActionProgressNotify",
	kCSMsgHeroStepUpNotify = "_dict2ListForHeroStepUpNotify",
	kCSMsgRelicWear = "_dict2ListForRelicWear",
	kCSMsgHeroRecycle = "_dict2ListForHeroRecycle",
	kCSMsgClanBattleCancelGridNotify = "_dict2ListForClanBattleCancelGridNotify",
	kCSMsgWeekICounterNotify = "_dict2ListForWeekICounterNotify",
	kCSMsgRoleCommEditFormation = "_dict2ListForRoleCommEditFormation",
	kCSMsgClanBattleSetRelic = "_dict2ListForClanBattleSetRelic",
	kCSMsgOpactArenaRoleInfoNotify = "_dict2ListForOpactArenaRoleInfoNotify",
	kCSMsgSubscribeGetAward = "_dict2ListForSubscribeGetAward",
	kCSMsgClanBattleOpenGridNotify = "_dict2ListForClanBattleOpenGridNotify",
	kCSMsgClanBattleOccupyMonsterNotify = "_dict2ListForClanBattleOccupyMonsterNotify",
	kCSMsgMasterApprenticeInviteAddNotify = "_dict2ListForMasterApprenticeInviteAddNotify",
	kCSMsgClanBattleBoxMarkAwardNotify = "_dict2ListForClanBattleBoxMarkAwardNotify",
	kCSMsgClanKick = "_dict2ListForClanKick",
	kCSMsgForeverTICounterNotify = "_dict2ListForForeverTICounterNotify",
	kCSMsgClanBattleExit = "_dict2ListForClanBattleExit",
	kCSMsgOpactArenaRankGet = "_dict2ListForOpactArenaRankGet",
	kCSMsgOpActBusinessOrderUpdate = "_dict2ListForOpActBusinessOrderUpdate",
	kCSMsgHouseFavorHistory = "_dict2ListForHouseFavorHistory",
	kCSMsgOpActBusinessMaterialProduct = "_dict2ListForOpActBusinessMaterialProduct",
	kCSMsgClanJoin = "_dict2ListForClanJoin",
	kCSMsgEquipTeamWear = "_dict2ListForEquipTeamWear",
	kCSMsgRedPacketGetAward = "_dict2ListForRedPacketGetAward",
	kCSMsgNewMazeRandPoolCheck = "_dict2ListForNewMazeRandPoolCheck",
	kCSMsgOpactArenaRoleGetNearRank = "_dict2ListForOpactArenaRoleGetNearRank",
	kCSMsgClanBattleGetLog = "_dict2ListForClanBattleGetLog",
	kCSMsgPVEQuit = "_dict2ListForPVEQuit",
	kCSMsgMazeSysDataNotify = "_dict2ListForMazeSysDataNotify",
	kCSMsgBroadcastSvrPkgNotify = "_dict2ListForBroadcastSvrPkgNotify",
	kCSMsgCollectAchieveGetAward = "_dict2ListForCollectAchieveGetAward",
	kCSMsgOpActFlottoryDraw = "_dict2ListForOpActFlottoryDraw",
	kCSMsgFormationSnapshot = "_dict2ListForFormationSnapshot",
	kCSMsgRankIndexGet = "_dict2ListForRankIndexGet",
	kCSMsgClanFuncShare = "_dict2ListForClanFuncShare",
	kCSMsgHeroOffWears = "_dict2ListForHeroOffWears",
	kCSMsgClanBattleGiveOrder = "_dict2ListForClanBattleGiveOrder",
	kCSMsgRentTeamNumNotify = "_dict2ListForRentTeamNumNotify",
	kCSMsgStageDataNotify = "_dict2ListForStageDataNotify",
	kCSMsgHouseVisit = "_dict2ListForHouseVisit",
	kCSMsgPetDegreeRuneActive = "_dict2ListForPetDegreeRuneActive",
	kCSMsgOpActSetFocus = "_dict2ListForOpActSetFocus",
	kCSMsgBuddyOp = "_dict2ListForBuddyOp",
	kCSMsgHeroStickLevelNotify = "_dict2ListForHeroStickLevelNotify",
	kCSMsgClanExit = "_dict2ListForClanExit",
	kCSMsgMasterApprenticeGraduation = "_dict2ListForMasterApprenticeGraduation",
	kCSMsgRechargeRebateNotify = "_dict2ListForRechargeRebateNotify",
	kCSMsgBuddyRecommend = "_dict2ListForBuddyRecommend",
	kCSMsgNewMazeLayerNextNotify = "_dict2ListForNewMazeLayerNextNotify",
	kCSMsgHouseShare = "_dict2ListForHouseShare",
	kCSMsgGiftDrawWinnersListGet = "_dict2ListForGiftDrawWinnersListGet",
	kCSMsgClanBattleCancelMonster = "_dict2ListForClanBattleCancelMonster",
	kCSMsgMasterSetBattleGuide = "_dict2ListForMasterSetBattleGuide",
	kCSMsgOpActAchieveExchangeItem = "_dict2ListForOpActAchieveExchangeItem",
	kCSMsgEquipGetNotify = "_dict2ListForEquipGetNotify",
	kCSMsgBuddyGiftOp = "_dict2ListForBuddyGiftOp",
	kCSMsgStageRecord = "_dict2ListForStageRecord",
	kCSMsgClanBattleOccupyGridNotify = "_dict2ListForClanBattleOccupyGridNotify",
	kCSMsgNewMazeMultiAwardListNotify = "_dict2ListForNewMazeMultiAwardListNotify",
	kCSMsgHouseFavor = "_dict2ListForHouseFavor",
	kCSMsgDesireRecommendNotify = "_dict2ListForDesireRecommendNotify",
	kCSMsgOpActTowerRoleAchieveNotify = "_dict2ListForOpActTowerRoleAchieveNotify",
	kCSMsgBuddyAdd = "_dict2ListForBuddyAdd",
	kCSMsgNewMazeRandomEventOptionSelect = "_dict2ListForNewMazeRandomEventOptionSelect",
	kCSMsgProficentOtherItemNotify = "_dict2ListForProficentOtherItemNotify",
	kCSMsgHouseVisitRandom = "_dict2ListForHouseVisitRandom",
	kCSMsgPetRuneActive = "_dict2ListForPetRuneActive",
	kCSMsgOpActTurnTableDraw = "_dict2ListForOpActTurnTableDraw",
	kCSMsgRoleCommChangeGender = "_dict2ListForRoleCommChangeGender",
	kCSMsgRechargeCancelOrder = "_dict2ListForRechargeCancelOrder",
	kCSMsgVIPSetHide = "_dict2ListForVIPSetHide",
	KCSMsgRefluxNewSetFlag = "_dict2ListForRefluxNewSetFlag",
	kCSMsgArtifactUpdateNotify = "_dict2ListForArtifactUpdateNotify",
	kCSMsgBuddyInfoNotify = "_dict2ListForBuddyInfoNotify",
	kCSMsgOpActEquipBaptizeDone = "_dict2ListForOpActEquipBaptizeDone",
	kCSMsgNewDayNotify = "_dict2ListForNewDayNotify",
	kCSMsgOpActivityMgrDataNotify = "_dict2ListForOpActivityMgrDataNotify"
}
RPC._msgReqBackend = {
	kCSMsgRoleLeaveLoginQueue = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleLogin = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleRandName = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleRename = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCreate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleInfo = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleLogout = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgExecuteGM = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMailUpdate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMailGetAttach = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMailReport = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyAdd = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyDel = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyInviteOp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddySearch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyBlackListAdd = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyBlackListDel = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyRecommend = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyGiftOp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyOnline = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBuddyBondSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActivityData = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgGagGSSetGag = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMonopolyRoll = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMonopolyExchange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDepositRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDepositGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActPlotPassCurStage = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActPlotGetAchieveAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBingoDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBingoSetBigReward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActSetFocus = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActShopRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActAchieveFinalAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActPlotSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActPlotGetRank = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActLotteryGetRank = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActShopLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawReplaceSetDisable = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactWishChoose = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactWishGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactFirePlaceGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawReplaceChangeIndex = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActOnHookRoleFirstIn = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActOnHookRoleOnCook = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActOnHookRoleDeliver = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActOnHookRoleCancelCook = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActOnHookRoleSpeedUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawGetShareAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawReplaceShareAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActHatsuneGetNodeAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActMonopolySetLibAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActMonopolyUseItem = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActClanBossDispatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActClanBossGetStageAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActClanBossGetAchieveAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActFlottoryDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActFlottorySetSelIndex = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceSelectTask = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceSelectFriendTask = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceSetFriend = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceSetCatInfo = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceSendFriend = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceGetPublishAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceGetTaskAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCatRaceGetFriendGift = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsRefreshDeposit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsGetDeposit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsRecvWord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsGivingWord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsDestroyWord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsComposeWord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsGetBuddyWord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActCollectWordsUseItem = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActAchieveSetClientTriggerFlag = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActAchieveExchangeItem = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActChatGameMakeChocolete = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActChatGameChooseBranch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActChatGameChatEnd = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActChatGameResetChat = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActChatGameFormulaShare = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActChatGameGivingGift = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActHomeDispatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActHomeDispatchGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActHomeDispatchSpeedUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActHomeDispatchBuild = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActGuessChooseAnswer = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActGuessAwardInfuse = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActGuessGetRank = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActGuessGetTotalAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActGuessWatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActGuessIsRight = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessMaterialProduct = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessMaterialCompose = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessStaminaReceive = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessStaminaDonated = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessOrderCommit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessOrderUpdate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessMaterialUpgrade = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActBusinessMaterialDelete = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTurnTableDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgGiftDrawWinnersListGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgGiftDrawGiftShare = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipMakeChoose = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipMakeRand = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipBaptizeChoose = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipBaptizeInit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipBaptizeRandAttr = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipBaptizeDone = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipBaptizeAttrLock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawNewbieUpDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawNewbieUpNewCycle = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActRandReplaceSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawNewbieCampDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActDrawSeasonDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipRecycleChoose = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipRecycleStart = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipRecycleStop = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipRecycleGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActEquipRecycleUnlockWorkShop = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActAchieveGetAllAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRechargeGenerateOrderID = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRechargeCancelOrder = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRechargeListGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRechargeGetFirstAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRechargeGetMulityAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgSubscribeGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDraw = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDrawNewbie = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDrawUnlockCamp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDrawNebieBestChange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDrawRecord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDrawSetDesire = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetDrawRest = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetDrawSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDrawNewbieReset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPVEStart = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPVEFinish = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPVEQuit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPVEBattleReplay = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPVEShare = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPVEAutoBattle = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationUpdate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationsUpdateByType = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationSnapshot = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationSnapshotSwapIdx = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationSnapshotGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationsUpdateByPos = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgStageUnlockNext = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgStageRecord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgStageSkip = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDepositAwardRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDepositAwardGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgDepositAwardStart = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgTowerStarAwardGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgTowerSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipWear = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipOff = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipSell = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipSwap = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipEvolve = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipBuild = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipBuildLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipLock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgArtifactWear = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgArtifactOff = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgArtifactSell = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgArtifactLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgArtifactLock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgShopExchange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgShopEnter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCurrencyExchange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgShopRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAchieveGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAchieveProgressUpdateClient = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleMiscIDCard = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleMiscYD = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleMiscConsignee = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipTowerSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipTowerReplayRecord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipTowerChooseHero = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBagSizeExtend = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPMatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPChallege = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPReportGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPGetDetail = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPTargetCache = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAsyncPVPScore = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCDKey = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBossTowerAwardGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBossTowerReplayRecord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOnceTowerReplayRecord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewbieReport = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgTaskGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgTaskGetAllDailyAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseUpdate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseVisit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseUnlockAwardGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseComfortAwardGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseVisitHistoryGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseFavor = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseFavorHistory = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseFavorRank = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseVisitRandom = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseShare = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseMainRoomSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseCommentSwitchSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMazeSelectBranch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMazeSelectRelics = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMazeSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMazeRelive = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMazeSelectSweepRelics = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMazeSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRankIndexGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRankGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRankTopGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBookTaskGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgWelfareGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgWelfarePushGiftPopupSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBattlePassGetTaskAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBattlePassGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBattlePassBuyBpCount = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBattlePassBpGetSystemData = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBattlePassReset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgSurveyFinish = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommEditFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommEditSignature = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommChangeGender = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommChangeHead = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommChangeHeadFrame = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommEditVowHero = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommChangeHeadPendant = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommEditSignet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleCommChangeBubble = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMonumentMsgGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCrystalMsgLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCrystalMsgSetSympathizer = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCrystalMsgUnsetSympathizer = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCrystalMsgSaveSympathizer = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCrystalMsgGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPowerExchange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgVIPGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgVIPSetHide = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanCreate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanJoin = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanAcceptApply = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanRefuseApply = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanExit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanDismiss = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanKick = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanAppoint = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanRename = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanRenotice = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanSearch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanRecommend = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanCheckin = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanTransfer = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanSendMail = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanRehead = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanSetAutoAccept = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanReHeadFrame = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFamiliarLevelChange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseDispatchStart = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseDispatchDone = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseDispatchLock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseDispatchRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHouseDispatchAllDone = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMultiPVPMatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMultiPVPTargetCache = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMultiPVPRank = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMultiPVPAwardGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMultiPVPReportGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRelicWear = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRelicOff = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRelicLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgSeasonRelicOp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgSkinWear = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgSkinExchange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgSkinUnlock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRechargeRebateAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaRoleOpen = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaEnroll = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaUpgradeLeague = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaMatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaDetailGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaReportGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaRankGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaRankTopGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaRoleInfoRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaRoleGetNearRank = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpactArenaSetRandFormaion = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerGetScoreAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerSetBuff = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerGetBuff = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerRefreshDeposite = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerGetDepositAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerReplayRecord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgOpActTowerEnter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentTaskRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentTaskSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentMatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentSetAutoAccept = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentSendLetter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentRenterRent = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentRenterCancel = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentOwnerAccept = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentOwnerRefuse = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentOwnerCancel = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentGetRentedFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentGetOwnerFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentGetLetter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentUpdateFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRentGetSendLetter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRankCacheGetPage = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRankCacheGetRealRanking = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgProficentLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgProficentGetScore = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgProficentGetOtherScore = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgProficentBookGemUse = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgQQBlueGetForeverAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgQQBlueGetDayAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRedPacketGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAdvanceGetTaskAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgAdvanceGetStepAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleEnter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleExit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleOccupyGrid = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleCancelGrid = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleOccupyMonster = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleCancelMonster = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleOpenGrid = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleNextLayer = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleBuySkill = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleUseSkill = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleSetModel = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleGiveOrder = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleSetRelic = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleScoreInfuse = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleGetScoreLog = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleGetLog = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleGetClanAchieveAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleGetMemberAchieveAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleGetHonor = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleMarkMember = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleUnmarkMember = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanBattleOpGridMark = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanFuncInvite = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanFuncRefuseInvite = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgClanFuncShare = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCampTowerSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCampTowerReplayRecord = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCampTowerUpdateStage = RPC.CONNECT_BACKEND_ZONE,
	KCSMsgDynamicExpressionUse = RPC.CONNECT_BACKEND_ZONE,
	KCSMsgRefluxGetOnceAward = RPC.CONNECT_BACKEND_ZONE,
	KCSMsgRefluxNewSetFlag = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRoleOpActSimpleGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgCollectAchieveGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeOpen = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeLevelEnter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeNodeSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeHaloEquip = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeHaloUnEquip = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeMultiAwardSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeLayerNextReq = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeFormationUpdate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeBattleLoseExit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeLevelExit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeRandPoolCheck = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeShopRefresh = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeShopPurchase = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeShopSell = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeRandomEventSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeRandomEventOptionSelect = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeFeatureUse = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeSetOutsideRelic = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeModifyInherit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeSelectInherit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeEnchanterUse = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewMazeTalentSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetPossess = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetPossessReplace = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetDevelopIntelligence = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetChooseIntelligence = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetDevelopGift = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetChooseGift = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetDegreeLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetDegreeRuneActive = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetStarUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetRecycle = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetExchange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetRuneActive = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetGemLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetGemRerandAttribute = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetGemInset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetAmuletSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetAmuletStarUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetRuneUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetRuneHeroBind = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetGemSaveAttribute = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetOffWears = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMysteryShopEnter = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMysteryShopExit = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpGroupEnterRoom = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpGroupDetailGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpGroupReportGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutGetHallData = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutEnterRoom = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutSetBPPool = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutBP = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutBPPoolGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutFormationGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutRoomInfoGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutReportGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutBet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutBetInfoGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockoutBetHistoryGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpActivityStateGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockouotChatReq = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgBPPvpKnockouotBanRuleSet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetMazeSaveFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetMazeSaveSupportFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetMazeReset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetMazeGetStepAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgPetMazeSweep = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveChooseLevel = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveChooseLimits = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveReset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveSaveFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveGetAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveGetFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveGetCurFormation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveWearRelic = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveResetProgress = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPveResetStage = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNewPvePopUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRelaxingGamePass = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRelaxingGameGetBigAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgRelaxingGameChooseFirstGame = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgFormationRecommendRankGet = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeAdd = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeDel = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeGraduation = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeInviteOp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeSearch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeRecommend = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeEnroll = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeQualificationUpdate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterApprenticeGetTaskAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterGetLevelAward = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgApprenticeRequestDevelopGuide = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterSetDevelopGuide = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterGetApprenticeAllHero = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgApprenticeRequestBattleGuide = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterSetBattleGuide = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterOpenDevelopGuide = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgApprenticeAddRentCnt = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgApprenticeAddGuideCnt = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgMasterClientUpdateProgress = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgItemSell = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgItemUse = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgItemCompound = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroLevelUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroStepUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroStarUp = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroRecycle = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroRecharge = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroReset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroLevelReset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroStepReset = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroLock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroUnlock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroStarUpBatch = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroExchange = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroOffWears = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroStarBack = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroPaint = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroPaintAbility = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroDevelop = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroDevelopUpdateRedPoint = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroPaintItemConvert = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroCrystalStoryUnlock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroPaintRelateUnlock = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeroNewPaint = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipSchemeUpdate = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipSchemeApply = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipSchemeRename = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipSchemeDelete = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgEquipTeamWear = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgHeartBeat = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgNetDelay = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgChatHeartBeat = RPC.CONNECT_BACKEND_CHAT,
	kCSMsgChatChannelList = RPC.CONNECT_BACKEND_CHAT,
	kCSMsgZChatRegister = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgZChatSend = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgChatPull = RPC.CONNECT_BACKEND_CHAT,
	kCSMsgZChatReport = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgWChatRegister = RPC.CONNECT_BACKEND_ZONE,
	kCSMsgWChatChannelChange = RPC.CONNECT_BACKEND_ZONE
}

if not IsGLDeclared("RPC") or not RPC then
	GLDeclare("RPC", RPC)
end

return RPC

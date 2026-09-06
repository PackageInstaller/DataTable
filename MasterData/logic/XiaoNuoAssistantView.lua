-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/XiaoNuoAssistantView.lua

module("logic.extensions.xiaonuoassistant.view.XiaoNuoAssistantView", package.seeall)

local XiaoNuoAssistantView = class("XiaoNuoAssistantView", ViewComponent)

XiaoNuoAssistantView.PopupWindowKey = "XiaoNuoAssistantView.PopupWindowKey"

function XiaoNuoAssistantView:ctor()
	XiaoNuoAssistantView.super.ctor(self)
end

function XiaoNuoAssistantView:buildUI()
	XiaoNuoAssistantView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnStart = self:getBtn("btnStart")
	self._btnSelectAll = self:getBtn("subTitle/btnSelectAll")
	self._markBtnSelectAll = self:getGo("subTitle/btnSelectAll/Background/Checkmark")
	self._btnSelectAllIsOn = false
	self._txtSubTitle = self:getTxt("subTitle/txtName")
	self._tabCell = self:getGo("tabcell")
	self._tabTableViewGo = self:getGo("tabtableview")
	self.tabScrollList = ScrollerList.create(self._tabTableViewGo, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._cellbase = self:getGo("cellbase")

	goutil.setActive(self._cellbase, false)

	self._detailcellList = {}

	for i = 1, #XiaoNuoAssistantModel.PrefabClass do
		local cellBaseGo = goutil.cloneAndSetParent(self._cellbase, self.mainGO.transform, "realcell" .. i)
		local detailcellGo = self:getGo("detailcell" .. i)

		goutil.setActive(cellBaseGo, false)
		goutil.setActive(detailcellGo, true)

		local detailcellparent = goutil.findChild(cellBaseGo, "detailcellparent")

		detailcellGo.name = XiaoNuoAssistantModel.cellName

		goutil.addChildToParent(detailcellGo, detailcellparent)
		GameUtil.setLocalPos(detailcellGo, 0, 0, 0)
		table.insert(self._detailcellList, cellBaseGo)
	end

	self._tableviewGo = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self._tableviewGo, self._detailcellList, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self.scrollList:regGetTagByIdx(GameUtil.handler(self._getTagByData, self))
	self.scrollList:regGetCellSize(function(view, index)
		return self:_setCellSize(view, index)
	end)

	self._dragTrigger = Framework.UIDragTrigger.Get(self._tableviewGo)
end

function XiaoNuoAssistantView:_setCellSize(view, index)
	local assistData = self.scrollList:getData()[index + 1]
	local funcIndex = assistData:getFuncIndex()
	local x, y = XiaoNuoAssistantController.instance:getCellHeight(funcIndex)

	return x, y
end

function XiaoNuoAssistantView:bindEvents()
	XiaoNuoAssistantView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSelectAll:AddClickListener(self._onBtnSelectAllClick, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._dragTrigger:AddEndDragListener(self._onDragTableviewEnd, self)
end

function XiaoNuoAssistantView:unbindEvents()
	XiaoNuoAssistantView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSelectAll:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._dragTrigger:RemoveEndDragListener()
end

function XiaoNuoAssistantView:onEnter()
	XiaoNuoAssistantView.super.onEnter(self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onChangeDay, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantClick, self._onCellClickBtn, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantUpdateMainView, self._updateMainViewRes, self)
	GlobalDispatcher:addListener(FamilyController.OnGetMyFamilyInfoRes, self._onGetMyFamilyInfoRes, self)
	self.addGEvent(self, FamilyController.GetDonatePoolInfoRes, self._onGetDonatePoolInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.InfiniteInfoRes, self._onInfiniteInfoRes, self)
	GlobalDispatcher:addListener(ThroneController.PM_GetThronePanelOtherInfoRes, self._onGetThronePanelOtherInfoRes, self)
	GlobalDispatcher:addListener(MoneyCatAgent.MoneyCatInfoRes, self._onMoneyCatInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BasicBenefitsGetInfoRes, self._onBasicBenefitsGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PigRaiseAdventureStateUpdate, self._onPigRaiseAdventureStateUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.SendOrGainHeart, self._onSendOrGainHeart, self)
	self.addGEvent(self, WTowerController.GetWarriorTowerProfitInfoRes, self._onGetWarriorTowerProfitInfoRes, self)
	self.addGEvent(self, GoodFeelController.PM_GFGetRaceBookInfoRes, self._onGFGetRaceBookInfoRes, self)
	self.addGEvent(self, GlobalNotify.LegendChallengeTimesInfoRes, self._onLegendChallengeTimesInfoRes, self)
	self.addGEvent(self, GlobalNotify.MCLG_SimpleProgressInfoRes, self._onMCLG_SimpleProgressInfoRes, self)
	self.addGEvent(self, PetDispatchAgent.PM_GetMyPetDispatchInfoRes, self._onGetMyPetDispatchInfoRes, self)
	self.addGEvent(self, VipAgent.PM_GetVipInfoRes, self._onGetVipInfoRes, self)
	self.addGEvent(self, ArenaAgent.OpenArenaRes, self._onOpenArenaRes, self)
	self.addGEvent(self, Arena3v3Agent.Arena3v3InfoRes, self._onArena3v3InfoRes, self)
	self.addGEvent(self, Arena3v3Agent.Arena3v3FormationRes, self._onArena3v3FormationRes, self)
	self.addGEvent(self, LingWenAgent.LingWenGetInfoRes, self._onLingWenGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_LoadAdventureBuildingInfoResp, self._onCuteAdvGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.UpdataNewFamilyTask, self._onFamilyTaskGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.SignInBuffGetInfo, self._onSignInBuffGetInfo, self)

	self._assistDataDic = {}
	self._assistDataList = {}
	self._curTabIndex = self:getFirstParam() or 0
	self._reqTabList = XiaoNuoAssistantModel.instance:getInitReqList()

	self:_initTabList()
	self:_initAssistDataDic()

	if self._curTabIndex > 0 then
		self:_onClickTab(self._curTabIndex, true)
	else
		self:_onClickTab(XiaoNuoAssistantModel.TabEnum.Material)
	end

	if not GameUtil.getUserData(XiaoNuoAssistantView.PopupWindowKey) then
		GameUtil.saveUserData(XiaoNuoAssistantView.PopupWindowKey, true)
		self:_onClickTip()
	end

	LotteryController.instance:CSRequestLotteryInfo()
end

function XiaoNuoAssistantView:onExit()
	XiaoNuoAssistantView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onChangeDay, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantClick, self._onCellClickBtn, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantUpdateMainView, self._updateMainViewRes, self)
	GlobalDispatcher:removeListener(FamilyController.OnGetMyFamilyInfoRes, self._onGetMyFamilyInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.InfiniteInfoRes, self._onInfiniteInfoRes, self)
	GlobalDispatcher:removeListener(ThroneController.PM_GetThronePanelOtherInfoRes, self._onGetThronePanelOtherInfoRes, self)
	GlobalDispatcher:removeListener(MoneyCatAgent.MoneyCatInfoRes, self._onMoneyCatInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.BasicBenefitsGetInfoRes, self._onBasicBenefitsGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PigRaiseAdventureStateUpdate, self._onPigRaiseAdventureStateUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.SendOrGainHeart, self._onSendOrGainHeart, self)
	self.tabScrollList:dispose()
	self.scrollList:dispose()
end

function XiaoNuoAssistantView:destroyUI()
	self.scrollList:dispose()
end

function XiaoNuoAssistantView:_sendReq(tabIndex)
	if tabIndex == XiaoNuoAssistantModel.TabEnum.Material then
		if not self._reqTabList[tabIndex][1] then
			MoneyCatAgent.instance:sendMoneyCatInfoReq()
		end

		if not self._reqTabList[tabIndex][2] then
			SupplymergeController.instance:sendBasicBenefitsGetInfoReq()
		end

		self._reqTabList[tabIndex][3] = self._reqTabList[tabIndex][3] or true

		if not self._reqTabList[tabIndex][4] then
			PetDispatchAgent.instance:sendGetMyPetDispatchInfoReq()
		end

		if not self._reqTabList[tabIndex][5] then
			VipController.instance:sendGetVipInfoReq()
		end

		self._reqTabList[tabIndex][6] = self._reqTabList[tabIndex][6] or true
	elseif tabIndex == XiaoNuoAssistantModel.TabEnum.Gameplay then
		if not self._reqTabList[tabIndex][1] then
			EndlessBattleController.instance:infiniteFightInfoReq()
		end

		if not self._reqTabList[tabIndex][2] then
			MaterialChallengeAgent.instance:sendMCLG_SimpleProgressInfoReq()
		end

		if not self._reqTabList[tabIndex][3] then
			LegendController.instance:sendLegendChallengeTimesInfoReqAll()
		end

		if not self._reqTabList[tabIndex][4] then
			WTowerController.instance:getWarriorInfo(function()
				local towerId = WTowerModel.instance:getTowerId()

				if WTowerModel.instance:getCurLevel(towerId) > 1 or towerId > 1 then
					WTowerController.instance:sendGetWarriorTowerProfitInfoReq()
				else
					self._reqTabList[tabIndex][4] = true

					self:_updateDetailInfoByRes()
				end
			end)
		end

		if FamilyController.instance:checkFamilyOpen() then
			if not self._reqTabList[tabIndex][5] then
				FamilyController.instance:getMyFamilyInfoReq()
			end

			self._reqTabList[tabIndex][6] = self._reqTabList[tabIndex][6] or true

			if not self._reqTabList[tabIndex][7] then
				FamilyController.instance:getDonatePoolInfoReq()
			end

			if not self._reqTabList[tabIndex][14] then
				FamilyHonorController.instance:csRequestFamilyTaskInfoReq()
			end
		else
			self._reqTabList[tabIndex][5] = true
			self._reqTabList[tabIndex][6] = true
			self._reqTabList[tabIndex][7] = true
			self._reqTabList[tabIndex][14] = true
		end

		if not self._reqTabList[tabIndex][8] then
			ArenaController.instance:getArenaInfos()
		end

		if SeniorArenaController.instance:getIsOpen(true) then
			if not self._reqTabList[tabIndex][9] then
				SeniorArenaController.instance:reqArenaInfo()
			end

			if not self._reqTabList[tabIndex][10] then
				SeniorArenaController.instance:checkMyDefendForms()
			end
		else
			self._reqTabList[tabIndex][9] = true
			self._reqTabList[tabIndex][10] = true
		end

		if not self._reqTabList[tabIndex][11] then
			HolyStripeCopyController.instance:getInfo()
		end

		if not self._reqTabList[tabIndex][12] then
			BreachFormationAgent.instance:sendPM_BreachFormationGetUserInfoReq(function(msg)
				BreakFormationModel.instance:handlePM_BreachFormationGetUserInfoRes(msg)
				BreakFormationController.instance:localNotify("onDataLoaded")

				self._reqTabList[tabIndex][12] = true

				self:_updateDetailInfoByRes()
			end)
		end

		if not self._reqTabList[tabIndex][13] then
			local buildingCount = #(CutePetConfig.instance:getAllAdventureBuilding() or {})

			if buildingCount > 0 then
				CutePetController.instance:sendPM_LoadAdventureBuildingInfoReq(buildingCount)
			end
		else
			self._reqTabList[tabIndex][13] = true
		end

		if not self._reqTabList[tabIndex][15] then
			XiaoNuoAssistantController.instance:sendGetSignInBuffInfoList()
		end
	elseif tabIndex == XiaoNuoAssistantModel.TabEnum.Relaxation then
		if not self._reqTabList[tabIndex][1] then
			ThroneAgent.instance:sendPM_GetThronePanelOtherInfoReq()
		end

		if not self._reqTabList[tabIndex][2] then
			AnimalsAgent.instance:sendPM_AnimalsGetStateReq(function(msg)
				PigraiseModel.instance:updateAfterGetState(msg)

				local isSendSuccess = PigraiseController.instance:getAdventureInfoReq()

				if not isSendSuccess then
					printInfo("test 宠物冒险信息1", msg)
					GlobalDispatcher:dispatch(GlobalNotify.PigRaiseAdventureStateUpdate)
				end

				printInfo("test 宠物冒险信息2", msg)
			end)
		end

		self._reqTabList[tabIndex][3] = true

		if not self._reqTabList[tabIndex][4] then
			GoodFeelingAgent.instance:sendPM_GFGetRaceBookInfoReq()
		end
	elseif tabIndex == XiaoNuoAssistantModel.TabEnum.Shop then
		self._reqTabList[tabIndex][1] = true
		self._reqTabList[tabIndex][2] = true
		self._reqTabList[tabIndex][3] = true
	end
end

function XiaoNuoAssistantView:_isTabResReady(tabIndex)
	if tabIndex == XiaoNuoAssistantModel.TabEnum.Material then
		return self._reqTabList[tabIndex][1] and self._reqTabList[tabIndex][2] and self._reqTabList[tabIndex][3] and self._reqTabList[tabIndex][4] and self._reqTabList[tabIndex][5] and self._reqTabList[tabIndex][6]
	elseif tabIndex == XiaoNuoAssistantModel.TabEnum.Gameplay then
		return self._reqTabList[tabIndex][1] and self._reqTabList[tabIndex][2] and self._reqTabList[tabIndex][3] and self._reqTabList[tabIndex][4] and self._reqTabList[tabIndex][5] and self._reqTabList[tabIndex][6] and self._reqTabList[tabIndex][7] and self._reqTabList[tabIndex][8] and self._reqTabList[tabIndex][9] and self._reqTabList[tabIndex][10] and self._reqTabList[tabIndex][11] and self._reqTabList[tabIndex][12] and self._reqTabList[tabIndex][13] and self._reqTabList[tabIndex][14] and self._reqTabList[tabIndex][15]
	elseif tabIndex == XiaoNuoAssistantModel.TabEnum.Relaxation then
		return self._reqTabList[tabIndex][1] and self._reqTabList[tabIndex][2] and self._reqTabList[tabIndex][3] and self._reqTabList[tabIndex][4]
	elseif tabIndex == XiaoNuoAssistantModel.TabEnum.Shop then
		return self._reqTabList[tabIndex][1] and self._reqTabList[tabIndex][2] and self._reqTabList[tabIndex][3]
	end

	return false
end

function XiaoNuoAssistantView:_onClickClose()
	self:close()
end

function XiaoNuoAssistantView:_updateDetailInfoByRes()
	if self:_isTabResReady(self._curTabIndex) then
		printInfo("test 收到协议,更新详细信息", self._curTabIndex)

		local list = self._assistDataDic[self._curTabIndex]

		for i, data in ipairs(list) do
			data:init()
		end

		self:_updateDetailInfo(self._curTabIndex)
	end
end

function XiaoNuoAssistantView:_updateMainViewRes()
	printInfo("test 弹窗奖励后，重新获取协议，更新主界面勾选信息")

	self._reqTabList = XiaoNuoAssistantModel.instance:getInitReqList()

	self:_onClickTab(self._curTabIndex, true)
end

function XiaoNuoAssistantView:_onMoneyCatInfoRes(status, msg)
	if status == 0 then
		self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][1] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][1] or true

		self:_updateDetailInfoByRes()
	end
end

function XiaoNuoAssistantView:_onBasicBenefitsGetInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][2] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][2] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onGetMyPetDispatchInfoRes(status, msg)
	if status == 0 then
		self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][4] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][4] or true

		self:_updateDetailInfoByRes()
	end
end

function XiaoNuoAssistantView:_onGetVipInfoRes(status, msg)
	if status == 0 then
		self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][5] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Material][5] or true

		self:_updateDetailInfoByRes()
	end
end

function XiaoNuoAssistantView:_onInfiniteInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][1] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][1] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onMCLG_SimpleProgressInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][2] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][2] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onLegendChallengeTimesInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][3] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][3] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onGetWarriorTowerProfitInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][4] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][4] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onGetMyFamilyInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][5] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][5] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onGetDonatePoolInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][7] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][7] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onOpenArenaRes(status, msg)
	if status == 0 then
		self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][8] = true
	end

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onArena3v3InfoRes(status, msg)
	if status == 0 then
		self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][9] = true
	end

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onArena3v3FormationRes(status, msg)
	if status == 0 then
		self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][10] = true
	end

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onLingWenGetInfoRes(status, msg)
	if status == 0 then
		self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][11] = true
	end

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onCuteAdvGetInfoRes(status, msg)
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][13] = true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onSignInBuffGetInfo()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][15] = true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onFamilyTaskGetInfoRes(status)
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Gameplay][14] = true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onGetThronePanelOtherInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Relaxation][1] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Relaxation][1] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onPigRaiseAdventureStateUpdate()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Relaxation][2] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Relaxation][2] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onGFGetRaceBookInfoRes()
	self._reqTabList[XiaoNuoAssistantModel.TabEnum.Relaxation][4] = self._reqTabList[XiaoNuoAssistantModel.TabEnum.Relaxation][4] or true

	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onSendOrGainHeart()
	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onChangeDay()
	printInfo("test XiaoNuoAssistantView:_onChangeDay")
	self:_updateDetailInfoByRes()
end

function XiaoNuoAssistantView:_onCellClickBtn()
	return
end

function XiaoNuoAssistantView:_onBtnSelectAllClick()
	self:_setBtnAllIsOn(not self._btnSelectAllIsOn)
	self:_setCellsSelectAll(self._btnSelectAllIsOn)
	self:_updateDetailCellList(self._curTabIndex)
end

function XiaoNuoAssistantView:_onClickStart()
	if not self:_isTabResReady(self._curTabIndex) then
		FloatWordMgr.instance:show("小诺开了小差，请重新打开界面并尝试")

		return
	end

	local reportParams = {}
	local xiaoNuoSendMoList = {}
	local tabFuncList = XiaoNuoAssistantModel.TabList[self._curTabIndex]

	for funcId, v in pairs(self._assistDataList) do
		if TableUtil.isHad(tabFuncList, funcId) then
			local sendMo = v:getSendCallbackList()

			if sendMo and sendMo.callbackList then
				table.insert(xiaoNuoSendMoList, sendMo)

				if #sendMo.callbackList > 0 then
					table.insert(reportParams, v:getFuncIndex())
				end
			end
		end
	end

	if #xiaoNuoSendMoList > 0 then
		local key = "XiaoNuoAssistantViewTipKey"

		if not GameUtil.getUserDayData(key) then
			local diamondNum = XiaoNuoAssistCostModel.instance:getCoinNumByOpenItems(AssistCell16.Diamond)
			local godGemNum = XiaoNuoAssistCostModel.instance:getCoinNumByOpenItems(AssistCell16.GodGem)
			local isHasCoinCost = diamondNum > 0 or godGemNum > 0

			if isHasCoinCost then
				local function funcTog()
					GameUtil.saveUserDayData(key, true)
				end

				local function okFunc()
					UIStateManager.instance:push(ViewName.AssistantRewardView, xiaoNuoSendMoList, self._curTabIndex)

					if #reportParams > 0 then
						SurveyController.instance:reportBehavior(SurveyBehaviorID.XiaoNuoAssistant_1, unpack(reportParams))
					end
				end

				local str = ""

				if diamondNum > 0 then
					str = string.format("%d钻石", diamondNum)
				end

				if godGemNum > 0 then
					if not string.nilorempty(str) then
						str = str .. "、"
					end

					str = str .. string.format("%d神钻", godGemNum)
				end

				local text = string.format("本次执行小诺助手预计消耗%s，请确认消耗！已执行的操作无法进行回退。", str)

				TipsFacade.instance:openPopupWindowWithTog(lang("tip"), text, okFunc, nil, funcTog, btnText1, btnText2, togText, alignment)
			else
				UIStateManager.instance:push(ViewName.AssistantRewardView, xiaoNuoSendMoList, self._curTabIndex)

				if #reportParams > 0 then
					SurveyController.instance:reportBehavior(SurveyBehaviorID.XiaoNuoAssistant_1, unpack(reportParams))
				end
			end
		else
			UIStateManager.instance:push(ViewName.AssistantRewardView, xiaoNuoSendMoList, self._curTabIndex)

			if #reportParams > 0 then
				SurveyController.instance:reportBehavior(SurveyBehaviorID.XiaoNuoAssistant_1, unpack(reportParams))
			end
		end
	else
		FloatWordMgr.instance:show("请先点击开启，启用功能")
	end
end

function XiaoNuoAssistantView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "NuoAssistant_rule")
end

function XiaoNuoAssistantView:_onDragTableviewEnd(eventData)
	XiaoNuoAssistantController.instance:localNotify(XiaoNuoAssistantController.HideDropdown)
end

function XiaoNuoAssistantView:_updateTabCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local changeGroup = btn.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local tabIndex = data
	local cfg = XiaoNuoAssistantConfig.instance:getTabCfg(tabIndex)

	txtName.text = cfg.tabName

	btn:AddClickListener(function()
		self:_onClickTab(tabIndex)
	end)
	changeGroup:SetState(self._curTabIndex == tabIndex and 1 or 0)
end

function XiaoNuoAssistantView:_clearTabCell(cell)
	return
end

function XiaoNuoAssistantView:_getTagByData(data, idx)
	return data:getTag()
end

function XiaoNuoAssistantView:_updateCell(view, cell, data, tag)
	local assistCellCls = GameUtil.AddLuaOnce(cell.gameObject, XiaoNuoAssistantModel.PrefabClass[tag])

	assistCellCls:init(data)
end

function XiaoNuoAssistantView:_clearCell(cell)
	local assistCellCls = GameUtil.GetLua(cell.gameObject, XiaoNuoAssistantModel.PrefabClass[cell.tag])

	if assistCellCls then
		assistCellCls:reset()
	end
end

function XiaoNuoAssistantView:_initTabList()
	self._tabList = {}

	for tabIndex, v in ipairs(XiaoNuoAssistantModel.TabList) do
		if tabIndex ~= XiaoNuoAssistantModel.TabEnum.Competition then
			table.insert(self._tabList, tabIndex)
		end
	end

	self.tabScrollList:reloadData(self._tabList)
end

function XiaoNuoAssistantView:_onClickTab(tabIndex, isForce)
	if not isForce and self._curTabIndex == tabIndex then
		return
	end

	self._curTabIndex = tabIndex

	XiaoNuoAssistCostModel.instance:initData(tabIndex)
	self.tabScrollList:reloadData(self._tabList)

	local count = #XiaoNuoAssistantModel.DataTypeList[self._curTabIndex]

	if count == 0 then
		self:_updateDetailInfo(self._curTabIndex)
	else
		self:_sendReq(self._curTabIndex)
		self:_updateDetailInfoByRes()
	end
end

function XiaoNuoAssistantView:_updateDetailInfo(tabIndex)
	local cfg = XiaoNuoAssistantConfig.instance:getTabCfg(tabIndex)

	self._txtSubTitle.text = cfg.tabName

	self:_updateDetailCellList(tabIndex)
	self:_updateBtnSelectAll()
end

function XiaoNuoAssistantView:_initAssistDataDic()
	local maxTabIndex = XiaoNuoAssistantModel.MaxTabCount

	for tabIndex = 1, maxTabIndex do
		local list = {}

		for i, funcIndexList in ipairs(XiaoNuoAssistantModel.TabList) do
			if i == tabIndex then
				list = funcIndexList
			end
		end

		local assistList = {}

		for i, funcIndex in ipairs(list) do
			local cls = XiaoNuoAssistantModel.DataClass[funcIndex].New(funcIndex)

			table.insert(assistList, cls)

			self._assistDataList[funcIndex] = cls
		end

		self._assistDataDic[tabIndex] = assistList
	end
end

function XiaoNuoAssistantView:_updateDetailCellList(tabIndex)
	self.scrollList:reloadData(self._assistDataDic[tabIndex])
end

function XiaoNuoAssistantView:_setBtnAllIsOn(isOn)
	goutil.setActive(self._markBtnSelectAll, isOn)

	self._btnSelectAllIsOn = isOn
end

function XiaoNuoAssistantView:_updateBtnSelectAll()
	self:_setBtnAllIsOn(false)
end

function XiaoNuoAssistantView:_setCellsSelectAll(isOn)
	local assistList = self._assistDataDic[self._curTabIndex]

	if #assistList == 0 then
		return
	end

	for i, v in ipairs(assistList) do
		v:setSelectAll(isOn)
	end
end

return XiaoNuoAssistantView

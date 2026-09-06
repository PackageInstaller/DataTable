-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKChampionshipView.lua

module("logic.extensions.teenchampionking.view.TCKChampionshipView", package.seeall)

local TCKChampionshipView = class("TCKChampionshipView", ViewComponent)

function TCKChampionshipView:ctor()
	TCKChampionshipView.super.ctor(self)
end

function TCKChampionshipView:unbindEvents()
	TCKChampionshipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function TCKChampionshipView:bindEvents()
	TCKChampionshipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function TCKChampionshipView:buildUI()
	TCKChampionshipView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self:_getFrameId())

	local commonTab = self._tabFrameWorkShow:getCommonTab()

	commonTab:setPreClickCallBack(GameUtil.handler(self._onClickPre, self))

	self._btnTip = self:getGo("leftTop/btnTip")
end

function TCKChampionshipView:onExit()
	TCKChampionshipView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)
end

function TCKChampionshipView:onEnter()
	TCKChampionshipView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	GlobalDispatcher:addListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
	self._tabFrameWorkShow:jumpTab()
	self:_updateUIByCfg()
end

function TCKChampionshipView:_onClickPre(tabData)
	local data = tabData.data

	if not (tabData.leaf == 0 and self._tabFrameWorkShow:_isUnlockAsHeadTab(data.headTabId) or self._tabFrameWorkShow:_isUnlockAsSecTab(data.headTabId, data.secTabId)) then
		local tips = self._tabFrameWorkShow:_getHeadTabLockTips(data)

		FloatWordMgr.instance:show(tips)

		return true
	elseif data.headTabId ~= 1 then
		local inRoomUserIds = TeenChampionKingModel.instance:getInRoomUserIds() or {}

		if table.keyof(inRoomUserIds, checknumber(RoleModel.instance:getUserId())) then
			TipsFacade.instance:openPopupWindow("提示", "是否真的取消准备并离开？", function()
				if tabData.leaf == 0 then
					self._tabFrameWorkShow:jumpTab(data.headTabId, 1)
				else
					self._tabFrameWorkShow:jumpTab(data.headTabId, data.secTabId)
				end
			end)

			return true
		end
	end
end

function TCKChampionshipView:_onStepChange()
	GlobalDispatcher:addListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)
	TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
end

function TCKChampionshipView:_updateUIByCfg()
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)

	local btn_list = {
		{
			showAdd = true,
			id = self._actCfg.guessItem
		},
		{
			showAdd = true,
			id = self._actCfg.exchangeItem
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function TCKChampionshipView:_handleGetInfo()
	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, (globalInfo or nil) and globalInfo.curStepId)
	local myKnockoutInfo = TeenChampionKingModel.instance:getMyKnockoutInfo(self._activityId)

	if not myKnockoutInfo or not myKnockoutInfo.knockoutInfo then
		self._tabFrameWorkShow:jumpTab(2, 1)
		GlobalDispatcher:removeListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)

		return
	end

	local myInfo = myKnockoutInfo.knockoutInfo
	local battleRoundId = checknumber(myInfo and myInfo.roundId)
	local addRoundId = TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN - 1

	if (battleRoundId > 0 or nil) and battleRoundId < curRoundId then
		if curRoundId >= TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN and curRoundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
			self._tabFrameWorkShow:jumpTab(2, curRoundId - addRoundId)
		else
			self._tabFrameWorkShow:jumpTab(2, TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX - addRoundId)
		end
	else
		self._tabFrameWorkShow:jumpTab(1, 0)
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)
end

function TCKChampionshipView:_getFrameId()
	return 20
end

function TCKChampionshipView:_onClickBtnTip()
	local key = self._actCfg.ruleKey4

	TipsFacade.instance:openRulesView(key)
end

function TCKChampionshipView:_onClickClose()
	local inRoomUserIds = TeenChampionKingModel.instance:getInRoomUserIds() or {}
	local inRoom = table.keyof(inRoomUserIds, checknumber(RoleModel.instance:getUserId()))

	if inRoom then
		TipsFacade.instance:openPopupWindow("提示", "是否真的取消准备并离开？", function()
			self:close()
		end)
	else
		self:close()
	end
end

return TCKChampionshipView

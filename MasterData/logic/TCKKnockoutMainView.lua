-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKKnockoutMainView.lua

module("logic.extensions.teenchampionking.view.TCKKnockoutMainView", package.seeall)

local TCKKnockoutMainView = class("TCKKnockoutMainView", ViewComponent)

function TCKKnockoutMainView:ctor()
	TCKKnockoutMainView.super.ctor(self)
end

function TCKKnockoutMainView:unbindEvents()
	TCKKnockoutMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function TCKKnockoutMainView:bindEvents()
	TCKKnockoutMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function TCKKnockoutMainView:buildUI()
	TCKKnockoutMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._tablist = self:getGo("tablist")
	self._contentCol = self:getGo("contentCol")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tabFrameWorkShow = TabFrameWorkShow.create(self, self._contentCol, self._tablist, self:_getFrameId())

	local commonTab = self._tabFrameWorkShow:getCommonTab()

	commonTab:setPreClickCallBack(GameUtil.handler(self._onClickPre, self))
end

function TCKKnockoutMainView:onExit()
	TCKKnockoutMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)
end

function TCKKnockoutMainView:onEnter()
	TCKKnockoutMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	GlobalDispatcher:addListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)
	TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
	self._tabFrameWorkShow:jumpTab(1)
	self:_updateUIByCfg()
end

function TCKKnockoutMainView:_onClickPre(tabData)
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

function TCKKnockoutMainView:_updateUIByCfg()
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

function TCKKnockoutMainView:_handleGetInfo()
	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, (globalInfo or nil) and globalInfo.curStepId)
	local myKnockoutInfo = TeenChampionKingModel.instance:getMyKnockoutInfo(self._activityId)
	local myInfo = myKnockoutInfo.knockoutInfo
	local battleRoundId = checknumber(myInfo and myInfo.roundId)

	if (battleRoundId > 0 or nil) and battleRoundId < curRoundId then
		if curRoundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and curRoundId <= TeenChampionKingController.ROUND_KNOCKOUT_MAX then
			self._tabFrameWorkShow:jumpTab(2, 1)
		elseif curRoundId >= TeenChampionKingController.ROUND_QUARTERFINALS then
			self._tabFrameWorkShow:jumpTab(2, 2)
		else
			self._tabFrameWorkShow:jumpTab(2, 1)
		end
	else
		self._tabFrameWorkShow:jumpTab(1, 0)
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetInfo, self)
end

function TCKKnockoutMainView:_getFrameId()
	return 19
end

function TCKKnockoutMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey3

	TipsFacade.instance:openRulesView(key)
end

function TCKKnockoutMainView:_onClickClose()
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

return TCKKnockoutMainView

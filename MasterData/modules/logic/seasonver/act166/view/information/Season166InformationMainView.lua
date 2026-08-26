-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationMainView.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationMainView", package.seeall)

local Season166InformationMainView = class("Season166InformationMainView", BaseView)

function Season166InformationMainView:onInitView()
	self.reportItems = {}
	self.btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Reward/#btn_Reward")
	self.txtRewardNum = gohelper.findChildTextMesh(self.viewGO, "Reward/#txt_RewardNum")
	self.slider = gohelper.findChildImage(self.viewGO, "Reward/#go_Slider")
	self.gorewardReddot = gohelper.findChild(self.viewGO, "Reward/#go_rewardReddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166InformationMainView:addEvents()
	self.addClickCb(self, self.btnReward, self.onClickReward, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnInformationUpdate, self.onInformationUpdate, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, self.onAnalyInfoSuccess, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnGetInfoBonus, self.onGetInfoBonus, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.OnGetInformationBonus, self.onGetInformationBonus, self)
	self.addEventCb(self, Season166Controller.instance, Season166Event.ClickInfoReportItem, self.setLocalUnlockState, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onViewClose, self)
end

function Season166InformationMainView:removeEvents()
	return
end

function Season166InformationMainView:_editableInitView()
	self.localUnlockStateTab = self:getUserDataTb_()
end

function Season166InformationMainView:onClickReward()
	ViewMgr.instance:openView(ViewName.Season166InformationRewardView, {
		actId = self.actId
	})
end

function Season166InformationMainView:onUpdateParam()
	return
end

function Season166InformationMainView:onAnalyInfoSuccess()
	self:refreshUI()
end

function Season166InformationMainView:onGetInfoBonus()
	self:refreshUI()
end

function Season166InformationMainView:onInformationUpdate()
	self:refreshUI()
end

function Season166InformationMainView:onGetInformationBonus()
	self:refreshUI()
end

function Season166InformationMainView:onOpen()
	self.actId = self.viewParam.actId

	self:refreshUI()
	RedDotController.instance:addRedDot(self.gorewardReddot, RedDotEnum.DotNode.Season166InfoBigReward)
end

function Season166InformationMainView:refreshUI()
	if not self.actId then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.Season166InformationAnalyView) then
		return
	end

	self:refreshReport()

	local actInfo = Season166Model.instance:getActInfo(self.actId)
	local hasGetBonusCount, bonusCount = actInfo:getBonusNum()

	self.txtRewardNum.text = string.format("<color=#de9754>%s</color>/%s", hasGetBonusCount, bonusCount)
	self.slider.fillAmount = hasGetBonusCount / bonusCount

	self:refreshItemUnlockState()
end

function Season166InformationMainView:refreshReport()
	local list = Season166Config.instance:getSeasonInfos(self.actId) or {}

	for i = 1, math.max(#list, #self.reportItems) do
		local item = self.reportItems[i]

		if not item then
			local itemGO = gohelper.findChild(self.viewGO, string.format("Report%s", i))

			if itemGO then
				item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, Season166InformationReportItem)
				self.reportItems[i] = item
			end
		end

		if item then
			item:refreshUI(list[i])
		end
	end
end

function Season166InformationMainView:refreshItemUnlockState()
	local saveUnlockStateTab = Season166Model.instance:getLocalUnlockState(Season166Enum.InforMainLocalSaveKey)
	local unlockTab = Season166Model.instance:getLocalPrefsTab(Season166Enum.ReportUnlockAnimLocalSaveKey)
	local finishTab = Season166Model.instance:getLocalPrefsTab(Season166Enum.ReportFinishAnimLocalSaveKey)

	for index, reportItem in pairs(self.reportItems) do
		if GameUtil.getTabLen(saveUnlockStateTab) == 0 then
			reportItem:refreshUnlockState(false)

			self.localUnlockStateTab[index] = Season166Enum.LockState
		else
			local saveUnlockState = saveUnlockStateTab[index]

			reportItem:refreshUnlockState(saveUnlockState)

			self.localUnlockStateTab[index] = saveUnlockState
		end

		reportItem:refreshUnlockAnimState(unlockTab)
		reportItem:refreshFinishAnimState(finishTab)
	end

	self:saveUnlockState()
end

function Season166InformationMainView:saveUnlockState()
	local saveStrTab = {}

	for index, unlockState in ipairs(self.localUnlockStateTab) do
		local saveStr = string.format("%s|%s", index, unlockState)

		table.insert(saveStrTab, saveStr)
	end

	local saveDataStr = cjson.encode(saveStrTab)

	Season166Controller.instance:savePlayerPrefs(Season166Enum.InforMainLocalSaveKey, saveDataStr)
end

function Season166InformationMainView:setLocalUnlockState(param)
	local infoId = param.infoId

	self.localUnlockStateTab[infoId] = param.unlockState

	self:saveUnlockState()
end

function Season166InformationMainView:_onViewClose(viewName)
	if viewName == ViewName.Season166InformationAnalyView then
		self:refreshUI()
	end
end

function Season166InformationMainView:onClose()
	self:saveUnlockState()
end

function Season166InformationMainView:onDestroyView()
	return
end

return Season166InformationMainView

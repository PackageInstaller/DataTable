-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgnormalstageView.lua

module("logic.extensions.originchenclg.view.OriginchenclgnormalstageView", package.seeall)

local OriginchenclgnormalstageView = class("OriginchenclgnormalstageView", ViewComponent)

function OriginchenclgnormalstageView:ctor()
	OriginchenclgnormalstageView.super.ctor(self)
end

function OriginchenclgnormalstageView:unbindEvents()
	OriginchenclgnormalstageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginchenclgnormalstageView:bindEvents()
	OriginchenclgnormalstageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function OriginchenclgnormalstageView:buildUI()
	OriginchenclgnormalstageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/txtTitle/btnTip")
	self._txtRuleDesc = self:getTxt("rule/scrView/Viewport/Content")
	self._stageViewGo = self:getGo("stageCol/stageView")
	self._stageCellGo = self:getGo("stageCol/stageCell")
	self._itemGroup = ItemGroup.New(self._stageViewGo, self._stageCellGo, nil, nil, true, self._clearGroupItem, self)

	local prizeScrViewGo = self:getGo("rule/prize/scrView")
	local prizeScrCellGo = self:getGo("rule/prize/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrViewGo, prizeScrCellGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function OriginchenclgnormalstageView:onExit()
	OriginchenclgnormalstageView.super.onExit(self)
	self._itemGroup:dispose()
	self._prizeScrollerList:dispose()
end

function OriginchenclgnormalstageView:onEnter()
	OriginchenclgnormalstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginChenClgGetInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_Notify_OriginChenClgChallengeNormalResultRes, self._updateUI, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = OriginChenClgController.instance:getActivityId()
	end

	self._actCfg = OriginChenClgConfig.instance:getActivityCfg(self._activityId)

	if self._actCfg then
		self._txtRuleDesc.text = self._actCfg.norRuleDesc or ""
	end

	if not OriginChenClgModel.instance:getInfo(self._activityId) then
		OriginChenClgAgent.instance:sendPM_OriginChenClgGetInfoReq(self._activityId)
	end

	self:_updateUI()
end

function OriginchenclgnormalstageView:_onClickBtnTip()
	local challengeCfg = OriginChenClgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginchenclgnormalstageView:_updateUI()
	local stageCfgs = OriginChenClgConfig.instance:getNorStageCfgs(self._activityId)

	if not stageCfgs or #stageCfgs == 0 then
		return
	end

	self:_initPassedStageIdMap()
	self:_updatePrizeList(stageCfgs)
	self._itemGroup:updateWithMoArray(stageCfgs, self._updateStageCell, self)
end

function OriginchenclgnormalstageView:_updatePrizeList(stageCfgs)
	local prizeList = {}

	self._isAllPass = true

	for _, stageCfg in ipairs(stageCfgs) do
		if not string.nilorempty(stageCfg.prize) then
			table.insert(prizeList, stageCfg.prize)
		end

		if not self._passedStageIdMap[stageCfg.stageId] then
			self._isAllPass = false
		end
	end

	local mergedPrizeList = MaterialMgr.combineItemsToList(prizeList)

	self._prizeScrollerList:reloadData(mergedPrizeList)
end

function OriginchenclgnormalstageView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local tagHasGainGo = goutil.findChild(mainGo, "tagHasGain")

	MaterialMgr.resetAll(itemGo)
	MaterialMgr.setCellByCfg(prizeStr, itemGo)
	GameUtil.SetActive(tagHasGainGo, self._isAllPass)
end

function OriginchenclgnormalstageView:_clearPrizeCell(cell)
	local itemGo = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginchenclgnormalstageView:_updateStageCell(item, stageCfg)
	local goTagFinish = goutil.findChild(item.mainGO, "tagFinish")
	local tagBuffChange = goutil.findChildComponent(item.mainGO, "tagBuff", "UIImageSpriteChange")
	local isPass = self._passedStageIdMap[stageCfg.stageId]

	GameUtil.SetActive(goTagFinish, isPass)

	local tagBuff = checknumber(stageCfg.tagBuff)

	if tagBuff > 0 and tagBuffChange then
		tagBuffChange:SetState(tagBuff - 1)
	end

	GameUtil.rmClickHandler(item.mainGO)
	GameUtil.addClickHandler(item.mainGO, GameUtil.handler(self._onClickStageCell, self, stageCfg, isPass))
end

function OriginchenclgnormalstageView:_clearGroupItem(item)
	GameUtil.rmClickHandler(item.mainGO)
end

function OriginchenclgnormalstageView:_onClickStageCell(stageCfg, isPass)
	if isPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local fmtMo = OriginChenClgModel.instance:getNorFmtMo()

	fmtMo:initParams(self._activityId, stageCfg.stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginchenclgnormalstageView:_initPassedStageIdMap()
	self._passedStageIdMap = {}

	local info = OriginChenClgModel.instance:getInfo(self._activityId)

	if info then
		if not info.passedNormalStageIds then
			local passedNormalStageIds = {}

			for _, stageId in ipairs(passedNormalStageIds) do
				self._passedStageIdMap[stageId] = true
			end
		end
	end
end

return OriginchenclgnormalstageView

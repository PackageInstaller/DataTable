-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremestageView.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremestageView", package.seeall)

local OriginchenclgextremestageView = class("OriginchenclgextremestageView", ViewComponent)

function OriginchenclgextremestageView:ctor()
	OriginchenclgextremestageView.super.ctor(self)
end

function OriginchenclgextremestageView:unbindEvents()
	OriginchenclgextremestageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._btnReset:RemoveClickListener()
end

function OriginchenclgextremestageView:bindEvents()
	OriginchenclgextremestageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
end

function OriginchenclgextremestageView:buildUI()
	OriginchenclgextremestageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/txtTitle/btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._txtRuleDesc = self:getTxt("rule/scrView/Viewport/Content")
	self._stageViewGo = self:getGo("stageCol/stageView")
	self._stageCellGo = self:getGo("stageCol/stageCell")
	self._itemGroup = ItemGroup.New(self._stageViewGo, self._stageCellGo, nil, nil, true, self._clearGroupItem, self)

	local prizeScrViewGo = self:getGo("rule/prize/scrView")
	local prizeScrCellGo = self:getGo("rule/prize/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrViewGo, prizeScrCellGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function OriginchenclgextremestageView:onExit()
	OriginchenclgextremestageView.super.onExit(self)
	removetimer(self._delayUpdateUI, self)
	self._itemGroup:dispose()
	self._prizeScrollerList:dispose()
end

function OriginchenclgextremestageView:onEnter()
	OriginchenclgextremestageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginChenClgResetExtremeRes, self._onHandlePM_OriginChenClgResetExtremeRes, self)
	self.addGEvent(self, GlobalNotify.handlePM_OriginChenClgConfirmExtremeRes, self._onHandlePM_OriginChenClgConfirmExtremeRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginChenClgGetInfoRes, self._updateUI, self)

	self._activityId = checknumber(self:getFirstParam())
	self._actCfg = OriginChenClgConfig.instance:getActivityCfg(self._activityId)

	if self._actCfg then
		self._txtRuleDesc.text = self._actCfg.extRuleDesc or ""
	end

	self:_updateUI()
	OriginChenClgController.instance:checkConfirmCI()
end

function OriginchenclgextremestageView:_onClickBtnTip()
	local challengeCfg = OriginChenClgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginchenclgextremestageView:_onClickbtnReset()
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否重置所有关卡?"), function()
		OriginChenClgAgent.instance:sendPM_OriginChenClgResetExtremeReq(self._activityId)
	end)
end

function OriginchenclgextremestageView:_onHandlePM_OriginChenClgResetExtremeRes()
	self:_updateUI()
end

function OriginchenclgextremestageView:_onHandlePM_OriginChenClgConfirmExtremeRes(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	removetimer(self._delayUpdateUI, self)
	settimer(0, self._delayUpdateUI, self, false)
end

function OriginchenclgextremestageView:_delayUpdateUI()
	self:_updateUI()
end

function OriginchenclgextremestageView:_updateUI()
	local stageCfgs = OriginChenClgConfig.instance:getExtremeStageCfgs(self._activityId)

	if not stageCfgs or #stageCfgs == 0 then
		return
	end

	self:_initExtStageInfoMap()
	self:_initCanClgStageId()
	self:_updatePrizeList()
	self._itemGroup:updateWithMoArray(stageCfgs, self._updateStageCell, self)
end

function OriginchenclgextremestageView:_updateStageCell(item, stageCfg)
	local goTagCanClg = goutil.findChild(item.mainGO, "tagCanClg")
	local goTagOrigin = goutil.findChild(item.mainGO, "tagOrigin")
	local goTagEnd = goutil.findChild(item.mainGO, "tagEnd")
	local goTagBuff = goutil.findChild(item.mainGO, "tagBuff")
	local tagBuffChange = goutil.findChildComponent(item.mainGO, "tagBuff", "UIImageSpriteChange")
	local stageInfo = self._extStageInfoMap[stageCfg.stageId]
	local isCanClg = self._canClgStageIdMap[stageCfg.stageId]

	GameUtil.SetActive(goTagOrigin, stageCfg.stageId == 1)
	GameUtil.SetActive(goTagEnd, stageCfg.stageId == 9)
	GameUtil.SetActive(goTagCanClg, isCanClg)

	local suit = stageInfo and checknumber(stageInfo.suit) or 0

	GameUtil.SetActive(goTagBuff, suit > 0)

	if suit > 0 and tagBuffChange then
		tagBuffChange:SetState(suit - 1)
	end

	GameUtil.rmClickHandler(item.mainGO)
	GameUtil.addClickHandler(item.mainGO, GameUtil.handler(self._onClickStageCell, self, stageCfg, isCanClg))
end

function OriginchenclgextremestageView:_clearGroupItem(item)
	GameUtil.rmClickHandler(item.mainGO)
end

function OriginchenclgextremestageView:_onClickStageCell(stageCfg, isCanClg)
	if self._extStageInfoMap[stageCfg.stageId] then
		local stageInfo = self._extStageInfoMap[stageCfg.stageId]

		UIStateManager.instance:push(ViewName.OriginchenclgextremestagereplayresultView, self._activityId, stageCfg.stageId, stageInfo)

		return
	end

	if not isCanClg then
		if self._extStageInfoMap[9] then
			if not self:_isAllFinish() then
				FloatWordMgr.instance:show("未达成通关要求，请重置后再试")
			end

			return
		end

		FloatWordMgr.instance:show("仅可选择相邻格子进行挑战")

		return
	end

	local fmtMo = OriginChenClgModel.instance:getExtFmtMo()

	fmtMo:initParams(self._activityId, stageCfg.stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function OriginchenclgextremestageView:_updatePrizeList()
	local info = OriginChenClgModel.instance:getInfo(self._activityId)

	self._isGainExtremePrize = info and checkbool(info.gainExtremePrize) or false

	local prizeList = self._actCfg and MaterialMgr.changeItemStrArr(self._actCfg.extremePrize) or {}

	self._prizeScrollerList:reloadData(prizeList)
end

function OriginchenclgextremestageView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local tagHasGainGo = goutil.findChild(mainGo, "tagHasGain")

	MaterialMgr.resetAll(itemGo)
	MaterialMgr.setCellByCfg(prizeStr, itemGo)
	GameUtil.SetActive(tagHasGainGo, self._isGainExtremePrize)
end

function OriginchenclgextremestageView:_clearPrizeCell(cell)
	local itemGo = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginchenclgextremestageView:_initExtStageInfoMap()
	self._extStageInfoMap = {}

	local info = OriginChenClgModel.instance:getInfo(self._activityId)

	if info then
		if not info.extremeStageInfos then
			local extremeStageInfos = {}

			for _, stageInfo in ipairs(extremeStageInfos) do
				self._extStageInfoMap[stageInfo.stageId] = stageInfo
			end
		end
	end
end

function OriginchenclgextremestageView:_initCanClgStageId()
	self._canClgStageIdMap = {}

	local info = OriginChenClgModel.instance:getInfo(self._activityId)

	if info then
		if not info.extremeStageInfos then
			local extremeStageInfos = {}
			local stageCfgs = OriginChenClgConfig.instance:getExtremeStageCfgs(self._activityId)
			local lastStageId = 0

			if stageCfgs then
				for _, stageCfg in pairs(stageCfgs) do
					if lastStageId < stageCfg.stageId then
						lastStageId = stageCfg.stageId
					end
				end
			end

			if lastStageId > 0 and self._extStageInfoMap[lastStageId] then
				return
			end

			local refStageId = 1

			if #extremeStageInfos > 0 then
				local maxPassIndex = -1

				for _, stageInfo in ipairs(extremeStageInfos) do
					if maxPassIndex < stageInfo.passIndex then
						maxPassIndex = stageInfo.passIndex
						refStageId = stageInfo.stageId
					end
				end
			end

			for _, neighborId in ipairs(self:_getNeighborStageIds(refStageId)) do
				if neighborId ~= 1 and not self._extStageInfoMap[neighborId] then
					self._canClgStageIdMap[neighborId] = true
				end
			end
		end
	end
end

function OriginchenclgextremestageView:_getNeighborStageIds(stageId)
	local row = math.ceil(stageId / 3)
	local col = (stageId - 1) % 3 + 1
	local directions = {
		{
			-1,
			0
		},
		{
			1,
			0
		},
		{
			0,
			-1
		},
		{
			0,
			1
		}
	}
	local neighbors = {}

	for _, dir in ipairs(directions) do
		local r = row + dir[1]
		local c = col + dir[2]

		if r >= 1 and r <= 3 and c >= 1 and c <= 3 then
			table.insert(neighbors, (r - 1) * 3 + c)
		end
	end

	return neighbors
end

function OriginchenclgextremestageView:_isAllFinish()
	if not self._extStageInfoMap[9] then
		return false
	end

	local visited = {}
	local queue = {
		1
	}
	local head = 1

	visited[1] = true

	while head <= #queue do
		local stageId = queue[head]

		head = head + 1

		if stageId == 9 then
			return true
		end

		local curStageInfo = self._extStageInfoMap[stageId]
		local curSuit = curStageInfo and checknumber(curStageInfo.suit) or 0

		for _, neighborId in ipairs(self:_getNeighborStageIds(stageId)) do
			local neighborStageInfo = self._extStageInfoMap[neighborId]
			local neighborSuit = neighborStageInfo and checknumber(neighborStageInfo.suit) or 0

			if not visited[neighborId] and neighborStageInfo and neighborSuit > 0 and (stageId == 1 or curSuit ~= neighborSuit) then
				visited[neighborId] = true

				table.insert(queue, neighborId)
			end
		end
	end

	return false
end

return OriginchenclgextremestageView

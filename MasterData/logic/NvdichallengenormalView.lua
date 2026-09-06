-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdichallengenormalView.lua

module("logic.extensions.nvdi.view.NvdichallengenormalView", package.seeall)

local NvdichallengenormalView = class("NvdichallengenormalView", ViewComponent)

function NvdichallengenormalView:ctor()
	NvdichallengenormalView.super.ctor(self)
end

function NvdichallengenormalView:unbindEvents()
	NvdichallengenormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function NvdichallengenormalView:bindEvents()
	NvdichallengenormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function NvdichallengenormalView:buildUI()
	NvdichallengenormalView.super.buildUI(self)

	self._txtDesc = self:getTxt("desc/txt")
	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._tableviewTop = self:getGo("tableview")
	self._tabelcell = self:getGo("tabelcell")
	self._topScrollList = ScrollerList.create(self._tableviewTop, self._tabelcell, GameUtil.handler(self._updateTopCell, self), GameUtil.handler(self.clearTopCell, self))
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")
	self._txtProgress = self:getTxt("progress/total/txtProgress")
	self._tableview = self:getGo("progress/tableview")
	self._rewardCell = self:getGo("progress/rewardCell")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._cellList = {}

	for i = 1, 3 do
		local go = self:getGo("tabelcell_" .. i)

		table.insert(self._cellList, go)
	end
end

function NvdichallengenormalView:onExit()
	NvdichallengenormalView.super.onExit(self)
	self._scrollList:dispose()
	self._topScrollList:dispose()
end

function NvdichallengenormalView:onEnter()
	NvdichallengenormalView.super.onEnter(self)

	local actId = checknumber(self:getFirstParam())

	self._activityId = actId > 0 and actId or 342001
	self._actCfg = NvdiChallengeConfig.instance:getActivityCfgById(self._activityId) or {}

	self.addGEvent(self, GlobalNotify.NVDI_CHALLENGE_INFO_UPDATE, self._refreshUI, self)
	self:_refreshUI()
	NvdiChallengeController.instance:sendGetInfo(self._activityId)
end

function NvdichallengenormalView:_refreshUI()
	self._info = NvdiChallengeModel.instance:getInfo(self._activityId) or {}
	self._groupId = checknumber(self._info.normalClgTodayGroupId)
	self._txtDesc.text = NvdiChallengeConfig.instance:getCommonCfgById("empress_normal_rule")
	self._stageInfoMap = {}

	for i, v in ipairs(self._info.normalClgStageInfo or {}) do
		self._stageInfoMap[v.dataBitId] = v.bestScore
	end

	local progress = checknumber(self._info.normalClgProgress)

	self._curProgress = progress
	self._prizeGainedBitIdList = self._info.normalClgProgressPrizeGainedBitId or {}
	self._txtProgress.text = progress

	local progressCfgList = NvdiChallengeConfig.instance:getProgressCfgById(self._activityId) or {}
	local scoreArr = {}
	local lastCanGetidx = -1
	local lastIdx = 0

	for i, v in ipairs(progressCfgList) do
		table.insert(scoreArr, v.progress)

		local isCanGet = self._curProgress >= v.progress

		if isCanGet then
			lastIdx = i
		end

		if lastCanGetidx == -1 then
			local isGainPrize = table.indexof(self._prizeGainedBitIdList, v.dataBitId) ~= false

			if isCanGet and not isGainPrize then
				lastCanGetidx = i - 1
			end
		end
	end

	local idx = lastCanGetidx

	if lastCanGetidx == -1 then
		idx = lastIdx
	end

	self._scrollList:reloadData(progressCfgList)
	self._scrollList:updateUnderSlider(self._progressBar, progress, scoreArr)
	self._scrollList:MoveCellToCenter(Mathf.Clamp(idx, 0, #progressCfgList))

	local list = NvdiChallengeConfig.instance:getGroupCfgList(self._activityId, self._groupId) or {}

	for i, v in ipairs(self._cellList) do
		local data = list[i]

		GameUtil.SetActive(v, false)

		if data then
			GameUtil.SetActive(v, true)
			self._updateTopCell(self, self, v, list[i])
		end
	end
end

function NvdichallengenormalView:_onClickTips()
	TipsFacade.instance:openRulesView("nvdichallengenormalview_rule")
end

function NvdichallengenormalView:clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function NvdichallengenormalView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._curProgress >= data.progress
	local isGainPrize = table.indexof(self._prizeGainedBitIdList, data.dataBitId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.dataBitId), self)
end

function NvdichallengenormalView:_onClickGetPrize(id)
	NvdiChallengeController.instance:sendGetProgressPrize(self._activityId, id)
end

function NvdichallengenormalView:_updateTopCell(view, cell, data, tag)
	local btn = goutil.findChild(cell, "root")
	local pass = goutil.findChild(cell, "root/pass")
	local txt = goutil.findChildTextComponent(cell, "root/txt/txtValue")
	local img = goutil.findChild(cell, "root/imgRole/img")

	GameUtil.SetActive(pass, false)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	if modelCo then
		uGuiUtil.setSpriteToImage(img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	txt.text = checknumber(self._stageInfoMap[data.dataBitId])

	GameUtil.addClickHandler(btn, function()
		local maxProgress = 0
		local progressCfgList = NvdiChallengeConfig.instance:getProgressCfgById(self._activityId) or {}

		for i, v in ipairs(progressCfgList) do
			maxProgress = math.max(maxProgress, v.progress)
		end

		if maxProgress <= self._curProgress then
			TipsFacade.instance:openCommonTips("已经通关~")
		else
			NvdiChallengeController.instance:showNormalMissionview(self._activityId, self._groupId, data.dataBitId)
		end
	end)
end

function NvdichallengenormalView:clearTopCell(cell)
	local img = goutil.findChild(cell, "root/imgRole/img")

	uGuiUtil.clearImage(img.gameObject)
end

function NvdichallengenormalView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progress/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function NvdichallengenormalView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return NvdichallengenormalView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/view/OriginKingCiYuanDragonClgStageView.lua

module("logic.extensions.originkingciyuandragonclg.view.OriginKingCiYuanDragonClgStageView", package.seeall)

local OriginKingCiYuanDragonClgStageView = class("OriginKingCiYuanDragonClgStageView", ViewComponent)

function OriginKingCiYuanDragonClgStageView:buildUI()
	OriginKingCiYuanDragonClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._prizeItem = self:getGo("prize/item")
	self._txtPrizeDesc = self:getTxt("prize/txtDesc")
	self._tagHasGain = self:getGo("prize/tagHasGain")
	self._blockCells = {}
	self._blockCount = 3

	for blockId = 1, self._blockCount do
		local cellPath = "stageCol/stageCell" .. blockId
		local cell = {}

		cell._btnClg = goutil.findChild(self.mainGO, cellPath .. "/btnClg")
		cell._txtName = goutil.findChildTextComponent(self.mainGO, cellPath .. "/txtName")
		cell._txtProgress = goutil.findChildTextComponent(self.mainGO, cellPath .. "/txtProgress")
		cell._slider = goutil.findChild(self.mainGO, cellPath .. "/slider")
		cell._btnDesc = goutil.findChild(self.mainGO, cellPath .. "/btnDesc")
		cell._arrowUp = goutil.findChild(self.mainGO, cellPath .. "/btnDesc/arrowUp")
		cell._arrowDown = goutil.findChild(self.mainGO, cellPath .. "/btnDesc/arrowDown")
		cell._buffTips = goutil.findChild(self.mainGO, cellPath .. "/buffTips")
		cell._txtBuffTips = goutil.findChildTextComponent(self.mainGO, cellPath .. "/buffTips/scrView/Viewport/Content")

		GameUtil.SetActive(cell._buffTips, false)
		GameUtil.SetActive(cell._arrowUp, false)
		GameUtil.SetActive(cell._arrowDown, true)

		self._blockCells[blockId] = cell
	end

	self._btnReset = self:getGo("btnReset")
end

function OriginKingCiYuanDragonClgStageView:bindEvents()
	OriginKingCiYuanDragonClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function OriginKingCiYuanDragonClgStageView:unbindEvents()
	OriginKingCiYuanDragonClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
end

function OriginKingCiYuanDragonClgStageView:onEnter()
	OriginKingCiYuanDragonClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginKingCiYuanDragonClgController.instance:getSubMo(self._activityId)
	self._actData = OriginKingCiYuanDragonClgConfig.instance:getActivityData(self._activityId)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingCiYuanDragonClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingCiYuanDragonClgResetRes, self._onUpdate, self)

	local changeSetId = self._subMo:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	OriginKingCiYuanDragonClgController.instance:sendPM_OriginKingCiYuanDragonClgGetInfoReq(self._activityId)
end

function OriginKingCiYuanDragonClgStageView:onExit()
	OriginKingCiYuanDragonClgStageView.super.onExit(self)
	GameUtil.SetGray(self._btnReset, false)
	self:_onClearBlockColUI()
	MaterialMgr.resetAll(self._prizeItem)
end

function OriginKingCiYuanDragonClgStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function OriginKingCiYuanDragonClgStageView:_onUpdateData()
	return
end

function OriginKingCiYuanDragonClgStageView:_onUpdateUI()
	self:_onUpdateBlockColUI()
	GameUtil.SetGray(self._btnReset, not self:_isNeedReset())
	MaterialMgr.setCellByCfg(self._actData.passPrize, self._prizeItem)

	local isHasGain = self._subMo:hasGainFirstPassPrize()

	GameUtil.SetActive(self._tagHasGain, isHasGain)
end

function OriginKingCiYuanDragonClgStageView:_onUpdateBlockColUI()
	for i = 1, self._blockCount do
		self:_updateBlockCell(i)
	end
end

function OriginKingCiYuanDragonClgStageView:_onClearBlockColUI()
	for _, cell in pairs(self._blockCells) do
		GameUtil.rmClickHandler(cell._btnClg)
	end
end

function OriginKingCiYuanDragonClgStageView:_updateBlockCell(blockId)
	local cell = self._blockCells[blockId]
	local progress = self._subMo:getProgressInBlock(blockId)
	local passCount = self._subMo:getPassStageCount(blockId)
	local totalCount = self._subMo:getStageCount(blockId)
	local isBlockPass = self._subMo:isBlockPass(blockId)

	for idx = 1, cell._slider.transform.childCount do
		local child = cell._slider.transform:GetChild(idx - 1)
		local tagFill = goutil.findChild(child, "tagFill")

		GameUtil.SetActive(tagFill, idx <= passCount)
		GameUtil.SetActive(child, idx <= totalCount)
	end

	cell._txtProgress.text = string.format("修复进度：%d%%", progress * 100)

	local stageData = OriginKingCiYuanDragonClgConfig.instance:getStageDataByBlock(self._activityId, blockId, Mathf.Min(passCount + 1, totalCount))

	cell._txtName.text = stageData and stageData.name

	local desc = ""

	if not isBlockPass then
		local activeStageIds = {}

		for otherBlockId = 1, self._blockCount do
			if otherBlockId ~= blockId then
				local otherPassCount = self._subMo:getPassStageCount(otherBlockId)

				for otherBlockStageId = 1, otherPassCount do
					local otherStageData = OriginKingCiYuanDragonClgConfig.instance:getStageDataByBlock(self._activityId, otherBlockId, otherBlockStageId)
					local stageId = otherStageData.stageId

					table.insert(activeStageIds, stageId)
				end
			end
		end

		for i, id in ipairs(activeStageIds) do
			local stageData = OriginKingCiYuanDragonClgConfig.instance:getStageData(self._activityId, id)

			if stageData then
				desc = i < #activeStageIds and desc .. stageData.buffDesc .. "\n" or desc .. stageData.buffDesc
			end
		end
	end

	if string.nilorempty(desc) then
		desc = "【暂无】"
	end

	cell._txtBuffTips.text = desc

	if isBlockPass then
		GameUtil.SetActive(cell._buffTips, false)
	end

	GameUtil.SetActive(cell._btnDesc, not isBlockPass)
	GameUtil.addClickHandler(cell._btnClg, function()
		local stageId = self._subMo:getLatestUnpassStageId(blockId)
		local stageData = OriginKingCiYuanDragonClgConfig.instance:getStageData(self._activityId, stageId)

		if stageData == nil then
			return
		end

		if self._subMo:isStagePass(stageId) then
			FloatWordMgr.instance:show("已通关")

			return
		end

		OriginKingCiYuanDragonClgController.instance:enterStageChallenge(self._activityId, stageId)
	end)
	GameUtil.addClickHandler(cell._btnDesc, function()
		local isNeedVisible = not GameUtil.GetActive(cell._buffTips)

		GameUtil.SetActive(cell._arrowUp, isNeedVisible)
		GameUtil.SetActive(cell._arrowDown, not isNeedVisible)
		GameUtil.SetActive(cell._buffTips, isNeedVisible)
	end)
end

function OriginKingCiYuanDragonClgStageView:_onClickBtnTip()
	if self._actData and self._actData.ruleKeyMain then
		TipsFacade.instance:openRulesView(self._actData.ruleKeyMain)
	end
end

function OriginKingCiYuanDragonClgStageView:_onClickBtnReset()
	if not self:_isNeedReset() then
		FloatWordMgr.instance:show("无需重置")

		return
	end

	local function okFunc()
		OriginKingCiYuanDragonClgController.instance:sendPM_OriginKingCiYuanDragonClgResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", "是否重置所有关卡", okFunc, nil, "确定", "取消")
end

function OriginKingCiYuanDragonClgStageView:_isNeedReset()
	local isNeedReset = false

	for blockId = 1, self._blockCount do
		if self._subMo:getLatestPassStageId(blockId) > 0 then
			isNeedReset = true

			break
		end
	end

	return isNeedReset
end

return OriginKingCiYuanDragonClgStageView

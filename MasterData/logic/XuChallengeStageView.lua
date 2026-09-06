-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengeStageView.lua

module("logic.extensions.xuchallenge.view.XuChallengeStageView", package.seeall)

local XuChallengeStageView = class("XuChallengeStageView", ViewComponent)

function XuChallengeStageView:buildUI()
	XuChallengeStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnReset = self:getGo("btnReset")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._stageView = self:getGo("stageCol/stageView")
	self._stageCell = self:getGo("stageCol/stageCell")
	self._stageRecordPos = self._stageView:GetComponent(ComponentType.TestRecordPos)

	GameUtil.SetActive(self._stageCell, false)

	self._layerCol = self:getGo("layerCol")
	self._layerCells = {}

	for i = 1, 3 do
		table.insert(self._layerCells, {
			go = self:getGo(string.format("layerCol/cell%s", i)),
			item = self:getGo(string.format("layerCol/cell%s/item", i)),
			tagHasGain = self:getGo(string.format("layerCol/cell%s/tagHasGain", i))
		})
	end

	self._rule = self:getGo("rule")
	self._txtRule = self:getTxt("rule/txt")
	self._buffTips = self:getGo("buffTips")
	self._txtBuffTips = self:getTxt("buffTips/txt")
	self._sacrificePetScrollListDic = {}
end

function XuChallengeStageView:bindEvents()
	XuChallengeStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function XuChallengeStageView:unbindEvents()
	XuChallengeStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
end

function XuChallengeStageView:onEnter()
	XuChallengeStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = XuChallengeController.instance:getSubMo(self._activityId)
	self._actData = XuChallengeConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeNotifyClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeResetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeReplacePetRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
	XuChallengeController.instance:sendPM_XuChallengeInfoReq(self._activityId)
end

function XuChallengeStageView:onExit()
	XuChallengeStageView.super.onExit(self)
	self:_clearStageCol()
	self:_clearLayerCol()
end

function XuChallengeStageView:_onSetUI()
	self._txtRule.text = self._actData.ruletips
end

function XuChallengeStageView:_onUpdate()
	self._stageDataList = XuChallengeConfig.instance:getStageDatas(self._activityId)
	self._layerDataList = XuChallengeConfig.instance:getStageLayerDatas(self._activityId)
	self._isAllBound = self:_isAllStageBound(self._stageDataList)
	self._currentStageId = self._subMo:getCurrentChallengeStageId()

	self:_updateTips()
	self:_updateStageCol()
	self:_updateLayerCol()
end

function XuChallengeStageView:_isAllStageBound(dataList)
	if dataList == nil or #dataList <= 0 then
		return false
	end

	for _, data in ipairs(dataList) do
		if not self._subMo:isHasBindRaceId(data.stageId) then
			return false
		end
	end

	return true
end

function XuChallengeStageView:_updateTips()
	GameUtil.SetActive(self._rule, not self._isAllBound)

	local sacrificeCount = self._subMo:getTotalSacrificeRaceIdCount()
	local buffData = XuChallengeConfig.instance:getBuffDataBySacrificeNum(self._activityId, sacrificeCount)

	if buffData then
		if not buffData.desc then
			local desc = ""
			local isShowBuff = not string.nilorempty(desc)

			GameUtil.SetActive(self._buffTips, isShowBuff)

			if isShowBuff then
				self._txtBuffTips.text = desc
			end
		end
	end
end

function XuChallengeStageView:_updateLayerCol()
	local isShowLayerCol = self._layerDataList ~= nil and #self._layerDataList > 0

	GameUtil.SetActive(self._layerCol, isShowLayerCol)

	if not isShowLayerCol then
		self:_clearLayerCol()

		return
	end

	if #self._layerDataList > #self._layerCells and not self._isLayerOverflowWarned then
		self._isLayerOverflowWarned = true

		printError(string.format("xuchallengestageview 当前最多展示%s层奖励，但配置了%s层，activityId = %s", #self._layerCells, #self._layerDataList, self._activityId))
	end

	for idx, cell in ipairs(self._layerCells) do
		local layerData = self._layerDataList[idx]
		local isShowCell = layerData ~= nil

		GameUtil.SetActive(cell.go, isShowCell)
		MaterialMgr.resetAll(cell.item)

		if isShowCell then
			if not string.nilorempty(layerData.prize) then
				MaterialMgr.setCellByCfg(layerData.prize, cell.item)
			end

			GameUtil.SetActive(cell.tagHasGain, self._subMo:isAllStageEverPass(layerData.stageIds))
		end
	end
end

function XuChallengeStageView:_clearLayerCol()
	for _, cell in ipairs(self._layerCells or {}) do
		MaterialMgr.resetAll(cell.item)
	end
end

function XuChallengeStageView:_updateStageCol()
	GameUtil.updateCellsList(self._stageView, self._stageCell, self._stageDataList, self._updateStageCell, self)
	self._stageRecordPos:LoadPlan(0)
end

function XuChallengeStageView:_clearStageCol()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)

	self._sacrificePetScrollListDic = {}
end

function XuChallengeStageView:_updateStageCell(mainGo, data, tabIdx)
	local stageId = checknumber(data.stageId)
	local isBound = self._subMo:isHasBindRaceId(stageId)
	local isCurrent = stageId == self._currentStageId
	local isPass = stageId <= checknumber(self._subMo:getMaxPassStage())
	local raceId = self._subMo:getBindRaceId(stageId)
	local sacrificeRaceIds = self._subMo:getSacrificeRaceIds(stageId)
	local btn = goutil.findChild(mainGo, "btn")
	local normal = goutil.findChild(mainGo, "btn/normal")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/normal/txtName")
	local active = goutil.findChild(mainGo, "btn/active")
	local icon = goutil.findChild(mainGo, "btn/active/icon")
	local tagPass = goutil.findChild(mainGo, "btn/tagPass")
	local tagInput = goutil.findChild(mainGo, "tagInput")
	local tagCurrent = goutil.findChild(mainGo, "tagCurrent")
	local sacrificePet = goutil.findChild(mainGo, "sacrificePet")

	txtName.text = string.format("第%s关", tabIdx)

	GameUtil.SetActive(normal, not isBound)
	GameUtil.SetActive(active, isBound)
	GameUtil.SetActive(tagPass, isPass)
	GameUtil.SetActive(tagInput, not isBound)
	GameUtil.SetActive(tagCurrent, self._isAllBound and isCurrent)
	GameUtil.SetActive(sacrificePet, sacrificeRaceIds ~= nil and #sacrificeRaceIds > 0)
	MaterialMgr.clearIcon(icon)

	if isBound then
		MaterialMgr.setIcon(icon, MatType.Pet, raceId)
	end

	self:_updateSacrificePetCol(mainGo, sacrificeRaceIds)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickStageCell, self, stageId))
end

function XuChallengeStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")
	local icon = goutil.findChild(mainGo, "btn/active/icon")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.clearIcon(icon)
	self:_clearSacrificePetCol(mainGo)
end

function XuChallengeStageView:_updateSacrificePetCol(mainGo, raceIds)
	local scrView = goutil.findChild(mainGo, "sacrificePet/scrView")
	local scrCell = goutil.findChild(mainGo, "sacrificePet/scrCell")

	if scrView and scrCell then
		if not self._sacrificePetScrollListDic[mainGo] then
			local scrollList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateSacrificePetCell, self), GameUtil.handler(self._clearSacrificePetCell, self))

			self._sacrificePetScrollListDic[mainGo] = self._sacrificePetScrollListDic[mainGo]

			self._sacrificePetScrollListDic[mainGo]:reloadData(raceIds or {})
			self._sacrificePetScrollListDic[mainGo]:setCenterMode(true)
			self._sacrificePetScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function XuChallengeStageView:_clearSacrificePetCol(mainGo)
	local scrollList = self._sacrificePetScrollListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._sacrificePetScrollListDic[mainGo] = nil
	end
end

function XuChallengeStageView:_updateSacrificePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
	MaterialMgr.setIcon(icon, MatType.Pet, raceId)
end

function XuChallengeStageView:_clearSacrificePetCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
end

function XuChallengeStageView:_onClickStageCell(stageId)
	if not self._subMo:isHasBindRaceId(stageId) then
		UIStateManager.instance:push(ViewName.XuChallengePetBindView, self._activityId, stageId)

		return
	end

	if not self._isAllBound then
		FloatWordMgr.instance:show("请先写入全部关卡精灵")

		return
	end

	if stageId ~= self._currentStageId then
		FloatWordMgr.instance:show("当前关卡不可挑战")

		return
	end

	XuChallengeController.instance:enterBattle(self._activityId, stageId)
end

function XuChallengeStageView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	if not string.nilorempty(key) then
		TipsFacade.instance:openRulesView(key)
	end
end

function XuChallengeStageView:_onClickBtnReset()
	if not self:_canReset() then
		FloatWordMgr.instance:show("无需重置")

		return
	end

	local function okFunc()
		if self:_canReset() then
			XuChallengeController.instance:sendPM_XuChallengeResetReq(self._activityId)
		end
	end

	TipsFacade.instance:openPopupWindow("提示", "是否确认重置当前所有关卡？", okFunc, nil, "确定", "取消")
end

function XuChallengeStageView:_canReset()
	for _, data in ipairs(self._stageDataList or {}) do
		local stageId = checknumber(data.stageId)

		if self._subMo:isHasBindRaceId(stageId) then
			return true
		end

		local sacrificeRaceIds = self._subMo:getSacrificeRaceIds(stageId)

		if sacrificeRaceIds ~= nil and #sacrificeRaceIds > 0 then
			return true
		end
	end

	return false
end

return XuChallengeStageView

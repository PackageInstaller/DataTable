-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/view/DivineMiRuiKeClgLevelView.lua

module("logic.extensions.divinemiruikeclg.view.DivineMiRuiKeClgLevelView", package.seeall)

local DivineMiRuiKeClgLevelView = class("DivineMiRuiKeClgLevelView", ViewComponent)

function DivineMiRuiKeClgLevelView:buildUI()
	DivineMiRuiKeClgLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnBuff = self:getBtn("btnBuff")
	self._txtRule = self:getTxt("desc/txtRule")
	self._slider = self:getSlider("reward/slider")
	self._txtSlider = self:getTxt("reward/txtNum")
	self._rewardItem = self:getGo("reward/item")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.scrollerGo2 = self:getGo("tableview2")
	self.cellGo2 = self:getGo("tablecell2")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
	self._powerPetMo = FightingPowerPetMo.New()
end

function DivineMiRuiKeClgLevelView:bindEvents()
	DivineMiRuiKeClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function DivineMiRuiKeClgLevelView:unbindEvents()
	DivineMiRuiKeClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivineMiRuiKeClgLevelView:onEnter()
	DivineMiRuiKeClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineMiRuiKeClgGetInfoRes, self._onGetInfoRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = DivineMiRuiKeClgConfig.instance:getActivityCfg(self._activityId)

	self:_updateViews()
end

function DivineMiRuiKeClgLevelView:onExit()
	DivineMiRuiKeClgLevelView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollList2:dispose()
	MaterialMgr.resetAll(self._rewardItem)
end

function DivineMiRuiKeClgLevelView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivineMiRuiKeClgBuffView, self._activityId)
end

function DivineMiRuiKeClgLevelView:_onGetInfoRes()
	self:_updateViews()
end

function DivineMiRuiKeClgLevelView:_updateCell(view, cell, data, tag)
	local passGo = goutil.findChild(cell, "btn/pass")
	local lockGo = goutil.findChild(cell, "btn/lock")
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "btn/txtDesc")
	local uiChangeGroup = goutil.findChild(cell, "btn"):GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.name
	txtDesc.text = string.format("第%d层", data.phaseId)

	if self._isPass then
		goutil.setActive(passGo, self._isPass)
		goutil.setActive(lockGo, false)
		uiChangeGroup:SetState(0)
	else
		goutil.setActive(passGo, self._curPhaseId > data.phaseId)
		goutil.setActive(lockGo, self._curPhaseId < data.phaseId)
		uiChangeGroup:SetState(self._curPhaseId == data.phaseId and 1 or 0)
	end
end

function DivineMiRuiKeClgLevelView:_clearCell(cell)
	return
end

function DivineMiRuiKeClgLevelView:_updateCell2(view, cell, data, tag)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local fmtGo = goutil.findChild(cell, "btnChallenge/fmt")
	local passGo = goutil.findChild(cell, "btnChallenge/pass")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local arrow = goutil.findChild(cell, "arrow")

	goutil.setActive(arrow, cell.index + 1 < self._maxStageNum)

	local cfg = DivineMiRuiKeClgConfig.instance:getMonsterCfg(data.creepsMasterId)

	if cfg then
		txtName.text = cfg.name or ""
	end

	local isPass = false

	isPass = self._isPass and true or self._curPhaseId > data.phaseId or self._curStageId > data.stageId

	goutil.setActive(passGo, isPass)
	GameUtil.addClickHandler(btnChallenge, function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		if self._curStageId > data.stageId then
			FloatWordMgr.instance:show("已通过本关")

			return
		end

		if self._curStageId < data.stageId then
			FloatWordMgr.instance:show("请先通过上一关")

			return
		end

		DivineMiRuiKeClgController.instance:openMissionView(self._activityId, data.phaseId, data.stageId)
	end)

	local fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = goutil.findChild(cell, string.format("btnChallenge/fmt/cell_%d", i))
		item.con = goutil.findChild(cell, string.format("btnChallenge/fmt/cell_%d/con", i))
		item.tag = goutil.findChild(cell, string.format("btnChallenge/fmt/cell_%d/tag", i))

		table.insert(fmtList, item)
	end

	for i, v in ipairs(fmtList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.go, false)
		goutil.setActive(v.tag, false)
	end

	local cfgCreeps = DivineMiRuiKeClgConfig.instance:getCreeps(data.creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreeps) do
		local item = fmtList[cfgEnemy.posId]

		if item and item.go then
			goutil.setActive(item.go, true)
			GameUtil.setLocalScale(item.con, 0.7, 0.7, 0.7)
			self._powerPetMo:fromChallengeCreepCo(cfgEnemy)

			local bagPetMo = self._powerPetMo:toBaseBagPetMo()
			local proxy = MaterialMgr.setCellByMo(bagPetMo, item.con)

			proxy.binder:setAutoTips(false)
		end
	end
end

function DivineMiRuiKeClgLevelView:_clearCell2(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)

	for i = 1, 9 do
		local go = goutil.findChild(cell, string.format("fmt/cell_%d", i))
		local con = goutil.findChild(cell, string.format("fmt/cell_%d/con", i))
		local tag = goutil.findChild(cell, string.format("fmt/cell_%d/tag", i))

		MaterialMgr.resetAll(con)
		goutil.setActive(go, false)
		goutil.setActive(go, false)
	end
end

function DivineMiRuiKeClgLevelView:_updateViews()
	self:_updateData()
	self:_updateRules()
	self:_updateProgress()
	self:_updatePhaseList()
	self:_updateStageList()
end

function DivineMiRuiKeClgLevelView:_updateData()
	self._curPhaseId = DivineMiRuiKeClgModel.instance:getCurPhaseId(self._activityId)
	self._curStageId = DivineMiRuiKeClgModel.instance:getCurStageId(self._activityId)
	self._isPass = DivineMiRuiKeClgModel.instance:isPassAll(self._activityId)
	self._cfgPhaseList = DivineMiRuiKeClgConfig.instance:getPhaseCfgList(self._activityId)
	self._maxPhaseCount = #self._cfgPhaseList

	if self._isPass then
		self._showPhaseId = self._maxPhaseCount or self._curPhaseId
	end

	self._cfgShowPhase = DivineMiRuiKeClgConfig.instance:getPhaseCfg(self._activityId, self._showPhaseId)
	self._cfgStageList = DivineMiRuiKeClgConfig.instance:getStageCfgList(self._activityId, self._showPhaseId) or {}
	self._maxStageCount = #self._cfgStageList
end

function DivineMiRuiKeClgLevelView:_updateRules()
	self._txtRule.text = self._cfgShowPhase.ruleDesc
end

function DivineMiRuiKeClgLevelView:_updateProgress()
	self._slider.slider.maxValue = self._maxStageCount

	if self._isPass then
		self._slider:SetValue(self._maxStageCount)
	elseif self._curStageId > 0 then
		self._slider:SetValue(self._curStageId - 1)
	else
		self._slider:SetValue(0)
	end

	if self._isPass then
		if not self._maxStageCount then
			local stageCount = Mathf.Max(0, self._curStageId - 1)

			self._txtSlider.text = string.format("本关进度\n%d/%d", stageCount, self._maxStageCount)

			MaterialMgr.resetAll(self._rewardItem)
			MaterialMgr.setCellByCfg(self._cfgShowPhase.prize, self._rewardItem)
		end
	end
end

function DivineMiRuiKeClgLevelView:_updatePhaseList()
	self._scrollList:reloadData(self._cfgPhaseList)
end

function DivineMiRuiKeClgLevelView:_updateStageList()
	local cfgStageList = DivineMiRuiKeClgConfig.instance:getStageCfgList(self._activityId, self._showPhaseId) or {}

	self._maxStageNum = #cfgStageList

	self._scrollList2:reloadData(cfgStageList)
end

return DivineMiRuiKeClgLevelView

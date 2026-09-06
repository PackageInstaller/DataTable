-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgStageView.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgStageView", package.seeall)

local OriginGodDragonClgStageView = class("OriginGodDragonClgStageView", ViewComponent)
local StageState_Normal = 1
local StageState_Backing = 2

function OriginGodDragonClgStageView:buildUI()
	OriginGodDragonClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTips = self:getTxt("tips/txt")
	self._strTxtTips = self._txtTips.text
	self._txtTitle = self:getTxt("title/txt")
	self._btnBack = self:getGo("btnBack")
	self._btnSureBack = self:getGo("btnSureBack")
	self._btnCancleBack = self:getGo("btnCancleBack")
	self._btnLockPet = self:getGo("btns/btnLockPet")
	self._btnBuff = self:getGo("btns/btnBuff")
	self._norStageView = self:getGo("norStageView")
	self._norStageCellList = {}

	for idx = 1, self._norStageView.transform.childCount do
		local mainGo = self._norStageView.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._btn = goutil.findChild(mainGo, "btn")
		cell._iconBtn = goutil.findChild(mainGo, "btn/icon")
		cell._tagPass = goutil.findChild(mainGo, "btn/tagPass")
		cell._tagLock = goutil.findChild(mainGo, "btn/tagLock")
		cell._tagSelected = goutil.findChild(mainGo, "btn/tagSelected")
		cell._btnRebuild = goutil.findChild(mainGo, "btnRebuild")
		cell._tagBuilded = goutil.findChild(mainGo, "tagBuilded")
		cell._iconTagBuilded = goutil.findChild(mainGo, "tagBuilded/icon")
		cell._txtName = goutil.findChildTextComponent(mainGo, "name/txt")
		cell._strTxtName = cell._txtName.text
		self._norStageCellList[idx] = cell
	end

	self._extStageView = self:getGo("extStageView")
	self._extStageCellList = {}

	for idx = 1, self._extStageView.transform.childCount do
		local mainGo = self._extStageView.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._btn = goutil.findChild(mainGo, "btn")
		cell._iconBtn = goutil.findChild(mainGo, "btn/icon")
		cell._tagPass = goutil.findChild(mainGo, "btn/tagPass")
		cell._tagLock = goutil.findChild(mainGo, "btn/tagLock")
		cell._txtName = goutil.findChildTextComponent(mainGo, "name/txt")
		cell._strTxtName = cell._txtName.text
		self._extStageCellList[idx] = cell
	end
end

function OriginGodDragonClgStageView:bindEvents()
	OriginGodDragonClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBack, self._onClickBtnBack, self)
	GameUtil.addClickHandler(self._btnSureBack, self._onClickBtnSureBack, self)
	GameUtil.addClickHandler(self._btnCancleBack, self._onClickBtnCancleBack, self)
	GameUtil.addClickHandler(self._btnLockPet, self._onClickBtnLockPet, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function OriginGodDragonClgStageView:unbindEvents()
	OriginGodDragonClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBack)
	GameUtil.rmClickHandler(self._btnSureBack)
	GameUtil.rmClickHandler(self._btnCancleBack)
	GameUtil.rmClickHandler(self._btnLockPet)
	GameUtil.rmClickHandler(self._btnBuff)
end

function OriginGodDragonClgStageView:onEnter()
	OriginGodDragonClgStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._zoneId = checknumber(params[2])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)
	self._actData = OriginGodDragonClgConfig.instance:getActivityData(self._activityId)
	self._stageState = StageState_Normal
	self._backingStageId = 0

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonEffectBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonBacktrackRes, self._handlePM_OriginGodDragonBacktrackRes, self)
	OriginGodDragonClgController.instance:sendPM_OriginGodDragonClgInfoReq(self._activityId)

	local changeSetId = self._subMo:popChangeSetId()

	while changeSetId do
		MaterialController.instance:showChangeSetInTemp(changeSetId)

		changeSetId = self._subMo:popChangeSetId()
	end
end

function OriginGodDragonClgStageView:onExit()
	OriginGodDragonClgStageView.super.onExit(self)
	self:_onClearNorStageUI()
	self:_onClearExtStageUI()
end

function OriginGodDragonClgStageView:_handlePM_OriginGodDragonBacktrackRes()
	self._stageState = StageState_Normal
	self._backingStageId = 0

	OriginGodDragonClgController.instance:sendPM_OriginGodDragonClgInfoReq(self._activityId)
end

function OriginGodDragonClgStageView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function OriginGodDragonClgStageView:_onUpdateData()
	self._stageDataLists = {}

	for k, v in pairs(OriginGodDragonClgEnum.StageType) do
		self._stageDataLists[v] = {}
	end

	local stageDataLists = OriginGodDragonClgConfig.instance:getStageDataListByZone(self._activityId, self._zoneId) or {}

	for _, data in ipairs(stageDataLists) do
		local stageType = self._subMo:getStageType(data.stageId)

		table.insert(self._stageDataLists[stageType], data)
	end

	self._newestPassNorStageId = 0

	for _, data in ipairs(self._stageDataLists[OriginGodDragonClgEnum.StageType.Nor]) do
		local stageId = data.stageId

		if self._subMo:isPassStage(stageId) then
			self._newestPassNorStageId = stageId
		else
			break
		end
	end
end

function OriginGodDragonClgStageView:_onUpdateUI()
	local leftCircleNum = self._subMo:getLeftCircleNum(self._zoneId)
	local max = self._subMo:getMaxCircleNum(self._zoneId)
	local cur = self._subMo:getCurCircleNumInZone(self._zoneId)
	local color = cur <= max and "20b376" or "eb4624"

	self._txtTips.text = string.format(self._strTxtTips, string.format("<color=#%s>%s</color>", color, cur), max)

	self:_onUpdateBackingBtnUI()
	self:_onUpdateNorStageUI()
	self:_onUpdateExtStageUI()
end

function OriginGodDragonClgStageView:_onUpdateNorStageUI()
	local norStageDataList = self._stageDataLists[OriginGodDragonClgEnum.StageType.Nor]

	for idx, cell in ipairs(self._norStageCellList) do
		local data = norStageDataList[idx]

		if data then
			self:_updateNorStageCell(cell, data.stageId)
		else
			GameUtil.SetActive(cell._mainGo, false)
			self:_clearNorStageCell(cell)
		end
	end
end

function OriginGodDragonClgStageView:_onClearNorStageUI()
	for _, cell in ipairs(self._norStageCellList) do
		self:_clearNorStageCell(cell)
	end
end

function OriginGodDragonClgStageView:_updateNorStageCell(cell, stageId)
	local data = OriginGodDragonClgConfig.instance:getStageData(self._activityId, stageId)
	local isPass = self._subMo:isPassStage(stageId)
	local isUnlock = self._subMo:isUnlockStage(stageId)
	local isSelected = self._backingStageId > 0 and stageId >= self._backingStageId and isPass and self._stageState == StageState_Backing
	local isEffectBuff = self._subMo:isEffectBuff(stageId)

	GameUtil.SetActive(cell._mainGo, true)
	GameUtil.SetActive(cell._tagPass, isPass)
	GameUtil.SetActive(cell._tagLock, not isUnlock)
	GameUtil.SetActive(cell._tagSelected, isSelected)
	GameUtil.SetActive(cell._tagBuilded, isPass and isEffectBuff)
	GameUtil.SetActive(cell._btnRebuild, isPass and not isEffectBuff)

	cell._txtName.text = string.format(cell._strTxtName, stageId)

	MaterialMgr.setIcon(cell._iconBtn, MatType.Pet, data.skinId, nil, nil)
	GameUtil.addClickHandler(cell._btnRebuild, function()
		if not isPass then
			FloatWordMgr.instance:show("未通关")

			return
		end

		if isEffectBuff then
			FloatWordMgr.instance:show("已激活buff")

			return
		end

		UIStateManager.instance:push(ViewName.OriginGodDragonClgBuffView, self._activityId, stageId)
	end, self)
	GameUtil.addClickHandler(cell._btn, function()
		if self._stageState == StageState_Normal then
			if isPass then
				FloatWordMgr.instance:show("已通关")

				return
			end

			if not isUnlock then
				FloatWordMgr.instance:show("未解锁")

				return
			end

			if not OriginGodDragonClgController.instance:isInOpenTime(self._activityId) then
				FloatWordMgr.instance:show("未在开放时间内")

				return
			end

			OriginGodDragonClgController.instance:enterStageBattle(self._activityId, stageId)
		else
			if self._backingStageId == stageId then
				self._backingStageId = 0

				self:_onUpdateNorStageUI()

				return
			end

			if not isUnlock then
				FloatWordMgr.instance:show("未解锁")

				return
			end

			if not isPass then
				FloatWordMgr.instance:show("关卡未通关")

				return
			end

			self._backingStageId = stageId

			self:_onUpdateNorStageUI()
		end
	end, self)
end

function OriginGodDragonClgStageView:_clearNorStageCell(cell)
	MaterialMgr.clearIcon(cell._iconBtn)
	GameUtil.rmClickHandler(cell._btnRebuild)
	GameUtil.rmClickHandler(cell._btn)
end

function OriginGodDragonClgStageView:_onUpdateExtStageUI()
	local extStageDataList = self._stageDataLists[OriginGodDragonClgEnum.StageType.Ext]

	for idx, cell in ipairs(self._extStageCellList) do
		local data = extStageDataList[idx]

		if data then
			self:_updateExtStageCell(cell, data.stageId)
		end
	end
end

function OriginGodDragonClgStageView:_onClearExtStageUI()
	for _, cell in ipairs(self._extStageCellList) do
		self:_clearExtStageCell(cell)
	end
end

function OriginGodDragonClgStageView:_updateExtStageCell(cell, stageId)
	local data = OriginGodDragonClgConfig.instance:getStageData(self._activityId, stageId)
	local teamData = OriginGodDragonClgConfig.instance:getCreepsTeamData(data.creepsMasterId)
	local isPass = self._subMo:isPassStage(stageId)
	local isUnlock = self._subMo:isUnlockStage(stageId)
	local isPassZone = self._subMo:isPassZone(self._zoneId)

	GameUtil.SetActive(cell._mainGo, true)
	GameUtil.SetActive(cell._tagPass, isPass)
	GameUtil.SetActive(cell._tagLock, not isUnlock)

	cell._txtName.text = teamData.name

	MaterialMgr.setIcon(cell._iconBtn, MatType.Pet, data.skinId, nil, nil)
	GameUtil.addClickHandler(cell._btn, function()
		if isPassZone then
			FloatWordMgr.instance:show("已通关")

			return
		end

		if not isUnlock then
			FloatWordMgr.instance:show("未解锁")

			return
		end

		if not OriginGodDragonClgController.instance:isInOpenTime(self._activityId) then
			FloatWordMgr.instance:show("未在开放时间内")

			return
		end

		OriginGodDragonClgController.instance:enterStageBattle(self._activityId, stageId)
	end, self)
end

function OriginGodDragonClgStageView:_clearExtStageCell(cell)
	MaterialMgr.clearIcon(cell._iconBtn)
	GameUtil.rmClickHandler(cell._btn)
end

function OriginGodDragonClgStageView:_onUpdateBackingBtnUI()
	local isHavePassExtStage = false
	local extStageDataList = self._stageDataLists[OriginGodDragonClgEnum.StageType.Ext]

	for _, data in ipairs(extStageDataList) do
		if self._subMo:isPassStage(data.stageId) then
			isHavePassExtStage = true

			break
		end
	end

	local firstExtStageId = extStageDataList[1].stageId
	local isHaveUnlockExtStage = self._subMo:isUnlockStage(firstExtStageId)

	self._txtTitle.text = "请通关前置关卡"

	local isNeedBack = self:_isNeedBack()

	if isNeedBack then
		GameUtil.SetActive(self._btnBack, self._stageState == StageState_Normal)
		GameUtil.SetActive(self._btnSureBack, self._stageState == StageState_Backing)
		GameUtil.SetActive(self._btnCancleBack, self._stageState == StageState_Backing)

		if self._stageState == StageState_Backing then
			self._txtTitle.text = "请选择要回溯的关卡"
		end
	else
		GameUtil.SetActive(self._btnBack, false)
		GameUtil.SetActive(self._btnSureBack, false)
		GameUtil.SetActive(self._btnCancleBack, false)
	end
end

function OriginGodDragonClgStageView:_onClickBtnBack()
	self._stageState = StageState_Backing
	self._backingStageId = 0

	self:_onUpdateBackingBtnUI()
	self:_onUpdateNorStageUI()
end

function OriginGodDragonClgStageView:_onClickBtnCancleBack()
	self._stageState = StageState_Normal
	self._backingStageId = 0

	self:_onUpdateBackingBtnUI()
	self:_onUpdateNorStageUI()
end

function OriginGodDragonClgStageView:_onClickBtnSureBack()
	if self._stageState == StageState_Normal then
		return
	end

	if self._backingStageId <= 0 then
		self:_onClickBtnCancleBack()

		return
	end

	local isPassZone = self._subMo:isPassZone(self._zoneId)

	if isPassZone then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local isHavePassExtStage = false
	local extStageDataList = self._stageDataLists[OriginGodDragonClgEnum.StageType.Ext]

	for _, data in ipairs(extStageDataList) do
		if self._subMo:isPassStage(data.stageId) then
			isHavePassExtStage = true

			break
		end
	end

	if isHavePassExtStage then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local isNeedBack = self:_isNeedBack()

	if not isNeedBack then
		FloatWordMgr.instance:show("无需回溯")

		return
	end

	local stageNameList = {}
	local norStageDataList = self._stageDataLists[OriginGodDragonClgEnum.StageType.Nor]
	local startIndex, endIndex = 0, 0

	for index, data in ipairs(norStageDataList) do
		if data.stageId == self._backingStageId then
			startIndex = index
		end

		if data.stageId <= self._newestPassNorStageId then
			endIndex = index
		end
	end

	for idx = startIndex, endIndex do
		table.insert(stageNameList, idx)
	end

	local backingStageId = self._backingStageId + 1

	if startIndex == endIndex or startIndex == 1 then
		backingStageId = self._backingStageId
	end

	local tipsContent = string.format("此次回溯将会回退第%s关的通关状态及所用回合数，是否确认回溯？", table.concat(stageNameList, ","))

	local function okFunc()
		OriginGodDragonClgController.instance:sendPM_OriginGodDragonBacktrackReq(self._activityId, self._zoneId, backingStageId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function OriginGodDragonClgStageView:_onClickBtnLockPet()
	UIStateManager.instance:push(ViewName.OriginGodDragonClgBanPetView, self._activityId)
end

function OriginGodDragonClgStageView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.OriginGodDragonClgBuffView, self._activityId)
end

function OriginGodDragonClgStageView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginGodDragonClgStageView:_isNeedBack()
	local extStageDataList = self._stageDataLists[OriginGodDragonClgEnum.StageType.Ext]
	local firstExtStageId = extStageDataList[1].stageId
	local isHaveUnlockExtStage = self._subMo:isUnlockStage(firstExtStageId)
	local maxCircleNum = self._subMo:getMaxCircleNum(self._zoneId)
	local circleNum = self._subMo:getCurCircleNumInZone(self._zoneId)

	return maxCircleNum <= circleNum and not isHaveUnlockExtStage
end

return OriginGodDragonClgStageView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleGoldFloorView.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleGoldFloorView", package.seeall)

local HolyDragonTempleGoldFloorView = class("HolyDragonTempleGoldFloorView", ViewComponent)
local _DefaultFloorId = 2

function HolyDragonTempleGoldFloorView:buildUI()
	HolyDragonTempleGoldFloorView.super.buildUI(self)

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._txtName = self:getTxt("infoCol/txtName")
	self._ruleDescScrollRect = self:getGo("infoCol/ruleDesc"):GetComponent(ComponentType.ScrollRect)
	self._txtRuleDesc = self:getTxt("infoCol/ruleDesc/Viewport/Content")
	self._txtTarget = self:getTxt("infoCol/txtTarget")
	self._fmtView = self:getGo("infoCol/fmt/fmtView")
	self._imgPass = self:getGo("infoCol/fmt/imgPass")

	local prizeScrView = self:getGo("infoCol/prize/scrView")
	local prizeScrCell = self:getGo("infoCol/prize/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeScrollerList:setCenterMode(true)

	self._btnClg = self:getGo("infoCol/btnClg")
	self._fmtCells = {}

	for i = 1, self._fmtView.transform.childCount do
		local go = self._fmtView.transform:GetChild(i - 1).gameObject

		self._fmtCells[i] = {
			go = go,
			mask = goutil.findChild(go, "mask"),
			icon = goutil.findChild(go, "mask/icon")
		}
	end
end

function HolyDragonTempleGoldFloorView:bindEvents()
	HolyDragonTempleGoldFloorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function HolyDragonTempleGoldFloorView:unbindEvents()
	HolyDragonTempleGoldFloorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClg)
end

function HolyDragonTempleGoldFloorView:onEnter()
	HolyDragonTempleGoldFloorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._floorId = checknumber(params[2])

	if self._floorId <= 0 then
		self._floorId = _DefaultFloorId
	end

	self._subMo = HolyDragonTempleController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleNotifyChallengeRes, self._onChallengeUpdate, self)
	self:_onUpdate()
end

function HolyDragonTempleGoldFloorView:onExit()
	HolyDragonTempleGoldFloorView.super.onExit(self)
	self._stageScrollerList:dispose()
	self._prizeScrollerList:dispose()
	self:_clearFmt()
end

function HolyDragonTempleGoldFloorView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyDragonTempleGoldFloorView:_onChallengeUpdate(msg)
	if msg and checknumber(msg.floorId) ~= self._floorId then
		return
	end

	self:_onUpdate()
end

function HolyDragonTempleGoldFloorView:_onUpdateData()
	self._floorData = HolyDragonTempleConfig.instance:getFloorData(self._activityId, self._floorId)
	self._isFloorOpen = self._floorData and GameUtil.checkIsInTimePeriod(self._floorData.openTime, self._floorData.endTime) or false
	self._stageDataList = {}

	local stageDatas = HolyDragonTempleConfig.instance:getStageDatas(self._activityId, self._floorId)

	for stageId, stageData in pairs(stageDatas or {}) do
		local data = {}

		data.stageId = stageId
		data.stageData = stageData

		table.insert(self._stageDataList, data)
	end

	table.sort(self._stageDataList, function(a, b)
		return a.stageId < b.stageId
	end)

	for i, data in ipairs(self._stageDataList) do
		data.index = i
		data.isPassed = self._subMo:isStagePassed(self._floorId, data.stageId)
		data.isPrePassed = i == 1 or self._subMo:isStagePassed(self._floorId, self._stageDataList[i - 1].stageId)
		data.isLocked = not self._isFloorOpen or not data.isPrePassed
		data.isChallengeable = self._isFloorOpen and data.isPrePassed and not data.isPassed
	end

	if not self:_hasStageData(self._curStageId) then
		self._curStageId = self:_getDefaultStageId()
	end
end

function HolyDragonTempleGoldFloorView:_onUpdateUI()
	self:_onUpdateStageColUI()
	self:_onUpdateInfoColUI()
end

function HolyDragonTempleGoldFloorView:_onUpdateStageColUI()
	self._stageScrollerList:reloadData(self._stageDataList)

	local index = self:_getCurStageIndex()

	if index > 0 then
		self._stageScrollerList:MoveCellToCenter(index - 1)
	end
end

function HolyDragonTempleGoldFloorView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local pos = data.index % 2 == 1 and goutil.findChild(go, "pos1") or goutil.findChild(go, "pos2")

	if btn and pos then
		local targetPos = GameUtil.getLocalPos(pos)

		GameUtil.setLocalPos(btn, targetPos.x, targetPos.y, 0)
	end

	if btn == nil then
		return
	end

	local txtName = goutil.findChildTextComponent(btn, "txtName")
	local tagPass = goutil.findChild(btn, "tagPass")
	local tagLock = goutil.findChild(btn, "tagLock")
	local tagSelect = goutil.findChild(btn, "tagSelect")
	local isSelected = self._curStageId == data.stageId

	txtName.text = langPara("第%s关", data.index)

	GameUtil.SetActive(tagPass, data.isPassed)
	GameUtil.SetActive(tagLock, data.isLocked and not data.isPassed)
	GameUtil.SetActive(tagSelect, isSelected)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		if self._curStageId == data.stageId then
			return
		end

		self._curStageId = data.stageId

		self._stageScrollerList:refresh()
		self:_onUpdateInfoColUI()
	end)
end

function HolyDragonTempleGoldFloorView:_clearStageCell(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function HolyDragonTempleGoldFloorView:_onUpdateInfoColUI()
	local data = self:_getCurStageData()

	if data == nil then
		self._txtName.text = ""
		self._txtTarget.text = ""
		self._txtRuleDesc.text = ""
		self._ruleDescScrollRect.verticalNormalizedPosition = 1

		self:_clearFmt()
		self:_updatePrizeList(nil, false)
		GameUtil.SetActive(self._imgPass, false)
		GameUtil.SetGray(self._btnClg, true)

		return
	end

	local stageData = data.stageData

	self._txtName.text = langPara("第%s关", data.index)
	self._txtTarget.text = stageData.targetDesc
	self._txtRuleDesc.text = stageData.ruleDesc
	self._ruleDescScrollRect.verticalNormalizedPosition = 1

	self:_setFmt(stageData.creepsMasterId)
	self:_updatePrizeList(stageData.prize, data.isPassed)
	GameUtil.SetActive(self._imgPass, data.isPassed)
	GameUtil.SetGray(self._btnClg, not data.isChallengeable)
end

function HolyDragonTempleGoldFloorView:_setFmt(creepsMasterId)
	self:_clearFmt()

	local creepsDatas = HolyDragonTempleConfig.instance:getCreepsDatas(creepsMasterId)

	for _, creepsData in pairs(creepsDatas or {}) do
		local posId = checknumber(creepsData.posId)
		local cell = self._fmtCells[posId]

		if cell then
			local proxy = MaterialMgr.setCell(MatType.Pet, creepsData.raceId, cell.icon)

			if proxy then
				proxy.binder:setAutoTips(false)

				local tmpMo = FightingPowerPetMo.createPetByLevel(creepsData.raceId, 1, 1, 0)

				proxy.binder:setClickCallBack(function()
					CommonTipsMgr.instance:showPetTips(tmpMo, true)
				end)
			end

			GameUtil.SetActive(cell.mask, true)
		end
	end
end

function HolyDragonTempleGoldFloorView:_clearFmt()
	for _, cell in ipairs(self._fmtCells or {}) do
		MaterialMgr.resetAll(cell.icon)
		GameUtil.SetActive(cell.go, true)
		GameUtil.SetActive(cell.mask, false)
	end
end

function HolyDragonTempleGoldFloorView:_updatePrizeList(prize, isGained)
	local prizeList = {}

	for _, prizeStr in ipairs(MaterialMgr.changeItemStrArr(prize or "")) do
		table.insert(prizeList, {
			prizeStr = prizeStr,
			isGained = isGained
		})
	end

	self._prizeScrollerList:reloadData(prizeList)
end

function HolyDragonTempleGoldFloorView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local tagHasGain = goutil.findChild(go, "tagHasGain")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prizeStr, item)
	GameUtil.SetActive(tagHasGain, data.isGained)
end

function HolyDragonTempleGoldFloorView:_clearPrizeCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local tagHasGain = goutil.findChild(go, "tagHasGain")

	MaterialMgr.resetAll(item)
	GameUtil.SetActive(tagHasGain, false)
end

function HolyDragonTempleGoldFloorView:_hasStageData(stageId)
	for _, data in ipairs(self._stageDataList or {}) do
		if data.stageId == stageId then
			return true
		end
	end

	return false
end

function HolyDragonTempleGoldFloorView:_getDefaultStageId()
	for _, data in ipairs(self._stageDataList or {}) do
		if data.isChallengeable then
			return data.stageId
		end
	end

	if self._stageDataList then
		return (self._stageDataList or nil) and (self._stageDataList.stageId or 0)
	end
end

function HolyDragonTempleGoldFloorView:_getCurStageData()
	for _, data in ipairs(self._stageDataList or {}) do
		if data.stageId == self._curStageId then
			return data
		end
	end

	return nil
end

function HolyDragonTempleGoldFloorView:_getCurStageIndex()
	for i, data in ipairs(self._stageDataList or {}) do
		if data.stageId == self._curStageId then
			return i
		end
	end

	return 0
end

function HolyDragonTempleGoldFloorView:_onClickBtnClg()
	local data = self:_getCurStageData()

	if data == nil then
		return
	end

	if data.isPassed then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	if not self._isFloorOpen then
		FloatWordMgr.instance:show(lang("未开启"))

		return
	end

	if not data.isPrePassed then
		FloatWordMgr.instance:show(lang("请先通关上一关卡"))

		return
	end

	HolyDragonTempleController.instance:showGoldMissionView(self._activityId, self._floorId, self._curStageId)
end

return HolyDragonTempleGoldFloorView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/view/HolyDragonTempleLightFloorView.lua

module("logic.extensions.holydragontemple.view.HolyDragonTempleLightFloorView", package.seeall)

local HolyDragonTempleLightFloorView = class("HolyDragonTempleLightFloorView", ViewComponent)

function HolyDragonTempleLightFloorView:buildUI()
	HolyDragonTempleLightFloorView.super.buildUI(self)

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._con = self:getGo("con")
	self._btnClg = self:getGo("btnClg")
	self._imgPass = self:getGo("btnClg/imgPass")
	self._txtRuleTips = self:getTxt("ruleTips/txt")
	self._rewardBubble = self:getGo("bubble")
	self._rewardItem = self:getGo("bubble/item")
	self._tagHasGain = self:getGo("bubble/tagHasGain")
end

function HolyDragonTempleLightFloorView:bindEvents()
	HolyDragonTempleLightFloorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function HolyDragonTempleLightFloorView:unbindEvents()
	HolyDragonTempleLightFloorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClg)
end

function HolyDragonTempleLightFloorView:onEnter()
	HolyDragonTempleLightFloorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._floorId = checknumber(params[2])
	self._subMo = HolyDragonTempleController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_HolyDragonTempleNotifyChallengeRes, self._onChallengeUpdate, self)
	self:_onUpdate()
end

function HolyDragonTempleLightFloorView:onExit()
	HolyDragonTempleLightFloorView.super.onExit(self)
	self._stageScrollerList:dispose()
	self:_clearReward()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function HolyDragonTempleLightFloorView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function HolyDragonTempleLightFloorView:_onChallengeUpdate(msg)
	if msg and checknumber(msg.floorId) ~= self._floorId then
		return
	end

	self:_onUpdate()
end

function HolyDragonTempleLightFloorView:_onUpdateData()
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

function HolyDragonTempleLightFloorView:_onUpdateUI()
	self:_onUpdateStageColUI()
	self:_onUpdateInfoUI()
	self:_updateRoleShow()
end

function HolyDragonTempleLightFloorView:_onUpdateStageColUI()
	self._stageScrollerList:reloadData(self._stageDataList)

	local index = self:_getCurStageIndex()

	if index > 0 then
		self._stageScrollerList:MoveCellToCenter(index - 1)
	end
end

function HolyDragonTempleLightFloorView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local tagSelect = goutil.findChild(go, "tagSelect")
	local tagPass = goutil.findChild(go, "tagPass")
	local skinId = checknumber((data.stageData or nil) and data.stageData.skinId)

	MaterialMgr.clearIcon(icon)

	if skinId > 0 then
		MaterialMgr.setIcon(icon, MatType.Pet, skinId)
	end

	GameUtil.SetActive(tagSelect, self._curStageId == data.stageId)
	GameUtil.SetActive(tagPass, data.isPassed)
	GameUtil.setUIGroupIdx(go, self:_getStageCellGroupIdx(data))
	GameUtil.addClickHandler(go, function()
		self._curStageId = data.stageId

		self:_onUpdateUI()
	end)
end

function HolyDragonTempleLightFloorView:_clearStageCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local tagPass = goutil.findChild(go, "tagPass")

	MaterialMgr.clearIcon(icon)
	GameUtil.SetActive(tagPass, false)
	GameUtil.rmClickHandler(cell.gameObject)
end

function HolyDragonTempleLightFloorView:_updateRoleShow()
	local skinId = self:_getCurStageSkinId()

	if skinId <= 0 then
		self._loader = RoleObjectPool.instance:removeRole(self._loader)

		return
	end

	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId) or {}

	if not modelCfg[3] then
		local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

		self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, modelCfg[3], nil, true, x, y)
	end
end

function HolyDragonTempleLightFloorView:_getCurStageSkinId()
	local data = self:_getCurStageData()
	local var_16_0

	if data then
		::label_16_0::

		var_16_0 = data.stageData and data.stageData.skinId
	end

	return checknumber(var_16_0)
end

function HolyDragonTempleLightFloorView:_onUpdateInfoUI()
	local data = self:_getCurStageData()

	if data == nil then
		self._txtRuleTips.text = ""

		GameUtil.SetActive(self._imgPass, false)
		GameUtil.setUIGroupIdx(self._btnClg, 0)
		self:_clearReward()

		return
	end

	self._txtRuleTips.text = data.stageData.ruleDesc or ""

	self:_updateReward(data.stageData.prize, data.isPassed)
	GameUtil.SetActive(self._imgPass, data.isPassed)
	GameUtil.setUIGroupIdx(self._btnClg, data.isChallengeable and 1 or 0)
end

function HolyDragonTempleLightFloorView:_updateReward(prize, isGained)
	self:_clearReward()

	local prizeList = MaterialMgr.changeItemStrArr(prize or "")

	if prizeList then
		if not prizeList[1] then
			local prizeStr

			if prizeStr == nil then
				GameUtil.SetActive(self._rewardBubble, false)

				return
			end

			MaterialMgr.setCellByCfg(prizeStr, self._rewardItem)
			GameUtil.SetActive(self._rewardBubble, true)
			GameUtil.SetActive(self._tagHasGain, isGained)
		end
	end
end

function HolyDragonTempleLightFloorView:_clearReward()
	if self._rewardItem then
		MaterialMgr.resetAll(self._rewardItem)
	end

	GameUtil.SetActive(self._rewardBubble, false)
	GameUtil.SetActive(self._tagHasGain, false)
end

function HolyDragonTempleLightFloorView:_hasStageData(stageId)
	for _, data in ipairs(self._stageDataList or {}) do
		if data.stageId == stageId then
			return true
		end
	end

	return false
end

function HolyDragonTempleLightFloorView:_getDefaultStageId()
	for _, data in ipairs(self._stageDataList or {}) do
		if data.isChallengeable then
			return data.stageId
		end
	end

	if self._stageDataList then
		return (self._stageDataList or nil) and (self._stageDataList.stageId or 0)
	end
end

function HolyDragonTempleLightFloorView:_getCurStageData()
	for _, data in ipairs(self._stageDataList or {}) do
		if data.stageId == self._curStageId then
			return data
		end
	end

	return nil
end

function HolyDragonTempleLightFloorView:_getCurStageIndex()
	for i, data in ipairs(self._stageDataList or {}) do
		if data.stageId == self._curStageId then
			return i
		end
	end

	return 0
end

function HolyDragonTempleLightFloorView:_getStageCellGroupIdx(data)
	if data.isPassed then
		return 2
	end

	if data.isLocked then
		return 0
	end

	return self._curStageId == data.stageId and 1 or 0
end

function HolyDragonTempleLightFloorView:_onClickBtnClg()
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

	HolyDragonTempleController.instance:showLightMissionView(self._activityId, self._floorId, self._curStageId)
end

return HolyDragonTempleLightFloorView

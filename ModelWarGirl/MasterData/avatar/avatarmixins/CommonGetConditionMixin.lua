-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\CommonGetConditionMixin.lua

local ResTower = require("ClientData/ResTower")
local ResGamePlayNotice = require("ClientData/ResGamePlayNotice")
local CommonGetConditionMixin = {}
local ConditionOutput = {
	willUnlock = false,
	locked = false,
	tNum = 0,
	num = 1,
	closed = false
}

function CommonGetConditionMixin:initCommonGetConditionMixin(baseData, syncData)
	return
end

function CommonGetConditionMixin:getIsConditionAllPass(conditionOutput)
	return not conditionOutput.locked and not conditionOutput.closed and conditionOutput.num > 0 and not conditionOutput.invaildNotice and not conditionOutput.invaildFunc and not conditionOutput.willUnlock
end

local STEP_TOWER_NOT_PASS = 104

function CommonGetConditionMixin:getStepTowerCondition(args)
	local layer = args[1]
	local level = args[2]
	local ConditionOutputCopy = utils.deepcopy(ConditionOutput)

	if self:checkStepTowerCanSweep(layer, level) == false then
		ConditionOutputCopy.invaildFunc = self.confirmToStepTower
	end

	local curLayer = self.stepTowerData.curPos.layer
	local curLevel = self.stepTowerData.curPos.stage

	if self:checkStepTowerCanSweep(layer, level) == false and layer == curLayer and level == curLevel then
		ConditionOutputCopy.willUnlock = true
	end

	ConditionOutputCopy.locked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_STEP_TOWER)

	if not ConditionOutputCopy.locked and not ConditionOutputCopy.invaildNotice then
		local passCount = self.stepTowerLayerData[layer].stage[level] ~= nil and self.stepTowerLayerData[layer].stage[level].num or 0

		ConditionOutputCopy.num = ResTower[layer][level].times - passCount
		ConditionOutputCopy.tNum = ResTower[layer][level].times
	end

	return ConditionOutputCopy
end

function CommonGetConditionMixin.confirmToStepTower(conditions)
	local function yesFunc()
		local itemTips = UIManager.getUI("itemTips", nil, false)

		if itemTips then
			itemTips:setVisible(false)
		end

		local stepTowerDlg = UIManager.getUI("stepTowerDlg", true)

		if stepTowerDlg then
			stepTowerDlg:jumpToCurStage(true)
		end
	end

	local msgContent = ""

	if conditions.willUnlock then
		msgContent = string.format(Lang.get(1830), ResGamePlayNotice[Const.GAME_PLAY_NOTICE_TOWER].name)
	else
		msgContent = string.format(Lang.get(1831), ResGamePlayNotice[Const.GAME_PLAY_NOTICE_TOWER].name)
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
end

local EQUIP_TOWER_NOT_PASS = 104

function CommonGetConditionMixin:getEquipTowerCondition(args)
	local equipTowerType = args[1]
	local layer = args[2]
	local ConditionOutputCopy = utils.deepcopy(ConditionOutput)

	if self:equipTowerisPass(equipTowerType, layer) == false then
		ConditionOutputCopy.equipTowerType = equipTowerType
		ConditionOutputCopy.layer = self.equipTowerData[equipTowerType] and self.equipTowerData[equipTowerType].layer + 1 or 1
		ConditionOutputCopy.invaildFunc = self.confirmToEquipTower
	end

	if self:equipTowerisPass(equipTowerType, layer) == false and self.equipTowerData[equipTowerType] and self.equipTowerData[equipTowerType].layer == layer then
		ConditionOutputCopy.willUnlock = true
	end

	ConditionOutputCopy.locked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_EQUIP_TOWER)

	return ConditionOutputCopy
end

function CommonGetConditionMixin.confirmToEquipTower(conditions)
	local function yesFunc()
		local itemTips = UIManager.getUI("itemTips", nil, false)

		if itemTips then
			itemTips:setVisible(false)
		end

		local equipTowerLevelDlg = UIManager.getUI("equipTowerLevelDlg", true)

		if equipTowerLevelDlg then
			equipTowerLevelDlg:showTowerLayer(conditions.equipTowerType, conditions.layer)
		end
	end

	local msgContent = ""

	if conditions.willUnlock then
		msgContent = string.format(Lang.get(1830), ResGamePlayNotice[Const.GAME_PLAY_NOTICE_EQUIP_TOWER].name)
	else
		msgContent = string.format(Lang.get(1831), ResGamePlayNotice[Const.GAME_PLAY_NOTICE_EQUIP_TOWER].name)
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
end

function CommonGetConditionMixin:getActivityCondition(args)
	local actId = args[1]

	if not self:isActivityValid(actId) then
		return false
	end

	return true
end

function CommonGetConditionMixin:getForceShowActivityCondition(args)
	local ConditionOutputCopy = utils.deepcopy(ConditionOutput)
	local actId = args[1]

	ConditionOutputCopy.closed = not self:isActivityValid(actId)

	return ConditionOutputCopy
end

function CommonGetConditionMixin:getBossExpandCondition(args)
	local towerType = args[1]
	local layer = args[2]
	local ConditionOutputCopy = utils.deepcopy(ConditionOutput)

	if self:checkBossExpandCanSweep(towerType, layer) == false then
		ConditionOutputCopy.invaildFunc = Slot(self.confirmToBossExpand, self)
		ConditionOutputCopy.towerType = towerType
		ConditionOutputCopy.towerLayer = layer
	end

	if self:checkBossExpandCanSweep(towerType, layer) == false and layer == self:getBossExpandCurLayer(towerType) then
		ConditionOutputCopy.willUnlock = true
	end

	ConditionOutputCopy.locked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_EXPAND)

	if not ConditionOutputCopy.locked and not ConditionOutputCopy.invaildNotice then
		local remainCount, totalCount = self:getBossExpandSweepCount(towerType)

		ConditionOutputCopy.num = remainCount
		ConditionOutputCopy.tNum = totalCount
	end

	return ConditionOutputCopy
end

function CommonGetConditionMixin:confirmToBossExpand(conditions)
	if not self:isBossExpandLayerOpen(conditions.towerType, conditions.towerLayer) then
		MsgManager.clientNotice(637)

		return
	end

	local function yesFunc()
		local itemTips = UIManager.getUI("itemTips", nil, false)

		if itemTips then
			itemTips:setVisible(false)
		end

		self:jumpToBossExpandCurStage(conditions.towerType)
	end

	local msgContent = ""

	if conditions.willUnlock then
		msgContent = string.format(Lang.get(1830), ResGamePlayNotice[Const.GAME_PLAY_NOTICE_BOSS_EXPAND].name)
	else
		msgContent = string.format(Lang.get(1831), ResGamePlayNotice[Const.GAME_PLAY_NOTICE_BOSS_EXPAND].name)
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
end

return CommonGetConditionMixin

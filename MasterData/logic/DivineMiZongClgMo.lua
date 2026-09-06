-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/data/DivineMiZongClgMo.lua

module("logic.extensions.divinemizongclg.data.DivineMiZongClgMo", package.seeall)

local DivineMiZongClgMo = class("DivineMiZongClgMo")

function DivineMiZongClgMo:ctor(activityId)
	self._activityId = activityId
	self._stageStarList = {}
	self._gainPrizeIds = {}
	self._todayGainItem = false
	self._buffList = {}
	self._fightResMsg = nil

	local matType, matId, matNum = 0, 0, 0
	local matName = ""
	local matStr = DivineMiZongClgConfig.instance:getUpgradeItem(activityId)

	if not string.nilorempty(matStr) then
		matType, matId, matNum = MaterialMgr.getMatParams(matStr)
		matName = MaterialMgr.getMaterialsName(matType, matId)
	end

	self._itemArr = {
		matType = matType,
		matId = matId,
		matNum = matNum,
		matName = matName
	}

	self:setUpgradeItemNum(0)
end

function DivineMiZongClgMo:dispose()
	self._fightResMsg = nil
end

function DivineMiZongClgMo:handlePM_DivineMiZongClgGetInfoRes(msg)
	MmUtil.coverList(self._stageStarList, msg.stageStarList)
	table.clear(self._gainPrizeIds)

	for k, v in pairs(msg.gainPrizeIds) do
		self._gainPrizeIds[v] = true
	end

	self:setUpgradeItemNum(msg.upgradeBuffItemCount)

	self._todayGainItem = checkbool(msg.todayGainItem)

	table.clear(self._buffList)

	for i, v in ipairs(msg.buffList) do
		self._buffList[v.buffType] = v
	end
end

function DivineMiZongClgMo:handlePM_DivineMiZongClgFightRes(msg)
	return
end

function DivineMiZongClgMo:handlePM_DivineMiZongClgNotifyFightRes(msg)
	self._fightResMsg = msg
end

function DivineMiZongClgMo:handlePM_DivineMiZongClgGainBuffItemRes(msg)
	self._todayGainItem = true

	self:setUpgradeItemNum(msg.upgradeBuffItemCount)
end

function DivineMiZongClgMo:handlePM_DivineMiZongClgUpgradeBuffRes(msg)
	self:setUpgradeItemNum(msg.upgradeBuffItemCount)

	self._buffList[msg.buff.buffType] = msg.buff
end

function DivineMiZongClgMo:handlePM_DivineMiZongClgResetBuffRes(msg)
	table.clear(self._buffList)
	self:setUpgradeItemNum(msg.upgradeBuffItemCount)
end

function DivineMiZongClgMo:handlePM_DivineMiZongClgGainPrizeRes(msg)
	self._gainPrizeIds[msg.prizeId] = true

	self:setUpgradeItemNum(msg.upgradeBuffItemCount)
end

function DivineMiZongClgMo:getTotalStar()
	local star = 0

	for _, v in pairs(self._stageStarList) do
		star = star + v
	end

	return star
end

function DivineMiZongClgMo:getStageCount()
	local cfg = DivineMiZongClgConfig.instance:getStageCfg(self._activityId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.stageId or 0)
end

function DivineMiZongClgMo:getStageStart(stageId)
	return self._stageStarList[stageId] or 0
end

function DivineMiZongClgMo:getMaxStageStart(stageId)
	local cfg = DivineMiZongClgConfig.instance:getStartPrizeCfg(self._activityId, stageId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.star or 0)
end

function DivineMiZongClgMo:isUnlockStage(stageId)
	local last = stageId - 1

	return last > 0 and self:getStageStart(last) > 0 or true
end

function DivineMiZongClgMo:getUpgradeBuffItemCount()
	return self._upgradeBuffItemCount
end

function DivineMiZongClgMo:isTodayGainItem()
	return self._todayGainItem
end

function DivineMiZongClgMo:isEnoughCostNextLevelBuff(buffType)
	if self:isFullLevelBuff(buffType) then
		return false
	else
		local cur = self:getBuffLevel(buffType)
		local next = cur + 1
		local cost = self:getUpdateBuffCostNum(buffType, next)
		local with = self:getUpgradeItemNum()

		return cost <= with
	end
end

function DivineMiZongClgMo:getUpdateBuffCostNum(buffType, buffLevel)
	local data = DivineMiZongClgConfig.instance:getBuffData(self._activityId, buffType, buffLevel)

	return (data or nil) and (data.upgradeCostItem or 0)
end

function DivineMiZongClgMo:isFullLevelBuff(buffType)
	local cur = self:getBuffLevel(buffType)
	local max = self:getMaxBuffLevel(buffType)

	return max <= cur
end

function DivineMiZongClgMo:getUpgradeItemName()
	return self._itemArr.matName
end

function DivineMiZongClgMo:getUpgradeItemNum()
	return self._upgradeBuffItemCount
end

function DivineMiZongClgMo:setUpgradeItemNum(value)
	value = checknumber(value)
	self._upgradeBuffItemCount = value

	MaterialFacade:UpdateMaterial(self._itemArr.matType, self._itemArr.matId, value)
end

function DivineMiZongClgMo:getUpgradeItem()
	return self._itemArr
end

function DivineMiZongClgMo:getMaxBuffLevel(buffType)
	return DivineMiZongClgConfig.instance:getMaxLevelBuff(self._activityId, buffType)
end

function DivineMiZongClgMo:getBuffLevel(buffType)
	local info = self:getBuffInfo(buffType)

	return (info or nil) and (info.buffLevel or 0)
end

function DivineMiZongClgMo:getBuffInfo(buffType)
	return self._buffList[buffType]
end

function DivineMiZongClgMo:isCanGetPrize(prizeId)
	return not self:isHasGainPrize(prizeId) and self:isEnoughGetPrize(prizeId)
end

function DivineMiZongClgMo:isHasGainPrize(prizeId)
	return self._gainPrizeIds[prizeId] or false
end

function DivineMiZongClgMo:isEnoughGetPrize(prizeId)
	local data = DivineMiZongClgConfig.instance:getProgressPrizeData(self._activityId, prizeId)
	local need = data and data.starProgress
	local cur = self:getTotalStar()

	return need <= cur
end

function DivineMiZongClgMo:getFightMsg()
	return self._fightResMsg
end

function DivineMiZongClgMo:getTryResultAndTipsUpdateBuff(isShowTips, buffType)
	local result = GameEnum.ResultCode.Success
	local tips

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = isShowTips and "不在活动时间范围内"
	elseif self:isFullLevelBuff(buffType) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "已达满级"
	elseif not self:isEnoughCostNextLevelBuff(buffType) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "升级道具不足"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return DivineMiZongClgMo

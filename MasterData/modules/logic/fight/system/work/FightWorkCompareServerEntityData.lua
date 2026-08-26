-- chunkname: @modules/logic/fight/system/work/FightWorkCompareServerEntityData.lua

module("modules.logic.fight.system.work.FightWorkCompareServerEntityData", package.seeall)

local FightWorkCompareServerEntityData = class("FightWorkCompareServerEntityData", FightWorkItem)

function FightWorkCompareServerEntityData:onStart(context)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		self:onDone(true)

		return
	end

	if FightModel.instance:isFinish() then
		self:onDone(true)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		self:onDone(true)

		return
	end

	if FightDataHelper.stateMgr.isReplay then
		self:onDone(true)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor then
		self:com_registTimer(self._delayDone, 5)

		self._count = 0

		self:com_registFightEvent(FightEvent.CountEntityInfoReply, self._onCountEntityInfoReply)

		local localEntityMODid = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()

		for k, localEntityMO in pairs(localEntityMODid) do
			if not localEntityMO:isStatusDead() then
				self._count = self._count + 1

				local entityId = localEntityMO.uid

				FightRpc.instance:sendEntityInfoRequest(entityId)
			end
		end

		if self._count == 0 then
			self:onDone(true)
		end

		return
	end

	self:onDone(true)
end

function FightWorkCompareServerEntityData.compareAttrMO(attrMO1, attrMO2, serverEntityMO, localEntityMO)
	if serverEntityMO:isVorpalith() or localEntityMO:isVorpalith() then
		return
	end

	if serverEntityMO:isRouge2Music() or localEntityMO:isRouge2Music() then
		return
	end

	if serverEntityMO:isAct191Boss() then
		return
	end

	if attrMO1.hp ~= attrMO2.hp then
		FightDataUtil.addDiff("hp", FightDataUtil.diffType.difference)
	end

	if attrMO1.multiHpNum ~= attrMO2.multiHpNum then
		FightDataUtil.addDiff("multiHpNum", FightDataUtil.diffType.difference)
	end
end

function FightWorkCompareServerEntityData.comparSummonedOneData(data1, data2)
	FightDataUtil.doFindDiff(data1, data2, {
		stanceIndex = true
	})
end

function FightWorkCompareServerEntityData.compareSummonedInfo(summonedInfo1, summonedInfo2, serverEntityMO, localEntityMO)
	FightDataUtil.addPathkey("dataDic")
	FightDataUtil.doFindDiff(summonedInfo1.dataDic, summonedInfo2.dataDic, nil, nil, FightWorkCompareServerEntityData.comparSummonedOneData)
	FightDataUtil.removePathKey()
end

local compareBuffFieldFunc = {
	actInfo = function(actInfo1, actInfo2)
		local function sortFunc(buffActInfo1, buffActInfo2)
			return buffActInfo1.actId < buffActInfo2.actId
		end

		table.sort(actInfo1, sortFunc)
		table.sort(actInfo2, sortFunc)
		FightDataUtil.doFindDiff(actInfo1, actInfo2)
	end
}

local function compareBuffMO(buffMO1, buffMO2)
	local filterKey = {
		_last_clone_mo = true
	}

	FightDataUtil.doFindDiff(buffMO1, buffMO2, filterKey, compareBuffFieldFunc)
end

function FightWorkCompareServerEntityData.compareBuffDic(buffDic1, buffDic2)
	FightDataUtil.doFindDiff(buffDic1, buffDic2, nil, nil, compareBuffMO)
end

local errorDes = {
	[FightDataUtil.diffType.missingSource] = "服务器数据不存在",
	[FightDataUtil.diffType.missingTarget] = "本地数据不存在",
	[FightDataUtil.diffType.difference] = "数据不一致"
}
local filterCompareKey = {
	storedDeviceExPoint = true,
	playCardExPoint = true,
	resistanceDict = true,
	_playCardAddExpoint = true,
	configMaxExPoint = true,
	buffFeaturesSplit = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	class = true,
	skillList = true,
	_moveCardAddExpoint = true
}

FightWorkCompareServerEntityData.filterCompareKey = filterCompareKey

local costomCompareFunc = {
	attrMO = FightWorkCompareServerEntityData.compareAttrMO,
	summonedInfo = FightWorkCompareServerEntityData.compareSummonedInfo,
	buffDic = FightWorkCompareServerEntityData.compareBuffDic
}

FightWorkCompareServerEntityData.costomCompareFunc = costomCompareFunc

function FightWorkCompareServerEntityData:_onCountEntityInfoReply(resultCode, msg)
	if resultCode == 0 then
		if msg.entityInfo then
			local localEntityMO = FightLocalDataMgr.instance.entityMgr:getById(msg.entityInfo.uid)

			if localEntityMO then
				local entityId = localEntityMO.id
				local serverEntityMO = FightEntityMO.New()
				local dataProto = FightEntityInfoData.New(msg.entityInfo)

				serverEntityMO:init(dataProto, localEntityMO.side)

				local diff, diffTab = FightDataUtil.findDiff(serverEntityMO, localEntityMO, filterCompareKey, costomCompareFunc)

				if diff then
					local config = localEntityMO:getCO()
					local str = "前后端entity数据不一致,entityId:%s, 角色名称:%s \n"

					str = string.format(str, entityId, (config or nil) and (config.name or ""))

					for rootKey, diffList in pairs(diffTab) do
						for i, tab in ipairs(diffList) do
							local diffValue = " "

							if tab.diffType == FightDataUtil.diffType.difference then
								local value1, value2 = FightDataUtil.getDiffValue(serverEntityMO, localEntityMO, tab)

								diffValue = string.format("    服务器数据:%s, 本地数据:%s", value1, value2)
							end

							str = str .. "路径: entityMO." .. tab.pathStr .. ", 原因:" .. errorDes[tab.diffType] .. diffValue .. "\n"
						end

						str = str .. "\n"
						str = str .. "服务器数据: entityMO." .. rootKey .. " = " .. FightHelper.logStr(serverEntityMO[rootKey], filterCompareKey) .. "\n"
						str = str .. "\n"
						str = str .. "本地数据: entityMO." .. rootKey .. " = " .. FightHelper.logStr(localEntityMO[rootKey], filterCompareKey) .. "\n"
						str = str .. "------------------------------------------------------------------------------------------------------------------------\n"
					end

					logError(str)
					FightLocalDataMgr.instance.entityMgr:replaceEntityMO(serverEntityMO)
				end
			else
				logError("数据错误")
			end
		end
	end

	self._count = self._count - 1

	if self._count <= 0 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
		self:onDone(true)
	end
end

function FightWorkCompareServerEntityData:_delayDone()
	logError("对比前后端数据超时")
	self:onDone(true)
end

function FightWorkCompareServerEntityData:clearWork()
	return
end

return FightWorkCompareServerEntityData

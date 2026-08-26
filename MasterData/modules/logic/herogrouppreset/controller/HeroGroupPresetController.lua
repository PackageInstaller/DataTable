-- chunkname: @modules/logic/herogrouppreset/controller/HeroGroupPresetController.lua

module("modules.logic.herogrouppreset.controller.HeroGroupPresetController", package.seeall)

local HeroGroupPresetController = class("HeroGroupPresetController", BaseController)

function HeroGroupPresetController:onInit()
	return
end

function HeroGroupPresetController:onInitFinish()
	return
end

function HeroGroupPresetController:addConstEvents()
	return
end

function HeroGroupPresetController:reInit()
	return
end

function HeroGroupPresetController:updateFightHeroGroup()
	if self:isFightScene() then
		HeroGroupModel.instance:_setSingleGroup()
	end
end

function HeroGroupPresetController:isFightScene()
	return GameSceneMgr.instance:isFightScene()
end

function HeroGroupPresetController:isFightShowType()
	return self._showType == HeroGroupPresetEnum.ShowType.Fight
end

function HeroGroupPresetController:isCopyShowType()
	return self._showType == HeroGroupPresetEnum.ShowType.Copy
end

function HeroGroupPresetController:useTrial()
	return GameSceneMgr.instance:isFightScene()
end

function HeroGroupPresetController:getHeroGroupTypeList()
	return self._heroGroupTypeList
end

function HeroGroupPresetController:getSelectedSubId()
	return self._subId
end

function HeroGroupPresetController.snapshotUsePreset(snapshotType)
	if not snapshotType then
		return
	end

	for k, v in pairs(HeroGroupPresetEnum.HeroGroupType2SnapshotType) do
		if snapshotType == v then
			return HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen[k]
		end
	end
end

function HeroGroupPresetController:openHeroGroupPresetTeamView(param, isImmediate)
	if param then
		self._showType = param.showType or HeroGroupPresetEnum.ShowType.Normal
	end

	self._heroGroupTypeList = param and param.heroGroupTypeList
	self._subId = param and param.subId
	self._targetId = param and param.targetId

	if not self:isFightScene() then
		HeroGroupModel.instance.episodeId = nil

		HeroGroupModel.instance:initRestrictHeroData()
		HeroGroupTrialModel.instance:clear()
		TowerModel.instance:clearRecordFightParam()
		FightModel.instance:setFightParam(FightParam.New())
	end

	ViewMgr.instance:closeView(ViewName.HeroGroupPresetTeamView)
	HeroGroupPresetController.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupPresetTeamView, param, isImmediate)
end

function HeroGroupPresetController:closeHeroGroupPresetEditView()
	ViewMgr.instance:closeView(ViewName.HeroGroupPresetEditView)
end

function HeroGroupPresetController:openHeroGroupPresetEditView(param, isImmediate)
	HeroGroupPresetController.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupPresetEditView, param, isImmediate)
end

function HeroGroupPresetController:openHeroGroupPresetModifyNameView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.HeroGroupPresetModifyNameView, param, isImmediate)
end

function HeroGroupPresetController:initCopyHeroGroupList()
	if not self:isFightScene() then
		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	self._copyList = {}

	local list = HeroGroupPresetHeroGroupChangeController.instance:getHeroGroupList(heroGroupType)

	if list then
		local useIds = {}

		for _, v in pairs(list) do
			local heroGroupMO = HeroGroupMO.New()

			heroGroupMO:init(v)

			if v.id then
				useIds[v.id] = true
			end

			table.insert(self._copyList, heroGroupMO)
		end

		for i, v in ipairs(self._copyList) do
			if not v.id then
				local newId = 1

				while useIds[newId] do
					newId = newId + 1
				end

				v.id = newId
				v.groupId = v.id
			end
		end
	end
end

function HeroGroupPresetController:getHeroGroupCopyList(heroGroupType)
	if self:isFightScene() and HeroGroupModel.instance:getPresetHeroGroupType() == heroGroupType and self._copyList then
		local list = {}

		for _, v in pairs(self._copyList) do
			local heroGroupMO = HeroGroupMO.New()

			heroGroupMO:init(v)
			table.insert(list, heroGroupMO)
		end

		return list
	end
end

function HeroGroupPresetController:deleteHeroGroupCopy(snapshotId, snapshotSubId)
	if not self:isFightScene() then
		return
	end

	if not self._copyList then
		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	local heroGroupSnapShotId = HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[heroGroupType]

	if heroGroupSnapShotId ~= snapshotId then
		logError(string.format("HeroGroupPresetController:deleteHeroGroupCopy error heroGroupSnapShotId:%s,snapshotId:%s", heroGroupSnapShotId, snapshotId))

		return
	end

	for i, v in ipairs(self._copyList) do
		if v.groupId == snapshotSubId then
			table.remove(self._copyList, i)

			return
		end
	end

	logError(string.format("HeroGroupPresetController:deleteHeroGroupCopy error heroGroupSnapShotId:%s,snapshotSubId:%s", heroGroupSnapShotId, snapshotSubId))
end

function HeroGroupPresetController:addHeroGroupCopy(snapshotId, snapshotSubId, heroGroupMo)
	if not self:isFightScene() then
		return
	end

	if not self._copyList then
		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	local heroGroupSnapShotId = HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[heroGroupType]

	if heroGroupSnapShotId ~= snapshotId then
		logError(string.format("HeroGroupPresetController:addHeroGroupCopy error heroGroupSnapShotId:%s,snapshotId:%s", heroGroupSnapShotId, snapshotId))

		return
	end

	for i, v in ipairs(self._copyList) do
		if v.groupId == snapshotSubId then
			table.remove(self._copyList, i)
			logError(string.format("HeroGroupPresetController:addHeroGroupCopy remove error heroGroupSnapShotId:%s,snapshotSubId:%s", heroGroupSnapShotId, snapshotSubId))

			break
		end
	end

	table.insert(self._copyList, heroGroupMo)
end

function HeroGroupPresetController:revertCurHeroGroup()
	if not self:isFightScene() then
		return
	end

	if not self._copyList then
		return
	end

	local presetHeroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not presetHeroGroupType then
		return
	end

	local heroGroupType = HeroGroupModel.instance.heroGroupType

	if heroGroupType == ModuleEnum.HeroGroupType.Temp or heroGroupType == ModuleEnum.HeroGroupType.Trial then
		return
	end

	local curHeroGroup = HeroGroupModel.instance:getCurGroupMO()

	if not curHeroGroup or not curHeroGroup.groupId then
		return
	end

	local copyListStr = ""

	for i, v in ipairs(self._copyList) do
		copyListStr = string.format("%s#%s", copyListStr, v.groupId)

		if v.groupId == curHeroGroup.groupId then
			local name = curHeroGroup.name

			curHeroGroup:init(v)

			curHeroGroup.name = name

			return
		end
	end

	logError(string.format("HeroGroupPresetController:revertCurHeroGroup error presetHeroGroupType:%s,heroGroupType:%s,snapshotSubId:%s,copyList:%s", presetHeroGroupType, heroGroupType, curHeroGroup.groupId, copyListStr))
end

function HeroGroupPresetController:clearCopyList()
	self._copyList = nil
end

function HeroGroupPresetController:copyPresetToOther(groupId, subId, targetGroupId, targetSubId, isDirectSave, callback, callbackObj)
	local sourceMo

	if groupId == HeroGroupPresetEnum.HeroGroupType.Common then
		sourceMo = HeroGroupModel.instance:getCommonGroupList(subId)
	else
		local snapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[groupId]

		if snapshotType then
			sourceMo = HeroGroupSnapshotModel.instance:getHeroGroupInfo(snapshotType, subId)
		end
	end

	if not sourceMo then
		logError(string.format("HeroGroupPresetController:copyPresetToOther sourceMo not found, groupId:%s, subId:%s", tostring(groupId), tostring(subId)))

		return
	end

	local targetMo

	if targetGroupId == HeroGroupPresetEnum.HeroGroupType.Common then
		targetMo = HeroGroupModel.instance:getCommonGroupList(targetSubId)
	else
		local targetSnapshotType = HeroGroupPresetEnum.HeroGroupType2SnapshotType[targetGroupId]

		if targetSnapshotType then
			targetMo = HeroGroupSnapshotModel.instance:getHeroGroupInfo(targetSnapshotType, targetSubId, true)
		end
	end

	if not targetMo then
		logError(string.format("HeroGroupPresetController:copyPresetToOther targetMo not found, targetGroupId:%s, targetSubId:%s", tostring(targetGroupId), tostring(targetSubId)))

		return
	end

	local targetId = targetMo.id
	local targetGroupIdValue = targetMo.groupId
	local targetName = targetMo.name

	targetMo:init(sourceMo)

	targetMo.id = targetId
	targetMo.groupId = targetGroupIdValue
	targetMo.name = targetName

	if sourceMo.aidDict then
		targetMo.aidDict = {}

		for k, v in pairs(sourceMo.aidDict) do
			targetMo.aidDict[k] = v
		end
	else
		targetMo.aidDict = nil
	end

	if sourceMo.trialDict then
		targetMo.trialDict = {}

		for k, v in pairs(sourceMo.trialDict) do
			targetMo.trialDict[k] = v
		end
	end

	targetMo.assistBossId = sourceMo:getAssistBossId() or 0

	local snapshotId = HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[targetGroupId]

	if not snapshotId then
		logError(string.format("HeroGroupPresetController:copyPresetToOther snapshotId not found, targetGroupId:%s", tostring(targetGroupId)))

		return nil
	end

	if not isDirectSave then
		return targetMo
	end

	local oldSnapshotType = HeroGroupPresetModel.instance._heroGroupSnapshotType

	HeroGroupPresetModel.instance:setHeroGroupSnapshotType(snapshotId)
	HeroGroupPresetModel.instance:externalSaveCurGroupData(callback, callbackObj, targetMo, snapshotId, targetSubId)
	HeroGroupPresetModel.instance:setHeroGroupSnapshotType(oldSnapshotType)
end

HeroGroupPresetController.instance = HeroGroupPresetController.New()

return HeroGroupPresetController

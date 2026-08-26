-- chunkname: @modules/logic/herogroup/rpc/HeroGroupRpc.lua

module("modules.logic.herogroup.rpc.HeroGroupRpc", package.seeall)

local HeroGroupRpc = class("HeroGroupRpc", BaseRpc)

function HeroGroupRpc:sendGetHeroGroupListRequest(callback, callbackObj)
	local req = HeroGroupModule_pb.GetHeroGroupListRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveGetHeroGroupListReply(resultCode, msg)
	if resultCode == 0 then
		HeroGroupModel.instance:onGetHeroGroupList(msg.groupInfoList)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnGetHeroGroupList)
	end
end

function HeroGroupRpc:sendUpdateHeroGroupRequest(groupId, heroUidList, groupName, clothId, equips, activity104Equips, callback, callbackObj)
	local req = HeroGroupModule_pb.UpdateHeroGroupRequest()

	req.groupInfo.groupId = groupId
	req.groupInfo.name = groupName or ""

	if clothId then
		req.groupInfo.clothId = clothId
	end

	if heroUidList then
		for _, heroUid in ipairs(heroUidList) do
			table.insert(req.groupInfo.heroList, heroUid)
		end
	end

	if equips then
		for i = 0, 3 do
			local equip = equips[i]

			if equip then
				local reqEquip = HeroDef_pb.HeroGroupEquip()

				reqEquip.index = equip.index

				for _, v in ipairs(equip.equipUid) do
					table.insert(reqEquip.equipUid, v)
				end

				table.insert(req.groupInfo.equips, reqEquip)
			end
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveUpdateHeroGroupReply(resultCode, msg)
	if resultCode == 0 then
		HeroGroupModel.instance:onModifyHeroGroup(msg.groupInfo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function HeroGroupRpc:sendSetHeroGroupEquipRequest(groupId, index, equipUid)
	local req = HeroGroupModule_pb.SetHeroGroupEquipRequest()

	req.groupId = groupId
	req.equip.index = index

	for i, v in ipairs(equipUid) do
		table.insert(req.equip.equipUid, v)
	end

	if Activity104Model.instance:isSeasonChapter() then
		local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

		heroGroupMO.equips[index].equipUid = equipUid

		heroGroupMO:updatePosEquips(req.equip)
		HeroGroupModel.instance:saveCurGroupData()

		return
	end

	self:sendMsg(req)
end

function HeroGroupRpc:onReceiveSetHeroGroupEquipReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local groupId = msg.groupId
	local equip = msg.equip
	local groupMO = HeroGroupModel.instance:getById(groupId)

	if groupMO then
		groupMO:updatePosEquips(equip)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, equip.index)

		if self._showSetHeroGroupEquipTip then
			self._showSetHeroGroupEquipTip()

			self._showSetHeroGroupEquipTip = nil
		end
	end
end

function HeroGroupRpc:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req, callback, callbackObj)
	if snapshotId == ModuleEnum.HeroGroupSnapshotType.Resources and snapshotSubId ~= VersionActivity2_8BossEnum.HeroGroupId.First and snapshotSubId ~= VersionActivity2_8BossEnum.HeroGroupId.Second then
		logError(string.format("HeroGroupRpc:sendSetHeroGroupSnapshotRequest snapshotId:%s snapshotSubId:%s 使用错误", snapshotId, snapshotSubId))
	end

	req.snapshotId = snapshotId
	req.snapshotSubId = snapshotSubId

	self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveSetHeroGroupSnapshotReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	logNormal("编队快照保存成功")
	HeroGroupController.instance:onReceiveHeroGroupSnapshot(msg)

	if self._showSetHeroGroupEquipTip then
		self._showSetHeroGroupEquipTip()

		self._showSetHeroGroupEquipTip = nil
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, msg.snapshotId, msg.snapshotSubId)
end

function HeroGroupRpc:onReceiveUpdateHeroGroupPush(resultCode, msg)
	if resultCode == 0 then
		HeroGroupModel.instance:onModifyHeroGroup(msg.groupInfo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function HeroGroupRpc:onReceiveUpdateHeroGroupSnapshotPush(resultCode, msg)
	if resultCode == 0 then
		local snapshotId = msg.snapshotId
		local snapshotSubId = msg.snapshotSubId
		local groupInfo = msg.groupInfo

		if snapshotId ~= ModuleEnum.HeroGroupSnapshotType.Common or snapshotSubId ~= 1 then
			logError(string.format("HeroGroupRpc:onReceiveUpdateHeroGroupSnapshotPush snapshotId:%s snapshotSubId:%s is error", snapshotId, snapshotSubId))

			return
		end

		local heroGroupMO = HeroGroupModel.instance:getCommonGroupList(snapshotSubId) or HeroGroupMO.New()

		heroGroupMO:init(groupInfo)
		HeroGroupModel.instance:addCommonGroupList(snapshotSubId, heroGroupMO)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end
end

function HeroGroupRpc:sendGetHeroGroupCommonListRequest(callback, callbackObj)
	local req = HeroGroupModule_pb.GetHeroGroupCommonListRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveGetHeroGroupCommonListReply(resultCode, msg)
	if resultCode == 0 then
		HeroGroupModel.instance:onGetCommonGroupList(msg)
	end
end

function HeroGroupRpc:sendChangeHeroGroupSelectRequest(id, select)
	local req = HeroGroupModule_pb.ChangeHeroGroupSelectRequest()

	req.id = id
	req.currentSelect = select

	self:sendMsg(req)
end

function HeroGroupRpc:onReceiveChangeHeroGroupSelectReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function HeroGroupRpc:sendUpdateHeroGroupNameRequest(id, index, name, callback, callbackObj)
	local req = HeroGroupModule_pb.UpdateHeroGroupNameRequest()

	req.id = id
	req.currentSelect = index
	req.name = name

	self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveUpdateHeroGroupNameReply(resultCode, msg)
	return
end

function HeroGroupRpc:sendGetAllHeroGroupSnapshotListRequest(callback, callbackObj)
	return self:sendGetHeroGroupSnapshotListRequest(0, callback, callbackObj)
end

function HeroGroupRpc:sendGetHeroGroupSnapshotListRequest(snapshotId, callback, callbackObj)
	local req = HeroGroupModule_pb.GetHeroGroupSnapshotListRequest()

	req.snapshotId = snapshotId

	return self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveGetHeroGroupSnapshotListReply(resultCode, msg)
	if resultCode == 0 then
		HeroGroupSnapshotModel.instance:onReceiveGetHeroGroupSnapshotListReply(msg)
	end
end

function HeroGroupRpc:sendDeleteHeroGroupRequest(snapshotId, snapshotSubId)
	local req = HeroGroupModule_pb.DeleteHeroGroupRequest()

	req.snapshotId = snapshotId
	req.snapshotSubId = snapshotSubId

	self:sendMsg(req)
end

function HeroGroupRpc:onReceiveDeleteHeroGroupReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local snapshotId = msg.snapshotId
	local snapshotSubId = msg.snapshotSubId
	local sortSubIds = msg.sortSubIds

	HeroGroupPresetController.instance:deleteHeroGroupCopy(snapshotId, snapshotSubId)
	HeroGroupPresetHeroGroupChangeController.instance:removeHeroGroup(snapshotId, snapshotSubId)
	HeroGroupSnapshotModel.instance:updateSortSubIds(snapshotId, sortSubIds)
	HeroGroupPresetItemListModel.instance:updateList()
end

function HeroGroupRpc:sendUpdateHeroGroupSortRequest(snapshotId, sortSubIds)
	local req = HeroGroupModule_pb.UpdateHeroGroupSortRequest()

	req.snapshotId = snapshotId

	for i, v in ipairs(sortSubIds) do
		table.insert(req.sortSubIds, v)
	end

	self:sendMsg(req)
end

function HeroGroupRpc:onReceiveUpdateHeroGroupSortReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local snapshotId = msg.snapshotId
	local sortSubIds = msg.sortSubIds

	HeroGroupSnapshotModel.instance:updateSortSubIds(snapshotId, sortSubIds)
	HeroGroupPresetItemListModel.instance:updateList()
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UpdateHeroGroupSort)
end

function HeroGroupRpc:sendCheckHeroGroupNameRequest(name, callback, callbackObj)
	local req = HeroGroupModule_pb.CheckHeroGroupNameRequest()

	req.name = name

	self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveCheckHeroGroupNameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function HeroGroupRpc:sendSetHeroGroupSnapshotBatchRequest(snapshotId, result, callback, callbackObj)
	local req = HeroGroupModule_pb.SetHeroGroupSnapshotBatchRequest()

	req.snapshotId = snapshotId

	local groupNos = {}

	for subId, heroGroupMO in pairs(result) do
		local groupNo = req.fightGroups:add()

		groupNo.snapshotSubId = subId

		FightParam.initFightGroup(groupNo.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId())

		groupNo.fightGroup.assistBossId = heroGroupMO:getAssistBossId() or 0

		table.insert(groupNos, groupNo)
	end

	self:sendMsg(req, callback, callbackObj)
end

function HeroGroupRpc:onReceiveSetHeroGroupSnapshotBatchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	logNormal("编队快照列表保存成功")
	HeroGroupController.instance:onReceiveHeroGroupSnapshotBatch(msg)

	if self._showSetHeroGroupEquipTip then
		self._showSetHeroGroupEquipTip()

		self._showSetHeroGroupEquipTip = nil
	end
end

HeroGroupRpc.instance = HeroGroupRpc.New()

return HeroGroupRpc

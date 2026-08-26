-- chunkname: @modules/logic/gm/view/GMFightEntityViewContainer.lua

module("modules.logic.gm.view.GMFightEntityViewContainer", package.seeall)

local GMFightEntityViewContainer = class("GMFightEntityViewContainer", BaseViewContainer)

function GMFightEntityViewContainer:buildViews()
	local entityScrollParam = ListScrollParam.New()

	entityScrollParam.scrollGOPath = "entitys"
	entityScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	entityScrollParam.prefabUrl = "entitys/item"
	entityScrollParam.cellClass = GMFightEntityItem
	entityScrollParam.scrollDir = ScrollEnum.ScrollDirV
	entityScrollParam.lineCount = 1
	entityScrollParam.cellWidth = 430
	entityScrollParam.cellHeight = 142

	local buffScrollParam = ListScrollParam.New()

	buffScrollParam.scrollGOPath = "buff/buffs"
	buffScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	buffScrollParam.prefabUrl = "buff/buffs/item"
	buffScrollParam.cellClass = GMFightEntityBuffItem
	buffScrollParam.scrollDir = ScrollEnum.ScrollDirV
	buffScrollParam.lineCount = 1
	buffScrollParam.cellWidth = 746
	buffScrollParam.cellHeight = 43

	local skillScrollParam = ListScrollParam.New()

	skillScrollParam.scrollGOPath = "skill/skills"
	skillScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	skillScrollParam.prefabUrl = "skill/skills/item"
	skillScrollParam.cellClass = GMFightEntitySkillItem
	skillScrollParam.scrollDir = ScrollEnum.ScrollDirV
	skillScrollParam.lineCount = 1
	skillScrollParam.cellWidth = 746
	skillScrollParam.cellHeight = 43

	local attrScrollParam = ListScrollParam.New()

	attrScrollParam.scrollGOPath = "attr"
	attrScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	attrScrollParam.prefabUrl = "attr/item"
	attrScrollParam.cellClass = GMFightEntityAttrItem
	attrScrollParam.scrollDir = ScrollEnum.ScrollDirV
	attrScrollParam.lineCount = 2
	attrScrollParam.cellWidth = 299
	attrScrollParam.cellHeight = 258

	local views = {}

	self.entityListView = LuaListScrollView.New(GMFightEntityModel.instance, entityScrollParam)

	table.insert(views, self.entityListView)

	self.buffListView = LuaListScrollView.New(GMFightEntityModel.instance.buffModel, buffScrollParam)

	table.insert(views, self.buffListView)

	self.skillListView = LuaListScrollView.New(GMFightEntityModel.instance.skillModel, skillScrollParam)

	table.insert(views, self.skillListView)

	self.attrListView = LuaListScrollView.New(GMFightEntityModel.instance.attrModel, attrScrollParam)

	table.insert(views, self.attrListView)
	table.insert(views, GMFightEntityView.New())
	table.insert(views, GMFightEntityInfoView.New())
	table.insert(views, GMFightEntityBuffView.New())
	table.insert(views, GMFightEntitySkillView.New())

	return views
end

function GMFightEntityViewContainer:onContainerOpen()
	self.addEventCb(self, FightController.instance, FightEvent.onReceiveEntityInfoReply, self._onGetEntityInfo, self)
end

function GMFightEntityViewContainer:onContainerClose()
	self.removeEventCb(self, FightController.instance, FightEvent.onReceiveEntityInfoReply, self._onGetEntityInfo, self)
end

function GMFightEntityViewContainer:_onGetEntityInfo(msg)
	local entityInfo = msg.entityInfo
	local entityId = entityInfo.uid

	if entityInfo then
		::label_4_0::

		local entityData = FightDataHelper.entityMgr:getById(entityId)

		if entityData then
			FightDataHelper.entityMgr:addEntityMOByProto(entityInfo)
		end

		local localEntityMO = FightLocalDataMgr.instance.entityMgr:getById(entityId)

		if localEntityMO then
			FightEntityDataHelper.copyEntityMO(entityData, localEntityMO)
		end

		GMFightEntityModel.instance:onGetSingleEntityInfo(msg)
		FightController.instance:dispatchEvent(FightEvent.CoverPerformanceEntityData, entityId)
	end
end

function GMFightEntityViewContainer:onContainerInit()
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

function GMFightEntityViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return GMFightEntityViewContainer

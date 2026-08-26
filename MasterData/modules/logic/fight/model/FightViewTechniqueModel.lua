-- chunkname: @modules/logic/fight/model/FightViewTechniqueModel.lua

module("modules.logic.fight.model.FightViewTechniqueModel", package.seeall)

local FightViewTechniqueModel = class("FightViewTechniqueModel", ListScrollModel)

function FightViewTechniqueModel:onInit()
	self._all = nil
end

function FightViewTechniqueModel:reInit()
	self._all = nil
end

function FightViewTechniqueModel:initFromSimpleProperty()
	if self._all then
		return
	end

	self._all = BaseModel.New()

	local recordStr = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.FightTechnique)
	local recordArr = FightStrUtil.instance:getSplitString2Cache(recordStr or "", true, "|", "#")

	if not recordArr then
		return
	end

	local unreadList = {}

	for i, arr in ipairs(recordArr) do
		for _, id in ipairs(arr) do
			local co = lua_fight_technique.configDict[id]

			if co then
				local mo = {
					id = id
				}

				self._all:addAtLast(mo)

				if i == 2 then
					table.insert(unreadList, mo)
				end
			end
		end
	end

	self:addList(unreadList)
end

function FightViewTechniqueModel:addUnread(id)
	if self._all:getById(id) then
		return
	end

	local mo = {
		id = id
	}

	self._all:addAtLast(mo)
	self:addAtLast(mo)

	return mo
end

function FightViewTechniqueModel:markRead(id)
	if not self._all:getById(id) or not self:getById(id) then
		return
	end

	local mo = self:getById(id)

	self:remove(mo)

	return mo
end

function FightViewTechniqueModel:getPropertyStr()
	local read = {}
	local unread = {}
	local allList = self._all:getList()

	for _, mo in ipairs(allList) do
		if self:getById(mo.id) then
			table.insert(unread, mo.id)
		else
			table.insert(read, mo.id)
		end
	end

	return string.format("%s|%s", table.concat(read, "#"), table.concat(unread, "#"))
end

function FightViewTechniqueModel:getAll()
	if self._all then
		return self._all:getList()
	end
end

function FightViewTechniqueModel:isUnlock(id)
	if self._all then
		for i, v in ipairs(self._all:getList()) do
			if v.id == id then
				return true
			end
		end
	end

	return nil
end

function FightViewTechniqueModel:readTechnique(id)
	if id and self:markRead(id) then
		local propertyStr = self:getPropertyStr()

		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, propertyStr)
	end
end

FightViewTechniqueModel.instance = FightViewTechniqueModel.New()

return FightViewTechniqueModel

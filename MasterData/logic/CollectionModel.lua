-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collection/model/CollectionModel.lua

module("logic.extensions.itembag.model.CollectionModel", package.seeall)

local CollectionModel = class("CollectionModel", BaseModel)

CollectionModel.UPDATE_SELECT_ITEM = "CollectionModel_update_select_item"

function CollectionModel:ctor()
	return
end

function CollectionModel:onInit()
	self:onReset()
end

function CollectionModel:onReset()
	self.curTabIdx = nil
	self.curItem = nil
	self._curOffset = 0
end

function CollectionModel:setCurrTabIdx(idx)
	self.curTabIdx = idx
end

function CollectionModel:getCurrTabIdx()
	self.curTabIdx = self.curTabIdx or 1

	return self.curTabIdx
end

function CollectionModel:setOffset(val)
	self._curOffset = checknumber(val)

	print("set tableview setOffset = " .. self._curOffset)
end

function CollectionModel:getOffset()
	return checknumber(self._curOffset)
end

function CollectionModel:setCurrItem(item, noDispath)
	self.curItem = item

	GlobalDispatcher:dispatch(CollectionModel.UPDATE_SELECT_ITEM)
end

function CollectionModel:getCurrItem()
	return self.curItem
end

function CollectionModel:getPlayListByType(type)
	local data = CollectionConfig.instance:getPlayListByType(type)

	table.sort(data, function(a, b)
		return a.order < b.order
	end)

	return data
end

CollectionModel.instance = CollectionModel.New()

return CollectionModel

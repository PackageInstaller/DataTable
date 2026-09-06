-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/model/HeadItemModel.lua

module("logic.extensions.headitem.model.HeadItemModel", package.seeall)

local HeadItemModel = class("HeadItemModel", BaseModel)

function HeadItemModel:ctor()
	HeadItemModel.super.ctor(self)
end

function HeadItemModel:onInit()
	self:onReset()
end

function HeadItemModel:onReset()
	self._hasInited = false
	self.headIconPool = {}
	self.headIconFramePool = {}
end

function HeadItemModel:reInited()
	self._hasInited = false
end

function HeadItemModel:init(msg)
	self._hasInited = true

	self:addIconList(msg.headIconList)
	self:addFrameList(msg.headIconFrameList)
end

function HeadItemModel:addIconList(list)
	for i, v in ipairs(list) do
		local mo = HeadItemMo.New()

		mo:initData(MatType.HeadIcon, v.id, 1)

		mo.isWear = v.isWear
		mo.overdueTime = v.overdueTime
		self.headIconPool[v.id] = mo

		if v.isWear == true then
			RoleModel.instance:setHeadIconId(v.id)
		end
	end
end

function HeadItemModel:addFrameList(list)
	for i, v in ipairs(list) do
		local mo = HeadItemMo.New()

		mo:initData(MatType.HeadFrame, v.id, 1)

		mo.isWear = v.isWear
		mo.overdueTime = v.overdueTime
		self.headIconFramePool[v.id] = mo

		if v.isWear == true then
			RoleModel.instance:setHeadFrameId(v.id)
		end
	end
end

function HeadItemModel:getHasInited()
	return self._hasInited
end

function HeadItemModel:getHeadIconList()
	local list = {}

	for i, v in pairs(self.headIconPool or {}) do
		table.insert(list, v)
	end

	return list
end

function HeadItemModel:getHeadFrameList()
	local list = {}

	for i, v in pairs(self.headIconFramePool or {}) do
		table.insert(list, v)
	end

	return list
end

function HeadItemModel:getHeadIconInfo(id)
	return self.headIconPool[id]
end

function HeadItemModel:isHaveHead(id)
	return self:getHeadIconInfo(id) ~= nil
end

function HeadItemModel:getHeadFrameInfo(id)
	return self.headIconFramePool[id]
end

function HeadItemModel:updateWearIcon(id)
	for k, v in pairs(self.headIconPool) do
		if v.id == id then
			v.isWear = true

			RoleModel.instance:setHeadIconId(v.id)
		else
			v.isWear = false
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.ON_HEAD_ITEM_CHANGE)
end

function HeadItemModel:updateWearFrame(id)
	for k, v in pairs(self.headIconFramePool) do
		if v.id == id then
			v.isWear = true

			RoleModel.instance:setHeadFrameId(v.id)
		else
			v.isWear = false
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.ON_HEAD_ITEM_CHANGE)
end

HeadItemModel.instance = HeadItemModel.New()

return HeadItemModel

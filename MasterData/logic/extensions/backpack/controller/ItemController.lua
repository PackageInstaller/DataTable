-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/controller/ItemController.lua

module("logic.extensions.backpack.controller.ItemController", package.seeall)

local M = class("ItemController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:_addEvent()
end

function M:_addEvent()
	GlobalDispatcher:addEventListener(EventType.ITEM_DEFAULT_USE_EVENT, self._dealDefaultUse, self)
	GlobalDispatcher:addEventListener(EventType.CONFIG_UPDATE_EVENT, self._handleUpdateConfig, self)
end

function M:_dealDefaultUse(e, uuid, itemId, count, param)
	BackpackAgent.instance:sendUseItemRequest(uuid, itemId, count, param)
end

function M:_handleUpdateConfig(evt, key)
	ItemModel.instance:clearAllPrefabItemData()
end

M.instance = M.New()

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonController.lua

module("logic.extensions.season.controller.SeasonController", package.seeall)

local M = class("SeasonController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.ACTIVITY_REFRESH + ActivityEnum.LogicType.SEASON, self._onSeasonActivityUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN_INIT, self._onSystemOpenInit, self)
end

function M:onLateInit()
	return
end

function M:onReset()
	self._gainItemsData = nil
end

function M:preCreate()
	ViewMgr.instance:preCreate(ViewName.SeasonNewMain)
end

function M:_onSeasonActivityUpdate()
	if SeasonFacade.instance:hasActivityOpen() then
		SeasonAgent.instance:sendSeasonInfoRequest()
	else
		ViewMgr.instance:close(ViewName.SeasonBuyVip, true)
		ViewMgr.instance:close(ViewName.SeasonNewPromote, true)
		ViewMgr.instance:close(ViewName.SeasonNewReport, true)
		ViewMgr.instance:close(ViewName.SeasonNewMain, true)
		SeasonModel.instance:setNew(true)
		SeasonModel.instance:clear()
	end
end

function M:_onSystemOpenInit()
	return
end

function M:popGainItems()
	if self._gainItemsData then
		GainItemController.instance:showGainItems(self._gainItemsData, true)
	end
end

function M:addGainItemsData(gainItemsData)
	if self._gainItemsData == nil then
		self._gainItemsData = gainItemsData
	else
		self._gainItemsData:add(gainItemsData)
	end
end

function M:clearGainItems()
	self._gainItemsData = nil
end

M.instance = M.New()

return M

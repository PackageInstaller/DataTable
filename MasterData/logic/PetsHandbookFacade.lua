-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/facade/PetsHandbookFacade.lua

module("logic.extensions.petshandbook.facade.PetsHandbookFacade", package.seeall)

local PetsHandbookFacade = class("PetsHandbookFacade")

function PetsHandbookFacade:ctor()
	return
end

function PetsHandbookFacade:getDefaultWays(raceId, idx, viewName)
	local _wayDatas = PetsHandBookModel.instance:getPetsWay(raceId)

	if not _wayDatas or #_wayDatas == 0 then
		return false
	end

	local _wayData

	GotoMgr.gotoByString((idx == nil and _wayDatas[1] or _wayDatas[idx]).jumpTo)

	return true
end

function PetsHandbookFacade:closeCurView(viewName)
	if not string.nilorempty(viewName) then
		ViewMgr.instance:close(viewName)
	end

	UIStateManager.instance:clear(true)
end

function PetsHandbookFacade:loadInfo()
	print("load handbook info")
	HandbookAgent.instance:sendUserPetManualInfoReq()
end

PetsHandbookFacade.instance = PetsHandbookFacade.New()

return PetsHandbookFacade

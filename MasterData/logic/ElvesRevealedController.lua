-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elvesrevealed/controller/ElvesRevealedController.lua

module("logic.extensions.elvesrevealed.controller.ElvesRevealedController", package.seeall)

local ElvesRevealedController = class("ElvesRevealedController", BaseController)

ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_ID = "elvesrevealed_lastTabId"
ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_MAP = "elvesrevealed_lastTabMap"

function ElvesRevealedController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._initTabMap, self)
end

function ElvesRevealedController:onReset()
	self._newTabIds = {}
end

function ElvesRevealedController:_initTabMap()
	local actId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ElvesRevealed)

	if actId <= 0 then
		return
	end

	local tabCfg = ElvesRevealedConfig.instance:getTabCfgsByActId(actId)
	local tabMaps = GameUtil.getUserData(ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_MAP)
	local curTabIds = {}

	for i, v in ipairs(tabCfg) do
		table.insert(curTabIds, v.tabId)
	end

	GameUtil.saveUserData(ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_MAP, curTabIds)

	local newTabIds = {}

	if tabMaps then
		for i, v1 in ipairs(curTabIds) do
			local isHad = table.keyof(tabMaps, v1)

			if not isHad then
				table.insert(newTabIds, v1)
			end
		end
	else
		for i, v in ipairs(tabCfg) do
			table.insert(newTabIds, v.tabId)
		end
	end

	self._newTabIds = newTabIds

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ElvesRevealed_TAB_COUNT_CHANGE, #self._newTabIds > 0)
end

function ElvesRevealedController:checkRedPoints(tabId)
	if self._newTabIds and #self._newTabIds > 0 then
		for i, v in ipairs(self._newTabIds) do
			if v == tabId then
				table.removebyvalue(self._newTabIds, tabId)

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ElvesRevealed_TAB_COUNT_CHANGE, #self._newTabIds > 0)

	return #self._newTabIds > 0
end

ElvesRevealedController.instance = ElvesRevealedController.New()

return ElvesRevealedController

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaPrizeRuleView.lua

module("logic.extensions.kingarena.view.prize.KingArenaPrizeRuleView", package.seeall)

local KingArenaPrizeRuleView = class("KingArenaPrizeRuleView", ViewComponent)

function KingArenaPrizeRuleView:buildUI()
	KingArenaPrizeRuleView.super.buildUI(self)

	self._txtWinGet = self:getTxt("part1/winGet/txt")
	self._txtLostGet = self:getTxt("part1/lostGet/txt")
	self._txtGainTips = self:getTxt("part1/gainTips")
	self._gainTipsStr = self._txtGainTips.text
	self._txtRank = self:getTxt("part2/rank/txt")
	self._iconSportsList = self:findChildGameObjectsByName(self.mainGO, "iconSportsGold")
end

function KingArenaPrizeRuleView:bindEvents()
	KingArenaPrizeRuleView.super.bindEvents(self)
end

function KingArenaPrizeRuleView:unbindEvents()
	KingArenaPrizeRuleView.super.unbindEvents(self)
end

function KingArenaPrizeRuleView:onEnter()
	KingArenaPrizeRuleView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)
	self._seasonData = KingArenaConfig.instance:getSeasonData(self._seasonId)

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGainSeasonPrizeRes, self._onUpdate, self)
	self:_onUpdate()
end

function KingArenaPrizeRuleView:onExit()
	KingArenaPrizeRuleView.super.onExit(self)

	for _, obj in ipairs(self._iconSportsList) do
		MaterialMgr.clearIcon(obj)
	end
end

function KingArenaPrizeRuleView:_onUpdate()
	self._txtWinGet.text = KingArenaConfig.instance:getCommonValue("WIN_ADD_ARENA_SCORE", true)
	self._txtLostGet.text = KingArenaConfig.instance:getCommonValue("LOST_ADD_ARENA_SCORE", true)
	self._txtGainTips.text = string.format(self._gainTipsStr, self._kingArenaMo:getMaxCanGainPrizeFightTimes())

	local bestRank = self._kingArenaMo:getBestRank()

	self._txtRank.text = bestRank <= 0 and "无" or bestRank

	local matStr = self._seasonData.exchangeItem
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	for _, obj in ipairs(self._iconSportsList) do
		MaterialMgr.setIcon(obj, matType, matId, nil, nil)
	end
end

function KingArenaPrizeRuleView:findChildGameObjectsByName(parent, targetName)
	local result = {}
	local stack = {
		parent
	}

	while #stack > 0 do
		local current = table.remove(stack)
		local transform = current.transform

		for i = 0, transform.childCount - 1 do
			local child = transform:GetChild(i)

			if child.gameObject.name == targetName then
				table.insert(result, child.gameObject)
			end

			table.insert(stack, child.gameObject)
		end
	end

	return result
end

return KingArenaPrizeRuleView

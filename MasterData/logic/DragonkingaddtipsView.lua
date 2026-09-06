-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonkingaddtipsView.lua

module("logic.extensions.dragonking.view.DragonkingaddtipsView", package.seeall)

local DragonkingaddtipsView = class("DragonkingaddtipsView", ViewComponent)

function DragonkingaddtipsView:ctor()
	DragonkingaddtipsView.super.ctor(self)
end

function DragonkingaddtipsView:unbindEvents()
	DragonkingaddtipsView.super.unbindEvents(self)
end

function DragonkingaddtipsView:bindEvents()
	DragonkingaddtipsView.super.bindEvents(self)
end

function DragonkingaddtipsView:buildUI()
	DragonkingaddtipsView.super.buildUI(self)

	self._itemList = {}

	for i = 1, 9 do
		local cell = self:getGo("itemNum_" .. i)

		table.insert(self._itemList, cell)
	end
end

function DragonkingaddtipsView:onExit()
	DragonkingaddtipsView.super.onExit(self)
end

function DragonkingaddtipsView:onEnter()
	DragonkingaddtipsView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	local activityId = self._fmtMo.activityId
	local stageId = self._fmtMo.stageId

	if not self._fmtMo.selectPetList then
		local selectPetList = {}
		local stageCfg = DragonKingChallengeConfig.instance:getStageCfgById(activityId, stageId) or {}

		self.creepsMasterId = stageCfg.creepsMasterId
		self.creeps = DragonKingChallengeConfig.instance:getCreepsConfig(self.creepsMasterId) or {}
		self._posMap = {}

		for k, v in pairs(self.creeps) do
			self._posMap[v.posId] = v
		end

		for i, cell in ipairs(self._itemList) do
			local real = goutil.findChild(cell, "real")
			local escort = goutil.findChild(cell, "escort")
			local cfg = self._posMap[i]

			GameUtil.SetActive(cell, cfg ~= nil)

			if cfg then
				GameUtil.SetActive(real, checkbool(cfg.isRealBody))
				GameUtil.SetActive(escort, table.indexof(selectPetList, cfg.creepsId) ~= false)
			end
		end
	end
end

return DragonkingaddtipsView

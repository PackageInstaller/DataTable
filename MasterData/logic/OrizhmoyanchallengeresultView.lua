-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/copy/OrizhmoyanchallengeresultView.lua

module("logic.extensions.fantian.view.copy.OrizhmoyanchallengeresultView", package.seeall)

local OrizhmoyanchallengeresultView = class("OrizhmoyanchallengeresultView", ViewComponent)

function OrizhmoyanchallengeresultView:ctor()
	OrizhmoyanchallengeresultView.super.ctor(self)
end

function OrizhmoyanchallengeresultView:unbindEvents()
	OrizhmoyanchallengeresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OrizhmoyanchallengeresultView:bindEvents()
	OrizhmoyanchallengeresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function OrizhmoyanchallengeresultView:buildUI()
	OrizhmoyanchallengeresultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtList = {}

	for i = 1, 3 do
		local txt = self:getGo("infoCon/itemInfo_" .. i)

		table.insert(self._txtList, txt)
	end
end

function OrizhmoyanchallengeresultView:onExit()
	OrizhmoyanchallengeresultView.super.onExit(self)
end

function OrizhmoyanchallengeresultView:onEnter()
	OrizhmoyanchallengeresultView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local activityId = params[1]
	local curSelectTierId = params[2]
	local curSelectLevel = params[3]
	local cfg = FanTianChallengeConfig.instance:getStageCfgById(activityId, curSelectTierId, curSelectLevel)

	self.creepsMasterId = cfg.creepsMasterId
	self.creeps = FanTianChallengeConfig.instance:getCreepsCfgById(self.creepsMasterId)

	local list = {}

	for k, crCfg in pairs(self.creeps) do
		if not string.nilorempty(crCfg.dragonSoulDesc) then
			table.insert(list, crCfg)
		end
	end

	for i, con in ipairs(self._txtList) do
		local txt = goutil.findChildTextComponent(con, "txtState")

		GameUtil.SetActive(con, false)

		txt.text = ""

		if i <= #list then
			GameUtil.SetActive(con, true)

			local crCfg = list[i]
			local hasGet = FanTianChallengeModel.instance:checkStageHasGain(activityId, curSelectTierId, curSelectLevel, crCfg.creepsId)

			txt.text = hasGet and "<color=#20b376>已获得</color>" or "<color=#eb4642>未获得</color>"
		end
	end
end

function OrizhmoyanchallengeresultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return OrizhmoyanchallengeresultView

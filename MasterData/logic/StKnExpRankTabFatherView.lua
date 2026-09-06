-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpRankTabFatherView.lua

module("logic.extensions.stknexp.view.StKnExpRankTabFatherView", package.seeall)

local StKnExpRankTabFatherView = class("StKnExpRankTabFatherView", TabFrameWorkMainView)

function StKnExpRankTabFatherView:onEnter()
	self._activityId = self:_getFrameParams().frameId
	self._subMo = StKnExpController.instance:getSubMo(self._activityId)

	StKnExpRankTabFatherView.super.onEnter(self)
end

function StKnExpRankTabFatherView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	StKnExpRankTabFatherView.super._updateSecTabCell(self, mainGo, headTabIndex, secTabIndex)

	local info = self:_getSecTabViewInfo(headTabIndex, secTabIndex)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	if not string.nilorempty(info.data.params) then
		local params = string.split(info.data.params, "#")
		local zoneId = checknumber(params[1])
		local data = StKnExpConfig.instance:getZoneData(self._activityId, zoneId)

		if data and txtName then
			txtName.text = data.name
		end
	end
end

function StKnExpRankTabFatherView:_getFrameId()
	return TabFrameWorkEnum.FrameIds_StKnExp
end

function StKnExpRankTabFatherView:_getDefaultSecTabIndex(headTabIndex)
	local secTabIndex = 0
	local cfg = StKnExpConfig.instance:getZoneCfg(self._activityId) or {}

	for zoneId, data in ipairs(cfg) do
		if self._subMo:isUnlockZone(zoneId) then
			secTabIndex = zoneId
		end
	end

	return secTabIndex
end

return StKnExpRankTabFatherView

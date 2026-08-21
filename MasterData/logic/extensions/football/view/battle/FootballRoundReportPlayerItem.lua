-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/battle/FootballRoundReportPlayerItem.lua

module("logic.extensions.football.view.battle.FootballRoundReportPlayerItem", package.seeall)

local M = class("FootballRoundReportPlayerItem", UIReusableLuaBehavior)

function M:buildUI()
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._imgHead = goutil.findChildImageComponent(self.mainGO, "imgHead")
	self._goPriorityCounter = goutil.findChild(self.mainGO, "sign")

	goutil.setActive(self._goPriorityCounter, false)

	self._userInfoMO = false
end

function M:destroyUI()
	self._txtName = false
	self._imgHead = false
	self._goPriorityCounter = false
	self._userInfoMO = false
end

function M:getTeamId()
	return self._userInfoMO.teamId
end

function M:getUserId()
	return self._userInfoMO.userId
end

function M:setUserInfoMO(userInfoMO)
	self._userInfoMO = userInfoMO
	self._txtName.text = userInfoMO.nickname

	IconLoader.setSprite(self._imgHead, IconType.HeadIcon, userInfoMO:getIconName())
end

function M:setPriorityCounter(enable)
	goutil.setActive(self._goPriorityCounter, enable)
end

return M

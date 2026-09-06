-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/raiders/RaidersCommonView.lua

module("logic.extensions.legend.view.raiders.RaidersCommonView", package.seeall)

local RaidersCommonView = class("RaidersCommonView", ViewComponent)

function RaidersCommonView:buildUI()
	RaidersCommonView.super.buildUI(self)

	self._txtPart1Desc1 = self:getTxt("part1/txtRule1")
	self._txtPart1Desc2 = self:getTxt("part1/txtRule2")
	self._txtPart2Desc1 = self:getTxt("part2/txtRule1")
	self._txtPart2Desc2 = self:getTxt("part2/txtRule2")
	self._txtPart1Rule2Go = self:getGo("part1/txtRule2")
	self._txtPart2Rule2Go = self:getGo("part2/txtRule2")
	self._togSelect = self:getToggle("togSelect")
	self._togPetName = self:getTxt("togSelect/txtPetName")
end

function RaidersCommonView:bindEvents()
	RaidersCommonView.super.bindEvents(self)
end

function RaidersCommonView:unbindEvents()
	RaidersCommonView.super.unbindEvents(self)
end

function RaidersCommonView:onEnter()
	RaidersCommonView.super.onEnter(self)

	local param = self:getFirstParam()

	self._challengeId = param.challengeId
	self._stageId = param.stageId
	self._txtCfg = param.txtCfg
	self._challengeName = param.challengeName
	self._togSelect.isOn = GameUtil.getUserDayData(MissionConst.MissionLegend .. self._challengeId)
	self._togPetName.text = self._challengeName
	self._txtPart1Desc1.text = self._txtCfg.playRule1
	self._txtPart1Desc2.text = self._txtCfg.playRule2
	self._txtPart2Desc1.text = self._txtCfg.winRule1
	self._txtPart2Desc2.text = self._txtCfg.winRule2

	goutil.setActive(self._txtPart1Rule2Go, not string.nilorempty(self._txtCfg.playRule2))
	goutil.setActive(self._txtPart2Rule2Go, not string.nilorempty(self._txtCfg.winRule2))
end

function RaidersCommonView:onExit()
	RaidersCommonView.super.onExit(self)
	GameUtil.saveUserDayData(MissionConst.MissionLegend .. self._challengeId, self._togSelect.isOn)
end

return RaidersCommonView

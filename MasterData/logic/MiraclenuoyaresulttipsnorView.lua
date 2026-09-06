-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyaresulttipsnorView.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyaresulttipsnorView", package.seeall)

local MiraclenuoyaresulttipsnorView = class("MiraclenuoyaresulttipsnorView", ViewComponent)

function MiraclenuoyaresulttipsnorView:ctor()
	MiraclenuoyaresulttipsnorView.super.ctor(self)

	self._banRaceIds = {}
end

function MiraclenuoyaresulttipsnorView:buildUI()
	MiraclenuoyaresulttipsnorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtCurDamage = goutil.findChildTextComponent(self.mainGO, "txtCurDamage")
	self._txtMaxDamage = goutil.findChildTextComponent(self.mainGO, "txtMaxDamage")
end

function MiraclenuoyaresulttipsnorView:bindEvents()
	MiraclenuoyaresulttipsnorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, function()
		self:close()
		BattleController.instance:endBattle()
	end, self)
end

function MiraclenuoyaresulttipsnorView:unbindEvents()
	MiraclenuoyaresulttipsnorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MiraclenuoyaresulttipsnorView:onEnter()
	MiraclenuoyaresulttipsnorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self:close()

		return
	end

	local curFightDamage = 0
	local normalClgTodayMaxDamage = 0
	local pb = MiracleNuoyaModel.instance.norFightEndPb

	if pb then
		curFightDamage = pb.curFightDamage
		normalClgTodayMaxDamage = math.max(pb.curFightDamage, (pb.normalClgInfo or nil) and (pb.normalClgInfo.normalClgTodayMaxDamage or 0))
	end

	self._txtCurDamage.text = curFightDamage
	self._txtMaxDamage.text = normalClgTodayMaxDamage
end

function MiraclenuoyaresulttipsnorView:onExit()
	MiraclenuoyaresulttipsnorView.super.onExit(self)
end

return MiraclenuoyaresulttipsnorView

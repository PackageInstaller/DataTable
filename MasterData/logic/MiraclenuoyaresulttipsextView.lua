-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyaresulttipsextView.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyaresulttipsextView", package.seeall)

local MiraclenuoyaresulttipsextView = class("MiraclenuoyaresulttipsextView", ViewComponent)

function MiraclenuoyaresulttipsextView:ctor()
	MiraclenuoyaresulttipsextView.super.ctor(self)

	self._banRaceIds = {}
end

function MiraclenuoyaresulttipsextView:buildUI()
	MiraclenuoyaresulttipsextView.super.buildUI(self)

	self._btnSave = goutil.findChild(self.mainGO, "btnSave")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtLeftHp = goutil.findChildTextComponent(self.mainGO, "txtLeftHp")
	self._txtBuff = goutil.findChildTextComponent(self.mainGO, "txtBuff")
end

function MiraclenuoyaresulttipsextView:bindEvents()
	MiraclenuoyaresulttipsextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnSave, self._onClickBtnSave, self)
end

function MiraclenuoyaresulttipsextView:unbindEvents()
	MiraclenuoyaresulttipsextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnSave)
end

function MiraclenuoyaresulttipsextView:onEnter()
	MiraclenuoyaresulttipsextView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._pb = MiracleNuoyaModel.instance.extFightEndPb

	if self._pb then
		local desc = ""
		local tb = MiracleNuoyaConfig.instance:getBuffListCfg(self._pb.activityId) or {}
		local list = {}

		for k, v in pairs(tb) do
			table.insert(list, v)
		end

		ArraySort.sortOn(list, "buffId", ArraySort.NUMERIC)

		for i, v in ipairs(list) do
			if self._pb.extremeClgSupportPetLeftHpPercent >= v.leftHpPercent then
				desc = v.buffDesc or ""

				break
			end
		end

		self._txtBuff.text = desc
		self._txtLeftHp.text = string.format("剩余血量：%d%%", self._pb.extremeClgSupportPetLeftHpPercent)
	end

	self.addGEvent(self, GlobalNotify.MiracleNuoYaConfirmExtre, self._handleMiracleNuoYaConfirmExtre, self)
end

function MiraclenuoyaresulttipsextView:onExit()
	MiraclenuoyaresulttipsextView.super.onExit(self)
end

function MiraclenuoyaresulttipsextView:_handleMiracleNuoYaConfirmExtre(status)
	if status == 0 then
		local activityId = self._activityId
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = MiracleNuoyaController.instance:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end
	end

	self:close()
	BattleController.instance:endBattle()
end

function MiraclenuoyaresulttipsextView:_onClickBtnSave()
	if self._pb then
		MiracleNuoyaController.instance:sendConfirmExtre(self._pb.activityId, self._pb.confirmNum, true)
	end
end

function MiraclenuoyaresulttipsextView:_onClickBtnSure()
	if self._pb then
		MiracleNuoyaController.instance:sendConfirmExtre(self._pb.activityId, self._pb.confirmNum, false)
	end
end

return MiraclenuoyaresulttipsextView

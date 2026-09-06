-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicHudGoto1View.lua

module("logic.extensions.psychicimprove.view.PsychicHudGoto1View", package.seeall)

local PsychicHudGoto1View = class("PsychicHudGoto1View", ViewComponent)

function PsychicHudGoto1View:buildUI()
	PsychicHudGoto1View.super.buildUI(self)

	self._btnGoto = self:getGo("btnGoto")
	self._rd = goutil.findChild(self._btnGoto, "rd")
	self._txtTime = self:getTxt("time/txtTime")
	self._reportBehaviorId = 201437
end

function PsychicHudGoto1View:bindEvents()
	PsychicHudGoto1View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function PsychicHudGoto1View:unbindEvents()
	PsychicHudGoto1View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
end

function PsychicHudGoto1View:onEnter()
	PsychicHudGoto1View.super.onEnter(self)

	self.hudCfg = self:getFirstParam()

	local funcId = checkint(self.hudCfg and self.hudCfg.funcId)
	local isOpen = true

	if funcId > 0 then
		isOpen = FuncOpenModel.instance:getFuncIsOpen(funcId)

		local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)
		local openTime = funcCfg and funcCfg.openTime

		if not string.nilorempty(openTime) then
			openTime = string.gsub(string.gsub(string.gsub(openTime, ":00:00", ":00"), "-", "."), "#", "-")
			self._txtTime.text = langPara("活动时间：%s", openTime)
		end
	end

	GameUtil.SetGray(self._btnGoto, not isOpen)
	goutil.setActive(self._rd, false)
	RedPointController.instance:regRedPoint(self._rd, unpack(string.split(self.hudCfg.redpointId or "", "#")))
end

function PsychicHudGoto1View:onExit()
	PsychicHudGoto1View.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._rd)
end

function PsychicHudGoto1View:_onClickGoto()
	self.hudCfg = self:getFirstParam()

	SurveyController.instance:reportBehavior(self._reportBehaviorId)

	local funcId = checkint(self.hudCfg and self.hudCfg.funcId)

	if (funcId > 0 or nil) and FuncOpenController.instance:checkFuncIdOrShowLockTips(funcId) then
		GotoMgr.gotoByString(self.hudCfg.parameter)
	end
end

return PsychicHudGoto1View

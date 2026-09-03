-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/StageResetPopViewMediator.lua

StageResetPopViewMediator = class("StageResetPopViewMediator", DmPopupViewMediator, _M)

StageResetPopViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StageResetPopViewMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kBtnHandlers = {
	["main.btn_ok.button"] = {
		func = "onClickOk"
	}
}

function StageResetPopViewMediator:initialize()
	super.initialize(self)
end

function StageResetPopViewMediator:dispose()
	super.dispose(self)
end

function StageResetPopViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.btn_ok", OneLevelMainButton, {})
end

function StageResetPopViewMediator:enterWithData(data)
	self._data = data

	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("CUSTOM_MISSION_RESET")
	})
	self:initContent()
end

function StageResetPopViewMediator:initContent()
	local couldResetTimes = self:playerVip2ResetTimes()
	local curResetTimes = self._data.resetTimes
	local str = curResetTimes .. "/" .. couldResetTimes
	local timeText = self:getView():getChildByFullName("main.node2.times_text")

	timeText:setString(Strings:get("Condi_Elite_Desc", {
		times = str
	}))

	local resetCost = self:getView():getChildByFullName("main.node1.cost_text")

	resetCost:setString(self._data.resetCost)
end

function StageResetPopViewMediator:playerVip2ResetTimes()
	local playerVipLevel = self._developSystem:getPlayer():getVipLevel()
	local times = ConfigReader:getDataByNameIdAndKey("Vip", playerVipLevel, "EliteBuyNum")

	return times or 1
end

function StageResetPopViewMediator:onCloseClicked(sender, eventType)
	self:close()
end

function StageResetPopViewMediator:onClickOk(sender, eventType)
	if self._data.resetTimes >= self:playerVip2ResetTimes() then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = Strings:get("SPECIAL_STAGE_TEXT_8")
		}))

		return
	end

	local bagSystem = self._developSystem:getBagSystem()

	if not bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, self._data.resetCost, {
		type = "tip"
	}) then
		return
	end

	self._stageSystem:requestResetPointTimes(self._data.mapId, self._data.pointId, true)
	self:close()
end

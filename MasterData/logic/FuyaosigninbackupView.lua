-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaohud/view/FuyaosigninbackupView.lua

module("logic.extensions.fuyaohud.view.FuyaosigninbackupView", package.seeall)

local FuyaosigninbackupView = class("FuyaosigninbackupView", OperationSignInView)

function FuyaosigninbackupView:unbindEvents()
	FuyaosigninbackupView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
end

function FuyaosigninbackupView:bindEvents()
	FuyaosigninbackupView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function FuyaosigninbackupView:buildUI()
	FuyaosigninbackupView.super.buildUI(self)

	self._txtPetDesc = self:getTxt("txtPetDesc")
	self._btnGet = self:getBtn("btnGet")
end

function FuyaosigninbackupView:onExit()
	FuyaosigninbackupView.super.onExit(self)
end

function FuyaosigninbackupView:onEnter()
	FuyaosigninbackupView.super.onEnter(self)
end

function FuyaosigninbackupView:_getShowRaceId()
	return 10333
end

function FuyaosigninbackupView:_getEffectPath()
	return "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
end

function FuyaosigninbackupView:_getYPos()
	return 0
end

function FuyaosigninbackupView:_onClickbtnGet()
	local cfg = OperationSignInConfig.instance:getSignInExtra(self.activityId)

	if cfg and not string.nilorempty(cfg.jumpTo) then
		GotoMgr.gotoByString(cfg.jumpTo)
		self:close()
	end
end

function FuyaosigninbackupView:_setJumpBtn()
	local cfg = OperationSignInConfig.instance:getSignInExtra(self.activityId)

	goutil.setActive(self._btnGet.gameObject, cfg)

	if not cfg then
		return
	end
end

return FuyaosigninbackupView

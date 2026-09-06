-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/divinemiuke/DivineMiuKeMainView.lua

module("logic.extensions.watertianyan.view.divinemiuke.DivineMiuKeMainView", package.seeall)

local DivineMiuKeMainView = class("DivineMiuKeMainView", WaterTianYanMainView)

function DivineMiuKeMainView:buildUI()
	DivineMiuKeMainView.super.buildUI(self)

	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
end

function DivineMiuKeMainView:onEnter()
	DivineMiuKeMainView.super.onEnter(self)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function DivineMiuKeMainView:onExit()
	DivineMiuKeMainView.super.onExit(self)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function DivineMiuKeMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

function DivineMiuKeMainView:_getActivityId()
	return WaterTianYanModel.instance:getDivineMiuKeActivityId()
end

return DivineMiuKeMainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signinbuff/view/CommonSignInBuffView.lua

module("logic.extensions.signinbuff.view.CommonSignInBuffView", package.seeall)

local CommonSignInBuffView = class("CommonSignInBuffView", ViewComponent)

function CommonSignInBuffView:buildUI()
	CommonSignInBuffView.super.buildUI(self)

	self._btnGainBuff = self:getGo("btnGain")
	self._txtDescBuff = self:getTxt("txtDesc")
	self._goBuffIcon = self:getGo("cell/con")
	self._redBuff = self:getGo("cell/red")
	self._goBuffLevel = self:getGo("level")
	self._txtBuffLevel = self:getTxt("level/txt")
end

function CommonSignInBuffView:onEnter()
	CommonSignInBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	SignInBuffController.instance:regSignInBuffPart(self._activityId, ViewName.CommonSignInBuffView, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function CommonSignInBuffView:onExit()
	CommonSignInBuffView.super.onExit(self)
	SignInBuffController.instance:unregSignInBuffPart(self._activityId, ViewName.CommonSignInBuffView, self._btnGainBuff)
end

function CommonSignInBuffView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffLevel = checknumber(param.buffLevel)

	GameUtil.SetActive(self._goBuffLevel, buffLevel > 0)

	if buffLevel > 0 then
		self._txtBuffLevel.text = string.format("Lv.%d", buffLevel)
	end

	local buffCfg = param.buffCfg
	local displayBuffCfg = buffCfg

	if not displayBuffCfg and buffLevel == 0 then
		local buffCfgs = SignInBuffConfig.instance:getBuffCfgsByActId(self._activityId)

		displayBuffCfg = buffCfgs and buffCfgs[1]
	end

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or lang("点击激活Buff")
	end

	local icon = displayBuffCfg and displayBuffCfg.icon

	if string.nilorempty(icon) then
		uGuiUtil.clearImage(self._goBuffIcon)
	else
		uGuiUtil.setSpriteToImage(self._goBuffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconUrl(icon))
	end
end

return CommonSignInBuffView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/webofficialpay/view/WebofficialpaymainView.lua

module("logic.extensions.webofficialpay.view.WebofficialpaymainView", package.seeall)

local WebofficialpaymainView = class("WebofficialpaymainView", ViewComponent)
local waitTime = 1

function WebofficialpaymainView:ctor()
	WebofficialpaymainView.super.ctor(self)
end

function WebofficialpaymainView:unbindEvents()
	WebofficialpaymainView.super.unbindEvents(self)
end

function WebofficialpaymainView:bindEvents()
	WebofficialpaymainView.super.bindEvents(self)
end

function WebofficialpaymainView:buildUI()
	WebofficialpaymainView.super.buildUI(self)

	self._effect = self:getGo("effect")
	self._txtNum = self:getTxt("cell/txtNum")
	self._imgIcon = self:getGo("cell/imgIcon")
end

function WebofficialpaymainView:onExit()
	WebofficialpaymainView.super.onExit(self)

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	removetimer(self._playTween, self)
end

function WebofficialpaymainView:onExitFinished()
	WebofficialpaymainView.super.onExitFinished(self)
	WebOfficialPayController.instance:tryShowNextAni()
end

function WebofficialpaymainView:onEnter()
	WebofficialpaymainView.super.onEnter(self)

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	removetimer(self._playTween, self)

	local param = self:getFirstParam()

	if not param then
		self:close()

		return
	end

	local mo = param.mo

	MaterialMgr.setIcon(self._imgIcon, mo.type, mo.id)

	self._totalNum = param.toCount
	self._curlNum = param.fromCount
	self._txtNum.text = self._curlNum
end

function WebofficialpaymainView:onEnterFinished()
	WebofficialpaymainView.super.onEnterFinished(self)

	local effPath = "20250110/baoxiangxiaoguo/fx_ui_baoxiangbaokai_01.prefab"

	self:playViewEffectUniGo(effPath, self._effect, nil, false, function()
		self:close()
	end, function()
		if self.tween then
			self.tween:Kill(false)

			self.tween = nil
		end

		settimer(waitTime, self._playTween, self, false)
	end)
end

function WebofficialpaymainView:_playTween()
	self.tween = TweenUtil.ValueTo(self._curlNum, self._totalNum, 0.5, function(val)
		self._txtNum.text = math.floor(val)
	end, function()
		if self.tween then
			self.tween:Kill(false)

			self.tween = nil
		end
	end, self)
end

return WebofficialpaymainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/view/DivineTianShanBattleExView.lua

module("logic.extensions.divinetianshanclg.view.DivineTianShanBattleExView", package.seeall)

local DivineTianShanBattleExView = class("DivineTianShanBattleExView", ViewComponent)

function DivineTianShanBattleExView:ctor()
	DivineTianShanBattleExView.super.ctor(self)
end

function DivineTianShanBattleExView:unbindEvents()
	DivineTianShanBattleExView.super.unbindEvents(self)
end

function DivineTianShanBattleExView:bindEvents()
	DivineTianShanBattleExView.super.bindEvents(self)
end

function DivineTianShanBattleExView:buildUI()
	DivineTianShanBattleExView.super.buildUI(self)

	self._fillImg = self:getImg("buffNum/fillImg")
	self._txtName = self:getTxt("buffNum/txtName")
	self._txtCurPorgress = self:getTxt("buffNum/txtCurPorgress")
	self._show = self:getGo("show")
	self._cg = self._show:GetComponent("CanvasGroup")
end

function DivineTianShanBattleExView:onExit()
	DivineTianShanBattleExView.super.onExit(self)

	if self._tween then
		self._tween:Kill(false)

		self._tween = nil
	end
end

function DivineTianShanBattleExView:onEnter()
	DivineTianShanBattleExView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BuffLayerNumChange, self._onBuffLayerNumChange, self)

	self._param = DivineTianShanClgController.instance:getExBuffParam()
	self._curLayout = 0
	self._buffProgress = 10
	self._clientBuffId = 0

	goutil.setActive(self._show, false)

	if self._param then
		self._clientBuffId = checknumber(self._param.clientBuffId)
		self._buffProgress = checknumber(self._param.buffProgress)
		self._txtName.text = langPara("%s进度", self._param.exTips)
	end

	self:updateLayout()
end

function DivineTianShanBattleExView:_onBuffLayerNumChange(buff)
	if buff and buff:getBuffId() == self._clientBuffId then
		self._curLayout = buff.layerNum

		self:updateLayout()
	end
end

function DivineTianShanBattleExView:updateLayout()
	self._txtCurPorgress.text = langPara("%s/%s", self._curLayout, self._buffProgress)
	self._fillImg.fillAmount = self._curLayout / self._buffProgress

	if self._curLayout >= self._buffProgress then
		self:_playShow()
	end
end

function DivineTianShanBattleExView:_playShow()
	goutil.setActive(self._show, true)

	self._txtCurPorgress.text = langPara("%s展开", self._param.exTips)
	self._curLayout = 0

	if self._tween then
		self._tween:Kill(false)

		self._tween = nil
	end

	self._tween = TweenUtil.ValueTo(1, 0, 1.5, function(val)
		self._cg.alpha = val
	end, function()
		self._tween = nil

		goutil.setActive(self._show, false)
		self:updateLayout()
	end, self, DG.Tweening.Ease.Linear)
end

return DivineTianShanBattleExView

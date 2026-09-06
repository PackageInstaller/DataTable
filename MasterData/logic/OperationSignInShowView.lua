-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/OperationSignInShowView.lua

module("logic.extensions.operationsignin.view.OperationSignInShowView", package.seeall)

local OperationSignInShowView = class("OperationSignInShowView", ViewComponent)
local SIGN_IN_NUM = 8

function OperationSignInShowView:ctor()
	OperationSignInShowView.super.ctor(self)
end

function OperationSignInShowView:buildUI()
	OperationSignInShowView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._signInCells = {}

	for i = 1, SIGN_IN_NUM do
		local cell = {}

		cell.go = self:getGo("cell_" .. i)
		cell.btn = GameUtil.asBtn(goutil.findChild(cell.go, "btnVideo"))
		cell.effectGo = goutil.findChild(cell.go, "effect")
		cell.effect = nil

		table.insert(self._signInCells, cell)
	end

	self._switchEffGo = self:getGo("effect")
end

function OperationSignInShowView:bindEvents()
	OperationSignInShowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, #self._signInCells do
		self._signInCells[i].btn:AddClickListener(function()
			self:_onClickVideo(i)
		end, self)
	end
end

function OperationSignInShowView:unbindEvents()
	OperationSignInShowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function OperationSignInShowView:destroyUI()
	OperationSignInShowView.super.destroyUI(self)
end

function OperationSignInShowView:onEnter()
	OperationSignInShowView.super.onEnter(self)

	self._changeSetId = nil

	local params = self:getOpenParam()

	if params then
		self._changeSetId = params[1]

		self:_showEffect(checknumber(params[2]))
	end
end

function OperationSignInShowView:onEnterFinished()
	OperationSignInShowView.super.onEnterFinished(self)
end

function OperationSignInShowView:onExit()
	OperationSignInShowView.super.onExit(self)

	if self._switchEffect then
		UIEffectManager.instance:stopEffect(self._switchEffect)

		self._switchEffect = nil
	end

	for i = 1, SIGN_IN_NUM do
		if self._signInCells[i].effect then
			UIEffectManager.instance:stopEffect(self._signInCells[i].effect)

			self._signInCells[i].effect = nil
		end
	end
end

function OperationSignInShowView:onExitFinished()
	OperationSignInShowView.super.onExitFinished(self)
end

function OperationSignInShowView:_showEffect(id)
	if self._switchEffect then
		UIEffectManager.instance:stopEffect(self._switchEffect)

		self._switchEffect = nil
	end

	local effectPath = "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_05_blue.prefab"

	self._switchEffect = UIEffectManager.instance:playEffect(self, effectPath, self._switchEffGo.transform, 0, 0, false, false, function()
		self:_showSingleEffect(id)
	end, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._switchEffect:setParent(self._switchEffGo.transform)
	self._switchEffect:setLocalPos(0, 0, 0)
	self._switchEffect:setScale(1)
end

function OperationSignInShowView:_showSingleEffect(i)
	if self._signInCells[i].effect then
		UIEffectManager.instance:stopEffect(self._signInCells[i].effect)

		self._signInCells[i].effect = nil
	end

	local effectPath = "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_anniu.prefab"

	self._signInCells[i].effect = UIEffectManager.instance:playEffect(self, effectPath, self._signInCells[i].effectGo.transform, 0, 0, false, false, function()
		self:_onEffectEnd()
	end, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._signInCells[i].effect:setParent(self._signInCells[i].effectGo.transform)
end

function OperationSignInShowView:_onEffectEnd()
	if checknumber(self._changeSetId) > 0 then
		MaterialFacade.instance:popAndShowChangeSetItems(self._changeSetId)
	end
end

function OperationSignInShowView:_onClickVideo(id)
	self:_showEffect(id)
end

return OperationSignInShowView

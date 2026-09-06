-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbbattleresultView.lua

module("logic.extensions.fbbchallenge.view.FbbbattleresultView", package.seeall)

local FbbbattleresultView = class("FbbbattleresultView", ViewComponent)

function FbbbattleresultView:ctor()
	FbbbattleresultView.super.ctor(self)
end

function FbbbattleresultView:buildUI()
	FbbbattleresultView.super.buildUI(self)

	self._txtTotalDamage = goutil.findChildTextComponent(self.mainGO, "bg/totalDamage/Text")
	self._txtCurDamage = goutil.findChildTextComponent(self.mainGO, "bg/curDamage/Text")
	self._btnOk = self:getBtn("bg/bg_3/btnOk")
end

function FbbbattleresultView:bindEvents()
	FbbbattleresultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickbtnOk, self)
end

function FbbbattleresultView:unbindEvents()
	FbbbattleresultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function FbbbattleresultView:destroyUI()
	FbbbattleresultView.super.destroyUI(self)
end

function FbbbattleresultView:onEnter()
	FbbbattleresultView.super.onEnter(self)

	self._params = FbbchallengeModel.instance:getBattleEndShowParams()

	FbbchallengeModel.instance:clearBattleEndShowParams()
	self:_updateView()
end

function FbbbattleresultView:onEnterFinished()
	FbbbattleresultView.super.onEnterFinished(self)
end

function FbbbattleresultView:onExit()
	FbbbattleresultView.super.onExit(self)
end

function FbbbattleresultView:onExitFinished()
	FbbbattleresultView.super.onExitFinished(self)
end

function FbbbattleresultView:_onClickbtnOk()
	self:close()
end

function FbbbattleresultView:_updateView()
	self._txtTotalDamage.text = self._params.totalDamage
	self._txtCurDamage.text = self._params.curDamage
end

return FbbbattleresultView

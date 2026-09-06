-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidereditView.lua

module("logic.extensions.treasureraider.view.TreasureraidereditView", package.seeall)

local TreasureraidereditView = class("TreasureraidereditView", ViewComponent)

function TreasureraidereditView:ctor()
	TreasureraidereditView.super.ctor(self)
end

function TreasureraidereditView:unbindEvents()
	TreasureraidereditView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnConfirm)
	GameUtil.rmClickHandler(self._btnBack)
end

function TreasureraidereditView:bindEvents()
	TreasureraidereditView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnConfirm, self._onClickConfirm, self)
	GameUtil.addClickHandler(self._btnBack, self._onClickBack, self)
end

function TreasureraidereditView:buildUI()
	TreasureraidereditView.super.buildUI(self)

	self._btnConfirm = self:getGo("btnConfirm")
	self._btnCancel = self:getGo("btnCancel")
	self._btnBack = self:getGo("lefttop/btn_back")
	self._txtRemainCount = self:getTxt("txtRemainCount")
	self._mainEffectGo = self:getGo("effect")
end

function TreasureraidereditView:onExit()
	TreasureraidereditView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderCloseEditMapView, self.close, self)
	TREditorController.instance:exitEdit()
	self:_removeMainEffect()
end

function TreasureraidereditView:onEnter()
	TreasureraidereditView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderCloseEditMapView, self.close, self)
	TREditorController.instance:enterEdit()

	local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()

	self._txtRemainCount.text = langPara("当前剩余次数: %s", sceneMo.myPlayerMo:getEditCountRemain())
end

function TreasureraidereditView:onEnterFinished()
	TreasureraidereditView.super.onEnterFinished(self)
	self:_addMainEffect()
end

function TreasureraidereditView:_removeMainEffect()
	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end
end

function TreasureraidereditView:_addMainEffect()
	self:_removeMainEffect()

	local effectPath = "20221223/duobaoqibing/fx_ui_duobaoqibing.prefab"
	local eff = UIEffectManager.instance:playEffect(self, effectPath, self._mainEffectGo.transform, 0, 0, true)

	eff:setParent(self._mainEffectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._mainEffect = eff
end

function TreasureraidereditView:_onClickConfirm()
	self:_doClose(TRMode_Edit.ExitFlag_Confirm)
end

function TreasureraidereditView:_onClickCancel()
	self:_doClose(TRMode_Edit.ExitFlag_Cancel)
end

function TreasureraidereditView:_onClickBack()
	self:_doClose(TRMode_Edit.ExitFlag_Close)
end

function TreasureraidereditView:_doClose(flag)
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderTryEndEdit, flag)
end

return TreasureraidereditView

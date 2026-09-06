-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tcpanduola/PopupBuffView.lua

module("logic.extensions.timelimitedchallenge.view.PopupBuffView", package.seeall)

local PopupBuffView = class("PopupBuffView", ViewComponent)

function PopupBuffView:unbindEvents()
	PopupBuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PopupBuffView:bindEvents()
	PopupBuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function PopupBuffView:onExit()
	PopupBuffView.super.onExit(self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = nil
end

function PopupBuffView:buildUI()
	PopupBuffView.super.buildUI(self)

	self._buffCell = PanduolaBuffCell.New(self:getGo("buffCell"))
	self._txtTitle = self:getTxt("txtTitle")
	self._btnClose = self:getBtn("btnClose")
end

function PopupBuffView:onEnter()
	PopupBuffView.super.onEnter(self)

	local params = self:getOpenParam()

	params = params[1]
	self._okHandler = params.okHandler
	self._okTarget = params.okTarget

	self._buffCell:updateWithPanduolaBuffId(params.buffId)
	self:_setEffectUrls()
	self:_createEffs()
end

function PopupBuffView:_onClickClose()
	self:close()
	GameUtil.callBack(self._okHandler, self._okTarget)
end

function PopupBuffView:_createEffs()
	self._effs = {}

	for _, v in ipairs(self._effPaths) do
		local parent = self.mainGO

		if not string.nilorempty(v.goPath) then
			parent = self:getGo(v.goPath)
		end

		local eff = UIEffectManager.instance:playEffect(self, v.path, parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setLocalEulerAngle(0, 0, 0)
		table.insert(self._effs, eff)
	end
end

function PopupBuffView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "point_fx",
			path = "fx_ui_xianshitiaozhan/fx_ui_kaiqipanduolalzhihe.prefab"
		}
	}
end

return PopupBuffView

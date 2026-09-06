-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/view/PetTitleTipView.lua

module("logic.extensions.pettitle.view.PetTitleTipView", package.seeall)

local PetTitleTipView = class("PetTitleTipView", ViewComponent)

function PetTitleTipView:ctor()
	PetTitleTipView.super.ctor(self)
end

function PetTitleTipView:unbindEvents()
	PetTitleTipView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PetTitleTipView:bindEvents()
	PetTitleTipView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function PetTitleTipView:buildUI()
	PetTitleTipView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._name = goutil.findChildTextComponent(self.mainGO, "bg/name")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "bg/tipView/Viewport/tipText")
	self._petTitleIcon = self:getGo("bg/petTitleIcon")
end

function PetTitleTipView:onExit()
	PetTitleTipView.super.onExit(self)
	MaterialMgr.resetAll(self._petTitleIcon)
end

function PetTitleTipView:onEnter()
	PetTitleTipView.super.onEnter(self)

	local id = tonumber(self:getFirstParam())
	local conf = PetTitleConfig.instance:getPetTitleConfig(id)

	self._name.text = conf.name
	self._tipText.text = conf.desc

	local proxy = MaterialMgr.setCell(MatType.PetTitle, id, self._petTitleIcon)

	proxy.binder:setAutoTips(false)
end

function PetTitleTipView:_onClickClose()
	CommonTipsMgr.instance:closeAllTips()
end

return PetTitleTipView

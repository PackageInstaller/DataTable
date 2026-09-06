-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerTipsView.lua

module("logic.extensions.waterdraktower.view.WLTowerTipsView", package.seeall)

local WLTowerTipsView = class("WLTowerTipsView", ViewComponent)

function WLTowerTipsView:ctor()
	WLTowerTipsView.super.ctor(self)
end

function WLTowerTipsView:bindEvents()
	WLTowerTipsView.super.bindEvents(self)
	GameUtil.asBtn(self._boxGo):AddClickListener(self.close, self)
end

function WLTowerTipsView:unbindEvents()
	WLTowerTipsView.super.unbindEvents(self)
	GameUtil.asBtn(self._boxGo):RemoveClickListener()
end

function WLTowerTipsView:onExit()
	WLTowerTipsView.super.onExit(self)
end

function WLTowerTipsView:destroyUI()
	WLTowerTipsView.super.destroyUI(self)
end

function WLTowerTipsView:buildUI()
	WLTowerTipsView.super.buildUI(self)

	local container = self:getGo("container")

	self._boxGo = goutil.findChild(container, "viewBoxGo")
	self._descTxt = goutil.findChildTextComponent(container, "viewBgGo/bossDescTxt")
	self._descTxt.text = ""
end

function WLTowerTipsView:onEnter()
	WLTowerTipsView.super.onEnter(self)

	local ceng = self:getFirstParam()

	self._descTxt.text = langPara("text_wltower_desc_11", checknumber(ceng))
end

return WLTowerTipsView

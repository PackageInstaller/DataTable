-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogeteggView.lua

module("logic.extensions.zoo.view.ZoogeteggView", package.seeall)

local ZoogeteggView = class("ZoogeteggView", ViewComponent)

function ZoogeteggView:ctor()
	ZoogeteggView.super.ctor(self)
end

function ZoogeteggView:buildUI()
	ZoogeteggView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._name = goutil.findChildTextComponent(self.mainGO, "bg/icon/name")
	self._icon = self:getGo("bg/icon")
	self._geneCell = self:getGo("bg/item_gene")
	self._normalGenes = self:getGo("bg/normal/sc")
	self._normalEmpty = self:getGo("bg/normal/empty")
	self._normalView = ScrollerList.create(self._normalGenes, self._geneCell, GameUtil.handler(self._updateCell, self))
	self._special = self:getGo("bg/special/sc")
	self._specialView = ScrollerList.create(self._special, self._geneCell, GameUtil.handler(self._updateCell, self))
	self._specialEmpty = self:getGo("bg/special/empty")
end

function ZoogeteggView:bindEvents()
	ZoogeteggView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZoogeteggView:unbindEvents()
	ZoogeteggView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZoogeteggView:destroyUI()
	ZoogeteggView.super.destroyUI(self)
end

function ZoogeteggView:onEnter()
	ZoogeteggView.super.onEnter(self)
	goutil.setActive(self._titleIcon, true)

	self._eggMo = self:getFirstParam()
	self._name.text = self._eggMo.name

	self._eggMo:refreshNormalGeneView(self._normalView)
	self._eggMo:refreshSpecialGeneView(self._specialView)
	goutil.setActive(self._normalEmpty, not (#self._eggMo.showGeneArray > 1))
	uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._eggMo.icon))
end

function ZoogeteggView:onEnterFinished()
	ZoogeteggView.super.onEnterFinished(self)
end

function ZoogeteggView:onExit()
	ZoogeteggView.super.onExit(self)
	uGuiUtil.clearImage(self._icon)
end

function ZoogeteggView:onExitFinished()
	ZoogeteggView.super.onExitFinished(self)
end

function ZoogeteggView:_updateCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

return ZoogeteggView

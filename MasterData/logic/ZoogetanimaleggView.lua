-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogetanimaleggView.lua

module("logic.extensions.zoo.view.ZoogetanimaleggView", package.seeall)

local ZoogetanimaleggView = class("ZoogetanimaleggView", ViewComponent)

function ZoogetanimaleggView:ctor()
	ZoogetanimaleggView.super.ctor(self)
end

function ZoogetanimaleggView:buildUI()
	ZoogetanimaleggView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._eggIcon = self:getGo("eggIcon")
	self._geneCell = self:getGo("item_gene")
	self._normal = self:getGo("normal/sc")
	self._normalView = ScrollerList.create(self._normal, self._geneCell, GameUtil.handler(self._updateCell, self))
end

function ZoogetanimaleggView:bindEvents()
	ZoogetanimaleggView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZoogetanimaleggView:unbindEvents()
	ZoogetanimaleggView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZoogetanimaleggView:destroyUI()
	ZoogetanimaleggView.super.destroyUI(self)
end

function ZoogetanimaleggView:onEnter()
	ZoogetanimaleggView.super.onEnter(self)

	local eggMo = self:getFirstParam()

	uGuiUtil.setSpriteToImage(self._eggIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(eggMo.icon))
	eggMo:refreshNormalGeneView(self._normalView)
end

function ZoogetanimaleggView:onEnterFinished()
	ZoogetanimaleggView.super.onEnterFinished(self)
end

function ZoogetanimaleggView:onExit()
	ZoogetanimaleggView.super.onExit(self)
	uGuiUtil.clearImage(self._eggIcon)
end

function ZoogetanimaleggView:onExitFinished()
	ZoogetanimaleggView.super.onExitFinished(self)
end

function ZoogetanimaleggView:_updateCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

return ZoogetanimaleggView

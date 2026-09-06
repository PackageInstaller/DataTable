-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogetanimalView.lua

module("logic.extensions.zoo.view.ZoogetanimalView", package.seeall)

local ZoogetanimalView = class("ZoogetanimalView", ViewComponent)

function ZoogetanimalView:ctor()
	ZoogetanimalView.super.ctor(self)
end

function ZoogetanimalView:buildUI()
	ZoogetanimalView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._animalIcon = self:getGo("animalIcon")
	self._name = self:getTxt("txtName")
	self._generation = goutil.findChildTextComponent(self._animalIcon, "generation")
	self._geneCell = self:getGo("item_gene")
	self._normal = self:getGo("normal/sc")
	self._special = self:getGo("special/sc")
	self._normalView = ScrollerList.create(self._normal, self._geneCell, GameUtil.handler(self._updateCell, self))
	self._specialView = ScrollerList.create(self._special, self._geneCell, GameUtil.handler(self._updateCell, self))
	self._shareBtn = self:getBtn("shareBtn")
end

function ZoogetanimalView:bindEvents()
	ZoogetanimalView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._shareBtn:AddClickListener(self._onClickShare, self)
end

function ZoogetanimalView:unbindEvents()
	ZoogetanimalView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._shareBtn:RemoveClickListener()
end

function ZoogetanimalView:destroyUI()
	ZoogetanimalView.super.destroyUI(self)
end

function ZoogetanimalView:onEnter()
	ZoogetanimalView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._animalMo = openParam[1]
	self._name.text = self._animalMo.name

	self._animalMo:refreshNormalGeneView(self._normalView)
	self._animalMo:refreshSpecialGeneView(self._specialView)

	self._animalShow, self._avatar = self._animalMo:showAnimalAvatar(self._animalIcon, 240, 256, 0.56, 0.45)
end

function ZoogetanimalView:onEnterFinished()
	ZoogetanimalView.super.onEnterFinished(self)
end

function ZoogetanimalView:onExit()
	ZoogetanimalView.super.onExit(self)
	self._normalView:dispose()
	self._animalShow:clear()
	self._avatar:destroy()
end

function ZoogetanimalView:onExitFinished()
	ZoogetanimalView.super.onExitFinished(self)
end

function ZoogetanimalView:_updateCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

function ZoogetanimalView:_onClickClose()
	self:close()
end

function ZoogetanimalView:_onClickShare()
	UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.Zoo, self._animalMo)
end

return ZoogetanimalView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoofollowView.lua

module("logic.extensions.zoo.view.ZoofollowView", package.seeall)

local ZoofollowView = class("ZoofollowView", ViewComponent)

function ZoofollowView:buildUI()
	ZoofollowView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._cancelBtn = self:getBtn("btns/cancelBtn")
	self._changeBtn = self:getBtn("btns/changeBtn")
	self._cell = self:getGo("item_gene")
	self._normalView = ScrollerList.create(self:getGo("right/normal/genes"), self._cell, GameUtil.handler(self._updateCell, self))
	self._specialView = ScrollerList.create(self:getGo("right/special/genes"), self._cell, GameUtil.handler(self._updateCell, self))
	self._name = self:getTxt("left/nameText")
	self._lv = self:getTxt("left/lvText")
	self._image = self:getGo("left/image")
end

function ZoofollowView:bindEvents()
	ZoofollowView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._cancelBtn:AddClickListener(self._onClickCancel, self)
	self._changeBtn:AddClickListener(self._onClickChange, self)
end

function ZoofollowView:unbindEvents()
	ZoofollowView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._changeBtn:RemoveClickListener()
end

function ZoofollowView:onEnter()
	ZoofollowView.super.onEnter(self)

	self._animalMo = self:getFirstParam()
	self._name.text = self._animalMo.name
	self._lv.text = string.format(lang("lv_number_nospace"), self._animalMo.level)
	self._show, self._avatar = self._animalMo:showAnimalAvatar(self._image, 128, 256, 0.74, 0.6)

	self._animalMo:refreshNormalGeneView(self._normalView)
	self._animalMo:refreshSpecialGeneView(self._specialView)

	local myZoo = ZooModel.instance:getMyZoo()

	if not myZoo then
		ZooController.instance:getMyZooInfo()
	end
end

function ZoofollowView:onExitFinished()
	self._show:clear()
	self._avatar:destroy()
	ZoofollowView.super.onExitFinished(self)
end

function ZoofollowView:_onClickCancel()
	ZooController.instance:sendPM_AnimalSetFollowStateReq(self._animalMo.id, false)
	self:close()
end

function ZoofollowView:_onClickChange()
	ZooController.instance:openSelectView(ZooController.ANIMALTYPE, function(ids)
		self:close()
		UIStateManager.instance:push(ViewName.ZoofollowsureView, ZooModel.instance:getMyAnimalById(ids[1]), self._animalMo)
	end, nil, ZooController.Once, nil, lang("petzoo_animalinfo_follow"))
end

function ZoofollowView:_updateCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

return ZoofollowView

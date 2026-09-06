-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoogetanimalbeforeView.lua

module("logic.extensions.zoo.view.ZoogetanimalbeforeView", package.seeall)

local ZoogetanimalbeforeView = class("ZoogetanimalbeforeView", ViewComponent)

function ZoogetanimalbeforeView:buildUI()
	ZoogetanimalbeforeView.super.buildUI(self)

	self._inputName = self:getInput("inputName")
	self._closeBtn = self:getBtn("bg/closeBtn")
	self._geneCell = self:getGo("item_gene")
	self._normal = self:getGo("normal/sc")
	self._special = self:getGo("special/sc")
	self._normalView = ScrollerList.create(self._normal, self._geneCell, GameUtil.handler(self._updateCell, self))
	self._specialView = ScrollerList.create(self._special, self._geneCell, GameUtil.handler(self._updateCell, self))
	self._enterBtn = self:getBtn("enterBtn")
	self._animal = self:getGo("animal")
end

function ZoogetanimalbeforeView:bindEvents()
	ZoogetanimalbeforeView.super.bindEvents(self)
	self._inputName:AddOnValueChanged(self._onInputValueChange, self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._enterBtn:AddClickListener(self._onClickEnter, self)
end

function ZoogetanimalbeforeView:unbindEvents()
	ZoogetanimalbeforeView.super.unbindEvents(self)
	self._inputName:RemoveOnValueChanged()
	self._closeBtn:RemoveClickListener()
	self._enterBtn:RemoveClickListener()
end

function ZoogetanimalbeforeView:onEnter()
	ZoogetanimalbeforeView.super.onEnter(self)

	self._animalMo = self:getFirstParam()

	self._inputName:SetText(self._animalMo.name)
	self._animalMo:refreshNormalGeneView(self._normalView)
	self._animalMo:refreshSpecialGeneView(self._specialView)

	self._animalShow, self._avatar = self._animalMo:showAnimalAvatar(self._animal, 280.4, 433.2, 0.56, 0.45)

	GlobalDispatcher:addListener(GlobalNotify.ZooTakeAnimalOutFromHatch, self._takeAnimalOutFromSlot, self)
end

function ZoogetanimalbeforeView:onExit()
	ZoogetanimalbeforeView.super.onExit(self)
	self._animalShow:clear()
	self._avatar:destroy()
	GlobalDispatcher:removeListener(GlobalNotify.ZooTakeAnimalOutFromHatch, self._takeAnimalOutFromSlot, self)
end

function ZoogetanimalbeforeView:_takeAnimalOutFromSlot(slotId, animalId)
	self:close()

	local myZoo = ZooModel.instance:getMyZoo()
	local animalMo = myZoo:getAnimalById(animalId)

	UIStateManager.instance:push(ViewName.ZoogetanimalView, animalMo)
end

function ZoogetanimalbeforeView:_onClickEnter()
	local openParam, newName = self:getOpenParam(), self._inputName:GetText()

	if ZooController.instance:checkNameValid(newName) then
		ZooController.instance:sendPM_TakeAnimalOutFromSlotReq(openParam[2], newName)
	end
end

function ZoogetanimalbeforeView:_onClickClose()
	local openParam, newName = self:getOpenParam(), self._inputName:GetText()

	if newName == self._animalMo.name then
		ZooController.instance:sendPM_TakeAnimalOutFromSlotReq(openParam[2], newName)
	else
		self:close()
	end
end

function ZoogetanimalbeforeView:_updateCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

return ZoogetanimalbeforeView

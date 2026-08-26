-- chunkname: @modules/logic/survival/view/shelter/ShelterCurrencyView.lua

module("modules.logic.survival.view.shelter.ShelterCurrencyView", package.seeall)

local ShelterCurrencyView = class("ShelterCurrencyView", BaseView)

function ShelterCurrencyView:onInitView()
	self.goRoot = gohelper.findChild(self.viewGO, self.rootGOPath)
	self._gocurrency = gohelper.findChild(self.goRoot, "tag")
	self._txtNum = gohelper.findChildTextMesh(self.goRoot, "tag/#txt_tag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShelterCurrencyView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterCurrencyView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterCurrencyView:ctor(param, path)
	ShelterCurrencyView.super.ctor(self)

	self.param = param
	self.rootGOPath = path
end

function ShelterCurrencyView:_editableInitView()
	return
end

function ShelterCurrencyView:onDestroyView()
	return
end

function ShelterCurrencyView:onOpen()
	self:onShelterBagUpdate()
end

function ShelterCurrencyView:onClose()
	return
end

function ShelterCurrencyView:onShelterBagUpdate()
	if not self.param then
		gohelper.setActive(self._gocontainer, false)

		return
	end

	local itemId = self.param[1]
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self._txtNum.text = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getItemCountPlus(itemId)
end

return ShelterCurrencyView

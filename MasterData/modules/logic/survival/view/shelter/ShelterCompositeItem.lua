-- chunkname: @modules/logic/survival/view/shelter/ShelterCompositeItem.lua

module("modules.logic.survival.view.shelter.ShelterCompositeItem", package.seeall)

local ShelterCompositeItem = class("ShelterCompositeItem", ListScrollCellExtend)

function ShelterCompositeItem:ctor(param)
	self.compositeView = param.compositeView
	self.index = param.index
end

function ShelterCompositeItem:onInitView()
	self.goUnChoose = gohelper.findChild(self.viewGO, "#go_unchoose")
	self.btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unchoose/#btn_click")
	self.goChoose = gohelper.findChild(self.viewGO, "#go_choosed")
	self.btnRemove = gohelper.findChildButtonWithAudio(self.viewGO, "#go_choosed/#btn_remove")
	self.goInfoView = gohelper.findChild(self.viewGO, "#go_choosed/#go_infoview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShelterCompositeItem:addEvents()
	self.addClickCb(self, self.btnAdd, self.onClickAdd, self)
	self.addClickCb(self, self.btnRemove, self.onClickRemove, self)
end

function ShelterCompositeItem:removeEvents()
	self:removeClickCb(self.btnAdd)
	self:removeClickCb(self.btnRemove)
end

function ShelterCompositeItem:_editableInitView()
	return
end

function ShelterCompositeItem:onClickAdd()
	self.compositeView:showMaterialView(self.index)
end

function ShelterCompositeItem:onClickRemove()
	self.compositeView:removeMaterialData(self.index)
end

function ShelterCompositeItem:onUpdateMO(mo)
	self.itemMo = mo

	self:refreshView()
end

function ShelterCompositeItem:refreshView()
	gohelper.setActive(self.goUnChoose, self.itemMo == nil)
	gohelper.setActive(self.goChoose, self.itemMo ~= nil)
	self:refreshInfoView()
end

function ShelterCompositeItem:refreshInfoView()
	if not self._infoPanel then
		local infoViewRes = self.compositeView.viewContainer:getSetting().otherRes.infoView
		local infoGo = self.compositeView.viewContainer:getResInst(infoViewRes, self.goInfoView)

		self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

		local t = {
			[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.Info,
			[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.Info
		}

		self._infoPanel:setChangeSource(t)
	end

	self._infoPanel:updateMo(self.itemMo)
end

function ShelterCompositeItem:onDestroyView()
	return
end

return ShelterCompositeItem

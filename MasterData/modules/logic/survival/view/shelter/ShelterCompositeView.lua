-- chunkname: @modules/logic/survival/view/shelter/ShelterCompositeView.lua

module("modules.logic.survival.view.shelter.ShelterCompositeView", package.seeall)

local ShelterCompositeView = class("ShelterCompositeView", BaseView)

function ShelterCompositeView:onInitView()
	self.goMaterial1 = gohelper.findChild(self.viewGO, "Panel/Left/#go_material1")
	self.goMaterial2 = gohelper.findChild(self.viewGO, "Panel/Left/#go_material2")
	self.materialItem1 = MonoHelper.addNoUpdateLuaComOnceToGo(self.goMaterial1, ShelterCompositeItem, {
		index = 1,
		compositeView = self
	})
	self.materialItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self.goMaterial2, ShelterCompositeItem, {
		index = 2,
		compositeView = self
	})
	self.goRightEmpty = gohelper.findChild(self.viewGO, "Panel/Right/#go_material3/empty")
	self.goRightHas = gohelper.findChild(self.viewGO, "Panel/Right/#go_material3/has")
	self.imageRightQuality = gohelper.findChildImage(self.viewGO, "Panel/Right/#go_material3/has/#image_quality")
	self.txtRightTips = gohelper.findChildTextMesh(self.viewGO, "Panel/Right/#go_material3/has/tips/#txt_tips")
	self.txtCount = gohelper.findChildTextMesh(self.viewGO, "Panel/Right/#txt_count")
	self.btnUncomposite = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/#btn_uncomposite")
	self.btnComposite = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/#btn_composite")
end

function ShelterCompositeView:addEvents()
	self.addClickCb(self, self.btnUncomposite, self.onClickUncomposite, self)
	self.addClickCb(self, self.btnComposite, self.onClickComposite, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnClickBagItem, self.onClickBagItem, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterCompositeView:removeEvents()
	self:removeClickCb(self.btnUncomposite)
	self:removeClickCb(self.btnComposite)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnClickBagItem, self.onClickBagItem, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterCompositeView:onShelterBagUpdate()
	self:refreshView()
end

function ShelterCompositeView:onEquipCompound(cmd, resultCode, msg)
	if resultCode == 0 then
		local item = msg.item
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init(item)

		itemMo.source = SurvivalEnum.ItemSource.Shelter

		local param = {
			itemMo = itemMo
		}

		ViewMgr.instance:openView(ViewName.ShelterCompositeSuccessView, param)
	end
end

function ShelterCompositeView:onClickUncomposite()
	self:onClickComposite()
end

function ShelterCompositeView:onClickComposite()
	local data1 = self:getSelectData(1)
	local data2 = self:getSelectData(2)
	local allSelect = data1 ~= nil and data2 ~= nil

	if not allSelect then
		GameFacade.showToast(ToastEnum.SurvivalCompositeSelectItem)

		return
	end

	local costStr = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterCompositeCost)
	local isEnough, itemId, costCount, curCount = self:getBag():costIsEnough(costStr)

	if not isEnough then
		local itemConfig = lua_survival_item.configDict[itemId]

		GameFacade.showToast(ToastEnum.DiamondBuy, itemConfig.name)

		return
	end

	local uids = {}

	table.insert(uids, data1.uid)
	table.insert(uids, data2.uid)
	SurvivalWeekRpc.instance:sendSurvivalEquipCompound(uids, self.onEquipCompound, self)
end

function ShelterCompositeView:onClickBagItem(itemMo)
	if not self.selectIndex then
		return
	end

	if itemMo then
		self.selectData[self.selectIndex] = itemMo.uid or nil
	end

	self.viewContainer:closeMaterialView()
	self:refreshView()
end

function ShelterCompositeView:showMaterialView(index)
	self.selectIndex = index

	self.viewContainer:showMaterialView(index)
end

function ShelterCompositeView:removeMaterialData(index)
	self.selectData[index] = nil

	self:refreshView()
end

function ShelterCompositeView:isSelectItem(slotId, itemMo)
	if not itemMo then
		return false
	end

	for k, uid in pairs(self.selectData) do
		if k ~= slotId and uid == itemMo.uid then
			return true
		end
	end
end

function ShelterCompositeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	self:refreshParam()
	self:refreshView()
end

function ShelterCompositeView:refreshParam()
	self.selectData = {}
	self.selectIndex = nil
end

function ShelterCompositeView:refreshView()
	self:refreshMaterialItem()
	self:refreshRight()
end

function ShelterCompositeView:refreshMaterialItem()
	self.materialItem1:onUpdateMO(self:getSelectData(1))
	self.materialItem2:onUpdateMO(self:getSelectData(2))
end

function ShelterCompositeView:refreshRight()
	local data1 = self:getSelectData(1)
	local data2 = self:getSelectData(2)
	local allSelect = data1 ~= nil and data2 ~= nil

	gohelper.setActive(self.goRightEmpty, not allSelect)
	gohelper.setActive(self.goRightHas, allSelect)

	if allSelect then
		local quality = math.min(data1.co.rare, data2.co.rare)

		UISpriteSetMgr.instance:setSurvivalSprite(self.imageRightQuality, string.format("survival_bag_itemquality%s", quality))

		self.txtRightTips.text = luaLang(string.format("survivalcompositeview_equip_tip%s", quality))
	end

	local costStr = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterCompositeCost)
	local isEnough, itemId, costCount, curCount = self:getBag():costIsEnough(costStr)

	self.txtCount.text = isEnough and string.format("%s/%s", curCount, costCount) or string.format("<color=#D74242>%s</color>/%s", curCount, costCount)

	gohelper.setActive(self.btnUncomposite, not allSelect or not isEnough)
	gohelper.setActive(self.btnComposite, allSelect and isEnough)
end

function ShelterCompositeView:getBag()
	return SurvivalMapHelper.instance:getBagMo()
end

function ShelterCompositeView:getSelectData(index)
	local uid = self.selectData[index]

	if not uid then
		return
	end

	local bag = self:getBag()

	return (bag:getItemByUid(uid))
end

function ShelterCompositeView:onClose()
	return
end

return ShelterCompositeView

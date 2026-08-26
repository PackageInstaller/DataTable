-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiConfirmSelectionView.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiConfirmSelectionView", package.seeall)

local V3a6YaMiConfirmSelectionView = class("V3a6YaMiConfirmSelectionView", BaseView)

function V3a6YaMiConfirmSelectionView:onInitView()
	self._gomission = gohelper.findChild(self.viewGO, "root/right/bg_target")
	self._txtmission = gohelper.findChildText(self.viewGO, "root/right/bg_target/#txt_mission")
	self._btnclick1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/part1/icon_edit/#btn_click")
	self._txtproductname = gohelper.findChildText(self.viewGO, "root/left/part1/txt_name")
	self._simagecurrentproducts = gohelper.findChildSingleImage(self.viewGO, "root/left/part1/#simage_currentproducts")
	self._btnclick2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/part2/icon_edit/#btn_click")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/right/bg_money/#txt_num")
	self._gocategoryroot = gohelper.findChild(self.viewGO, "root/left/part1/#grid_v3a6_dormitorymode_categoryitem")
	self._goemployeeroot = gohelper.findChild(self.viewGO, "root/left/part2/#scroll_hero/Viewport/content")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "root/right/progress/#slider_progress")
	self._imgsliderprogress = gohelper.findChildImage(self.viewGO, "root/right/progress/#slider_progress/fg")
	self._simageproducts = gohelper.findChildSingleImage(self.viewGO, "root/right/go_preview/#simage_products")
	self._txtname = gohelper.findChildText(self.viewGO, "root/right/go_preview/#txt_name")
	self._gopreview = gohelper.findChild(self.viewGO, "root/right/go_preview")
	self._goempty = gohelper.findChild(self.viewGO, "root/right/go_emtpy")
	self.clickCollider = ZProj.BoxColliderClickListener.Get(self._sliderprogress.gameObject)

	self.clickCollider:SetIgnoreUI(true)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiConfirmSelectionView:addEvents()
	self._btnclick1:AddClickListener(self._btnclick1OnClick, self)
	self._btnclick2:AddClickListener(self._btnclick2OnClick, self)
	self._sliderprogress:AddOnValueChanged(self._onSliderEdit, self)
	self.clickCollider:AddMouseUpListener(self._onMouseUp, self)
	self.clickCollider:AddClickListener(self._onMouseDown, self)
end

function V3a6YaMiConfirmSelectionView:removeEvents()
	self._btnclick1:RemoveClickListener()
	self._btnclick2:RemoveClickListener()
	self._sliderprogress:RemoveOnValueChanged()
	self.clickCollider:RemoveMouseUpListener()
	self.clickCollider:RemoveClickListener()
end

function V3a6YaMiConfirmSelectionView:_btnclick1OnClick()
	V3a6YaMiController.instance:openProductView()
end

function V3a6YaMiConfirmSelectionView:_btnclick2OnClick()
	V3a6YaMiController.instance:openSelectHeroView()
end

function V3a6YaMiConfirmSelectionView:_onMouseDown()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_hua_lp)
end

function V3a6YaMiConfirmSelectionView:_onMouseUp()
	self:_cancelSliderAudio()
end

function V3a6YaMiConfirmSelectionView:_onSliderEdit()
	if self._isEnterPerform then
		self:_cancelSliderAudio()

		return
	end

	local isCanEnter, toast = V3a6YaMiModel.instance:isCanEnterPerform()

	if not isCanEnter and toast then
		GameFacade.showToast(toast)

		return
	end

	local sliderValue = self._sliderprogress:GetValue()

	self._imgsliderprogress.fillAmount = sliderValue

	if sliderValue >= 0.95 and isCanEnter then
		V3a6YaMiController.instance:enterResearch()
		V3a6YaMiStatHelper.instance:StartResearch()

		self._isEnterPerform = true

		self:_cancelSliderAudio()
		self:closeThis()

		return
	end
end

function V3a6YaMiConfirmSelectionView:_cancelSliderAudio()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.stop_ui_renmen_waiwei_hua_lp)
end

function V3a6YaMiConfirmSelectionView:_editableInitView()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmMatrials, self._onSelectProductMaterial, self)

	self._root = gohelper.findChild(self.viewGO, "root/left/part2")
	self._attrPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._root, V3a6YaMiAttrPanel)
end

function V3a6YaMiConfirmSelectionView:onUpdateParam()
	self:refreshView()
end

function V3a6YaMiConfirmSelectionView:_onSelectProductMaterial()
	V3a6YaMiModel.instance:getGenerateProduct()
	self:_refreshProduct()
end

function V3a6YaMiConfirmSelectionView:refreshView()
	self:_refreshProduct()
	self:_refreshHeros()
	self:_refreshMission()
end

function V3a6YaMiConfirmSelectionView:_refreshProduct()
	local curMoney = V3a6YaMiModel.instance:getCurrencyNum()
	local cost = V3a6YaMiModel.instance:getCurSelectMaterialCost()
	local productMo = V3a6YaMiModel.instance:getWillProductMo()
	local subType, materials = V3a6YaMiModel.instance:getSelectMaterials()
	local isLock = not productMo or productMo.isLock

	if subType and materials then
		local mo = V3a6YaMiModel.instance:getMaterialMo(subType)

		self._txtproductname.text = mo.co.name
		self._txtname.text = productMo.co.name

		local icon = ResUrl.getV3a6YaMiCollectionSingleBg(mo.co.icon)

		self._simagecurrentproducts:LoadImage(icon)

		local path = V3a6YaMiEnum.ResPath.v3a6_dormitorymode_categoryitem
		local prefab = self.viewContainer:getRes(path)
		local list = {}

		for _, id in ipairs(materials) do
			local mo = V3a6YaMiModel.instance:getMaterialMo(id)

			table.insert(list, mo)
		end

		gohelper.CreateObjList(self, self.onCreateProductItem, list, self._gocategoryroot, prefab, V3a6YaMiMaterialItem)

		if not isLock then
			local producticon = ResUrl.getV3a6YaMiItemSingleBg(productMo.co.icon)

			self._simageproducts:LoadImage(producticon)
		end
	end

	gohelper.setActive(self._goempty, isLock)
	gohelper.setActive(self._gopreview, not isLock)

	self._txtnum.text = curMoney - cost
end

function V3a6YaMiConfirmSelectionView:_refreshMission()
	local missionMo = V3a6YaMiModel.instance:getCurMissionMo()

	if missionMo then
		local co = missionMo.co

		self._txtmission.text = co.desc
	end

	gohelper.setActive(self._gomission, missionMo ~= nil)
end

function V3a6YaMiConfirmSelectionView:_refreshHeros()
	local heros = V3a6YaMiModel.instance:getSelectHeros()

	if heros then
		local path = V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employeeitem
		local prefab = self.viewContainer:getRes(path)
		local list = {}

		for _, id in ipairs(heros) do
			local mo = V3a6YaMiModel.instance:getHeroMoById(id)

			table.insert(list, mo)
		end

		gohelper.CreateObjList(self, self.onCreateEmployeeItem, list, self._goemployeeroot, prefab, V3a6YaMiSelectHeroItem)
	end

	local attrMo = V3a6YaMiModel.instance:getHeroTeamAttrMo()

	self._attrPanel:onRefresh(attrMo, false)
end

function V3a6YaMiConfirmSelectionView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan)

	self._isEnterPerform = false

	self:refreshView()
	self._sliderprogress:SetValue(0)

	self._imgsliderprogress.fillAmount = 0
end

function V3a6YaMiConfirmSelectionView:onCreateProductItem(itemGo, data, index)
	itemGo:onUpdateMO(data, true)
end

function V3a6YaMiConfirmSelectionView:onCreateEmployeeItem(itemGo, data, index)
	itemGo:onUpdateMO(data)
end

function V3a6YaMiConfirmSelectionView:onClose()
	self:_cancelSliderAudio()
end

function V3a6YaMiConfirmSelectionView:onDestroyView()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmMatrials, self._onSelectProductMaterial, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmSelectHeros, self._refreshHeros, self)
	self._simagecurrentproducts:UnLoadImage()
	self._simageproducts:UnLoadImage()
end

return V3a6YaMiConfirmSelectionView

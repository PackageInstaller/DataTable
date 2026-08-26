-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiProductView.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiProductView", package.seeall)

local V3a6YaMiProductView = class("V3a6YaMiProductView", BaseView)

function V3a6YaMiProductView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gomission = gohelper.findChild(self.viewGO, "root/right/layout/#bg_target")
	self._txtmission = gohelper.findChildText(self.viewGO, "root/right/layout/#bg_target/#txt_mission")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/right/layout/#bg_funds/#txt_num")
	self._gotarget = gohelper.findChild(self.viewGO, "root/right/layout/currentproducts")
	self._txttarget = gohelper.findChildText(self.viewGO, "root/right/layout/currentproducts/#txt_target")
	self._simagecurrentproducts = gohelper.findChildSingleImage(self.viewGO, "root/right/layout/currentproducts/#simage_currentproducts")
	self._goempty = gohelper.findChild(self.viewGO, "root/right/layout/currentproducts/#go_empty")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_next")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_handbook")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiProductView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
end

function V3a6YaMiProductView:removeEvents()
	self._btnnext:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
end

function V3a6YaMiProductView:_btnnextOnClick()
	V3a6YaMiModel.instance:saveSelectMaterials()
	V3a6YaMiController.instance:onEnterNextView()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onConfirmMatrials)
	self:closeThis()
end

function V3a6YaMiProductView:_btnhandbookOnClick()
	local param = {
		orginView = self.viewName
	}

	V3a6YaMiController.instance:openProductHandbookView(param)
end

function V3a6YaMiProductView:_editableInitView()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectProductMaterial, self._onSelectProductMaterial, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmProductRecipe, self._onConfirmProductRecipe, self)

	self._animTarget = self._gotarget:GetComponent(typeof(UnityEngine.Animator))
	self._productItems = self:getUserDataTb_()

	local path = V3a6YaMiEnum.ResPath.v3a6_dormitorymode_categoryitem
	local prefab = self.viewContainer:getRes(path)

	for _, type in pairs(V3a6YaMiEnum.MaterialType) do
		self._productItems[type] = self:getUserDataTb_()

		local list = V3a6YaMiModel.instance:getMaterialMosByType(type)

		table.sort(list, self.sortMaterials)

		local root = gohelper.findChild(self.viewGO, string.format("root/left/part%s/#grid_v3a6_dormitorymode_categoryitem", type))

		gohelper.CreateObjList(self, self.onCreateProductItem, list, root, prefab, V3a6YaMiSelectMaterialItem)

		local txtMaxCount = gohelper.findChildText(self.viewGO, string.format("root/left/part%s/txt_name/txt", type))

		if txtMaxCount then
			local lang = luaLang("v3a6_yami_selectproduct_tip1")
			local const = V3a6YaMiEnum.MaterialInfo[type].ConstId
			local maxCount = V3a6YaMiConfig.instance:getConstValueByConst(const)

			txtMaxCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, maxCount)
		end
	end

	gohelper.setActive(self._gotarget, true)

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function V3a6YaMiProductView.sortMaterials(a, b)
	return a.co.id < b.co.id
end

function V3a6YaMiProductView:onCreateProductItem(itemGo, data, index)
	itemGo:onUpdateMO(data)

	self._productItems[data.co.type][index] = itemGo
end

function V3a6YaMiProductView:onUpdateParam()
	return
end

function V3a6YaMiProductView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan)
	V3a6YaMiModel.instance:refreshSelectMaterials()
	self._animPlayer:Play("v3a6_dormitorymode_choosematerialsview_open", self._playedOpenAnim, self)
	self:_refreshMission()
	self:_refreshProduct()
end

function V3a6YaMiProductView:_playedOpenAnim()
	local isPlayAudio = false

	for _, list in pairs(self._productItems) do
		for _, item in pairs(list) do
			local isPlay = item:checkPlayUnlock()

			if not isPlayAudio and isPlay then
				isPlayAudio = true
			end
		end
	end

	if isPlayAudio then
		AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_shua)
	end
end

function V3a6YaMiProductView:_refreshMission()
	local missionMo = V3a6YaMiModel.instance:getCurMissionMo()

	if missionMo then
		local co = missionMo.co

		self._txtmission.text = co.desc
	end

	gohelper.setActive(self._gomission, missionMo ~= nil)
end

function V3a6YaMiProductView:_refreshProduct()
	for _, list in pairs(self._productItems) do
		for _, item in pairs(list) do
			item:refreshSelect()
		end
	end

	self:_refreshNextBtn()
	self:_checkGenerateProduct()
end

function V3a6YaMiProductView:_onConfirmProductRecipe(id)
	self:_refreshProduct()
end

function V3a6YaMiProductView:_onSelectProductMaterial(type, id)
	self:_refreshProduct()
end

function V3a6YaMiProductView:_refreshNextBtn()
	local isUnselect = V3a6YaMiModel.instance:isUnselectProductMaterial()

	gohelper.setActive(self._btnnext.gameObject, not isUnselect)
end

function V3a6YaMiProductView:_checkGenerateProduct()
	local mo = V3a6YaMiModel.instance:getGenerateProduct()

	if not self._lastProductId or mo and self._lastProductId ~= mo.id or not mo and self._lastProductId and self._lastProductId > 0 then
		self._animTarget:Play("switch", 0, 0)
	end

	TaskDispatcher.cancelTask(self._refreshGenerateProduct, self)
	TaskDispatcher.runDelay(self._refreshGenerateProduct, self, 0.16)

	if mo then
		self._lastProductId = mo.id or -1
	end
end

function V3a6YaMiProductView:_refreshGenerateProduct()
	local mo = V3a6YaMiModel.instance:getGenerateProduct()
	local curMoney = V3a6YaMiModel.instance:getCurrencyNum()
	local isUnlockLock = mo and not mo.isLock
	local productName = "???"

	if isUnlockLock then
		productName = mo.co.name

		local icon = ResUrl.getV3a6YaMiItemSingleBg(mo.co.icon)

		self._simagecurrentproducts:LoadImage(icon)
	end

	local cost = V3a6YaMiModel.instance:getCurSelectMaterialCost()
	local lang = luaLang("v3a6_yami_selectproduct_tip2")

	self._txttarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, productName)

	local lang2 = luaLang("v3a6_yami_selectproduct_rewardnum")

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang2, curMoney, cost)

	gohelper.setActive(self._goempty, not isUnlockLock)
	gohelper.setActive(self._simagecurrentproducts.gameObject, isUnlockLock)
end

function V3a6YaMiProductView:onClose()
	return
end

function V3a6YaMiProductView:onDestroyView()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectProductMaterial, self._onSelectProductMaterial, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmProductRecipe, self._onConfirmProductRecipe, self)
	self._simagecurrentproducts:UnLoadImage()
end

return V3a6YaMiProductView

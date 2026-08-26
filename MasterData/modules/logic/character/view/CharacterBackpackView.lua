-- chunkname: @modules/logic/character/view/CharacterBackpackView.lua

module("modules.logic.character.view.CharacterBackpackView", package.seeall)

local CharacterBackpackView = class("CharacterBackpackView", BaseView)

function CharacterBackpackView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorolecategory = gohelper.findChild(self.viewGO, "category/#go_rolecategory")
	self._goequipcategory = gohelper.findChild(self.viewGO, "category/#go_equipcategory")
	self._goequipsub = gohelper.findChild(self.viewGO, "category/#go_equipsub")
	self._goequipsubcategory1 = gohelper.findChild(self.viewGO, "category/#go_equipsub/#go_equipsubcategory1")
	self._goequipsubcategory2 = gohelper.findChild(self.viewGO, "category/#go_equipsub/#go_equipsubcategory2")
	self._goequipsubcategory3 = gohelper.findChild(self.viewGO, "category/#go_equipsub/#go_equipsubcategory3")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterBackpackView:addEvents()
	return
end

function CharacterBackpackView:removeEvents()
	return
end

function CharacterBackpackView:_editableInitView()
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgimg")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))

	self._isFirstOpenCharacter = true
	self._isFirstOpenEquip = true
end

function CharacterBackpackView:initCategory()
	self._categoryList = self:getUserDataTb_()

	self:_refreshCategorys()
end

function CharacterBackpackView:_refreshCategorys(force_tab)
	for _, v in ipairs(self._categoryList) do
		v:destroyView()
	end

	self._categoryList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[2]
	local child = self:getResInst(path, self._gorolecategory)
	local item = CharacterCategoryItem.New()

	item:initView(child, {
		index = 1,
		enName = "CREW",
		name = luaLang("activitynovicesign_character")
	})
	table.insert(self._categoryList, item)
	self:_setCategory(force_tab)
end

function CharacterBackpackView:_onFuncUnlockRefresh()
	self:_refreshCategorys(self.cur_select_tab)
end

function CharacterBackpackView:_changeCategory(index)
	if index == 2 and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))

		return
	end

	for _, v in ipairs(self._categoryList) do
		v:updateSeletedStatus(index)
	end

	local isEquip = index == 2
	local viewBg = isEquip and "zhuangbei_006" or "juesebeibao_005"

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/" .. viewBg))
	gohelper.setActive(self._goequipsub, isEquip)

	if isEquip then
		if self._isFirstOpenEquip then
			self.viewContainer:playEquipOpenAnimation()

			self._isFirstOpenEquip = false
		end
	elseif self._isFirstOpenCharacter then
		self.viewContainer:playCardOpenAnimation()

		self._isFirstOpenCharacter = false
	end

	self.viewContainer:switchTab(index)

	self.cur_select_tab = index
end

function CharacterBackpackView:onOpen()
	self:initCategory()
	self:_addEvent()
end

function CharacterBackpackView:onUpdateParam()
	self:_setCategory()
end

function CharacterBackpackView:_setCategory(force_tab)
	if not force_tab then
		::label_11_0::

		if self.viewParam then
			if not self.viewParam.jumpTab then
				local jumpTab = JumpEnum.CharacterBackpack.Character
				local cate = jumpTab == JumpEnum.CharacterBackpack.Equip and 2 or 1

				self:_changeCategory(cate)
			end
		end
	end
end

function CharacterBackpackView:onClose()
	self:_removeEvent()
end

function CharacterBackpackView:_addEvent()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.BackpackChangeCategory, self._changeCategory, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self._onFuncUnlockRefresh, self)
end

function CharacterBackpackView:_removeEvent()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.BackpackChangeCategory, self._changeCategory, self)
	self.removeEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self._onFuncUnlockRefresh, self)
end

function CharacterBackpackView:onDestroyView()
	self._imgBg:UnLoadImage()

	for _, v in ipairs(self._categoryList) do
		v:destroyView()
	end
end

return CharacterBackpackView

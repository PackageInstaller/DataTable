-- chunkname: @modules/logic/versionactivity3_7/skingift/view/V3a7_SkinGiftCheckView.lua

module("modules.logic.versionactivity3_7.skingift.view.V3a7_SkinGiftCheckView", package.seeall)

local V3a7_SkinGiftCheckView = class("V3a7_SkinGiftCheckView", BaseView)

function V3a7_SkinGiftCheckView:onInitView()
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "pickchoice/txtbg/txt_desc/#btn_tip")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#scroll_hero")
	self._gorare = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_rare")
	self._gorareroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_rare/#go_rareroot")
	self._gonasa = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_nasa")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#scroll_hero/Viewport/Content/#go_nasa/title/#txt_locked")
	self._gonasaroot = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/Content/#go_nasa/#go_nasaroot")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_SkinGiftCheckView:addEvents()
	self._btntip:AddClickListener(self._btntipOnClick, self)
end

function V3a7_SkinGiftCheckView:removeEvents()
	self._btntip:RemoveClickListener()
end

function V3a7_SkinGiftCheckView:_btntipOnClick()
	HelpController.instance:openBpRuleTipsView(luaLang("ruledetail"), "Rule Details", V3a7_SkinGiftHelper.getSkinGiftRareDesc(self.itemId, "material_packageskin_rate_desc_3_7", "MaterialTipViewPackageSkinDescFmt_3_7"))
end

function V3a7_SkinGiftCheckView:_editableInitView()
	self.skinItemGo = gohelper.findChild(self.viewGO, "storeskingoodsitem")

	gohelper.setActive(self.skinItemGo, false)

	self.skinItemList = {}
end

function V3a7_SkinGiftCheckView:onUpdateParam()
	return
end

function V3a7_SkinGiftCheckView:onOpen()
	self:checkParam()
	self:refreshUI()
end

function V3a7_SkinGiftCheckView:checkParam()
	if not self.viewParam or not self.viewParam.type or not self.viewParam.itemId then
		return
	end

	self.type = self.viewParam.type
	self.itemId = self.viewParam.itemId
	self.itemConfig = ItemConfig.instance:getItemConfig(self.type, self.itemId)

	if not self.itemConfig then
		logError("找不到对应道具 type: " .. tostring(self.type) .. " itemId: " .. tostring(self.itemId))

		return
	end

	local rateInfoList = ItemConfig.instance:getRewardGroupRateInfoList(self.itemConfig.effect)
	local list = {}

	for _, info in ipairs(rateInfoList) do
		local mo = {
			info.materialType,
			info.materialId
		}

		table.insert(list, mo)
	end

	self.rateInfoList = list
end

function V3a7_SkinGiftCheckView:refreshUI()
	self:refreshSkinList()
end

function V3a7_SkinGiftCheckView:refreshSkinList()
	local advancedSkinList = {}
	local uniqueSkinList = {}

	if self.rateInfoList and next(self.rateInfoList) then
		for index, info in ipairs(self.rateInfoList) do
			local skinConfig = SkinConfig.instance:getSkinCo(info[2])

			if V3a7_SkinGiftEnum.UniqueSkinDic[skinConfig.id] then
				table.insert(uniqueSkinList, {
					id = skinConfig.id,
					index = index
				})
			else
				table.insert(advancedSkinList, {
					id = skinConfig.id,
					index = index
				})
			end
		end
	end

	local haveAdvancedSkin = next(advancedSkinList)
	local haveUnique = next(uniqueSkinList)

	gohelper.setActive(self._gorare, haveUnique)
	gohelper.setActive(self._gonasa, haveAdvancedSkin)

	if haveAdvancedSkin then
		table.sort(advancedSkinList, V3a7_SkinGiftCheckView.sortSkinList)
		self:refreshSingleList(advancedSkinList, self._gonasaroot)
	end

	if haveUnique then
		table.sort(uniqueSkinList, V3a7_SkinGiftCheckView.sortSkinList)
		self:refreshSingleList(uniqueSkinList, self._gorareroot)
	end
end

function V3a7_SkinGiftCheckView.sortSkinList(a, b)
	local haveA = HeroModel.instance:checkHasSkin(a.id)
	local haveB = HeroModel.instance:checkHasSkin(b.id)

	if haveA == haveB then
		return a.index < b.index
	end

	return haveB
end

function V3a7_SkinGiftCheckView:refreshSingleList(dataList, parentGo)
	gohelper.CreateObjList(self, self.onGetSkinItem, dataList, parentGo, self.skinItemGo, V3a7_SkinGiftItem)
end

function V3a7_SkinGiftCheckView:onGetSkinItem(item, data, index)
	table.insert(self.skinItemList, item)
	gohelper.setActive(item.viewGO, true)
	item:setInfo(data.id)
end

function V3a7_SkinGiftCheckView:onClose()
	return
end

function V3a7_SkinGiftCheckView:onDestroyView()
	if self.skinItemList and next(self.skinItemList) then
		for _, item in ipairs(self.skinItemList) do
			item:onDestroy()
		end
	end
end

return V3a7_SkinGiftCheckView

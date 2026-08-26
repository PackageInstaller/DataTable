-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionEnchantView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantView", package.seeall)

local V1a6_CachotCollectionEnchantView = class("V1a6_CachotCollectionEnchantView", BaseView)

function V1a6_CachotCollectionEnchantView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._txttitle = gohelper.findChildText(self.viewGO, "#simage_title/#txt_title")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_view")
	self._gocollectionbagitem = gohelper.findChild(self.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionbagitem")
	self._dropcollectionclassify = gohelper.findChildDropdown(self.viewGO, "left/#drop_collectionclassify")
	self._gomiddle = gohelper.findChild(self.viewGO, "#go_middle")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_middle/#simage_collection")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_middle/#txt_name")
	self._gogrid1 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid1")
	self._gogridselect1 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid1/#go_gridselect1")
	self._gogridadd1 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid1/#go_gridadd1")
	self._gogridget1 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid1/#go_gridget1")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "#go_middle/grids/#go_grid1/#go_gridget1/#simage_icon1")
	self._btngridclick1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_middle/grids/#go_grid1/#btn_gridclick1")
	self._gogrid2 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid2")
	self._gogridselect2 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid2/#go_gridselect2")
	self._gogridadd2 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid2/#go_gridadd2")
	self._gogridget2 = gohelper.findChild(self.viewGO, "#go_middle/grids/#go_grid2/#go_gridget2")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "#go_middle/grids/#go_grid2/#go_gridget2/#simage_icon2")
	self._btngridclick2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_middle/grids/#go_grid2/#btn_gridclick2")
	self._gounique = gohelper.findChild(self.viewGO, "#go_middle/#go_unique")
	self._txtuniquetips = gohelper.findChildText(self.viewGO, "#go_middle/#go_unique/#txt_uniquetips")
	self._gocollectionenchantitem = gohelper.findChild(self.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem")
	self._simageframe = gohelper.findChildSingleImage(self.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#simage_frame")
	self._goenchant = gohelper.findChild(self.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#go_enchant")
	self._txtdes = gohelper.findChildText(self.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#txt_des")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goencahntempty = gohelper.findChild(self.viewGO, "right/#go_enchantempty")
	self._scrolleffectcontainer = gohelper.findChildScrollRect(self.viewGO, "#go_middle/#scroll_effectcontainer")
	self._goskills = gohelper.findChild(self.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_skills")
	self._goskillitem = gohelper.findChild(self.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_skills/#go_skillitem")
	self._gospdescs = gohelper.findChild(self.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_spdescs")
	self._gospdescitem = gohelper.findChild(self.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_spdescs/#go_spdescitem")
	self._gocollectionempty = gohelper.findChild(self.viewGO, "left/#go_collectionempty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionEnchantView:addEvents()
	self._btngridclick1:AddClickListener(self._btngridclick1OnClick, self)
	self._btngridclick2:AddClickListener(self._btngridclick2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._dropcollectionclassify:AddOnValueChanged(self._onSwitchCategory, self)
	self.addEventCb(self, V1a6_CachotCollectionEnchantController.instance, V1a6_CachotEvent.OnSelectEnchantCollection, self.onSelectBagItem, self)
end

function V1a6_CachotCollectionEnchantView:removeEvents()
	self._btngridclick1:RemoveClickListener()
	self._btngridclick2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._dropcollectionclassify:RemoveOnValueChanged()
	self.removeEventCb(self, V1a6_CachotCollectionEnchantController.instance, V1a6_CachotEvent.OnSelectEnchantCollection, self.onSelectBagItem, self)
end

function V1a6_CachotCollectionEnchantView:_btngridclick1OnClick()
	self:refreshAllHoleSelectState(V1a6_CachotEnum.CollectionHole.Left)

	local isCouldRemoveEnchant = self:checkIsCouldRemoveEnchant(V1a6_CachotEnum.CollectionHole.Left)

	V1a6_CachotCollectionEnchantController.instance:onSelectHoleGrid(V1a6_CachotEnum.CollectionHole.Left, isCouldRemoveEnchant)
end

function V1a6_CachotCollectionEnchantView:_btngridclick2OnClick()
	self:refreshAllHoleSelectState(V1a6_CachotEnum.CollectionHole.Right)

	local isCouldRemoveEnchant = self:checkIsCouldRemoveEnchant(V1a6_CachotEnum.CollectionHole.Right)

	V1a6_CachotCollectionEnchantController.instance:onSelectHoleGrid(V1a6_CachotEnum.CollectionHole.Right, isCouldRemoveEnchant)
end

function V1a6_CachotCollectionEnchantView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotCollectionEnchantView:_editableInitView()
	self._categoryList = {
		V1a6_CachotCollectionEnchantView.AllFilterType,
		V1a6_CachotEnum.CollectionType.Weapon,
		V1a6_CachotEnum.CollectionType.Protect,
		V1a6_CachotEnum.CollectionType.Decorate
	}
	self._anim = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function V1a6_CachotCollectionEnchantView:onUpdateParam()
	return
end

function V1a6_CachotCollectionEnchantView:onOpen()
	if self.viewParam then
		self:refreshUI(self.viewParam)
	end
end

function V1a6_CachotCollectionEnchantView:refreshUI(curSelectCollectionId)
	V1a6_CachotCollectionEnchantController.instance:onOpenView(curSelectCollectionId)
	self:initCategory()
	self:initEnchantsListUI()
	self:initCollectionsListUI()
end

local delayTime2SwitchCollectionIcon = 0.2

function V1a6_CachotCollectionEnchantView:onSelectBagItem(curSelectCollectionId)
	local curSelectMO = V1a6_CachotEnchantBagListModel.instance:getById(curSelectCollectionId)

	if curSelectMO then
		local collectionConfig = V1a6_CachotCollectionConfig.instance:getCollectionConfig(curSelectMO.cfgId)

		if collectionConfig then
			self._txtname.text = tostring(collectionConfig.name)
			self._collectionIconUrl = ResUrl.getV1a6CachotIcon("collection/" .. collectionConfig.icon)

			gohelper.setActive(self._goadd, collectionConfig.holeNum > 0)
			self:refreshHoleUI(curSelectMO, collectionConfig)
			self:refreshCollectionDesc(curSelectMO, collectionConfig)
			V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(collectionConfig, self._txtuniquetips, self._gounique)

			local isPlaySwitchAnim = false

			if self._curSelectCollectionId and self._curSelectCollectionId ~= curSelectCollectionId then
				self._anim:Play("swicth", 0, 0)

				isPlaySwitchAnim = true
			end

			TaskDispatcher.cancelTask(self._switchCollectionIcon, self)
			TaskDispatcher.runDelay(self._switchCollectionIcon, self, (isPlaySwitchAnim or nil) and (delayTime2SwitchCollectionIcon or 0))

			self._curSelectCollectionId = curSelectCollectionId
		end
	else
		self._curSelectCollectionId = nil
	end

	gohelper.setActive(self._gomiddle, curSelectMO ~= nil)
	self:resetHoleClickCount()
end

function V1a6_CachotCollectionEnchantView:_switchCollectionIcon()
	self._simagecollection:LoadImage(self._collectionIconUrl)
end

function V1a6_CachotCollectionEnchantView:refreshHoleUI(collectionMO, collectionConfig)
	if collectionMO and collectionConfig then
		if not collectionConfig.holeNum then
			local holeNum = 0

			gohelper.setActive(self._gogrid1, holeNum >= 1)
			gohelper.setActive(self._gogrid2, holeNum >= 2)

			local leftEnchantId = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
			local rightEnchantId = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)

			self:refreshSingleHoleUI(V1a6_CachotEnum.CollectionHole.Left, leftEnchantId)
			self:refreshSingleHoleUI(V1a6_CachotEnum.CollectionHole.Right, rightEnchantId)
		end
	end
end

function V1a6_CachotCollectionEnchantView:refreshSingleHoleUI(index, enchantId)
	local curSelectHoleIndex = V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex()
	local hasEnchant = enchantId and enchantId ~= 0

	gohelper.setActive(self["_gogridadd" .. index], not hasEnchant)
	gohelper.setActive(self["_gogridget" .. index], hasEnchant)
	gohelper.setActive(self["_gogridselect" .. index], curSelectHoleIndex == index)

	if hasEnchant then
		local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
		local enchantMO = rogueInfo and rogueInfo:getCollectionByUid(enchantId)
		local enchantCfgId = enchantMO and enchantMO.cfgId
		local enchantCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(enchantCfgId)

		if enchantCfg and self["_simageicon" .. index] then
			self["_simageicon" .. index]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. enchantCfg.icon))
		end
	end
end

function V1a6_CachotCollectionEnchantView:refreshAllHoleSelectState(selectHoleIndex)
	for _, holeIndex in pairs(V1a6_CachotEnum.CollectionHole) do
		gohelper.setActive(self["_gogridselect" .. holeIndex], selectHoleIndex == holeIndex)
	end
end

function V1a6_CachotCollectionEnchantView:refreshCollectionDesc(collectionMO, collectionConfig)
	if collectionConfig then
		V1a6_CachotCollectionHelper.refreshSkillDesc(collectionConfig, self._goskills, self._goskillitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(collectionConfig, self._gospdescs, self._gospdescitem)
	end

	self._scrolleffectcontainer.verticalNormalizedPosition = 1
end

V1a6_CachotCollectionEnchantView.AllFilterType = 6

function V1a6_CachotCollectionEnchantView:initCategory()
	local categoryNameList = {}

	for _, v in ipairs(self._categoryList) do
		local categoryNameCn

		table.insert(categoryNameList, v == V1a6_CachotCollectionEnchantView.AllFilterType and luaLang("cachot_CollectionTypeName_All") or luaLang(V1a6_CachotEnum.CollectionTypeName[v]))
	end

	self._dropcollectionclassify:AddOptions(categoryNameList)
end

function V1a6_CachotCollectionEnchantView:initEnchantsListUI()
	local isEnchantEmpty = V1a6_CachotCollectionEnchantListModel.instance:isEnchantEmpty()

	gohelper.setActive(self._goencahntempty, isEnchantEmpty)
end

function V1a6_CachotCollectionEnchantView:initCollectionsListUI()
	local isCollectionEmpty = V1a6_CachotEnchantBagListModel.instance:isBagEmpty()

	gohelper.setActive(self._gocollectionempty, isCollectionEmpty)
	gohelper.setActive(self._gomiddle, not isCollectionEmpty)
end

function V1a6_CachotCollectionEnchantView:_onSwitchCategory(index)
	index = index + 1

	local categoryId = self._categoryList[index]

	if categoryId then
		self._scrollview.verticalNormalizedPosition = 1

		V1a6_CachotCollectionEnchantController.instance:switchCategory(categoryId)
		self:initCollectionsListUI()
	end
end

V1a6_CachotCollectionEnchantView.RemoveEnchantMinClickCount = 2

function V1a6_CachotCollectionEnchantView:checkIsCouldRemoveEnchant(holeIndex)
	if holeIndex ~= self._checkHoleIndex then
		self:resetHoleClickCount()
	end

	self._checkHoleIndex = holeIndex
	self._holeClickCount = self._holeClickCount + 1

	if self._holeClickCount >= V1a6_CachotCollectionEnchantView.RemoveEnchantMinClickCount then
		self:checkHoleClickToast(holeIndex)
		self:resetHoleClickCount()

		return true
	end
end

function V1a6_CachotCollectionEnchantView:resetHoleClickCount()
	self._holeClickCount = 0
end

local repeatClickToastCount = 2

function V1a6_CachotCollectionEnchantView:checkHoleClickToast(holeIndex)
	local isEnchantListEmpty = V1a6_CachotCollectionEnchantListModel.instance:isEnchantEmpty()

	if isEnchantListEmpty then
		ToastController.instance:showToast(ToastEnum.V1a6Cachot_EnchantListEmpty)
	else
		local curSelectMO = V1a6_CachotEnchantBagListModel.instance:getById(self._curSelectCollectionId)
		local enchantId = curSelectMO and curSelectMO:getEnchantId(holeIndex)
		local hasEnchant = enchantId and enchantId ~= V1a6_CachotEnum.EmptyEnchantId

		if curSelectMO and not hasEnchant and self._holeClickCount and self._holeClickCount >= repeatClickToastCount then
			ToastController.instance:showToast(ToastEnum.V1a6Cachot_SelectCollectionEnchant)
		end
	end
end

function V1a6_CachotCollectionEnchantView:releaseSingleImage()
	if V1a6_CachotEnum.CollectionHole then
		for _, collectionHole in pairs(V1a6_CachotEnum.CollectionHole) do
			local simage = self["_simageicon" .. collectionHole]

			if simage then
				simage:UnLoadImage()
			end
		end
	end
end

function V1a6_CachotCollectionEnchantView:onClose()
	V1a6_CachotCollectionEnchantController.instance:onCloseView()
end

function V1a6_CachotCollectionEnchantView:onDestroyView()
	TaskDispatcher.cancelTask(self._switchCollectionIcon, self)
	self:releaseSingleImage()
end

return V1a6_CachotCollectionEnchantView

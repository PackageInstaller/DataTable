-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionBagView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagView", package.seeall)

local V1a6_CachotCollectionBagView = class("V1a6_CachotCollectionBagView", BaseView)

function V1a6_CachotCollectionBagView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._txttitle = gohelper.findChildText(self.viewGO, "#simage_title/#txt_title")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_view")
	self._gocollectionbagitem = gohelper.findChild(self.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionbagitem")
	self._btntotalpreview = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_totalpreview")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_right/#simage_collection")
	self._gogrid1 = gohelper.findChild(self.viewGO, "#go_right/grids/#go_grid1")
	self._gonone1 = gohelper.findChild(self.viewGO, "#go_right/grids/#go_grid1/#go_none1")
	self._goget1 = gohelper.findChild(self.viewGO, "#go_right/grids/#go_grid1/#go_get1")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "#go_right/grids/#go_grid1/#go_get1/#simage_icon1")
	self._gogrid2 = gohelper.findChild(self.viewGO, "#go_right/grids/#go_grid2")
	self._gonone2 = gohelper.findChild(self.viewGO, "#go_right/grids/#go_grid2/#go_none2")
	self._goget2 = gohelper.findChild(self.viewGO, "#go_right/grids/#go_grid2/#go_get2")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "#go_right/grids/#go_grid2/#go_get2/#simage_icon2")
	self._gounique = gohelper.findChild(self.viewGO, "#go_right/#go_container/#go_unique")
	self._txtuniquetips = gohelper.findChildText(self.viewGO, "#go_right/#go_container/#go_unique/#txt_uniquetips")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_right/#txt_name")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_right/#go_container")
	self._scrolleffectcontainer = gohelper.findChildScrollRect(self.viewGO, "#go_right/#go_container/#scroll_effectcontainer")
	self._goskills = gohelper.findChild(self.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_skills")
	self._goskillitem = gohelper.findChild(self.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_skills/#go_skillitem")
	self._gospdescs = gohelper.findChild(self.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_spdescs")
	self._gospdescitem = gohelper.findChild(self.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_spdescs/#go_spdescitem")
	self._goadd = gohelper.findChild(self.viewGO, "#go_right/#go_add")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#go_add/#btn_add")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._goline = gohelper.findChild(self.viewGO, "left/#scroll_view/Viewport/Content/#go_line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionBagView:addEvents()
	self._btntotalpreview:AddClickListener(self._btntotalpreviewOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, V1a6_CachotCollectionBagController.instance, V1a6_CachotEvent.OnSelectBagCollection, self.onSelectBagItem, self)
end

function V1a6_CachotCollectionBagView:removeEvents()
	self._btntotalpreview:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, V1a6_CachotCollectionBagController.instance, V1a6_CachotEvent.OnSelectBagCollection, self.onSelectBagItem, self)
end

function V1a6_CachotCollectionBagView:_btntotalpreviewOnClick()
	V1a6_CachotController.instance:openV1a6_CachotCollectionOverView()
end

function V1a6_CachotCollectionBagView:_btnaddOnClick()
	V1a6_CachotController.instance:openV1a6_CachotCollectionEnchantView({
		collectionId = self._curSelectCollectionId
	})
end

function V1a6_CachotCollectionBagView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotCollectionBagView:_editableInitView()
	self._goEffectScrollContent = gohelper.findChild(self.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content")
	self._imageCollectionIcon = gohelper.findChildImage(self.viewGO, "#go_right/#simage_collection")
	self._anim = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function V1a6_CachotCollectionBagView:onUpdateParam()
	return
end

function V1a6_CachotCollectionBagView:onOpen()
	if self.viewParam then
		self._isCanEnchant = self.viewParam == nil and true or self.viewParam

		self:initScrollInfo()
		V1a6_CachotCollectionBagController.instance:onOpenView()
		self:refreshCollectionSplitLine()

		if V1a6_CachotCollectionBagController.instance.guideMoveCollection then
			V1a6_CachotCollectionBagController.instance.guideMoveCollection = nil

			V1a6_CachotCollectionBagController.instance:moveCollectionWithHole2TopAndSelect()
		end
	end
end

local delayTime2SwitchCollectionIcon = 0.2

function V1a6_CachotCollectionBagView:onSelectBagItem(selectCellId)
	selectCellId = selectCellId or self._curSelectCollectionId

	local isPlaySwitchAnim = false

	if self._curSelectCollectionId and selectCellId then
		self._anim:Play("switch", 0, 0)

		isPlaySwitchAnim = true
	end

	self:refreshCollectionSplitLine()

	local curSelectMO = V1a6_CachotCollectionBagListModel.instance:getById(selectCellId)
	local collectionCfgId = curSelectMO and curSelectMO.cfgId
	local collectionConfig = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionCfgId)

	gohelper.setActive(self._goempty, curSelectMO == nil)
	gohelper.setActive(self._goright, curSelectMO ~= nil)
	gohelper.setActive(self._btntotalpreview.gameObject, curSelectMO ~= nil)

	if curSelectMO and collectionConfig then
		local selectIndex = V1a6_CachotCollectionBagListModel.instance:getIndex(curSelectMO)

		self:scrollFocusOnSelectCell(selectIndex)

		self._curSelectCollectionId = curSelectMO.id
		self._txtname.text = tostring(collectionConfig.name)
		self._collectionIconUrl = ResUrl.getV1a6CachotIcon("collection/" .. collectionConfig.icon)

		self:_setCollectionIconVisible()
		TaskDispatcher.cancelTask(self._switchCollectionIcon, self)
		TaskDispatcher.runDelay(self._switchCollectionIcon, self, (isPlaySwitchAnim or nil) and (delayTime2SwitchCollectionIcon or 0))

		local canEnchant = collectionConfig.type ~= V1a6_CachotEnum.CollectionType.Enchant and collectionConfig.holeNum > 0 and self._isCanEnchant

		gohelper.setActive(self._goadd, canEnchant)
		self:updateCollectionDescScrollSize(canEnchant)
		self:refreshHoleUI(curSelectMO, collectionConfig)
		V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(collectionConfig, self._txtuniquetips, self._gounique)
		V1a6_CachotCollectionHelper.refreshSkillDesc(collectionConfig, self._goskills, self._goskillitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(collectionConfig, self._gospdescs, self._gospdescitem)
	end
end

local normalSkillDescScrollHeight = 219
local expandSkillDescScrollHeight = 338

function V1a6_CachotCollectionBagView:updateCollectionDescScrollSize(canEnchant)
	if canEnchant then
		if not normalSkillDescScrollHeight then
			local targetHeight = expandSkillDescScrollHeight

			recthelper.setHeight(self._scrolleffectcontainer.transform, targetHeight)
		end
	end
end

function V1a6_CachotCollectionBagView:_setCollectionIconVisible()
	local collectionIconUrl = self._simagecollection.curImageUrl

	self._imageCollectionIcon.enabled = not string.nilorempty(collectionIconUrl)
end

function V1a6_CachotCollectionBagView:_switchCollectionIcon()
	self._simagecollection:LoadImage(self._collectionIconUrl)
end

function V1a6_CachotCollectionBagView:refreshHoleUI(collectionMO, collectionConfig)
	if collectionConfig and collectionMO then
		if not collectionConfig.holeNum then
			local holeNum = 0

			gohelper.setActive(self._gogrid1, holeNum >= 1)
			gohelper.setActive(self._gogrid2, holeNum >= 2)

			local leftEnchantUid = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
			local rightEnchantUid = collectionMO:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)

			self:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left, leftEnchantUid)
			self:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right, rightEnchantUid)
		end
	end
end

function V1a6_CachotCollectionBagView:refreshSingleHole(index, enchantUid)
	local hasEnchant = enchantUid and enchantUid ~= 0

	gohelper.setActive(self["_gonone" .. index], not hasEnchant)
	gohelper.setActive(self["_goget" .. index], hasEnchant)

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if hasEnchant and rogueInfo then
		local enchantMO = rogueInfo:getCollectionByUid(enchantUid)
		local enchantCfgId = enchantMO and enchantMO.cfgId
		local enchantCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(enchantCfgId)

		if enchantCfg and self["_simageicon" .. index] then
			self["_simageicon" .. index]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. enchantCfg.icon))
		end
	end
end

function V1a6_CachotCollectionBagView:scrollFocusOnSelectCell(cellIndex)
	local lineCountAheadTarget = math.ceil(cellIndex / self._scrollLineCount) - 1
	local verticalScrollPixel = lineCountAheadTarget * self._singleItemHeightAndSpace + self._scrollStartSpace
	local curVerticalScrollPixel = self._csScrollView.VerticalScrollPixel
	local scrollOffset = verticalScrollPixel - curVerticalScrollPixel

	if scrollOffset > self._scrollHeight or scrollOffset < 0 then
		self._csScrollView.VerticalScrollPixel = verticalScrollPixel
	end
end

function V1a6_CachotCollectionBagView:initScrollInfo()
	self._luaListScrollView = self.viewContainer:getScrollView()
	self._csScrollView = self._luaListScrollView:getCsListScroll()
	self._scrollLineCount = self._luaListScrollView._param.lineCount
	self._singleItemHeightAndSpace = self._luaListScrollView._param.cellHeight + self._luaListScrollView._param.cellSpaceV
	self._scrollStartSpace = self._luaListScrollView._param.startSpace
	self._scrollHeight = recthelper.getHeight(self._scrollview.transform)
end

function V1a6_CachotCollectionBagView:releaseSingleImage()
	if V1a6_CachotEnum.CollectionHole then
		for _, collectionHole in pairs(V1a6_CachotEnum.CollectionHole) do
			local simage = self["_simageicon" .. collectionHole]

			if simage then
				simage:UnLoadImage()
			end
		end
	end

	self._simagecollection:UnLoadImage()
end

local lineOffsetY = 48

function V1a6_CachotCollectionBagView:refreshCollectionSplitLine()
	local unEnchantCollectionLineNum = V1a6_CachotCollectionBagListModel.instance:getUnEnchantCollectionLineNum()
	local enchantCollectionNum = V1a6_CachotCollectionBagListModel.instance:getEnchantCollectionNum()
	local isNeedShowSplitLine = unEnchantCollectionLineNum > 0 and enchantCollectionNum > 0

	gohelper.setActive(self._goline, isNeedShowSplitLine)

	if isNeedShowSplitLine then
		local scrollParam = self.viewContainer:getScrollParam()

		if scrollParam then
			if not scrollParam.cellHeight then
				local cellHeight = 0

				if scrollParam then
					if not scrollParam.cellSpaceV then
						local cellSpaceV = 0

						if scrollParam then
							if not scrollParam.startSpace then
								local startSpace = 0
								local linePosY = -((cellHeight + cellSpaceV) * unEnchantCollectionLineNum + startSpace) + lineOffsetY

								recthelper.setAnchorY(self._goline.transform, linePosY)
							end
						end
					end
				end
			end
		end
	end
end

function V1a6_CachotCollectionBagView:onClose()
	V1a6_CachotCollectionBagController.instance:onCloseView()
end

function V1a6_CachotCollectionBagView:onDestroyView()
	TaskDispatcher.cancelTask(self._switchCollectionIcon, self)
	self:releaseSingleImage()
end

return V1a6_CachotCollectionBagView

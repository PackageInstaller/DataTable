-- chunkname: @modules/logic/college/view/building/CollegeBuildingRefinedPropView.lua

module("modules.logic.college.view.building.CollegeBuildingRefinedPropView", package.seeall)

local CollegeBuildingRefinedPropView = class("CollegeBuildingRefinedPropView", ListScrollCellExtend)

function CollegeBuildingRefinedPropView:ctor(sceneType)
	CollegeBuildingRefinedPropView.super.ctor(self)

	self._sceneType = sceneType or CollegeEnum.SceneType.City
end

function CollegeBuildingRefinedPropView:onInitView()
	self._goScroll = gohelper.findChild(self.viewGO, "#scroll_BuffList")
	self._goBuffList = gohelper.findChild(self.viewGO, "#scroll_BuffList/Viewport/#go_BuffList")
	self._goBuffItem = gohelper.findChild(self.viewGO, "#scroll_BuffList/Viewport/#go_BuffList/#go_Buffitem")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_EmptyBuff")
	self._curEntryMoMap = {}
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function CollegeBuildingRefinedPropView:onUpdateMO(data)
	self:initData(data or self._data)
	self:refreshUI()
end

function CollegeBuildingRefinedPropView:initData(data)
	self._data = data
	self._co = data.co

	if self._sceneType == CollegeEnum.SceneType.City then
		local slotCoTab = CollegeConfig.instance:getBuildingSlotInfo(self._co.id)

		if slotCoTab then
			self._maxSlotNum = slotCoTab.maxSlotNum or 0
		end
	elseif self._sceneType == CollegeEnum.SceneType.Map then
		self._maxSlotNum = self._co.slots
	end

	self._hasSlot = self._maxSlotNum and self._maxSlotNum > 0
end

function CollegeBuildingRefinedPropView:refreshUI()
	gohelper.setActive(self.viewGO, self._hasSlot)

	if not self._hasSlot then
		return
	end

	self:refreshEntryList()
end

function CollegeBuildingRefinedPropView:refreshEntryList()
	local entryInfoList = self:_buildEntryInfoList()
	local showEntry = entryInfoList and #entryInfoList > 0

	if self._sceneType == CollegeEnum.SceneType.Map then
		showEntry = showEntry and self._data.isFinish
	end

	gohelper.setActive(self._goScroll, showEntry)
	gohelper.setActive(self._goEmpty, not showEntry)

	if not showEntry then
		return
	end

	self._showNewAnim = false

	gohelper.CreateObjList(self, self._refreshEntryItem, entryInfoList, self._goBuffList, self._goBuffItem)
	self._animator:Play(self._showNewAnim and "leveup" or "idle", 0, 0)

	self._lastEntryMoMap = self._lastEntryMoMap or {}

	tabletool.clear(self._lastEntryMoMap)
	tabletool.addValues(self._lastEntryMoMap, self._curEntryMoMap)
	tabletool.clear(self._curEntryMoMap)

	self._showNewAnim = false
end

function CollegeBuildingRefinedPropView:_buildEntryInfoList()
	local characterUidList = self._data.slotCharacterUid
	local characterBox = CollegeModel.instance:getSceneMo().characterBox
	local entryInfoList = {}

	for _, characterUid in ipairs(characterUidList) do
		local characterMo = characterBox:getCharacterMo(characterUid)

		if characterMo and characterMo.entries then
			for _, entryMo in ipairs(characterMo.entries) do
				if CollegeConfig.instance:isEntryTendencyBuilding(entryMo.id, self._data.id) then
					table.insert(entryInfoList, {
						characterMo = characterMo,
						entryMo = entryMo
					})
				end
			end
		end
	end

	return entryInfoList
end

function CollegeBuildingRefinedPropView:_refreshEntryItem(goItem, entryInfo, index)
	local txtDesc = gohelper.findChildText(goItem, "#txt_BuffDescr")
	local characterMo = entryInfo.characterMo

	if characterMo.co then
		local actorCo = characterMo.co
		local actorName = actorCo and actorCo.name

		if entryInfo.entryMo then
			local entryCo = entryInfo.entryMo.co
			local entryDesc = entryCo and entryCo.description

			txtDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("college_building_refinedpropdesc"), {
				actorName,
				entryDesc
			})

			if self._lastEntryMoMap and not self._lastEntryMoMap[entryInfo.entryMo] then
				self._showNewAnim = true
			end

			self._curEntryMoMap[entryInfo.entryMo] = true
		end
	end
end

return CollegeBuildingRefinedPropView

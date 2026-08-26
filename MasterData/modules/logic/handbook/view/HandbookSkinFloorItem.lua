-- chunkname: @modules/logic/handbook/view/HandbookSkinFloorItem.lua

module("modules.logic.handbook.view.HandbookSkinFloorItem", package.seeall)

local HandbookSkinFloorItem = class("HandbookSkinFloorItem", ListScrollCellExtend)

function HandbookSkinFloorItem:onInitView()
	gohelper.setActive(self.viewGO, true)

	self._goSelectedState = gohelper.findChild(self.viewGO, "#select")
	self._goUnSelectedState = gohelper.findChild(self.viewGO, "#unclick")
	self._txtSelectedFloorName = gohelper.findChildText(self._goSelectedState, "#name")
	self._txtUnSelectedFloorName = gohelper.findChildText(self._goUnSelectedState, "#name")
	self._txtSelectedFloorNameEn = gohelper.findChildText(self._goSelectedState, "#name/#name_en")
	self._txtUnSelectedFloorNameEn = gohelper.findChildText(self._goUnSelectedState, "#name/#name_en")
	self._txtSelectedCurSuitIdx = gohelper.findChildText(self._goSelectedState, "#num")
	self._txtUnSelectedCurSuitIdx = gohelper.findChildText(self._goUnSelectedState, "#num")
	self._selectTabRedDot = gohelper.findChild(self.viewGO, "#unclick/#name/#goRedDot")
	self._unSelectTabRedDot = gohelper.findChild(self.viewGO, "#select/#name/#goRedDot")
	self._click = gohelper.findChildClickWithAudio(self.viewGO, "#unclick/btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinFloorItem:addEvents()
	self._click:AddClickListener(self.onClick, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshRedDot, self)
end

function HandbookSkinFloorItem:removeEvents()
	self._click:RemoveClickListener()
	self.removeEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshRedDot, self)
end

function HandbookSkinFloorItem:onClick()
	if self._onClickAction then
		self._onClickAction(self._clickActionObj, self)
	end
end

function HandbookSkinFloorItem:setClickAction(clickAction, clickActionObj)
	self._onClickAction = clickAction
	self._clickActionObj = clickActionObj
end

function HandbookSkinFloorItem:_editableInitView()
	self._selectNewRedDot = RedDotController.instance:addNotEventRedDot(self._selectTabRedDot)

	self._selectNewRedDot:setShowType(RedDotEnum.Style.Green)
	self._selectNewRedDot:setCheckShowRedDotFunc(self.refreshSingleRedDot, self)

	self._unSelectNewRedDot = RedDotController.instance:addNotEventRedDot(self._unSelectTabRedDot)

	self._unSelectNewRedDot:setShowType(RedDotEnum.Style.Green)
	self._unSelectNewRedDot:setCheckShowRedDotFunc(self.refreshSingleRedDot, self)
end

function HandbookSkinFloorItem:onUpdateData(cfg, index)
	self._suitGroupCfg = cfg
	self._idx = index
	self._suitList = HandbookConfig.instance:getSkinSuitCfgListInGroup(cfg.id) or {}
	self._suitCount = #self._suitList
	self._curSuitIdx = 1
	self._skinIdList = {}

	for i = 1, #self._suitList do
		local suitCfg = self._suitList[i]

		tabletool.addValues(self._skinIdList, HandbookConfig.instance:getSkinIdListBySuitId(suitCfg.id))
	end

	self._skinCount = #self._skinIdList
end

function HandbookSkinFloorItem:getHasSkinCount()
	local skinIdList = self._skinIdList

	if not skinIdList or #skinIdList < 1 then
		return 0
	end

	local hasCount = 0
	local tHeroModel = HeroModel.instance

	for i = 0, #skinIdList do
		if tHeroModel:checkHasSkin(skinIdList[i]) then
			hasCount = hasCount + 1
		end
	end

	return hasCount
end

function HandbookSkinFloorItem:getIdx()
	return self._idx
end

function HandbookSkinFloorItem:refreshFloorView()
	self._txtSelectedFloorName.text = self._suitGroupCfg.name
	self._txtUnSelectedFloorName.text = self._suitGroupCfg.name
	self._txtSelectedFloorNameEn.text = self._suitGroupCfg.nameEn
	self._txtUnSelectedFloorNameEn.text = self._suitGroupCfg.nameEn
end

function HandbookSkinFloorItem:refreshCurSuitIdx()
	local skinCount = 0

	if self._skinIdList then
		for i = 1, #self._skinIdList do
			if self._skinIdList[i] ~= 0 then
				skinCount = skinCount + 1
			end
		end
	end

	local hasSkinCount = self:getHasSkinCount()
	local str = hasSkinCount .. "/" .. skinCount

	self._txtSelectedCurSuitIdx.text = str
	self._txtUnSelectedCurSuitIdx.text = str
end

function HandbookSkinFloorItem:refreshSelectState(selected)
	self._isSelected = selected

	if self._isSelected then
		if self._showRedDot then
			local groupId = self._suitGroupCfg.id

			HandbookController.instance:markHandbookSkinRedDotShow(groupId)
			self:refreshRedDot()
		end

		gohelper.setActive(self._goSelectedState, true)
		gohelper.setActive(self._goUnSelectedState, false)
	else
		gohelper.setActive(self._goSelectedState, false)
		gohelper.setActive(self._goUnSelectedState, true)
	end
end

function HandbookSkinFloorItem:refreshRedDot()
	local groupId = self._suitGroupCfg.id
	local needRedDot = HandbookEnum.HandbookSkinShowRedDotMap[groupId]

	if needRedDot then
		::label_13_0::

		local showFirstRedDot = HandbookController.instance:isHandbookSkinRedDotShow(groupId)

		self._showRedDot = showFirstRedDot or HandbookController.instance:isHandbookSkinGroupNewRedDotShow(groupId)

		gohelper.setActive(self._selectTabRedDot, self._showRedDot)
		gohelper.setActive(self._unSelectTabRedDot, self._showRedDot)
		self._selectNewRedDot:refreshRedDot()
		self._unSelectNewRedDot:refreshRedDot()
	end
end

function HandbookSkinFloorItem:refreshSingleRedDot()
	return self._showRedDot
end

function HandbookSkinFloorItem:hasRedDot()
	return self._showRedDot
end

function HandbookSkinFloorItem:onDestroyView()
	return
end

return HandbookSkinFloorItem

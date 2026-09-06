-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikeranktabView.lua

module("logic.extensions.roguelike.view.RoguelikeranktabView", package.seeall)

local RoguelikeranktabView = class("RoguelikeranktabView", ViewComponent)
local PageIndex

function RoguelikeranktabView:unbindEvents()
	RoguelikeranktabView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function RoguelikeranktabView:bindEvents()
	RoguelikeranktabView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickBtnClose, self)
end

function RoguelikeranktabView:buildUI()
	RoguelikeranktabView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btn_close")
	self._container = self:getGo("container")
	self._bg = self:getGo("bg")
	self._pageScrollObj = self:getGo("pagescrollview")
	self._pageCell = self:getGo("pagecell")
	self._pagetableview = ScrollerList.create(self._pageScrollObj, self._pageCell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageTableview, self))

	self._pagetableview:regGetCellSize(function(view, index)
		return self:_pageCellSize(view, index)
	end)

	self._dropLineRectTrans = self:getGo("pagescrollview/viewport/content/dropLine"):GetComponent(goutil.Type_RectTransform)

	self:_initScrollBgParam()
end

function RoguelikeranktabView:onExit()
	RoguelikeranktabView.super.onExit(self)
	self._pagetableview:dispose()
end

function RoguelikeranktabView:onEnter()
	RoguelikeranktabView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1] or RoguelikeModel.instance:getActivityId()

	local index = checknumber(params[2])

	index = index > 0 and index or PageIndex or 1

	self:_onClickTab(index)
	self:_initTabList(index)
	self:_updateTabList(self:_getClickIndexByChildIndex(index))
end

function RoguelikeranktabView:_onClickTab(index, dispatchSelectSub)
	PageIndex = index

	local cfgBigTab = RoguelikeConfig.instance:getBigTabCfgBySmallTabIndex(index)

	if cfgBigTab and cfgBigTab.isHide then
		if ViewMgr.instance:isOpen(cfgBigTab.tabViewName) then
			ViewMgr.instance:close(cfgBigTab.tabViewName)
		end

		self:showTabAt(self._container, cfgBigTab.tabViewName, self._activityId, cfgBigTab.params)
	else
		local config = RoguelikeConfig.instance:getSmallTabCfg(index)

		if ViewMgr.instance:isOpen(config.viewName) then
			ViewMgr.instance:close(config.viewName)
		end

		self:showTabAt(self._container, config.viewName, self._activityId, config.params)
	end
end

function RoguelikeranktabView:_pageCellSize(view, index)
	if self._pagetableview:getData()[index + 1].isParentTag then
		return 178, 70
	else
		return 178, 60
	end
end

function RoguelikeranktabView:_updatePageCell(view, cell, data)
	local imgBigBgChange = goutil.findChild(cell, "imgBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgSmallBgChange = goutil.findChild(cell, "click/imgSmallBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgSmallBgColorChange = goutil.findChild(cell, "click/imgSmallBg"):GetComponent(ComponentType.UIImageColorChange)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNameChange = txtName.gameObject:GetComponent(ComponentType.UITextColorChange)
	local redPoint = goutil.findChild(cell, "dot")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "click")

	btn:AddClickListener(function()
		self:_onClickPageCell(data)
	end)
	imgBigBgChange:SetState(data.isParentTag and (data.isUnfold and 1 or 0) or 2)
	imgSmallBgChange:SetState(data.isParentTag and 2 or data.isSelect and 1 or 0)

	txtName.text = data.name

	txtNameChange:SetState(data.isParentTag and (data.isUnfold and 1 or 0) or data.isSelect and 3 or 2)
	imgSmallBgColorChange:SetState(data.isSelect and 1 or 0)
	RedPointController.instance:unregRedPoint(redPoint)

	if #data.redPointIds > 0 then
		RedPointController.instance:regRedPoint(redPoint, unpack(data.redPointIds))
	else
		goutil.setActive(redPoint, false)
	end
end

function RoguelikeranktabView:_clearPageTableview(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "click")
	local redPoint = goutil.findChild(cell, "dot")

	btn:RemoveClickListener()
	RedPointController.instance:unregRedPoint(redPoint)
end

function RoguelikeranktabView:_initTabList(selectChildIndex)
	self._curSelectClickIndex = 1

	local list = {}
	local index = 1
	local ParentPageInfo = RoguelikeConfig.instance:getBigTabSortList()

	for i, v in ipairs(ParentPageInfo) do
		local parentElement = {}

		parentElement.index = index
		parentElement.parentIndex = v.index
		parentElement.name = v.name
		parentElement.cfg = v
		parentElement.isParentTag = true
		parentElement.isUnfold = false
		parentElement.childIndexList = {}
		parentElement.redPointIds = {}

		table.insert(list, parentElement)

		index = index + 1

		if not v.isHide then
			for j, childIndex in ipairs(v.childIndex) do
				if selectChildIndex == childIndex then
					parentElement.isUnfold = true
					self._curSelectClickIndex = index
				end

				local isAddChild = true
				local petCgs
				local redPointIds = {}
				local childCfg = RoguelikeConfig.instance:getSmallTabCfg(childIndex)

				if isAddChild then
					local info = childCfg
					local childElement = {}

					childElement.index = index
					childElement.parentIndex = parentElement.index
					childElement.name = info.name
					childElement.cfg = info
					childElement.isParentTag = false
					childElement.isSelect = selectChildIndex == childIndex
					childElement.redPointIds = redPointIds

					table.insert(list, childElement)
					table.insert(parentElement.childIndexList, index)

					index = index + 1
				end
			end
		end

		parentElement.isSingleChild = #parentElement.childIndexList == 1
	end

	self._saveList = list
end

function RoguelikeranktabView:_getClickIndexByChildIndex(childIndex)
	local index = 1

	for i, v in ipairs(self._saveList) do
		if v.isParentTag then
			if v.isSingleChild and self._saveList[v.childIndexList[1]].cfg.index == childIndex then
				index = v.index

				break
			end

			if v.cfg.isHide and v.cfg.childIndex then
				local isEnd = false

				for i2, v2 in ipairs(v.cfg.childIndex) do
					if v2 == childIndex then
						index = v.index

						break
					end
				end

				if isEnd then
					break
				end
			end
		elseif v.cfg.index == childIndex then
			index = v.index

			break
		end
	end

	return index
end

function RoguelikeranktabView:_updateTabList(clickIndex)
	self._curSelectClickIndex = clickIndex
	self._filterList = self._filterList or {}

	table.clear(self._filterList)

	local isClickParent = self._saveList[clickIndex].isParentTag
	local selectParentIndex = 1
	local isSelectParentUnfold = false

	if isClickParent then
		selectParentIndex = clickIndex
		isSelectParentUnfold = self._saveList[clickIndex].isUnfold

		for i, v in ipairs(self._saveList) do
			if v.isParentTag then
				if clickIndex == v.index then
					v.isUnfold = (v.isSingleChild or v.cfg.isHide) and true or not v.isUnfold
					isSelectParentUnfold = v.isUnfold
				else
					v.isUnfold = false
				end

				table.insert(self._filterList, v)
			else
				local parentElement = self._saveList[v.parentIndex]

				if parentElement.isUnfold then
					if parentElement.isSingleChild then
						v.isSelect = true
					else
						v.isSelect = v.index == parentElement.childIndexList[1]

						table.insert(self._filterList, v)
					end
				else
					v.isSelect = false
				end
			end
		end
	else
		for i, v in ipairs(self._saveList) do
			if v.isParentTag then
				table.insert(self._filterList, v)
			else
				v.isSelect = clickIndex == v.index

				if self._saveList[v.parentIndex].isUnfold then
					table.insert(self._filterList, v)
				end

				if v.isSelect then
					selectParentIndex = v.parentIndex
					isSelectParentUnfold = self._saveList[v.parentIndex].isUnfold
				end
			end
		end
	end

	self._pagetableview:reloadData(self._filterList)
	self:_updateScrollBg(self:_getSelectedIndex(selectParentIndex), isSelectParentUnfold, self:_getChildCellCount(selectParentIndex))
end

function RoguelikeranktabView:_getSelectedIndex(parentIndex)
	local index = 1

	for i, v in ipairs(self._filterList) do
		if v.isParentTag and v.index == parentIndex then
			index = i

			break
		end
	end

	return index
end

function RoguelikeranktabView:_getChildCellCount(parentIndex)
	local parentElement = self._saveList[parentIndex]

	if parentElement.isUnfold then
		return #parentElement.childIndexList
	else
		return 0
	end
end

function RoguelikeranktabView:_initScrollBgParam()
	local tableview = self._pagetableview:getView()

	self._cellSpaceingY = tableview.cellSpacing.y
	self._cellOffsetY = tableview.cellOffset.y
	self._cellHeight = 60
end

function RoguelikeranktabView:_updateScrollBg(index, isUnfold, childCellCount)
	local posY = 0 - (self._cellOffsetY + (index - 1) * (self._cellHeight + self._cellSpaceingY))

	posY = posY - 35

	local height = 0

	if isUnfold then
		local count = childCellCount

		if count > 1 then
			height = count * (self._cellHeight + self._cellSpaceingY) + self._cellHeight * 0.5
		end
	end

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._dropLineRectTrans, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._dropLineRectTrans, x, posY)
	goutil.setHeight(self._dropLineRectTrans, height)
end

function RoguelikeranktabView:_onClickPageCell(data)
	if not data.isParentTag then
		if self._curSelectClickIndex ~= data.index then
			self:_updateTabList(data.index)
			self:_onClickTab(data.cfg.index)
		end
	else
		if data.cfg.isHide and self._curSelectClickIndex ~= data.index then
			self:_onClickTab(data.cfg.childIndex[1])
		end

		if not data.isUnfold and data.childIndexList[1] then
			local childFirstIndex = self._saveList[data.childIndexList[1]].cfg.index

			self:_onClickTab(childFirstIndex)
		end

		if not data.isSingleChild or self._curSelectClickIndex ~= data.index then
			self:_updateTabList(data.index)
		end
	end
end

function RoguelikeranktabView:_onClickBtnClose()
	self:close()
end

return RoguelikeranktabView

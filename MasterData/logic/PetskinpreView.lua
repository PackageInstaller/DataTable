-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetskinpreView.lua

module("logic.extensions.petskinpreview.view.PetskinpreView", package.seeall)

local PetskinpreView = class("PetskinpreView", ViewComponent)
local PageIndex, PageData

PetskinpreView.SelectSubTabWithParams = "PetskinpreView.SelectSubTabWithParams"
PetskinpreView.NotifyClickSubTab = "PetskinpreView.NotifyClickSubTab"

function PetskinpreView:ctor()
	PetskinpreView.super.ctor(self)
end

function PetskinpreView:unbindEvents()
	PetskinpreView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetskinpreView:bindEvents()
	PetskinpreView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickBtnClose, self)
end

function PetskinpreView:buildUI()
	PetskinpreView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btn_close")
	self._container = self:getGo("container")
	self._bg = self:getGo("bg")
	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateExtCell, self), GameUtil.handler(self._onUpdateRight, self))
end

function PetskinpreView:onExit()
	PetskinpreView.super.onExit(self)

	self._curViewName = ""
end

function PetskinpreView:onEnter()
	PetskinpreView.super.onEnter(self)
	self.addGEvent(self, PetskinpreView.SelectSubTabWithParams, self._onSelectSubTabWithParams, self)

	local params = self:getOpenParam() or {}

	self._userId = checknumber(params[1])

	local index = checknumber(params[2])

	index = index > 0 and index or PageIndex or 1

	PetSkinlPreviewController.instance:setUserId(self._userId)

	self._curViewName = ""

	self:_initScrollTab()
end

function PetskinpreView:_initScrollTab()
	self._commonTab:clearAllData()

	local ParentPageInfo = PetskinpreviewConfig.instance:getBigTabSortList()

	for i, data in ipairs(ParentPageInfo) do
		local obj = self._commonTab:addTabData(data.name, data)

		for j, childIndex in ipairs(data.childIndex) do
			local childCfg = PetskinpreviewConfig.instance:getSmallTabCfg(childIndex)
			local tem = self._commonTab:addTabData(childCfg.name, childCfg, obj.root)
		end
	end

	self._commonTab:jumpTabByData(PageData)
end

function PetskinpreView:_onUpdateExtCell(view, cell, tabData, tag)
	local redpoint = goutil.findChild(cell, "redpoint")

	RedPointController.instance:unregRedPoint(redpoint)

	if not tabData.data then
		if tabData.data.redPointIds and #tabData.data.redPointIds > 0 then
			RedPointController.instance:regRedPoint(redpoint, unpack(tabData.data.redPointIds))
		else
			goutil.setActive(redpoint, false)
		end
	end
end

function PetskinpreView:_onUpdateRight(tabData)
	if tabData == nil then
		self._curSelectData = nil

		self:showTabAt(self.container, "")

		return
	end

	local data = tabData.data

	self._curSelectData = data
	PageData = data

	if tabData.leaf == 0 then
		self:showTabAt(self.container)
		self:showTabAt(self.container, self._curSelectData.tabViewName, self._userId)

		self._curViewName = self._curSelectData.tabViewName
	elseif self._curViewName ~= self._curSelectData.viewName then
		self._curViewName = self._curSelectData.viewName

		self:showTabAt(self.container)
		self:showTabAt(self._container, self._curSelectData.viewName, self._userId, self._curSelectData.index)
	else
		GlobalDispatcher:dispatch(PetskinpreView.NotifyClickSubTab, self._curSelectData.index)
	end
end

function PetskinpreView:_onClickTab(index, dispatchSelectSub)
	PageIndex = index

	local cfgBigTab = PetskinpreviewConfig.instance:getBigTabCfgBySmallTabIndex(index)

	if cfgBigTab and cfgBigTab.isHide then
		if ViewMgr.instance:isOpen(cfgBigTab.tabViewName) then
			ViewMgr.instance:close(cfgBigTab.tabViewName)
		end

		self:showTabAt(self._container, cfgBigTab.tabViewName, self._userId)
	else
		local config = PetskinpreviewConfig.instance:getSmallTabCfg(index)

		self:showTabAt(self._container, config.viewName, self._userId, index)

		if dispatchSelectSub == nil or dispatchSelectSub and cfgBigTab.params and cfgBigTab.params.needDispatchSelectSubTab then
			GlobalDispatcher:dispatch(PetskinpreView.NotifyClickSubTab, index)
		end
	end
end

function PetskinpreView:_pageCellSize(view, index)
	if self._pagetableview:getData()[index + 1].isParentTag then
		return 178, 70
	else
		return 178, 60
	end
end

function PetskinpreView:_updatePageCell(view, cell, data)
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

function PetskinpreView:_clearPageTableview(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "click")
	local redPoint = goutil.findChild(cell, "dot")

	btn:RemoveClickListener()
	RedPointController.instance:unregRedPoint(redPoint)
end

function PetskinpreView:_initTabList(selectChildIndex)
	self._curSelectClickIndex = 1

	local list = {}
	local index = 1
	local ParentPageInfo = PetskinpreviewConfig.instance:getBigTabSortList()

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
				local childCfg = PetskinpreviewConfig.instance:getSmallTabCfg(childIndex)

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

function PetskinpreView:_getClickIndexByChildIndex(childIndex)
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

function PetskinpreView:_updateTabList(clickIndex)
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

function PetskinpreView:_getSelectedIndex(parentIndex)
	local index = 1

	for i, v in ipairs(self._filterList) do
		if v.isParentTag and v.index == parentIndex then
			index = i

			break
		end
	end

	return index
end

function PetskinpreView:_getChildCellCount(parentIndex)
	local parentElement = self._saveList[parentIndex]

	if parentElement.isUnfold then
		return #parentElement.childIndexList
	else
		return 0
	end
end

function PetskinpreView:_initScrollBgParam()
	local tableview = self._pagetableview:getView()

	self._cellSpaceingY = tableview.cellSpacing.y
	self._cellOffsetY = tableview.cellOffset.y
	self._cellHeight = 60
end

function PetskinpreView:_updateScrollBg(index, isUnfold, childCellCount)
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

function PetskinpreView:_onSelectSubTabWithParams(checkKvParams, dispatchSelectSub)
	if not checkKvParams then
		return
	end

	local list = self._commonTab:getTabList() or {}
	local paramCount = table.nums(checkKvParams)

	for i, v in ipairs(list) do
		if v.leafList and #v.leafList > 0 then
			for ii, vv in ipairs(v.leafList) do
				local params = vv.data.params

				if params then
					local count = paramCount

					for key, val in pairs(params) do
						if checkKvParams[key] == val then
							count = count - 1

							if count <= 0 then
								self._commonTab:setSelectTabByTabData(vv, false)

								break
							end
						end
					end
				end
			end
		end
	end
end

function PetskinpreView:_onClickPageCell(data, dispatchSelectSub)
	if not data.isParentTag then
		if self._curSelectClickIndex ~= data.index then
			self:_updateTabList(data.index)
			self:_onClickTab(data.cfg.index, dispatchSelectSub)
		end
	else
		if data.cfg.isHide and self._curSelectClickIndex ~= data.index then
			self:_onClickTab(data.cfg.childIndex[1], dispatchSelectSub)
		end

		if not data.isUnfold and data.childIndexList[1] then
			local childFirstIndex = self._saveList[data.childIndexList[1]].cfg.index

			self:_onClickTab(childFirstIndex, dispatchSelectSub)
		end

		if not data.isSingleChild or self._curSelectClickIndex ~= data.index then
			self:_updateTabList(data.index)
		end
	end
end

function PetskinpreView:_onClickBtnClose()
	PageIndex = nil
	PageData = nil

	self:close()
end

return PetskinpreView

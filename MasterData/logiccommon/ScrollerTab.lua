-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/ScrollerTab.lua

module("logiccommon.common.viewlib.usualviews.ScrollerTab", package.seeall)

local ScrollerTab = class("ScrollerTab")

ScrollerTab.TAG_ROOT = 1
ScrollerTab.TAG_LEAF = 2

function ScrollerTab.createCell(cellGo, updateCellCallBack, clearCellCallBack, width, height)
	local tem = {}

	tem.cell = cellGo
	tem.updateCellCallBack = updateCellCallBack
	tem.clearCellCallBack = clearCellCallBack
	tem.width = width
	tem.height = height

	return tem
end

function ScrollerTab:init(tableviewGo, cellParmList, onUpdateRightCallBack, dropLineGo)
	self._tabList = {}
	self._tabMap = {}
	self._tempList = {}
	self._isOpenLeaf = false
	self._rootIdx = 0
	self._leafIdx = 0
	self._onUpdateRightCallBack = onUpdateRightCallBack
	self._cellDataMap = {}

	local cellList = {}

	for i, v in ipairs(cellParmList) do
		v.tag = i

		table.insert(cellList, v.cell)

		self._cellDataMap[v.tag] = v
	end

	self._scrollList = ScrollerList.create(tableviewGo, cellList, GameUtil.handler(self._upateTabCell, self), GameUtil.handler(self._clearTagCell, self))

	self._scrollList:regGetTagByIdx(GameUtil.handler(self._getTagByData, self))
	self._scrollList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._gap = self._scrollList._tableview.cellSpacing.y
	self._dropLineGo = dropLineGo

	if self._dropLineGo then
		self._dropLineTr = self._dropLineGo.transform

		local x, y, z = Framework.TransformUtil.GetAnchoredPos(self._dropLineTr, 0, 0)

		self._dropLineOffsetX = x
		self._dropLineV2 = Vector2.New(self._dropLineTr.sizeDelta.x, 0)
		self._dropLineTr.sizeDelta = self._dropLineV2
	end
end

function ScrollerTab:setTabDataFilterCallBack(callBack)
	self._onTabDataFilterCallBack = callBack
end

function ScrollerTab:setIsUnlockCallBack(callBack)
	self._onIsUnlockCallBack = callBack
end

function ScrollerTab:setPreClickCallBack(callBack)
	self._onPreClickCallBack = callBack
end

function ScrollerTab:setDefaultLeafCallBack(callBack)
	self._onDefaultLeafCallBack = callBack
end

function ScrollerTab:_onReloadFinish()
	if self._dropLineGo then
		self._dropLineTr:SetAsFirstSibling()
	end
end

function ScrollerTab:setSelectTabByTabData(tabData, isCall)
	local root = tabData and tabData.root
	local leaf = tabData and tabData.leaf

	if isCall == nil then
		isCall = true
	end

	if isCall then
		self:setSelectTab(root, leaf)
	else
		self:setSelectTabNotCall(root, leaf)
	end
end

function ScrollerTab:setSelectTab(root, leaf)
	self._rootIdx = checknumber(root)
	self._leafIdx = checknumber(leaf)
	self._isOpenLeaf = false

	if self._rootIdx > 0 and self._leafIdx > 0 then
		self._isOpenLeaf = true
	end

	self:updateTabList()
end

function ScrollerTab:setSelectTabNotCall(root, leaf)
	self._rootIdx = checknumber(root)
	self._leafIdx = checknumber(leaf)
	self._isOpenLeaf = false

	if self._rootIdx > 0 and self._leafIdx > 0 then
		self._isOpenLeaf = true
	end

	self:updateTabListWithoutCall()
end

function ScrollerTab:clearAllData()
	self._tabMap = {}
	self._tabList = {}
end

function ScrollerTab:getTabDataByCfg(data)
	if data == nil then
		printError(">>>>>>>特征数据不能为nil")

		return nil
	end

	for root, arr in pairs(self._tabMap) do
		for leaf, tabData in pairs(arr) do
			if tabData.data == data then
				return tabData
			end
		end
	end

	printError(">>>>>>>没找到！")

	return nil
end

function ScrollerTab:addTabData(tabName, data, hisRoot)
	self._tabMap = self._tabMap or {}

	local tabData = {}

	tabData.tabName = tabName
	tabData.tag = ScrollerTab.TAG_ROOT
	tabData.data = data

	local leaf = 0
	local root = checknumber(hisRoot)

	if root == 0 then
		leaf = 0
		self._tabList = self._tabList or {}
		root = #self._tabList + 1
		tabData.root = #self._tabList + 1
		tabData.leaf = leaf
		tabData.leafList = {}

		table.insert(self._tabList, tabData)

		self._tabMap[tabData.root] = self._tabMap[tabData.root] or {}
		self._tabMap[tabData.root][tabData.leaf] = tabData
	else
		tabData.tag = ScrollerTab.TAG_LEAF

		local rootData = self._tabList[root]

		if rootData then
			leaf = #rootData.leafList + 1
			tabData.root = root
			tabData.leaf = leaf

			table.insert(rootData.leafList, tabData)

			self._tabMap[tabData.root] = self._tabMap[tabData.root] or {}
			self._tabMap[tabData.root][tabData.leaf] = tabData
		else
			printError(">>>>>>>>>>>>>>请先构造root节点再构造leaf节点")
		end
	end

	return tabData
end

function ScrollerTab:reloadData(list)
	self._tabList = list
	self._tabMap = self._tabMap or {}

	for i, tabData in ipairs(self._tabList) do
		self._tabMap[tabData.root] = self._tabMap[tabData.root] or {}
		self._tabMap[tabData.root][tabData.leaf] = tabData

		if tabData.leafList then
			for ii, vv in ipairs(tabData.leafList) do
				self._tabMap[vv.root] = self._tabMap[vv.root] or {}
				self._tabMap[vv.root][vv.leaf] = vv
			end
		end
	end

	self:updateTabList()
end

function ScrollerTab:getTabList()
	return self._tabList
end

function ScrollerTab:_clearTagCell(cell)
	local idx = cell.index
	local list = self._scrollList:getData()

	if list then
		local tabData = list[idx + 1]
		local tag = tabData.tag
		local cfg = self._cellDataMap[tabData.tag]

		GameUtil.callBack(cfg.clearCellCallBack, cell, tabData, tag)
	end
end

function ScrollerTab:_upateTabCell(view, cell, tabData, tag)
	if tag == ScrollerTab.TAG_ROOT then
		self:_updateRootCell(view, cell, tabData, tag)
	elseif tag == ScrollerTab.TAG_LEAF then
		self:_updateLeafCell(view, cell, tabData, tag)
	elseif enableDebug then
		printError(">>>>>自己拓展实现tag的CallBack", tabData.tag)
	end
end

function ScrollerTab:_getTagByData(tabData, idx)
	return tabData.tag
end

function ScrollerTab:_getCellSize(view, idx)
	local list = self._scrollList:getData()

	if not list[idx + 1] then
		local tabData = {}
		local w, h = self:_getDataSize(tabData)

		return w, h
	end
end

function ScrollerTab:_getDataSize(tabData)
	local cfg = self._cellDataMap[tabData.tag]

	if cfg == nil then
		return 0, 0
	else
		return cfg.width, cfg.height
	end
end

function ScrollerTab:_updateRootCell(view, cell, tabData, tag)
	local cfg = self._cellDataMap[tabData.tag]

	GameUtil.callBack(cfg.updateCellCallBack, view, cell, tabData, tag)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onRootClick, self, tabData))
end

function ScrollerTab:_updateLeafCell(view, cell, tabData, tag)
	local cfg = self._cellDataMap[tabData.tag]

	GameUtil.callBack(cfg.updateCellCallBack, view, cell, tabData, tag)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onLeafClick, self, tabData))
end

function ScrollerTab:_onRootClick(tabData)
	if self._onPreClickCallBack ~= nil then
		local boo = GameUtil.callBack(self._onPreClickCallBack, tabData)

		if boo then
			return
		end
	end

	if tabData.root == self._rootIdx then
		self._isOpenLeaf = not self._isOpenLeaf

		self:updateTabList()
	else
		self._rootIdx = tabData.root
		self._isOpenLeaf = true

		if tabData.leafList and #tabData.leafList > 0 then
			self._leafIdx = 0

			if self._onDefaultLeafCallBack then
				local leafIdx = checknumber(GameUtil.callBack(self._onDefaultLeafCallBack, tabData))

				if leafIdx > 0 then
					for i, v in ipairs(tabData.leafList) do
						if v.leaf == leafIdx and not self:_onFilter(v) and self:_isUnlock(v) then
							self._leafIdx = leafIdx

							break
						end
					end
				end
			end

			if self._leafIdx == 0 then
				for i, v in ipairs(tabData.leafList) do
					if not self:_onFilter(v) and self:_isUnlock(v) then
						self._leafIdx = v.leaf

						break
					end
				end
			end
		else
			self._leafIdx = 0
		end

		self:updateTabList()
	end
end

function ScrollerTab:_onLeafClick(tabData)
	if self._onPreClickCallBack ~= nil then
		local boo = GameUtil.callBack(self._onPreClickCallBack, tabData)

		if boo then
			return
		end
	end

	if not self:_isUnlock(tabData) then
		return
	end

	self._leafIdx = tabData.leaf

	self._scrollList:refresh()
	GameUtil.callBack(self._onUpdateRightCallBack, self:getCurrTabData())
end

function ScrollerTab:refresh()
	self._scrollList:refresh()
end

function ScrollerTab:updateTabListWithoutCall()
	local rootIdx = self._rootIdx
	local leafIdx = self._leafIdx
	local list = {}
	local dropLineSizeY = 0
	local dropLineHeight = 0
	local idx = 0

	for i, tabData in ipairs(self._tabList or {}) do
		if not self:_onFilter(tabData) then
			table.clear(self._tempList)

			local has = true

			if tabData.leafList and #tabData.leafList > 0 then
				has = false

				for ii, vv in ipairs(tabData.leafList) do
					if not self:_onFilter(vv) then
						table.insert(self._tempList, vv)

						has = true
					end
				end
			end

			if has then
				table.insert(list, tabData)

				if tabData.root == rootIdx and tabData.leaf == leafIdx then
					idx = #list - 1
				end

				if rootIdx > tabData.root then
					local w, h = self:_getDataSize(tabData)

					dropLineSizeY = dropLineSizeY - h - self._gap
				end

				if tabData.root == rootIdx then
					local w, h = self:_getDataSize(tabData)

					dropLineSizeY = dropLineSizeY - h + 20
				end

				if tabData.root == rootIdx and leafIdx > 0 and self._isOpenLeaf then
					for jj, vv in ipairs(self._tempList) do
						table.insert(list, vv)

						if vv.root == rootIdx and vv.leaf == leafIdx then
							idx = #list - 1
						end

						local w, h = self:_getDataSize(vv)

						dropLineHeight = dropLineHeight + h + self._gap
					end

					if #self._tempList > 0 then
						dropLineHeight = dropLineHeight + self._gap + self._gap + 5 + 20
					end
				end
			end
		end
	end

	if self._dropLineGo then
		if self._isOpenLeaf then
			self._dropLineV2.y = dropLineHeight
			self._dropLineTr.sizeDelta = self._dropLineV2

			GameUtil.setAnchoredPos(self._dropLineGo, self._dropLineOffsetX, dropLineSizeY)
		else
			self._dropLineV2.y = 0
			self._dropLineTr.sizeDelta = self._dropLineV2
		end
	end

	self._scrollList:reloadData(list)
	self._scrollList:MoveCellInView(idx)
end

function ScrollerTab:updateTabList()
	self:updateTabListWithoutCall()
	GameUtil.callBack(self._onUpdateRightCallBack, self:getCurrTabData())
end

function ScrollerTab:getCurrTabData()
	if self._tabMap[self._rootIdx] then
		return self._tabMap[self._rootIdx][self._leafIdx]
	end

	return nil
end

function ScrollerTab:getTabData(...)
	local tabData
	local keys = {
		...
	}
	local current = self._tabMap

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function ScrollerTab:_onFilter(tabData)
	if self._onTabDataFilterCallBack then
		local boo = GameUtil.callBack(self._onTabDataFilterCallBack, tabData)

		return checkbool(boo)
	end

	return false
end

function ScrollerTab:_isUnlock(tabData)
	if self._onIsUnlockCallBack then
		local boo = GameUtil.callBack(self._onIsUnlockCallBack, tabData)

		return checkbool(boo)
	end

	return true
end

function ScrollerTab:dispose()
	self._scrollList:dispose()
end

function ScrollerTab:getScrollList()
	return self._scrollList
end

function ScrollerTab:getRootIdx()
	return self._rootIdx
end

function ScrollerTab:getLeafIdx()
	return self._leafIdx
end

return ScrollerTab

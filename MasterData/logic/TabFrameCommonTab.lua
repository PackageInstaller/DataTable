-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/common/TabFrameCommonTab.lua

module("logic.extensions.tabframework.view.common.TabFrameCommonTab", package.seeall)

local TabFrameCommonTab = class("TabFrameCommonTab", ScrollerTab)

function TabFrameCommonTab.create(tableviewGo, updateCellExtCallBack, onUpdateRightCallBack)
	local commonTab = TabFrameCommonTab.New()

	commonTab:preInit(tableviewGo, updateCellExtCallBack, onUpdateRightCallBack)

	return commonTab
end

function TabFrameCommonTab:preInit(tableviewGo, updateCellExtCallBack, onUpdateRightCallBack)
	self._updateCellExtCallBack = updateCellExtCallBack

	local dropLineGo = goutil.findChild(tableviewGo, "viewport/content/dropLine")
	local rootcell = goutil.findChild(tableviewGo, "rootcell")
	local leafcell = goutil.findChild(tableviewGo, "leafcell")
	local list = {}

	if rootcell then
		local tem = ScrollerTab.createCell(rootcell, GameUtil.handler(self._onUpdateRootCell, self), GameUtil.handler(self._onClearRootCell, self), 192, 74)

		table.insert(list, tem)
	end

	if leafcell then
		local tem = ScrollerTab.createCell(leafcell, GameUtil.handler(self._onUpdateLeafCell, self), GameUtil.handler(self._onClearLeafCell, self), 192, 62)

		table.insert(list, tem)
	end

	self:init(tableviewGo, list, onUpdateRightCallBack, dropLineGo)
end

function TabFrameCommonTab:jumpTabByData(data)
	local tabData, targetTabData
	local data = data

	if data then
		tabData = self:getTabDataByCfg(data)
	end

	if tabData and not self:_onFilter(tabData) and self:_isUnlock(tabData) then
		targetTabData = tabData
	else
		local tabList = self:getTabList()

		for i, tabData in ipairs(tabList) do
			if not self:_onFilter(tabData) and self:_isUnlock(tabData) then
				if tabData.leafList and #tabData.leafList > 0 then
					local isBreak = false

					for ii, vv in ipairs(tabData.leafList) do
						if not self:_onFilter(vv) and self:_isUnlock(vv) then
							targetTabData = vv
							isBreak = true

							break
						end
					end

					if isBreak then
						break
					end
				else
					targetTabData = tabData

					break
				end
			end
		end
	end

	self:setSelectTabByTabData(targetTabData)
end

function TabFrameCommonTab:_onUpdateRootCell(view, cell, tabData, tag)
	local imgNor = goutil.findChild(cell, "imgNor")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtNorGo = goutil.findChild(cell, "txtNorGo")
	local txtNor = goutil.findChildTextComponent(cell, "txtNorGo/txt")
	local txtSelectGo = goutil.findChild(cell, "txtSelectGo")
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelectGo/txt")
	local lock = goutil.findChild(cell, "lock")
	local redpoint = goutil.findChild(cell, "redpoint")
	local newTag = goutil.findChild(cell, "newTag")
	local txtTag = goutil.findChildTextComponent(cell, "newTag/txtTag")

	GameUtil.SetActive(lock, false)
	GameUtil.SetActive(redpoint, false)
	GameUtil.SetActive(newTag, false)

	txtNor.text = tabData.tabName
	txtSelect.text = tabData.tabName

	GameUtil.SetActive(imgSelect, tabData.root == self:getRootIdx())
	GameUtil.SetActive(txtSelectGo, tabData.root == self:getRootIdx())
	GameUtil.SetActive(imgNor, tabData.root ~= self:getRootIdx())
	GameUtil.SetActive(txtNorGo, tabData.root ~= self:getRootIdx())
	GameUtil.callBack(self._updateCellExtCallBack, view, cell, tabData, tag)
end

function TabFrameCommonTab:_onUpdateLeafCell(view, cell, tabData, tag)
	local imgNor = goutil.findChild(cell, "imgNor")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtNorGo = goutil.findChild(cell, "txtNorGo")
	local txtNor = goutil.findChildTextComponent(cell, "txtNorGo/txt")
	local txtSelectGo = goutil.findChild(cell, "txtSelectGo")
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelectGo/txt")
	local lock = goutil.findChild(cell, "lock")
	local redpoint = goutil.findChild(cell, "redpoint")
	local newTag = goutil.findChild(cell, "newTag")
	local txtTag = goutil.findChildTextComponent(cell, "newTag/txtTag")

	GameUtil.SetActive(lock, false)
	GameUtil.SetActive(redpoint, false)
	GameUtil.SetActive(newTag, false)

	txtNor.text = tabData.tabName
	txtSelect.text = tabData.tabName

	GameUtil.SetActive(imgSelect, tabData.leaf == self:getLeafIdx())
	GameUtil.SetActive(txtSelectGo, tabData.leaf == self:getLeafIdx())
	GameUtil.SetActive(imgNor, tabData.leaf ~= self:getLeafIdx())
	GameUtil.SetActive(txtNorGo, tabData.leaf ~= self:getLeafIdx())
	GameUtil.callBack(self._updateCellExtCallBack, view, cell, tabData, tag)
end

function TabFrameCommonTab:_onClearRootCell(cell, tabData, tag)
	local redpoint = goutil.findChild(cell, "redpoint")

	RedPointController.instance:unregRedPoint(redpoint)
end

function TabFrameCommonTab:_onClearLeafCell(cell, tabData, tag)
	local redpoint = goutil.findChild(cell, "redpoint")

	RedPointController.instance:unregRedPoint(redpoint)
end

return TabFrameCommonTab

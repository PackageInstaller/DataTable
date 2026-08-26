-- chunkname: @modules/logic/room/view/backpack/RoomBackpackView.lua

module("modules.logic.room.view.backpack.RoomBackpackView", package.seeall)

local RoomBackpackView = class("RoomBackpackView", BaseView)

function RoomBackpackView:onInitView()
	self._gocategoryItem = gohelper.findChild(self.viewGO, "#scroll_category/viewport/content/#go_categoryItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBackpackView:addEvents()
	return
end

function RoomBackpackView:removeEvents()
	return
end

function RoomBackpackView:_btnTabOnClick(tabId)
	local checkResult = self.viewContainer:checkTabId(tabId)

	if not checkResult then
		logError(string.format("RoomBackpackView._btnTabOnClick error, no subview, tabId:%s", tabId))

		return
	end

	if self._curSelectTab == tabId then
		return
	end

	self.viewContainer:switchTab(tabId)

	self._curSelectTab = tabId

	self:refreshTab()
end

function RoomBackpackView:_editableInitView()
	gohelper.setActive(self._gocategoryItem, false)
	self:clearVar()
end

function RoomBackpackView:onUpdateParam()
	return
end

function RoomBackpackView:onOpen()
	self._curSelectTab = self.viewContainer:getDefaultSelectedTab()

	self:setTabItem()
	self:refreshTab()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_lower)
end

function RoomBackpackView:setTabItem()
	for tabId, tabSetting in ipairs(RoomBackpackViewContainer.TabSettingList) do
		local tabItem = self._tabDict[tabId]

		if not tabItem then
			local go = gohelper.cloneInPlace(self._gocategoryItem, tabId)

			if not gohelper.isNil(go) then
				tabItem = self:getUserDataTb_()
				tabItem.go = go
				tabItem.btn = gohelper.getClickWithDefaultAudio(go)

				tabItem.btn:AddClickListener(self._btnTabOnClick, self, tabId)

				tabItem.goselected = gohelper.findChild(go, "#go_selected")
				tabItem.gounselected = gohelper.findChild(go, "#go_normal")
				tabItem.goreddot = gohelper.findChild(go, "#go_reddot")

				if tabId == RoomBackpackViewContainer.SubViewTabId.Critter then
					RedDotController.instance:addRedDot(tabItem.goreddot, RedDotEnum.DotNode.CritterIsFull)
				end

				local namecn = luaLang(tabSetting.namecn)
				local unselectednamecn = gohelper.findChildText(go, "#go_normal/#txt_namecn")
				local selectednamecn = gohelper.findChildText(go, "#go_selected/#txt_namecn")

				unselectednamecn.text = namecn
				selectednamecn.text = namecn

				local nameen = luaLang(tabSetting.nameen)
				local unselectednameen = gohelper.findChildText(go, "#go_normal/#txt_nameen")
				local selectednameen = gohelper.findChildText(go, "#go_selected/#txt_nameen")

				unselectednameen.text = nameen
				selectednameen.text = nameen

				gohelper.setActive(go, true)

				self._tabDict[tabId] = tabItem
			end
		end
	end
end

function RoomBackpackView:refreshTab()
	for tabId, tab in pairs(self._tabDict) do
		local isSelected = tabId == self._curSelectTab

		gohelper.setActive(tab.goselected, isSelected)
		gohelper.setActive(tab.gounselected, not isSelected)
	end
end

function RoomBackpackView:clearVar()
	self._curSelectTab = nil

	self:clearTab()
end

function RoomBackpackView:clearTab()
	if self._tabDict then
		for _, tab in pairs(self._tabDict) do
			tab.btn:RemoveClickListener()
		end
	end

	self._tabDict = {}
end

function RoomBackpackView:onClose()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
end

function RoomBackpackView:onDestroyView()
	self:clearVar()
end

return RoomBackpackView

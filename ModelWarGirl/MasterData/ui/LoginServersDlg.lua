-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\LoginServersDlg.lua

local UIControls = require("UI/UIControls")
local EventConst = require("EventConst")
local SwitchServerHelper = require("Helper/SwitchServerHelper")
local ResSubServerList = require("ClientData/ResSubServerList")
local SvrListManager = SvrListManager
local EventCenter = EventCenter
local REQ_TYPE = SvrListManager.REQ_TYPE

if Framework.Tools.LuaToolkit.IsEditor() or not IS_PUBLISH_VERSION then
	ResSubServerList = {
		{
			Subtab = Lang.get(80587)
		},
		{
			Subtab = Lang.get(80588)
		},
		{
			Subtab = Lang.get(78791)
		},
		{
			Subtab = Lang.get(80589)
		},
		{
			Subtab = Lang.get(45087)
		},
		{
			Subtab = Lang.get(45088)
		},
		{
			Subtab = Lang.get(45089)
		},
		{
			Subtab = Lang.get(45090)
		},
		{
			Subtab = Lang.get(46266)
		},
		{
			Subtab = Lang.get(48653)
		},
		{
			Subtab = Lang.get(51264)
		},
		{
			Subtab = Lang.get(63936)
		},
		{
			Subtab = Lang.get(45091)
		},
		{
			Subtab = Lang.get(532)
		}
	}
end

local LoginServerCell = Class("LoginServerCell", UIControls.ScrollViewLoopCell)

function LoginServerCell:ctor()
	self._preClickMaintainNum = 0
	self._preClickMaintainTime = os.time()
	self.BtnServerNml = UIControls.Button(self, "BtnServerNml")

	self.BtnServerNml:addEventClick(self.onSensorClick)

	self.subGridPlayerNml = UIControls.PlayerHeadGridChild(self, "BtnServerNml/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.subGridPlayerNml:setEnable(false)
	self.subGridPlayerNml:setVisible(true)

	self.BtnServerDis = UIControls.Button(self, "BtnServerDis")

	self.BtnServerDis:addEventClick(self.onSensorClick)

	self.subGridPlayerDis = UIControls.PlayerHeadGridChild(self, "BtnServerDis/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.subGridPlayerDis:setEnable(false)
	self.subGridPlayerDis:setVisible(true)
	self.subGridPlayerDis:setGray(true)
end

function LoginServerCell:setServerCellInfo(info, unSelect)
	local serverShouldShow

	self._info = info
	self._state = info.state

	local roleInfo = SvrListManager.getRoleInfo(info.id)

	if info.state ~= Const.SERVER_STATE_MAINTAIN then
		self.BtnServerDis:setVisible(false)
		self.BtnServerNml:setVisible(true)
		self.BtnServerNml:setEnable(not unSelect)

		self.isServerMaintain = false
		serverShouldShow = "BtnServerNml"

		UIControls.Panel(self, "BtnServerDis"):setVisible(false)

		self.imgNew = UIControls.Panel(self, "BtnServerNml/IconNew")

		self.imgNew:setVisible(info.state == Const.SERVER_STATE_RECOMMEND or false)

		self.GridPlayer = UIControls.Panel(self, "BtnServerNml/GridPlayer")

		if roleInfo then
			self.GridPlayer:setVisible(true)
			self.subGridPlayerNml:setCommInfo(roleInfo, true, self)
		else
			self.GridPlayer:setVisible(false)
		end
	else
		self.BtnServerNml:setVisible(false)
		self.BtnServerDis:setVisible(true)
		self.BtnServerDis:setEnable(not unSelect)

		self.isServerMaintain = true
		serverShouldShow = "BtnServerDis"

		UIControls.Panel(self, "BtnServerNml"):setVisible(false)

		self.GridPlayer = UIControls.Panel(self, "BtnServerDis/GridPlayer")

		if roleInfo then
			self.GridPlayer:setVisible(true)
			self.subGridPlayerDis:setCommInfo(roleInfo, true, self)
		else
			self.GridPlayer:setVisible(false)
		end
	end

	self.serverName = UIControls.Label(self, serverShouldShow .. "/TextName")

	self.serverName:setText(info.name or Lang.get(30078))
end

function LoginServerCell:onSensorClick(sender)
	if not self.isServerMaintain or self._preClickMaintainNum >= 5 then
		self._preClickMaintainNum = 0

		if self.mEventSelect then
			self.mEventSelect(self._info.id)

			return
		end
	else
		MsgManager.clientNotice(271)
	end

	if self._preClickMaintainTime and os.time() - self._preClickMaintainTime < 5 then
		self._preClickMaintainNum = self._preClickMaintainNum + 1
	else
		self._preClickMaintainTime = os.time()
		self._preClickMaintainNum = 1
	end
end

local LoginServerTab = Class("LoginServerTab", UIControls.Child)

function LoginServerTab:ctor()
	self.sensor = UIControls.Button(self, "", "Text")

	self.sensor:addEventClick(self.onTabClick)
end

function LoginServerTab:setInfo(info)
	self._info = info

	self.sensor:setText(info.name or Lang.get(30079))
end

function LoginServerTab:setData(groupType, groupId)
	self.groupType = groupType
	self.groupId = groupId
end

function LoginServerTab:onTabClick(sender)
	if self.mEventSelect then
		self.mEventSelect(self._info, sender, self.groupId)
	end
end

local LoginSubServerTab = Class("LoginSubServerTab", UIControls.ScrollViewLoopCell)

LoginSubServerTab.parity = {
	even_number = 0,
	odd_number = 1
}

function LoginSubServerTab:ctor()
	self.sensor = UIControls.Button(self, "", "Text")

	self.sensor:addEventClick(self.onSensorClick)

	self.selectedBg = UIControls.Image(self, "BgBtn")
end

function LoginSubServerTab:setSubServerTabInfo(info, unSelect)
	self._info = info
	self._id = info.id

	self.sensor:setText(info.name or Lang.get(30078))
	self.sensor:setEnable(not unSelect)

	self.parity = 0

	if info.id % 2 == 0 then
		self.parity = LoginSubServerTab.parity.even_number

		self.selectedBg:setImage("Atlas/LoginAtlas/LoginAtlas", "BtnChoiceAsh")
	else
		self.parity = LoginSubServerTab.parity.odd_number

		self.selectedBg:setImage("Atlas/LoginAtlas/LoginAtlas", "BtnChoiceBlack")
	end
end

function LoginSubServerTab:onSensorClick(sender)
	if self.mEventSelect then
		self.mEventSelect(self._info, sender, self._id)
	end
end

local strClassName = "LoginServersDlg"
local LoginServersDlg = Class(strClassName, UIControls.Window)

function LoginServersDlg:_debugGroupServers(serverID)
	local server = SvrListManager.getServerInfo(serverID)
	local text = server.name
	local f_start, f_end = string.find(text, "-")
	local groupId

	if f_start then
		groupId = tonumber(string.sub(text, 1, tonumber(f_start) - 1))
	end

	local id

	id = (groupId == 1 or groupId == 9) and 1 or (groupId == 38 or groupId == 39) and 2 or (groupId == 40 or groupId == 41 or groupId == 42) and 3 or (groupId == 7 or groupId == 8 or groupId == 37) and 4 or groupId == 15 and 5 or (groupId == 12 or groupId == 18) and 6 or groupId == 21 and 7 or (groupId == 13 or groupId == 25) and 8 or groupId == 23 and 9 or (groupId == 19 or groupId == 22) and 10 or (groupId == 24 or groupId == 32) and 11 or (groupId == 28 or groupId == 29 or groupId == 33) and 12 or (groupId == 11 or groupId == 16) and 13 or 14

	if not self.groupAllServers[id] then
		self.groupAllServers[id] = {}
	end

	table.insert(self.groupAllServers[id], serverID)
end

local subServerListCount = 20
local RECENT_GROUP_ID = -999
local RECOMMEND_GROUP_ID = -998
local GroupType = {
	NORMAL = 1,
	RECENT = 2
}

function LoginServersDlg:ctor()
	self.tabs = {}
	self._serverCells = {}
	self._slot4TabSelect = Slot(self.onTabClick, self)
	self._slot4ServerSelect = Slot(self.onServerClick, self)
	self._slot4SubTabSelect = Slot(self.onSubTabClick, self)
	self._slotSelectedServerChanged = Slot(self.onSelectedServerChanged, self)
	self._slotServerListChanged = Slot(self.onServerListChanged, self)
	self.recentSrvName = UIControls.Label(self, "BgPanel/ServerState/TextServer")
	self.textTitle = UIControls.Label(self, "BgPanel/ServerState/TextTitle")
	self.ServerPanel1 = UIControls.ScrollViewLoopV(self, "BgPanel/ServerPanel1", 0, self.onServerCellChanged)

	self.ServerPanel1:setVisible(true)

	self.bgServerList = UIControls.Panel(self, "BgPanel/BgServerList")

	self.bgServerList:setVisible(true)

	self.ServerPanel2 = UIControls.Panel(self, "BgPanel/ServerPanel2")

	self.ServerPanel2:setVisible(false)

	self.ServerPanel2_SubTabList = UIControls.ScrollViewLoopV(self, "BgPanel/ServerPanel2/SubTabList", 0, self.refreshSubTabs)
	self.ServerPanel2_SubServerList = UIControls.ScrollViewLoopV(self, "BgPanel/ServerPanel2/ServerList", 0, self.onServerCellChanged)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onDlgClose)
end

function LoginServersDlg:onOpen()
	LoginServersDlg.super.onOpen(self)
	self:groupingAllServers()

	self._pickedTabGroupId = 1

	self:refreshAll()
	EventCenter.addEventListener(EventConst.SELECTED_SERVER_CHANGED, self._slotSelectedServerChanged)
	EventCenter.addEventListener(EventConst.SERVER_LIST_CHANGED, self._slotServerListChanged)
end

function LoginServersDlg:onClose()
	EventCenter.removeEventListener(EventConst.SELECTED_SERVER_CHANGED, self._slotSelectedServerChanged)
	EventCenter.removeEventListener(EventConst.SERVER_LIST_CHANGED, self._slotServerListChanged)
	SvrListManager.stopRequest(REQ_TYPE.FULL)
	LoginServersDlg.super.onClose(self)
end

function LoginServersDlg:showServers(isSettingChangeSvr)
	if isSettingChangeSvr then
		self.isSettingChangeSvr = isSettingChangeSvr

		self.textTitle:setText(Lang.get(30080))
	else
		self.isSettingChangeSvr = isSettingChangeSvr

		self.textTitle:setText(Lang.get(1400))
	end

	if not self:getVisible() then
		self:setVisible(true)
	end

	self:updateServerList()
	self:onServerListChanged()
end

function LoginServersDlg:updateServerList()
	SvrListManager.requestUpdate(REQ_TYPE.FULL)
	SvrListManager.requestUpdate(REQ_TYPE.ENTRY)
end

function LoginServersDlg:onServerListChanged()
	local TextServer = SvrListManager.getServerInfo(SvrListManager.getLastLoginSvrID())
	local subServerList

	if not self.isSettingChangeSvr and self.lastLogin then
		subServerList = ResSubServerList[self.lastLogin % #ResSubServerList]
	else
		subServerList = ResSubServerList[self.subTabSelectDefault % #ResSubServerList]
	end

	local subTabName = subServerList and subServerList.Subtab or ResSubServerList[#ResSubServerList].Subtab

	if subTabName and TextServer ~= nil and not self.isSettingChangeSvr then
		self.recentSrvName:setText(subTabName .. " - " .. TextServer.name)
	elseif TextServer ~= nil and not self.isSettingChangeSvr then
		self.recentSrvName:setText(TextServer.name)
	elseif self.isSettingChangeSvr and subTabName then
		local selected = SvrListManager.getServerInfo(SvrListManager.getSelectedSvrID())

		self.recentSrvName:setText(subTabName .. " - " .. selected.name)
	elseif self.isSettingChangeSvr then
		local selected = SvrListManager.getServerInfo(SvrListManager.getSelectedSvrID())

		self.recentSrvName:setText(selected.name)
	else
		self.recentSrvName:setText(Lang.get(3845))
	end

	self:refreshAll()
end

function LoginServersDlg:onSelectedServerChanged()
	self:refreshServers()
end

function LoginServersDlg:refreshAll()
	self:refreshTabs()
	self:refreshServers()
end

function LoginServersDlg:refreshTabs()
	local idx = 1

	for i = 1, 2 do
		local groupInfo = {
			id = i,
			name = i == 1 and Lang.get(1369) or Lang.get(30081)
		}
		local tab = self.tabs[idx]
		local groupId = groupInfo.id

		if tab == nil then
			tab = LoginServerTab(self, "BgPanel/TabPanel/Content", "System/Login/BtnTabServer", 0, 0, true)
			tab.mEventSelect = self._slot4TabSelect
			self.tabs[idx] = tab
		end

		idx = idx + 1

		tab:setInfo(groupInfo)

		if groupId == RECENT_GROUP_ID then
			tab:setData(GroupType.RECENT, groupId)
		else
			tab:setData(GroupType.NORMAL, groupId)
		end
	end

	local tabIndex = self:getTabIndex(self._pickedTabGroupId)

	if tabIndex then
		self:switchTab(self.tabs[tabIndex].sensor, tabIndex)
	end
end

function LoginServersDlg:refreshSubTabs(sender, targetCell, newIdx)
	local index = self.subTabCount - newIdx + 1
	local info = {}

	if targetCell == nil then
		targetCell = LoginSubServerTab(sender, "System/Login/BtnSubTabServer", index, 0, 0)
		targetCell.mEventSelect = self._slot4SubTabSelect
	end

	local subServerList = ResSubServerList[index % #ResSubServerList]

	info.name = subServerList and subServerList.Subtab or ResSubServerList[#ResSubServerList].Subtab or tostring(1 + (index - 1) * subServerListCount) .. " - " .. tostring(subServerListCount + (index - 1) * subServerListCount)
	info.id = index

	targetCell:setSubServerTabInfo(info)

	if index == self.subTabSelectDefault then
		self:switchSubTab(targetCell.sensor, self.subTabSelectDefault)
	end
end

function LoginServersDlg.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end

	return false
end

function LoginServersDlg:refreshServers()
	if self._pickedTabGroupId == 1 then
		self._groupServers = {}
		self._curSubTab = nil

		local cellRecentList = SvrListManager.getRecentList()
		local cellRecommendList = SvrListManager.getRecommendList()

		table.sort(cellRecentList, function(a, b)
			return b < a
		end)

		for _, v in ipairs(cellRecentList) do
			if SvrListManager.getServerInfo(v) then
				table.insert(self._groupServers, v)
			end
		end

		for _, v in ipairs(cellRecommendList) do
			if not LoginServersDlg.contains(self._groupServers, v) and SvrListManager.getServerInfo(v) then
				table.insert(self._groupServers, v)
			end
		end

		self.ServerPanel1:setVisible(true)
		self.bgServerList:setVisible(true)
		self.ServerPanel2:setVisible(false)

		local jumpIdx = self:jumpIndex(self._groupServers, true)

		self.ServerPanel1:setTotalCount(#self._groupServers, jumpIdx)
	else
		self:groupingAllServers()
		self.ServerPanel1:setVisible(false)
		self.bgServerList:setVisible(false)
		self.ServerPanel2:setVisible(true)

		local jumpIdx = 0

		if self.subTabCount - self.subTabSelectDefault < 6 then
			jumpIdx = 0
		elseif self.subTabSelectDefault < 6 then
			jumpIdx = self.subTabCount - 5
		else
			jumpIdx = self.subTabCount - self.subTabSelectDefault + 1
		end

		self.ServerPanel2_SubTabList:setTotalCount(self.subTabCount, jumpIdx)
	end
end

function LoginServersDlg:jumpIndex(serverCells, isCommend, groupId)
	if self.subTabSelectDefault ~= groupId and not isCommend then
		return 0
	end

	local jumpIdx = 0
	local selectedID = SvrListManager.getSelectedSvrID()

	for k, v in ipairs(serverCells) do
		if selectedID == v then
			jumpIdx = k

			break
		end
	end

	if not isCommend then
		jumpIdx = #serverCells - jumpIdx + 1
	end

	if #serverCells <= (#serverCells % 2 == 1 and 7 or 8) then
		jumpIdx = 0
	elseif #serverCells - jumpIdx < 8 then
		jumpIdx = #serverCells - (#serverCells % 2 == 1 and 8 or 7)
	else
		jumpIdx = jumpIdx - (jumpIdx % 2 == 1 and 0 or 1)
	end

	return jumpIdx
end

function LoginServersDlg:groupingAllServers()
	local allServers = SvrListManager.getFullList()
	local allServersCount = #allServers
	local selected = SvrListManager.getSelectedSvrID()
	local lastLoginSvrID = SvrListManager.getLastLoginSvrID()

	self.subTabCount = math.ceil(allServersCount / subServerListCount)
	self.groupAllServers = {}

	for i = 1, self.subTabCount do
		self.groupAllServers[i] = {}
	end

	for i = 1, allServersCount do
		if Framework.Tools.LuaToolkit.IsEditor() then
			self:_debugGroupServers(allServers[i])

			self.subTabCount = #ResSubServerList
		else
			table.insert(self.groupAllServers[math.ceil(i / subServerListCount)], allServers[i])
		end

		if selected == allServers[i] then
			self.subTabSelectDefault = math.ceil(i / subServerListCount)
		end

		if lastLoginSvrID == allServers[i] then
			self.lastLogin = math.ceil(i / subServerListCount)
		end
	end

	if not self.subTabSelectDefault then
		self.subTabSelectDefault = self.subTabCount
	end
end

function LoginServersDlg:refreshSubServers(groupId)
	if not self.groupAllServers[groupId] then
		return
	end

	self._selectSubGroupId = groupId

	local jumpIdx = self.subTabSelectDefault == groupId and self:jumpIndex(self.groupAllServers[groupId], nil, groupId) or 1

	self.ServerPanel2_SubServerList:setTotalCount(#self.groupAllServers[groupId], jumpIdx)
end

function LoginServersDlg:onServerCellChanged(sender, targetCell, newIdx)
	if self._pickedTabGroupId == 2 then
		newIdx = #self.groupAllServers[self._selectSubGroupId] - newIdx + 1
	end

	local id = self._pickedTabGroupId == 1 and self._groupServers[newIdx] or self.groupAllServers[self._selectSubGroupId][newIdx]
	local serverInfo = SvrListManager.getServerInfo(id)

	if serverInfo == nil or serverInfo.name == nil then
		return
	end

	if targetCell == nil then
		targetCell = LoginServerCell(sender, "System/Login/ServerCell", newIdx, 0, 0)

		if not targetCell.mEventSelect then
			targetCell.mEventSelect = self._slot4ServerSelect
		end
	else
		if targetCell.idx then
			self._serverCells[targetCell.idx] = nil
		end

		targetCell.idx = newIdx
	end

	self._serverCells[newIdx] = targetCell

	local selectedID = SvrListManager.getSelectedSvrID()

	targetCell:setServerCellInfo(serverInfo, serverInfo.id == selectedID)
end

function LoginServersDlg:switchTab(tab, groupId)
	if self._curTab then
		self._curTab:setEnable(true)
	end

	if tab then
		tab:setEnable(false)
	end

	self._curTab = tab
end

function LoginServersDlg:switchSubTab(tab, groupId)
	if self._curSubTab then
		self._curSubTab:setEnable(true)

		if self._curSubTab.mParent.parity == LoginSubServerTab.parity.even_number then
			self._curSubTab.mParent.selectedBg:setImage("Atlas/LoginAtlas/LoginAtlas", "BtnChoiceAsh")
		else
			self._curSubTab.mParent.selectedBg:setImage("Atlas/LoginAtlas/LoginAtlas", "BtnChoiceBlack")
		end
	else
		self:refreshSubServers(groupId)
	end

	if tab then
		tab:setEnable(false)
		tab.mParent.selectedBg:setImage("Atlas/LoginAtlas/LoginAtlas", "BtnChoiceYellow")
	end

	self._curSubTab = tab
end

function LoginServersDlg:onTabClick(info, tab, groupId)
	self._pickedTabGroupId = groupId

	self:switchTab(tab, groupId)
	self:refreshServers(groupId)
end

function LoginServersDlg:onSubTabClick(info, tab, groupId)
	self:switchSubTab(tab, groupId)
	self:refreshSubServers(groupId)
end

function LoginServersDlg:onServerClick(id)
	local serverinfo = SvrListManager.getServerInfo(id)

	if self.isSettingChangeSvr then
		local function yes_changeSvr()
			SwitchServerHelper.changeSvrAndTryReset(serverinfo)
		end

		SwitchServerHelper.tryUpdatePatchVersion(serverinfo.svrMark)
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(8), string.format(Lang.get(30077), serverinfo.name), yes_changeSvr, nil)

		return
	else
		SvrListManager.selectWithPriority(id, SvrListManager.PRIORITY_USER)
	end

	self:setVisible(false)
end

function LoginServersDlg:onDlgClose(sender)
	self:setVisible(false)
end

local Group_Priority = {
	RECENT_GROUP_ID,
	RECOMMEND_GROUP_ID
}

function LoginServersDlg:getTabIndex(pickedGroupId)
	if pickedGroupId == nil then
		local svrList = SvrListManager.getFullList()

		if svrList then
			for _, groupId in ipairs(Group_Priority) do
				if svrList[groupId] and #svrList[groupId] > 0 then
					pickedGroupId = groupId

					break
				end
			end
		end
	end

	if pickedGroupId then
		for i, tab in pairs(self.tabs) do
			if tab.groupId == pickedGroupId then
				return i
			end
		end
	end

	for i, tab in pairs(self.tabs) do
		local included = false

		for _, gorupId in ipairs(Group_Priority) do
			if tab.groupId == gorupId then
				included = true

				break
			end
		end

		if not included then
			return i
		end
	end
end

return LoginServersDlg

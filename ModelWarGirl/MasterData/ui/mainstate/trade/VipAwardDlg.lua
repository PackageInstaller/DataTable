-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\VipAwardDlg.lua

local VIPAttrItem = require("UI/Welfare/VIPAttrItem")
local ResVip = require("ClientData/ResVIP")
local ResPrivilege = require("ClientData/ResPrivilege")
local strClassName = "VipAwardDlg"
local VipAwardDlg = Class(strClassName, UIControls.Window)

function VipAwardDlg:ctor()
	self:initUI()
end

function VipAwardDlg:initUI()
	self.awardGrids = {}
	self.privItems = {}
	self._slot4Attr = Slot(self.onSttrClick, self)
	self.imgVip = UIControls.Image(self, "Bg/VIPInfo/IconVIP")
	self.txtVip = UIControls.Label(self, "Bg/VIPInfo/TextVIP")
	self.attrInfoAnim = UIControls.UIAni(self, "Bg/VIPAttrInfoPanel")
	self.attrInfoPanel = UIControls.Panel(self, "Bg/VIPAttrInfoPanel")
	self.txtAttrInfo = UIControls.Label(self, "Bg/VIPAttrInfoPanel/Text")
	self.contentPanel = UIControls.Panel(self, "Bg/AwardList/Content")
	self.scroller = UIControls.ScrollView(self, "Bg/AwardList")
	self.contentAttrPanel = UIControls.Panel(self, "Bg/VipBuffList/Content")
	self.attrScroller = UIControls.ScrollView(self, "Bg/VipBuffList")
end

function VipAwardDlg:onShow(param, attrs, items, heros, equip, artifact, relic)
	self.curVipLevel = param

	local clientItems = {}

	for _, item in pairs(ClientUtils.getAttrItems(attrs)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonItems(items)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonEquips(equip)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonArtifactsById(artifact)) do
		table.insert(clientItems, item)
	end

	if relic then
		for _, item in pairs(ClientUtils.getCommonRelicsById(relic)) do
			table.insert(clientItems, item)
		end
	end

	for index, item in ipairs(clientItems) do
		local nameGridContainer = UIControls.GridNameContainerChild(self, "Bg/AwardList/Content", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)

		nameGridContainer.mDisableWays = true

		nameGridContainer:setObj(item)

		if Const.HIDE_VIP_ATTR_NAME then
			nameGridContainer.txtItemName:setText("")
		end

		table.insert(self.awardGrids, nameGridContainer.grid)
	end

	CurAvatar:resetOpenBoxDlg()
	self:initVipInfo()
end

function VipAwardDlg:initVipInfo()
	self.vipData = ResVip[self.curVipLevel]

	self.txtVip:setText(self.curVipLevel)
	self.imgVip:setImage("Atlas/StoreAtlas/" .. self.vipData.icon_path, self.vipData.icon_name)
	self:showPrivs()
end

function VipAwardDlg:showPrivs()
	local data = self.vipData
	local level = self.curVipLevel

	for _, pItem in ipairs(self.privItems) do
		pItem:setVisible(false)
	end

	if not data.privilege_id then
		return
	end

	local priIds = {}
	local privTab = {}

	for i, id in ipairs(data.privilege_id) do
		local lastVipPriData = CurAvatar:getVipClientData(level - 1).priIdByType

		if not lastVipPriData[ResPrivilege[id].type] then
			privTab[id] = {
				2,
				i
			}

			table.insert(priIds, id)
		elseif not lastVipPriData[ResPrivilege[id].type][id] then
			privTab[id] = {
				1,
				i
			}

			table.insert(priIds, id)
		end
	end

	table.sort(priIds, function(a, b)
		if privTab[a][1] == privTab[b][1] then
			return privTab[a][2] < privTab[b][2]
		else
			return privTab[a][1] > privTab[b][1]
		end
	end)

	for index, id in ipairs(priIds) do
		local privData = ResPrivilege[id]

		if not self.privItems[index] then
			self.privItems[index] = VIPAttrItem(self, "Bg/VipBuffList/Content", "System/Store/BtnVIPAttr", 0, 0)
		end

		self.privItems[index]:setVisible(true)
		self.privItems[index]:setData(privData, nil, level)

		self.privItems[index].mEventClick = self._slot4Attr

		if Const.HIDE_VIP_ATTR_NAME then
			self.privItems[index].btn:setText("")
		end
	end

	for i, item in ipairs(self.privItems) do
		item:setSelect(false)
	end

	coroutine.start(self.coSetScrollEnable, self)
end

function VipAwardDlg:onSttrClick(info, visible)
	for i, item in ipairs(self.privItems) do
		item:setSelect(false)
	end

	if visible == true then
		self.attrInfoAnim:startAni("ShowVIPAttrInfo", true)
		self.txtAttrInfo:setText(info.desc)
		self.attrInfoPanel:setVisible(true)

		local voiceList = info.vioceIds

		if voiceList then
			local playVoiceId = voiceList[math.random(#voiceList)]

			CueManager.playVocal(playVoiceId)
		end
	else
		self.attrInfoAnim:startAni("HideVIPAttrInfo", true)
	end
end

function VipAwardDlg:coSetScrollEnable()
	coroutine.wait(0.1)

	local cellPanelPos = self.contentPanel:getRectSize()
	local attrPanelPos = self.contentAttrPanel:getRectSize()

	if cellPanelPos.width <= 1052 then
		self.scroller:setObjEnabled(false)
	else
		self.scroller:setObjEnabled(true)
	end

	if attrPanelPos.height <= 339 then
		self.attrScroller:setObjEnabled(false)
	else
		self.attrScroller:setObjEnabled(true)
	end
end

function VipAwardDlg:onClose(...)
	for _, grid in ipairs(self.awardGrids) do
		grid:flyToCommonFuncEntryPanel()
	end

	VipAwardDlg.super.onClose(self)
end

return VipAwardDlg

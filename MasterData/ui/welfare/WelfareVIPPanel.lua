-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareVIPPanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local DragTwoPages = require("UI/Control/DragTwoPages")
local ResVIP = require("ClientData/ResVIP")
local ResRandClient = require("ClientData/ResRandClient")
local ResPrivilege = require("ClientData/ResPrivilege")
local RPC = require("Framework/RPC")
local ResClientNotice = require("ClientData/ResClientNotice")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local VIPAttrItem = require("UI/Welfare/VIPAttrItem")
local VipInfoPage = Class("VipInfoPage", UIControls.Child)

function VipInfoPage:ctor()
	self.imgVip = UIControls.Image(self, "VIPInfoPanel/IconVIP")
	self.txtVip = UIControls.Label(self, "VIPInfoPanel/TextVIP")
	self.slider = UIControls.Slider(self, "VIPInfoPanel/VIPPointSlider", "ProgressPanel/Text")
	self.sliderFull = UIControls.Image(self, "VIPInfoPanel/VIPPointSlider/FillArea/Fill")
	self.img4Slider = UIControls.Image(self, "VIPInfoPanel/VIPPointSlider/ProgressPanel/Icon")
	self.btnGet = UIControls.Button(self, "VIPInfoPanel/AwardPanel/BtnGet")
	self.btnGo = UIControls.Button(self, "VIPInfoPanel/AwardPanel/BtnGo")
	self.txtState = UIControls.Label(self, "VIPInfoPanel/AwardPanel/TextState")
	self.txtAwardTitle = UIControls.Panel(self, "VIPInfoPanel/AwardPanel/TextTitle")
	self.txtTipV0 = UIControls.Label(self, "VIPInfoPanel/AwardPanel/TextV0")

	self.btnGet:addEventClick(self.onGetClick)
	self.btnGo:addEventClick(self.onGoClick)
	self.btnGo:setVisible(false)

	self.items = {}
	self.privItems = {}
end

function VipInfoPage:setData(level, srvData)
	self.level = level

	local data = CurAvatar:getVipClientData(level)

	self.data = data

	self.txtVip:setText(level)

	local moneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_VIP_POINT]

	self.img4Slider:setImage(moneyInfo[1], moneyInfo[2])

	if ResVIP[level + 1] then
		self.slider:setText(string.format("%d/%d", srvData.value, ResVIP[level + 1].need_exp))
	end

	self.imgVip:setImage("Atlas/StoreAtlas/" .. data.icon_path, data.icon_name)
	self.imgVip:setObjGray(false)

	self.state = 0

	if data.need_exp > srvData.value then
		if ResVIP[level - 1] then
			if ResVIP[level - 1].need_exp <= srvData.value then
				self.state = 1
			else
				self.state = 0
			end
		end

		self.slider:setValue(0)
		self.slider:setText("")
		self.imgVip:setObjGray(true)
	else
		self.state = 2

		if ResVIP[level + 1] then
			if ResVIP[level + 1].need_exp > srvData.value then
				self.slider:setValue(srvData.value / ResVIP[level + 1].need_exp)
			else
				self.slider:setText(Lang.get(98))
				self.slider:setValue(1)
			end
		end
	end

	if not ResVIP[level + 1] then
		if self.state == 2 then
			self.slider:setText(srvData.value)
			self.slider:setValue(1)
			self.sliderFull:setImage("Atlas/StoreAtlas/StoreVIPAtlas", "BgExpMax")
		end
	else
		self.sliderFull:setImage("Atlas/StoreAtlas/StoreVIPAtlas", "BgExp")
	end

	self.btnGet:setVisible(false)
	self.txtState:setVisible(false)
	self.txtTipV0:setVisible(false)
	self.txtAwardTitle:setVisible(true)

	local awardState = srvData.awardState[level]

	if self.state < 2 then
		if not awardState then
			self.txtAwardTitle:setVisible(false)
		end
	elseif awardState == 1 then
		self.btnGet:setVisible(true)
	elseif awardState == 2 then
		self.txtState:setText(Lang.get(74))
		self.txtState:setVisible(true)
	else
		self.txtAwardTitle:setVisible(false)

		if self.level == 0 then
			self.txtTipV0:setText(ResClientNotice[237].notice)
			self.txtTipV0:setVisible(true)
		else
			self.txtState:setText(Lang.get(98))
			self.txtState:setVisible(true)
		end
	end

	local stateList = srvData.awardState
	local hasPreAward = false
	local hasNextAward = false

	for i = 0, level - 1 do
		if stateList[i] == 1 then
			hasPreAward = true

			break
		end
	end

	for i = level + 1, Const.VIP_MAX_LEVEL + 1 do
		if stateList[i] == 1 then
			hasNextAward = true

			break
		end
	end

	self.mParent:setPreNew(hasPreAward)
	self.mParent:setNextNew(hasNextAward)
	self:refreshAwardItems(awardState)
	self:resetPrivs(level, srvData, self.state)
end

function VipInfoPage:refreshAwardItems(awardState)
	for _, item in ipairs(self.items) do
		item:destroy()
	end

	if awardState == nil then
		return
	end

	local data = self.data
	local awardData = ResRandClient[data.award]

	for idx, id in ipairs(awardData.show_ids) do
		local item = BaseObject.GetObject(id, awardData.show_nums[idx])

		self.items[idx] = UIControls.getGridChild(item, self, "VIPInfoPanel/AwardPanel/AwardGridPanel")

		self.items[idx]:setVisible(true)

		self.items[idx].isShowPreviewTips = true
		self.items[idx].mDisableWays = true

		self.items[idx]:setObj(item)

		if awardState == 2 then
			self.items[idx]:setObjGray(true)
		else
			self.items[idx]:setObjGray(false)
		end
	end
end

function VipInfoPage:resetPrivs(level, srvData, state)
	local data = self.data

	for _, pItem in ipairs(self.privItems) do
		pItem:setVisible(false)
	end

	if not data.privilege_id then
		return
	end

	local priIds = {}

	for idx, id in ipairs(data.privilege_id) do
		priIds[#priIds + 1] = id
	end

	if state == 2 then
		-- block empty
	elseif ResVIP[level - 1] then
		local privTab = {}

		for i, id in ipairs(priIds) do
			privTab[id] = {
				0,
				i
			}

			local lastVipPriData = CurAvatar:getVipClientData(level - 1).priIdByType

			if not lastVipPriData[ResPrivilege[id].type] then
				privTab[id] = {
					2,
					i
				}
			elseif not lastVipPriData[ResPrivilege[id].type][id] then
				privTab[id] = {
					1,
					i
				}
			end
		end

		table.sort(priIds, function(a, b)
			if privTab[a][1] == privTab[b][1] then
				return privTab[a][2] < privTab[b][2]
			else
				return privTab[a][1] > privTab[b][1]
			end
		end)
	end

	self._slot4Attr = Slot(self.onSttrClick, self)

	for index, id in ipairs(priIds) do
		local privData = ResPrivilege[id]

		if not self.privItems[index] then
			self.privItems[index] = VIPAttrItem(self, "VIPAttrPanel/Content", "System/Store/BtnVIPAttr", 0, 0)
		end

		self.privItems[index]:setVisible(true)
		self.privItems[index]:setData(privData, state, self.level)

		self.privItems[index].mEventClick = self._slot4Attr
	end

	for i, item in ipairs(self.privItems) do
		item:setSelect(false)
	end
end

function VipInfoPage:onSttrClick(info, visible)
	for i, item in ipairs(self.privItems) do
		item:setSelect(false)
	end

	if self.btnAttrEventClick then
		self.btnAttrEventClick(info, visible)
	end
end

function VipInfoPage:onGetClick()
	if self.btnGetEventClick then
		self:btnGetEventClick(self.level)
	end
end

function VipInfoPage:onGoClick()
	if self.btnGoEventClick then
		self:btnGoEventClick()
	end
end

local strClassName = "WelfareVIPPanel"
local WelfareVIPPanel = Class(strClassName, welfareBase)

function WelfareVIPPanel:ctor()
	self.maxLevel = Const.VIP_MAX_LEVEL
	self._slot4btnAttr = Slot(self.onBtnAttrClick, self)

	self:initUI()
end

function WelfareVIPPanel:initUI()
	self.dragPages = DragTwoPages(self, "Mask/ContentPanel1", "Mask/ContentPanel2", "BtnPre", "BtnNext")
	self.attrInfoPanel = UIControls.Panel(self, "VIPAttrInfoPanel")
	self.txtAttrInfo = UIControls.Label(self, "VIPAttrInfoPanel/Text")
	self.imgPreNew = UIControls.Image(self, "BtnPre/IconNew")
	self.imgNextNew = UIControls.Image(self, "BtnNext/IconNew")
	self.attrInfoAnim = UIControls.UIAni(self, "VIPAttrInfoPanel")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.pages = {}

	for i = 1, 2 do
		self.pages[i] = VipInfoPage(self, "Mask/ContentPanel" .. i, "System/Store/StoreVIPInfoPanel")

		self.pages[i]:setVisible(true)

		self.pages[i].btnAttrEventClick = self._slot4btnAttr
		self.pages[i].btnGetEventClick = self.onBtnGetClick
		self.pages[i].btnGoEventClick = self.onBtnGoClick
	end
end

function WelfareVIPPanel:refreshData()
	self.srvData = CurAvatar:getVipSrvData()

	if self.curPage then
		self.curPage:setData(self.currentPageIndex - 1, self.srvData)
	end

	self.dragPages:initPage(self.maxLevel + 1, self.srvData.curShowLevel + 1)
end

function WelfareVIPPanel:onOpenPanel()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, UIMiscConfig.VIP_UI_ID)
	self:refreshData()
end

function WelfareVIPPanel:onClosePanel()
	WelfareVIPPanel.super.onClosePanel(self)
end

function WelfareVIPPanel:onBtnAttrClick(info, visible)
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

function WelfareVIPPanel:onBtnGoClick()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_JUMP)
	CurAvatar:jumpToRecharge()
end

function WelfareVIPPanel:onBtnGetClick(level)
	RPC.vIPGetAward(level)
end

function WelfareVIPPanel:setPreNew(isNew)
	self.imgPreNew:setVisible(isNew)
end

function WelfareVIPPanel:setNextNew(isNew)
	self.imgNextNew:setVisible(isNew)
end

function WelfareVIPPanel:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	self.attrInfoPanel:setVisible(false)

	self.currentPageIndex = currentPageIndex
	self.currentPanelIndex = panelIndex

	self.pages[panelIndex]:setData(currentPageIndex - 1, self.srvData)

	self.curPage = self.pages[panelIndex]
end

return WelfareVIPPanel

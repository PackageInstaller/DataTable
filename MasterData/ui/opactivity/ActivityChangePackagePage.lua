-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityChangePackagePage.lua

local ResShopExchg = require("ClientData/ResShopExchg")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local WebView = require("SDK/Plugin/WebView")
local UIControls = UIControls
local classNameStr = "ActivityChangePackagePage"
local ActivityChangePackagePage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityChangePackagePage, ActivityPanelMixin)

function ActivityChangePackagePage:initUI()
	self.grids = {}
	self.panelRuleLowVersion = UIControls.Panel(self, "TextRule1")
	self.panelRuleHighVersion = UIControls.Panel(self, "TextRule2")
	self.btnGoShop = UIControls.Panel(self, "BtnGo")
	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)
end

local CAN_CHANGE_VERSION = 349144

function ActivityChangePackagePage:_setData()
	self.hasGot = false
	self.opId = self.actObj.opId

	for exchgId, shopData in pairs(self.actObj.actData.clientData) do
		self.exchgId = exchgId

		local clientData = ResShopExchg[exchgId] or {}
		local bonus = {}

		for index, iInfo in ipairs(clientData.exchg or {}) do
			local iId = iInfo.key
			local iNum = iInfo.value or 1
			local newObj = BaseObject.GetObject(iId, iNum)

			table.insert(bonus, newObj)
		end

		ClientUtils.CreateBonusGridByItems(self, self.grids, "AwardPanel", bonus)

		local buyNum = self.actObj.actData:getHasBuyNum(exchgId)

		if buyNum > 0 then
			self.hasGot = true

			for index, grid in ipairs(self.grids) do
				grid:setGet(true)
			end
		end

		break
	end

	self.nowVersion = VersionUtils.getEngineVersion()

	if self.hasGot then
		self.btnGoShop:setVisible(false)
		self.btnGet:setVisible(false)
		self.panelRuleLowVersion:setVisible(false)
		self.panelRuleHighVersion:setVisible(true)
	elseif self.nowVersion > CAN_CHANGE_VERSION and self:checkRegion() then
		self.btnGoShop:setVisible(false)
		self.btnGet:setVisible(true)
		self.panelRuleLowVersion:setVisible(false)
		self.panelRuleHighVersion:setVisible(true)
	else
		self.btnGoShop:setVisible(true)
		self.btnGet:setVisible(false)
		self.panelRuleLowVersion:setVisible(true)
		self.panelRuleHighVersion:setVisible(false)
		self.panelRuleHighVersion:setVisible(false)
	end
end

local REGIONS = {
	RegionConst.REGION_JP,
	RegionConst.REGION_KR,
	RegionConst.REGION_SEA
}

function ActivityChangePackagePage:checkRegion()
	for i, region in pairs(REGIONS) do
		if RegionUtils.isCurrentRegion(region) then
			return true
		end
	end

	return false
end

function ActivityChangePackagePage:onBtnGetClick()
	if self.exchgId then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.exchgId, 1), self.opId)
	end
end

function ActivityChangePackagePage:onActivityDataRefresh(actObj)
	self:_setData()
end

return ActivityChangePackagePage

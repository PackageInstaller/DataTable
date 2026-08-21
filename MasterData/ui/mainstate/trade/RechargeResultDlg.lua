-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\RechargeResultDlg.lua

local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local strClassName = "RechargeResultDlg"
local RechargeResultDlg = Class(strClassName, UIControls.Window)

function RechargeResultDlg:ctor()
	self:initUI()
end

function RechargeResultDlg:initUI()
	self.awardGrids = {}
	self.contentPanel = UIControls.Panel(self, "Bg/AwardList/Content")
	self.scroller = UIControls.ScrollView(self, "Bg/AwardList")
end

function RechargeResultDlg:onShow(attrs, items, heros, equip, artifact, showTitle, closeCB, relic)
	self.closeCB = closeCB

	if showTitle then
		self.textTitle = UIControls.Label(self, "Bg/TextTitle")

		self.textTitle:setText(showTitle)
	end

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

		nameGridContainer:setObj(item)

		nameGridContainer.grid.mDisableWays = true

		table.insert(self.awardGrids, nameGridContainer.grid)
	end

	CurAvatar:resetOpenBoxDlg()
	coroutine.start(self.coSetScrollEnable, self)
end

function RechargeResultDlg:coSetScrollEnable()
	coroutine.wait(0.1)

	local cellPanelPos = self.contentPanel:getRectSize()

	if cellPanelPos.height <= 238 then
		self.scroller:setObjEnabled(false)
	else
		self.scroller:setObjEnabled(true)
	end
end

function RechargeResultDlg:onGetSkin(heroId, id)
	self.imgBed = UIControls.Image(self, "Bg/AwardList/ImgBed")
	self.txtName = UIControls.Label(self, "Bg/AwardList/TxtName")

	local baseData = ResItemHeroBase[heroId] and ResItemHeroBase[heroId][id] or nil

	if not baseData or not self.imgBed then
		self:setVisible(false)

		return
	end

	self.imgBed:setImage("Atlas" .. baseData.icon_path, baseData.icon_name)
	self.txtName:setText(baseData.name)
end

function RechargeResultDlg:onClose(...)
	for _, grid in ipairs(self.awardGrids) do
		grid:flyToCommonFuncEntryPanel()
	end

	if self.closeCB then
		self.closeCB()
	end

	RechargeResultDlg.super.onClose(self)
end

return RechargeResultDlg

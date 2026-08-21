-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CleanResultDlg.lua

local strClassName = "CleanResultDlg"
local CleanResultDlg = Class(strClassName, UIControls.Window)

function CleanResultDlg:ctor()
	self:initUI()
end

function CleanResultDlg:initUI()
	self.awardGrids = {}
	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
	self.panelFunc = UIControls.Panel(self, "Bg/FuncPanel")
	self.btnConfirm = UIControls.Button(self, "Bg/FuncPanel/BtnClose")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm)

	self.btnAgain = UIControls.Button(self, "Bg/FuncPanel/BtnClean", "Text")
	self.textCost = UIControls.Label(self, "Bg/FuncPanel/BtnClean/TextNum")

	self.btnAgain:addEventClick(self.onClickBtnAgain)

	self.sizeLayout = self:getController():GetCom(UIConst.ControlTypeLayoutElement, "Bg/AwardList")
	self.panelMaterial = UIControls.Panel(self, "Bg/MetrialPanel")
	self.txtMaterialName = UIControls.Label(self, "Bg/MetrialPanel/TextName")
	self.txtMaterialGet = UIControls.Label(self, "Bg/MetrialPanel/TextGet")
	self.txtMaterialNeed = UIControls.Label(self, "Bg/MetrialPanel/TextNeed")
end

function CleanResultDlg:onClickBtnConfirm()
	self:setVisible(false)
end

function CleanResultDlg:onClickBtnAgain()
	if self.againFunc then
		self.againFunc()
		self:setVisible(false)
	end
end

function CleanResultDlg:setAgainConfig(againFunc, textAgain, textCost)
	self.againFunc = againFunc

	self.btnAgain:setText(textAgain)
	self.textCost:setText(textCost or "")
	self.btnAgain:setVisible(true)
end

function CleanResultDlg:setNeedMaterial(itemId, getCount, needCount)
	local clientItem = BaseObject.GetObject(itemId, getCount)

	if not self.itemGrid then
		self.itemGrid = UIControls.getGridChild(clientItem, self, "Bg/MetrialPanel")
		self.itemGrid.mEnableTips = false

		self.itemGrid.btnSensor:clearEventClick()
		self.itemGrid:setVisible(true)
	end

	self.itemGrid:setObj(clientItem)
	self.panelMaterial:setVisible(true)
	self.txtMaterialGet:setText(string.format(Lang.get(30206), getCount))
	self.txtMaterialNeed:setText(string.format(Lang.get(30207), needCount))
	self.txtMaterialName:setText(clientItem.name)
end

function CleanResultDlg:onShow(notifyType, attrs, items, heros, equip, artifact, showTitle)
	self.textTitle:setText(showTitle or Lang.get(1747))

	self.againFunc = nil

	self.btnAgain:setVisible(false)

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

	for index, item in ipairs(clientItems) do
		local newGrid = {}

		if not self.awardGrids[index] then
			newGrid = UIControls.getGridChild(item, self, "Bg/AwardList/Content")

			newGrid:setVisible(true)

			newGrid.mDisableWays = true
			self.awardGrids[index] = newGrid
		end

		self.awardGrids[index]:setObj(item)
	end

	if #clientItems < #self.awardGrids then
		for index = #clientItems + 1, #self.awardGrids do
			self.awardGrids[index]:destroy()

			self.awardGrids[index] = nil
		end
	end

	if #clientItems <= 10 then
		self.sizeLayout.preferredHeight = 162
	elseif #clientItems <= 20 then
		self.sizeLayout.preferredHeight = 334
	else
		self.sizeLayout.preferredHeight = 400
	end
end

return CleanResultDlg

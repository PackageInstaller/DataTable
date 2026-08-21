-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPoolProbabilityDlg.lua

local ResPetGashaponDrawProbabilityShow = require("ClientData/ResPetGashaponDrawProbabilityShow")
local ResPetGashaponConfig = require("ClientData/ResPetGashaponConfig")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local ResPetGashaponDrawRuleShow = require("ClientData/ResPetGashaponDrawRuleShow")
local ResPetGashaponDrawUp = require("ClientData/ResPetGashaponDrawUp")
local ResPetGashaponDrawLib = require("ClientData/ResPetGashaponDrawLib")
local strClassName = "PoolProbabilityCell"
local PoolProbabilityCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PoolProbabilityCell:ctor()
	self:initUI()
end

function PoolProbabilityCell:initUI()
	self.imgSelf = UIControls.Image(self, "")
	self.bgGashapon = UIControls.Image(self, "BgGashapon")
	self.imgLinked = UIControls.Image(self, "BgGashapon/ImgLinked")
	self.textGrade = UIControls.Label(self, "TextGrade")
	self.textNum = UIControls.Label(self, "TextNum")
	self.textRealProbability = UIControls.Label(self, "TextRealProbability")
	self.itemCells = {}
end

function PoolProbabilityCell:setData(data)
	self.data = data
	self.configData = ResPetGashaponConfig[data.gashapon_id]

	if self.configData.icon_path then
		self.bgGashapon:setImage(self.configData.icon_path, self.configData.icon)
	end

	local atlas = "Atlas/PetPoolAtlas/PetPoolProbabilityAtlas/PetPoolProbabilityAtlas02"
	local imgName = {
		"BgGreenShort",
		"BgBlueShort",
		"BgYellowShort",
		"BgPinkShort"
	}

	self.imgSelf:setImage(atlas, imgName[self.configData.quality])
	self.imgLinked:setVisible(self.configData.quality == Const.PET_DRAW_QUALITY_ACT)
	self.textGrade:setText(self.configData.gashapon_name)

	local limitLibPb = ResPetGashaponDraw[1].limit_lib_probability
	local drawNum, limit = self:getGashaponDrawNum()
	local totalWeight = self.mParent.totalWeight

	if limit then
		self.textNum:setText(string.format(Lang.get(79920), limit - drawNum, limit))

		local curSelfWeight = self.mParent.everyWeights[data.gashapon_id]

		if totalWeight > 0 then
			self.textRealProbability:setText(string.format("%.2f%%", curSelfWeight * 100 / totalWeight * (limitLibPb / 100)))
		else
			self.textRealProbability:setText("0.00%")
		end
	else
		self.textNum:setText(Lang.get(79921))

		if CurAvatar:checkPetPoolCanReset() then
			self.textRealProbability:setText("100.00%")
		else
			local allOtherPb = 0

			for i, v in pairs(self.mParent.everyWeights) do
				local pb = string.format("%.2f", v * 100 / totalWeight * (limitLibPb / 100))

				allOtherPb = allOtherPb + pb
			end

			self.textRealProbability:setText(string.format("%.2f%%", 100 - allOtherPb))
		end
	end

	for i, cell in pairs(self.itemCells or {}) do
		cell:destroy()

		cell = nil
	end

	self.itemCells = {}

	for i, itemId in ipairs(self.data.reward) do
		local itemNum = self.data.reward_num[i]
		local fakeItem = BaseObject.GetObject(itemId, itemNum)
		local itemGrid = self.itemCells[i]

		if itemGrid == nil then
			itemGrid = UIControls.GridNameContainerChild(self, "AwardShowList/Content", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)
		end

		itemGrid.mDisableWays = true

		itemGrid:setObj(fakeItem)
		itemGrid.txtItemName:setVisible(false)
		itemGrid.txtItemNum:setVisible(true)

		if self.configData.quality == Const.PET_DRAW_QUALITY_SPECIAL_CHOOSE then
			itemGrid.txtItemNum:setText(Lang.get(79274))
		elseif tonumber(self.data.probability[i]) == 1 then
			itemGrid.txtItemNum:setText("100%")
		else
			itemGrid.txtItemNum:setText(self.data.probability[i] or "")
		end

		self.itemCells[i] = itemGrid
	end
end

function PoolProbabilityCell:getGashaponDrawNum()
	if self.configData.quality == Const.PET_DRAW_QUALITY_ACT then
		local limit

		for _, data in pairs(self.mParent.actObjs or {}) do
			local actObj = data.actObj

			for _, v in pairs(ResPetGashaponDrawLib[actObj.actData.replaceLibId] or {}) do
				if self.data.gashapon_id == v.gashapon_id then
					limit = v.limit
				end
			end

			for _, record in pairs(actObj.actData.drawData.drawRecord or {}) do
				if record.gashapon_id and self.data.gashapon_id == record.gashapon_id then
					return record.drawed_num, limit
				end
			end
		end

		return 0, limit
	else
		local limit

		for i, v in pairs(ResPetGashaponDrawLib[ResPetGashaponDraw[1].limit_lib] or {}) do
			if self.data.gashapon_id == v.gashapon_id then
				limit = v.limit
			end
		end

		for _, record in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
			if record.gashapon_id and self.data.gashapon_id == record.gashapon_id then
				return record.drawed_num, limit
			end
		end

		return 0, limit
	end
end

local strClassName = "PetPoolProbabilityDlg"
local PetPoolProbabilityDlg = Class(strClassName, UIControls.Window)

function PetPoolProbabilityDlg:ctor()
	self:initUI()
end

function PetPoolProbabilityDlg:initUI()
	self.btnProbability = UIControls.Button(self, "BgPanel/TabPanel/Btn1")

	self.btnProbability:addEventClick(self.onBtnProbabilityClick)

	self.btnMinimum = UIControls.Button(self, "BgPanel/TabPanel/Btn2")

	self.btnMinimum:addEventClick(self.onBtnMinimumClick)

	self.probabilityInfo = UIControls.Panel(self, "BgPanel/ProbabilityInfo")
	self.minimumInfo = UIControls.Panel(self, "BgPanel/MinimumInfo")
	self.minimumTextRule = UIControls.Label(self, "BgPanel/MinimumInfo/TextRuleListPanel/Content/MinimumTextRule")
	self.probabilityScroll = UIControls.ScrollViewLoopV(self, "BgPanel/ProbabilityInfo/ProbabilityList")

	self.probabilityScroll:addEventCellChanged(self.onCellChanged)

	self.cells = {}
end

function PetPoolProbabilityDlg:setData(curActId, actObjs)
	self.actObjs = actObjs

	self.probabilityInfo:setVisible(true)
	self.btnProbability:setEnable(false)
	self.minimumInfo:setVisible(false)
	self.btnMinimum:setEnable(true)
	self.minimumTextRule:setText(ResPetGashaponDrawRuleShow[1].rule)

	self.probabilityList = {}

	local showID = ResPetGashaponDraw[1].show or 1

	if curActId ~= 0 and ResPetGashaponDrawUp[curActId] then
		showID = ResPetGashaponDrawUp[curActId].show
	end

	for i, v in ipairs(ResPetGashaponDrawProbabilityShow[showID] or {}) do
		table.insert(self.probabilityList, v)
	end

	table.sort(self.probabilityList, function(a, b)
		return a.order < b.order
	end)

	self.totalWeight, self.everyWeights = self:getCurTotalAndEveryWeight()

	self.probabilityScroll:setTotalCount(#self.probabilityList)
end

function PetPoolProbabilityDlg:getCurTotalAndEveryWeight()
	local totalWeight = 0
	local everyWeights = {}

	for _, data in pairs(self.actObjs or {}) do
		local actObj = data.actObj

		for _, v in pairs(ResPetGashaponDrawLib[actObj.actData.replaceLibId] or {}) do
			local curWeight = v.weight * v.limit

			for _, record in pairs(actObj.actData.drawData.drawRecord or {}) do
				if record.gashapon_id and v.gashapon_id == record.gashapon_id then
					curWeight = v.weight * (v.limit - record.drawed_num)
				end
			end

			totalWeight = totalWeight + curWeight
			everyWeights[v.gashapon_id] = curWeight
		end
	end

	for i, v in pairs(ResPetGashaponDrawLib[ResPetGashaponDraw[1].limit_lib] or {}) do
		if ResPetGashaponConfig[v.gashapon_id].quality ~= Const.PET_DRAW_QUALITY_NORMAL then
			local curWeight = v.weight * v.limit

			for _, record in pairs(CurAvatar.roleDrawData[Const.DrawTypePet].drawRecord or {}) do
				if record.gashapon_id and v.gashapon_id == record.gashapon_id then
					curWeight = v.weight * (v.limit - record.drawed_num)
				end
			end

			totalWeight = totalWeight + curWeight
			everyWeights[v.gashapon_id] = curWeight
		end
	end

	return totalWeight, everyWeights
end

function PetPoolProbabilityDlg:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or PoolProbabilityCell(sender, "System/PetPool/PetPoolProbabilityCell", newIdx)

	if not self.probabilityList or #self.probabilityList == 0 then
		return
	end

	if self.probabilityList[newIdx] ~= nil then
		targetCell:setData(self.probabilityList[newIdx])
	end

	self.cells[newIdx] = targetCell
end

function PetPoolProbabilityDlg:onBtnProbabilityClick()
	self.probabilityInfo:setVisible(true)
	self.btnProbability:setEnable(false)
	self.minimumInfo:setVisible(false)
	self.btnMinimum:setEnable(true)
end

function PetPoolProbabilityDlg:onBtnMinimumClick()
	self.probabilityInfo:setVisible(false)
	self.btnProbability:setEnable(true)
	self.minimumInfo:setVisible(true)
	self.btnMinimum:setEnable(false)
end

return PetPoolProbabilityDlg

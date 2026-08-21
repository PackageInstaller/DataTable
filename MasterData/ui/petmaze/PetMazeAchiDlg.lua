-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\PetMazeAchiDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResPetMazeBattlePass = require("ClientData/ResPetMazeBattlePass")
local RechargeManager = require("System/Recharge/RechargeManager")
local PetMazeAchieveSeasonCell = Class("PetMazeAchieveSeasonCell", UIControls.Child)

function PetMazeAchieveSeasonCell:ctor()
	self.slider = UIControls.Slider(self, "Slider")
	self.panelTextSlider = UIControls.Panel(self, "Slider/BgText")
	self.textSlider = UIControls.Label(self, "Slider/BgText/TextNum")
	self.grids = {}
	self.effHight = UIControls.Panel(self, "BuffPanel/ImgHigh")
	self.gridBuff = UIControls.BattleBuffGridChild(self, "BuffPanel", "System/Common/Grid/GridBuffSmall", 0, 0, true)
end

function PetMazeAchieveSeasonCell:setData(curData, preData)
	self.preProgress = 0

	if preData then
		self.preProgress = preData.star_need
	end

	self.curData = curData

	self.gridBuff:setObj(self.curData.free_award)
end

function PetMazeAchieveSeasonCell:setProgress(curProgress)
	local needProgress = self.curData.star_need

	if curProgress > self.preProgress then
		self.slider:setValue((curProgress - self.preProgress) / (needProgress - self.preProgress))
	else
		self.slider:setValue(0)
	end

	self.textSlider:setText(needProgress)
	self.effHight:setVisible(needProgress <= curProgress)
	self.panelTextSlider:setVisible(curProgress < needProgress)

	for _, grid in ipairs(self.grids) do
		grid:setGetEffect(needProgress <= curProgress)
	end
end

local PetMazeAchieveSeasonChild = Class("PetMazeAchieveSeasonChild", UIControls.Child)

function PetMazeAchieveSeasonChild:ctor()
	self.textProgress = UIControls.Label(self, "BgStarInfo/TextStar")
	self.imgBg = UIControls.Image(self, "BgNextDiff")
	self.actObj = self.mParent.actObj
	self.showData = self.actObj.actData:getBattlePassData(true)
	self.curProgress = self.actObj.actData:getCurSeasonStar()
	self.panelNextDiff = UIControls.Panel(self, "BgNextDiff/BuffPanel")
	self.cellList = {}

	for index = 1, #self.showData do
		local newCell = PetMazeAchieveSeasonCell(self, "AchiBuffList/Content", "System/MazzPet/MazzPetSeasonAchiCell")

		newCell:setData(self.showData[index], self.showData[index - 1])
		newCell:setVisible(true)
		table.insert(self.cellList, newCell)
	end
end

function PetMazeAchieveSeasonChild:refresh()
	self.curProgress = self.actObj.actData:getCurSeasonStar()

	self.textProgress:setText(self.curProgress)

	for _, cell in pairs(self.cellList) do
		cell:setProgress(self.curProgress)
	end

	if self.actObj.actData:thisTimeOver() then
		self.imgBg:setImage("Atlas/MazzPetAtlas/MazzPetAtlas11", "TxtDefeat2")
		self.panelNextDiff:setVisible(true)
	end
end

local PetMazeAchieveHistoryCell = Class("PetMazeAchieveHistoryCell", UIControls.ScrollViewLoopCell)

function PetMazeAchieveHistoryCell:ctor()
	self.slider = UIControls.Slider(self, "ProgressSlider")
	self.textSlider = UIControls.Label(self, "ProgressSlider/BgText/TextNum")
	self.freeGrids = {}
	self.btnFreeGet = UIControls.Button(self, "BtnGetFree")

	self.btnFreeGet:addEventClick(self.onFreeGetClick)

	self.imgFree = UIControls.Image(self, "FreeItemPanel/Bg")
	self.giftGrids = {}
	self.btnGiftGet = UIControls.Button(self, "BtnGetPay")

	self.btnGiftGet:addEventClick(self.onGiftGetClick)

	self.imgGift = UIControls.Image(self, "PayItemPanel")
	self.panelUnfinish = UIControls.Panel(self, "BgUnfinish")
end

function PetMazeAchieveHistoryCell:onFreeGetClick()
	RPC.petMazeGetStepAward({
		{
			season = self.phase,
			step = self.curData.id
		}
	})
end

function PetMazeAchieveHistoryCell:onGiftGetClick()
	RPC.petMazeGetStepAward({
		{
			is_super = 1,
			season = self.phase,
			step = self.curData.id
		}
	})
end

function PetMazeAchieveHistoryCell:setData(actData, curData, preData)
	self.actData = actData
	self.curData = curData
	self.preProgress = curData.preProgress or 0

	if preData then
		self.preProgress = preData.star_need
	end

	self.phase = self.curData.phase

	ClientUtils.CreateBonusGrid(self, self.freeGrids, "FreeItemPanel", self.curData.free_award, true, nil, true)
	ClientUtils.CreateBonusGrid(self, self.giftGrids, "PayItemPanel", self.curData.pay_award, true, nil, true)
	self:refresh()
end

function PetMazeAchieveHistoryCell:refresh()
	local stateData = self.actData:getHistoryData(self.phase)
	local hasBuy = stateData.hasBuy
	local freeGet = stateData.freeGet or {}
	local giftGet = stateData.giftGet or {}
	local curProgress = self.actData:getCurHistoryStar()
	local needProgress = self.curData.star_need

	if curProgress > self.preProgress then
		self.slider:setValue((curProgress - self.preProgress) / (needProgress - self.preProgress))
	else
		self.slider:setValue(0)
	end

	self.panelUnfinish:setVisible(curProgress < needProgress)
	self.textSlider:setText(needProgress)

	freeGet = freeGet[self.curData.id] and true or false
	giftGet = giftGet[self.curData.id] and true or false

	for _, grid in ipairs(self.freeGrids) do
		grid:setGet(freeGet)
	end

	self.btnFreeGet:setVisible(not freeGet and curProgress >= self.curData.star_need)

	for _, grid in ipairs(self.giftGrids) do
		grid:setState(not hasBuy, giftGet)
	end

	self.btnGiftGet:setVisible(hasBuy and not giftGet and curProgress >= self.curData.star_need)

	if curProgress >= self.curData.star_need then
		self.imgFree:setImage("Atlas/MazzPetAtlas/MazzPetAtlas11", "BgRow2")
	else
		self.imgFree:setImage("Atlas/MazzPetAtlas/MazzPetAtlas11", "BgRow1")
	end
end

local PetMazeAchieveHistoryChild = Class("PetMazeAchieveHistoryChild", UIControls.Child)

function PetMazeAchieveHistoryChild:ctor()
	self.giftBonusGrids = {}
	self.textProgress = UIControls.Label(self, "BgBPDes/BgStarInfo/TextStar")
	self.btnGiftBuy = UIControls.Button(self, "BgBPDes/BtnBPUnlock")

	self.btnGiftBuy:addEventClick(self.onGiftBuyClick)

	self.panelGiftBought = UIControls.Panel(self, "BgBPDes/BgBPPay")
	self.textBuyPrice = UIControls.PriceBuyPanel(self, "BgBPDes/BtnBPUnlock/PricePanel")
	self.btnGetAll = UIControls.Button(self, "BtnReceive")

	self.btnGetAll:addEventClick(self.onGetAll)

	self.btnPre = UIControls.Button(self, "BtnNext")

	self.btnPre:addEventClick(self.onPreClick)

	self.iconPreNew = UIControls.Panel(self, "BtnNext/IconNew")
	self.btnNext = UIControls.Button(self, "BtnPre")

	self.btnNext:addEventClick(self.onNextClick)

	self.iconNextNew = UIControls.Panel(self, "BtnPre/IconNew")
	self.cellList = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "BPList")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.actObj = self.mParent.actObj
	self.showData, self.firstIndex, self.newPhaseDict = self.actObj.actData:getBattlePassData()

	self:onShow(self.firstIndex)
end

function PetMazeAchieveHistoryChild:onGiftBuyClick()
	if self.rechargeId and self.product then
		local rechargeArgs = {
			special = {
				type = Const.RECHARGE_SPECIAL_TYPE.PETMAZEBP,
				phase = self.phase
			}
		}

		RechargeManager.startRecharge(self.rechargeId, rechargeArgs, nil)
	end
end

function PetMazeAchieveHistoryChild:onGetAll()
	local outputData = {}

	for index, info in ipairs(self.pageData) do
		if self.curProgress >= info.star_need then
			if not self.freeGet[info.id] then
				table.insert(outputData, {
					season = self.phase,
					step = info.id
				})
			end

			if self.hasBuy and not self.giftGet[info.id] then
				table.insert(outputData, {
					is_super = 1,
					season = self.phase,
					step = info.id
				})
			end
		end
	end

	if #outputData > 0 then
		RPC.petMazeGetStepAward(outputData)
	end
end

function PetMazeAchieveHistoryChild:onPreClick()
	self:onShow(self.pageIndex - 1)
end

function PetMazeAchieveHistoryChild:onNextClick()
	self:onShow(self.pageIndex + 1)
end

function PetMazeAchieveHistoryChild:onShow(pageIndex)
	self.pageIndex = pageIndex

	self.btnPre:setVisible(self.pageIndex ~= 1)
	self.btnNext:setVisible(self.pageIndex ~= #self.showData)

	self.pageData = self.showData[self.pageIndex]

	self:refresh()

	local firstIndex = 1

	for index, info in ipairs(self.pageData) do
		if info.star_need > self.curProgress then
			break
		elseif not self.freeGet[index] then
			firstIndex = index

			break
		elseif self.hasBuy and not self.giftGet[index] then
			firstIndex = index

			break
		end
	end

	self.scroll:setTotalCount(#self.pageData, firstIndex)
end

function PetMazeAchieveHistoryChild:refresh(refreshData)
	if refreshData then
		local showData, firstIndex, newPhaseDict = self.actObj.actData:getBattlePassData()

		self.newPhaseDict = newPhaseDict
	end

	self.curProgress = self.actObj.actData:getCurHistoryStar()

	self.textProgress:setText(self.curProgress)

	self.phase = self.pageData[1].phase

	local stateData = self.actObj.actData:getHistoryData(self.phase)

	self.hasBuy = stateData.hasBuy
	self.freeGet = stateData.freeGet or {}
	self.giftGet = stateData.giftGet or {}

	if self.hasBuy then
		self.btnGiftBuy:setVisible(false)
		self.panelGiftBought:setVisible(true)
	else
		self.btnGiftBuy:setVisible(true)
		self.panelGiftBought:setVisible(false)

		local bpId = self.pageData[1].bpid
		local bpData = ResPetMazeBattlePass[bpId]

		self.rechargeId = bpData.bp_recharge
		self.product = RechargeManager.getProductByRechargeId(self.rechargeId)

		if self.product then
			self.textBuyPrice:setText(self.product.priceText)
		end
	end

	for newIdx, cell in pairs(self.cellList) do
		cell:setData(self.actObj.actData, self.pageData[newIdx], self.pageData[newIdx - 1])
	end

	self.btnGetAll:setVisible(self.newPhaseDict[self.phase] and true or false)

	local preNew = false
	local nextNew = false

	self.hasNew = false

	for _, pageData in ipairs(self.showData) do
		local phase = pageData[1].phase

		if self.newPhaseDict[phase] then
			self.hasNew = true

			if phase > self.phase then
				nextNew = true
			elseif phase < self.phase then
				preNew = true
			end
		end
	end

	if preNew then
		self.iconPreNew:setVisible(true)
	else
		self.iconPreNew:setVisible(false)
	end

	if nextNew then
		self.iconNextNew:setVisible(true)
	else
		self.iconNextNew:setVisible(false)
	end

	self.mParent.newHistoryAchi:setVisible(self.hasNew)
end

function PetMazeAchieveHistoryChild:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = PetMazeAchieveHistoryCell(sender, "System/MazzPet/MazzPetHistoryAchiCell", newIdx, 0, 0)
	else
		self.cellList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.actObj.actData, self.pageData[newIdx], self.pageData[newIdx - 1])

	self.cellList[newIdx] = targetCell
end

local PetMazeAchiDlg = Class("PetMazeAchiDlg", UIControls.Window)

MixinClass(PetMazeAchiDlg, ActivityPanelMixin)

function PetMazeAchiDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnSeasonAchi = UIControls.Button(self, "BgPanel/TabPanel/BtnSeasonAchi")

	self.btnSeasonAchi:addEventClick(self.onClickBtnSeason)

	self.panelSeason = PetMazeAchieveSeasonChild(self, "BgPanel/BpPanel", "System/MazzPet/MazzPetSeasonAchiPanel")
	self.btnHistoryAchi = UIControls.Button(self, "BgPanel/TabPanel/BtnHistoryAchi")

	self.btnHistoryAchi:addEventClick(self.onClickBtnHistory)

	self.newHistoryAchi = UIControls.Panel(self, "BgPanel/TabPanel/BtnHistoryAchi/Content/IconNew")
	self.panelHistory = PetMazeAchieveHistoryChild(self, "BgPanel/BpPanel", "System/MazzPet/MazzPetHistoryAchiPanel")
end

function PetMazeAchiDlg:_setData()
	self:onClickBtnSeason()
end

function PetMazeAchiDlg:refreshSeason()
	self.panelSeason:setVisible(true)
	self.panelHistory:setVisible(false)
	self.panelSeason:refresh()
end

function PetMazeAchiDlg:refreshHistory()
	self.panelSeason:setVisible(false)
	self.panelHistory:setVisible(true)
	self.panelHistory:refresh()
end

function PetMazeAchiDlg:onClickBtnSeason()
	self.btnSeasonAchi:setEnable(false)
	self.btnHistoryAchi:setEnable(true)
	self:refreshSeason()
end

function PetMazeAchiDlg:onClickBtnHistory()
	self.btnSeasonAchi:setEnable(true)
	self.btnHistoryAchi:setEnable(false)
	self:refreshHistory()
end

function PetMazeAchiDlg:onClickBtnClose()
	self:setVisible(false)
end

function PetMazeAchiDlg:updateActivityData()
	if self.panelSeason:getVisible() then
		self.panelSeason:refresh()
	else
		self.panelHistory:refresh(true)
	end
end

return PetMazeAchiDlg

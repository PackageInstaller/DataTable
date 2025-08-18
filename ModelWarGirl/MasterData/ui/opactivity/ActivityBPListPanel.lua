-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBPListPanel.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResRandClient = require("ClientData/ResRandClient")
local ActivityBPCell = Class("ActivityBPCell", UIControls.ScrollViewLoopCell)

function ActivityBPCell:ctor()
	self:initUI()
end

function ActivityBPCell:initUI()
	self.freeGrids = {}
	self.rechargeGrids = {}
	self.bgFreeNothing = UIControls.Panel(self, "FreeItemPanel/BgNothing")
	self.bgPayNothing = UIControls.Panel(self, "PayItemPanel/BgNothing")
	self.progressSlider = UIControls.Slider(self, "ProgressSlider")
	self.btnGetFree = UIControls.Button(self, "BtnGetFree")

	self.btnGetFree:addEventClick(self.onBtnGetFreeClick)

	self.btnGetPay = UIControls.Button(self, "BtnGetPay")

	self.btnGetPay:addEventClick(self.onBtnGetPayClick)

	self.textNum = UIControls.Label(self, "ProgressSlider/BgText/TextNum")
	self.imgFree = UIControls.Image(self, "FreeItemPanel")
	self.imgPay = UIControls.Image(self, "PayItemPanel")
	self.altasPath = "Atlas/ActivityAtlas/ActivityBPAtlas"
end

function ActivityBPCell:init(atlasPath)
	if atlasPath then
		self.altasPath = atlasPath
	end
end

function ActivityBPCell:setData(data, lastParam, nmlState, rechargeState)
	self.data = data
	self.lastParam = lastParam
	self.state = nmlState
	self.rechargeState = rechargeState

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[2] then
		self.gridPrefabPath = self.mParent.replaceableCellPath[2]
	end

	self.textNum:setText(data.desc_name)

	if data.award then
		ClientUtils.CreateActivityBonusGrid(self, self.freeGrids, "FreeItemPanel", data.award, self.gridPrefabPath)

		for _, grid in ipairs(self.freeGrids) do
			grid:setState(nmlState)
		end

		self.bgFreeNothing:setVisible(false)
	else
		self.bgFreeNothing:setVisible(true)
	end

	self.btnGetFree:setVisible(nmlState == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.btnGetPay:setVisible(rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH)

	if data.recharge_award then
		ClientUtils.CreateActivityBonusGrid(self, self.rechargeGrids, "PayItemPanel", data.recharge_award, self.gridPrefabPath)

		for _, grid in ipairs(self.rechargeGrids) do
			grid:setState(rechargeState)
		end

		self.bgPayNothing:setVisible(false)
	else
		self.bgPayNothing:setVisible(true)

		for _, grid in ipairs(self.rechargeGrids) do
			grid:setVisible(false)
		end
	end

	if nmlState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.imgFree:setImage(self.altasPath, "BgActivityFrogGiftSel01")
	else
		self.imgFree:setImage(self.altasPath, "BgActivityFrogGiftNml01")
	end

	if rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.imgPay:setImage(self.altasPath, "BgActivityFrogGiftSel02")
	else
		self.imgPay:setImage(self.altasPath, "BgActivityFrogGiftNml02")
	end

	if self.mParent.nowProcess >= data.param then
		self.progressSlider:setValue(1)
	elseif self.mParent.currFoucsData == data then
		self.progressSlider:setValue((self.mParent.nowProcess - lastParam) / (data.param - lastParam))
	else
		self.progressSlider:setValue(0)
	end
end

function ActivityBPCell:onBtnGetFreeClick()
	if self.mParent.onlyFastReceive then
		self.mParent:onBtnReceiveClick()

		return
	end

	if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.opId, self.data.index, self.data.type), self.mParent.opId)
	end
end

function ActivityBPCell:onBtnGetPayClick()
	if self.mParent.onlyFastReceive then
		self.mParent:onBtnReceiveClick()

		return
	end

	if self.rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.opId, self.data.index, self.data.type), self.mParent.opId)
	end
end

local classNameStr = "ActivityBPListPanel"
local ActivityBPListPanel = Class(classNameStr, UIControls.Child)

MixinClass(ActivityBPListPanel, ActivityPanelMixin)

function ActivityBPListPanel:ctor()
	return
end

function ActivityBPListPanel:initUI()
	self.btnBuyFast = UIControls.Button(self, "BtnBuyFast")

	self.btnBuyFast:addEventClick(self.onBtnBuyFastClick)

	self.bgBPPay = UIControls.Panel(self, "BgBPDes/BgBPPay")
	self.btnBPUnlock = UIControls.Panel(self, "BgBPDes/BtnBPUnlock")
	self.textCurrency = UIControls.Label(self, "BgBPDes/BgCurrency/TextCurrency")
	self.textDes = UIControls.Label(self, "BgBPDes/BtnBPUnlock/TextDes")
	self.bgAwardPreview = UIControls.Panel(self, "BgAwardPreview")
	self.scrollItems = UIControls.ScrollViewLoopV(self, "BPList", 0, self._onCellChanged)
	self.cells = {}
	self.btnReceive = UIControls.Button(self, "BtnReceive")

	self.btnReceive:addEventClick(self.onBtnReceiveClick)

	self.btnBPUnlock = UIControls.Button(self, "BgBPDes/BtnBPUnlock")

	self.btnBPUnlock:addEventClick(self.onBtnBPUnlockClick)

	self.bgAwardPreview = UIControls.Image(self, "BgAwardPreview")
	self.previewGrids = {}

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "BgBPDes/BtnBPUnlock/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "BgBPDes/BtnBPUnlock/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function ActivityBPListPanel:_setData()
	self.opId = self.actObj.opId
	self.achieveData = {}

	local svrData

	for _, sData in pairs(self.actObj.actData.serverData) do
		svrData = sData
	end

	self.checkHidePreviewPanel = false
	self.clientTemplateData = self.actObj.clientTemplateData

	if self.clientTemplateData and self.clientTemplateData.template_args and #self.clientTemplateData.template_args > 0 then
		local num = tonumber(self.clientTemplateData.template_args[1])

		if num and num > 0 then
			self.checkHidePreviewPanel = true
		end
	end

	self.nowProcess = svrData and svrData.progress or 0

	local nowGot = svrData and svrData.got or {}

	for actType, cData in pairs(self.actObj.actData.clientData) do
		self.activityType = actType

		for _, data in ipairs(cData) do
			table.insert(self.achieveData, data)
		end
	end

	local rechargeAwards = {}

	self.currFoucsData = nil

	for i, data in ipairs(self.achieveData) do
		if self.nowProcess < data.param then
			self.currFoucsData = data

			break
		else
			table.insert(rechargeAwards, data.recharge_award)
		end
	end

	if self.currFoucsData == nil then
		self.currFoucsData = self.achieveData[#self.achieveData]
	end

	self.textCurrency:setText(self.nowProcess .. "/" .. self.currFoucsData.param)

	self.recharged = self.actObj.actData.hasRecharged == 1

	if self.recharged then
		self.bgBPPay:setVisible(true)
		self.btnBPUnlock:setVisible(false)
		self.bgAwardPreview:setVisible(false)
	else
		self.bgBPPay:setVisible(false)
		self.btnBPUnlock:setVisible(true)

		local product = RechargeManager.getProductByRechargeId(self.actObj.actData.connectRechargeId)

		if product then
			self.textDes:setText(product.priceText .. Lang.get(483))
		else
			self.textDes:setText(Lang.get(483))
		end

		if #rechargeAwards < 1 then
			self.bgAwardPreview:setVisible(false)
		else
			if not self.checkHidePreviewPanel then
				self.bgAwardPreview:setVisible(true)
			end

			if self.replaceableCellPath and self.replaceableCellPath[2] then
				self.gridPrefabPath = self.replaceableCellPath[2]
			end

			ClientUtils.CreatePreviewBonusSumGrid(self, self.previewGrids, "BgAwardPreview/ItemPreviewList", rechargeAwards, self.gridPrefabPath)
		end
	end

	self.btnReceive:setVisible(self:checkBtnReceiveShow())

	for idx, data in ipairs(self.achieveData) do
		local state = self.actObj.actData:getAchieveState(self.activityType, idx)

		if state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH or state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			self.toGetCellIdx = idx

			break
		end

		if data.recharge_award and data.recharge_award > 0 then
			state = self.actObj.actData:getAchieveState(self.activityType, idx, true)

			if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
				self.toGetCellIdx = idx

				break
			end
		end
	end

	local idx

	if self.toGetCellIdx then
		idx = self.toGetCellIdx - 1
		idx = idx <= 0 and 1 or idx
	end

	self.maxTargetCellIdx = #self.achieveData - 3

	if idx and idx > self.maxTargetCellIdx then
		idx = self.maxTargetCellIdx
	end

	idx = idx and idx or self.maxTargetCellIdx
	self.targetCellIdx = idx

	self.scrollItems:setTotalCount(#self.achieveData, self.targetCellIdx)
end

function ActivityBPListPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		if self.replaceableCellPath and self.replaceableCellPath[1] then
			targetCell = ActivityBPCell(sender, "System/Activity/" .. self.replaceableCellPath[1], newIdx, 0, 0)
		else
			targetCell = ActivityBPCell(sender, "System/Activity/ActivityBP/ActivityBPCell", newIdx, 0, 0)
		end

		if self.replaceableCellPath and self.replaceableCellPath[3] then
			targetCell:init("Atlas/" .. self.replaceableCellPath[3])
		end
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	if self.toGetCellIdx and newIdx == self.toGetCellIdx then
		targetCell.isNextToGet = true
	else
		targetCell.isNextToGet = false
	end

	self.cells[newIdx] = targetCell

	local lastDataParam = self.achieveData[newIdx - 1] and self.achieveData[newIdx - 1].param or 0

	self.cells[newIdx]:setData(self.achieveData[newIdx], lastDataParam, self.actObj.actData:getAchieveState(self.activityType, newIdx), self.actObj.actData:getAchieveState(self.activityType, newIdx, true))
end

function ActivityBPListPanel:onBtnBPUnlockClick()
	RechargeManager.startRecharge(self.actObj.actData.connectRechargeId, nil, nil)
end

function ActivityBPListPanel:onBtnReceiveClick()
	for idx, data in ipairs(self.achieveData) do
		local state = self.actObj.actData:getAchieveState(self.activityType, idx)

		if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, -1, data.type), self.opId)

			break
		end

		local rechargeState = self.actObj.actData:getAchieveState(self.activityType, idx, true)

		if rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
			CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, -1, data.type), self.opId)

			break
		end
	end
end

function ActivityBPListPanel:checkBtnReceiveShow()
	local canGetCount = 0

	for idx, data in ipairs(self.achieveData) do
		local state = self.actObj.actData:getAchieveState(self.activityType, idx)

		if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			canGetCount = canGetCount + 1
		end

		local rechargeState = self.actObj.actData:getAchieveState(self.activityType, idx, true)

		if rechargeState == Const.ACT_ACHIEVE_STATE_ENOUGH then
			canGetCount = canGetCount + 1
		end
	end

	return canGetCount >= 2
end

function ActivityBPListPanel:onBtnBuyFastClick()
	local ui = UIManager.getUI("achiBuyBox", true)
	local exchgID = self.actObj.actData.miscData.achi_exchg_id
	local maxExchgValue = self.achieveData[#self.achieveData].param - self.nowProcess

	ui:showItem(self.actObj.opId, exchgID, maxExchgValue)
	ui:bindWindow(self)
end

function ActivityBPListPanel:onActivityDataRefresh(actObj)
	self:_setData()
end

function ActivityBPListPanel:setOnlyFastReceive(value)
	self.onlyFastReceive = value
end

return ActivityBPListPanel

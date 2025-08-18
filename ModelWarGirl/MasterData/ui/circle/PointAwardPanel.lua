-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\PointAwardPanel.lua

local AWARD_DIAMOND = 1
local AWARD_ADV_CIRCLE_COIN = 2
local PointAwardCell = require("UI/Circle/PointAwardCell")
local strClassName = "PointAwardPanel"
local PointAwardPanel = Class(strClassName, UIControls.Panel)

function PointAwardPanel:ctor()
	self:initUI()
end

function PointAwardPanel:initUI()
	self.imgIconPoint = UIControls.Image(self, self.mPath .. "/PointInfoPanel/TotalPointPanel/BtnPoint/Icon")
	self.btnPoint = UIControls.Button(self, self.mPath .. "/PointInfoPanel/TotalPointPanel/BtnPoint", "TextPoint")

	self.btnPoint:addEventClick(self.onBtnPointClick)

	self.btnRecord = UIControls.Button(self, self.mPath .. "/PointInfoPanel/TotalPointPanel/BtnRecord")

	self.btnRecord:addEventClick(self.onBtnRecordClick)

	self.awardCellList = {}

	for i = 1, 2 do
		local imgAwardIcon = UIControls.Image(self, self.mPath .. "/PointInfoPanel/AwardPanel/Award" .. i .. "/Icon")
		local txtAwardValue = UIControls.Label(self, self.mPath .. "/PointInfoPanel/AwardPanel/Award" .. i .. "/TextNum")
		local aniAward = UIControls.UIAni(self, self.mPath .. "/PointInfoPanel/AwardPanel/Award" .. i)

		aniAward:addEventAnimateCue(self.refreshAwardTxtValue)

		local _btnAward = UIControls.Button(self, self.mPath .. "/PointInfoPanel/AwardPanel/Award" .. i)

		_btnAward:addEventClick(self.onBtnAwardClick)

		self.awardCellList[i] = {
			imgIcon = imgAwardIcon,
			txtValue = txtAwardValue,
			ani = aniAward,
			btnAward = _btnAward
		}
	end

	self.panelFrame = UIControls.Panel(self, self.mPath .. "/PointInfoPanel/FramePanel")

	self.panelFrame:playAnimator("FramePointAwardRabbitReset")

	self.pointEfx = UIControls.Panel(self, self.mPath .. "/PointInfoPanel/FramePanel/EfxPoint")
	self.cells = {}
	self.scrollPointAward = UIControls.ScrollViewLoopV(self, self.mPath .. "/AwardList")

	self.scrollPointAward:addEventCellChanged(self.onPointAwardChanged)
	self:_initShowInfo()
end

function PointAwardPanel:onBtnAwardClick(sender)
	for idx, awardCellInfo in ipairs(self.awardCellList) do
		if sender == awardCellInfo.btnAward then
			local showItem

			if idx == AWARD_DIAMOND then
				showItem = BaseObject.GetObject(Const.MONEY_ID_DIAMOND)
			else
				showItem = BaseObject.GetObject(Const.MONEY_ID_ADV_CIRCLE_COIN)
			end

			self.mDisableWays = true

			UIManager.getUI("itemTips"):showObj(self, showItem)

			break
		end
	end
end

function PointAwardPanel:onBtnPointClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_CIRCLE_BATTLE_SCORE)
end

function PointAwardPanel:_initShowInfo()
	if CurAvatar.myCircle then
		local pointIconPath = UIConst.CIRCLE_BATTLE_SCORE_PATH

		if pointIconPath then
			self.imgIconPoint:setImage(pointIconPath[1], pointIconPath[2])
		end

		local iconInfo = ClientUtils.getMoneyIcon(Const.MONEY_ID_DIAMOND)

		if iconInfo then
			self.awardCellList[AWARD_DIAMOND].imgIcon:setImage(iconInfo[1], iconInfo[2])
		end

		local iconInfo = ClientUtils.getMoneyIcon(Const.MONEY_ID_ADV_CIRCLE_COIN)

		if iconInfo then
			self.awardCellList[AWARD_ADV_CIRCLE_COIN].imgIcon:setImage(iconInfo[1], iconInfo[2])
		end
	end
end

function PointAwardPanel:refreshPanelData(isRefreshForInfuse)
	self.pointAwardData = CurAvatar.myCircle:getPointAwardDataList()

	self.btnPoint:setText(CurAvatar.myCircle:getCurScore())

	if isRefreshForInfuse then
		self.scrollPointAward:setTotalCount(#self.pointAwardData)
	else
		local startIdx

		for idx, pointAward in ipairs(self.pointAwardData) do
			if pointAward.status == Const.CIRCLE_POINT_STATUS.NEXT or pointAward.status == Const.CIRCLE_POINT_STATUS.GET then
				startIdx = idx

				break
			end
		end

		self:refreshAwardTxtValue()
		self.scrollPointAward:setTotalCount(#self.pointAwardData, startIdx)
	end
end

function PointAwardPanel:playInfuseAniShow(infuseId)
	for idx, cell in pairs(self.cells) do
		if cell.infuseId == infuseId then
			cell:playGetAward()
			self.panelFrame:playAnimator("FramePointAwardRabbitReset")
			self.panelFrame:playAnimator("FramePointAwardRabbitGet")

			break
		end
	end

	self.awardCellList[AWARD_DIAMOND].ani:startAni("GetPointAward", true)
	self.awardCellList[AWARD_ADV_CIRCLE_COIN].ani:startAni("GetPointAward", true)
end

function PointAwardPanel:refreshAwardTxtValue()
	local pileAwardDiamond, pileAwardAdvCircleCoin = CurAvatar.myCircle:getPileAwardValue()

	self.awardCellList[AWARD_DIAMOND].txtValue:setText(pileAwardDiamond)
	self.awardCellList[AWARD_ADV_CIRCLE_COIN].txtValue:setText(pileAwardAdvCircleCoin)
end

function PointAwardPanel:onPointAwardChanged(sender, targetCell, newIdx)
	targetCell = targetCell or PointAwardCell(sender, "System/CircleBattle/PointAwardCell", newIdx)

	if not self.pointAwardData or #self.pointAwardData == 0 then
		return
	end

	if self.pointAwardData[newIdx] ~= nil then
		targetCell:setAwardData(self.pointAwardData[newIdx])
	end

	self.cells[newIdx] = targetCell
end

function PointAwardPanel:onBtnRecordClick()
	local circleBattlePointRecordDlg = UIManager.getUI("circleBattlePointRecordDlg", true)
end

return PointAwardPanel

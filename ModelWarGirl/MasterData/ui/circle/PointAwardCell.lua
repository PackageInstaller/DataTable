-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\PointAwardCell.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResClanBattleScore = require("ClientData/ResClanBattleScore")
local strClassName = "PointAwardCell"
local PointAwardCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PointAwardCell:ctor()
	self:initUI()
end

function PointAwardCell:initUI()
	self.sliderProgress = UIControls.Slider(self, "Bg/Slider")
	self.txtPoint = UIControls.Label(self, "Bg/TextPoint")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick, 2)

	self.panelBg = UIControls.Panel(self, "Bg")
	self.txtStatus = UIControls.Label(self, "Bg/Text")
	self.imgBgAwardSpe = UIControls.Image(self, "BgAwardSpe")
	self.awardGridList = {}
end

function PointAwardCell:onBtnConfirmClick()
	CurAvatar:tryCallCircleBattleRpc("clanBattleScoreInfuse", self.awardData.resData.id)
end

function PointAwardCell:setAwardData(awardData, idx)
	self.awardData = awardData
	self.infuseId = self.awardData.resData.id
	self.idx = idx

	if CurAvatar.myCircle then
		local awardIdList = {}
		local awardNum = {}

		for i = 1, 2 do
			if self.awardData.resData.award[i] then
				table.insert(awardIdList, self.awardData.resData.award[i].id)
				table.insert(awardNum, self.awardData.resData.award[i].num)
			end
		end

		for i, _ in ipairs(awardIdList) do
			local awardObjectNum = awardNum[i] or 1

			if not self.awardGridList[i] then
				self.awardGridList[i] = UIControls.getGridAwardContainer(self, "Bg/AwardPanel")
			end

			self.awardGridList[i].mDisableWays = true

			local item = BaseObject.GetObject(awardIdList[i], awardObjectNum)

			self.awardGridList[i]:setObj(item)

			if self.awardData.status == Const.CIRCLE_POINT_STATUS.GOT then
				self.awardGridList[i]:setState(false, true)
			else
				self.awardGridList[i]:setState(false, false)
			end

			self.awardGridList[i]:setVisible(true)
		end

		self.txtPoint:setText(self.awardData.resData.score)
		self.txtStatus:setText(CurAvatar:getPointStatusDesc(self.awardData.status))

		if self.awardData.status == Const.CIRCLE_POINT_STATUS.DIS then
			self.panelBg:playStateAnimator("PointAwardCellDis")
		elseif self.awardData.status == Const.CIRCLE_POINT_STATUS.NEXT then
			self.panelBg:playStateAnimator("PointAwardCellDis")
		elseif self.awardData.status == Const.CIRCLE_POINT_STATUS.GET then
			self.panelBg:playStateAnimator("PointAwardCellGet")
		elseif self.awardData.status == Const.CIRCLE_POINT_STATUS.GOT then
			self.panelBg:playStateAnimator("PointAwardCellGot")
		end

		self.btnConfirm:setVisible(self.awardData.status == Const.CIRCLE_POINT_STATUS.GET)
		self.imgBgAwardSpe:setVisible(self.awardData.resData.flag and self.awardData.resData.flag == 1)

		if self.infuseId ~= 1 then
			self.sliderProgress:setVisible(true)

			local gearData = CurAvatar.myCircle:getCurScoreGearData()

			if self.infuseId == gearData.resData.id then
				local curScore = CurAvatar.myCircle:getCurScore()
				local lastScore = ResClanBattleScore[gearData.resData.id - 1].score
				local progress = (curScore - lastScore) / (gearData.resData.score - lastScore)

				self.sliderProgress:setValue(progress)
			else
				local progress = self.infuseId < gearData.resData.id and 1 or 0

				self.sliderProgress:setValue(progress)
			end
		else
			self.sliderProgress:setVisible(false)
		end
	end
end

function PointAwardCell:playGetAward()
	for _, awardGrid in ipairs(self.awardGridList) do
		FlyIconUtils.setFlyUItoUI(awardGrid, self.mParent.pointEfx, awardGrid.object.id, awardGrid.object.num)
	end
end

return PointAwardCell

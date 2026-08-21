-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayMainPanel.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivitySeasonBPMisc = require("ClientData/ResOpActivitySeasonBPMisc")
local ResOpActivitySeasonBPPreviewShow = require("ClientData/ResOpActivitySeasonBPPreviewShow")
local ResOpActivityeAutoOpen = require("ClientData/ResOpActivityeAutoOpen")
local ResOpActivitySeasonBPShow = require("ClientData/ResOpActivitySeasonBPShow")
local SeaSonPlayMainAwardCell = Class("SeaSonPlayMainAwardCell", UIControls.ScrollViewLoopCell)

function SeaSonPlayMainAwardCell:ctor()
	self:initUI()
end

function SeaSonPlayMainAwardCell:initUI(...)
	self.iconNew = UIControls.Image(self, "IconNew")
	self.sliderNum = UIControls.Label(self, "SliderNum")
	self.panelAwardBack = UIControls.Panel(self, "AwardBack")
	self.panelBigAwardBack = UIControls.Panel(self, "BigAwardBack")
	self.btnAwardBackUIClickThrough = UIControls.Button(self, "AwardBack/UIClickThrough")

	self.btnAwardBackUIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.btnBigAwardBackUIClickThrough = UIControls.Button(self, "BigAwardBack/UIClickThrough")

	self.btnBigAwardBackUIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.effectNode = UIControls.LazyEffectPlayer(self, "BigAwardBack/EffectNode")
	self.imgBigAward = UIControls.Image(self, "BigAwardBack/AwardNode/AwardImage")
	self.awardBagImage = UIControls.Image(self, "AwardBack/AwardNode/AwardImage")
	self.btnOpenChooseAward = UIControls.Button(self, "AwardBack")
	self.btnOpenChooseBigAward = UIControls.Button(self, "BigAwardBack")

	self.btnOpenChooseAward:addEventClick(self.onOpenChooseAward)
	self.btnOpenChooseBigAward:addEventClick(self.onOpenChooseAward)

	self.choiceImg = UIControls.Image(self, "ChoiceImg")
	self.imgStateLock = UIControls.Panel(self, "StatePanel/ImgStateLock")
	self.imgStateGet = UIControls.Panel(self, "StatePanel/ImgStateGet")
	self.statePanel = UIControls.Panel(self, "StatePanel")
end

function SeaSonPlayMainAwardCell:setData(data)
	self.data = data

	self.sliderNum:setText(self.data.index)

	self.isBig = self.data.high_award == 1

	if self.isBig then
		if self.awardCell then
			self.awardCell:setVisible(false)
		end
	elseif self.bigAwardCell then
		self.bigAwardCell:setVisible(false)
	end

	self.choiceImg:setVisible(false)
	self.panelAwardBack:setVisible(not self.isBig)
	self.panelBigAwardBack:setVisible(self.isBig)
	self.effectNode:setVisible(self.data.state == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.iconNew:setVisible(self.data.state == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.btnAwardBackUIClickThrough:setVisible(self.data.state == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.btnBigAwardBackUIClickThrough:setVisible(self.data.state == Const.ACT_ACHIEVE_STATE_ENOUGH)

	local award = self.data.award

	if ResRandClient[award] then
		local num = #ResRandClient[award].show_ids

		if self.data.achieve_bonus then
			self.awardBagImage:setVisible(true)
			self.awardBagImage:setImage(self.data.achieve_bonus[1].icon_path, self.data.achieve_bonus[1].icon)
			self.imgBigAward:setVisible(true)
			self.choiceImg:setVisible(self.data.state == Const.ACT_ACHIEVE_STATE_GOT)
			self.imgBigAward:setImage(self.data.achieve_bonus[1].icon_path, self.data.achieve_bonus[1].icon)

			if self.awardCell then
				self.awardCell:setVisible(false)
			end

			if self.bigAwardCell then
				self.bigAwardCell:setVisible(false)
			end
		else
			self.awardBagImage:setVisible(false)
			self.imgBigAward:setVisible(false)

			local fakeItem = BaseObject.GetObject(ResRandClient[award].show_ids[1], ResRandClient[award].show_nums[1])

			if self.isBig then
				if not self.bigAwardCell then
					self.bigAwardCell = UIControls.getGridAwardContainer(self, "BigAwardBack/AwardNode")
				end

				self.bigAwardCell:setVisible(true)
				self.bigAwardCell:setObj(fakeItem)
			else
				if not self.awardCell then
					self.awardCell = UIControls.getGridAwardContainer(self, "AwardBack/AwardNode")
				end

				self.awardCell:setVisible(true)
				self.awardCell:setObj(fakeItem)
			end
		end

		self.imgStateGet:setVisible(self.data.state == Const.ACT_ACHIEVE_STATE_GOT)
		self.statePanel:setVisible(self.data.state ~= Const.ACT_ACHIEVE_STATE_ENOUGH)
		self.imgStateLock:setVisible(self.data.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH)
	end
end

function SeaSonPlayMainAwardCell:onUIClickThroughClick()
	if self.data.state == Const.ACT_ACHIEVE_STATE_ENOUGH and CurAvatar.activityObjs[self.data.detail_id] then
		local actId = CurAvatar.activityObjs[self.data.detail_id].opId

		RPC.opActGetAward(actId, self.data.index, self.data.type)
	end
end

function SeaSonPlayMainAwardCell:onOpenChooseAward(...)
	if self.data and self.data.state ~= Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.mParent:openShowChoose(self.data, self:getPosition())
	end
end

local SeasonPlayMainPanel = Class("SeasonPlayMainPanel", UIControls.Child)

function SeasonPlayMainPanel:ctor()
	self:initUI()
end

function SeasonPlayMainPanel:initUI()
	self.scrollAwardList = UIControls.ScrollViewLoopH(self, "AwardList")

	self.scrollAwardList:addEventCellChanged(self.onAwardListChanged)

	self.txtNum = UIControls.Label(self, "FireNum/TxtNum")
	self.slider = UIControls.Slider(self, "FireNum/Slider")
	self.txtNub = UIControls.Label(self, "FireNum/Slider/TxtNub")
	self.lvUpAni = UIControls.UIAni(self, "FireNum")

	self.lvUpAni:addEventFinish(self.onAniFinish)

	self.awardCells = {}
	self.bigAwardPanel = UIControls.Panel(self, "BigAwardPanel")
	self.imgBigAward = UIControls.Image(self, "BigAwardPanel/AwardPanel/AwardImage")
	self.btnOpenBigAwardShow = UIControls.Button(self, "BigAwardPanel/AwardPanel/AwardImage")

	self.btnOpenBigAwardShow:addEventClick(self.onBtnBigAwardClick)

	self.txtBigAwardDesc = UIControls.Label(self, "BigAwardPanel/TextNum")
	self.showChooseBigAward = UIControls.Panel(self, "BigAwardPanel/ShowChooseAward")
	self.btnCloseShowChooseBigAward = UIControls.Button(self, "BigAwardPanel/ShowChooseAward/UIClickThrough")

	self.btnCloseShowChooseBigAward:addEventClick(self.onbtnCloseShowChooseBigAwardClick)

	self.awardCells = {}
	self.showChooseAward = UIControls.Panel(self, "ShowChooseAward")
	self.chooseAwardNode = UIControls.Image(self, "ShowChooseAward/ChooseAwardNode")
	self.btnCloseShowChooseAward = UIControls.Button(self, "ShowChooseAward/UIClickThrough")

	self.btnCloseShowChooseAward:addEventClick(self.onbtnCloseShowChooseAwardClick)

	self.chooseAward = UIControls.Panel(self, "ShowChooseAward/ChooseAwardNode")
	self.chooseAwardPosY = self.chooseAward:getPosition().y
end

function SeasonPlayMainPanel:setActObj(actObj)
	self.actObj = actObj
end

function SeasonPlayMainPanel:setMainShow(...)
	if not self.actObj then
		self.actObj = self.mParent.actObj
	end

	if self.actObj then
		self.actData = self.actObj.actData
		self.cellAwardPath = "System/SeasonPlay/SeasonPlayMainAwardCell"

		if self.actObj.clientTemplateData and self.actObj.clientTemplateData.src_replace and self.actObj.clientTemplateData.src_replace[1] then
			self.cellAwardPath = self.actObj.clientTemplateData.src_replace[1]
		end

		local maxIndex = 120

		self.nowProgress = self.actData:getAchieveProgress(Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT)

		if self.actData.clientData and self.actData.clientData[Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT] then
			maxIndex = #self.actData.clientData[Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT]
		end

		local lastData, nowHaveProgress, rate, preRoundProgress, preProgress = self.actData:getNextAchieveInfo(true)
		local needProgress = lastData.param - preProgress
		local havePregress = nowHaveProgress - preProgress

		self.showNowProgress = math.min(havePregress, needProgress)

		self.slider:setValue(rate)

		if lastData then
			if maxIndex == lastData.index and needProgress == 0 then
				self.nowIndex = lastData.index
			else
				self.nowIndex = lastData.index - 1
			end
		end

		if self.nowIndex == maxIndex then
			self.txtNub:setText(Lang.get(1699))
			self.slider:setValue(1)
		else
			self.txtNub:setText(utils.format("%1s/%2s", self.showNowProgress, needProgress))
			self.slider:setValue(rate)
		end

		self.txtNum:setText(self.nowIndex or 0)

		self.awardDatas = self.actData.clientData[Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT]

		local focusIndex = 0

		for index, oneData in ipairs(self.awardDatas or {}) do
			oneData.state = self.actData:getAchieveState(oneData.type, oneData.index)

			if oneData.state == Const.ACT_ACHIEVE_STATE_ENOUGH and focusIndex == 0 then
				focusIndex = index
			end
		end

		self.maxCellNum = #self.awardDatas

		if ResOpActivitySeasonBPMisc[self.actData.actId] then
			local resData = ResOpActivitySeasonBPMisc[self.actData.actId]

			self.miscData = resData

			local limit = resData.show_level or 0

			if limit > self.nowIndex and resData.hide_level and resData.hide_level ~= 0 then
				self.maxCellNum = math.min(self.maxCellNum, resData.hide_level)
			end
		end

		if focusIndex == 0 then
			focusIndex = self.nowIndex
		end

		focusIndex = math.min(self.maxCellNum, focusIndex)

		if self.focusIndex == nil then
			self.focusIndex = focusIndex

			self.scrollAwardList:setTotalCount(self.maxCellNum, self.focusIndex)
		end

		self.scrollAwardList:setTotalCount(self.maxCellNum)
	end
end

function SeasonPlayMainPanel:onAwardListChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = SeaSonPlayMainAwardCell(sender, self.cellAwardPath, newIdx)
	else
		self.awardCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.awardCells[newIdx] = targetCell

	if self.awardDatas and self.awardDatas[newIdx] then
		targetCell:setData(self.awardDatas[newIdx])
	end

	self.viewLastIdx = 1

	local totalNum = 5

	for i = newIdx, newIdx + totalNum do
		if self.awardCells[i] and self.awardCells[i].mIndex > self.viewLastIdx then
			self.viewLastIdx = self.awardCells[i].mIndex
		end
	end

	self:refreshBigAwardPanel()
end

function SeasonPlayMainPanel:refreshBigAwardPanel(...)
	local isGet = false

	for i = self.viewLastIdx, self.maxCellNum do
		if self.awardDatas[i] and self.awardDatas[i].high_award and self.awardDatas[i].high_award == 1 and self.awardDatas[i].state and self.awardDatas[i].state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			self:showBigAward(self.awardDatas[i])

			isGet = true

			break
		end
	end

	if not isGet then
		for i = self.maxCellNum, 1, -1 do
			if self.awardDatas[i] and self.awardDatas[i].high_award and self.awardDatas[i].high_award == 1 and self.awardDatas[i].state then
				self:showBigAward(self.awardDatas[i])

				break
			end
		end
	end
end

function SeasonPlayMainPanel:showBigAward(nodeData)
	if nodeData and nodeData.desc_name then
		self.txtBigAwardDesc:setText(nodeData.desc_name)

		local award = nodeData.award

		if ResRandClient[award] then
			if nodeData.achieve_bonus then
				if self.awardItemCell then
					self.awardItemCell:setVisible(false)
				end

				self.imgBigAward:setVisible(true)
				self.imgBigAward:setImage(nodeData.achieve_bonus[1].icon_path, nodeData.achieve_bonus[1].icon)
			else
				self.imgBigAward:setVisible(false)

				if not self.awardItemCell then
					self.awardItemCell = UIControls.getGridAwardContainer(self, "BigAwardPanel/AwardPanel")
				end

				local fakeItem = BaseObject.GetObject(ResRandClient[award].show_ids[1], ResRandClient[award].show_nums[1])

				self.awardItemCell:setVisible(true)
				self.awardItemCell:setObj(fakeItem)
			end

			if not self.showBigAwardChooseCells then
				self.showBigAwardChooseCells = {}
			end

			for i, id in ipairs(ResRandClient[award].show_ids) do
				if not self.showBigAwardChooseCells[i] then
					self.showBigAwardChooseCells[i] = UIControls.getGridAwardContainer(self, "BigAwardPanel/ShowChooseAward/AwardNode")
				end

				self.showBigAwardChooseCells[i]:setVisible(true)

				local fakeItem = BaseObject.GetObject(id, ResRandClient[award].show_nums[i])

				self.showBigAwardChooseCells[i]:setObj(fakeItem)
			end

			local num = #ResRandClient[award].show_ids

			for i = num + 1, #self.showBigAwardChooseCells do
				self.showBigAwardChooseCells[i]:setVisible(false)
			end
		end
	end
end

function SeasonPlayMainPanel:onAniFinish(animCon, animName)
	if animName == "ShowSeasonLvUp" and self.mParent then
		self.mParent:refreshData()
	end
end

function SeasonPlayMainPanel:checkSeattleLvUpShow(num)
	if num and self.showNowProgress and num > self.showNowProgress then
		self.slider:setValue(1)
		self.lvUpAni:startAni("ShowSeasonLvUp", true)
	end
end

function SeasonPlayMainPanel:openShowChoose(nodeData, pos)
	self.showChooseBigAward:setVisible(false)
	self.showChooseAward:setVisible(true)

	if not self.showChooseAwardCell then
		self.showChooseAwardCell = {}
	end

	local award = nodeData.award

	if ResRandClient[award] then
		self.chooseAwardNode:setVisible(true)

		for i, id in ipairs(ResRandClient[award].show_ids) do
			if not self.showChooseAwardCell[i] then
				self.showChooseAwardCell[i] = UIControls.getGridAwardContainer(self, "ShowChooseAward/ChooseAwardNode")
			end

			self.showChooseAwardCell[i]:setVisible(true)

			local fakeItem = BaseObject.GetObject(id, ResRandClient[award].show_nums[i])

			self.showChooseAwardCell[i]:setObj(fakeItem)
		end

		local num = #ResRandClient[award].show_ids

		for i = num + 1, #self.showChooseAwardCell do
			self.showChooseAwardCell[i]:setVisible(false)
		end
	end

	local width = self.chooseAward:getRectSize().width

	self.chooseAward:setPosition(pos.x + width - 200, self.chooseAwardPosY)
end

function SeasonPlayMainPanel:onbtnCloseShowChooseAwardClick()
	self.showChooseAward:setVisible(false)
end

function SeasonPlayMainPanel:onBtnBigAwardClick(...)
	self.showChooseBigAward:setVisible(true)
	self.showChooseAward:setVisible(false)
end

function SeasonPlayMainPanel:onbtnCloseShowChooseBigAwardClick()
	self.showChooseBigAward:setVisible(false)
end

return SeasonPlayMainPanel

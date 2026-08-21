-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBPGiftPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local BPGiftCell = require("UI/OpActivity/BPGiftCell")
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")
local ResOpActivityDetail = require("ClientData/ResOpActivityDetail")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResJumpGuide = require("ClientData/ResJumpGuide")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local strClassName = "ActivityBPGiftPage"
local ActivityBPGiftPage = Class(strClassName, UIControls.Child)

MixinClass(ActivityBPGiftPage, ActivityPanelMixin)

function ActivityBPGiftPage:ctor()
	self.bpGiftCells = {}
	self.cellSize = 225
end

function ActivityBPGiftPage:initUI()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.btnJump = UIControls.Panel(self, "BtnSkip")
	self.sliderProgres = UIControls.Slider(self, "Scroll View/Viewport/Content/Slider")
	self.sliderPanel = UIControls.Panel(self, "Scroll View/Viewport/Content")
	self.sliderPos = {
		x = self.sliderPanel:getPosition().x,
		y = self.sliderPanel:getPosition().y
	}
	self.scrollItems = UIControls.ScrollViewLoopV(self, "TaskPaidList", 0, self._onCellChanged)

	if UIControls.checkControlFunc(self, "BgTextDes/TextLv") then
		self.textLv = UIControls.Label(self, "BgTextDes/TextLv")
	end

	if UIControls.checkControlFunc(self, "BgTextDes/BgTextBpPoint/TextBpPoint") then
		self.textBpPoint = UIControls.Label(self, "BgTextDes/BgTextBpPoint/TextBpPoint")
		self.panelBpPoint = UIControls.Panel(self, "BgTextDes/BgTextBpPoint")
	end
end

function ActivityBPGiftPage:setAchieveToGift()
	local tempData = ResOpActivityTemplate[self.actObj.actId]

	if tempData then
		local detailId = tempData.detail_id
		local relateId = tempData.relate_act and tempData.relate_act[1]

		if relateId and relateId > 0 then
			local objGift = CurAvatar:getActivityObj(relateId)

			if objGift and objGift.endTime == 0 and objGift.curState == Const.OPACT_STATE_CLOSE and tempData.relate_act[2] then
				relateId = tempData.relate_act[2]
			end

			local relateActivityTemplate = ResOpActivityTemplate[relateId]

			if relateActivityTemplate then
				detailId = relateActivityTemplate.detail_id
			end
		end

		if detailId and not self.achieveToGift then
			self.achieveToGift = {}

			local giftData = ResOpActivityDetail[detailId]

			for index, data in ipairs(giftData) do
				if data.act_limit_id and ResOpActivityConditionLimit[data.act_limit_id] then
					local limitData = ResOpActivityConditionLimit[data.act_limit_id]

					if not self.achieveToGift[limitData.param1] then
						self.achieveToGift[limitData.param1] = {}
					end

					self.achieveToGift[limitData.param1][limitData.param2] = {
						data.param[1],
						limitData
					}
				end
			end
		end
	end
end

function ActivityBPGiftPage:_setData()
	self.actData = self.actObj.actData

	if not self.achieveToGift then
		self:setAchieveToGift()
	end

	self.inLockIndex = self.actData.inLockIndex

	if not self.objGift then
		self.objGift = {}

		local relateId = self.actObj.templateData.relate_act and self.actObj.templateData.relate_act[1]

		if relateId then
			CurAvatar:addActivityRelated(relateId, "activityMainDlg", self.actObj.actId)

			self.objGift = CurAvatar:getActivityObj(relateId)

			if self.objGift and self.objGift.curState == Const.OPACT_STATE_CLOSE and self.actObj.templateData.relate_act[2] then
				relateId = self.actObj.templateData.relate_act[2]

				CurAvatar:addActivityRelated(relateId, "activityMainDlg", self.actObj.actId)

				self.objGift = CurAvatar:getActivityObj(relateId)
			end
		end
	end

	self.cellsData = {}

	for actType, typeData in pairs(self.actData.clientData) do
		for _, data in pairs(typeData) do
			if not self.inLockIndex[data.index] then
				if not self.actType then
					self.actType = data.type
				end

				table.insert(self.cellsData, data)
			end
		end
	end

	table.sort(self.cellsData, function(a, b)
		return a.param < b.param
	end)
end

function ActivityBPGiftPage:_onShow(isOnPageShow)
	self:setTarget()
end

function ActivityBPGiftPage:setTarget(noRefreshAll)
	if noRefreshAll then
		for newIdx, targetCell in pairs(self.bpGiftCells) do
			local clientData = self.cellsData[newIdx]
			local rechargeId

			if self.achieveToGift[clientData.type] and self.achieveToGift[clientData.type][clientData.index] then
				rechargeId = self.achieveToGift[clientData.type][clientData.index][1]
			end

			targetCell:setData(clientData, self.actData, self.objGift, rechargeId)
		end
	else
		local targPoint = math.min(self:getTargetPoint(), #self.cellsData - 3)
		local progress = 0

		if self.actData.serverData[self.actType] then
			progress = self.actData:getAchieveProgress(self.actType)
		end

		local curProIndex = 0

		for index, data in ipairs(self.cellsData) do
			if progress >= data.param then
				curProIndex = index
			else
				break
			end
		end

		local value = curProIndex / #self.cellsData

		if self.sliderProgres then
			self.sliderProgres:setValue(value)

			local rectSize = self.sliderPanel:getRectSize()

			self.sliderPanel:setRectSize(rectSize.width, self.cellSize * #self.cellsData)

			if targPoint > 1 then
				local deltaY = self.cellSize * (targPoint - 1)

				self.sliderPanel:setPosition(self.sliderPos.x, self.sliderPos.y + deltaY)
			end

			if self.actType == Const.ACT_TYPE_ENCORE_HERO or self.actType == Const.ACT_TYPE_ENCORE_HERO_LIGHT_DARK then
				self.sliderProgres:setVisible(false)

				if self.textLv and self.textBpPoint then
					if curProIndex >= #self.cellsData then
						if Const.REVIEW_VERSION then
							self.textLv:setText(Lang.get(1699))
						else
							self.textLv:setText("LV.MAX")
						end

						self.panelBpPoint:setVisible(false)
					else
						if Const.REVIEW_VERSION then
							self.textLv:setText(string.format(Lang.get(111361), curProIndex))
						else
							self.textLv:setText(string.format("LV.%d", curProIndex))
						end

						local nextIndex = self.cellsData[curProIndex + 1] and curProIndex + 1 or curProIndex

						self.textBpPoint:setText(string.format("%d/%d", progress, self.cellsData[nextIndex].param))
						self.panelBpPoint:setVisible(true)
					end
				end
			end
		end

		self.scrollItems:setTotalCount(#self.cellsData, targPoint, false)
	end
end

function ActivityBPGiftPage:getTargetPoint()
	local targetIndex

	for i, data in ipairs(self.cellsData) do
		local state = self.actData:getAchieveState(data.type, data.index)

		if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			targetIndex = i

			break
		end
	end

	if targetIndex == nil then
		for i, data in ipairs(self.cellsData) do
			local rechargeId = self.achieveToGift[data.type] and self.achieveToGift[data.type][data.index] and self.achieveToGift[data.type][data.index][1] or nil

			if rechargeId then
				local svrDataGift = self.objGift.actData.serverData[rechargeId]
				local count = svrDataGift and svrDataGift.count or 0
				local product = RechargeManager.getProductByRechargeId(rechargeId)
				local canBuyCount = product.buyTimesMax - count

				if canBuyCount > 0 then
					targetIndex = i

					break
				end
			end
		end
	end

	if targetIndex and targetIndex > 1 then
		return targetIndex - 1
	else
		return 1
	end
end

function ActivityBPGiftPage:refreshPanel()
	return
end

function ActivityBPGiftPage:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		local path = "System/Activity/"
		local cellPath = "ActivityHeroGrowthGift/HeroGrowthGiftItem01"

		if self.replaceableCellPath and self.replaceableCellPath[1] then
			cellPath = self.replaceableCellPath[1]
		end

		targetCell = BPGiftCell(sender, path .. cellPath, newIdx, 0, 0)
		targetCell.mEventClickFree = Slot(self.onBtnFreeClick, self)
		targetCell.mEventClickPay = Slot(self.onBtnPayClick, self)
	else
		self.bpGiftCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.bpGiftCells[newIdx] = targetCell

	local clientData = self.cellsData[newIdx]
	local rechargeId

	if self.achieveToGift[clientData.type] and self.achieveToGift[clientData.type][clientData.index] then
		rechargeId = self.achieveToGift[clientData.type][clientData.index][1]
	end

	self.bpGiftCells[newIdx]:setData(clientData, self.actData, self.objGift, rechargeId)
end

function ActivityBPGiftPage:onBtnFreeClick(sender)
	if sender.state == 3 then
		local noticeStr = Lang.get(30609)

		if self.achieveToGift[sender.data.type] and self.achieveToGift[sender.data.type][sender.data.index] and self.achieveToGift[sender.data.type][sender.data.index][2] and self.achieveToGift[sender.data.type][sender.data.index][2].unlock_desc then
			noticeStr = self.achieveToGift[sender.data.type][sender.data.index][2].unlock_desc
		end

		MsgManager.notice(noticeStr)
	else
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, sender.data.index, sender.data.type), self.actObj.opId)
	end
end

function ActivityBPGiftPage:onBtnPayClick(sender)
	if sender.state == 3 then
		local noticeStr = Lang.get(30609)

		if self.achieveToGift[sender.data.type] and self.achieveToGift[sender.data.type][sender.data.index] and self.achieveToGift[sender.data.type][sender.data.index][2] and self.achieveToGift[sender.data.type][sender.data.index][2].unlock_desc then
			noticeStr = self.achieveToGift[sender.data.type][sender.data.index][2].unlock_desc
		end

		MsgManager.notice(noticeStr)
	else
		local rechargeArgs = {}

		rechargeArgs.chooseResult = sender.chooseResult

		CurAvatar:activityRPC(Functor(RechargeManager.startRecharge, sender.rechargeId, rechargeArgs, nil), self.objGift.opId)
	end
end

function ActivityBPGiftPage:onActivityDataRefresh(actObj)
	self:setTarget(true)
end

return ActivityBPGiftPage

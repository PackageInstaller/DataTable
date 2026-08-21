-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\AchievePanelInPage.lua

local ResRandClient = require("ClientData/ResRandClient")
local DragTwoPages = require("UI/Control/DragTwoPages")
local AchieveInPage = Class("AchieveInPage", UIControls.Child)

function AchieveInPage:ctor()
	self.txtFrozen = UIControls.Label(self, "TxtFrozen")
	self.txtPanel = UIControls.Panel(self, "TxtPanel")
	self.txtTask = UIControls.Label(self, "TxtPanel/TxtTask")
	self.txtNum = UIControls.Label(self, "TxtPanel/TxtNum")
	self.slider = UIControls.Slider(self, "TaskSlider", "TaskText")
	self.aniToget = UIControls.UIAni(self, "BtnPreview")
	self.imgState = UIControls.Image(self, "ImgState")
	self.btnGet = UIControls.Button(self, "BtnPreview/BtnGet")

	self.btnGet:addEventClick(self.onAwardClick)

	self.awardItems = {}
end

function AchieveInPage:initPageData(actObj, lotteryActId, clientData, isLotteryDraw)
	self.actObj = actObj
	self.lotteryActId = lotteryActId
	self.clientData = clientData
	self.isLotteryDraw = isLotteryDraw
end

function AchieveInPage:refreshPageData(isLotteryDraw, index)
	self.isLotteryDraw = isLotteryDraw

	self:showAchieve(index)
end

function AchieveInPage:showAchieve(index)
	if not self.isLotteryDraw then
		self.txtPanel:setVisible(true)
		self.slider:setVisible(true)
		self.aniToget:setVisible(true)
		self.imgState:setVisible(true)
		self.txtFrozen:setVisible(false)

		local data = self.clientData[index][1]
		local curShowState = self.actObj.actData:getAchieveState(data.type, data.index)

		self.curShowState = curShowState

		local descNum = "(" .. index .. "/" .. #self.clientData .. ")"

		self.txtNum:setText(descNum)
		self.txtTask:setText(data.desc_name)

		local curShowProgress, maxShowProgress = self.actObj.actData:getAchieveShowProgress(data)

		curShowProgress = curShowProgress < maxShowProgress and curShowProgress or maxShowProgress

		self.slider:setValue(curShowProgress / maxShowProgress)
		self.slider:setText(curShowProgress .. "/" .. maxShowProgress)
		self.txtFrozen:setVisible(false)

		if not self.actObj:isValid() or self.curShowState == Const.ACT_ACHIEVE_STATE_GOT then
			self.imgState:setVisible(true)
			self.aniToget:setVisible(false)
			self:setObjGray(true)
		else
			if self.curShowState == Const.ACT_ACHIEVE_STATE_ENOUGH then
				self.aniToget:startAniLoop("LoopHeroUpCardGet")
				self.btnGet:setVisible(true)

				self.curShowIndex = index
			else
				self.aniToget:startAniLoop("ResetHeroUpCardGet")
				self.btnGet:setVisible(false)
			end

			self.imgState:setVisible(false)
			self.aniToget:setVisible(true)
			self:setObjGray(false)

			local awardData = ResRandClient[data.award]

			if awardData and awardData.show_ids then
				for idx, id in ipairs(awardData.show_ids) do
					if not self.awardItems[idx] then
						local item = BaseObject.GetObject(awardData.show_ids[idx], awardData.show_nums[idx])
						local awardItem = UIControls.getGridAwardContainer(self, "BtnPreview/GridPanel")

						awardItem:setVisible(true)
						awardItem:setObj(item)

						awardItem.grid.mDisableWays = true
						self.awardItems[idx] = awardItem
					end

					self.awardItems[idx].grid.mEnableTips = self.curShowState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
				end
			end
		end
	else
		self.txtFrozen:setVisible(true)
		self.txtPanel:setVisible(false)
		self.slider:setVisible(false)
		self.aniToget:setVisible(false)
		self.imgState:setVisible(false)
	end
end

function AchieveInPage:onAwardClick()
	if self.curShowState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		local ui = UIManager.getUI("activityLotteryGetCodeDlg", true)

		ui:setCode(self.lotteryActId, "")
		ui:onDraw(self.isLotteryDraw)

		local param = self.clientData[self.curShowIndex][1].index
		local achieveType = self.clientData[self.curShowIndex][1].type

		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, param, achieveType), self.actObj.opId)
	end
end

local AchievePanelInPage = Class("AchievePanelInPage", UIControls.Panel)

function AchievePanelInPage:ctor()
	self:initUI()
end

function AchievePanelInPage:initUI()
	self.dragPages = DragTwoPages(self.mParent, "TaskPanel/ContentPanel1", "TaskPanel/ContentPanel2", "BtnLeft", "BtnRight")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)

	self.dragPages:setOutRangeNotice(Lang.get(58689))
end

function AchievePanelInPage:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	self.panelIndex = panelIndex
	self.currentPageIndex = currentPageIndex

	self.pages[panelIndex]:showAchieve(currentPageIndex)
end

function AchievePanelInPage:setButtonState(isLotteryDraw)
	local parent = self.mParent
	local leftBtn = UIControls.Button(parent, "BtnLeft")
	local leftArrowImage = UIControls.Image(parent, "BtnLeft/IconArrow")
	local rightBtn = UIControls.Button(parent, "BtnRight")
	local rightArrowImage = UIControls.Image(parent, "BtnRight/IconArrow")

	leftBtn:setVisible(not isLotteryDraw and self.lotteryActObj.curState ~= Const.OPACT_STATE_PREOPEN)
	rightBtn:setVisible(not isLotteryDraw and self.lotteryActObj.curState ~= Const.OPACT_STATE_PREOPEN)
	leftBtn:setEnable(not isLotteryDraw)
	rightBtn:setEnable(not isLotteryDraw)
	leftArrowImage:setVisible(not isLotteryDraw)
	rightArrowImage:setVisible(not isLotteryDraw)
end

function AchievePanelInPage:initPanel(actId, lotteryActId)
	self.actId = actId
	self.lotteryActId = lotteryActId
	self.actObj = CurAvatar:getActivityObj(self.actId)
	self.lotteryActObj = CurAvatar:getActivityObj(self.lotteryActId)
	self.clientData = {}

	local clientData = self.actObj.actData.clientData

	for idx, data in pairs(clientData) do
		table.insert(self.clientData, data)
	end

	table.sort(self.clientData, function(a, b)
		return a[1].show_priority < b[1].show_priority
	end)
end

function AchievePanelInPage:refreshData(isLotteryDraw)
	local curShowIndex, notEnoughIndex

	for i, typeData in ipairs(self.clientData) do
		local data = typeData[1]
		local achieveType = data.type
		local curState = self.actObj.actData:getAchieveState(achieveType, data.index)

		if curState == Const.ACT_ACHIEVE_STATE_ENOUGH then
			curShowIndex = i

			break
		elseif curState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			notEnoughIndex = notEnoughIndex or i
		end
	end

	curShowIndex = curShowIndex or notEnoughIndex
	curShowIndex = curShowIndex or #self.clientData

	for i, page in pairs(self.pages or {}) do
		if page then
			page:destroy()

			page = nil
		end
	end

	self.pages = nil

	if not self.pages then
		local taskCellPrefabPath = self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[1] or "ActivityASUSPrize"

		taskCellPrefabPath = "System/Activity/" .. taskCellPrefabPath .. "/TaskCell"

		local page1 = AchieveInPage(self, "ContentPanel1", taskCellPrefabPath, 0, 0, true)
		local page2 = AchieveInPage(self, "ContentPanel2", taskCellPrefabPath, 0, 0, true)

		page1:initPageData(self.actObj, self.lotteryActId, self.clientData, isLotteryDraw)
		page2:initPageData(self.actObj, self.lotteryActId, self.clientData, isLotteryDraw)

		self.pages = {
			page1,
			page2
		}

		self.dragPages:initPage(3, curShowIndex)
	elseif self.currentPageIndex ~= curShowIndex then
		self.dragPages:initPage(3, curShowIndex)
	else
		self.pages[self.panelIndex]:refreshPageData(isLotteryDraw, curShowIndex)
	end

	self:setButtonState(isLotteryDraw)
end

return AchievePanelInPage

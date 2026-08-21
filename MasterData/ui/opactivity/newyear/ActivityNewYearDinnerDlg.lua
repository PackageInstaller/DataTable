-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\NewYear\\ActivityNewYearDinnerDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityNYDinnerMainCell = Class("ActivityNYDinnerMainCell", UIControls.Panel)

function ActivityNYDinnerMainCell:ctor()
	self.panelCooking = UIControls.Panel(self, self.mPath .. "/CookingPanel")
	self.textCookingTime = UIControls.Label(self, self.mPath .. "/CookingPanel/TimeProgress/TxtTime")
	self.sliderCookingTime = UIControls.Slider(self, self.mPath .. "/CookingPanel/TimeProgress")
	self.imgFood = UIControls.Image(self, self.mPath .. "/CookingPanel/IconFood")
	self.panelQueue = UIControls.Panel(self, self.mPath .. "/CookingPanel/BgQueue")
	self.imgQueueFood = UIControls.Image(self, self.mPath .. "/CookingPanel/BgQueue/IconFood")
	self.panelFree = UIControls.Panel(self, self.mPath .. "/FreePanel")
	self.panelFreeNew = UIControls.Panel(self, self.mPath .. "/FreePanel/IconNew")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.textLock = UIControls.Label(self, self.mPath .. "/LockPanel/Txt")
	self.btnLockJump = UIControls.Button(self, self.mPath .. "/LockPanel/BtnCondition")

	self.btnLockJump:addEventClick(self.onLockJumpClick)

	self.panelLockNml = UIControls.Panel(self, self.mPath .. "/LockPanel/DecPanel")
	self.panelFreeze = UIControls.Panel(self, self.mPath .. "/FrozenPanel")
	self.panelFinish = UIControls.Button(self, self.mPath .. "/HaveFood")

	self.panelFinish:addEventClick(self.onGetClick)

	self.imgFinishFood = UIControls.Image(self, self.mPath .. "/HaveFood/IconFood")
	self.iconFinishFirstNew = UIControls.Image(self, self.mPath .. "/HaveFood/IconNew")
	self.iconFinishNew = UIControls.Image(self, self.mPath .. "/HaveFood/IconNew1")
	self.aniCell = UIControls.UIAni(self, self.mPath)
end

function ActivityNYDinnerMainCell:setData(pos, openedInfo, cookerInfo)
	self.pos = pos

	if openedInfo then
		self.panelLock:setVisible(false)
		self.extraPanel:setVisible(true)

		self.cooking = cookerInfo[1]
		self.queue = cookerInfo[2]
		self.finish = cookerInfo[3]
		self.getting = nil

		if self.cooking then
			self.panelFreeze:setVisible(false)
			self.liveImg:playLive2DByPath(openedInfo.cooking_live_path or "")
			self.panelCooking:setVisible(true)
			self.extraImg:setVisible(true)
			self.panelFree:setVisible(false)

			if self.cooking.resData.icon_path and self.cooking.resData.icon then
				self.imgFood:setImage(self.cooking.resData.icon_path, self.cooking.resData.icon)
			end

			local costTime = self.cooking.endTime - self.cooking.startTime
			local startTime = self.cooking.startTime
			local curPassed = ClientUtils.getServerTime() - startTime

			self.sliderCookingTime:setValue(curPassed / costTime)

			if curPassed < costTime then
				self.sliderCookingTime:setValue(1, costTime - curPassed)
				ClientTimerManager.AddSecondTickUI(self.textCookingTime, costTime - curPassed)
			end

			if self.queue then
				self.panelQueue:setVisible(true)

				if self.queue.resData.icon_path and self.queue.resData.icon then
					self.imgQueueFood:setImage(self.queue.resData.icon_path, self.queue.resData.icon)
				end
			else
				self.panelQueue:setVisible(false)
			end
		else
			self.extraImg:setVisible(false)
			self.panelCooking:setVisible(false)
			self.liveImg:playLive2DByPath(openedInfo.live_path or "")

			if self.mParent.actObj:inFreeze() then
				self.panelFreeze:setVisible(true)
				self.panelFree:setVisible(false)
			else
				self.panelFreeze:setVisible(false)
				self.panelFree:setVisible(true)

				if self.mParent.actObj.actData:hasFood() then
					self.panelFreeNew:setVisible(true)
				else
					self.panelFreeNew:setVisible(false)
				end
			end
		end

		if self.finish and #self.finish > 0 then
			self.finishFood = self.finish[1]

			self.panelFinish:setVisible(true)

			if self.finish[1].resData.icon_path and self.finish[1].resData.icon then
				self.imgFinishFood:setImage(self.finish[1].resData.icon_path, self.finish[1].resData.icon)
			end

			if not self.finish[1].gotBonus then
				self.iconFinishFirstNew:setVisible(true)
				self.iconFinishNew:setVisible(false)
			else
				self.iconFinishFirstNew:setVisible(false)
				self.iconFinishNew:setVisible(true)
			end
		else
			self.panelFinish:setVisible(false)
		end

		self.liveImg:setVisible(true)
	else
		self.lockData = cookerInfo

		self.textLock:setText(cookerInfo.unlock_desc)
		self.panelLock:setVisible(true)
		self.panelFreeze:setVisible(false)

		if self.lockData.unlock_jump then
			self.panelLockNml:setVisible(false)
			self.btnLockJump:setVisible(true)
		else
			self.btnLockJump:setVisible(false)
			self.panelLockNml:setVisible(true)
		end

		self.liveImg:setVisible(false)
		self.extraPanel:setVisible(false)
		self.panelCooking:setVisible(false)
		self.panelFree:setVisible(false)
	end
end

function ActivityNYDinnerMainCell:onGetClick()
	if not self.getting then
		self.mParent.actObj.actData:rpcGetBonus(self.pos, self.finishFood)

		self.getting = true
	end
end

function ActivityNYDinnerMainCell:onLockJumpClick()
	if self.lockData and self.lockData.unlock_jump then
		if self.lockData.unlock_confirm then
			UIManager.showConfirmWithId(self.lockData.unlock_confirm, Functor(JumpGuideManager.jump, self.lockData.unlock_jump))
		else
			JumpGuideManager.jump(self.lockData.unlock_jump)
		end
	end
end

function ActivityNYDinnerMainCell:setExtraUIs(liveImg, liveBtn, panel, img)
	self.extraPanel = panel
	self.extraImg = img
	self.liveImg = liveImg
	self.liveBtn = liveBtn
end

function ActivityNYDinnerMainCell:playUnlockAnim()
	self.aniCell:startAni("UnlockEve", true)
end

local ActivityCookingGrid = Class("ActivityCookingGrid", UIControls.Panel)

function ActivityCookingGrid:ctor()
	self.textName = UIControls.Label(self, self.mPath .. "/TxtTitle")
	self.panelEmpty = UIControls.Panel(self, self.mPath .. "/FreePanel")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.textLock = UIControls.Label(self, self.mPath .. "/LockPanel/TxtLock")
	self.panelAward = UIControls.Panel(self, self.mPath .. "/AwardPanel")
	self.grids = {}
	self.imgFood = UIControls.Image(self, self.mPath .. "/AwardPanel/GirdFood")
	self.textFoodName = UIControls.Label(self, self.mPath .. "/AwardPanel/TxtAwardTitle")
	self.textAwardTime = UIControls.Label(self, self.mPath .. "/AwardPanel/TimeProgress/TxtTime")
	self.sliderAwardTime = UIControls.Slider(self, self.mPath .. "/AwardPanel/TimeProgress")
	self.btnChange = UIControls.Button(self, self.mPath .. "/AwardPanel/BtnChange")

	self.btnChange:addEventClick(self.onChangeClick)
end

function ActivityCookingGrid:setData(locked, nowFood, isQueue)
	if locked then
		self.panelEmpty:setVisible(false)
		self.panelLock:setVisible(true)
		self.panelAward:setVisible(false)

		if isQueue then
			self.textLock:setText(self.mParent.actData.miscData.queue_desc)
		end
	else
		self.panelLock:setVisible(false)

		if nowFood then
			self.panelEmpty:setVisible(false)
			self.panelAward:setVisible(true)
			ClientUtils.CreateBonusGrid(self, self.grids, self.mPath .. "/AwardPanel/AwardList", nowFood.resData.reward_id, nil, nil, true)

			if nowFood.resData.icon_path and nowFood.resData.icon then
				self.imgFood:setImage(nowFood.resData.icon_path, nowFood.resData.icon)
			end

			self.textFoodName:setText(nowFood.resData.name or "")

			local costTime = nowFood.endTime - nowFood.startTime

			if isQueue then
				self.textAwardTime:setText(utils.calcTimeTxt(costTime))
				self.sliderAwardTime:setValue(1)
				self.btnChange:setVisible(true)
			else
				local startTime = nowFood.startTime
				local curPassed = ClientUtils.getServerTime() - startTime

				self.sliderAwardTime:setValue(curPassed / costTime)

				if curPassed < costTime then
					self.sliderAwardTime:setValue(1, costTime - curPassed)
					ClientTimerManager.AddSecondTickUI(self.textAwardTime, costTime - curPassed)
				end

				self.btnChange:setVisible(false)
			end
		else
			self.panelEmpty:setVisible(true)
			self.panelAward:setVisible(false)
		end
	end
end

function ActivityCookingGrid:onChangeClick()
	CurAvatar:activityRPC(RPC.opActOnHookRoleCancelCook, self.mParent.actData.actObject.opId, self.mParent.actData.actObject.opId, self.mParent.pos)
end

local ActivityCookingFinishGrid = Class("ActivityCookingFinishGrid", UIControls.Panel)

function ActivityCookingFinishGrid:ctor()
	self.imgFood = UIControls.Image(self, self.mPath .. "/GirdFood")
	self.imgFirstNew = UIControls.Image(self, self.mPath .. "/IconNew")
	self.imgNew = UIControls.Image(self, self.mPath .. "/IconNew1")
	self.textName = UIControls.Label(self, self.mPath .. "/TxtTitle")
	self.btnGet = UIControls.Button(self, self.mPath .. "/BtnGet")

	self.btnGet:addEventClick(self.onGetClick)
end

function ActivityCookingFinishGrid:setData(finish)
	if finish and #finish > 0 then
		self.getting = nil
		self.finishFood = finish[1]

		self:setVisible(true)

		if self.finishFood.resData.icon_path and self.finishFood.resData.icon then
			self.imgFood:setImage(self.finishFood.resData.icon_path, self.finishFood.resData.icon)
		end

		self.textName:setText(self.finishFood.resData.name or "")

		if not self.finishFood.gotBonus then
			self.imgFirstNew:setVisible(true)
			self.imgNew:setVisible(false)
		else
			self.imgFirstNew:setVisible(false)
			self.imgNew:setVisible(true)
		end
	else
		self:setVisible(false)
	end
end

function ActivityCookingFinishGrid:onGetClick()
	if not self.getting then
		self.mParent.actData:rpcGetBonus(self.mParent.pos, self.finishFood)

		self.getting = true
	end
end

local ActivityCookingFoodGrid = Class("ActivityCookingFoodGrid", UIControls.ScrollViewLoopCell)

function ActivityCookingFoodGrid:ctor()
	self.imgFood = UIControls.Image(self, "GirdFood")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.textName = UIControls.Label(self, "TxtFoodName")
	self.btnCook = UIControls.Button(self, "BtnCook")

	self.btnCook:addEventClick(self.onCookClick)

	self.textTime = UIControls.Label(self, "TxtTime")
	self.panelSelf = UIControls.Panel(self, "")
	self.textExp = UIControls.Label(self, "ExpriencePanel/TxtNum")
	self.grids = {}
end

function ActivityCookingFoodGrid:setData(foodInfo, actData, pos)
	self.actData = actData
	self.pos = pos

	local hasItem = foodInfo[1]

	self.foodData = foodInfo[2]

	if self.foodData.icon_path and self.foodData.icon then
		self.imgFood:setImage(self.foodData.icon_path, self.foodData.icon)
	end

	self.textName:setText(self.foodData.name or "")
	self.textExp:setText("+" .. self.foodData.add_exp)

	local needItem = BaseObject.GetObject(self.foodData.cost_item, 1)

	if not self.gridNeed then
		self.gridNeed = UIControls.getGridChild(needItem, self, "GirdMetrial")

		self.gridNeed:setVisible(true)
	end

	self.gridNeed:setObj(needItem)

	self.hasNum = CurAvatar:getItemNumById(self.foodData.cost_item) or 0

	self.gridNeed.textNum:setText(self.hasNum .. "/1")
	self.textTime:setText(actData:getFoodCookTimeStr(self.foodData.food_id))
	self.btnCook:setEnable(self.hasNum > 0)
	ClientUtils.CreateBonusGrid(self, self.grids, "AwardList", self.foodData.reward_id, nil, nil, true)
	self.panelSelf:setObjGray(self.hasNum <= 0, true)
end

function ActivityCookingFoodGrid:onCookClick()
	if self.actData.curCooking[self.pos] and self.actData.cueQueue[self.pos] then
		MsgManager.notice(self.actData.miscData.full_notice or "")
	elseif self.actData.curCooking[self.pos] and self.actData:isQueueLocked(self.pos) then
		MsgManager.notice(self.actData.miscData.lock_notice or "")
	else
		local nowNum = 0

		if self.actData.curFinish[self.pos] then
			nowNum = #self.actData.curFinish[self.pos]
		end

		if self.actData.curCooking[self.pos] then
			nowNum = nowNum + 1
		end

		if nowNum >= 10 then
			MsgManager.notice(self.actData.miscData.limit_notice or "")

			return
		end

		CurAvatar:activityRPC(RPC.opActOnHookRoleOnCook, self.actData.actObject.opId, self.actData.actObject.opId, self.pos, self.foodData.food_id)
	end
end

local ActivityCookPosDetailPanel = Class("ActivityCookPosDetailPanel", UIControls.Panel)

function ActivityCookPosDetailPanel:ctor()
	self.panelFoodMenu = UIControls.Panel(self, self.mPath .. "/FoodMenuPanel")
	self.foodCells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/FoodMenuPanel/FoodMenuList")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.panelNowList = UIControls.Panel(self, self.mPath .. "/CookingListPanel")
	self.nowFoodGrid = ActivityCookingGrid(self, self.mPath .. "/CookingListPanel/CookPanel")
	self.nowQueueFoodGrid = ActivityCookingGrid(self, self.mPath .. "/CookingListPanel/WaitPanel")
	self.panelFreeze = UIControls.Panel(self, self.mPath .. "/CookingListPanel/CookPanel/FrozenPanel")
	self.panelFinish = ActivityCookingFinishGrid(self, self.mPath .. "/FoodFinishPanel")
end

function ActivityCookPosDetailPanel:refreshData(pos)
	if self.pos == nil and pos == nil then
		return
	end

	if pos then
		self.pos = pos
	end

	self.actData = self.mParent.actObj.actData
	self.posDetailData, self.posInfo = self.actData:getCookingData(self.pos)
	self.allFood = self.actData:getSortedAllFood()

	self.scroll:setTotalCount(#self.allFood, 1, false)
	self.nowFoodGrid:setData(false, self.posInfo[1], false)
	self.nowQueueFoodGrid:setData(self.actData:isQueueLocked(self.pos), self.posInfo[2], true)
	self.panelFinish:setData(self.posInfo[3])
	self.panelFreeze:setVisible(self.mParent.actObj:inFreeze())
end

function ActivityCookPosDetailPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityCookingFoodGrid(sender, self.mParent.cellPath .. "/FoodMenuCell", newIdx)
	else
		self.foodCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(self.allFood[newIdx], self.actData, self.pos)

	self.foodCells[newIdx] = targetCell
end

local strClassName = "ActivityNewYearDinnerDlg"
local ActivityNewYearDinnerDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityNewYearDinnerDlg, ActivityPanelMixin)

local MAX_ACT_NUM = 6

function ActivityNewYearDinnerDlg:initUI()
	self.cellPath = "System/Activity/ActivityNewYearEve"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1]
	end

	self.panelMain = UIControls.Panel(self, "MainInfoPanel")
	self.textTime = UIControls.Label(self, "MainInfoPanel/TimePanel/TxtTime")
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnClose)

	self.panelsCookers = {}

	for index = 1, MAX_ACT_NUM do
		local liveImg = UIControls.LazyLivePlayer(self, "MainInfoPanel/CookPanel/GridCook" .. index .. "/Live2D")
		local liveBtn = UIControls.Button(self, "MainInfoPanel/CookPanel/GridCook" .. index .. "/Live2D")

		liveBtn.pos = index

		liveBtn:addEventClick(self.onPosClick)

		local newCooker = ActivityNYDinnerMainCell(self, "MainInfoPanel/CookPanel/GridCook" .. index .. "/LocalCook")
		local newPanel = UIControls.Panel(self, "MainInfoPanel/CookPanel/GridCook" .. index .. "/IconPan")
		local newImg = UIControls.Panel(self, "MainInfoPanel/CookPanel/GridCook" .. index .. "/IconPan/IconCooking")

		newCooker:setExtraUIs(liveImg, liveBtn, newPanel, newImg)
		table.insert(self.panelsCookers, newCooker)
	end

	self.btnLevel = UIControls.Button(self, "MainInfoPanel/BtnKitchenLevel")

	self.btnLevel:addEventClick(self.onLevelClick)

	self.panelLevelMax = UIControls.Panel(self, "MainInfoPanel/BtnKitchenLevel/TopLevelPanel")
	self.textLevel = UIControls.Label(self, "MainInfoPanel/BtnKitchenLevel/LevelPanel/TxtNum")
	self.sliderLevel = UIControls.Slider(self, "MainInfoPanel/BtnKitchenLevel/LevelProgress")
	self.textLevelExp = UIControls.Label(self, "MainInfoPanel/BtnKitchenLevel/LevelProgress/TxtNum")
	self.btnAVG = UIControls.Button(self, "MainInfoPanel/BtnAVG")

	self.btnAVG:addEventClick(self.onAVGClick)

	self.btnSpeedUp = UIControls.Button(self, "MainInfoPanel/BtnCook")

	self.btnSpeedUp:addEventClick(self.onSpeedUpClick)

	self.panelPosDetailInfo = ActivityCookPosDetailPanel(self, "CookInfoPanel")
end

function ActivityNewYearDinnerDlg:_setData()
	self.actObj.actData:refreshItemData()
	self:refreshData()
end

function ActivityNewYearDinnerDlg:refreshData()
	local actData = self.actObj.actData

	for pos, posCooker in ipairs(self.panelsCookers) do
		local openedInfo, cookerInfo = actData:getCookingData(pos)

		posCooker:setData(pos, openedInfo, cookerInfo)
	end

	self.unlockPos = actData:getLevelUnlockPos()

	local levelData = actData.levelData

	self.nowLevel = actData.level

	self.textLevel:setText(self.nowLevel)

	if self.nowLevel == 0 then
		actData:rpcFirstIn()
		self.panelLevelMax:setVisible(false)
		self.textLevelExp:setText("0/0")
		self.sliderLevel:setValue(1)
	elseif self.nowLevel == #levelData then
		self.panelLevelMax:setVisible(true)
		self.textLevelExp:setText(Lang.get(467))
		self.sliderLevel:setValue(1)
	else
		self.panelLevelMax:setVisible(false)

		local exp = actData.exp
		local data = levelData[self.nowLevel + 1]
		local nowExp = data.need_exp - levelData[self.nowLevel].need_exp

		self.textLevelExp:setText(exp .. "/" .. nowExp)
		self.sliderLevel:setValue(exp / nowExp)
	end

	self:checkUnlockPos()
end

function ActivityNewYearDinnerDlg:checkUnlockPos()
	if self.coNextAvg then
		coroutine.stop(self.coNextAvg)

		self.coNextAvg = nil
	end

	if self.unlockPos and #self.unlockPos > 0 then
		if self.closeModePos then
			self:leaveCloseMode()
		end

		if UIManager.tryGetUI("activityNewYearBonusDlg") then
			return
		end

		if UIManager.tryGetUI("activityNewYearLevelUpDlg") then
			return
		end

		local pos = table.remove(self.unlockPos, 1)
		local posData = self.actObj.actData.clientData[pos]

		if posData and posData.unlock_avg then
			UIManager.playAVG(posData.unlock_avg, nil, Functor(self.playUnlockAnim, self, pos), true)
		end
	end
end

function ActivityNewYearDinnerDlg:updateActivityData()
	self:refreshData()

	if self.closeModePos then
		self.panelPosDetailInfo:refreshData()
	end

	local activityNewYearSpeedUpDlg = UIManager.tryGetUI("activityNewYearSpeedUpDlg")

	if activityNewYearSpeedUpDlg then
		activityNewYearSpeedUpDlg:onShow(self.actObj.actData)
	end
end

function ActivityNewYearDinnerDlg:playUnlockAnim(pos)
	self.actObj.actData:saveLevelUnlockPos()

	if self.id == nil then
		return
	end

	local posPanel = self.panelsCookers[pos]

	if posPanel then
		posPanel:playUnlockAnim()
	end

	if self.unlockPos and #self.unlockPos > 0 then
		self.coNextAvg = coroutine.start(self.funcCoNextAvg, self)
	else
		self:bgmOn()
	end
end

function ActivityNewYearDinnerDlg:funcCoNextAvg()
	coroutine.wait(1)
	self:checkUnlockPos()
end

function ActivityNewYearDinnerDlg:onPosClick(sender)
	if self.actObj:inFreeze() then
		MsgManager.notice(self.actObj.actData.miscData.freeze_notice or "")

		return
	end

	if not self.closeModePos then
		self:enterCloseMode(sender.pos)
	end
end

function ActivityNewYearDinnerDlg:onLevelClick(sender)
	local activityNewYearLevelDlg = UIManager.getUI("activityNewYearLevelDlg", true)

	activityNewYearLevelDlg:onShow(self.actObj.actData)
	activityNewYearLevelDlg:bindWindow(self)
end

function ActivityNewYearDinnerDlg:setHide(v, showAni, notOnOpen)
	ActivityNewYearDinnerDlg.super.setHide(self, v, showAni, notOnOpen)

	if v and self.panelMain then
		self.panelMain:setVisible(false)
	end
end

function ActivityNewYearDinnerDlg:onOpen()
	ActivityNewYearDinnerDlg.super.onOpen(self)

	if self.panelMain then
		self.panelMain:setVisible(true)
		self:refreshData()
	end
end

function ActivityNewYearDinnerDlg:onAVGClick(sender)
	UIManager.getUI("activityNewYearAvgDlg", true):onShow(self.actObj.actData)
end

function ActivityNewYearDinnerDlg:onSpeedUpClick(sender)
	local activityNewYearSpeedUpDlg = UIManager.getUI("activityNewYearSpeedUpDlg", true)

	activityNewYearSpeedUpDlg:onShow(self.actObj.actData)
	activityNewYearSpeedUpDlg:bindWindow(self)
end

function ActivityNewYearDinnerDlg:enterCloseMode(pos)
	self.closeModePos = pos

	self:playAni("ShowCook" .. pos)
	self.panelPosDetailInfo:refreshData(pos)
end

function ActivityNewYearDinnerDlg:leaveCloseMode()
	if self.closeModePos then
		self:playAni("ShowOutCook" .. self.closeModePos)

		self.closeModePos = nil
	end
end

function ActivityNewYearDinnerDlg:onBtnClose()
	if self.closeModePos then
		self:leaveCloseMode()
	else
		self:setVisible(false)
	end
end

function ActivityNewYearDinnerDlg:destroy()
	if self.coNextAvg then
		coroutine.stop(self.coNextAvg)

		self.coNextAvg = nil
	end

	ActivityNewYearDinnerDlg.super.destroy(self)
end

return ActivityNewYearDinnerDlg

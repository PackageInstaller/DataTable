-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayListDlg.lua

local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResRandClient = require("ClientData/ResRandClient")
local SeasonPlayListCell = Class("SeasonPlayListCell", UIControls.ScrollViewLoopCell)
local FlyIconUtils = require("UI/Common/FlyIconUtils")

function SeasonPlayListCell:ctor(...)
	self:initUI()
end

function SeasonPlayListCell:initUI(...)
	self.textNumNow = UIControls.Label(self, "TaskDayListCell/TextNum1")
	self.textNumTarget = UIControls.Label(self, "TaskDayListCell/TextNum2")
	self.slider = UIControls.Slider(self, "TaskDayListCell/Slider")
	self.txt = UIControls.Label(self, "TaskDayListCell/Text")
	self.btnGo = UIControls.Button(self, "TaskDayListCell/BtnGo")

	self.btnGo:addEventClick(self.onBtnGoClick)

	self.timeTips = UIControls.Image(self, "TaskDayListCell/TimeTips")
	self.txtTime = UIControls.Label(self, "TaskDayListCell/TimeTips/Text")
	self.btnConfirm = UIControls.Button(self, "TaskDayListCell/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtRuleTitle = UIControls.Label(self, "TaskDayListCell/RulePanel/TextRuleTitle")
	self.textRule = UIControls.Label(self, "TaskDayListCell/RulePanel/TextRule")
	self.animator = UIControls.Panel(self, "TaskDayListCell")
	self.iconNewOpen = UIControls.Panel(self, "TaskDayListCell/IconNewOpen")
	self.cells = {}
	self.txtTime = UIControls.Label(self, "TaskDayListCell/TimeTips/Text")
	self.timeTips = UIControls.Panel(self, "TaskDayListCell/TimeTips")
end

function SeasonPlayListCell:setData(data)
	if not data then
		return
	end

	self.data = data
	self.state = self.data.state
	self.isRank = self.data.isRank

	self.btnConfirm:setVisible(false)

	if self.isRank then
		self.animator:playStateAnimator("SeasonPlayListCellRank")
	elseif self.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.animator:playStateAnimator("SeasonPlayListCellHigh")
		self.btnConfirm:setVisible(true)
	elseif self.state == Const.ACT_ACHIEVE_STATE_GOT then
		self.animator:playStateAnimator("SeasonPlayListCellDis")
	else
		self.animator:playStateAnimator("SeasonPlayListCellNml")
	end

	self.btnGo:setVisible(false)

	if self.data.detail_id and self.data.type and ResOpActivityAchieveMisc[self.data.detail_id] and ResOpActivityAchieveMisc[self.data.detail_id][self.data.type] then
		local jumpId = ResOpActivityAchieveMisc[self.data.detail_id][self.data.type].jump_id

		if jumpId and jumpId ~= 0 then
			self.jumpId = jumpId
		end
	end

	if self.data.jump_id and self.data.jump_id ~= 0 then
		self.jumpId = self.data.jump_id
	end

	if self.jumpId and self.jumpId ~= 0 then
		self.btnGo:setVisible(self.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH)
	else
		self.btnGo:setVisible(false)
	end

	if self.data.action_desc then
		self.txtRuleTitle:setText(self.data.action_desc)
	end

	self.textRule:setText(self.data.desc_name)
	self.textNumNow:setVisible(not self.isRank)
	self.textNumTarget:setVisible(not self.isRank)
	self.slider:setVisible(not self.isRank)
	self.txt:setVisible(not self.isRank)

	local awardId

	if self.isRank then
		awardId = self.data.awardID
	else
		awardId = self.data.award

		self.textNumTarget:setText(self:calcNum(self.data.param))

		local nowProgress = math.min(self.data.nowProgress or 0, self.data.param)

		self.textNumNow:setText(self:calcNum(nowProgress))

		local rate = nowProgress / self.data.param

		self.slider:setValue(rate)
	end

	local num = 0

	if awardId and ResRandClient[awardId] then
		for i, id in ipairs(ResRandClient[awardId].show_ids) do
			if not self.cells[i] then
				self.cells[i] = UIControls.getGridAwardContainer(self, "TaskDayListCell/GridItemPanel")
			end

			self.cells[i]:setVisible(true)

			local fakeItem = BaseObject.GetObject(id, ResRandClient[awardId].show_nums[i])

			self.cells[i]:setObj(fakeItem)
		end

		num = #ResRandClient[awardId].show_ids
	end

	for i = num + 1, #self.cells do
		self.cells[i]:setVisible(false)
	end

	self.iconNewOpen:setVisible(self:checkCellNewOpen())
	self:setTimeShow()
end

function SeasonPlayListCell:checkCellNewOpen(...)
	if self.mParent.type == Const.SEASON_TASK_TYPE_WEEK or self.mParent.type == Const.SEASON_TASK_TYPE_CHALLENGE then
		if not self.mParent.visMap[self.data.detail_id] then
			return true
		else
			local endTime = self.mParent.visMap[self.data.detail_id]
			local actObj = CurAvatar:getActivityObj(self.data.detail_id)

			if actObj and actObj:isOpen() and actObj.endTime and type(endTime) == "number" and endTime < actObj.endTime then
				return true
			end
		end
	end

	return false
end

function SeasonPlayListCell:calcNum(num)
	if not num then
		return
	end

	if num > 10000000 then
		num = math.floor(num / 1000000)

		return num .. "M"
	end

	if num > 10000 then
		num = math.floor(num / 1000)

		return num .. "k"
	end

	return num
end

function SeasonPlayListCell:setTimeShow()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if self.mParent.type == Const.SEASON_TASK_TYPE_CHALLENGE or self.mParent.type == Const.SEASON_TASK_TYPE_OPACT then
		local remainTime = self:getRemainTime()

		if remainTime and remainTime > 0 then
			self.timeTips:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, Lang.get(48654), Slot(self.onTimeOut, self))
		else
			self.timeTips:setVisible(false)
		end
	else
		self.timeTips:setVisible(false)
	end
end

function SeasonPlayListCell:onTimeOut()
	self.timeTips:setVisible(false)
end

function SeasonPlayListCell:getRemainTime()
	if self.data.isRank then
		if self.data.relate_act_id and self.data.relate_act_id ~= 0 then
			local actObj = CurAvatar:getActivityObj(self.data.relate_act_id)

			if actObj and actObj:isOpen() then
				return actObj:getRemainOpenTime()
			end
		elseif RegionUtils.isJP() then
			return ClientUtils.getServerTimeNextWday(7) - ClientUtils.getServerTime()
		else
			return ClientUtils.getServerTimeNextWday(5) - ClientUtils.getServerTime()
		end
	else
		local actObj = CurAvatar:getActivityObj(self.data.detail_id)

		if actObj and actObj:isOpen() then
			return actObj:getRemainOpenTime()
		end
	end

	return 0
end

function SeasonPlayListCell:onBtnGoClick()
	if self.jumpId and JumpGuideManager.checkCanJump(self.jumpId, true) then
		JumpGuideManager.jump(self.jumpId)
		self.mParent:setVisible(false)
	end
end

function SeasonPlayListCell:onBtnConfirmClick()
	if self.state == Const.ACT_ACHIEVE_STATE_ENOUGH and CurAvatar.activityObjs[self.data.detail_id] then
		local actId = CurAvatar.activityObjs[self.data.detail_id].opId

		RPC.opActGetAward(actId, self.data.index, self.data.type)
	end
end

local SeasonPlayListDlg = Class("SeasonPlayListDlg", UIControls.Window)

function SeasonPlayListDlg:ctor()
	self:initUI()
end

function SeasonPlayListDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.scrollList = UIControls.ScrollViewLoopV(self, "BgPanel/AwardList")

	self.scrollList:addEventCellChanged(self.onListChanged)

	self.cells = {}
	self.txtTime = UIControls.Label(self, "BgPanel/TxtTime")
	self.bgBadge = UIControls.Image(self, "BgPanel/BgTitle/BgBadge")
	self.txtTitle01 = UIControls.Label(self, "BgPanel/BgTitle/TxtTitle01")
	self.txtTitle02 = UIControls.Label(self, "BgPanel/BgTitle/TxtTitle02")
end

function SeasonPlayListDlg:setType(type)
	self.type = type or self.type
	self.data = CurAvatar:getSeasonPlaySubDataByType(self.type)

	if self.data then
		self:setData(self.data)
	end

	self.visMap = {}

	local userData = CurAvatar:getClientUserData(Const.USER_KEY_SEASON_PLAY_NEW_OPEN)

	if userData then
		local actObj = CurAvatar:getSeasonPlayActivity()
		local actId = actObj and actObj.actId or 0

		if userData.actId == actId and userData[self.type] then
			for id, k in pairs(userData[self.type]) do
				self.visMap[id] = k
			end
		end
	end

	if type then
		CurAvatar:saveSeasonPlaySawTasksByType(type)
	end

	self.resData = CurAvatar:getSeaSonPlayEntranceResDataByType(self.type)

	if self.resData then
		self.txtTitle01:setText(self.resData.desc)
		self.txtTitle02:setText(self.resData.desc)

		if self.resData.list_icon_path then
			self.bgBadge:setImage(self.resData.list_icon_path, self.resData.list_icon_name)
		end
	end

	self:setTimeShow()
	self:registerGetAwardCallBack()
end

function SeasonPlayListDlg:onTimeOut()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
end

function SeasonPlayListDlg:setTimeShow(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	if self.type == Const.SEASON_TASK_TYPE_WEEK then
		self.txtTime:setVisible(true)

		local remainTime = ClientUtils.getServerTimeNextWday(5) - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, Lang.get(48670), Slot(self.onTimeOut, self))
	elseif self.type == Const.SEASON_TASK_TYPE_CHALLENGE or self.type == Const.SEASON_TASK_TYPE_OPACT then
		self.txtTime:setVisible(false)
	end
end

function SeasonPlayListDlg:getRelateActRemainTime(...)
	for index, data in ipairs(self.data or {}) do
		if not data.isRank then
			local actObj = CurAvatar:getActivityObj(data.detail_id)

			if actObj then
				local remainTime = actObj:getRemainOpenTime()

				if remainTime and remainTime > 0 then
					return remainTime
				end
			end
		end
	end

	if self.resData and self.resData.relate_act_id then
		local actObj = CurAvatar:getActivityObj(self.resData.relate_act_id)

		if actObj and actObj:isOpen() then
			return actObj:getRemainOpenTime()
		end
	end
end

function SeasonPlayListDlg:setData(data)
	table.sort(self.data, function(a, b)
		if a.state == b.state then
			if a.show_priority and b.show_priority then
				return a.show_priority < b.show_priority
			end
		elseif a.state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			return true
		else
			if a.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
				return b.state == Const.ACT_ACHIEVE_STATE_GOT
			end

			return false
		end
	end)
	self.scrollList:setTotalCount(#self.data)
end

function SeasonPlayListDlg:onListChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = SeasonPlayListCell(sender, "System/SeasonPlay/SeasonPlayListCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	if self.data and self.data[newIdx] then
		self.cells[newIdx]:setData(self.data[newIdx])
	end
end

function SeasonPlayListDlg:registerGetAwardCallBack()
	for k, data in pairs(self.data or {}) do
		local actId = data.detail_id
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj:isOpen() then
			CurAvatar:setCacheActivityBonus(actObj.opId, Slot(self.onGetAward, self))
		end
	end
end

function SeasonPlayListDlg:onGetAward(datas)
	if self and self:getVisible() and datas and datas[3] then
		local id = datas[3][1].id

		if id then
			FlyIconUtils.setFlyUItoUI(self.scrollList, self.endFlyObj, datas[3][1].id, datas[3][1].num, nil)
		end
	end
end

function SeasonPlayListDlg:setEndFlyObj(obj)
	self.endFlyObj = obj
end

function SeasonPlayListDlg:onBtnCloseClick()
	self:setVisible(false)
end

function SeasonPlayListDlg:onClose()
	SeasonPlayListDlg.super.onClose(self)

	local seasonPlayMainDlg = UIManager.tryGetUI("seasonPlayMainDlg")

	if seasonPlayMainDlg and seasonPlayMainDlg:getVisible() then
		seasonPlayMainDlg:refreshData()
	end
end

return SeasonPlayListDlg

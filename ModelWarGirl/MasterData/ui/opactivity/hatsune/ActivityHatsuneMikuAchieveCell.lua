-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Hatsune\\ActivityHatsuneMikuAchieveCell.lua

local ActivityHatsuneMikuAchieveCell = Class("ActivityHatsuneMikuAchieveCell", UIControls.Child)

function ActivityHatsuneMikuAchieveCell:ctor()
	self.titleTxt = UIControls.Label(self, "TitleText")
	self.awardItem = UIControls
	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirm)

	self.redDot = UIControls.Image(self, "BtnConfirm/IconNew")
	self.residueNum = UIControls.Label(self, "BtnConfirm/ResidueNum")
	self.refreshTime = UIControls.Label(self, "RefreshTime")
	self.slider = UIControls.Slider(self, "Slider", "TextNum")
	self.grids = {}
	self.heartbeatTime = 2
end

function ActivityHatsuneMikuAchieveCell:setData(cellData)
	self.achieveType = cellData.achieveType
	self.achieveIndex = cellData.achieveIndex
	self.actData = cellData.actData
	self.achieveData = self.actData:getAchieveOneData(self.achieveType, self.achieveIndex)
	self.awardId = self.achieveData.award
	self.desc = self.achieveData.desc_name

	self:refreshData()
end

function ActivityHatsuneMikuAchieveCell:refreshData()
	self.titleTxt:setText(self.desc)

	local progress = self.actData:getAchieveProgress(self.achieveType)
	local param = self.actData:getAchieveParam(self.achieveType, self.achieveIndex)
	local rate = 0

	rate = param <= progress and 1 or progress / param

	self.slider:setValue(rate)

	local selCount = 0
	local maxRound

	selCount, maxRound = self.actData:getSelectCount(self.achieveType, self.achieveIndex)

	if self.achieveType == Const.ACT_ACHIEVE_TYPE_RECHARGE then
		progress = progress / 100
		param = param / 100
	end

	progress = math.min(param * maxRound, progress)

	self.slider:setText(progress .. "/" .. param)

	local state = self.actData:getAchieveState(self.achieveType, self.achieveIndex)
	local selectable = state == Const.ACT_ACHIEVE_STATE_ENOUGH

	self.btnConfirm:setEnable(selectable)
	self.redDot:setVisible(selectable)

	local tip = Lang.get(114)

	if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		tip = Lang.get(32787)

		if selCount > 1 then
			tip = utils.format(Lang.get(32786), tip, selCount)
		end
	elseif state == Const.ACT_ACHIEVE_STATE_GOT then
		tip = Lang.get(74)
	end

	self.residueNum:setText(tip)

	for key, grid in ipairs(self.grids) do
		grid:destroy()
	end

	self.grids = {}

	ClientUtils.CreateBonusGrid(self, self.grids, "AwardItemNode", self.awardId, true, nil, true)

	local nextResetTime = self.actData:getNextResetTime(self.achieveType)

	if nextResetTime and nextResetTime ~= 0 and state == Const.ACT_ACHIEVE_STATE_GOT and self.actData.miscData and self.actData.miscData.refresh_time > 0 then
		self.refreshTime:setVisible(true)
		self.btnConfirm:setVisible(false)

		local curTime = ClientUtils.getServerTime()

		if curTime <= nextResetTime then
			local countTime = nextResetTime - curTime

			ClientTimerManager.AddSecondFormatTickUI(self.refreshTime, countTime, false, Lang.get(48670), Slot(self.resetTimeOver, self))
		else
			self:resetTimeOver()
		end
	else
		self.refreshTime:setVisible(false)
		self.btnConfirm:setVisible(true)
	end
end

function ActivityHatsuneMikuAchieveCell:resetTimeOver()
	self.actData:resetDaily(self.achieveType)
	self:refreshData()
end

function ActivityHatsuneMikuAchieveCell:onBtnConfirm()
	local nextResetTime = self.actData:getNextResetTime(self.achieveType)
	local curTime = ClientUtils.getServerTime()

	if nextResetTime and nextResetTime ~= 0 and nextResetTime <= curTime then
		self:resetTimeOver()
		MsgManager.clientNotice(407)

		return nil
	end

	local opId = self.actData.actObject.opId

	CurAvatar:activityRPC(Functor(RPC.opActGetAward, opId, self.achieveIndex, self.achieveType), opId)
end

return ActivityHatsuneMikuAchieveCell

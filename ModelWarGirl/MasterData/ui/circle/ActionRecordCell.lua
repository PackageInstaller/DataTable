-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\ActionRecordCell.lua

local strClassName = "ActionRecordCell"
local ActionRecordCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function ActionRecordCell:ctor()
	self:initUI()
end

function ActionRecordCell:initUI()
	self.imgSelf = UIControls.Image(self, "")
	self.imgIconType = UIControls.Image(self, "IconType")
	self.txtTime = UIControls.Label(self, "TextTime")
	self.txtName = UIControls.Label(self, "TextName")
	self.txtAction = UIControls.Label(self, "TextAction")
	self.txtJob = UIControls.Label(self, "TextJob")
	self.imgIconJob = UIControls.Image(self, "IconJob")
end

function ActionRecordCell:setActionRecordData(actionRecordData)
	self.actionRecordData = actionRecordData

	local playerName, svrName = utils.GetPlayerName(self.actionRecordData.name)

	self.txtName:setText(playerName)

	local timeStr = os.date("%m-%d %H:%M:%S", self.actionRecordData.tick)

	self.txtTime:setText(timeStr)

	if self.actionRecordData.type == Const.CIRCLE_ACTION_RECORD_TYPE.SEARCH or self.actionRecordData.type == Const.CIRCLE_ACTION_RECORD_TYPE.SKILL then
		self.imgSelf:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgSearch")
		self.imgIconType:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "IconSearch")
	else
		self.imgSelf:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "BgBattle")
		self.imgIconType:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas3", "IconBattle")
	end

	local actionStr = CurAvatar:getActionLogStr(self.actionRecordData.type, self.actionRecordData.param1, self.actionRecordData.param2)

	self.txtAction:setText(actionStr)

	local memberDuty = self.actionRecordData.duty

	if memberDuty ~= Const.CIRCLE_DUTY_MEMBER then
		self.imgIconJob:setVisible(true)
		self.txtJob:setVisible(true)
		self.txtJob:setText(CurAvatar:getDutyName(memberDuty))

		local dutyImgPath = CurAvatar:getDutySpritePath(memberDuty)

		if dutyImgPath then
			self.imgIconJob:setImage(dutyImgPath[1], dutyImgPath[2])
		end
	else
		self.imgIconJob:setVisible(false)
		self.txtJob:setVisible(false)
	end
end

return ActionRecordCell

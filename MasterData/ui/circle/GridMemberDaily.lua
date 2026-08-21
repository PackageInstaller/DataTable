-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\GridMemberDaily.lua

local ResClanLog = require("ClientData/ResClanLog")
local strClassName = "GridMemberDaily"
local GridMemberDaily = Class(strClassName, UIControls.ScrollViewLoopCell)

function GridMemberDaily:ctor()
	self:initUI()
end

function GridMemberDaily:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgIconSex = UIControls.Image(self, "IconSex")
	self.txtName = UIControls.Label(self, "TextName")
	self.txtDaily = UIControls.Label(self, "TextDaily")
	self.txtTime = UIControls.Label(self, "TextTime")
	self.txtLv = UIControls.Label(self, "TextLV")
end

function GridMemberDaily:onBtnSelfClick()
	CurAvatar:showPlayerTips(self.logData.base.uid, self)
end

function GridMemberDaily:setDailyData(logData)
	self.logData = logData

	self.txtTime:setText(utils.getDeadlineStr(self.logData.tick))

	if not self.gridPlayer then
		self.gridPlayer = UIControls.PlayerHeadGridChild(self, "GridPlayerCommon", "System/Common/Grid/GridPlayerCommon", 0, 0, true)

		self.gridPlayer:hideLevel()
	end

	self.gridPlayer:setCommInfo(self.logData.base, false, self)

	self.name, self.serverName = utils.GetPlayerName(self.logData.base.name)

	self.txtName:setText(self.name)
	self.txtLv:setText(string.format(Lang.get(30171), self.logData.base.level))

	if self.logData.base.gender == Const.GENDER_MAN then
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.imgIconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.txtDaily:setText(ResClanLog[self.logData.id].content)
end

return GridMemberDaily

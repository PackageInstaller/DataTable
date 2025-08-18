-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\Task\\ActivityCatRaceFriendTaskCell.lua

local ResOpActivityCatRaceTask = require("ClientData/ResOpActivityCatRaceTask")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local strClassName = "ActivityCatRaceFriendTaskCell"
local ActivityCatRaceFriendTaskCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function ActivityCatRaceFriendTaskCell:ctor()
	self:initUI()
end

function ActivityCatRaceFriendTaskCell:initUI()
	self.friendNameTxt = UIControls.Label(self, "FriendTaskPanel/TextFriendName")
	self.friendHeadImg = UIControls.Image(self, "FriendTaskPanel/BgFriend/ImgPortrait")
	self.friendTaskDescTxt = UIControls.Label(self, "FriendTaskPanel/TextTask")
	self.friendTaskAchieveDescTxt = UIControls.Label(self, "FriendTaskPanel/BgConsume/TextConsume")
	self.friendTaskTitleTxt = UIControls.Label(self, "FriendTaskPanel/BgConsume/TextTitle")
	self.completeStateTxt = UIControls.Label(self, "TextState")
	self.compImage = UIControls.Image(self, "ImgComp")
	self.getBtn = UIControls.Button(self, "BtnGet", "Text")

	self.getBtn:addEventClick(self._onBtnGet)

	self.getImg = UIControls.Image(self, "BtnGet")
end

function ActivityCatRaceFriendTaskCell:setData(data, mainActID)
	self.mainActID = mainActID
	self.mainActObj = CurAvatar:getActivityObj(self.mainActID)

	if self.mainActObj then
		self.mainActData = self.mainActObj.actData
		self.mainOpID = self.mainActObj.opId
		self.friendData = data

		self:refreshData()
	end
end

function ActivityCatRaceFriendTaskCell:refreshData()
	self.friendNameTxt:setText(self.friendData.name)
	HeadHelper.setHeadIcon(self.friendHeadImg, self.friendData.head, self.friendData.uid)

	if self.friendData.opActSimpleItem and self.friendData.opActSimpleItem.specdata and self.friendData.opActSimpleItem.specdata.cat_race then
		self.taskID = self.friendData.opActSimpleItem.specdata.cat_race.sel_task_id
		self.achieveData = self.mainActData:getTaskDetailFromID(self.taskID)
		self.taskDetail = ResOpActivityCatRaceTask[self.mainActID][self.taskID]

		if self.taskDetail and self.achieveData then
			self.friendTaskDescTxt:setText(self.taskDetail.desc)
			self.friendTaskAchieveDescTxt:setText(self.achieveData.desc_name)
			self.friendTaskTitleTxt:setText(self.taskDetail.title)
			self.friendTaskDescTxt:setVisible(true)
		end
	end

	if self.mainActData:checkIsFinishFriendTask(self.friendData.uid) then
		self.getBtn:setVisible(false)
		self.completeStateTxt:setVisible(true)
		self.friendTaskTitleTxt:setVisible(false)
		self.friendTaskAchieveDescTxt:setVisible(false)
	elseif self.mainActData:checkIsProcessFriendTask(self.friendData.uid) then
		self.getBtn:setVisible(true)
		self.getBtn:setText(Lang.get(693))
		self.getBtn:setEnable(false)
		self.completeStateTxt:setVisible(false)
		self.friendTaskTitleTxt:setVisible(false)
		self.friendTaskAchieveDescTxt:setVisible(false)
	else
		self.getBtn:setText(Lang.get(52410))
		self.getBtn:setVisible(true)

		if not self.mParent:checkCanSelectFriendTask() then
			self.getBtn:setEnable(false)
		else
			self.getBtn:setEnable(true)
		end

		self.completeStateTxt:setVisible(false)
		self.friendTaskTitleTxt:setVisible(true)
		self.friendTaskAchieveDescTxt:setVisible(true)
	end

	if self.mainActData:checkFriendIsComp(self.friendData.uid) then
		self.compImage:setVisible(true)
	else
		self.compImage:setVisible(false)
	end
end

function ActivityCatRaceFriendTaskCell:_onBtnGet()
	CurAvatar:activityRPC(Functor(RPC.opActCatRaceSelectFriendTask, self.mainOpID, self.friendData.uid), self.mainOpID)
	self.mParent:onBtnMyTask()

	self.mainActData.lastFriendTaskGetRecord = ClientUtils.getServerTime()
end

return ActivityCatRaceFriendTaskCell

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\ApprenticePanel.lua

local ResMasterMisc = require("ClientData/ResMasterMisc")
local ResMasterLevel = require("ClientData/ResMasterLevel")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local ResClientNotice = require("ClientData/ResClientNotice")
local ConditionCell = Class("AppriencelCell_ConditionCell", UIControls.Panel)

function ConditionCell:ctor()
	self.txtProgress = UIControls.Label(self, self.mPath .. "/TextProgress")
	self.slider = UIControls.Slider(self, self.mPath .. "/Slider")
	self.txtSlider = UIControls.Label(self, self.mPath .. "/TextNum")
end

function ConditionCell:setData(conditionId, otherPlayer)
	self.conditionId = conditionId
	self.otherPlayer = otherPlayer

	local config = ResConditionLimit[conditionId]
	local ratio = 0

	if config.unlock_stage then
		local curData = CurAvatar:getMainStageInfo(self.otherPlayer.stageInfo[1], self.otherPlayer.stageInfo[2], self.otherPlayer.stageInfo[3])

		if curData then
			local strLevel = ClientUtils.getMainStageLevelStr(curData.season, curData.chapter, curData.level)

			self.txtProgress:setText(strLevel)

			local goalData = CurAvatar:getMainStageInfo(config.unlock_stage[1], config.unlock_stage[2], config.unlock_stage[3])

			ratio = curData.idx / goalData.idx
		end
	elseif config.unlock_crystal_level then
		local curLv = self.otherPlayer.crystalLv

		self.txtProgress:setText(string.format(Lang.get(30171), curLv))

		ratio = curLv / config.unlock_crystal_level
	end

	ratio = math.min(ratio, 1)

	self.slider:setValue(ratio)
	self.txtSlider:setText(math.floor(ratio * 100) .. "%")
end

local ApprenticeCell = Class("ApprenticePanel_AppriencelCell", UIControls.ScrollViewLoopCell)

function ApprenticeCell:ctor()
	self.apprenticePart = UIControls.Panel(self, "StudentPanel")
	self.headCell = UIControls.PlayerHeadGridChild(self, "StudentPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtName = UIControls.Label(self, "StudentPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "StudentPanel/TextPlayerName/IconSex")
	self.txtServer = UIControls.Label(self, "StudentPanel/TextServer")
	self.imgServer = UIControls.Image(self, "StudentPanel/TextServer/IconServer")
	self.txtTime = UIControls.Label(self, "StudentPanel/TextTime")
	self.btnChat = UIControls.Button(self, "StudentPanel/BtnChat")

	self.btnChat:addEventClick(self.onClickBtnChat)

	self.btnGuide = UIControls.Button(self, "StudentPanel/BtnGuide")

	self.btnGuide:addEventClick(self.onClickBtnGuide)

	self.imgRedGuide = UIControls.Image(self, "StudentPanel/BtnGuide/IconNew")
	self.conditionCellList = {}

	for i = 1, 2 do
		local cell = ConditionCell(self, "StudentPanel/ProgressPanel" .. i)

		table.insert(self.conditionCellList, cell)
	end

	self.unlockPart = UIControls.Panel(self, "UnlockPanel")
	self.lockPart = UIControls.Panel(self, "LockPanel")
	self.txtLock = UIControls.Label(self, "LockPanel/Text")
	self.btnBattleGuide = UIControls.Button(self, "StudentPanel/ProgressPanel1/BtnRequest")

	self.btnBattleGuide:addEventClick(self.onClickBtnBattleGuide)
end

function ApprenticeCell:setData(unlock, data, idx)
	self.lockPart:setVisible(not unlock)
	self.unlockPart:setVisible(unlock and data == nil)
	self.apprenticePart:setVisible(unlock and data ~= nil)

	if not unlock then
		local unlockLv = 0

		for _, config in ipairs(ResMasterLevel) do
			if idx <= config.apprentice_num then
				unlockLv = config.level

				break
			end
		end

		self.txtLock:setText(string.format(ResClientNotice[797].notice, unlockLv))

		return
	end

	if unlock and data == nil then
		return
	end

	self.otherPlayer = data
	self.uid = self.otherPlayer.uid

	self.headCell:setPlayer(self.otherPlayer, true, self)
	self.txtName:setText(self.otherPlayer.name)

	if self.otherPlayer.gender == Const.GENDER_MAN then
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.txtServer:setText(self.otherPlayer.serverName or "")

	if self.otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	if self.otherPlayer.online then
		self.headCell:setObjGray(false)
		self.txtTime:setText(Lang.get(841))
	else
		self.headCell:setObjGray(true)
		self.txtTime:setText(ClientUtils.strServerTimePassed(self.otherPlayer.logout_tick))
	end

	local conditionList = ResMasterMisc[1].graduate_condition

	for i = 1, #self.conditionCellList do
		local cell = self.conditionCellList[i]
		local checkData = i <= #conditionList

		cell:setVisible(checkData)

		if checkData then
			cell:setData(conditionList[i], self.otherPlayer)
		end
	end

	local idx = utils.getIndexByValue(CurAvatar.apprenticeRequestDevelopGuideList, self.uid)

	self.imgRedGuide:setVisible(idx > 0)

	local reqStage = CurAvatar.apprenticeRequestBattleGuideDic[self.uid] or 0
	local curStage = self.otherPlayer.stageInfo[1] * 10000 + self.otherPlayer.stageInfo[2] * 100 + self.otherPlayer.stageInfo[3]

	self.btnBattleGuide:setVisible(curStage < reqStage)
end

function ApprenticeCell:onClickBtnChat()
	UIManager.getUI("chatDlg", true):addFriendTalk(self.otherPlayer)
end

function ApprenticeCell:onClickBtnGuide()
	CurAvatar:guideApprentice(self.otherPlayer.uid)
end

function ApprenticeCell:onClickBtnBattleGuide()
	CurAvatar:guideApprentice(self.otherPlayer.uid, CurAvatar.apprenticeRequestBattleGuideDic[self.uid])
end

local ApprenticePanel = Class("ApprenticePanel", UIControls.Child)

function ApprenticePanel:ctor()
	self.scrollApprentice = UIControls.ScrollViewLoopV(self, "BgPanel/StudentList")

	self.scrollApprentice:addEventCellChanged(self.onScrollAppreticeChange)

	self.txtTip = UIControls.Label(self, "BgPanel/TipsPanel/Text")
end

function ApprenticePanel:onShow()
	self:refreshShow()
	self.txtTip:setText(ResClientNotice[782].notice)
end

function ApprenticePanel:refreshShow()
	self.uidList = CurAvatar.apprenticeUidList or {}
	self.curMaxNum = CurAvatar:getCurMaxApprenticeNum()
	self.maxApprenticeNum = ResMasterLevel[#ResMasterLevel].apprentice_num

	self.scrollApprentice:setTotalCount(self.maxApprenticeNum)
end

function ApprenticePanel:onScrollAppreticeChange(sender, cell, idx)
	if not cell then
		cell = ApprenticeCell(sender, "System/HandBook/RankSelectTeacherManageCell", idx)
	else
		cell.mIndex = idx
	end

	if idx <= self.curMaxNum then
		local uid = self.uidList[idx]
		local data = CurAvatar.apprenticeDic[uid]

		cell:setData(true, data)
	else
		cell:setData(false, nil, idx)
	end
end

function ApprenticePanel:onMasterExperienceNotify()
	self:refreshShow()
end

return ApprenticePanel

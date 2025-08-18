-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattlePointAwardDlg.lua

local PointAwardPanel = require("UI/Circle/PointAwardPanel")
local CircleAchievePanel = require("UI/Circle/CircleAchievePanel")
local strClassName = "CircleBattlePointAwardDlg"
local CircleBattlePointAwardDlg = Class(strClassName, UIControls.Window)
local TAB_POINT_AWARD = 1
local TAB_MEMBER_ACHIEVE = 2
local TAB_CIRCLE_ACHIEVE = 3

function CircleBattlePointAwardDlg:ctor()
	self:initUI()
end

function CircleBattlePointAwardDlg:initUI()
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTabList = {}
	self.imgPointNew = UIControls.Panel(self, "Bg/TabPanel/Btn1/IconNew")
	self.imgMemberAchieveNew = UIControls.Panel(self, "Bg/TabPanel/Btn2/IconNew")
	self.imgCircleAchieveNew = UIControls.Panel(self, "Bg/TabPanel/Btn3/IconNew")

	for i = 1, 3 do
		local btnTab = UIControls.Button(self, "Bg/TabPanel/Btn" .. i)

		btnTab:addEventClick(self.onBtnTabClick)

		self.btnTabList[i] = btnTab
	end

	self.panelPointAward = PointAwardPanel(self, "Bg/PointAwardPanel")
	self.panelCircleAchieve = CircleAchievePanel(self, "Bg/PointGetPanel")
	self.panelList = {
		self.panelPointAward,
		self.panelCircleAchieve
	}

	self:onBtnTabClick(self.btnTabList[1])

	self.txtTitle = UIControls.Label(self, "Bg/PointAwardPanel/PointInfoPanel/AwardPanel/TextTitle")

	self:refreshTime()
	self:refreshTabHint()
end

function CircleBattlePointAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CircleBattlePointAwardDlg:refreshPanel()
	if CurAvatar.myCircle then
		for _, panel in pairs(self.panelList) do
			if panel:getVisible() then
				panel:refreshPanelData(true)
			end
		end
	end

	self:refreshTabHint()
end

function CircleBattlePointAwardDlg:playInfuseAniShow(infuse_id)
	self.panelPointAward:playInfuseAniShow(infuse_id)
end

function CircleBattlePointAwardDlg:playAchieveGetAniShow(achieveId)
	self.panelCircleAchieve:playAchieveGetAniShow(achieveId)
end

function CircleBattlePointAwardDlg:refreshTabHint()
	self.imgPointNew:setVisible(CurAvatar:checkCanScoreInfuse())
	self.imgMemberAchieveNew:setVisible(CurAvatar:checkMemberAchieveComplete())
	self.imgCircleAchieveNew:setVisible(CurAvatar:checkCircleAchieveComplete())
end

function CircleBattlePointAwardDlg:refreshTime(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtTitle)

	local leftTime = 0
	local actObj = CurAvatar:getCircleBattleActivity()

	if actObj then
		leftTime = actObj.actData:getLeftTimeToEnd()
	end

	if leftTime > 0 then
		ClientTimerManager.AddSecondFormatTickUI(self.txtTitle, leftTime, nil, Lang.get(48658), nil, nil)
	end
end

function CircleBattlePointAwardDlg:onBtnTabClick(sender)
	for idx, btn in ipairs(self.btnTabList) do
		if btn == sender then
			if idx == TAB_POINT_AWARD then
				self.panelPointAward:setVisible(true)
				self.panelCircleAchieve:setVisible(false)

				if CurAvatar.myCircle then
					self.panelPointAward:refreshPanelData()
				end
			elseif idx == TAB_CIRCLE_ACHIEVE or idx == TAB_MEMBER_ACHIEVE then
				self.panelPointAward:setVisible(false)
				self.panelCircleAchieve:setVisible(true)

				if CurAvatar.myCircle then
					local achieveType = idx == TAB_CIRCLE_ACHIEVE and Const.CIRCLE_ACHIEVE_TYPE.CIRCLE or Const.CIRCLE_ACHIEVE_TYPE.MEMBER

					self.panelCircleAchieve:setAchieveType(achieveType)
					self.panelCircleAchieve:refreshPanelData()
				end
			end
		end

		btn:setEnable(btn ~= sender)
	end
end

return CircleBattlePointAwardDlg

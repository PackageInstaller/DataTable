-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomListDlg.lua

local HeroShowRoomInfoPanel = require("UI/Hero/HeroShowRoomInfoPanel")
local DragTwoPages = require("UI/Control/DragTwoPages")
local UserData = require("Helper/UserData")
local strClassName = "HeroShowRoomListDlg"
local HeroShowRoomListDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomListDlg:ctor()
	self:initUI()
end

function HeroShowRoomListDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")
	self.dragPages = DragTwoPages(self, "MainInfoPanel/ContentPanel1", "MainInfoPanel/ContentPanel2", "BtnPre", "BtnNext", nil, nil, true)
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.pages = {}

	local pagePrefabPath = "System/HeroShowRoom/HeroShowRoomInfoPanel"

	for i = 1, 2 do
		self.pages[i] = HeroShowRoomInfoPanel(self, "MainInfoPanel/ContentPanel" .. i, pagePrefabPath, 0, 0, true)
	end

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnLine = UIControls.Button(self, "BtnLine")

	self.btnLine:addEventClick(self.onBtnLineClick)

	self.btnLineImg = UIControls.Image(self, "BtnLine/Img")
end

function HeroShowRoomListDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RELATION_ROOM)
end

function HeroShowRoomListDlg:onBtnCloseClick()
	self:setVisible(false)
end

local PAGE_TRANS_ANIMATION_DIC = {
	{
		[2] = "ShowRoomListCutover01",
		[6] = "ShowRoomListCutover07"
	},
	{
		[3] = "ShowRoomListCutover02",
		[1] = "ShowRoomListCutover12"
	},
	{
		[4] = "ShowRoomListCutover03",
		[2] = "ShowRoomListCutover11"
	},
	{
		[3] = "ShowRoomListCutover10",
		[5] = "ShowRoomListCutover04"
	},
	{
		[6] = "ShowRoomListCutover05",
		[4] = "ShowRoomListCutover09"
	},
	{
		[1] = "ShowRoomListCutover06",
		[5] = "ShowRoomListCutover08"
	}
}

function HeroShowRoomListDlg:setRoomHeroList(roomHeroListDic, teamId)
	self.roomHeroListDic = roomHeroListDic
	self.idx = Const.TEAM_PAGEIDX_DIC[teamId]

	self.uiAni:startAni("HeroShowRoomListCanvas0" .. teamId, true)

	self.showLine = UserData.loadCommonData("RoomLineShow" .. CurAvatar.uid)

	if self.showLine == nil or self.showLine == "" then
		self.showLine = "true"

		UserData.saveCommonData("RoomLineShow" .. CurAvatar.uid, self.showLine)
	end

	self.dragPages:initPage(6, self.idx)
end

function HeroShowRoomListDlg:refreshForHeroInfo()
	self.roomHeroListDic = CurAvatar:getRoomHeroListDic()

	if self.curPage then
		self.curPage:setRoomHeros(self.roomHeroListDic[Const.PAGEIDX_TEAM_DIC[self.currentPageIndex]])
	end
end

function HeroShowRoomListDlg:onDragEvent(sender, currentPageIndex, panelIndex)
	if self.curPage then
		self.curPage:revertOriShowStatus()
	end

	if self.currentPageIndex then
		if CurAvatar.hintNewTeamIdDic and CurAvatar.hintNewTeamIdDic[Const.PAGEIDX_TEAM_DIC[self.currentPageIndex]] == 1 then
			CurAvatar:clearRelationNewTeamHint(Const.PAGEIDX_TEAM_DIC[self.currentPageIndex])
		end

		local animationName = PAGE_TRANS_ANIMATION_DIC[self.currentPageIndex][currentPageIndex]

		self.uiAni:startAni(animationName, true)
	end

	self:clearRelationTeamNewHint()

	self.currentPageIndex = currentPageIndex
	self.curPage = self.pages[panelIndex]

	self.curPage:setRoomHeros(self.roomHeroListDic[Const.PAGEIDX_TEAM_DIC[self.currentPageIndex]])

	if self.showLine == "true" then
		self.btnLineImg:playAnimator("BtnSwitchOn")

		for i = 1, 2 do
			self.pages[i]:showAndHideLine(true)
		end
	else
		self.btnLineImg:playAnimator("BtnSwitchOff")

		for i = 1, 2 do
			self.pages[i]:showAndHideLine(false)
		end
	end
end

function HeroShowRoomListDlg:clearRelationTeamNewHint()
	if self.currentPageIndex then
		if CurAvatar.relationTeamHintSvrData[Const.PAGEIDX_TEAM_DIC[self.currentPageIndex]] and CurAvatar.relationTeamHintSvrData[Const.PAGEIDX_TEAM_DIC[self.currentPageIndex]] == 1 then
			RPC.heroDevelopUpdateRedPoint(Const.RELATION_HINT_OPEN_TYPE_TEAM, Const.PAGEIDX_TEAM_DIC[self.currentPageIndex])
		elseif CurAvatar.hintNewTeamIdDic and CurAvatar.hintNewTeamIdDic[Const.PAGEIDX_TEAM_DIC[self.currentPageIndex]] == 1 then
			CurAvatar:clearRelationNewTeamHint(Const.PAGEIDX_TEAM_DIC[self.currentPageIndex])
		end
	end
end

function HeroShowRoomListDlg:refreshHintShow()
	if self.curPage then
		self.curPage:refreshHintShow()
	end
end

function HeroShowRoomListDlg:onBtnLineClick()
	if self.showLine == "true" then
		self.btnLineImg:playAnimator("BtnSwitchOff")

		for i = 1, 2 do
			self.pages[i]:showAndHideLine(false)
		end

		self.showLine = "false"

		UserData.saveCommonData("RoomLineShow" .. CurAvatar.uid, self.showLine)
	else
		self.btnLineImg:playAnimator("BtnSwitchOn")

		for i = 1, 2 do
			self.pages[i]:showAndHideLine(true)
		end

		self.showLine = "true"

		UserData.saveCommonData("RoomLineShow" .. CurAvatar.uid, self.showLine)
	end
end

function HeroShowRoomListDlg:onClose()
	self:clearRelationTeamNewHint()
	HeroShowRoomListDlg.super.onClose(self)
end

return HeroShowRoomListDlg

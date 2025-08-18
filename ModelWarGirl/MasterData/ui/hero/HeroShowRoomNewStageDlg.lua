-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomNewStageDlg.lua

local GridHeroShowRoom = require("UI/Hero/GridHeroShowRoom")
local strClassName = "HeroShowRoomNewStagePanel"
local HeroShowRoomNewStagePanel = Class(strClassName, UIControls.Child)

function HeroShowRoomNewStagePanel:ctor()
	self:initUI()
end

function HeroShowRoomNewStagePanel:initUI()
	self.imgTextTeam = UIControls.Image(self, "TextTeam")
end

function HeroShowRoomNewStagePanel:setHeroList(teamId, heroList)
	for _, hero in ipairs(heroList) do
		local gridHero = GridHeroShowRoom(self, "HeroNewStagePanel", "System/HeroShowRoom/GridHeroShowRoom", 0, 0, true)

		gridHero:setHero(hero)
		gridHero.btnSelf:setEnable(false)
	end

	local txtTeamPath = UIConst.getLargeTeamIconPath(teamId)

	if txtTeamPath then
		self.imgTextTeam:setImage(txtTeamPath[1], txtTeamPath[2])
	end
end

local strClassName = "HeroShowRoomNewStageDlg"
local HeroShowRoomNewStageDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomNewStageDlg:ctor()
	self:initUI()
end

function HeroShowRoomNewStageDlg:initUI()
	self.txtTitle = UIControls.Label(self, "BgPanel/BgTitleBack/TextTitle")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventAnimateCue(self.playMainDlgEfx)
	self:initUIShow()
end

function HeroShowRoomNewStageDlg:playMainDlgEfx(aniCom, eventKey)
	if eventKey == "NewStageAfter" and CurAvatar.relationAutoOpenDlg and CurAvatar.relationAutoOpenDlg == 1 and self.heroListDic then
		local heroShowRoomMainDlg = UIManager.getUI("heroShowRoomMainDlg", nil, false)

		if heroShowRoomMainDlg then
			heroShowRoomMainDlg:playNewStageEfx(self.heroListDic)
		end
	end
end

function HeroShowRoomNewStageDlg:initUIShow()
	self.heroListDic = CurAvatar:getNewStageHeroListDic()

	for teamId, heroList in pairs(self.heroListDic) do
		local newStagePanel = HeroShowRoomNewStagePanel(self, "BgPanel/HeroNewStageList/Content", "System/HeroShowRoom/HeroShowRoomNewStagePanel", 0, 0, true)

		newStagePanel:setHeroList(teamId, heroList)
	end

	self.txtTitle:setText(ClientUtils.getClientNotice(626))
end

function HeroShowRoomNewStageDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroShowRoomNewStageDlg:onDestroy()
	if CurAvatar.relationAutoOpenDlg and CurAvatar.relationAutoOpenDlg == 1 then
		RPC.heroDevelopUpdateRedPoint(Const.RELATION_HINT_OPEN_TYPE_STAGE)
	end

	HeroShowRoomNewStageDlg.super.onDestroy(self)
end

return HeroShowRoomNewStageDlg

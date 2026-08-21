-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomMainDlg.lua

local strClassName = "HeroShowRoomMainDlg"
local HeroShowRoomMainDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomMainDlg:ctor()
	self:initUI()
end

function HeroShowRoomMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnIconNewList = {}
	self.btnRoomList = {}

	for i = 1, 6 do
		local btnRoom = UIControls.Button(self, "BgImage/BtnRoom" .. i)

		btnRoom:addEventClick(self.onBtnRoomClick)

		self.btnRoomList[i] = btnRoom

		local iconNewOpen = UIControls.Panel(self, "BgImage/BtnRoom" .. i .. "/IconNew1")
		local iconNewSweep = UIControls.Panel(self, "BgImage/BtnRoom" .. i .. "/IconNew2")

		self.btnIconNewList[i] = {
			new = iconNewOpen,
			sweep = iconNewSweep
		}
	end

	self.efxNewStageList = {}
	self.efxNewStage = UIControls.LazyEffectPlayer(self, "BgImage/EfxNewStage")

	for idx = 1, 6 do
		self.efxNewStageList[idx] = {}

		local efxStage = UIControls.LazyEffectPlayer(self, "BgImage/EfxNewStage" .. idx)

		self.efxNewStageList[idx][1] = efxStage

		local efxBrand = UIControls.LazyEffectPlayer(self, "BgImage/BtnRoom" .. idx .. "/EfxBrand")

		self.efxNewStageList[idx][2] = efxBrand
	end

	self.card1EfxPanelList = {}
	self.card2PanelList = {}

	for i = 1, 6 do
		local efxCom = UIControls.LazyEffectPlayer(self, "BgImage/CardCommonPanel/CardPanel1/Card" .. i .. "/EfxPanel")

		self.card1EfxPanelList[i] = efxCom

		local efxCom2 = UIControls.Panel(self, "BgImage/CardCommonPanel/CardPanel2/Card" .. i)

		self.card2PanelList[i] = efxCom2
	end

	self.btnNewStage = UIControls.Button(self, "MainInfoPanel/BtnNewStage")

	self.btnNewStage:addEventClick(self.onBtnNewStageClick)
	self.btnNewStage:setVisible(CurAvatar:haveNewHeroRelation())

	if CurAvatar.relationAutoOpenDlg and CurAvatar.relationAutoOpenDlg == 1 then
		self:onBtnNewStageClick()
	end

	self:refreshHintShow()

	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)
end

function HeroShowRoomMainDlg:refreshHintShow()
	for teamId, iconNews in ipairs(self.btnIconNewList) do
		iconNews.new:setVisible(false)
		iconNews.sweep:setVisible(false)

		if CurAvatar.hintNewTeamIdDic and CurAvatar.hintNewTeamIdDic[teamId] and CurAvatar.hintNewTeamIdDic[teamId] == 1 then
			iconNews.new:setVisible(true)
		elseif CurAvatar.hintRelationSweepTeamDic and CurAvatar.hintRelationSweepTeamDic[teamId] and CurAvatar.hintRelationSweepTeamDic[teamId] == 1 then
			iconNews.sweep:setVisible(true)
		end
	end
end

function HeroShowRoomMainDlg:onBtnNewStageClick()
	local heroShowRoomNewStageDlg = UIManager.getUI("heroShowRoomNewStageDlg", true)
end

function HeroShowRoomMainDlg:onBtnRoomClick(sender)
	for i, btnRoom in ipairs(self.btnRoomList) do
		if btnRoom == sender then
			local heroShowRoomListDlg = UIManager.getUI("heroShowRoomListDlg", true)

			heroShowRoomListDlg:setRoomHeroList(CurAvatar:getRoomHeroListDic(), i)

			break
		end
	end
end

function HeroShowRoomMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroShowRoomMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RELATION_MAIN)
end

function HeroShowRoomMainDlg:playNewStageEfx(heroListDic)
	self.activeTeamIdList = {}

	for page, team in ipairs(Const.PAGEIDX_TEAM_DIC) do
		if heroListDic[team] then
			table.insert(self.activeTeamIdList, team)
		end
	end

	if self.activeTeamIdList and #self.activeTeamIdList > 0 then
		self.efxNewStage:setVisible(true)

		local animation1 = "NewStageTeam" .. #self.activeTeamIdList

		for idx, team in ipairs(self.activeTeamIdList) do
			self.card1EfxPanelList[idx]:playEffectByPath("Effects/UI/efx_ui_HeroShowRoomMainCanvas_0" .. team .. "_002.prefab")
		end

		self.uiAni:startAni(animation1, true)
	end
end

function HeroShowRoomMainDlg:_onAniFinish(aniCom, aniName)
	if string.find(aniName, "NewStageTeam") then
		self.corYieldPlayCard2 = coroutine.start(self.yieldPlayCard2, self)
	end
end

function HeroShowRoomMainDlg:yieldPlayCard2()
	if self.activeTeamIdList and #self.activeTeamIdList > 0 then
		for idx, teamId in ipairs(self.activeTeamIdList) do
			if idx ~= 1 then
				coroutine.wait(0.2)
			end

			local efxComs = self.efxNewStageList[teamId]

			if efxComs then
				efxComs[1]:setVisible(true)
				efxComs[2]:setVisible(true)
			end

			self.card2PanelList[teamId]:setVisible(true)
		end
	end

	self.isPlayingEfx = false
end

function HeroShowRoomMainDlg:clearCoroutine()
	if self.corYieldPlayCard2 then
		coroutine.stop(self.corYieldPlayCard2)

		self.corYieldPlayCard2 = nil
	end
end

function HeroShowRoomMainDlg:onDestroy()
	self:clearCoroutine()
	HeroShowRoomMainDlg.super.onDestroy(self)
end

return HeroShowRoomMainDlg

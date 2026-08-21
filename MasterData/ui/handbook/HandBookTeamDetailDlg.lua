-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookTeamDetailDlg.lua

local ResHero = require("ClientData/ResHero")
local ResHeroMisc = require("ClientData/ResHeroMisc")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local TeamDetailCell = Class("TeamDetailCell", UIControls.Child)

function TeamDetailCell:ctor(...)
	self:initUI()
end

function TeamDetailCell:initUI(...)
	if UIControls.checkControlFunc(self, "VerPanel/TextVer") then
		self.txtVer = UIControls.Label(self, "VerPanel/TextVer")
	end

	self.aniLevelUp = UIControls.UIAni(self, "")
	self.inited = nil
	self.btns = {}
	self.initMap = {}
	self.modelBtns = {}
	self.curBtn = nil
end

function TeamDetailCell:setData(data, index)
	self.data = data
	self.index = index
	self.isURTeam = self.index == Const.UR_TEAM_INDEX

	local map = self:refreshData()

	if not self.inited then
		self.inited = true

		for i, hid in ipairs(self.data) do
			local info = ResHero[hid]

			if not self.initMap[info.model] then
				local path0 = "HeroPanel/Hero" .. info.model
				local path = path0 .. "/BtnHero"

				if info and UIControls.checkControlFunc(self, path) then
					local panelHero = UIControls.Panel(self, path0)

					if self.mWindow:isShowHero(hid) then
						local btn = self.modelBtns[info.model]

						if not btn then
							btn = UIControls.Button(self, path)
							btn.panelSel = UIControls.Panel(self, path .. "/ImgSel")
							btn.panelAni = UIControls.Panel(self, path .. "/Img")

							btn:addEventClick(self.onBtnHeroClick)

							self.modelBtns[info.model] = btn
						end

						btn.pInfo = map[hid]
						btn.isOwn = CurAvatar.handBookHeroDic[hid]

						if btn.isOwn then
							self.initMap[info.model] = true

							btn.panelAni:playStateAnimator("HeroStateAni")
						else
							btn.panelAni:playStateAnimator("HeroDis")
						end

						panelHero:setVisible(true)
						table.insert(self.btns, btn)
					else
						panelHero:setVisible(false)
					end
				end
			end
		end
	end

	self:setBtnSelect(false)
end

function TeamDetailCell:refreshData(...)
	local map = {}
	local gInfo

	if self.mWindow:isOtherTeam() then
		gInfo = CurAvatar:getOtherProficientGInfo(self.index)
	else
		gInfo = CurAvatar:getProficientGInfo(self.index, self.isURTeam)
	end

	local level = 0

	if gInfo and gInfo.item then
		for i, item in ipairs(gInfo.item) do
			map[item.resid] = item
		end

		level = gInfo.level
	end

	if self.txtVer then
		self.txtVer:setText(level)
	end

	self:setBtnSelect(false)

	return map
end

function TeamDetailCell:onBtnHeroClick(sender)
	if not sender.isOwn then
		MsgManager.notice(Lang.get(30315))

		self.mWindow.ignoreHeroInfoCall = false

		self.mWindow:onBtnHeroInfoClick()
	else
		self.mWindow.ignoreHeroInfoCall = self.mWindow.btnHeroInfo:getVisible()

		self:setBtnSelect(false)

		self.curBtn = sender

		self:setBtnSelect(true)
		self.mWindow:onBtnHeroClick(sender)
	end
end

function TeamDetailCell:setBtnSelect(v)
	if self.curBtn then
		self.curBtn:setEnable(not v)
		self.curBtn.panelSel:setVisible(v)
	end
end

function TeamDetailCell:playAniLevelUp(...)
	if self.isURTeam then
		self.aniLevelUp:startAni("ChangeTeamDetail01")
	else
		self.aniLevelUp:startAni("ChangeTeamDetail0" .. self.index)
	end
end

local DragTwoPages = require("UI/Control/DragTwoPages")
local strClassName = "HandBookTeamDetailDlg"
local HandBookTeamDetailDlg = Class(strClassName, UIControls.Window)

function HandBookTeamDetailDlg:ctor(...)
	self:initUI()
end

function HandBookTeamDetailDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnProficient = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnGP", "TextGP")

	self.btnProficient:addEventClick(self.onBtnProficientClick)

	self.btnVer = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnVer", "TextVer")

	self.btnVer:addEventClick(self.onBtnVerClick)

	self.btnHeroInfo = UIControls.Button(self, "MainInfoPanel/HeroInfoPanel")

	self.btnHeroInfo:addEventClick(self.onBtnHeroInfoClick)

	self.btnJumpHero = UIControls.Button(self, "MainInfoPanel/HeroInfoPanel/InfoPanel/BtnGo")

	self.btnJumpHero:addEventClick(self.onBtnJumpHeroClick)

	self.imgNewPre = UIControls.Image(self, "MainInfoPanel/BtnPre/IconNew")
	self.imgNewNext = UIControls.Image(self, "MainInfoPanel/BtnNext/IconNew")
	self.imgIconLogo = UIControls.Image(self, "MainInfoPanel/IconLogo")
	self.imgLogo = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnShare/IconLogo")
	self.sharePanel = ShareAchievePanel(self, "MainInfoPanel/InfoPanel")

	self.sharePanel:setNoAwardInfo("handBookTeamDetailDlg")
	self.sharePanel:setShareVisible(true)
	self.sharePanel:setBeforeAction(self.onClickShare, self)
	self.sharePanel:setFinishAction(self.onShareFinish, self)

	if UIControls.checkControlFunc(self, "MainInfoPanel/InfoPanel/BtnShare/IconUR") then
		self.urShare = UIControls.Panel(self, "MainInfoPanel/InfoPanel/BtnShare/IconUR")
	end

	self.imgStar = UIControls.Image(self, "MainInfoPanel/HeroInfoPanel/InfoPanel/TextStarTitle/ImgStar")
	self.imgPaint = UIControls.Image(self, "MainInfoPanel/HeroInfoPanel/InfoPanel/TextCoatingTitle/ImgCoating")
	self.imgPaintPlus = UIControls.Image(self, "MainInfoPanel/HeroInfoPanel/InfoPanel/TextCoatingTitle/IconCoating02")
	self.txtPaintPlusLevel = UIControls.Label(self, "MainInfoPanel/HeroInfoPanel/InfoPanel/TextCoatingTitle/IconCoating02/Text")
	self.imgNewLevel = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnVer/IconNew")
	self.imgBg = UIControls.RawImage(self, "BgImage")
	self.imgGp = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnGP/IconGP")
	self.imgBgTitle = UIControls.Image(self, "MainInfoPanel/InfoPanel/BtnGP/BgTitle")
	self.txtHeroName = UIControls.Label(self, "MainInfoPanel/HeroInfoPanel/InfoPanel/TextName")
	self.txtAttrNone = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnGP/TextAttrNone")
	self.txtGpTitle = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnGP/TextGPTitle")
	self.attrUIs = {}

	for i = 1, 2 do
		local path = "MainInfoPanel/InfoPanel/BtnGP/Attr" .. i
		local panel = UIControls.Panel(self, path)
		local txtAttrName = UIControls.Label(self, path .. "/TextAttr")
		local txtAttrValue = UIControls.Label(self, path .. "/TextAttrValue")

		table.insert(self.attrUIs, {
			panel,
			txtAttrName,
			txtAttrValue
		})
	end

	self.panelOtherTeam = UIControls.Panel(self, "MainInfoPanel/Mask/ContentPanelList3")
	self.panelNewGp = UIControls.Panel(self, "MainInfoPanel/InfoPanel/BtnGP/IconNew")
	self.panelInfo = UIControls.Panel(self, "MainInfoPanel/InfoPanel")
	self.panelPaint = UIControls.Panel(self, "MainInfoPanel/HeroInfoPanel/InfoPanel/TextCoatingTitle")
	self.panelPre = UIControls.Panel(self, "MainInfoPanel/BtnPre")
	self.panelNext = UIControls.Panel(self, "MainInfoPanel/BtnNext")
	self.panelBg1 = UIControls.DragClickPanel(self, "MainInfoPanel/Mask/ContentPanel1")
	self.panelBg2 = UIControls.DragClickPanel(self, "MainInfoPanel/Mask/ContentPanel2")

	self.panelBg1:setDragBeginFunc(Slot(self.onDragStart, self))
	self.panelBg2:setDragBeginFunc(Slot(self.onDragStart, self))

	self.pages = {}
	self.otherTeamDetailCell = TeamDetailCell(self, "MainInfoPanel/Mask/ContentPanelList3/Content", "System/HandBook/TeamDetail07", 0, 0, true)
	self.scrollViewOtherTeam = UIControls.ScrollView(self, "MainInfoPanel/Mask/ContentPanelList3")

	self.scrollViewOtherTeam:addEventValueChanged(self.onOtherTeamScroll)

	self.ignoreHeroInfoCall = false
end

function HandBookTeamDetailDlg:onOpen(...)
	HandBookTeamDetailDlg.super.onOpen(self)
	self:refreshData()
	self:onBtnHeroInfoClick()
end

function HandBookTeamDetailDlg:checkLevelUpAni(...)
	if self.curTeamIndex then
		if self.isLevelUp then
			if self.isURTeam then
				self.urTeamDetailCell:playAniLevelUp()
			else
				local page = self.pages[self.panelIndex]

				if page then
					page:playAniLevelUp()
				end
			end
		end

		self.isLevelUp = nil
	end
end

function HandBookTeamDetailDlg:show(teamIndex, isURTeam)
	self.isURTeam = isURTeam or teamIndex == Const.UR_TEAM_INDEX
	self.teamData = CurAvatar:getConfigTeamHeros()
	self.curTeamIndex = teamIndex or Const.OTHER_TEAM_INDEX

	if self.urShare then
		self.urShare:setVisible(self.isURTeam)
	end

	if self.isURTeam then
		self.teamData = CurAvatar:getConfigURTeamHeros()

		self.btnHeroInfo:setRecttransform(UIConst.AnchorPresets.StretchAll, Vector2(-600, -600), Vector2(0, 0))
		self.panelOtherTeam:setVisible(false)
		self.imgLogo:setVisible(false)
		self.imgIconLogo:setVisible(false)

		self.contentPanel1 = self:getController():GetCom(UIConst.ControlTypeDragPage, "MainInfoPanel/Mask/ContentPanel1")
		self.contentPanel1.enabled = false
		self.urTeamDetailCell = TeamDetailCell(self, "MainInfoPanel/Mask/ContentPanel1", "System/HandBook/TeamDetail08", 0, 0, true)

		local data = self.teamData[Const.UR_TEAM_INDEX]

		self.urTeamDetailCell:setData(data, Const.UR_TEAM_INDEX)
		self:refreshData()
	elseif self.curTeamIndex >= 1 and self.curTeamIndex <= 6 then
		if not self.dragPages then
			self.dragPages = DragTwoPages(self, "MainInfoPanel/Mask/ContentPanel1", "MainInfoPanel/Mask/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
			self.dragPages.dragEvent = Slot(self.onDragEvent, self)
		end

		self.dragPages:initPage(#self.teamData, self.curTeamIndex)
		self.panelOtherTeam:setVisible(false)
		self.btnHeroInfo:setRecttransform(UIConst.AnchorPresets.StretchAll, Vector2(-600, -600), Vector2(0, 0))
	elseif Const.IS_SHOW_OTHER_TEAM_PROFICIENT then
		self.btnHeroInfo:setRecttransform(UIConst.AnchorPresets.StretchAll, Vector2(-600, -600), Vector2(0, 1080))
		self.panelBg1:setVisible(false)
		self.panelBg2:setVisible(false)
		self.btnVer:setVisible(false)
		self.imgLogo:setVisible(false)
		self.panelOtherTeam:setVisible(true)
		self.imgBgTitle:setColorByRGBA(141, 255, 253)
		self.imgGp:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas", "IconGP1")
		self.imgGp:setColorByRGBA(255, 255, 255)
		self.txtGpTitle:setText(Lang.get(43992))

		self.teamData = CurAvatar:getConfigOtherTeamHeros()

		local data = self.teamData[Const.OTHER_TEAM_INDEX]

		self.otherTeamDetailCell:setData(data, Const.OTHER_TEAM_INDEX)
		self:refreshData()
	end
end

function HandBookTeamDetailDlg:refreshData(...)
	if self.curTeamIndex == nil then
		return
	end

	local page = self.pages[self.panelIndex]

	if page then
		page:refreshData()
	end

	local teamInfo
	local isOtherTeam = self:isOtherTeam()

	if isOtherTeam then
		teamInfo = CurAvatar:getOtherProficientGInfo()

		self.imgBg:setImage("NoAlpha/HandBookRank/HandBookTeam/BgTeam07")
	else
		teamInfo = CurAvatar:getProficientGInfo(self.curTeamIndex, self.isURTeam)

		if not self.isURTeam then
			self.btnClose:setText(Const.HERO_TEAM_CONFIG[self.curTeamIndex].short_name or "")
			self.imgLogo:setImage("Atlas/CommonAtlas/IconTeamLargeAtlas", "TxtTeam0" .. self.curTeamIndex)
			self.imgIconLogo:setImage("Atlas/CommonAtlas/IconTeamLargeAtlas", "TxtTeam0" .. self.curTeamIndex)
			self.imgBg:setImage("NoAlpha/HandBookRank/HandBookTeam/BgTeam0" .. self.curTeamIndex)
		else
			self.imgBg:setImage("NoAlpha/HandBookRank/HandBookTeam/BgTeam08")
			self.urTeamDetailCell:refreshData()
		end
	end

	local score = 0

	if teamInfo then
		score = teamInfo.score

		self.btnVer:setText(teamInfo.level)
	else
		self.btnVer:setText(0)
	end

	self.btnProficient:setText(score)

	local buffInfo = utils.getProficientCommonBuffs(score, isOtherTeam, self.isURTeam)

	if buffInfo then
		self.txtAttrNone:setVisible(false)

		for i, info in ipairs(buffInfo) do
			local attrName = BattleConst.PROP_TYPE_CONFIG[info.id]
			local zhName, valueStr = ClientUtils.getRolePropZhName(attrName, info.value, true)

			self.attrUIs[i][1]:setVisible(true)
			self.attrUIs[i][2]:setText(zhName)
			self.attrUIs[i][3]:setText("+" .. valueStr)
		end
	else
		self.txtAttrNone:setVisible(true)

		for i = 1, 2 do
			self.attrUIs[i][1]:setVisible(false)
		end
	end

	if not self.isURTeam then
		local prenNew = CurAvatar:isNewProficient(self.curTeamIndex - 1)

		prenNew = prenNew or CurAvatar:isProficientLvUp(self.curTeamIndex - 1)

		local nextNew = CurAvatar:isNewProficient(self.curTeamIndex + 1)

		nextNew = nextNew or CurAvatar:isProficientLvUp(self.curTeamIndex + 1)

		self.imgNewNext:setVisible(nextNew)
		self.imgNewPre:setVisible(prenNew)
	end

	local lvUp = CurAvatar:isProficientLvUp(self.curTeamIndex, nil, self.isURTeam)

	self.imgNewLevel:setVisible(lvUp)

	local newGp = false

	if self.curTeamIndex == Const.OTHER_TEAM_INDEX then
		newGp = CurAvatar:isOtherNewProficient()
	else
		newGp = CurAvatar:isNewProficient(self.curTeamIndex, self.isURTeam)
	end

	self.panelNewGp:setVisible(newGp)
end

function HandBookTeamDetailDlg:refreshUI(isLevelUp)
	self:refreshData()

	self.isLevelUp = isLevelUp
end

function HandBookTeamDetailDlg.sortFunc(v1, v2)
	if v1.star == v2.star then
		local paint1 = v1:getPaintData()
		local paint2 = v2:getPaintData()

		if paint1 and paint2 then
			return paint1.level > paint2.level
		else
			return v1.star > v2.star
		end
	else
		return v1.star > v2.star
	end
end

function HandBookTeamDetailDlg:isShowHero(hid)
	if not self.hideModelMap then
		self.hideModelMap = {}

		for i, id in ipairs(ResHeroMisc[1].hide_heros or {}) do
			self.hideModelMap[id] = true
		end
	end

	return not self.hideModelMap[hid]
end

function HandBookTeamDetailDlg:isOtherTeam(teamIndex)
	teamIndex = teamIndex or self.curTeamIndex

	return teamIndex == Const.OTHER_TEAM_INDEX
end

function HandBookTeamDetailDlg:onOtherTeamScroll(...)
	self:onBtnHeroInfoClick()
end

function HandBookTeamDetailDlg:onClickShare()
	self.imgIconLogo:setVisible(true)

	if self.curTeamIndex == Const.OTHER_TEAM_INDEX or self.isURTeam then
		self.imgIconLogo:setVisible(false)
	end
end

function HandBookTeamDetailDlg:onShareFinish()
	self.imgIconLogo:setVisible(false)
end

function HandBookTeamDetailDlg:onBtnJumpHeroClick(...)
	if self.curHeroId then
		local heros = {}

		for gid, hero in pairs(CurAvatar.heroDic) do
			if hero.id == self.curHeroId then
				table.insert(heros, hero)
			end
		end

		if #heros > 0 then
			table.sort(heros, self.sortFunc)

			local heroMainDlg = UIManager.getUI("heroMainDlg")

			heroMainDlg.ignoreBeginnerOpen = true

			heroMainDlg:setVisible(true)

			if heroMainDlg then
				heroMainDlg:initForContentPanel(Const.HERO_CONTENT_PANEL.BASE_INFO, heros[1].gid)
			end
		else
			MsgManager.notice(Lang.get(31299))
		end
	end
end

function HandBookTeamDetailDlg:onDragStart(...)
	return
end

function HandBookTeamDetailDlg:onBtnHeroClick(sender)
	local pInfo = sender.pInfo

	if pInfo then
		if not CurAvatar.handBookHeroDic[pInfo.resid] then
			MsgManager.notice(Lang.get(30316))

			return
		end

		local heroConfig = ResHero[pInfo.resid]

		self.curHeroId = pInfo.resid

		self.btnHeroInfo:setVisible(true)

		local heroInfo = ResHero[pInfo.resid]

		self.txtHeroName:setText(heroInfo.hero_name)

		local maxStar = math.min(15, pInfo.score + (heroConfig.ori_star or 5) - 1)
		local starPath = maxStar < 10 and "IconStar0" or "IconStar"

		self.imgStar:setImage("Atlas/HeroAtlas/HeroCardCommonAtlas", starPath .. maxStar)

		local maxPaint = pInfo.score - 11

		if maxPaint <= 0 then
			self.panelPaint:setVisible(false)
		else
			self.panelPaint:setVisible(true)

			local showPaint = math.min(6, maxPaint)

			self.imgPaint:setImage("Atlas/HeroAtlas/HeroCoatingAtlas", "CoatingImgName0" .. showPaint)

			if Const.PAINT_PLUS_OPEN then
				local hero = CurAvatar:getMaxStartLvHeroByHeroId(pInfo.resid)

				if hero then
					local showLevel = hero:getPaintPlusShowLevel()

					if showLevel and showLevel ~= 0 then
						self.imgPaintPlus:setVisible(true)
						self.txtPaintPlusLevel:setText(showLevel)
					else
						self.imgPaintPlus:setVisible(false)
					end
				else
					self.imgPaintPlus:setVisible(false)
				end
			else
				self.imgPaintPlus:setVisible(false)
			end
		end
	end
end

function HandBookTeamDetailDlg:onBtnHeroInfoClick(...)
	if self.btnHeroInfo:getVisible() == false then
		return
	end

	if self.ignoreHeroInfoCall == true then
		self.ignoreHeroInfoCall = false

		return
	end

	self.btnHeroInfo:setVisible(false)

	if self.pages then
		for i, page in ipairs(self.pages) do
			page:setBtnSelect(false)
		end
	end

	if Const.IS_SHOW_OTHER_TEAM_PROFICIENT then
		self.otherTeamDetailCell:setBtnSelect(false)
	end
end

function HandBookTeamDetailDlg:onBtnVerClick(...)
	UIManager.getUI("handBookTeamUpgradeDlg", true):show(self.curTeamIndex, self.isURTeam)
end

function HandBookTeamDetailDlg:onBtnProficientClick(...)
	local result = true

	if self:isOtherTeam() then
		result = CurAvatar:isOtherNewProficient(self.curTeamIndex)
	else
		result = CurAvatar:isNewProficient(self.curTeamIndex, self.isURTeam)
	end

	if not result then
		MsgManager.notice(Lang.get(30317))

		return
	end

	UIManager.getUI("handBookTeamGetGPDlg", true):show(self.curTeamIndex, self.isURTeam)
end

function HandBookTeamDetailDlg:onDragEvent(sender, currentPageIndex, panelIndex)
	local data = self.teamData[currentPageIndex]

	self.curTeamIndex = currentPageIndex
	self.panelIndex = panelIndex

	local page = self.pages[panelIndex]

	if page then
		if page.index ~= currentPageIndex then
			page:destroy()

			page = TeamDetailCell(self, "MainInfoPanel/Mask/ContentPanel" .. panelIndex, "System/HandBook/TeamDetail0" .. currentPageIndex, 0, 0, true)
		end
	else
		page = TeamDetailCell(self, "MainInfoPanel/Mask/ContentPanel" .. panelIndex, "System/HandBook/TeamDetail0" .. currentPageIndex, 0, 0, true)
	end

	self.pages[panelIndex] = page

	page:setData(data, currentPageIndex)
	self:refreshData()
end

function HandBookTeamDetailDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HANDBOOK_TEAM)
end

function HandBookTeamDetailDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return HandBookTeamDetailDlg

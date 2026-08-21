-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterApprenticeGuideDlg.lua

local ResMasterMisc = require("ClientData/ResMasterMisc")
local ResClientNotice = require("ClientData.ResClientNotice")
local CardHeroListPage = require("UI/PetMaze/CardHeroListPage")
local CurHeroCell = Class("MasterApprenticeGuideDlg_CurHeroCell", UIControls.Panel)

function CurHeroCell:ctor()
	return
end

function CurHeroCell:setData(hero)
	self.hero = hero

	local checkData = hero ~= nil

	if self.heroCard then
		self.heroCard:setVisible(checkData)
	end

	if hero then
		if not self.heroCard then
			self.heroCard = UIControls.HeroCardChild(self, self.mPath .. "/BgGrid", "System/Hero/GridHeroCard", 0, 0, true)
		end

		self.heroCard:setHero(hero)
		self.heroCard.btnSelf:setEnable(false)
	end
end

local RecHeroCell = Class("MasterApprenticeGuideDlg_RecHeroCell", UIControls.Panel)

function RecHeroCell:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)

	self.imgMasterBg = UIControls.Image(self, self.mPath .. "/BgTeacher")
	self.imgApprenticeBg = UIControls.Image(self, self.mPath .. "/BgStudent")
end

function RecHeroCell:setData(targetType, hero, clickCb)
	self.targetType = targetType
	self.hero = hero
	self.clickCb = clickCb

	local checkData = hero ~= nil
	local checkClick = targetType == Const.MASTER_APPRENTICE_TYPE.Master and clickCb ~= nil

	self.imgMasterBg:setVisible(targetType == Const.MASTER_APPRENTICE_TYPE.Master)
	self.imgApprenticeBg:setVisible(targetType == Const.MASTER_APPRENTICE_TYPE.Apprentice)
	self.btn:setEnable(checkClick)

	if self.heroCard then
		self.heroCard:setVisible(checkData)
	end

	if checkData then
		if not self.heroCard then
			if targetType == Const.MASTER_APPRENTICE_TYPE.Master then
				self.heroCard = UIControls.HeroCardChild(self, self.mPath .. "/BgTeacher", "System/Hero/GridHeroCard", 0, 0, true)
			else
				self.heroCard = UIControls.HeroCardChild(self, self.mPath .. "/BgStudent", "System/Hero/GridHeroCard", 0, 0, true)
			end

			self.slotOnClickBtn = self.slotOnClickBtn or Slot(self.onClickBtn, self)

			self.heroCard:setSelectCallback(self.slotOnClickBtn)
		end

		self.heroCard:setHero(hero)
		self.heroCard.btnSelf:setEnable(checkClick)
	end
end

function RecHeroCell:onClickBtn()
	if self.clickCb then
		self.clickCb(self)
	end
end

local MasterApprenticeGuideDlg = Class("MasterApprenticeGuideDlg", UIControls.Window)

function MasterApprenticeGuideDlg:ctor()
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.aniEdit = UIControls.UIAni(self, "MainInfoPanel")
	self.btnRequest = UIControls.Button(self, "MainInfoPanel/HeroPanel/RecommendPanel/HeroPanel/BtnGuide")

	self.btnRequest:addEventClick(self.onClickBtnResquest)

	self.txtRequest = UIControls.Label(self, "MainInfoPanel/HeroPanel/RecommendPanel/HeroPanel/BtnGuide/Text")
	self.txtRequestCd = UIControls.Label(self, "MainInfoPanel/HeroPanel/RecommendPanel/HeroPanel/BtnGuide/TextCD")
	self.recommendEfx = UIControls.LazyEffectPlayer(self, "MainInfoPanel/HeroPanel/RecommendPanel/Efx")
	self.txtMasterTitle1 = UIControls.Label(self, "MainInfoPanel/HeroPanel/BgTitle1/Text")
	self.txtMasterTitle2 = UIControls.Label(self, "MainInfoPanel/HeroPanel/BgTitle2/Text")
	self.txtApprenticeTitle1 = UIControls.Label(self, "MainInfoPanel/HeroPanel/BgTitle1/Text2")
	self.txtApprenticeTitle2 = UIControls.Label(self, "MainInfoPanel/HeroPanel/BgTitle2/Text2")
	self.curHeroCellList = {}
	self.recHeroCellList = {}

	for i = 1, 5 do
		local cell = CurHeroCell(self, "MainInfoPanel/HeroPanel/PresentPanel/Panel" .. i)

		table.insert(self.curHeroCellList, cell)

		cell = RecHeroCell(self, "MainInfoPanel/HeroPanel/RecommendPanel/HeroPanel/BtnHeroPanel" .. i)

		table.insert(self.recHeroCellList, cell)
	end

	self.slotOnClickHeroCell = Slot(self.onClickHeroCell, self)
	self.slotCancelAndCloseEditHeroPanel = Slot(self.cancelAndCloseEditHeroPanel, self)
	self.slotConfirmAndCloseEditHeroPanel = Slot(self.confirmAndCloseEditHeroPanel, self)
	self.slotRefreshRecommendPanel = Slot(self.refreshRecommendPanel, self)
	self.cardHeroListPage = CardHeroListPage(self, "MainInfoPanel/HeroListPanel")

	self.cardHeroListPage:init(5, true, nil, self.slotCancelAndCloseEditHeroPanel, self.slotConfirmAndCloseEditHeroPanel, nil, self.slotRefreshRecommendPanel, nil)
end

function MasterApprenticeGuideDlg:onClose()
	MasterApprenticeGuideDlg.super.onClose(self)
	self:clearRequestTimer()
end

function MasterApprenticeGuideDlg:setData(targetType, apprenticeUid, heroDic, crystal_hero, guide_hero)
	self.targetType = targetType

	local checkMaster = targetType == Const.MASTER_APPRENTICE_TYPE.Master

	self.txtMasterTitle1:setVisible(checkMaster)
	self.txtMasterTitle2:setVisible(checkMaster)
	self.txtApprenticeTitle1:setVisible(not checkMaster)
	self.txtApprenticeTitle2:setVisible(not checkMaster)

	if checkMaster then
		self.apprenticeUid = apprenticeUid
		self.heroDic = heroDic
		self.curHeroDic = {}

		if crystal_hero then
			for _, gid in pairs(crystal_hero) do
				if self.heroDic[gid] then
					table.insert(self.curHeroDic, self.heroDic[gid])
				end
			end
		end

		self.recHeroGidList = {}

		if guide_hero then
			for _, gid in pairs(guide_hero) do
				if self.heroDic[gid] then
					table.insert(self.recHeroGidList, gid)
				end
			end
		end

		self:refreshCurHeroPanel(self.curHeroDic)

		self.initalRecHeroGidList = utils.deepcopy(self.recHeroGidList)

		self:refreshRecommendPanel(self.recHeroGidList)
		CurAvatar:clearApprenticeRequestDevelopGuideRed(self.apprenticeUid)
		RPC.masterClientUpdateProgress("kResMasterApprenticeTaskActionDevelopeGuideTimes", 1)
	else
		self.curHeroDic = CurAvatar:getPriestsFormationDic()

		self:refreshCurHeroPanel(self.curHeroDic)

		self.recHeroGidList = CurAvatar.masterGuideHeroGidList

		self:refreshRecommendPanel(self.recHeroGidList)

		local check = RedDotManager.getKeyState(UIConst.RD_HINT_APPRENTICE_DEVELOP_GUIDE)

		if check then
			self.recommendEfx:playEffect()
		end

		CurAvatar:clearMasterDevelopGuideRed()
	end

	self:refreshBtnRequest()
end

function MasterApprenticeGuideDlg:refreshCurHeroPanel(heroList)
	for i, cell in ipairs(self.curHeroCellList) do
		cell:setData(heroList[i])
	end
end

function MasterApprenticeGuideDlg:refreshRecommendPanel(heroGidList)
	local heroDic = self.targetType == Const.MASTER_APPRENTICE_TYPE.Master and self.heroDic or CurAvatar.heroDic

	for i, cell in ipairs(self.recHeroCellList) do
		local gid = heroGidList[i]

		cell:setData(self.targetType, gid and heroDic[gid], self.slotOnClickHeroCell)
	end
end

function MasterApprenticeGuideDlg:onClickHeroCell(cell)
	if not self.checkOpenEditHeroPanel then
		self:openEditHeroPanel()
	elseif cell.hero then
		self.cardHeroListPage:cancelSelectCell(cell.hero.gid)
	end
end

function MasterApprenticeGuideDlg:cancelAndCloseEditHeroPanel()
	self:closeEditHeroPanel()
	self:refreshRecommendPanel(self.initalRecHeroGidList)
end

function MasterApprenticeGuideDlg:confirmAndCloseEditHeroPanel(selectHeroGidList)
	local function yesFunc()
		self:realConfirmAndCloseEditHeroPanel(selectHeroGidList)
	end

	if #selectHeroGidList < 5 then
		UIManager.showConfirmWithId(1144, yesFunc)
	else
		UIManager.showConfirmWithId(1143, yesFunc)
	end
end

function MasterApprenticeGuideDlg:realConfirmAndCloseEditHeroPanel(selectHeroGidList)
	self:closeEditHeroPanel()

	self.recHeroGidList = utils.deepcopy(selectHeroGidList)
	self.initalRecHeroGidList = utils.deepcopy(selectHeroGidList)

	RPC.masterSetDevelopGuide(self.apprenticeUid, self.recHeroGidList)
end

function MasterApprenticeGuideDlg:openEditHeroPanel()
	self.aniEdit:startAni("ShowGuide")

	self.checkOpenEditHeroPanel = true

	self.cardHeroListPage:onOpen(self.recHeroGidList, nil, self.heroDic)
end

function MasterApprenticeGuideDlg:closeEditHeroPanel()
	self.aniEdit:startAni("HideGuide")

	self.checkOpenEditHeroPanel = false
end

function MasterApprenticeGuideDlg:refreshBtnRequest()
	self.btnRequest:setVisible(self.targetType == Const.MASTER_APPRENTICE_TYPE.Apprentice)
	self:clearRequestTimer()

	if self.targetType == Const.MASTER_APPRENTICE_TYPE.Apprentice then
		local cd = self:getRequestCd()

		self:refreshTxtRequestCd(cd)

		if cd > 0 then
			self.slotOnRequestTimerChange = self.slotOnRequestTimerChange or Slot(self.onRequestTimerChange, self)
			self.requestTimer = Timer(self.slotOnRequestTimerChange, 1, -1)

			self.requestTimer:Start()
		end
	end
end

function MasterApprenticeGuideDlg:getRequestCd()
	local cur = ClientUtils.getServerTime()

	return CurAvatar.lastRequestMasterGuideTick + ResMasterMisc[1].guide_cd - cur
end

function MasterApprenticeGuideDlg:onRequestTimerChange()
	local cd = self:getRequestCd()

	self:refreshTxtRequestCd(cd)

	if cd <= 0 then
		self:clearRequestTimer()
	end
end

function MasterApprenticeGuideDlg:refreshTxtRequestCd(cd)
	self.btnRequest:setEnable(cd <= 0)
	self.txtRequest:setVisible(cd <= 0)
	self.txtRequestCd:setVisible(cd > 0)

	if cd > 0 then
		local strTime = ClientUtils.getTimeStrBySecond(cd)

		self.txtRequestCd:setText(string.format(ResClientNotice[798].notice, strTime))
	end
end

function MasterApprenticeGuideDlg:clearRequestTimer()
	if self.requestTimer then
		self.requestTimer:Stop()

		self.requestTimer = nil
	end
end

function MasterApprenticeGuideDlg:onClickBtnResquest()
	if CurAvatar.master then
		RPC.apprenticeRequestDevelopGuide(CurAvatar.master.uid)
	end
end

function MasterApprenticeGuideDlg:onClickBtnClose()
	self:setVisible(false)
end

function MasterApprenticeGuideDlg:onApprenticeRequestDevelopGuideResp()
	self:refreshBtnRequest()
end

return MasterApprenticeGuideDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookTeamGetGpDlg.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResHero = require("ClientData/ResHero")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local TeamHeroCell = Class("TeamHeroCell", UIControls.Child)

function TeamHeroCell:ctor(...)
	self:initUI()
end

function TeamHeroCell:initUI(...)
	self.imgHeroIcon = UIControls.Image(self, "BgHead/IconHead")
	self.imgQuality = UIControls.Image(self, "BgHead/ImgQuality")
	self.imgHeroStar = UIControls.Image(self, "ImgStar")
	self.imgPaint = UIControls.Image(self, "CoatingImg")
	self.iconCoating02 = UIControls.Image(self, "IconCoating02")
	self.txtPaintPlusLevel = UIControls.Label(self, "IconCoating02/Text")
end

function TeamHeroCell:setData(resid, star, paintLevel, isGray)
	local info = ResHero[resid]

	if info then
		local modelData = utils.getCommonModelData(info.model)

		if modelData then
			self.imgHeroIcon:setImage("Atlas/" .. modelData.head_path, modelData.head_name)
		end

		if star then
			local starPath = star < 10 and "IconStar0" or "IconStar"

			self.imgHeroStar:setImage("Atlas/HeroAtlas/HeroCardCommonAtlas", starPath .. star)
		end

		local stepImgIdx = ResStarUpCondition[star].step_img_idx or 1
		local path = UIConst.HERO_QUALITY_HEAD_CONFIG[stepImgIdx]

		if path then
			self.imgQuality:setImage(path[1], path[2])
		end

		if star == 15 and paintLevel and paintLevel > 0 then
			self.imgPaint:setVisible(true)

			if paintLevel > 6 then
				self.imgPaint:setImage("Atlas/HeroAtlas/HeroCoatingAtlas", "CoatingImgC0" .. 6)

				local levelList = CurAvatar:getHeroPaintPlusProficientAddLevelListById(resid)

				if levelList and levelList[paintLevel - 6] then
					self.iconCoating02:setVisible(true)
					self.txtPaintPlusLevel:setText(levelList[paintLevel - 6])
				else
					self.iconCoating02:setVisible(false)
				end
			else
				self.iconCoating02:setVisible(false)
				self.imgPaint:setImage("Atlas/HeroAtlas/HeroCoatingAtlas", "CoatingImgC0" .. paintLevel)
			end
		else
			self.imgPaint:setVisible(false)
		end
	end

	if isGray == nil then
		isGray = false
	end

	self:setObjGray(isGray)
end

local TeamGetGPCell = Class("TeamGetGPCell", UIControls.ScrollViewLoopCell)

function TeamGetGPCell:ctor(...)
	self:initUI()
end

function TeamGetGPCell:initUI(...)
	self.txtTitle = UIControls.Label(self, "TextTitle")
	self.txtProficient = UIControls.Label(self, "TextGP")
	self.imgTitle = UIControls.Image(self, "ImgTitle")
	self.imgGp = UIControls.Image(self, "IconGP")
	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.preGridHero = TeamHeroCell(self, "BeforePanel", "System/Common/Grid/GridHeroTeam", 0, 0, true)
	self.afterGridHero = TeamHeroCell(self, "AfterPanel", "System/Common/Grid/GridHeroTeam", 0, 0, true)

	if self.mWindow.isOtherTeam then
		self.imgGp:setColorByRGBA(255, 255, 255)
		self.imgGp:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas", "IconGP1")
	end
end

function TeamGetGPCell:setData(data)
	self.bitPos = data.pos
	self.info = data.info

	local heroConfig = ResHero[self.info.resid]
	local desc = ""
	local iconName = ""

	if self.bitPos == 1 then
		desc = Lang.get(590)
		iconName = "BgNew"

		self.preGridHero:setData(self.info.resid, heroConfig.ori_star, nil, true)
		self.afterGridHero:setData(self.info.resid, heroConfig.ori_star, nil)
	elseif self.bitPos > 1 and self.bitPos < 12 then
		desc = Lang.get(1202)
		iconName = "BgStar"

		local newStar = self.bitPos - 1 + heroConfig.ori_star

		self.preGridHero:setData(self.info.resid, newStar - 1, nil)
		self.afterGridHero:setData(self.info.resid, newStar, nil)
	else
		desc = Lang.get(1133)
		iconName = "BgCoating"

		local newPaintLevel = self.bitPos - 11

		self.preGridHero:setData(self.info.resid, 15, newPaintLevel - 1)
		self.afterGridHero:setData(self.info.resid, 15, newPaintLevel)
	end

	self.txtTitle:setText(desc)
	self.txtProficient:setText("+1")

	if self.mWindow.isURTeam then
		self.txtProficient:setText("+" .. Const.UR_HAND_BOOK_SCORE or 4)
	end

	self.imgTitle:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas1", iconName)
end

function TeamGetGPCell:isCanClaim(...)
	return true
end

function TeamGetGPCell:flyAward(...)
	if self.mWindow.isOtherTeam then
		FlyIconUtils.setFlyImagetoUI(self.imgGp, self.mWindow.imgGp, "Atlas/HandBookAtlas/HandBookTeamAtlas", "IconGP1", 1)
	else
		FlyIconUtils.setFlyImagetoUI(self.imgGp, self.mWindow.imgGp, "Atlas/HandBookAtlas/HandBookTeamAtlas1", "IconGP", 1)
	end
end

function TeamGetGPCell:onBtnGetClick(...)
	self:flyAward()

	if self.mWindow.isOtherTeam then
		RPC.proficentGetOtherScore(self.info.resid, self.bitPos - 1, nil)
	else
		RPC.proficentGetScore(self.info.resid, self.bitPos - 1, nil, self.mWindow.teamIndex, self.mWindow.isURTeam and 1 or 0)
	end
end

local strClassName = "HandBookTeamGetGPDlg"
local HandBookTeamGetGPDlg = Class(strClassName, UIControls.Window)

function HandBookTeamGetGPDlg:ctor(...)
	self:initUI()
end

function HandBookTeamGetGPDlg:initUI(...)
	self.txtProficient = UIControls.Label(self, "BgPanel/GPPanel/TextGP")
	self.txtGpTitle = UIControls.Label(self, "BgPanel/GPPanel/TextGPTitle")
	self.txtAttrNone = UIControls.Label(self, "BgPanel/GPPanel/TextAttrNone")
	self.btnGetAll = UIControls.Button(self, "BgPanel/BtnGetAll")

	self.btnGetAll:addEventClick(self.onBtnGetAllClick)

	self.imgGp = UIControls.Image(self, "BgPanel/GPPanel/IconGP")
	self.imgBgTitle = UIControls.Image(self, "BgPanel/GPPanel/BgTitle")
	self.panelAttrNone = UIControls.Panel(self, "BgPanel/GPPanel/TextAttrNone")
	self.panelAttrDesc = UIControls.Panel(self, "BgPanel/GPPanel/TextAttrTitle")
	self.efxAttr = UIControls.LazyEffectPlayer(self, "BgPanel/GPPanel/Efx")
	self.attrUIs = {}

	for i = 1, 2 do
		local path = "BgPanel/GPPanel/Attr" .. i
		local panel = UIControls.UIAni(self, path)
		local txtAttrName = UIControls.Label(self, path .. "/TextAttr")
		local txtAttrValue = UIControls.Label(self, path .. "/TextAttrValue")

		table.insert(self.attrUIs, {
			panel,
			txtAttrName,
			txtAttrValue
		})
	end

	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/GetList", 0, self.onCellChanged)
	self.initAttrMap = {}
	self.cells = {}
end

function HandBookTeamGetGPDlg:onOpen(...)
	HandBookTeamGetGPDlg.super.onOpen(self)
end

function HandBookTeamGetGPDlg:show(teamIndex, isURTeam)
	self.teamIndex = teamIndex
	self.isURTeam = isURTeam
	self.isOtherTeam = false

	if (self.teamIndex < 1 or self.teamIndex > 6) and not self.isURTeam then
		self.isOtherTeam = true

		self.imgBgTitle:setColorByRGBA(141, 255, 253)
		self.imgGp:setColorByRGBA(255, 255, 255)
		self.imgGp:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas", "IconGP1")
		self.txtGpTitle:setText(Lang.get(43992))
		self.txtAttrNone:setText(Lang.get(43993))
	end

	self:refreshUI(true)
end

function HandBookTeamGetGPDlg:refreshUI(isInit)
	local teamInfo

	if self.isOtherTeam then
		teamInfo = CurAvatar:getOtherProficientGInfo(self.teamIndex)
	else
		teamInfo = CurAvatar:getProficientGInfo(self.teamIndex, self.isURTeam)
	end

	local score = 0

	if teamInfo then
		score = teamInfo.score
	end

	self.txtProficient:setText(score)

	local buffInfo = utils.getProficientCommonBuffs(score, self.isOtherTeam, self.isURTeam)

	if buffInfo then
		if isInit then
			self.panelAttrNone:setVisible(true)
		else
			self.panelAttrNone:setVisible(false)
		end

		self.panelAttrDesc:setVisible(not isInit)

		for i, info in ipairs(buffInfo) do
			if isInit then
				self.initAttrMap[info.id] = info.value
			end

			local attrName = BattleConst.PROP_TYPE_CONFIG[info.id]
			local zhName, valueStr = ClientUtils.getRolePropZhName(attrName, info.value - (self.initAttrMap[info.id] or 0), true)

			self.attrUIs[i][1]:setVisible(not isInit)

			if not isInit then
				if info.isChange then
					self.attrUIs[i][1]:startAni("HandBookTeamAttrChange")
				end

				self.efxAttr:setVisible(true)
				self.efxAttr:playEffect()
			end

			self.attrUIs[i][2]:setText(zhName)
			self.attrUIs[i][3]:setText("+" .. valueStr)
		end
	else
		self.panelAttrNone:setVisible(true)

		for i, ui in ipairs(self.attrUIs) do
			ui[1]:setVisible(false)
		end

		self.panelAttrDesc:setVisible(false)
	end

	local gInfo

	if self.isOtherTeam then
		gInfo = CurAvatar:getOtherProficientGInfo(self.teamIndex)
	else
		gInfo = CurAvatar:getProficientGInfo(self.teamIndex, self.isURTeam)
	end

	if gInfo then
		self.proficientDatas = CurAvatar:getNewProficientInfo(gInfo)
	end

	if self.proficientDatas then
		self.btnGetAll:setVisible(#self.proficientDatas > 10)
		self:refreshList()
	end
end

function HandBookTeamGetGPDlg:refreshList(...)
	self.scrollView:setTotalCount(#self.proficientDatas)
end

function HandBookTeamGetGPDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = TeamGetGPCell(sender, "System/HandBook/HandBookTeamGetGPCell", newIdx, 0, 0)

		table.insert(self.cells, targetCell)
	end

	targetCell.mIndex = newIdx

	targetCell:setData(self.proficientDatas[newIdx])
end

function HandBookTeamGetGPDlg:onBtnGetAllClick(...)
	for i, cell in ipairs(self.cells) do
		if cell:isCanClaim() then
			cell:flyAward()
		end
	end

	if self.isOtherTeam then
		RPC.proficentGetOtherScore(nil, nil, 1)
	else
		RPC.proficentGetScore(nil, nil, 1, self.teamIndex, self.isURTeam and 1 or 0)
	end
end

return HandBookTeamGetGPDlg

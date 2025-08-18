-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\EquipTips.lua

local SingleEquipTipsChild = require("UI/Common/Tips/SingleEquipTipsChild")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local strClassName = "EquipTips"
local EquipTips = Class(strClassName, UIControls.Tips)

function EquipTips:ctor(prefabPath, order, needShow)
	self:initUI()
end

function EquipTips:initUI()
	self.panelEquipInfo = SingleEquipTipsChild(self, "BgR", "System/Common/Tips/EquipInfoPanel", 0, 0, true)
	self.panelEquipInfo.isDynamicHeight = true
	self.panelHeroNone = UIControls.Panel(self, "BgPanel/HeroInfoNone")
	self.panelHero = UIControls.Panel(self, "BgPanel/HeroInfo")
	self.panelEmpty = UIControls.Panel(self, "BgPanel/EmptyPanel")
	self.imgBgYellow = UIControls.Image(self, "BgPanel/Func/BgHeroInfo/BgYellow")

	self:initFuncBtn(5)

	self.btnEvolve = UIControls.Button(self, "BgPanel/Func/BtnFunc6")

	self.btnEvolve:addEventClick(self.onBtnEvolveClick)

	self.btnBuild = UIControls.Button(self, "BgPanel/Func/BtnFunc7")

	self.btnBuild:addEventClick(self.onBtnBuildClick)

	self.imgCanEvoNew = UIControls.Image(self, "BgPanel/Func/BtnFunc6/IconNew")
	self.imgCanBuildNew = UIControls.Image(self, "BgPanel/Func/BtnFunc7/IconNew")

	if UIControls.checkControlFunc(self, "BgPanel/Func/FuncPanel/BtnFunc1/Image") then
		self.imgLock = UIControls.Image(self, "BgPanel/Func/FuncPanel/BtnFunc1/Image")
	end
end

function EquipTips:_setObj(grid)
	self.grid = grid
	self.equip = grid.object
	self.equipList = self.equip.equipList

	local heroGid = self.equip.inWearing
	local hero = grid.uiConfig ~= nil and grid.uiConfig.wearHero or nil

	if not hero and CurAvatar and heroGid and not utils.isCheckRoleInfo() then
		hero = CurAvatar.heroDic[heroGid]
	end

	self.imgBgYellow:setVisible(hero ~= nil)

	if hero then
		self.gridHero = UIControls.GridHeroInfoChild(self, "BgPanel/HeroInfo", "System/Common/Grid/GridHeroInfo")

		self.gridHero.btnHeroHead:setEnable(false)
		self.gridHero:setHero(hero)

		local stepImgIdx = ResStarUpCondition[hero.star].step_img_idx or 1
		local color = hero:getQualityColor(stepImgIdx)

		self.imgBgYellow:setObjColor(color)
	end

	self.panelHero:setVisible(hero ~= nil)
	self.panelHeroNone:setVisible(hero == nil and self._config ~= nil)
	self.panelEmpty:setVisible(self._config ~= nil)
	self.panelEquipInfo:setItem(self.equip, self.equipList)
	self.btnEvolve:setVisible(self.equip:isOpenEvo())
	self.imgCanEvoNew:setVisible(self.equip:getCanEvo())
	self.btnBuild:setVisible(self.equip:isOpenBuild())
	self.imgCanBuildNew:setVisible(self.equip:getCanBuild())

	self.isLock = self.equip.isLock

	if self.imgLock then
		local imgName = "IconLockopenNml"

		if self.isLock and self.isLock == Const.EQUIP_STATE_LOCK then
			imgName = "IconLockNml"
		end

		self.imgLock:setImage("Atlas/CommonAtlas/TipsNewAtlas", imgName)
	end
end

function EquipTips:refreshLockInfo()
	self.isLock = self.equip.isLock

	if self.imgLock then
		local imgName = "IconLockopenNml"

		if self.isLock and self.isLock == Const.EQUIP_STATE_LOCK then
			imgName = "IconLockNml"
		end

		self.imgLock:setImage("Atlas/CommonAtlas/TipsNewAtlas", imgName)
	end

	self.panelEquipInfo:setItem(self.equip, self.equipList)
end

function EquipTips:onBtnEvolveClick()
	if self.grid.uiConfig and self.grid.uiConfig.fromEditPlan then
		MsgManager.clientNotice(376)
		self:setVisible(false)

		return
	end

	local isFromBattle

	if self.grid.uiConfig and self.grid.uiConfig.fromBattle then
		isFromBattle = true
	end

	self:setVisible(false)

	local heroEquipEvolutionDlg = UIManager.getUI("heroEquipEvolutionDlg", true)

	heroEquipEvolutionDlg:setEquip(self.equip, isFromBattle)
end

function EquipTips:onBtnBuildClick()
	if self.grid.uiConfig and self.grid.uiConfig.fromEditPlan then
		MsgManager.clientNotice(376)
		self:setVisible(false)

		return
	end

	local isFromBattle

	if self.grid.uiConfig and self.grid.uiConfig.fromBattle then
		isFromBattle = true
	end

	self:setVisible(false)

	local heroEquipBuildDlg = UIManager.getUI("heroEquipBuildDlg", true)

	heroEquipBuildDlg:setData(Const.BUILD_PANEL_TYPE_STONE, self.equip, isFromBattle)
end

return EquipTips

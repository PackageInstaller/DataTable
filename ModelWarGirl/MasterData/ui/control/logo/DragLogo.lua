-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Logo\\DragLogo.lua

local strClassName = "DragLogo"
local DragLogo = Class(strClassName, UIControls.Logo)
local ResColor = require("ClientData/ResColor")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local GREEN = {
	0,
	255,
	0,
	255
}
local RED = {
	255,
	0,
	0,
	255
}
local EFFPATH = "Effects/UI/"

function DragLogo:ctor(entity, prefabPath, x, y)
	self.entity = entity
	self.isHero = false

	self:initUI()
	self:setSelect(false)
end

function DragLogo:destroy()
	DragLogo.super.destroy(self)
end

function DragLogo:initUI()
	self.imgGroup = UIControls.Image(self, "BasicInfoPanel/IconGroup")
	self.txtLv = UIControls.Label(self, "BasicInfoPanel/TextLv")
	self.imgCareer = UIControls.Image(self, "BasicInfoPanel/IconCareer")
	self.aniSupport = UIControls.UIAni(self, "BgSupport")
	self.imgBoss = UIControls.Panel(self, "IconBoss")
	self.imgSelect = UIControls.LazyEffectPlayer(self, "ImgSelect")
	self.panelBlood = UIControls.Panel(self, "BloodPanel")
	self.sliderHp = UIControls.Slider(self, "BloodPanel/Slider")
	self.imgBlood = UIControls.Image(self, "BloodPanel/Slider/Fill")
	self.aniOvercome = UIControls.UIAni(self, "BgGroupOrder")
	self.panelCheck = UIControls.Panel(self, "ImgCheck")

	if UIControls.checkControlFunc(self, "BasicInfoPanel/ImgCrystalLv") then
		self.panelCrystalLv = UIControls.Panel(self, "BasicInfoPanel/ImgCrystalLv")
		self.textCrystalLv = UIControls.Label(self, "BasicInfoPanel/ImgCrystalLv/TextCrystalLv")
	end

	self.IconSolderList = {}

	if UIControls.checkControlFunc(self, "SolderPanel") then
		self.solderPanel = UIControls.Panel(self, "SolderPanel")

		for i = 1, 3 do
			local iconSolder = UIControls.Image(self, "SolderPanel/IconSolder" .. i)
			local bgIconSolder = UIControls.Image(self, "SolderPanel/BgIconSolder" .. i)

			self.IconSolderList[i] = {
				iconSolder = iconSolder,
				bgIconSolder = bgIconSolder
			}
		end
	end
end

function DragLogo:playBattleSupport()
	self.aniSupport:setVisible(true)
	self.aniSupport:startAni("ShowSupport", true)
end

function DragLogo:playBattleOvercome(isLoop)
	self.aniOvercome:setVisible(true)

	if isLoop then
		self.aniOvercome:startAniLoop("ShowGroupOrderLoop")
	else
		self.aniOvercome:startAni("ShowGroupOrder", true)
	end
end

function DragLogo:stopBattleOvercome()
	self.aniOvercome:setVisible(false)
end

function DragLogo:setTarget(target, isHero)
	if target == nil then
		self:setVisible(false)

		return
	end

	if Const.REVIEW_VERSION then
		self.txtLv:setText(target:getShowLv() .. Lang.get(163))
	else
		self.txtLv:setText("LV." .. target:getShowLv())
	end

	local lvColor = target:getLvColor({
		[Const.CAMP_TYPE.SLIM_SNOW] = ResColor.GREYDIS
	})

	self.txtLv:setFontColor(lvColor)

	if self.panelCrystalLv and target.crystalSecondLevel and target.crystalSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.textCrystalLv:setText(math.floor(target.crystalSecondLevel / 10))
	end

	self.isHero = isHero ~= nil and true or false

	local careerPath = target:getGragCareerPath()

	if careerPath then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
	end

	local groupPath = target:getTeamPath()

	if groupPath then
		self.imgGroup:setImage(groupPath[1], groupPath[2])
	end

	self.imgBoss:setVisible(target.resData.eliteType ~= nil)
	self.panelCheck:setVisible(false)
	self:setVisible(true)
end

function DragLogo:showHP(hero)
	if hero then
		local color = self.isHero == true and ResColor.GREEN or ResColor.RED

		self.imgBlood:setColorByRGBA(color.r, color.g, color.b, color.a)
		self.panelBlood:setVisible(true)

		if hero.mazeHp then
			self.sliderHp:setValue(hero.mazeHp * 0.0001)
		else
			self.sliderHp:setValue(1)
		end
	end
end

function DragLogo:showCheck(show)
	self.panelCheck:setVisible(show)
end

function DragLogo:setSupport(maxCount, curCount)
	return
end

function DragLogo:setTargetEff(range)
	self.imgSelect:setVisible(true)

	local effName = math.abs(range) > 1 and "efx_ui_target02.prefab" or "efx_ui_target01.prefab"

	self.imgSelect:playEffectByPath(EFFPATH .. effName)
end

function DragLogo:closeTargetEff()
	self.imgSelect:setVisible(false)
end

function DragLogo:setSelect(isSelect)
	self.imgSelect:setVisible(isSelect)

	if isSelect then
		self.imgSelect:playEffectByPath(EFFPATH .. "efx_ui_select.prefab")
	end
end

function DragLogo:setSolder(target)
	self.solderPanel:setVisible(true)

	local solderList = target:getMazeSolderState()

	for i = 1, 3 do
		if solderList[i] then
			self.IconSolderList[i].iconSolder:setVisible(true)
			self.IconSolderList[i].bgIconSolder:setVisible(true)

			if ResNewMazeFettersType[solderList[i].id] then
				local fetter = ResNewMazeFettersType[solderList[i].id][1]

				self.IconSolderList[i].iconSolder:setImage(fetter.icon_path, fetter.icon_name)
			end

			if solderList[i].isDefault then
				self.IconSolderList[i].bgIconSolder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", "BgFetter1")
			else
				self.IconSolderList[i].bgIconSolder:setImage("Atlas/CommonAtlas/GridAtlas/GridLosder01", "BgFetter2")
			end
		else
			self.IconSolderList[i].iconSolder:setVisible(false)
			self.IconSolderList[i].bgIconSolder:setVisible(false)
		end
	end
end

return DragLogo

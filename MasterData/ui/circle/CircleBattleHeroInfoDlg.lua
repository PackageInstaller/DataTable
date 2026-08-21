-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleHeroInfoDlg.lua

local RoleInfoHeroDlg = require("UI/RoleInfo/RoleInfoHeroDlg")
local ATTR_PANEL_PROP_MAP = {
	{
		prop = "atk"
	},
	{
		prop = "mhp"
	},
	{
		prop = "p_def"
	},
	{
		prop = "cri_rate"
	},
	{
		prop = "cri_dmg"
	},
	{
		prop = "assist_enhance"
	},
	{
		prop = "effect_hit"
	}
}
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local strClassName = "CircleBattleHeroInfoDlg"
local CircleBattleHeroInfoDlg = Class(strClassName, RoleInfoHeroDlg)

function CircleBattleHeroInfoDlg:ctor()
	self.actActive = false

	local actOj = CurAvatar:getCircleBattleActivity()

	if actOj and actOj:inOpenState() then
		self.actActive = true
	end
end

function CircleBattleHeroInfoDlg:showForCircleBattle()
	self.isFromCircleBattle = true

	self.panelGame:setVisible(true)
	self.panelImgDes:setVisible(true)
	self.txtGamePlayDes:setText(ClientUtils.getClientNotice(566))
end

function CircleBattleHeroInfoDlg:refreshUIForCircleBattle(heroList)
	local dataList = heroList

	self:setData(dataList, self.curCardIdx, self.orderCell)
end

function CircleBattleHeroInfoDlg:clearRelicInfo()
	if self.gridRelic then
		self.gridRelic:setVisible(false)
	end

	self.btnRelicGrid:setEnable(true)

	local dataList = CurAvatar:getCanWearRelicsInCircleBattle(self.selectedHero)

	if #dataList > 0 then
		self.imgRelicNew:setVisible(self.actActive)
	else
		self.imgRelicNew:setVisible(false)
	end
end

function CircleBattleHeroInfoDlg:onRelicGridClick(sender)
	if self.isFromCircleBattle then
		local dataList = CurAvatar:getCanWearRelicsInCircleBattle(self.selectedHero)

		if #dataList > 0 then
			local relicWearDlg = UIManager.getUI("relicWearDlg", true)

			relicWearDlg:setHero(self.selectedHero, dataList, nil, true)
			relicWearDlg.panelFund:setVisible(false)
		else
			MsgManager.clientNotice(281)
		end
	elseif self.selectedHero:getRelic() and self.gridRelic then
		UIManager.getUI("relicTips"):showObj(self, self.relic)
	end
end

function CircleBattleHeroInfoDlg:refreshPropPanel()
	local equips = self.selectedHero:getEquips()
	local artifact = self.selectedHero:getArtifact()

	self.container = PropHelper.getHeroPanelAttrContainer(self, self.selectedHero.id, self.selectedHero:getPropLevel(), self.selectedHero.step, self.selectedHero.star, equips, artifact, self.selectedHero, self.selectedHero:getSkinData(), self.selectedHero:getBaseData(), self.selectedHero:getRelic(), self.selectedHero:getPaintData())

	for i = 1, #ATTR_PANEL_PROP_MAP do
		local attrName = ATTR_PANEL_PROP_MAP[i].prop
		local value = self.container[attrName] or 0
		local zhName, valueStr = ClientUtils.getRolePropZhName(attrName, value, true)
		local attriconInfo = ClientUtils.getRolePropIcon(attrName)

		self.attrMoreList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		self.attrMoreList[i]:setData(zhName, valueStr)

		if self.attrList[i] then
			self.attrList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
			self.attrList[i]:setData(zhName, valueStr)

			local rankValue = CurAvatar:getHeroPropValueByStep(attrName, self.selectedHero)
			local attrRank = CurAvatar:getHeroPropRank(attrName, rankValue)
			local rankIconInfo = UIConst.HERO_PROP_RANK_ICON[attrRank]
			local imgRank = UIControls.Image(self.attrList[i], self.attrList[i].mPath .. "/IconScore")

			imgRank:setImage(rankIconInfo[1], rankIconInfo[2])
		end
	end

	for i = #ATTR_PANEL_PROP_MAP + 1, #self.attrMoreList do
		self.attrMoreList[i]:setVisible(false)
	end
end

function CircleBattleHeroInfoDlg:setData(heros, idx)
	self.heros = heros
	idx = idx or 1

	self:setSelectHero(idx)
	self:setVisible(true)
end

return CircleBattleHeroInfoDlg

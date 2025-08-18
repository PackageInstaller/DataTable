-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroUpgradeResultDlg.lua

local strClassName = "HeroUpgradeResultDlg"
local HeroUpgradeResultDlg = Class(strClassName, UIControls.Window)
local HeroUpgradeResultAttrPanel = require("UI/Hero/HeroUpgradeResultAttrPanel")
local ResStar = require("ClientData/ResStar")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local STAR_UP_ATTR = {
	"atk_percent",
	"mhp_percent",
	"star_atk_percent",
	"star_mhp_percent"
}
local STAR_UP_SHIELD_ATTR = {
	star_atk_percent = 1,
	atk_percent = 1,
	mhp_percent = 1,
	star_mhp_percent = 1
}

function HeroUpgradeResultDlg:ctor()
	self:initUI()
end

function HeroUpgradeResultDlg:initUI()
	self.txtTitle1 = UIControls.Label(self, "BgPanel/TextTitle1")
	self.attrPanelList = {}

	for i = 1, 5 do
		local attrPanel = HeroUpgradeResultAttrPanel(self, "BgPanel/AttrPanel" .. i)

		self.attrPanelList[i] = attrPanel
	end
end

function HeroUpgradeResultDlg:setInfo(upgradeType, hero)
	self.hero = hero

	local oriContainer = {}

	self.attrNameMap = {}

	local equips = hero:getEquips()
	local artifact = hero:getArtifact()

	self.upgradeType = upgradeType

	if upgradeType == 1 then
		self.txtTitle1:setText(Lang.get(1233))

		oriContainer = PropHelper.getHeroPanelAttrContainer(self, hero.id, hero:getPropLevel(), hero.battleStep - 1, hero.star, equips, artifact, hero, hero:getSkinData(), hero:getBaseData(), hero:getRelic(), hero:getPaintData(), hero:getRelationPointData())
	else
		self.txtTitle1:setText(Lang.get(1202))

		oriContainer = PropHelper.getHeroPanelAttrContainer(self, hero.id, hero:getPropLevel(), hero.battleStep, hero.star - 1, equips, artifact, hero, hero:getSkinData(), hero:getBaseData(), hero:getRelic(), hero:getPaintData(), hero:getRelationPointData())
	end

	local targetContainer = PropHelper.getHeroPanelAttrContainer(self, hero.id, hero:getPropLevel(), hero.battleStep, hero.star, equips, artifact, hero, hero:getSkinData(), hero:getBaseData(), hero:getRelic(), hero:getPaintData(), hero:getRelationPointData())
	local changeContainer = {}

	if upgradeType == 1 then
		for k, v in pairs(targetContainer) do
			local attrInfo = self:genAttrInfo(k, oriContainer[k], v)

			if attrInfo then
				table.insert(changeContainer, attrInfo)
			end
		end

		local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

		if heroMainDlg then
			local stepUpPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.STAGE_UP]

			if stepUpPanel and stepUpPanel:getVisible() and not stepUpPanel.showSkill then
				stepUpPanel:onBtnSkillClick()
			end
		end
	else
		for k, v in pairs(targetContainer) do
			if not STAR_UP_SHIELD_ATTR[k] then
				local attrInfo = self:genAttrInfo(k, oriContainer[k], v)

				if attrInfo then
					table.insert(changeContainer, attrInfo)
				end
			end
		end

		local starPropOri = ResStar[hero.resData.star_prop_id][hero.star - 1]
		local starPropTar = ResStar[hero.resData.star_prop_id][hero.star]

		if starPropOri.max_level ~= starPropTar.max_level then
			local attrInfo = {}

			attrInfo.attrName = Lang.get(30361)
			attrInfo.oriValue = string.format(Lang.get(30171), starPropOri.max_level)
			attrInfo.tarValue = string.format(Lang.get(30171), starPropTar.max_level)

			table.insert(changeContainer, attrInfo)
		end
	end

	for i, v in ipairs(changeContainer) do
		self.attrPanelList[i]:setData(v.attrName, v.oriValue, v.tarValue)
	end

	if upgradeType == 1 then
		for i, v in ipairs(changeContainer) do
			local afterRankValue = CurAvatar:getHeroPropValueByStep(self.attrNameMap[v.attrName], hero)
			local afterIconInfo = UIConst.HERO_PROP_RANK_ICON[CurAvatar:getHeroPropRank(self.attrNameMap[v.attrName], afterRankValue)]
			local beforeRankValue = CurAvatar:getHeroPropValueByStep(self.attrNameMap[v.attrName], hero, hero.battleStep - 1)
			local beforeIconInfo = UIConst.HERO_PROP_RANK_ICON[CurAvatar:getHeroPropRank(self.attrNameMap[v.attrName], beforeRankValue)]

			self.attrPanelList[i]:setRankIcon(beforeIconInfo, afterIconInfo)
		end
	end

	for i = #changeContainer + 1, 5 do
		self.attrPanelList[i]:setVisible(false)
	end
end

function HeroUpgradeResultDlg:genAttrInfo(attrName, oriAttr, tarAttr)
	if oriAttr and tarAttr ~= oriAttr and type(oriAttr) == "number" then
		local attrInfo = {}
		local tarValue = tarAttr or 0
		local attrFromPlayer = self.upgradeType == 1
		local tarZhName, tarValueStr = ClientUtils.getRolePropZhName(attrName, tarValue, attrFromPlayer)
		local oriValue = oriAttr or 0
		local oriZhName, oriValueStr = ClientUtils.getRolePropZhName(attrName, oriValue, attrFromPlayer)

		attrInfo.attrName = tarZhName
		attrInfo.oriValue = oriValueStr
		attrInfo.tarValue = tarValueStr
		self.attrNameMap[tarZhName] = attrName

		return attrInfo
	end
end

function HeroUpgradeResultDlg:onClose()
	HeroUpgradeResultDlg.super.onClose(self)

	if self.upgradeType == 1 then
		local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

		if heroMainDlg then
			heroMainDlg.heroContentPanel:playSkillUpEfx(self.hero.recharge)
		end
	end
end

return HeroUpgradeResultDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SingleArtifactTipsChild.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResHero = require("ClientData/ResHero")
local ArtifactTipsAttrCell = require("UI/Common/Tips/ArtifactTipsAttrCell")
local SingleArtifactTipsChild = Class("SingleArtifactTipsChild", UIControls.Child)

function SingleArtifactTipsChild:ctor()
	self:initUI()
end

function SingleArtifactTipsChild:initUI()
	self.attrCells = {}

	for i = 1, Const.MAX_NUMBER_ARTIFACT_ATTR do
		local cell = ArtifactTipsAttrCell(self, "AttrPanel/Attr0" .. i)

		table.insert(self.attrCells, cell)
	end

	self.gridArtifact = UIControls.ArtifactGridChild(self, "GridPanel", "System/Common/Grid/GridBadgeSmallItem", 0, 0, true)
	self.gridArtifact.mEnableTips = false
	self.textDesc = UIControls.Label(self, "TextDes")
	self.txtCareer = UIControls.Label(self, "TextName/TextCareer")
	self.panelSkill = UIControls.Panel(self, "SkillPanel")
	self.imgSkill = UIControls.Image(self, "SkillPanel/Icon")
	self.textSkill = UIControls.Label(self, "SkillPanel/TextTitle")
	self.textSkillDesc = UIControls.Label(self, "SkillPanel/TextDesPanel/Content/TextDes")
	self.textSkillLvMax = UIControls.Label(self, "SkillPanel/TextLvMax")
	self.textSkillLv = UIControls.Label(self, "SkillPanel/TextLvMax/TextLv")
	self.textName = UIControls.Label(self, "TextName")
end

function SingleArtifactTipsChild:setItem(artifact)
	if not artifact.resData then
		return
	end

	self.gridArtifact:setObj(artifact)
	self.gridArtifact.txtSkillLv:setVisible(false)

	if self.textDesc then
		self.textDesc:setText(artifact.resData.desc or "")
	end

	if artifact.resData.career_tips then
		self.txtCareer:setText(artifact.resData.career_tips)
	elseif artifact.heroId then
		if utils.tableIsContainsElement(Const.ARTIFACT_RELIC_TIPSINFO_CHANGE_LIST, artifact.heroId) then
			self.txtCareer:setText(Lang.get(56679))
		else
			self.txtCareer:setText(string.format(Lang.get(32775), ResHero[artifact.heroId].hero_name))
		end
	else
		self.txtCareer:setText(Const.CAREER_CONFIG[artifact.career].name)
	end

	local skill = self.gridArtifact.object.skill

	if skill then
		local skillPath = skill:getIconPath()

		if skillPath then
			self.imgSkill:setImage(skillPath[1], skillPath[2])
		end

		self.textSkill:setText(skill.name)
		self.textSkillDesc:setText(skill.desc)
	end

	local index = 1
	local props = artifact:getArtifactAttrs()

	for propName, propValue in pairs(props) do
		local cell = self.attrCells[index]

		if cell then
			cell:setAttr(propName, propValue)

			index = index + 1
		end
	end

	self.textName:setText(artifact.name)
	self.textSkillLv:setText(string.format(Lang.get(30171), skill.level))

	if self.textSkillLvMax then
		self.textSkillLvMax:setText(string.format(Lang.get(30171), artifact:getMaxSkillLv()))
	end
end

return SingleArtifactTipsChild

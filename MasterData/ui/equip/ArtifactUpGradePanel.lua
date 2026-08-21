-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\ArtifactUpGradePanel.lua

local SingleArtifactTipsChild = require("UI/Common/Tips/SingleArtifactTipsChild")
local ArtifactUpGradeMaterialPanel = require("UI/Equip/ArtifactUpGradeMaterialPanel")
local ResArtifactXP = require("ClientData/ResArtifactXP")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResArtifactLevelUp = require("ClientData/ResArtifactLevelUp")
local ArtifactTipsAttrCell = require("UI/Common/Tips/ArtifactTipsAttrCell")
local strClassName = "ArtifactUpGradePanel"
local ArtifactUpGradePanel = Class(strClassName, SingleArtifactTipsChild)

function ArtifactUpGradePanel:initUI()
	self.attrCells = {}

	for i = 1, Const.MAX_NUMBER_ARTIFACT_ATTR do
		local cell = ArtifactTipsAttrCell(self, "InfoList/Content/AttrPanel/Attr0" .. i)

		table.insert(self.attrCells, cell)
	end

	self.textCareer = UIControls.Label(self, "InfoList/Content/TextName/TextCareer")
	self.upgradeMaterialPanel = ArtifactUpGradeMaterialPanel(self, "BadgeUpGrade")
	self.gridArtifact = self.upgradeMaterialPanel.gridArtifact
	self.bgUpgrade = UIControls.Label(self, "InfoList/Content/BgUpgrade")
	self.textLevel = UIControls.Label(self, "InfoList/Content/BgUpgrade/Text")
	self.txtRule = UIControls.Label(self, "InfoList/Content/SkillPanel/TextRule")

	for _, cell in ipairs(self.attrCells) do
		cell.txtUpValue = UIControls.Label(cell, cell.mPath .. "/TextNum2")

		cell.txtUpValue:setVisible(false)
	end

	self.txtMaxLv = UIControls.Label(self, "InfoList/Content/AttrPanel/Attr03/TextNum")
	self.txtMaxLvUp = UIControls.Label(self, "InfoList/Content/AttrPanel/Attr03/TextNum2")
	self.txtCareer = UIControls.Label(self, "InfoList/Content/TextName/TextCareer")
	self.textName = UIControls.Label(self, "InfoList/Content/TextName")
	self.txtSkillUp = UIControls.Label(self, "InfoList/Content/SkillPanel/LvPanel/TextNum2")
	self.txtDesUp = UIControls.Label(self, "InfoList/Content/SkillPanel/TextDes1")
	self.panelSkill = UIControls.Panel(self, "InfoList/Content/SkillPanel")
	self.imgSkill = UIControls.Image(self, "InfoList/Content/SkillPanel/Icon")
	self.textSkill = UIControls.Label(self, "InfoList/Content/SkillPanel/TextTitle")
	self.textSkillDesc = UIControls.Label(self, "InfoList/Content/SkillPanel/TextDes")
	self.textSkillLv = UIControls.Label(self, "InfoList/Content/SkillPanel/LvPanel/TextLv")
	self.scrollStoryList = UIControls.ScrollView(self, "InfoList")
	self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
end

function ArtifactUpGradePanel:yieldSetScrollStatus()
	self.scrollStoryList:gotoTop()
	coroutine.step()

	local contentSize = self.scrollStoryList:getContentSize()
	local maxHeight = self.scrollStoryList:getSize().height

	if maxHeight >= contentSize[2] then
		self.scrollStoryList:cancelScroll()
	else
		self.scrollStoryList:openScroll(true)
	end
end

function ArtifactUpGradePanel:setItem(artifact)
	ArtifactUpGradePanel.super.setItem(self, artifact)
	self.gridArtifact.txtSkillLv:setVisible(false)
	self.textName:setText(artifact.name)
	self.textCareer:setText(Const.CAREER_CONFIG[artifact.career].name)
	self.upgradeMaterialPanel:setArtifact(artifact)
	self.textLevel:setVisible(artifact.enhanceLevel ~= 0)
	self.textLevel:setText("+" .. artifact.enhanceLevel)
	self.txtMaxLv:setText(ResArtifactLevelUp[artifact.breakLevel].limit_level)
	self.txtDesUp:setVisible(false)
	self.txtMaxLvUp:setVisible(false)
	self.txtSkillUp:setVisible(false)
	self.txtRule:setVisible(artifact:getSkillLevel() < artifact:getMaxSkillLv())
end

function ArtifactUpGradePanel:updateMaterial(materialItem, isAdd)
	self.upgradeMaterialPanel:updateMaterial(materialItem, isAdd)
end

function ArtifactUpGradePanel:getAddMaterialCount()
	return self.upgradeMaterialPanel:getAddMaterialCount()
end

function ArtifactUpGradePanel:showPropChange(predictLevel, predictBreak)
	local artifact = self.gridArtifact.object
	local curLv = self.gridArtifact.object.enhanceLevel
	local curBreak = self.gridArtifact.object.breakLevel

	if predictLevel - curLv > 0 or predictBreak - curBreak > 0 then
		for _, cell in ipairs(self.attrCells) do
			local predictValue = utils.getArtifactMainPropValue(artifact, cell.attrName, predictLevel, predictBreak)

			if predictValue - cell.value > 0 then
				local zhName, attrValue = ClientUtils.getRolePropZhName(cell.attrName, predictValue)

				cell.txtUpValue:setText(attrValue)
			end

			cell.txtUpValue:setVisible(predictValue - cell.value > 0)
		end

		if predictLevel - curLv > 0 then
			local oriSkillLv = artifact:getSkillLevel()
			local predictSkillLV = ResArtifactXP[artifact.resData.templete_id][predictLevel].skill_level

			self.txtSkillUp:setVisible(predictSkillLV - oriSkillLv > 0)
			self.txtSkillUp:setText(string.format(Lang.get(30171), predictSkillLV))
			self.txtDesUp:setVisible(predictSkillLV - oriSkillLv > 0)

			if ResPassiveSkill[artifact.resData.passive_id] and ResPassiveSkill[artifact.resData.passive_id][predictSkillLV] then
				self.txtDesUp:setText(ResPassiveSkill[artifact.resData.passive_id][predictSkillLV].desc)
			end
		end
	else
		for _, cell in ipairs(self.attrCells) do
			cell.txtUpValue:setVisible(false)
		end

		self.txtSkillUp:setVisible(false)
		self.txtDesUp:setVisible(false)
	end

	self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
end

function ArtifactUpGradePanel:showStarChange(predictStar, curStar)
	if predictStar - curStar > 0 then
		local curMax = ResArtifactLevelUp[curStar].limit_level
		local predictMax = ResArtifactLevelUp[predictStar].limit_level

		self.txtMaxLvUp:setVisible(true)

		if predictStar == self.gridArtifact.object:getMaxBreakLv() then
			self.txtMaxLvUp:setText("MAX")
		else
			self.txtMaxLvUp:setText(predictMax)
		end
	else
		self.txtMaxLvUp:setVisible(false)
	end
end

function ArtifactUpGradePanel:clearMaterial(props, total_xp)
	local newArtifact = CurAvatar.bagArtifacts[self.gridArtifact.object.gid]

	self:setItem(newArtifact)
	self.upgradeMaterialPanel:clearMaterial()
end

return ArtifactUpGradePanel

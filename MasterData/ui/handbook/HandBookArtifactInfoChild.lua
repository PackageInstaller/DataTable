-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookArtifactInfoChild.lua

local ArtifactTipsAttrCell = require("UI/Common/Tips/ArtifactTipsAttrCell")
local SingleArtifactTipsChild = require("UI/Common/Tips/SingleArtifactTipsChild")
local strClassName = "HandBookArtifactInfoChild"
local HandBookArtifactInfoChild = Class(strClassName, SingleArtifactTipsChild)

function HandBookArtifactInfoChild:initUI()
	self.attrCells = {}

	for i = 1, Const.MAX_NUMBER_ARTIFACT_ATTR do
		local cell = ArtifactTipsAttrCell(self, "AttrPanel/Attr0" .. i)

		table.insert(self.attrCells, cell)
	end

	self.gridArtifact = UIControls.ArtifactGridPanel(self, "InfoPanel/GridPanel/GridBadgeItem")
	self.gridArtifact.mEnableTips = false
	self.textDesc = UIControls.Label(self, "InfoPanel/TextDes")
	self.panelSkill = UIControls.Panel(self, "SkillPanel")
	self.imgSkill = UIControls.Image(self, "SkillPanel/Icon")
	self.textSkill = UIControls.Label(self, "SkillPanel/TextTitle")
	self.textSkillDesc = UIControls.Label(self, "SkillPanel/ScrollRect/Content/TextDes")
	self.textSkillLvMax = UIControls.Label(self, "SkillPanel/TextLvMax")
	self.textSkillLv = UIControls.Label(self, "SkillPanel/TextLvMax/TextLv")
	self.textName = UIControls.Label(self, "InfoPanel/TextName")
	self.imgCareer = UIControls.Image(self, "InfoPanel/IconCareer")
	self.txtCareer = UIControls.Label(self, "InfoPanel/IconCareer/TextCareer")
	self.txtGet = UIControls.Label(self, "InfoPanel/TextDes/TextGet")
	self.imgMax = UIControls.Image(self, "ImgMax")
	self.imgNow = UIControls.Image(self, "ImgNow")
end

function HandBookArtifactInfoChild:setArtifact(artifact)
	self:setItem(artifact)

	local careerPath = artifact:getCareerIconPath()

	if careerPath then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
	end

	self.txtCareer:setText(Const.CAREER_CONFIG[artifact.career].name)
	self.txtGet:setText(artifact.handInfo.get_des)
	self.imgNow:setVisible(self.mWindow.isShowGrowth == true and self.mWindow.idGrowthestArtifactDic[artifact.id] ~= nil)
	self.imgMax:setVisible(not self.imgNow:getVisible())

	local bagHad = self.mWindow.idGrowthestArtifactDic and self.mWindow.idGrowthestArtifactDic[artifact.id] ~= nil

	if self.mWindow.isShowGrowth and bagHad then
		self.gridArtifact.textLevel:setText("+" .. artifact.enhanceLevel .. "/+" .. artifact:getMaxEnhanceLv())
	end
end

return HandBookArtifactInfoChild

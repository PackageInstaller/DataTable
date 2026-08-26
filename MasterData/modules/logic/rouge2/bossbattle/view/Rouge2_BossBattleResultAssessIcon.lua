-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleResultAssessIcon.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleResultAssessIcon", package.seeall)

local Rouge2_BossBattleResultAssessIcon = class("Rouge2_BossBattleResultAssessIcon", LuaCompBase)

function Rouge2_BossBattleResultAssessIcon:init(go)
	self.viewGO = go

	self:onInitView()
end

function Rouge2_BossBattleResultAssessIcon:onInitView()
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self._goNotEmpty = gohelper.findChild(self.viewGO, "#go_NotEmpty")
	self._simageAssessIcon = gohelper.findChildSingleImage(self.viewGO, "#go_NotEmpty/#simage_AssessIcon")
	self._goAssessIcon = self._simageAssessIcon.gameObject
	self._tranAssessIcon = self._goAssessIcon.transform

	self:initEffectTab()
end

function Rouge2_BossBattleResultAssessIcon:initEffectTab()
	self._effectTab = self:getUserDataTb_()

	local childNum = self._tranAssessIcon.childCount

	for i = 1, childNum do
		local goEffect = self._tranAssessIcon:GetChild(i - 1).gameObject
		local effectName = string.lower(goEffect.name)

		self._effectTab[effectName] = goEffect

		gohelper.setActive(goEffect, false)
	end
end

function Rouge2_BossBattleResultAssessIcon:addEventListeners()
	return
end

function Rouge2_BossBattleResultAssessIcon:removeEventListeners()
	return
end

function Rouge2_BossBattleResultAssessIcon:setData(score)
	score = score or 0

	local assessCo = Rouge2_BossBattleConfig.instance:getAssessConfigByScore(score)
	local isEmpty = assessCo == nil

	gohelper.setActive(self._goNotEmpty, not isEmpty)
	gohelper.setActive(self._goEmpty, isEmpty)

	if isEmpty then
		return
	end

	Rouge2_IconHelper.setBossAssessIcon(score, self._simageAssessIcon)

	local strLevel = assessCo and assessCo.strLevel
	local lowerStrLevel = strLevel and string.lower(strLevel) or ""

	for effectName, goEffect in pairs(self._effectTab) do
		gohelper.setActive(goEffect, effectName == lowerStrLevel)
	end
end

function Rouge2_BossBattleResultAssessIcon:onDestroyView()
	self._simageAssessIcon:UnLoadImage()
end

return Rouge2_BossBattleResultAssessIcon

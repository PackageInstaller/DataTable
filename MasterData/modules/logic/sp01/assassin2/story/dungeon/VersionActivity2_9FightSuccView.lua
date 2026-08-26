-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9FightSuccView.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9FightSuccView", package.seeall)

local VersionActivity2_9FightSuccView = class("VersionActivity2_9FightSuccView", FightSuccView)
local FinishFlagAlpha = 1
local UnFinishFlagAlpha = 0.37
local FinishProgressIconAlpha = 1
local UnFinishProgressIconAlpha = 0.39

function VersionActivity2_9FightSuccView:onOpen()
	VersionActivity2_9FightSuccView.super.onOpen(self)

	local conditionText = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())

	self:_showPlatCondition(conditionText, self._goCondition, nil, DungeonEnum.StarType.Normal)
end

function VersionActivity2_9FightSuccView:_showPlatCondition(platConditionText, go, starImage, targetStarNum)
	if string.nilorempty(platConditionText) then
		gohelper.setActive(go, false)
	else
		gohelper.setActive(go, true)

		local resultStar = tonumber(FightResultModel.instance.star) or 0

		if resultStar < targetStarNum then
			gohelper.findChildText(go, "condition").text = gohelper.getRichColorText(platConditionText, "#6C6C6B")

			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(go, "image_gou"), UnFinishFlagAlpha)
			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(go, "star"), UnFinishProgressIconAlpha)
			SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildImage(go, "star"), "#FFFFFF")
		else
			gohelper.findChildText(go, "condition").text = gohelper.getRichColorText(platConditionText, "#C4C0BD")

			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(go, "image_gou"), FinishFlagAlpha)
			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(go, "star"), FinishProgressIconAlpha)
			SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildImage(go, "star"), "#FFFFFF")
		end

		VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(self._curEpisodeId, gohelper.findChildImage(go, "star"))
	end
end

function VersionActivity2_9FightSuccView:_addItem(material, customRefreshCallback, customRefreshCallbackParam)
	local go = gohelper.clone(self._bonusItemGo, self._bonusItemContainer, material.id)
	local itemIconGO = gohelper.findChild(go, "container/itemIcon")
	local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemIconGO)
	local tagGO = gohelper.findChild(go, "container/tag")
	local imgFirstGO = gohelper.findChild(go, "container/tag/imgFirst")
	local imgFirstHardGO = gohelper.findChild(go, "container/tag/imgFirstHard")
	local imgFirstSimpleGO = gohelper.findChild(go, "container/tag/imgFirstSimple")
	local imgNormalGO = gohelper.findChild(go, "container/tag/imgNormal")
	local imgAdvanceGO = gohelper.findChild(go, "container/tag/imgAdvance")
	local imgEquipDailyGO = gohelper.findChild(go, "container/tag/imgEquipDaily")
	local imgTimeFirstGO = gohelper.findChild(go, "container/tag/limitfirstbg")
	local actTagGo = gohelper.findChild(go, "container/tag/imgact")
	local containerGO = gohelper.findChild(go, "container")
	local goprogress = gohelper.findChild(go, "container/tag/#go_progress")
	local imageprogress = gohelper.findChildImage(go, "container/tag/#go_progress/#image_icon")
	local txtprogress = gohelper.findChildText(go, "container/tag/#go_progress/#txt_progress")

	gohelper.setActive(containerGO, false)
	gohelper.setActive(tagGO, material.bonusTag)

	if material.bonusTag then
		local isShowProgressTag = material.bonusTag == FightEnum.FightBonusTag.AdvencedBonus or material.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus

		gohelper.setActive(imgFirstGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and self._normalMode)
		gohelper.setActive(imgFirstHardGO, material.bonusTag == FightEnum.FightBonusTag.FirstBonus and self._hardMode)
		gohelper.setActive(imgNormalGO, false)
		gohelper.setActive(imgAdvanceGO, material.bonusTag == FightEnum.FightBonusTag.AdvencedBonus and not isShowProgressTag)
		gohelper.setActive(imgEquipDailyGO, material.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
		gohelper.setActive(imgTimeFirstGO, material.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus and not isShowProgressTag)
		gohelper.setActive(actTagGo, material.bonusTag == FightEnum.FightBonusTag.ActBonus)
		gohelper.setActive(imgFirstSimpleGO, material.bonusTag ~= FightEnum.FightBonusTag.SimpleBouns and FightEnum.FightBonusTag.FirstBonus and self._simpleMode or true)
		gohelper.setActive(goprogress, isShowProgressTag)

		if isShowProgressTag then
			VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(self._curEpisodeId, imageprogress)

			if material.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus then
				if not DungeonEnum.StarType.Normal then
					local starType = DungeonEnum.StarType.Advanced

					VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(self._curEpisodeId, starType, txtprogress)
				end
			end
		end
	end

	material.isIcon = true

	itemIcon:onUpdateMO(material)
	itemIcon:setCantJump(true)
	itemIcon:setCountFontSize(40)
	itemIcon:setAutoPlay(true)
	itemIcon:isShowEquipRefineLv(true)
	itemIcon:isShowAddition((material.bonusTag and material.bonusTag == FightEnum.FightBonusTag.AdditionBonus or nil) and true)

	if customRefreshCallback then
		customRefreshCallback(self, itemIcon, customRefreshCallbackParam)
	end

	gohelper.setActive(go, false)

	local canvasGroup = tagGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	canvasGroup.alpha = 0

	self:applyBonusVfx(material, go)

	return containerGO, go
end

return VersionActivity2_9FightSuccView

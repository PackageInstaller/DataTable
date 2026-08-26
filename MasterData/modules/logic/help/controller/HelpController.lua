-- chunkname: @modules/logic/help/controller/HelpController.lua

module("modules.logic.help.controller.HelpController", package.seeall)

local HelpController = class("HelpController", BaseController)

function HelpController:onInit()
	return
end

function HelpController:onInitFinish()
	return
end

function HelpController:addConstEvents()
	return
end

function HelpController:canShowFirstHelp(helpId)
	if ViewMgr.instance._openViewNameSet[ViewName.SkinOffsetAdjustView] then
		return
	end

	if GuideModel.instance:isDoingClickGuide() then
		return
	end

	if not GuideController.instance:isForbidGuides() then
		local guideId = GuideModel.instance:getDoingGuideId()

		if guideId then
			return
		end

		if helpId == HelpEnum.HelpId.Dungeon and DungeonModel.instance:hasPassLevel(10115) then
			return
		end
	end

	if HelpModel.instance:isShowedHelp(helpId) then
		return
	end

	if not self:checkGuideStepLock(helpId) then
		return
	end

	return true
end

function HelpController:tryShowFirstHelp(helpId, param)
	if not self:canShowFirstHelp(helpId) then
		return
	end

	self:showHelp(helpId, true)
end

function HelpController:showHelp(helpId, auto)
	ViewMgr.instance:openView(ViewName.HelpView, {
		id = helpId,
		auto = auto
	})
end

function HelpController:checkGuideStepLock(helpId)
	if not helpId then
		return false
	end

	local helpCo = HelpConfig.instance:getHelpCO(helpId)

	if not helpCo then
		logError("please check help config, not found help Config!, help id is " .. helpId)
	end

	local pageIdList = string.splitToNumber(helpCo.page, "#")
	local result = false

	for _, pageId in ipairs(pageIdList) do
		local pageCo = HelpConfig.instance:getHelpPageCo(pageId)

		if self:canShowPage(pageCo) then
			result = true

			break
		end
	end

	return result
end

function HelpController:canShowPage(pageCo)
	return pageCo.unlockGuideId == 0 or GuideModel.instance:isGuideFinish(pageCo.unlockGuideId)
end

function HelpController:canShowVideo(videoCo)
	return videoCo.unlockGuideId == 0 or GuideModel.instance:isGuideFinish(videoCo.unlockGuideId)
end

function HelpController:openStoreTipView(desc, optTitle)
	local viewParam = {
		desc = desc,
		title = optTitle
	}

	ViewMgr.instance:openView(ViewName.StoreTipView, viewParam)
end

function HelpController:openBpRuleTipsView(title, titleEn, ruleDesc)
	local viewParam = {
		title = title,
		titleEn = titleEn,
		ruleDesc = ruleDesc
	}

	ViewMgr.instance:openView(ViewName.BpRuleTipsView, viewParam)
end

HelpController.instance = HelpController.New()

return HelpController

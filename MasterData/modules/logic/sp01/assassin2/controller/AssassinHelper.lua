-- chunkname: @modules/logic/sp01/assassin2/controller/AssassinHelper.lua

module("modules.logic.sp01.assassin2.controller.AssassinHelper", package.seeall)

local AssassinHelper = _M

function AssassinHelper.setQuestTypeIcon(questType, imgComp)
	if gohelper.isNil(imgComp) then
		logError("AssassinHelper.setQuestTypeIcon error, imgComp is nil")

		return
	end

	local icon = AssassinConfig.instance:getQuestTypeIcon(questType)

	UISpriteSetMgr.instance:setSp01AssassinSprite(imgComp, icon)
end

function AssassinHelper.setAssassinItemIcon(assassinItemId, imgComp)
	if gohelper.isNil(imgComp) then
		logError("AssassinHelper.setAssassinItemIcon error, imgComp is nil")

		return
	end

	local icon = AssassinConfig.instance:getAssassinItemIcon(assassinItemId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(imgComp, icon)
end

function AssassinHelper.setAssassinActIcon(actId, imgComp)
	if gohelper.isNil(imgComp) then
		return
	end

	local icon = AssassinConfig.instance:getAssassinActIcon(actId)

	if string.nilorempty(icon) then
		gohelper.setActive(imgComp, false)
	else
		UISpriteSetMgr.instance:setSp01AssassinSprite(imgComp, icon)
		gohelper.setActive(imgComp, true)
	end
end

function AssassinHelper.setAssassinSkillIcon(skillId, imgComp)
	if gohelper.isNil(imgComp) then
		logError("AssassinHelper.setAssassinSkillIcon error, imgComp is nil")

		return
	end

	local icon = AssassinConfig.instance:getAssassinSkillIcon(skillId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(imgComp, icon)
end

function AssassinHelper.lockScreen(key, lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(key)
	else
		UIBlockMgr.instance:endBlock(key)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function AssassinHelper.getPlayerCacheDataKey(key, id)
	return string.format("%s_%s", key, id)
end

function AssassinHelper.formatLv(lv)
	return string.format("Lv.%s", lv)
end

function AssassinHelper.getLibraryTopTitleByActId(actId)
	local actCo = ActivityConfig.instance:getActivityCo(actId)

	return actCo and actCo.name
end

function AssassinHelper.setLibraryIcon(libraryId, imgComp)
	if gohelper.isNil(imgComp) then
		logError("图片组件不可为空")

		return
	end

	local libraryCo = AssassinConfig.instance:getLibrarConfig(libraryId)

	if libraryCo then
		if not libraryCo.res then
			local iconName = ""
			local iconUrl = "library/" .. iconName

			imgComp:LoadImage(ResUrl.getSp01AssassinSingleBg(iconUrl))
		end
	end
end

function AssassinHelper.setLibraryToastIcon(libraryId, imgComp)
	if gohelper.isNil(imgComp) then
		logError("图片组件不可为空")

		return
	end

	local libraryCo = AssassinConfig.instance:getLibrarConfig(libraryId)

	if libraryCo then
		if not libraryCo.toastIcon then
			local iconName = ""
			local iconUrl = "library/assassinlibrarytoast_pic/" .. iconName

			imgComp:LoadImage(ResUrl.getSp01AssassinSingleBg(iconUrl))
		end
	end
end

function AssassinHelper.multipleKeys2OneKey(...)
	local paramList = {
		...
	}

	return table.concat(paramList, "_")
end

return AssassinHelper

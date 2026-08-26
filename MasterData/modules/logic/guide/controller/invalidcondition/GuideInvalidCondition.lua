-- chunkname: @modules/logic/guide/controller/invalidcondition/GuideInvalidCondition.lua

module("modules.logic.guide.controller.invalidcondition.GuideInvalidCondition", package.seeall)

local GuideInvalidCondition = _M

function GuideInvalidCondition.checkSetEquip()
	local group = HeroGroupModel.instance:getCustomHeroGroupMo(ModuleEnum.HeroGroupServerType.Equip)

	if not group then
		return false
	end

	local equipList = group:getAllPosEquips()

	for k, v in pairs(equipList) do
		if v and v.equipUid and v.equipUid[1] ~= "0" then
			return true
		end
	end

	return false
end

function GuideInvalidCondition.checkAllGroupSetEquip()
	local list = HeroGroupModel.instance:getList()

	for i, group in ipairs(list) do
		local equipList = group:getAllPosEquips()

		for k, v in pairs(equipList) do
			if v and v.equipUid and v.equipUid[1] ~= "0" then
				return true
			end
		end
	end

	return false
end

function GuideInvalidCondition.checkSummon()
	local heroMOList = HeroModel.instance:getList()

	return heroMOList and #heroMOList > 1
end

function GuideInvalidCondition.checkMainSceneSkin()
	return MainSceneSwitchModel.instance:getCurSceneId() ~= MainSceneSwitchConfig.instance:getDefaultSceneId()
end

function GuideInvalidCondition.checkFinishElement4_6()
	return DungeonMapModel.instance:elementIsFinished(1040601)
end

function GuideInvalidCondition.checkFinishGuide(guideId, params)
	return GuideModel.instance:isGuideFinish(tonumber(params[3]))
end

function GuideInvalidCondition.checkFinishGuideAndValidAct(guideId, params)
	local guideId = tonumber(params[3])
	local actId = tonumber(params[4])

	return GuideModel.instance:isGuideFinish(guideId) and ActivityHelper.getActivityStatus(actId) == ActivityEnum.ActivityStatus.Normal
end

function GuideInvalidCondition.checkViewsIsClose(guideId, params)
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return false
	end

	local views = {
		unpack(params, 3)
	}
	local isAllClose = true

	for _, viewName in pairs(views) do
		if ViewMgr.instance:isOpen(viewName) then
			isAllClose = false

			break
		end
	end

	return isAllClose
end

return GuideInvalidCondition

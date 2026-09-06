-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/controller/LTDaJiaoController.lua

module("logic.extensions.luotiandajiao.controller.LTDaJiaoController", package.seeall)

local LTDaJiaoController = class("LTDaJiaoController", BaseController)

function LTDaJiaoController:ctor()
	return
end

function LTDaJiaoController:onInit()
	return
end

function LTDaJiaoController:onReset()
	return
end

function LTDaJiaoController:getGroupList()
	local groupPlanId = LTDaJiaoModel.instance:curGroupPlanId()
	local groupCfgs = LTDaJiaoConfig.instance:getGroupCfgs(groupPlanId)

	if groupCfgs then
		local list = {}
		local totalCount = #groupCfgs
		local unlockMaxIndex = 0

		for i, v in ipairs(groupCfgs) do
			local element = {}

			element.cfg = v
			element.isPass = LTDaJiaoModel.instance:isPass(v.group)

			local isUnlock, unlockTimestamp = LTDaJiaoModel.instance:isUnlock(v.group)

			element.isUnlock = isUnlock
			element.unlockTimestamp = unlockTimestamp
			element.isSelect = false

			if element.isUnlock then
				unlockMaxIndex = i
			end

			element.isChampion = i == totalCount
			element.desc = element.isChampion and "冠军赛" or string.format("%d强赛", v.desc)

			table.insert(list, element)
		end

		if unlockMaxIndex > 0 then
			list[unlockMaxIndex].isSelect = true
		end

		return list
	else
		return {}
	end
end

LTDaJiaoController.instance = LTDaJiaoController.New()

return LTDaJiaoController

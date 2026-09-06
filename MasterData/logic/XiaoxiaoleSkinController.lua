-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/controller/XiaoxiaoleSkinController.lua

module("logic.extensions.xiaoxiaoleskin.controller.XiaoxiaoleSkinController", package.seeall)

local XiaoxiaoleSkinController = class("XiaoxiaoleSkinController", BaseController)

function XiaoxiaoleSkinController:ctor()
	return
end

function XiaoxiaoleSkinController:onInit()
	self:onReset()
end

function XiaoxiaoleSkinController:onReset()
	return
end

function XiaoxiaoleSkinController:showChangeSetInTemp(showType, activityId)
	local changeSetId = ScratchLotteryModel.instance:getChangeSetId(activityId)

	MaterialController.instance:setChangeSetPopup(changeSetId, showType)
	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function XiaoxiaoleSkinController:playEffect(view, parent, path, loop, finish)
	return (UIEffectManager.instance:playEffect(view, "20230331/pifuchoujiang/" .. path .. ".prefab", nil, 0, 0, loop, false, function(finishHandlerTarget, eff)
		finish()
	end, function(target, eff)
		local effGo = eff.effGo.transform

		goutil.addChildToParent(effGo, parent)
		Framework.TransformUtil.SetLocalPos(effGo, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(effGo, 1, 1, 1)
		eff:setEffTime(1)
	end))
end

XiaoxiaoleSkinController.instance = XiaoxiaoleSkinController.New()

return XiaoxiaoleSkinController

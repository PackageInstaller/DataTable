-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/controller/TimeCapsuleController.lua

module("logic.extensions.timecapsule.controller.TimeCapsuleController", package.seeall)

local TimeCapsuleController = class("TimeCapsuleController", BaseController)

function TimeCapsuleController:ctor()
	TimeCapsuleController.super.ctor(self)
end

function TimeCapsuleController:onInit()
	TimeCapsuleController.super.onInit(self)
end

function TimeCapsuleController:onReset()
	TimeCapsuleController.super.onReset(self)
end

function TimeCapsuleController:pageRed(page)
	local noteInfos = TimeCapsuleModel.instance:getNoteInfoByPage(page)

	return noteInfos[1] and not noteInfos[1].active
end

function TimeCapsuleController:getActivityTime()
	local startTime = GameUtil.string2date(TimeCapsuleConfig.instance:getCommonValue("ACT_START_TIME"))
	local endTime = GameUtil.string2date(TimeCapsuleConfig.instance:getCommonValue("ACT_END_TIME"))

	return string.format("活动时间:%d月%d日%d:%02d-%d月%d日%d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function TimeCapsuleController:showCI()
	if TimeCapsuleModel.instance:getTreasureNoteId() then
		local effPath = "fx_ui_shiguangjiaonang/fx_ui_jiaonang.prefab"

		ViewBlockMgr.instance:blockClick(true, kBlockKeyViewLoading)
		UIEffectManager.instance:playScreenEffect(effPath, Vector3.New(), false, nil, nil, function(finishHandler, eff)
			eff:setScale(0.05)
			eff:setLocalPos(0, -0.1, 0.5)
			settimer(1.2, function()
				ViewBlockMgr.instance:blockClick(false, kBlockKeyViewLoading)
				UIStateManager.instance:push(ViewName.NoteView, TimeCapsuleModel.instance:getTreasureNoteId(), function()
					TimeCapsuleModel.instance:setTreasureNoteId(nil)
					UIStateManager.instance:push(ViewName.TimeCapsuleView)
				end)
			end, nil, false)
		end)
	else
		TreasureNewController.instance:showCI()
	end
end

TimeCapsuleController.instance = TimeCapsuleController.New()

return TimeCapsuleController

-- chunkname: @modules/logic/versionactivity2_8/activity2nd/controller/Activity2ndController.lua

module("modules.logic.versionactivity2_8.activity2nd.controller.Activity2ndController", package.seeall)

local Activity2ndController = class("Activity2ndController", BaseController)

function Activity2ndController:onInit()
	return
end

function Activity2ndController:onInitFinish()
	return
end

function Activity2ndController:addConstEvents()
	return
end

function Activity2ndController:enterActivity2ndMainView()
	if ActivityHelper.isOpen(ActivityEnum.Activity.V2a8_PVPopupReward) then
		Activity101Rpc.instance:sendGet101InfosRequest(ActivityEnum.Activity.V2a8_PVPopupReward)
	end

	Activity196Rpc.instance:sendGet196InfoRequest(Activity196Enum.ActId, self._openMainView, self)
end

function Activity2ndController:_openMainView()
	local param = {
		actId = Activity196Enum.ActId
	}

	ViewMgr.instance:openView(ViewName.Activity2ndCollectionPageView, param)
end

function Activity2ndController:trySendText(str)
	local strList = Activity2ndConfig.instance:getStrList()
	local id = 0

	for _, codeCo in ipairs(strList) do
		if string.upper(codeCo.code) == str then
			id = codeCo.id

			break
		end
	end

	if id ~= 0 then
		local hasReceied = Activity196Model.instance:checkRewardReceied(id)

		if not hasReceied then
			Activity196Rpc.instance:sendAct196GainRequest(Activity196Enum.ActId, id)

			id = 0
		else
			self:dispatchEvent(Activity2ndEvent.InputErrorOrHasReward, luaLang(Activity2ndEnum.ShowTipsType.HasGetReward))
		end
	else
		self:dispatchEvent(Activity2ndEvent.InputErrorOrHasReward, luaLang(Activity2ndEnum.ShowTipsType.Error))
	end
end

function Activity2ndController:statButtonClick(actId)
	StatController.instance:track(StatEnum.EventName.Activity2ndPageButtonClick, {
		[StatEnum.EventProperties.ButtonName] = Activity2ndEnum.StatButtonName[actId]
	})
end

function Activity2ndController:statTakePhotos(id, result)
	if result then
		if not StatEnum.Result.Success then
			local result = StatEnum.Result.Fail

			StatController.instance:track(StatEnum.EventName.Activity2ndTakePhotoGame, {
				[StatEnum.EventProperties.EpisodeId] = tostring(id),
				[StatEnum.EventProperties.Result] = result
			})
		end
	end
end

function Activity2ndController:reInit()
	return
end

Activity2ndController.instance = Activity2ndController.New()

return Activity2ndController

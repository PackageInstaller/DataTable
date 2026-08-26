-- chunkname: @modules/logic/survival/controller/work/SurvivalSceneOperationLogPushWork.lua

module("modules.logic.survival.controller.work.SurvivalSceneOperationLogPushWork", package.seeall)

local SurvivalSceneOperationLogPushWork = class("SurvivalSceneOperationLogPushWork", SurvivalMsgPushWork)

function SurvivalSceneOperationLogPushWork:onStart(context)
	local npcItems

	for k, v in ipairs(self._msg.data) do
		local logMo = SurvivalLogMo.New()

		logMo:init(v)
		SurvivalController.instance:showToast(logMo:getLogStr())

		if logMo.isNpcRecr then
			npcItems = npcItems or {}

			local itemMo = SurvivalBagItemMo.New()

			itemMo:init({
				count = 1,
				id = logMo.isNpcRecr
			})
			table.insert(npcItems, itemMo)
		end
	end

	if npcItems then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
			items = npcItems,
			title = luaLang("survival_reward_npc_title")
		})
	else
		self:onDone(true)
	end
end

function SurvivalSceneOperationLogPushWork:onViewClose(viewName)
	if viewName == ViewName.SurvivalGetRewardView then
		self:onDone(true)
	end
end

function SurvivalSceneOperationLogPushWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onViewClose, self)
end

return SurvivalSceneOperationLogPushWork

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/controller/ConsumelotteryController.lua

module("logic.extensions.consumelottery.controller.ConsumelotteryController", package.seeall)

local ConsumelotteryController = class("ConsumelotteryController", BaseController)

ConsumelotteryController.PM_ConsumeLotteryGetInfoRes = "ConsumelotteryController.PM_ConsumeLotteryGetInfoRes"
ConsumelotteryController.PM_ConsumeLotteryDrawRes = "ConsumelotteryController.PM_ConsumeLotteryDrawRes"
ConsumelotteryController.PM_ConsumeLotteryGetAddressInfoRes = "ConsumelotteryController.PM_ConsumeLotteryGetAddressInfoRes"
ConsumelotteryController.PM_ConsumeLotteryUpdateAddressInfoRes = "ConsumelotteryController.PM_ConsumeLotteryUpdateAddressInfoRes"

function ConsumelotteryController:ctor()
	return
end

function ConsumelotteryController:onInit()
	GlobalDispatcher:addListener(ConsumeLotteryAgent.PM_ConsumeLotteryGetInfoRes, self._PM_ConsumeLotteryGetInfoRes, self)
	GlobalDispatcher:addListener(ConsumeLotteryAgent.PM_ConsumeLotteryDrawRes, self._PM_ConsumeLotteryDrawRes, self)
	GlobalDispatcher:addListener(ConsumeLotteryAgent.PM_ConsumeLotteryGetAddressInfoRes, self._PM_ConsumeLotteryGetAddressInfoRes, self)
	GlobalDispatcher:addListener(ConsumeLotteryAgent.PM_ConsumeLotteryUpdateAddressInfoRes, self._PM_ConsumeLotteryUpdateAddressInfoRes, self)
	self:onReset()
end

function ConsumelotteryController:onReset()
	self._drawChangeSetId = nil
end

function ConsumelotteryController:openView()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ConsumeLottery)

	if cfg then
		UIStateManager.instance:push(ViewName.ConsumelotterymainView, cfg.activityId)
	else
		FloatWordMgr.instance:show("不在活动开放时间内")
	end
end

function ConsumelotteryController:_PM_ConsumeLotteryGetInfoRes(status, msg)
	if status == 0 then
		ConsumelotteryModel.instance:setConsumeLotteryInfo(msg)
	end

	GlobalDispatcher:dispatch(ConsumelotteryController.PM_ConsumeLotteryGetInfoRes, status, msg)
end

function ConsumelotteryController:_PM_ConsumeLotteryDrawRes(status, msg)
	if status == 0 then
		self._drawChangeSetId = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		ConsumelotteryModel.instance:lotteryDrawRes(msg)

		if not ViewMgr.instance:isOpen(ViewName.ConsumelotterydrawView) then
			self:showLotteryResault()
		end
	end

	GlobalDispatcher:dispatch(ConsumelotteryController.PM_ConsumeLotteryDrawRes, status, msg)
end

function ConsumelotteryController:showLotteryResault()
	if self._drawChangeSetId then
		MaterialController.instance:showChangeSetInTemp(self._drawChangeSetId)

		self._drawChangeSetId = nil
	end
end

function ConsumelotteryController:_PM_ConsumeLotteryGetAddressInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(ConsumelotteryController.PM_ConsumeLotteryGetAddressInfoRes, status, msg)
end

function ConsumelotteryController:_PM_ConsumeLotteryUpdateAddressInfoRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("提交成功")
	end

	GlobalDispatcher:dispatch(ConsumelotteryController.PM_ConsumeLotteryUpdateAddressInfoRes, status, msg)
end

ConsumelotteryController.instance = ConsumelotteryController.New()

return ConsumelotteryController

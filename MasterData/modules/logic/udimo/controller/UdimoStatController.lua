-- chunkname: @modules/logic/udimo/controller/UdimoStatController.lua

module("modules.logic.udimo.controller.UdimoStatController", package.seeall)

local UdimoStatController = class("UdimoStatController", BaseController)

function UdimoStatController:onInit()
	return
end

function UdimoStatController:onInitFinish()
	return
end

function UdimoStatController:addConstEvents()
	return
end

function UdimoStatController:_resetWaitEnterUdimoLock()
	return
end

function UdimoStatController:_tryCallMethodName(method)
	xpcall(self[method], __G__TRACKBACK__, self)
end

function UdimoStatController:gameSetting(settingId)
	local var_6_0 = {
		[StatEnum.EventProperties.SettingKey] = "udimo"
	}

	var_6_0[StatEnum.EventProperties.SettingValue] = UdimoConfig.instance:getSettingName(settingId) or ""

	StatController.instance:track(StatEnum.EventName.UdimoGameSettings, var_6_0)
end

function UdimoStatController:udimoViewOperation(operationType, useTime)
	local USE_SIGN = UdimoItemModel.USE_SIGN
	local infoList = {}
	local udimoMOList = UdimoModel.instance:getList()
	local typeStr = "udimo"

	for _, udimoMO in ipairs(udimoMOList) do
		table.insert(infoList, {
			id = udimoMO:getId(),
			type = typeStr,
			use = udimoMO:getIsUse() and USE_SIGN or 0
		})
	end

	local deInfoList = UdimoItemModel.instance:getDecorationInfoList()

	if deInfoList then
		typeStr = "udimoDecoration"

		for _, deInfo in ipairs(deInfoList) do
			table.insert(infoList, {
				id = deInfo.decorationId,
				type = typeStr,
				use = deInfo.isUse
			})
		end
	end

	local bgInfoList = UdimoItemModel.instance:getBgInfoByList()

	if bgInfoList then
		typeStr = "udimoBackground "

		for _, bgInfo in ipairs(bgInfoList) do
			table.insert(infoList, {
				id = bgInfo.backgroundId,
				type = typeStr,
				use = bgInfo.isUse
			})
		end
	end

	local var_7_0 = {}

	var_7_0[StatEnum.EventProperties.ViewName] = UdimoModel.instance:getResumeViewName() or ""
	var_7_0[StatEnum.EventProperties.OperationType] = operationType or ""
	var_7_0[StatEnum.EventProperties.UseTime] = useTime or 0
	var_7_0[StatEnum.EventProperties.UdimoInfo] = infoList

	StatController.instance:track(StatEnum.EventName.UdimoViewOperation, var_7_0)
end

function UdimoStatController:udimoOperation(udimoId, interactId, friendId)
	local obj = {
		udimo_id = udimoId
	}

	if interactId then
		obj.interact_id = interactId
	end

	if friendId then
		obj.friend_id = friendId
	end

	StatController.instance:track(StatEnum.EventName.UdimoOperation, {
		[StatEnum.EventProperties.UdimoInteractObj] = obj
	})
end

UdimoStatController.instance = UdimoStatController.New()

return UdimoStatController

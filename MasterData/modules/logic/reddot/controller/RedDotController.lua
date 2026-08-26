-- chunkname: @modules/logic/reddot/controller/RedDotController.lua

module("modules.logic.reddot.controller.RedDotController", package.seeall)

local RedDotController = class("RedDotController", BaseController)

function RedDotController:onInit()
	self:reInit()
end

function RedDotController:reInit()
	TaskDispatcher.cancelTask(self._checkExpire, self)
end

function RedDotController:onInitFinish()
	return
end

function RedDotController:addConstEvents()
	return
end

function RedDotController:addNotEventRedDot(parentGo, checkFunc, checkFuncObj, showType)
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(parentGo, CommonRedDotIconNoEvent)

	comp:setShowType(showType)
	comp:setCheckShowRedDotFunc(checkFunc, checkFuncObj)

	return comp
end

function RedDotController:addRedDotTag(parentGo, id, reverse, overrideRefreshFunc, overrideRefreshFuncObj)
	local tagCom = MonoHelper.addNoUpdateLuaComOnceToGo(parentGo, CommonRedDotTag)

	tagCom:setId(id, reverse)
	tagCom:overrideRefreshDotFunc(overrideRefreshFunc, overrideRefreshFuncObj)
	tagCom:refreshDot()

	return tagCom
end

function RedDotController:addRedDot(parentGo, id, uid, overrideRefreshFunc, overrideRefreshFuncObj)
	return self:addMultiRedDot(parentGo, {
		{
			id = id,
			uid = uid
		}
	}, overrideRefreshFunc, overrideRefreshFuncObj)
end

function RedDotController:addMultiRedDot(parentGo, infoList, overrideRefreshFunc, overrideRefreshFuncObj)
	local icon = MonoHelper.getLuaComFromGo(parentGo, CommonRedDotIcon)

	icon = icon or MonoHelper.addNoUpdateLuaComOnceToGo(parentGo, CommonRedDotIcon)

	icon:setMultiId(infoList)
	icon:overrideRefreshDotFunc(overrideRefreshFunc, overrideRefreshFuncObj)
	icon:refreshDot()

	return icon
end

function RedDotController:getRedDotComp(parentGo)
	return (MonoHelper.getLuaComFromGo(parentGo, CommonRedDotIcon))
end

function RedDotController:CheckExpireDot()
	TaskDispatcher.cancelTask(self._checkExpire, self)
	TaskDispatcher.runRepeat(self._checkExpire, self, 1)
end

function RedDotController:_checkExpire()
	local time = RedDotModel.instance:getLatestExpireTime()

	if time == 0 then
		TaskDispatcher.cancelTask(self._checkExpire, self)

		return
	end

	if time <= ServerTime.now() then
		TaskDispatcher.cancelTask(self._checkExpire, self)
		RedDotRpc.instance:sendGetRedDotInfosRequest()
	end
end

RedDotController.instance = RedDotController.New()

return RedDotController

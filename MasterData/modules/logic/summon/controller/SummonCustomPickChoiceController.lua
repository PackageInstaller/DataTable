-- chunkname: @modules/logic/summon/controller/SummonCustomPickChoiceController.lua

module("modules.logic.summon.controller.SummonCustomPickChoiceController", package.seeall)

local SummonCustomPickChoiceController = class("SummonCustomPickChoiceController", BaseController)

function SummonCustomPickChoiceController:onOpenView(poolId)
	SummonCustomPickChoiceListModel.instance:initDatas(poolId)
	self:dispatchEvent(SummonEvent.onCustomPickListChanged)
end

function SummonCustomPickChoiceController:onCloseView()
	return
end

function SummonCustomPickChoiceController:trySendChoice()
	local poolId = SummonCustomPickChoiceListModel.instance:getPoolId()
	local poolMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if not poolMO or not poolMO:isOpening() then
		return false
	end

	local selectList = SummonCustomPickChoiceListModel.instance:getSelectIds()

	if not selectList then
		return false
	end

	local maxSelectCount = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()

	if maxSelectCount > #selectList then
		if maxSelectCount == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		if maxSelectCount == 2 then
			GameFacade.showToast(ToastEnum.SummonCustomPickTwoMoreSelect)
		end

		if maxSelectCount == 3 then
			GameFacade.showToast(ToastEnum.SummonCustomPickThreeMoreSelect)
		end

		return false
	end

	local heroNameStr = self:getSelectHeroNameStr(selectList)
	local msgId, poolName = self:getConfirmParam(selectList)
	local isStrongPool = SummonConfig.instance:isStrongCustomChoice(poolId)

	if isStrongPool then
		self:realSendChoice()
	else
		GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSendChoice, nil, nil, self, nil, nil, heroNameStr, poolName)
	end
end

function SummonCustomPickChoiceController:realSendChoice()
	local poolId = SummonCustomPickChoiceListModel.instance:getPoolId()
	local isStrongPool = SummonConfig.instance:isStrongCustomChoice(poolId)

	if isStrongPool then
		local selectList = SummonCustomPickChoiceListModel.instance:getSelectIds()

		SummonRpc.instance:sendChooseEnhancedPoolHeroRequest(poolId, selectList[1])
	else
		local selectList = SummonCustomPickChoiceListModel.instance:getSelectIds()

		SummonRpc.instance:sendChooseDoubleUpHeroRequest(poolId, selectList)
	end
end

function SummonCustomPickChoiceController:getSelectHeroNameStr(selectList)
	local heroNameStr = ""

	for i = 1, #selectList do
		local heroCo = HeroConfig.instance:getHeroCO(selectList[i])

		heroNameStr = i == 1 and heroCo.name or heroNameStr .. ", " .. heroCo.name
	end

	return heroNameStr
end

function SummonCustomPickChoiceController:getConfirmParam(selectList)
	local poolId = SummonCustomPickChoiceListModel.instance:getPoolId()
	local poolCo = SummonConfig.instance:getSummonPool(poolId)

	if poolCo.type == SummonEnum.Type.StrongCustomOnePick then
		return MessageBoxIdDefine.SummonStrongCustomPickConfirm, poolCo.nameCn
	else
		return MessageBoxIdDefine.SummonCustomPickConfirm, poolCo.nameCn
	end
end

function SummonCustomPickChoiceController:setSelect(heroId)
	local selectList = SummonCustomPickChoiceListModel.instance:getSelectIds()
	local maxSelectCount = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()

	if maxSelectCount == 1 then
		SummonCustomPickChoiceListModel.instance:clearSelectIds()
	elseif not SummonCustomPickChoiceListModel.instance:isHeroIdSelected(heroId) and maxSelectCount <= #selectList then
		if maxSelectCount == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOnePleaseCancel)
		end

		if maxSelectCount == 2 then
			GameFacade.showToast(ToastEnum.SummonCustomPickTwoPleaseCancel)
		end

		if maxSelectCount == 3 then
			GameFacade.showToast(ToastEnum.SummonCustomPickThreePleaseCancel)
		end

		return
	end

	SummonCustomPickChoiceListModel.instance:setSelectId(heroId)
	self:dispatchEvent(SummonEvent.onCustomPickListChanged)
end

SummonCustomPickChoiceController.instance = SummonCustomPickChoiceController.New()

LuaEventSystem.addEventMechanism(SummonCustomPickChoiceController.instance)

return SummonCustomPickChoiceController

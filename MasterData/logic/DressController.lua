-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/controller/DressController.lua

module("logic.extensions.dress.controller.DressController", package.seeall)

local DressController = class("DressController", BaseController)

function DressController:ctor()
	return
end

DressController.AddNewDressGoodItems = "DressShopAddNewDressGoodItems_20210927"

function DressController:onInit()
	GlobalDispatcher:addListener(ClothesAgent.NotifyClothesChangedRes, self._changeClothesRes, self)
end

function DressController:onReset()
	return
end

function DressController:showDressShopAddNewRedPoint()
	local hasShow = GameUtil.getUserDayData(DressController.AddNewDressGoodItems) ~= nil

	if hasShow then
		return
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DRESSSHOPADDNEWGOODSITEM, true)
end

function DressController:saveRedPointKeyValue()
	GameUtil.saveUserDayData(DressController.AddNewDressGoodItems, 1)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DRESSSHOPADDNEWGOODSITEM, false)
end

function DressController:sendGetNotoutInfoReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		ClothesAgent.instance:sendGetNoOutClothesReq(self._getNotoutInfoRes, self, self._errorCall)
	end
end

function DressController:_getNotoutInfoRes(msg)
	DressModel.instance:updateAfterGetNotoutDressInfo(msg)
	self:_callback()
end

function DressController:sendGetOutInfoReq(handler, handlerObj)
	if handler and handlerObj then
		if not self:_checkIsReqing() then
			self._handler = handler
			self._handlerObj = handlerObj

			ClothesAgent.instance:sendGetOutClothesReq(self._getOutInfoRes, self, self._errorCall)
		end
	else
		ClothesAgent.instance:sendGetOutClothesReq(self._getOutInfoRes, self, self._errorCall)
	end
end

function DressController:_getOutInfoRes(msg)
	DressModel.instance:updateAfterGetOutDressInfo(msg)

	local dataList = DressModel.instance:getOutDressDatas()

	if dataList and #dataList > 0 then
		UIStateManager.instance:push(ViewName.DressoutView, dataList)
	end

	self:_callback()
end

function DressController:sendSaveAvatarReq(wearingClothes_i32_Ary, handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		ClothesAgent.instance:sendSetMyAvatarReq(wearingClothes_i32_Ary, self._saveAvatarRes, self, self._errorCall)
	end
end

function DressController:_saveAvatarRes(msg)
	DressModel.instance:updateAfterSaveAvatar(msg)
	PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
		RoleModel.instance:setMyCardInfo(msg)
	end)
	self:_callback()
end

function DressController:_changeClothesRes(status, msg)
	if status == 0 then
		DressModel.instance:updateAfterGetDressInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.UpdateDressInfo)
	end
end

function DressController:_callback(...)
	local handler = self._handler
	local handlerObj = self._handlerObj

	if handler then
		if handlerObj then
			self._handler(handlerObj, ...)
		else
			handler(...)
		end
	end

	self._handler = nil
	self._handlerObj = nil
end

function DressController:_errorCall()
	self._handler = nil
	self._handlerObj = nil
end

function DressController:_checkIsReqing()
	if self._handler then
		print("_checkIsReqing")
		print(debug.traceback())
		FloatWordMgr.instance:show("Dress has sent req ")

		return true
	else
		return false
	end
end

function DressController:getDeduceCostNum(shopData, costNum, ownNum)
	if not shopData then
		return 0
	end

	local deduceCfg = shopData:getDeduceCfg()

	if not deduceCfg then
		return 0
	end

	local needNum = costNum - ownNum
	local arr = string.split(deduceCfg.deduction, ":")
	local matType = checknumber(arr[1])
	local matId = checknumber(arr[2])

	return needNum * deduceCfg.deduceFactor
end

function DressController:sendGetClothesPresetReq()
	ClothesAgent.instance:sendGetClothesPresetReq()
end

function DressController:handleGetClothesPresetRes(msg)
	DressModel.instance:handleGetClothesPresetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GetClothesPresetRes)
end

function DressController:sendUpdateClothesPresetReq(clothesPreset)
	ClothesAgent.instance:sendUpdateClothesPresetReq(clothesPreset)
end

function DressController:handleUpdateClothesPresetRes(msg)
	DressModel.instance:handleUpdateClothesPresetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateClothesPresetRes)
end

DressController.instance = DressController.New()

return DressController

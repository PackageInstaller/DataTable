-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/controller/HoshigamiController.lua

module("logic.extensions.hoshigami.controller.HoshigamiController", package.seeall)

local HoshigamiController = class("HoshigamiController", BaseController)

HoshigamiController.PM_LoadAllHoshigamiRes = "HoshigamiController.PM_LoadAllHoshigamiRes"
HoshigamiController.PM_EquipHoshigamiRes = "HoshigamiController.PM_EquipHoshigamiRes"
HoshigamiController.PM_UnloadHoshigamiRes = "HoshigamiController.PM_UnloadHoshigamiRes"
HoshigamiController.PM_UpgradeHoshigamiRes = "HoshigamiController.PM_UpgradeHoshigamiRes"
HoshigamiController.PM_DecomposeHoshigamisRes = "HoshigamiController.PM_DecomposeHoshigamisRes"
HoshigamiController.PM_GetAllHoshigamiPrefabSuitRes = "HoshigamiController.PM_GetAllHoshigamiPrefabSuitRes"
HoshigamiController.PM_SaveHoshigamiPrefabSuitRes = "HoshigamiController.PM_SaveHoshigamiPrefabSuitRes"
HoshigamiController.PM_UseHoshigamiPrefabSuitRes = "HoshigamiController.PM_UseHoshigamiPrefabSuitRes"
HoshigamiController.PM_NotifyHoshigamisChangeRes = "HoshigamiController.PM_NotifyHoshigamisChangeRes"
HoshigamiController.UpdateSelectPos = "HoshigamiController.UpdateSelectPos"
HoshigamiController.UpdateSelectPosInBag = "HoshigamiController.UpdateSelectPosInBag"
HoshigamiController.UpdateEquipRootView = "HoshigamiController.UpdateEquipRootView"
HoshigamiController.TakeOnInPrefabSuit = "HoshigamiController.TakeOnInPrefabSuit"
HoshigamiController.FilterTypeToShow = "HoshigamiController.FilterTypeToShow"

function HoshigamiController:ctor()
	return
end

function HoshigamiController:onInit()
	GlobalDispatcher:addListener(HoshigamiAgent.PM_LoadAllHoshigamiRes, self._PM_LoadAllHoshigamiRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_EquipHoshigamiRes, self._PM_EquipHoshigamiRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_UnloadHoshigamiRes, self._PM_UnloadHoshigamiRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_UpgradeHoshigamiRes, self._PM_UpgradeHoshigamiRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_DecomposeHoshigamisRes, self._PM_DecomposeHoshigamisRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_GetAllHoshigamiPrefabSuitRes, self._PM_GetAllHoshigamiPrefabSuitRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_SaveHoshigamiPrefabSuitRes, self._PM_SaveHoshigamiPrefabSuitRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_UseHoshigamiPrefabSuitRes, self._PM_UseHoshigamiPrefabSuitRes, self)
	GlobalDispatcher:addListener(HoshigamiAgent.PM_NotifyHoshigamisChangeRes, self._PM_NotifyHoshigamisChangeRes, self)
	self:onReset()
end

function HoshigamiController:onReset()
	self._isLoadAllHoshigami = false
end

function HoshigamiController:sendPM_LoadAllHoshigamiReq()
	if self._isLoadAllHoshigami then
		return
	end

	HoshigamiAgent.instance:sendPM_LoadAllHoshigamiReq()
end

function HoshigamiController:_PM_LoadAllHoshigamiRes(status, msg)
	if status == 0 then
		self._isLoadAllHoshigami = true

		HoshigamiModel.instance:seHoshigamis(msg.hoshigamis)
		BagPetsController.instance:calcAllPetHoshigamiAttr()
		GlobalDispatcher:dispatch(HoshigamiController.PM_LoadAllHoshigamiRes)
	end
end

function HoshigamiController:_PM_EquipHoshigamiRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HoshigamiController.PM_EquipHoshigamiRes)
	end
end

function HoshigamiController:_PM_UnloadHoshigamiRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HoshigamiController.PM_UnloadHoshigamiRes)
	end
end

function HoshigamiController:_PM_UpgradeHoshigamiRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HoshigamiController.PM_UpgradeHoshigamiRes)
	end
end

function HoshigamiController:_PM_DecomposeHoshigamisRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HoshigamiController.PM_DecomposeHoshigamisRes)
	end
end

function HoshigamiController:_PM_GetAllHoshigamiPrefabSuitRes(status, msg)
	if status == 0 then
		HoshigamiModel.instance:setPrefabSuit(msg.suits)
		GlobalDispatcher:dispatch(HoshigamiController.PM_GetAllHoshigamiPrefabSuitRes)
	end
end

function HoshigamiController:_PM_SaveHoshigamiPrefabSuitRes(status, msg)
	if status == 0 then
		HoshigamiModel.instance:saveHoshigamiPrefabSuit()
		GlobalDispatcher:dispatch(HoshigamiController.PM_SaveHoshigamiPrefabSuitRes)
		FloatWordMgr.instance:show("套装预设保存成功")
	end
end

function HoshigamiController:_PM_UseHoshigamiPrefabSuitRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("Todo 播特效还有啥？")
		GlobalDispatcher:dispatch(HoshigamiController.PM_UseHoshigamiPrefabSuitRes)
	end
end

function HoshigamiController:_PM_NotifyHoshigamisChangeRes(status, msg)
	if status == 0 then
		HoshigamiModel.instance:addNewHoshigamis(msg.hoshigamis)
		GlobalDispatcher:dispatch(HoshigamiController.PM_NotifyHoshigamisChangeRes)
	end
end

HoshigamiController.instance = HoshigamiController.New()

return HoshigamiController

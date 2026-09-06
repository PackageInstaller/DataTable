-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/controller/mode/TRMode_Edit.lua

module("logic.extensions.treasureraider.controller.mode.TRMode_Edit", package.seeall)

local TRMode_Edit = class("TRMode_Edit", FsmState)

TRMode_Edit.ExitFlag_Confirm = 1
TRMode_Edit.ExitFlag_Cancel = 2
TRMode_Edit.ExitFlag_Close = 3

function TRMode_Edit:ctor()
	TRMode_Edit.super.ctor(self, TREditorController.EMode_EditorMode)
end

function TRMode_Edit:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderTryEndEdit, self._onEndEdit, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderBuildingExchange, self._onExchange, self)

	self.sceneMo = TreasureRaiderModel.instance.mySceneMo
	self.buildingMap = self.sceneMo:cloneBuildings()
	self.exchangeList = {}

	TRMode_Edit.super.onEnter(self)
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderBeginEdit)
end

function TRMode_Edit:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderTryEndEdit, self._onEndEdit, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderBuildingExchange, self._onExchange, self)

	self.buildingMap = nil
	self.sceneMo = nil

	TRMode_Edit.super.onExit(self)
	self:doExitDone()
	GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderEndEdit)
end

function TRMode_Edit:onDestroy()
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderTryEndEdit, self._onEndEdit, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderBuildingExchange, self._onExchange, self)

	self.buildingMap = nil
	self.sceneMo = nil

	TRMode_Edit.super.onDestroy(self)
end

function TRMode_Edit:_onEndEdit(flag)
	if flag == TRMode_Edit.ExitFlag_Confirm then
		local req = self:_constructReq()

		if req then
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("保存地图将扣除1次编辑次数，是否确定保存"), function()
				RichManAgent.instance:sendPM_RichManEditMapReq(req)
			end)
		else
			FloatWordMgr.instance:show(lang("没有改变"))
			GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderCloseEditMapView)
		end
	elseif flag == TRMode_Edit.ExitFlag_Close then
		if self:_isBuildingLayoutChanged() then
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("当前尚未保存地图布局，是否继续退出？"), function()
				self:_resetBuildings()
				GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderCloseEditMapView)
			end)
		else
			self:_resetBuildings()
			GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderCloseEditMapView)
		end
	else
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("是否取消地图编辑?"), function()
			self:_resetBuildings()
			GlobalDispatcher:dispatch(GlobalNotify.TreasureRaiderCloseEditMapView)
		end)
	end
end

function TRMode_Edit:_onExchange(fromGridId, toGridId)
	return
end

function TRMode_Edit:_resetBuildings()
	self.sceneMo:resetBuilding(self.buildingMap)
end

function TRMode_Edit:_isBuildingLayoutChanged()
	local oldBuildingMap = self.buildingMap
	local scene = SceneMgr.instance:getCurScene()
	local newBuildingMap = scene:getSceneMo().buildingMap

	for gridId, oldBuildingMo in pairs(oldBuildingMap) do
		if not newBuildingMap[gridId] then
			return true
		end

		if newBuildingMap[gridId] ~= oldBuildingMo.__originMo then
			return true
		end
	end

	return table.nums(oldBuildingMap) ~= table.nums(newBuildingMap)
end

function TRMode_Edit:_addOnePair(req, fromGridId, toGridId)
	local editPair = RichManExtension_pb.PM_RichManEditPair()

	editPair.fromGridId = fromGridId
	editPair.toGridId = toGridId

	local serialEditPair = req.buildingGrids:add()

	serialEditPair:ParseFromString(editPair:SerializeToString())
end

function TRMode_Edit:_constructReq()
	local req = RichManExtension_pb.PM_RichManEditMapReq()

	req.activityId = TreasureRaiderConfig.instance:getActivityId()

	local scene = SceneMgr.instance:getCurScene()
	local newBuildingMap = scene:getSceneMo().buildingMap
	local oldBuildingMap = {}

	for _, oldBuildingMo in pairs(self.buildingMap) do
		oldBuildingMap[oldBuildingMo.__originMo] = oldBuildingMo
	end

	local bHasChange = false

	for _, newBuildingMo in pairs(newBuildingMap) do
		local fromGridId = oldBuildingMap[newBuildingMo].gridId
		local toGridId = newBuildingMo.gridId

		if fromGridId ~= toGridId then
			self:_addOnePair(req, fromGridId, toGridId)

			bHasChange = true
		end
	end

	if bHasChange then
		return req
	else
		return nil
	end
end

return TRMode_Edit

-- chunkname: @modules/logic/versionactivity1_8/dungeon/controller/Activity157Controller.lua

module("modules.logic.versionactivity1_8.dungeon.controller.Activity157Controller", package.seeall)

local Activity157Controller = class("Activity157Controller", BaseController)

function Activity157Controller:onInit()
	self._openBlueprintAfterFactoryMapView = false
end

function Activity157Controller:reInit()
	self:onInit()
end

function Activity157Controller:getAct157ActInfo(isToast, failedDoCb, cb, cbObj)
	local actId = Activity157Model.instance:getActId()
	local isOnline = ActivityModel.instance:isActOnLine(actId)

	if isOnline then
		Activity157Rpc.instance:sendGet157InfoRequest(actId, cb, cbObj)
	else
		if isToast then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		if failedDoCb and cb then
			cb(cbObj)
		end
	end
end

function Activity157Controller:openFactoryMapView(isOpenBlueprint)
	self._openBlueprintAfterFactoryMapView = isOpenBlueprint

	HandbookRpc.instance:sendGetHandbookInfoRequest()
	self.getAct157ActInfo(self, true, false, self._openFactoryMapViewAfterRpc, self)
end

function Activity157Controller:_openFactoryMapViewAfterRpc(cmd, resultCode, msg)
	if not resultCode or resultCode ~= 0 then
		self._openBlueprintAfterFactoryMapView = false

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryMapView)
end

function Activity157Controller:onFactoryMapViewOpen()
	if self._openBlueprintAfterFactoryMapView then
		self:openFactoryBlueprintView()
	end

	self._openBlueprintAfterFactoryMapView = false
end

function Activity157Controller:openFactoryBlueprintView()
	local isUnlockFactoryBlueprint = Activity157Model.instance:getIsUnlockFactoryBlueprint()

	if isUnlockFactoryBlueprint then
		ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryBlueprintView)
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157LockedFactoryEntrance)
	end
end

function Activity157Controller:getFactoryProduction()
	local isUnlockFactoryBlueprint = Activity157Model.instance:getIsUnlockFactoryBlueprint()

	if not isUnlockFactoryBlueprint then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotUnlockFactoryBlueprint)

		return
	end

	local canGetNum = Activity157Model.instance:getFactoryProductionNum()
	local isCanGet = canGetNum > 0
	local nextRecoverTime = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local isLastDay = string.nilorempty(nextRecoverTime)
	local isFinished = not isCanGet and isLastDay

	if isFinished then
		GameFacade.showToast(ToastEnum.V1a8Activity157FactoryProductFinish)

		return
	end

	if not isCanGet then
		GameFacade.showToast(ToastEnum.V1a8Activity157NoFactoryProduction)

		return
	end

	local actId = Activity157Model.instance:getActId()

	Activity157Rpc.instance:sendAct157AcceptProductionRequest(actId)
end

function Activity157Controller:openCompositeView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryCompositeView)
end

function Activity157Controller:enterFactoryRepairGame(componentId)
	if not componentId then
		return
	end

	local isRepaired = Activity157Model.instance:isRepairComponent(componentId)

	if isRepaired then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	Activity157RepairGameModel.instance:setGameDataBeforeEnter(componentId)
	self:initRule()
	self:refreshAllConnection()
	self:updateConnection()
	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryRepairView)
end

function Activity157Controller:factoryComposite(compositeCount, costItemCount, cb, cbObj)
	if not compositeCount or not costItemCount then
		return
	end

	local actId = Activity157Model.instance:getActId()
	local strCost = Activity157Config.instance:getAct157Const(actId, Activity157Enum.ConstId.FactoryCompositeCost)
	local param = strCost and string.split(strCost, "#")

	if ((param or nil) and ItemModel.instance:getItemQuantity(param[1], param[2])) < costItemCount then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotEnoughMaterial)

		return
	end

	Activity157Rpc.instance:sendAct157CompoundRequest(actId, compositeCount, cb, cbObj)
end

function Activity157Controller:initRule()
	self._rule = self._rule or Activity157GameRule.New()

	local w, h = Activity157RepairGameModel.instance:getGameSize()

	self._rule:setGameSize(w, h)
end

function Activity157Controller:resetGame()
	Activity157RepairGameModel.instance:resetGameData()
	self:refreshAllConnection()
	self:updateConnection()
	self:dispatchEvent(ArmPuzzlePipeEvent.ResetGameRefresh)
end

function Activity157Controller:refreshAllConnection()
	local w, h = Activity157RepairGameModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = Activity157RepairGameModel.instance:getData(x, y)

			self:refreshConnection(mo)
		end
	end
end

local LEFT = ArmPuzzlePipeEnum.dir.left
local RIGHT = ArmPuzzlePipeEnum.dir.right
local DOWN = ArmPuzzlePipeEnum.dir.down
local UP = ArmPuzzlePipeEnum.dir.up

function Activity157Controller:refreshConnection(mo)
	local x, y = mo.x, mo.y

	self._rule:setSingleConnection(x - 1, y, RIGHT, LEFT, mo)
	self._rule:setSingleConnection(x + 1, y, LEFT, RIGHT, mo)
	self._rule:setSingleConnection(x, y + 1, DOWN, UP, mo)
	self._rule:setSingleConnection(x, y - 1, UP, DOWN, mo)
end

function Activity157Controller:updateConnection()
	Activity157RepairGameModel.instance:resetEntryConnect()

	local entryTable, resultTable = self._rule:getReachTable()

	self._rule:_mergeReachDir(entryTable)
	self._rule:_unmarkBranch()

	local result = self._rule:isGameClear(resultTable)

	Activity157RepairGameModel.instance:setGameClear(result)
end

function Activity157Controller:changeDirection(x, y, needRefresh)
	local mo = self._rule:changeDirection(x, y)

	if needRefresh then
		self:refreshConnection(mo)
	end
end

function Activity157Controller:checkDispatchClear()
	if Activity157RepairGameModel.instance:getGameClear() then
		self:dispatchEvent(ArmPuzzlePipeEvent.PipeGameClear)
	end
end

Activity157Controller.instance = Activity157Controller.New()

return Activity157Controller

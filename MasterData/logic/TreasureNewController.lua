-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/controller/TreasureNewController.lua

module("logic.extensions.treasurenew.controller.TreasureNewController", package.seeall)

local json = require("cjson")
local TreasureNewController = class("TreasureNewController", BaseController)

function TreasureNewController:ctor()
	return
end

function TreasureNewController:onInit()
	GlobalDispatcher:addListener("treasure_map", self._enterTreasureState, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.sendGetInfoReq, self)
	GlobalDispatcher:addListener(NewTreasureAgent.PM_NewTreasureNotifyStartDigRes, self._onUseMap, self)
end

function TreasureNewController:onReset()
	return
end

function TreasureNewController:sendGetInfoReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		NewTreasureAgent.instance:sendPM_NewTreasureInfoReq(self._getInfoRes, self, self._errorCall)
	end
end

function TreasureNewController:_getInfoRes(msg)
	TreasureNewModel.instance:updateAfterGetInfo(msg)

	local isShowPoint = TreasureNewModel.instance:getState() ~= 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TREASUREMAP, isShowPoint)
	self:_callback()
end

function TreasureNewController:sendFinishDigReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		NewTreasureAgent.instance:sendPM_NewTreasureFinishDigReq(self._finishDigRes, self, self._errorCall)
	end
end

function TreasureNewController:_finishDigRes(msg)
	TreasureNewModel.instance:updateFinishDig(msg)
	self:_callback()
	UIStateManager.instance:popByName(ViewName.TreasurenewDigView)
	self:_openTreasureView()
end

function TreasureNewController:sendPrizeReq(handler, handlerObj)
	if not self:_checkIsReqing() then
		self._handler = handler
		self._handlerObj = handlerObj

		NewTreasureAgent.instance:sendPM_NewTreasurePrizeReq(self._prizeRes, self, self._errorCall)
	end
end

function TreasureNewController:_prizeRes(msg)
	print(">>>>>>>>>>>>>>>>>>>>>>>>>> TreasureNewController:_prizeRes(msg)")

	local ci = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(ci)

	if ci then
		self.ciList = ci
	end

	TreasureNewModel.instance:updatePrize(msg)

	local isShowPoint = TreasureNewModel.instance:getState() ~= 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TREASUREMAP, isShowPoint)

	if msg.noteId and msg.noteId ~= 0 then
		TimeCapsuleModel.instance:setTreasureNoteId(msg.noteId)
	end

	self:_callback()
end

function TreasureNewController:_onUseMap(status, msg)
	TreasureNewModel.instance:updateUseMapRes(msg)

	local isShowPoint = TreasureNewModel.instance:getState() ~= 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TREASUREMAP, true)

	local targetcfg = TreasureNewModel.instance:getTargetCfg()

	if targetcfg then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		mainPlayer:gotoScenePosition(targetcfg.sceneId, targetcfg.x, targetcfg.y, function()
			UIStateManager.instance:open(ViewName.TreasurenewDigView, true)
		end)
	end
end

function TreasureNewController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function TreasureNewController:useTreasureMap(data, num)
	if checkint(num) <= 0 then
		return false
	end

	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送，无法进入挖宝流程!")

		return false
	end

	if TreasureNewModel.instance:getState() ~= 0 then
		FloatWordMgr.instance:show("请完成当前的挖宝任务后,再开启挖宝任务！")

		return false
	end

	local function callback()
		UIStateManager.instance:clear()
		UIStateManager.instance:open(ViewName.TreasurenewautoView, data, num)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), "即将开启自动挖宝任务，期间可点击屏幕中止", callback)
end

function TreasureNewController:getlockCSceneListJson()
	local unlockSceneList = {}
	local sendJson

	if #unlockSceneList == 0 then
		sendJson = nil
	else
		local para = {
			unlock = unlockSceneList
		}

		sendJson = json.encode(para)
	end

	return sendJson
end

function TreasureNewController:_enterTreasureState()
	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送，无法进入挖宝流程!")

		return
	end

	local function handler()
		local state = TreasureNewModel.instance:getState()

		if state == 0 then
			-- block empty
		elseif state == 1 then
			local targetcfg = TreasureNewModel.instance:getTargetCfg()

			if targetcfg then
				local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

				mainPlayer:gotoScenePosition(targetcfg.sceneId, targetcfg.x, targetcfg.y, function()
					UIStateManager.instance:open(ViewName.TreasurenewDigView, true)
				end)
			end
		elseif state == 2 then
			self:_openTreasureView()
		else
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_TREASUREMAP, false)
		end
	end

	self.sendGetInfoReq(self, handler, self)
end

function TreasureNewController:checkIsAbleToQuickUseMapItem(materialId)
	local cfg = TreasureNewConfig.instance:getMapCfgByMatId(materialId)

	if cfg then
		return RoleModel.instance:getMyLevel() >= cfg.directGainLevel
	end
end

function TreasureNewController:quickUseMap(materialId, num)
	if self:checkIsAbleToQuickUseMapItem(materialId) then
		NewTreasureAgent.instance:sendPM_NewTreasureDirectGainPrizeReq(materialId, num)
	end
end

function TreasureNewController:handleQuickUseMap(msg)
	return
end

function TreasureNewController:_callback(...)
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

function TreasureNewController:_errorCall()
	self._handler = nil
	self._handlerObj = nil
end

function TreasureNewController:_checkIsReqing()
	if self._handler then
		print("_checkIsReqing")
		print(debug.traceback())
		FloatWordMgr.instance:show("TreasureNew sent req ")

		return true
	else
		return false
	end
end

function TreasureNewController:_openTreasureView()
	if TreasureNewModel.instance:getTurnTableId() == 3 then
		UIStateManager.instance:open(ViewName.ReadyforwartreasureView)
	else
		UIStateManager.instance:open(ViewName.TreasurenewView)
	end
end

TreasureNewController.instance = TreasureNewController.New()

return TreasureNewController

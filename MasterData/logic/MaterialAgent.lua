-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/agent/MaterialAgent.lua

module("logic.extensions.material.agent.MaterialAgent", package.seeall)

local MaterialAgent = class("MaterialAgent", BaseAgent)

MaterialAgent.UseMaterialRes = "MaterialAgent_UseMaterialRes"
MaterialAgent.NotifyMaterialChangedRes = "MaterialAgent_NotifyMaterialChangedRes"
MaterialAgent.LoadAllMaterialsRes = "MaterialAgent_LoadAllMaterialsRes"
MaterialAgent.SellMaterialsRes = "MaterialAgent_SellMaterialsRes"
MaterialAgent.UseExchangeCodeRes = "MaterialAgent_UseExchangeCodeRes"
MaterialAgent.BatchUseMaterialRes = "MaterialAgent_BatchUseMaterialRes"
MaterialAgent.NotifyTimedItemChangeRes = "MaterialAgent_NotifyTimedItemChangeRes"
MaterialAgent.NotifyExpirableItemChangeRes = "MaterialAgent_NotifyExpirableItemChangeRes"

function MaterialAgent:ctor()
	return
end

function MaterialAgent:setExtId(extId)
	MaterialAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MaterialAgent:sendUseMaterialReq(materialType, materialId, num, extraParams, handler, handlerObj, errHandler)
	local req = MaterialExtension_pb.UseMaterialReq()

	req.materialType = materialType
	req.materialId = materialId
	req.num = num
	req.extraParams = extraParams

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialAgent.UseMaterialRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialAgent:handleUseMaterialRes(status, msg)
	self:dispatch(MaterialAgent.UseMaterialRes, status, msg)
end

function MaterialAgent:handleNotifyMaterialChangedRes(status, msg)
	self:dispatch(MaterialAgent.NotifyMaterialChangedRes, status, msg)
end

function MaterialAgent:sendLoadAllMaterialsReq(handler, handlerObj, errHandler)
	local req = MaterialExtension_pb.LoadAllMaterialsReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialAgent.LoadAllMaterialsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialAgent:handleLoadAllMaterialsRes(status, msg)
	forcePrint("MaterialAgent.handleLoadAllMaterialsRes===", status)
	self:dispatch(MaterialAgent.LoadAllMaterialsRes, status, msg)
end

function MaterialAgent:sendSellMaterialsReq(type, id, num, handler, handlerObj, errHandler)
	local req = MaterialExtension_pb.SellMaterialsReq()

	req.type = type
	req.id = id
	req.num = num

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialAgent.SellMaterialsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialAgent:handleSellMaterialsRes(status, msg)
	self:dispatch(MaterialAgent.SellMaterialsRes, status, msg)
end

function MaterialAgent:sendUseExchangeCodeReq(exchangeCode, handler, handlerObj, errHandler)
	local req = MaterialExtension_pb.UseExchangeCodeReq()

	req.exchangeCode = exchangeCode

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialAgent.UseExchangeCodeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialAgent:handleUseExchangeCodeRes(status, msg)
	self:dispatch(MaterialAgent.UseExchangeCodeRes, status, msg)
end

function MaterialAgent:sendBatchUseMaterialReq(materialType, items_pb_Ary, extraParams, handler, handlerObj, errHandler)
	local req = MaterialExtension_pb.BatchUseMaterialReq()

	req.materialType = materialType

	if items_pb_Ary ~= nil then
		for i, v1 in ipairs(items_pb_Ary) do
			local items = req.items:add()

			items:ParseFromString(v1:SerializeToString())
		end
	end

	req.extraParams = extraParams

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MaterialAgent.BatchUseMaterialRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MaterialAgent:sendGetMixSelectOnceInfoReq(materialType, materialId)
	local req = MaterialExtension_pb.GetMixSelectOnceInfoReq()

	req.materialType = materialType
	req.materialId = materialId

	self:sendMsg(req)
end

function MaterialAgent:handleGetMixSelectOnceInfoRes(status, msg)
	if status == 0 then
		MaterialModel.instance:updateMixSelectOnceList(msg)
	end
end

function MaterialAgent:handleBatchUseMaterialRes(status, msg)
	self:dispatch(MaterialAgent.BatchUseMaterialRes, status, msg)
end

function MaterialAgent:handleNotifyTimedItemChangeRes(status, msg)
	if status == 0 then
		self:dispatch(MaterialAgent.NotifyTimedItemChangeRes, status, msg)
	end
end

function MaterialAgent:handleNotifyExpirableItemChangeRes(status, msg)
	if status == 0 then
		self:dispatch(MaterialAgent.NotifyExpirableItemChangeRes, status, msg)
	end
end

MaterialAgent.instance = MaterialAgent.New()

return MaterialAgent

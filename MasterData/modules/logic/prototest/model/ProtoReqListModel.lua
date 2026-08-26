-- chunkname: @modules/logic/prototest/model/ProtoReqListModel.lua

module("modules.logic.prototest.model.ProtoReqListModel", package.seeall)

local ProtoReqListModel = class("ProtoReqListModel", ListScrollModel)

function ProtoReqListModel:onInit()
	self._reqList = nil
end

function ProtoReqListModel:getFilterList(filterStr)
	self:_checkInitReqList()

	local list = {}

	filterStr = string.lower(filterStr)

	for _, reqObj in ipairs(self._reqList) do
		if string.nilorempty(filterStr) or string.find(reqObj.cmdStr, filterStr) or string.find(reqObj.reqLower, filterStr) or string.find(reqObj.moduleLower, filterStr) then
			table.insert(list, reqObj)
		end
	end

	return list
end

function ProtoReqListModel:_checkInitReqList()
	if self._reqList then
		return
	end

	self._reqList = {}

	local cmdDict = LuaSocketMgr.instance:getCmdSettingDict()

	if cmdDict then
		for cmd, cmdObj in pairs(cmdDict) do
			if #cmdObj >= 3 then
				local mo = {}

				mo.cmd = cmd
				mo.cmdStr = tostring(cmd)
				mo.req = cmdObj[2]
				mo.reqLower = string.lower(cmdObj[2])
				mo.module = cmdObj[1]
				mo.moduleLower = string.lower(cmdObj[1])

				table.insert(self._reqList, mo)
			end
		end
	else
		logError("init cmd RequestList fail, module_cmd not exist")
	end
end

ProtoReqListModel.instance = ProtoReqListModel.New()

return ProtoReqListModel

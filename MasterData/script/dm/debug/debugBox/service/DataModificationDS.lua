-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/service/DataModificationDS.lua

DataModificationDS = class("DataModificationDS", Service, _M)

local opType = {
	OPCODE_DATA_MODIFICATION = 99001
}

function DataModificationDS:initialize()
	super.initialize(self)
end

function DataModificationDS:dispose()
	super.dispose(self)
end

function DataModificationDS:requestTest(params, callback)
	local sendData = {}

	sendData.obj = params

	dump(sendData, "DataModificationDS___")

	local request = self:newRequest(opType.OPCODE_DATA_MODIFICATION, sendData, function(response)
		if callback ~= nil then
			callback(response)
		end
	end, nil, true)

	self:sendRequest(request)
end

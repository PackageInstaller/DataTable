-- chunkname: @modules/common/res/ResDispose.lua

module("modules.common.res.ResDispose", package.seeall)

local ResDispose = _M
local CHECK_INTERVAL = 4
local waitList = {}

function ResDispose.dispose()
	waitList = {}
end

function ResDispose.open()
	TaskDispatcher.runRepeat(ResDispose._loop, nil, CHECK_INTERVAL)
end

function ResDispose.close()
	TaskDispatcher.cancelTask(ResDispose._loop, nil)
end

function ResDispose.unloadTrue()
	local assetPool = ResMgr.getAssetPool()

	waitList = {}

	for url, assetMO in pairs(assetPool) do
		if assetMO:canRelease() then
			table.insert(waitList, assetMO)
		end
	end

	for i, v in ipairs(waitList) do
		v:tryDispose()
	end
end

function ResDispose._loop()
	local assetPool = ResMgr.getAssetPool()

	waitList = {}

	for url, assetMO in pairs(assetPool) do
		if assetMO:canRelease() then
			table.insert(waitList, assetMO)
		end
	end

	for i, v in ipairs(waitList) do
		v:tryDispose()
	end
end

return ResDispose

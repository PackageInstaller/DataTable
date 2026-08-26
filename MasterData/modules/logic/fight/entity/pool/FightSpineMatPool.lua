-- chunkname: @modules/logic/fight/entity/pool/FightSpineMatPool.lua

module("modules.logic.fight.entity.pool.FightSpineMatPool", package.seeall)

local FightSpineMatPool = class("FightSpineMatPool")
local MaxCount = 10
local _poolDict = {}

function FightSpineMatPool.getMat(matName)
	local pool = _poolDict[matName]

	if not pool then
		pool = {}
		_poolDict[matName] = pool
	end

	if #pool > 0 then
		return table.remove(pool, #pool)
	else
		local path = ResUrl.getRoleSpineMat(matName)
		local assetItem = FightHelper.getPreloadAssetItem(path)

		if assetItem then
			local mat = assetItem:GetResource()

			if mat then
				return UnityEngine.Object.Instantiate(mat)
			end
		end
	end

	logError("Material has not preload: " .. matName)
end

function FightSpineMatPool.returnMat(matName, mat)
	local pool = _poolDict[matName]

	if not pool then
		pool = {}
		_poolDict[matName] = pool
	end

	if #pool > MaxCount then
		gohelper.destroy(mat)
	else
		table.insert(pool, mat)
	end
end

function FightSpineMatPool.dispose()
	for _, pool in pairs(_poolDict) do
		for _, mat in ipairs(pool) do
			gohelper.destroy(mat)
		end
	end

	_poolDict = {}
end

return FightSpineMatPool

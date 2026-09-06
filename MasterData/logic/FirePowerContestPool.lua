-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/FirePowerContestPool.lua

module("logic.extensions.firepowercontest.game.FirePowerContestPool", package.seeall)

local FirePowerContestPool = class("FirePowerContestPool")

FirePowerContestPool.Bullet = 1
FirePowerContestPool.Item = 2
FirePowerContestPool.Combo = 3
FirePowerContestPool.AddScore = 4
FirePowerContestPool.Effect = 5

function FirePowerContestPool:ctor(bulletBase, itemBase, comboBase, txtAddScoreBase, effectCell)
	self._pool = {
		[FirePowerContestPool.Bullet] = {},
		[FirePowerContestPool.Item] = {},
		[FirePowerContestPool.Combo] = {},
		[FirePowerContestPool.AddScore] = {},
		[FirePowerContestPool.Effect] = {}
	}
	self._base = {
		[FirePowerContestPool.Bullet] = bulletBase,
		[FirePowerContestPool.Item] = itemBase,
		[FirePowerContestPool.Combo] = comboBase,
		[FirePowerContestPool.AddScore] = txtAddScoreBase,
		[FirePowerContestPool.Effect] = effectCell
	}
end

function FirePowerContestPool:dispose()
	for _, pool in pairs(self._pool) do
		for i, v in ipairs(pool) do
			goutil.destroy(v)
		end
	end

	self._pool = {}
	self._base = {}
end

function FirePowerContestPool:createFromPool(type, parent)
	if not parent then
		-- block empty
	end

	local pool = self._pool[type]

	if pool then
		local item = table.remove(pool, #pool)

		if not item then
			local base = self._base[type]

			if base then
				item = goutil.cloneAndSetParent(base, parent)
			end
		else
			goutil.addChildToParent(item, parent)
		end

		goutil.setActive(item, true)

		return item
	end

	return nil
end

function FirePowerContestPool:recover(type, item)
	goutil.setActive(item, false)

	local pool = self._pool[type]

	if pool then
		table.insert(pool, item)
	else
		goutil.destroy(item)
	end
end

return FirePowerContestPool

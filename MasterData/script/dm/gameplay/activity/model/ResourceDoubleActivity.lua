-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ResourceDoubleActivity.lua

ResourceDoubleActivity = class("ResourceDoubleActivity", BaseActivity, _M)

ResourceDoubleActivity:has("_gameEvnEffect", {
	is = "r"
})

function ResourceDoubleActivity:initialize(id)
	super.initialize(self, id)
	self:initGameEvnEffect()
end

function ResourceDoubleActivity:synchronize(data)
	super.synchronize(self, data)
end

function ResourceDoubleActivity:initGameEvnEffect()
	self._gameEvnEffect = {}

	local config = self:getActivityConfig()

	for i = 1, #config.system do
		local gameEvn = config.system[i]

		self._gameEvnEffect[gameEvn] = {
			rate = config.rate[i]
		}
	end
end

function ResourceDoubleActivity:getSwitch()
	return GameConfigs.closeResourceDoubleActivity
end

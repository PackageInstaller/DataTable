-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/PassActivity.lua

PassActivity = class("PassActivity", BaseActivity, _M)

PassActivity:has("_allData", {
	is = "r"
})

function PassActivity:initialize()
	super.initialize(self)

	self._allData = {}
end

function PassActivity:dispose()
	super.dispose(self)
end

function PassActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	self._allData = data
end

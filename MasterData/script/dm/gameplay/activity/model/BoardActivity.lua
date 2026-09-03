-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/BoardActivity.lua

BoardActivity = class("BoardActivity", BaseActivity, _M)

function BoardActivity:initialize()
	super.initialize(self)

	self._taskList = {}
end

function BoardActivity:dispose()
	super.dispose(self)
end

function BoardActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)
end

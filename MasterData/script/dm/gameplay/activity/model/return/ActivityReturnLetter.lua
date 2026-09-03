-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/return/ActivityReturnLetter.lua

ActivityReturnLetter = class("ActivityReturnLetter", BaseActivity, _M)

ActivityReturnLetter:has("_taskList", {
	is = "r"
})
ActivityReturnLetter:has("_isDraw", {
	is = "r"
})

function ActivityReturnLetter:initialize()
	super.initialize(self)

	self._isDraw = false
end

function ActivityReturnLetter:dispose()
	super.dispose(self)
end

function ActivityReturnLetter:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.isDraw then
		self._isDraw = data.isDraw
	end
end

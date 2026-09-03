-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptions.lua

MazeOptions = class("MazeOptions", objectlua.Object, _M)

MazeOptions:has("_id", {
	is = "rw"
})
MazeOptions:has("_configId", {
	is = "rw"
})
MazeOptions:has("_level", {
	is = "rw"
})

function MazeOptions:initialize()
	super.initialize(self)

	self._optionsList = {}
	self._type = ""
end

function MazeOptions:syncData(data)
	self._type = data.type
end

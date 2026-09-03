-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreCaseEndAction.lua

ExploreCaseEndAction = class("ExploreCaseEndAction", objectlua.Object)

function ExploreCaseEndAction:initialize(id)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("MapCaseEndAction", id)
end

function ExploreCaseEndAction:getAction()
	return self._config.Action
end

function ExploreCaseEndAction:getFactorType2()
	return self._config.FactorType2
end

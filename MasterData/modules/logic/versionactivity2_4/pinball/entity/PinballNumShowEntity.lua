-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballNumShowEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballNumShowEntity", package.seeall)

local PinballNumShowEntity = class("PinballNumShowEntity", LuaCompBase)

function PinballNumShowEntity:init(go)
	self.go = go
	self._trans = go.transform
	self._txtnum = gohelper.findChildTextMesh(go, "#txt_num")

	TaskDispatcher.runDelay(self.dispose, self, 2)
end

function PinballNumShowEntity:setType(num)
	self._txtnum.text = num
end

function PinballNumShowEntity:setPos(x, y)
	recthelper.setAnchor(self._trans, x, y)
end

function PinballNumShowEntity:dispose()
	gohelper.destroy(self.go)
end

function PinballNumShowEntity:onDestroy()
	TaskDispatcher.cancelTask(self.dispose, self)
end

return PinballNumShowEntity

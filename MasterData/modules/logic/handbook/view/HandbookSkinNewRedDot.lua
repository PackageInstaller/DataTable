-- chunkname: @modules/logic/handbook/view/HandbookSkinNewRedDot.lua

module("modules.logic.handbook.view.HandbookSkinNewRedDot", package.seeall)

local HandbookSkinNewRedDot = class("HandbookSkinNewRedDot", LuaCompBase)

function HandbookSkinNewRedDot:ctor(param)
	self._suitId = param[1]
end

function HandbookSkinNewRedDot:init(go)
	self.goRedDot = gohelper.findChild(go, "scale")
end

function HandbookSkinNewRedDot:addEventListeners()
	self.addEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshRedDot, self)
end

function HandbookSkinNewRedDot:removeEventListeners()
	self.removeEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshRedDot, self)
end

function HandbookSkinNewRedDot:refreshRedDot()
	if self._forceHide then
		return
	end

	local showRedDot = HandbookController.instance:isHandbookSkinSuitNewRedDotShow(self._suitId)

	gohelper.setActive(self.goRedDot, showRedDot)
end

function HandbookSkinNewRedDot:forceHide()
	self._forceHide = true

	gohelper.setActive(self.goRedDot, false)
end

function HandbookSkinNewRedDot:resetForceHide()
	self._forceHide = nil

	self:refreshRedDot()
end

function HandbookSkinNewRedDot:onStart()
	return
end

function HandbookSkinNewRedDot:dispose()
	return
end

function HandbookSkinNewRedDot:onDestroy()
	return
end

return HandbookSkinNewRedDot

-- chunkname: @modules/logic/sp01/act204/view/Activity204TaskEntranceItem.lua

module("modules.logic.sp01.act204.view.Activity204TaskEntranceItem", package.seeall)

local Activity204TaskEntranceItem = class("Activity204TaskEntranceItem", Activity204EntranceItemBase)

function Activity204TaskEntranceItem:init(go)
	Activity204TaskEntranceItem.super.init(self, go)

	self._golimitTask = gohelper.findChild(self.go, "root/#gp_limitTask")
end

function Activity204TaskEntranceItem:addEventListeners()
	Activity204TaskEntranceItem.super.addEventListeners(self)
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.UpdateTask, self._onUpdateTask, self)
end

function Activity204TaskEntranceItem:removeEventListeners()
	Activity204TaskEntranceItem.super.removeEventListeners(self)
end

function Activity204TaskEntranceItem:onUpdateMO(actId)
	Activity204TaskEntranceItem.super.onUpdateMO(self, actId)
	self:_chcekHasAnyLimitTask()
end

function Activity204TaskEntranceItem:_onUpdateTask()
	self:_chcekHasAnyLimitTask()
	self:updateReddot()
end

function Activity204TaskEntranceItem:_chcekHasAnyLimitTask()
	local actMo = Activity204Model.instance:getActMo(self._actId)

	if not actMo then
		return
	end

	gohelper.setActive(self._golimitTask, actMo:hasAnyLimitTask())
end

function Activity204TaskEntranceItem:updateReddot()
	if self._actCfg and self._actCfg.redDotId ~= 0 then
		RedDotController.instance:addRedDot(self._goRedPoint, self._actCfg.redDotId, nil, self.checkReddotFunc, self)
	end
end

function Activity204TaskEntranceItem:checkReddotFunc(redDotIcon)
	redDotIcon:defaultRefreshDot()

	redDotIcon.show = redDotIcon.show or Activity204Model.instance:hasNewTask(self._actId)

	local redDotCo = RedDotConfig.instance:getRedDotCO(self._actCfg.redDotId)
	local redDotType = redDotCo and redDotCo.style

	redDotIcon:showRedDot(redDotType)
end

return Activity204TaskEntranceItem

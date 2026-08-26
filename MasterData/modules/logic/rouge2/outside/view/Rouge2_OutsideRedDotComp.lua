-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_OutsideRedDotComp.lua

module("modules.logic.rouge2.outside.view.Rouge2_OutsideRedDotComp", package.seeall)

local Rouge2_OutsideRedDotComp = class("Rouge2_OutsideRedDotComp", Rouge2_BackpackItemReddotComp)

function Rouge2_OutsideRedDotComp.Get(goReddot, goCheck, goScroll)
	local reddotComp = MonoHelper.addNoUpdateLuaComOnceToGo(goReddot, Rouge2_OutsideRedDotComp)

	reddotComp.checkComp = Rouge2_BackpackItemCheckComp.Get(goCheck, goScroll)

	return reddotComp
end

function Rouge2_OutsideRedDotComp:intReddotInfo(id, uid, type)
	if not id then
		return
	end

	self._id = id
	self._uid = uid or 0
	self._type = type or 0
	self._isDotShow = RedDotModel.instance:isDotShow(self._id, self._uid)

	gohelper.setActive(self.go, self._isDotShow)
end

function Rouge2_OutsideRedDotComp:refresh()
	if not self._isDotShow then
		return false
	end

	local isFullInView = self.checkComp:checkIsItemFullInView()

	if isFullInView then
		self:onItemFullInView()

		return true
	end

	return false
end

function Rouge2_OutsideRedDotComp:onItemFullInView()
	logNormal("移除肉鸽2红点 type: " .. self._type .. " id:" .. self._id .. "uid: " .. self._uid)
	Rouge2_OutsideController.instance:addShowRedDot(self._type, self._uid)

	self._isDotShow = false

	gohelper.setActive(self.go, self._isDotShow)
end

return Rouge2_OutsideRedDotComp

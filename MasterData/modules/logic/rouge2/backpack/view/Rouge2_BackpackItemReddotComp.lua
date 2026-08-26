-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackItemReddotComp.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackItemReddotComp", package.seeall)

local Rouge2_BackpackItemReddotComp = class("Rouge2_BackpackItemReddotComp", LuaCompBase)

function Rouge2_BackpackItemReddotComp.Get(goReddot, goCheck, goScroll)
	local reddotComp = MonoHelper.addNoUpdateLuaComOnceToGo(goReddot, Rouge2_BackpackItemReddotComp)

	reddotComp.checkComp = Rouge2_BackpackItemCheckComp.Get(goCheck, goScroll)

	return reddotComp
end

function Rouge2_BackpackItemReddotComp:init(go)
	self.go = go
	self.tran = go.transform
end

function Rouge2_BackpackItemReddotComp:addEventListeners()
	return
end

function Rouge2_BackpackItemReddotComp:intReddotInfo(id, uid)
	if not id then
		return
	end

	self._id = id
	self._uid = uid or 0
	self._isDotShow = RedDotModel.instance:isDotShow(self._id, self._uid)

	gohelper.setActive(self.go, self._isDotShow)
	self:refresh()
end

function Rouge2_BackpackItemReddotComp:refresh()
	if not self._isDotShow then
		return
	end

	local isFullInView = self.checkComp:checkIsItemFullInView()

	if isFullInView then
		self:onItemFullInView()
	end
end

function Rouge2_BackpackItemReddotComp:onItemFullInView()
	Rouge2_BackpackController.instance:updateItemReddotStatus(self._uid, Rouge2_Enum.ItemStatus.Old)

	self._isDotShow = RedDotModel.instance:isDotShow(self._id, self._uid)

	gohelper.setActive(self.go, self._isDotShow)
end

return Rouge2_BackpackItemReddotComp

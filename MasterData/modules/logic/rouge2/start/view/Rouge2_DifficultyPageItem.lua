-- chunkname: @modules/logic/rouge2/start/view/Rouge2_DifficultyPageItem.lua

module("modules.logic.rouge2.start.view.Rouge2_DifficultyPageItem", package.seeall)

local Rouge2_DifficultyPageItem = class("Rouge2_DifficultyPageItem", LuaCompBase)

function Rouge2_DifficultyPageItem:ctor(view)
	Rouge2_DifficultyPageItem.super.ctor(self)

	self._view = view
end

function Rouge2_DifficultyPageItem:init(go)
	self.go = go
	self._goContainer = gohelper.findChild(self.go, "go_Container")
	self._difficultyItemTab = self:getUserDataTb_()

	gohelper.setActive(self.go, true)
end

function Rouge2_DifficultyPageItem:addEventListeners()
	return
end

function Rouge2_DifficultyPageItem:removeEventListeners()
	return
end

function Rouge2_DifficultyPageItem:onUpdateMO(difficultyMoList)
	self._moList = difficultyMoList

	if self._moList then
		self._moNum = #self._moList or 0
	end

	for i = 1, self._moNum do
		local mo = self._moList[i]
		local difficultyItem = self:_getOrCreateDifficultyItem(i)

		difficultyItem:onUpdateMO(mo)
	end

	for i = self._moNum + 1, #self._difficultyItemTab do
		self._difficultyItemTab[i]:setUse(false)
	end
end

function Rouge2_DifficultyPageItem:_getOrCreateDifficultyItem(index)
	local difficultyItem = self._difficultyItemTab[index]

	if not difficultyItem then
		local godifficulty = self._view:getResInst(Rouge2_Enum.ResPath.DifficultyItem, self._goContainer)

		difficultyItem = MonoHelper.addNoUpdateLuaComOnceToGo(godifficulty, Rouge2_DifficultyItem)
		self._difficultyItemTab[index] = difficultyItem
	end

	return difficultyItem
end

function Rouge2_DifficultyPageItem:onDestory()
	return
end

return Rouge2_DifficultyPageItem

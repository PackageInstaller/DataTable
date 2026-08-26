-- chunkname: @modules/logic/abyss/view/AbyssTaskStageItem.lua

module("modules.logic.abyss.view.AbyssTaskStageItem", package.seeall)

local AbyssTaskStageItem = class("AbyssTaskStageItem", LuaCompBase)

function AbyssTaskStageItem:init(go)
	self.viewGO = go
	self._gostaritem = gohelper.findChild(self.viewGO, "starbg/#go_staritem")
	self._gostargroup = gohelper.findChild(self.viewGO, "starbg/#go_staritem/#go_stargroup")
	self._txtchapternum = gohelper.findChildTextMesh(self.viewGO, "starbg/#txt_chapternum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssTaskStageItem:_editableInitView()
	return
end

function AbyssTaskStageItem:setInfo(stageInfoMo, index)
	if stageInfoMo == nil then
		return
	end

	self._txtchapternum.text = GameUtil.getRomanNums(index)
	self.stageInfoMo = stageInfoMo

	self:refreshStar(stageInfoMo:isChallenged(), stageInfoMo.star, stageInfoMo.totalStar)
end

function AbyssTaskStageItem:refreshStar(haveChallenged, curStar, maxStar)
	local haveStar = maxStar > 0

	gohelper.setActive(self.viewGO, haveStar)

	if not haveStar then
		return
	end

	local starDic = {}

	for i = 1, maxStar do
		starDic[i] = haveChallenged and i <= curStar and 1 or 0
	end

	gohelper.CreateObjList(self, self.onStarItemCreate, starDic, nil, self._gostargroup)
end

function AbyssTaskStageItem:onStarItemCreate(itemGo, state, index)
	local isFinish = state == 1
	local isFinal = index >= self.stageInfoMo.totalStar
	local starLocked = gohelper.findChild(itemGo, "star1")
	local starFinished = gohelper.findChild(itemGo, "star2")
	local starLocked2 = gohelper.findChild(itemGo, "star3")
	local starFinished2 = gohelper.findChild(itemGo, "star4")

	gohelper.setActive(starFinished, isFinish and not isFinal)
	gohelper.setActive(starLocked, not isFinish and not isFinal)
	gohelper.setActive(starFinished2, isFinish and isFinal)
	gohelper.setActive(starLocked2, not isFinish and isFinal)
end

function AbyssTaskStageItem:onDestroy()
	return
end

return AbyssTaskStageItem

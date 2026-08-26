-- chunkname: @modules/logic/fight/view/FightGuideItem.lua

module("modules.logic.fight.view.FightGuideItem", package.seeall)

local FightGuideItem = class("FightGuideItem", LuaCompBase)

function FightGuideItem:init(go)
	self.go = go
	self._simagebg = gohelper.findChildSingleImage(go, "#simage_icon")
	self._btnclose = gohelper.findChildButtonWithAudio(go, "#btn_close")

	self._btnclose:AddClickListener(self._btncloseOnClick, self)

	self._customGODict = self:getUserDataTb_()

	local customParentGO = gohelper.findChild(go, "#go_customList")
	local customParentTr = customParentGO.transform
	local childCount = customParentTr.childCount

	for i = 1, childCount do
		local childTr = customParentTr:GetChild(i - 1)
		local id = tonumber(childTr.name)

		if id then
			self._customGODict[id] = childTr.gameObject
		end
	end
end

function FightGuideItem:_btncloseOnClick()
	ViewMgr.instance:closeView(ViewName.FightGuideView)
end

function FightGuideItem:updateItem(param)
	self._index = param.index
	self._maxIndex = param.maxIndex
	self._id = param.id

	transformhelper.setLocalPos(self.go.transform, param.pos, 0, 0)

	if GuideEnum.GuideIconWithCn[self._id] then
		self._simagebg:LoadImage(ResUrl.getFightGuideLangIcon(self._id))
	else
		self._simagebg:LoadImage(ResUrl.getFightGuideIcon(self._id))
	end

	gohelper.setActive(self._customGODict[self._id], true)
	gohelper.setActive(self._btnclose.gameObject, self._maxIndex == self._index)
end

function FightGuideItem:setSelect(index)
	local isSelect = self._index == index

	if isSelect then
		gohelper.setActive(self.go, true)
		TaskDispatcher.cancelTask(self._hideGO, self)
	elseif self.go.activeInHierarchy then
		TaskDispatcher.runDelay(self._hideGO, self, 0.25)
	end
end

function FightGuideItem:_hideGO()
	gohelper.setActive(self.go, false)
end

function FightGuideItem:onDestroy()
	self._btnclose:RemoveClickListener()
	TaskDispatcher.cancelTask(self._hideGO, self)
	self._simagebg:UnLoadImage()
end

return FightGuideItem

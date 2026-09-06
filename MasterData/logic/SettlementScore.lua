-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementScore.lua

module("logic.extensions.battlesettlement.view.SettlementScore", package.seeall)

local SettlementScore = class("SettlementScore", BSAnimPlay)

function SettlementScore:buildUI(parent)
	SettlementScore.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._element = goutil.findChild(parent, "element")

	self._element:SetActive(false)

	self._scrollRectAdapter = Framework.ScrollRectAdapter.GetFrom(parent, "scrollList")
	self._scrollRect = goutil.findChild(parent, "scrollList"):GetComponent(goutil.Type_RectTransform)
	self._contentRect = goutil.findChild(parent, "scrollList/Viewport/Content"):GetComponent(goutil.Type_RectTransform)
	self._titleHeight = 50
	self._preHeight = 5
	self._postHeight = 10
	self._unitHeight = 30
	self._maxLineCount = 3
end

function SettlementScore:destroyUI()
	self._parent = nil
	self._parentRectTrans = nil
end

function SettlementScore:onEnter(totalHeight, curPosY, delayTime, isSuccess)
	SettlementScore.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true
	self._isSuccess = isSuccess

	printInfo("test SettlementScore:onEnter")
	goutil.setActive(self._parent, true)

	self._curViewDatas = {}
	self._targetConditionItems = {}

	self:_setConditions()
	self:_loadList()

	return self:getNextData()
end

function SettlementScore:onExit()
	self._isEntered = false

	self:doKillTween()
	self:_clearList()
	goutil.setActive(self._parent, false)
end

function SettlementScore:_updateCurDelay()
	self._curDelay = self._curDelay + self._delayTime1
end

function SettlementScore:_getPosY(index)
	local count = index >= 1 and index or 1

	return -1 * (self._preHeight + (count - 1) * self._unitHeight)
end

function SettlementScore:_setConditions()
	self._curTime = self._time1
	self._curDelay = self._delayTime1 + self:_getCurTimePoint()

	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	self._imgBgTarget:DOAnchorPosX(0, self._curTime):SetDelay(self._curDelay)

	local params = BattleSettlementModel.instance:getParams()

	for i, v in ipairs(params.scoreList) do
		local element = {}

		element.txtDesc = v
		element.posY = self:_getPosY(i)
		element.curTime = self._curTime

		self:_updateCurDelay()

		element.curDelay = self._curDelay

		table.insert(self._curViewDatas, element)
	end
end

function SettlementScore:_setContentHeight()
	local count = self:_getItemCount()
	local sizeDelta = self._contentRect.sizeDelta
	local height = self._preHeight + self._postHeight + count * self._unitHeight

	self._contentRect.sizeDelta = Vector2.New(sizeDelta.x, height)

	local scrollCount = count < self._maxLineCount and count or self._maxLineCount
	local scrollHeight = self._preHeight + self._postHeight + scrollCount * self._unitHeight

	if count > self._maxLineCount then
		scrollHeight = scrollHeight + self._unitHeight / 2
	end

	self._scrollRect.sizeDelta = Vector2.New(sizeDelta.x, scrollHeight)
end

function SettlementScore:_resetContentPos()
	self._scrollRectAdapter.scrollRect.verticalNormalizedPosition = 1
end

function SettlementScore:_getItemCount()
	if self._curViewDatas then
		return #self._curViewDatas
	end

	return 0
end

function SettlementScore:_setHeight()
	local count = self:_getItemCount()

	if count > self._maxLineCount then
		if not self._maxLineCount then
			local num = count
			local height = self._titleHeight + self._preHeight + self._postHeight + num * self._unitHeight

			if count > self._maxLineCount then
				height = height + self._unitHeight / 2
			end

			self.height = height

			Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())

			local sizeDelta = self._parentRectTrans.sizeDelta

			self._parentRectTrans.sizeDelta = Vector2.New(sizeDelta.x, height)
		end
	end
end

function SettlementScore:getMaxHeight()
	return self._titleHeight + self._preHeight + self._postHeight + self._maxLineCount * self._unitHeight + self._unitHeight / 2
end

function SettlementScore:_setAnimCostTime()
	local titleCount = 1
	local count = self:_getItemCount() + titleCount

	self.animCostTime = self._delayTime1 * count
end

function SettlementScore:_loadList()
	printInfo("SettlementScore _loadList")
	self:_setContentHeight()
	self:_resetContentPos()
	printInfo("score len = " .. #self._curViewDatas)

	for i, v in ipairs(self._curViewDatas) do
		local go = goutil.cloneAndSetParent(self._element, self._contentRect.transform, "item" .. tostring(i))

		go:SetActive(true)

		local conditionItem = GameUtil.AddLuaOnce(go, ScoreConditionItem)

		conditionItem:init(go, v)
		table.insert(self._targetConditionItems, conditionItem)
	end
end

function SettlementScore:_clearList()
	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:reset()
		end

		self._targetConditionItems = nil
	end

	self._curViewDatas = nil

	goutil.clearChildren(self._contentRect.gameObject)
end

function SettlementScore:doTween()
	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:doTween()
		end
	end
end

function SettlementScore:doKillTween()
	SettlementScore.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)

	if self._targetConditionItems then
		for i, v in ipairs(self._targetConditionItems) do
			v:doKillTween()
		end
	end
end

function SettlementScore:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
end

return SettlementScore

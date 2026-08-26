-- chunkname: @modules/common/others/LuaScrollRectTransition.lua

module("modules.common.others.LuaScrollRectTransition", package.seeall)

local LuaScrollRectTransition = class("LuaScrollRectTransition", LuaCompBase)

function LuaScrollRectTransition.getByListView(luaListScrollView)
	local csListScroll = luaListScrollView:getCsListScroll()
	local scrollParam = luaListScrollView._param
	local scrollRectGO = csListScroll.gameObject
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(scrollRectGO, LuaScrollRectTransition)

	comp.scrollRectGO = scrollRectGO
	comp.dir = scrollParam.scrollDir
	comp.lineCount = scrollParam.lineCount
	comp.cellWidth = scrollParam.cellWidth
	comp.cellHeight = scrollParam.cellHeight

	if scrollParam.scrollDir == ScrollEnum.ScrollDirH then
		comp.cellSpace = scrollParam.cellSpaceH or scrollParam.cellSpaceV
	end

	comp.startSpace = scrollParam.startSpace

	return comp
end

function LuaScrollRectTransition.getByScrollRectGO(scrollRectGO, dir, lineCount, cellWidth, cellHeight, cellSpace, startSpace)
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(scrollRectGO, LuaScrollRectTransition)

	comp.scrollRectGO = scrollRectGO
	comp.dir = dir
	comp.lineCount = lineCount
	comp.cellWidth = cellWidth
	comp.cellHeight = cellHeight
	comp.cellSpace = cellSpace or 0
	comp.startSpace = startSpace or 0

	return comp
end

function LuaScrollRectTransition:ctor()
	self.transitionTime = 0.2
end

function LuaScrollRectTransition:init(go)
	self._scrollRect = go:GetComponent(gohelper.Type_ScrollRect)
	self._transform = self._scrollRect.transform
	self._contentTr = self._scrollRect.content
end

function LuaScrollRectTransition:onDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function LuaScrollRectTransition:focusCellInViewPort(cellIdx, hasTransition, notCellChildCount)
	self:_checkInitSize()

	local viewPortSize = SLFramework.UGUI.RectTrHelper.GetSize(self._transform, self.dir)
	local contentSize = SLFramework.UGUI.RectTrHelper.GetSize(self._contentTr, self.dir)

	if self.dir == ScrollEnum.ScrollDirH then
		local cellSize = (self.cellWidth or self.cellHeight) + self.cellSpace
		local cellIdxInLine = cellIdx % self.lineCount == 0 and Mathf.Round(cellIdx / self.lineCount) or Mathf.Ceil(cellIdx / self.lineCount)
		local pos = 0
		local normalizedPosition = self._scrollRect.normalizedPosition

		if self.dir == ScrollEnum.ScrollDirH then
			if not normalizedPosition.x then
				local startPos = normalizedPosition.y

				if viewPortSize < contentSize then
					local pos1 = (cellIdxInLine * cellSize - cellSize) / (contentSize - viewPortSize)
					local pos2 = (cellIdxInLine * cellSize - viewPortSize) / (contentSize - viewPortSize)

					pos1 = Mathf.Clamp01(self:_fixNormalize(pos1))
					pos2 = Mathf.Clamp01(self:_fixNormalize(pos2))

					if pos1 <= startPos and startPos <= pos2 or pos2 <= startPos and startPos <= pos1 then
						return
					else
						pos = math.abs(startPos - pos1) < math.abs(startPos - pos2) and pos1 or pos2
					end
				else
					pos = self:_fixNormalize(pos)
				end

				if self.dir == ScrollEnum.ScrollDirH then
					normalizedPosition.x = pos
				else
					normalizedPosition.y = pos
				end

				if hasTransition then
					self._normalizedPosition = normalizedPosition
					self._tweenId = ZProj.TweenHelper.DOTweenFloat(startPos, pos, self.transitionTime, self._frameCallback, nil, self)
				else
					self._scrollRect.normalizedPosition = normalizedPosition
				end
			end
		end
	end
end

function LuaScrollRectTransition:_fixNormalize(value)
	if self.dir == ScrollEnum.ScrollDirV then
		return 1 - value
	end

	return value
end

function LuaScrollRectTransition:_frameCallback(value)
	if self.dir == ScrollEnum.ScrollDirH then
		self._normalizedPosition.x = value
	else
		self._normalizedPosition.y = value
	end

	self._scrollRect.normalizedPosition = self._normalizedPosition
end

function LuaScrollRectTransition:_checkInitSize()
	local noWidth = (not self.cellWidth or self.cellWidth <= 0) and self.dir == ScrollEnum.ScrollDirH
	local noHeight = (not self.cellHeight or self.cellHeight <= 0) and self.dir == ScrollEnum.ScrollDirV

	if noWidth or noHeight then
		local item = self._contentTr:GetChild(0)

		if item then
			self.cellWidth = recthelper.getWidth(item)
			self.cellHeight = recthelper.getHeight(item)
		end
	end
end

return LuaScrollRectTransition

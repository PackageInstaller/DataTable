-- chunkname: @modules/common/others/LuaListScrollExtend.lua

module("modules.common.others.LuaListScrollExtend", package.seeall)

local LuaListScrollExtend = class("LuaListScrollExtend", LuaListScrollView)

function LuaListScrollExtend:onUpdateFinish()
	for k, v in pairs(self._cellCompDict) do
		k.parent_view = self

		if k.initDone then
			k:initDone()
		end
	end

	self.isInitDone = true
end

function LuaListScrollExtend:onDestroyView()
	LuaListScrollExtend.super.onDestroyView(self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function LuaListScrollExtend:moveTo(index, tween, offset)
	offset = offset or 0

	local lineIndex = math.ceil(index / self._param.lineCount)
	local space = self:getScrollSpace()
	local size = self:getCellSize()
	local targetPixel = (size + space) * (lineIndex - 1) + self._param.startSpace + offset
	local moCount = self._model:getCount()
	local maxLineIndex = math.ceil(moCount / self._param.lineCount)
	local scrollWidth = self:getScrollWidth()
	local maxPixel = (size + space) * maxLineIndex - space + self._param.startSpace + self._param.endSpace - scrollWidth

	if targetPixel < 0 then
		targetPixel = 0
	elseif maxPixel < targetPixel then
		targetPixel = maxPixel
	end

	if tween then
		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end

		if self._param.scrollDir == ScrollEnum.ScrollDirV then
			if not self._csListScroll.VerticalScrollPixel then
				local curPixel = self._csListScroll.HorizontalScrollPixel

				self._tweenId = ZProj.TweenHelper.DOTweenFloat(curPixel, targetPixel, 0.2, self._frameCallback, self._finishCallback, self)
			end
		end
	elseif self._param.scrollDir == ScrollEnum.ScrollDirV then
		self._csListScroll.VerticalScrollPixel = targetPixel
	elseif self._param.scrollDir == ScrollEnum.ScrollDirH then
		self._csListScroll.HorizontalScrollPixel = targetPixel
	end
end

function LuaListScrollExtend:_frameCallback(value)
	if self._param.scrollDir == ScrollEnum.ScrollDirV then
		self._csListScroll.VerticalScrollPixel = value
	elseif self._param.scrollDir == ScrollEnum.ScrollDirH then
		self._csListScroll.HorizontalScrollPixel = value
	end
end

function LuaListScrollExtend:_finishCallback()
	self._tweenId = nil
end

function LuaListScrollExtend:getScrollWidth()
	if self._param.scrollDir == ScrollEnum.ScrollDirV then
		return recthelper.getHeight(self._csListScroll.transform)
	elseif self._param.scrollDir == ScrollEnum.ScrollDirH then
		return recthelper.getWidth(self._csListScroll.transform)
	end
end

function LuaListScrollExtend:getScrollSpace()
	if self._param.scrollDir == ScrollEnum.ScrollDirV then
		return self._param.cellSpaceV
	elseif self._param.scrollDir == ScrollEnum.ScrollDirH then
		return self._param.cellSpaceH
	end
end

function LuaListScrollExtend:getCellSize()
	if self._param.scrollDir == ScrollEnum.ScrollDirV then
		return self._param.cellHeight
	elseif self._param.scrollDir == ScrollEnum.ScrollDirH then
		return self._param.cellWidth
	end
end

return LuaListScrollExtend

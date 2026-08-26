-- chunkname: @modules/logic/achievement/view/AchievementMainViewFold.lua

module("modules.logic.achievement.view.AchievementMainViewFold", package.seeall)

local AchievementMainViewFold = class("AchievementMainViewFold", BaseView)

function AchievementMainViewFold:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementMainViewFold:addEvents()
	return
end

function AchievementMainViewFold:removeEvents()
	return
end

function AchievementMainViewFold:_editableInitView()
	self._modlInst = AchievementMainTileModel.instance

	self.addEventCb(self, AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, self.onClickGroupFoldBtn, self)
end

function AchievementMainViewFold:onDestroyView()
	return
end

function AchievementMainViewFold:onOpen()
	return
end

function AchievementMainViewFold:onClose()
	self.removeEventCb(self, AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, self.onClickGroupFoldBtn, self)
	TaskDispatcher.cancelTask(self.onEndPlayGroupFadeAnim, self)
	TaskDispatcher.cancelTask(self.onPreEndPlayGroupFadeAnim, self)
	TaskDispatcher.cancelTask(self.onDispatchAchievementFadeAnimationEvent, self)

	self._modifyMap = nil

	self:onEndPlayGroupFadeAnim()
end

function AchievementMainViewFold:onClickGroupFoldBtn(groupId, isFold)
	self:onStartPlayGroupFadeAnim()
	self:doAchievementFadeAnimation(groupId, isFold)
end

function AchievementMainViewFold:onStartPlayGroupFadeAnim()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainViewFold_BeginPlayGroupFadeAnim")
end

function AchievementMainViewFold:onEndPlayGroupFadeAnim()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainViewFold_BeginPlayGroupFadeAnim")
end

local foldoutDurationPerHeight = 0.001
local foldInDurationPerHeight = 0.0003
local minAchievementFadeAnimDuration = 0
local maxAchievementFadeAnimDuration = 0.35

function AchievementMainViewFold:doAchievementFadeAnimation(groupId, isFold)
	local modelInst = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
	local moList = modelInst:getCurGroupMoList(groupId)
	local firstMO = moList and moList[1]
	local groupTopIndex = modelInst:getIndex(firstMO)

	self._isFold = isFold
	self._modifyGroupId = groupId

	local lastModifyMO
	local lastFadeAnimDuration = 0

	self._modifyMap = self:getUserDataTb_()

	local cellRenderCount = self:getCurRenderCellCount(groupId, moList, isFold)
	local startIndex = isFold and cellRenderCount or 1
	local endIndex = isFold and 1 or cellRenderCount
	local step = isFold and -1 or 1

	for i = startIndex, endIndex, step do
		local mo = moList[i]

		self._modifyMap[mo] = true

		mo:clearOverrideLineHeight()

		if not isFold and not mo.isGroupTop then
			local insertIndex = groupTopIndex + i - 1

			modelInst:addAt(mo, insertIndex)
		end

		local effectParams = self:getEffectParams(curFilterType, isFold, mo, lastModifyMO)

		if not isFold and not mo.isGroupTop then
			mo:overrideLineHeight(0)
		end

		TaskDispatcher.runDelay(self.onDispatchAchievementFadeAnimationEvent, effectParams, lastFadeAnimDuration)

		lastFadeAnimDuration = lastFadeAnimDuration + effectParams.duration
		lastModifyMO = mo
	end

	if isFold then
		self:onBeginFoldIn(self._modifyGroupId, self._isFold)
	end

	TaskDispatcher.cancelTask(self.onPreEndPlayGroupFadeAnim, self)
	TaskDispatcher.runDelay(self.onPreEndPlayGroupFadeAnim, self, lastFadeAnimDuration)
	TaskDispatcher.cancelTask(self.onEndPlayGroupFadeAnim, self)
	TaskDispatcher.runDelay(self.onEndPlayGroupFadeAnim, self, lastFadeAnimDuration)
end

function AchievementMainViewFold:onBeginFoldIn(groupId, isFold)
	local modelInst = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()
	local moList = modelInst:getCurGroupMoList(groupId)

	if moList then
		for i = 1, #moList do
			local mo = moList[i]

			if not self._modifyMap[mo] then
				mo:setIsFold(isFold)
				mo:clearOverrideLineHeight()
				modelInst:remove(mo)
			end
		end

		modelInst:onModelUpdate()
	end
end

function AchievementMainViewFold:onPreEndPlayGroupFadeAnim()
	local modelInst = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()
	local moList = modelInst:getCurGroupMoList(self._modifyGroupId)

	if moList then
		local firstMO = moList and moList[1]
		local groupTopIndex = modelInst:getIndex(firstMO)

		for i = 1, #moList do
			local mo = moList[i]

			mo:setIsFold(self._isFold)
			mo:clearOverrideLineHeight()

			if not self._isFold and not self._modifyMap[mo] then
				local insertIndex = groupTopIndex + i - 1

				modelInst:addAt(mo, insertIndex)
			end
		end

		modelInst:onModelUpdate()
	end
end

function AchievementMainViewFold:getEffectParams(curFilterType, isFold, mo, lastModifyMO)
	local orginLineHeight = mo:getLineHeight(curFilterType, not isFold)
	local targetLineHeight = mo:getLineHeight(curFilterType, isFold)

	if isFold then
		if not foldInDurationPerHeight then
			local durationPerHeight = foldoutDurationPerHeight
			local duration = math.abs(targetLineHeight - orginLineHeight) * durationPerHeight

			duration = Mathf.Clamp(duration, minAchievementFadeAnimDuration, maxAchievementFadeAnimDuration)

			return {
				mo = mo,
				isFold = isFold,
				orginLineHeight = orginLineHeight,
				targetLineHeight = targetLineHeight,
				duration = duration,
				lastModifyMO = lastModifyMO
			}
		end
	end
end

function AchievementMainViewFold.onDispatchAchievementFadeAnimationEvent(effectParams)
	local isFold = effectParams.isFold
	local lastModifyMO = effectParams.lastModifyMO

	if isFold and lastModifyMO and not lastModifyMO.isGroupTop then
		local modelInst = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()

		modelInst:remove(lastModifyMO)
	end

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnPlayGroupFadeAnim, effectParams)
end

local maxAchievementShowCount = 3

function AchievementMainViewFold:getCurRenderCellCount(groupId, moList, isFold)
	local viewType = AchievementMainCommonModel.instance:getCurrentScrollType()
	local luaScrollView = self.viewContainer:getScrollView(viewType)
	local csListScrollView = luaScrollView:getCsScroll()
	local renderCellCount = 0

	renderCellCount = not isFold and self:getCurRenderCellCountWhileFoldIn(groupId, moList, csListScrollView) or self:getCurRenderCellCountWhileFoldOut(groupId, moList, luaScrollView, csListScrollView)
	renderCellCount = Mathf.Clamp(renderCellCount, 1, maxAchievementShowCount)

	return renderCellCount
end

function AchievementMainViewFold:getCurRenderCellCountWhileFoldIn(groupId, moList, csListScrollView)
	local curFilterType = AchievementMainCommonModel.instance:getCurrentFilterType()
	local renderCellCount = 0
	local scrollPixel = csListScrollView.VerticalScrollPixel
	local viewHeight = recthelper.getHeight(csListScrollView.transform)
	local remainShowPixel = Mathf.Clamp(viewHeight - scrollPixel, 0, viewHeight)

	for i = 1, #moList do
		local mo = moList[i]
		local itemHeight = mo:getLineHeight(curFilterType, false)

		remainShowPixel = remainShowPixel - itemHeight

		if remainShowPixel > 0 then
			renderCellCount = renderCellCount + 1
		else
			break
		end
	end

	return renderCellCount
end

function AchievementMainViewFold:getCurRenderCellCountWhileFoldOut(groupId, moList, listScrollView, csListScrollView)
	local cellDict = listScrollView._cellCompDict
	local renderCellMap = {}
	local renderCellCount = 0

	for cell, _ in pairs(cellDict) do
		local cellGroupId = cell._mo.groupId

		if cellGroupId == groupId then
			renderCellMap[cell._mo.id] = cell
		end
	end

	for i = 1, #moList do
		local mo = moList[i]
		local cellItem = renderCellMap[mo.id]

		if cellItem then
			if not (cellItem._index - 1) then
				local cellIndex = -1

				if not cellItem then
					break
				end

				if not csListScrollView:IsVisual(cellIndex) then
					break
				end

				renderCellCount = renderCellCount + 1
			end
		end
	end

	return renderCellCount
end

return AchievementMainViewFold

-- chunkname: @modules/common/others/simplelistcomp/SimpleListComp.lua

module("modules.common.others.simplelistcomp.SimpleListComp", package.seeall)

local SimpleListComp = class("SimpleListComp", LuaCompBase)

function SimpleListComp:ctor(param)
	self.param = param.listParam
	self.viewContainer = param.viewContainer
	self.cellClass = self.param.cellClass

	if self.cellClass then
		self.paramClassName = self.cellClass.__cname or "dynamic"
	end

	self.items = {}
	self.listScrollView = nil
	self.mixScrollView = nil
	self.scrollRect = nil
	self.scrollbarWrap = nil
	self.listType = nil
	self.cellCtorParam = {
		viewContainer = self.viewContainer,
		simpleListComp = self,
		cellParam = self.param.cellParam
	}
	self.isClickAutoSelect = self.param.isClickAutoSelect
end

function SimpleListComp:init(go)
	self.go = go
end

function SimpleListComp:setRes(res)
	self.res = res

	if res then
		self.isResString = type(self.res) == "string"

		if not self.isResString then
			gohelper.setActive(self.res, false)
		end
	end
end

function SimpleListComp:onCreate()
	local _, listScrollView = self.go:TryGetComponent(gohelper.Type_ListScrollView, self.listScrollView)

	self.listScrollView = listScrollView

	local _, mixScrollView = self.go:TryGetComponent(gohelper.Type_MixScrollView, self.mixScrollView)

	self.mixScrollView = mixScrollView

	if self.listScrollView then
		self.listType = SimpleListType.ListScrollView
	elseif self.mixScrollView then
		self.listType = SimpleListType.LuaMixScrollView
	else
		local _, scrollRect = self.go:TryGetComponent(gohelper.Type_ScrollRect, self.scrollRect)

		self.scrollRect = scrollRect

		if self.scrollRect then
			self.listType = SimpleListType.Custom_RootIsScrollRect
			self.scrollRectViewport = self.scrollRect.viewport.gameObject
			self.customMode_content = self.scrollRect.content.gameObject

			if self.scrollRect.vertical then
				self.scrollDir = ScrollEnum.ScrollDirV or ScrollEnum.ScrollDirH
			end
		else
			self.listType = SimpleListType.Custom
			self.customMode_content = self.go
		end

		if self.customMode_content then
			local _, layoutGroup = self.customMode_content:TryGetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup), self.scrollRect)

			self.horizontalOrVerticalLayoutGroup = layoutGroup
		end
	end

	if self:isListScrollViewType() then
		local _, scrollRect = self.go:TryGetComponent(gohelper.Type_ScrollRect, self.scrollRect)

		self.scrollRect = scrollRect
		self.scrollbarWrap = gohelper.onceAddComponent(self.go, typeof(SLFramework.UGUI.ScrollRectWrap))
		self.scrollRectViewport = self.scrollRect.viewport.gameObject
		self.content = self.scrollRect.content

		if self.scrollRect.vertical then
			self.scrollDir = ScrollEnum.ScrollDirV or ScrollEnum.ScrollDirH
		end
	elseif self:isCustomType() then
		self.content = self.customMode_content
	end

	if not self.res then
		local trans = self.content.transform:GetChild(0)

		self.res = trans.gameObject

		gohelper.setActive(self.res, false)
	end

	if self.res then
		local w, h
		local isResString = type(self.res) == "string"

		if isResString then
			local go = self.viewContainer:getResInst(self.res, self.go, self.cellClass.__cname)

			self.res = go

			local transform = go.transform

			w = recthelper.getWidth(transform)
			h = recthelper.getHeight(transform)

			gohelper.setActive(go, false)
		else
			local transform = self.res.transform

			w = recthelper.getWidth(transform)
			h = recthelper.getHeight(transform)
		end

		if self.param.cellWidth <= 0 then
			self.param.cellWidth = w
		end

		if self.param.cellHeight <= 0 then
			self.param.cellHeight = h
		end
	end

	if self.listType == SimpleListType.ListScrollView then
		self.listScrollView:Init(self.scrollDir, self.param.lineCount, self.param.cellWidth, self.param.cellHeight, self.param.cellSpaceH, self.param.cellSpaceV, self.param.startSpace, self.param.endSpace, self.param.sortMode, self.param.frameUpdateMs, self.param.minUpdateCountInFrame, self.onListScrollViewUpdateCell, nil, nil, self)
		self.scrollbarWrap:AddOnValueChanged(self.onValueChanged, self)
	elseif self.listType == SimpleListType.LuaMixScrollView then
		self.mixScrollView:Init(self.scrollDir, self.param.startSpace, self.param.endSpace, {}, self.onMixScrollViewUpdateCell, self)
	end
end

function SimpleListComp:addEventListeners()
	return
end

function SimpleListComp:removeEventListeners()
	if self.scrollbarWrap then
		self.scrollbarWrap:RemoveOnValueChanged()
	end
end

function SimpleListComp:onDestroy()
	self:clearRemoveAnim()
end

function SimpleListComp:getItemGoName(index)
	self.paramClassName = self.cellClass.__cname
end

function SimpleListComp:isListScrollViewType()
	return self.listType == SimpleListType.ListScrollView or self.listType == SimpleListType.LuaMixScrollView
end

function SimpleListComp:isCustomType()
	return self.listType == SimpleListType.Custom or self.listType == SimpleListType.Custom_RootIsScrollRect
end

function SimpleListComp:haveData()
	return self.datas and #self.datas > 0
end

function SimpleListComp:setData(datas, isResetSelect)
	self.datas = datas

	if isResetSelect == nil then
		isResetSelect = true
	end

	if isResetSelect then
		self.select = nil
	end

	if self.listType == SimpleListType.ListScrollView then
		tabletool.clear(self.items)
		self.listScrollView:UpdateTotalCount(#datas)
	elseif self.listType == SimpleListType.LuaMixScrollView then
		tabletool.clear(self.items)

		local mixCellInfos = {}

		for i, data in ipairs(datas) do
			local type = data._type == nil and 1 or data._type
			local lineWidth = data._size

			if lineWidth == nil then
				logError("LuaMixScrollView模式需要设置_size")

				lineWidth = self.scrollDir == ScrollEnum.ScrollDirV and self.param.cellHeight or self.param.cellWidth
			end

			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(type, lineWidth, nil)

			table.insert(mixCellInfos, mixCellInfo)
		end

		self.mixScrollView:UpdateInfo(mixCellInfos, true, false)
	else
		self:refreshCustomMode()
	end
end

function SimpleListComp:getItems()
	return self.items
end

function SimpleListComp:getItemByIndex(index)
	return self.items[index]
end

function SimpleListComp:setRefreshAnimation(isPlay, interval, groupNum, startDelayS)
	self.isPlayRefreshAnim = isPlay

	if isPlay then
		self.animInterval = interval
		self.animationStartTime = Time.time
		self.groupNum = groupNum or 1
		self.startDelayS = startDelayS or 0
	end
end

function SimpleListComp:tryPlayShowAnim(item)
	if self.isPlayRefreshAnim then
		local animators = item:getItemAnimators()

		if animators then
			for i, animator in ipairs(animators) do
				animator:Play(UIAnimationName.Open, 0, 0)
				animator:Update(0)

				local num = math.floor(item.itemIndex / self.groupNum)
				local openAnimTime = self.startDelayS + self.animationStartTime + self.animInterval * num
				local currentAnimatorStateInfo = animator:GetCurrentAnimatorStateInfo(0)
				local length = currentAnimatorStateInfo.length
				local nor = (Time.time - openAnimTime) / length

				animator:Play(UIAnimationName.Open, 0, nor)
				animator:Update(0)
			end
		end
	end
end

function SimpleListComp:removeItemWithAnim(index, replaceData, animName, moveInterval, callback, callbackObj)
	if not self:isListScrollViewType() then
		return
	end

	replaceData = replaceData or self.datas
	animName = animName or UIAnimationName.Close
	moveInterval = moveInterval or 0
	self.removeAnimCallBack = callback
	self.removeAnimCallBackObj = callbackObj

	local removeItem = self:getItemByIndex(index)

	if not removeItem then
		logWarn("item不在显示中")
		table.remove(self.datas, index)
		self:setData(replaceData, self.select and self.select == index)

		return
	end

	table.remove(self.datas, index)

	local removeItemAnimator = removeItem:getRootAnimator()

	self.removeAnimFlow = FlowSequence.New()

	self.removeAnimFlow:addWork(AnimatorWork.New({
		go = removeItemAnimator.gameObject,
		animName = animName
	}))

	local itemParallelWork = FlowParallel.New()
	local delayCount = 0
	local items = self:getItems()

	for i, v in ipairs(items) do
		if i ~= removeItem.itemIndex then
			local oldIndex = v.itemIndex

			if oldIndex > removeItem.itemIndex then
				local newIndex = oldIndex - 1
				local rect = self.listScrollView:GetRenderCellRect(oldIndex - 1)
				local newPosX, newPosY = recthelper.getAnchor(self.listScrollView:GetRenderCellRect(newIndex - 1))
				local oldPosX, oldPosY = recthelper.getAnchor(rect)

				recthelper.setAnchor(rect, oldPosX, oldPosY)

				local work = TweenWork.New({
					type = "DOAnchorPos",
					t = 0.15,
					tr = rect,
					tox = newPosX,
					toy = newPosY,
					ease = EaseType.Linear
				})
				local sequence = FlowSequence.New()

				if moveInterval > 0 then
					sequence:addWork(WorkWaitSeconds.New(moveInterval * delayCount))
				end

				sequence:addWork(work)
				itemParallelWork:addWork(sequence)

				delayCount = delayCount + 1
			end
		end
	end

	self.removeAnimFlow:addWork(itemParallelWork)
	self.removeAnimFlow:addWork(FunctionWork.New(function()
		self:setData(replaceData, self.select and self.select == index)
	end, self))
	UIBlockMgr.instance:startBlock(UIBlockKey.SimpleListComp)
	TaskDispatcher.runDelay(self.removeBlock, self, 2)
	self.removeAnimFlow:registerDoneListener(self.onRemoveAnimFlowDone, self)
	self.removeAnimFlow:start()
end

function SimpleListComp:onRemoveAnimFlowDone()
	if self.removeAnimCallBack then
		self.removeAnimCallBack(self.removeAnimCallBackObj)
	end

	self:clearRemoveAnim()
end

function SimpleListComp:removeBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.SimpleListComp)
end

function SimpleListComp:clearRemoveAnim()
	TaskDispatcher.cancelTask(self.removeBlock, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.SimpleListComp)

	self.removeAnimFlow = nil
	self.removeAnimCallBack = nil
	self.removeAnimCallBackObj = nil
end

function SimpleListComp:getListScrollView()
	if self.listType == SimpleListType.ListScrollView then
		return self.listScrollView
	elseif self.listType == SimpleListType.LuaMixScrollView then
		return self.mixScrollView
	end
end

function SimpleListComp:onMixScrollViewUpdateCell(cellGO, index, type, param)
	self:onListScrollViewUpdateCell(cellGO, index)
end

function SimpleListComp:onListScrollViewUpdateCell(cellGO, index)
	index = index + 1

	local childCount = cellGO.transform.childCount
	local go, item

	if childCount <= 0 then
		local name = self.paramClassName .. "_" .. index

		go = self.isResString and self.viewContainer:getResInst(self.res, cellGO, name) or gohelper.clone(self.res, cellGO, name)

		gohelper.setActive(go, true)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, self.cellClass, self.cellCtorParam)
	else
		go = cellGO.transform:GetChild(0).gameObject
		item = MonoHelper.getLuaComFromGo(go, self.cellClass, self.cellCtorParam)
	end

	if self.items[index] and self.items[index] ~= item then
		self.items[index]:hideItem()
	end

	self.items[index] = item

	local isSelect = index == self.select
	local isLastItem = index == #self.datas

	item:showItem(self.datas[index], index, isSelect, isLastItem, self.onClickItem, self)
	item:setSelect(self.select == index)
	self:tryPlayShowAnim(item)
end

function SimpleListComp:setOnValueChanged(onValueChangedCallBack, context)
	self.callBackContext = context
	self.onValueChangedCallBack = onValueChangedCallBack
end

function SimpleListComp:onValueChanged(scrollX, scrollY)
	if self.onValueChangedCallBack then
		self.onValueChangedCallBack(self.callBackContext, scrollX, scrollY)
	end
end

function SimpleListComp:getScrollPixel()
	local listScrollView = self:getListScrollView()

	if self.scrollDir == ScrollEnum.ScrollDirV then
		return listScrollView.VerticalScrollPixel
	elseif self.scrollDir == ScrollEnum.ScrollDirH then
		return listScrollView.HorizontalScrollPixel
	end
end

function SimpleListComp:addCustomItem(go, class)
	class = class or self.cellClass
	self.items[#self.items + 1] = MonoHelper.addNoUpdateLuaComOnceToGo(go, class, self.cellCtorParam)
end

function SimpleListComp:refreshCustomMode()
	local customItemAmount = #self.items
	local listLength = #self.datas

	for index = 1, listLength do
		if customItemAmount < index then
			local go
			local name = self.paramClassName .. "_" .. index

			go = self.isResString and self.viewContainer:getResInst(self.res, self.customMode_content, name, self) or gohelper.clone(self.res, self.customMode_content, name)

			gohelper.setActive(go, true)

			self.items[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, self.cellClass, self.cellCtorParam)
		end

		local item = self.items[index]

		gohelper.setActive(item.viewGO, true)

		local isLastItem = index == #self.datas
		local isSelect = index == self.select

		item:showItem(self.datas[index], index, isSelect, isLastItem, self.onClickItem, self)
		item:setSelect(self.select == index)
		self:tryPlayShowAnim(item)
	end

	for i = listLength + 1, customItemAmount do
		local item = self.items[i]

		gohelper.setActive(item.viewGO, false)
		self.items[i]:hideItem()
	end
end

function SimpleListComp:rebuildLayout()
	ZProj.UGUIHelper.RebuildLayout(self.customMode_content.transform)
end

function SimpleListComp:setOnClickItem(onClickItemFunc, context)
	self.onClickItemFunc = onClickItemFunc
	self.onClickItemFuncContext = context
end

function SimpleListComp:setIsClickAutoSelect(v)
	self.isClickAutoSelect = v
end

function SimpleListComp:onClickItem(item)
	if self.onClickItemFunc then
		self.onClickItemFunc(self.onClickItemFuncContext, item)
	end

	if self.isClickAutoSelect then
		self:setSelect(item.itemIndex)
	end
end

function SimpleListComp:setSelect(tarSelect)
	local haveChange = (not tarSelect or not self.select or self.select ~= tarSelect) and (not not tarSelect or not not self.select)

	if haveChange then
		local oldSelect = self.select

		if self.select and self.items[self.select] then
			self.items[self.select]:setSelect(false)
		end

		self.select = tarSelect

		if self.select and self.items[self.select] then
			self.items[self.select]:setSelect(true)
		end

		if self.onSelectCallBack then
			self.onSelectCallBack(self.onSelectCallBackContext, self.items[self.select], self.select, oldSelect)
		end
	end
end

function SimpleListComp:setOnSelectChange(onSelectCallBack, onSelectCallBackContext)
	self.onSelectCallBack = onSelectCallBack
	self.onSelectCallBackContext = onSelectCallBackContext
end

function SimpleListComp:getSelect()
	return self.select
end

function SimpleListComp:getCurSelectItem()
	return self.items[self.select]
end

function SimpleListComp:moveTo(index)
	if self.listType == SimpleListType.ListScrollView then
		local listScrollView = self:getListScrollView()

		index = index - 1

		local space = 0

		if index > 0 then
			space = self:getScrollSpace()
		end

		if self.scrollDir == ScrollEnum.ScrollDirV then
			listScrollView.VerticalScrollPixel = (self.param.cellHeight + space) * index
		elseif self.scrollDir == ScrollEnum.ScrollDirH then
			listScrollView.HorizontalScrollPixel = (self.param.cellWidth + space) * index
		end
	elseif self.listType == SimpleListType.Custom_RootIsScrollRect then
		if self.scrollDir == ScrollEnum.ScrollDirV then
			local item = self:getItemByIndex(index)
			local itemPos = math.abs(recthelper.getAnchorY(item.transform))
			local tarPer = 0.5
			local contentH = recthelper.getHeight(self.customMode_content.transform)
			local viewPortH = recthelper.getHeight(self.scrollRectViewport.transform)
			local dis = contentH - viewPortH
			local tarPos = dis + viewPortH * tarPer
			local normalizedPos = (tarPos - itemPos) / dis

			normalizedPos = GameUtil.clamp(normalizedPos, 0, 1)
			self.scrollRect.verticalNormalizedPosition = normalizedPos
		elseif self.scrollDir == ScrollEnum.ScrollDirH then
			self.scrollRect.horizontalNormalizedPosition = 1
		end
	end
end

function SimpleListComp:getScrollSpace()
	if self.listType == SimpleListType.ListScrollView then
		if self.scrollDir == ScrollEnum.ScrollDirV then
			return self.param.cellSpaceV
		elseif self.scrollDir == ScrollEnum.ScrollDirH then
			return self.param.cellSpaceH
		end
	end
end

return SimpleListComp

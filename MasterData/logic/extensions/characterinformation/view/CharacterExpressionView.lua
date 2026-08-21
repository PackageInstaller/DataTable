-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/CharacterExpressionView.lua

module("logic.extensions.characterinformation.view.CharacterExpressionView", package.seeall)

local M = class("CharacterExpressionView", DynamicFragmentView)

function M:buildUI()
	self._loopList = LoopListHelper.New(self:getGo("role_expression_tips_-1061086282"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._loopViewComp = self._loopList:GetLoopListView()
	self._scroll = self:getUIComponent("role_expression_tips_-1061086282", UIComponentType.ScrollRect)
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
	self._loopViewComp = nil
	self._scroll = nil
end

function M:onEnter()
	self:_setEvent(true)

	self._itemCell = {}
	self._photoUnit = nil

	self:_refreshByHeroChange()
	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_EXPRESSION_SPINE_CHANGE, true)
end

function M:onExit()
	self:_setEvent(false)
	self:_playItemOpenAni(false)
	self:beforeExit()

	for _, shower in pairs(self._itemCell or {}) do
		shower:StopAni()
		shower:setAlpha(0)
	end

	self._loopList:ClearCells()

	self._itemCell = nil
end

function M:beforeExit()
	if self._curUseFacdeId ~= self._curSelectFaceId then
		local faceCO = ExpressionConfig.instance:getConfigByModelIdAndExpressionId(self._modelId, self._curUseFacdeId)

		self._photoUnit:setFace(faceCO.expressionRes)
	end

	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_EXPRESSION_SPINE_CHANGE, false)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_UNLOCK, self._refreshViewWhenChangeFace, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_UNLOCK, self._refreshViewWhenChangeFace, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_VIEW_SWITCH, self._refreshByHeroChange, self)
	end
end

function M:playGuiAni(name)
	if self.mainGO.activeSelf and not string.nilorempty(name) and name == "close" then
		for key, shower in pairs(self._itemCell or {}) do
			shower:playAniByName("role_other_item_close")
		end
	end
end

function M:_refreshByHeroChange()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._heroId = self._heroData:getId()
	self._modelId = self._heroData:getModelId()
	self._curUseFacdeId = CharacterInformationModel.instance:getCurSelectFace(self._heroId)
	self._curSelectFaceId = self._curUseFacdeId

	local herodata = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	self._ownHero = herodata ~= nil and herodata ~= false

	self:_refreshView()

	self._scroll.enabled = false
	self._needPlayItemCellOpenAni = true

	self:_refreshScrollView(false)
	settimer(0.1, self._delayMoveToSelectedItem, self, false)
end

function M:_delayMoveToSelectedItem()
	removetimer(self._delayMoveToSelectedItem, self)

	local index = self._curSelectFaceId - 1

	self._loopList:MoveToItemIndex(index, 0)
	self:_playItemOpenAni(true)
end

function M:_refreshView()
	self._expressionList = {}

	local count = ExpressionConfig.instance:getExpressionCountByModelId(self._modelId)

	for i = 1, count do
		local faceData = {}
		local faceCO = ExpressionConfig.instance:getConfigByModelIdAndExpressionId(self._modelId, i)

		if faceCO then
			faceData.faceCO = faceCO
			faceData.heroId = self._heroId

			table.insert(self._expressionList, faceData)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_TAB_CHANGE, false)
end

function M:_refreshViewWhenChangeFace()
	self._curUseFacdeId = CharacterInformationModel.instance:getCurSelectFace(self._heroId)

	self:_refreshScrollViewData()
end

function M:_refreshScrollView(resetPos)
	self._loopList:SetListItemCount(#self._expressionList, resetPos)
	self._loopList:RefreshAllShownItem()
end

function M:_refreshScrollViewData()
	for _, shower in pairs(self._itemCell or {}) do
		shower:setUseAndSelectFaceId(self._curUseFacdeId, self._curSelectFaceId)
		shower:_refreshView()
	end
end

function M:_onCellUpdate(curIndex)
	local dataIndex = curIndex + 1
	local data = self._expressionList[dataIndex]
	local item = self._loopList:NewListViewItem("role_other_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, ExpressionCellComp)

	shower:setUseAndSelectFaceId(self._curUseFacdeId, self._curSelectFaceId)
	shower:updateData(data, self._ownHero, dataIndex)
	shower:setClickCallBack(self._clickCallBack, self)

	self._itemCell[item.gameObject:GetInstanceID()] = shower

	if self._needPlayItemCellOpenAni then
		shower:setAlpha(0)
		goutil.setActive(item.gameObject, true)
	else
		shower:setAlpha(1)
		goutil.setActive(item.gameObject, true)
		shower:playOpenAni()
	end

	return item
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	local minIndex, maxIndex = self._loopList:GetCurShowItemIndexRange()

	if play then
		local index = 1

		for i = minIndex, maxIndex do
			local isLast = i == maxIndex
			local loopItem = self._loopViewComp:GetShownItemByItemIndex(i)

			if loopItem then
				local shower = self._itemCell[loopItem.gameObject:GetInstanceID()]

				shower:StopAni()
				shower:setAlpha(0)

				local delay = index * 0.07

				delay = delay > 1 and 1 or delay

				local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
					shower:playOpenAni()
					shower:setAlpha(1)

					if isLast then
						self._needPlayItemCellOpenAni = false
						self._scroll.enabled = true
					end
				end)

				table.insert(self._cacheTweenLst, tweenDelay)

				index = index + 1
			end
		end

		for _, shower in pairs(self._itemCell or {}) do
			local showerIndex = shower:getIndex() - 1

			if showerIndex < minIndex or maxIndex < showerIndex then
				shower:StopAni()
				shower:setAlpha(1)
				shower:fixAni()
			end
		end
	else
		for _, shower in pairs(self._itemCell or {}) do
			shower:setAlpha(1)
			shower:fixAni()
		end

		self._cacheTweenLst = nil
		self._needPlayItemCellOpenAni = false
	end
end

function M:_clickCallBack(funcName, ...)
	if funcName == "select" then
		self:_onSelectItem(...)
	elseif funcName == "use" then
		self:_onClickUse(...)
		self:_refreshScrollViewData()
	end
end

function M:_onSelectItem(faceId, index)
	self._curSelectFaceId = faceId

	self:_refreshScrollViewData()

	local faceData = self._expressionList[index]

	self._photoUnit:setFace(faceData.faceCO.expressionRes)
end

function M:_onClickUse(faceId, index)
	if not self._ownHero then
		return
	end

	local newFaceId = 2000 + faceId
end

return M

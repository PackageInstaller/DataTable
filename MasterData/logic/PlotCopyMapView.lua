-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotCopyMapView.lua

module("logic.extensions.plotcopy.view.PlotCopyMapView", package.seeall)

local PlotCopyMapView = class("PlotCopyMapView", ViewComponent)

function PlotCopyMapView:ctor()
	return
end

function PlotCopyMapView:buildUI()
	self._mapItem = self:getGo("bigMap/mapItem")
	self._root = self:getGo("bigMap/moveableMap/root")
	self._recordPos = self._root:GetComponent("TestRecordPos")
	self._bigMapRect = self:getGo("bigMap"):GetComponent(goutil.Type_RectTransform)
	self._targetPointRect = self:getGo("bigMap/targetPoint"):GetComponent(goutil.Type_RectTransform)
	self._moveableMapRect = self:getGo("bigMap/moveableMap"):GetComponent(goutil.Type_RectTransform)

	goutil.setActive(self._mapItem, false)

	self._bgEffect = self:getGo("bigMap/moveableMap/effect")
	self._areaParent = self:getGo("bigMap/moveableMap/area")
	self._areas = {}

	local count = CopyConfig.instance:getPlotAreaCfgsCount()

	for i = 1, count do
		local go = Framework.GameObjectUtil.AddNewChildToParent(self._areaParent, "area" .. i)

		go:AddComponent(goutil.Type_RectTransform)

		self._areas[i] = go
	end

	self._recordArea = self._areaParent:GetComponent("TestRecordPos")

	self._recordArea:LoadPlan(0)

	self._dissipationEffectGo = self:getGo("bigMap/moveableMap/dissipationEffect")
	self._lockItem = self:getGo("bigMap/lockItem")
	self._lockParent = self:getGo("bigMap/moveableMap/lock")
	self._lockGos = {}

	goutil.setActive(self._lockItem, false)

	for i = 1, count do
		local go = goutil.cloneAndSetParent(self._lockItem, self._lockParent.transform, "lock_" .. i)

		goutil.setActive(go, true)

		self._lockGos[i] = go
	end

	self._recordLock = self._lockParent:GetComponent("TestRecordPos")

	self._recordLock:LoadPlan(0)
end

function PlotCopyMapView:onEnter()
	self._isFirst = true

	GlobalDispatcher:addListener(GlobalNotify.CopyUpdateMap, self._updateMap, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyUpdateMapSelect, self._updateSelectItem, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyHideSelectItem, self._hideItem, self)
	GlobalDispatcher:addListener(GlobalNotify.PlayAreaUnlockEffect, self._playAreaUnlockEffect, self)

	self._plotMapItems = {}

	self:_loadAreaEffect()
	self:_loadBgEffect()
	self:_initAreaUnlockEffect()
	self:_initAreaOpenState()
end

function PlotCopyMapView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CopyUpdateMap, self._updateMap, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopyUpdateMapSelect, self._updateSelectItem, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopyHideSelectItem, self._hideItem, self)
	GlobalDispatcher:removeListener(GlobalNotify.PlayAreaUnlockEffect, self._playAreaUnlockEffect, self)
	self:_clearMapItems()
	self:_removeAreaEffect()
end

function PlotCopyMapView:_updateMap(chapterType, curViewDatas, initSelectIndex, isSwitch)
	self:_clearMapItems()

	local chapters = CopyConfig.instance:getChapters(chapterType)
	local childCount = self._root.transform.childCount

	for i, v in ipairs(curViewDatas) do
		local go = i <= childCount and self._root.transform:GetChild(i - 1).gameObject or goutil.cloneAndSetParent(self._mapItem, self._root.transform, "item" .. i)

		goutil.setActive(go, true)

		go.name = "item_" .. v.cfg.chapterId

		local plotMapItem = GameUtil.AddLuaOnce(go, PlotMapItem)

		plotMapItem:init(go, v, self)
		plotMapItem:setSelect(v.index == initSelectIndex)
		table.insert(self._plotMapItems, plotMapItem)
	end

	if chapterType == GameEnum.Chapter.Plot then
		self._recordPos:LoadPlan(0)
	else
		self._recordPos:LoadPlan(1)
	end

	self:_focusItem(initSelectIndex, isSwitch)
end

function PlotCopyMapView:_clearMapItems()
	if self._plotMapItems then
		for i, v in ipairs(self._plotMapItems) do
			v:reset()
		end

		table.clear(self._plotMapItems)
	end

	local childCount = self._root.transform.childCount

	if childCount > 0 then
		for i = 1, childCount do
			local transform = self._root.transform:GetChild(i - 1)

			transform.gameObject:SetActive(false)
		end
	end
end

function PlotCopyMapView:_updateSelectItem(selectIndex, isSame)
	for i, v in ipairs(self._plotMapItems) do
		v:setSelect(i == selectIndex)
	end

	self:_focusItem(selectIndex, false, isSame)
end

function PlotCopyMapView:_focusItem(selectIndex, isSwitch, isSame)
	local moveItem

	for i, v in ipairs(self._plotMapItems) do
		if v:getIndex() == selectIndex then
			moveItem = v
		end
	end

	if moveItem then
		moveItem:focusItem(self._bigMapRect, self._moveableMapRect, self._targetPointRect, self._isFirst, isSwitch, isSame)

		if self._isFirst then
			self._isFirst = false
		end
	end
end

function PlotCopyMapView:_hideItem(selectIndex)
	local selectItem = self._plotMapItems[selectIndex]

	if selectItem then
		selectItem:hideItem()
	end
end

function PlotCopyMapView:_loadBgEffect()
	local effect = UIEffectManager.instance:playEffect(self, "fx_scene_dachangjing/fx_scene_dachangjing.prefab", self._bgEffect.transform, 0, 0, true, false)

	effect:setParent(self._bgEffect.transform)
	effect:setScale(1)
end

function PlotCopyMapView:_loadAreaEffect()
	self._areaEffects = {}

	for i, v in ipairs(self._areas) do
		local effectPath = "fx_ui_suoding/fx_ui_suoding_smoke01.prefab"
		local effect = UIEffectManager.instance:playEffect(self, effectPath, self._areas[i].transform, 0, 0, true, false)

		effect:setParent(self._areas[i].transform)
		effect:setScale(1)
		effect:setSortingOrder(211)

		effect.hideEffWhileNotOnTop = false

		table.insert(self._areaEffects, effect)
	end
end

function PlotCopyMapView:_removeAreaEffect()
	if self._areaEffects then
		for i, v in ipairs(self._areaEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._areaEffects)

		self._areaEffects = nil
	end
end

function PlotCopyMapView:_initAreaOpenState()
	PlotCopyModel.instance:markAreaUnlock()

	local cfgs = CopyConfig.instance:getPlotAreaAllCfg()

	for i, vCfg in ipairs(cfgs) do
		local chapterId = vCfg.chapterIds[1]
		local isChapterUnLock = PlotCopyModel.instance:isChapterUnlock(chapterId)
		local areaId = PlotCopyModel.instance:getAreaIdBy(chapterId)
		local isPlayedEffect = PlotCopyModel.instance:getAreaUnlockState(areaId)
		local isActive = not isChapterUnlock and not isPlayedEffect

		goutil.setActive(self._areas[i], isActive)
		goutil.setActive(self._lockGos[i], isActive)
	end
end

function PlotCopyMapView:_initAreaUnlockEffect()
	goutil.setActive(self._dissipationEffectGo, false)

	local effectPath = "fx_ui_suoding/fx_ui_suoding_smoke02.prefab"
	local effect = UIEffectManager.instance:playEffect(self, effectPath, self._dissipationEffectGo.transform, 0, 0, true, false)

	effect:setParent(self._dissipationEffectGo.transform)
	effect:setScale(1)
	effect:setSortingOrder(211)
	effect:setLocalPos(0, 0, 0)

	effect.hideEffWhileNotOnTop = false
end

function PlotCopyMapView:_playAreaUnlockEffect(areaId, effectTime)
	PlotCopyModel.instance:setAreaUnlockStateOver(areaId)

	local targetGo = self._areas[areaId]
	local lockGo = self._lockGos[areaId]

	if targetGo then
		self._dissipationEffectGo.transform.position = targetGo.transform.position
		self._dissipationEffectGo.transform.localScale = targetGo.transform.localScale
	end

	goutil.setActive(self._dissipationEffectGo, true)
	goutil.setActive(targetGo, false)
	goutil.setActive(lockGo, false)
	TweenUtil.DoDelay(effectTime, function()
		goutil.setActive(self._dissipationEffectGo, false)
	end)
end

return PlotCopyMapView

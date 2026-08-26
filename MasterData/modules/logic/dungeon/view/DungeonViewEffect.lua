-- chunkname: @modules/logic/dungeon/view/DungeonViewEffect.lua

module("modules.logic.dungeon.view.DungeonViewEffect", package.seeall)

local DungeonViewEffect = class("DungeonViewEffect", BaseView)

function DungeonViewEffect:onInitView()
	self._gostory = gohelper.findChild(self.viewGO, "#go_story")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonViewEffect:addEvents()
	return
end

function DungeonViewEffect:removeEvents()
	return
end

function DungeonViewEffect:_editableInitView()
	self._effect = gohelper.findChild(self.viewGO, "#go_story/effect")
	self._effectTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._effect)

	self._effectTouchEventMgr:SetIgnoreUI(true)
	self._effectTouchEventMgr:SetOnlyTouch(true)
	self._effectTouchEventMgr:SetOnTouchDownCb(self._onEffectTouchDown, self)
	self:_loadEffect()
end

function DungeonViewEffect:_loadEffect()
	self._effectItem = self:getUserDataTb_()
	self._effectIndex = 1
	self._effectNum = 3
	self._effectUrl = "ui/viewres/dungeon/dungeonview_effect.prefab"
	self._effectLoader = MultiAbLoader.New()

	self._effectLoader:addPath(self._effectUrl)
	self._effectLoader:startLoad(self._effectLoaded, self)
end

function DungeonViewEffect:_effectLoaded(effectLoader)
	local assetItem = effectLoader:getAssetItem(self._effectUrl)
	local effectPrefab = assetItem:GetResource(self._effectUrl)

	for i = 1, self._effectNum do
		local item = self:getUserDataTb_()

		item.go = gohelper.clone(effectPrefab, self._effect)
		item.tweenId = nil

		table.insert(self._effectItem, item)
		gohelper.setActive(item.go, false)
	end
end

function DungeonViewEffect:_onEffectTouchDown(pos)
	if UIBlockMgr.instance:isBlock() then
		return
	end

	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	if not viewNameList or #viewNameList <= 0 then
		return
	end

	for i = #viewNameList, 1, -1 do
		local viewSetting = ViewMgr.instance:getSetting(viewNameList[i])

		if viewNameList[i] ~= ViewName.DungeonView and (viewSetting.layer == "POPUP_TOP" or viewSetting.layer == "POPUP") then
			return
		end

		if viewNameList[i] == ViewName.DungeonView then
			break
		end
	end

	local item = self._effectItem[self._effectIndex]

	if not item then
		return
	end

	pos = recthelper.screenPosToAnchorPos(pos, self._effect.transform)

	if item.tweenId then
		ZProj.TweenHelper.KillById(item.tweenId)
		gohelper.setActive(item.go, false)
	end

	gohelper.setActive(item.go, true)
	transformhelper.setLocalPosXY(item.go.transform, pos.x, pos.y)

	item.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1, nil, self._effectTweenFinish, self, self._effectIndex)
	self._effectIndex = self._effectIndex >= self._effectNum and 1 or self._effectIndex + 1
end

function DungeonViewEffect:_effectTweenFinish(effectIndex)
	local item = self._effectItem[effectIndex]

	if not item then
		return
	end

	item.tweenId = nil

	gohelper.setActive(item.go, false)
end

function DungeonViewEffect:onDestroyView()
	if self._effectTouchEventMgr then
		TouchEventMgrHepler.remove(self._effectTouchEventMgr)

		self._effectTouchEventMgr = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()
	end

	for i = 1, #self._effectItem do
		local item = self._effectItem[i]

		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)
		end
	end
end

return DungeonViewEffect

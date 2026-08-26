-- chunkname: @modules/logic/towercompose/view/result/TowerComposeNormalResultHeroGroupListView.lua

module("modules.logic.towercompose.view.result.TowerComposeNormalResultHeroGroupListView", package.seeall)

local TowerComposeNormalResultHeroGroupListView = class("TowerComposeNormalResultHeroGroupListView", BaseView)

function TowerComposeNormalResultHeroGroupListView:onInitView()
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "go_Result/#go_herogroupcontain")
	self._goheroitem = gohelper.findChild(self.viewGO, "go_Result/#go_heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeNormalResultHeroGroupListView:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function TowerComposeNormalResultHeroGroupListView:removeEvents()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function TowerComposeNormalResultHeroGroupListView:_editableInitView()
	gohelper.setActive(self._goheroitem, false)
	self:_initData()
	self:_initHeroItems()
end

function TowerComposeNormalResultHeroGroupListView:onUpdateParam()
	return
end

function TowerComposeNormalResultHeroGroupListView:onOpen()
	self:_updateHeroList()
	self:_playOpenAnimation()
end

function TowerComposeNormalResultHeroGroupListView:_initData()
	self.fightParam = TowerComposeModel.instance:getRecordFightParam()
	self._themeId, self._layerId = self.fightParam.themeId, self.fightParam.layerId
	self._towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self._themeId, self._layerId)
	self._dunEpisodeCo = DungeonConfig.instance:getEpisodeCO(self._towerEpisodeCo.episodeId)
	self._episodeId = self._towerEpisodeCo.episodeId
	self._battleId = self._dunEpisodeCo.battleId
	self._battleCo = lua_battle.configDict[self._battleId]
	self._isPlane = self._towerEpisodeCo.plane ~= TowerComposeEnum.PlaneType.None
	self._playerNum = self._battleCo.roleNum
end

function TowerComposeNormalResultHeroGroupListView:_initHeroItems()
	self._heroItemList = self:getUserDataTb_()
	self.heroItemGOList = self:getUserDataTb_()
	self._heroPosTrs = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()
	self._bgList = self:getUserDataTb_()
	self._orderList = self:getUserDataTb_()

	for index = 1, self._playerNum do
		self:createHeroItem(index, self._goherogroupcontain)
	end
end

function TowerComposeNormalResultHeroGroupListView:createHeroItem(index, heroContainer)
	local heroItemGO = self.heroItemGOList[index]

	if not heroItemGO then
		heroItemGO = {
			index = index
		}
		heroItemGO.planeType = self._isPlane and Mathf.Ceil(index / self._playerNum) or 0
		heroItemGO.heroContainerGO = heroContainer
		heroItemGO.posGO = gohelper.findChild(heroContainer, "area/pos" .. index .. "/container")
		heroItemGO.heroRoot = gohelper.findChild(heroContainer, "hero")
		heroItemGO.areaRoot = gohelper.findChild(heroContainer, "area")
		heroItemGO.go = gohelper.clone(self._goheroitem, heroItemGO.heroRoot, "heroItem" .. index)

		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(heroItemGO.go, TowerComposeResultHeroGroupHeroItem, self)

		self.heroItemGOList[index] = heroItemGO

		local posTrans = heroItemGO.posGO.transform
		local bg = gohelper.findChild(heroContainer, "hero/bg" .. index .. "/bg")
		local order = gohelper.findChildText(heroContainer, "hero/bg" .. index .. "/bg/txt_order")

		table.insert(self._bgList, bg)
		table.insert(self._orderList, order)
		table.insert(self._heroItemPosList, heroItemGO.go.transform)
		table.insert(self._heroPosTrs, posTrans)
		table.insert(self._heroItemList, heroItem)
		heroItem:setIndex(index)
		self:setHeroItemPos(heroItem, index)
		heroItem:setParent(self._heroPosTrs[index])
		heroItem:setPlaneType(heroItem.planeType)
	end

	gohelper.setActive(heroItemGO.go, true)

	if heroItemGO.planeType == 2 then
		self._orderList[index].text = index % 4 or index
	end
end

function TowerComposeNormalResultHeroGroupListView:setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self._heroPosTrs[index]
	local heroContainerGO = self.heroItemGOList[index].heroContainerGO
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, heroContainerGO.transform)

	if heroItem then
		heroItem:resetEquipPos()
	end

	recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)
end

function TowerComposeNormalResultHeroGroupListView:_updateHeroList()
	for index, heroItem in ipairs(self._heroItemList) do
		local mo = HeroSingleGroupModel.instance:getById(index)

		heroItem:onUpdateMO(mo)
	end
end

function TowerComposeNormalResultHeroGroupListView:_playOpenAnimation()
	for i, posTr in ipairs(self._heroPosTrs) do
		if posTr then
			local anim = posTr.gameObject:GetComponent(typeof(UnityEngine.Animator))

			anim:Play(UIAnimationName.Open)
			anim:Update(0)

			anim.speed = 1
		end
	end

	for i, heroItem in ipairs(self._heroItemList) do
		if heroItem then
			local anim = heroItem.anim

			anim:Play(UIAnimationName.Open)
			anim:Update(0)

			anim.speed = 1
		end
	end

	for i, bg in ipairs(self._bgList) do
		if bg then
			local anim = bg:GetComponent(typeof(UnityEngine.Animator))

			anim:Play(UIAnimationName.Open)
			anim:Update(0)

			anim.speed = 1
		end
	end
end

function TowerComposeNormalResultHeroGroupListView:_onScreenSizeChange()
	for i = 1, self._playerNum do
		local heroItem = self._heroItemList[i]

		self:setHeroItemPos(heroItem, i)
	end
end

function TowerComposeNormalResultHeroGroupListView:onClose()
	return
end

function TowerComposeNormalResultHeroGroupListView:onDestroyView()
	return
end

return TowerComposeNormalResultHeroGroupListView

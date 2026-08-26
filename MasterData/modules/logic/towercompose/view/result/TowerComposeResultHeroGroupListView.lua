-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultHeroGroupListView.lua

module("modules.logic.towercompose.view.result.TowerComposeResultHeroGroupListView", package.seeall)

local TowerComposeResultHeroGroupListView = class("TowerComposeResultHeroGroupListView", BaseView)

function TowerComposeResultHeroGroupListView:onInitView()
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain")
	self._goherogroupcontain2 = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain2")
	self._goplaneHeroContain = gohelper.findChild(self.viewGO, "go_result/#go_herogroupcontain2/contain")
	self._goheroitem = gohelper.findChild(self.viewGO, "go_result/#go_heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeResultHeroGroupListView:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function TowerComposeResultHeroGroupListView:removeEvents()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function TowerComposeResultHeroGroupListView:_editableInitView()
	gohelper.setActive(self._goheroitem, false)
	self:_initData()
	self:_initHeroItems()
end

function TowerComposeResultHeroGroupListView:onUpdateParam()
	return
end

function TowerComposeResultHeroGroupListView:onOpen()
	self:_checkReplaceHeroList()
	self:_updateHeroList()
	self:_playOpenAnimation()
end

function TowerComposeResultHeroGroupListView:_checkReplaceHeroList()
	local groupMO = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(self._roleNum)
	groupMO:setTowerComposeHeroList(self._roleNum)
	HeroSingleGroupModel.instance:setSingleGroup(groupMO, true)
end

function TowerComposeResultHeroGroupListView:_initData()
	self.fightParam = TowerComposeModel.instance:getRecordFightParam()
	self._themeId, self._layerId = self.fightParam.themeId, self.fightParam.layerId
	self._towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(self._themeId, self._layerId)
	self._dunEpisodeCo = DungeonConfig.instance:getEpisodeCO(self._towerEpisodeCo.episodeId)
	self._episodeId = self._towerEpisodeCo.episodeId
	self._battleId = self._dunEpisodeCo.battleId
	self._battleCo = lua_battle.configDict[self._battleId]
	self._isPlane = self._towerEpisodeCo.plane ~= TowerComposeEnum.PlaneType.None
	self._isTwicePlane = self._towerEpisodeCo.plane == TowerComposeEnum.PlaneType.Twice

	if self._isPlane then
		if not ModuleEnum.HeroGroupSnapshotType.TowerComposeBoss then
			local heroGroupId = ModuleEnum.HeroGroupSnapshotType.TowerComposeNormal
			local heroTeamConfig = lua_hero_team.configDict[heroGroupId]
			local roleNumMax = heroTeamConfig.batNum

			self._playerNum = self._battleCo.roleNum
			self._roleNum = self._isTwicePlane and roleNumMax or self._playerNum

			gohelper.setActive(self._goherogroupcontain, not self._isTwicePlane)
			gohelper.setActive(self._goherogroupcontain2, self._isTwicePlane)
		end
	end
end

function TowerComposeResultHeroGroupListView:_initHeroItems()
	self._heroItemList = self:getUserDataTb_()
	self._heroItemGoList = self:getUserDataTb_()
	self._heroPosTrs = self:getUserDataTb_()
	self._heroItemPosList = self:getUserDataTb_()
	self._bgList = self:getUserDataTb_()
	self._orderList = self:getUserDataTb_()

	if self._isTwicePlane then
		if not self._goplaneHeroContain then
			local heroContainerGO = self._goherogroupcontain

			for index = 1, self._roleNum do
				self:createHeroItem(index, heroContainerGO)
			end
		end
	end
end

function TowerComposeResultHeroGroupListView:createHeroItem(index, heroContainer)
	local heroItemGO = self._heroItemGoList[index]

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

		self._heroItemGoList[index] = heroItemGO

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

function TowerComposeResultHeroGroupListView:setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self._heroPosTrs[index]
	local heroContainerGO = self._heroItemGoList[index].heroContainerGO
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, heroContainerGO.transform)

	if heroItem then
		heroItem:resetEquipPos()
	end

	recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)
end

function TowerComposeResultHeroGroupListView:_updateHeroList()
	for index, heroItem in ipairs(self._heroItemList) do
		local mo = HeroSingleGroupModel.instance:getById(index)

		heroItem:onUpdateMO(mo)
	end
end

function TowerComposeResultHeroGroupListView:_playOpenAnimation()
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

function TowerComposeResultHeroGroupListView:_onScreenSizeChange()
	for i = 1, self._roleNum do
		local heroItem = self._heroItemList[i]

		self:setHeroItemPos(heroItem, i)
	end
end

function TowerComposeResultHeroGroupListView:onClose()
	return
end

function TowerComposeResultHeroGroupListView:onDestroyView()
	return
end

return TowerComposeResultHeroGroupListView

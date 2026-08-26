-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupListView.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupListView", package.seeall)

local V3a9_BossRush_HeroGroupListView = class("V3a9_BossRush_HeroGroupListView", BaseView)

function V3a9_BossRush_HeroGroupListView:onInitView()
	self.herogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self.heroContainer = gohelper.findChild(self.viewGO, "herogroupcontain/heroContainer")
	self.recordPos = gohelper.findChild(self.viewGO, "herogroupcontain/recordPos")
	self.equipItem = gohelper.findChild(self.viewGO, "herogroupcontain/heroContainer/go_EquipItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_HeroGroupListView:addEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshInfo, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnModifyHeroGroup, self._refreshHeros, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnModifyEquip, self._refreshEquips, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshHeros, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UseHeroGroup, self._onUseHeroGroup, self)
end

function V3a9_BossRush_HeroGroupListView:removeEvents()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshInfo, self)
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnModifyHeroGroup, self._refreshHeros, self)
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnModifyEquip, self._refreshEquips, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshHeros, self)
	self.removeEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UseHeroGroup, self._onUseHeroGroup, self)
end

function V3a9_BossRush_HeroGroupListView:_onUseHeroGroup(param)
	if not param or not param.groupId or not param.subId then
		return
	end

	local groupMo = HeroGroupModel.instance:getCommonGroupList(param.subId)

	if not groupMo or not groupMo.heroList then
		return
	end

	V3a9_BossRushModel.instance:replaceFrontHeroGroup(groupMo.heroList, groupMo.equips)
end

function V3a9_BossRush_HeroGroupListView:refreshInfo()
	if not self._actModeTeam then
		return
	end

	self:refresh()
end

function V3a9_BossRush_HeroGroupListView:_editableInitView()
	self._heroItems = self:getUserDataTb_()
	self._fontHeroItems = self:getUserDataTb_()
	self._equipItems = self:getUserDataTb_()
	self._heroRoots = self:getUserDataTb_()
	self._equipRoots = self:getUserDataTb_()

	gohelper.setActive(self.equipItem.gameObject, false)

	for i = 1, V3a9BossRushEnum.HeroCount do
		local heroItem = self:_getHeroItem(i, self._stage)
		local heroRoot = gohelper.findChild(self.recordPos, "heroPos" .. i)

		self._heroRoots[i] = heroRoot

		local anchorPos = recthelper.rectToRelativeAnchorPos(heroRoot.transform.position, self.recordPos.transform)

		recthelper.setAnchor(heroItem.viewGO.transform, anchorPos.x, anchorPos.y)
		CommonDragHelper.instance:registerDragObj(heroItem.viewGO, self._onBeginDrag, nil, self._onEndDrag, self._checkCanDrag, self, i)

		if i <= 4 then
			local equipPos = gohelper.findChild(self.recordPos, "equipPos" .. i)

			self._equipRoots[i] = equipPos

			local _anchorPos = recthelper.rectToRelativeAnchorPos(equipPos.transform.position, self.recordPos.transform)
			local equipItem = self:_getEquipItem(i)

			recthelper.setAnchor(equipItem.go.transform, _anchorPos.x, _anchorPos.y)
			gohelper.setActive(equipItem.go.gameObject, true)
			CommonDragHelper.instance:registerDragObj(equipItem.go, self._onBeginEquipDrag, nil, self._onEndEquipDrag, self._checkEquipCanDrag, self, i)
		end
	end
end

function V3a9_BossRush_HeroGroupListView:_getHeroItem(index)
	local item = self._heroItems[index]

	if not item then
		local path = self.viewContainer:getSetting().otherRes[1]
		local goHero = self:getResInst(path, self.heroContainer)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(goHero, V3a9_BossRush_HeroGroupItem)

		item:setParam(index < 5)

		item.index = index
		self._heroItems[index] = item
	end

	return item
end

function V3a9_BossRush_HeroGroupListView:_getFontHeroItem(index)
	local item = self._fontHeroItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.findChild(self.heroContainer, "bg" .. index)
		item.txtindex = gohelper.findChildText(item.go, "Index")
		item.txtName = gohelper.findChildText(item.go, "Name")
		item.goranks = self:getUserDataTb_()

		for i = 1, 3 do
			local rank = gohelper.findChild(item.go, "Name/layout/rankobj/rank" .. i)

			table.insert(item.goranks, rank)
		end

		item.txtLv = gohelper.findChildText(item.go, "Name/layout/lv/lvnum")
		self._fontHeroItems[index] = item
	end

	return item
end

function V3a9_BossRush_HeroGroupListView:_getEquipItem(index)
	local item = self._equipItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self.equipItem, "equip_" .. index)
		item.goequip = gohelper.findChild(item.go, "equip")
		item.goEmpty = gohelper.findChild(item.go, "go_Empty")
		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "btn_Click")

		item.btnClick:AddClickListener(self._btnClickEquip, self, index)

		item.moveContainer = gohelper.findChild(item.goequip, "moveContainer")
		item.equipIcon = gohelper.findChildImage(item.goequip, "moveContainer/equipIcon")
		item.equipRare = gohelper.findChildImage(item.goequip, "moveContainer/equiprare")
		item.equiptxten = gohelper.findChildText(item.goequip, "equiptxten")
		item.equiptxtlv = gohelper.findChildText(item.goequip, "moveContainer/equiplv/txtequiplv")
		item.equipGolv = gohelper.findChild(item.goequip, "moveContainer/equiplv")
		self._equipItems[index] = item
	end

	return item
end

function V3a9_BossRush_HeroGroupListView:_calcIndex(position)
	for i, item in ipairs(self._heroRoots) do
		local posTr = item.transform

		if gohelper.isMouseOverGo(posTr, position) then
			return i
		end
	end

	for i, item in ipairs(self._fontHeroItems) do
		local posTr = item.go.transform

		if gohelper.isMouseOverGo(posTr, position) then
			return i
		end
	end
end

function V3a9_BossRush_HeroGroupListView:_checkCanDrag(index)
	if self._stageMo:isChallenge() then
		GameFacade.showToast(ToastEnum.BossRushHeroGroupCantEdit)

		return true
	end

	local heroItem = self._heroItems[index]
	local heroId = heroItem and heroItem:getHeroId()

	if not heroId then
		return true
	end

	return false
end

function V3a9_BossRush_HeroGroupListView:_onBeginDrag(index, pointerEventData)
	if self._stageMo:isChallenge() then
		return
	end

	local heroItem = self._heroItems[index]

	if not heroItem then
		return
	end

	gohelper.setAsLastSibling(heroItem.viewGO)
end

function V3a9_BossRush_HeroGroupListView:_onEndDrag(index, pointerEventData)
	if self._stageMo:isChallenge() then
		return
	end

	local heroItem = self._heroItems[index]

	if not heroItem then
		return
	end

	local toIndex = self:_calcIndex(pointerEventData.position)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not toIndex or toIndex == index then
		self:_setHeroItemPos(heroItem, index, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	local heroId = heroItem:getHeroId()
	local otherHeroItem = self._heroItems[toIndex]
	local otherHeroId = otherHeroItem:getHeroId()

	if V3a9_BossRushModel.instance:isRestrict(heroId, toIndex) or V3a9_BossRushModel.instance:isRestrict(otherHeroId, index) then
		GameFacade.showToast(ToastEnum.BossRushHeroRestrict1)
		self:_setHeroItemPos(heroItem, index, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	gohelper.setAsLastSibling(otherHeroItem.viewGO)

	self._tweenId = self:_setHeroItemPos(otherHeroItem, index, true)

	self._setHeroItemPos(self, heroItem, toIndex, true, function()
		CommonDragHelper.instance:setGlobalEnabled(true)
		V3a9_BossRushModel.instance:exchangeHero(self._stage, index, toIndex)
	end, self)
end

function V3a9_BossRush_HeroGroupListView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self._heroRoots[index].transform
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.heroContainer.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(heroItem.viewGO.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(heroItem.viewGO.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function V3a9_BossRush_HeroGroupListView:_checkEquipCanDrag(index)
	if self._stageMo:isChallenge() then
		GameFacade.showToast(ToastEnum.BossRushHeroGroupCantEdit)

		return true
	end

	local equipItem = self._equipItems[index]
	local equipMo = equipItem and equipItem.equipMo

	if not equipMo then
		return true
	end

	return false
end

function V3a9_BossRush_HeroGroupListView:_onBeginEquipDrag(index, pointerEventData)
	if self._stageMo:isChallenge() then
		return
	end

	local equipItem = self._equipItems[index]

	if not equipItem then
		return
	end

	gohelper.setAsLastSibling(equipItem.go)
end

function V3a9_BossRush_HeroGroupListView:_onEndEquipDrag(index, pointerEventData)
	if self._stageMo:isChallenge() then
		return
	end

	local equipItem = self._equipItems[index]

	if not equipItem then
		return
	end

	local toIndex = self:_calcIndex(pointerEventData.position)

	CommonDragHelper.instance:setGlobalEnabled(false)

	if not toIndex or toIndex == index or toIndex > 4 then
		self:_setEquipItemPos(equipItem, index, true, function()
			CommonDragHelper.instance:setGlobalEnabled(true)
		end)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)

	local otherEquipItem = self._equipItems[toIndex]

	gohelper.setAsLastSibling(otherEquipItem.go)

	self._tweenId = self:_setEquipItemPos(otherEquipItem, index, true)

	self._setEquipItemPos(self, equipItem, toIndex, true, function()
		CommonDragHelper.instance:setGlobalEnabled(true)
		V3a9_BossRushModel.instance:exchangeEquips(self._stage, index, toIndex)
	end, self)
end

function V3a9_BossRush_HeroGroupListView:_setEquipItemPos(equipItem, index, tween, callback, callbackObj)
	local posTr = self._equipRoots[index].transform
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.heroContainer.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(equipItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(equipItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function V3a9_BossRush_HeroGroupListView:_btnClickEquip(index)
	if self._stageMo:isChallenge() then
		GameFacade.showToast(ToastEnum.BossRushHeroGroupCantEdit)

		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		local heroMo, isAssist = V3a9_BossRushModel.instance:getTeamHeroMo(index, self._stage)

		if isAssist then
			heroMo = heroMo and heroMo.heroMO
		end

		local equipItem = self._equipItems[index]
		local equipMo = equipItem.equipMo
		local param = {
			heroMo = heroMo,
			equipMo = equipMo,
			posIndex = index,
			stage = self._stage,
			fromView = EquipEnum.FromViewEnum.V3a9_BossRush_HeroGroupListView,
			heroGroupMo = self._heroGroupMO
		}

		EquipController.instance:openEquipInfoTeamView(param)

		return
	end

	GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
end

function V3a9_BossRush_HeroGroupListView:onOpen()
	local stage, actId = V3a9_BossRushModel.instance:getEnterActStage()

	self._stage = stage
	self._actId = actId
	self._stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)
	self._actModeTeam = V3a9_BossRushModel.instance:getActModeTeam()

	self:_initHeroITem()
	self:refresh()
end

function V3a9_BossRush_HeroGroupListView:_getHeroUId(index)
	local heroMo, isAssist = V3a9_BossRushModel.instance:getTeamHeroMo(index, self._stage)

	if heroMo then
		if isAssist then
			return heroMo.heroUid
		else
			return heroMo.uid
		end
	end
end

function V3a9_BossRush_HeroGroupListView:_btnClickHero(index)
	if self._stageMo:isChallenge() then
		GameFacade.showToast(ToastEnum.BossRushHeroGroupCantEdit)

		return
	end

	V3a9_BossRushController.instance:closeExpandBondsTipView()

	local heroUid = self:_getHeroUId(index)

	V3a9_BossRushController.instance:openHeroGroupEditView(self._actId, self._stage, index, heroUid)
end

function V3a9_BossRush_HeroGroupListView:_initHeroITem()
	for i = 1, V3a9BossRushEnum.HeroCount do
		local heroItem = self:_getHeroItem(i)

		heroItem:setClickCb(self._btnClickHero, self)
		self:_setHeroItemPos(heroItem, i)
	end
end

function V3a9_BossRush_HeroGroupListView:_refreshHeroItem(index)
	local heroMo = V3a9_BossRushModel.instance:getTeamHeroMo(index, self._stage)
	local heroId = heroMo and heroMo.heroId
	local heroItem = self:_getHeroItem(index)

	heroItem:onUpdateMO(index)
	self:_setHeroItemPos(heroItem, index)

	local isHasHero = heroMo ~= nil

	if index <= 4 then
		local fontHeroItem = self:_getFontHeroItem(index)

		if isHasHero then
			local level = heroMo.level
			local co = HeroConfig.instance:getHeroCO(heroId)

			fontHeroItem.txtName.text = co.name

			local _level, rank = HeroConfig.instance:getShowLevel(level)

			for j = 1, 3 do
				gohelper.setActive(fontHeroItem.goranks[j].gameObject, j == rank - 1)
			end

			fontHeroItem.txtLv.text = _level
		else
			fontHeroItem.txtindex.text = index
		end

		gohelper.setActive(fontHeroItem.txtindex.gameObject, not isHasHero)
		gohelper.setActive(fontHeroItem.txtName.gameObject, isHasHero)
	end
end

function V3a9_BossRush_HeroGroupListView:_refreshHeros()
	for i = 1, V3a9BossRushEnum.HeroCount do
		self:_refreshHeroItem(i)
	end
end

function V3a9_BossRush_HeroGroupListView:_refreshEquipItem(index)
	local equipItem = self:_getEquipItem(index)
	local equipUId = self._equipList[index]

	if equipUId then
		::label_31_0::

		local equipMo = EquipModel.instance:getEquip(equipUId)

		equipItem.equipMo = equipMo

		if equipMo then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(equipItem.equipIcon, equipMo.config.icon)

			equipItem.equiptxtlv.text = "LV." .. equipMo.level

			local rareIcon = "bianduixingxian_" .. equipMo.config.rare

			UISpriteSetMgr.instance:setHeroGroupSprite(equipItem.equipRare, rareIcon)
		end

		gohelper.setActive(equipItem.goequip.gameObject, equipMo ~= nil)
		gohelper.setActive(equipItem.goEmpty.gameObject, equipMo == nil)
		self:_setEquipItemPos(equipItem, index)
	end
end

function V3a9_BossRush_HeroGroupListView:_refreshEquips()
	self._equipList = V3a9_BossRushModel.instance:getEquipUIds(self._stage)

	for i = 1, 4 do
		self:_refreshEquipItem(i)
	end
end

function V3a9_BossRush_HeroGroupListView:refresh()
	self._heroGroupMO = V3a9_BossRushModel.instance:getCurGroupMO()

	self:_refreshHeros()
	self:_refreshEquips()
end

function V3a9_BossRush_HeroGroupListView:onClose()
	for _, item in ipairs(self._equipItems) do
		item.btnClick:RemoveClickListener()
		CommonDragHelper.instance:unregisterDragObj(item.go)
	end

	for _, item in ipairs(self._heroItems) do
		CommonDragHelper.instance:unregisterDragObj(item.viewGO)
	end
end

function V3a9_BossRush_HeroGroupListView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	CommonDragHelper.instance:setGlobalEnabled(true)
end

return V3a9_BossRush_HeroGroupListView

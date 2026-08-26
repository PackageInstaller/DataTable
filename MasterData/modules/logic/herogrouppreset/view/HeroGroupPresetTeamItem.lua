-- chunkname: @modules/logic/herogrouppreset/view/HeroGroupPresetTeamItem.lua

module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamItem", package.seeall)

local HeroGroupPresetTeamItem = class("HeroGroupPresetTeamItem", ListScrollCellExtend)

function HeroGroupPresetTeamItem:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._btninfoclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_infoclick")
	self._goherogrouplist = gohelper.findChild(self.viewGO, "#go_info/#go_herogrouplist")
	self._gobossitem = gohelper.findChild(self.viewGO, "#go_info/#go_bossitem")
	self._btnclickboss = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#go_bossitem/#btn_clickboss")
	self._gobossempty = gohelper.findChild(self.viewGO, "#go_info/#go_bossitem/#go_bossempty")
	self._gobosscontainer = gohelper.findChild(self.viewGO, "#go_info/#go_bossitem/#go_bosscontainer")
	self._simagebossicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/#go_bossitem/#go_bosscontainer/#simage_bossicon")
	self._imagebosscareer = gohelper.findChildImage(self.viewGO, "#go_info/#go_bossitem/#go_bosscontainer/#image_bosscareer")
	self._simagecloth = gohelper.findChildSingleImage(self.viewGO, "#go_info/#simage_cloth")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_use")
	self._gousing = gohelper.findChild(self.viewGO, "#go_info/#go_using")
	self._btnreplace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/#btn_replace")
	self._goreplaced = gohelper.findChild(self.viewGO, "#go_info/#go_replaced")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_info/#txt_num")
	self._btndelete = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/top/#btn_delete")
	self._btntop = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/top/#btn_top")
	self._btnrename = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/top/#btn_rename")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/top/#btn_rename/#txt_name")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_add")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupPresetTeamItem:addEvents()
	self._btninfoclick:AddClickListener(self._btninfoclickOnClick, self)
	self._btnclickboss:AddClickListener(self._btnclickbossOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
	self._btnreplace:AddClickListener(self._btnreplaceOnClick, self)
	self._btndelete:AddClickListener(self._btndeleteOnClick, self)
	self._btntop:AddClickListener(self._btntopOnClick, self)
	self._btnrename:AddClickListener(self._btnrenameOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
end

function HeroGroupPresetTeamItem:removeEvents()
	self._btninfoclick:RemoveClickListener()
	self._btnclickboss:RemoveClickListener()
	self._btnuse:RemoveClickListener()
	self._btnreplace:RemoveClickListener()
	self._btndelete:RemoveClickListener()
	self._btntop:RemoveClickListener()
	self._btnrename:RemoveClickListener()
	self._btnadd:RemoveClickListener()
end

function HeroGroupPresetTeamItem:_btnclickbossOnClick()
	if HeroGroupPresetController.instance:isFightScene() then
		GameFacade.showToast(ToastEnum.HeroGroupPresetCannotEditTip)

		return
	end

	TowerController.instance:openAssistBossView(self._mo.assistBossId, true, TowerEnum.TowerType.Normal, TowerEnum.PermanentTowerId, {
		towerAssistBossItemCls = HeroGroupPresetTowerAssistBossItem,
		heroGroupMO = self._mo,
		saveGroup = function()
			HeroGroupPresetModel.instance:externalSaveCurGroupData(nil, nil, self._mo, self._groupId, self._mo.id)
			self:_showBossInfo()
		end
	})
end

function HeroGroupPresetTeamItem:_btnaddOnClick()
	local subId = HeroGroupPresetHeroGroupChangeController.instance:getEmptyHeroGroupId(self._groupId)

	if not subId then
		logError("HeroGroupPresetTeamItem addHeroGroup failed")

		return
	end

	self._newSubId = subId

	self:_addNewHeroGroup(subId)
end

function HeroGroupPresetTeamItem:_addNewHeroGroup(subId)
	local name = HeroGroupPresetHeroGroupNameController.instance:getName(self._groupId, subId)

	HeroGroupPresetController.instance:openHeroGroupPresetModifyNameView({
		name = name,
		groupId = self._groupId,
		subId = subId,
		addCallback = self._addNewHeroGroupNameCallback,
		callbackObj = self
	})
end

function HeroGroupPresetTeamItem:_addNewHeroGroupNameCallback(name)
	self._newHeroGroupName = name
	self._newHeroGroupMo = HeroGroupMO.New()

	self._addHeroGroupMo(self, self._addCallback, self, self._newHeroGroupMo, self._groupId, self._newSubId)
end

function HeroGroupPresetTeamItem:_addHeroGroupMo(callback, callbackObj, heroGroupMO, groupId, subId)
	heroGroupMO.groupId = subId
	heroGroupMO.id = subId

	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
	local mainList = heroGroupMO:getMainList()
	local subList = heroGroupMO:getSubList()

	FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, mainList, subList)

	local snapshotId = groupId
	local snapshotSubId = subId

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req, callback, callbackObj)
end

function HeroGroupPresetTeamItem:_replaceHeroGroupMo(heroList, callback, callbackObj)
	self._mo:replaceHeroList(heroList)

	local heroGroupMO = self._mo
	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroGroupMO:getMainList(), heroGroupMO:getSubList(), heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId())

	local snapshotId = self._groupId
	local snapshotSubId = self._mo.id

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(snapshotId, snapshotSubId, req, callback, callbackObj)
end

function HeroGroupPresetTeamItem:_addCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroGroupPresetHeroGroupChangeController.instance:addHeroGroup(self._groupId, self._newHeroGroupMo.id, self._newHeroGroupMo)
	HeroGroupPresetController.instance:addHeroGroupCopy(self._groupId, self._newHeroGroupMo.id, self._newHeroGroupMo)
	HeroGroupPresetItemListModel.instance:updateList()
	HeroGroupRpc.instance:sendUpdateHeroGroupNameRequest(self._groupId, self._newSubId, self._newHeroGroupName, HeroGroupPresetModifyNameView.UpdateHeroGroupNameRequest)

	if HeroGroupPresetController.instance:isFightScene() then
		self:_useHeroGroup(self._groupId, self._newHeroGroupMo.id)

		return
	end

	HeroGroupPresetItemListModel.instance:setNewHeroGroupInfo(self._groupId, self._newHeroGroupMo.id)
	self:_openHeroGroupPresetEditView(self._newHeroGroupMo, self._newHeroGroupMo.id, self._newHeroGroupName, true)
end

function HeroGroupPresetTeamItem:_btninfoclickOnClick()
	return
end

function HeroGroupPresetTeamItem:_openHeroGroupPresetEditView(herogroupMo, subId, heroGroupName, onlyQuickEdit, moIndex)
	HeroGroupPresetSingleGroupModel.instance:setMaxHeroCount(HeroGroupPresetItemListModel.instance:getHeroNum())
	HeroGroupPresetModel.instance:setHeroGroupSnapshotType(self._groupId)
	HeroGroupPresetModel.instance:setHeroGroupMo(herogroupMo)
	HeroGroupPresetModel.instance:setCurGroupId(subId)
	HeroGroupPresetItemListModel.instance:setHeroGroupSnapshotSubId(subId)

	moIndex = moIndex or 1

	local equips = herogroupMo:getPosEquips(moIndex - 1).equipUid
	local param = {}

	param.singleGroupMOId = moIndex
	param.originalHeroUid = HeroGroupPresetSingleGroupModel.instance:getHeroUid(moIndex)
	param.equips = equips
	param.onlyQuickEdit = onlyQuickEdit
	param.heroGroupName = heroGroupName

	HeroGroupPresetController.instance:openHeroGroupPresetEditView(param)
end

function HeroGroupPresetTeamItem:_btnreplaceOnClick()
	if not self._view.viewParam then
		return
	end

	local heroList = self._view.viewParam.replaceTeamList

	if not heroList then
		return
	end

	local teamSubId = HeroGroupPresetItemListModel.instance:getReplaceTeamSubId(heroList)

	if not teamSubId or teamSubId > 0 then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.CharacterRecommedGroupReplaceTip, MsgBoxEnum.BoxType.Yes_No, function()
		self._replaceHeroGroupMo(self, heroList, self._replaceTeamCallback, self)
	end, nil, nil, self)
end

function HeroGroupPresetTeamItem:_btnrenameOnClick()
	HeroGroupPresetController.instance:openHeroGroupPresetModifyNameView({
		name = self._name,
		groupId = self._groupId,
		subId = self._mo.id
	})
end

function HeroGroupPresetTeamItem:_btnuseOnClick()
	self:_useHeroGroup(self._groupId, self._mo.id)
end

function HeroGroupPresetTeamItem:_useHeroGroup(groupId, subId)
	HeroGroupPresetController.instance:revertCurHeroGroup()
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.UseHeroGroup, {
		groupId = groupId,
		subId = subId
	})
	ViewMgr.instance:closeView(self._view.viewName, nil, true)
end

function HeroGroupPresetTeamItem:_btndeleteOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupDeleteTip, MsgBoxEnum.BoxType.Yes_No, function()
		HeroGroupRpc.instance:sendDeleteHeroGroupRequest(self._groupId, self._mo.id)
	end)
end

function HeroGroupPresetTeamItem:_btntopOnClick()
	local sortList = HeroGroupSnapshotModel.instance:getSortSubIds(self._groupId)

	tabletool.removeValue(sortList, self._mo.id)
	table.insert(sortList, 1, self._mo.id)
	HeroGroupRpc.instance:sendUpdateHeroGroupSortRequest(self._groupId, sortList)
end

function HeroGroupPresetTeamItem:_editableInitView()
	self._goclothbg = gohelper.findChild(self.viewGO, "#go_info/clothbg")
	self._goline = gohelper.findChild(self.viewGO, "#go_info/top/line")

	gohelper.setActive(self._gousing, false)

	self._heroItemList = self:getUserDataTb_()

	gohelper.setActive(self._goheroitem, false)
	gohelper.setActive(self._gobossitem, false)
	gohelper.setActive(self._simagecloth, false)
	gohelper.setActive(self._goclothbg, false)

	self._animator = self.viewGO:GetComponent("Animator")

	function self._getAnimator()
		return self._animator
	end

	self.getAnimator = self._getAnimator
end

function HeroGroupPresetTeamItem:_editableAddEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UpdateGroupName, self._onUpdateGroupName, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.ClickHero, self._onClickHero, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.ClickEquip, self._onClickEquip, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.ChangeEquip, self._onChangeEquip, self)
	self.addEventCb(self, HeroGroupPresetController.instance, HeroGroupPresetEvent.UpdateHeroGroupSort, self._onUpdateHeroGroupSort, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCallBack, self)
end

function HeroGroupPresetTeamItem:_editableRemoveEvents()
	return
end

function HeroGroupPresetTeamItem:_onCloseViewCallBack(viewName)
	if viewName == ViewName.HeroGroupPresetEditView then
		local heroGroupTpye, subId = HeroGroupPresetItemListModel.instance:getNewHeroGroupInfo()

		if self._groupId == heroGroupTpye and self._mo.id == subId then
			HeroGroupPresetItemListModel.instance:setNewHeroGroupInfo()
			self._animator:Play("add", 0, 0)
		end
	end
end

function HeroGroupPresetTeamItem:_onUpdateHeroGroupSort()
	self:_showSetTopAnim()
end

function HeroGroupPresetTeamItem:_onChangeEquip(presetGroupId, presetSubId)
	if self._groupId == presetGroupId and self._mo and self._mo.id == presetSubId then
		self:_refreshHeroItem()
	end
end

function HeroGroupPresetTeamItem:_onClickHero(mo, index)
	if self._mo ~= mo then
		return
	end

	HeroGroupPresetItemListModel.instance:setEditHeroGroupSnapshotSubId(self._mo.id)
	self:_openHeroGroupPresetEditView(self._mo, self._mo.id, self._name, nil, index)
end

function HeroGroupPresetTeamItem:_onClickEquip(mo, param)
	if self._mo ~= mo then
		return
	end

	param.presetGroupId = self._groupId
	param.presetSubId = self._mo.id
	param.heroGroupMo = self._mo

	EquipController.instance:openEquipInfoTeamView(param)
end

function HeroGroupPresetTeamItem:_modifyHeroGroup()
	if not self._mo or self._mo.id ~= HeroGroupPresetItemListModel.instance:getHeroGroupSnapshotSubId() then
		return
	end

	self:_refreshHeroItem()

	if self._mo and self._mo.id == HeroGroupPresetItemListModel.instance:getEditHeroGroupSnapshotSubId() then
		HeroGroupPresetItemListModel.instance:setEditHeroGroupSnapshotSubId()
		self._animator:Play("refresh", 0, 0)
	end
end

function HeroGroupPresetTeamItem:_onUpdateGroupName(subId)
	if self._mo and self._mo.id == subId then
		self:_updateName()
	end
end

function HeroGroupPresetTeamItem:onUpdateMO(mo)
	self._groupId = HeroGroupPresetItemListModel.instance:getHeroGroupSnapshotType()

	local isAdd = mo.__isAdd

	gohelper.setActive(self._goinfo, not isAdd)
	gohelper.setActive(self._btnadd, isAdd)

	if isAdd then
		return
	end

	self._mo = mo
	self._singleGroupModel = self._singleGroupModel or HeroGroupPresetSingleGroupModel.New()

	if self._heroNum ~= HeroGroupPresetItemListModel.instance:getHeroNum() then
		self._singleGroupModel:setMaxHeroCount(HeroGroupPresetItemListModel.instance:getHeroNum())

		self._heroNum = HeroGroupPresetItemListModel.instance:getHeroNum()
	end

	local showDeleteBtn = HeroGroupPresetItemListModel.instance:showDeleteBtn()

	gohelper.setActive(self._btndelete, showDeleteBtn)
	gohelper.setActive(self._goline, showDeleteBtn)
	gohelper.setActive(self._btntop, self._index ~= 1)
	self:_refreshHeroItem()
	self:_updateName()
	self:_showFightInfo()
	self:_showBossInfo()
	self:_showReplace()
end

function HeroGroupPresetTeamItem:_showSetTopAnim()
	self.getAnimator = nil

	self._animator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(self._delayResetAnimator, self)
	TaskDispatcher.runDelay(self._delayResetAnimator, self, 0)
end

function HeroGroupPresetTeamItem:_delayResetAnimator()
	self.getAnimator = self._getAnimator
end

function HeroGroupPresetTeamItem:_showBossInfo()
	local showBoss = HeroGroupPresetEnum.HeroGroupSnapshotTypeShowBoss[self._groupId]

	gohelper.setActive(self._gobossitem, showBoss)

	if not showBoss then
		return
	end

	local assistBossId = self._mo.assistBossId

	if assistBossId then
		::label_36_0::

		local bossConfig = TowerConfig.instance:getAssistBossConfig(assistBossId)
		local showBossInfo = bossConfig ~= nil

		gohelper.setActive(self._gobossempty, not showBossInfo)
		gohelper.setActive(self._gobosscontainer, showBossInfo)

		if showBossInfo then
			UISpriteSetMgr.instance:setCommonSprite(self._imagebosscareer, string.format("lssx_%s", bossConfig.career))

			local skinConfig = FightConfig.instance:getSkinCO(bossConfig.skinId)

			self._simagebossicon:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))
		end
	end
end

function HeroGroupPresetTeamItem:_showFightInfo()
	local isFightShowType = HeroGroupPresetController.instance:isFightShowType()
	local isCopyShowType = HeroGroupPresetController.instance:isCopyShowType()

	if not isFightShowType and not isCopyShowType then
		return
	end

	local isUse = HeroGroupPresetController.instance:getSelectedSubId() == self._mo.id

	gohelper.setActive(self._gousing, isUse)
	gohelper.setActive(self._btnuse, not isUse)

	if isUse then
		gohelper.setActive(self._btndelete, false)
	end
end

function HeroGroupPresetTeamItem:_updateName()
	self._name = HeroGroupPresetHeroGroupNameController.instance:getName(self._groupId, self._mo.id)
	self._txtname.text = self._name
end

function HeroGroupPresetTeamItem:_refreshHeroItem()
	if HeroGroupPresetController.instance:isFightScene() then
		HeroGroupPresetHeroGroupChangeController.instance:handleHeroListData(self._groupId, self._mo)
	end

	self._singleGroupModel:setSingleGroup(self._mo, HeroGroupPresetController.instance:isFightScene())

	local heroList = self._mo.heroList
	local num = HeroGroupPresetItemListModel.instance:getHeroNum()

	for i = 1, num do
		if heroList then
			::label_39_0::

			local heroData = HeroModel.instance:getById(heroList[i])
			local heroItem = self._heroItemList[i]

			if not heroItem then
				local path = self._view.viewContainer:getSetting().otherRes[3]
				local itemGo = self._view:getResInst(path, self._goherogrouplist)

				heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, HeroGroupPresetTeamHeroItem)

				table.insert(self._heroItemList, heroItem)
			end

			local singleGroupMo = self._singleGroupModel:getById(i)

			heroItem:onUpdateMO(singleGroupMo, heroData, self._mo, i)
		end
	end
end

function HeroGroupPresetTeamItem:_showReplace()
	if self._view.viewParam then
		local teamList = self._view.viewParam.replaceTeamList
		local teamSubId = HeroGroupPresetItemListModel.instance:getReplaceTeamSubId(teamList)

		if not teamList or not teamSubId then
			gohelper.setActive(self._btnreplace.gameObject, false)
			gohelper.setActive(self._goreplaced.gameObject, false)

			return
		end

		ZProj.UGUIHelper.SetGrayscale(self._btnreplace.gameObject, teamSubId > 0)
		gohelper.setActive(self._btnreplace.gameObject, teamSubId ~= self._mo.id)
		gohelper.setActive(self._goreplaced.gameObject, teamSubId == self._mo.id)
	end
end

function HeroGroupPresetTeamItem:_replaceTeamCallback()
	if HeroGroupPresetController.instance:isFightScene() then
		HeroGroupPresetController.instance:updateFightHeroGroup()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end

	HeroGroupPresetController.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:closeView(ViewName.HeroGroupEditView)
	HeroGroupPresetItemListModel.instance:onModelUpdate()
	GameFacade.showToast(ToastEnum.CharacterRecommedGroupReplaceSuccess)
end

function HeroGroupPresetTeamItem:onSelect(isSelect)
	return
end

function HeroGroupPresetTeamItem:onDestroyView()
	TaskDispatcher.cancelTask(self._delayResetAnimator, self)

	self._getAnimator = nil
	self.getAnimator = nil
end

return HeroGroupPresetTeamItem

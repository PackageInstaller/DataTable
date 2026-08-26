-- chunkname: @modules/logic/equip/view/EquipTeamView.lua

module("modules.logic.equip.view.EquipTeamView", package.seeall)

local EquipTeamView = class("EquipTeamView", BaseView)

function EquipTeamView:onInitView()
	self._simagebgmask = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgmask")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._goequipcontainer = gohelper.findChild(self.viewGO, "#go_equipcontainer")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#go_equipcontainer/#scroll_equip")
	self._goequipsort = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort")
	self._btnequiplv = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv")
	self._btnequiprare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare")
	self._simagenoequiptip = gohelper.findChildSingleImage(self.viewGO, "#simage_noequiptip")
	self._goroletags = gohelper.findChild(self.viewGO, "tags/#go_roletags")
	self._goposlist = gohelper.findChild(self.viewGO, "tags/#go_poslist")
	self._gostorytag = gohelper.findChild(self.viewGO, "tags/#go_roletags/#go_storytag")
	self._goaidtag = gohelper.findChild(self.viewGO, "tags/#go_roletags/#go_aidtag")
	self._goskillpos = gohelper.findChild(self.viewGO, "#go_skillpos")
	self._goTouchArea = gohelper.findChild(self.viewGO, "#go_touchArea")
	self._simageblurmask = gohelper.findChildSingleImage(self.viewGO, "#simage_blurmask")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipTeamView:addEvents()
	self._btnequiplv:AddClickListener(self._btnequiplvOnClick, self)
	self._btnequiprare:AddClickListener(self._btnequiprareOnClick, self)
	self._slide:AddDragBeginListener(self._onDragBegin, self)
	self._slide:AddDragEndListener(self._onDragEnd, self)
end

function EquipTeamView:removeEvents()
	self._btnequiplv:RemoveClickListener()
	self._btnequiprare:RemoveClickListener()
	self._slide:RemoveDragBeginListener()
	self._slide:RemoveDragEndListener()
end

EquipTeamView.DragAbsPositionX = 30

function EquipTeamView:_btnshowskillOnClick()
	return
end

function EquipTeamView:_btnequiplvOnClick()
	EquipTeamListModel.instance:sortByLevel()
	self:_refreshEquipBtnIcon()
end

function EquipTeamView:_btnequiprareOnClick()
	EquipTeamListModel.instance:sortByQuality()
	self:_refreshEquipBtnIcon()
end

function EquipTeamView:_refreshEquipBtnIcon()
	local tag = EquipTeamListModel.instance:getBtnTag()

	gohelper.setActive(self._equipLvBtns[1], tag ~= 1)
	gohelper.setActive(self._equipLvBtns[2], tag == 1)
	gohelper.setActive(self._equipQualityBtns[1], tag ~= 2)
	gohelper.setActive(self._equipQualityBtns[2], tag == 2)

	local levelState, qualityState, timeState = EquipTeamListModel.instance:getRankState()

	transformhelper.setLocalScale(self._equipLvArrow[1], 1, levelState, 1)
	transformhelper.setLocalScale(self._equipLvArrow[2], 1, levelState, 1)
	transformhelper.setLocalScale(self._equipQualityArrow[1], 1, qualityState, 1)
	transformhelper.setLocalScale(self._equipQualityArrow[2], 1, qualityState, 1)
end

function EquipTeamView:_onHyperLinkClick()
	local targetInScreenPos = recthelper.uiPosToScreenPos(self._goskillpos.transform, ViewMgr.instance:getUICanvas())

	EquipController.instance:openEquipSkillTipView({
		self._equipMO,
		nil,
		true,
		targetInScreenPos
	})
end

function EquipTeamView:_onDragBegin(param, pointerEventData)
	self.startDragPosX = pointerEventData.position.x
end

function EquipTeamView:_onDragEnd(param, pointerEventData)
	local endDragPosX = pointerEventData.position.x

	if math.abs(endDragPosX - self.startDragPosX) > EquipTeamView.DragAbsPositionX then
		if endDragPosX < self.startDragPosX then
			self:_onSlideNext()
		else
			self:_onSlideLast()
		end
	end

	local maskIndex = Mathf.Clamp(self._currentSlideIndex - 1, 0, 3)

	maskIndex = maskIndex == 3 and 0 or maskIndex

	self._simagebgmask:LoadImage(ResUrl.getEquipBg("bg_heromask_" .. maskIndex .. ".png"))
	self._simageblurmask:LoadImage(ResUrl.getUIMaskTexture("bg_zhezhao_" .. maskIndex))

	local heroUidList = HeroGroupModel.instance:getCurGroupMO().heroList
	local heroUid = heroUidList[self._currentSlideIndex]

	self.viewParam.heroMO = HeroModel.instance:getById(heroUid)

	EquipTeamListModel.instance:openTeamEquip(self._currentSlideIndex - 1, self.viewParam.heroMO)
	self:_changeEquip()
	self:_setRoleTag()
end

function EquipTeamView:_setRoleTag()
	local pos = EquipTeamListModel.instance:getCurPosIndex()
	local hero_group_mo = HeroSingleGroupModel.instance:getById(pos + 1)
	local battleId = HeroGroupModel.instance.battleId
	local battleCO = battleId and lua_battle.configDict[battleId]
	local isLock = not HeroGroupModel.instance:isPositionOpen(hero_group_mo.id)

	if hero_group_mo.aid then
		local isAidLock = hero_group_mo.aid == -1
		local roleNum = HeroGroupModel.instance:getBattleRoleNum()
		local isRoleNumLock = roleNum and roleNum < hero_group_mo.id

		gohelper.setActive(self._gostorytag, hero_group_mo.aid and hero_group_mo.aid ~= -1)

		if battleCO then
			gohelper.setActive(self._goaidtag, not isLock and not isAidLock and not isRoleNumLock and hero_group_mo.id > battleCO.playerMax)
		else
			gohelper.setActive(self._goaidtag, not isLock and not isAidLock and not isRoleNumLock and hero_group_mo.id == ModuleEnum.MaxHeroCountInGroup)
		end

		if not self._goaidtag.activeSelf and not self._gostorytag.activeSelf then
			self._isShowHeroTag = false

			return
		end

		gohelper.setActive(self._goroletags, true)

		self._isShowHeroTag = true

		local posX, posY = recthelper.getAnchor(gohelper.findChild(self._goposlist, "pos" .. pos).transform)

		recthelper.setAnchor(self._goroletags.transform, posX, posY)
	end
end

function EquipTeamView:_onSlideNext()
	self._currentSlideIndex = self._currentSlideIndex + 1

	if self._currentSlideIndex <= self._maxSlideIndex then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEquipItem, self._herogroupContainOffset_x[self._currentSlideIndex])
	else
		self._currentSlideIndex = self._maxSlideIndex
	end
end

function EquipTeamView:_onSlideLast()
	self._currentSlideIndex = self._currentSlideIndex - 1

	if self._currentSlideIndex > 0 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEquipItem, self._herogroupContainOffset_x[self._currentSlideIndex])
	else
		self._currentSlideIndex = 1
	end
end

function EquipTeamView:_editableInitView()
	self._strengthenattrs = self:getUserDataTb_()

	self._simagenoequiptip:LoadImage(ResUrl.getEquipBg("bg_xinxiang_wuzhuangtai.png"))

	self._equipLvBtns = self:getUserDataTb_()
	self._equipLvArrow = self:getUserDataTb_()
	self._equipQualityBtns = self:getUserDataTb_()
	self._equipQualityArrow = self:getUserDataTb_()

	for i = 1, 2 do
		self._equipLvBtns[i] = gohelper.findChild(self._btnequiplv.gameObject, "btn" .. tostring(i))
		self._equipLvArrow[i] = gohelper.findChild(self._equipLvBtns[i], "arrow").transform
		self._equipQualityBtns[i] = gohelper.findChild(self._btnequiprare.gameObject, "btn" .. tostring(i))
		self._equipQualityArrow[i] = gohelper.findChild(self._equipQualityBtns[i], "arrow").transform
	end

	gohelper.addUIClickAudio(self._btnequiplv.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnequiprare.gameObject, AudioEnum.UI.UI_Common_Click)

	self._slide = SLFramework.UGUI.UIDragListener.Get(self._goTouchArea)
	self._herogroupContainOffset_x = self:getUserDataTb_()
	self._maxSlideIndex = 4

	self._simagemask:LoadImage(ResUrl.getEquipBg("full/mask.png"))
end

function EquipTeamView:onUpdateParam()
	return
end

function EquipTeamView:onOpen()
	local heroMO = EquipTeamListModel.instance:getHero()
	local posIndex = EquipTeamListModel.instance:getCurPosIndex()

	self._heroId = heroMO and heroMO.heroId
	posIndex = posIndex == 3 and 0 or posIndex

	self._simagebgmask:LoadImage(ResUrl.getEquipBg("bg_heromask_" .. posIndex .. ".png"))
	self._simageblurmask:LoadImage(ResUrl.getUIMaskTexture("bg_zhezhao_" .. posIndex))
	self:showEquipList()
	self:_refreshEquipBtnIcon()
	self:_setRoleTag()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.ChangeEquip, self._changeEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self._onEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self._onEquipChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._hideNoEquipTip, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnCompareEquip, self._setMaskVisible, self)

	self._currentSlideIndex = self.viewParam.posIndex + 1

	self:_initHeorGroupItemPos()
end

function EquipTeamView:onOpenFinish()
	self._viewAnim.enabled = true

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.setHeroGroupEquipEffect, true)
end

function EquipTeamView:_onEquipChange()
	TaskDispatcher.cancelTask(self._changeEquip, self)
	TaskDispatcher.runDelay(self._changeEquip, self, 0.1)
end

function EquipTeamView:_changeEquip()
	self:showEquipList()
end

function EquipTeamView:_initHeorGroupItemPos()
	local heroGroupItemList = HeroGroupModel.instance:getHeroGroupItemPos()

	for k, v in ipairs(heroGroupItemList) do
		local offsetx = recthelper.getAnchorX(v) + recthelper.getAnchorX(v.parent)

		table.insert(self._herogroupContainOffset_x, offsetx)
	end
end

function EquipTeamView:_showNoEquipTip(viewName)
	if viewName == ViewName.EquipTeamShowView then
		gohelper.setActive(self._simagenoequiptip.gameObject, false)
	end
end

function EquipTeamView:_hideNoEquipTip(viewName)
	if viewName == ViewName.EquipTeamShowView then
		gohelper.setActive(self._simagenoequiptip.gameObject, self._isNullEquipShow)
	end
end

function EquipTeamView:showEquipList()
	EquipTeamListModel.instance:setEquipList(true)
	EquipTeamAttrListModel.instance:SetAttrList()

	self._isNullEquipShow = true

	local count = EquipTeamAttrListModel.instance:getCount()

	if count > 0 then
		local equipList = EquipTeamListModel.instance:getTeamEquip()

		for _, uid in ipairs(equipList) do
			self._equipMO = EquipModel.instance:getEquip(uid)
			self._config = self._equipMO.config

			local viewList = ViewMgr.instance:getOpenViewNameList()

			if viewList[#viewList] == ViewName.EquipTeamShowView or not ViewMgr.instance:isOpen(ViewName.EquipTeamShowView) then
				EquipController.instance:openEquipTeamShowView({
					self._equipMO.uid,
					true
				})
			end

			self._isNullEquipShow = false

			break
		end
	end

	local equipList = EquipTeamListModel.instance:getEquipList()

	if equipList then
		if not #equipList then
			local totalEquipCount = 0

			if self._isNullEquipShow and totalEquipCount > 0 then
				for _, equipMO in ipairs(equipList) do
					self._equipMO = equipMO
					self._config = self._equipMO.config

					local viewList = ViewMgr.instance:getOpenViewNameList()

					if viewList[#viewList] == ViewName.EquipTeamShowView or not ViewMgr.instance:isOpen(ViewName.EquipTeamShowView) then
						EquipController.instance:openEquipTeamShowView({
							self._equipMO.uid,
							false
						})
					end

					self._isNullEquipShow = false

					break
				end
			end

			gohelper.setActive(self._simagenoequiptip.gameObject, self._isNullEquipShow)
		end
	end
end

function EquipTeamView:_setMaskVisible(isCompare)
	gohelper.setActive(self._simagemask.gameObject, isCompare)
	gohelper.setActive(self._simageblurmask.gameObject, not isCompare)
	gohelper.setActive(self._goroletags, self._isShowHeroTag and not isCompare)
end

function EquipTeamView:onClose()
	TaskDispatcher.cancelTask(self._changeEquip, self)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.setHeroGroupEquipEffect, false)
	gohelper.setActive(self._goroletags, false)
	EquipTeamListModel.instance:clearEquipList()
end

function EquipTeamView:onDestroyView()
	self._simagebgmask:UnLoadImage()
	self._simageblurmask:UnLoadImage()
	self._simagenoequiptip:UnLoadImage()
	self._simagemask:UnLoadImage()
end

return EquipTeamView

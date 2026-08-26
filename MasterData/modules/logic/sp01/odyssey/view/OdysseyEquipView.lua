-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyEquipView.lua

module("modules.logic.sp01.odyssey.view.OdysseyEquipView", package.seeall)

local OdysseyEquipView = class("OdysseyEquipView", BaseView)

function OdysseyEquipView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/BG/#simage_fullbg")
	self._scrollLeftTab = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_LeftTab")
	self._goTabItem = gohelper.findChild(self.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem/#image_icon")
	self._goselect = gohelper.findChild(self.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#scroll_LeftTab/Viewport/Content/#go_TabItem/#btn_click")
	self._gocontainer = gohelper.findChild(self.viewGO, "root/#go_container")
	self._scrollEquip = gohelper.findChildScrollRect(self.viewGO, "root/#go_container/#scroll_Equip")
	self._goempty = gohelper.findChild(self.viewGO, "root/#go_container/#go_empty")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "root/hero/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "root/hero/#btn_right")
	self._scrollSuit = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_Suit")
	self._goOdysseyEquipParent = gohelper.findChild(self.viewGO, "root/hero/go_Equip")
	self._simageHero = gohelper.findChildSingleImage(self.viewGO, "root/hero/Hero/#simage_hero")
	self._goTipsItem = gohelper.findChild(self.viewGO, "root/hero/#go_tipsitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyEquipView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, self.onItemSelect, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, self.OnEquipSuitSelect, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipPosSelect, self.onEquipPosSelect, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OnTipSubViewClose, self.onTipSubViewClose, self)
	self.addEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self.onHeroGroupUpdate, self)
end

function OdysseyEquipView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipItemSelect, self.onItemSelect, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipSuitSelect, self.OnEquipSuitSelect, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnEquipPosSelect, self.onEquipPosSelect, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OnTipSubViewClose, self.onTipSubViewClose, self)
	self.removeEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self.onHeroGroupUpdate, self)
end

function OdysseyEquipView:_btnclickOnClick()
	return
end

function OdysseyEquipView:_btnleftOnClick()
	local heroIndex = self._heroPosIndex - 1

	if heroIndex <= 0 then
		return
	end

	self._heroPosIndex = heroIndex

	self._animHero:Play("left", 0, 0)
end

function OdysseyEquipView:_btnrightOnClick()
	local heroIndex = self._heroPosIndex + 1

	if heroIndex > self._heroPosMax then
		return
	end

	self._heroPosIndex = heroIndex

	self._animHero:Play("right", 0, 0)
end

function OdysseyEquipView:_editableInitView()
	OdysseyEquipSuitTabListModel.instance:initList()

	self._equipFilterType = nil
	self._odysseyItemList = {}

	local parent = self._goOdysseyEquipParent.transform
	local mainCountConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount)
	local childCount = tonumber(mainCountConstCo.value)

	for i = 1, childCount do
		local child = self:getResInst(self.viewContainer:getSetting().otherRes[2], parent.gameObject)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(child.gameObject, OdysseyHeroGroupEquipItem)

		table.insert(self._odysseyItemList, item)
	end

	self.equipTipItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goTipsItem, OdysseyEquipTipItem)

	self.equipTipItem:setActive(false)

	self._gohero = gohelper.findChild(self.viewGO, "root/hero")
	self._goEmptyHero = gohelper.findChild(self.viewGO, "root/hero/Hero/empty")
	self._animHero = self._gohero:GetComponent(gohelper.Type_Animator)
	self._animEventWrap = self._gohero:GetComponent(gohelper.Type_AnimationEventWrap)

	self._animEventWrap:AddEventListener("switch", self.onSelectHeroAnimEvent, self)

	self._animScroll = gohelper.findChildComponent(self.viewGO, "root/#go_container", gohelper.Type_Animator)
end

function OdysseyEquipView:onUpdateParam()
	return
end

function OdysseyEquipView:onOpen()
	local param = self.viewParam
	local index = param.index
	local heroPos = param.heroPos

	self:refreshList(false, true)
	self:initSwitchList(heroPos, index)
end

function OdysseyEquipView:onSelectHeroAnimEvent()
	self:onSelectHero(self._heroPosIndex)
end

function OdysseyEquipView:onSelectHero(heroPosIndex, equipIndex, selectCurrent)
	self._heroPosIndex = heroPosIndex
	equipIndex = equipIndex or OdysseyEnum.EquipDefaultIndex
	self._equipIndex = equipIndex
	self._heroPos = self._heroPosList[heroPosIndex]

	self:refreshHero()
	self:refreshItem()
	self:selectEquipPos(equipIndex, selectCurrent)
	self:refreshSwitchState()
end

function OdysseyEquipView:refreshHero()
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
	local heroPos = self._heroPos
	local heroId = heroGroupMo.heroIdPosDic[self._heroPos]
	local haveHero = false

	if heroId ~= nil and heroId ~= 0 then
		local skinCo

		if heroId < 0 then
			local trialCo = lua_hero_trial.configDict[-heroId][0]

			skinCo = SkinConfig.instance:getSkinCo(trialCo.skin)
		else
			local heroMo = HeroModel.instance:getByHeroId(heroId)

			skinCo = SkinConfig.instance:getSkinCo(heroMo.skin)
		end

		if skinCo == nil then
			logError("奥德赛角色活动 角色皮肤表id为空：装备uid：" .. tostring(self.mo.uid))
		else
			if skinCo.gainApproach ~= CharacterEnum.SkinGainApproach.Init then
				local characterId = skinCo.characterId
				local initConfig
				local skinConfigList = SkinConfig.instance:getCharacterSkinCoList(characterId)

				if skinConfigList ~= nil and next(skinConfigList) then
					for _, config in ipairs(skinConfigList) do
						if config.gainApproach == CharacterEnum.SkinGainApproach.Init then
							initConfig = config

							break
						end
					end

					if initConfig == nil then
						logError("奥德赛角色活动 角色默认皮肤表id为空：角色：" .. tostring(characterId))
					else
						haveHero = true
						skinCo = initConfig
					end
				else
					logError("奥德赛角色活动 角色皮肤列表为空：角色：" .. tostring(characterId))
				end
			else
				haveHero = true
			end

			local heroIconPath = ResUrl.getHeadIconImg(skinCo.id)

			self.skinCo = skinCo

			self._simageHero:LoadImage(heroIconPath, self.onLoadHeadIcon, self)
		end
	end

	gohelper.setActive(self._simageHero, haveHero)
	gohelper.setActive(self._goEmptyHero, not haveHero)
	logNormal(string.format("索引:%s Id:%s", heroPos, heroId))
end

function OdysseyEquipView:onLoadHeadIcon()
	ZProj.UGUIHelper.SetImageSize(self._simageHero.gameObject)

	local offsetStr = self.skinCo.playercardViewImgOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simageHero.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simageHero.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	end
end

function OdysseyEquipView:initSwitchList(heroPos, equipIndex)
	local tempPosIndex = 1
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
	local tempPosList = {}

	for pos, hero in ipairs(heroGroupMo.heroList) do
		table.insert(tempPosList, pos)
	end

	for index, pos in ipairs(tempPosList) do
		if pos == heroPos then
			tempPosIndex = index

			break
		end
	end

	self._heroPosMax = #tempPosList
	self._heroPosList = tempPosList

	self:onSelectHero(tempPosIndex, equipIndex, true)
end

function OdysseyEquipView:onHeroGroupUpdate()
	self:refreshList(true, false)
	self:refreshItem()

	local saveType = OdysseyHeroGroupModel.instance:getSaveType()

	OdysseyHeroGroupModel.instance:setSaveType(nil)

	if saveType and saveType == OdysseyEnum.HeroGroupSaveType.ItemEquip or saveType == OdysseyEnum.HeroGroupSaveType.ItemReplace then
		self:checkChangeEquipPos()
	else
		self:selectCurItemAndPos()
	end
end

function OdysseyEquipView:selectCurItemAndPos()
	self:selectEquipPos(self._equipIndex)
	OdysseyEquipListModel.instance:setSelect(nil)
end

function OdysseyEquipView:checkChangeEquipPos()
	if self.equipCount <= 1 then
		self:selectCurItemAndPos()

		return
	end

	local equipIndex = self._equipIndex
	local heroPos = self._heroPos
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
	local equipMo = heroGroupMo:getOdysseyEquips(heroPos - 1)

	for index, equipIdParam in ipairs(equipMo.equipUid) do
		local equipId = tonumber(equipIdParam)

		if index ~= equipIndex and equipId ~= nil and equipId == 0 then
			equipIndex = index

			self:onEquipPosSelect(index)

			return
		end
	end

	self:selectCurItemAndPos()
end

function OdysseyEquipView:onTipSubViewClose()
	self:onItemSelect(nil)
end

function OdysseyEquipView:refreshSwitchState()
	local index = self._heroPosIndex

	gohelper.setActive(self._btnleft, index > 1)
	gohelper.setActive(self._btnright, index < self._heroPosMax)
end

function OdysseyEquipView:refreshItem()
	local heroPos = self._heroPos
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
	local equipMo = heroGroupMo:getOdysseyEquips(heroPos - 1)

	for index, equipIdParam in ipairs(equipMo.equipUid) do
		local item = self._odysseyItemList[index]

		if not item then
			logError("奥德赛编队界面 装备索引超过上限 index: " .. tostring(index))
		else
			local equipId = tonumber(equipIdParam)

			item:setActive(true)
			item:setInfo(heroPos, index, equipId, OdysseyEnum.BagType.Bag)
			item:refreshUI()
		end
	end

	local itemCount = #self._odysseyItemList
	local equipCount = #equipMo.equipUid

	self.equipCount = equipCount

	if equipCount < itemCount then
		for i = equipCount + 1, itemCount do
			local item = self._odysseyItemList[i]

			item:clear()
			item:setActive(false)
		end
	end
end

function OdysseyEquipView:refreshList(keepOrder, showAnim)
	if self._equipFilterType == nil then
		OdysseyEquipSuitTabListModel.instance:selectAllTag()
	end

	OdysseyEquipListModel.instance:copyListFromEquipModel(OdysseyEnum.ItemType.Equip, self._equipFilterType, OdysseyEnum.BagType.FightPrepare, keepOrder)

	if showAnim then
		self._animScroll:Play("flash", 0, 0)
	end
end

function OdysseyEquipView:onItemSelect(mo)
	self._equipMo = mo

	if mo ~= nil then
		local equipUid = mo.uid

		if equipUid == 0 then
			logError("奥德赛 下半活动 背包道具uid 为0")

			return
		else
			local infoMo = OdysseyHeroGroupModel.instance:getCurHeroGroup()
			local itemMo = infoMo:getEquipByUid(mo.uid)

			if itemMo ~= nil and itemMo.heroPos == self._heroPos and itemMo.slotId ~= self._equipIndex then
				self:onEquipPosSelect(itemMo.slotId)
				self:onItemSelect(mo)
			else
				local viewParam = {}

				viewParam.itemId = mo.itemId
				viewParam.equipUid = mo.uid
				viewParam.equipIndex = self._equipIndex
				viewParam.heroPos = self._heroPos

				self.equipTipItem:setActive(true)
				self.equipTipItem:setData(viewParam)
			end
		end
	else
		OdysseyEquipListModel.instance:clearSelect()
		self.equipTipItem:setActive(false)
	end
end

function OdysseyEquipView:onEquipPosSelect(pos)
	self:selectEquipPos(pos, true)
end

function OdysseyEquipView:selectEquipPos(pos, selectCurrent)
	self._equipIndex = pos

	for _, item in ipairs(self._odysseyItemList) do
		item:setSelect(pos)
	end

	OdysseyEquipListModel.instance:clearSelect()

	if self._equipIndex ~= nil and selectCurrent then
		local heroPos = self._heroPos
		local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
		local equipMo = heroGroupMo:getOdysseyEquips(heroPos - 1)
		local equipUid = equipMo:getEquipUID(pos)

		if equipUid and equipUid ~= 0 then
			local itemMo = OdysseyItemModel.instance:getItemMoByUid(equipUid)

			if itemMo then
				local selectSuitMo = OdysseyEquipSuitTabListModel.instance:getSelect()

				if selectSuitMo and selectSuitMo.type ~= OdysseyEnum.EquipSuitType.All and itemMo.config.suitId ~= selectSuitMo.suitId then
					OdysseyEquipSuitTabListModel.instance:selectAllTag(true)
					logNormal("选中全部类型装备标签")
				end
			end

			OdysseyEquipListModel.instance:setSelect(equipUid)
		else
			self:onItemSelect(nil)
		end
	else
		self:onItemSelect(nil)
	end
end

function OdysseyEquipView:OnEquipSuitSelect(mo)
	local suitType

	if mo.type == OdysseyEnum.EquipSuitType.All then
		-- block empty
	else
		suitType = mo and mo.suitId

		if self._equipFilterType == suitType then
			return
		end
	end

	self._equipFilterType = suitType

	OdysseyEquipListModel.instance:clearSelect()
	self:onItemSelect(nil)
	self:refreshList(false, true)
end

function OdysseyEquipView:onClose()
	self._animEventWrap:RemoveAllEventListener()
end

function OdysseyEquipView:onDestroyView()
	return
end

return OdysseyEquipView

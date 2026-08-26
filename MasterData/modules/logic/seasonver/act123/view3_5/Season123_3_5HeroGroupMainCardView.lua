-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5HeroGroupMainCardView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5HeroGroupMainCardView", package.seeall)

local Season123_3_5HeroGroupMainCardView = class("Season123_3_5HeroGroupMainCardView", BaseView)

function Season123_3_5HeroGroupMainCardView:onInitView()
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "herogroupcontain/#simage_role")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5HeroGroupMainCardView:addEvents()
	return
end

function Season123_3_5HeroGroupMainCardView:removeEvents()
	return
end

function Season123_3_5HeroGroupMainCardView:_editableInitView()
	self._simagerole:LoadImage(ResUrl.getSeasonIcon("img_vertin.png"))

	self._supercardGroups = {}

	for i = 1, Activity123Enum.MainCardNum do
		local groupObj = self:getUserDataTb_()

		groupObj.go = gohelper.findChild(self.viewGO, string.format("herogroupcontain/#go_supercard%s", i))
		groupObj.golight = gohelper.findChild(groupObj.go, "light")
		groupObj.goempty = gohelper.findChild(groupObj.go, string.format("#go_supercardempty"))
		groupObj.gopos = gohelper.findChild(groupObj.go, string.format("#go_supercardpos"))
		groupObj.btnclick = gohelper.findChildButtonWithAudio(groupObj.go, "#btn_supercardclick")

		groupObj.btnclick:AddClickListener(self._btnseasonsupercardOnClick, self, i)

		groupObj.goCheck = gohelper.findChild(groupObj.go, "#go_check")
		groupObj.goExchange = gohelper.findChild(groupObj.go, "#go_exchange")
		groupObj.goDesc = gohelper.findChild(groupObj.go, "#scroll_desc")
		groupObj.txtDesc = gohelper.findChildTextMesh(groupObj.go, "#scroll_desc/Viewport/Content/#txt_desc")
		self._supercardGroups[i] = groupObj
	end
end

function Season123_3_5HeroGroupMainCardView:onDestroyView()
	self._simagerole:UnLoadImage()

	if self._supercardGroups then
		for _, cardGroup in pairs(self._supercardGroups) do
			cardGroup.btnclick:RemoveClickListener()

			if cardGroup.cardItem then
				cardGroup.cardItem:destroy()

				cardGroup.cardItem = nil
			end
		end

		self._supercardGroups = nil
	end
end

function Season123_3_5HeroGroupMainCardView:onOpen()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.refreshMainCards, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshMainCards, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self.refreshMainCards, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.RecordRspMainCardRefresh, self.refreshMainCards, self)
	self:refreshMainCards()
end

function Season123_3_5HeroGroupMainCardView:onClose()
	return
end

function Season123_3_5HeroGroupMainCardView:refreshMainCards()
	for slot = 1, Activity123Enum.MainCardNum do
		self:_refreshMainCard(slot)
	end
end

function Season123_3_5HeroGroupMainCardView:_refreshMainCard(slot)
	local actId = self.viewParam.actId
	local stage = self.viewParam.stage
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local unlock = Season123HeroGroupModel.instance:isEquipCardPosUnlock(slot, Season123EquipItemListModel.MainCharPos)
	local cardGroup = self._supercardGroups[slot]

	gohelper.setActive(cardGroup.goempty, unlock)
	gohelper.setActive(cardGroup.btnclick, unlock)

	if not unlock then
		return
	end

	local act104EquipId = Season123HeroGroupModel.instance:getMainPosEquipId(slot)
	local cardItem = cardGroup.cardItem
	local isEmpty = not act104EquipId or act104EquipId == 0

	gohelper.setActive(cardGroup.goDesc, not isEmpty)

	if not isEmpty then
		if not cardItem then
			cardItem = Season123_3_5CelebrityCardItem.New()

			cardItem:init(cardGroup.gopos, act104EquipId)

			cardGroup.cardItem = cardItem
		else
			cardItem:reset(act104EquipId)
		end

		local cardConfig = Season123Config.instance:getSeasonEquipCo(act104EquipId)

		cardGroup.txtDesc.text = cardConfig.scoreTitle
	end

	if cardItem then
		gohelper.setActive(cardItem.go, not isEmpty)
	end

	gohelper.setActive(cardGroup.golight, not isEmpty)

	local stageConfig = Season123Config.instance:getStageCo(actId, stage)
	local mainEquipList = string.splitToNumber(stageConfig.mainEquip, "#")
	local equipCount = #mainEquipList

	self.isSingleCard = equipCount == 1

	local isMulti = equipCount > 1

	gohelper.setActive(cardGroup.goCheck, unlock and not isEmpty and mainEquipList)
	gohelper.setActive(cardGroup.goExchange, unlock and not isEmpty and isMulti)
end

function Season123_3_5HeroGroupMainCardView:_btnseasonsupercardOnClick(slot)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local param = {
		actId = self.viewParam.actId,
		stage = self.viewParam.stage,
		slot = slot
	}

	if not Season123HeroGroupModel.instance:isEquipCardPosUnlock(param.slot, Season123EquipItemListModel.MainCharPos) then
		return
	end

	if self.isSingleCard then
		local act104EquipId = Season123HeroGroupModel.instance:getMainPosEquipId(slot)

		if act104EquipId and act104EquipId > 0 then
			Season123Controller.instance:openSeasonCardDescView(act104EquipId)

			return
		end
	end

	ViewMgr.instance:openView(Season123Controller.instance:getEquipHeroViewName(), param)
end

return Season123_3_5HeroGroupMainCardView

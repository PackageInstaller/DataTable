-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9HeroGroupMainCardView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9HeroGroupMainCardView", package.seeall)

local Season123_1_9HeroGroupMainCardView = class("Season123_1_9HeroGroupMainCardView", BaseView)

function Season123_1_9HeroGroupMainCardView:onInitView()
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "herogroupcontain/#simage_role")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_9HeroGroupMainCardView:addEvents()
	return
end

function Season123_1_9HeroGroupMainCardView:removeEvents()
	return
end

function Season123_1_9HeroGroupMainCardView:_editableInitView()
	self._simagerole:LoadImage(ResUrl.getSeasonIcon("img_vertin.png"))

	self._supercardItems = {}
	self._supercardGroups = {}

	for i = 1, Activity123Enum.MainCardNum do
		local groupObj = self:getUserDataTb_()

		groupObj.golight = gohelper.findChild(self.viewGO, string.format("herogroupcontain/#go_supercard%s/light", i))
		groupObj.goempty = gohelper.findChild(self.viewGO, string.format("herogroupcontain/#go_supercard%s/#go_supercardempty", i))
		groupObj.gopos = gohelper.findChild(self.viewGO, string.format("herogroupcontain/#go_supercard%s/#go_supercardpos", i))
		groupObj.btnclick = gohelper.findChildButtonWithAudio(self.viewGO, string.format("herogroupcontain/#go_supercard%s/#btn_supercardclick", i))

		groupObj.btnclick:AddClickListener(self._btnseasonsupercardOnClick, self, i)

		self._supercardGroups[i] = groupObj
	end
end

function Season123_1_9HeroGroupMainCardView:onDestroyView()
	self._simagerole:UnLoadImage()

	if self._supercardGroups then
		for _, cardGroup in pairs(self._supercardGroups) do
			cardGroup.btnclick:RemoveClickListener()
		end

		self._supercardGroups = nil
	end

	if self._supercardItems then
		for _, item in pairs(self._supercardItems) do
			item:destroy()
		end

		self._supercardItems = nil
	end
end

function Season123_1_9HeroGroupMainCardView:onOpen()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.refreshMainCards, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshMainCards, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.HeroGroupIndexChanged, self.refreshMainCards, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.RecordRspMainCardRefresh, self.refreshMainCards, self)
	self:refreshMainCards()
end

function Season123_1_9HeroGroupMainCardView:onClose()
	return
end

function Season123_1_9HeroGroupMainCardView:refreshMainCards()
	for slot = 1, Activity123Enum.MainCardNum do
		self:_refreshMainCard(slot)
	end
end

function Season123_1_9HeroGroupMainCardView:_refreshMainCard(slot)
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local act104EquipId = Season123HeroGroupModel.instance:getMainPosEquipId(slot)
	local cardGroup = self._supercardGroups[slot]
	local cardItem = self._supercardItems[slot]
	local showLight = false

	if act104EquipId and act104EquipId ~= 0 then
		if not cardItem then
			cardItem = Season123_1_9CelebrityCardItem.New()

			cardItem:init(cardGroup.gopos, act104EquipId)

			self._supercardItems[slot] = cardItem
		else
			gohelper.setActive(cardItem.go, true)
			cardItem:reset(act104EquipId)
		end

		showLight = true
	elseif cardItem then
		gohelper.setActive(cardItem.go, false)
	end

	gohelper.setActive(cardGroup.golight, showLight)

	local seasonMO = Season123Model.instance:getActInfo(self.viewParam.actId)

	if not seasonMO then
		return
	end

	local unlock = Season123HeroGroupModel.instance:isEquipCardPosUnlock(slot, Season123EquipItemListModel.MainCharPos)

	gohelper.setActive(cardGroup.goempty, unlock)
	gohelper.setActive(cardGroup.btnclick, unlock)
end

function Season123_1_9HeroGroupMainCardView:_btnseasonsupercardOnClick(slot)
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

	ViewMgr.instance:openView(Season123Controller.instance:getEquipHeroViewName(), param)
end

return Season123_1_9HeroGroupMainCardView

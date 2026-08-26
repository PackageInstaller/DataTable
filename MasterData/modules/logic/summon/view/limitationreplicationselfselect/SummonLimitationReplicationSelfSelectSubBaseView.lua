-- chunkname: @modules/logic/summon/view/limitationreplicationselfselect/SummonLimitationReplicationSelfSelectSubBaseView.lua

module("modules.logic.summon.view.limitationreplicationselfselect.SummonLimitationReplicationSelfSelectSubBaseView", package.seeall)

local SummonLimitationReplicationSelfSelectSubBaseView = class("SummonLimitationReplicationSelfSelectSubBaseView", SummonMainCharacterProbUp)

function SummonLimitationReplicationSelfSelectSubBaseView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagead1eff = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1_eff")
	self._simagefontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_fontbg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem2")
	self._txttimes = gohelper.findChildText(self.viewGO, "#go_ui/current/first/#txt_times")
	self._simagetitle1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_title1")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonLimitationReplicationSelfSelectSubBaseView:addEvents()
	SummonLimitationReplicationSelfSelectSubBaseView.super.addEvents(self)
end

function SummonLimitationReplicationSelfSelectSubBaseView:removeEvents()
	SummonLimitationReplicationSelfSelectSubBaseView.super.removeEvents(self)
end

function SummonLimitationReplicationSelfSelectSubBaseView:_editableInitView()
	SummonLimitationReplicationSelfSelectSubBaseView.super._editableInitView(self)
end

SummonLimitationReplicationSelfSelectSubBaseView.LimitCount = 1

function SummonLimitationReplicationSelfSelectSubBaseView:initCharacterItemCount()
	self._characterItemCount = SummonLimitationReplicationSelfSelectSubBaseView.LimitCount
end

function SummonLimitationReplicationSelfSelectSubBaseView:showCharacter()
	local characterDetails
	local detailConfigId = SummonConfig.instance:getSummonDetailIdByHeroId(self.config.id)
	local indexDict = {}

	if detailConfigId ~= nil then
		local characterDetailIds = {
			detailConfigId
		}

		for i = 1, #characterDetailIds do
			local characterDetailId = characterDetailIds[i]
			local characterDetailConfig = SummonConfig.instance:getCharacterDetailConfig(characterDetailId)
			local index = characterDetailConfig.location
			local characteritem = self._characteritems[index]

			if characteritem then
				local heroId = characterDetailConfig.heroId
				local heroConfig = HeroConfig.instance:getHeroCO(heroId)

				UISpriteSetMgr.instance:setCommonSprite(characteritem.imagecareer, "lssx_" .. tostring(heroConfig.career))

				characteritem.txtnamecn.text = heroConfig.name

				for j = 1, 6 do
					gohelper.setActive(characteritem.rares[j], j <= CharacterEnum.Star[heroConfig.rare])
				end

				characteritem.characterDetailId = characterDetailId

				gohelper.setActive(characteritem.go, true)

				indexDict[index] = true
			end
		end
	end

	for i = 1, #self._characteritems do
		gohelper.setActive(self._characteritems[i].go, indexDict[i])
	end
end

function SummonLimitationReplicationSelfSelectSubBaseView:onUpdateParam()
	SummonLimitationReplicationSelfSelectSubBaseView.super.onUpdateParam(self)
end

function SummonLimitationReplicationSelfSelectSubBaseView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshView, self)
	self:playEnterAnim()
	self:_refreshView()
end

function SummonLimitationReplicationSelfSelectSubBaseView:stopAnimator()
	self._animRoot:Play("None")
end

function SummonLimitationReplicationSelfSelectSubBaseView:onClose()
	SummonLimitationReplicationSelfSelectSubBaseView.super.onClose(self)
end

function SummonLimitationReplicationSelfSelectSubBaseView:onDestroyView()
	SummonLimitationReplicationSelfSelectSubBaseView.super.onDestroyView(self)
end

return SummonLimitationReplicationSelfSelectSubBaseView

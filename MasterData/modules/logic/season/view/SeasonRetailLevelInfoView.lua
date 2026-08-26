-- chunkname: @modules/logic/season/view/SeasonRetailLevelInfoView.lua

module("modules.logic.season.view.SeasonRetailLevelInfoView", package.seeall)

local SeasonRetailLevelInfoView = class("SeasonRetailLevelInfoView", BaseView)

function SeasonRetailLevelInfoView:onInitView()
	self._simageuppermask = gohelper.findChildSingleImage(self.viewGO, "#simage_uppermask")
	self._simagedecorate = gohelper.findChildSingleImage(self.viewGO, "#simage_decorate")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._gobottom = gohelper.findChild(self.viewGO, "bottom")
	self._gonormalcondition = gohelper.findChild(self.viewGO, "bottom/#go_conditions/#go_normalcondition")
	self._txtnormalrule = gohelper.findChildText(self.viewGO, "bottom/#go_conditions/#go_normalcondition/#txt_normalrule")
	self._gospecialcondition = gohelper.findChild(self.viewGO, "bottom/#go_conditions/#go_specialcondition")
	self._txtspecialrule = gohelper.findChildText(self.viewGO, "bottom/#go_conditions/#go_specialcondition/#txt_specialrule")
	self._txtlevelname = gohelper.findChildText(self.viewGO, "bottom/#txt_levelname")
	self._txtenemylevelnum = gohelper.findChildText(self.viewGO, "bottom/txt_enemylevel/#txt_enemylevelnum")
	self._scrollcelebritycard = gohelper.findChildScrollRect(self.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard")
	self._gocarditem = gohelper.findChild(self.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard/scrollcontent_seasoncelebritycarditem")
	self._txtdecr = gohelper.findChildText(self.viewGO, "bottom/#txt_decr")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_start")
	self._gotag = gohelper.findChild(self.viewGO, "bottom/#go_tag")
	self._txttagdesc = gohelper.findChildText(self.viewGO, "bottom/#go_tag/descbg/#txt_tagdesc")
	self._gostageitem = gohelper.findChild(self.viewGO, "bottom/stages/#go_stageitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonRetailLevelInfoView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function SeasonRetailLevelInfoView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function SeasonRetailLevelInfoView:_onBattleReply(msg)
	Activity104Model.instance:onStartAct104BattleReply(msg)
end

function SeasonRetailLevelInfoView:_btnclose1OnClick()
	self:closeThis()
end

function SeasonRetailLevelInfoView:_btnclose2OnClick()
	self:closeThis()
end

function SeasonRetailLevelInfoView:_btncloseOnClick()
	self:closeThis()
end

function SeasonRetailLevelInfoView:_btnstartOnClick()
	local actId = ActivityEnum.Activity.Season

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(actId, 0, self.viewParam.episodeId)
end

function SeasonRetailLevelInfoView:_editableInitView()
	self._simageuppermask:LoadImage(ResUrl.getSeasonIcon("full/seasonsecretlandentrance_mask.png"))
	self._simagedecorate:LoadImage(ResUrl.getSeasonIcon("particle.png"))
end

function SeasonRetailLevelInfoView:onUpdateParam()
	return
end

function SeasonRetailLevelInfoView:onOpen()
	self._cardItems = {}

	self:_setInfo()
end

local commonRewardParams = {
	targetFlagUIPosX = -32.7,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 28.3
}

function SeasonRetailLevelInfoView:_setInfo()
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail, self.viewParam.retail.position)

	local showStage = math.min(Activity104Model.instance:getAct104CurStage(), 6)

	self._txtlevelname.text = SeasonConfig.instance:getSeasonTagDesc(Activity104Model.instance:getCurSeasonId(), self.viewParam.retail.tag).name .. " " .. GameUtil.getRomanNums(showStage)

	local stage = Activity104Model.instance:getRetailStage()
	local actId = ActivityEnum.Activity.Season

	self._txtenemylevelnum.text = HeroConfig.instance:getCommonLevelDisplay(SeasonConfig.instance:getSeasonRetailCo(actId, stage).level)

	local tag = Activity104Model.instance:getRetailEpisodeTag(self.viewParam.retail.id)

	gohelper.setActive(self._gotag, not string.nilorempty(tag))

	self._txttagdesc.text = tostring(tag)

	for _, v in pairs(self._cardItems) do
		gohelper.setActive(v.go, false)
	end

	for i = 1, #self.viewParam.retail.showActivity104EquipIds do
		local equipId = self.viewParam.retail.showActivity104EquipIds[i]

		if not self._cardItems[i] then
			self._cardItems[i] = SeasonCelebrityCardItem.New()

			self._cardItems[i]:init(self._gocarditem, equipId, commonRewardParams)
		else
			gohelper.setActive(self._cardItems[i].go, true)
			self._cardItems[i]:reset(equipId)
		end

		self._cardItems[i]:showTag(true)
		self._cardItems[i]:showProbability(true)
	end

	gohelper.setActive(self._gonormalcondition, self.viewParam.retail.advancedId ~= 0 and self.viewParam.retail.advancedRare == 1)
	gohelper.setActive(self._gospecialcondition, self.viewParam.retail.advancedId ~= 0 and self.viewParam.retail.advancedRare == 2)

	if self.viewParam.retail.advancedId ~= 0 then
		local name = "      " .. lua_condition.configDict[self.viewParam.retail.advancedId].desc

		if self.viewParam.retail.advancedRare == 1 then
			self._txtnormalrule.text = name
		elseif self.viewParam.retail.advancedRare == 2 then
			self._txtspecialrule.text = name
		end
	end

	self:_refreshStateUI()
end

SeasonRetailLevelInfoView.MaxStageCount = 7

function SeasonRetailLevelInfoView:_refreshStateUI()
	self._stageItemsTab = self._stageItemsTab or self:getUserDataTb_()

	local stage = Activity104Model.instance:getAct104CurStage()

	for i = 1, SeasonRetailLevelInfoView.MaxStageCount do
		local stageItem = self._stageItemsTab[i]

		if not stageItem then
			stageItem = gohelper.cloneInPlace(self._gostageitem, "stageitem_" .. i)

			table.insert(self._stageItemsTab, i, stageItem)
		end

		gohelper.setActive(stageItem, i <= 6 or i <= stage)

		local dark = gohelper.findChildImage(stageItem, "dark")
		local light = gohelper.findChildImage(stageItem, "light")

		gohelper.setActive(light.gameObject, i <= stage)
		gohelper.setActive(dark.gameObject, stage < i)

		local color = i == 7 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(light, color)
	end
end

function SeasonRetailLevelInfoView:onClose()
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail)
end

function SeasonRetailLevelInfoView:onDestroyView()
	if self._cardItems then
		for _, v in pairs(self._cardItems) do
			v:destroy()
		end

		self._cardItems = nil
	end

	self._simageuppermask:UnLoadImage()
	self._simagedecorate:UnLoadImage()
end

return SeasonRetailLevelInfoView

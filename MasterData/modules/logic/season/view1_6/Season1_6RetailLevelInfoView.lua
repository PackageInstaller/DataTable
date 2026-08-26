-- chunkname: @modules/logic/season/view1_6/Season1_6RetailLevelInfoView.lua

module("modules.logic.season.view1_6.Season1_6RetailLevelInfoView", package.seeall)

local Season1_6RetailLevelInfoView = class("Season1_6RetailLevelInfoView", BaseView)

function Season1_6RetailLevelInfoView:onInitView()
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
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6RetailLevelInfoView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function Season1_6RetailLevelInfoView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnstart:RemoveClickListener()
end

function Season1_6RetailLevelInfoView:_btnclose1OnClick()
	self:closeThis()
end

function Season1_6RetailLevelInfoView:_btnclose2OnClick()
	self:closeThis()
end

function Season1_6RetailLevelInfoView:_btncloseOnClick()
	self:closeThis()
end

function Season1_6RetailLevelInfoView:_btnstartOnClick()
	Activity104Model.instance:enterAct104Battle(self.viewParam.episodeId, 0)
end

function Season1_6RetailLevelInfoView:_editableInitView()
	self._simageuppermask:LoadImage(ResUrl.getSeasonIcon("full/seasonsecretlandentrance_mask.png"))
	self._simagedecorate:LoadImage(ResUrl.getSeasonIcon("particle.png"))
	self._simageleftbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	self._simagerightbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
end

function Season1_6RetailLevelInfoView:onUpdateParam()
	return
end

function Season1_6RetailLevelInfoView:onOpen()
	self._cardItems = {}

	self:_setInfo()
end

local commonRewardParams = {
	targetFlagUIPosX = -32.7,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 28.3
}

function Season1_6RetailLevelInfoView:_setInfo()
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail, self.viewParam.retail.position)

	local showStage = math.min(Activity104Model.instance:getAct104CurStage(), 6)
	local actId = Activity104Model.instance:getCurSeasonId()

	self._txtlevelname.text = SeasonConfig.instance:getSeasonTagDesc(actId, self.viewParam.retail.tag).name .. " " .. GameUtil.getRomanNums(showStage)

	local stage = Activity104Model.instance:getRetailStage()

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
			self._cardItems[i] = Season1_6CelebrityCardItem.New()

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

Season1_6RetailLevelInfoView.MaxStageCount = 7

function Season1_6RetailLevelInfoView:_refreshStateUI()
	self._stageItemsTab = self._stageItemsTab or self:getUserDataTb_()

	local stage = Activity104Model.instance:getAct104CurStage()

	for i = 1, Season1_6RetailLevelInfoView.MaxStageCount do
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

function Season1_6RetailLevelInfoView:onClose()
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail)
end

function Season1_6RetailLevelInfoView:onDestroyView()
	if self._cardItems then
		for _, v in pairs(self._cardItems) do
			v:destroy()
		end

		self._cardItems = nil
	end

	self._simageuppermask:UnLoadImage()
	self._simagedecorate:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return Season1_6RetailLevelInfoView

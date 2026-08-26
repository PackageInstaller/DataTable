-- chunkname: @modules/logic/season/view3_0/Season3_0RetailLevelInfoView.lua

module("modules.logic.season.view3_0.Season3_0RetailLevelInfoView", package.seeall)

local Season3_0RetailLevelInfoView = class("Season3_0RetailLevelInfoView", BaseView)

function Season3_0RetailLevelInfoView:onInitView()
	self._simageuppermask = gohelper.findChildSingleImage(self.viewGO, "#simage_uppermask")
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
	self._gostage = gohelper.findChild(self.viewGO, "bottom/stages")
	self._gostageitem = gohelper.findChild(self.viewGO, "bottom/stages/#go_stageitem")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0RetailLevelInfoView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function Season3_0RetailLevelInfoView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnstart:RemoveClickListener()
end

function Season3_0RetailLevelInfoView:_btnclose1OnClick()
	self:closeThis()
end

function Season3_0RetailLevelInfoView:_btnclose2OnClick()
	self:closeThis()
end

function Season3_0RetailLevelInfoView:_btncloseOnClick()
	self:closeThis()
end

function Season3_0RetailLevelInfoView:_btnstartOnClick()
	Activity104Model.instance:enterAct104Battle(self.retailInfo.id, 0)
end

function Season3_0RetailLevelInfoView:_editableInitView()
	self._simageuppermask:LoadImage(SeasonViewHelper.getSeasonIcon("full/seasonsecretlandentrance_mask.png"))
	self._simageleftbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	self._simagerightbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
end

function Season3_0RetailLevelInfoView:onUpdateParam()
	self:refreshParam()
	self:_setInfo()
end

function Season3_0RetailLevelInfoView:onOpen()
	self:refreshParam()
	self:_setInfo()
end

function Season3_0RetailLevelInfoView:refreshParam()
	self.retailInfo = self.viewParam.retail
end

local commonRewardParams = {
	targetFlagUIPosX = -32.7,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 28.3
}

function Season3_0RetailLevelInfoView:_setInfo()
	if not self.retailInfo then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail, self.retailInfo.position)

	local actId = Activity104Model.instance:getCurSeasonId()
	local episodeCo = SeasonConfig.instance:getSeasonRetailEpisodeCo(actId, self.retailInfo.id)

	self._txtlevelname.text = episodeCo.desc
	self._txtenemylevelnum.text = HeroConfig.instance:getCommonLevelDisplay(episodeCo.level)

	gohelper.setActive(self._gotag, false)

	self._cardItems = self._cardItems or {}

	for _, v in pairs(self._cardItems) do
		gohelper.setActive(v.go, false)
	end

	for i = 1, #self.retailInfo.showActivity104EquipIds do
		local equipId = self.retailInfo.showActivity104EquipIds[i]

		if not self._cardItems[i] then
			self._cardItems[i] = Season3_0CelebrityCardItem.New()

			self._cardItems[i]:init(self._gocarditem, equipId, commonRewardParams)
		else
			gohelper.setActive(self._cardItems[i].go, true)
			self._cardItems[i]:reset(equipId)
		end

		self._cardItems[i]:showTag(true)
		self._cardItems[i]:showProbability(true)
	end

	local advancedId = self.retailInfo.advancedId
	local advancedRare = self.retailInfo.advancedRare

	gohelper.setActive(self._gonormalcondition, advancedId ~= 0 and advancedRare == 1)
	gohelper.setActive(self._gospecialcondition, advancedId ~= 0 and advancedRare == 2)

	if advancedId ~= 0 then
		local name = "      " .. lua_condition.configDict[advancedId].desc

		if advancedRare == 1 then
			self._txtnormalrule.text = name
		elseif advancedRare == 2 then
			self._txtspecialrule.text = name
		end
	end

	self:_refreshStateUI()
end

function Season3_0RetailLevelInfoView:_refreshStateUI()
	local stage = Activity104Model.instance:getAct104CurStage()
	local maxStage = Activity104Model.instance:getMaxStage()

	self.starComp = self.starComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._gostage, SeasonStarProgressComp)

	self.starComp:refreshStar(self._gostageitem, stage, maxStage)
end

function Season3_0RetailLevelInfoView:onClose()
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail)
end

function Season3_0RetailLevelInfoView:onDestroyView()
	if self._cardItems then
		for _, v in pairs(self._cardItems) do
			v:destroy()
		end

		self._cardItems = nil
	end

	self._simageuppermask:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return Season3_0RetailLevelInfoView

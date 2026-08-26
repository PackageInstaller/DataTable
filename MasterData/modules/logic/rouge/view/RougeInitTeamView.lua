-- chunkname: @modules/logic/rouge/view/RougeInitTeamView.lua

module("modules.logic.rouge.view.RougeInitTeamView", package.seeall)

local RougeInitTeamView = class("RougeInitTeamView", BaseView)

function RougeInitTeamView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gopoint = gohelper.findChild(self.viewGO, "Title/bg/volume/#go_point")
	self._txtnum = gohelper.findChildText(self.viewGO, "Title/bg/volume/#txt_num")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._gocontent = gohelper.findChild(self.viewGO, "Scroll View/Viewport/#go_content")
	self._goitem1 = gohelper.findChild(self.viewGO, "Scroll View/Viewport/#go_content/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "Scroll View/Viewport/#go_content/#go_item2")
	self._btnhelp = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_help")
	self._gounselect = gohelper.findChild(self.viewGO, "Left/#btn_help/#go_unselect")
	self._goselected = gohelper.findChild(self.viewGO, "Left/#btn_help/#go_selected")
	self._gofull = gohelper.findChild(self.viewGO, "Left/#btn_help/#go_full")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._godifficultytips = gohelper.findChild(self.viewGO, "#go_difficultytips")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "#go_difficultytips/#txt_difficulty")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeInitTeamView:addEvents()
	self._btnhelp:AddClickListener(self._btnhelpOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function RougeInitTeamView:removeEvents()
	self._btnhelp:RemoveClickListener()
	self._btnstart:RemoveClickListener()
end

function RougeInitTeamView:_btnhelpOnClick()
	if self._helpState == RougeEnum.HelpState.Full then
		if self._capacityFull then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return
		end

		if self._heroFull then
			GameFacade.showToast(ToastEnum.RougeTeamFull)

			return
		end

		return
	end

	if self._helpState == RougeEnum.HelpState.Selected then
		self._assistMo = nil

		self:_modifyHeroGroup()

		return
	end

	RougeController.instance:setPickAssistViewParams(self._curCapacity, self._maxCapacity)
	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Rouge, 1, nil, self._onPickHandler, self, true)
end

function RougeInitTeamView:_onPickHandler(mo)
	if not mo then
		self._assistMo = nil

		return
	end

	if self._assistMo then
		if not self._assistMo.id then
			local assistIndex = self:_getAssistIndex(mo.heroMO.heroId)

			if not assistIndex then
				return
			end

			self._assistMo = self._assistMo or RougeAssistHeroSingleGroupMO.New()

			self._assistMo:init(assistIndex, mo.heroMO.uid, mo.heroMO)
			self:_modifyHeroGroup()
		end
	end
end

function RougeInitTeamView:_getAssistIndex(assistHeroId)
	for i, heroItem in ipairs(self._heroItemList) do
		local mo = RougeHeroSingleGroupModel.instance:getById(i)
		local heroMo = mo:getHeroMO()

		if heroMo and heroMo.heroId == assistHeroId and assistHeroId then
			RougeHeroSingleGroupModel.instance:removeFrom(i)

			return i
		end
	end

	for i, heroItem in ipairs(self._heroItemList) do
		local mo = RougeHeroSingleGroupModel.instance:getById(i)
		local heroMo = mo:getHeroMO()

		if not heroMo then
			return i
		end
	end
end

function RougeInitTeamView:_checkHelpState()
	if self._assistMo then
		self:_updateHelpState(RougeEnum.HelpState.Selected)

		return
	end

	self._capacityFull = self._curCapacity >= self._maxCapacity
	self._heroFull = self._heroNum >= RougeEnum.InitTeamHeroNum

	if self._capacityFull or self._heroFull then
		self:_updateHelpState(RougeEnum.HelpState.Full)

		return
	end

	self:_updateHelpState(RougeEnum.HelpState.UnSelected)
end

function RougeInitTeamView:_updateHelpState(state)
	self._helpState = state

	gohelper.setActive(self._gounselect, state == RougeEnum.HelpState.UnSelected)
	gohelper.setActive(self._goselected, state == RougeEnum.HelpState.Selected)
	gohelper.setActive(self._gofull, state == RougeEnum.HelpState.Full)
end

function RougeInitTeamView:_btnstartOnClick()
	local season = RougeConfig1.instance:season()
	local heroList = {}
	local heroMoList = {}

	for i, heroItem in ipairs(self._heroItemList) do
		local mo = RougeHeroSingleGroupModel.instance:getById(i)
		local heroMo = mo:getHeroMO()

		if heroMo then
			table.insert(heroList, heroMo.heroId)
			table.insert(heroMoList, heroMo)
		end
	end

	if self._assistMo then
		local assistHeroMo = self._assistMo

		RougeRpc.instance:sendEnterRougeSelectHeroesRequest(season, heroList, self._assistMo, function(cmd, resultCode, msg)
			if resultCode ~= 0 then
				return
			end

			RougeController.instance:enterRouge()
			RougeMapModel.instance:setFirstEnterMap(true)
			RougeStatController.instance:selectInitHeroGroup(heroMoList, assistHeroMo)
		end)
	end
end

function RougeInitTeamView:_editableInitView()
	self._heroNum = 0

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseOtherView, self)
	self:_initHeroItemList()
	self:_updateHeroList()
	self:_initPageProgress()
end

function RougeInitTeamView:_initPageProgress()
	local itemClass = RougePageProgress
	local go = self.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, self._goprogress, itemClass.__cname)

	self._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._pageProgress:setData()
end

function RougeInitTeamView:_initHeroItemList()
	self._heroItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[1]
	local itemPrefab = self.viewContainer:getRes(path)

	for i = 1, RougeEnum.InitTeamHeroNum do
		if i % 2 == 1 then
			local itemGo = gohelper.cloneInPlace(self._goitem1 or self._goitem2)

			itemGo.name = "item_" .. tostring(i)

			gohelper.setActive(itemGo, true)

			local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, RougeInitTeamHeroItem)

			item:setIndex(i)
			item:setRougeInitTeamView(self)
			item:setHeroItem(itemPrefab)
			table.insert(self._heroItemList, item)
		end
	end
end

function RougeInitTeamView:_updateHeroList()
	local capacity = 0
	local assistCapacity = 0
	local noneAssistCapacity = 0

	self._heroNum = 0

	local isTrial = false

	for i, heroItem in ipairs(self._heroItemList) do
		local mo = RougeHeroSingleGroupModel.instance:getById(i)

		isTrial = false

		if self._assistMo and self._assistMo.id == i then
			mo = self._assistMo
			isTrial = true
		end

		local heroMo = mo:getHeroMO()

		if self._isModify and heroMo then
			::label_14_0::

			local showSelectEffect = heroItem:getHeroMo() ~= heroMo

			heroItem:setTrialValue(isTrial)
			heroItem:onUpdateMO(mo)

			if showSelectEffect then
				heroItem:showSelectEffect()
			end

			if heroMo then
				self._heroNum = self._heroNum + 1
			end

			capacity = capacity + heroItem:getCapacity()

			if isTrial then
				assistCapacity = heroItem:getCapacity()
			else
				noneAssistCapacity = noneAssistCapacity + heroItem:getCapacity()
			end
		end
	end

	self._assistCapacity = assistCapacity
	self._noneAssistCurCapacity = noneAssistCapacity

	self:_updateCurNum(capacity)
end

function RougeInitTeamView:getAssistCapacity()
	return self._assistCapacity
end

function RougeInitTeamView:getAssistPos()
	return (self._assistMo or nil) and (self._assistMo.id or nil)
end

function RougeInitTeamView:getAssistHeroId()
	return (self._assistMo or nil) and (self._assistMo.heroId or nil)
end

function RougeInitTeamView:_updateCurNum(capacity)
	self._curCapacity = capacity

	if self._capacityComp then
		self._capacityComp:updateCurNum(capacity)
	end

	gohelper.setActive(self._btnstart, capacity ~= 0)
end

function RougeInitTeamView:onUpdateParam()
	return
end

function RougeInitTeamView:onOpen()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)

	local styleId = RougeModel.instance:getStyle()

	self._styleConfig = RougeConfig1.instance:getStyleConfig(styleId)

	self:_initCapacity()
	self:_initDifficultyTips()
	self:_updateHelpState(RougeEnum.HelpState.UnSelected)
end

function RougeInitTeamView:_initDifficultyTips()
	local difficulty = RougeModel.instance:getDifficulty()

	self._txtdifficulty.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougefactionview_txtDifficultyTiitle"), RougeConfig1.instance:getDifficultyCOTitle(difficulty))

	local styleIndex = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(difficulty)
	local red = gohelper.findChild(self._godifficultytips, "red")
	local orange = gohelper.findChild(self._godifficultytips, "orange")
	local green = gohelper.findChild(self._godifficultytips, "green")

	gohelper.setActive(green, styleIndex == 1)
	gohelper.setActive(orange, styleIndex == 2)
	gohelper.setActive(red, styleIndex == 3)
end

function RougeInitTeamView:_initCapacity()
	self._maxCapacity = RougeModel.instance:getTeamCapacity()

	gohelper.setActive(self._gopoint, false)

	self._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, RougeCapacityComp)

	self._capacityComp:setMaxNum(self._maxCapacity)
	self._capacityComp:setPoint(self._gopoint)
	self._capacityComp:setTxt(self._txtnum)
	self._capacityComp:initCapacity()
	self._capacityComp:showChangeEffect(true)
end

function RougeInitTeamView:getCapacityProgress()
	return self._curCapacity, self._maxCapacity
end

function RougeInitTeamView:getNoneAssistCapacityProgress()
	return self._noneAssistCurCapacity, self._maxCapacity
end

function RougeInitTeamView:onOpenFinish()
	ViewMgr.instance:closeView(ViewName.RougeFactionView)
	self:_checkFocusCurView()
end

function RougeInitTeamView:_modifyHeroGroup()
	self._isModify = true

	self:_updateHeroList()

	self._isModify = false

	self:_checkHelpState()
end

function RougeInitTeamView:onClose()
	return
end

function RougeInitTeamView:onDestroyView()
	return
end

function RougeInitTeamView:_onCloseOtherView()
	self:_checkFocusCurView()
end

function RougeInitTeamView:_checkFocusCurView()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()
	local topViewName = openViewNameList[#openViewNameList]

	if topViewName == ViewName.RougeInitTeamView then
		RougeController.instance:dispatchEvent(RougeEvent.FocusOnView, "RougeInitTeamView")
	end
end

return RougeInitTeamView

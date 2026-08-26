-- chunkname: @modules/logic/dungeon/view/DungeonResChapterItem.lua

module("modules.logic.dungeon.view.DungeonResChapterItem", package.seeall)

local DungeonResChapterItem = class("DungeonResChapterItem", BaseChildView)

function DungeonResChapterItem:onInitView()
	self._anim = gohelper.findChild(self.viewGO, "anim"):GetComponent(typeof(UnityEngine.Animator))
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "anim/#simage_icon")
	self._golock = gohelper.findChild(self.viewGO, "anim/#go_lock")
	self._goopentime = gohelper.findChild(self.viewGO, "anim/#go_opentime")
	self._btnclick = gohelper.findChild(self.viewGO, "anim/#btn_click")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "anim/#txt_deadline")
	self._gospecialopen = gohelper.findChild(self.viewGO, "anim/#go_specialopen")
	self._goequipmap = gohelper.findChild(self.viewGO, "anim/#go_equipmap")
	self._imagefightcountbg = gohelper.findChildImage(self.viewGO, "anim/#go_equipmap/fightcount/txt/#image_fightcountbg")
	self._txtfightcount = gohelper.findChildText(self.viewGO, "anim/#go_equipmap/fightcount/txt/#txt_fightcount")
	self._gofightcountbg = gohelper.findChild(self.viewGO, "anim/#go_equipmap/fightcount/bg")
	self._goremainfightcountbg = gohelper.findChild(self.viewGO, "anim/#go_equipmap/fightcount/bg2")
	self._goTurnBackTip = gohelper.findChild(self.viewGO, "anim/turnback_tipsbg")
	self._txtTurnBackTip = gohelper.findChildText(self.viewGO, "anim/turnback_tipsbg/tips")
	self._goDoubleDropTip = gohelper.findChild(self.viewGO, "anim/#go_doubledroptip")
	self._gotripledroptip = gohelper.findChild(self.viewGO, "anim/#go_tripledroptip")
	self._txttripledropTip = gohelper.findChildText(self.viewGO, "anim/#go_tripledroptip/tips")
	self._gotrace = gohelper.findChild(self.viewGO, "anim/#go_trace")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonResChapterItem:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnClickDungeonCategory, self.replayEnterAnim, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.onUpdateParam, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.onUpdateParam, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, self.showDoubleDropTips, self)
	self.addEventCb(self, CruiseController.instance, CruiseEvent.RefreshTripleDropInfo, self.showMultiDropTips, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onUpdateParam, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonResChapterItem:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnClickDungeonCategory, self.replayEnterAnim, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.onUpdateParam, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.onUpdateParam, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, self.showDoubleDropTips, self)
	self.removeEventCb(self, CruiseController.instance, CruiseEvent.RefreshTripleDropInfo, self.showMultiDropTips, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

DungeonResChapterItem.AudioConfig = {
	[DungeonEnum.ChapterListType.Resource] = AudioEnum.UI.play_ui_checkpoint_sources_open,
	[DungeonEnum.ChapterListType.Insight] = AudioEnum.UI.UI_checkpoint_Insight_open
}

function DungeonResChapterItem:_btncategoryOnClick()
	if self._chapterCo.type == DungeonEnum.ChapterType.Gold then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GoldDungeon))

			return
		end
	elseif self._chapterCo.type == DungeonEnum.ChapterType.Exp then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ExperienceDungeon))

			return
		end
	elseif self._chapterCo.type == DungeonEnum.ChapterType.Buildings then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Buildings))

			return
		end
	elseif self._chapterCo.type == DungeonEnum.ChapterType.Equip and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.EquipDungeon))

		return
	end

	self:playAudio()

	if self._chapterCo.type == DungeonEnum.ChapterType.Break then
		if self._openTimeValid == false then
			GameFacade.showToast(ToastEnum.DungeonResChapter, self._chapterCo.name)

			return
		end
	elseif self._openTimeValid == false then
		GameFacade.showToast(ToastEnum.DungeonResChapter, self._chapterCo.name)

		return
	end

	DungeonModel.instance:changeCategory(self._chapterCo.type, false)

	local param = {}

	param.chapterId = DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId(self._chapterCo.id)

	DungeonController.instance:openDungeonChapterView(param)
end

function DungeonResChapterItem:playAudio()
	local isNormalType, isResourceType, isBreakType = DungeonModel.instance:getChapterListTypes()
	local audio

	AudioMgr.instance:trigger(isResourceType and DungeonResChapterItem.AudioConfig[DungeonEnum.ChapterListType.Resource] or isBreakType and DungeonResChapterItem.AudioConfig[DungeonEnum.ChapterListType.Insight] or DungeonResChapterItem.AudioConfig[DungeonEnum.ChapterListType.Resource])
end

function DungeonResChapterItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._btnclick.gameObject)
end

function DungeonResChapterItem:onOpen()
	self._click:AddClickListener(self._btncategoryOnClick, self)
	self:initItemEffect()
end

function DungeonResChapterItem:onClose()
	self._click:RemoveClickListener()
end

function DungeonResChapterItem:onUpdateParam()
	self._chapterCo = self.viewParam
	self._openTimeValid = true

	gohelper.setActive(self._golock, false)

	local hasOpenTime = LuaUtil.isEmptyStr(self._chapterCo.openDay) == false

	if self._chapterCo.id == DungeonEnum.EquipDungeonChapterId then
		hasOpenTime = false
	end

	self:showEquip(self._chapterCo)
	self:showMultiDropTips()
	self:showTurnBackAddition()
	self:showDoubleDropTips()
	gohelper.setActive(self._goopentime, hasOpenTime)
	gohelper.setActive(self._txtdeadline.gameObject, false)
	gohelper.setActive(self._gospecialopen, false)

	if hasOpenTime then
		self._openTimeValid = false

		local serverDay = ServerTime.weekDayInServerLocal()
		local dayList = GameUtil.splitString2(self._chapterCo.openDay, true, "|", "#")

		self._weekTextTab = self:getUserDataTb_()

		for i = 1, 4 do
			local o = self:getUserDataTb_()

			o.go = gohelper.findChild(self.viewGO, "anim/#go_opentime/everyweek/weekbg" .. tostring(i))
			o.txt = gohelper.findChildText(o.go, "#txt_week" .. tostring(i))
			self._weekTextTab[i] = o

			gohelper.setActive(self._weekTextTab[i].go, false)
		end

		for _, data in ipairs(dayList) do
			for i, v in ipairs(data) do
				local day = tonumber(v)

				gohelper.setActive(self._weekTextTab[i].go, true)

				self._weekTextTab[i].txt.text = TimeUtil.weekDayToLangStr(day)

				if day == serverDay then
					self._openTimeValid = true
				end
			end
		end

		if self._chapterCo.type == DungeonEnum.ChapterType.Break then
			if self._openTimeValid == false then
				gohelper.setActive(self._golock, true)
			end
		elseif self._openTimeValid == false then
			gohelper.setActive(self._golock, true)
		end
	end

	self:_showGoldEffect()
	self:setItemEffect()
	self:_refreshTraced()
end

function DungeonResChapterItem:_showGoldEffect()
	local haveRemaintime = DungeonModel.instance:getEquipRemainingNum() > 0

	gohelper.setActive(self._gofightcountbg, not haveRemaintime)
	gohelper.setActive(self._goremainfightcountbg, haveRemaintime)
end

function DungeonResChapterItem:initItemEffect()
	local itemIdTabs = {
		DungeonEnum.ChapterId.ResourceExp,
		DungeonEnum.ChapterId.ResourceGold,
		DungeonEnum.EquipDungeonChapterId,
		DungeonEnum.ChapterId.InsightMountain,
		DungeonEnum.ChapterId.InsightStarfall,
		DungeonEnum.ChapterId.InsightSylvanus,
		DungeonEnum.ChapterId.InsightBrutes,
		DungeonEnum.ChapterId.HarvestDungeonChapterId
	}

	self._itemEffectTabs = self:getUserDataTb_()

	for k, v in pairs(itemIdTabs) do
		local item = self:getUserDataTb_()

		item.id = v
		item.go = gohelper.findChild(self.viewGO, "anim/item_" .. itemIdTabs[k])
		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(item.go, false)
		table.insert(self._itemEffectTabs, item)
	end
end

function DungeonResChapterItem:setItemEffect()
	for k, v in pairs(self._itemEffectTabs) do
		if v.id == self._chapterCo.id then
			gohelper.setActive(v.go, true)
			self:setLockState(v.anim)
		else
			gohelper.setActive(v.go, false)
		end
	end
end

function DungeonResChapterItem:replayEnterAnim()
	self._anim:Play("dungeonreschapteritem_in", 0, 0)
end

function DungeonResChapterItem:showEquip(chapterCo)
	local enterAfterFreeLimit = chapterCo.enterAfterFreeLimit > 0

	gohelper.setActive(self._goequipmap, enterAfterFreeLimit)

	if not enterAfterFreeLimit then
		return
	end

	self._remainCount = DungeonModel.instance:getChapterRemainingNum(chapterCo.type)

	local countColor = self._remainCount == 0 and "#E25D34" or "#CC6230"

	self._txtfightcount.text = string.format("<color=%s>%s</color>", countColor, self._remainCount)

	SLFramework.UGUI.GuiHelper.SetColor(self._imagefightcountbg, countColor)
end

function DungeonResChapterItem:showTurnBackAddition()
	if self.isShowTriple then
		gohelper.setActive(self._goTurnBackTip, false)

		return
	end

	local isShowAddition = TurnbackModel.instance:isShowTurnBackAddition(self._chapterCo.id)

	if isShowAddition then
		local turnbackId = TurnbackModel.instance:getCurTurnbackId()
		local additionRate = TurnbackConfig.instance:getAdditionRate(turnbackId)
		local strRate = string.format("%s%%", additionRate / 10)

		self._txtTurnBackTip.text = formatLuaLang("turnback_addition", strRate)
	end

	gohelper.setActive(self._goTurnBackTip, isShowAddition)

	self.isShowAddition = isShowAddition
end

function DungeonResChapterItem:showDoubleDropTips()
	if self.isShowTriple or self.isShowAddition then
		gohelper.setActive(self._goDoubleDropTip, false)

		return
	end

	local isShowDouble = DoubleDropModel.instance:isShowDoubleByChapter(self._chapterCo.id, true)

	gohelper.setActive(self._goDoubleDropTip, isShowDouble)

	self.isShowDouble = isShowDouble
end

function DungeonResChapterItem:showMultiDropTips()
	local isMultiDrop, limit, total, magnification = Activity217Model.instance:getShowTripleByChapter(self._chapterCo.id)
	local multiDropShow = isMultiDrop and limit > 0

	if multiDropShow then
		local actName = Activity217Model.instance:getActName()

		magnification = magnification and magnification - 1 .. "00"
		self._txttripledropTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("doubleactivity_outtips"), actName, magnification)
	end

	gohelper.setActive(self._gotripledroptip, multiDropShow)

	self.isShowTriple = multiDropShow
end

function DungeonResChapterItem:setLockState(anim)
	if self._openTimeValid then
		anim:Play("item_in01", 0, 0)
	else
		anim:Play("item_in02", 0, 0)
	end
end

function DungeonResChapterItem:_refreshTraced()
	self:_refreshTracedIcon()
end

function DungeonResChapterItem:_refreshTracedIcon()
	if not self._chapterCo then
		return
	end

	if DungeonModel.instance:chapterIsLock(self._chapterCo.id) then
		return
	end

	local isTrade = CharacterRecommedModel.instance:isTradeChapter(self._chapterCo.id)

	if isTrade then
		local tradeIconPrefab = CharacterRecommedController.instance:getTradeIcon()

		if not tradeIconPrefab then
			return
		end

		self._tracedIcon = self._tracedIcon or gohelper.clone(tradeIconPrefab, self._gotrace)
	end

	if self._tracedIcon then
		gohelper.setActive(self._tracedIcon, isTrade)
	end
end

function DungeonResChapterItem:onDestroyView()
	return
end

return DungeonResChapterItem

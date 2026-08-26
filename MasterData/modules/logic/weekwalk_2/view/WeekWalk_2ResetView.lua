-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2ResetView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2ResetView", package.seeall)

local WeekWalk_2ResetView = class("WeekWalk_2ResetView", BaseView)

function WeekWalk_2ResetView:onInitView()
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#simage_line")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "levelinfo/#simage_bg")
	self._txtlevelname = gohelper.findChildText(self.viewGO, "levelinfo/#go_selectlevel/#txt_levelname")
	self._goempty = gohelper.findChild(self.viewGO, "levelinfo/#go_empty")
	self._gounselectlevel = gohelper.findChild(self.viewGO, "levelinfo/#go_unselectlevel")
	self._gounfinishlevel = gohelper.findChild(self.viewGO, "levelinfo/#go_unfinishlevel")
	self._gorevive = gohelper.findChild(self.viewGO, "levelinfo/#go_revive")
	self._goroles = gohelper.findChild(self.viewGO, "levelinfo/#go_roles")
	self._goheroitem = gohelper.findChild(self.viewGO, "levelinfo/#go_roles/#go_heroitem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "levelinfo/#btn_reset")
	self._goselectlevel = gohelper.findChild(self.viewGO, "levelinfo/#go_selectlevel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2ResetView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function WeekWalk_2ResetView:removeEvents()
	self._btnreset:RemoveClickListener()
end

function WeekWalk_2ResetView:_btnresetOnClick()
	if not self._selectedBattleItem then
		return
	end

	local battleInfo = self._selectedBattleItem:getBattleInfo()

	if battleInfo.star <= 0 then
		return
	end

	local prevBattleId = 0

	for i, v in ipairs(self._battleItemList) do
		local isSelected = v == self._selectedBattleItem

		prevBattleId = v:getBattleInfo().battleId

		if isSelected then
			break
		end
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkResetLayerBattle, MsgBoxEnum.BoxType.Yes_No, function()
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ResetLayerRequest(self._mapId, prevBattleId, self.closeThis, self)
	end, nil, nil, nil, nil, nil, self:_getBattleName())
end

function WeekWalk_2ResetView:_editableInitView()
	gohelper.addUIClickAudio(self._btnreset.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)

	self._resetBtnCanvasGroup = gohelper.onceAddComponent(self._btnreset.gameObject, typeof(UnityEngine.CanvasGroup))
	self._mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	self._sceneConfig = self._mapInfo.sceneConfig
	self._mapId = self._mapInfo.id
	self._heroItemList = nil

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("dreamrewardbg.png"))
	self._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))

	self._needShowHeros = true

	gohelper.setActive(self._gorevive, self._needShowHeros)
	gohelper.setActive(self._goempty, not self._needShowHeros)

	if self._needShowHeros then
		self:_showHeros()
	end

	self:_showBattleList()
	self:_initFinishStatus()
	self:_showCurLevel()
end

function WeekWalk_2ResetView:_showCurLevel()
	local index = 1
	local battleInfos = self._mapInfo.battleInfos

	for i, v in ipairs(battleInfos) do
		index = i

		if v.star <= 0 then
			break
		end
	end
end

function WeekWalk_2ResetView:_initFinishStatus()
	gohelper.setActive(self._goselectlevel, false)

	local hasStarIndex = self._mapInfo:getHasStarIndex()

	self._resetBtnCanvasGroup.alpha = 0.3

	if hasStarIndex <= 0 then
		gohelper.setActive(self._gounfinishlevel, true)

		return
	end

	gohelper.setActive(self._gounselectlevel, true)
end

function WeekWalk_2ResetView:_showBattleList()
	self._battleItemList = self:getUserDataTb_()

	local battleInfos = self._mapInfo.battleInfos

	for i, v in ipairs(battleInfos) do
		local itemPath = self.viewContainer:getSetting().otherRes[1]
		local itemGo = self:getResInst(itemPath, self._goprogress)
		local battleItem = MonoHelper.addLuaComOnceToGo(itemGo, WeekWalk_2ResetBattleItem, {
			self,
			v,
			i,
			battleInfos
		})

		table.insert(self._battleItemList, battleItem)
	end
end

function WeekWalk_2ResetView:selectBattleItem(battleItem)
	if self._selectedBattleItem == battleItem then
		self._selectedBattleItem = nil
	else
		self._selectedBattleItem = battleItem
	end

	local selectedIndex

	for i, v in ipairs(self._battleItemList) do
		local isSelected = v == self._selectedBattleItem

		if isSelected then
			selectedIndex = i

			self:_showSelectBattleInfo(battleItem, i)
		end

		v:setSelect(isSelected)
		v:setFakedReset(selectedIndex, isSelected)
	end

	gohelper.setActive(self._gounselectlevel, not self._selectedBattleItem)

	if self._needShowHeros then
		self:_showHeros()
	end

	if not self._selectedBattleItem then
		self._resetBtnCanvasGroup.alpha = 0.3

		gohelper.setActive(self._goselectlevel, false)
	end
end

function WeekWalk_2ResetView:_showSelectBattleInfo(battleItem, index)
	self._battleIndex = index

	gohelper.setActive(self._goselectlevel, true)

	self._txtlevelname.text = self:_getBattleName()

	gohelper.setActive(self._gounselectlevel, false)

	self._resetBtnCanvasGroup.alpha = 1

	if self._needShowHeros then
		self:_showHeros()
	end
end

function WeekWalk_2ResetView:_showHeros()
	if not self._heroItemList then
		self._heroItemList = self:getUserDataTb_()

		for i = 1, 4 do
			local go = gohelper.cloneInPlace(self._goheroitem)

			gohelper.setActive(go, true)

			local t = self:getUserDataTb_()

			t._goempty = gohelper.findChild(go, "go_empty")
			t._gohero = gohelper.findChild(go, "go_hero")
			t._simageheroicon = gohelper.findChildSingleImage(go, "go_hero/simage_heroicon")
			t._imagecareer = gohelper.findChildImage(go, "go_hero/image_career")
			self._heroItemList[i] = t
		end
	end

	if self._selectedBattleItem then
		local battleInfo = self._selectedBattleItem:getPrevBattleInfo()
		local heroIds = battleInfo and battleInfo.heroIds

		for i, v in ipairs(self._heroItemList) do
			local heroId = heroIds and heroIds[i]
			local t = self._heroItemList[i]

			gohelper.setActive(t._goempty, not heroId)
			gohelper.setActive(t._gohero, heroId)

			if heroId then
				local heroConfig = HeroConfig.instance:getHeroCO(heroId)
				local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

				t._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
				UISpriteSetMgr.instance:setCommonSprite(t._imagecareer, "lssx_" .. heroConfig.career)
			end
		end
	end
end

function WeekWalk_2ResetView:_getBattleName()
	return string.format("%s-0%s", self._sceneConfig.battleName, self._battleIndex)
end

function WeekWalk_2ResetView:onOpen()
	return
end

function WeekWalk_2ResetView:onClose()
	return
end

function WeekWalk_2ResetView:onDestroyView()
	if self._heroItemList then
		for i, v in ipairs(self._heroItemList) do
			v._simageheroicon:UnLoadImage()
		end
	end

	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
end

return WeekWalk_2ResetView

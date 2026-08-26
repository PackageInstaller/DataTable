-- chunkname: @modules/logic/weekwalk/view/WeekWalkEnemyInfoView.lua

module("modules.logic.weekwalk.view.WeekWalkEnemyInfoView", package.seeall)

local WeekWalkEnemyInfoView = class("WeekWalkEnemyInfoView", BaseView)

function WeekWalkEnemyInfoView:onOpen()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagebattlelistbg = gohelper.findChildSingleImage(self.viewGO, "go_battlelist/#simage_battlelistbg")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "go_battlelist/#btn_reset", AudioEnum.WeekWalk.play_artificial_ui_resetmap)
	self._mapId = self.viewParam.mapId

	self._simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))

	local info = WeekWalkModel.instance:getInfo()
	local mapInfo = info:getMapInfo(self._mapId)
	local battleIds = mapInfo.battleIds

	self.viewParam.battleId = self.viewParam.battleId or battleIds[1]
	self._battleIds = battleIds
	self._mapConfig = WeekWalkConfig.instance:getMapConfig(self._mapId)

	local typeConfig = lua_weekwalk_type.configDict[self._mapConfig.type]

	if typeConfig.showDetail <= 0 and mapInfo.isFinish <= 0 then
		gohelper.setActive(self._btnreset.gameObject, false)
		gohelper.setActive(gohelper.findChild(self.viewGO, "go_battlelist"), false)
		self:_doUpdateSelectIcon(self.viewParam.battleId)

		return
	end

	self._gobattlebtntemplate = gohelper.findChild(self.viewGO, "go_battlelist/scroll_battle/Viewport/battlelist/#go_battlebtntemplate")
	self._btnList = self:getUserDataTb_()
	self._statusList = self:getUserDataTb_()

	local showIndex = 5

	showIndex = math.min(showIndex, #mapInfo.battleInfos)

	local mapMaxStarNum = mapInfo:getStarNumConfig()

	for i = 1, showIndex do
		local container = gohelper.cloneInPlace(self._gobattlebtntemplate)
		local go = container.gameObject
		local btn = gohelper.findChildButton(go, "btn")
		local txt = gohelper.findChildText(go, "txt")
		local selectIcon = gohelper.findChild(go, "selectIcon")

		txt.text = "0" .. i

		local battleId = battleIds[i]
		local battleInfo = mapInfo:getBattleInfo(battleId)
		local starGo2 = gohelper.findChild(go, "star2")
		local starGo3 = gohelper.findChild(go, "star3")
		local starGo = mapMaxStarNum <= 2 and starGo2 or starGo3

		gohelper.setActive(starGo2, false)
		gohelper.setActive(starGo3, false)
		gohelper.setActive(starGo, true)

		local transform = starGo.transform
		local itemCount = transform.childCount
		local statusTable = {
			selectIcon,
			txt
		}

		for index = 1, itemCount do
			local child = transform:GetChild(index - 1)
			local image = child:GetComponentInChildren(gohelper.Type_Image)

			UISpriteSetMgr.instance:setWeekWalkSprite(image, index <= battleInfo.star and "star_highlight4" or "star_null4", true)
			table.insert(statusTable, image)
		end

		btn:AddClickListener(self._changeBattleId, self, battleId)
		gohelper.addUIClickAudio(btn.gameObject, AudioEnum.WeekWalk.play_artificial_ui_checkpointswitch)
		gohelper.setActive(go, true)
		table.insert(self._statusList, statusTable)
		table.insert(self._btnList, btn)
	end

	self._btnreset:AddClickListener(self._reset, self)

	local mapTypeConfig = WeekWalkConfig.instance:getMapTypeConfig(self._mapId)
	local showReset = mapTypeConfig.canResetLayer > 0 and ViewMgr.instance:isOpen(ViewName.WeekWalkView)
	local hideResetBtn = self.viewParam.hideResetBtn

	if hideResetBtn then
		showReset = false
	end

	gohelper.setActive(self._btnreset.gameObject, showReset and false)

	if showReset then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShowResetBtn)
	end

	self:_doUpdateSelectIcon(self.viewParam.battleId)
end

function WeekWalkEnemyInfoView:_reset()
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkResetLayer, MsgBoxEnum.BoxType.Yes_No, function()
		WeekwalkRpc.instance:sendResetLayerRequest(self._mapId)
		self:closeThis()
	end)
end

function WeekWalkEnemyInfoView:_changeBattleId(battleId)
	if not battleId then
		return
	end

	local infoView = self.viewContainer:getEnemyInfoView()

	infoView._battleId = battleId

	infoView:_refreshUI()
	self:_updateSelectIcon()
end

function WeekWalkEnemyInfoView:_updateSelectIcon()
	local infoView = self.viewContainer:getEnemyInfoView()

	self:_doUpdateSelectIcon(infoView._battleId)
end

function WeekWalkEnemyInfoView:_doUpdateSelectIcon(battleId)
	local ruleView = self.viewContainer:getWeekWalkEnemyInfoViewRule()

	ruleView:refreshUI(battleId)

	if not self._statusList then
		return
	end

	for i, v in ipairs(self._battleIds) do
		local isSelected = v == battleId
		local t = self._statusList[i]

		if not t then
			break
		end

		gohelper.setActive(t[1], isSelected)

		if isSelected then
			SLFramework.UGUI.GuiHelper.SetColor(t[2], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(t[3], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(t[4], "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(t[2], "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(t[3], "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(t[4], "#C1C5B6")
		end

		if t[5] then
			SLFramework.UGUI.GuiHelper.SetColor(t[5], isSelected and "#FFFFFF" or "#C1C5B6")
		end
	end
end

function WeekWalkEnemyInfoView:onDestroyView()
	WeekWalkEnemyInfoView.super.onDestroyView(self)

	if self._btnList then
		for i, v in ipairs(self._btnList) do
			v:RemoveClickListener()
		end
	end

	self._btnreset:RemoveClickListener()
	self._simagebattlelistbg:UnLoadImage()
end

return WeekWalkEnemyInfoView

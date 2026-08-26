-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotDifficultyView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotDifficultyView", package.seeall)

local V1a6_CachotDifficultyView = class("V1a6_CachotDifficultyView", BaseView)

function V1a6_CachotDifficultyView:onInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goredmask = gohelper.findChild(self.viewGO, "redmask")
	self._maskanimator = self._goredmask:GetComponent(typeof(UnityEngine.Animator))
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gotipswindow = gohelper.findChild(self.viewGO, "#go_tipswindow")
	self._txtlevelname = gohelper.findChildText(self.viewGO, "#go_tipswindow/bg/#txt_levelname")
	self._gonext = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_next")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tipswindow/#go_next/#btn_next")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_tipswindow/#scroll_view")
	self._golevel = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_level")
	self._scrolllevel = gohelper.findChildScrollRect(self.viewGO, "#go_tipswindow/#go_level/#scroll_level")
	self._golevelContent = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content")
	self._golevelitem = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content/#go_item")
	self._btnup = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tipswindow/#go_level/#btn_up")
	self._btndown = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tipswindow/#go_level/#btn_down")
	self._gopreview = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_preview")
	self._simageleft = gohelper.findChildSingleImage(self.viewGO, "#simage_left")
	self._txtname = gohelper.findChildText(self.viewGO, "#simage_left/#txt_name")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._levelItemObjects = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotDifficultyView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnup:AddClickListener(self._btnupOnClick, self)
	self._btndown:AddClickListener(self._btndownOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotDifficultyView:removeEvents()
	self._btnnext:RemoveClickListener()
	self._btnup:RemoveClickListener()
	self._btndown:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotDifficultyView:_btncloseOnClick()
	self:closeThis()
	V1a6_CachotController.instance:openV1a6_CachotMainView()
end

function V1a6_CachotDifficultyView:_btnnextOnClick()
	if not self._currentSelectLevel then
		logError("V1a6_CachotDifficultyView selectlevel is nil")

		return
	end

	PlayerPrefsHelper.setNumber(self:_getPlayerPrefKeyDifficulty(), self._currentSelectLevel)
	V1a6_CachotController.instance:openV1a6_CachotTeamView({
		isInitSelect = true,
		selectLevel = self._currentSelectLevel
	})
end

function V1a6_CachotDifficultyView:_getPlayerPrefKeyDifficulty()
	return PlayerPrefsKey.Version1_6V1a6_CachotDifficulty .. PlayerModel.instance:getPlayinfo().userId
end

function V1a6_CachotDifficultyView:_btnupOnClick()
	local canMove = self:_btnClick(true)

	if canMove then
		self._animator:Update(0)
		self._animator:Play("down", 0, 0)
	end
end

function V1a6_CachotDifficultyView:_btndownOnClick()
	local canMove = self:_btnClick(false)

	if canMove then
		self._animator:Update(0)
		self._animator:Play("up", 0, 0)
	end
end

function V1a6_CachotDifficultyView:_btnClick(isUp)
	local difficulty

	self._lastSelectLevel = self._currentSelectLevel

	if isUp then
		difficulty = self._currentSelectLevel - 1 <= 0 and 1 or self._currentSelectLevel - 1
	else
		difficulty = self._currentSelectLevel + 1 >= self._levelCount and self._levelCount or self._currentSelectLevel + 1

		if not self:_checkDifficultyUnlock(difficulty) then
			GameFacade.showToast(ToastEnum.V1a6CachotToast01)

			return false
		end
	end

	if self._currentSelectLevel == difficulty then
		return
	end

	self._currentSelectLevel = difficulty
	self._selectIndex = isUp and (self._selectIndex == self._selectIndex and 1 or 2) or self._selectIndex == self._selectIndex and 2 or 1

	self:_refreshItem(isUp)

	self.currentmask = self:_getTargetMask(self._lastSelectLevel)
	self.nextmask = self:_getTargetMask(self._currentSelectLevel)

	self:_playMaskAnimation()

	return true
end

function V1a6_CachotDifficultyView:_editableInitView()
	for i = 1, 2 do
		self:_createLevelItem(i)
	end

	self._selectIndex = 1
end

function V1a6_CachotDifficultyView:onOpen()
	self._currentSelectLevel = PlayerPrefsHelper.getNumber(self:_getPlayerPrefKeyDifficulty(), 1)
	self._levelCount = V1a6_CachotConfig.instance:getDifficultyCount()
	self.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()
	self.unlocklevelcount = #self.stateMo.passDifficulty
	self._unlockCoList = {}

	for key, value in pairs(lua_rogue_difficulty.configList) do
		if self.unlocklevelcount >= value.preDifficulty then
			table.insert(self._unlockCoList, value)
		end
	end

	if self._currentSelectLevel > #self._unlockCoList then
		self._currentSelectLevel = #self._unlockCoList
	end

	self:_refreshItem()
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotDifficultyView, self._btncloseOnClick, self)
	self._animator:Play("open", 0, 0)
	self._animator:Update(0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_preparation_open)

	self.currentmask = self:_getTargetMask(self._currentSelectLevel)

	self:_playMaskAnimation()
end

function V1a6_CachotDifficultyView:onOpenFinish()
	local scrollList = self.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.ScrollRect), true)

	if scrollList then
		local iter = scrollList:GetEnumerator()

		while iter:MoveNext() do
			local scroll = iter.Current

			scroll.scrollSensitivity = 0
		end
	end
end

function V1a6_CachotDifficultyView:_createLevelItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.findChild(self.viewGO, "#go_tipswindow/#go_level/#scroll_level/Viewport/Content/#go_item" .. index)

	item.go = itemGo
	item.termitem = gohelper.findChild(itemGo, "main/#go_termitem")
	item.levelname = gohelper.findChildText(itemGo, "main/#go_termitem/#txt_levelname")
	item.content = gohelper.findChild(itemGo, "main/#go_termitem/#scroll_term/Viewport/Content")
	item.termcontent = gohelper.findChild(itemGo, "main/#go_termitem/#scroll_term/Viewport/Content/termcontent")
	item.gotermnode = gohelper.findChild(itemGo, "main/#go_termitem/#scroll_term/Viewport/Content/termcontent/termnode")
	item.txtenemy = gohelper.findChildText(item.content, "topnode/enemy/txt")
	item.txtscoreadd = gohelper.findChildText(item.content, "topnode/scoreadd/txt")
	item.golevel = gohelper.findChild(itemGo, "main/#go_level")
	item.difficulty = gohelper.findChildText(itemGo, "main/#go_level/#txt_level")
	item._gouptitle = gohelper.findChild(itemGo, "#go_uptitle")
	item._txtuptitle = gohelper.findChildText(itemGo, "#go_uptitle/node/#txt_term")
	item._txtuplevel = gohelper.findChildText(itemGo, "#go_uptitle/#txt_level")
	item._godowntitle = gohelper.findChild(itemGo, "#go_downtitle")
	item._txtdowntitle = gohelper.findChildText(itemGo, "#go_downtitle/node/#txt_term")
	item._txtdownlevel = gohelper.findChildText(itemGo, "#go_downtitle/#txt_level")
	item.transform = itemGo.transform

	gohelper.setActive(itemGo, true)
	table.insert(self._levelItemObjects, item)
end

function V1a6_CachotDifficultyView:_refreshItem(isUp)
	local selectCo = V1a6_CachotConfig.instance:getDifficultyConfig(self._currentSelectLevel)
	local selectItem = self._levelItemObjects[self._selectIndex]

	self:_refreshItemContent(selectItem, selectCo)

	local isFirst = self._currentSelectLevel == 1
	local isLast = self._currentSelectLevel == self._levelCount

	if self._currentSelectLevel - 1 > 0 then
		local beforeco = V1a6_CachotConfig.instance:getDifficultyConfig(self._currentSelectLevel - 1)

		selectItem._txtuptitle.text = beforeco.title
		selectItem._txtuplevel.text = beforeco.difficulty
	end

	if self._currentSelectLevel + 1 <= self._levelCount then
		local nextco = V1a6_CachotConfig.instance:getDifficultyConfig(self._currentSelectLevel + 1)

		selectItem._txtdowntitle.text = nextco.title
		selectItem._txtdownlevel.text = nextco.difficulty
	end

	gohelper.setActive(selectItem._gouptitle, not isFirst)
	gohelper.setActive(self._btnup, not isFirst)
	gohelper.setActive(selectItem._godowntitle, not isLast)
	gohelper.setActive(self._btndown, not isLast)

	self._btndowncanvasGroup = gohelper.onceAddComponent(self._btndown.gameObject, gohelper.Type_CanvasGroup)
	self._godowntitlecanvasGroup = gohelper.onceAddComponent(selectItem._godowntitle, gohelper.Type_CanvasGroup)
	self._btndowncanvasGroup.alpha = not isLast and not self:_checkDifficultyUnlock(self._currentSelectLevel + 1) and 0.3 or 1
	self._godowntitlecanvasGroup.alpha = not isLast and not self:_checkDifficultyUnlock(self._currentSelectLevel + 1) and 0.3 or 1

	if self._lastSelectLevel then
		local selectCo = V1a6_CachotConfig.instance:getDifficultyConfig(self._lastSelectLevel)
		local selectIndex = isUp and (self._selectIndex == self._selectIndex and 2 or 1) or self._selectIndex == self._selectIndex and 1 or 2
		local selectItem = self._levelItemObjects[selectIndex]

		self:_refreshItemContent(selectItem, selectCo)
	end
end

function V1a6_CachotDifficultyView:_refreshItemContent(item, co)
	item.co = co
	item.termco = {}

	table.insert(item.termco, co.initHeroCount)

	if not string.nilorempty(co.effectDesc1) then
		table.insert(item.termco, co.effectDesc1)
	end

	if not string.nilorempty(co.effectDesc2) then
		table.insert(item.termco, co.effectDesc2)
	end

	if not string.nilorempty(co.effectDesc3) then
		table.insert(item.termco, co.effectDesc3)
	end

	item.difficulty.text = co.difficulty
	item.levelname.text = co.title
	item.txtenemy.text = "Lv." .. co.showDifficulty
	item.txtscoreadd.text = formatLuaLang("cachotdifficulty_scoreadd", co.scoreAdd / 10) .. "%"

	gohelper.CreateObjList(self, self._onItemShow, item.termco, item.termcontent, item.gotermnode)
end

function V1a6_CachotDifficultyView:_onItemShow(obj, data, index)
	local transform = obj.transform
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local num = transform:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local desc = string.split(data, "|")

	if index == 1 then
		name.text = luaLang("cachotdifficulty_originrole")
		num.text = desc[1]
	else
		if string.nilorempty(desc[2]) then
			gohelper.setActive(num.gameObject, false)
		else
			gohelper.setActive(num.gameObject, true)
		end

		name.text = desc[1]
		num.text = desc[2]
	end
end

function V1a6_CachotDifficultyView:_reallyRefreshView()
	if self._currentSelectLevel then
		for i, v in ipairs(self._levelItemObjects) do
			local isCurrentSelectLevel = self._currentSelectLevel == i

			self:_refreshItem(v, isCurrentSelectLevel)
		end
	end
end

function V1a6_CachotDifficultyView:_checkDifficultyUnlock(difficulty)
	if difficulty <= #self._unlockCoList then
		return true
	end

	return false
end

function V1a6_CachotDifficultyView:_playMaskAnimation()
	if not self.currentmask then
		return
	end

	local animName

	if not self.nextmask and self.currentmask then
		animName = "level" .. self.currentmask

		self._maskanimator:Update(0)
		self._maskanimator:Play(animName, 0, 0)
	elseif self.currentmask and self.nextmask then
		animName = "level" .. self.currentmask .. "to" .. self.nextmask

		self._maskanimator:Update(0)
		self._maskanimator:Play(animName, 0, 0)

		local info = self._maskanimator:GetCurrentAnimatorStateInfo(0)
		local duration = info.length

		TaskDispatcher.runDelay(self._switchAnimFinish, self, duration)
	end
end

function V1a6_CachotDifficultyView:_switchAnimFinish()
	TaskDispatcher.cancelTask(self._switchAnimFinish, self)

	local animName = "level" .. self.nextmask

	self._maskanimator:Update(0)
	self._maskanimator:Play(animName, 0, 0)

	self.currentmask = self.nextmask
	self.nextmask = nil
end

function V1a6_CachotDifficultyView:_getTargetMask(level)
	if level == 1 then
		return 1
	elseif level == 2 then
		return 2
	elseif level >= 3 then
		return 3
	end
end

function V1a6_CachotDifficultyView:onClose()
	TaskDispatcher.cancelTask(self._switchAnimFinish, self)
end

function V1a6_CachotDifficultyView:onDestroyView()
	return
end

return V1a6_CachotDifficultyView

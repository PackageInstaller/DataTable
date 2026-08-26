-- chunkname: @modules/logic/season/view3_0/Season3_0SpecialMarketShowLevelItem.lua

module("modules.logic.season.view3_0.Season3_0SpecialMarketShowLevelItem", package.seeall)

local Season3_0SpecialMarketShowLevelItem = class("Season3_0SpecialMarketShowLevelItem", LuaCompBase)

function Season3_0SpecialMarketShowLevelItem:init(go)
	self.go = go
	self.transform = go.transform
	self._goline = gohelper.findChild(go, "#go_line")
	self._goselectedpass = gohelper.findChild(go, "#go_selectedpass")
	self._txtselectpassindex = gohelper.findChildText(go, "#go_selectedpass/#txt_selectpassindex")
	self._goselectedunpass = gohelper.findChild(go, "#go_selectedunpass")
	self._txtselectunpassindex = gohelper.findChildText(go, "#go_selectedunpass/#txt_selectunpassindex")
	self._gopass = gohelper.findChild(go, "#go_pass")
	self._txtpassindex = gohelper.findChildText(go, "#go_pass/#txt_passindex")
	self._gounpass = gohelper.findChild(go, "#go_unpass")
	self._txtunpassindex = gohelper.findChildText(go, "#go_unpass/#txt_unpassindex")
	self._golock = gohelper.findChild(go, "#go_lock")
	self._txtlockindex = gohelper.findChildText(go, "#go_lock/#txt_lockindex")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "#btn_click")

	self._btnClick:AddClickListener(self._btnOnClick, self)
end

function Season3_0SpecialMarketShowLevelItem:_btnOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local isOpen, remainTime = Activity104Model.instance:isSpecialLayerOpen(actId, self.index)

	if not isOpen then
		local day = math.ceil(remainTime / TimeUtil.OneDaySecond)
		local msg = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_unlockHardEpisodeTime"), day)

		GameFacade.showToastString(msg)

		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSpecialEpisode, self.index)
end

function Season3_0SpecialMarketShowLevelItem:reset(index, targetIndex, maxSpecialLayer)
	self.index = index
	self.targetIndex = targetIndex
	self.maxSpecialLayer = maxSpecialLayer

	self:_refreshItem()
end

function Season3_0SpecialMarketShowLevelItem:_refreshItem()
	gohelper.setActive(self.go, true)

	local actId = Activity104Model.instance:getCurSeasonId()
	local isOpen = Activity104Model.instance:isSpecialLayerOpen(actId, self.index)

	gohelper.setActive(self._golock, not isOpen)

	if isOpen then
		local pass = Activity104Model.instance:isSpecialLayerPassed(self.index)
		local isSelect = self.targetIndex == self.index

		gohelper.setActive(self._gopass, pass and not isSelect)
		gohelper.setActive(self._gounpass, not pass and not isSelect)
		gohelper.setActive(self._goselectedpass, pass and isSelect)
		gohelper.setActive(self._goselectedunpass, not pass and isSelect)
	else
		gohelper.setActive(self._gopass, false)
		gohelper.setActive(self._gounpass, false)
		gohelper.setActive(self._goselectedpass, false)
		gohelper.setActive(self._goselectedunpass, false)
	end

	gohelper.setActive(self._goline, self.index < self.maxSpecialLayer)

	local indexStr = string.format("%02d", self.index)

	self._txtselectpassindex.text = indexStr
	self._txtselectunpassindex.text = indexStr
	self._txtpassindex.text = indexStr
	self._txtunpassindex.text = indexStr
	self._txtlockindex.text = indexStr
end

function Season3_0SpecialMarketShowLevelItem:destroy()
	self._btnClick:RemoveClickListener()
end

return Season3_0SpecialMarketShowLevelItem

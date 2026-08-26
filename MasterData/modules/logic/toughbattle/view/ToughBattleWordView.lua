-- chunkname: @modules/logic/toughbattle/view/ToughBattleWordView.lua

module("modules.logic.toughbattle.view.ToughBattleWordView", package.seeall)

local ToughBattleWordView = class("ToughBattleWordView", BaseView)

function ToughBattleWordView:onInitView()
	self._root = gohelper.findChild(self.viewGO, "root/#go_words")
	self._item = gohelper.findChild(self.viewGO, "root/#go_words/item")
end

function ToughBattleWordView:onOpen()
	self._wordRes = self:getResInst(self.viewContainer._viewSetting.otherRes.word, self._root)

	gohelper.setActive(self._item, false)
	gohelper.setActive(self._wordRes, false)
	TaskDispatcher.runRepeat(self._createWord, self, ToughBattleEnum.WordInterval, -1)
	self:_createWord()
end

function ToughBattleWordView:_createWord()
	if not self._nowPosIndex then
		self._nowPosIndex = math.random(1, #ToughBattleEnum.WordPlace)
	else
		local posIndex = math.random(1, #ToughBattleEnum.WordPlace - 1)

		if posIndex >= self._nowPosIndex then
			posIndex = posIndex + 1
		end

		self._nowPosIndex = posIndex
	end

	self._coIndexSort = self._coIndexSort or {}

	if self._coIndexSort[1] then
		self._nowCoIndex = table.remove(self._coIndexSort, 1)
	else
		for i = 1, #lua_siege_battle_word.configList do
			self._coIndexSort[i] = i
		end

		self._coIndexSort = GameUtil.randomTable(self._coIndexSort)
		self._nowCoIndex = self._nowCoIndex == self._coIndexSort[1] and table.remove(self._coIndexSort, 2) or table.remove(self._coIndexSort, 1)
	end

	local cloneGo = gohelper.cloneInPlace(self._item)

	gohelper.setActive(cloneGo, true)

	local pos = ToughBattleEnum.WordPlace[self._nowPosIndex]

	recthelper.setAnchor(cloneGo.transform, pos.x, pos.y)
	MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, ToughBattleWordComp, {
		co = lua_siege_battle_word.configList[self._nowCoIndex],
		res = self._wordRes
	})
end

function ToughBattleWordView:onClose()
	TaskDispatcher.cancelTask(self._createWord, self)
end

return ToughBattleWordView

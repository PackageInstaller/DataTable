-- chunkname: @modules/logic/seasonver/act166/view/Season166WordEffectView.lua

module("modules.logic.seasonver.act166.view.Season166WordEffectView", package.seeall)

local Season166WordEffectView = class("Season166WordEffectView", BaseView)

function Season166WordEffectView:onInitView()
	self.content = gohelper.findChild(self.viewGO, "#go_wordEffectContent")
end

function Season166WordEffectView:onOpen()
	self.wordContentGO = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self.content)
	self.wordEffect = self:getResInst(self.viewContainer._viewSetting.otherRes[2], self.wordContentGO)
	self.viewType = self.viewParam.viewType
	self.actId = self.viewParam.actId

	gohelper.setActive(self.wordContentGO, false)
	gohelper.setActive(self.wordEffect, false)

	self.wordEffectConfigList = Season166Config.instance:getSeasonWordEffectConfigList(self.viewParam.actId, self.viewType)

	TaskDispatcher.runRepeat(self._createWord, self, Season166Enum.WordInterval, -1)
	self:_createWord()
end

function Season166WordEffectView:_createWord()
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_aekn_piaozi)

	if not self._nowPosIndex then
		self._nowPosIndex = math.random(1, #self.wordEffectConfigList)
	else
		local posIndex = math.random(1, #self.wordEffectConfigList - 1)

		if posIndex >= self._nowPosIndex then
			posIndex = posIndex + 1
		end

		self._nowPosIndex = posIndex
	end

	self._coIndexSort = self._coIndexSort or {}

	if self._coIndexSort[1] then
		self._nowCoIndex = table.remove(self._coIndexSort, 1)
	else
		for i = 1, #self.wordEffectConfigList do
			self._coIndexSort[i] = i
		end

		self._coIndexSort = GameUtil.randomTable(self._coIndexSort)
		self._nowCoIndex = self._nowCoIndex == self._coIndexSort[1] and table.remove(self._coIndexSort, 2) or table.remove(self._coIndexSort, 1)
	end

	local cloneGo = gohelper.cloneInPlace(self.wordContentGO)

	gohelper.setActive(cloneGo, true)

	local wordEffectCofig = self.wordEffectConfigList[self._nowCoIndex]
	local wordEffectPosConfig = Season166Config.instance:getSeasonWordEffectPosConfig(self.actId, wordEffectCofig.id)
	local pos = string.splitToNumber(wordEffectPosConfig.pos, "#")

	recthelper.setAnchor(cloneGo.transform, pos[1], pos[2])
	MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Season166WordEffectComp, {
		co = wordEffectCofig,
		res = self.wordEffect
	})
end

function Season166WordEffectView:onClose()
	TaskDispatcher.cancelTask(self._createWord, self)
end

return Season166WordEffectView

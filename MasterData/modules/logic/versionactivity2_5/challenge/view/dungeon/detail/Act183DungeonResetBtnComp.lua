-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonResetBtnComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonResetBtnComp", package.seeall)

local Act183DungeonResetBtnComp = class("Act183DungeonResetBtnComp", Act183DungeonBaseComp)

function Act183DungeonResetBtnComp:init(go)
	Act183DungeonResetBtnComp.super.init(self, go)

	self._btnresetepisode = gohelper.getClickWithDefaultAudio(self.go)
end

function Act183DungeonResetBtnComp:addEventListeners()
	self._btnresetepisode:AddClickListener(self._btnresetepisodeOnClick, self)
end

function Act183DungeonResetBtnComp:removeEventListeners()
	self._btnresetepisode:RemoveClickListener()
end

function Act183DungeonResetBtnComp:updateInfo(episodeMo)
	Act183DungeonResetBtnComp.super.updateInfo(self, episodeMo)

	self._isCanReset = self._groupEpisodeMo:isEpisodeCanReset(self._episodeId)
end

function Act183DungeonResetBtnComp:_btnresetepisodeOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetEpisode, MsgBoxEnum.BoxType.Yes_No, self._startResetEpisode, nil, nil, self)
end

function Act183DungeonResetBtnComp:_startResetEpisode()
	Act183Controller.instance:resetEpisode(self._activityId, self._episodeId)
end

function Act183DungeonResetBtnComp:checkIsVisible()
	return self._isCanReset
end

function Act183DungeonResetBtnComp:show()
	Act183DungeonResetBtnComp.super.show(self)
end

function Act183DungeonResetBtnComp:onDestroy()
	Act183DungeonResetBtnComp.super.onDestroy(self)
end

return Act183DungeonResetBtnComp

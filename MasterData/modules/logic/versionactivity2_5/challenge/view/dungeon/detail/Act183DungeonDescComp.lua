-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonDescComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonDescComp", package.seeall)

local Act183DungeonDescComp = class("Act183DungeonDescComp", Act183DungeonBaseComp)

function Act183DungeonDescComp:init(go)
	Act183DungeonDescComp.super.init(self, go)

	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._gohard = gohelper.findChild(self.go, "#go_hard")
	self._txttitle = gohelper.findChildText(self.go, "title/#txt_title")
	self._godone = gohelper.findChild(self.go, "title/#go_done")
	self._txtdesc = gohelper.findChildText(self.go, "#scroll_detail/Viewport/Content/top/#txt_desc")
	self._btninfo = gohelper.findChildButtonWithAudio(self.go, "title/#btn_Info")
	self._gotop = gohelper.findChild(self.go, "#scroll_detail/Viewport/Content/top")
	self._topTran = self._gotop.transform
end

function Act183DungeonDescComp:addEventListeners()
	self._btninfo:AddClickListener(self._btninfoOnClick, self)
end

function Act183DungeonDescComp:removeEventListeners()
	self._btninfo:RemoveClickListener()
end

function Act183DungeonDescComp:checkIsVisible()
	return true
end

function Act183DungeonDescComp:show()
	Act183DungeonDescComp.super.show(self)

	self._txttitle.text = self._episodeCo.title
	self._txtdesc.text = self._episodeCo.desc

	gohelper.setActive(self._gonormal, self._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(self._gohard, self._groupType == Act183Enum.GroupType.HardMain)
	gohelper.setActive(self._godone, self._status == Act183Enum.EpisodeStatus.Finished)
end

function Act183DungeonDescComp:_btninfoOnClick()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeCo then
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(episodeCo.battleId)
	end
end

function Act183DungeonDescComp:getHeight()
	ZProj.UGUIHelper.RebuildLayout(self._topTran)

	return recthelper.getHeight(self._topTran)
end

function Act183DungeonDescComp:onDestroy()
	Act183DungeonDescComp.super.onDestroy(self)
end

return Act183DungeonDescComp

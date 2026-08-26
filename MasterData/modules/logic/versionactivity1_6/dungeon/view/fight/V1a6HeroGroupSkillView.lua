-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/fight/V1a6HeroGroupSkillView.lua

module("modules.logic.versionactivity1_6.dungeon.view.fight.V1a6HeroGroupSkillView", package.seeall)

local V1a6HeroGroupSkillView = class("V1a6HeroGroupSkillView", BaseView)

function V1a6HeroGroupSkillView:onInitView()
	self._gototem = gohelper.findChild(self.viewGO, "#go_totem")
end

function V1a6HeroGroupSkillView:addEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SwitchReplay, self.switchReplay, self)
end

function V1a6HeroGroupSkillView:removeEvents()
	return
end

V1a6HeroGroupSkillView.PrefabPath = "ui/viewres/herogroup/herogroupviewtalent.prefab"

function V1a6HeroGroupSkillView:onOpen()
	local fightParam = FightModel.instance:getFightParam()
	local chapterId = fightParam.chapterId
	local isAct1_6Dungeon = false

	if chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Story1 or chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Story2 or chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Story3 or chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Story4 or chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.ElementFight or chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.BossFight then
		local isAct148Unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

		if not isAct148Unlock then
			return
		end

		isAct1_6Dungeon = true
	end

	if not isAct1_6Dungeon then
		return
	end

	self.loader = PrefabInstantiate.Create(self._gototem)

	self.loader:startLoad(V1a6HeroGroupSkillView.PrefabPath, self.onLoadFinish, self)
end

function V1a6HeroGroupSkillView:onLoadFinish()
	self.loadFinishDone = true
	self.go = self.loader:getInstGO()
	self._singleBg = gohelper.findChildSingleImage(self.go, "#go_Talent/Talent/image_TalentIcon")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.go, "#go_Talent/#btn_click")

	self._btnclick:AddClickListener(self._btnClickOnClick, self)
	self:refreshPoint()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function V1a6HeroGroupSkillView:onReceiveMsg()
	self.receiveMsgDone = true

	self:refreshPoint()
end

function V1a6HeroGroupSkillView:refreshPoint()
	if not self.loadFinishDone then
		return
	end

	gohelper.setActive(self._gototem, true)
end

function V1a6HeroGroupSkillView:switchReplay(isReplay)
	self.isReplay = isReplay

	self:refreshPoint()
end

function V1a6HeroGroupSkillView:_btnClickOnClick()
	if self.isReplay then
		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillView)
end

function V1a6HeroGroupSkillView:onCloseViewFinish()
	return
end

function V1a6HeroGroupSkillView:onDestroyView()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end

	if self._singleBg then
		self._singleBg:UnLoadImage()
	end

	if self.loader then
		self.loader:dispose()
	end
end

return V1a6HeroGroupSkillView

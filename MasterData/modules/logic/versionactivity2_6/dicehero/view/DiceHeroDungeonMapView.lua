-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroDungeonMapView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDungeonMapView", package.seeall)

local DiceHeroDungeonMapView = class("DiceHeroDungeonMapView", BaseView)

function DiceHeroDungeonMapView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_dicebtn")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_dicebtn/#btn_enter", AudioEnum2_6.DiceHero.play_ui_wenming_alaifugameplay)
	self._gored = gohelper.findChild(self.viewGO, "#go_dicebtn/#btn_enter/#go_reddot")
	self._anim = gohelper.findChildAnim(self.viewGO, "#go_dicebtn/#btn_enter")
end

function DiceHeroDungeonMapView:addEvents()
	self._btnEnter:AddClickListener(self.onClickEnter, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, DiceHeroController.instance, DiceHeroEvent.InfoUpdate, self.onActStateChange, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.UnlockPermanent, self.onActStateChange, self)
end

function DiceHeroDungeonMapView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.removeEventCb(self, DiceHeroController.instance, DiceHeroEvent.InfoUpdate, self.onActStateChange, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.UnlockPermanent, self.onActStateChange, self)
end

function DiceHeroDungeonMapView:refreshView()
	self.chapterId = self.viewParam.chapterId

	self:onActStateChange()
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a6DiceHero)

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		self._anim:Play("close", 0, 1)
	else
		self._anim:Play("open", 0, 0)
	end
end

function DiceHeroDungeonMapView:onOpen()
	self:refreshView()
end

function DiceHeroDungeonMapView:onUpdateParam()
	self:refreshView()
end

function DiceHeroDungeonMapView:onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self._anim:Play("close", 0, 0)
	end
end

function DiceHeroDungeonMapView:onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self._anim:Play("open", 0, 0)
	end
end

function DiceHeroDungeonMapView:setEpisodeListVisible(value)
	if value and self:isShowRoot() then
		self._anim:Play("open", 0, 0)
	else
		self._anim:Play("close", 0, 0)
	end
end

function DiceHeroDungeonMapView:isShowRoot()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DiceHero) and self.chapterId == DungeonEnum.ChapterId.Main1_9 then
		return true
	end
end

function DiceHeroDungeonMapView:onActStateChange()
	if self:isShowRoot() then
		gohelper.setActive(self._goroot, true)
	else
		gohelper.setActive(self._goroot, false)
	end
end

function DiceHeroDungeonMapView:onClickEnter()
	if OptionPackageController.instance:checkNeedDownload(OptionPackageEnum.Package.VersionActivity) then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroMainView)
end

return DiceHeroDungeonMapView

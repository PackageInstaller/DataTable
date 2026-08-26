-- chunkname: @modules/logic/versionactivity1_7/dungeon/view/DungeonMapToughBattleActView.lua

module("modules.logic.versionactivity1_7.dungeon.view.DungeonMapToughBattleActView", package.seeall)

local DungeonMapToughBattleActView = class("DungeonMapToughBattleActView", BaseView)

function DungeonMapToughBattleActView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_toughbattle")
	self._gotoughbattle = gohelper.findChild(self.viewGO, "#go_toughbattle/#go_toughbattle")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_toughbattle/#go_toughbattle/#btn_entry")
	self._gochallenge = gohelper.findChild(self.viewGO, "#go_toughbattle/#go_toughbattle/#btn_entry/go_challenge")
	self._gored = gohelper.findChild(self.viewGO, "#go_toughbattle/#go_toughbattle/#go_reddot")
	self._anim = self._gotoughbattle:GetComponent(typeof(UnityEngine.Animator))
end

function DungeonMapToughBattleActView:addEvents()
	self._btnEnter:AddClickListener(self.onClickToughBattle, self)
	self.addEventCb(self, ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, self.onActStateChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
end

function DungeonMapToughBattleActView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self.removeEventCb(self, ToughBattleController.instance, ToughBattleEvent.ToughBattleActChange, self.onActStateChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
end

function DungeonMapToughBattleActView:refreshView()
	self.chapterId = self.viewParam.chapterId

	self:onActStateChange()
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V1a9ToughBattle)

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		self._anim:Play("close", 0, 1)
	else
		self._anim:Play("open", 0, 0)
	end
end

function DungeonMapToughBattleActView:onOpen()
	self:refreshView()
end

function DungeonMapToughBattleActView:onUpdateParam()
	self:refreshView()
end

function DungeonMapToughBattleActView:onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self._anim:Play("close", 0, 0)
	end
end

function DungeonMapToughBattleActView:onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self._anim:Play("open", 0, 0)
	end
end

function DungeonMapToughBattleActView:setEpisodeListVisible(value)
	if value and self:isShowRoot() then
		self._anim:Play("open", 0, 0)
	else
		self._anim:Play("close", 0, 0)
	end
end

function DungeonMapToughBattleActView:isShowRoot()
	if ToughBattleModel.instance:getActIsOnline() and self.chapterId == DungeonEnum.ChapterId.Main1_7 then
		return true
	end
end

function DungeonMapToughBattleActView:onActStateChange()
	if self:isShowRoot() then
		gohelper.setActive(self._gotoughbattle, true)
		gohelper.setActive(self._goroot, true)

		local info = ToughBattleModel.instance:getActInfo()

		gohelper.setActive(self._gochallenge, info.openChallenge)
	else
		gohelper.setActive(self._gotoughbattle, false)
		gohelper.setActive(self._goroot, false)
	end
end

function DungeonMapToughBattleActView:onClickToughBattle()
	ToughBattleModel.instance:setIsJumpActElement(true)

	if not self:isInMain_7_28() then
		JumpController.instance:jumpByParam("4#10728#1")
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, ToughBattleEnum.ActElementId)
end

function DungeonMapToughBattleActView:isInMain_7_28()
	local viewContainer = self.viewContainer
	local mapScene = viewContainer:getMapScene()

	if not mapScene then
		return false
	end

	local mapCfg = mapScene._mapCfg

	if not mapCfg then
		return false
	end

	return mapCfg.id == ToughBattleEnum.MapId_7_28
end

return DungeonMapToughBattleActView

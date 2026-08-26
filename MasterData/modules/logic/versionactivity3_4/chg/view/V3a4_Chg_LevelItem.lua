-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_LevelItem.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_LevelItem", package.seeall)

local V3a4_Chg_LevelItem = class("V3a4_Chg_LevelItem", RougeSimpleItemBase)

function V3a4_Chg_LevelItem:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._goSpecial = gohelper.findChild(self.viewGO, "#go_Special")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Current")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_LevelItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function V3a4_Chg_LevelItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function V3a4_Chg_LevelItem:ctor(...)
	self:__onInit()
	V3a4_Chg_LevelItem.super.ctor(self, ...)
end

function V3a4_Chg_LevelItem:_btnClickOnClick()
	local p = self:parent()

	p:onLevelItemClick(self)
end

function V3a4_Chg_LevelItem:_editableInitView()
	V3a4_Chg_LevelItem.super._editableInitView(self)

	self._special = V3a4_Chg_LevelItem__Special.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	self._special:init(self._goSpecial)

	self._normal = V3a4_Chg_LevelItem__Normal.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	self._normal:init(self._goNormal)
end

function V3a4_Chg_LevelItem:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_special")
	GameUtil.onDestroyViewMember(self, "_normal")
	self:_destroyWorkFlow()
	V3a4_Chg_LevelItem.super.onDestroyView(self)
	self:__onDispose()
end

function V3a4_Chg_LevelItem:episodeId()
	return self._mo.id
end

function V3a4_Chg_LevelItem:isLevelPass()
	local c = self:baseViewContainer()

	return c:isLevelPass(self:episodeId())
end

function V3a4_Chg_LevelItem:isLevelUnlock()
	local c = self:baseViewContainer()

	return c:isLevelUnlock(self:episodeId())
end

function V3a4_Chg_LevelItem:getElementCoByEpisodeId()
	local c = self:baseViewContainer()

	return c:getElementCoByEpisodeId(self:episodeId())
end

function V3a4_Chg_LevelItem:trackPass(...)
	local littleGameCo = self:getElementCoByEpisodeId()

	if not littleGameCo then
		return
	end

	local c = self:baseViewContainer()

	return c:trackPass(...)
end

function V3a4_Chg_LevelItem:setData(mo)
	V3a4_Chg_LevelItem.super.setData(self, mo)

	local episodeCO = mo
	local isBattle = not not self:getElementCoByEpisodeId()
	local isPassed = self:isLevelPass()
	local isUnLocked = self:isLevelUnlock()
	local numStr = self:index() < 9 and string.format("%02d", self:index()) or ""

	self:_setNum(numStr)
	self:_setName(episodeCO.name)
	self:_setActive_goStar(isPassed)
	self:_setActive_goLocked(not isUnLocked)
	self._special:setActive(isBattle)
	self._normal:setActive(not isBattle)
	self:playIdle(isUnLocked)
end

function V3a4_Chg_LevelItem:_setActive_goLocked(isActive)
	self._normal:setActive_goLocked(isActive)
	self._special:setActive_goLocked(isActive)
end

function V3a4_Chg_LevelItem:_setName(name)
	self._normal:setName(name)
	self._special:setName(name)
end

function V3a4_Chg_LevelItem:_setNum(num)
	self._special:setNum(num)
	self._normal:setNum(num)
end

function V3a4_Chg_LevelItem:_setActive_goStar(isActive)
	self._special:setActive_goStar(isActive)
	self._normal:setActive_goStar(isActive)
end

function V3a4_Chg_LevelItem:playStarAnim(...)
	self._special:playStarAnim(...)
	self._normal:playStarAnim(...)
end

function V3a4_Chg_LevelItem:setActive_goCurrent(isActive)
	gohelper.setActive(self._goCurrent, isActive)
end

local WaitSecBeforPlayAfterStory = 1.5
local WaitEventWorkParam = "ChgController;ChgEvent;OnGameFinished"

function V3a4_Chg_LevelItem:playStory()
	local episodeCO = self._mo

	self:_destroyWorkFlow()

	self._flow = FlowSequence.New()

	if not self:isLevelPass() then
		self._flow:addWork(FunctionWork.New(self._onStartEpisode, self))
	end

	if episodeCO.beforeStory ~= 0 then
		self._flow:addWork(PlayStoryWork.New(episodeCO.beforeStory))
	end

	local littleGameCo = self:getElementCoByEpisodeId()

	if littleGameCo then
		self._flow:addWork(FunctionWork.New(ChgController.enterGame, ChgController.instance, littleGameCo))
		self._flow:addWork(WaitEventWork.New(WaitEventWorkParam))
	else
		ChgBattleModel.instance:clear()
	end

	if not self:isLevelPass() then
		self._flow:addWork(FunctionWork.New(self._onFinishedEpisode, self))
	else
		self._flow:addWork(FunctionWork.New(self.trackPass, self))
	end

	if littleGameCo then
		self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
		self._flow:addWork(WorkWaitSeconds.New(WaitSecBeforPlayAfterStory))
		self._flow:addWork(BpCloseViewWork.New(ViewName.V3a4_Chg_GameView))
		self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
	end

	if episodeCO.afterStory ~= 0 then
		self._flow:addWork(PlayStoryWork.New(episodeCO.afterStory))
	end

	self._flow:start()
end

function V3a4_Chg_LevelItem:_onStartEpisode()
	local episodeCO = self._mo

	DungeonRpc.instance:sendStartDungeonRequest(episodeCO.chapterId, self:episodeId())
end

function V3a4_Chg_LevelItem:_onFinishedEpisode()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self:episodeId())
	DungeonRpc.instance:sendEndDungeonRequest(false)
	self:trackPass(true)
end

function V3a4_Chg_LevelItem:_destroyWorkFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

local kBlock = "V3a4_Chg_LevelItem"

function V3a4_Chg_LevelItem:_lockScreen(lock)
	if lock then
		self:baseViewContainer():startBlockSlient(10, kBlock)
	else
		self:baseViewContainer():endBlockSlient(kBlock)
	end
end

function V3a4_Chg_LevelItem:playUnlock()
	self._normal:playUnlock()
	self._special:playUnlock()
end

function V3a4_Chg_LevelItem:playIdle(isUnLocked)
	self._normal:playIdle(isUnLocked)
	self._special:playIdle(isUnLocked)
end

return V3a4_Chg_LevelItem

-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_LevelItem.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_LevelItem", package.seeall)

local V3a7_Wmz_LevelItem = class("V3a7_Wmz_LevelItem", RougeSimpleItemBase)

function V3a7_Wmz_LevelItem:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._goSpecial = gohelper.findChild(self.viewGO, "#go_Special")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Current")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_LevelItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function V3a7_Wmz_LevelItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function V3a7_Wmz_LevelItem:ctor(...)
	self:__onInit()
	V3a7_Wmz_LevelItem.super.ctor(self, ...)
end

function V3a7_Wmz_LevelItem:_btnClickOnClick()
	local p = self:parent()

	p:onLevelItemClick(self)
end

function V3a7_Wmz_LevelItem:_editableInitView()
	V3a7_Wmz_LevelItem.super._editableInitView(self)

	self._special = V3a7_Wmz_LevelItem__Special.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	self._special:init(self._goSpecial)

	self._normal = V3a7_Wmz_LevelItem__Normal.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	self._normal:init(self._goNormal)

	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function V3a7_Wmz_LevelItem:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_special")
	GameUtil.onDestroyViewMember(self, "_normal")
	V3a7_Wmz_LevelItem.super.onDestroyView(self)
	self:__onDispose()
end

function V3a7_Wmz_LevelItem:episodeId()
	return self._mo.episodeId
end

function V3a7_Wmz_LevelItem:isEpisodePass()
	local c = self:baseViewContainer()

	return c:isEpisodePass(self:episodeId())
end

function V3a7_Wmz_LevelItem:isEpisodeUnlock()
	local c = self:baseViewContainer()

	return c:isEpisodeUnlock(self:episodeId())
end

function V3a7_Wmz_LevelItem:bHasGame()
	local episodeCO = self._mo

	return episodeCO.gameId and episodeCO.gameId > 0 or false
end

function V3a7_Wmz_LevelItem:bHasPreStory()
	local episodeCO = self._mo

	return episodeCO.storyBefore and episodeCO.storyBefore > 0 or false
end

function V3a7_Wmz_LevelItem:bHasPostStory()
	local episodeCO = self._mo

	return episodeCO.storyClear and episodeCO.storyClear > 0 or false
end

function V3a7_Wmz_LevelItem:setData(mo)
	V3a7_Wmz_LevelItem.super.setData(self, mo)

	local episodeCO = mo
	local bHasGame = self:bHasGame()
	local isPassed = self:isEpisodePass()
	local isUnLocked = self:isEpisodeUnlock()
	local numStr = self:index() < 9 and string.format("%02d", self:index()) or ""

	self:_setNum(numStr)
	self:_setName(episodeCO.name)
	self:_setActive_goStar(isPassed)
	self:_setActive_goLocked(not isUnLocked)
	self._special:setActive(bHasGame)
	self._normal:setActive(not bHasGame)
	self:playIdle(isUnLocked)
end

function V3a7_Wmz_LevelItem:_setActive_goLocked(isActive)
	self._normal:setActive_goLocked(isActive)
	self._special:setActive_goLocked(isActive)
end

function V3a7_Wmz_LevelItem:_setName(name)
	self._normal:setName(name)
	self._special:setName(name)
end

function V3a7_Wmz_LevelItem:_setNum(num)
	self._special:setNum(num)
	self._normal:setNum(num)
end

function V3a7_Wmz_LevelItem:_setActive_goStar(isActive)
	self._special:setActive_goStar(isActive)
	self._normal:setActive_goStar(isActive)
end

function V3a7_Wmz_LevelItem:playStarAnim(...)
	self._special:playStarAnim(...)
	self._normal:playStarAnim(...)
	self._anim:Play(UIAnimationName.Finish, 0, 0)
end

function V3a7_Wmz_LevelItem:setActive_goCurrent(isActive)
	gohelper.setActive(self._goCurrent, isActive)
end

function V3a7_Wmz_LevelItem:playStory()
	local episodeId = self:episodeId()

	if not self:isEpisodeUnlock(episodeId) then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	local c = self:baseViewContainer()

	c:setOnPreHookGamePostStory(self._cbOnPreHookGamePostStory, self)
	c:startSimpleGameFlow(episodeId)
end

local kWaitSecBeforPlayAfterStory = 1.5

function V3a7_Wmz_LevelItem:_cbOnPreHookGamePostStory(refFlow)
	if not self:bHasGame() then
		return
	end

	if self:bHasPostStory() then
		refFlow:addWork(FunctionWork.New(self._lockScreen, self, true))
	end

	refFlow:addWork(WorkWaitSeconds.New(kWaitSecBeforPlayAfterStory))
	refFlow:addWork(BpCloseViewWork.New(ViewName.V3a7_Wmz_GameView))

	if self:bHasPostStory() then
		refFlow:addWork(FunctionWork.New(self._lockScreen, self, false))
	end
end

local kBlock = "V3a7_Wmz_LevelItem"

function V3a7_Wmz_LevelItem:_lockScreen(lock)
	if lock then
		self:baseViewContainer():startBlockSlient(10, kBlock)
	else
		self:baseViewContainer():endBlockSlient(kBlock)
	end
end

function V3a7_Wmz_LevelItem:playUnlock()
	self._normal:playUnlock()
	self._special:playUnlock()
	self._anim:Play(UIAnimationName.Unlock, 0, 0)
end

function V3a7_Wmz_LevelItem:playIdle(isUnLocked)
	self._normal:playIdle(isUnLocked)
	self._special:playIdle(isUnLocked)

	if isUnLocked then
		self:playIdle_Unlocked()
	else
		self:playIdle_Locked()
	end
end

function V3a7_Wmz_LevelItem:playIdle_Unlocked()
	self._anim:Play(UIAnimationName.Unlock, 0, 1)
end

function V3a7_Wmz_LevelItem:playIdle_Locked()
	self._anim:Play(UIAnimationName.Idle, 0, 0)
end

return V3a7_Wmz_LevelItem

-- chunkname: @modules/logic/character/view/CharacterSpineGCView.lua

module("modules.logic.character.view.CharacterSpineGCView", package.seeall)

local CharacterSpineGCView = class("CharacterSpineGCView", BaseView)
local NeedGCSpineCount = 5

function CharacterSpineGCView:onInitView()
	self._skinList = {}
end

function CharacterSpineGCView:addEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnSwitchSpine, self._recordSkin, self)
end

function CharacterSpineGCView:removeEvents()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.OnSwitchSpine, self._recordSkin, self)
end

function CharacterSpineGCView:onOpenFinish()
	self:_recordSkin()
end

function CharacterSpineGCView:onUpdateParam()
	self:_recordSkin()
end

function CharacterSpineGCView:onClose()
	self._skinList = {}

	TaskDispatcher.cancelTask(self._delayGC, self)
	TaskDispatcher.cancelTask(self._clearUnusedBanks, self)
end

function CharacterSpineGCView:_recordSkin()
	local param = self.viewContainer.viewParam

	if param and param.heroId then
		table.insert(self._skinList, param.skin)

		if #self._skinList > NeedGCSpineCount then
			if #self._skinList < NeedGCSpineCount * 2 then
				TaskDispatcher.cancelTask(self._delayGC, self)
			end

			TaskDispatcher.runDelay(self._delayGC, self, 1)
		end

		TaskDispatcher.cancelTask(self._clearUnusedBanks, self)
		TaskDispatcher.runDelay(self._clearUnusedBanks, self, 0.1)
	end
end

function CharacterSpineGCView:_clearUnusedBanks()
	AudioMgr.instance:clearUnusedBanks()
end

function CharacterSpineGCView:_delayGC()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)

	self._skinList = {}
end

return CharacterSpineGCView

-- chunkname: @modules/logic/character/view/CharacterSkinSwitchSpineGCView.lua

module("modules.logic.character.view.CharacterSkinSwitchSpineGCView", package.seeall)

local CharacterSkinSwitchSpineGCView = class("CharacterSkinSwitchSpineGCView", BaseView)
local NeedGCSpineCount = 4

function CharacterSkinSwitchSpineGCView:onInitView()
	self._skinList = {}
end

function CharacterSkinSwitchSpineGCView:addEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnSkinSwitchSpine, self._recordSkin, self)
end

function CharacterSkinSwitchSpineGCView:removeEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnSkinSwitchSpine, self._recordSkin, self)
end

function CharacterSkinSwitchSpineGCView:onOpenFinish()
	self:_recordSkin()
end

function CharacterSkinSwitchSpineGCView:onUpdateParam()
	self:_recordSkin()
end

function CharacterSkinSwitchSpineGCView:onClose()
	self._skinList = {}

	TaskDispatcher.cancelTask(self._delayGC, self)
end

function CharacterSkinSwitchSpineGCView:_recordSkin(skinId)
	table.insert(self._skinList, skinId)

	if #self._skinList > NeedGCSpineCount then
		if #self._skinList < NeedGCSpineCount * 2 then
			TaskDispatcher.cancelTask(self._delayGC, self)
		end

		TaskDispatcher.runDelay(self._delayGC, self, 1)
	end
end

function CharacterSkinSwitchSpineGCView:_delayGC()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, self)

	self._skinList = {}
end

return CharacterSkinSwitchSpineGCView

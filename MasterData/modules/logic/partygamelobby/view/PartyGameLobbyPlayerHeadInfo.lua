-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyPlayerHeadInfo.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyPlayerHeadInfo", package.seeall)

local PartyGameLobbyPlayerHeadInfo = class("PartyGameLobbyPlayerHeadInfo", ListScrollCellExtend)

function PartyGameLobbyPlayerHeadInfo:onInitView()
	self._simageemoji = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_emoji")
	self._gomainPlayer = gohelper.findChild(self.viewGO, "#go_mainPlayer")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyPlayerHeadInfo:addEvents()
	return
end

function PartyGameLobbyPlayerHeadInfo:removeEvents()
	return
end

function PartyGameLobbyPlayerHeadInfo:_editableInitView()
	self.emojiAnim = self._simageemoji.gameObject:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._simageemoji.transform.parent, false)
	gohelper.setActive(self._txtname, false)
	gohelper.setActive(self._gomainPlayer, false)

	self.showChatTime = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.ShowChatTime, true)
end

function PartyGameLobbyPlayerHeadInfo:showMainPlayerFlag()
	gohelper.setActive(self._gomainPlayer, true)
end

function PartyGameLobbyPlayerHeadInfo:_editableAddEvents()
	return
end

function PartyGameLobbyPlayerHeadInfo:_editableRemoveEvents()
	return
end

function PartyGameLobbyPlayerHeadInfo:onUpdateMO(mo, isEmoji)
	self._mo = mo
	self._isEmoji = isEmoji

	if not self._isEmoji then
		self._txtname.text = self:_getName()

		gohelper.setActive(self._txtname, true)
	end
end

function PartyGameLobbyPlayerHeadInfo:_getName()
	if SLFramework.FrameworkSettings.IsEditor and string.nilorempty(self._mo.name) then
		return "noname_" .. tostring(self._mo.id)
	end

	return self._mo.name
end

function PartyGameLobbyPlayerHeadInfo:showEmoji(emoji)
	if not emoji or emoji <= 0 then
		return
	end

	local emojiConfig = Activity225Config.instance:getMemeConfig(emoji)

	if not emojiConfig then
		return
	end

	gohelper.setActive(self._simageemoji.transform.parent, true)
	self._simageemoji:LoadImage(emojiConfig.icon)
	TaskDispatcher.cancelTask(self._delayHideEmoji, self)
	TaskDispatcher.runDelay(self._delayHideEmoji, self, self.showChatTime)
end

function PartyGameLobbyPlayerHeadInfo:_delayHideEmoji()
	if self.emojiAnim then
		self.emojiAnim:Play("out", 0, 0)
		self.emojiAnim:Update(0)
	end

	TaskDispatcher.runDelay(self.hideEmoji, self, 0.167)
end

function PartyGameLobbyPlayerHeadInfo:hideEmoji()
	gohelper.setActive(self._simageemoji.transform.parent, false)
end

function PartyGameLobbyPlayerHeadInfo:onSelect(isSelect)
	return
end

function PartyGameLobbyPlayerHeadInfo:bindPlayerGo(entity)
	if self._uiFollower then
		return
	end

	self._uiFollower = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.UIFollower))

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform
	local followGo = gohelper.create3d(entity, "uiPos")

	transformhelper.setLocalPos(followGo.transform, 0, 2.7, 0)
	self._uiFollower:Set(mainCamera, uiCamera, plane, followGo.transform, 0, 0, 0, 0, 0)
	self._uiFollower:SetBillboardRoot(entity.transform)
	self._uiFollower:SetUseBillboard(true)
	self._uiFollower:SetEnable(true)
	self._uiFollower:ForceUpdate()

	self._sceneNodeGo = entity
end

function PartyGameLobbyPlayerHeadInfo:onDestroyView()
	TaskDispatcher.cancelTask(self._delayHideEmoji, self)
	TaskDispatcher.cancelTask(self.hideEmoji, self)
end

return PartyGameLobbyPlayerHeadInfo

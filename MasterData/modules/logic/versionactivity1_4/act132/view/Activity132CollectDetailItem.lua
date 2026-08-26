-- chunkname: @modules/logic/versionactivity1_4/act132/view/Activity132CollectDetailItem.lua

module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailItem", package.seeall)

local Activity132CollectDetailItem = class("Activity132CollectDetailItem", UserDataDispose)

function Activity132CollectDetailItem:ctor(go)
	self:__onInit()

	self._viewGO = go
	self._goTips = gohelper.findChild(go, "tips")
	self._txtLock = gohelper.findChildTextMesh(self._goTips, "txt_Lock")
	self._goDesc = gohelper.findChild(go, "txtDesc")
	self._txtDesc = self._goDesc:GetComponent(gohelper.Type_TextMesh)
	self._animTxt = self._goDesc:GetComponent(typeof(UnityEngine.Animator))
end

function Activity132CollectDetailItem:setData(data, unlockDict)
	self.data = data

	if not data then
		gohelper.setActive(self._viewGO, false)

		return
	end

	gohelper.setActive(self._viewGO, true)
	self:refreshState()
end

function Activity132CollectDetailItem:refreshState()
	if not self.data then
		return
	end

	local state = Activity132Model.instance:getContentState(self.data.activityId, self.data.contentId)

	self._txtDesc.text = self.data.content
	self._txtLock.text = self.data.unlockDesc

	gohelper.setActive(self._goTips, state ~= Activity132Enum.ContentState.Unlock)
	gohelper.setActive(self._goDesc, state == Activity132Enum.ContentState.Unlock)
end

function Activity132CollectDetailItem:playUnlock()
	self:refreshState()
	self._animTxt:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
end

function Activity132CollectDetailItem:destroy()
	self:__onDispose()
end

return Activity132CollectDetailItem

-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupLockView.lua

module("modules.logic.abyss.view.AbyssHeroGroupLockView", package.seeall)

local AbyssHeroGroupLockView = class("AbyssHeroGroupLockView", BaseView)

function AbyssHeroGroupLockView:onInitView()
	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_replayready/Reset")
	self._goreplayready = gohelper.findChild(self.viewGO, "#go_container/#go_replayready")
	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	self._btnReadPreset = gohelper.findChildButton(self.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssHeroGroupLockView:addEvents()
	self.btnReset:AddClickListener(self._btnResetOnClick, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.onResetSubEpisode, self)
end

function AbyssHeroGroupLockView:removeEvents()
	self.btnReset:RemoveClickListener()
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.onResetSubEpisode, self)
end

function AbyssHeroGroupLockView:_btnResetOnClick()
	AbyssController.instance:tryResetCurStage()
end

function AbyssHeroGroupLockView:_editableInitView()
	gohelper.setActive(self._dropherogroup, false)
end

function AbyssHeroGroupLockView:onResetSubEpisode()
	self:refreshUI()
end

function AbyssHeroGroupLockView:onUpdateParam()
	return
end

function AbyssHeroGroupLockView:onOpen()
	self:refreshUI()
end

function AbyssHeroGroupLockView:refreshUI()
	local stageInfoMo = AbyssModel.instance:getCurStageMo()
	local isLock = stageInfoMo:isChallenged()

	gohelper.setActive(self._btnReadPreset, not isLock)
	gohelper.setActive(self._goreplayready, isLock)
	gohelper.setActive(self._dropherogroup, false)
end

function AbyssHeroGroupLockView:onClose()
	return
end

return AbyssHeroGroupLockView

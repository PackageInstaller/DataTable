-- chunkname: @modules/logic/summon/view/SummonView.lua

module("modules.logic.summon.view.SummonView", package.seeall)

local SummonView = class("SummonView", BaseView)

function SummonView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._imageskiptxt = gohelper.findChildImage(self.viewGO, "#btn_skip/#image_skiptxt")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#btn_skip/#image_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function SummonView:removeEvents()
	self._btnskip:RemoveClickListener()
end

function SummonView:_btnskipOnClick()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonSkip)
end

function SummonView:_editableInitView()
	gohelper.setActive(self._btnskip.gameObject, false)
end

function SummonView:_initSummonView()
	return
end

function SummonView:onUpdateParam()
	logNormal("SummonView onUpdateParam")
end

function SummonView:onOpen()
	logNormal("SummonView onOpen")
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonTabSet, self._handleSelectTab, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.startDraw, self)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	SummonMainModel.instance:updateLastPoolId()
	self:_handleSelectTab()
end

function SummonView:onOpenFinish()
	if Act101VersionSummonController.instance:isOpen() and Act101VersionSummonController.instance:isCliamed() then
		Act101VersionSummonController.instance:saveTakeALookSummon(true)
	end
end

function SummonView:startDraw()
	gohelper.setActive(self._btnskip.gameObject, not SummonController.instance:isInSummonGuide() and not SummonModel.instance:getSendEquipFreeSummon())
end

function SummonView:_handleSelectTab()
	local poolId = SummonController.instance:getLastPoolId()
	local tabIndex = SummonMainModel.getResultTypeById(poolId)

	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabIndex)
end

function SummonView:onDestroyView()
	return
end

function SummonView:onClose()
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Close)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

return SummonView

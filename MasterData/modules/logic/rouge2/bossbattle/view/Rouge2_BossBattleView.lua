-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossBattleView.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossBattleView", package.seeall)

local Rouge2_BossBattleView = class("Rouge2_BossBattleView", BaseView)

function Rouge2_BossBattleView:onInitView()
	self._scrollBoss = gohelper.findChildScrollRect(self.viewGO, "#scroll_Boss")
	self._btnRecord = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Record")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BossBattleView:addEvents()
	self._btnRecord:AddClickListener(self._btnRecordOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateBossBattleInfo, self._onUpdateBossBattleInfo, self)
end

function Rouge2_BossBattleView:removeEvents()
	self._btnRecord:RemoveClickListener()
end

function Rouge2_BossBattleView:_btnRecordOnClick()
	local param = {
		viewType = Rouge2_OutsideEnum.SaveInfoViewType.Show
	}

	Rouge2_ViewHelper.openSaveInfoView(param)
end

function Rouge2_BossBattleView:_editableInitView()
	return
end

function Rouge2_BossBattleView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.EnterBoss)
	self:initList()
end

function Rouge2_BossBattleView:initList()
	self._bossBattleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()

	Rouge2_BossBattleListModel.instance:initList()
end

function Rouge2_BossBattleView:_onUpdateBossBattleInfo()
	self:initList()
end

function Rouge2_BossBattleView:onClose()
	return
end

function Rouge2_BossBattleView:onDestroyView()
	return
end

return Rouge2_BossBattleView

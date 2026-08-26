-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131BattleView.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131BattleView", package.seeall)

local Activity131BattleView = class("Activity131BattleView", BaseView)

function Activity131BattleView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/layout/top/title/#txt_title")
	self._gobg = gohelper.findChild(self.viewGO, "rotate/#go_bg")
	self._txtinfo = gohelper.findChildText(self.viewGO, "rotate/#go_bg/#txt_info")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#btn_closetip")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/right/go_fight/#btn_fight")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131BattleView:addEvents()
	self._btnclosetip:AddClickListener(self._btnclosetipOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Activity131BattleView:removeEvents()
	self._btnclosetip:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function Activity131BattleView:_btnclosetipOnClick()
	return
end

function Activity131BattleView:_btnfightOnClick()
	Activity131Controller.instance:enterFight(self.episodeCfg)
end

function Activity131BattleView:_btncloseOnClick()
	self._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doClose, self, 0.233)
end

function Activity131BattleView:_doClose()
	self:closeThis()
end

function Activity131BattleView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Activity131BattleView:onUpdateParam()
	return
end

function Activity131BattleView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)

	local episodeId = tonumber(self.viewContainer.viewParam)

	self.episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)

	if self.episodeCfg then
		self._txttitle.text = self.episodeCfg.name
		self._txtinfo.text = self.episodeCfg.desc
	end
end

function Activity131BattleView:onClose()
	return
end

function Activity131BattleView:onDestroyView()
	return
end

return Activity131BattleView

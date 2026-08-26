-- chunkname: @modules/logic/toughbattle/view/ToughBattleLoadingView.lua

module("modules.logic.toughbattle.view.ToughBattleLoadingView", package.seeall)

local ToughBattleLoadingView = class("ToughBattleLoadingView", BaseView)

function ToughBattleLoadingView:onInitView()
	self._imgstage = gohelper.findChildImage(self.viewGO, "root/#go_stageinfo/#simage_stagepic")
	self._imgstage2 = gohelper.findChildImage(self.viewGO, "root/#go_start/#simage_stagepic")
	self._gobg = gohelper.findChild(self.viewGO, "root/#go_bg")
	self._gofightsuccess = gohelper.findChild(self.viewGO, "root/#go_fightsuccess")
	self._gostageinfo = gohelper.findChild(self.viewGO, "root/#go_stageinfo")
	self._gostart = gohelper.findChild(self.viewGO, "root/#go_start")
	self._enemy = gohelper.findChild(self.viewGO, "root/#go_bg/enemy")
	self._stageen1 = gohelper.findChild(self.viewGO, "root/#go_stageinfo/txten1")
	self._stageen2 = gohelper.findChild(self.viewGO, "root/#go_stageinfo/txten2")
	self._txtstage = gohelper.findChildTextMesh(self.viewGO, "root/#go_stageinfo/txt")
end

function ToughBattleLoadingView:onOpen()
	gohelper.setActive(self._gofightsuccess, false)
	gohelper.setActive(self._gostageinfo, false)
	gohelper.setActive(self._gostart, false)
	gohelper.setActive(self._gobg, false)
	UISpriteSetMgr.instance:setToughBattleSprite(self._imgstage, "toughbattle_stage_1_" .. self.viewParam.stage)
	UISpriteSetMgr.instance:setToughBattleSprite(self._imgstage2, "toughbattle_stage_2_" .. self.viewParam.stage)
	gohelper.setActive(self._enemy, self.viewParam.stage == 2)
	gohelper.setActive(self._stageen1, self.viewParam.stage == 1)
	gohelper.setActive(self._stageen2, self.viewParam.stage == 2)

	if self.viewParam.stage == 1 then
		self:playStageInfo()
	else
		self:playFightSuccess()
	end
end

function ToughBattleLoadingView:playFightSuccess()
	gohelper.setActive(self._gofightsuccess, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_win)
	TaskDispatcher.runDelay(self.playStageInfo, self, 1.667)
end

function ToughBattleLoadingView:playStageInfo()
	gohelper.setActive(self._gofightsuccess, false)
	gohelper.setActive(self._gobg, true)
	gohelper.setActive(self._gostageinfo, true)

	self._txtstage.text = self.viewParam.stage == 1 and luaLang("toughbattle_stage1_title") or luaLang("toughbattle_stage2_title")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bushu)
	TaskDispatcher.runDelay(self.playStart, self, 1.667)
end

function ToughBattleLoadingView:playStart()
	gohelper.setActive(self._gostageinfo, false)
	gohelper.setActive(self._gostart, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_kaishi)
	TaskDispatcher.runDelay(self.closeThis, self, 1.333)
end

function ToughBattleLoadingView:onClose()
	TaskDispatcher.cancelTask(self.playFightSuccess, self)
	TaskDispatcher.cancelTask(self.playStart, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return ToughBattleLoadingView

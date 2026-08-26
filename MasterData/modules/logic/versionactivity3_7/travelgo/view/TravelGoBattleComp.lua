-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoBattleComp.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoBattleComp", package.seeall)

local TravelGoBattleComp = class("TravelGoBattleComp", LuaCompBase)

function TravelGoBattleComp:ctor(goView)
	self.goView = goView
end

function TravelGoBattleComp:init(viewGO)
	self.viewGO = viewGO
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.Title = gohelper.findChild(self.viewGO, "Title")
	self.BattleStart1 = gohelper.findChild(self.viewGO, "BattleStart1")
	self.BattleStart2 = gohelper.findChild(self.viewGO, "BattleStart2")
	self.battleMask2 = gohelper.findChild(self.viewGO, "#simage_BossMask")
	self.Tips = gohelper.findChild(self.viewGO, "Tips")
	self.textTip = gohelper.findChildTextMesh(self.viewGO, "Tips/#txt_Tips")
	self.tipanimator = self.Tips:GetComponent(gohelper.Type_Animator)
	self.Title = gohelper.findChild(self.viewGO, "Title")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_Title")
	self.titleAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.Title)

	gohelper.setActive(self.viewGO, false)
	gohelper.setActive(self.Tips, false)

	self.controller = TravelGoController.instance
end

function TravelGoBattleComp:addEvents()
	self.addEventCb(self, self.controller, TravelGoEvent.OnBattleStart, self.onBattleStart, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnBattleStartComplete, self.onBattleStartComplete, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnShowBattleTip, self.onShowBattleTip, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnRoundStart, self.onRoundStart, self)
end

function TravelGoBattleComp:onDestroy()
	TaskDispatcher.cancelTask(self.onBattleTipFinish, self)
end

function TravelGoBattleComp:onBattleStart()
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_fight)
	gohelper.setActive(self.viewGO, true)
	gohelper.setActive(self.Tips, false)
	self._animatorPlayer:Play(UIAnimationName.Open)

	local travelGoEventMO = TravelGoModel.instance.travelGoEventMO
	local enemyCfgId = travelGoEventMO.cfg.npc
	local cfg = lua_activity220_unit.configDict[enemyCfgId]

	self.BattleStart1:SetActive(false)
	self.BattleStart2:SetActive(false)
	self.battleMask2:SetActive(false)

	if cfg.type == 0 then
		self.BattleStart1:SetActive(true)
	elseif cfg.type == 2 then
		self.BattleStart2:SetActive(true)
		self.battleMask2:SetActive(true)
	end

	self.curRound = nil

	self:_updateTitleRound(1)
end

function TravelGoBattleComp:onBattleStartComplete()
	self.goView:onBattleStartCompleteShowEntity()
end

function TravelGoBattleComp:onBattleEventFinish()
	self.goView:onBattleEventFinishHideEntity()
	self.titleAnimatorPlayer:Play(UIAnimationName.Close)
	self._animatorPlayer:Play(UIAnimationName.Close, self._onPlayCloseFinished, self)
end

function TravelGoBattleComp:_onPlayCloseFinished()
	gohelper.setActive(self.viewGO, false)
	self.goView:afterBattleCompCloseShowEntityAndDayComp()
end

function TravelGoBattleComp:onShowBattleTip(tip)
	gohelper.setActive(self.Tips, true)

	self.textTip.text = tip

	self.tipanimator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(self.onBattleTipFinish, self, 1)
end

function TravelGoBattleComp:onBattleTipFinish()
	self.tipanimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.cancelTask(self.onBattleTipFinish, self)
end

function TravelGoBattleComp:onRoundStart(entity)
	if entity and entity.entityType == TravelGoBattleEnum.EntityType.Player then
		local newRound = tonumber(entity.tag.round)

		if self.curRound and newRound == self.curRound then
			return
		end

		self.titleAnimatorPlayer:Play(UIAnimationName.Close, self._updateTitleRound, self, newRound)
	end
end

function TravelGoBattleComp:_updateTitleRound(round)
	self.txtTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("TravelGoView_battleRound"), round)
	self.curRound = round

	self.titleAnimatorPlayer:Play(UIAnimationName.Open)
end

return TravelGoBattleComp

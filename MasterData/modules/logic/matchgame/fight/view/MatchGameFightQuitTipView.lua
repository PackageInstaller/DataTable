-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightQuitTipView.lua

module("modules.logic.matchgame.fight.view.MatchGameFightQuitTipView", package.seeall)

local MatchGameFightQuitTipView = class("MatchGameFightQuitTipView", BaseView)

function MatchGameFightQuitTipView:onInitView()
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "center/btn/#btn_quitgame")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "center/btn/#btn_cancel")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "center/btn/#btn_restart")
	self._gotargetContent = gohelper.findChild(self.viewGO, "center/#go_targetContent")
	self._gotargetItem = gohelper.findChild(self.viewGO, "center/#go_targetContent/#go_targetItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameFightQuitTipView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function MatchGameFightQuitTipView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function MatchGameFightQuitTipView:_btnquitgameOnClick()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.QuitGame)
	self:closeThis()
end

function MatchGameFightQuitTipView:_btncancelOnClick()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.ContinueGame)
	self:closeThis()
end

function MatchGameFightQuitTipView:_btnrestartOnClick()
	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RestartGame)
	self:closeThis()
end

function MatchGameFightQuitTipView:_editableInitView()
	self.targetItemMap = self:getUserDataTb_()

	gohelper.setActive(self._gotargetItem, false)
	NavigateMgr.instance:addEscape(ViewName.MatchGameFightQuitTipView, self._btncancelOnClick, self)
end

function MatchGameFightQuitTipView:onUpdateParam()
	return
end

function MatchGameFightQuitTipView:onOpen()
	if self.viewParam then
		self.targetGoalData = self.viewParam.targetGoalData or {}
	end

	self:refreshTarget()
end

function MatchGameFightQuitTipView:refreshTarget()
	local gameInfoData = MatchGameFightModel.instance:getGameInfoData()
	local goalData = MatchGameFightModel.instance:getFightGoalData(gameInfoData.mapLevelId)

	if goalData and #goalData.goalList > 0 then
		for index, goalInfo in ipairs(goalData.goalList) do
			local targetItem = self.targetItemMap[index]

			if not targetItem then
				targetItem = {
					goalInfo = goalInfo,
					index = index,
					type = goalInfo[1],
					go = gohelper.clone(self._gotargetItem, self._gotargetContent, "targetItem" .. index)
				}
				targetItem.txtTarget = gohelper.findChildText(targetItem.go, "txt_target")
				targetItem.goUnfinish = gohelper.findChild(targetItem.go, "result/go_unfinish")
				targetItem.goFinish = gohelper.findChild(targetItem.go, "result/go_finish")
				self.targetItemMap[index] = targetItem
			end

			gohelper.setActive(targetItem.go, true)

			if targetItem.type == MatchGameFightEnum.FightTargetType.MatchElementNum then
				local elementConfig = MatchGameFightConfig.instance:getElementConfig(goalInfo[2])

				targetItem.txtTarget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("matchgame_fight_goal_match"), {
					goalInfo[3],
					elementConfig.name
				})

				local elementNum = MatchGameFightModel.instance:getMatchElementNum(goalInfo[2])

				targetItem.isGet = elementNum >= goalInfo[3]
			elseif targetItem.type == MatchGameFightEnum.FightTargetType.KillAll then
				targetItem.txtTarget.text = luaLang("matchgame_fight_goal_killAll")
				targetItem.isGet = self.targetGoalData.enemyHp <= 0 and self.targetGoalData.curWaveCount >= self.targetGoalData.totalWaveCount
			elseif targetItem.type == MatchGameFightEnum.FightTargetType.RoundNum then
				targetItem.txtTarget.text = GameUtil.getSubPlaceholderLuaLang(luaLang("matchgame_fight_goal_roundNum"), {
					goalInfo[2]
				})
				targetItem.isGet = self.targetGoalData.curRoundCount <= goalInfo[2]
			end

			gohelper.setActive(targetItem.goUnfinish, not targetItem.isGet)
			gohelper.setActive(targetItem.goFinish, targetItem.isGet)
		end
	end
end

function MatchGameFightQuitTipView:onClose()
	return
end

function MatchGameFightQuitTipView:onDestroyView()
	return
end

return MatchGameFightQuitTipView

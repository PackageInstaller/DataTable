-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wushenshou/view/WuShenPrePareView.lua

module("logic.extensions.wushenshou.view.WuShenPrePareView", package.seeall)

local WuShenPrePareView = class("WuShenPrePareView", MissionView)

function WuShenPrePareView:ctor()
	WuShenPrePareView.super.ctor(self)

	self._noForbit = nil
end

function WuShenPrePareView:buildUI()
	WuShenPrePareView.super.buildUI(self)
end

function WuShenPrePareView:onEnter()
	self:onEnterInherit()
	GameUtil.SetActive(self._btnGuide, false)

	self._shenshouType = self:getFirstParam() or 1

	self:_setDescStr("", "", nil)
	self:procMid()
	GameUtil.SetActive(self._petButton, false)
	GameUtil.SetActive(self._videoButton, false)
end

function WuShenPrePareView:procMid()
	local taskes = TaskModel.instance:getCurrentTriggerTaskesByType(GameEnum.TaskType.Main)
	local taskId = taskes[1]:getTaskId()
	local taskCo = TaskConfig.instance:getTaskCo(taskId)
	local chapterId = checknumber(taskCo.chapterId)
	local cfg = TaskConfig.instance:getChapterCo(chapterId)
	local taskId = cfg and cfg.taskes[checknumber(taskCo.chapterOrder)] or 0
	local titleStr = ""

	printInfo("test chapterId:chapterOrder", chapterId, taskId)

	if chapterId == 1 then
		if taskId == 2 then
			titleStr = "杰伦的战斗训练"
		elseif taskId == 6 then
			titleStr = "格兰特的入学考核"
		end
	end

	local levelStr = ""
	local ruleDesc = "击败敌方阵容即可通关"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
end

function WuShenPrePareView:onEnterFinished()
	WuShenPrePareView.super.onEnterFinished(self)

	if self._noForbit then
		for i, v in ipairs(BagPetsController.instance:getFightBagPet()) do
			if not TableUtil.isHad(self._noForbit, v.raceId) then
				BagPetsFacade.instance:setPetForbit(v.petId, true)
			end
		end
	end

	settimer(1, self._onRefresh, self, false)
end

function WuShenPrePareView:_onRefresh()
	removetimer(self._onRefresh, self)
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
end

function WuShenPrePareView:onExit()
	WuShenPrePareView.super.onExit(self)
	removetimer(self._onRefresh, self)
end

function WuShenPrePareView:onExitFinished()
	WuShenPrePareView.super.onExitFinished(self)
	GameUtil.SetActive(self._petButton, true)

	if not self._noForbit then
		return nil
	end

	for i, v in ipairs(BagPetsController.instance:getFightBagPet()) do
		if not TableUtil.isHad(self._noForbit, v.raceId) then
			BagPetsFacade.instance:setPetForbit(v.petId, false)
		end
	end

	self._noForbit = nil
end

function WuShenPrePareView:_onClickStart()
	if not FormationModel.instance:isCurFormationEmpty() then
		self:_startClg()
	end
end

function WuShenPrePareView:_startClg()
	GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._startNow, self)

	if FormationController.instance:SaveFormationEx() then
		return
	else
		self:_startNow()
	end
end

function WuShenPrePareView:_startNow()
	self:_setBattleResultTxtTitle()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	TaskAgent.instance:sendTaskFightMonsterReq(self._shenshouType, BattleSettlementModel.Enum.GodMonster)

	WushenViewController.IS_NEED_SHOW_GAS = true
end

return WuShenPrePareView

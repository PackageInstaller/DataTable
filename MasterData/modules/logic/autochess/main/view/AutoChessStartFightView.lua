-- chunkname: @modules/logic/autochess/main/view/AutoChessStartFightView.lua

module("modules.logic.autochess.main.view.AutoChessStartFightView", package.seeall)

local AutoChessStartFightView = class("AutoChessStartFightView", BaseView)

function AutoChessStartFightView:onInitView()
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessStartFightView:_onEscapeBtnClick()
	return
end

function AutoChessStartFightView:_editableInitView()
	NavigateMgr.instance:addEscape(ViewName.AutoChessStartFightView, self._onEscapeBtnClick, self)
end

function AutoChessStartFightView:onOpen()
	local groupId = AudioMgr.instance:getIdFromString("autochess")
	local stateId = AudioMgr.instance:getIdFromString("battle")

	AudioMgr.instance:setSwitch(groupId, stateId)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_battle_enter)
	TaskDispatcher.runDelay(self.closeThis, self, 1.5)

	local chessMo = AutoChessModel.instance:getChessMo()
	local roundType = chessMo.lastSvrFight.roundType

	if roundType == AutoChessEnum.RoundType.BOSS then
		local actMo = Activity182Model.instance:getActMo()
		local bossId = actMo:getGameMo(actMo.activityId, AutoChessEnum.ModuleId.PVP).bossId
		local bossCfg = lua_auto_chess_boss.configDict[bossId]

		if bossCfg then
			self._simageBg:LoadImage(ResUrl.getMovingChessIcon(bossCfg.loadingImage, "handbook"))

			return
		end
	end

	self._simageBg:LoadImage(ResUrl.getMovingChessIcon("v2a5_autochess_anim_decbg"))
end

function AutoChessStartFightView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return AutoChessStartFightView

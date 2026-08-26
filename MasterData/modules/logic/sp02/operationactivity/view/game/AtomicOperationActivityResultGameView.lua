-- chunkname: @modules/logic/sp02/operationactivity/view/game/AtomicOperationActivityResultGameView.lua

module("modules.logic.sp02.operationactivity.view.game.AtomicOperationActivityResultGameView", package.seeall)

local AtomicOperationActivityResultGameView = class("AtomicOperationActivityResultGameView", BaseView)

function AtomicOperationActivityResultGameView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_FullBG")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "root/Score/#txt_score")
	self._imagelevel = gohelper.findChildImage(self.viewGO, "root/Score/#image_level")
	self._gorewardItem = gohelper.findChild(self.viewGO, "root/Reward/#go_rewardItem")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/Reward/#go_rewardItem/iconitem/#txt_num")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "root/LayoutGroup/#btn_Finished")
	self._btnNew = gohelper.findChildButtonWithAudio(self.viewGO, "root/LayoutGroup/#btn_New")
	self._txtGameTimes = gohelper.findChildText(self.viewGO, "root/LayoutGroup/#btn_New/#txt_GameTimes")
	self._txtCombo = gohelper.findChildText(self.viewGO, "root/Combo/#txt_combo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityResultGameView:addEvents()
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
	self._btnNew:AddClickListener(self._btnNewOnClick, self)
end

function AtomicOperationActivityResultGameView:removeEvents()
	self._btnFinished:RemoveClickListener()
	self._btnNew:RemoveClickListener()
end

function AtomicOperationActivityResultGameView:_btnFinishedOnClick()
	AtomicOperationActivityGameController.instance:exitGame()
end

function AtomicOperationActivityResultGameView:_btnNewOnClick()
	AtomicOperationActivityGameController.instance:restartGame()
end

function AtomicOperationActivityResultGameView:_editableInitView()
	self._txtReaminTime = gohelper.findChildTextMesh(self.viewGO, "root/LayoutGroup/#btn_New/#go_txtlimit/txt")
end

function AtomicOperationActivityResultGameView:onUpdateParam()
	return
end

function AtomicOperationActivityResultGameView:onOpen()
	self:refreshUI()
end

function AtomicOperationActivityResultGameView:refreshUI()
	local gameInfoMo = AtomicOperationActivityGameModel.instance:getInfoMo()

	self._txtScoreNum.text = tostring(gameInfoMo.curScore)

	local rankStr, rewardNum = AtomicOperationActivityHelper.getScoreLevel(gameInfoMo.curScore)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imagelevel, "v3a3_eliminate_level_" .. string.lower(rankStr))

	self._txtnum.text = tostring(rewardNum)

	local maxRewardTimes = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.DailyRewardGameCount)
	local infoMo = AtomicOperationActivityModel.instance:getCurInfoMo()
	local remainTimes = math.max(0, maxRewardTimes - infoMo.totalRewardCount)
	local timeDesc

	self._txtReaminTime.text = remainTimes > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_summon_progress_remain_game_time_desc"), remainTimes) or luaLang("sp02_summon_progress_no_game_time_desc")

	if not gameInfoMo.maxComboCount then
		self._txtCombo.text = tostring(gameInfoMo.maxComboCount)
	end
end

function AtomicOperationActivityResultGameView:onClose()
	return
end

function AtomicOperationActivityResultGameView:onDestroyView()
	return
end

return AtomicOperationActivityResultGameView

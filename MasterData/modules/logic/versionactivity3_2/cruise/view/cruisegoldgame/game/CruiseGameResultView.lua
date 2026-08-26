-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGameResultView.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGameResultView", package.seeall)

local CruiseGameResultView = class("CruiseGameResultView", BaseView)

function CruiseGameResultView:onInitView()
	self.btn_New = gohelper.findChildButton(self.viewGO, "Right/LayoutGroup/#btn_New")
	self.btn_Finished = gohelper.findChildButton(self.viewGO, "Right/LayoutGroup/#btn_Finished")
	self.txt_GameTimes = gohelper.findChildTextMesh(self.viewGO, "Right/LayoutGroup/#btn_New/#txt_GameTimes")
	self.Defeat = gohelper.findChild(self.viewGO, "pointResult/Defeat")
	self.Victory = gohelper.findChild(self.viewGO, "pointResult/Victory")
	self.Draw = gohelper.findChild(self.viewGO, "pointResult/Draw")
	self.txt_Descr = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_Descr")
	self.textBonusNum = gohelper.findChildTextMesh(self.viewGO, "Right/#go_reward/#go_rewardItem/iconitem/#txt_num")
end

function CruiseGameResultView:addEvents()
	self.addClickCb(self, self.btn_New, self.onClickBtnBtnNew, self)
	self.addClickCb(self, self.btn_Finished, self.onClickBtnFinished, self)
end

function CruiseGameResultView:onOpen()
	self.resultType = Activity218Model.instance.resultType

	gohelper.setActive(self.Victory, self.resultType == Activity218Enum.GameResultType.Victory)
	gohelper.setActive(self.Defeat, self.resultType == Activity218Enum.GameResultType.Defeat)
	gohelper.setActive(self.Draw, self.resultType == Activity218Enum.GameResultType.Draw)

	if self.resultType == Activity218Enum.GameResultType.Victory then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)

		self.txt_Descr.text = luaLang("CruiseGame_3")
	elseif self.resultType == Activity218Enum.GameResultType.Defeat then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)

		self.txt_Descr.text = luaLang("CruiseGame_4")
	elseif self.resultType == Activity218Enum.GameResultType.Draw then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)

		self.txt_Descr.text = luaLang("CruiseGame_5")
	end

	self.cfg_activity218_control = Activity218Config.instance:getCfg_activity218_control()
	self.totalCount = self.cfg_activity218_control.times
	self.finishGameCount = Activity218Model.instance:getFinishGameCount()
	self.txt_GameTimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("CruiseGame_1"), {
		self.totalCount - self.finishGameCount,
		self.totalCount
	})
	self.textBonusNum.text = Activity218Config.instance:getGamePoint(self.resultType)

	gohelper.setActive(self.btn_New, self.finishGameCount < self.totalCount)
end

function CruiseGameResultView:onClose()
	return
end

function CruiseGameResultView:onDestroyView()
	return
end

function CruiseGameResultView:onClickBtnFinished()
	Activity218Controller.instance:exiteGame()
end

function CruiseGameResultView:onClickBtnBtnNew()
	if self.finishGameCount < self.totalCount then
		Activity218Controller.instance:startNext()
	end
end

return CruiseGameResultView

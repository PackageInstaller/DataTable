-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameResultView.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameResultView", package.seeall)

local DeleikeGameResultView = class("DeleikeGameResultView", BaseView)

function DeleikeGameResultView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._txtTarget = gohelper.findChildText(self.viewGO, "targets/TargetItem/#txt_Target")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DeleikeGameResultView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function DeleikeGameResultView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function DeleikeGameResultView:onClickModalMask()
	self:_btnCloseOnClick()
end

function DeleikeGameResultView:_btnCloseOnClick()
	self:closeThis()
	DeleikeGameMgr.instance:endGame()
end

function DeleikeGameResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.Deleike.game_success)
	DeleikeGameMgr.instance:setInputLocked(true)

	local gameCfg = DeleikeGameMgr.instance.gameCfg

	self._txtTarget.text = gameCfg.targetDesc
end

return DeleikeGameResultView

-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErTipItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTipItem", package.seeall)

local MoLiDeErTipItem = class("MoLiDeErTipItem", LuaCompBase)

function MoLiDeErTipItem:init(go)
	self.viewGO = go
	self._txtTips = gohelper.findChildText(self.viewGO, "#txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErTipItem:_editableInitView()
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function MoLiDeErTipItem:setMsg(msg)
	self._txtTips.text = msg
end

function MoLiDeErTipItem:appearAnimation()
	TaskDispatcher.runDelay(self.onAnimTimeEnd, self, MoLiDeErEnum.DelayTime.TipHide)
end

function MoLiDeErTipItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErTipItem:onAnimTimeEnd()
	TaskDispatcher.cancelTask(self.onAnimTimeEnd, self)
	MoLiDeErGameController.instance:dispatchEvent(MoLiDeErEvent.GameTipRecycle, self)
end

function MoLiDeErTipItem:reset()
	self:setActive(false)
	TaskDispatcher.cancelTask(self.onAnimTimeEnd, self)
end

function MoLiDeErTipItem:onDestroy()
	TaskDispatcher.cancelTask(self, self.onAnimTimeEnd)
end

return MoLiDeErTipItem

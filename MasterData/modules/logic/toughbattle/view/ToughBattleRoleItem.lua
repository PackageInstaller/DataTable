-- chunkname: @modules/logic/toughbattle/view/ToughBattleRoleItem.lua

module("modules.logic.toughbattle.view.ToughBattleRoleItem", package.seeall)

local ToughBattleRoleItem = class("ToughBattleRoleItem", LuaCompBase)

function ToughBattleRoleItem:init(go)
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._goselect = gohelper.findChild(go, "#go_select")
	self._imgrole = gohelper.findChildImage(go, "#simage_rolehead")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#btn_click")
end

function ToughBattleRoleItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
end

function ToughBattleRoleItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function ToughBattleRoleItem:initData(data)
	self._isNew = data.isNewGet
	self._co = data.co

	if self._co and not self._isNew then
		UISpriteSetMgr.instance:setToughBattleRoleSprite(self._imgrole, "roleheadpic0" .. self._co.sort)
	else
		UISpriteSetMgr.instance:setToughBattleRoleSprite(self._imgrole, "roleheadempty")
	end
end

function ToughBattleRoleItem:playFirstAnim()
	if self._isNew then
		self._anim:Play("get", 0, 0)
		TaskDispatcher.runDelay(self._delaySetIcon, self, 0.3)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_gather)
	else
		self._anim:Play("idle")
	end
end

function ToughBattleRoleItem:_delaySetIcon()
	UISpriteSetMgr.instance:setToughBattleRoleSprite(self._imgrole, "roleheadpic0" .. self._co.sort)
end

function ToughBattleRoleItem:setClickCallBack(callback, callobj)
	self._clickCallBack = callback
	self._callobj = callobj
end

function ToughBattleRoleItem:_onClick()
	if not self._co then
		GameFacade.showToast(ToastEnum.ToughBattleClickEmptyHero)

		return
	end

	if self._clickCallBack then
		self._clickCallBack(self._callobj, self._co)
	end
end

function ToughBattleRoleItem:setSelect(co)
	gohelper.setActive(self._goselect, co and co == self._co)
end

function ToughBattleRoleItem:onDestroy()
	TaskDispatcher.cancelTask(self._delaySetIcon, self)

	self._clickCallBack = nil
	self._callobj = nil
end

return ToughBattleRoleItem

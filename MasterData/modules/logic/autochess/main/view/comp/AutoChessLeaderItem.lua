-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessLeaderItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessLeaderItem", package.seeall)

local AutoChessLeaderItem = class("AutoChessLeaderItem", LuaCompBase)

function AutoChessLeaderItem:init(go)
	self.go = go
	self._btnClick = gohelper.findChildButtonWithAudio(go, "#btn_Click")
	self._goSelectFrame = gohelper.findChild(go, "#go_SelectFrame")
	self._goUnLock = gohelper.findChild(go, "#go_UnLock")
	self._goMesh = gohelper.findChild(go, "#go_UnLock/Mesh")
	self._imageRole = gohelper.findChildImage(go, "#go_UnLock/Mesh/role")
	self._txtHp = gohelper.findChildText(go, "#go_UnLock/hp/#txt_Hp")
	self._btnCheck = gohelper.findChildButtonWithAudio(go, "#go_UnLock/#btn_Check")
	self._goSelect = gohelper.findChild(go, "#go_Select")
	self._goLock = gohelper.findChild(go, "#go_Lock")
	self._txtLock = gohelper.findChildText(go, "#go_Lock/#txt_Lock")
	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goMesh, AutoChessMeshComp)
end

function AutoChessLeaderItem:addEventListeners()
	self.addClickCb(self, self._btnClick, self.onClick, self)
	self.addClickCb(self, self._btnCheck, self.onCheck, self)
end

function AutoChessLeaderItem:setData(id)
	if id then
		self.id = id
		self.config = AutoChessConfig.instance:getLeaderCfg(id)

		self.meshComp:setData(self.config.image, false, true)

		self._txtHp.text = self.config.hp

		gohelper.setActive(self.go, true)
	else
		local episodeId = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)

		if episodeId ~= 0 then
			local episodeName = AutoChessConfig.instance:getEpisodeCO(episodeId).name
			local txt = luaLang("autochess_leaderitem_unlock")

			self._txtLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, episodeName)
		end

		gohelper.setActive(self.go, episodeId ~= 0)
	end

	gohelper.setActive(self._goUnLock, id)
	gohelper.setActive(self._goLock, not id)
end

function AutoChessLeaderItem:setClickCallback(callback, callbackObj)
	self.callback = callback
	self.callbackObj = callbackObj

	gohelper.setActive(self._btnClick, true)
end

function AutoChessLeaderItem:setSelect(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
	gohelper.setActive(self._goSelectFrame, isSelect)
end

function AutoChessLeaderItem:onClick()
	if not self.id then
		return
	end

	if self.callback then
		self.callback(self.callbackObj, self.id)
	end
end

function AutoChessLeaderItem:setActiveChesk(bool)
	gohelper.setActive(self._btnCheck, bool)
end

function AutoChessLeaderItem:onCheck()
	ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
		leaderId = self.id
	})
end

return AutoChessLeaderItem

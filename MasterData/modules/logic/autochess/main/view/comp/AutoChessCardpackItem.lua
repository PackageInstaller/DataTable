-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessCardpackItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessCardpackItem", package.seeall)

local AutoChessCardpackItem = class("AutoChessCardpackItem", LuaCompBase)

function AutoChessCardpackItem:init(go)
	self.go = go
	self.goSelect = gohelper.findChild(go, "go_select")
	self.simageCardpack = gohelper.findChildSingleImage(go, "simage_cardpack")
	self.txtName = gohelper.findChildText(go, "txt_name")
	self.txtDesc = gohelper.findChildText(go, "scroll_desc/viewport/txt_desc")
	self.goLock = gohelper.findChild(go, "go_lock")
	self.txtUnlock = gohelper.findChildText(go, "go_lock/txt_unlock")
	self.btnClick = gohelper.findChildButton(go, "btn_Click")
	self.btnCheck = gohelper.findChildButtonWithAudio(go, "btn_Check")
	self.goNew = gohelper.findChild(go, "go_new")
end

function AutoChessCardpackItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._btnOnClick, self)
	self.addClickCb(self, self.btnCheck, self._btnCheckOnClick, self)
end

function AutoChessCardpackItem:_btnCheckOnClick()
	if self.checkCallback then
		self.checkCallback(self.checkCallbackObj, self.config.id)
	end
end

function AutoChessCardpackItem:_btnOnClick()
	if self.clickCallback then
		self.clickCallback(self.clickCallbackObj, self.config.id)
	end
end

function AutoChessCardpackItem:setData(config)
	self.config = config

	self.simageCardpack:LoadImage(ResUrl.getMovingChessIcon(self.config.icon, "handbook"))

	self.txtName.text = self.config.name

	local actMo = Activity182Model.instance:getActMo()
	local unlockLvl = AutoChessConfig.instance:getCardpackUnlockLevel(self.config.id)

	self.isLock = unlockLvl > actMo.warnLevel

	gohelper.setActive(self.goLock, self.isLock)

	self.txtUnlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_warnlevel_unlock"), unlockLvl)
	self.txtDesc.text = self.config.desc
end

function AutoChessCardpackItem:setSelect(bool)
	gohelper.setActive(self.goSelect, bool)
end

function AutoChessCardpackItem:setClickCallback(callback, callbackObj)
	self.clickCallback = callback
	self.clickCallbackObj = callbackObj

	gohelper.setActive(self.btnClick, true)
end

function AutoChessCardpackItem:setCheckCallback(callback, callbackObj)
	self.checkCallback = callback
	self.checkCallbackObj = callbackObj

	gohelper.setActive(self.btnCheck, true)
end

function AutoChessCardpackItem:refreshNewTag()
	gohelper.setActive(self.goNew, (not self.isLock or nil) and AutoChessHelper.getUnlockReddot(AutoChessStrEnum.ClientReddotKey.Cardpack, self.config.id))
end

return AutoChessCardpackItem

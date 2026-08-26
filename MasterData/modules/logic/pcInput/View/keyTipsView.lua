-- chunkname: @modules/logic/pcInput/View/keyTipsView.lua

module("modules.logic.pcInput.View.keyTipsView", package.seeall)

local keyTipsView = class("keyTipsView", LuaCompBase)
local ResPath = "ui/viewres/pc/pcbuttonitem.prefab"

function keyTipsView:ctor(param)
	self._keyName = param.keyname
	self._activityid = param.activityId
	self._keyid = param.keyid
end

function keyTipsView:init(go)
	self._go = go

	self:load()
end

function keyTipsView:load()
	self._loader = PrefabInstantiate.Create(self._go)

	self._loader:startLoad(ResPath, keyTipsView._onCallback, self)
end

function keyTipsView:_onCallback()
	self._instGO = self._loader:getInstGO()

	local keyTips = GameUtil.playerPrefsGetNumberByUserId("keyTips", 0)

	gohelper.setActive(self._instGO, not GuideController.instance:isAnyGuideRunning() and keyTips == 1)

	self._text1 = gohelper.findChildText(self._instGO, "btn_1/#txt_btn")
	self._text2 = gohelper.findChildText(self._instGO, "btn_2/#txt_btn")
	self._btn1 = gohelper.findChild(self._instGO, "btn_1")
	self._btn2 = gohelper.findChild(self._instGO, "btn_2")

	if not self._keyName then
		local key = PCInputModel.instance:getKey(self._activityid, self._keyid)

		key = PCInputController.instance:KeyNameToDescName(self._keyName)

		if self:selectType(self._keyName) == 1 then
			self._btn1:SetActive(true)
			self._btn2:SetActive(false)

			self._text1.text = self._keyName
		else
			self._btn1:SetActive(false)
			self._btn2:SetActive(true)

			self._text2.text = self._keyName
		end
	end
end

function keyTipsView:Show(bshow)
	if self._instGO then
		self._instGO:SetActive(bshow and not GuideController.instance:isAnyGuideRunning() and GameUtil.playerPrefsGetStringByUserId("keyTips", "0") == 1)
	end

	if self._go then
		gohelper.setActive(self._go, bshow)
	end
end

function keyTipsView:selectType(key)
	if string.len(key) > 1 then
		return 2
	else
		return 1
	end
end

function keyTipsView:Refresh(activityId, keyid)
	self._activityid = activityId
	self._keyid = keyid
	self._keyName = nil

	if self._instGO then
		self:_onCallback()
	end
end

function keyTipsView:RefreshByKeyName(keyName)
	self._keyName = keyName
	self._activityid = nil
	self._keyid = nil

	if self._instGO then
		self:_onCallback()
	end
end

function keyTipsView:addEventListeners()
	self.addEventCb(self, SettingsController.instance, SettingsEvent.OnKeyTipsChange, self._onCallback, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function keyTipsView:removeEventListeners()
	self.removeEventCb(self, SettingsController.instance, SettingsEvent.OnKeyTipsChange, self._onCallback, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function keyTipsView:onOpenViewCallBack(viewName)
	if viewName == ViewName.GuideView then
		self:Show(false)
	end
end

function keyTipsView:onCloseViewCallBack(viewName)
	if viewName == ViewName.GuideView then
		self:Show(true)
	end
end

function keyTipsView:onStart()
	return
end

function keyTipsView:onDestroy()
	return
end

return keyTipsView

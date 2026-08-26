-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174BetSuccessView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174BetSuccessView", package.seeall)

local Act174BetSuccessView = class("Act174BetSuccessView", BaseView)

function Act174BetSuccessView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._txtRule = gohelper.findChildText(self.viewGO, "#txt_Rule")
	self._imageHpPercent = gohelper.findChildImage(self.viewGO, "hp/bg/fill")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174BetSuccessView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Act174BetSuccessView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Act174BetSuccessView:_btnCloseOnClick()
	self:closeThis()
end

function Act174BetSuccessView:_editableInitView()
	self.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)
	self.hpEffList = self:getUserDataTb_()

	for i = 1, self.maxHp do
		self.hpEffList[#self.hpEffList + 1] = gohelper.findChild(self.viewGO, "hp/bg/#hp0" .. i)
	end
end

function Act174BetSuccessView:onUpdateParam()
	return
end

function Act174BetSuccessView:onOpen()
	local actInfo = Activity174Model.instance:getActInfo()
	local gameInfo = actInfo:getGameInfo()

	self._imageHpPercent.fillAmount = gameInfo.hp / self.maxHp

	for i = 1, self.maxHp do
		gohelper.setActive(self.hpEffList[i], i == gameInfo.hp)
	end

	TaskDispatcher.runDelay(self.closeThis, self, 3)
end

function Act174BetSuccessView:onClose()
	return
end

function Act174BetSuccessView:onDestroyView()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return Act174BetSuccessView

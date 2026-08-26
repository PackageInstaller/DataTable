-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceReRollView.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceReRollView", package.seeall)

local Rouge2_MapDiceReRollView = class("Rouge2_MapDiceReRollView", BaseView)

function Rouge2_MapDiceReRollView:onInitView()
	self._goRedice = gohelper.findChild(self.viewGO, "root/#go_Redice")
	self._txtRediceTips = gohelper.findChildText(self.viewGO, "root/#go_Redice/#txt_RediceTips")
	self._txtStartRediceTips = gohelper.findChildText(self.viewGO, "root/#go_Redice/#btn_StartRedice/#txt_StartRediceTips")
	self._btnStartRedice = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Redice/#btn_StartRedice", AudioEnum.Rouge2.DiceReRoll)
	self._btnAbortRedice = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_Redice/#btn_AbortRedice")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapDiceReRollView:addEvents()
	self._btnStartRedice:AddClickListener(self._btnStartRediceOnClick, self)
	self._btnAbortRedice:AddClickListener(self._btnAbortRediceOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
end

function Rouge2_MapDiceReRollView:removeEvents()
	self._btnStartRedice:RemoveClickListener()
	self._btnAbortRedice:RemoveClickListener()
end

function Rouge2_MapDiceReRollView:_btnStartRediceOnClick()
	if not self._isEnoughCoin then
		GameFacade.showToast(ToastEnum.Rouge2CantReDice)

		return
	end

	Rouge2_Rpc.instance:sendRouge2ReRollCheckRequest()
end

function Rouge2_MapDiceReRollView:_btnAbortRediceOnClick()
	self.viewContainer:endAttrCheck()
end

function Rouge2_MapDiceReRollView:_editableInitView()
	self._mainView = self.viewContainer:getMainView()

	gohelper.setActive(self._goRedice, false)
end

function Rouge2_MapDiceReRollView:onOpen()
	self:initViewParams()
end

function Rouge2_MapDiceReRollView:initViewParams()
	self._checkResInfo = self._mainView:getCheckResInfo()
	self._checkCo = self._checkResInfo and self._checkResInfo:getCheckConfig()
	self._checkId = self._checkResInfo and self._checkResInfo:getCheckId()
	self._checkDiceRes = self._checkResInfo and self._checkResInfo:getCheckDiceRes()
	self._checkRes = self._checkResInfo and self._checkResInfo:getCheckRes()
	self._isSucceed = self._checkRes ~= Rouge2_MapEnum.AttrCheckResult.Failure
	self._reRollTimes = self._checkResInfo and self._checkResInfo:getCheckReRollTimes()
end

function Rouge2_MapDiceReRollView:checkShowRediceTips()
	local retryCostNum = Rouge2_MapAttrCheckHelper.getRediceCostNum(self._checkId, self._reRollTimes + 1)
	local curRevivalCoin = Rouge2_Model.instance:getRevivalCoin()
	local isFail = self._checkRes == Rouge2_MapEnum.AttrCheckResult.Failure

	self._isEnoughCoin = retryCostNum > 0 and retryCostNum <= curRevivalCoin

	local isFirstDice = self._reRollTimes <= 0

	if isFail then
		::label_9_0::

		if isFirstDice then
			if not self._isEnoughCoin then
				local showRediceTips = not isFirstDice

				gohelper.setActive(self._goRedice, showRediceTips)

				if not showRediceTips then
					if isFail and not self._isEnoughCoin then
						self.viewContainer:endAttrCheck()
					end

					return
				end

				local goActiveRedice = gohelper.findChild(self._btnStartRedice.gameObject, "go_Active")
				local goDisactiveRedice = gohelper.findChild(self._btnStartRedice.gameObject, "go_Disactive")

				gohelper.setActive(goActiveRedice, self._isEnoughCoin)
				gohelper.setActive(goDisactiveRedice, not self._isEnoughCoin)

				self._txtRediceTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_mapdiceview_redicetips"), retryCostNum)
				self._txtStartRediceTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_mapdiceview_startredicetips"), curRevivalCoin)
			end
		end
	end
end

function Rouge2_MapDiceReRollView:_onUpdateMapInfo()
	self:hideTips()
	self:initViewParams()
end

function Rouge2_MapDiceReRollView:hideTips()
	gohelper.setActive(self._goRedice, false)
end

function Rouge2_MapDiceReRollView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return Rouge2_MapDiceReRollView

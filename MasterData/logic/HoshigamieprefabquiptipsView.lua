-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamieprefabquiptipsView.lua

module("logic.extensions.hoshigami.view.HoshigamieprefabquiptipsView", package.seeall)

local HoshigamieprefabquiptipsView = class("HoshigamieprefabquiptipsView", HoshigamiequiptipBaseView)

function HoshigamieprefabquiptipsView:onEnter()
	HoshigamieprefabquiptipsView.super.onEnter(self)
	GlobalDispatcher:addListener(HoshigamiController.PM_EquipHoshigamiRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
	self:_updateView()
end

function HoshigamieprefabquiptipsView:onExit()
	HoshigamieprefabquiptipsView.super.onExit(self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_EquipHoshigamiRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
end

function HoshigamieprefabquiptipsView:_onClickstrengthBtn()
	UIStateManager.instance:push(ViewName.HoshigamistrengthView, self._hoshigamiId)
	self:close()
end

function HoshigamieprefabquiptipsView:_onClicktakeonBtn()
	if self._posType then
		HoshigamiModel.instance:changeHoshigamiInPrefabSuit(self._hoshigamiId, self._posType)
		GlobalDispatcher:dispatch(HoshigamiController.TakeOnInPrefabSuit)
	end

	self:close()
end

function HoshigamieprefabquiptipsView:_onClicktakeoffBtn()
	if self._posType then
		HoshigamiModel.instance:changeHoshigamiInPrefabSuit(nil, self._posType)
		GlobalDispatcher:dispatch(HoshigamiController.TakeOnInPrefabSuit)
	end

	self:close()
end

function HoshigamieprefabquiptipsView:_updateView()
	local params = self:getOpenParam()

	self._hoshigamiId = params[1]

	local hideBtn = params[2]

	self._hoshigamiInfo = HoshigamiModel.instance:getHoshigamisInfo(self._hoshigamiId)

	local info = self._hoshigamiInfo
	local showStren = false
	local showTakeOn = false
	local showTakeOff = false
	local showCompareHoshigamiId = false
	local takeOnStr = "装备"

	self._posType = nil

	if info then
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)

		self._posType = cfg.positionType

		MaterialMgr.setIcon(self._iconGo, MatType.Hoshigami, cfg.id)

		if not self._isCompare then
			showTakeOn, showTakeOff, takeOnStr, showCompareHoshigamiId = self:_checkTakeOnAndOffShow(cfg, info)
			showStren = not HoshigamiModel.instance:isMaxStren(info.hoshigamiId)
		end

		if showCompareHoshigamiId then
			self:showTabAt(self._compareConGo, ViewName.HoshigamieprefabquipcomparetipsView, showCompareHoshigamiId)
		end
	end

	self._takeonBtnText.text = takeOnStr

	self:_setRootPos(showCompareHoshigamiId)
	goutil.setActive(self._compareConGo, showCompareHoshigamiId)
	goutil.setActive(self._strengthBtn.gameObject, not hideBtn and showStren)
	goutil.setActive(self._takeonBtn.gameObject, not hideBtn and showTakeOn)
	goutil.setActive(self._takeoffBtn.gameObject, not hideBtn and showTakeOff)
	goutil.setActive(self._wearTipTextGo, self._isCompare)
end

function HoshigamieprefabquiptipsView:_checkTakeOnAndOffShow(cfg, info)
	local showTakeOn = false
	local showTakeOff = false
	local takeOnStr = "装备"
	local showCompareHoshigamiId = false

	if HoshigamiModel.instance:isWearHoshigamiInPrefabSuit(info.hoshigamiId) then
		showTakeOff = true
	else
		local wearInfo = HoshigamiModel.instance:getCompareInfoInPrefabSuit(info.hoshigamiId)

		showTakeOn = true

		if wearInfo then
			showCompareHoshigamiId = wearInfo.hoshigamiId
			takeOnStr = "替换"
		end
	end

	return showTakeOn, showTakeOff, takeOnStr, showCompareHoshigamiId
end

function HoshigamieprefabquiptipsView:getCurrSuitInfos()
	local idList = HoshigamiModel.instance:getCurrEditPrefabIdList() or {}
	local list = {}

	for k, v in pairs(idList) do
		local info = HoshigamiModel.instance:getHoshigamisInfo(v)

		table.insert(list, info)
	end

	return list
end

return HoshigamieprefabquiptipsView

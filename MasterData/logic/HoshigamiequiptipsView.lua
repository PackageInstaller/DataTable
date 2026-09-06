-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiequiptipsView.lua

module("logic.extensions.hoshigami.view.HoshigamiequiptipsView", package.seeall)

local HoshigamiequiptipsView = class("HoshigamiequiptipsView", HoshigamiequiptipBaseView)

function HoshigamiequiptipsView:onEnter()
	HoshigamiequiptipsView.super.onEnter(self)
	GlobalDispatcher:addListener(HoshigamiController.PM_EquipHoshigamiRes, self._updateView, self)
	GlobalDispatcher:addListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
	self:_updateView()
end

function HoshigamiequiptipsView:onExit()
	HoshigamiequiptipsView.super.onExit(self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_EquipHoshigamiRes, self._updateView, self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_UnloadHoshigamiRes, self._updateView, self)
end

function HoshigamiequiptipsView:_onClickstrengthBtn()
	UIStateManager.instance:push(ViewName.HoshigamistrengthView, self._hoshigamiId, self._petId)
	self:close()
end

function HoshigamiequiptipsView:_onClicktakeonBtn()
	local function okFunc()
		HoshigamiAgent.instance:sendPM_EquipHoshigamiReq(self._petId, self._hoshigamiId)
		self:close()
	end

	if checknumber(self._hoshigamiInfo.equippedPetId) > 0 then
		local pet = BagPetsController.instance:getPet(self._hoshigamiInfo.equippedPetId)
		local cfg = CharacterConfig.instance:getPetCo(pet.raceId)
		local content = string.format("是否把%s的星神镶嵌到当前精灵上？", cfg.name)

		TipsFacade.instance:openPopupWindow("提示", content, okFunc)
	else
		okFunc()
	end
end

function HoshigamiequiptipsView:_onClicktakeoffBtn()
	HoshigamiAgent.instance:sendPM_UnloadHoshigamiReq(self._petId, self._hoshigamiId)
	self:close()
end

function HoshigamiequiptipsView:_updateView()
	self._petId = HoshigamiModel.instance:getCurrShowPetId()
	self._hoshigamiInfo = HoshigamiModel.instance:getHoshigamisInfo(self._hoshigamiId)

	local info = self._hoshigamiInfo
	local showStren = false
	local showTakeOn = false
	local showTakeOff = false
	local showCompareHoshigamiId = false
	local takeOnStr = "装备"

	if info then
		local cfg = HoshigamiConfig.instance:getHoshigamiCfg(info.defineId)

		MaterialMgr.setIcon(self._iconGo, MatType.Hoshigami, cfg.id)

		if not self._isCompare then
			showTakeOn, showTakeOff, takeOnStr, showCompareHoshigamiId = self:_checkTakeOnAndOffShow(cfg, info)
			showStren = not HoshigamiModel.instance:isMaxStren(info.hoshigamiId)
		end

		if showCompareHoshigamiId then
			self:showTabAt(self._compareConGo, ViewName.HoshigamiequipcomparetipsView, showCompareHoshigamiId)
		end
	end

	self._takeonBtnText.text = takeOnStr

	self:_setRootPos(showCompareHoshigamiId)
	goutil.setActive(self._compareConGo, showCompareHoshigamiId)
	goutil.setActive(self._strengthBtn.gameObject, showStren)
	goutil.setActive(self._takeonBtn.gameObject, showTakeOn)
	goutil.setActive(self._takeoffBtn.gameObject, showTakeOff)
	goutil.setActive(self._wearTipTextGo, self._isCompare)
end

function HoshigamiequiptipsView:_checkTakeOnAndOffShow(cfg, info)
	local showTakeOn = false
	local showTakeOff = false
	local takeOnStr = "装备"
	local showCompareHoshigamiId = false
	local petId = HoshigamiModel.instance:getCurrShowPetId()

	if info.equippedPetId == petId then
		showTakeOff = true
	else
		showTakeOn = true

		local wearInfo = HoshigamiModel.instance:getHoshigamiWithPosType(petId, cfg.positionType)

		if wearInfo then
			showCompareHoshigamiId = wearInfo.hoshigamiId
			takeOnStr = "替换"
		end
	end

	return showTakeOn, showTakeOff, takeOnStr, showCompareHoshigamiId
end

function HoshigamiequiptipsView:getCurrSuitInfos()
	local petId = HoshigamiModel.instance:getCurrShowPetId()

	return (HoshigamiModel.instance:getHoshigamisByPetId(petId))
end

return HoshigamiequiptipsView

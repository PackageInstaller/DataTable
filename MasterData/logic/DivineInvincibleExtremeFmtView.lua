-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtremeFmtView.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleExtremeFmtView", package.seeall)

local DivineInvincibleExtremeFmtView = class("DivineInvincibleExtremeFmtView", ViewComponent)

function DivineInvincibleExtremeFmtView:ctor()
	DivineInvincibleExtremeFmtView.super.ctor(self)
end

function DivineInvincibleExtremeFmtView:buildUI()
	DivineInvincibleExtremeFmtView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._fmtView = self:getGo("fmtView")
end

function DivineInvincibleExtremeFmtView:bindEvents()
	DivineInvincibleExtremeFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function DivineInvincibleExtremeFmtView:unbindEvents()
	DivineInvincibleExtremeFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineInvincibleExtremeFmtView:onEnter()
	DivineInvincibleExtremeFmtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo._activityId
	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)

	GameUtil.SetActive(self._fmtView, true)
	self:_onUpdate()
end

function DivineInvincibleExtremeFmtView:onExit()
	DivineInvincibleExtremeFmtView.super.onExit(self)
end

function DivineInvincibleExtremeFmtView:_onUpdate()
	for posId = 1, 9 do
		local mainGo = self._fmtView.transform:GetChild(posId - 1).gameObject

		GameUtil.SetActive(mainGo, true)

		local imgFinish = goutil.findChild(mainGo, "imgFinish")
		local iconAtlas = goutil.findChild(mainGo, "iconAtlas")
		local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
		local data = DivineInvincibleConfig.instance:getExtPassData(self._activityId, posId)
		local isFinish = self._clgMo:isFinishInExtPass(posId)
		local needTimes = self._clgMo:getNeedTimesInExtPass(posId)
		local stateKey

		if not string.nilorempty(data.validator) then
			local arr = string.split(data.validator, "$")

			stateKey = arr[2]
		end

		if stateKey then
			local state = (GameEnum.Races[stateKey] or 1) - 1

			GameUtil.setUIImageSpriteIdx(iconAtlas, state)
		end

		txtCount.text = needTimes

		GameUtil.SetActive(imgFinish, isFinish)
	end
end

function DivineInvincibleExtremeFmtView:_onClickTip()
	GameUtil.SetActive(self._fmtView, not GameUtil.GetActive(self._fmtView))
end

return DivineInvincibleExtremeFmtView

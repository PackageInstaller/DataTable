-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetverifybtnUI.lua

module("logic.extensions.petverify.view.PetverifybtnUI", package.seeall)

local PetverifybtnUI = class("PetverifybtnUI", ViewComponent)

function PetverifybtnUI:ctor()
	PetverifybtnUI.super.ctor(self)
end

function PetverifybtnUI:buildUI()
	PetverifybtnUI.super.buildUI(self)

	self.lvbg = self:getGo("lvbg")
	self._btnVerify = self:getBtn("btnVerify")
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "txtVerifyEffect")
	self._imgEffect = self:getGo("btnVerify")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "txtLv")
end

function PetverifybtnUI:bindEvents()
	PetverifybtnUI.super.bindEvents(self)
	self._btnVerify:AddClickListener(self._onClickVerify, self)
end

function PetverifybtnUI:unbindEvents()
	PetverifybtnUI.super.unbindEvents(self)
	self._btnVerify:RemoveClickListener()
end

function PetverifybtnUI:destroyUI()
	PetverifybtnUI.super.destroyUI(self)
end

function PetverifybtnUI:onEnter()
	PetverifybtnUI.super.onEnter(self)

	local params = self:getOpenParam()

	self._obj = params[1]
	self.clickCallBack = params[2]

	GlobalDispatcher:addListener(GlobalNotify.PetVerifySuccess, self._refresh, self)
	self:_refresh(buffId, buffLvl)
end

function PetverifybtnUI:onEnterFinished()
	PetverifybtnUI.super.onEnterFinished(self)
end

function PetverifybtnUI:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PetVerifySuccess, self._refresh, self)
	uGuiUtil.clearImage(self._imgEffect.gameObject)

	self._txtVerifyEffect.text = ""

	PetverifybtnUI.super.onExit(self)
end

function PetverifybtnUI:onExitFinished()
	PetverifybtnUI.super.onExitFinished(self)
end

function PetverifybtnUI:_refresh(buffId, buffLvl)
	if self._obj.chanllengeId == 1 then
		local cfg = TimeLimitedConfig.instance:getCircleFightCfg(self._challengeId)
		local verifyBuffCfg = PetVerifyBuffConfig.instance:getBuffCfgById(id)
	end

	if buffCfg then
		if buffLvl > 0 then
			self._txtVerifyEffect.text = string.format("%s \n%s", buffCfg.name, buffCfg.desc)

			GameUtil.SetActive(self.lvbg, true)
		else
			self._txtVerifyEffect.text = "未激活鼓舞"

			GameUtil.SetActive(self.lvbg, false)
		end

		self._txtLv.text = checknumber(buffLvl) > 0 and string.format("Lv.%d", buffLvl) or ""

		uGuiUtil.setSpriteToImage(self._imgEffect.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffCfg.icon))
	end
end

function PetverifybtnUI:_onClickVerify()
	GameUtil.callBack(self.clickCallBack)
end

return PetverifybtnUI

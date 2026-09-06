-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoorecycleView.lua

module("logic.extensions.zoo.view.ZoorecycleView", package.seeall)

local ZoorecycleView = class("ZoorecycleView", ViewComponent)

function ZoorecycleView:buildUI()
	ZoorecycleView.super.buildUI(self)

	self._enterBtn = self:getBtn("Nego_Main/enterBtn")
	self._cancelBtn = self:getBtn("Nego_Main/cancelBtn")
	self._closeBtn = self:getBtn("Nego_Main/Btn_Close")
	self._txtTip = self:getTxt("Nego_Main/Content")
	self._tipIcon = self:getGo("Nego_Main/icon")

	local txtTitle = self:getTxt("Nego_Main/txtTitle")
	local btnCancelTxt = self:getTxt("Nego_Main/cancelBtn/Text")
	local btnSureTxt = self:getTxt("Nego_Main/enterBtn/Text")

	txtTitle.text = lang("petzoo_animal_delete_title")
	btnSureTxt.text = lang("mail_confirm")
	btnCancelTxt.text = lang("mail_cancel")
end

function ZoorecycleView:bindEvents()
	ZoorecycleView.super.bindEvents(self)
	self._enterBtn:AddClickListener(self._onClickEnter, self)
	self._cancelBtn:AddClickListener(self.close, self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZoorecycleView:unbindEvents()
	ZoorecycleView.super.unbindEvents(self)
	self._enterBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
end

function ZoorecycleView:onEnter()
	ZoorecycleView.super.onEnter(self)

	self._animalId = self:getFirstParam()

	local value = ZooConfig.instance:getRecycleAnimalGain()
	local proxy = MaterialMgr.setCellByCfg(value, self._tipIcon)

	Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.5, 0.5, 1)

	local sp = string.split(value, ":")

	self._txtTip.text = string.format(lang("petzoo_animal_delete_tips"), sp[3])

	GlobalDispatcher:addListener(GlobalNotify.OnZooRecycleAnimal, self._onRecycleAnimal, self)
end

function ZoorecycleView:onExit()
	ZoorecycleView.super.onExit(self)
	MaterialMgr.resetAll(self._tipIcon)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooRecycleAnimal, self._onRecycleAnimal, self)
end

function ZoorecycleView:_onClickEnter()
	ZooController.instance:sendPM_ZooRecycleAnimalReq(self._animalId)
end

function ZoorecycleView:_onRecycleAnimal(animalId)
	if animalId == self._animalId then
		self:close()
	end
end

return ZoorecycleView

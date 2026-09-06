-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoofollowsureView.lua

module("logic.extensions.zoo.view.ZoofollowsureView", package.seeall)

local ZoofollowsureView = class("ZoofollowsureView", ViewComponent)

function ZoofollowsureView:buildUI()
	ZoofollowsureView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._okBtn = self:getBtn("okBtn")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._sureText = goutil.findChildTextComponent(self.mainGO, "sureText")

	local left = self:getGo("top/left")
	local right = self:getGo("top/right")

	self._currNameText = goutil.findChildTextComponent(left, "nameText")
	self._currItemCon = goutil.findChild(left, "con")
	self._nextNameText = goutil.findChildTextComponent(right, "nameText")
	self._nextItemCon = goutil.findChild(right, "con")
end

function ZoofollowsureView:bindEvents()
	ZoofollowsureView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._okBtn:AddClickListener(self._onClickOkBtn, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function ZoofollowsureView:unbindEvents()
	ZoofollowsureView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._okBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function ZoofollowsureView:onEnter()
	ZoofollowsureView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._leftAnimalMo = openParam[1]
	self._rightAnimalMo = openParam[2]

	self:_initView()
end

function ZoofollowsureView:onExitFinished()
	self._leftShow:clear()
	self._leftAvatar:destroy()
	self._rightShow:clear()
	self._rightAvatar:destroy()
	ZoofollowsureView.super.onExitFinished(self)
end

function ZoofollowsureView:_onClickOkBtn()
	ZooController.instance:sendPM_AnimalSetFollowStateReq(self._leftAnimalMo.id, true)
	self:close()
end

function ZoofollowsureView:_initView()
	self:_setCurrZooData(self._leftAnimalMo)
	self:_setNextZooData(self._rightAnimalMo)

	self._sureText.text = string.format(lang("petzoo_animalinfo_follow_replacetips"), self._currNameText.text, self._nextNameText.text)
end

function ZoofollowsureView:_setCurrZooData(animalMo)
	self._leftShow, self._leftAvatar = animalMo:showAnimalAvatar(self._currItemCon, 128, 256, 0.8, 0.65)
	self._currNameText.text = animalMo.name
end

function ZoofollowsureView:_setNextZooData(animalMo)
	self._rightShow, self._rightAvatar = animalMo:showAnimalAvatar(self._nextItemCon, 128, 256, 0.8, 0.65)
	self._nextNameText.text = animalMo.name
end

return ZoofollowsureView

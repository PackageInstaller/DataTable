-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PvbufftipView.lua

module("logic.extensions.petverify.view.PvbufftipView", package.seeall)

local PvbufftipView = class("PvbufftipView", ViewComponent)

function PvbufftipView:ctor()
	PvbufftipView.super.ctor(self)
end

function PvbufftipView:buildUI()
	PvbufftipView.super.buildUI(self)

	self._txtContent = goutil.findChildTextComponent(self.mainGO, "ruleBase/txtContent")
	self._togSelect = self:getToggle("togSelect")
	self._togSelectTrans = self:getGo("togSelect"):GetComponent(goutil.Type_RectTransform)
end

function PvbufftipView:bindEvents()
	PvbufftipView.super.bindEvents(self)
end

function PvbufftipView:unbindEvents()
	PvbufftipView.super.unbindEvents(self)
end

function PvbufftipView:destroyUI()
	PvbufftipView.super.destroyUI(self)
end

function PvbufftipView:onEnter()
	PvbufftipView.super.onEnter(self)
	self._togSelect.gameObject:SetActive(false)

	self.planId = self:getFirstParam()
	self.cbFlag = PetverifyController.instance:getVerifyInfo(self.planId, GameUtil.handler(self._refresh, self))
end

function PvbufftipView:onEnterFinished()
	PvbufftipView.super.onEnterFinished(self)
end

function PvbufftipView:onExit()
	PvbufftipView.super.onExit(self)
	PetverifyController.instance:rmVerifyInfoCallback(self.cbFlag)
end

function PvbufftipView:onExitFinished()
	PvbufftipView.super.onExitFinished(self)
end

function PvbufftipView:_refresh()
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(planId)

	if verifyCfg then
		local color = "11a568"
		local verifyDes = string.format(verifyCfg.des, color)

		self._txtContent.text = string.format("当前战力鼓舞<color=#%s>%d级</color>！\n%s！\n自阵战力大幅提升！", color, verifyCfg.level, verifyDes)
	else
		self._txtContent.text = "当前战力鼓舞<color=#11a568>0级</color>！\n放入精灵验证\n可大幅提升战力喔！"
	end
end

function PvbufftipView:_setToggle(isShow, isBase)
	return
end

return PvbufftipView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetRingLvupView.lua

module("logic.extensions.bag.view.stack.PetRingLvupView", package.seeall)

local PetRingLvupView = class("PetRingLvupView", PetAwakeLvupBaseView)

function PetRingLvupView:unbindEvents()
	PetRingLvupView.super.unbindEvents(self)
end

function PetRingLvupView:bindEvents()
	PetRingLvupView.super.bindEvents(self)
end

function PetRingLvupView:onExit()
	PetRingLvupView.super.onExit(self)
end

function PetRingLvupView:buildUI()
	PetRingLvupView.super.buildUI(self)

	self._titleRing = goutil.findChildTextComponent(self.mainGO, "title_ring")
	self._contentRing = goutil.findChildTextComponent(self.mainGO, "content_ring")
	self._stars = GameUtil.getChildren(self:getGo("stars"))
	self._txtLeftLv = goutil.findChildTextComponent(self.mainGO, "level/txt_left_lv")
	self._txtRightLv = goutil.findChildTextComponent(self.mainGO, "level/txt_right_lv")
	self._txtLeftPower = goutil.findChildTextComponent(self.mainGO, "power/txt_left_lv")
	self._txtRightPower = goutil.findChildTextComponent(self.mainGO, "power/txt_right_lv")
	self._attrsLayout = self:getGo("attrsLayout"):GetComponent("UILayoutSingleLine")
	self._attrs = GameUtil.getChildren(self._attrsLayout.gameObject)
	self._skillUpBg = self:getGo("skillUpBg")
	self._textList = GameUtil.getChildren(self._skillUpBg)
end

function PetRingLvupView:onEnter()
	PetRingLvupView.super.onEnter(self)

	local params = self:getOpenParam()

	self._mo = params[1]
	self._preMo = params[2]

	for k, v in ipairs(self._stars) do
		goutil.setActive(v, k <= rareCfg.starNum)
	end

	self._txtLeftPower.text = self._preMo:getFightingPower()
	self._txtRightPower.text = self._mo:getFightingPower()

	print("txt_left_lv = " .. self._preMo.awakenLv .. "txt_right_lv = " .. self._mo.awakenLv)

	self._txtLeftLv.text = CharacterConfig.instance:getAwakenNameWithRing(self._preMo.awakenLv)
	self._txtRightLv.text = CharacterConfig.instance:getAwakenNameWithRing(self._mo.awakenLv)

	self:_updateAttrs()
	self:_updateSkillUp()
end

return PetRingLvupView

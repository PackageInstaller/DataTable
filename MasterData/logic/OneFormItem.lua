-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/OneFormItem.lua

module("logic.extensions.seniorarena.view.OneFormItem", package.seeall)

local OneFormItem = class("OneFormItem")

function OneFormItem:ctor(go)
	self._go = go
	self._txtForce = goutil.findChildTextComponent(go, "force/txtForce")
	self._pointPet = goutil.findChild(go, "pointPet")
	self._txtIdx = goutil.findChildTextComponent(go, "txtIdx")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")
	self._imgBg = goutil.findChild(go, "imgBg")
	self._redPoint = goutil.findChild(go, "redPoint")
	self._imgAdd = goutil.findChild(go, "imgAdd")
	self._force = goutil.findChild(go, "force")

	goutil.setActive(self._btnClick.gameObject, false)
	self:setRedPointActive(false)
end

function OneFormItem:updateWithOpponentMo(mo)
	self:setRedPointActive(false)
	MaterialMgr.resetAll(self._pointPet)
	goutil.setActive(self._imgAdd, true)

	if mo.raceId > 0 then
		goutil.setActive(self._imgAdd, false)

		local proxy = MaterialMgr.setCell(MatType.Pet, mo.raceId, self._pointPet)

		if proxy then
			proxy.binder:setStars(mo.awakenLevel)
			proxy.binder:setIconDirection(false)
		end
	end

	self._txtForce.text = math.max(0, checknumber(mo.zdl))

	goutil.setActive(self._btnClick.gameObject, false)
	goutil.setActive(self._force, checknumber(self._txtForce.text) > 0)
end

function OneFormItem:updateWithPlayerFormMo(mo, idx)
	self:setRedPointActive(false)
	MaterialMgr.resetAll(self._pointPet)
	goutil.setActive(self._imgAdd, true)

	self._txtForce.text = "0"

	if mo then
		local petMo = mo:getMaxPowerPet()

		if petMo then
			goutil.setActive(self._imgAdd, false)

			local proxy = MaterialMgr.setCellByMo(petMo, self._pointPet)

			if proxy then
				proxy.binder:setIconDirection(false)
			end

			self._txtForce.text = petMo:getFightingPower()
		end

		goutil.setActive(self._btnClick.gameObject, false)
	end

	goutil.setActive(self._force, checknumber(self._txtForce.text) > 0)
end

function OneFormItem:setBtnClickHandler(handler, handlerTarget)
	goutil.setActive(self._btnClick.gameObject, true)
	self._btnClick:AddClickListener(handler, handlerTarget)
end

function OneFormItem:setRedPointActive(isActive)
	goutil.setActive(self._redPoint, isActive)
end

function OneFormItem:clear()
	MaterialMgr.resetAll(self._pointPet)
end

return OneFormItem

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotObstacleCon.lua

module("logic.extensions.defendcarrot.model.DefendCarrotObstacleCon", package.seeall)

local DefendCarrotObstacleCon = class("DefendCarrotObstacleCon", DefendCarrotUnitCon)

function DefendCarrotObstacleCon:ctor(container)
	DefendCarrotObstacleCon.super.ctor(self, container)
end

function DefendCarrotObstacleCon:buildUI()
	DefendCarrotObstacleCon.super.buildUI(self)

	if self.container then
		self._sldHP = Framework.SliderAdapter.GetFrom(self.container, "sldHP")
		self._iconChange = goutil.findChildComponent(self.container, "icon", "UIImageSpriteChange")
		self._iconImg = self._iconChange:GetComponent(goutil.Type_UIImage)
		self._fire = goutil.findChild(self.container, "fire")

		GameUtil.SetActive(self._fire, false)
	end
end

function DefendCarrotObstacleCon:beDamage(damValue)
	self:refreshHP()
end

function DefendCarrotObstacleCon:refreshHP()
	if self._unit then
		local hp = math.floor(self._unit:getCurHp())
		local maxHp = math.floor(self._unit:getHpMax())

		if maxHp <= hp then
			goutil.setActive(self._sldHP.gameObject, false)
		else
			self._sldHP:SetValue(hp / maxHp)
			goutil.setActive(self._sldHP.gameObject, true)
		end
	end
end

function DefendCarrotObstacleCon:updateFireUI(id)
	GameUtil.SetActive(self._fire, self._unit.id == id)
end

function DefendCarrotObstacleCon:updateUI()
	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)
		self:refreshHP()
		goutil.setActive(self.container, true)

		local cfg = self._unit:getObstacleCfg()

		if cfg and cfg.resPath then
			self._iconChange:ChangeSprite(cfg.resPath)
			self._iconImg:SetNativeSize()
		end
	else
		self:reset()
	end
end

function DefendCarrotObstacleCon:reset()
	DefendCarrotObstacleCon.super.reset(self)
	GameUtil.SetActive(self._fire, false)
end

return DefendCarrotObstacleCon

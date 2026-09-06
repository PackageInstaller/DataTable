-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameObstacleCon.lua

module("logic.extensions.orimatgame.model.OriMatGameObstacleCon", package.seeall)

local OriMatGameObstacleCon = class("OriMatGameObstacleCon", OriMatGameUnitCon)

function OriMatGameObstacleCon:ctor(container)
	OriMatGameObstacleCon.super.ctor(self, container)
end

function OriMatGameObstacleCon:buildUI()
	OriMatGameObstacleCon.super.buildUI(self)

	if self.container then
		self._sldHP = Framework.SliderAdapter.GetFrom(self.container, "sldHP")
		self._iconChange = goutil.findChildComponent(self.container, "icon", "UIImageSpriteChange")
		self._iconImg = self._iconChange:GetComponent(goutil.Type_UIImage)
		self._fire = goutil.findChild(self.container, "fire")

		GameUtil.SetActive(self._fire, false)
	end
end

function OriMatGameObstacleCon:beDamage(damValue)
	self:refreshHP()
end

function OriMatGameObstacleCon:refreshHP()
	if self._unit then
		local hp = math.floor(self._unit:getCurHp())
		local maxHp = math.floor(self._unit:getHpMax())

		goutil.setActive(self._sldHP.gameObject, true)

		if hp <= maxHp then
			self._sldHP:SetValue(hp / maxHp)
		end
	end
end

function OriMatGameObstacleCon:updateFireUI(id)
	GameUtil.SetActive(self._fire, self._unit.id == id)
end

function OriMatGameObstacleCon:updateUI()
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

function OriMatGameObstacleCon:reset()
	OriMatGameObstacleCon.super.reset(self)
	GameUtil.SetActive(self._fire, false)
end

return OriMatGameObstacleCon

-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiHeroEntity.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiHeroEntity", package.seeall)

local V3a6YaMiHeroEntity = class("V3a6YaMiHeroEntity", LuaCompBase)

function V3a6YaMiHeroEntity:init(go)
	self.go = go
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
end

function V3a6YaMiHeroEntity:refreshMo(mo)
	self._mo = mo
end

function V3a6YaMiHeroEntity:refreshHero(id, index)
	self.id = id
	self._simageheroicon = gohelper.findChildSingleImage(self.go, "#simage_hero")

	local image1 = self._mo.co.image1
	local image2 = self._mo.co.image2
	local icon = index % 2 == 1 and image1 or image2
	local res = ResUrl.getV3a6YaMiHeroSingleBg(icon)

	self._simageheroicon:LoadImage(res)
end

function V3a6YaMiHeroEntity:appear()
	self:setActive(true)
end

function V3a6YaMiHeroEntity:setActive(isActive)
	gohelper.setActive(self.go, isActive)
end

function V3a6YaMiHeroEntity:playEffectAnim(effectId)
	local co = V3a6YaMiConfig.instance:getEffectCo(effectId)

	if not co then
		return
	end

	self._anim:Play(co.effectVx, 0, 0)

	if co.effectVx == "fire" then
		AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_fire)
	end
end

function V3a6YaMiHeroEntity:onDestroy()
	self._simageheroicon:UnLoadImage()
end

return V3a6YaMiHeroEntity

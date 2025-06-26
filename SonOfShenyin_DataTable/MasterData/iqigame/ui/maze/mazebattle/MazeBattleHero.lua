-- chunkname: @IQIGame\\UI\\Maze\\MazeBattle\\MazeBattleHero.lua

local UISpineView = require("IQIGame/UI/Common/UISpine/UISpineView")
local Hero = Clone(UISpineView)

Hero.heroCid = 0
Hero.showComplete = false

function Hero.New(heroCid, parentTrans, callback)
	local obj = Clone(Hero)

	obj:__OnInit(heroCid, parentTrans, callback)

	return obj
end

function Hero:__OnInit(heroCid, parentTrans, callback)
	self.heroCid = heroCid
	self.callback = callback
	self.showComplete = false

	local skinCfg = SkinModule.GetHeroCurrentSkinConfig(heroCid)

	self:_OnCreate(skinCfg.UIEntityID, parentTrans, nil, function()
		self:__OnSpineViewReady()
	end)
end

function Hero:__OnSpineViewReady()
	self:DisableClick()

	self.showComplete = true

	self:PlayIdleAnim()

	if self.callback ~= nil then
		self.callback(self)
	end
end

function Hero:GetParentTrans()
	return self.spineEntityGo.transform.parent
end

function Hero:PlayDieAnim()
	self:_PlayAnim("die", false)
end

function Hero:PlayBornAnim()
	self:_PlayAnim("born", false)
end

function Hero:PlayMoveAnim()
	self:_PlayAnim("S_move", true)
end

function Hero:PlayIdleAnim()
	self:_PlayAnim("S_stay", true)
end

function Hero:PlayerAnimByName(animationName, isLoop)
	self:_PlayAnim(animationName, isLoop)
end

function Hero:SetFlip(isUnitFlip)
	self.spineEntityGo.transform.localScale = isUnitFlip and Vector3(-1, 1, 1) or Vector3.one
end

function Hero:OnHide()
	self:_Hide()
end

function Hero:Dispose()
	self:_Dispose()
end

return Hero

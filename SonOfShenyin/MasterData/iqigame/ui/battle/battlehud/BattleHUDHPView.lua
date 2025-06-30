-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDHPView.lua

local m = {
	shieldMaterialPropertyName = "_ShieldRatio",
	hpReduceSpeedMin = 0.1,
	hpTweenDelay = 15,
	hpMaterialPropertyName = "_HPRatio",
	hpColorMaterialPropertyName = "_Color",
	hpReduceSpeedMax = 1,
	lastHpRatio = 0,
	hpTweenBegin = 0,
	lastShieldRatio = 0,
	hpLeftColorMaterialPropertyName = "_HPLeftColor",
	lastHp = 0,
	shieldEffectHeight = 0,
	shieldColorMaterialPropertyName = "_ShieldColor",
	isReduceTween = false,
	lastShield = 0,
	spriteUVMapping = "_UVMapping",
	hpTweenEnd = 0,
	hpTweenValue = 0,
	hpLeftMaterialPropertyName = "_HPLeftRatio",
	hpWidth = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	local rectTrans = self.hpImage:GetComponent("RectTransform")

	self.hpWidth = rectTrans.sizeDelta.x
	self.material = UnityEngine.Object.Instantiate(self.hpImage:GetComponent(typeof(UnityEngine.UI.Image)).material)
	self.hpImage:GetComponent(typeof(UnityEngine.UI.Image)).material = self.material
	self.hpAnchorPointRectTrans = self.hpAnchorPoint:GetComponent("RectTransform")
	self.hpAnchorPointAnim = self.hpAnchorPoint:GetComponent(typeof(UnityEngine.Animation))

	self.hpAnchorPoint.gameObject:SetActive(false)

	self.shieldEffectRectTrans = self.shieldEffect:GetComponent("RectTransform")
	self.shieldEffectHeight = self.shieldEffectRectTrans.sizeDelta.y
	self.shieldEffectAnim = self.shieldEffect:GetComponent(typeof(UnityEngine.Animation))

	self.shieldEffect.gameObject:SetActive(false)
end

function m:OnInit(isFriendly)
	local path = BattleUIApi:GetHPImage(isFriendly)

	AssetUtil.LoadImage(self, path, self.bgImage:GetComponent(typeof(UnityEngine.UI.Image)))
	self:OnInitMaterialInfo(isFriendly)
end

function m:OnInitMaterialInfo(isFriendly)
	self.material:SetColor(self.hpColorMaterialPropertyName, BattleUIApi:GetHpColor(isFriendly))
	self.material:SetColor(self.hpLeftColorMaterialPropertyName, BattleUIApi:GetHpTweenColor(isFriendly))
	self.material:SetColor(self.shieldColorMaterialPropertyName, BattleUIApi:GetShieldColor(isFriendly))
	self.material:SetVector(self.spriteUVMapping, UGUIUtil.GetSpriteNormalizedUV(self.hpImage:GetComponent(typeof(UnityEngine.UI.Image))))

	self.lastHpRatio = 0
	self.lastHp = 0
	self.lastShieldRatio = 0
	self.lastShield = 0
end

function m:UpdateHP(currentHP, maxHP, shield)
	local denominator = math.max(currentHP + shield, maxHP)
	local hpRatio = currentHP / denominator
	local shieldRatio = shield / denominator

	self.material:SetFloat(self.hpMaterialPropertyName, hpRatio)
	self.material:SetFloat(self.shieldMaterialPropertyName, shieldRatio)

	if self.lastHp ~= currentHP then
		self:__PlayAnchorPointEffect(hpRatio)
		self:__PlayHpChangeEffect(hpRatio, shieldRatio)
	end

	if self.lastShield ~= shield then
		self:__PlayShieldEffect(hpRatio, shieldRatio, self.lastShieldRatio)
	end

	self.lastHpRatio = hpRatio
	self.lastHp = currentHP
	self.lastShieldRatio = shieldRatio
	self.lastShield = shield
end

function m:__PlayHpChangeEffect(hpRatio)
	local hpTweenBegin = self.lastHpRatio
	local hpTweenEnd = hpRatio

	if hpTweenEnd < hpTweenBegin then
		self:PlayReduceTween(hpTweenBegin, hpTweenEnd)
	else
		self:StopReduceTween()
	end
end

function m:PlayReduceTween(beginValue, endValue)
	if self.isReduceTween then
		if endValue >= self.hpTweenValue then
			self:StopReduceTween()

			return
		end

		self.hpTweenEnd = math.min(self.hpTweenEnd, endValue)
	else
		self.hpTweenDelay = 5
		self.hpTweenBegin = beginValue
		self.hpTweenValue = beginValue
		self.hpTweenEnd = endValue
		self.isReduceTween = true
	end
end

function m:StopReduceTween()
	self.isReduceTween = false

	self.material:SetFloat(self.hpLeftMaterialPropertyName, 0)
end

function m:__OnUpdateReduceTween()
	if not self.isReduceTween then
		return
	end

	self.hpTweenDelay = self.hpTweenDelay - 1

	if self.hpTweenDelay > 0 then
		return
	end

	self.hpTweenValue = self.hpTweenValue - Time.deltaTime * math.abs(self.hpTweenEnd - self.hpTweenValue) * 5

	if self.hpTweenValue <= self.hpTweenEnd - 0.01 then
		self:StopReduceTween()
	end

	self.material:SetFloat(self.hpLeftMaterialPropertyName, self.hpTweenValue)
end

function m:__PlayAnchorPointEffect(hpRatio)
	if hpRatio >= self.lastHpRatio then
		return
	end

	if self.hpAnchorPointAnim.isPlaying then
		self.hpAnchorPointAnim:Stop()
	end

	self.hpAnchorPoint.gameObject:SetActive(true)

	local anchorPointValue = self.hpWidth * hpRatio

	self.hpAnchorPointRectTrans.anchoredPosition = Vector2.New(anchorPointValue, 0)

	self.hpAnchorPointAnim:Play()
end

function m:__OnAnchorPointUpdate()
	if not self.hpAnchorPoint.gameObject.activeSelf then
		return
	end

	if self.hpAnchorPointAnim.isPlaying then
		return
	end

	self.hpAnchorPoint.gameObject:SetActive(false)
end

function m:__PlayShieldEffect(hpRatio, curRatio, lastRatio)
	if curRatio == lastRatio then
		return
	end

	if lastRatio < curRatio then
		self:__PlayShieldAddEffect(hpRatio, curRatio, lastRatio)
	end
end

function m:__PlayShieldAddEffect(hpRatio, curRatio, lastRatio)
	if self.shieldEffectAnim.isPlaying then
		self.shieldEffectAnim:Stop()
	end

	local posX = self.hpWidth * hpRatio
	local width = self.hpWidth * (curRatio - lastRatio)

	if hpRatio + curRatio > 1 then
		posX = self.hpWidth - width
	end

	self.shieldEffectRectTrans.gameObject:SetActive(true)

	self.shieldEffectRectTrans.anchoredPosition = Vector2.New(posX, 0)
	self.shieldEffectRectTrans.sizeDelta = Vector2.New(width, self.shieldEffectHeight)

	self.shieldEffectAnim:Play()
end

function m:__OnShieldEffectUpdate()
	if not self.shieldEffect.gameObject.activeSelf then
		return
	end

	if self.shieldEffectAnim.isPlaying then
		return
	end

	self.shieldEffect.gameObject:SetActive(false)
end

function m:OnUpdate()
	self:__OnUpdateReduceTween()
	self:__OnAnchorPointUpdate()
	self:__OnShieldEffectUpdate()
end

function m:Dispose()
	self.shieldEffectRectTrans = nil
	self.shieldEffectAnim = nil
	self.hpAnchorPointRectTrans = nil
	self.hpAnchorPointAnim = nil
	self.material = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m

-- chunkname: @IQIGame\\Scene\\FlightChallenge\\FlightGameEnemyHpView.lua

local m = {
	totalHp = 0,
	currentHp = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:Reset()
	self.MonsterHp:SetActive(false)
	self.BossHp:SetActive(false)

	self.currentHp = 0

	for i = 1, 3 do
		self["Race" .. i]:SetActive(false)
	end
end

function m:SetData(enemyData)
	self.enemyData = enemyData
	self.totalHp = self.enemyData:GetChallengeEnemyAttr(FlightGameConstant.Attribute.Flight_Shield_Value)
	self.currentHp = self.totalHp

	local isBoss = self.enemyData:GetConfigData().Type == FlightGameConstant.MonsterType.MonsterType_Boss

	self.BossHp:SetActive(isBoss)
	self.MonsterHp:SetActive(not isBoss)

	for i = 1, 3 do
		self["Race" .. i]:SetActive(self.enemyData:GetConfigData().Race == i)
	end

	self:UpdateView()
end

function m:RefreshHp(hp)
	self.currentHp = hp
	self.currentHp = self.currentHp < 0 and 0 or self.currentHp

	self:UpdateView()
end

function m:UpdateView()
	self.MonsterHpBar:GetComponent("Image").fillAmount = self.currentHp / self.totalHp
	self.BossHpBar:GetComponent("Image").fillAmount = self.currentHp / self.totalHp

	UGUIUtil.SetText(self.MonsterHpValue, string.format("%s/%s", self.currentHp, self.totalHp))
	UGUIUtil.SetText(self.BossHpValue, string.format("%s/%s", self.currentHp, self.totalHp))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m

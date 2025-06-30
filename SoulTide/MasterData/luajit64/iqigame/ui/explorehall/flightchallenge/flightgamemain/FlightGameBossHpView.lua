-- chunkname: @IQIGame\\UI\\ExploreHall\\FlightChallenge\\FlightGameMain\\FlightGameBossHpView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateUpdateGameBoss(enemyData, hp)
		self:OnUpdateGameBoss(enemyData, hp)
	end

	self:AddListener()
	self:Hide()
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateFlightGameBossEvent, self.DelegateUpdateGameBoss)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateFlightGameBossEvent, self.DelegateUpdateGameBoss)
end

function m:OnUpdateGameBoss(enemyData, hp)
	if hp > 0 then
		self:Show()
		UGUIUtil.SetText(self.TextHp, hp)

		local totalHp = enemyData:GetChallengeEnemyAttr(FlightGameConstant.Attribute.Flight_Shield_Value)

		UGUIUtil.SetText(self.TextHpTotal, FlightGameMainUIApi:GetString("TextHpTotal", totalHp))

		self.ImgHp:GetComponent("Image").fillAmount = hp / totalHp
	else
		self:Hide()
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m

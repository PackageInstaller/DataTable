-- chunkname: @IQIGame\\UI\\Battle\\ReservesView.lua

local ReservesView = {}

function ReservesView.New(ReserveRolePrefab, ReserveRolePanel)
	local o = Clone(ReservesView)

	o:Initialize(ReserveRolePrefab, ReserveRolePanel)

	return o
end

function ReservesView:Initialize(ReserveRolePrefab, ReserveRolePanel)
	self.ReserveRolePrefab = ReserveRolePrefab

	self.ReserveRolePrefab:SetActive(false)

	self.View = ReserveRolePanel
end

function ReservesView:ReservesReset()
	if self.reserves then
		for _, reserveObj in pairs(self.reserves) do
			GameObject.Destroy(reserveObj)
		end
	end

	self.reserves = nil
	self.currentReserve = -1
end

function ReservesView:Dispose()
	AssetUtil.UnloadAsset(self)
	self:ReservesReset()
end

function ReservesView:ReservesInit(tubstituteIDs)
	self:ReservesReset()

	self.reserves = {}

	for i = 1, #tubstituteIDs do
		local tubstituteID = tubstituteIDs[i]
		local obj = UnityEngine.GameObject.Instantiate(self.ReserveRolePrefab, self.View.transform)
		local image = obj:GetComponent(typeof(UnityEngine.UI.Image))
		local monsterConfig = CfgMonsterTable[tubstituteID]

		if monsterConfig then
			local path = BattleApi:GetMonsterHeadIconPath(monsterConfig.HeadIcon)

			AssetUtil.LoadImage(self, path, image)
			obj:SetActive(true)
			table.insert(self.reserves, obj)
		else
			logError(string.format("初始化预备队伍出错，找不到monsterID=%d的敌人", tubstituteID))
		end
	end

	self.currentReserve = 1
end

function ReservesView:ReservesUpdate()
	local reserveObj = self.reserves[self.currentReserve]

	if reserveObj then
		reserveObj:SetActive(false)
	end

	self.currentReserve = self.currentReserve + 1
end

function ReservesView:GetLastCount()
	if self.reserves == nil then
		return 0
	end

	local totalNum = #self.reserves

	if totalNum == 0 then
		return 0
	end

	return totalNum - self.currentReserve + 1
end

return ReservesView

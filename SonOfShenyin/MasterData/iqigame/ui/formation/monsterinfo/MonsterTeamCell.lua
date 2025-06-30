-- chunkname: @IQIGame\\UI\\Formation\\MonsterInfo\\MonsterTeamCell.lua

local monsterCell = require("IQIGame.UI.Formation.MonsterInfo.MonsterCell")
local MonsterTeamCell = {
	MonsterCell = {}
}

function MonsterTeamCell.New(gameObject, mainUIController)
	local obj = Clone(MonsterTeamCell)

	obj:Init(gameObject, mainUIController)

	return obj
end

function MonsterTeamCell:Init(gameObject, mainUIController)
	self.gameObject = gameObject
	self.MainUIController = mainUIController

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitDelegates()
	self:AddListeners()
	self.gameObject:SetActive(true)
	self.headItem:SetActive(false)
end

function MonsterTeamCell:InitDelegates()
	return
end

function MonsterTeamCell:AddListeners()
	return
end

function MonsterTeamCell:RemoveListeners()
	return
end

function MonsterTeamCell:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function MonsterTeamCell:Refresh(index, totalCount, monsterTeamCid)
	self.gameObject:SetActive(true)

	self.monsterTeamCid = monsterTeamCid

	LuaUtility.SetText(self.CurCount, index)
	LuaUtility.SetText(self.MaxCount, totalCount)

	local monsterTeamCfg = CfgMonsterTeamTable[monsterTeamCid]
	local monsters = {}

	table.addAll(monsters, monsterTeamCfg.MonsterTeam)
	table.addAll(monsters, monsterTeamCfg.BackTeam)

	for i, v in pairs(self.MonsterCell) do
		v.gameObject:SetActive(false)
	end

	local index = 1

	for i, v in pairs(monsters) do
		if v > 0 then
			local cell = self.MonsterCell[i]

			if not cell then
				local gameObject = UnityEngine.Object.Instantiate(self.headItem, self.monsterHeadGrid.transform)

				cell = monsterCell.New(gameObject, self)
				self.MonsterCell[i] = cell
			end

			cell:Refresh(v, index)

			index = index + 1
		end
	end
end

return MonsterTeamCell

-- chunkname: @IQIGame\\Editor\\GuideCheckerUIDefaultData.lua

local m = {}

function m.GetDefaultPrefabId()
	local formationPOD = FormationModule.GetFormationByIndex(1)
	local currentPrefabId

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid ~= nil then
			currentPrefabId = prefabId

			break
		end
	end

	return currentPrefabId
end

function m.GetDefaultSoulData()
	return SoulModule.GetSoulData(20010012)
end

m.UserData = {
	HomeLandUnlockRoomUI = 1,
	FormationChooseEquipUI = {
		formationIndex = 1,
		prefabId = m.GetDefaultPrefabId()
	},
	FormationChooseSoulUI = {
		formationIndex = 1,
		prefabId = m.GetDefaultPrefabId()
	},
	SoulTalentUI = {
		m.GetDefaultSoulData(),
		{
			m.GetDefaultSoulData()
		}
	},
	SoulLevelUpUI = {
		m.GetDefaultSoulData(),
		{
			m.GetDefaultSoulData()
		}
	},
	SoulUI = {
		[UIParam.soulUI.soulData] = m.GetDefaultSoulData(),
		[UIParam.soulUI.switchList] = {
			m.GetDefaultSoulData()
		}
	},
	EquipUI = {
		forShow = true,
		data = {
			CfgItemTable[41001]
		}
	},
	MazeDetailUI = {
		mazeCid = 25020100
	},
	BuyMultiConfirmUI = {
		cid = 21045031,
		itemCids = {
			2
		},
		itemNums = {
			1
		},
		args = {
			1
		}
	},
	MazeClockUI = {
		retryCount = 1,
		speedChange = 0,
		cid = 54021100,
		brickList = {
			{
				ClockLevel = 1,
				ClockType = 1,
				ClockArea = {
					0,
					1
				}
			}
		}
	},
	BattleMonsterInfoUI = {
		monsterCid = 10101101
	},
	MazeSelectLevelUI = {
		chapterCid = 25011001
	}
}

function m.GetUserData(uiName)
	return m.UserData[uiName]
end

return m

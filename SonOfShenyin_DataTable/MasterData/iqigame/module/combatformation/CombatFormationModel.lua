-- chunkname: @IQIGame\\Module\\CombatFormation\\CombatFormationModel.lua

CombatFormationModel = {
	EaseFormation = {
		Two = 2,
		One = 1,
		Four = 4,
		Three = 3
	},
	WarkLockType = {
		HelpHero = 3,
		Hero = 1,
		NPC = 2
	},
	E_FormationCellStateOnDrag = {
		CanReplaceFromHeroCell = 2,
		CanNotReplace = 0,
		CanReplaceFromBlankCell = 1,
		None = -1
	}
}

function CombatFormationModel.InitData()
	CombatFormationModel.FormationDic = {}
	CombatFormationModel.CurChooseWarlockData = nil
	CombatFormationModel.CurOperateDragNextId = nil
	CombatFormationModel.ChangeDataTable = {
		LastBox = {},
		NextBox = {}
	}
	CombatFormationModel.PreviewWarlockList = {}
	CombatFormationModel.isInitialize = true
	CombatFormationModel.isTouch_drag_id = nil
	CombatFormationModel.canExistSameCidHero = false
end

function CombatFormationModel.Initialize()
	CombatFormationModel.InitData()
end

function CombatFormationModel.ResetAll()
	CombatFormationModel.ResetChangeDataTable()

	CombatFormationModel.PreviewWarlockList = {}

	for i, v in pairs(CombatFormationModel.HeroBoxPool) do
		if v then
			ObjectPoolManager:UnLoadAsset(Constant.PoolObjName.Formation, v.cid, v.obj)
		end
	end

	CombatFormationModel.HeroBoxPool = {}

	ObjectPoolManager:UnLoadGameAsset(Constant.PoolObjName.Formation)

	CombatFormationModel.CurChooseWarlockData = nil
end

function CombatFormationModel.ResetChangeDataTable()
	CombatFormationModel.ChangeDataTable = {
		LastBox = {},
		NextBox = {}
	}
end

function CombatFormationModel.Reload(formations)
	for i, v in pairs(formations) do
		CombatFormationModel.CreateWarlockData(v, v.cid)
	end
end

function CombatFormationModel.CreateWarlockData(FormationPOD, index, isCreateNewWarlockData)
	local FormationData = CombatFormationData.New()

	FormationData:Initialize(FormationPOD, isCreateNewWarlockData)

	CombatFormationModel.FormationDic[index] = FormationData
end

function CombatFormationModel.GetSpecialFormation(Formationcid)
	local FormationPOD = {}
	local config = CfgFormationTable[Formationcid]

	FormationPOD.cid = Formationcid
	FormationPOD.heros = {}

	for i = 1, #config.SeatType do
		if config.SeatType[i] == 1 and config.SeatValue[i] ~= 0 then
			FormationPOD.heros[i] = config.SeatValue[i]
		end
	end

	CombatFormationModel.CreateWarlockData(FormationPOD, Formationcid, true)
end

function CombatFormationModel.GetPreviewWarlockList()
	CombatFormationModel.PreviewWarlockList = {}

	for i, v in pairs(WarlockModule.WarlockDataDic) do
		local B_Add = true

		if B_Add then
			CombatFormationModel.PreviewWarlockList[v.cid] = v
		end
	end
end

function CombatFormationModel.CreateSpecialFormation(formationdata)
	local isNotSaveReal = true

	if CombatFormationModel.CurFormation.BaseData.Type ~= 1 then
		isNotSaveReal = false

		for i, v in pairs(formationdata) do
			if v.mark == false then
				CombatFormationModel.CurFormation.Box[v.index] = nil
			else
				if CombatFormationModel.CurFormation.Box[v.index] == nil then
					CombatFormationModel.CurFormation.Box[v.index] = {}
				end

				CombatFormationModel.CurFormation.Box[v.index].WarlockData = WarlockModule.WarlockDataDic[v.warlockCid]
			end
		end

		CombatFormationModel.SaveFormationSucceed()
	end

	return isNotSaveReal
end

function CombatFormationModel.DetectionIsRepetitionEntry()
	for _, data in pairs(CombatFormationModel.CurFormation.Box) do
		if data.WarlockData.id == CombatFormationModel.CurChooseWarlockData.id then
			return true
		end
	end

	return false
end

function CombatFormationModel.DetectionTypeGetConfig(levelType, transcriptId)
	local config

	if levelType == Constant.ChapterPassType.TYPE_MAINLINE then
		config = CfgPlotDupStageTable[transcriptId]
	elseif levelType == Constant.ChapterPassType.TYPE_RESOURCES then
		config = CfgDailyDupStageTable[transcriptId]
	elseif levelType == Constant.ChapterPassType.TYPE_EQUIP then
		config = CfgEquipDupStageTable[transcriptId]
	elseif levelType == Constant.ChapterPassType.TYPE_BOSS then
		config = CfgBossStageTable[transcriptId]
	end

	return config
end

function CombatFormationModel.FormationWarlock(formationdata, formationid)
	CombatFormationModel.FormationChange = true

	local Formationcid = formationid and formationid or CombatFormationModel.CurFormation.FormationId
	local heros = CombatFormationModel.CurFormation:GetNetBoxData()

	for i, v in pairs(heros) do
		warning("i    " .. i .. "    v  " .. v)
	end

	for i = 1, #formationdata do
		local itemData = formationdata[i]

		if itemData.mark == false then
			warning(" 清除格子-------------    " .. itemData.index .. "    " .. tostring(heros[itemData.index]))

			if heros[itemData.index] ~= nil then
				heros[itemData.index] = nil
			end
		else
			warning("???  " .. itemData.index .. "   " .. tostring(itemData.warlockCid))

			heros[itemData.index] = itemData.warlockCid
		end
	end

	warning("新的阵型格子=============================== Formationcid  " .. tostring(Formationcid))

	for i, v in pairs(heros) do
		warning("i    " .. i .. "    v  " .. v .. " aa ")
	end

	net_formation.saveFormation(Formationcid, heros)
end

function CombatFormationModel.SaveFormationSucceed(code)
	EventDispatcher.Dispatch(EventID.SaveFormationSucceed)
end

function CombatFormationModel.UpdateFormation(FormationPOD)
	log("更新阵型数据  " .. FormationPOD.cid)
	CombatFormationModel.FormationDic[FormationPOD.cid]:Initialize(FormationPOD)
end

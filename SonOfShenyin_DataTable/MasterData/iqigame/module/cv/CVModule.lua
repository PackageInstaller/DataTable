-- chunkname: @IQIGame\\Module\\CV\\CVModule.lua

CVModule = {}

local this = CVModule

function this.PlayFightOverCVWithAttackUnit(actionType, attackUnit)
	local unlockCVList = {}
	local heroCidList = {}

	for _, v in pairs(attackUnit) do
		if v.type == 1 then
			heroCidList[v.val] = true
		end
	end

	for _, cfgCVPlay in pairsCfg(CfgCVPlayTable) do
		if heroCidList[cfgCVPlay.CVSoundId] and this._GetIsHaveCVPlayWithType(cfgCVPlay, actionType) then
			local cvList = this.GetCVCanPlayList(cfgCVPlay.CVParam[actionType])

			if #cvList > 0 then
				table.insert(unlockCVList, cvList)
			end
		end
	end

	math.randomseed(os.time())

	local randomCV = math.random(1, #unlockCVList)

	this._RandomPlayCV(unlockCVList[randomCV])
end

function this.PlayFightOverCVWithAttackHeroCid(actionType, heroCid)
	local unlockCVList = {}

	for _, cfgCVPlay in pairsCfg(CfgCVPlayTable) do
		if cfgCVPlay.CVSoundId == heroCid and this._GetIsHaveCVPlayWithType(cfgCVPlay, actionType) then
			local cvList = this.GetCVCanPlayList(cfgCVPlay.CVParam[actionType])

			if #cvList > 0 then
				table.insert(unlockCVList, cvList)
			end
		end
	end

	math.randomseed(os.time())

	local randomCV = math.random(1, #unlockCVList)

	this._RandomPlayCV(unlockCVList[randomCV])
end

function this.PlayFightCVWithBattleUnit(actionType, battleUnits)
	local unlockCVList = {}
	local heroCidList = {}

	for _, v in pairs(battleUnits) do
		local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(v.battleUnitID)

		if battleUnitData.troopType == BattleModule.attackBattleTroopType then
			heroCidList[battleUnitData:GetHeroCid()] = true
		end
	end

	for _, cfgCVPlay in pairsCfg(CfgCVPlayTable) do
		if heroCidList[cfgCVPlay.CVSoundId] and this._GetIsHaveCVPlayWithType(cfgCVPlay, actionType) then
			local cvList = this.GetCVCanPlayList(cfgCVPlay.CVParam[actionType])

			if #cvList > 0 then
				table.insert(unlockCVList, cvList)
			end
		end
	end

	math.randomseed(os.time())

	local randomCV = math.random(1, #unlockCVList)

	this._RandomPlayCV(unlockCVList[randomCV])
end

function this.PlayCV(actionType, heroCid)
	for _, v in pairsCfg(CfgCVPlayTable) do
		if v.CVSoundId == heroCid and v.CVType then
			local len = #v.CVType

			for i = 1, len do
				if v.CVType[i] == actionType and v.CVParam[i] and this._GetIsHaveCVPlayWithType(v, actionType) then
					local cvList = this.GetCVCanPlayList(v.CVParam[i])

					if #cvList == 0 then
						return
					end

					if actionType == Constant.CVActionType.RoleUpgrade then
						this.PlayRoleUpgradeCV(cvList, heroCid)
					else
						this._RandomPlayCV(cvList)
					end
				end
			end
		end
	end
end

function this.PlayRoleUpgradeCV(cvList, heroCid)
	local heroData = WarlockModule.GetHeroData(heroCid)

	if not heroData then
		return
	end

	local breakLv = heroData.breakLv
	local soundId = this.__GetCvSoundID(cvList[breakLv])

	if not soundId then
		warning(string.format("【CV】角色 %s 没有配置突破等级为 %s 的cv", heroData:GetCfg().Name, breakLv))

		return
	end

	this.currentPlayCVId = LuaUtility.PlaySoundWithID(soundId)
end

function this.StopCV()
	if this.currentPlayCVId then
		LuaUtility.StopSoundWithSerialId(this.currentPlayCVId)

		this.currentPlayCVId = nil
	end
end

function this.GetCVCanPlayList(cvList)
	local array = {}

	if not cvList or #cvList <= 0 then
		return array
	end

	local len = #cvList

	for i = 1, len do
		local cfgCVHeroData = CfgUtil.GetCfgCVHeroDataWithID(cvList[i])

		if ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(cfgCVHeroData.Condition)) then
			table.insert(array, cfgCVHeroData)
		end
	end

	return array
end

function this._RandomPlayCV(cvList)
	if this.currentPlayCVId then
		LuaUtility.StopSoundWithSerialId(this.currentPlayCVId)

		this.currentPlayCVId = nil
	end

	if not cvList then
		return
	end

	local len = #cvList

	if len <= 0 then
		return
	end

	local num = math.random(1, len)
	local soundId = this.__GetCvSoundID(cvList[num])

	this.currentPlayCVId = LuaUtility.PlaySoundWithID(soundId)
end

function this.GetAllCanPlayWithType(cfgCVPlay, actionType)
	local len = #cfgCVPlay.CVType

	for i = 1, len do
		if cfgCVPlay.CVType[i] == actionType then
			return this.GetCVCanPlayList(cfgCVPlay.CVParam[actionType])
		end
	end
end

function this._GetIsHaveCVPlayWithType(cfgCVPlay, actionType)
	return cfgCVPlay.CVParam and cfgCVPlay.CVParam[actionType] and #cfgCVPlay.CVParam[actionType] > 0
end

function this.__GetCvSoundID(cvCfg)
	if PlayerModule.GetSex() == Constant.PlayerSex.WoMen then
		if cvCfg.CVGirlSoundId == 0 then
			return cvCfg.CVSoundId
		end

		return cvCfg.CVGirlSoundId
	else
		return cvCfg.CVSoundId
	end
end

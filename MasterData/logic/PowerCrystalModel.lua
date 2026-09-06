-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/model/PowerCrystalModel.lua

module("logic.extensions.powercrystal.model.PowerCrystalModel", package.seeall)

local PowerCrystalModel = class("PowerCrystalModel", BaseModel)

PowerCrystalModel.RefreshMainView = "RefreshMainView"
PowerCrystalModel.PutInPetSuccess = "PutInPetSuccess"
PowerCrystalModel.PlayMoveEffect = "PlayMoveEffect"
PowerCrystalModel.PlaySlotEffect = "PlaySlotEffect"
PowerCrystalModel.GetInfoSuccessed = "PowerCrystalModel.GetInfoSuccessed"

function PowerCrystalModel:ctor()
	return
end

function PowerCrystalModel:onInit()
	self:onReset()
end

function PowerCrystalModel:onReset()
	self.slotInfos = {}
	self.leaderpetids = {}
	self.inPowerCrystalPetList = {}
	self.is_res_proto = false
	self.useUnlockItemItems = 0
end

function PowerCrystalModel:resProtoSuccessed()
	self.is_res_proto = true
end

function PowerCrystalModel:isProtoRes()
	return self.is_res_proto
end

function PowerCrystalModel:getSlotState(slotId)
	local info = self:getSlotInfo(slotId)

	return (info or nil) and (tonumber(info.cdInternval) > 0 and GameEnum.PowerCrystalPosType.Cool or info.petId > 0 and GameEnum.PowerCrystalPosType.Hold or info.petId == -1 and GameEnum.PowerCrystalPosType.Empty or GameEnum.PowerCrystalPosType.Lock)
end

function PowerCrystalModel:isSlotOpen(slotId)
	return self:getSlotState(slotId) ~= GameEnum.PowerCrystalPosType.Lock
end

function PowerCrystalModel:getPetNum()
	return BagModel.instance:BagCount()
end

function PowerCrystalModel:setUseUnlockItemItems(times)
	self.useUnlockItemItems = times
end

function PowerCrystalModel:getUseUnlockItemItems()
	return self.useUnlockItemItems
end

function PowerCrystalModel:setLeaderpetids(leaderpetids)
	self.leaderpetids = leaderpetids
end

function PowerCrystalModel:getLeaderpetids()
	return self.leaderpetids
end

function PowerCrystalModel:setSlotInfos(slotInfos)
	self.slotInfos = slotInfos
end

function PowerCrystalModel:getSlotInfos()
	return self.slotInfos
end

function PowerCrystalModel:getSlotInfo(slotId)
	local info

	for _, v in pairs(self.slotInfos) do
		if v.slotId == slotId then
			info = v

			break
		end
	end

	return info
end

function PowerCrystalModel:GetSortParms()
	local parm1 = {}
	local parm2 = {}
	local sortName

	local function func(data)
		return (data ~= nil and FormationNewModel.instance:HasPet(data.petId) or nil) and 1
	end

	table.insert(parm1, 1, func)
	table.insert(parm2, 1, ArraySort.DESCENDING)

	self._sortValue = self:GetSortState()

	for k, v in ipairs(self._sortValue) do
		local vArr = BagModel.SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, BagModel.SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

function PowerCrystalModel:addOneSlotInfo(info)
	table.insert(self.slotInfos, info)
end

function PowerCrystalModel:clickToUnlockSlot(slotId)
	if slotId > 1 then
		local preIsOpen = self:isSlotOpen(slotId - 1)

		if not preIsOpen then
			FloatWordMgr.instance:show("需要先解锁前一个槽位")

			return
		end
	end

	local content, matType, matId, matNum = self:getUnLockSlotCostEnoughAndStr(slotId)

	local function fireProto()
		PowerCrystalController.instance:sendPM_PowerCrystalUnlockSlotReq(slotId)
	end

	local function okFunc()
		if MaterialFacade.instance:checkMatEnough(matType, matId, matNum) then
			fireProto()
		end
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, okFunc, nil)
end

function PowerCrystalModel:getUnLockSlotCostEnoughAndStr(slotId)
	local enough = false
	local matType = 0
	local matId = 0
	local matNum = 0
	local str = ""
	local useUnlockItemItems = self:getUseUnlockItemItems()
	local cfg = PowerCrystalConfig.instance:getSlotUnLockCostCdg(useUnlockItemItems + 1)

	if cfg then
		matType, matId = PowerCrystalConfig.instance:getMainOrSecondCostMo(true)
		matNum = cfg.mainCostNum

		local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

		enough = matNum <= has_num

		local m_cfg = MaterialFacade.instance:getMatCfg(matType, matId)
		local name = m_cfg.name
		local itemStr = MaterialMgr.createSerName(matType, matId)
		local goodsStr = TipsFacade.instance:getContentMatStr(itemStr, 50, -10, true)

		str = str .. "\n是否消耗" .. name .. "<color=#d44c28>" .. goodsStr .. "X" .. matNum .. "</color>解锁该栏位？"
	end

	return string.trim(str), matType, matId, matNum
end

function PowerCrystalModel:setSlotCoolTime(slotId, time)
	local info = self:getSlotInfo(slotId)

	if info and info.petId <= 0 then
		info.cdInternval = time
	end
end

function PowerCrystalModel:getSlotCoolTime(slotId)
	local info = self:getSlotInfo(slotId)

	return (info or nil) and math.max(0, info.cdInternval)
end

function PowerCrystalModel:getUnLockSlotCostByTime(time)
	return math.ceil(time / PowerCrystalConfig.instance:getOneDiamondTime()) * 1
end

function PowerCrystalModel:unLockSlotSuccess(msg)
	local slotId = msg.slotId
	local info = self:getSlotInfo(slotId)

	self:setUseUnlockItemItems(msg.useUnlockItemTimes)

	if not info then
		local info = {
			curTalent = 0,
			originalLv = 0,
			petId = -1,
			curLv = 0,
			cdInternval = 0,
			originalTalent = 0,
			slotId = slotId
		}

		self:addOneSlotInfo(info)
	else
		info.petId = -1
		info.cdInternval = 0
	end
end

function PowerCrystalModel:putInPetSuccessed(slotId, petId, curLv, curTalent, originalLv, originalTalent)
	local info = self:getSlotInfo(slotId)

	if info then
		info.petId = petId
		info.cdInternval = 0
		info.curLv = curLv
		info.curTalent = curTalent
		info.originalLv = originalLv
		info.originalTalent = originalTalent
	end
end

function PowerCrystalModel:putOffPetSuccessed(slotId, cdInternval)
	local info = self:getSlotInfo(slotId)

	if info then
		info.petId = -1
		info.cdInternval = cdInternval
	end
end

function PowerCrystalModel:clearCoolSuccessed(slotId)
	local info = self:getSlotInfo(slotId)

	if info then
		info.cdInternval = 0
		info.petId = -1
	end
end

function PowerCrystalModel:getFilterList()
	local pet_id_list = {}
	local race_id_list = {}
	local list1 = self:getLeaderpetids()

	for _, petId in ipairs(list1) do
		local info = BagPetsFacade.instance:getPetInfo(petId)

		if info then
			race_id_list[info.raceId] = true
		end

		pet_id_list[petId] = true
	end

	local list2 = self:getSlotInfos()

	for k, vo in ipairs(list2) do
		local info = BagPetsFacade.instance:getPetInfo(vo.petId)

		if info then
			race_id_list[info.raceId] = true
		end

		pet_id_list[vo.petId] = true
	end

	return pet_id_list, race_id_list
end

function PowerCrystalModel:getSlotOpenNum()
	local list = self:getSlotInfos() or {}

	return #list
end

function PowerCrystalModel:getSlotUpNum()
	local num = 0
	local list = self:getSlotInfos() or {}

	for i, v in ipairs(list) do
		if v.petId > 0 then
			num = num + 1
		end
	end

	return num
end

function PowerCrystalModel:FormatUpPetStr()
	return self:getSlotUpNum() .. "/" .. self:getSlotOpenNum()
end

function PowerCrystalModel:setCoolEnd(slotId)
	local info = self:getSlotInfo(slotId)

	if info then
		info.cdInternval = 0
	end
end

function PowerCrystalModel:checkRedDot()
	local dot = false

	if FuncOpenModel.instance:getFuncIsOpen(66) and self:isProtoRes() then
		local list = PowerCrystalConfig.instance:getSlotCfg()

		if list then
			for i, v in ipairs(list) do
				dot = self:checkSlotOpenRedDot(v.slotId)

				if dot then
					break
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_POWER_CRYSTAL, dot)

	return dot
end

function PowerCrystalModel:getRedIsActive()
	return
end

function PowerCrystalModel:checkSlotOpenRedDot(slotId)
	local dot = false

	if FuncOpenModel.instance:getFuncIsOpen(66) and self:isProtoRes() then
		if slotId > 1 then
			local open = self:isSlotOpen(slotId - 1)

			if not open then
				return false
			end
		end

		local cfg = PowerCrystalConfig.instance:getSlotUnLockCostCdg(slotId)
		local info = self:getSlotInfo(slotId)

		if cfg and not info then
			dot = self:checkGoodsEnough(true, cfg.mainCostNum)
		end
	end

	return dot
end

function PowerCrystalModel:checkGoodsEnough(isMainCost, matNum)
	local matType, matId = PowerCrystalConfig.instance:getMainOrSecondCostMo(isMainCost)
	local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

	return matNum <= has_num
end

function PowerCrystalModel:initInPowerCrystalPetList()
	local slotinfos = self:getSlotInfos()
	local leaderpetids = self:getLeaderpetids()

	self.inPowerCrystalPetList = {}

	for _, petId in ipairs(leaderpetids) do
		self.inPowerCrystalPetList[petId] = true
	end

	for _, v in ipairs(slotinfos) do
		if v.petId > 0 then
			self.inPowerCrystalPetList[v.petId] = true
		end
	end
end

function PowerCrystalModel:isInPowerCrystal(petId)
	return self.inPowerCrystalPetList[petId]
end

PowerCrystalModel.instance = PowerCrystalModel.New()

return PowerCrystalModel

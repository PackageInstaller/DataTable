-- chunkname: @modules/logic/sp02/atomic/model/AtomicModel.lua

module("modules.logic.sp02.atomic.model.AtomicModel", package.seeall)

local AtomicModel = class("AtomicModel", BaseModel)

function AtomicModel:onInit()
	self:reInit()
end

function AtomicModel:reInit()
	self.data = nil
end

function AtomicModel:updateInfo(info)
	local data = self:getData()

	data:updateInfo(info)
end

function AtomicModel:getData()
	if not self.data then
		self.data = AtomicMO.New()

		self.data:init()
	end

	return self.data
end

function AtomicModel:getTalentEquipList()
	local data = self:getData()
	local talentMo = data:getTalentInfo()

	return talentMo:getEquipList()
end

function AtomicModel:canInstallTalent(callback, callbackObj)
	local equipList = self:getTalentEquipList()
	local hasEmptySlot = false

	for _, nodeId in ipairs(equipList) do
		if not nodeId or nodeId == 0 then
			hasEmptySlot = true

			break
		end
	end

	if not hasEmptySlot then
		return
	end

	local data = self:getData()
	local talentMo = data:getTalentInfo()
	local list = lua_atomic_talent.configList
	local hasUnInstalled = false

	for i, v in ipairs(list) do
		if v.mark and talentMo:isTalentUnlocked(v.id) and not talentMo:isTalentEquipped(v.id) then
			hasUnInstalled = true

			break
		end
	end

	if not hasUnInstalled then
		return
	end

	local noStr = luaLang("sp02_atomic_talent_messagebox_no")
	local yesStr = luaLang("sp02_atomic_talent_messagebox_yes")

	MessageBoxController.instance:showOptionMsgBoxAndSetBtn(MessageBoxIdDefine.AtomicTalentGotoInstall, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, yesStr, nil, noStr, nil, callback, AtomicController.openTalentView, nil, callbackObj, AtomicController.instance)

	return true
end

function AtomicModel:getAllUnlockTalentCost()
	local data = self:getData()
	local talentMo = data:getTalentInfo()
	local list = lua_atomic_talent.configList
	local allCostNum = 0

	for i, v in ipairs(list) do
		if talentMo:isTalentUnlocked(v.id) and not string.nilorempty(v.cost) then
			local costData = string.splitToNumber(v.cost, "#")

			allCostNum = allCostNum + costData[3]
		end
	end

	return allCostNum
end

AtomicModel.instance = AtomicModel.New()

return AtomicModel

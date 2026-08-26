-- chunkname: @modules/logic/survival/model/map/SurvivalChoiceMo.lua

module("modules.logic.survival.model.map.SurvivalChoiceMo", package.seeall)

local SurvivalChoiceMo = class("SurvivalChoiceMo")

function SurvivalChoiceMo:ctor()
	self.callback = nil
	self.callobj = nil
	self.param = nil
	self.desc = ""
	self.icon = SurvivalEnum.EventChoiceIcon.None
	self.color = SurvivalConst.EventChoiceColor.Green
	self.conditionStr = ""
	self.resultStr = ""
	self.otherParam = ""
	self.unitId = 0
	self.treeId = 0

	self:clearValues()
end

function SurvivalChoiceMo.Create(data)
	local mo = SurvivalChoiceMo.New()

	mo:init(data)

	return mo
end

function SurvivalChoiceMo:init(data)
	self.callback = data.callback
	self.callobj = data.callobj
	self.param = data.param
	self.desc = data.desc or ""
	self.icon = data.icon or SurvivalEnum.EventChoiceIcon.None
	self.conditionStr = data.conditionStr or ""
	self.resultStr = data.resultStr or ""
	self.unitId = data.unitId or 0
	self.otherParam = data.otherParam or ""

	self:refreshData()
end

function SurvivalChoiceMo:clearValues()
	self.exStr = nil
	self.isValid = true
	self.isCostTime = false
	self.exStepDesc = nil
	self.exShowItemMos = nil
	self.npcWorthCheck = nil
	self.isShowBogusBtn = false
	self.exBogusData = nil
	self.openFogRange = nil
	self.isRoleExclusive = nil
end

function SurvivalChoiceMo:refreshData()
	self.color = SurvivalEnum.IconToColor[self.icon]

	self:checkConditionStr()
end

function SurvivalChoiceMo:checkConditionStr()
	self:clearValues()

	if not string.nilorempty(self.conditionStr) then
		local arr = string.split(self.conditionStr, "|")
		local type = arr[1]
		local func = SurvivalChoiceMo["checkCondition_" .. type]

		if func then
			func(self, arr[2])
		end

		if not string.nilorempty(self.exStr) then
			return
		end
	end

	if not string.nilorempty(self.resultStr) then
		local arr = string.split(self.resultStr, "|")
		local type = arr[1]
		local func = SurvivalChoiceMo["checkCondition_" .. type]

		if func then
			func(self, arr[2])
		end
	end
end

function SurvivalChoiceMo:checkCondition_RoleExclusive(param)
	local ids = string.splitToNumber(param, "#")
	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local roleId = survivalShelterRoleMo.roleId

	if roleId then
		for _, id in ipairs(ids) do
			if id == roleId then
				self.isRoleExclusive = true

				break
			end
		end
	end
end

function SurvivalChoiceMo:checkCondition_CostGameTime(param)
	local consume = tonumber(param) or 0

	consume = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.ChoiceCostTime, consume)
	self.isCostTime = true
	self.isValid = true
	self.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_costtime"), consume)
end

function SurvivalChoiceMo:checkCondition_AddHealth(param)
	self.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_changehealth"), "+" .. param)
end

function SurvivalChoiceMo:checkCondition_DeductHealth(param)
	self.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_changehealth"), "-" .. param)
end

function SurvivalChoiceMo:checkCondition_ItemGE(param)
	local arr = string.splitToNumber(param, "#")

	if not arr[1] then
		local itemId = 0

		if not arr[2] then
			local needNum = 0
			local bagMo = SurvivalMapHelper.instance:getBagMo()
			local nowNum = bagMo:getItemCountPlus(itemId)

			self.isValid = needNum <= nowNum

			if not self.isValid then
				local itemCo = lua_survival_item.configDict[itemId]

				self.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), (itemCo or nil) and (itemCo.name or ""), needNum)
			end
		end
	end
end

function SurvivalChoiceMo:checkCondition_ItemLT(param)
	local arr = string.splitToNumber(param, "#")

	if not arr[1] then
		local itemId = 0

		if not arr[2] then
			local needNum = 0
			local bagMo = SurvivalMapHelper.instance:getBagMo()
			local nowNum = bagMo:getItemCountPlus(itemId)

			self.isValid = nowNum < needNum

			if not self.isValid then
				local itemCo = lua_survival_item.configDict[itemId]

				self.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyLT"), (itemCo or nil) and (itemCo.name or ""), needNum)
			end
		end
	end
end

function SurvivalChoiceMo:checkCondition_AddItem(param)
	local dict = GameUtil.splitString2(param, true, "&", ":")

	self.isValid = true

	for _, arr in ipairs(dict) do
		local itemId = arr[1]
		local count = arr[2]
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init({
			id = itemId,
			count = count
		})

		if itemMo:isCurrency() and itemMo.id == SurvivalEnum.CurrencyType.Enthusiastic then
			self.exStr = luaLang("survival_choice_enthusiastic_get")
		elseif itemMo:isCurrency() and itemMo.id < SurvivalEnum.CurrencyType.Enthusiastic then
			self.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_getitem"), itemMo.co.name, count)
		elseif not itemMo:isCurrency() then
			-- block empty
		end
	end
end

function SurvivalChoiceMo:checkCondition_CostPointItem(param)
	self.exStr = luaLang("survival_choice_enthusiastic_cost")
end

function SurvivalChoiceMo:checkCondition_CostItem(param)
	local dict = GameUtil.splitString2(param, true, "&", ":")
	local bagMo = SurvivalMapHelper.instance:getBagMo()

	self.exShowItemMos = {}
	self.isShowBogusBtn = true
	self.exStepDesc = luaLang("survival_eventview_commititem")
	self.isValid = true

	local currencyMo

	for _, arr in ipairs(dict) do
		local itemId = arr[1]
		local count = arr[2]
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init({
			id = itemId,
			count = count
		})
		table.insert(self.exShowItemMos, itemMo)

		if not currencyMo and itemMo:isCurrency() then
			currencyMo = itemMo
		end

		local nowNum = bagMo:getItemCountPlus(itemId)

		if nowNum < count and self.isValid then
			self.isValid = false
			self.exStr = itemMo:isCurrency() and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), itemMo.co.name, itemMo.count) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_item_noenough"), itemMo.co.name)
		end
	end

	if self.isValid and currencyMo then
		self.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_costitem"), currencyMo.co.name, currencyMo.count)
	end
end

function SurvivalChoiceMo:checkCondition_SnatchCond(param)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local unitMo = sceneMo.unitsById[self.unitId]

	if not unitMo then
		return
	end

	local index = tonumber(self.otherParam) + 1
	local subItem = unitMo.co.subItem

	if not string.nilorempty(subItem) then
		local bagMo = SurvivalMapHelper.instance:getBagMo()

		self.exShowItemMos = {}
		self.isShowBogusBtn = true
		self.exStepDesc = luaLang("survival_eventview_commititem")
		self.isValid = true

		local itemsList = {}
		local l = string.split(subItem, "|")

		for i, str in ipairs(l) do
			itemsList[i] = {}

			local l2 = string.split(str, "&")

			for j, str2 in ipairs(l2) do
				local l3 = string.split(str2, ":")

				table.insert(itemsList[i], {
					tonumber(l3[1]),
					(tonumber(l3[2]))
				})
			end
		end

		local currencyMo
		local items = itemsList[index]

		if items then
			for _, arr in ipairs(items) do
				local itemId = arr[1]
				local count = arr[2]
				local itemMo = SurvivalBagItemMo.New()

				itemMo:init({
					id = itemId,
					count = count
				})
				table.insert(self.exShowItemMos, itemMo)

				if not currencyMo and itemMo:isCurrency() then
					currencyMo = itemMo
				end

				local nowNum = bagMo:getItemCountPlus(itemId)

				if nowNum < count and self.isValid then
					self.isValid = false
					self.exStr = itemMo:isCurrency() and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), itemMo.co.name, itemMo.count) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_item_noenough"), itemMo.co.name)
				end
			end

			if self.isValid and currencyMo then
				self.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_costitem"), currencyMo.co.name, currencyMo.count)
			end
		end
	end
end

function SurvivalChoiceMo:checkCondition_RecrNpc(param)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local unitMo = sceneMo.unitsById[self.unitId]

	if not unitMo then
		return
	end

	local recruitmentCo = lua_survival_recruitment.configDict[unitMo.co.recruitment]

	if not recruitmentCo then
		return
	end

	local bagMo = SurvivalMapHelper.instance:getBagMo()

	self.isShowBogusBtn = true
	self.exStepDesc = recruitmentCo.desc

	if recruitmentCo.conditionType == SurvivalEnum.NpcRecruitmentType.ItemCost then
		self.exBogusData = {}
		self.exBogusData.exStepDesc = luaLang("survival_eventview_commititem")

		local dict = GameUtil.splitString2(recruitmentCo.param, true, "&", ":")

		self.exBogusData.exShowItemMos = {}
		self.exBogusData.isValid = true

		for _, arr in ipairs(dict) do
			local itemId = arr[1]
			local count = arr[2]
			local itemMo = SurvivalBagItemMo.New()

			itemMo:init({
				id = itemId,
				count = count
			})
			table.insert(self.exBogusData.exShowItemMos, itemMo)

			local nowNum = bagMo:getItemCountPlus(itemId)

			if nowNum < count and self.exBogusData.isValid then
				self.exBogusData.isValid = false
				self.exBogusData.exStr = itemMo:isCurrency() and GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), itemMo.co.name, count) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_item_noenough"), itemMo.co.name)
			end
		end
	elseif recruitmentCo.conditionType == SurvivalEnum.NpcRecruitmentType.ItemCheck then
		local dict = GameUtil.splitString2(recruitmentCo.param, true, "&", ":")

		for _, arr in ipairs(dict) do
			local itemId = arr[1]
			local count = arr[2]
			local nowNum = bagMo:getItemCountPlus(itemId)

			if nowNum < count and self.isValid then
				self.isValid = false

				local itemCo = lua_survival_item.configDict[itemId]

				if itemCo.type == SurvivalEnum.ItemType.Currency then
					self.exStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_choice_currencyGE"), itemCo.name, count)

					break
				end

				self.exStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_choice_item_noenough"), itemCo.name)

				break
			end
		end
	elseif recruitmentCo.conditionType == SurvivalEnum.NpcRecruitmentType.NpcNumCheck then
		local paramArr = string.splitToNumber(recruitmentCo.param, "#")
		local curCount = bagMo:getNPCCount()

		self.isValid = SurvivalHelper.instance:getOperResult(paramArr[1], curCount, paramArr[2])

		if not self.isValid then
			self.exStr = luaLang("survival_choice_recruitmentNPC")
		end
	elseif recruitmentCo.conditionType == SurvivalEnum.NpcRecruitmentType.WorthCheck then
		self.isValid = true
		self.npcWorthCheck = tonumber(recruitmentCo.param) or 0
	elseif recruitmentCo.conditionType == SurvivalEnum.NpcRecruitmentType.FinishTask or recruitmentCo.conditionType == SurvivalEnum.NpcRecruitmentType.FinishEvent then
		self.isValid = self.otherParam == "true"

		if not self.isValid then
			self.exStr = luaLang("survival_choice_recruitmentNPC")
		end
	end
end

function SurvivalChoiceMo:checkCondition_CommitItems(param)
	self.isValid = true
	self.npcWorthCheck = tonumber(param) or 0
end

function SurvivalChoiceMo:checkCondition_RemoveFog(param)
	local arr = string.splitToNumber(param, "#") or {}

	self.openFogRange = arr[1] or 0
end

return SurvivalChoiceMo

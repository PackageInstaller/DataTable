-- chunkname: @IQIGame\\UI\\Lottery\\Template\\LotteryTemplateController.lua

local AppointedRoot = {}

function AppointedRoot.New(view)
	local obj = Clone(AppointedRoot)

	obj:__Init(view)

	return obj
end

function AppointedRoot:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "Btn", self.__ShowAppointedSwitchView)
	EventUtil.AddEventListener(self, EventID.LotteryAppointedValueChange, self.__OnLotteryAppointedValueChange)
end

function AppointedRoot:Show(cardPoolCid)
	self.cardPoolCid = cardPoolCid
	self.selectHeroCid = 0

	local recordCardPoolCid = LotteryModule.GetShowGroupRecordData(cardPoolCid)

	self.gameObject:SetActive(true)

	if recordCardPoolCid == 0 then
		self.NormalBtn.gameObject:SetActive(true)
		self.RoleIcon.gameObject:SetActive(false)

		return
	end

	self.NormalBtn.gameObject:SetActive(false)
	self.RoleIcon.gameObject:SetActive(true)

	local cardGroupData = CfgCardGroupTable[cardPoolCid]

	ForArray(cardGroupData.CardJackpotID, function(_index, _cardCid)
		if _cardCid == recordCardPoolCid then
			self.selectHeroCid = cardGroupData.ShowCard[_index]

			return true
		end
	end)

	if self.selectHeroCid == 0 then
		self.NormalBtn.gameObject:SetActive(true)
		self.RoleIcon.gameObject:SetActive(false)
	else
		local headIconPath = SkinModule.GetHeroDefaultSkinImgPath(self.selectHeroCid, Constant.SkinImageType.FriendHeadImg)

		AssetUtil.LoadImage_SetNativeSize(self, headIconPath, self.RoleIcon)
	end
end

function AppointedRoot:__ShowAppointedSwitchView()
	EventDispatcher.Dispatch(EventID.SetLotteryAppointedViewActive, true, self.cardPoolCid, self.selectHeroCid)
end

function AppointedRoot:__OnLotteryAppointedValueChange(showGroupCid, recordCid)
	if self.cardPoolCid ~= showGroupCid then
		return
	end

	self:Show(showGroupCid)
end

function AppointedRoot:Hide()
	self.gameObject:SetActive(false)
end

function AppointedRoot:Dispose()
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local LotterySkillNameTemplate = require("IQIGame/UI/Lottery/Template/LotterySkillNameTemplate")
local LotteryRoleNameTemplate = require("IQIGame/UI/Lottery/Template/LotteryRoleNameTemplate")
local controller = {
	cardPoolCid = 0,
	namePrefabs = {}
}

function controller.New(cardPoolCid, view, isGroupCid)
	local obj = Clone(controller)

	obj:__Init(cardPoolCid, view, isGroupCid)

	return obj
end

function controller:__Init(cardPoolCid, view, isGroupCid)
	self.cardPoolCid = cardPoolCid
	self.view = view
	self.isGroupCid = isGroupCid

	LuaCodeInterface.BindOutlet(self.view, self)
	ForArrayByCount(1, 10, 1, function(_index)
		local name = string.format("roleName_%d", _index)
		local namePrefab = self[name]

		if namePrefab == nil then
			return true
		end

		self:__SetRoleNamePrefabData(namePrefab)
	end)
	ForArrayByCount(1, 10, 1, function(_index)
		local name = string.format("skillName_%d", _index)
		local namePrefab = self[name]

		if namePrefab == nil then
			return true
		end

		self:__SetSkillNamePrefabData(namePrefab)
	end)
	self:RefreshMustGuaranteeText()

	if self.isGroupCid then
		self.appointedView = AppointedRoot.New(self.AppointedRoot)
	end
end

function controller:__SetRoleNamePrefabData(namePrefab)
	local roleCid = tonumber(namePrefab.gameObject.name)
	local item = LotteryRoleNameTemplate.New(namePrefab)

	item:Show(roleCid)
	table.insert(self.namePrefabs, item)
end

function controller:__SetSkillNamePrefabData(namePrefab)
	local skillCid = tonumber(namePrefab.gameObject.name)
	local item = LotterySkillNameTemplate.New(namePrefab)

	item:Show(skillCid)
	table.insert(self.namePrefabs, item)
end

function controller:Show()
	self.view.gameObject:SetActive(true)

	if self.isGroupCid then
		self.appointedView:Show(self.cardPoolCid)
	end

	self:RefreshMustGuaranteeText()
end

function controller:RefreshMustGuaranteeText()
	local cardPoolCid = self.cardPoolCid

	if self.isGroupCid then
		cardPoolCid = LotteryModule.GetGroupCardJackpotID(self.cardPoolCid, false)
	end

	if self.mustGuaranteeText == nil then
		return
	end

	local cardJackpotData = CfgCardJackpotTable[cardPoolCid]
	local cardJackpotGroupData = CfgCardJackpotGroupTable[cardJackpotData.CardGroup]
	local poolData = LotteryModule.GetPoolDataByType(cardPoolCid)

	if poolData == nil then
		poolData = {}
		poolData.mustGuarantee = 80
	end

	local nextMustGuarantee = cardJackpotGroupData.MustGuarantee - poolData.mustGuarantee

	self.mustGuaranteeText:GetComponent("Text").text = tostring(nextMustGuarantee)
end

function controller:Hide()
	self.view.gameObject:SetActive(false)
end

function controller:Dispose()
	if self.appointedView ~= nil then
		self.appointedView:Dispose()
	end

	ForPairs(self.namePrefabs, function(k, _item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return controller

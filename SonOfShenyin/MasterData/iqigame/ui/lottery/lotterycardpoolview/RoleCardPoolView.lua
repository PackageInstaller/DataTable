-- chunkname: @IQIGame\\UI\\Lottery\\LotteryCardPoolView\\RoleCardPoolView.lua

local LotteryCardPoolView = require("IQIGame/UI/Lottery/LotteryCardPoolView/LotteryCardPoolView")
local LotteryRoleNameTemplate = require("IQIGame/UI/Lottery/Template/LotteryRoleNameTemplate")
local SubRoleItem = {}

function SubRoleItem.New(view)
	local obj = Clone(SubRoleItem)

	obj:__Init(view)

	return obj
end

function SubRoleItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.nameItem = LotteryRoleNameTemplate.New(self.nameRoot)
end

function SubRoleItem:Show(roleCid)
	self.gameObject:SetActive(true)

	local bgPath = LotteryUIApi:GetSubItemBackground(roleCid)

	AssetUtil.LoadImage(self, bgPath, self.gameObject:GetComponent("Image"))
	self.nameItem:Show(roleCid)
end

function SubRoleItem:Hide()
	self.gameObject:SetActive(false)
end

function SubRoleItem:Dispose()
	self.nameItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local RoleCardPoolView = Clone(LotteryCardPoolView)

RoleCardPoolView.mainNameItem = nil
RoleCardPoolView.subItems = {}
RoleCardPoolView.uniqueEntityID = 0

function RoleCardPoolView.New(view)
	local obj = Clone(RoleCardPoolView)

	obj:Init(view)

	return obj
end

function RoleCardPoolView:__Init()
	self.mainNameItem = LotteryRoleNameTemplate.New(self.mainNameRoot)

	for i = 0, self.subItemRoot.transform.childCount - 1 do
		local subItemView = self.subItemRoot.transform:GetChild(i):GetChild(0).gameObject
		local subItem = SubRoleItem.New(subItemView)

		table.insert(self.subItems, subItem)
	end
end

function RoleCardPoolView:__Show()
	local cardJackpotData = CfgCardJackpotTable[self.cardJackpotID]
	local mainRoleCid = cardJackpotData.CardDetailShow[1]

	self:__FillMainRoleData(mainRoleCid, cardJackpotData.CardSpine)

	for i = 2, #cardJackpotData.CardDetailShow do
		local subItem = self.subItems[i - 1]

		subItem:Show(cardJackpotData.CardDetailShow[i])
	end
end

function RoleCardPoolView:__FillMainRoleData(roleCid, spineOffset)
	local bgPath = LotteryUIApi:GetMainItemBackground(roleCid)

	AssetUtil.LoadImage(self, bgPath, self.mainItem:GetComponent("Image"))
	self.mainNameItem:Show(roleCid)
	self:__ReleasePreviewSpine()

	local offsetX = spineOffset[1] and spineOffset[1] or 0
	local offsetY = spineOffset[2] and spineOffset[2] or 0

	self.uniqueEntityID = EntityUtility.GetHeroUIEntity_NormalSkin(roleCid, self.spineNode.transform, Vector3.New(offsetX, offsetY, 0), function(_entityComponent)
		local previewSpine = _entityComponent.gameObject
		local skeletonGraphic = previewSpine:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

		skeletonGraphic:Initialize(true)
		skeletonGraphic.AnimationState:SetAnimation(0, "idle", true)
	end)
end

function RoleCardPoolView:__ReleasePreviewSpine()
	if self.uniqueEntityID == 0 then
		return
	end

	EntityUtility.HideEntityByEntityID(self.uniqueEntityID)

	self.uniqueEntityID = 0
end

function RoleCardPoolView:__Hide()
	self:__ReleasePreviewSpine()
end

function RoleCardPoolView:__Dispose()
	self:__ReleasePreviewSpine()
	self.mainNameItem:Dispose()
	AssetUtil.UnloadAsset(self)
end

return RoleCardPoolView

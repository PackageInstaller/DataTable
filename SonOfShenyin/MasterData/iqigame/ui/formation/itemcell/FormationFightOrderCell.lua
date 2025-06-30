-- chunkname: @IQIGame\\UI\\Formation\\ItemCell\\FormationFightOrderCell.lua

local FormationFightOrderCell = {}

function FormationFightOrderCell.New(gameObject, mainUIController)
	local obj = Clone(FormationFightOrderCell)

	obj:Init(gameObject, mainUIController)

	return obj
end

function FormationFightOrderCell:Init(gameObject, mainUIController)
	self.gameObject = gameObject
	self.MainUIController = mainUIController

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	local dragButton = self.gameObject:GetComponent("IQIGame.Onigao.Game.UIDragShiftButton")

	function dragButton.onBeginDrag(eventData)
		self:OnBeginDrag(nil, eventData, nil)
	end

	function dragButton.onDrag(eventData)
		self:OnDrag(nil, eventData, nil)
	end

	function dragButton.onEndDrag(eventData)
		self:OnEndDrag(nil, eventData, LuaCodeInterface.GetPointerCurrentRaycast(eventData))
	end

	function dragButton.onEndShift(oldIndex, newIndex)
		self:OnEndShift(oldIndex, newIndex)
	end

	self:AddListeners()
end

function FormationFightOrderCell:AddListeners()
	return
end

function FormationFightOrderCell:RemoveListeners()
	return
end

function FormationFightOrderCell:SetData(heroData, index)
	self.heroData = heroData
end

function FormationFightOrderCell:RefreshHeroInfo(index)
	local path = SkinModule.GetHeroCurrentSkinImgPath(self.heroData.heroCid, Constant.SkinImageType.HeadIcon)

	self.SelectParent.gameObject:SetActive(false)
	AssetUtil.LoadImage(self, path, self.RoleImage:GetComponent("Image"))
	LuaUtility.SetText(self.orderNumText, BattleUIApi:GetBattleActionOrderText(index))
end

function FormationFightOrderCell:OnBeginDrag(go, eventData, eventData_go)
	local size = FormationUIApi.GetHeroIconDragSize()

	LuaUtility.SetScaleWithTransform(self.gameObject.transform, size, size, size)
	self.SelectParent.gameObject:SetActive(true)
end

function FormationFightOrderCell:OnDrag(go, eventData, eventData_go)
	return
end

function FormationFightOrderCell:OnEndDrag(go, eventData, eventData_go)
	local size = FormationUIApi.GetHeroIconDefaultSize()

	LuaUtility.SetScaleWithTransform(self.gameObject.transform, size, size, size)
	self.SelectParent.gameObject:SetActive(false)
end

function FormationFightOrderCell:OnEndShift(oldIndex, newIndex)
	self.MainUIController:ShiftIndex(oldIndex, newIndex)
end

function FormationFightOrderCell:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return FormationFightOrderCell

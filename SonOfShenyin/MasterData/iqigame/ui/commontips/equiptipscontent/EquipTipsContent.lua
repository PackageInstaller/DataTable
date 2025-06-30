-- chunkname: @IQIGame\\UI\\CommonTips\\EquipTipsContent\\EquipTipsContent.lua

local EquipTipsHeadContent = require("IQIGame.UI.CommonTips.EquipTipsContent.EquipTipsHeadContent")
local EquipTipsInfoContent = require("IQIGame.UI.CommonTips.EquipTipsContent.EquipTipsInfoContent")
local EquipTipsContent = {}

function EquipTipsContent.New(view)
	local obj = Clone(EquipTipsContent)

	obj:__Init(view)

	return obj
end

function EquipTipsContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.headContent = EquipTipsHeadContent.New(self.TopParent)
	self.infoContent = EquipTipsInfoContent.New(self.ContentScrollView)

	function self.__onDetailBtnClickEventProxy()
		self:__OnDetailBtnClickEventHandler()
	end

	function self.__OnDecomposeBtnClickEventProxy()
		self:__OnDecomposeBtnClickEventHandler()
	end

	self:__AddListeners()
end

function EquipTipsContent:__AddListeners()
	self.DetailBtn:GetComponent("Button").onClick:AddListener(self.__onDetailBtnClickEventProxy)
end

function EquipTipsContent:__RemoveListeners()
	self.DetailBtn:GetComponent("Button").onClick:RemoveListener(self.__onDetailBtnClickEventProxy)
end

function EquipTipsContent:Dispose()
	self:__RemoveListeners()
	self.headContent:Dispose()
	self.infoContent:Dispose()

	self.itemData = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipTipsContent:SetData(userData)
	self.itemData = userData.data

	self.headContent:SetData(self.itemData, userData.cbParams)
	self.infoContent:SetData(self.itemData, userData.cbParams)
	self.DetailBtn:SetActive(not userData.cbParams.forShow)

	local isEquip = self:__RefreshWareState(self.itemData.equipData)

	self.infoContent:SetEquipmentSeatActive(isEquip)
end

function EquipTipsContent:__RefreshWareState(equipData)
	local needShow = equipData.heroCid ~= 0 and equipData.heroCid ~= nil

	LuaUtility.SetGameObjectShow(self.WareState, needShow)

	if needShow then
		local headPath = SkinModule.GetHeroCurrentSkinImgPath(equipData.heroCid, Constant.SkinImageType.HeadIcon)

		AssetUtil.LoadImage(self, headPath, self.heroHeadIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.wareText, CfgHeroTable[equipData.heroCid].Name)
	end

	return needShow
end

function EquipTipsContent:__OnDetailBtnClickEventHandler()
	UIModule.Close(Constant.UIControllerName.CommonEquipTipsUI)
	UIModule.Open(Constant.UIControllerName.EquipStrengthUI, Constant.UILayer.UI, {
		isHideEquipButton = true,
		equipData = self.itemData.equipData
	})
end

return EquipTipsContent

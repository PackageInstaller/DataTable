-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleBreach\\RoleBreachAttrView.lua

local m = {
	AttrItemCellList = {}
}
local roleBreachAttrItem = require("IQIGame.UI.RoleDevelopment.RoleBreachAttrItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local luaTable = {}

	self.MainAttributeItemBindLua = LuaCodeInterface.BindOutlet(self.MainAttributeItem, luaTable)

	UGUIUtil.SetText(self.MainAttributeItemBindLua.CurLvTitle, RoleDevelopmentApi:GetLvText())
	UGUIUtil.SetText(self.MainAttributeItemBindLua.NextLvTitle, RoleDevelopmentApi:GetLvText())
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(cacheHeroData)
	self.heroData = cacheHeroData

	self:ShowRoleAttr()
	self:SetRoleBreachState()
	self:ShowHeroInfo()
end

function m:ShowHeroInfo()
	LuaUtility.SetText(self.HeroInfoText, self.heroData:GetCurHeroBreachCfg(self.heroData.breakLv).BreakDes)

	local path = self.heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesVerticalDraw)
	local giftItems = self.heroData:GetCurHeroBreachCfg(self.heroData.breakLv).BreakGift

	if giftItems ~= nil and table.len(giftItems) > 0 then
		local giftItem = giftItems[1]

		if SkinModule.IsSkinItemByItemCid(giftItem) then
			local skinCid = SkinModule.GetSkinCidBySkinItemCid(giftItem)

			path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesVerticalDraw)
		end
	end

	local goHeroImageCom = self.RoleImg:GetComponent("Image")

	self:LoadImage(path, goHeroImageCom)
	LuaUtility.SetGameObjectShow(self.RoleForceImg, CfgHeroTable[self.heroData.cid].Forces > 0)

	if CfgHeroTable[self.heroData.cid].Forces > 0 then
		path = WarlockApi:GetForceImgPath(CfgHeroTable[self.heroData.cid].Forces)

		self:LoadImage(path, self.RoleForceImg:GetComponent("Image"))
	end
end

function m:ShowRoleAttr()
	self.curAttrData = self.heroData:QueryHeroBreachCfg(self.heroData.breakLv)
	self.nextAttrData = self.heroData:QueryHeroBreachCfg(self.heroData.breakLv + 1)

	UGUIUtil.SetText(self.MainAttributeItemBindLua.AttrName, RoleDevelopmentApi:GetAttarTitle())
	UGUIUtil.SetText(self.MainAttributeItemBindLua.CurAttrText, self.curAttrData.MaxHeroLv .. "/")
	UGUIUtil.SetText(self.MainAttributeItemBindLua.CurAttrMaxText, self.curAttrData.MaxHeroLv)
	self.MainAttributeItemBindLua.NextAttrText:SetActive(not self.heroData:IsMaxBreachLv())
	self.MainAttributeItemBindLua.ArrowImg:SetActive(not self.heroData:IsMaxBreachLv())
	self.MainAttributeItemBindLua.NextLvTitle:SetActive(not self.heroData:IsMaxBreachLv())
	self.MainAttributeItemBindLua.AttrImg:SetActive(false)

	if not self.heroData:IsMaxBreachLv() then
		UGUIUtil.SetText(self.MainAttributeItemBindLua.NextAttrText, self.curAttrData.MaxHeroLv .. "/")
		UGUIUtil.SetText(self.MainAttributeItemBindLua.NextAttrMaxText, self.nextAttrData.MaxHeroLv)
	end

	self:RefreshAttr()
end

function m:RefreshAttr()
	local lastAttrData

	lastAttrData = (self.heroData.breakLv ~= 0 or nil) and self.heroData:QueryHeroBreachCfg(self.heroData.breakLv - 1)

	local attrLength = 0

	for i = 1, #self.nextAttrData.AttrType do
		if self.nextAttrData.AttrType[i] ~= 0 and CfgAttributeTable[self.nextAttrData.AttrType[i]] ~= nil and CfgAttributeTable[self.nextAttrData.AttrType[i]].Show and self.nextAttrData.AttrValue[i] ~= 0 then
			attrLength = attrLength + 1

			if self.AttrItemCellList[attrLength] == nil then
				local attrItem = UnityEngine.Object.Instantiate(self.AttributeItem)

				attrItem.transform:SetParent(self.AttributeGrid.transform, false)

				self.AttrItemCellList[attrLength] = roleBreachAttrItem.New(attrItem)
			end

			self.AttrItemCellList[attrLength]:SetData(self.heroData, self.curAttrData, self.nextAttrData, i, lastAttrData)
		end
	end

	for i = 1, #self.AttrItemCellList do
		if attrLength < i then
			self.AttrItemCellList[i]:Hide()
		else
			self.AttrItemCellList[i]:Show()
		end
	end
end

function m:SetRoleBreachState()
	self:LoadImage(self.heroData:GetCurStaticSkinImagePath(Constant.SkinType.StaticImage), self.RoleImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetNextBreachStateImg(self.heroData.breakLv + 1), self.NextBreachImg:GetComponent("Image"))
	self:LoadImage(RoleDevelopmentApi:GetNextBreachFontImg(self.heroData.breakLv + 1), self.NexBreachFontImg:GetComponent("Image"))
end

function m:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, self.LoadImageFail, imgobj)
end

function m:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData:GetComponent(typeof(UnityEngine.RectTransform)), userData)
end

function m:LoadImageFail(assetName, status, errorMessage, userData)
	return
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m

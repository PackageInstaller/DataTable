-- chunkname: @IQIGame\\UI\\Soul\\SoulHeadCell.lua

SoulHeadCell = {
	showFavorLv = false,
	isMySoul = true,
	showLv = true
}

function SoulHeadCell.New(go, showLv, showFavorLv)
	local o = Clone(SoulHeadCell)

	o:Initialize(go, showLv, showFavorLv)

	return o
end

function SoulHeadCell:Dispose()
	self.goView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtn)
	EventDispatcher.RemoveEventListener(EventID.SoulDataChange, self.delegateSoulDataChange)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function SoulHeadCell:Initialize(go, showLv, showFavorLv)
	self.goView = go

	if showLv ~= nil then
		self.showLv = showLv
	end

	if showFavorLv ~= nil then
		self.showFavorLv = showFavorLv
	end

	LuaCodeInterface.BindOutlet(self.goView, self)

	function self.DelegateOnClickBtn()
		self:OnclickBtn()
	end

	function self.delegateSoulDataChange(soulID)
		self:OnSoulDataChange(soulID)
	end

	self.imgIconHead = self.goIconHead:GetComponent("Image")
	self.imgQualityFrame = self.goQualityFrame:GetComponent("Image")

	self.goView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtn)
	EventDispatcher.AddEventListener(EventID.SoulDataChange, self.delegateSoulDataChange)
end

function SoulHeadCell:RefreshView(pSoulData, checkSpecialEquip)
	self.soulData = pSoulData

	self:SetSelected(false)

	local woreSpecialEquip = SoulPrefabModule.CheckWoreSpecialEquip(self.soulData.soulCid)

	self:LoadAsset(UIGlobalApi.GetSoulHeadQualityPath(woreSpecialEquip), self.imgQualityFrame)
	self:LoadAsset(UIGlobalApi.GetImagePath(self.soulData:GetCfgSoulRes3D().HeadIcon), self.imgIconHead)
	self:UpdateSoulMood()
	self.goLevelText:SetActive(self.showLv)
	UGUIUtil.SetText(self.goLevelText, self.soulData.lv)
	self.FavorLv:SetActive(self.showFavorLv)
	UGUIUtil.SetText(self.TextFavorLv, self.soulData.favorLv)
end

function SoulHeadCell:OnSoulDataChange(soulID)
	if self.soulData and self.soulData.soulCid == soulID and self.isMySoul then
		self.soulData = SoulModule.GetSoulData(soulID)

		self:UpdateSoulMood()
	end
end

function SoulHeadCell:UpdateSoulMood()
	local status = SoulModule.GetMoodState(self.soulData.soulCid, self.soulData.mood)

	if self.goMoonIcon ~= nil and not LuaCodeInterface.GameObjIsDestroy(self.goMoonIcon) then
		self:LoadAsset(MiscApi:GetString("SoulMoodImagePath", status), self.goMoonIcon:GetComponent("Image"))
	end
end

function SoulHeadCell:SetImageRaycastTarget(value)
	for i = 0, self.goView.transform.childCount - 1 do
		local childTrans = self.goView.transform:GetChild(i)
		local image = childTrans:GetComponent("Image")

		if image ~= nil then
			image.raycastTarget = value
		end
	end
end

function SoulHeadCell:OnclickBtn()
	if self.clickCallBack ~= nil then
		self.clickCallBack(self)
	end
end

function SoulHeadCell:LoadAsset(path, icon)
	AssetUtil.LoadImage(self, path, icon)
end

function SoulHeadCell:SetSelected(value)
	self.Selected = value

	self.goCheck:SetActive(value)
end

function SoulHeadCell:SetMouseEnabled(value)
	self.goView:GetComponent("Button").interactable = value

	local graphics = self.goView:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

	for i = 0, graphics.Length - 1 do
		graphics[i].raycastTarget = value
	end
end

function SoulHeadCell:SetIsMine(value)
	self.isMySoul = value

	self.goMoonIcon:SetActive(value)
end

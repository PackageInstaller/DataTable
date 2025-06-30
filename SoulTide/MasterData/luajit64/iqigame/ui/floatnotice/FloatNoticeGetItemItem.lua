-- chunkname: @IQIGame\\UI\\FloatNotice\\FloatNoticeGetItemItem.lua

local m = {
	IsExpired = false,
	ShowEffectDelay = 0.2,
	__ActiveTimer = -1,
	Type = 0
}
local FloatNoticeItemBase = require("IQIGame.UI.FloatNotice.FloatNoticeItemBase")

m = extend(FloatNoticeItemBase, m)

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:OnInit()
	self.ItemCell = ItemCell.New(self.ItemCellGo, false)
end

function m:__GetType()
	return Constant.Notice.FloatTypeGetItem
end

function m:SetData(param)
	self.__ActiveTimer = 0

	local cfgItemData = CfgItemTable[param.itemCid]

	self.ItemCell:SetItemByCID(param.itemCid, 1)
	UGUIUtil.SetText(self.ItemNameText, cfgItemData.Name)
	UGUIUtil.SetText(self.ItemNumText, FloatNoticeUIApi:GetString("ItemNumText", param.itemNum))
	AssetUtil.LoadImage(self, FloatNoticeUIApi:GetString("QualityImage", cfgItemData.Quality), self.QualityBg:GetComponent("Image"))
	self.QualityEffect4:SetActive(cfgItemData.Quality == 4)
	self.QualityEffect5:SetActive(cfgItemData.Quality == 5)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	self.__ActiveTimer = self.__ActiveTimer + elapseSeconds

	if self.__ActiveTimer ~= -1 and self.__ActiveTimer > self.ShowEffectDelay then
		self.Effect:SetActive(true)

		self.__ActiveTimer = -1
	end
end

function m:OnAboutToOutOfSight()
	self:DisableEffect()
end

function m:OnReset()
	self:DisableEffect()
end

function m:DisableEffect()
	self.Effect:SetActive(false)

	self.__ActiveTimer = -1
end

function m:OnDispose()
	AssetUtil.UnloadAsset(self)
	self.ItemCell:Dispose()
end

return m

-- chunkname: @IQIGame\\UI\\Setting\\SettingExhibitionPosCell.lua

local m = {}

function m.New(view, pos)
	local obj = Clone(m)

	obj:Init(view, pos)

	return obj
end

function m:Init(view, pos)
	self.View = view
	self.pos = pos

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:SetData(cfgID)
	self.setCfgID = cfgID

	if cfgID ~= nil and cfgID > 0 then
		self.Empty:SetActive(false)
		self.Full:SetActive(true)

		local path = UIGlobalApi.GetIconPath(CfgItemTable[cfgID].Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	else
		self.Empty:SetActive(true)
		self.Full:SetActive(false)
	end
end

function m:OnBtnSelf()
	local tab = WarehouseModule.GetItemsByTypeAndSubType(Constant.ItemType.Item, 39)

	if #tab == 0 then
		NoticeModule.ShowNotice(21090000)

		return
	end

	UIModule.Open(Constant.UIControllerName.ChangeExhibitionUI, Constant.UILayer.UI, {
		self.pos,
		self.setCfgID
	})
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m

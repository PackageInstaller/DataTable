-- chunkname: @IQIGame\\UI\\Mall\\MallRecommendView.lua

local MallRecommendView = {
	bgPool = {}
}

function MallRecommendView.New(view, mainView)
	local obj = Clone(MallRecommendView)

	obj:Init(view, mainView)

	return obj
end

function MallRecommendView:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnJump = self.goBtnJump:GetComponent("Button")

	function self.onClickBtnJumpDelegate()
		self:OnClickBtnJump()
	end

	self:OnAddListener()
end

function MallRecommendView:Open(cfgMallData)
	self.cfgMallData = cfgMallData

	self.View:SetActive(true)
	self:RefreshBg()

	self.isOpening = true
end

function MallRecommendView:Close()
	self:OnHide()
end

function MallRecommendView:OnHide()
	self.View:SetActive(false)

	self.isOpening = false
end

function MallRecommendView:OnDestroy()
	self.mainView = nil

	AssetUtil.UnloadAsset(self)
	self:OnRemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MallRecommendView:OnAddListener()
	self.btnJump.onClick:AddListener(self.onClickBtnJumpDelegate)
end

function MallRecommendView:OnRemoveListener()
	self.btnJump.onClick:RemoveListener(self.onClickBtnJumpDelegate)
end

function MallRecommendView:OnClickBtnJump()
	JumpModule.Jump(self.cfgMallData.Source, self.cfgMallData.Id)
end

function MallRecommendView:RefreshBg()
	local path = UIGlobalApi.GetAssetPath(self.cfgMallData.BG)
	local bg = self.bgPool[path]

	if bg == nil then
		AssetUtil.LoadAsset(self, path, self.OnLoadBgSuccess)

		return
	end

	for i, v in pairs(self.bgPool) do
		v:SetActive(path == i)
	end
end

function MallRecommendView:OnLoadBgSuccess(assetName, asset, duration, userData)
	if not self.isOpening then
		return
	end

	local bg = UnityEngine.Object.Instantiate(asset)

	bg.transform:SetParent(self.goBgContainer.transform, false)

	self.bgPool[assetName] = bg

	local sortComponents = bg:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))
	local canvas = self.mainView.UIController:GetComponent("Canvas")

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = canvas
	end

	self:RefreshBg()
end

return MallRecommendView

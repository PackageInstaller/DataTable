-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\GameLevelInfo\\GameChapterItem.lua

local m = {
	isUnlock = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.EnterBtnConmponent = self.View:GetComponent("Button")
	self.BgImgComponent = self.Bg:GetComponent("Image")
	self.ProgressImgComponent = self.ProgressImg:GetComponent("Image")
	self.ProgressTextComponent = self.ProgressText:GetComponent("Text")

	function self.DelegateBtnClick()
		self:OnEnterBtnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.EnterBtnConmponent.onClick:AddListener(self.DelegateBtnClick)
end

function m:RemoveListeners()
	self.EnterBtnConmponent.onClick:RemoveListener(self.DelegateBtnClick)
end

function m:SetData(data)
	self.ChapterData = data
	self.ChapterNameText:GetComponent("Text").text = data:GetCfg().ChapterTypeName
	self.isUnlock = GameChapterModule.ChapterIsUnLock(self.ChapterData.Id)

	data:UpdateData(self.ChapterData.Id, self.isUnlock)
	self.Bg:SetActive(self.isUnlock)
	self.Unlock:SetActive(self.isUnlock)
	self.Lock:SetActive(not self.isUnlock)

	if self.isUnlock then
		local path = UIGlobalApi.GetImagePath(data:GetCfg().Picture)

		self:LoadImage(path, self.BgImgComponent)

		local maxNum = #GameChapterModule.levelItems[self.ChapterData.Id]
		local num = GameChapterModule.GetChapterProgress(self.ChapterData.Id)

		self.ProgressImgComponent.fillAmount = num / maxNum
		self.ProgressTextComponent.text = math.floor(num / maxNum * 100) .. "%"
	end
end

function m:OnEnterBtnClick()
	if self.isUnlock then
		UIModule.Open(Constant.UIControllerName.GameLevelUI, Constant.UILayer.UI, self.ChapterData)
	else
		NoticeModule.ShowNotice(51009)
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:LoadImage(path, imageGo)
	AssetUtil.LoadImage(self, path, imageGo)
end

return m

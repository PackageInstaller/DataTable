-- chunkname: @IQIGame\\UI\\Chapter\\EquipChapter\\EquipChapterItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateEnterStageBtn()
		self:OnOpenStageBtnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateEnterStageBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateEnterStageBtn)
end

function m:SetData(chapterData)
	self.chapterData = chapterData

	local path = UIGlobalApi.GetImagePath(chapterData:GetCfg().ChapterImg)

	self:LoadImg(path, self.ChapterImg)

	path = UIGlobalApi.GetImagePath(chapterData:GetCfg().ChapterNameImg)

	self:LoadImg(path, self.ChapterNameImg)

	if chapterData:GetCfg().ChapterNameBGImg then
		path = UIGlobalApi.GetImagePath(chapterData:GetCfg().ChapterNameBGImg)

		self:LoadImg(path, self.ChapterNameBg)
	end

	UGUIUtil.SetText(self.DropDesc, chapterData:GetCfg().Desc)
end

function m:OnOpenStageBtnClick()
	UIModule.Open(Constant.UIControllerName.EquipDupUI, Constant.UILayer.UI, self.chapterData)
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m

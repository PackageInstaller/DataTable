-- chunkname: @IQIGame\\UI\\Library\\LibraryNewsMsgView.lua

local LibraryNewsMsgView = {}

function LibraryNewsMsgView.New(view, parent)
	local obj = Clone(LibraryNewsMsgView)

	obj:Init(view, parent)

	return obj
end

function LibraryNewsMsgView:Init(view, parent)
	self.View = view
	self.rootParent = parent

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextWeatherTitle, LibraryNewsUIApi:GetString("TextWeatherTitle"))

	self.btnClose = self.BtnClose:GetComponent("Button")
	self.btnClose1 = self.BtnClose1:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end

	self:AddEventListener()
end

function LibraryNewsMsgView:AddEventListener()
	self.btnClose.onClick:AddListener(self.delegateBtnClose)
	self.btnClose1.onClick:AddListener(self.delegateBtnClose)
end

function LibraryNewsMsgView:RemoveEventListener()
	self.btnClose.onClick:RemoveListener(self.delegateBtnClose)
	self.btnClose1.onClick:RemoveListener(self.delegateBtnClose)
end

function LibraryNewsMsgView:UpDateView()
	if self.ImgNewsType and self.libraryNewData.cfgInfo.PaperType ~= nil and self.libraryNewData.cfgInfo.PaperType ~= "" then
		local typePath = LibraryNewsUIApi:GetString("NewsTypePath", self.libraryNewData.cfgInfo.PaperType)

		AssetUtil.LoadImage(self, typePath, self.ImgNewsType:GetComponent("Image"))
	end

	if self.TextPaperTypeName and self.libraryNewData.cfgInfo.PaperTypeName ~= nil and self.libraryNewData.cfgInfo.PaperTypeName ~= "" then
		UGUIUtil.SetText(self.TextPaperTypeName, self.libraryNewData.cfgInfo.PaperTypeName)
	end

	if self.TextPaperTypeEngName and self.libraryNewData.cfgInfo.PaperTypeEngName ~= nil and self.libraryNewData.cfgInfo.PaperTypeEngName ~= "" then
		UGUIUtil.SetText(self.TextPaperTypeEngName, self.libraryNewData.cfgInfo.PaperTypeEngName)
	end

	if self.TextWeather and self.libraryNewData.cfgInfo.Weather ~= nil and self.libraryNewData.cfgInfo.Weather ~= "" then
		UGUIUtil.SetText(self.TextWeather, self.libraryNewData.cfgInfo.Weather)
	end

	if self.ImgWeather and self.libraryNewData.cfgInfo.WeatherImage ~= nil and self.libraryNewData.cfgInfo.WeatherImage ~= "" then
		local imgWeatherPath = UIGlobalApi.GetImagePath(self.libraryNewData.cfgInfo.WeatherImage)

		AssetUtil.LoadImage(self, imgWeatherPath, self.ImgWeather:GetComponent("Image"))
	end

	if self.TextPaperData and self.libraryNewData.cfgInfo.PaperData ~= nil and self.libraryNewData.cfgInfo.PaperData ~= "" then
		UGUIUtil.SetText(self.TextPaperData, self.libraryNewData.cfgInfo.PaperData)
	end

	if self.TextMainNews1 and self.libraryNewData.cfgInfo.MainNews1 ~= nil and self.libraryNewData.cfgInfo.MainNews1 ~= "" then
		UGUIUtil.SetText(self.TextMainNews1, self.libraryNewData.cfgInfo.MainNews1)
	end

	if self.TextMainNewsEng1 and self.libraryNewData.cfgInfo.MainNewsEng1 ~= nil and self.libraryNewData.cfgInfo.MainNewsEng1 ~= "" then
		UGUIUtil.SetText(self.TextMainNewsEng1, self.libraryNewData.cfgInfo.MainNewsEng1)
	end

	if self.TextSubHeading1 and self.libraryNewData.cfgInfo.SubHeading1 ~= nil and self.libraryNewData.cfgInfo.SubHeading1 ~= "" then
		UGUIUtil.SetText(self.TextSubHeading1, self.libraryNewData.cfgInfo.SubHeading1)
	end

	if self.TextMainContent1 and self.libraryNewData.cfgInfo.MainContent1 ~= nil and self.libraryNewData.cfgInfo.MainContent1 ~= "" then
		UGUIUtil.SetText(self.TextMainContent1, self.libraryNewData.cfgInfo.MainContent1)
	end

	if self.ImgMainImage1 and self.libraryNewData.cfgInfo.MainImage1 ~= nil and self.libraryNewData.cfgInfo.MainImage1 ~= "" then
		local imgMainImage1Path = UIGlobalApi.GetImagePath(self.libraryNewData.cfgInfo.MainImage1)

		AssetUtil.LoadImage(self, imgMainImage1Path, self.ImgMainImage1:GetComponent("Image"))
	end

	if self.TextMainNews2 and self.libraryNewData.cfgInfo.MainNews2 ~= nil and self.libraryNewData.cfgInfo.MainNews2 ~= "" then
		UGUIUtil.SetText(self.TextMainNews2, self.libraryNewData.cfgInfo.MainNews2)
	end

	if self.TextMainNewsEng2 and self.libraryNewData.cfgInfo.MainNewsEng2 ~= nil and self.libraryNewData.cfgInfo.MainNewsEng2 ~= "" then
		UGUIUtil.SetText(self.TextMainNewsEng2, self.libraryNewData.cfgInfo.MainNewsEng2)
	end

	if self.TextSubHeading2 and self.libraryNewData.cfgInfo.SubHeading2 ~= nil and self.libraryNewData.cfgInfo.SubHeading2 ~= "" then
		UGUIUtil.SetText(self.TextSubHeading2, self.libraryNewData.cfgInfo.SubHeading2)
	end

	if self.TextMainContent2 and self.libraryNewData.cfgInfo.MainContent2 ~= nil and self.libraryNewData.cfgInfo.MainContent2 ~= "" then
		UGUIUtil.SetText(self.TextMainContent2, self.libraryNewData.cfgInfo.MainContent2)
	end

	if self.ImgMainImage2 and self.libraryNewData.cfgInfo.MainImage2 ~= nil and self.libraryNewData.cfgInfo.MainImage2 ~= "" then
		local imgMainImage2Path = UIGlobalApi.GetImagePath(self.libraryNewData.cfgInfo.MainImage2)

		AssetUtil.LoadImage(self, imgMainImage2Path, self.ImgMainImage2:GetComponent("Image"))
	end

	if self.TextMainNews3 and self.libraryNewData.cfgInfo.MainNews3 ~= nil and self.libraryNewData.cfgInfo.MainNews3 ~= "" then
		UGUIUtil.SetText(self.TextMainNews3, self.libraryNewData.cfgInfo.MainNews3)
	end

	if self.TextMainNewsEng3 and self.libraryNewData.cfgInfo.MainNewsEng3 ~= nil and self.libraryNewData.cfgInfo.MainNewsEng3 ~= "" then
		UGUIUtil.SetText(self.TextMainNewsEng3, self.libraryNewData.cfgInfo.MainNewsEng3)
	end

	if self.TextSubHeading3 and self.libraryNewData.cfgInfo.SubHeading3 ~= nil and self.libraryNewData.cfgInfo.SubHeading3 ~= "" then
		UGUIUtil.SetText(self.TextSubHeading3, self.libraryNewData.cfgInfo.SubHeading3)
	end

	if self.TextMainContent3 and self.libraryNewData.cfgInfo.MainContent3 ~= nil and self.libraryNewData.cfgInfo.MainContent3 ~= "" then
		UGUIUtil.SetText(self.TextMainContent3, self.libraryNewData.cfgInfo.MainContent3)
	end

	if self.ImgMainImage3 and self.libraryNewData.cfgInfo.MainImage3 ~= nil and self.libraryNewData.cfgInfo.MainImage3 ~= "" then
		local imgMainImage3Path = UIGlobalApi.GetImagePath(self.libraryNewData.cfgInfo.MainImage3)

		AssetUtil.LoadImage(self, imgMainImage3Path, self.ImgMainImage3:GetComponent("Image"))
	end
end

function LibraryNewsMsgView:OnClickBtnClose()
	self:Close()
end

function LibraryNewsMsgView:Open(data)
	self.libraryNewData = data

	self.rootParent.NewsPaperView:SetActive(true)
	self.rootParent.Panel:SetActive(false)
	self.View:SetActive(true)
	self:UpDateView()

	if self.libraryNewData.isRead == false then
		TownLibraryModule.ViewNewsBook(self.libraryNewData.cfgID)
	end
end

function LibraryNewsMsgView:Close()
	self.View:SetActive(false)
	self.rootParent.NewsPaperView:SetActive(false)
	self.rootParent.Panel:SetActive(true)

	if self.closeCallBack then
		self.closeCallBack()
	end
end

function LibraryNewsMsgView:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListener()

	self.closeCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return LibraryNewsMsgView

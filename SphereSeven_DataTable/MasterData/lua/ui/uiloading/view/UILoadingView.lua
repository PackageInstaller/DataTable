--[[
-- added by wsh @ 2017-12-18
-- UILoading视图层
--]]

if LoadingBg == nil then
	LoadingBg = {
		[1] = "1.png",
		[2] = "2.png",
		[3] = "3.png",
		[4] = "4.png",
	}
end

local UILoadingView = BaseClass("UILoadingView", UIBaseView)
local base = UIBaseView

local function InitTipsText(self)
	local id = Mathf.Random(1, table.count(Z_TipsText))
	LangUtil.BindText(self.tips_text).text = Z_TipsText[id].Content
end

local function OnCreate(self)
	base.OnCreate(self)
	local rc = self.rc
    self.loading_slider = rc:GetObject("SliderBar"):GetComponent(typeof(UE_UI.Slider))
	self.tips_text = LangUtil.BindText(rc:GetObject("TipsText"))
	self.loading_slider.normalizedValue= 0.0
	self.card_info = rc:GetObject("CardInfo")
	self.img = rc:GetObject("BG"):GetComponent("Image")
	self.parent = rc:GetObject("Parent")
	self.parent:SetActive(false)
end

local function OnEnable(self)
	base.OnEnable(self)
	self.parent:SetActive(false)
	self.tips_text.text = ""
	local tab = {}
	table.walk(LoadingBg, function (k, v)
		tab[k] = "UI/LoadBg_"..LangUtil.GetLangType().."/"..v
	end)
	local count = math.random(1, table.count(tab))
	self.img.sprite = AtlasManager:GetInstance():CoLoadImageAsync(tab[count])
	InitTipsText(self)
	self.parent:SetActive(true)
end

local function Update(self)
	self.loading_slider.normalizedValue = self.model.value
end

local function OnDestroy(self)
	self.loading_slider = nil
	base.OnDestroy(self)
end

UILoadingView.OnCreate = OnCreate
UILoadingView.OnEnable = OnEnable
UILoadingView.Update = Update
UILoadingView.OnDestroy = OnDestroy

return UILoadingView
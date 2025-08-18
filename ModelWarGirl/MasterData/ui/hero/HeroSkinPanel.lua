-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroSkinPanel.lua

local HeroContentSkinPanel = require("UI/Hero/ContentPanel/HeroContentSkinPanel")
local HeroContentBasePanel = require("UI/Hero/ContentPanel/HeroContentBasePanel")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local BtnTab = Class("BtnTab", UIControls.Panel)

function BtnTab:ctor()
	self.btn = UIControls.Button(self, self.mPath .. "")

	self.btn:addEventClick(self.onBtnClick)

	self.iconNew = UIControls.Panel(self, self.mPath .. "/IconNew")
end

function BtnTab:setNew(hasNew)
	self.iconNew:setVisible(hasNew)
end

function BtnTab:setData(idx)
	self.index = idx
end

function BtnTab:setSelect(isSelected)
	self.btn:setEnable(not isSelected)
end

function BtnTab:onBtnClick()
	if self.mEventClick then
		self.mEventClick(self.index)
	end
end

local strClassName = "HeroSkinPanel"
local HeroSkinPanel = Class(strClassName, UIControls.Panel)
local HERO_CONTENT_MAP = {
	{
		btn2DVisible = true,
		redDotFunc = "checkSkinNew",
		pagePath = "SkinInfoPanel",
		btnName = "BtnTabSkin",
		luaTable = HeroContentSkinPanel
	},
	{
		btn2DVisible = false,
		redDotFunc = "checkBaseNew",
		pagePath = "BedMainPanel",
		btnName = "BtnTabBed",
		luaTable = HeroContentBasePanel
	}
}

function HeroSkinPanel:ctor()
	self.btnTabs = {}
	self.pages = {}
	self.curSelBase = {}

	self:initUI()
end

function HeroSkinPanel:initUI()
	for idx, info in ipairs(HERO_CONTENT_MAP) do
		if not self.btnTabs[idx] then
			self.btnTabs[idx] = BtnTab(self, self.mPath .. "/MainInfoPanel/" .. info.btnName)
			self.btnTabs[idx].mEventClick = Slot(self.onTabClick, self)
		end

		self.btnTabs[idx]:setData(idx)

		if not self.pages[idx] then
			local pageType = info.luaTable

			if pageType then
				self.pages[idx] = pageType(self, self.mPath .. "/MainInfoPanel/" .. info.pagePath)
			end
		end
	end

	self.btnChange2d = UIControls.Button(self, self.mPath .. "/MainInfoPanel/BtnChange2D", "TxtChange")

	self.btnChange2d:addEventClick(self.onBtnPortraitClick)

	self.imgChange2d = UIControls.Image(self, self.mPath .. "/MainInfoPanel/BtnChange2D/ImgChange")
	self.btnAttr = UIControls.Button(self, self.mPath .. "/MainInfoPanel/BtnAttrInfo")

	self.btnAttr:addEventClick(Slot(self.onBtnAttrClick, self))

	if self.pages[1].enjoyPanel then
		local btnEnjoy = UIControls.Button(self, self.mPath .. "/MainInfoPanel/BtnEnjoy")

		self.pages[1].enjoyPanel:setBtnEnjoy(btnEnjoy)
	end
end

function HeroSkinPanel:resetPage()
	if self.curSelId == 2 then
		self.pages[self.curSelId]:setVisible(false)
		self.btnTabs[self.curSelId]:setSelect(false)
	end

	self.curSelId = 1

	self.pages[1]:setHideByScale(false)
	self.pages[1]:resetShowType()
	self.btnTabs[1]:setSelect(true)
	self.btnChange2d:setVisible(true)
end

function HeroSkinPanel:setHero(hero, isEnter, isDrag, needResetUI)
	local svrData = CurAvatar:getSkinDataByHeroId(hero.id)

	self.svrData = svrData or {}
	self.hero = hero

	local needRefresTarget = needResetUI or isEnter or isDrag

	if self.pages then
		for idx, page in ipairs(self.pages) do
			page:setHero(hero, needRefresTarget)
		end
	end

	self.curSelId = self.curSelId or 1

	if not needRefresTarget then
		if self.hero then
			local speCamp = self.hero:isLightOrDark()

			if not speCamp and self.btnTabs[self.curSelId] then
				-- block empty
			else
				self:onTabClick(1)

				self.curSelId = 1
			end
		end
	else
		self:onTabClick(1)

		self.curSelId = 1
	end

	self:checkNew()
end

function HeroSkinPanel:checkNew()
	for id, btn in ipairs(self.btnTabs) do
		if HERO_CONTENT_MAP[id].redDotFunc then
			local func = self[HERO_CONTENT_MAP[id].redDotFunc]
			local hasNew = func(self)

			btn:setNew(hasNew)
		end
	end
end

function HeroSkinPanel:onTabClick(idx)
	if idx == 2 and self.hero then
		local speCamp = self.hero:isLightOrDark()

		if speCamp == true then
			MsgManager.notice(Lang.get(30360))

			return
		end
	end

	if self.curSelId then
		self.btnTabs[self.curSelId]:setSelect(false)

		if self.pages[self.curSelId].onHide then
			self.pages[self.curSelId]:onHide()
		end

		if self.pages[self.curSelId].hideByScale then
			self.pages[self.curSelId]:setHideByScale(true)
		else
			self.pages[self.curSelId]:setVisible(false)
		end
	end

	self.curSelId = idx

	self.btnTabs[idx]:setSelect(true)
	self.pages[idx]:setVisible(true)
	self.pages[idx]:setHideByScale(false)
	self.pages[idx]:setData(true)

	local btn2DVisible = HERO_CONTENT_MAP[idx].btn2DVisible

	self.btnChange2d:setVisible(btn2DVisible)
end

function HeroSkinPanel:onCloseClick()
	for idx, page in ipairs(self.pages) do
		if page.onHide then
			page:onHide()
		end
	end

	self:setHideByScale(true)
end

function HeroSkinPanel:onBtnPortraitClick()
	if self.pages[self.curSelId].onBtnPortraitClick then
		self.pages[self.curSelId]:onBtnPortraitClick()
	end
end

function HeroSkinPanel:onBtnAttrClick()
	local ui = UIManager.getUI("skinAttrTips", true)

	ui:setData(self.hero.id)
end

function HeroSkinPanel:checkBaseNew()
	if CurAvatar.canNewBaseUnlockDic[self.hero.gid] then
		return true
	end

	return false
end

function HeroSkinPanel:checkSkinNew()
	if CurAvatar.canNewSkinUnlockDic[self.hero.gid] then
		return true
	end

	return false
end

function HeroSkinPanel:resetCurSel(ignoreAnim)
	for idx, page in ipairs(self.pages) do
		page:resetCurSel(ignoreAnim)
	end
end

function HeroSkinPanel:getEnJoyPanel()
	return self.pages[1].enjoyPanel
end

return HeroSkinPanel

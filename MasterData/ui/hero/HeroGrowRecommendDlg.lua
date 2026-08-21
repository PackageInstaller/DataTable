-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroGrowRecommendDlg.lua

local RecHeroGrid = require("UI/Hero/RecHeroGrid")
local PriestHeroGrid = require("UI/Hero/PriestHeroGrid")
local strClassName = "HeroGrowRecommendDlg"
local HeroGrowRecommendDlg = Class(strClassName, UIControls.Window)

function HeroGrowRecommendDlg:ctor()
	self:initUI()
end

function HeroGrowRecommendDlg:initUI()
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.priestHeroGridDic = {}
	self.recHeroGridDic = {}

	for i = 1, 5 do
		local tempPriestHeroGrid = PriestHeroGrid(self, "MainInfoPanel/PresentPanel/Panel" .. i)

		table.insert(self.priestHeroGridDic, tempPriestHeroGrid)

		local tempRecHeroGrid = RecHeroGrid(self, "MainInfoPanel/RecommendPanel/Panel" .. i)

		table.insert(self.recHeroGridDic, tempRecHeroGrid)
	end
end

function HeroGrowRecommendDlg:onOpen()
	HeroGrowRecommendDlg.super.onOpen(self)
	self:refreshRecommendData()
end

function HeroGrowRecommendDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RECOMMEND_GROW)
end

function HeroGrowRecommendDlg:refreshRecommendData()
	self.priestsDic = CurAvatar:getPriestsFormationDic()
	self.recommendDic = CurAvatar:getRecommendFormationDic(self.priestsDic)

	local recLvUpPriest, recLv = CurAvatar:getRecLvUpPriest()

	for pos, priestHeroGrid in ipairs(self.priestHeroGridDic) do
		if self.priestsDic[pos] then
			priestHeroGrid:setHero(self.priestsDic[pos], pos)

			if recLvUpPriest and recLv and recLvUpPriest.gid == self.priestsDic[pos].gid then
				priestHeroGrid:setRecLv(recLv)
			end
		else
			priestHeroGrid:clear()
		end
	end

	for pos, recHeroGrid in ipairs(self.recHeroGridDic) do
		if self.recommendDic[pos] then
			recHeroGrid:setHero(self.recommendDic[pos], pos)
		else
			recHeroGrid:clear()
		end
	end
end

function HeroGrowRecommendDlg:onBtnCloseClick()
	self:setVisible(false)
end

return HeroGrowRecommendDlg

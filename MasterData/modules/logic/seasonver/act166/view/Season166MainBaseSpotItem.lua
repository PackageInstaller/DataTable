-- chunkname: @modules/logic/seasonver/act166/view/Season166MainBaseSpotItem.lua

module("modules.logic.seasonver.act166.view.Season166MainBaseSpotItem", package.seeall)

local Season166MainBaseSpotItem = class("Season166MainBaseSpotItem", LuaCompBase)

function Season166MainBaseSpotItem:ctor(param)
	self.param = param
end

function Season166MainBaseSpotItem:init(go)
	self:__onInit()

	self.go = go
	self.actId = self.param.actId
	self.baseId = self.param.baseId
	self.config = self.param.config
	self.txtName = gohelper.findChildText(self.go, "txt_name")
	self.txtTitle = gohelper.findChildText(self.go, "txt_title")
	self.goStars = gohelper.findChild(self.go, "go_stars")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")

	local scoreConfigList = Season166Config.instance:getSeasonScoreCos(self.actId)

	self.finalLevelScore = scoreConfigList[#scoreConfigList].needScore
	self.starTab = self:getUserDataTb_()

	for i = 1, 3 do
		local starItem = {}

		starItem.star = gohelper.findChild(self.goStars, "go_star" .. i)
		starItem.dark = gohelper.findChild(starItem.star, "dark")
		starItem.light = gohelper.findChild(starItem.star, "light")
		starItem.imageLight = gohelper.findChildImage(starItem.star, "light")
		starItem.imageLight1 = gohelper.findChildImage(starItem.star, "light/light1")

		table.insert(self.starTab, starItem)
	end
end

function Season166MainBaseSpotItem:addEventListeners()
	self.btnClick:AddClickListener(self.onClickBaseSpotItem, self)
end

function Season166MainBaseSpotItem:onClickBaseSpotItem()
	local param = {}

	param.actId = self.actId
	param.baseId = self.baseId
	param.config = self.config
	param.viewType = Season166Enum.WordBaseSpotType

	Season166Controller.instance:openSeasonBaseSpotView(param)
end

function Season166MainBaseSpotItem:refreshUI()
	self.txtName.text = self.config.name
	self.txtTitle.text = string.format("St.%d", self.baseId)

	local lightStarCount = Season166BaseSpotModel.instance:getStarCount(self.actId, self.baseId)
	local curMaxScore = Season166BaseSpotModel.instance:getBaseSpotMaxScore(self.actId, self.baseId)

	for i = 1, #self.starTab do
		gohelper.setActive(self.starTab[i].light, i <= lightStarCount)
		gohelper.setActive(self.starTab[i].dark, lightStarCount < i)

		local lightStarUrl = curMaxScore >= self.finalLevelScore and "season166_result_inclinedbulb3" or "season166_result_inclinedbulb2"

		UISpriteSetMgr.instance:setSeason166Sprite(self.starTab[i].imageLight, lightStarUrl)
		UISpriteSetMgr.instance:setSeason166Sprite(self.starTab[i].imageLight1, lightStarUrl)
	end
end

function Season166MainBaseSpotItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function Season166MainBaseSpotItem:destroy()
	self:__onDispose()
end

return Season166MainBaseSpotItem

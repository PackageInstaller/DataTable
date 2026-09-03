-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/shuangdan/ActivitySupportWinHolidayMediator.lua

ActivitySupportWinHolidayMediator = class("ActivitySupportWinHolidayMediator", DmPopupViewMediator, _M)

ActivitySupportWinHolidayMediator:has("_rankSystem", {
	is = "rw"
}):injectWith("RankSystem")
ActivitySupportWinHolidayMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.showRankBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickShowRankBtn"
	}
}
local supportUIConfig = {
	{
		anim = "redwin_baimengpailian",
		yinfu = "shuandan_img_hjcx_wxp.png",
		bg = "asset/ui/activity/shuandan_img_hjcx_di.png",
		role = {
			img = "asset/ui/activity/shuandan_img_hjcx_ren.png",
			offset = {
				-48,
				-60
			}
		},
		name = {
			img = "shuandan_txt_hjcx_zi.png",
			offset = {
				10,
				-13
			}
		},
		winTextOutLine = cc.c4b(255, 85, 238, 255),
		scoreOutLine = cc.c4b(255, 33, 190, 255),
		rankButton = {
			arrowImg = "shuandan_btn_ckscjth.png",
			textColor = cc.c3b(150, 46, 110)
		}
	},
	{
		anim = "whitewin_baimengpailian",
		yinfu = "shuandan_img_bmcx_wxp.png",
		bg = "asset/ui/activity/shuandan_img_bmcx_di.png",
		role = {
			img = "asset/ui/activity/shuandan_img_bmcx_ren.png",
			offset = {
				-22,
				-20
			}
		},
		name = {
			img = "shuandan_txt_bmcx_zi.png",
			offset = {
				17,
				-18
			}
		},
		winTextOutLine = cc.c4b(29, 167, 255, 255),
		scoreOutLine = cc.c4b(42, 172, 255, 255),
		rankButton = {
			arrowImg = "shuandan_btn_ckscjtl.png",
			textColor = cc.c3b(68, 49, 141)
		}
	}
}

function ActivitySupportWinHolidayMediator:initialize()
	super.initialize(self)
end

function ActivitySupportWinHolidayMediator:dispose()
	super.dispose(self)
end

function ActivitySupportWinHolidayMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
end

function ActivitySupportWinHolidayMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._periodsInfo = self._activity:getPeriodsInfo()
	self._periodId = self._periodsInfo.periodId

	self:setupView()
end

function ActivitySupportWinHolidayMediator:getIndexByHeroId()
	self._curPeriod = self._activity:getSupportCurPeriodData()

	local heros = self._curPeriod.config.SupportHero
	local winId = self._activity:getWinHeroId()

	for index, id in pairs(heros) do
		if id == winId then
			return index
		end
	end

	return 1
end

function ActivitySupportWinHolidayMediator:setupView()
	local index = self:getIndexByHeroId()
	local uiConfig = supportUIConfig[index]
	local animNode = self._main:getChildByName("animNode")
	local anim = cc.MovieClip:create(uiConfig.anim)

	anim:addTo(animNode):posite(80, 175)

	local bgImgNode = anim:getChildByName("bgimg")
	local bgImg = ccui.ImageView:create(uiConfig.bg)

	bgImg:addTo(bgImgNode):center(bgImgNode:getContentSize())

	for i = 1, 2 do
		local animNode = anim:getChildByName("bganim" .. i)

		for index = 1, 2 do
			local bgNode = animNode:getChildByName("bg" .. index)
			local bgImg = ccui.ImageView:create(uiConfig.bg)

			bgImg:addTo(bgNode):center(bgNode:getContentSize())
		end
	end

	for i = 1, 2 do
		local roleNode = anim:getChildByName("role" .. i)
		local bgImg = ccui.ImageView:create(uiConfig.role.img)

		bgImg:addTo(roleNode):center(roleNode:getContentSize()):posite(uiConfig.role.offset[1], uiConfig.role.offset[2])
	end

	local yinfuAnimNode = anim:getChildByName("yinfu")

	for i = 1, 2 do
		local yinfuNode = yinfuAnimNode:getChildByName("yinfu" .. i)
		local yinfuImg = ccui.ImageView:create(uiConfig.yinfu, 1)

		yinfuImg:addTo(yinfuNode):center(yinfuNode:getContentSize()):offset(-5, -15)
	end

	local nameNode = anim:getChildByName("name")
	local nameImg = ccui.ImageView:create(uiConfig.name.img, 1)

	nameImg:addTo(nameNode):center(nameNode:getContentSize()):offset(uiConfig.name.offset[1], uiConfig.name.offset[2])
	anim:addEndCallback(function()
		anim:stop()
	end)

	local darkDi = self._main:getChildByName("heidi")

	darkDi:setOpacity(234)
	darkDi:runAction(cc.FadeTo:create(0.4, 224))

	local winText = self._main:getChildByName("Text_win")

	winText:enableOutline(uiConfig.winTextOutLine, 1)

	local scoreNode = self._main:getChildByName("scorePanel")

	scoreNode:getChildByName("value2"):enableOutline(uiConfig.scoreOutLine, 2)
	scoreNode:getChildByName("value1"):enableOutline(uiConfig.scoreOutLine, 2)
	scoreNode:getChildByName("value1"):setString(self._activity:getWinPopularity())

	local rankBtn = self._main:getChildByName("showRankBtn")

	rankBtn:getChildByName("Text_name"):setColor(uiConfig.rankButton.textColor)
	rankBtn:getChildByName("Image_arrow"):loadTexture(uiConfig.rankButton.arrowImg, 1)
end

function ActivitySupportWinHolidayMediator:onClickShowRankBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._activitySystem:enterSagaSupportRankRewardView(self._activityId, self._periodId)
end

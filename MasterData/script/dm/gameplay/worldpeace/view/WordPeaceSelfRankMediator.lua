-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceSelfRankMediator.lua

WordPeaceSelfRankMediator = class("WordPeaceSelfRankMediator", DmPopupViewMediator, _M)

WordPeaceSelfRankMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WordPeaceSelfRankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function WordPeaceSelfRankMediator:initialize()
	super.initialize(self)
end

function WordPeaceSelfRankMediator:dispose()
	super.dispose(self)
end

function WordPeaceSelfRankMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
end

function WordPeaceSelfRankMediator:setupView(data)
	self._worldPeace = self._worldPeaceSystem:getWorldPeace()
	self._memberRankList = self._worldPeace:getMemberRankList()
	self._clubChatReward = self._worldPeace:getClubChatReward()
	self._chatPlayerRewards = self._worldPeace:getChatPlayerRewards()
	self._clubRankList = self._worldPeace:getClubRankList()

	self._worldPeaceSystem:setCampIndex(self._clubRankList)
	table.sort(self._clubRankList, function(a, b)
		return a.rank < b.rank
	end)

	local cellclone = self:getView():getChildByName("cell")
	local listview = self:getView():getChildByName("ListView")

	cellclone:setVisible(false)

	local rankRes = {
		"swear_img_paiming01.png",
		"swear_img_paiming02.png",
		"swear_img_paiming03.png"
	}
	local campColor = {
		"#fd62ff",
		"#ffe26e",
		"#81cdff"
	}

	for i = 1, 3 do
		local v = self._clubRankList[i]
		local cell = cellclone:clone()

		cell:setVisible(true)

		local rank = cell:getChildByName("rank")
		local clubicon = cell:getChildByName("clubicon")
		local reward = cell:getChildByName("reward")
		local clubname = cell:getChildByName("clubname")
		local cnt = cell:getChildByName("cnt")
		local point = cell:getChildByName("point")

		point:changeParent(reward)
		rank:loadTexture("asset/commonRaw/" .. rankRes[i])
		clubname:setString((v or nil) and (v.groupName or ""))
		rank:ignoreContentAdaptWithSize(true)
		clubname:setColor(GameStyle:stringToColor(campColor[(v or nil) and (v.camp or 1)]))

		if v and self._clubChatReward and self._clubChatReward[v.gId] then
			cnt:setString(self._clubChatReward[v.gId].point)
		else
			cnt:setString("")
		end

		if v then
			local icon = IconFactory:createClubIcon({
				id = v.groupHeadImg
			}, {
				isNoBG = true
			})

			icon:addTo(clubicon)
			icon:center(clubicon:getContentSize())
			icon:setScale(1.2)
		end

		listview:pushBackCustomItem(cell)

		if v and self._clubChatReward and self._clubChatReward[v.gId] then
			for k_, v_ in pairs(self._clubChatReward[v.gId].totalRewards) do
				local icon = IconFactory:createRewardIcon(v_, {
					showAmount = true,
					isWidget = true
				})

				icon:addTo(reward):center(reward:getContentSize())
				icon:setScaleNotCascade(0.4)
				icon:offset((k_ - 1) * 65)
			end

			local Club_Bride_RankFactor = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Bride_RankFactor", "content")

			point:setString("x" .. Club_Bride_RankFactor[tostring(i)] * 100 .. "%")
			point:setVisible(#self._clubChatReward[v.gId].totalRewards > 0)
			point:offset(-100, 0)
		else
			point:setVisible(false)
		end
	end

	listview:setScrollBarEnabled(false)

	if self._chatPlayerRewards and #self._chatPlayerRewards > 0 then
		self:getView():getChildByName("viewbtn"):setVisible(#self._chatPlayerRewards > 0)
	else
		self:getView():getChildByName("viewbtn"):setVisible(false)
	end

	self:getView():getChildByName("viewbtn"):addClickEventListener(function()
		local view = self:getInjector():getInstance("WordPeaceChatRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, self._chatPlayerRewards))
	end)
end

function WordPeaceSelfRankMediator:initContent()
	return
end

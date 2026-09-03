-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/DreamChallengeDetailMediator.lua

DreamChallengeDetailMediator = class("DreamChallengeDetailMediator", DmAreaViewMediator, _M)

DreamChallengeDetailMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")
DreamChallengeDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.openPanel.open"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickOpenBtn"
	},
	["main.openPanel.detailBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDetailBtn"
	}
}
local kPartyIcon = {
	BSNCT = "asset/heroRect/heroForm/sl_businiao.png",
	MNJH = "asset/heroRect/heroForm/sl_smzs.png",
	DWH = "asset/heroRect/heroForm/sl_dongwenhui.png",
	XD = "asset/heroRect/heroForm/sl_seed.png",
	UNKNOWN = "asset/heroRect/heroForm/sl_unknown.png",
	WNSXJ = "asset/heroRect/heroForm/sl_weinasi.png",
	SSZS = "asset/heroRect/heroForm/sl_shimengzhishe.png"
}
local kJobIcon = {
	Aoe = "asset/heroRect/heroOccupation/zy_fashi.png",
	Attack = "asset/heroRect/heroOccupation/zy_gongxi.png",
	Support = "asset/heroRect/heroOccupation/zy_fuzhu.png",
	Curse = "asset/heroRect/heroOccupation/zy_zhoushu.png",
	Defense = "asset/heroRect/heroOccupation/zy_shouhu.png",
	Summon = "asset/heroRect/heroOccupation/zy_zhaohuan.png",
	Cure = "asset/heroRect/heroOccupation/zy_zhiyu.png"
}
local kOtherHeroIcon = "asset/heroRect/heroOccupation/zy_zhoushu.png"

function DreamChallengeDetailMediator:initialize()
	super.initialize(self)
end

function DreamChallengeDetailMediator:dispose()
	super.dispose(self)
end

function DreamChallengeDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function DreamChallengeDetailMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._detailView = self._main:getChildByName("openPanel")
	self._openBtn = self._detailView:getChildByName("open")
	self._lockView = self._main:getChildByName("lockPanel")
	self._pointDescRt = nil

	self:initAnim()
end

function DreamChallengeDetailMediator:initAnim()
	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:addCallbackAtFrame(30, function()
		mc:stop()
	end)
	mc:stop()
	mc:addTo(self._openBtn):center(self._openBtn:getContentSize())
	mc:setScale(0.8)
	mc:setLocalZOrder(100)
end

function DreamChallengeDetailMediator:initData(mediator, data)
	self._mediator = mediator
	self._mapId = data.mapId
	self._pointId = data.pointId
	self._isUnLock = self._dreamSystem:checkPointLock(self._mapId, self._pointId)
	self._addData = {}

	local recomandHeros = self._dreamSystem:getRecomandHero(self._mapId, self._pointId)

	for i = 1, #recomandHeros do
		local tmp = {}

		tmp.type = "Hero"
		tmp.id = recomandHeros[i]
		self._addData[#self._addData + 1] = tmp
	end

	local recomandPartys = self._dreamSystem:getRecomandParty(self._mapId, self._pointId)

	for i = 1, #recomandPartys do
		local tmp = {}

		tmp.type = "Party"
		tmp.id = recomandPartys[i]
		self._addData[#self._addData + 1] = tmp
	end

	local recomandJobs = self._dreamSystem:getRecomandJob(self._mapId, self._pointId)

	for i = 1, #recomandJobs do
		local tmp = {}

		tmp.type = "Job"
		tmp.id = recomandJobs[i]
		self._addData[#self._addData + 1] = tmp
	end

	self._teamData = self._dreamSystem:getPointScreen(self._mapId, self._pointId)
end

function DreamChallengeDetailMediator:setupView(mediator, data)
	self:initData(mediator, data)
	self:initWidget()
	self:refreshView()
end

function DreamChallengeDetailMediator:refreshView()
	self._lockView:setVisible(not self._isUnLock)
	self._detailView:setVisible(self._isUnLock)

	if self._isUnLock then
		local buffInfoBtnPosX = 0
		local timeNode = self._detailView:getChildByName("timeNode")
		local timeText = self._detailView:getChildByFullName("timeNode.desc")
		local timeTitle = self._detailView:getChildByFullName("timeNode.title")
		local timeBg = self._detailView:getChildByFullName("timeNode.timeBg")
		local leftWorlds = self._detailView:getChildByFullName("bg")

		leftWorlds:setPosition(cc.p(701, 383))

		local textPic = DataReader:getDataByNameIdAndKey("DreamChallengePoint", self._pointId, "TextPic")

		if textPic and textPic ~= "" then
			timeBg:setVisible(false)
			leftWorlds:setVisible(true)
			leftWorlds:loadTexture("asset/ui/dreamChallenge/" .. textPic .. ".png", ccui.TextureResType.localType)
		else
			leftWorlds:setVisible(false)
			timeBg:setVisible(true)
		end

		local challengeType = DataReader:getDataByNameIdAndKey("DreamChallengePoint", self._pointId, "MissionPicType")

		if kDreamChallengeType.kTwo == challengeType or kDreamChallengeType.kThree == challengeType then
			timeBg:loadTexture("mjt_z_xntz_sjd.png", ccui.TextureResType.plistType)
			timeTitle:setTextColor(cc.c3b(201, 0, 62))
		else
			timeBg:loadTexture("mjt_z_mjjc_sjd.png", ccui.TextureResType.plistType)
			timeTitle:setTextColor(cc.c3b(93, 82, 205))
		end

		timeNode:setVisible(false)

		local timeStrKey = self._dreamSystem:getMapTimeDesc(self._mapId)

		if timeStrKey and timeStrKey ~= "" then
			timeNode:setVisible(true)

			local startStamp, endStamp = self._dreamSystem:getMapStartAndEndTime(self._mapId)
			local startTime = TimeUtil:localDate("%Y.%m.%d %H:%M", startStamp)
			local endTime = TimeUtil:localDate("%Y.%m.%d %H:%M", endStamp)
			local str = Strings:get(timeStrKey, {
				StartTime = startTime,
				EndTime = endTime,
				fontName = CUSTOM_TTF_FONT_1
			})
			local richText = ccui.RichText:createWithXML("", {})

			richText:setAnchorPoint(timeText:getAnchorPoint())
			richText:setPosition(cc.p(timeText:getPosition()))
			richText:addTo(timeText:getParent())
			richText:setString(str)
		end

		local desc = self._detailView:getChildByFullName("pointDesc")

		desc:setVisible(false)

		if self._pointDescRt then
			self._pointDescRt:removeFromParent()

			self._pointDescRt = nil
		end

		local pointDesc = self._dreamSystem:getPointTimeDesc(self._pointId)

		if pointDesc and pointDesc ~= "" and self._pointDescRt == nil then
			desc:setVisible(true)

			local richText = ccui.RichText:createWithXML(Strings:get(pointDesc, {
				fontSize = 20,
				fontName = CUSTOM_TTF_FONT_1
			}), {})

			richText:setAnchorPoint(desc:getAnchorPoint())
			richText:setPosition(cc.p(desc:getPosition()))
			richText:addTo(desc:getParent())
			richText:renderContent(desc:getContentSize().width, 0, true)

			self._pointDescRt = richText
		end

		local rewardPanel = self._detailView:getChildByFullName("rewardPanel")
		local rewardId = self._dreamSystem:getPointShowReward(self._mapId, self._pointId)
		local reward = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

		for i = 1, #reward do
			local icon = IconFactory:createRewardIcon(reward[i], {
				showAmount = true,
				isWidget = true,
				notShowQulity = false
			})

			icon:addTo(rewardPanel):setScale(0.5)
			icon:setPosition(cc.p(40 + (i - 1) * 70, 35))

			if RewardSystem:checkIsComposeItem(reward[i]) then
				IconFactory:bindClickHander(icon, IconTouchHandler:new(self), reward[i], {
					touchDisappear = true,
					swallowTouches = true
				})
			else
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward[i], {
					needDelay = true
				})
			end
		end

		local title3 = self._detailView:getChildByFullName("title3")
		local text = self._detailView:getChildByFullName("title3.title3")

		title3:setVisible(false)

		local teamData = self._dreamSystem:getPointScreen(self._mapId, self._pointId)
		local teamCond, teamTitleStr
		local restrictStr = ""

		if teamData.Up then
			teamTitleStr = Strings:get("DreamChallenge_Point_Reward_Title_1")
			restrictStr = Strings:get("DreamChallenge_Point_Rrestrict02")

			text:setString(teamTitleStr)

			teamCond = teamData.Up
		else
			teamTitleStr = Strings:get("DreamChallenge_Point_Reward_Title_2")
			restrictStr = Strings:get("DreamChallenge_Point_Rrestrict01")

			text:setString(teamTitleStr)

			teamCond = teamData.Down
		end

		for i = 1, 5 do
			local node = self._detailView:getChildByFullName("node_" .. i)

			node:setVisible(false)
		end

		for i = 1, #teamCond do
			local node = self._detailView:getChildByFullName("node_" .. i)
			local data = teamCond[i]

			if not node then
				return
			end

			node:setVisible(true)

			if not title3:isVisible() then
				title3:setVisible(true)
				title3:setPositionX(node:getPositionX())
			end

			local attackText = node:getChildByFullName("text")
			local icon = node:getChildByFullName("icon")
			local iconTexture = kOtherHeroIcon
			local infoDesc = ""
			local infoTitle = ""

			if data.type == "job" then
				infoTitle = Strings:get("TypeName_" .. data.value)

				attackText:setString(infoTitle)
				icon:loadTexture(kJobIcon[data.value], ccui.TextureResType.localType)

				iconTexture = kJobIcon[data.value]
				infoDesc = Strings:get("DreamChallenge_Point_Team_Desc_" .. data.value, {
					fontSize = 18,
					fontName = TTF_FONT_FZYH_M,
					restrict = restrictStr
				})
			elseif data.type == "Party" then
				infoTitle = Strings:get("HeroPartyName_" .. data.value)

				attackText:setString(infoTitle)
				icon:loadTexture(kPartyIcon[data.value], ccui.TextureResType.localType)

				infoDesc = Strings:get("DreamChallenge_Point_Team_Desc_" .. data.value, {
					fontSize = 18,
					fontName = TTF_FONT_FZYH_M,
					restrict = restrictStr
				})
				iconTexture = kPartyIcon[data.value]
			elseif data.type == "Tag" then
				infoTitle = Strings:get("DC_Map_OtherHero_IconName")

				attackText:setString(infoTitle)
				icon:loadTexture(kOtherHeroIcon, ccui.TextureResType.localType)

				infoDesc = Strings:get("DreamChallenge_Point_Team_Desc_Tag", {
					fontSize = 18,
					fontName = TTF_FONT_FZYH_M,
					restrict = restrictStr
				})
			end

			buffInfoBtnPosX = node:getPositionX() + 100

			local touchInfo = {}

			touchInfo.icon = iconTexture
			touchInfo.type = RewardType.kShow
			touchInfo.title = infoTitle
			touchInfo.desc = infoDesc

			icon:setSwallowTouches(false)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), touchInfo, {
				needDelay = true
			})
		end

		local buffBtn = self._detailView:getChildByFullName("detailBtn")

		buffBtn:setPositionX(buffInfoBtnPosX)
	else
		local timeNode = self._lockView:getChildByName("timeNode")
		local timeText = self._lockView:getChildByFullName("timeNode.desc")
		local timeBg = self._lockView:getChildByFullName("timeNode.timeBg")
		local timeTitle = self._lockView:getChildByFullName("timeNode.title")
		local leftWorlds = self._lockView:getChildByFullName("bg")

		leftWorlds:setPosition(cc.p(701, 383))

		local textPic = DataReader:getDataByNameIdAndKey("DreamChallengePoint", self._pointId, "TextPic")

		if textPic and textPic ~= "" then
			timeBg:setVisible(false)
			leftWorlds:setVisible(true)
			leftWorlds:loadTexture("asset/ui/dreamChallenge/" .. textPic .. ".png", ccui.TextureResType.localType)
		else
			leftWorlds:setVisible(false)
			timeBg:setVisible(true)
		end

		timeNode:setVisible(false)

		local timeStrKey = self._dreamSystem:getMapTimeDesc(self._mapId)

		timeNode:setVisible(false)

		if timeStrKey and timeStrKey ~= "" then
			timeNode:setVisible(true)

			local startStamp, endStamp = self._dreamSystem:getMapStartAndEndTime(self._mapId)
			local startTime = TimeUtil:localDate("%Y.%m.%d %H:%M", startStamp)
			local endTime = TimeUtil:localDate("%Y.%m.%d %H:%M", endStamp)
			local str = Strings:get(timeStrKey, {
				StartTime = startTime,
				EndTime = endTime,
				fontName = CUSTOM_TTF_FONT_1
			})
			local richText = ccui.RichText:createWithXML(str, {})

			richText:setAnchorPoint(timeText:getAnchorPoint())
			richText:setPosition(cc.p(timeText:getPosition()))
			richText:addTo(timeText:getParent())
		end

		local rewardPanel = self._lockView:getChildByFullName("rewardPanel")
		local rewardId = self._dreamSystem:getPointShowReward(self._mapId, self._pointId)
		local reward = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

		for i = 1, #reward do
			local icon = IconFactory:createRewardIcon(reward[i], {
				showAmount = true,
				isWidget = true,
				notShowQulity = false
			})

			icon:addTo(rewardPanel):setScale(0.5)
			icon:setPosition(cc.p(40 + (i - 1) * 70, 35))

			if RewardSystem:checkIsComposeItem(reward[i]) then
				IconFactory:bindClickHander(icon, IconTouchHandler:new(self), reward[i], {
					touchDisappear = true,
					swallowTouches = true
				})
			else
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward[i], {
					needDelay = true
				})
			end
		end

		local talkText = self._lockView:getChildByFullName("role.Text_43")

		talkText:setString(Strings:get(self._dreamSystem:getShortDesc(self._mapId, self._pointId)))

		local pointLockCond = self._dreamSystem:getPointLockCond(self._mapId, self._pointId)
		local condIndex = 1
		local condNodes = {}

		for i = 1, 3 do
			local node = self._lockView:getChildByFullName("lockInfo.node" .. i)

			node:setVisible(false)

			condNodes[i] = node
		end

		if pointLockCond.Pass then
			local node = condNodes[condIndex]

			node:setVisible(true)

			local condText = node:getChildByName("cond")
			local nameText = node:getChildByName("name")

			condText:setString(Strings:get("DreamChallenge_Point_Cond_Pass"))

			local condSize = condText:getContentSize()

			nameText:setPositionX(condSize.width + condText:getPositionX() + 10)

			local mapName = self._dreamSystem:getMapName(self._mapId)
			local pointName = ""
			local battleName = self._dreamSystem:getBattleName(pointLockCond.Pass)
			local isPass = true

			if pointLockCond and pointLockCond.Pass then
				local pointIds = self._dreamSystem:getPointIds(self._mapId)

				for i = 1, #pointIds do
					local battleIds = self._dreamSystem:getBattleIds(self._mapId, pointIds[i])

					for j = 1, #battleIds do
						if pointLockCond.Pass == battleIds[j] then
							pointName = self._dreamSystem:getPointName(pointIds[i])

							if not self._dreamSystem:isBattleHasPass(self._mapId, pointIds[i], pointLockCond.Pass) then
								isPass = false
							end
						end
					end
				end
			end

			nameText:setString("[" .. pointName .. "-" .. battleName .. "]")
			nameText:setTextColor(isPass and cc.c3b(6, 237, 0) or cc.c3b(255, 120, 0))

			condIndex = condIndex + 1
		end

		if pointLockCond.LEVEL then
			local node = condNodes[condIndex]

			node:setVisible(true)

			local condText = node:getChildByName("cond")
			local nameText = node:getChildByName("name")
			local playerInfo = self._developSystem:getPlayer()
			local isPass = playerInfo:getLevel() >= pointLockCond.LEVEL

			condText:setString(Strings:get("DreamChallenge_Point_Cond_Level"))
			nameText:setString(tostring(pointLockCond.LEVEL))

			local condSize = condText:getContentSize()

			nameText:setPositionX(condSize.width + condText:getPositionX() + 10)
			nameText:setTextColor(isPass and cc.c3b(6, 237, 0) or cc.c3b(255, 120, 0))

			condIndex = condIndex + 1
		end

		if pointLockCond.Hero then
			local node = condNodes[condIndex]

			node:setVisible(true)

			local condText = node:getChildByName("cond")
			local nameText = node:getChildByName("name")

			condText:setString(Strings:get("DreamChallenge_Point_Cond_Hero"))

			local condSize = condText:getContentSize()

			nameText:setPositionX(condSize.width + condText:getPositionX() + 10)

			local nameStr = ""
			local isPass = true

			for i = 1, #pointLockCond.Hero do
				local info = self._dreamSystem:getHeroInfo(pointLockCond.Hero[i])

				nameStr = nameStr .. info.name .. " "

				if not self._dreamSystem:checkHeroExist(pointLockCond.Hero[i]) then
					isPass = false
				end
			end

			nameText:setString(nameStr)
			nameText:setTextColor(isPass and cc.c3b(6, 237, 0) or cc.c3b(255, 120, 0))

			condIndex = condIndex + 1
		end
	end
end

function DreamChallengeDetailMediator:onClickOpenBtn()
	self._mediator:onPointClick(self._mapId, self._pointId)
end

function DreamChallengeDetailMediator:onClickDetailBtn()
	local view = self:getInjector():getInstance("DreamChallengeBuffDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		mapId = self._mapId,
		pointId = self._pointId
	}))
end

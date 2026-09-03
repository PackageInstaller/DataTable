-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceClubRankMediator.lua

WorldPeaceClubRankMediator = class("WorldPeaceClubRankMediator", DmPopupViewMediator, _M)

WorldPeaceClubRankMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceClubRankMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
WorldPeaceClubRankMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local CampImage = {
	"CB_img_qizhired.png",
	"CB_img_qizhiyellow.png",
	"CB_img_qizhiblue.png"
}
local RankImgPath = {
	"CB_img_No1.png",
	"CB_img_No2.png",
	"CB_img_No3.png"
}

function WorldPeaceClubRankMediator:initialize()
	super.initialize(self)
end

function WorldPeaceClubRankMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function WorldPeaceClubRankMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._tipsText = self._main:getChildByName("Text_tips")
	self._timeText = self._main:getChildByName("Text_time")
end

function WorldPeaceClubRankMediator:setupView(data)
	self._worldPeace = self._worldPeaceSystem:getWorldPeace()
	self._clubInfo = self._clubSystem:getClubInfoOj()

	self:refreshData()

	if not self._init then
		self._init = true

		self:setRankView()
		self:startTimer()
	end
end

function WorldPeaceClubRankMediator:refreshData()
	local curTime = self._gameServerAgent:remoteTimestamp()
	local timeList = self._worldPeaceSystem:getTimeList()
	local status = self._worldPeaceSystem:getStatus()

	self._clubRankList = {}
	self._showStatus = ""

	local data = self._worldPeace:getClubChatReward() or {}

	if status == WPStatus.kPrepare then
		for k, v in pairs(data) do
			v.point = v.point or 0
			self._clubRankList[#self._clubRankList + 1] = v
		end

		self._showStatus = "swearChat"

		table.sort(self._clubRankList, function(a, b)
			return a.point > b.point
		end)

		for i, v in pairs(self._clubRankList) do
			v.rank = i
		end
	else
		local pointData = self._worldPeace:getClubPoint()
		local clubRank = self._worldPeace:getClubRankMap()

		for k, v in pairs(data) do
			v.clubPoint = pointData[v.gId] or 0
			v.rank = clubRank[v.gId] or -1
			self._clubRankList[#self._clubRankList + 1] = v
		end

		self._showStatus = "battle"

		table.sort(self._clubRankList, function(a, b)
			return a.clubPoint > b.clubPoint
		end)
	end

	self._worldPeaceSystem:setCampIndex(self._clubRankList)
	table.sort(self._clubRankList, function(a, b)
		return a.gId > b.gId
	end)
end

function WorldPeaceClubRankMediator:setRankView()
	self:refreshRankView()
end

local posY = {
	215,
	178,
	145
}
local qiganSize = {
	cc.size(139, 348),
	cc.size(116, 272),
	cc.size(116, 242)
}

function WorldPeaceClubRankMediator:refreshRankView()
	for i = 1, 3 do
		local cell = self._main:getChildByName("cell" .. i)
		local clubNode = cell:getChildByName("clubinfo")
		local iconNode = clubNode:getChildByName("clubicon")
		local nameText = clubNode:getChildByName("Text_name")
		local campImg = clubNode:getChildByName("Image_camp")
		local scoreText = clubNode:getChildByName("Text_score")
		local guangImg = clubNode:getChildByName("Image_guang")

		guangImg:setVisible(false)

		local rankNode = cell:getChildByName("rank")
		local rewardDi = rankNode:getChildByName("Image_1")
		local rewardNode = rankNode:getChildByName("reward")

		rewardNode:removeAllChildren()
		rewardNode:setScrollBarEnabled(false)

		local qiganImg = cell:getChildByName("Image_qigan")

		qiganImg:ignoreContentAdaptWithSize(true)

		local rankImg = rankNode:getChildByName("Image_rank")

		rankImg:ignoreContentAdaptWithSize(true)

		local tipsText = cell:getChildByName("Text_tips")

		tipsText:setVisible(false)

		local factorText = rankNode:getChildByName("Text_factor")
		local factorDi = rankNode:getChildByName("Image_16")
		local scoreDi = clubNode:getChildByName("Image_1")
		local data = self._clubRankList[i]

		iconNode:removeAllChildren()
		qiganImg:posite(138, 101)

		if not data then
			campImg:loadTexture(CampImage[i], 1)
			clubNode:setPositionY(posY[3])
			nameText:setString(Strings:get("RankRuleUI_4"))
			scoreText:setString("")
			qiganImg:setContentSize(cc.size(116, 260))
			rankNode:setVisible(false)
			tipsText:setVisible(false)
			scoreDi:setVisible(false)
		else
			campImg:loadTexture(CampImage[data.camp], 1)
			nameText:setString(data.groupName)

			if not data.groupHeadImg then
				if data.headImg then
					local var_10_0 = {}

					var_10_0.id = data.groupHeadImg or data.headImg

					local icon = IconFactory:createClubIcon(var_10_0, {
						isNoBG = true
					})

					icon:addTo(iconNode):center(iconNode:getContentSize())
					icon:setScale(2)
				end

				local score = 0

				if self._showStatus == "battle" then
					scoreText:setString(data.clubPoint or 0)

					score = data.clubPoint or 0
				else
					scoreText:setString(data.point or 0)

					score = data.point or 0
				end

				local rewards = data.totalRewards

				if rewards and #rewards > 0 then
					self:createReward(rewards, rewardNode)
					tipsText:setVisible(false)
					rewardDi:setVisible(true)
					rewardNode:setVisible(true)
				else
					rewardDi:setVisible(false)
					tipsText:setVisible(true)
					tipsText:setString(Strings:get("ClubMapBoss_WaitReward"))
					rankImg:setVisible(false)
					factorDi:setVisible(false)
					factorText:setVisible(false)
				end

				if score > 0 then
					scoreDi:setVisible(true)
					rankNode:setVisible(true)
					factorText:setVisible(self._showStatus == "battle")
					factorDi:setVisible(self._showStatus == "battle")

					if self._showStatus == "battle" then
						clubNode:setPositionY(posY[data.rank])
						qiganImg:setContentSize(qiganSize[data.rank])

						if data.rank == 1 then
							qiganImg:loadTexture("CB_img_qigan1.png", 1)
							qiganImg:posite(140, 101)
							guangImg:setVisible(true)
						else
							qiganImg:loadTexture("CB_img_qigan2.png", 1)
						end

						rankImg:loadTexture(RankImgPath[data.rank], 1)
						rankImg:setVisible(true)

						local rankFactor = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Bride_RankFactor", "content")

						factorText:setString("+" .. rankFactor[tostring(data.rank)] * 100 .. "%")
					else
						clubNode:setPositionY(posY[3])
						qiganImg:setContentSize(qiganSize[3])
						qiganImg:loadTexture("CB_img_qigan2.png", 1)
						rankImg:setVisible(false)
					end
				else
					scoreDi:setVisible(false)
					scoreText:setString("")
					clubNode:setPositionY(posY[3])
					qiganImg:loadTexture("CB_img_qigan2.png", 1)
					qiganImg:setContentSize(qiganSize[3])
					rankImg:setVisible(false)
					factorDi:setVisible(false)
					factorText:setVisible(false)
				end
			end
		end
	end
end

function WorldPeaceClubRankMediator:createReward(rewards, rewardList)
	local rewardCount = #rewards
	local count = math.ceil(rewardCount / 4)
	local scale = 0.4
	local width = 55
	local height = 50

	if rewardCount < 4 then
		scale = 0.5
		width = 70
		height = 70
	end

	for i = 1, count do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(218, height))
		rewardList:pushBackCustomItem(layout)

		for index = 1, 4 do
			local reward = rewards[index + (i - 1) * 4]

			if reward then
				local icon = IconFactory:createRewardIcon(reward, {
					isWidget = true
				})

				icon:addTo(layout):posite(width * 0.5 + (index - 1) * width, 25)
				icon:setScaleNotCascade(0.5)
				icon:setScale(scale)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})
			end
		end
	end

	if rewardCount <= 4 then
		rewardList:setContentSize((width + 5) * rewardCount, 100)
		rewardList:posite(0 + (4 - rewardCount) * width * 0.5, 0)
	else
		rewardList:setContentSize(cc.size(218, 100))
		rewardList:posite(29, 4)
	end
end

function WorldPeaceClubRankMediator:startTimer()
	local timeList = self._worldPeaceSystem:getTimeList()

	self._oldStatus = self._worldPeaceSystem:getStatus()

	local function update()
		local curTime = self._gameServerAgent:remoteTimestamp()
		local status = self._worldPeaceSystem:getStatus()

		if self._oldStatus ~= status then
			timeList = self._worldPeaceSystem:getTimeList()
			self._oldStatus = status
		end

		self._timeText:setVisible(false)

		if status == WPStatus.kPrepare then
			self._timeText:setVisible(true)

			local isChatTime = curTime < timeList.battleStartTime and curTime > timeList.chatTime1PRE
			local remainTime = 0
			local strId = ""

			if isChatTime then
				remainTime = timeList.battleStartTime - curTime
				strId = "ClubMapBoss_RemainingPreparation"
			else
				remainTime = timeList.chatTime1PRE - curTime
				strId = "ClubMapBoss_WaitBattle"
			end

			if remainTime >= 86400 then
				local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

				self._timeText:setString(Strings:get(strId, {
					time = timeStr
				}))
			else
				local format = Strings:get("Common_Time_07")
				local timeStr = TimeUtil:formatTime(format, remainTime)

				self._timeText:setString(Strings:get(strId, {
					time = timeStr
				}))
			end
		elseif status == WPStatus.kBattle then
			self._timeText:setVisible(true)

			local remainTime = timeList.closeTime - curTime
			local strId = "ClubMapBoss_RemainingBattle"

			if remainTime >= 86400 then
				local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

				self._timeText:setString(Strings:get(strId, {
					time = timeStr
				}))
			else
				local format = Strings:get("Common_Time_07")
				local timeStr = TimeUtil:formatTime(format, remainTime)

				self._timeText:setString(Strings:get(strId, {
					time = timeStr
				}))
			end
		end
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

	update()
end

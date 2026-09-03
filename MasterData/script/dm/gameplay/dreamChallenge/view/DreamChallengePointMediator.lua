-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/dreamChallenge/view/DreamChallengePointMediator.lua

DreamChallengePointMediator = class("DreamChallengePointMediator", DmAreaViewMediator, _M)

DreamChallengePointMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
DreamChallengePointMediator:has("_dreamSystem", {
	is = "r"
}):injectWith("DreamChallengeSystem")

local kBtnHandlers = {
	["main.detailBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickDetailBtn"
	},
	["main.resetBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickResetBtn"
	}
}
local kPointPos = {
	cc.p(12, 256),
	cc.p(456, 256),
	cc.p(12, 128),
	cc.p(456, 128),
	cc.p(12, 0),
	(cc.p(456, 0))
}
local kPointPosSmall = {
	cc.p(2, 283),
	cc.p(300, 283),
	cc.p(598, 283),
	cc.p(2, 190),
	cc.p(300, 190),
	cc.p(598, 190),
	cc.p(2, 96),
	cc.p(300, 96),
	cc.p(598, 96),
	cc.p(2, 2),
	cc.p(300, 2),
	(cc.p(598, 2))
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

function DreamChallengePointMediator:initialize()
	super.initialize(self)
end

function DreamChallengePointMediator:dispose()
	super.dispose(self)
end

function DreamChallengePointMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function DreamChallengePointMediator:setupView(pNode, data)
	self._mapId = data.mapId
	self._pointId = data.pointId

	self:initWidget()
	self:refreshPointView()
	self:refreshBuffInfo()
	self:checkGuide()
end

function DreamChallengePointMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._pointView = self._main:getChildByName("point")
	self._pointCellType = DataReader:getDataByNameIdAndKey("DreamChallengePoint", self._pointId, "MissionPicType")

	local pointCellNameStr = "pointCellClone"

	if kDreamChallengeType.kOne == self._pointCellType then
		pointCellNameStr = "pointCellClone"
	elseif kDreamChallengeType.kTwo == self._pointCellType then
		pointCellNameStr = "pointCell2Clone"
	elseif kDreamChallengeType.kThree == self._pointCellType then
		pointCellNameStr = "pointCell3Clone"
	elseif kDreamChallengeType.kForth == self._pointCellType then
		pointCellNameStr = "pointCell4Clone"
	elseif kDreamChallengeType.kFifth == self._pointCellType then
		pointCellNameStr = "pointCell5Clone"
	end

	self._pointCellClone = self:getView():getChildByName(pointCellNameStr)
	self._pointCellCloneSmall = self:getView():getChildByName(pointCellNameStr .. "Small")
	self._infoList = self._main:getChildByName("infoList")
	self._infoCellClone = self:getView():getChildByName("infoCellClone")
	self._infoBuffCellClone = self:getView():getChildByName("buffInfoCellClone")
	self._bg = self._main:getChildByName("bg")

	self._bg:setVisible(true)

	if kDreamChallengeType.kForth == self._pointCellType then
		self._bg:setVisible(false)
	end
end

function DreamChallengePointMediator:refreshPointView()
	self._pointView:removeAllChildren()
	self._pointView:setScrollBarEnabled(false)
	self._pointView:setTouchEnabled(true)
	self._pointView:setBounceEnabled(true)

	local battles = self._dreamSystem:getBattleIds(self._mapId, self._pointId)
	local battleNum = #battles
	local battlesTmp = {}

	table.deepcopy(battles, battlesTmp)

	if battleNum >= 12 then
		if not self._pointCellCloneSmall then
			local targetCell = self._pointCellClone
			local pointListWidth = 940
			local rowCellNum = battleNum >= 12 and 3 or 2
			local row = math.ceil(battleNum / rowCellNum)
			local offsetY = targetCell:getContentSize().height
			local offsetX = targetCell:getContentSize().width
			local innerSize = cc.size(pointListWidth, row * offsetY)
			local startPosX = (pointListWidth - rowCellNum * offsetX) / 2
			local startPosY = innerSize.height - targetCell:getContentSize().height

			self._pointView:setInnerContainerSize(cc.size(pointListWidth, row * offsetY))
			self._pointView:setContentSize(cc.size(pointListWidth, 366))

			local i = 0

			local function showHero(battlesTmp)
				if #battlesTmp == 0 then
					return
				end

				local battleId = table.remove(battlesTmp, 1)

				i = i + 1

				local layout = targetCell:clone()

				self:setPoint(layout, battleId, i, battleNum >= 12)

				local r = math.mod(i, rowCellNum)

				if r == 0 then
					r = rowCellNum
				end

				local l = math.floor((i - 1) / rowCellNum)

				layout:addTo(self._pointView):setPosition(cc.p(startPosX + (r - 1) * offsetX, startPosY - l * offsetY))

				local scale = cc.ScaleTo:create(0.6, 1)
				local fadeIn = cc.FadeIn:create(0.2)
				local spawn = cc.Spawn:create(scale, fadeIn)

				layout:runAction(spawn)
				performWithDelay(self:getView(), function()
					showHero(battlesTmp)
				end, i * 0.01)
			end

			showHero(battlesTmp)
		end
	end
end

function DreamChallengePointMediator:setPoint(layout, battleId, index, small)
	local name = layout:getChildByFullName("name")

	name:setString(self._dreamSystem:getBattleName(battleId))

	if self._pointCellType == kDreamChallengeType.kForth then
		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(244, 244, 255, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(155, 175, 251, 255)
			}
		}
		local lineGradiantDir = {
			x = 0,
			y = -1
		}

		name:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
		name:enableShadow(cc.c4b(17, 13, 40, 79.05), cc.size(2, 0), 2)
	end

	local num = layout:getChildByFullName("num")

	num:setString(tostring(index))

	if self._pointCellType == kDreamChallengeType.kForth then
		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(147, 102, 193, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(81, 50, 157, 255)
			}
		}
		local lineGradiantDir = {
			x = 0,
			y = -1
		}

		num:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	end

	local isUnLock = self._dreamSystem:checkBattleLock(self._mapId, self._pointId, battleId)
	local isPass = self._dreamSystem:checkBattlePass(self._mapId, self._pointId, battleId)
	local isReward = self._dreamSystem:checkBattleRewarded(self._mapId, self._pointId, battleId)
	local isRewardLock = self._dreamSystem:checkBattleRewardLock(self._mapId, self._pointId, battleId)
	local frontBg = layout:getChildByFullName("frontBg")
	local img = self._dreamSystem:getBattleBackground(self._mapId, self._pointId, battleId)

	frontBg:loadTexture("asset/ui/dreamChallenge/" .. img, ccui.TextureResType.localType)

	local mask = layout:getChildByFullName("mask")
	local mask2 = layout:getChildByFullName("mask2")

	mask:setVisible(false)
	mask2:setVisible(false)

	if isPass then
		if isReward then
			mask:setVisible(false)
			mask2:setVisible(true)
		else
			mask:setVisible(true)
			mask2:setVisible(false)
		end
	end

	local pass = layout:getChildByFullName("pass")

	pass:setVisible(isPass)

	local rewardPanel = layout:getChildByFullName("reward")
	local rewardId = self._dreamSystem:getBattleReward(self._mapId, self._pointId, battleId)
	local reward = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")[1]
	local icon = IconFactory:createRewardIcon(reward, {
		showAmount = true,
		isWidget = true,
		notShowQulity = false
	})

	if small then
		if reward and reward.type == RewardType.kBuff then
			icon:addTo(rewardPanel):center(rewardPanel:getContentSize()):setScale(0.65):offset(2, -1)
		else
			icon:addTo(rewardPanel):center(rewardPanel:getContentSize()):setScale(0.55):offset(1, 0)
		end
	elseif reward and reward.type == RewardType.kBuff then
		icon:addTo(rewardPanel):center(rewardPanel:getContentSize()):setScale(0.85):offset(3, -2)
	else
		icon:addTo(rewardPanel):center(rewardPanel:getContentSize()):setScale(0.7):offset(1, 0)
	end

	local guang = layout:getChildByFullName("guang")
	local klqImg = layout:getChildByFullName("klq")

	if reward and reward.type == RewardType.kBuff then
		guang:loadTexture("mjt_xuanzhongtai.png", ccui.TextureResType.plistType)
	end

	if small then
		guang:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.4, 1.12), cc.ScaleTo:create(0.3, 1.2))))
	else
		guang:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.4, 1.05), cc.ScaleTo:create(0.3, 1.1))))
	end

	guang:setVisible(isRewardLock and not isReward)
	klqImg:setVisible(isRewardLock and not isReward)

	local lock = layout:getChildByFullName("lock")

	lock:setVisible(not isUnLock)

	local gou = layout:getChildByFullName("gou")

	gou:setVisible(isReward)

	if not isRewardLock or isReward then
		icon:setSwallowTouches(false)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			needDelay = true
		})
	else
		rewardPanel:setSwallowTouches(true)
		rewardPanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._dreamSystem:requestReceiveBox(self._mapId, self._pointId, battleId, function(response)
					if response.resCode == 0 then
						self:refreshPointView()
						self:refreshBuffInfo()

						local view = self:getInjector():getInstance("getRewardView")
						local rewards = {}

						for i = 1, #response.data.buffs do
							local buff = response.data.buffs[i]
							local buffItem = {}

							buffItem.code = buff.value
							buffItem.type = RewardType.kBuff
							buffItem.amount = 1
							rewards[#rewards + 1] = buffItem
						end

						for i = 1, #response.data.rewards do
							rewards[#rewards + 1] = response.data.rewards[i]
						end

						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							maskOpacity = 0
						}, {
							rewards = rewards
						}))
					end
				end)
			end
		end)
	end

	layout:setSwallowTouches(false)
	layout:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			if isUnLock then
				if not isPass then
					self._dreamSystem:enterBattleTeam(self._mapId, self._pointId, battleId)
				end
			else
				self:dispatch(ShowTipEvent({
					tip = Strings:get("DreamChallenge_Point_Locked_TIPS")
				}))
			end
		end
	end)
end

function DreamChallengePointMediator:refreshBuffInfo()
	self._infoList:setScrollBarEnabled(false)
	self._infoList:removeAllChildren()

	local tiredNum = self._dreamSystem:getPointFatigue(self._mapId, self._pointId)
	local node1 = self._infoCellClone:clone()
	local tiredIcon = node1:getChildByFullName("icon")

	tiredIcon:loadTexture("icon_pilao1.png", ccui.TextureResType.plistType)
	tiredIcon:setContentSize(cc.size(53, 53))

	local tiredTitle = node1:getChildByFullName("title")
	local tiredText = node1:getChildByFullName("text")

	tiredTitle:setString(Strings:get("DreamChallenge_Point_Tired_Title"))
	tiredText:setString(Strings:get("DreamChallenge_Point_Tired_Text", {
		num = tiredNum
	}))

	local touchInfo = {}

	touchInfo.icon = "asset/common/common_hongxin.png"
	touchInfo.type = RewardType.kShow
	touchInfo.title = Strings:get("DreamChallenge_Point_Tired_Title")
	touchInfo.desc = Strings:get("DreamChallenge_Point_Tired_Desc", {
		fontSize = 18,
		fontName = TTF_FONT_FZYH_M,
		num = tiredNum
	})

	tiredIcon:setSwallowTouches(false)
	IconFactory:bindTouchHander(tiredIcon, IconTouchHandler:new(self), touchInfo, {
		needDelay = true
	})
	self._infoList:pushBackCustomItem(node1)

	local teamData = self._dreamSystem:getPointScreen(self._mapId, self._pointId)
	local teamCond
	local teamTitleStr = ""
	local restrictStr = ""

	if teamData.Up then
		teamTitleStr = Strings:get("DreamChallenge_Point_Reward_Title_1")
		restrictStr = Strings:get("DreamChallenge_Point_Rrestrict02")
		teamCond = teamData.Up
	else
		teamTitleStr = Strings:get("DreamChallenge_Point_Reward_Title_2")
		restrictStr = Strings:get("DreamChallenge_Point_Rrestrict01")
		teamCond = teamData.Down
	end

	for i = 1, #teamCond do
		local node2 = self._infoCellClone:clone()
		local data = teamCond[i]
		local title = node2:getChildByFullName("title")
		local text = node2:getChildByFullName("text")
		local icon = node2:getChildByFullName("icon")
		local line = node2:getChildByFullName("line2")
		local iconTexture = kOtherHeroIcon
		local infoDesc = ""
		local infoTitle = ""

		if data.type == "job" then
			iconTexture = kJobIcon[data.value]
			infoTitle = Strings:get("TypeName_" .. data.value)

			text:setString(infoTitle)
			icon:loadTexture(kJobIcon[data.value], ccui.TextureResType.localType)
			icon:setContentSize(cc.size(61, 61))

			infoDesc = Strings:get("DreamChallenge_Point_Team_Desc_" .. data.value, {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_M,
				restrict = restrictStr
			})
		elseif data.type == "Party" then
			iconTexture = kPartyIcon[data.value]
			infoTitle = Strings:get("HeroPartyName_" .. data.value)

			text:setString(infoTitle)
			icon:loadTexture(kPartyIcon[data.value], ccui.TextureResType.localType)
			icon:setContentSize(cc.size(63, 63))

			infoDesc = Strings:get("DreamChallenge_Point_Team_Desc_" .. data.value, {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_M,
				restrict = restrictStr
			})
		elseif data.type == "Tag" then
			infoTitle = Strings:get("DC_Map_OtherHero_IconName")

			text:setString(infoTitle)
			icon:loadTexture(kOtherHeroIcon, ccui.TextureResType.localType)
			icon:setContentSize(cc.size(63, 63))

			infoDesc = Strings:get("DreamChallenge_Point_Team_Desc_Tag", {
				fontSize = 18,
				fontName = TTF_FONT_FZYH_M,
				restrict = restrictStr
			})
		end

		title:setString(teamTitleStr)
		title:setVisible(i == 1)
		line:setVisible(i == 1)

		local touchInfo = {}

		touchInfo.icon = iconTexture
		touchInfo.type = RewardType.kShow
		touchInfo.title = infoTitle
		touchInfo.desc = infoDesc

		icon:setSwallowTouches(false)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), touchInfo, {
			needDelay = true
		})
		self._infoList:pushBackCustomItem(node2)
	end

	local heros, skill = self._dreamSystem:getRecomandHero(self._mapId, self._pointId)
	local addIndex = 0

	for i = 1, #heros do
		addIndex = addIndex + 1

		local config = ConfigReader:getRecordById("HeroBase", heros[i])
		local node3 = self._infoCellClone:clone()
		local attackText = node3:getChildByFullName("text")
		local icon = node3:getChildByFullName("icon")
		local title = node3:getChildByFullName("title")
		local line = node3:getChildByFullName("line2")

		attackText:setString("")

		local effectConfig = ConfigReader:getRecordById("Skill", skill)

		if effectConfig then
			attackText:setString(Strings:get(effectConfig.Desc_short))
			attackText:setColor(cc.c3b(255, 159, 48))
		end

		icon:removeAllChildren()
		icon:loadTexture((config.Rareity == 15 or nil) and "asset/commonRaw/common_bd_sp01.png", ccui.TextureResType.localType)
		icon:setContentSize(cc.size(93, 93))

		local touchInfo = {}

		touchInfo.code = skill
		touchInfo.type = RewardType.kBuff
		touchInfo.amount = 0
		touchInfo.buffType = "Buff"

		icon:setSwallowTouches(false)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), touchInfo, {
			needDelay = true
		})

		local config = ConfigReader:getRecordById("HeroBase", heros[i])
		local heroImg = IconFactory:createRoleIconSpriteNew({
			id = config.RoleModel
		})

		heroImg:addTo(icon):center(icon:getContentSize())
		heroImg:setName("iconHero")
		heroImg:setScale(0.25)
		title:setString(Strings:get("DreamChallenge_Point_Reward_Title_0"))
		title:setVisible(addIndex == 1)
		line:setVisible(addIndex == 1)
		self._infoList:pushBackCustomItem(node3)
	end

	local partys, skill = self._dreamSystem:getRecomandParty(self._mapId, self._pointId)

	for i = 1, #partys do
		addIndex = addIndex + 1

		local node4 = self._infoCellClone:clone()
		local attackText = node4:getChildByFullName("text")
		local icon = node4:getChildByFullName("icon")
		local title = node4:getChildByFullName("title")
		local line = node4:getChildByFullName("line2")

		attackText:setString("")

		local effectConfig = ConfigReader:getRecordById("Skill", skill)

		if effectConfig then
			attackText:setString(Strings:get(effectConfig.Desc_short))
			attackText:setColor(cc.c3b(255, 159, 48))
		end

		icon:removeAllChildren()

		local skillIcon = "asset/skillIcon/" .. effectConfig.Icon .. ".png"

		icon:loadTexture(skillIcon, ccui.TextureResType.localType)
		icon:setContentSize(cc.size(63, 63))

		local touchInfo = {}

		touchInfo.code = skill
		touchInfo.type = RewardType.kBuff
		touchInfo.amount = 0
		touchInfo.buffType = "Buff"

		icon:setSwallowTouches(false)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), touchInfo, {
			needDelay = true
		})
		title:setString(Strings:get("DreamChallenge_Point_Reward_Title_0"))
		title:setVisible(addIndex == 1)
		line:setVisible(addIndex == 1)
		self._infoList:pushBackCustomItem(node4)
	end

	local jobs, skill = self._dreamSystem:getRecomandJob(self._mapId, self._pointId)

	for i = 1, #jobs do
		addIndex = addIndex + 1

		local node5 = self._infoCellClone:clone()
		local attackText = node5:getChildByFullName("text")
		local icon = node5:getChildByFullName("icon")
		local title = node5:getChildByFullName("title")
		local line = node5:getChildByFullName("line2")

		attackText:setString("")

		local effectConfig = ConfigReader:getRecordById("Skill", skill)

		if effectConfig then
			attackText:setString(Strings:get(effectConfig.Desc_short))
			attackText:setColor(cc.c3b(255, 159, 48))
		end

		icon:removeAllChildren()

		local skillIcon = "asset/skillIcon/" .. effectConfig.Icon .. ".png"

		icon:loadTexture(skillIcon, ccui.TextureResType.localType)
		icon:setContentSize(cc.size(61, 61))

		local touchInfo = {}

		touchInfo.code = skill
		touchInfo.type = RewardType.kBuff
		touchInfo.amount = 0
		touchInfo.buffType = "Buff"

		icon:setSwallowTouches(false)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), touchInfo, {
			needDelay = true
		})
		title:setString(Strings:get("DreamChallenge_Point_Reward_Title_0"))
		title:setVisible(addIndex == 1)
		line:setVisible(addIndex == 1)
		self._infoList:pushBackCustomItem(node5)
	end

	local index = 1
	local battleIds = self._dreamSystem:getBattleIds(self._mapId, self._pointId)

	for i = 1, #battleIds do
		local buff = self._dreamSystem:getBattleRewardBuff(battleIds[i])

		if buff then
			local buffInfo = buff
			local node = self._infoBuffCellClone:clone()
			local attackText = node:getChildByFullName("text")
			local icon = node:getChildByFullName("buff")
			local title = node:getChildByFullName("title")
			local line = node:getChildByFullName("line2")
			local tips = node:getChildByFullName("tips")
			local skillConfig = ConfigReader:getRecordById("Skill", buffInfo.value)

			title:setVisible(index == 1)
			line:setVisible(index == 1)
			title:setString("BUFF")

			if skillConfig then
				attackText:setString(Strings:get(skillConfig.Name))
				attackText:setColor(cc.c3b(255, 159, 48))
			end

			local isLock = self._dreamSystem:checkBuffLock(self._mapId, self._pointId, buffInfo.value)
			local isUsed = self._dreamSystem:checkBuffUsed(self._mapId, self._pointId, buffInfo.value)
			local info = {}

			info.id = buffInfo.value
			info.isLock = isLock
			info.isGray = isLock or isUsed

			local buffIcon = IconFactory:createBuffIcon(info, {
				scale = 0.65
			})

			buffIcon:addTo(icon):center(icon:getContentSize())
			tips:setVisible(isUsed)

			local touchInfo = {}

			touchInfo.code = buffInfo.value
			touchInfo.type = RewardType.kBuff
			touchInfo.amount = 0
			touchInfo.buffType = buffInfo.Type

			if isLock then
				local pointName = self._dreamSystem:getPointName(self._pointId)
				local battleName = self._dreamSystem:getBattleName(battleIds[i])

				touchInfo.desc = Strings:get("DreamChallenge_Buff_Lock_Desc", {
					point = pointName,
					battle = battleName
				})
			elseif isUsed then
				touchInfo.desc = Strings:get("DreamChallenge_Buff_Used")
			elseif buffInfo.Type == "OneTimeBuff" then
				local buffs = self._dreamSystem:getBuffs(self._mapId, self._pointId)

				if buffs and buffs[buffInfo.value] then
					touchInfo.desc = Strings:get("DreamChallenge_Buff_End_Num", {
						num = buffs[buffInfo.value].duration
					})
				end
			elseif buffInfo.Type == "TimeBuff" then
				local buffs = self._dreamSystem:getBuffs(self._mapId, self._pointId)

				if buffs and buffs[buffInfo.value] then
					local str = ""
					local fmtStr = "${d}:${H}:${M}:${S}"
					local timeStr = TimeUtil:formatTime(fmtStr, buffs[buffInfo.value].time)
					local parts = string.split(timeStr, ":", nil, true)
					local timeTab = {}

					timeTab.day = tonumber(parts[1])
					timeTab.hour = tonumber(parts[2])
					timeTab.min = tonumber(parts[3])
					timeTab.sec = tonumber(parts[4])
					str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")
					touchInfo.desc = Strings:get("DreamChallenge_Buff_End_Time", {
						time = str
					})
				end
			end

			icon:setSwallowTouches(false)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), touchInfo, {
				needDelay = true
			})

			index = index + 1

			self._infoList:pushBackCustomItem(node)
		end
	end
end

function DreamChallengePointMediator:checkGuide()
	return
end

function DreamChallengePointMediator:onClickDetailBtn()
	local view = self:getInjector():getInstance("DreamChallengeBuffDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		mapId = self._mapId,
		pointId = self._pointId
	}))
end

function DreamChallengePointMediator:onClickResetBtn()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf._dreamSystem:requestResetPoint(outSelf._mapId, outSelf._pointId, function(response)
				if response.resCode == 0 then
					outSelf:dispatch(Event:new(EVT_DREAMCHALLENGE_POINT_RESET, {
						mapId = outSelf._mapId,
						pointId = outSelf._pointId
					}))
					outSelf:refreshPointView()
				end
			end)
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local pointName = self._dreamSystem:getPointName(self._pointId)
	local str = Strings:get("DreamChallenge_Reset_Point", {
		pointName = pointName
	})
	local data = {
		title = Strings:get("DreamChallenge_Reset_Title"),
		title1 = Strings:get("DreamChallenge_Reset_Title_En"),
		content = Strings:get("DreamChallenge_Reset_Point", {
			pointName = pointName
		}),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

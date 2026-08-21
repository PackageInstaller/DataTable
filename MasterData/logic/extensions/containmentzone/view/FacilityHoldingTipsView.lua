-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingTipsView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingTipsView", package.seeall)

local M = class("FacilityHoldingTipsView", ViewComponent)

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self)

	self.mainGO = mainGO

	self:setViewPresentor(viewPresentor)
end

function M:buildUI()
	self._tipsRoot = self:getGo("facility_holding_main_view_-1658787499")
	self._txtName = self:getText("facility_holding_main_view_-1058236847")
	self._icon = self:getImage("battle_hero_item_892867850")
	self._goNoHero = goutil.findChild(self._tipsRoot, "cell/hero_item/pos/imgNone").gameObject
	self._txtMood = self:getText("facility_holding_main_view_-1896635277")
	self._goMoodRoot = self:getGo("facility_holding_main_view_-1076532556")
	self._Mood = {
		{
			go = self:getGo("facility_holding_main_view_796514451"),
			img = self:getImage("facility_holding_main_view_-1978292734")
		},
		{
			go = self:getGo("facility_holding_main_view_1146216036"),
			img = self:getImage("facility_holding_main_view_141937998")
		},
		{
			go = self:getGo("facility_holding_main_view_-1909143321"),
			img = self:getImage("facility_holding_main_view_632026805")
		}
	}
	self._ReportEfficient = {
		self:getText("facility_holding_main_view_-1971208495"),
		self:getText("facility_holding_main_view_2099249431"),
		self:getText("facility_holding_main_view_-1493450702"),
		(self:getText("facility_holding_main_view_696103916"))
	}
	self._rootHoldEfficient = self:getRectTransform("facility_holding_main_view_-168458558")
	self._rootEchoEfficient = self:getRectTransform("facility_holding_main_view_-1032977391")
	self._rootPreference = self:getRectTransform("facility_holding_main_view_353700539")
	self._rootHate = self:getRectTransform("facility_holding_main_view_-1509038333")
	self._rootTouch = self:getRectTransform("facility_holding_main_view_1614892064")
	self._txtPreference = self:getText("facility_holding_main_view_1458733923")
	self._txtHate = self:getText("facility_holding_main_view_1736801930")
	self._txtTouch = self:getText("facility_holding_main_view_-1321350772")
end

function M:destroyUI()
	self._tipsRoot = nil
	self._txtName = nil
	self._icon = nil
	self._goNoHero = nil
	self._txtMood = nil
	self._goMoodRoot = nil
	self._Mood = nil
	self._ReportEfficient = nil
	self._rootHoldEfficient = nil
	self._rootEchoEfficient = nil
	self._rootPreference = nil
	self._rootHate = nil
	self._rootTouch = nil
	self._txtPreference = nil
	self._txtHate = nil
	self._txtTouch = nil
	self._roomInfoMo = nil
	self._protomerInfoMo = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setShow(show)
	goutil.setActive(self._tipsRoot, show)

	if show then
		self:onEnter()
		self:_printLogMsg()
	else
		self:onExit()
	end
end

function M:updateShow(roomInfoMo, protomerInfoMo)
	self._roomInfoMo = roomInfoMo
	self._protomerInfoMo = protomerInfoMo

	local cfgInfo = protomerInfoMo:getCfgInfo()
	local heroId = roomInfoMo:getHeroId()

	self:_updateHintHeroInfo(roomInfoMo)

	local reportPredict = protomerInfoMo:getReportEvaluatePredict()

	for index, txt in ipairs(self._ReportEfficient) do
		txt.text = string.format("%0.1f%%", reportPredict[index])
	end

	local holdEfficient = protomerInfoMo:getHoldEfficient()

	self:_duelBrickProcess(self._rootHoldEfficient, holdEfficient, 1, 0)

	local preferenTyp = cfgInfo.preferen[1] or 1

	self._txtPreference.text = ContainmentUtil.getPreferenName(preferenTyp)

	local preferenVal = 0

	if heroId > 0 then
		preferenVal = ContainmentUtil.getHeroQuaValByProtomerPreferen(heroId, preferenTyp)
	end

	self:_duelBrickProcess(self._rootPreference, preferenVal, 2, 0)

	local hateTyp = cfgInfo.preferen[2] or 0

	self._txtHate.text = ContainmentUtil.getPreferenName(hateTyp)

	local hateVal = 0

	if heroId > 0 and hateTyp > 0 then
		hateVal = ContainmentUtil.getHeroQuaValByProtomerPreferen(heroId, hateTyp)
	end

	self:_duelBrickProcess(self._rootHate, hateVal, 2, 1)
	goutil.setActive(self._rootHate.gameObject, hateTyp > 0)

	self._txtTouch.text = ContainmentUtil.getTouchDefineName(protomerInfoMo:getTouchWay(), protomerInfoMo:getProtomerId())

	local touchVal = 0

	if preferenVal > 0 and preferenVal <= 1 then
		touchVal = 3
	elseif preferenVal > 1 then
		touchVal = 6
	end

	self:_duelBrickProcess(self._rootTouch, touchVal, 2, 0)

	local echoLevel = protomerInfoMo:getEchoLevel()

	self:_duelBrickProcess(self._rootEchoEfficient, echoLevel, 1, 0)
end

function M:_duelBrickProcess(rootTr, val, starIndex, sunActiveIndex)
	for i = starIndex, rootTr.childCount - 1 do
		local tmpGo = rootTr:GetChild(i):GetChild(sunActiveIndex).gameObject
		local show = val > i - starIndex

		goutil.setActive(tmpGo, show)
	end
end

function M:_updateHintHeroInfo(roomInfoMo)
	local heroId = roomInfoMo:getHeroId()

	if heroId > 0 then
		IconLoader.setSprite(self._icon, IconType.HeadIcon, ContainmentUtil.getHeroHeadIconSrc(heroId))

		local moodValue = ContainmentUtil.getHeroRoomMood(heroId)
		local moodMaxValue = HouseConfig.instance:getHouseConst("MoodMax").numValue
		local moodTyp = HouseWorkerModel.instance:getMoodInterval(moodValue)
		local fillAmount = moodValue / moodMaxValue

		for index, value in ipairs(self._Mood) do
			local show = index == moodTyp

			if show then
				value.img.fillAmount = fillAmount
			end

			goutil.setActive(value.go, show)
		end

		self._txtMood.text = string.format("%s/%s", math.floor(moodValue), moodMaxValue)
	end

	self._txtName.text = heroId > 0 and ContainmentUtil.getHeroName(heroId) or "NONE"

	goutil.setActive(self._txtMood.gameObject, heroId > 0)
	goutil.setActive(self._icon.gameObject, heroId > 0)
	goutil.setActive(self._goMoodRoot, heroId > 0)
	goutil.setActive(self._goNoHero, heroId == 0)
end

function M:_printLogMsg()
	if Astral.OSDef.isEditor then
		local roomInfoMo = self._roomInfoMo
		local protomerInfoMo = self._protomerInfoMo
		local FullEvaluateSchedule = ContainmentConfig.instance:getConstByKey("FullEvaluateSchedule")
		local remainCount = math.min(protomerInfoMo:getProductivity() / (protomerInfoMo:getCfgProductivity() / FullEvaluateSchedule), FullEvaluateSchedule)

		remainCount = FullEvaluateSchedule - math.floor(remainCount)

		printWarn(string.format("[报告概率] 剩余评估次数[%s] = 评分次数[%s] - math.floor(math.min(生产值[%s]/(生产需求[%s]/评分次数[%s]),评分次数[%s]))", remainCount, FullEvaluateSchedule, protomerInfoMo:getProductivity(), protomerInfoMo:getCfgProductivity(), FullEvaluateSchedule, FullEvaluateSchedule))

		local predictScore = protomerInfoMo:getScore() + remainCount * protomerInfoMo:getScoreAdd()

		printWarn(string.format("[报告概率] 预估点数[%s] = 累计评价点数[%s] + 剩余评估次数[%s] * 每次评价点数[%s]", predictScore, protomerInfoMo:getScore(), remainCount, protomerInfoMo:getScoreAdd()))

		local evaluateCode = ContainmentConfig.instance:getProtomerCoById(protomerInfoMo:getProtomerId()).evaluate
		local cfgLst = ContainmentConfig.instance:getEvaluateLst(evaluateCode)
		local maxEvaluateKey = cfgLst[1].key

		printWarn(string.format("[收容效率][%s] = (每次评价点数[%s]*10÷[方案id [%s]]最大范围值[%s])*6", protomerInfoMo:getHoldEfficient(), protomerInfoMo:getScoreAdd(), evaluateCode, maxEvaluateKey))

		local cfgInfo = protomerInfoMo:getCfgInfo()
		local preferenTyp = cfgInfo.preferen[1] or 1
		local hateTyp = cfgInfo.preferen[2] or 0
		local preferenVal = 0
		local hateVal = 0
		local heroId = roomInfoMo:getHeroId()

		if heroId > 0 then
			local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

			preferenVal = ContainmentUtil.getHeroQuaValByProtomerPreferen(heroId, preferenTyp)

			printWarn(string.format("[角色六维][%s] 力量[%s] 敏捷[%s] 知识[%s] 沟通[%s] 洞察[%s] 幸运[%s]", heroId, cfgCharacter.qua6[1], cfgCharacter.qua6[2], cfgCharacter.qua6[3], cfgCharacter.qua6[4], cfgCharacter.qua6[5], cfgCharacter.qua6[6]))

			if hateTyp > 0 then
				hateVal = ContainmentUtil.getHeroQuaValByProtomerPreferen(heroId, preferenTyp)
			end
		end

		printWarn(string.format("原体偏好[%s][%s] 对应值[%s]", preferenTyp, ContainmentUtil.getPreferenName(preferenTyp), preferenVal))

		if hateTyp > 0 then
			printWarn(string.format("原体厌恶[%s][%s] 对应值[%s]", hateTyp, ContainmentUtil.getPreferenName(hateTyp), hateVal))
		else
			printWarn("原体无厌恶")
		end
	end
end

return M

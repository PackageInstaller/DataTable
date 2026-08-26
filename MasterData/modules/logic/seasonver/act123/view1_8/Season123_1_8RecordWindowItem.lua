-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8RecordWindowItem.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8RecordWindowItem", package.seeall)

local Season123_1_8RecordWindowItem = class("Season123_1_8RecordWindowItem", LuaCompBase)
local NotBestRecordMoveY = 6

function Season123_1_8RecordWindowItem:init(go)
	self.go = go
	self._gobestrecord = gohelper.findChild(self.go, "#go_bestrecord")
	self._gonormalrecord = gohelper.findChild(self.go, "#go_normalrecord")
	self._txtTotalEn = gohelper.findChildText(self.go, "#go_normalrecord/en1")
	self._goBestBg = gohelper.findChild(self.go, "#go_normalrecord/totaltime/#img_bestBg")
	self._goBestCircle = gohelper.findChild(self.go, "#go_normalrecord/totaltime/#go_bestcircle")
	self._txtBlueTxtTime = gohelper.findChildText(self.go, "#go_normalrecord/totaltime/#go_bestcircle/#txt_timeblue")
	self._txttime = gohelper.findChildText(self.go, "#go_normalrecord/totaltime/#txt_time")
	self._btndetails = gohelper.findChildButtonWithAudio(self.go, "#go_normalrecord/#btn_details")

	local goHeroList = gohelper.findChild(self.go, "#go_normalrecord/#scroll_herolist")

	self._transHeroList = goHeroList.transform
	self._originalHeroListY = recthelper.getAnchorY(self._transHeroList)
	self._goContent = gohelper.findChild(self.go, "#go_normalrecord/#scroll_herolist/Viewport/Content")
	self._goheroitem = gohelper.findChild(self.go, "#go_normalrecord/#scroll_herolist/Viewport/Content/#go_heroitem")
	self._itemAni = self.go:GetComponent(typeof(UnityEngine.Animator))
end

function Season123_1_8RecordWindowItem:addEventListeners()
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
end

function Season123_1_8RecordWindowItem:removeEventListeners()
	self._btndetails:RemoveClickListener()
end

function Season123_1_8RecordWindowItem:_btndetailsOnClick()
	if not self.mo or not self.mo.attackStatistics then
		return
	end

	FightStatModel.instance:setAtkStatInfo(self.mo.attackStatistics)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function Season123_1_8RecordWindowItem:onLoad(delayOpenAnimTime, isPlayOpen)
	gohelper.setActive(self.go, false)

	self._isPlayOpen = isPlayOpen

	TaskDispatcher.runDelay(self._delayActive, self, delayOpenAnimTime)
end

function Season123_1_8RecordWindowItem:_delayActive()
	gohelper.setActive(self.go, true)
	self:playAnimation((self._isPlayOpen or nil) and (UIAnimationName.Open or UIAnimationName.Idle))

	self._isPlayOpen = false
end

function Season123_1_8RecordWindowItem:onUpdateMO(mo)
	self.mo = mo

	if not self.mo or self.mo.isEmpty then
		gohelper.setActive(self._gobestrecord, false)
		gohelper.setActive(self._gonormalrecord, false)

		return
	end

	gohelper.setActive(self._gonormalrecord, true)

	if not self.mo.round then
		local isBest = self.mo.isBest

		if not self.mo.heroList then
			local heroList = {}

			self._txttime.text = self.mo.round
			self._txtBlueTxtTime.text = self.mo.round

			gohelper.setActive(self._gobestrecord, isBest)
			gohelper.setActive(self._goBestBg, isBest)
			gohelper.setActive(self._goBestCircle, isBest)

			local color = isBest and "#7D4A29" or "#393939"

			SLFramework.UGUI.GuiHelper.SetColor(self._txtTotalEn, color)

			if isBest then
				if not self._originalHeroListY then
					local heroListY = self._originalHeroListY + NotBestRecordMoveY

					recthelper.setAnchorY(self._transHeroList, heroListY)
					gohelper.CreateObjList(self, self._onHeroItemLoad, heroList, self._goContent, self._goheroitem)
				end
			end
		end
	end
end

function Season123_1_8RecordWindowItem:playAnimation(animName)
	if not self._itemAni then
		return
	end

	self._itemAni:Play(animName or UIAnimationName.Idle)
end

function Season123_1_8RecordWindowItem:_onHeroItemLoad(obj, heroData, index)
	if gohelper.isNil(obj) then
		return
	end

	local goEmpty = gohelper.findChild(obj, "empty")
	local goAssist = gohelper.findChild(obj, "assist")
	local goHero = gohelper.findChild(obj, "hero")
	local heroCfg, heroIcon
	local heroId = heroData.heroId

	if heroId and heroId ~= 0 then
		heroCfg = HeroConfig.instance:getHeroCO(heroId)
	end

	if not gohelper.isNil(goHero) then
		heroIcon = IconMgr.instance:getCommonHeroIconNew(goHero)
	end

	if heroCfg and heroIcon then
		if not heroData.level then
			local level = 1

			if not heroData.skinId then
				local skinId = heroCfg.skinId
				local isBalance = heroData.isBalance
				local isAssist = heroData.isAssist
				local heroMo = HeroMo.New()

				heroMo:initFromConfig(heroCfg)

				local _, rank = HeroConfig.instance:getShowLevel(level)

				heroMo.rank = rank
				heroMo.level = level
				heroMo.skin = skinId

				heroIcon:onUpdateMO(heroMo)
				heroIcon:isShowRare(false)
				heroIcon:isShowEmptyWhenNoneHero(false)
				heroIcon:setIsBalance(isBalance)
				gohelper.setActive(goHero, true)
				gohelper.setActive(goAssist, isAssist)
				gohelper.setActive(goEmpty, false)
			end
		end
	else
		gohelper.setActive(goHero, false)
		gohelper.setActive(goAssist, false)
		gohelper.setActive(goEmpty, true)
	end
end

function Season123_1_8RecordWindowItem:onDestroy()
	TaskDispatcher.cancelTask(self._delayActive, self)

	self._isPlayOpen = false
end

return Season123_1_8RecordWindowItem

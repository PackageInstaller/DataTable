-- chunkname: @modules/logic/fight/buffbehaviours/FightBuffBehaviour_3_3Dream.lua

module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_3_3Dream", package.seeall)

local FightBuffBehaviour_3_3Dream = class("FightBuffBehaviour_3_3Dream", FightBuffBehaviourBase)
local dreamPath = "ui/viewres/fight/fighttower/fightdreamview.prefab"
local TempBuffList = {}
local ForbidDreamType = {
	Beautiful = 1,
	Nightmare = 2,
	None = 0
}
local PointState = {
	Nightmare = 3,
	ForbidNightmare = 4,
	Beautiful = 1,
	ForbidBeautiful = 2,
	Empty = 0
}

function FightBuffBehaviour_3_3Dream:onAddBuff(entityId, buffId, buffMo)
	self.root = gohelper.findChild(self.viewGo, "root/topLeftContent")
	self.buffId = buffId
	self.entityId = entityId
	self.entityMo = FightDataHelper.entityMgr:getById(entityId)
	self.forbidType = ForbidDreamType.None

	self:initCo()

	self.loader = MultiAbLoader.New()

	self.loader:addPath(dreamPath)
	self.loader:startLoad(self.onLoadFinish, self)
end

function FightBuffBehaviour_3_3Dream:initCo()
	local co = lua_fight_buff2special_behaviour.configDict[self.buffId]
	local paramList = FightStrUtil.instance:getSplitToNumberCache(co.param, "#")

	if paramList then
		self.maxPoint = paramList[1] or 7
	end

	self.beautifulDreamBuffId = paramList and paramList[2]
	self.nightmareBuffId = paramList and paramList[3]
	self.forbidBeautifulBuffId = paramList and paramList[4]
	self.forbidNightmareBuffId = paramList and paramList[5]
end

function FightBuffBehaviour_3_3Dream:onLoadFinish()
	local assetItem = self.loader:getFirstAssetItem()

	if not assetItem then
		logError(" load dream res failed")

		return
	end

	local prefab = assetItem:GetResource()

	self.go = gohelper.clone(prefab, self.root)
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.goNormal = gohelper.findChild(self.go, "#normal")
	self.goBeautiful = gohelper.findChild(self.go, "#sweet_dreams")
	self.goNightmare = gohelper.findChild(self.go, "#nightmare")
	self.goPointItem = gohelper.findChild(self.go, "point/point")
	self.rightTopRectTr = gohelper.findChildComponent(self.go, "right_top", gohelper.Type_RectTransform)

	gohelper.setActive(self.goPointItem, false)

	self.click = gohelper.findChildClickWithDefaultAudio(self.go, "btn")
	self.pointItemList = {}

	self.addClickCb(self, self.click, self.onClick, self)
	self:initPointList()
	self:refreshPointList()
	self:directRefreshBg()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdateFunc, self)
end

function FightBuffBehaviour_3_3Dream:onBuffUpdateFunc(entityId, effectType, buffId, buffUid, configEffect, buffMo)
	if entityId ~= self.entityId then
		return
	end

	local isValid = self:checkIsDreamBuffId(buffId) or self:checkIsForbidDreamId(buffId)

	if not isValid then
		return
	end

	self:refreshPointList()
end

function FightBuffBehaviour_3_3Dream:checkIsDreamBuffId(buffId)
	return buffId == self.beautifulDreamBuffId or buffId == self.nightmareBuffId
end

function FightBuffBehaviour_3_3Dream:checkIsForbidDreamId(buffId)
	return buffId == self.forbidBeautifulBuffId or buffId == self.forbidNightmareBuffId
end

function FightBuffBehaviour_3_3Dream:initPointList()
	for i = 1, self.maxPoint do
		local pointItem = self:getUserDataTb_()

		pointItem.go = gohelper.cloneInPlace(self.goPointItem)

		gohelper.setActive(pointItem.go, true)

		pointItem.goEmpty = gohelper.findChild(pointItem.go, "empty")
		pointItem.goBeautiful = gohelper.findChild(pointItem.go, "sweet_point")
		pointItem.goNightmare = gohelper.findChild(pointItem.go, "night_point")
		pointItem.beautifulAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(pointItem.goBeautiful)
		pointItem.nightmareAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(pointItem.goNightmare)
		pointItem.curState = PointState.Empty
		pointItem.playingAnim = false

		table.insert(self.pointItemList, pointItem)
	end
end

function FightBuffBehaviour_3_3Dream:getBuffList()
	if not self.entityMo then
		return
	end

	tabletool.clear(TempBuffList)
	self.entityMo:getOrderedBuffList_ByTime(TempBuffList)

	self.forbidType = ForbidDreamType.None

	for i = #TempBuffList, 1, -1 do
		local buffMo = TempBuffList[i]
		local buffId = buffMo.buffId

		if self:checkIsForbidDreamId(buffId) then
			table.remove(TempBuffList, i)

			if buffId == self.forbidBeautifulBuffId then
				self.forbidType = ForbidDreamType.Beautiful or ForbidDreamType.Nightmare
			end
		elseif self:checkIsDreamBuffId(buffId) then
			-- block empty
		else
			table.remove(TempBuffList, i)
		end
	end

	return TempBuffList
end

function FightBuffBehaviour_3_3Dream:refreshPointList()
	local buffList = self:getBuffList()

	if not buffList then
		return
	end

	local forbidType = self.forbidType

	for i = 1, self.maxPoint do
		local buffMo = buffList[i]
		local pointItem = self.pointItemList[i]

		if not buffMo then
			pointItem.curState = PointState.Empty

			gohelper.setActive(pointItem.goEmpty, true)
			gohelper.setActive(pointItem.goBeautiful, false)
			gohelper.setActive(pointItem.goNightmare, false)
		else
			gohelper.setActive(pointItem.goEmpty, false)

			local preState = pointItem.curState
			local buffId = buffMo.buffId

			if buffId == self.beautifulDreamBuffId then
				gohelper.setActive(pointItem.goNightmare, false)
				gohelper.setActive(pointItem.goBeautiful, true)

				if forbidType == ForbidDreamType.Beautiful then
					pointItem.curState = PointState.ForbidBeautiful

					if pointItem.curState ~= preState then
						self:playAnimatorAnim(pointItem.beautifulAnimatorPlayer, "disabled", pointItem)
					end
				else
					pointItem.curState = PointState.Beautiful

					if pointItem.curState ~= preState then
						pointItem.playingAnim = true

						self:playAnimatorAnim(pointItem.beautifulAnimatorPlayer, "light", pointItem)
					end
				end
			else
				gohelper.setActive(pointItem.goBeautiful, false)
				gohelper.setActive(pointItem.goNightmare, true)

				if forbidType == ForbidDreamType.Nightmare then
					pointItem.curState = PointState.ForbidNightmare

					if pointItem.curState ~= preState then
						pointItem.playingAnim = true

						self:playAnimatorAnim(pointItem.nightmareAnimatorPlayer, "disabled", pointItem)
					end
				else
					pointItem.curState = PointState.Nightmare

					if pointItem.curState ~= preState then
						pointItem.playingAnim = true

						self:playAnimatorAnim(pointItem.nightmareAnimatorPlayer, "light", pointItem)
					end
				end
			end
		end
	end

	self:tryRefreshBg()
end

function FightBuffBehaviour_3_3Dream:tryRefreshBg()
	for i = 1, self.maxPoint do
		local pointItem = self.pointItemList[i]

		if pointItem.playingAnim then
			return
		end
	end

	self:directRefreshBg()
end

function FightBuffBehaviour_3_3Dream:playAnimatorAnim(animatorPlayer, animName, pointItem)
	pointItem.playingAnim = true

	animatorPlayer:Play(animName, self.onPlayPointAnimDone, self, pointItem)
end

function FightBuffBehaviour_3_3Dream:onPlayPointAnimDone(pointItem)
	pointItem.playingAnim = false

	self:tryRefreshBg()
end

function FightBuffBehaviour_3_3Dream:directRefreshBg()
	local forbidType = self.forbidType

	gohelper.setActive(self.goNormal, forbidType == ForbidDreamType.None)
	gohelper.setActive(self.goBeautiful, forbidType == ForbidDreamType.Nightmare)
	gohelper.setActive(self.goNightmare, forbidType == ForbidDreamType.Beautiful)
	self:playAudio()
end

function FightBuffBehaviour_3_3Dream:getResName(buffId, forbidType)
	if buffId == self.beautifulDreamBuffId then
		if forbidType == ForbidDreamType.Beautiful then
			return "fight_towerdream_point4"
		else
			return "fight_towerdream_point2"
		end
	elseif forbidType == ForbidDreamType.Nightmare then
		return "fight_towerdream_point5"
	else
		return "fight_towerdream_point3"
	end
end

function FightBuffBehaviour_3_3Dream:onClick()
	local screenPos = recthelper.uiPosToScreenPos(self.rightTopRectTr)
	local title = luaLang("fight_dream_title_3_3")
	local desc = luaLang("fight_dream_desc_3_3")

	FightCommonTipController.instance:openCommonView(title, desc, screenPos)
end

function FightBuffBehaviour_3_3Dream:playAudio()
	if self.playedAudio then
		return
	end

	if self.forbidType == ForbidDreamType.None then
		return
	end

	local audioId = self.forbidType == ForbidDreamType.Beautiful and 310005 or 310010

	self.playedAudio = true

	AudioMgr.instance:trigger(audioId)
end

function FightBuffBehaviour_3_3Dream:onUpdateBuff(entityId, buffId, buffMo)
	if entityId ~= self.entityId then
		return
	end

	local isValid = self:checkIsDreamBuffId(buffId) or self:checkIsForbidDreamId(buffId)

	if not isValid then
		return
	end

	self:refreshPointList()
end

function FightBuffBehaviour_3_3Dream:onRemoveBuff(entityId, buffId, buffMo)
	gohelper.destroy(self.go)
end

function FightBuffBehaviour_3_3Dream:clearLoader()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function FightBuffBehaviour_3_3Dream:onDestroy()
	self:clearLoader()
	FightBuffBehaviour_3_3Dream.super.onDestroy(self)
end

return FightBuffBehaviour_3_3Dream

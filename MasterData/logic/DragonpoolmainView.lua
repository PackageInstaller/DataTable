-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/view/DragonpoolmainView.lua

module("logic.extensions.dragonpool.view.DragonpoolmainView", package.seeall)

local DragonpoolmainView = class("DragonpoolmainView", ViewComponent)

function DragonpoolmainView:ctor()
	DragonpoolmainView.super.ctor(self)
end

function DragonpoolmainView:unbindEvents()
	DragonpoolmainView.super.unbindEvents(self)
	self._btnReward:RemoveClickListener()
	self._btnTouch:RemoveClickListener()
	self._btnCut:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
	self._touchmask:RemoveClickListener()
end

function DragonpoolmainView:bindEvents()
	DragonpoolmainView.super.bindEvents(self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btnTouch:AddClickListener(self._onClickbtnTouch, self)
	self._btnCut:AddClickListener(self._onClickbtnCut, self)
	self._btnChat:AddClickListener(self._onClickbtnChat, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnAgain:AddClickListener(self._onClickbtnAgain, self)

	for i, v in ipairs(self._grassItems) do
		PointerEnterHandler.Get(v.go):AddLuaHandler(function(_go, eventData)
			self:_onEnterGrass(_go, i)
		end)
	end

	BeginDragHandler.Get(self._btnCut.gameObject):AddLuaHandler(function(_go, eventData)
		self:_onBeginDrag(_go, eventData)
	end)
	EndDragHandler.Get(self._btnCut.gameObject):AddLuaHandler(function(_go, eventData)
		self:_onEndDrag(_go, eventData)
	end)
	DragHandler.Get(self._btnCut.gameObject):AddLuaHandler(function(_go, eventData)
		self:_onDrag(_go, eventData)
	end)
	self._touchmask:AddClickListener(self._onClicktouchmask, self)
end

function DragonpoolmainView:buildUI()
	DragonpoolmainView.super.buildUI(self)

	self._txtFeel = self:getTxt("valuepart/txtFeel")
	self._txtGrow = self:getTxt("valuepart/txtGrow")
	self._btnReward = self:getBtn("btnReward")
	self._btnTouch = self:getBtn("btnTouch")
	self._btnCut = self:getBtn("btnCut")
	self._btnChat = self:getBtn("btnChat")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtBtnChat = self:getTxt("btnChat/txtBtnChat")
	self._txtBtnTouch = self:getTxt("btnTouch/txtBtnTouch")
	self._grassGo = self:getGo("dragonpart/grass")
	self._grassItems = {}

	for i = 1, 6 do
		self._grassItems[i] = {
			go = goutil.findChild(self._grassGo, "grass" .. i)
		}
	end

	self._btnAgain = self:getBtn("btnAgain")
	self._txtBtnAgain = self:getTxt("btnAgain/tip/txt")
	self._dragIcon = self:getGo("dragonpart/icon")
	self._redpointGo = self:getGo("btnReward/redpoint")
	self._typewriter = self:getGo("chatpart/chat/txtChat"):GetComponent(ComponentType.TypewriterNew)
	self._typewriter.speed = 0.02
	self._shoutaoGo = self:getResInstance(DragonpoolmainViewPresentor.ShouTao)

	goutil.setActive(self._shoutaoGo, false)

	self._touchmask = self:getBtn("touchmask")
end

function DragonpoolmainView:onExit()
	DragonpoolmainView.super.onExit(self)

	self._dragGo = nil

	uGuiUtil.clearImage(self._dragIcon)
	RedPointController.instance:unregRedPoint(self._redpointGo)
	removetimer(self._sendTouch, self)
end

function DragonpoolmainView:onEnter()
	DragonpoolmainView.super.onEnter(self)
	self.addGEvent(self, DragonPoolAgent.DragonPoolGetInfoRes, self._updateUI, self)
	self.addGEvent(self, DragonPoolAgent.DragonPoolChatRes, self._updateUI, self)
	self.addGEvent(self, DragonPoolAgent.DragonPoolWeedRes, self._updateUI, self)
	self.addGEvent(self, DragonPoolAgent.DragonPoolTouchRes, self._updateUI, self)
	self.addGEvent(self, DragonPoolAgent.DragonPoolNextEggRes, self._updateUI, self)

	self._activityType = GameEnum.ActivityType.DragonPool
	self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)

	DragonpoolModel.instance:setActivityId(self._activityId)

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._inTouching = false

	goutil.setActive(self._touchmask.gameObject, false)
	self:_updateUI()
	DragonPoolAgent.instance:sendPM_DragonPoolGetInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redpointGo, RedPointModel.ID_DRAGONPOOL_REWARD)
end

function DragonpoolmainView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.DragonpoolrewardView)
end

function DragonpoolmainView:_onClickbtnTouch()
	if not self._info then
		return
	end

	local currEggCfg = DragonpoolConfig.instance:getEggCfg(self._activityId, self._info.eggId)

	if self._info.growth >= currEggCfg.maxGrowth then
		FloatWordMgr.instance:show("当前龙蛋已出生，无法增加心情值噢！")

		return
	end

	local cfg = DragonpoolConfig.instance:getActivityCfg(self._activityId)
	local maxTime = cfg.dailyTouchTimes

	if maxTime <= self._info.todayTouchTimes then
		FloatWordMgr.instance:show("次数用尽，明天再来吧~")

		return
	end

	local time = checknumber(self._info.nextCanTouchTime)
	local nowMs = ServerTime.nowMs()

	if nowMs <= time then
		local tip = string.format("冷却中,还需等待%ss", math.ceil((time - nowMs) / 1000))

		FloatWordMgr.instance:show(tip)

		return
	end

	self:_startTouch()
end

function DragonpoolmainView:_startTouch()
	if self._inTouching then
		return
	end

	self._inTouching = true

	goutil.setActive(self._touchmask.gameObject, true)

	if self._shoutaoGo then
		self._shoutaoGo.transform:SetParent(self._dragIcon.transform)
		Framework.TransformUtil.SetLocalRotation(self._shoutaoGo.transform, 300, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._shoutaoGo.transform, 0, 0, -500)
		Framework.TransformUtil.SetLocalScale(self._shoutaoGo.transform, 500, 500, 500)
		Framework.GameObjectUtil.SetLayerRecursively(self._shoutaoGo, SceneLayer.UI_Value)
		goutil.setActive(self._shoutaoGo, true)
	end

	removetimer(self._sendTouch, self)
	settimer(3, self._sendTouch, self, false)
end

function DragonpoolmainView:_sendTouch()
	self._inTouching = false

	goutil.setActive(self._touchmask.gameObject, false)
	goutil.setActive(self._shoutaoGo, false)
	DragonPoolAgent.instance:sendPM_DragonPoolTouchReq(self._activityId)
end

function DragonpoolmainView:_onClickbtnCut()
	return
end

function DragonpoolmainView:_onClickbtnChat()
	if not self._info then
		return
	end

	local currEggCfg = DragonpoolConfig.instance:getEggCfg(self._activityId, self._info.eggId)

	if self._info.growth >= currEggCfg.maxGrowth then
		FloatWordMgr.instance:show("当前龙蛋已出生，无法增加心情值噢！")

		return
	end

	local cfg = DragonpoolConfig.instance:getActivityCfg(self._activityId)
	local maxTime = cfg.dailyChatTimes

	if maxTime <= self._info.todayChatTimes then
		FloatWordMgr.instance:show("次数用尽，明天再来吧~")

		return
	end

	local time = checknumber(self._info.nextCanChatTime)
	local nowMs = ServerTime.nowMs()

	if nowMs <= time then
		local tip = string.format("冷却中,还需等待%ss", math.ceil((time - nowMs) / 1000))

		FloatWordMgr.instance:show(tip)

		return
	end

	DragonPoolAgent.instance:sendPM_DragonPoolChatReq(self._activityId)
end

function DragonpoolmainView:_onClickbtnClose()
	self:close()
end

function DragonpoolmainView:_onClickbtnTip()
	local ruleCo = RulesConfig.instance:getRuleCo("dragonpooltipview")

	CommonTipsMgr.instance:showTips(ruleCo.rules, self._btnTip.gameObject)
end

function DragonpoolmainView:_onClickbtnAgain()
	DragonPoolAgent.instance:sendPM_DragonPoolNextEggReq(self._activityId)
end

function DragonpoolmainView:_updateUI()
	self._info = DragonpoolModel.instance:getInfo()

	if not self._info then
		return
	end

	self:_setChat()
	self:_setGrass()
	self:_setValues()
	self:_setTime()
	self:_setPlayTime()
	self:_setEgg()
end

function DragonpoolmainView:_setChat()
	local textId = self._info.textId
	local str = DragonpoolConfig.instance:getChatTxt(self._activityId, textId)

	if self._typewriter.text ~= str then
		self._typewriter:SetText(str)
	end
end

function DragonpoolmainView:_setGrass()
	if not self._info then
		return
	end

	local nowMs = ServerTime.nowMs()

	for i, v in ipairs(self._info.grassList) do
		local item = self._grassItems[v.grassId]

		if item then
			local time = checknumber(v.nextCanWeedTime)
			local isWeed = time <= nowMs

			goutil.setActive(item.go, isWeed)
		end
	end
end

function DragonpoolmainView:_setValues()
	self._txtFeel.text = self._info.mood
	self._txtGrow.text = self._info.growth
end

function DragonpoolmainView:_setTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function DragonpoolmainView:_setPlayTime()
	local chatTime = self._info.todayChatTimes
	local chatTotalTime = DragonpoolConfig.instance:getDailyChatTimes(self._activityId)

	self._txtBtnChat.text = string.format("%s/%s", chatTotalTime - chatTime, chatTotalTime)

	local touchTime = self._info.todayTouchTimes
	local touchTotalTime = DragonpoolConfig.instance:getDailyTouchTimes(self._activityId)

	self._txtBtnTouch.text = string.format("%s/%s", touchTotalTime - touchTime, touchTotalTime)
end

function DragonpoolmainView:_onEnterGrass(go, index)
	if not self._info then
		return
	end

	if not self._dragGo then
		return
	end

	local currEggCfg = DragonpoolConfig.instance:getEggCfg(self._activityId, self._info.eggId)

	if self._info.growth >= currEggCfg.maxGrowth then
		FloatWordMgr.instance:show("当前龙蛋已出生，无法增加心情值噢！")

		return
	end

	if index <= 0 then
		return
	end

	local info
	local nowMs = ServerTime.nowMs()

	for i, v in ipairs(self._info.grassList) do
		local time = checknumber(v.nextCanWeedTime)

		if v.grassId == index and time < nowMs then
			self:_playCutAnim(go, v.grassId)

			break
		end
	end
end

function DragonpoolmainView:_playCutAnim(go, grassId)
	DragonPoolAgent.instance:sendPM_DragonPoolWeedReq(self._activityId, grassId)
end

function DragonpoolmainView:_setEgg()
	if not self._info then
		return
	end

	local currEggCfg = DragonpoolConfig.instance:getEggCfg(self._activityId, self._info.eggId)
	local maxGrowth = DragonpoolConfig.instance:getMaxGrowth(self._activityId, self._info.eggId)
	local nextCfg = DragonpoolConfig.instance:getEggCfg(self._activityId, self._info.eggId + 1)
	local isEgg = maxGrowth > self._info.growth

	goutil.setActive(self._btnAgain.gameObject, nextCfg and not isEgg)
	uGuiUtil.setSpriteToImage(self._dragIcon, nil, isEgg and string.format("%s.png", currEggCfg.eggIcon) or string.format("%s.png", currEggCfg.dragonIcon))

	if not isEgg then
		if nextCfg then
			local cfgs = DragonpoolConfig.instance:getEggCfgs(self._activityId)
			local len = #cfgs

			self._txtBtnAgain.text = string.format("还有<color=%s>%s</color>个蛋等待孵化", GameEnum.ColorConst.Red, len - currEggCfg.eggId)
		else
			self._txtBtnAgain.text = ""
		end
	end
end

function DragonpoolmainView:_onDrag(go, eventData)
	if not self._dragGo then
		return
	end

	self._dragGo.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function DragonpoolmainView:_onBeginDrag(go, eventData)
	self._dragGo = goutil.findChild(go, "icon")

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._dragGo.transform, 0, 0)

	self._cacheLocalPos = {
		x,
		y
	}
end

function DragonpoolmainView:_onEndDrag(go, eventData)
	if not self._dragGo then
		return
	end

	Framework.TransformUtil.SetAnchoredPos(self._dragGo.transform, self._cacheLocalPos[1], self._cacheLocalPos[2])

	self._dragGo = nil
end

function DragonpoolmainView:_onClicktouchmask()
	FloatWordMgr.instance:show("抚摸中~")
end

return DragonpoolmainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunLotteryView.lua

module("logic.extensions.funarena.view.FunLotteryView", package.seeall)

local FunLotteryView = class("FunLotteryView", ViewComponent)

function FunLotteryView:ctor()
	FunLotteryView.super.ctor(self)
end

function FunLotteryView:buildUI()
	FunLotteryView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnStart = goutil.findChild(self.mainGO, "btnStart")
	self._mask = goutil.findChild(self.mainGO, "mask")
	self._btnTip = goutil.findChild(self.mainGO, "btnTip")
	self._conRole = goutil.findChild(self.mainGO, "con")
	self._pet = nil
	self._bubble = goutil.findChild(self.mainGO, "bubble")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "bubble/txtDesc")
	self._imgSlogan = goutil.findChild(self.mainGO, "imgSlogan")
	self._txtTop = goutil.findChildTextComponent(self.mainGO, "txtTop")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._iconCost = goutil.findChild(self.mainGO, "txtCost/icon")
	self._txtCost = goutil.findChildTextComponent(self.mainGO, "txtCost")
	self._winEffGo = goutil.findChild(self.mainGO, "winEff")
	self._winEff = nil
	self._effSelect = nil
	self._cellList = self._cellList or {}
end

function FunLotteryView:bindEvents()
	FunLotteryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._mask, self._onClickMask, self)
end

function FunLotteryView:unbindEvents()
	FunLotteryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._mask)
end

function FunLotteryView:destroyUI()
	FunLotteryView.super.destroyUI(self)
end

function FunLotteryView:onEnter()
	FunLotteryView.super.onEnter(self)

	self._activityId = FunArenaModel.instance.activityId
	self._challengeCfg = FunArenaConfig.instance:getChallengeCfgById(self._activityId)
	self._lotteryCfgs = FunArenaConfig.instance:getLotteryCfgsById(self._activityId)

	if self._activityId == 0 or #self._challengeCfg == 0 or #self._lotteryCfgs == 0 then
		self:_onClickBtnClose()

		return
	end

	self._cellList = self._cellList or {}
	self._maxIndex = checknumber(#self._lotteryCfgs)
	self._curIndex = self._curIndex or 1
	self._isDrawing = false
	self._clickMaskNum = self._clickMaskNum or 0

	GlobalDispatcher:addListener(GlobalNotify.FunArenaGetInfo, self._updateUI, self)
	self:_setPlaneUI()
	self:_updateUI()
	self:_updateCell()
end

function FunLotteryView:onExit()
	FunLotteryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunArenaGetInfo, self._updateUI, self)
	GlobalDispatcher:removeListener(FunArenaAgent.PM_BigCastChallengeLotteryReq, self.onMsgHandler, self)
	removetimer(self._updateTimer, self)

	if self._cellList then
		for _, cell in pairs(self._cellList) do
			MaterialMgr.resetAll(cell._icon)

			if cell._bigEff then
				UIEffectManager.instance:stopEffect(cell._bigEff)
			end
		end

		self._cellList = {}
	end

	UIEffectManager.instance:stopEffect(self._effSelect)

	self._effSelect = nil

	UIEffectManager.instance:stopEffect(self._winEff)

	self._winEff = nil

	RoleObjectPool.instance:removeRole(self._pet)
end

function FunLotteryView:_setPlaneUI()
	self:_createCell()
end

function FunLotteryView:_updateUI()
	self._isDrawing = false

	local lotteryCost = self._challengeCfg.lotteryCost
	local lotteryScore = FunArenaModel.instance._infoRes.lotteryScore

	if self._txtCost then
		self._txtCost.text = string.format("<color=%s>%s</color>/%s", (lotteryCost <= lotteryScore or nil) and "#AAFF00", lotteryScore, lotteryCost)
	end

	local lotteryTimes = FunArenaModel.instance._infoRes.lotteryTimes

	if self._txtCount then
		self._txtCount.text = langPara("Fun_LotteryView_Tips_7", lotteryTimes)
	end

	self:_setActivityTime()

	local isHasTitle = not string.nilorempty(self._challengeCfg.lotterTitle)

	GameUtil.SetActive(self._imgSlogan, isHasTitle)

	local tips = self._challengeCfg.down

	if self._txtTop and not string.nilorempty(tips) then
		self._txtTop.text = tips
	end

	local path = "20211217/choujiang/fx_ui_choujiangkuang.prefab"

	local function callBack(target, eff)
		eff:setParent(nil)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
	end

	self._effSelect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, false, nil, callBack, nil)

	local path = "20211217/choujiang/fx_ui_saoguang.prefab"

	local function callBack(target, eff)
		eff:setParent(self._winEffGo.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
	end

	self._winEff = UIEffectManager.instance:playEffect(self, path, self._winEffGo, 0, 0, true, false, nil, callBack, nil)

	if self._iconCost then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/items/%s.png", self._challengeCfg.res)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(self._iconCost, spriteType, spriteName, func)
	end

	local petId = self._challengeCfg.petId

	if self.skinId ~= 0 and self._conRole then
		local scale = self._challengeCfg.petScale
		local x = self._challengeCfg.petPos[1]
		local y = self._challengeCfg.petPos[2]

		self._pet = RoleObjectPool.instance:addRoleToParent(self._pet, petId, self._conRole, scale, nil, true, x, y)
	end
end

function FunLotteryView:_onClickBtnClose()
	if self._isDrawing then
		FloatWordMgr.instance:show(lang("Fun_LotteryView_Tips_1"))

		return
	end

	self:close()
end

function FunLotteryView:_onClickBtnStart()
	if self._isDrawing then
		FloatWordMgr.instance:show(lang("Fun_LotteryView_Tips_1"))

		return
	end

	local lotteryScore = FunArenaModel.instance._infoRes.lotteryScore
	local lotteryCost = checknumber(self._challengeCfg.lotteryCost)

	if lotteryScore < lotteryCost then
		FloatWordMgr.instance:show(lang("winner_challenge_1"))

		return
	end

	self:_startDraw()
end

function FunLotteryView:_onClickBtnTip()
	local key = "winnerrandom"

	TipsFacade.instance:openRulesView(key)
end

function FunLotteryView:_setActivityTime()
	self.openTime, self.endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FunArena, self._activityId)

	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_1"))

		return
	end

	local readyTime = self.openTime - ServerTime.nowServerLook()

	if readyTime >= 0 then
		FloatWordMgr.instance:show(lang("drawequip_open_tips"))

		return
	end

	if leftTime > 0 then
		removetimer(self._updateTimer, self)
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()

		return
	end
end

function FunLotteryView:_updateTimer()
	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime > 0 then
		if self._txtBubble then
			local desc = lang("Fun_LotteryView_Tips_2")
			local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime)
			local str = ""

			if day > 0 then
				str = langPara("Fun_LotteryView_Tips_3", day, hour)
			elseif day <= 0 and hour > 0 then
				str = langPara("Fun_LotteryView_Tips_4", hour, min)
			elseif hour <= 0 and min > 0 then
				str = langPara("Fun_LotteryView_Tips_5", min, sec)
			elseif min <= 0 and sec > 0 then
				str = langPara("Fun_LotteryView_Tips_6", sec)
			end

			self._txtBubble.text = desc .. str
		end
	else
		if self._txtBubble then
			self._txtBubble.text = lang("text_equip_desc_1")
		end

		FloatWordMgr.instance:show(lang("text_equip_desc_1"))
		removetimer(self._updateTimer, self)
	end
end

function FunLotteryView:_createCell()
	for index = 1, self._maxIndex do
		local go = goutil.findChild(self.mainGO, "rewardGroup/cell" .. index)

		if go then
			local cell = {}

			cell._mainGo = go
			cell._icon = goutil.findChild(cell._mainGo, "icon")
			cell._tag = goutil.findChild(cell._mainGo, "tag")
			cell._txtNum = goutil.findChildTextComponent(cell._mainGo, "txtNum")
			cell._soldout = goutil.findChild(cell._mainGo, "soldout")
			cell._effGo = goutil.findChild(self.mainGO, "rewardEffGroup/cell" .. index .. "/eff")
			cell._bgUIChange = cell._mainGo:GetComponent(ComponentType.UIImageSpriteChange)
			cell._index = index
			cell._bigEff = nil

			GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickCell, self, cell))

			self._cellList[index] = cell
		end
	end
end

function FunLotteryView:_updateCell()
	for _, cell in pairs(self._cellList) do
		local data = self:_getCellCfg(cell._index)
		local matStr = data.prize
		local matCfg = MaterialMgr.getMatCfgByStr(matStr)
		local matInfo = string.split(matStr, ":")
		local matType = checknumber(matInfo[1])
		local cfgId = checknumber(matInfo[2])
		local matNum = checknumber(matInfo[#matInfo])

		MaterialMgr.clearIcon(cell._icon)
		MaterialMgr.setIcon(cell._icon, matType, cfgId)

		if cell._txtNum then
			cell._txtNum.text = matNum
		end

		GameUtil.SetActive(cell._soldout, false)
		GameUtil.SetActive(cell._tag, data.prizeType == 1)
		cell._bgUIChange:SetState(data.prizeType or 0)

		local path2 = "20211217/choujiang/fx_ui_dajiangkuang.prefab"

		local function callBack(target, eff)
			eff:setClipping(cell._effGo:GetComponent(goutil.Type_RectTransform))
			eff:setParent(cell._effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		if data.prizeType == 1 and cell._effGo and cell._bigEff == nil then
			cell._bigEff = UIEffectManager.instance:playEffect(self, path2, cell._effGo, 0, 0, true, false, nil, callBack, nil)
		end
	end
end

function FunLotteryView:_getCellCfg(prizeId)
	local cfg = self._lotteryCfgs[prizeId]
	local lotteryTimes = FunArenaModel.instance._infoRes.lotteryTimes
	local res = {}

	for _, data in ipairs(cfg) do
		if lotteryTimes + 1 >= data.startTimes then
			res = data
		else
			break
		end
	end

	return res
end

function FunLotteryView:_onClickCell(cell)
	local data = self:_getCellCfg(cell._index)

	CommonTipsMgr.instance:openTipsByConfStr(cell._mainGo, data.prize)
end

function FunLotteryView:_onClickMask()
	self._clickMaskNum = self._clickMaskNum + 1

	if self._clickMaskNum >= 2 then
		self._clickMaskNum = 0

		GameUtil.SetActive(self._mask, false)
		removetimer(self._updateTime, self)
		self:_endDraw()
	end
end

function FunLotteryView:_startDraw()
	GlobalDispatcher:addListener(FunArenaAgent.PM_BigCastChallengeLotteryReq, self.onMsgHandler, self)
	FunArenaController.instance:onSendLotteryReq(self._activityId)
end

function FunLotteryView:onMsgHandler()
	self._remainTimeEnd = 1.5
	self._remainTimeStart = 0.2
	self._remainTime = self._remainTimeStart
	self._tangent = nil
	self._curIndex = self._curIndex - 1
	self._curStepNum = 0
	self._matchIndex = checknumber(FunArenaModel.instance._lotteryRes.prizeId)

	local k = 3

	self._totalStepNum = self._maxIndex * k + (self._matchIndex - self._curIndex)
	self._tangent = (self._remainTimeEnd - self._remainTimeStart) / self._totalStepNum
	self._curRemainTime = 0
	self._interval = 0.1
	self._isDrawing = true

	GameUtil.SetActive(self._effSelect.effGo, true)
	removetimer(self._updateTime, self)
	settimer(self._interval, self._updateTime, self, true)
	GameUtil.SetActive(self._mask, true)
end

function FunLotteryView:_updateTime()
	self._remainTime = self._remainTime + self._interval

	local remainTime = self._tangent * self._curStepNum + self._remainTimeStart

	if remainTime > self._remainTime then
		return
	end

	self._curStepNum = self._curStepNum + 1
	self._curIndex = self._curIndex + 1

	if self._curIndex <= self._maxIndex then
		self._curIndex = self._curIndex or 1
	end

	if self._effSelect and self._effSelect.effGo then
		local selectEff = self._effSelect
		local selectEffGo = self._cellList[self._curIndex]._effGo

		self:_setEff(selectEff, selectEffGo, selectEffGo, true)
	end

	if self._curStepNum >= self._totalStepNum then
		removetimer(self._updateTime, self)
		removetimer(self._endDraw, self)
		settimer(1, self._endDraw, self, false)

		return
	end
end

function FunLotteryView:_endDraw()
	if self._isDrawing == false then
		return
	end

	self._isDrawing = false
	self._curIndex = self._matchIndex

	local selectEff = self._effSelect
	local selectEffGo = self._cellList[self._curIndex]._effGo

	self:_setEff(selectEff, selectEffGo, selectEffGo, true)
	GameUtil.SetActive(self._mask, false)

	local changeSetId = FunArenaModel.instance._lotteryRes.changeSetId

	MaterialController.instance:showChangeSetInTemp(changeSetId)
	self:_updateCell()
end

function FunLotteryView:_setEff(eff, ClipGo, parent, isVisible)
	if not eff or not ClipGo then
		return
	end

	eff:setClipping(ClipGo:GetComponent(goutil.Type_RectTransform))
	eff:setParent(parent and parent.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1, 1, 1)
	GameUtil.SetActive(eff.effGo, isVisible)
end

return FunLotteryView

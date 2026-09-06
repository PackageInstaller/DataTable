-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodClosetView.lua

module("logic.extensions.femalegod.view.FemaleGodClosetView", package.seeall)

local FemaleGodClosetView = class("FemaleGodClosetView", ViewComponent)

function FemaleGodClosetView:ctor()
	FemaleGodClosetView.super.ctor(self)
end

function FemaleGodClosetView:unbindEvents()
	FemaleGodClosetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnExpend)

	for i = 1, 2 do
		local btnGoto = self:getGo("cell" .. i .. "/btnGoto")

		GameUtil.rmClickHandler(btnGoto)
	end
end

function FemaleGodClosetView:bindEvents()
	FemaleGodClosetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnExpend, self._onClickBtnExpend, self)
end

function FemaleGodClosetView:buildUI()
	FemaleGodClosetView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._rewardTableview = self:getGo("scorollReward/tableview")
	self._scrollRewardList = ScrollerList.create(self._rewardTableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._imgCost = self:getGo("total/imgCost")
	self._txtCurScore = self:getTxt("total/txtCurScore")
	self._btnExpend = self:getGo("btnExpend")
	self._expendBubble = self:getGo("btnExpend/bubble")
	self._txtExpendNum = self:getTxt("btnExpend/txtNum")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._imgCanExpend = self:getGo("btnExpend/imgCanExpend")
	self._rotateRate = 2
	self._animRoot = self:getGo("btnExpend/animRoot")
	self._root = self:getGo("btnExpend/root")
end

function FemaleGodClosetView:onExit()
	FemaleGodClosetView.super.onExit(self)
	self._scrollRewardList:dispose()
	MaterialMgr.clearIcon(self._imgCost)
	self._rotateSequence:Kill(true)

	self._rotateSequence = nil
	self._eff = nil

	self:_clearSpine(self._animRoot)
end

function FemaleGodClosetView:onEnter()
	FemaleGodClosetView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_InflationMoneyGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_InflationMoneyGainProgressPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actCfg = FemaleGodConfig.instance:getActivityCfg(self._activityId)
	self._progressCfg = FemaleGodConfig.instance:getProgressCfg(self._activityId)
	self._closetCfg = FemaleGodConfig.instance:getClosetCfg(self._activityId)
	self._info = FemaleGodModel.instance:getInfo(self._activityId)
	self._curCanExpendId = 0

	self:_onSetUI()
	self:_loadSpine(self._animRoot, "character/99987_nvshenpzj/99987_nvshenpzj-ui_p.prefab", {
		-5,
		-35,
		1
	})
	FemaleGodController.instance:sendPM_InflationMoneyGetInfoReq(self._activityId)
end

function FemaleGodClosetView:_onSetUI()
	self:_onUpdate()

	self._txtTime.text = self:_getLeftTime()

	MaterialMgr.setIcon(self._imgCost, 204, 2, nil, nil)

	if self._rotateSequence then
		self._rotateSequence:Kill(true)

		self._rotateSequence = nil
	end

	GameUtil.setLocalRotation(self._imgCanExpend, 0, 0, 0)

	self._rotateSequence = DG.Tweening.DOTween.Sequence()

	local rotateTween = self._imgCanExpend.transform:DORotate(Vector3.New(0, 0, 360), self._rotateRate, DG.Tweening.RotateMode.FastBeyond360):SetEase(DG.Tweening.Ease.Linear)

	self._rotateSequence:Append(rotateTween)
	self._rotateSequence:SetLoops(-1)
end

function FemaleGodClosetView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function FemaleGodClosetView:_updateData()
	self._info = FemaleGodModel.instance:getInfo(self._activityId)
end

function FemaleGodClosetView:_updateUI()
	local newCanGetId = FemaleGodController.instance:getNewCanExpendIdx(self._activityId, self._info.progress, self._info.gainedPrizeId)
	local arr = string.split(self._actCfg.inflationMoneyMaterialKey, ":")
	local expendNum = MaterialModel.instance:getMaterialsNumber(arr[1], arr[2])

	self._txtExpendNum.text = "当前持有膨胀金\n" .. "<color=#eb4642>" .. expendNum .. "</color>"

	GameUtil.SetActive(self._imgCanExpend, newCanGetId ~= nil)
	GameUtil.SetActive(self._expendBubble, newCanGetId ~= nil)

	for i = 1, 2 do
		local btnGoto = self:getGo("cell" .. i .. "/btnGoto")
		local imgPet = self:getGo("cell" .. i .. "/imgPet/img")
		local txtTitle = self:getTxt("cell" .. i .. "/txtTitle")
		local txtDesc = self:getTxt("cell" .. i .. "/desc/txtDesc")

		txtTitle.text = self._closetCfg[i].title
		txtDesc.text = self._closetCfg[i].desc

		local modelCo = CharacterConfig.instance:getModelCo(self._closetCfg[i].skinId)

		uGuiUtil.setSpriteToImage(imgPet, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		GameUtil.rmClickHandler(btnGoto)
		GameUtil.addClickHandler(btnGoto, function()
			local btnStr = self._closetCfg[i].jumpStr

			GotoMgr.gotoByString(btnStr)
			self:close()
		end, self)
	end

	local index = 0
	local scoreList = {}

	for i, v in ipairs(self._progressCfg) do
		table.insert(scoreList, v.progress)

		local hasGeted = i <= checknumber(#self._info.gainedPrizeId)

		if hasGeted then
			index = i
		end
	end

	self._scrollRewardList:updateUnderSlider(self._progressSlider, checknumber(self._info.progress), scoreList)
	self._scrollRewardList:reloadData(self._progressCfg)
	self._scrollRewardList:MoveCellToCenter(index)

	local curScore = self._info.progress
	local nextScore = self:_getNextScore()

	if nextScore == nil then
		GameUtil.SetActive(self._txtCurScore.gameObject, false)
	else
		self._txtCurScore.text = "<color=#EB4642>(" .. curScore .. "</color>/" .. nextScore .. ")"
	end
end

function FemaleGodClosetView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function FemaleGodClosetView:_updateCell(view, cell, data)
	local btnGoto = goutil.findChild(cell, "btnGoto")
	local imgPet = goutil.findChild(cell, "imgPet")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "desc/txtDesc")
	local idx = data.id

	txtTitle.text = self._closetCfg[idx].title
	txtDesc.text = self._closetCfg[idx].desc

	local modelCo = CharacterConfig.instance:getModelCo(data.skinId)

	uGuiUtil.setSpriteToImage(imgPet, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.addClickHandler(btnGoto, function()
		local btnStr = self._actCfg.jumpStr

		GotoMgr.gotoByString(btnStr)
	end, self)
end

function FemaleGodClosetView:_clearCell(cell)
	local imgPet = goutil.findChild(cell, "imgPet")
	local btnGoto = goutil.findChild(cell, "btnGoto")

	uGuiUtil.clearImage(imgPet)
	GameUtil.rmClickHandler(btnGoto)
end

function FemaleGodClosetView:_updateRewardCell(view, cell, data)
	local imgPet = goutil.findChild(cell, "imgPet")
	local desc = goutil.findChild(cell, "desc")
	local txtProgress = goutil.findChildTextComponent(cell, "txtProgress")
	local txtDesc1 = goutil.findChildTextComponent(cell, "desc/txt1")
	local txtDesc2 = goutil.findChildTextComponent(cell, "desc/txt2")
	local txtDesc3 = goutil.findChildTextComponent(cell, "desc/txt3")
	local idx = data.prizeId
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
	local hasGeted = idx <= checknumber(#self._info.gainedPrizeId)
	local canGet = checknumber(self._info.progress) >= data.progress

	txtProgress.text = self._progressCfg[idx].progress

	if canGet then
		if hasGeted then
			txtDesc1.text = "已膨胀\n" .. matNum .. "神钻"

			GameUtil.SetActive(txtDesc1.gameObject, true)
			GameUtil.SetActive(txtDesc2.gameObject, false)
			GameUtil.SetActive(txtDesc3.gameObject, false)
		else
			txtDesc2.text = "可膨胀\n" .. matNum .. "神钻"

			GameUtil.SetActive(txtDesc1.gameObject, false)
			GameUtil.SetActive(txtDesc2.gameObject, true)
			GameUtil.SetActive(txtDesc3.gameObject, false)
		end
	else
		txtDesc3.text = "可膨胀\n" .. matNum .. "神钻"

		GameUtil.SetActive(txtDesc1.gameObject, false)
		GameUtil.SetActive(txtDesc2.gameObject, false)
		GameUtil.SetActive(txtDesc3.gameObject, true)
	end
end

function FemaleGodClosetView:_clearRewardCell(cell)
	return
end

function FemaleGodClosetView:_getLeftTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(452, self._activityId)
	local leftTimeStamp = etime - ServerTime.now()

	if leftTimeStamp >= 86400 then
		return GameUtil.formatTimeStamp("%d天%H小时%M分钟", leftTimeStamp)
	else
		return GameUtil.formatTimeStamp("%H小时%M分钟", leftTimeStamp)
	end
end

function FemaleGodClosetView:_getNextScore()
	for i, data in ipairs(self._progressCfg) do
		local canGet = checknumber(self._info.progress) >= data.progress

		if canGet then
			self._curCanExpendId = data.prizeId
		end
	end

	local cfg = self._progressCfg

	if self._curCanExpendId < #cfg then
		return cfg[self._curCanExpendId + 1].progress
	end
end

function FemaleGodClosetView:_onClickBtnExpend()
	local newCanGetId = FemaleGodController.instance:getNewCanExpendIdx(self._activityId, self._info.progress, self._info.gainedPrizeId)

	if newCanGetId ~= nil then
		GameUtil.SetActive(self._animRoot, true)
		GameUtil.SetActive(self._root, false)
		ViewBlockMgr.instance:blockClick(true, self)

		local function callBack()
			FemaleGodController.instance:sendPM_InflationMoneyGainProgressPrizeReq(self._activityId, newCanGetId)
			GameUtil.SetActive(self._animRoot, false)
			GameUtil.SetActive(self._root, true)
			ViewBlockMgr.instance:blockClick(false, self)
		end

		self._spineCtrlPool[self._animRoot]:_playAnim("baojinbi", false, callBack)
	else
		local isAllGet = #self._info.gainedPrizeId >= #self._progressCfg

		if isAllGet then
			FloatWordMgr.instance:show("膨胀金已全部领取")
		else
			FloatWordMgr.instance:show("尚未达到领取条件")
		end
	end
end

function FemaleGodClosetView:_loadSpine(mainGo, spinePath, pos)
	if self._spineCtrlPool == nil then
		self._spineCtrlPool = {}
	end

	if not self._spineCtrlPool[mainGo] then
		local ctrl = FemaleGodSpineCtrl.New()

		self._spineCtrlPool[mainGo] = ctrl

		ctrl:onInit(mainGo, self._view, spinePath)

		pos = pos or {}

		if not pos[3] then
			local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

			if not pos[4] then
				local scaleX = scale

				GameUtil.setLocalPos(mainGo, x, y)
				GameUtil.setLocalScale(mainGo, scaleX, scale, scale)
			end
		end
	end
end

function FemaleGodClosetView:_clearSpine(mainGo)
	if self._spineCtrlPool then
		local ctrl = self._spineCtrlPool[mainGo]

		if ctrl then
			ctrl:onClear()
		end
	end
end

return FemaleGodClosetView

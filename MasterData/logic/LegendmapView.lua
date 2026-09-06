-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendmapView.lua

module("logic.extensions.legend.view.LegendmapView", package.seeall)

local LegendmapView = class("LegendmapView", ViewComponent)
local State = {
	narrow = 2,
	enlarge = 1
}
local Block = {
	"Grass",
	"Water",
	"Fire",
	"Light",
	"Dark",
	"Origin"
}

function LegendmapView:ctor()
	LegendmapView.super.ctor(self)
end

function LegendmapView:buildUI()
	LegendmapView.super.buildUI(self)

	local scrollviewPath = "scrollview/Viewport/Content/"

	self._viewportTrans = self:getGo("scrollview/Viewport"):GetComponent("RectTransform")
	self._contentTrans = self:getGo("scrollview/Viewport/Content"):GetComponent("RectTransform")
	self._scrollView = self:getGo("scrollview"):GetComponent("ScrollRect")
	self._content = self:getGo("scrollview/Viewport/Content")
	self.btnClose = self:getBtn("main/leftTop/btnClose")
	self._container = self:getGo(scrollviewPath .. "container")
	self._cell = self:getGo("petCell")
	self._btnFindPet = self:getBtn("btnFindPet")
	self.btnReturn = self:getGo("main/btnReturn")

	GameUtil.SetActive(self._cell, false)

	self._blockList = {}

	for i = 1, 6 do
		local obj = {}
		local go = self:getGo(scrollviewPath .. "container/" .. Block[i])

		obj.go = go
		obj.pos = self:getGo(scrollviewPath .. "container/" .. Block[i] .. "Pos")
		obj.btn = self:getBtn(scrollviewPath .. "container/btn_" .. i)
		obj.lock = goutil.findChild(go, "lock")
		obj.txtUnLock = goutil.findChildTextComponent(go, "lock/txtUnLock")

		table.insert(self._blockList, obj)
	end

	self._cellList = {}
	self._bg = self:getBtn(scrollviewPath .. "container/bg")
	self._findView = self:getGo("findViewContainer")
	self._customInput = UICustomInput.Get(self._findView)
	self._arrow = self:getGo("btnFindPet/arrow")
	self._zoomPara = 2

	local var_2_0 = {
		z = 0,
		x = 0
	}

	var_2_0.y = -0
	self._originPos = var_2_0
	self._bgEffect = self:getGo(scrollviewPath .. "effect")
	self._btnTip = self:getBtn("main/leftTop/btnTip")
	self._btnDivineEvolve = self:getBtn("btnDivineevolve")
	self._btnSwitch = self:getBtn("main/btnSwitch")
	self._bgChangeTitle = self:getGo("main/title/bgChange"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtTitle = self:getTxt("main/title/txt")
	self._txtTitleChange = self:getGo("main/title/txt"):GetComponent(ComponentType.UITextColorChange)
	self._lockSwitch = self:getGo("main/btnSwitch/lock")
	self._rdSwitch = self:getGo("main/btnSwitch/rd")
end

function LegendmapView:bindEvents()
	LegendmapView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
	self._bg:AddClickListener(self._onClickBg, self)
	GameUtil.addClickHandler(self.btnReturn, self._onClickBg, self)
	self._btnFindPet:AddClickListener(self._onClickFind, self)
	self._customInput:AddListener(self._onCloseCVviewCallback, self)

	for i = 1, 6 do
		self._blockList[i].btn:AddClickListener(function()
			self:_moveToBlock(i)
		end, self)
	end

	self._btnTip:AddClickListener(function()
		UIStateManager.instance:open(ViewName.RulesView, "tlchallenge")
	end)
	self._btnDivineEvolve:AddClickListener(self._onClickDivine, self)
	self._btnSwitch:AddClickListener(self._onClickSwitch, self)
end

function LegendmapView:unbindEvents()
	LegendmapView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self._bg:RemoveClickListener()
	self._btnFindPet:RemoveClickListener()

	for i = 1, 6 do
		self._blockList[i].btn:RemoveClickListener()
	end

	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self.btnReturn)
	self._btnTip:RemoveClickListener()
	self._btnDivineEvolve:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
end

function LegendmapView:destroyUI()
	LegendmapView.super.destroyUI(self)
end

function LegendmapView:onEnter()
	LegendmapView.super.onEnter(self)
	self:_initBlockBtnClickState()

	self._state = State.narrow
	self._scrollView.enabled = false

	GameUtil.SetActive(self.btnReturn, self._state == State.enlarge)
	LegendController.instance:sendLegendChallengeTimesInfoReqAll()

	local rate = 1
	local dx = 0
	local d = UnityEngine.Screen.width / UnityEngine.Screen.height

	if d > 2.23 then
		dx = -160
	end

	rate = d < 1.7777777778 and 1280 / UnityEngine.Screen.width or 720 / UnityEngine.Screen.height

	local r1 = 1.7777777777777777
	local r2 = UnityEngine.Screen.width / UnityEngine.Screen.height
	local r3 = r2 / r1
	local sizeX = 1280

	if r2 - r1 > 0.01 then
		sizeX = 1280 * r3
	end

	self._viewportTrans.sizeDelta = Vector2.New(sizeX, 720)
	self._contentTrans.sizeDelta = Vector2.New(sizeX, 720)

	self:_refresh()
	self:_moveToBlock(self:_getFirstLocatePos(), true)
	self:_onSwitchMap()
	self.addGEvent(self, GlobalNotify.LegendSwitchMap, self._onSwitchMap, self)
end

function LegendmapView:onEnterFinished()
	LegendmapView.super.onEnterFinished(self)
end

function LegendmapView:onExit()
	LegendmapView.super.onExit(self)

	for k, v in ipairs(self._cellList) do
		goutil.destroy(v.cell)
	end

	table.clear(self._cellList)
end

function LegendmapView:onExitFinished()
	LegendmapView.super.onExitFinished(self)
end

function LegendmapView:_onClickDivine()
	UIStateManager.instance:push(ViewName.DivineEvolveEnterView)
end

function LegendmapView:_refresh()
	return
end

function LegendmapView:_tweenScale(from, to, pos, callBack)
	local scale = GameUtil.getLocalScale(self._content)

	if math.abs(to - scale.x) < 1e-05 then
		GameUtil.callBack(callBack)

		return
	end

	if self.tweenSc then
		self.tweenSc:Kill(false)

		self.tweenSc = nil
	end

	GameUtil.setLocalScale(self._content, from, from, from)

	for k, v in ipairs(self._cellList) do
		local cell = v.cell
		local data = v.data

		if self._state == State.enlarge then
			if not data.bottomScale then
				local scalePara = data.topScale

				GameUtil.setLocalScale(cell, scalePara, scalePara, scalePara)
			end
		end
	end

	local width = self._contentTrans.sizeDelta.x
	local height = self._contentTrans.sizeDelta.y
	local parm = DG.Tweening.Ease.Linear
	local ttt = 0.2

	if from < to then
		ttt = 0.3
		parm = DG.Tweening.Ease.OutBack
	else
		self:_refresh()
	end

	self._scrollView.enabled = false
	self.tweenSc = TweenUtil.ValueTo(from, to, ttt, function(val)
		GameUtil.setLocalScale(self._content, val, val, val)

		if pos then
			self._scrollView.verticalNormalizedPosition = (pos.y + height * 0.5) / height
			self._scrollView.horizontalNormalizedPosition = (pos.x + width * 0.5) / width
		else
			self._scrollView.verticalNormalizedPosition = 0.5
			self._scrollView.horizontalNormalizedPosition = 0.5
		end

		for i, v in ipairs(self._blockList) do
			local go = v.go

			GameUtil.setLocalScale(go, 1 / val, 1 / val, 1 / val)
		end
	end, function()
		if self._state == State.narrow then
			-- block empty
		end

		self._scrollView.enabled = true

		GameUtil.callBack(callBack)

		self.tweenSc = nil

		self:_refresh()
		GameUtil.SetActive(self.btnReturn, self._state == State.enlarge)
	end, self, parm)
end

function LegendmapView:moveToWithOutTween(val, pos)
	if self.tweenSc then
		self.tweenSc:Kill(false)

		self.tweenSc = nil
	end

	for k, v in ipairs(self._cellList) do
		local cell = v.cell
		local data = v.data

		if self._state == State.enlarge then
			if not data.bottomScale then
				local scalePara = data.topScale

				GameUtil.setLocalScale(cell, scalePara, scalePara, scalePara)
			end
		end
	end

	local width = self._contentTrans.sizeDelta.x
	local height = self._contentTrans.sizeDelta.y

	GameUtil.setLocalScale(self._content, val, val, val)

	if pos then
		self._scrollView.verticalNormalizedPosition = (pos.y + height * 0.5) / height
		self._scrollView.horizontalNormalizedPosition = (pos.x + width * 0.5) / width
	else
		self._scrollView.verticalNormalizedPosition = 0.5
		self._scrollView.horizontalNormalizedPosition = 0.5
	end

	for i, v in ipairs(self._blockList) do
		local go = v.go

		GameUtil.setLocalScale(go, 1 / val, 1 / val, 1 / val)
	end

	if self._state == State.narrow then
		-- block empty
	end

	self._scrollView.enabled = true

	GameUtil.callBack(callBack)

	self.tweenSc = nil

	self:_refresh()
	GameUtil.SetActive(self.btnReturn, self._state == State.enlarge)
end

function LegendmapView:_onClickCell(cell, data)
	local isUnlock = UnlockModel.instance:isFunctionUnlock(data.challengeId)

	if not isUnlock then
		return
	end

	local name = LegendConst.isNewOpen .. data.challengeId

	GameUtil.saveUserData(name, LegendConst.isNewOpenParam)

	local challengeCfg = LegendConfig.instance:getLegendChallengeCfg(data.challengeId)

	GotoMgr.gotoByString(challengeCfg.jumpTo)
end

function LegendmapView:_moveToBlock(blockId, notTween)
	local obj = self._blockList[blockId]

	if obj.isLock then
		FloatWordMgr.instance:show(obj.lockTip)
	elseif self.tweenSc == nil then
		if self._state ~= State.enlarge then
			self._state = State.enlarge

			local pos = GameUtil.getLocalPos(obj.pos)

			if notTween then
				self:moveToWithOutTween(self._zoomPara, pos)
			else
				self:_tweenScale(1, self._zoomPara, pos)
			end

			LegendModel.instance:setMapState(State.enlarge)
			LegendModel.instance:setBlockId(blockId)
			GlobalDispatcher:dispatch(GlobalNotify.LegendMapZoom)
		else
			self:_onClickBg()
		end
	end
end

function LegendmapView:_onClickBg()
	if self.tweenSc == nil and self._state ~= State.narrow then
		self._state = State.narrow

		self:_tweenScale(self._zoomPara, 1)
		LegendModel.instance:setMapState(State.narrow)
		GlobalDispatcher:dispatch(GlobalNotify.LegendMapZoom)
	end
end

function LegendmapView:_setCell(cell, data)
	local imgTitle = goutil.findChildComponent(cell, "needToRotate/icon", "UIImageSpriteChange")
	local rareTitle = goutil.findChild(cell, "rare")
	local avatar = goutil.findChild(cell, "needToRotate/mask/imgIcon")
	local needToRotate = goutil.findChild(cell, "needToRotate")
	local txtPower = goutil.findChildTextComponent(cell, "power/txtPower")

	txtPower.text = data.zdl

	local isUnlock = UnlockModel.instance:isFunctionUnlock(data.challengeId)
	local isShow = isUnlock and (not data.hide or self._state ~= State.narrow) and not self._blockList[data.blockId].isLock

	GameUtil.SetActive(cell, isShow)
	GameUtil.setLocalPos(cell.gameObject.transform, data.position[1], data.position[2] - 80, 0)

	local raceId = data.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local rare = petCo.rare

	imgTitle:SetState(rare - 1)

	local proxy = MaterialMgr.setCell(MatType.Rare, raceId, rareTitle)
	local direction = data.direction and -1 or 1

	if self._state == State.enlarge then
		if not data.bottomScale then
			local scalePara = data.topScale

			GameUtil.setLocalScale(needToRotate, direction, 1, 1)
			GameUtil.setLocalScale(cell, scalePara, scalePara, scalePara)

			local modelCo = CharacterConfig.instance:getModelCo(raceId)

			uGuiUtil.setSpriteToImage(avatar.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, cell, data))
		end
	end
end

function LegendmapView:_onCloseCVviewCallback(hover)
	return
end

function LegendmapView:_onClickFind()
	self:showTabAt(self._findView, ViewName.LegendmapchallengeView)
	GameUtil.setLocalScale(self._arrow, -1, 1, 1)
end

function LegendmapView:_resetPosition()
	GameUtil.setLocalPos(self._content, 0, 0, 0)
end

function LegendmapView:_loadBgEffect(scale)
	return
end

function LegendmapView:_initBlockBtnClickState()
	for i = 1, 6 do
		local cfg = LegendConfig.instance:getBlockCfgById(i)

		goutil.setActive(self._blockList[i].btn.gameObject, cfg and cfg.isPermitBigger)
	end
end

function LegendmapView:_getFirstLocatePos()
	local resultAreaId = 6
	local dealType = LegendController.instance:getCurMapDealType()

	if dealType == LegendController.MapDealType.Original then
		local cfgs = LegendConfig.instance:getLegendChallengeCfgs()

		for i, v in ipairs(cfgs) do
			if self:_isFuncUnlock(v.unlockId) and not LegendModel.instance:isChallengePass(v.challengeId) then
				resultAreaId = v.areaId

				break
			end
		end
	else
		local curMapId = LegendController.instance:getCurLegendMapId()
		local cfgs = LegendConfig.instance:getMapDetailCfg(curMapId)

		for i, v in ipairs(cfgs) do
			if self:_isFuncUnlock(v.unlockId) and not BagModel.instance:isExistRaceId(v.raceId) then
				resultAreaId = v.areaId

				break
			end
		end
	end

	return resultAreaId
end

function LegendmapView:_isFuncUnlock(unlockId)
	if unlockId > 0 then
		return FuncOpenModel.instance:getFuncIsOpen(unlockId)
	else
		return true
	end
end

function LegendmapView:_onClickSwitch()
	local funcId = LegendController.instance:getSwitchOpenFuncId()
	local isLock = not FuncOpenModel.instance:getFuncIsOpen(funcId)

	if isLock then
		local funcOpenCfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		if funcOpenCfg then
			if not funcOpenCfg.description then
				local tips = ""

				FloatWordMgr.instance:show(tips)

				return
			end
		end
	end

	local curMapId = LegendController.instance:getCurLegendMapId()
	local cfgs = LegendConfig.instance:getMapListCfgs()

	curMapId = curMapId + 1

	if curMapId > #cfgs then
		curMapId = 1
	end

	LegendController.instance:setCurLegendMapId(curMapId)
end

function LegendmapView:_onSwitchMap()
	local curMapId = LegendController.instance:getCurLegendMapId()
	local curMapCfg = LegendConfig.instance:getMapListCfg(curMapId)

	self._txtTitle.text = curMapCfg.mapName

	self._bgChangeTitle:SetState(curMapId - 1)
	self._txtTitleChange:SetState(curMapId - 1)

	local funcId = LegendController.instance:getSwitchOpenFuncId()
	local isLock = not FuncOpenModel.instance:getFuncIsOpen(funcId)

	goutil.setActive(self._lockSwitch, isLock)

	local dealType = LegendController.instance:getCurMapDealType()

	if dealType == LegendController.MapDealType.Original then
		goutil.setActive(self._rdSwitch, false)
	else
		goutil.setActive(self._rdSwitch, LegendController.instance:isActiveRedPoint())
	end
end

return LegendmapView

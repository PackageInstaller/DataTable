-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/view/PetTrialView.lua

module("logic.extensions.pettrial.view.PetTrialView", package.seeall)

local PetTrialView = class("PetTrialView", TableViewComponent)

function PetTrialView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PetTrialView:_cellSize(view, index)
	return 250, 100
end

function PetTrialView:ctor()
	PetTrialView.super.ctor(self)
end

function PetTrialView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._tableview:AddOnScrollValueChanged(self._onScrollValueChange, self)
end

function PetTrialView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._tableview:RemoveScrollValueChanged()
end

function PetTrialView:buildUI()
	PetTrialView.super.buildUI(self)
	self:_loadRecords("0:0#-19:163#-4:179#-25.967681741497:-0.16825006025202#-18.810990046448:133.88560447761#-11:99#15:65#-15:5#-14:112#-5:14#-19:114#-80.914263128855:-106.73458176199#-49.230182262998:-37.784755172231#-27.347186833717:63.109430965531#-59.596181677603:-128.42255005462#-23.587265534038:-176.36939443861#-74.639799958466:34.628012988722#-42.334562496509:100.98879132614#-61.861782177575:-75.02909848072#-24.65068803682:-34.906942475965#-59.104255913752:159.10268511766#-65.553372541316:1.6766160931576#-64.144652227068:-142.86976175821#-32.978632050704:-71.836888395352#-15:-108#-11:-2#3:42#-17:54#14:68")
	self:_saveRecords()

	self._closeButton = self:getBtn("lefttop/btnClose")
	self._clipRectTrans = self._tableview:GetComponent("RectTransform")
	self._btnRule = self:getBtn("lefttop/btn_tip")
	self._bg = self:getGo("bg")
end

function PetTrialView:destroyUI()
	return
end

function PetTrialView:onEnter()
	WaitingView.instance:show()
	PetTrialController.instance:getMyKingLoadInfoReq(self._updateView, self)

	local url = string.format("ui/bigbg/pettrial/jlsl_bg0%s.png", 1)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, url, nil, self)

	self._effs = {}
	self._bgEff = UIEffectManager.instance:playEffect(self, "fx_ui_jinglingshilian/fx_ui_jinglingshilian_bg.prefab", nil, nil, nil, true)
end

function PetTrialView:_updateView()
	WaitingView.instance:hide()

	self._curViewDatas = PetTrialConfig.instance:getStateCfgs()

	self:reloadData()
end

function PetTrialView:_onReloadFinish()
	self._isReloadFinish = true

	self._tableview:MoveCellToCebter(PetTrialModel.instance:getCurStage())
	self:_sortCells()
end

function PetTrialView:_onScrollValueChange(vec)
	self:_sortCells()
end

function PetTrialView:_createRandomPos()
	local t = PetTrialConfig.instance:getStateCfgs()

	self._records = {}

	for i = 1, #t do
		local record = {}
		local preRecord = self._records[i - 1]

		if preRecord then
			record.x = math.random(-20, 20)
			record.y = math.random(-200, 200)

			local w = record.x - preRecord.x + self:_cellSize(nil, i - 2)
			local h = record.y - preRecord.y
			local len = math.sqrt(w * w + h * h)
			local ratio = len / 290

			if ratio > 1 then
				record.x = record.x - w * (1 - 1 / ratio)
				record.y = record.y - h * (1 - 1 / ratio)
			end
		else
			record.x = 0
			record.y = 0
		end

		table.insert(self._records, record)
	end
end

function PetTrialView:_saveRecords()
	local str = ""

	for i = 1, #self._records do
		if i > 1 then
			str = str .. "#"
		end

		local record = self._records[i]

		str = str .. string.format("%s:%s", record.x, record.y)
	end

	print("_saveRecords = " .. str)
end

function PetTrialView:_loadRecords(str)
	self._records = {}

	local t = string.split(str, "#")

	for _, v in ipairs(t) do
		local record = {}
		local vec = string.split(v, ":")

		record.x = checknumber(vec[1])
		record.y = checknumber(vec[2])

		table.insert(self._records, record)
	end
end

function PetTrialView:getLocalRotation(idx)
	local len = #self._records
	local idx1 = (idx - 1) % len + 1
	local idx2 = idx % len + 1
	local record1 = self._records[idx1]
	local record2 = self._records[idx2]

	if record1 and record2 then
		local w = record2.x - record1.x + self:_cellSize(nil, idx - 1)
		local h = record2.y - record1.y
		local rad = math.atan(h / w)

		return math.floor(rad * 180 / math.pi)
	end

	return 0
end

function PetTrialView:_sortCells()
	local count = self._tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = self._tableview:GetCellByIndex(i)

		if cell then
			cell.transform:SetSiblingIndex(cell.index + 1)
		end
	end
end

function PetTrialView:_updateCell(view, cell, data)
	local idx = cell.index + 1
	local data = self._curViewDatas[idx]
	local container = goutil.findChild(cell.gameObject, "container")
	local line = goutil.findChild(container, "line")

	goutil.setActive(line, idx ~= #self._curViewDatas)

	local recordIdx = (idx - 1) % #self._records + 1
	local record = self._records[recordIdx]

	Framework.TransformUtil.SetAnchoredPos(container:GetComponent("RectTransform"), record.x, record.y)
	Framework.TransformUtil.SetLocalRotation(line.transform, 0, 0, self:getLocalRotation(idx))

	local imgKuang = goutil.findChildComponent(container, "imgKuang", "Image")
	local imgDi = goutil.findChildComponent(imgKuang.gameObject, "imgDi", "Image")
	local uiChangeGroup = container:GetComponent("UIChangeGroup")
	local txtName = goutil.findChildTextComponent(imgKuang.gameObject, "txtName")
	local mask = goutil.findChild(imgKuang.gameObject, "mask")
	local imgIcon = goutil.findChildComponent(mask, "headIcon", "Image")
	local btn = Framework.ButtonAdapter.Get(container)
	local imgLocked = goutil.findChild(imgKuang.gameObject, "imgLocked")
	local imgFinish = goutil.findChild(imgKuang.gameObject, "imgFinish")
	local star = goutil.findChild(imgKuang.gameObject, "star")
	local effPoint = goutil.findChild(imgKuang.gameObject, "eff")

	txtName.text = data.name

	local showPetIcon = data.raceId > 0

	uiChangeGroup:SetState(showPetIcon and 1 or 0)
	goutil.setActive(mask, showPetIcon)
	imgKuang:SetNativeSize()
	imgDi:SetNativeSize()

	if showPetIcon then
		local modelCo = CharacterConfig.instance:getModelCo(data.raceId)

		uGuiUtil.setSpriteToImage(imgIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	end

	local curStage = PetTrialModel.instance:getCurStage()
	local passed = curStage >= data.stageId

	goutil.setActive(imgFinish, passed)
	goutil.setActive(star, passed)

	local opened = FuncOpenController.instance:getConditionReached(data.openCondition)
	local canFight = data.stageId <= curStage + 1 and opened
	local img = showPetIcon and imgIcon or imgDi
	local val = canFight and 1 or 0.5

	Game.ImageUtil.SetColorRGBA(img, val, val, val, 1)
	goutil.setActive(imgLocked, not canFight)
	btn:AddClickListener(function()
		self:_onClickBtn(data, opened)
	end)

	if self._effs[cell.gameObject] then
		UIEffectManager.instance:stopEffect(self._effs[cell.gameObject])
	end

	if data.stageId == curStage + 1 and opened then
		local eff = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben01.prefab", effPoint, 0, 0, true, false, nil, function(self, uiEffect)
			Framework.TransformUtil.SetLocalPos(uiEffect.effGo.transform, 0, 0, 0)
			uiEffect:setClipping(self._clipRectTrans)
		end, self)

		eff:setParent(effPoint.transform)

		local scale = showPetIcon and 1 or 0.8

		eff:setScale(scale)

		self._effs[cell.gameObject] = eff
	end
end

function PetTrialView:_onClickBtn(data, opened)
	local curStage = PetTrialModel.instance:getCurStage()

	if not opened then
		FloatWordMgr.instance:show(data.lockedTips .. "即可开启")
	elseif curStage < data.stageId - 1 then
		FloatWordMgr.instance:show("请先通关前面的挑战")
	else
		UIStateManager.instance:open(ViewName.PetTrialDetail, data)
	end
end

function PetTrialView:_updateBg()
	self._canvasGroup.alpha = 0

	local curChallengeId = PetTrialwidth / 2 - self:getLevelItemCellPos(curChallengeId)

	self._curIndex = 1

	local url = string.format("ui/bigbg/pettrial/jlsl_bg0%s.png", self._curIndex)

	uGuiUtil.setSpriteToImage(self._bg1.gameObject, uGuiUtil.SpriteType.BigBg, url, self._onResLoaded, self)
end

function PetTrialView:_onResLoaded()
	return
end

function PetTrialView:_onValueChanged(view)
	if not self._isReloadFinish then
		return
	end

	local offset = view:GetOffset()
	local maxOffset = view:GetMaxOffset()
	local progress = Mathf.Clamp(offset / maxOffset, 0, 1)
	local index = Mathf.Clamp(math.ceil(progress * 3), 1, 3)

	if self._curIndex == index then
		return
	end

	self._curIndex = index

	local url = string.format("ui/bigbg/pettrial/jlsl_bg0%s.png", index)

	uGuiUtil.setSpriteToImage(self._bg2.gameObject, uGuiUtil.SpriteType.BigBg, url)

	local bg1 = self._bg1
	local bg2 = self._bg2

	self._bg1 = self._bg2
	self._bg2 = self._bg1

	print("trween bg")
	TweenUtil.ValueTo(0, 1, 0.2, function(val)
		Game.ImageUtil.SetImageAlpha(bg2, val)
	end, nil, self)
	TweenUtil.ValueTo(1, 0, 0.2, function(val)
		Game.ImageUtil.SetImageAlpha(bg1, val)
	end, nil, self)
end

function PetTrialView:onEnterFinished()
	return
end

function PetTrialView:onExit()
	for _, v in pairs(self._effs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effs = nil

	if self._bgEff ~= nil then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end
end

function PetTrialView:onExitFinished()
	return
end

function PetTrialView:_updateSweepTimes()
	self._txtSweepTimes.text = tostring(PetTrialModel.instance:getHasSweepTimes())
end

function PetTrialView:_onClickClose()
	self:close()
end

function PetTrialView:_onClickLevel(id)
	local isOpen, level = PetTrialModel.instance:getIsOpen(id)

	if not isOpen then
		TipsFacade.instance:openLockTips(level, 0, langPara("精灵试炼第%s关", id))
	elseif not PetTrialModel.instance:getIsLighted(id) then
		FloatWordMgr.instance:show("请先通关前面的试炼")
	else
		UIStateManager.instance:open(ViewName.PetTrialDetail, id)
	end
end

function PetTrialView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "kingload")
end

return PetTrialView

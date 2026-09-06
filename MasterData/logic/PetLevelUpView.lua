-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetLevelUpView.lua

module("logic.extensions.bag.view.stack.PetLevelUpView", package.seeall)

local PetLevelUpView = class("PetLevelUpView", ViewComponent)
local json = require("cjson")

function PetLevelUpView:ctor()
	PetLevelUpView.super.ctor(self)

	self._matIds = {
		{
			4,
			2
		},
		{
			4,
			3
		},
		{
			4,
			25
		}
	}
end

function PetLevelUpView:destroyUI()
	PetLevelUpView.super.destroyUI(self)
end

function PetLevelUpView:onExitFinished()
	PetLevelUpView.super.onExitFinished(self)
end

function PetLevelUpView:onEnterFinished()
	PetLevelUpView.super.onEnterFinished(self)
end

function PetLevelUpView:unbindEvents()
	PetLevelUpView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnLvlupOne)
	GameUtil.rmClickHandler(self._btnLvlupMax)
end

function PetLevelUpView:bindEvents()
	PetLevelUpView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self._btnLvlupOne, self._onClickLevelUpOne, self)
	GameUtil.addClickHandler(self._btnLvlupMax, self._onClickLevelUpTalentMax, self)
end

function PetLevelUpView:onExit()
	PetLevelUpView.super.onExit(self)
	self:_clearMaterials()

	self._isPlaying = false
	self._clicking = false
	self._isReqing = false

	removetimer(self._onPlayFinished, self)
	removetimer(self._onClickFinished, self)
	removetimer(self._onLongPressTick, self)
	self:_clearEffects()

	local addExp = self:_getCurAddExp()

	if addExp > 0 then
		self:_reqUpgrade()
	end
end

function PetLevelUpView:buildUI()
	PetLevelUpView.super.buildUI(self)

	self._closeButton = self:getBtn("btn_close")
	self._txtCurLevel = goutil.findChildTextComponent(self.mainGO, "lv/txt_lv")
	self._sliderExp = goutil.findChildComponent(self.mainGO, "lv/bloodbar", "Slider")
	self._txtExpProgress = goutil.findChildTextComponent(self.mainGO, "lv/txt_power")
	self._btnLvlupOne = self:getGo("btnLvlupOne")
	self._btnLvlupMax = self:getGo("btnLvlupMax")

	self:_initMaterials()
end

function PetLevelUpView:_initMaterials()
	local itemGird = self:getGo("ItemGird")

	self._mats = ItemGroup.New(itemGird, nil, function(go, item)
		item.btnClick = Framework.ButtonAdapter.GetFrom(go, "container")
		item.longPressed = item.btnClick:GetComponent("UILongPressed")
		item.icon = goutil.findChild(go, "container/icon")
		item.txtNum = goutil.findChildTextComponent(go, "txt_num")

		item.btnClick:AddClickListener(function()
			self:_onClickMat(item)
		end)

		local matMo = self._matIds[item.index]

		item.txtExp = goutil.findChildTextComponent(go, "txt_exp")
		item.txtExp.text = self:getAddExpPerText(matMo[1], matMo[2])
		item.mainGO.name = "cell_" .. matMo[2]
		item.mask = goutil.findChild(go, "mask")

		goutil.setActive(item.mask, false)
	end)
end

function PetLevelUpView:_onClickMat(item)
	if BagModel.instance:isPowerCrystalFollower(self._mo.petId) then
		FloatWordMgr.instance:show("该精灵进驻在力量之核中，无法升级")

		return
	end

	if self._selectedIndex == nil and self:_updateEatNums(item.index) then
		self:_updateTargetUI()
	end
end

function PetLevelUpView:_onClickLevelUpOne()
	local needExp = self._mo:getNextLvlExp()

	self:_onSelectItemByExp(needExp)
end

function PetLevelUpView:_onClickLevelUpTalentMax()
	local maxTalentLvl = self:getMaxTalentLv()
	local needExp = self:getCurLvNeedExp(maxTalentLvl)
	local curExp = self._mo:getCurExp()
	local leftExp = needExp - curExp

	self:_onSelectItemByExp(leftExp)
end

function PetLevelUpView:_onSelectItemByExp(leftExp)
	for i, matMo in ipairs(self._matIds) do
		local expOneItem = self:getAddExpPer(matMo[1], matMo[2])
		local count = MaterialFacade.instance:getMatNumber(matMo[1], matMo[2])
		local needCount = math.ceil(leftExp / expOneItem)
		local maxSelect = math.min(needCount, count)
		local cell = self._cells[i]

		cell.selectedNum = maxSelect
		leftExp = leftExp - maxSelect * expOneItem

		if leftExp <= 0 then
			break
		end
	end

	self:close()
end

function PetLevelUpView:_onLongPressTick()
	if not self:_updateEatNums(self._selectedIndex) then
		self._selectedIndex = nil

		removetimer(self._onLongPressTick, self)
	else
		self:_updateTargetUI()
	end
end

function PetLevelUpView:_onLongPressed(item, isUp)
	if ViewMgr.instance:isOpen(ViewName.GuideHeadView) or ViewMgr.instance:isOpen(ViewName.tblHightLight) then
		return
	end

	if not isUp then
		self._selectedIndex = item.index

		settimer(0, self._onLongPressTick, self)
	else
		self._selectedIndex = nil

		removetimer(self._onLongPressTick, self)
	end
end

function PetLevelUpView:_updateEatNums(i)
	if self._mo == nil then
		return false
	end

	if BagModel.instance:isPowerCrystalFollower(self._mo.petId) then
		FloatWordMgr.instance:show("该精灵进驻在力量之核中，无法升级")

		return
	end

	local cell = self._cells[i]
	local matMo = self._matIds[i]
	local totalNum = self:_getTotalNum(i)

	if totalNum <= cell.selectedNum then
		MaterialMgr.openGetSource(matMo[1], matMo[2], GameUtil.handler(self.close, self))

		return false
	end

	if self._targetLv == self:getMaxLevel() or self._targetLv == self:getMaxTalentLv() then
		FloatWordMgr.instance:show("精灵已经满级")
		self:close()

		return
	end

	local addExp = self:_getCurAddExp() + self:getAddExpPer(matMo[1], matMo[2])
	local maxLv = math.min(self:getMaxLevel(), self:getMaxTalentLv())
	local leftExp = self:getCurExp() + addExp - self:getCurLvNeedExp(maxLv)

	cell.selectedNum = checknumber(cell.selectedNum) + 1

	if leftExp < 0 then
		self:_updateTargetUI()

		return true
	else
		self:close()
	end
end

function PetLevelUpView:_updateTargetUI(leftExp)
	local addExp = self:_getCurAddExp() - checknumber(leftExp)
	local targetLv, targetExp = self:getCurLvAndExp(self:getCurExp() + addExp)
	local targetNeedExp = self:getCurLvNeedExp(targetLv + 1) - self:getCurLvNeedExp(targetLv)

	self._txtExpProgress.text = targetLv == self:getMaxLevel() and "已满级" or string.format("%s/%s", targetExp, targetNeedExp)
	self._sliderExp.value = targetNeedExp <= 0 and 1 or targetExp / targetNeedExp
	self._txtCurLevel.text = string.format("%s/%s", targetLv, self:getMaxTalentLv())
	self._targetLv = targetLv
	self._targetLeftExp = targetNeedExp - targetExp

	self._mats:updateWithLen(#self._matIds, function(item, index)
		local matMo = self._matIds[index]
		local num = MaterialModel.instance:getMaterialsNumber(matMo[1], matMo[2]) - checknumber(self._cells[index].selectedNum)

		item.txtNum.text = string.format("%s", num)

		goutil.setActive(item.mask, num == 0)
	end)
	self:_refreshBtn()

	if targetLv > self._curShowLv then
		self:_playLvUpEffect()
	end

	self._curShowLv = targetLv
end

function PetLevelUpView:_refreshBtn()
	GameUtil.SetGray(self._btnLvlupMax, true)
	GameUtil.SetGray(self._btnLvlupOne, true)

	for i, matMo in ipairs(self._matIds) do
		local num = MaterialModel.instance:getMaterialsNumber(matMo[1], matMo[2]) - ((self._cells[i] or nil) and checknumber(self._cells[i].selectedNum))

		if num > 0 then
			GameUtil.SetGray(self._btnLvlupMax, false)
			GameUtil.SetGray(self._btnLvlupOne, false)

			break
		end
	end
end

function PetLevelUpView:onEnter()
	PetLevelUpView.super.onEnter(self)
	self:_showMaterials()
	MopupModel.instance:setPetTalentUpCostStr()

	self._mo = BagPetsController.instance:GetCurPetMo()
	self._preMo = self._mo:GetClone()
	self._curShowLv = self._mo.level
	self._targetLv = self._mo.level
	self._cells = {}

	self:_updateUI()
	self:_refreshBtn()
	UIStateManager.instance:popByName(ViewName.PetBondDetailView)
end

function PetLevelUpView:_showMaterials()
	local items = self._mats:getItems()

	for k, item in pairs(items) do
		item.longPressed:AddListener(function(target, isUp)
			self:_onLongPressed(item, isUp)
		end, self)

		local matMo = self._matIds[item.index]

		MaterialMgr.setCell(matMo[1], matMo[2], item.icon)
	end
end

function PetLevelUpView:_clearMaterials()
	local comp = typeof(Framework.ImageBigBG)
	local items = self._mats:getItems()

	for k, item in pairs(items) do
		item.longPressed:RemoveListener()
		MaterialMgr.resetAll(item.icon)
	end
end

function PetLevelUpView:_logIsReqing()
	return
end

function PetLevelUpView:_updateUI()
	self._mats:updateWithLen(#self._matIds, function(item, index)
		local matMo = self._matIds[index]
		local num = MaterialModel.instance:getMaterialsNumber(matMo[1], matMo[2])

		item.txtNum.text = string.format("%s", num)

		goutil.setActive(item.mask, num == 0)
		table.insert(self._cells, {
			selectedNum = 0
		})
	end)

	local curExp = self._mo:getCurExceedExp()
	local needExp = self._mo:getNextLvlExp()

	self._txtExpProgress.text = self._mo:isMaxLv() and "已满级" or string.format("%s/%s", curExp, needExp)
	self._sliderExp.value = needExp <= 0 and 1 or curExp / needExp
	self._targetLeftExp = needExp - curExp
	self._txtCurLevel.text = string.format("%s/%s", self._mo.level, self:getMaxTalentLv())

	if self._mo.level > self._curShowLv then
		self:_playLvUpEffect()
	end

	self._curShowLv = self._mo.level
end

function PetLevelUpView:getMaxTalentLv()
	return CharacterConfig.instance:getMaxLvByTalentLv(self._mo.talentLevel)
end

function PetLevelUpView:getMaxLevel()
	return CharacterConfig.instance:GetMaxLevel(self._mo.raceId)
end

function PetLevelUpView:getAddExpPer(matType, matId)
	local cfg = MaterialConfig.instance:getCfgByMatAndId(matType, matId)

	if cfg ~= nil then
		return checknumber(cfg.content)
	else
		return 0
	end
end

function PetLevelUpView:getAddExpPerText(matType, matId)
	local exp = self:getAddExpPer(matType, matId)
	local w = math.floor(exp / 10000)
	local t = math.floor(exp / 1000)

	return "经验+" .. exp
end

function PetLevelUpView:getCurLvNeedExp(targetLv)
	return CharacterConfig.instance:GetCurLevelExp(self._mo.raceId, targetLv)
end

function PetLevelUpView:getCurLvAndExp(exp)
	return CharacterConfig.instance:GetCurExpLevel(self._mo.raceId, exp)
end

function PetLevelUpView:getCurExp()
	return self._mo:getCurExp()
end

function PetLevelUpView:_getUpNeedExp(level)
	if level >= self:getMaxLevel() then
		return 0
	else
		return self:getCurLvNeedExp(level + 1) - self:getCurLvNeedExp(level)
	end
end

function PetLevelUpView:_getCurAddExp()
	local addExp = 0

	for i = 1, #self._matIds do
		local cell = self._cells[i]
		local mat = self._matIds[i]

		addExp = addExp + checknumber(cell.selectedNum) * self:getAddExpPer(mat[1], mat[2])
	end

	return addExp
end

function PetLevelUpView:_getTotalNum(i)
	local mat = self._matIds[i]

	return (MaterialFacade.instance:getMatNumber(mat[1], mat[2]))
end

function PetLevelUpView:_reqUpgrade()
	local items = {}

	for i = 1, #self._matIds do
		local cell = self._cells[i]
		local mat = self._matIds[i]

		if cell.selectedNum > 0 then
			table.insert(items, {
				id = checknumber(mat[2]),
				num = checknumber(cell.selectedNum)
			})
		end
	end

	MaterialFacade.instance:batchUseItem(MatType.Item, items, GameUtil.jsonToString({
		pi = self._mo.petId
	}), function()
		self:_onUpgradeSuccess()
	end)
end

function PetLevelUpView:_onClickFinished()
	self._clicking = false
end

function PetLevelUpView:_onUpgradeSuccess()
	print("upgrade success")

	if self._mo and self._preMo then
		BagPetsFacade.instance:checkAndOpenPetUp(self._mo, self._preMo)
	end
end

local effPaths = {
	{
		loop = false,
		goPath = "",
		path = "fx_ui_jingyanshengji/fx_ui_jingyan_shengji.prefab"
	}
}

function PetLevelUpView:_onClickClose()
	self:close()
end

function PetLevelUpView:_playLvUpEffect()
	if not self._isPlaying then
		self:_clearEffects()

		self._isPlaying = true

		AudioPlayerEx.instance:playEffect(30213)
		settimer(0.2, self._onPlayFinished, self, false)

		self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)
	end
end

function PetLevelUpView:_onPlayFinished()
	self._isPlaying = false
end

function PetLevelUpView:_clearEffects()
	if self._effs then
		for k, v in pairs(self._effs) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._effs = nil
	end
end

return PetLevelUpView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/usualviews/CostMatAndLvupView.lua

module("logiccommon.common.viewlib.usualviews.CostMatAndLvupView", package.seeall)

local CostMatAndLvupView = class("CostMatAndLvupView", ViewComponent)

function CostMatAndLvupView:ctor()
	CostMatAndLvupView.super.ctor(self)
	self:setMatIds()
end

function CostMatAndLvupView:destroyUI()
	CostMatAndLvupView.super.destroyUI(self)
end

function CostMatAndLvupView:onExitFinished()
	CostMatAndLvupView.super.onExitFinished(self)
end

function CostMatAndLvupView:onEnterFinished()
	CostMatAndLvupView.super.onEnterFinished(self)
end

function CostMatAndLvupView:unbindEvents()
	CostMatAndLvupView.super.unbindEvents(self)
	self._btnOneKey:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
end

function CostMatAndLvupView:bindEvents()
	CostMatAndLvupView.super.bindEvents(self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
end

function CostMatAndLvupView:onExit()
	CostMatAndLvupView.super.onExit(self)
end

function CostMatAndLvupView:buildUI()
	CostMatAndLvupView.super.buildUI(self)
end

function CostMatAndLvupView:buildGridUI()
	self._cells = {}

	local rectGrid = self._grid:GetComponent("RectTransform")
	local cloneGo = goutil.findChild(self._grid, 1)
	local cell
	local sizeDelta = rectGrid.sizeDelta

	rectGrid.sizeDelta = Vector2.New(sizeDelta.x, 110 * #self._matIds)

	for i = 1, #self._matIds do
		local go

		if i == 1 then
			go = cloneGo
		else
			go = goutil.cloneAndSetParent(cloneGo, self._grid.transform, i)

			Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
		end

		cell = {
			mainGO = go,
			pointItem = goutil.findChild(go, "pointItem"),
			btnAdd = Framework.ButtonAdapter.GetFrom(go, "btnAdd"),
			btnSub = Framework.ButtonAdapter.GetFrom(go, "btnSub"),
			sliderProgress = Framework.SliderAdapter.GetFrom(go, "sliderProgress"),
			txtProgress = goutil.findChildTextComponent(go, "txtProgress")
		}

		cell.sliderProgress:AddOnValueChanged(function(val)
			self:_onValueChanged(i, val)
		end)

		cell.addlongPressed = cell.btnAdd:GetComponent("UILongPressed")
		cell.sublongPressed = cell.btnSub:GetComponent("UILongPressed")

		cell.btnAdd:AddClickListener(function()
			self:_updateEatNums(i, true)
		end)
		cell.btnSub:AddClickListener(function()
			self:_updateEatNums(i, false)
		end)

		if cell.addlongPressed ~= nil then
			cell.addlongPressed:AddListener(function(target, isUp)
				self:_onLongPressed(i, true, isUp)
			end, self)
		end

		if cell.sublongPressed ~= nil then
			cell.sublongPressed:AddListener(function(target, isUp)
				self:_onLongPressed(i, false, isUp)
			end, self)
		end

		local matStr = string.format("%s:%s:0", self._matIds[i][1], self._matIds[i][2])

		MaterialMgr.setCellByCfg(matStr, cell.pointItem)
		table.insert(self._cells, cell)
	end
end

function CostMatAndLvupView:_onValueChanged(i, val)
	local totalNum = self:_getTotalNum(i)
	local cell = self._cells[i]

	cell.selectedNum = math.round(val * totalNum)

	if self._isInit then
		do
			local maxEatNum = self:_getMaxEatNum(i)

			cell.selectedNum = math.min(maxEatNum, cell.selectedNum)

			self:_updateTargetLvAndExp()
		end

		local var_15_0

		if totalNum > 0 then
			var_15_0 = cell.selectedNum / totalNum or 0
		end
	end

	cell.sliderProgress:SetValue(var_15_0)

	cell.txtProgress.text = string.format("<color=#0068B7FF>%s</color><size=24>/%s</size>", cell.selectedNum, totalNum)
end

function CostMatAndLvupView:_updateEatNums(i, isAdd)
	if self._targetLv == self:getMaxLevel() and isAdd then
		return false
	else
		local cell = self._cells[i]
		local totalNum = self:_getTotalNum(i)
		local preNum = cell.selectedNum

		if isAdd then
			cell.selectedNum = preNum + 1 or preNum - 1
		end

		cell.selectedNum = math.min(self._cells[i].selectedNum, totalNum)
		cell.selectedNum = math.max(self._cells[i].selectedNum, 0)

		if cell.selectedNum ~= preNum then
			cell.sliderProgress:SetValue((totalNum > 0 or nil) and (cell.selectedNum / totalNum or 0))
		end

		return cell.selectedNum ~= preNum
	end
end

function CostMatAndLvupView:_onLongPressed(i, isAdd, isUp)
	if not isUp then
		self._index = i
		self._isAdd = isAdd

		settimer(0, self._onLongPressTick, self)
	else
		self._index = nil
		self._isAdd = nil

		removetimer(self._onLongPressTick, self)
	end
end

function CostMatAndLvupView:_onLongPressTick()
	print("long press ticking")

	local isSuccess = self:_updateEatNums(self._index, self._isAdd)

	if not isSuccess then
		removetimer(self._onLongPressTick, self)
	end
end

function CostMatAndLvupView:_initUI()
	self._isInit = false

	for i = 1, #self._cells do
		self:_onValueChanged(i, 0)
	end

	self._isInit = true

	local maxLv = self:getMaxLevel()
	local curLv, curExp = self:getCurLvAndExp(self:getCurExp())

	self._txtCurLevel.text = string.format("Lv.%s/%s", curLv, maxLv)

	local needExp = self:_getUpNeedExp(curLv)

	goutil.setActive(self._txtTargetLevel.gameObject, false)

	self._txtExpProgress.text = curLv >= self:getMaxLevel() and "MAX" or string.format("%s/%s", curExp, needExp)

	if needExp > 0 then
		self._sliderExp.value = curExp / needExp or 1
	end

	self._sliderAdd.value = 0

	self:onValueChange(curLv, addExp)

	self._targetLv = curLv
end

function CostMatAndLvupView:setEnable(enable)
	for i = 1, #self._matIds do
		local cell = self._cells[i]

		if not enable then
			cell.btnAdd:RemoveClickListener()
			cell.btnSub:RemoveClickListener()
			cell.sliderProgress:RemoveOnValueChanged()
		else
			cell.sliderProgress:AddOnValueChanged(function(val)
				self:_onValueChanged(i, val)
			end)
			cell.btnAdd:AddClickListener(function()
				self:_updateEatNums(i, true)
			end)
			cell.btnSub:AddClickListener(function()
				self:_updateEatNums(i, false)
			end)
		end
	end
end

function CostMatAndLvupView:_getTotalNum(i)
	local mat = self._matIds[i]

	return (MaterialFacade.instance:getMatNumber(mat[1], mat[2]))
end

function CostMatAndLvupView:_getMaxEatNum(i)
	local addExp = 0
	local maxLv = self:getMaxLevel()

	for idx = 1, #self._matIds do
		if idx ~= i then
			local cell = self._cells[idx]
			local mat = self._matIds[idx]

			addExp = addExp + cell.selectedNum * self:getAddExpPer(mat[1], mat[2])
		end
	end

	local addExpPer = self:getAddExpPer(self._matIds[i][1], self._matIds[i][2])
	local totalNum = self:_getTotalNum(i)

	if addExpPer > 0 then
		local leftExp = self:getCurLvNeedExp(maxLv) - (self:getCurExp() + addExp)

		leftExp = math.max(0, leftExp)

		return math.min(totalNum, math.ceil(leftExp / addExpPer))
	else
		return totalNum
	end
end

function CostMatAndLvupView:_getCurAddExp()
	local addExp = 0

	for i = 1, #self._matIds do
		local cell = self._cells[i]
		local mat = self._matIds[i]

		addExp = addExp + cell.selectedNum * self:getAddExpPer(mat[1], mat[2])
	end

	return addExp
end

function CostMatAndLvupView:getSelectedNums()
	local t = {}

	for i = 1, #self._matIds do
		local cell = self._cells[i]
		local mat = self._matIds[i]

		if cell.selectedNum > 0 then
			table.insert(t, {
				mat[2],
				cell.selectedNum
			})
		end
	end

	return t
end

function CostMatAndLvupView:_updateTargetLvAndExp()
	local addExp = self:_getCurAddExp()
	local targetLv, targetExp = self:getCurLvAndExp(self:getCurExp() + addExp)
	local maxLv = self:getMaxLevel()
	local curLv, curExp = self:getCurLvAndExp(self:getCurExp())
	local needExp = self:_getUpNeedExp(curLv)

	goutil.setActive(self._txtTargetLevel.gameObject, curLv < targetLv)

	self._txtTargetLevel.text = string.format("Lv.%s", targetLv)

	if targetLv == maxLv then
		self._sliderAdd.value = 1
		self._txtExpProgress.text = "MAX"

		if needExp > 0 then
			self._sliderExp.value = curExp / needExp or 1
		end
	elseif curLv < targetLv then
		local targetNeedExp = self:getCurLvNeedExp(targetLv + 1) - self:getCurLvNeedExp(targetLv)

		self._txtExpProgress.text = string.format("%s/%s", targetExp, targetNeedExp)

		if targetNeedExp > 0 then
			self._sliderAdd.value = targetExp / targetNeedExp or 1
		end

		self._sliderExp.value = 0
	else
		if needExp > 0 then
			self._sliderExp.value = curExp / needExp or 1
		end

		self._txtExpProgress.text = string.format("%s/%s", targetExp, needExp)

		if needExp > 0 then
			self._sliderAdd.value = (curExp + addExp) / needExp or 1
		end
	end

	self._targetLv = targetLv

	self:onValueChange(targetLv, addExp)
end

function CostMatAndLvupView:_onClickOneKey()
	local maxLv = self:getMaxLevel()
	local leftExp = self:getCurLvNeedExp(maxLv) - self:getCurExp()
	local totalExp = {}

	for i = 1, #self._matIds do
		totalExp[i] = i == 1 and 0 or totalExp[i - 1]

		local totalNum = self:_getTotalNum(i)
		local mat = self._matIds[i]

		totalExp[i] = totalExp[i] + totalNum * self:getAddExpPer(mat[1], mat[2])
	end

	for i = #self._matIds, 1, -1 do
		local totalNum = self:_getTotalNum(i)
		local mat = self._matIds[i]
		local addExpPer = self:getAddExpPer(mat[1], mat[2])
		local cell = self._cells[i]
		local costNum = 0

		if leftExp <= 0 then
			costNum = 0
		elseif leftExp < addExpPer * totalNum then
			costNum = math.floor(leftExp / addExpPer)

			if i == 1 or leftExp - costNum * addExpPer > totalExp[i - 1] then
				costNum = costNum + 1
			end
		else
			costNum = totalNum
		end

		leftExp = leftExp - costNum * addExpPer

		cell.sliderProgress:SetValue((totalNum > 0 or nil) and (costNum / totalNum or 0))
	end
end

function CostMatAndLvupView:_onClickUpgrade()
	print("click upgrade")
end

function CostMatAndLvupView:setMatIds()
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
		},
		{
			4,
			24
		}
	}
end

function CostMatAndLvupView:getMaxLevel()
	return 50
end

function CostMatAndLvupView:getAddExpPer(matType, matId)
	return 10
end

function CostMatAndLvupView:getCurLvNeedExp(targetLv)
	return 100
end

function CostMatAndLvupView:getCurLvAndExp(exp)
	return 10, 10
end

function CostMatAndLvupView:_getUpNeedExp(level)
	if level >= self:getMaxLevel() then
		return 0
	else
		return self:getCurLvNeedExp(level + 1) - self:getCurLvNeedExp(level)
	end
end

function CostMatAndLvupView:getCurExp()
	return
end

function CostMatAndLvupView:onValueChange(targetLv, addExp)
	return
end

function CostMatAndLvupView:onEnter()
	CostMatAndLvupView.super.onEnter(self)
end

function CostMatAndLvupView:_onClickUpgrade()
	print("click upgrade")
end

return CostMatAndLvupView

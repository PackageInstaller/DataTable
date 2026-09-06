-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/view/ParallelkingdragonresultView.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonresultView", package.seeall)

local ParallelkingdragonresultView = class("ParallelkingdragonresultView", ViewComponent)

function ParallelkingdragonresultView:ctor()
	ParallelkingdragonresultView.super.ctor(self)
end

function ParallelkingdragonresultView:unbindEvents()
	ParallelkingdragonresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function ParallelkingdragonresultView:bindEvents()
	ParallelkingdragonresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function ParallelkingdragonresultView:buildUI()
	ParallelkingdragonresultView.super.buildUI(self)

	self._txtKill = self:getTxt("base/txtKill")
	self._txtBtnSure = self:getTxt("btnSure/txt")
	self._imgKillChange = self:getGo("base/imgKill"):GetComponent(ComponentType.UIImageSpriteChange)
	self._itemsGo = self:getGo("treasure/items")
	self._itemsLayout = self:getGo("treasure/items"):GetComponent(ComponentType.UILayoutSingleLine)
	self._itemGo = self:getGo("treasure/item")
	self._treasureGo = self:getGo("treasure")
	self._btnSure = self:getBtn("btnSure")

	goutil.setActive(self._itemGo, false)

	self._items = {}
end

function ParallelkingdragonresultView:onExit()
	ParallelkingdragonresultView.super.onExit(self)
	self:_hideAllItems()
end

function ParallelkingdragonresultView:onEnter()
	ParallelkingdragonresultView.super.onEnter(self)

	self._notifyClgMsg = self:getFirstParam()

	self:_updateUI()
end

function ParallelkingdragonresultView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

function ParallelkingdragonresultView:_updateUI()
	local isWin = self._notifyClgMsg.isWin
	local isPass = self._notifyClgMsg.isPass

	self._imgKillChange:SetState(isWin and 0 or 1)

	self._txtBtnSure.text = isWin and isPass and "下一关" or "重新挑战"
	self._txtKill.text = self:_getKillNumDesc()

	goutil.setActive(self._treasureGo, true)
	self:_updateItems(self._notifyClgMsg.gainTreasureIdAndNum)
end

function ParallelkingdragonresultView:_getKillNumDesc()
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = 0
	local curNum = 0

	for k, v in pairs(enemys) do
		if not v.attrs:isFakePet() then
			totalNum = totalNum + 1

			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	local isReach = totalNum <= curNum
	local color = self:_getColorStr(isReach)

	return string.format("<color=#%s>(%d/%d)</color>", color, curNum, totalNum)
end

function ParallelkingdragonresultView:_getColorStr(bValue)
	return (bValue or nil) and (SettlementTarget.Colors.Sucess or SettlementTarget.Colors.Fail)
end

function ParallelkingdragonresultView:_updateItems(gainTreasureIdAndNum)
	self:_hideAllItems()

	local stageCfg = ParallelkingdragonConfig.instance:getStageCfg(self._notifyClgMsg.activityId, self._notifyClgMsg.stageId)
	local treasurePositionMap = {}
	local treasurePositionList = {}

	for i, tId in ipairs(stageCfg.treasurePosition) do
		if tId > 0 then
			treasurePositionMap[tId] = (treasurePositionMap[tId] or 0) + 1
		end
	end

	for tId, needNum in pairs(treasurePositionMap) do
		table.insert(treasurePositionList, {
			treasureId = tId,
			needNum = needNum
		})
	end

	for i, data in ipairs(treasurePositionList) do
		if data.treasureId > 0 then
			local item = self:_getFreeItem()

			self:_updateItem(item, data.treasureId, data.needNum, gainTreasureIdAndNum)
		end
	end

	self._itemsLayout:Layout()
end

function ParallelkingdragonresultView:_updateItem(item, treasureId, needNum, gainTreasureIdAndNum)
	local tCfg = ParallelkingdragonConfig.instance:getTreasureCfg(self._notifyClgMsg.activityId, treasureId)
	local num = 0

	if tCfg.buffId > 0 then
		for i, v in ipairs(gainTreasureIdAndNum) do
			if v.left == treasureId then
				num = v.right

				break
			end
		end
	else
		num = 1
	end

	if not self._notifyClgMsg.isWin then
		num = 0
	end

	MaterialMgr.setCell(MatType.Item_Fake, tCfg.itemId, item.conGo)

	item.txtDesc.text = string.format("数量：%s/<color=#20b376>%s</color>", num, needNum)

	item.imgGou:SetState(needNum <= num and 0 or 1)
end

function ParallelkingdragonresultView:_hideAllItems()
	for i, v in ipairs(self._items) do
		v.isUse = false

		goutil.setActive(v.go, false)
		MaterialMgr.resetAll(v.conGo)
	end
end

function ParallelkingdragonresultView:_getFreeItem()
	local item

	for i, v in ipairs(self._items) do
		if not v.isUse then
			item = v

			break
		end
	end

	if not item then
		local go = goutil.cloneAndSetParent(self._itemGo, self._itemsGo.transform)
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		local imgGou = goutil.findChild(go, "imgGou"):GetComponent(ComponentType.UIImageSpriteChange)
		local conGo = goutil.findChild(go, "con")

		item = {
			isUse = false,
			go = go,
			txtDesc = txtDesc,
			imgGou = imgGou,
			conGo = conGo
		}

		table.insert(self._items, item)
	end

	goutil.setActive(item.go, true)

	item.isUse = true

	return item
end

return ParallelkingdragonresultView

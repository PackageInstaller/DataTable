-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunelevelupView.lua

module("logic.extensions.rune.view.RunelevelupView", package.seeall)

local RunelevelupView = class("RunelevelupView", ViewComponent)
local LIMIT = 300

function RunelevelupView:ctor()
	RunelevelupView.super.ctor(self)

	self.select_count = 0
end

function RunelevelupView:buildUI()
	RunelevelupView.super.buildUI(self)

	self.goldBarCon = self:getGo("goldBarCon")
	self.btnClose = self:getGo("container/upInfo/btnClose")
	self.btnHelp = self:getGo("container/upInfo/btnHelp")
	self.equipItem = self:getGo("container/leftInfo/equipItem")
	self.qhShowTran = self:getGo("container/leftInfo/qhShowTran")
	self.qhItem = self:getGo("container/leftInfo/qhItem")

	GameUtil.SetActive(self.qhItem, false)

	self.equipNameTxt = self:getTxt("container/leftInfo/equipNameTxt")
	self.qhNowTxt = self:getTxt("container/leftInfo/qhNowTxt")
	self.qhNextTxt = self:getTxt("container/leftInfo/qhNextTxt")
	self.qhNumTxt = self:getTxt("container/leftInfo/qhNumTxt")
	self.txtLevelUpNum = self:getTxt("container/leftInfo/txtLevelUpNum")
	self.qhBarSli = goutil.findChildComponent(self.mainGO, "container/leftInfo/qhBarSli", "Slider")
	self.equipListSR = self:getGo("container/rightInfo/equipListSR")
	self.itemGridGo = self:getGo("container/rightInfo/itemGridGo")
	self.moneyCountTxt = self:getTxt("container/rightInfo/moneyCountTxt")
	self.putInBtn = self:getGo("container/rightInfo/putInBtn")
	self.btnMaxLvl = self:getGo("container/rightInfo/btnMaxLvl")
	self.strengthenBtn = self:getGo("container/rightInfo/strengthenBtn")
	self.imgEmpty = self:getGo("container/rightInfo/imgEmpty")
	self.txtCount = self:getTxt("container/rightInfo/txtCount")
	self.longPressed = self.putInBtn:GetComponent("UILongPressed")
	self._tableviewBag = ScrollerList.create(self.equipListSR, self.itemGridGo, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
end

function RunelevelupView:bindEvents()
	RunelevelupView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.onClose, self)
	GameUtil.addClickHandler(self.strengthenBtn, self.onSureLvlup, self)
	GameUtil.addClickHandler(self.putInBtn, self.onOneKeyPut, self)
	GameUtil.addClickHandler(self.btnMaxLvl, self.onOneKeyMaxLevel, self)
	GameUtil.addClickHandler(self.btnHelp, self.onHelpClick, self)
	self.longPressed:AddToggledListener(self._onLongPressed, self)
end

function RunelevelupView:unbindEvents()
	RunelevelupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.strengthenBtn)
	GameUtil.rmClickHandler(self.putInBtn)
	GameUtil.rmClickHandler(self.btnMaxLvl)
	GameUtil.rmClickHandler(self.btnHelp)
	self.longPressed:RemoveToggledListener()
end

function RunelevelupView:destroyUI()
	RunelevelupView.super.destroyUI(self)
end

function RunelevelupView:onEnter()
	RunelevelupView.super.onEnter(self)

	self.leftList = {}
	self.itemList = {}

	local param = self:getOpenParam()

	self.currRuneId = checknumber(param[1])
	self.currRuneMo = RuneModel.instance:getItemData(self.currRuneId)

	local totalExp = self.currRuneMo.curExp

	self.curTweenExp = totalExp
	self.currTotalExp = totalExp

	local lvl, max, nextExp = RuneConfig.instance:getLvlupInfo(self.currRuneMo:getDefineId(), totalExp)

	self.isRealMaxLvl = false

	if max <= lvl then
		self.isRealMaxLvl = true
	end

	self._tableviewBag:MoveCellInView(0)

	self.select_count = 0

	RuneController.instance:getSuitInfo(GameUtil.handler(self.refresh, self, true))
	GlobalDispatcher:addListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)
	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor)
end

function RunelevelupView:onEnterFinished()
	RunelevelupView.super.onEnterFinished(self)
end

function RunelevelupView:onExit()
	RunelevelupView.super.onExit(self)
	RuneAgent.instance:reset()
	self._tableviewBag:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)

	if self.upEffect then
		UIEffectManager.instance:stopEffect(self.upEffect)

		self.upEffect = nil
	end

	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end
end

function RunelevelupView:onExitFinished()
	RunelevelupView.super.onExitFinished(self)
end

function RunelevelupView:onClose()
	if self:getHasMaterial() then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("当前有选中的星辉升级材料是否放弃升级？"), function()
			self:close()
		end)
	else
		self:close()
	end
end

function RunelevelupView:getHasMaterial()
	local mats = {}

	for k, v in pairs(self.itemList) do
		for kk, vv in pairs(v) do
			if vv > 0 then
				local materials = MaterialExtension_pb.MaterialItemNO()

				materials.id = checknumber(kk)
				materials.num = checknumber(vv)

				table.insert(mats, materials)
			end
		end
	end

	local runes = {}
	local hasBig = false

	for k, v in pairs(self.leftList) do
		table.insert(runes, v.runeId)

		if v:getQuality() >= GameEnum.RuneQuality.TYPE_ZI then
			hasBig = true
		end
	end

	return #runes > 0 or #mats > 0
end

function RunelevelupView:refresh(isShowMat)
	self:showLeftView()
	self:showRightView()

	if isShowMat then
		self:showMaterial()
	end
end

function RunelevelupView:showLeftView()
	MaterialMgr.setCellByData(MatType.Rune, self.currRuneMo, self.equipItem)

	self.equipNameTxt.text = self.currRuneMo:getName()
end

function RunelevelupView:showRightView()
	self.totalCount = 0

	local list = {}
	local matStr = RuneConfig.instance:getConst("RUNE_MATERIAL_ID")
	local matArr = string.split(matStr, ",")

	for i, v in ipairs(matArr) do
		local mo = MaterialMgr.getModel(MatType.Item, v)

		if mo then
			table.insert(list, mo)

			self.totalCount = self.totalCount + mo.num
		end
	end

	local currQuality = self.currRuneMo:getQuality()
	local allList = RuneModel.instance:getAllFreeRune()

	for k, v in pairs(allList) do
		if v ~= self.currRuneMo then
			if currQuality >= v:getQuality() then
				table.insert(list, v)
			end

			if v:getQuality() < GameEnum.RuneQuality.TYPE_ZI then
				self.totalCount = self.totalCount + 1
			end
		end
	end

	if list == nil or #list == 0 then
		self._tableviewBag:regGetDataLen(function()
			return 0
		end)
	else
		self._tableviewBag:regGetDataLen(function()
			return math.max(#list, 20)
		end)
	end

	self._tableviewBag:reloadData(list)
	GameUtil.SetActive(self.imgEmpty, list == nil or #list == 0)
end

function RunelevelupView:clearCell(cell)
	local con = goutil.findChild(cell, "con")
	local reduceBtn = goutil.findChild(cell, "reduceBtn")

	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(reduceBtn)
	MaterialMgr.resetAll(con)
end

function RunelevelupView:updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local reduceBtn = goutil.findChild(cell, "reduceBtn")

	GameUtil.SetActive(reduceBtn, false)
	GameUtil.rmClickHandler(cell)
	GameUtil.rmClickHandler(reduceBtn)

	if data then
		if data.__cname == "RuneItemMo" then
			local proxy = MaterialMgr.setCellByData(MatType.Rune, data, con)

			GameUtil.addClickHandler(cell, GameUtil.handler(self.onSelectRune, self, data))
			GameUtil.addClickHandler(reduceBtn, GameUtil.handler(self.onSelectRune, self, data))

			local idx = table.indexof(self.leftList, data)

			if idx == false then
				GameUtil.SetActive(reduceBtn, false)

				if proxy then
					proxy.binder:setNum(1)
				end
			else
				GameUtil.SetActive(reduceBtn, true)

				if proxy then
					proxy.binder:setNum(1, 1)
				end
			end
		else
			local proxy = MaterialMgr.setCellByData(data.type, data, con)

			GameUtil.addClickHandler(cell, GameUtil.handler(self.onSelectItem, self, data))
			GameUtil.addClickHandler(reduceBtn, GameUtil.handler(self.onReduceItem, self, data))

			local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)

			if self.itemList[data.type] and checknumber(self.itemList[data.type][data.id]) > 0 then
				GameUtil.SetActive(reduceBtn, true)

				if proxy then
					proxy.binder:setNum(num, checknumber(self.itemList[data.type][data.id]))
				end
			else
				GameUtil.SetActive(reduceBtn, false)

				if proxy then
					proxy.binder:setNum(num)
				end
			end
		end
	else
		MaterialMgr.resetAll(con)
	end
end

function RunelevelupView:onSelectRune(runeMo)
	local idx = table.indexof(self.leftList, runeMo)

	if idx == false then
		if self.isMaxLvl then
			self:showNoNeed()
		elseif self.select_count >= LIMIT then
			self:showLimit()
		else
			local qual = runeMo:getQuality()

			if qual <= self.currRuneMo:getQuality() then
				self.select_count = self.select_count + 1

				table.insert(self.leftList, runeMo)
				self._tableviewBag:refresh()
				self:showMaterial()
			else
				FloatWordMgr.instance:show(lang("当前放入的升级材料品质高于的星辉品质，不能放入噢！"))
			end
		end
	else
		self.select_count = self.select_count - 1

		table.remove(self.leftList, idx)
		self._tableviewBag:refresh()
		self:showMaterial()
	end
end

function RunelevelupView:onSelectItem(mo)
	if self.isMaxLvl then
		self:showNoNeed()
	elseif self.select_count >= LIMIT then
		self:showLimit()
	else
		local num = MaterialFacade.instance:getMatNumber(mo.type, mo.id)

		self.itemList[mo.type] = self.itemList[mo.type] or {}

		if num > checknumber(self.itemList[mo.type][mo.id]) then
			self.select_count = self.select_count + 1
		end

		self.itemList[mo.type][mo.id] = math.min(num, checknumber(self.itemList[mo.type][mo.id]) + 1)

		self._tableviewBag:refresh()
		self:showMaterial()
	end
end

function RunelevelupView:showNoNeed()
	FloatWordMgr.instance:show(lang("当前星辉已达到等级上限，无法放入更多材料！"))
end

function RunelevelupView:showLimit()
	FloatWordMgr.instance:show(langPara("当前星辉升级材料最多放入%s个，无法放入更多材料！", LIMIT))
end

function RunelevelupView:showSelectAll()
	FloatWordMgr.instance:show(langPara("当前星辉符合条件的升级材料已经全部放入，无法放入更多材料！", LIMIT))
end

function RunelevelupView:onReduceItem(mo)
	self.itemList[mo.type] = self.itemList[mo.type] or {}

	if checknumber(self.itemList[mo.type][mo.id]) > 0 then
		self.select_count = self.select_count - 1
	end

	self.itemList[mo.type][mo.id] = math.max(0, checknumber(self.itemList[mo.type][mo.id]) - 1)

	self._tableviewBag:refresh()
	self:showMaterial()
end

function RunelevelupView:getMatExp(id)
	local matStr = RuneConfig.instance:getConst("RUNE_MATERIAL_ID")
	local matArr = string.split(matStr, ",")
	local expStr = RuneConfig.instance:getConst("RUNE_MATERIAL_ADD_EXP")
	local expArr = string.split(expStr, ",")
	local idx = table.indexof(matArr, id .. "")

	if idx ~= false then
		return checknumber(expArr[idx])
	end

	return 0
end

function RunelevelupView:showCurSliderValue(totalExp)
	local lvl, max, nextExp = RuneConfig.instance:getLvlupInfo(self.currRuneMo:getDefineId(), totalExp)

	self.qhNumTxt.text = totalExp .. "/" .. nextExp
	self.nextLvl = lvl
	self.isMaxLvl = false

	if max <= lvl then
		self.isMaxLvl = true
		self.qhNextTxt.text = langPara("强化等级: <color=#b3484b>%s(MAX)</color>", max)
		self.qhBarSli.value = 1
	else
		self.qhNextTxt.text = langPara("强化等级: <color=#b3484b>%s</color>", lvl)
		self.qhBarSli.value = totalExp / nextExp
	end
end

function RunelevelupView:showMaterial()
	self.txtCount.text = langPara("已经选中：(%s/%s)", self.select_count, LIMIT)

	local count = 0

	for k, v in pairs(self.itemList) do
		for kk, vv in pairs(v) do
			count = count + self:getMatExp(kk) * checknumber(vv)
		end
	end

	for k, mo in pairs(self.leftList) do
		count = count + mo:getTotalExp()
	end

	self.costMoney = count * checknumber(RuneConfig.instance:getConst("UPGRADE_COIN_EXP_RATIO"))
	self.moneyCountTxt.text = self.costMoney
	self.qhNowTxt.text = langPara("当前等级: <color=#b3484b>%s</color>", self.currRuneMo.level)

	local totalExp = self.currRuneMo.curExp + count
	local isUp = totalExp > self.currTotalExp

	self.currTotalExp = totalExp

	local lvl, max, nextExp = RuneConfig.instance:getLvlupInfo(self.currRuneMo:getDefineId(), totalExp)

	self.qhNumTxt.text = totalExp .. "/" .. nextExp
	self.nextLvl = lvl
	self.isMaxLvl = false

	if max <= lvl then
		self.isMaxLvl = true
		self.qhNextTxt.text = langPara("强化等级: <color=#b3484b>%s(MAX)</color>", max)
		self.qhBarSli.value = 1
	else
		self.qhNextTxt.text = langPara("强化等级: <color=#b3484b>%s</color>", lvl)
		self.qhBarSli.value = totalExp / nextExp
	end

	if self.tween then
		self.tween:Kill(false)
	end

	if nextExp <= self.curTweenExp then
		self.curTweenExp = nextExp
	end

	if isUp then
		local path = "fx_ui_jingyanshengji/fx_ui_jingyan_shengji.prefab"

		self.upEffect = UIEffectManager.instance:playEffect(self, path, self.qhBarSli, 0, 0, false)

		self.upEffect:setParent(self.qhBarSli.transform)
		self.upEffect:setScale(1)

		self.qhBarSli.value = self.curTweenExp / nextExp
		self.tween = TweenUtil.ValueTo(self.curTweenExp, totalExp, 0.2, function(val)
			self.curTweenExp = val
			self.qhBarSli.value = val / nextExp
		end, function()
			self.tween = nil
		end, self)
	end

	goutil.clearChildren(self.qhShowTran)

	local curPropStr = self.currRuneMo:getProp()
	local cfg = RuneConfig.instance:getRuneLvlCfg(self.currRuneMo:getDefineId(), math.min(lvl, max))
	local curArr = GameUtil.propToList({
		curPropStr
	})
	local nextArr = GameUtil.propToList({
		cfg.propertyApp
	})

	for k, v in pairs(nextArr) do
		local cur = 0

		for kk, vv in pairs(curArr) do
			if vv.name == v.name then
				cur = vv.value

				break
			end
		end

		self:showItem(v.name, cur, v.value)
	end
end

function RunelevelupView:showItem(name, value, next)
	local cell = goutil.clone(self.qhItem, "qhItem")

	goutil.addChildToParent(cell, self.qhShowTran)
	GameUtil.SetActive(cell, true)

	local attrIconSpt = goutil.findChildComponent(cell, "attrIconSpt", "UIImageSpriteChange")
	local qhNameTxt = goutil.findChildTextComponent(cell, "qhNameTxt")
	local qhNowCountTxt = goutil.findChildTextComponent(cell, "qhNowCountTxt")
	local ImageGo5 = goutil.findChild(cell, "ImageGo5")
	local qhNextCountTxt = goutil.findChildTextComponent(cell, "qhNextCountTxt")
	local idx = table.indexof(GameEnum.AttrTypeName, name)

	attrIconSpt:SetState(idx - 1)

	qhNameTxt.text = name
	qhNowCountTxt.text = value
	qhNowCountTxt.text = GameUtil.getValueOrPercent(value)

	if next == nil then
		GameUtil.SetActive(ImageGo5, false)
		GameUtil.SetActive(qhNextCountTxt, false)
	else
		GameUtil.SetActive(ImageGo5, true)
		GameUtil.SetActive(qhNextCountTxt, true)

		qhNextCountTxt.text = GameUtil.getValueOrPercent(next)
	end
end

function RunelevelupView:onOneKeyMaxLevel()
	if self.isRealMaxLvl then
		self:showNoNeed()
	elseif self:getHasMaterial() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("当前有选中的星辉升级材料，\n请先【确认升级】或取消掉选中的升级材料后，\n再使用钻石满级。"))
	else
		self.lastlvl = self.currRuneMo.level

		local runeId = self.currRuneMo:getDefineId()
		local maxLvl = RuneConfig.instance:getRuneMaxLevel(runeId)
		local maxExp = RuneConfig.instance:getRuneLvlCfg(runeId, maxLvl).exp
		local needExp = maxExp - self.currRuneMo.curExp
		local per = checknumber(RuneConfig.instance:getConst("DIAMOND_LEVEL_UP_RATIO"))
		local costNum = math.ceil(needExp / per)
		local content = langPara("确定要花费%s钻石，将该星辉升至满级吗？\n升至满级需要星辉经验为：%s\n（1钻石=%s星辉经验）", costNum, needExp, per)

		TipsFacade.instance:openPopupCostDiamondView(costNum, content, function()
			RuneAgent.instance:sendPM_RuneDiamondLevelUpReq(self.currRuneMo.runeId, function(msg)
				self.itemList = {}
				self.leftList = {}
				self.select_count = 0

				local totalExp = self.currRuneMo.curExp

				self.currTotalExp = totalExp
				self.curTweenExp = totalExp

				local lvl, max, nextExp = RuneConfig.instance:getLvlupInfo(self.currRuneMo:getDefineId(), totalExp)

				self.isRealMaxLvl = false

				if max <= lvl then
					self.isRealMaxLvl = true
				end

				UIStateManager.instance:push(ViewName.RunelvupView, self.currRuneId, self.lastlvl, maxLvl)
				self:refresh(true)
			end)
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function RunelevelupView:_onLongPressed(item, isUp)
	self:onOneKeyPut()
end

function RunelevelupView:onOneKeyPut()
	if self.isRealMaxLvl then
		self:showNoNeed()
	else
		self.itemList = {}
		self.leftList = {}

		local id = self.currRuneMo:getDefineId()
		local maxLvl = RuneConfig.instance:getRuneMaxLevel(id)
		local lvl, max, nextExp = RuneConfig.instance:getLvlupInfo(id, self.currTotalExp)
		local nextLvl = math.min(maxLvl, lvl + 1)
		local cfg = RuneConfig.instance:getRuneLvlCfg(id, nextLvl)
		local curExp = self.currRuneMo.curExp
		local totalExp = cfg.exp

		self.select_count = 0

		local list = self._tableviewBag:getData()

		for i, mo in ipairs(list) do
			if totalExp <= curExp or self.select_count >= LIMIT then
				break
			elseif mo.__cname == "RuneItemMo" then
				local qual = mo:getQuality()

				if qual < GameEnum.RuneQuality.TYPE_ZI and qual <= self.currRuneMo:getQuality() then
					curExp = curExp + mo:getTotalExp()

					table.insert(self.leftList, mo)

					self.select_count = self.select_count + 1

					if self.select_count >= LIMIT then
						break
					end
				end
			else
				local exp = self:getMatExp(mo.id)
				local num = MaterialModel.instance:getMaterialsNumber(mo.type, mo.id)

				for i = 1, num do
					if totalExp <= curExp then
						break
					else
						curExp = curExp + exp
						self.itemList[mo.type] = self.itemList[mo.type] or {}
						self.itemList[mo.type][mo.id] = checknumber(self.itemList[mo.type][mo.id]) + 1
						self.select_count = self.select_count + 1

						if self.select_count >= LIMIT then
							break
						end
					end
				end
			end
		end

		local overExp = curExp - totalExp

		if overExp > 0 then
			for i = #list, 1, -1 do
				if overExp == 0 then
					break
				end

				local mo = list[i]

				if mo.__cname == "RuneItemMo" then
					local idx = table.indexof(self.leftList, mo)

					if idx ~= false then
						local exp = mo:getTotalExp()

						if exp <= overExp then
							overExp = overExp - exp

							table.remove(self.leftList, idx)

							self.select_count = self.select_count - 1
						end
					end
				elseif self.itemList[mo.type] then
					local exp = self:getMatExp(mo.id)

					if exp <= overExp then
						local count = checknumber(self.itemList[mo.type][mo.id])

						if count > 0 then
							for i = 1, count do
								if exp <= overExp then
									overExp = overExp - exp
									self.itemList[mo.type][mo.id] = checknumber(self.itemList[mo.type][mo.id]) - 1
									self.select_count = self.select_count - 1
								end
							end
						end
					end
				end
			end
		end

		if self.select_count >= LIMIT then
			self:showLimit()
		elseif self.select_count >= self.totalCount then
			self:showSelectAll()
		end

		self:refresh(true)
	end
end

function RunelevelupView:onSureLvlup()
	if self.isRealMaxLvl then
		self:showNoNeed()

		return
	end

	local num = MaterialModel.instance:getMaterialsNumber(MatType.Coin, MatType.Coin_Gold)

	if num >= self.costMoney then
		local mats = {}

		for k, v in pairs(self.itemList) do
			for kk, vv in pairs(v) do
				if vv > 0 then
					local materials = MaterialExtension_pb.MaterialItemNO()

					materials.id = checknumber(kk)
					materials.num = checknumber(vv)

					table.insert(mats, materials)
				end
			end
		end

		local runes = {}
		local hasBig = false

		for k, v in pairs(self.leftList) do
			table.insert(runes, v.runeId)

			if v:getQuality() >= GameEnum.RuneQuality.TYPE_ZI then
				hasBig = true
			end
		end

		if #runes > 0 or #mats > 0 then
			if hasBig then
				TipsFacade.instance:openPopupWindow(lang("tip"), lang("当前放入的升级材料中，有<color='#744BBEFF'>紫色</color>以上品质的星辉，是否确认升级？"), function()
					self:sendLvlupMsg(mats, runes)
				end)
			else
				TipsFacade.instance:openPopupCostCoinView(self.costMoney, langPara("确定要消耗%s金币进行星辉升级吗？", self.costMoney), function()
					self:sendLvlupMsg(mats, runes)
				end)
			end
		else
			TipsFacade.instance:openCommonTips(lang("请选择升级材料"))
		end
	else
		TipsFacade.instance:openCommonTips(lang("当前金币不足，无法完成升级"))
	end
end

function RunelevelupView:sendLvlupMsg(mats, runes)
	self.lastlvl = self.currRuneMo.level

	RuneAgent.instance:sendPM_RuneLevelUpReq(self.currRuneId, mats, runes, function(msg)
		local ci = msg.changeSetId

		RuneController.instance:stopShowCI(ci, ItemGetController.TITLE_RETURNMAT)

		self.itemList = {}
		self.leftList = {}
		self.select_count = 0

		local totalExp = self.currRuneMo.curExp

		self.currTotalExp = totalExp
		self.curTweenExp = totalExp

		local lvl, max, nextExp = RuneConfig.instance:getLvlupInfo(self.currRuneMo:getDefineId(), totalExp)

		self.isRealMaxLvl = false

		if max <= lvl then
			self.isRealMaxLvl = true
		end

		if self.nextLvl > self.lastlvl then
			UIStateManager.instance:push(ViewName.RunelvupView, self.currRuneId, self.lastlvl, self.nextLvl)
		else
			TipsFacade.instance:openCommonTips(lang("升级成功，已经为当前星辉注入能量"))
			RuneController.instance:showRuneCI()
		end

		self:refresh(true)
	end)
end

function RunelevelupView:onHelpClick()
	return
end

return RunelevelupView

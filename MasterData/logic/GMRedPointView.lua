-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmredpoint/GMRedPointView.lua

module("logic.extensions.gm.view.gmredpoint.GMRedPointView", package.seeall)

local GMRedPointView = class("GMRedPointView", ViewComponent)
local SifterCond = {
	"isLight",
	"isAttrActivated",
	"isInTime",
	"isFuncOpenByServer",
	"isFuncOpenByClient",
	"isHaveRedGos",
	"isMasterRed",
	"isServantRed",
	"isReg"
}
local TabMode = {
	Server = 4,
	Client = 3,
	Exact = 2,
	Once = 6,
	Cycle = 5,
	Global = 1
}
local TabTitle = {
	Server = "后端红点",
	Client = "前端红点",
	Exact = "精确搜索",
	Once = "单次红点",
	Cycle = "周期红点",
	Global = "已注册红点"
}

function GMRedPointView:buildUI()
	GMRedPointView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "topCol/btnClose")
	self._btnTips = goutil.findChild(self.mainGO, "topCol/btnTips")
	self._txtCurTime = goutil.findChildTextComponent(self.mainGO, "topCol/txtCurTime/txt")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._descContent = goutil.findChild(self.mainGO, "descCol/descScrollerview/Viewport/Content")
	self._descScrollercell = goutil.findChild(self.mainGO, "descCol/descScrollercell")
	self._descScrollerview = goutil.findChild(self.mainGO, "descCol/descScrollerview")
	self._descScrollerList = ScrollerList.create(self._descScrollerview, self._descScrollercell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))

	self._descScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._descScrollercellTemp = goutil.cloneAndSetParent(self._descScrollercell, self._descScrollercell.transform.parent, self._descScrollercell.name .. "(clone)")
	self._txtDescScrollercellTemp = goutil.findChildTextComponent(self._descScrollercellTemp, "txtDesc")
	self._btnClear = goutil.findChild(self.mainGO, "funCol/InputField/btnClear")
	self._txtInfoDesc = goutil.findChildTextComponent(self.mainGO, "funCol/txtInfoDesc")
	self._InputField = goutil.findChild(self.mainGO, "funCol/InputField")
	self._InputFieldAdapter = self:getInput("funCol/InputField")
	self._btnShowAll = goutil.findChild(self.mainGO, "funCol/ctrlCol/btnShowAll")
	self._btnShowSifter = goutil.findChild(self.mainGO, "funCol/ctrlCol/btnShowSifter")
	self._sifterview = goutil.findChild(self.mainGO, "funCol/ctrlCol/sifterview")
	self._sifterviewUiCustonInput = UICustomInput.Get(self._sifterview)
	self._tabview = goutil.findChild(self._sifterview, "tabview")
	self._tabCell1 = goutil.findChild(self._sifterview, "tabview/tabCell1")

	GameUtil.SetActive(self._descScrollercellTemp, false)

	self._redInfoList = {}
end

function GMRedPointView:bindEvents()
	GMRedPointView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnClear, function()
		self:_setInputField("")
	end, self)
	self._InputFieldAdapter:AddOnValueChanged(self._onValueChanged, self)
	GameUtil.addClickHandler(self._btnShowAll, self._onClickBtnShowAll, self)
	GameUtil.addClickHandler(self._btnShowSifter, self._onClickBtnShowSifter, self)
	self._sifterviewUiCustonInput:AddListener(self._onClickBtnShowSifter, self)
end

function GMRedPointView:unbindEvents()
	GMRedPointView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnClear)
	self._InputFieldAdapter:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnShowAll)
	GameUtil.rmClickHandler(self._btnShowSifter)
	self._sifterviewUiCustonInput:RemoveListener()
end

function GMRedPointView:onEnter()
	GMRedPointView.super.onEnter(self)

	if self._gmRedMoMgr == nil then
		self._gmRedMoMgr = GMRedMoMgr.New()
	end

	self._gmRedMoMgr:onEnter()

	self._curTabMode = self._curTabMode or 1

	self:_initSifterData()

	self._isNeedUpdate = false

	self.addGEvent(self, GlobalNotify.GMRedMoMgrUpdateFinish, self._handleGMRedMoMgrUpdateFinish, self)

	local params = self:getOpenParam() or {}

	if not string.nilorempty(params[1]) then
		self:_setInputField(params[1])
	end

	self:_onUpdate()
	settimer(0.1, self._onTicking, self, true)
end

function GMRedPointView:onExit()
	GMRedPointView.super.onExit(self)
	removetimer(self._onTicking, self)
	self._gmRedMoMgr:onExit()
	self._tabScrollList:dispose()
	self._descScrollerList:dispose()
end

function GMRedPointView:destroyUI()
	GMRedPointView.super.destroyUI(self)
	self._gmRedMoMgr:destroy()

	self._gmRedMoMgr = nil
end

function GMRedPointView:_onTicking()
	if self._isNeedUpdate then
		self._isNeedUpdate = false

		self:_onUpdate()
	end
end

function GMRedPointView:_handleGMRedMoMgrUpdateFinish()
	self._isNeedUpdate = true
end

function GMRedPointView:_onUpdate()
	self._isNeedUpdate = false

	self:_onUpdateData()
	self:_onUpdateUI()
end

function GMRedPointView:_onUpdateData()
	self:_updateTabData()
	self:_updateDescData()
end

function GMRedPointView:_onUpdateUI()
	self:_onupdatePlaneUI()
	self:_updateTabScrollerList()
	self:_onUpdateDescCol()
	self:_onUpdateSifterView()
end

function GMRedPointView:_onupdatePlaneUI()
	local nowStamp = ServerTime.now()
	local nowT = GameUtil.time2date(nowStamp)
	local nowStr = string.format("%02d年 %02d月 %02d日 %02d时 %02d分 %02d秒", nowT.year, nowT.month, nowT.day, nowT.hour, nowT.min, nowT.sec)

	self._txtCurTime.text = string.format("当前时间：%s 【%s】", self:color("pinkClr", nowStr), self:color("pinkClr", nowStamp * 1000))
end

function GMRedPointView:_updateTabData()
	self._tabDataList = {}

	for i, mode in pairs(TabMode) do
		local var_14_0 = {
			mode = mode
		}

		var_14_0.title = TabTitle[i] or ""
		self._tabDataList[mode] = var_14_0
	end
end

function GMRedPointView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function GMRedPointView:_updateTabCell(view, cell, data, tag)
	local idx = cell.index + 1
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local UIChangeGroup = mainGo:GetComponent(typeof(UIChangeGroup))

	txtTitle.text = data.title

	UIChangeGroup:SetState(self._curTabMode == idx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, idx))
end

function GMRedPointView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function GMRedPointView:_onClickTab(idx)
	self._curTabMode = idx

	self:_onUpdateUI()
end

function GMRedPointView:_updateDescData()
	local listGroup = {}
	local redIdList = self._gmRedMoMgr:getRedIdList()

	listGroup[TabMode.Global] = {}

	for _, redId in ipairs(redIdList) do
		if string.nilorempty(redId) then
			printError("警告:列表存在一个空的红点")
		else
			table.insert(listGroup[TabMode.Global], redId)
		end

		if self:_getRedMo(redId) == nil then
			printError(string.format("警告:管理模块不存在对应redMo: %s", redId))
		end
	end

	listGroup[TabMode.Exact] = {}

	if self._exRedIdList then
		for _, redId in ipairs(self._exRedIdList) do
			table.insert(listGroup[TabMode.Exact], redId)
		end
	end

	listGroup[TabMode.Client] = {}

	for _, redId in ipairs(redIdList) do
		if checknumber(redId) <= 0 then
			table.insert(listGroup[TabMode.Client], redId)
		end
	end

	listGroup[TabMode.Server] = {}

	for _, redId in ipairs(redIdList) do
		if checknumber(redId) > 0 then
			table.insert(listGroup[TabMode.Server], redId)
		end
	end

	listGroup[TabMode.Cycle] = {}

	for _, redId in ipairs(redIdList) do
		local redMo = self:_getRedMo(redId)

		if redMo and redMo:isCycleRed() then
			table.insert(listGroup[TabMode.Server], redId)
		end
	end

	listGroup[TabMode.Once] = {}

	for _, redId in ipairs(redIdList) do
		local redMo = self:_getRedMo(redId)

		if redMo and redMo:isOnceRed() then
			table.insert(listGroup[TabMode.Once], redId)
		end
	end

	self._redIdListGroup = listGroup
end

function GMRedPointView:_getRedIdList(tabMode)
	return self._redIdListGroup[tabMode] or {}
end

function GMRedPointView:_getRedMo(redId)
	return self._gmRedMoMgr:getRedMo(redId)
end

function GMRedPointView:_onUpdateDescCol()
	local redIdList = {}

	for _, redId in ipairs(self:_getRedIdList(self._curTabMode)) do
		local isFit = true
		local redMo = self:_getRedMo(redId)

		for condIdx, condMo in ipairs(self._sifterCondMoList) do
			if condMo.state ~= 0 and condMo.field ~= nil then
				if condMo.state == 1 then
					if redMo[condMo.field](redMo) ~= true then
						isFit = false

						break
					end
				elseif condMo.state == 2 and redMo[condMo.field](redMo) ~= false then
					isFit = false

					break
				end
			end
		end

		if isFit then
			table.insert(redIdList, redId)
		end
	end

	if self._curTabMode ~= TabMode.Cycle and self._curTabMode ~= TabMode.Once and self._curTabMode ~= TabMode.Exact then
		table.sort(redIdList, function(a, b)
			if checknumber(a) == checknumber(b) then
				return false
			end

			return checknumber(a) < checknumber(b)
		end)
	end

	table.clear(self._redInfoList)

	for _, redId in ipairs(redIdList) do
		local redMo = self:_getRedMo(redId)

		if redMo then
			local info = {}

			info.redId = redId
			info.redMo = redMo
			info.desc = self:_getRedDesc(redMo)

			table.insert(self._redInfoList, info)
		end
	end

	self._descScrollerList:reloadData(self._redInfoList)

	self._txtInfoDesc.text = string.format("红点数量:%s个", #self._redInfoList)
end

function GMRedPointView:_numInView()
	if not self._redInfoList then
		return 0
	end

	return #self._redInfoList
end

function GMRedPointView:_getCellSize(view, idx)
	local info = self._redInfoList[idx + 1]

	self._txtDescScrollercellTemp.text = info.desc

	return GameUtil.getWidth(self._descScrollercellTemp), Mathf.Max(46, self._txtDescScrollercellTemp.preferredHeight + 10 + 10)
end

function GMRedPointView:_updateDescCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = info.desc

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(mainGo:GetComponent(goutil.Type_RectTransform))
end

function GMRedPointView:_getRedDesc(redMo)
	local redId = redMo:getRedId()
	local str1 = ""
	local f1 = string.format("redId:[%s]", self:color("yellowClr", redId))
	local f2 = string.format("点亮:[%s]", self:getBoolIcon(redMo:isLight()))

	str1 = string.format("%s %s %s", f1, f2, redMo:isReg() and string.format("激活属性:[%s]", self:getBoolIcon(redMo:isAttrActivated())) or "(未注册)")

	local str2 = ""
	local info = redMo:getRedInfo()

	if info then
		local startStamp, endStamp = checknumber(info.showTime), checknumber(info.endTime)

		if startStamp ~= 0 or endStamp ~= 0 then
			local f1 = string.format("激活期:[%s] ", self:getBoolIcon(redMo:isInTime()))
			local f2 = string.format("%s", GameUtil.getFormatTimeByStamp(startStamp / 1000, endStamp / 1000))

			str2 = string.format("\n%s %s", f1, f2)
		end
	end

	local str3 = ""
	local info = redMo:getRedInfo()
	local funcIdList = info and info.funcIdList

	if funcIdList then
		local opIds, clIds = "", ""

		for _, funcId in ipairs(info.funcIdList) do
			funcId = checknumber(funcId)

			if FuncOpenModel.instance:getFuncIsOpen(funcId) then
				opIds = opIds .. funcId
			else
				clIds = clIds .. funcId
			end
		end

		str3 = string.format("\n关联的功能id(Client): 已开启:[%s] 未开启:[%s]", self:color("greenClr", opIds), self:color("redClr", clIds))
	end

	local str4 = ""
	local cfg = RedPointConfig.instance:getCfgById(checknumber(redId))

	if cfg and not string.nilorempty(cfg.funcIds) then
		local opIds, clIds = "", ""

		for _, funcId in ipairs(string.split(cfg.funcIds, "#")) do
			funcId = checknumber(funcId)

			if FuncOpenModel.instance:getFuncIsOpen(funcId) then
				opIds = opIds .. funcId
			else
				clIds = clIds .. funcId
			end
		end

		str4 = string.format("\n关联的功能id(Server)(h-红点配置表): 已开启:[%s] 未开启:[%s]", self:color("greenClr", opIds), self:color("redClr", clIds))
	end

	local str5 = ""
	local goList = redMo:getGoList()

	if #goList > 0 then
		local temp = ""

		for index, redGo in ipairs(goList) do
			local go = redGo.gameObject
			local path = ""

			while true do
				if not goutil.isNil(go) then
					path = go.name .. path
				else
					break
				end

				if go.transform.parent then
					go = go.transform.parent.gameObject
					path = "/" .. path
				else
					break
				end
			end

			temp = temp .. string.format("\n注册路径%s:[%s]", index, path)
		end

		str5 = temp
	end

	local str6 = ""
	local servantRedIdList = redMo:getServantRedIdList()

	if #servantRedIdList > 0 then
		local temp = self:color("yellowClr", servantRedIdList[1])

		for i = 2, #servantRedIdList do
			temp = string.format("%s, %s", temp, self:color("yellowClr", servantRedIdList[i]))
		end

		str6 = string.format("\n拥有的仆红点:[%s]", temp)
	end

	local str7 = ""
	local masterRedIdList = redMo:getMasterRedIdList()

	if #masterRedIdList > 0 then
		local temp = self:color("yellowClr", masterRedIdList[1])

		for i = 2, #masterRedIdList do
			temp = string.format("%s, %s", temp, self:color("yellowClr", masterRedIdList[i]))
		end

		str7 = string.format("\n归属的主红点:[%s]", temp)
	end

	local str8 = ""

	if redMo:isCycleRed() then
		local cycleData = RedPointExConfig.instance:getRpeCycleData(redId)

		if cycleData then
			local typeStr = ""

			typeStr = cycleData.redType == GameEnum.CycleRedType.Day and "每日" or cycleData.redType == GameEnum.CycleRedType.Week and "每周" or cycleData.redType == GameEnum.CycleRedType.Moon and "每月" or self:getBoolIcon(false)

			local viewNameStrTemp = ""

			if not string.nilorempty(cycleData.viewName) then
				viewNameStrTemp = string.format("\n监听界面:[%s]", cycleData.viewName or "nil")
			end

			local funcIdStrTemp = ""

			if cycleData.funcIdArray then
				local opIds, clIds = "", ""

				for _, funcId in ipairs(cycleData.funcIdArray) do
					funcId = checknumber(funcId)

					if FuncOpenModel.instance:getFuncIsOpen(funcId) then
						opIds = opIds .. funcId
					else
						clIds = clIds .. funcId
					end
				end

				funcIdStrTemp = string.format("\n关联的功能id列表(周期红点)(h红点前端扩展表): 已开启:[%s] 未开启:[%s]", self:color("greenClr", opIds), self:color("redClr", clIds))
			end

			str8 = str8 .. string.format("\n周期类型:[%s]", typeStr) .. viewNameStrTemp .. string.format("\n是否强制上锁[%s]", self:getBoolIcon(cycleData.isForceLock)) .. (string.nilorempty(cycleData.startUnlockTime) and string.nilorempty(cycleData.endUnlockTime) or string.format("\n开始解锁时间[%s], 结束解锁时间[%s]", cycleData.startUnlockTime, cycleData.endUnlockTime)) .. funcIdStrTemp
		end
	end

	local str9 = ""

	if redMo:isOnceRed() then
		local onceData = RedPointExConfig.instance:getRpeOnceData(redId)

		if onceData then
			local viewNameStrTemp = ""

			if not string.nilorempty(onceData.viewName) then
				viewNameStrTemp = string.format("\n监听界面:[%s]", onceData.viewName or "nil")
			end

			str9 = str9 .. "\n[单次红点类型]" .. (onceData.isStatic and " [默认静默状态]" or "") .. viewNameStrTemp .. string.format("\n是否强制上锁[%s]", self:getBoolIcon(onceData.isForceLock)) .. (string.nilorempty(onceData.startUnlockTime) and string.nilorempty(onceData.endUnlockTime) or string.format("\n开始解锁时间[%s] 结束解锁时间[%s]", onceData.startUnlockTime, onceData.endUnlockTime))
		end
	end

	return str1 .. str2 .. str3 .. str4 .. str5 .. str6 .. str7 .. str8 .. str9
end

function GMRedPointView:_clearDescCell(cell)
	local mainGo = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = ""
end

local clrs = {
	redClr = "#ff0000",
	pinkClr = "#ff00ff",
	greenClr = "#008500",
	yellowClr = "#B4AB3B"
}

function GMRedPointView:color(clr, str)
	return string.format("<color=%s>%s</color>", clrs[clr], str)
end

function GMRedPointView:getBoolIcon(isTrue)
	return self:color(isTrue and "greenClr" or "redClr", isTrue and "√" or "×")
end

function GMRedPointView:_setInputField(str)
	local oldStr = self:_getInputField()

	self._InputFieldAdapter:SetText(str)

	if str == oldStr then
		self:_updateExRedIdList()
	end
end

function GMRedPointView:_getInputField()
	return self._InputFieldAdapter:GetText()
end

function GMRedPointView:_onValueChanged(inputStr)
	self:_updateExRedIdList()
end

function GMRedPointView:_updateExRedIdList()
	local inputStr = self:_getInputField()

	self._curTabMode = string.nilorempty(inputStr) and TabMode.Global or TabMode.Exact
	self._exRedIdList = {}

	if not string.nilorempty(inputStr) then
		local input = string.gsub(inputStr, "[,.;:#]", " ")

		input = string.gsub(input, "%s+", "#")

		local redIdArray = string.split(input, "#")

		for _, redId in ipairs(redIdArray) do
			if not string.nilorempty(redId) then
				table.insert(self._exRedIdList, redId)
			end
		end
	end

	self._gmRedMoMgr:addRedIds(self._exRedIdList)
end

function GMRedPointView:_onUpdateSifterView()
	local parentTran = self._tabview.transform

	for condIdx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(condIdx - 1)
		local UIChangeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)

		UIChangeGroup:SetState(self:_getSifterCondState(condIdx))
		GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTabCell, self, condIdx))
	end
end

function GMRedPointView:_initSifterData()
	local list = {}

	for condIdx, cond in ipairs(SifterCond) do
		list[condIdx] = {
			state = 0,
			field = cond
		}
	end

	self._sifterCondMoList = list
end

function GMRedPointView:_getSifterCondState(condIdx)
	if self._sifterCondMoList[condIdx] then
		return self._sifterCondMoList[condIdx].state
	else
		return 0
	end
end

function GMRedPointView:_getSifterCondField(condIdx)
	if self._sifterCondMoList[condIdx] then
		return self._sifterCondMoList[condIdx].field
	else
		return nil
	end
end

function GMRedPointView:_changeSifterState(condIdx)
	if self._sifterCondMoList[condIdx] == nil then
		printError("错误,对应condIdx无此条件")

		return
	end

	self._sifterCondMoList[condIdx].state = (self._sifterCondMoList[condIdx].state + 1) % 3
end

function GMRedPointView:_onClickTabCell(condIdx)
	self:_changeSifterState(condIdx)
	self:_onUpdateUI()
end

function GMRedPointView:_onClickBtnShowAll()
	for condIdx, condMo in ipairs(self._sifterCondMoList) do
		self._sifterCondMoList[condIdx].state = 0
	end

	self:_onUpdateUI()
end

function GMRedPointView:_onClickBtnShowSifter(hover)
	if not hover then
		GameUtil.SetActive(self._sifterview, not GameUtil.GetActive(self._sifterview))
	end
end

function GMRedPointView:_onClickBtnClose()
	self:close()
end

function GMRedPointView:_onClickBtnTips()
	local ruleStr = "" .. "\n---------- 点亮的条件 ----------\n" .. "--[点亮],若[" .. self:getBoolIcon(true) .. "]则红点亮，[" .. self:getBoolIcon(false) .. "]则不亮\n" .. "--[激活属性],点亮的条件之一,如果激活属性为false,则无法点亮\n" .. "--[激活期],点亮的条件之一,激活期内才能被激活\n" .. "--[关联的功能id(Client)],对应功能ID开启才能被激活\n" .. "--[关联的功能id(Server)(h-红点配置表)],对应功能ID开启才能被激活\n" .. "\n---------- 其它信息 ----------\n" .. "--[注册路径],红点对应的预制体路径，同一红点id可能对应多个预制体\n" .. "--[主仆红点]任一仆从红点亮,则主红点亮; 所有仆从红点熄灭,则主红点熄灭\n"

	TipsFacade.instance:openTipWindowNoX("使用方法", ruleStr)
end

return GMRedPointView

-- chunkname: @modules/logic/gm/view/act165/GMAct165EditView.lua

module("modules.logic.gm.view.act165.GMAct165EditView", package.seeall)

local GMAct165EditView = class("GMAct165EditView", BaseView)

function GMAct165EditView:onInitView()
	self._gopre = gohelper.findChild(self.viewGO, "#go_pre")
	self._inputstory = gohelper.findChildInputField(self.viewGO, "#go_pre/#input_story")
	self._inputstep = gohelper.findChildInputField(self.viewGO, "#go_pre/#input_step")
	self._inputkw = gohelper.findChildInputField(self.viewGO, "#go_pre/#input_kw")
	self._goitemstep = gohelper.findChild(self.viewGO, "#go_pre/#go_itemstep")
	self._goiditem = gohelper.findChild(self.viewGO, "#go_pre/#go_itemstep/#go_iditem")
	self._btnsetcount = gohelper.findChildButtonWithAudio(self.viewGO, "#go_pre/#btn_setcount")
	self._btnstep = gohelper.findChildButtonWithAudio(self.viewGO, "#go_pre/#btn_step")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_pre/#go_topleft")
	self._gostep = gohelper.findChild(self.viewGO, "#go_step")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_step/#btn_return")
	self._btnokconfig = gohelper.findChildButtonWithAudio(self.viewGO, "#go_step/#btn_okconfig")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_step/#btn_ok")
	self._btnclear = gohelper.findChildButtonWithAudio(self.viewGO, "#go_step/#btn_clear")
	self._gostepitem = gohelper.findChild(self.viewGO, "#go_step/stepitem/#go_stepitem")
	self._txtcurStepId = gohelper.findChildText(self.viewGO, "#go_step/#txt_curStepId")
	self._gokwitem = gohelper.findChild(self.viewGO, "#go_step/kwitem/#go_kwitem")
	self._txtcurround = gohelper.findChildText(self.viewGO, "#go_step/#txt_curround")
	self._goscrollround = gohelper.findChild(self.viewGO, "#go_step/#go_scrollround")
	self._goround = gohelper.findChild(self.viewGO, "#go_step/#go_scrollround/Viewport/Content/#go_round")
	self._btnround = gohelper.findChildButtonWithAudio(self.viewGO, "#go_step/#go_scrollround/#btn_round")
	self._txttip = gohelper.findChildText(self.viewGO, "#txt_tip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GMAct165EditView:addEvents()
	self._btnsetcount:AddClickListener(self._btnsetcountOnClick, self)
	self._btnstep:AddClickListener(self._btnstepOnClick, self)
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
	self._btnokconfig:AddClickListener(self._btnokconfigOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnclear:AddClickListener(self._btnclearOnClick, self)
	self._btnround:AddClickListener(self._btnroundOnClick, self)
end

function GMAct165EditView:removeEvents()
	self._btnsetcount:RemoveClickListener()
	self._btnstep:RemoveClickListener()
	self._btnreturn:RemoveClickListener()
	self._btnokconfig:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btnclear:RemoveClickListener()
	self._btnround:RemoveClickListener()
end

function GMAct165EditView:_btnclearOnClick()
	self._curround = {}

	for _, list in pairs(self._stepItemList) do
		for _, item in pairs(list) do
			item.isClick = false
			item.icon.color = Color.white
			item.kwList = {}

			self:_showKw(item)
		end
	end

	self._txtcurStepId.text = ""
	self.curStepItem = nil
end

function GMAct165EditView:_btnreturnOnClick()
	gohelper.setActive(self._gopre, true)
	gohelper.setActive(self._gostep, false)
end

function GMAct165EditView:_btnsetcountOnClick()
	local story = self._inputstory:GetText()
	local stepCount = self._inputstep:GetText()
	local kwCount = self._inputkw:GetText()

	if string.nilorempty(story) or string.nilorempty(stepCount) or string.nilorempty(kwCount) then
		self:_showTip("未完成填写")

		return
	end

	self._storyId = tonumber(story)
	self._stepCount = tonumber(stepCount)
	self._kwCount = tonumber(kwCount)

	for i = 1, stepCount do
		local item = self:_getStepIdItem(i)
		local ids = ""

		for j = 1, item.count do
			ids = ids .. self:_getStepId(i, j) .. "  "
		end

		item.txtIds.text = ids

		transformhelper.setLocalPosXY(item.go.transform, -750, -50 + -80 * i)
		gohelper.setActive(item.go, true)
	end
end

function GMAct165EditView:_btnokconfigOnClick()
	local roundList = {}

	for _, _round in pairs(self._allround) do
		for step, info in pairs(_round) do
			local id = self:_getStepId(step, info.index)

			if not roundList[id] then
				roundList[id] = {}
				roundList[id].rounds = {}
				roundList[id].step = step
				roundList[id].index = info.index
			end

			table.insert(roundList[id].rounds, _round)
		end
	end

	local confiList = {}

	for _, list in pairs(roundList) do
		local id, info = self:_getConfig(list.step, list.index, list.rounds)

		if not string.nilorempty(info) then
			table.insert(confiList, {
				id = id,
				info = info
			})
		end
	end

	table.sort(confiList, self._sortConfig)

	local str = ""

	for _, config in ipairs(confiList) do
		str = str .. config.id .. "  " .. config.info .. "\n\n"
	end

	SLFramework.SLLogger.LogError(str)
end

function GMAct165EditView._sortConfig(a, b)
	return a.id < b.id
end

function GMAct165EditView:_btnroundOnClick()
	if not self._isShowRoundPanel then
		self:_showAllRound()
	end

	self:_activeRoundPanel(not self._isShowRoundPanel)
end

function GMAct165EditView:_btnstepOnClick()
	gohelper.setActive(self._gopre, false)
	gohelper.setActive(self._gostep, true)
	self:_createStepItem()
end

function GMAct165EditView:_btnokOnClick()
	if not LuaUtil.tableNotEmpty(self._curround) then
		self:_showTip("当前路径未选择步骤")

		return
	end

	if not self._curround[self._stepCount] then
		self:_showTip("没有选择结局")

		return
	end

	if not self._curround[1] then
		self:_showTip("没有选择开头")

		return
	end

	local index = self:_getSameRound(self._curround)

	if index == -1 then
		local round = tabletool.copy(self._curround)

		table.insert(self._allround, round)
		self:_showTip("保存成功")
	else
		self:_showTip("已有相同路径 " .. index)
	end
end

function GMAct165EditView:_addEvents()
	return
end

function GMAct165EditView:_removeEvents()
	if self._stepIdList then
		for index, item in pairs(self._stepIdList) do
			PlayerPrefsHelper.setNumber("gmact165stepcount_" .. self._storyId .. "_" .. index, item.count)
			item.btnAdd:RemoveClickListener()
			item.btnremove:RemoveClickListener()
		end
	end

	if self._stepItemList then
		for _, list in pairs(self._stepItemList) do
			for _, item in pairs(list) do
				item.btn:RemoveClickListener()
			end
		end
	end

	if self._roundItemList then
		for _, item in pairs(self._roundItemList) do
			item.btn:RemoveClickListener()
		end
	end

	if self._kwItemList then
		for _, item in pairs(self._kwItemList) do
			item.btn:RemoveClickListener()
		end
	end
end

function GMAct165EditView:_getStepIdItem(index)
	local item = self._stepIdList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goiditem)
		local btnAdd = gohelper.findChildButtonWithAudio(go, "btn_add")
		local btnremove = gohelper.findChildButtonWithAudio(go, "btn_remove")
		local txtcount = gohelper.findChildText(go, "txt_count")
		local txtIds = gohelper.findChildText(go, "ids")
		local txtIndex = gohelper.findChildText(go, "txt_index")
		local count = PlayerPrefsHelper.getNumber("gmact165stepcount_" .. self._storyId .. "_" .. index, 1)

		txtIndex.text = index
		txtcount.text = count

		local function refreshTxt()
			txtcount.text = item.count

			local ids = ""

			for i = 1, item.count do
				ids = ids .. self:_getStepId(index, i) .. "  "
			end

			txtIds.text = ids
		end

		local function addCb()
			if index ~= 1 then
				item.count = item.count + 1

				refreshTxt()
			end
		end

		local function removeCb()
			if index ~= 1 and item.count > 1 then
				item.count = item.count - 1
				txtcount.text = item.count

				local ids = ""

				for i = 1, item.count do
					ids = ids .. self:_getStepId(index, i) .. "  "
				end

				txtIds.text = ids

				refreshTxt()
			end
		end

		btnAdd:AddClickListener(addCb, self)
		btnremove:AddClickListener(removeCb, self)

		item = {
			go = go,
			btnAdd = btnAdd,
			btnremove = btnremove,
			txtcount = txtcount,
			txtIds = txtIds,
			count = count
		}
		self._stepIdList[index] = item
	end

	return item
end

function GMAct165EditView:_editableInitView()
	self:_addEvents()
	self._inputstory:SetText("1")
	self._inputstep:SetText("8")
	self._inputkw:SetText("10")

	self._stepIdList = self:getUserDataTb_()
	self._stepItemList = self:getUserDataTb_()
	self._roundItemList = self:getUserDataTb_()
	self._kwItemList = self:getUserDataTb_()
	self._allround = {}
	self._curround = {}

	self:_activeRoundPanel(false)
	self:_showCurRound()
	gohelper.setActive(self._gopre, true)
	gohelper.setActive(self._gostep, false)
end

function GMAct165EditView:onUpdateParam()
	return
end

function GMAct165EditView:onOpen()
	return
end

function GMAct165EditView:onClose()
	return
end

function GMAct165EditView:onDestroyView()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._hideTip, self)
end

function GMAct165EditView:_getStepId(step, index)
	return self._storyId * 1000 + step * 100 + index
end

function GMAct165EditView:_createStepItem()
	for i, iditem in pairs(self._stepIdList) do
		if not iditem.count then
			local count = 0

			for j = 1, count do
				local item = self:_getStepItem(i, j)
				local posX = -900 + i * 200
				local posY = 50 + count * 100 - j * 200

				transformhelper.setLocalPosXY(item.go.transform, posX, posY)
				gohelper.setActive(item.go, true)
			end
		end
	end
end

function GMAct165EditView:_getStepItem(step, index)
	local list = self._stepItemList[step]

	if not list then
		list = self:getUserDataTb_()
		self._stepItemList[step] = list
	end

	local item = list[index]

	if not item then
		item = self:getUserDataTb_()

		local id = self:_getStepId(step, index)
		local go = gohelper.cloneInPlace(self._gostepitem, id)
		local txtId = gohelper.findChildText(go, "txt")

		item.txtkw = gohelper.findChildText(go, "kw")
		item.icon = gohelper.findChildImage(go, "icon")
		txtId.text = id

		local function cb()
			self:_onClickStepItem(item)
		end

		local btn = gohelper.findChildButtonWithAudio(go, "btn")

		btn:AddClickListener(cb, self)

		item.go = go
		item.btn = btn
		item.isClick = false
		item.step = step
		item.index = index
		item.id = id
		item.kwList = {}
		list[index] = item
	end

	return item
end

function GMAct165EditView:_onClickStepItem(item)
	if item.isClick then
		self:_removeCurStep(item)
	else
		self:_addCurStep(item)
	end

	self:_refreshKwItem(item)
	self:_showCurRound()
end

function GMAct165EditView:_addCurStep(item)
	if self._curround[item.step] then
		local index = self._curround[item.step].index
		local preItem = self._stepItemList[item.step][index]

		self:_removeCurStep(preItem)
	end

	self._curround[item.step] = self._curround[item.step] or {}
	self._curround[item.step].index = item.index
	self._curround[item.step].kws = {}
	self._txtcurStepId.text = "步骤：" .. item.id
	self.curStepItem = item

	self:_showKw(self.curStepItem)

	item.icon.color = Color.yellow
	item.isClick = true
end

function GMAct165EditView:checkHasPreRound(step)
	local round = {}

	for _step, index in pairs(self._curround) do
		if _step <= step then
			round[_step] = index
		end
	end

	for _, _round in pairs(self._allround) do
		if self:isHasPreRound(round, _round) then
			return true
		end
	end

	return false
end

function GMAct165EditView:isHasPreRound(round1, round2)
	if not LuaUtil.tableNotEmpty(round1) or not LuaUtil.tableNotEmpty(round2) then
		return false
	end

	for step, index in pairs(round1) do
		if round2[step] ~= index then
			return false
		end
	end

	return true
end

function GMAct165EditView:_removeCurStep(item)
	item.icon.color = Color.white
	item.isClick = false
	self._curround[item.step] = nil
	self.curStepItem = nil
	item.kwList = {}
	self._txtcurStepId.text = ""

	self:_showKw(item)
end

function GMAct165EditView:_showCurRound()
	self._txtcurround.text = self:_getRoundStr(self._curround)
end

function GMAct165EditView:_getRoundStr(round)
	local str = ""

	for step, info in pairs(round) do
		str = step == 1 and str .. self:_getStepIdAndKw(step, info.index, info.kws) or str .. "#" .. self:_getStepIdAndKw(step, info.index, info.kws)
	end

	return str
end

function GMAct165EditView:_getStepIdAndKw(step, index, kws)
	local id = self:_getStepId(step, index)
	local kwsStr = self:_getListStr(kws, "#")

	if not string.nilorempty(kwsStr) then
		return string.format("%s<color=#00FFE1><size=25>(%s)</color></size>", id, kwsStr)
	end

	return id
end

function GMAct165EditView:_showAllRound()
	self._roundItemList = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._allRoundCB, self._allround, self._goround.transform.parent.gameObject, self._goround)
end

function GMAct165EditView:_getSameRound(round)
	for index, _round in pairs(self._allround) do
		if self:_isSameTable(round, _round) then
			return index
		end
	end

	return -1
end

function GMAct165EditView:_allRoundCB(obj, data, index)
	local item = self:getUserDataTb_()

	item.btn = gohelper.findChildButtonWithAudio(obj, "txt/btn")
	item.txt = gohelper.findChildText(obj, "txt")
	item.txt.text = self:_getRoundStr(data)

	local function cb()
		self:_onClickDeleteBtn(index)
	end

	item.go = obj

	item.btn:AddClickListener(cb, self)

	self._roundItemList[index] = item
end

function GMAct165EditView:_onClickDeleteBtn(index)
	table.remove(self._allround, index)

	local item = self._roundItemList[index]

	gohelper.setActive(item.go, false)
	table.remove(self._roundItemList, index)
end

function GMAct165EditView:_isSameTable(round1, round2)
	local len1 = tabletool.len(round1)
	local len2 = tabletool.len(round2)

	if len1 ~= len2 then
		return false
	end

	for step, index in pairs(round1) do
		if index ~= round2[step] then
			return false
		end
	end

	return true
end

function GMAct165EditView:_createKwItem()
	self._kwItemList = self:getUserDataTb_()

	local list = {}

	for i = 1, self._kwCount do
		table.insert(list, i)
	end

	gohelper.CreateObjList(self, self._createKwItemCB, list, self._gokwitem.transform.parent.gameObject, self._gokwitem)
end

function GMAct165EditView:_createKwItemCB(obj, data, index)
	local item = self:getUserDataTb_()

	item.id = self._storyId * 100 + index
	item.isClick = false
	item.go = obj
	item.txt = gohelper.findChildText(obj, "txt")
	item.icon = gohelper.findChildImage(obj, "icon")
	item.btn = gohelper.findChildButtonWithAudio(obj, "btn")
	item.txt.text = item.id

	local function cb()
		self:_onClickKwItem(item)
	end

	item.btn:AddClickListener(cb, self)

	self._kwItemList[index] = item
end

function GMAct165EditView:_onClickKwItem(item)
	if not self.curStepItem then
		self:_showTip("未选择步骤")

		return
	end

	if self.curStepItem.step == self._stepCount then
		self:_showTip("结局不需要选关键词")

		return
	end

	if item.isClick then
		self:_removeKw(item)
	else
		self:_addKw(item)
	end
end

function GMAct165EditView:_addKw(item)
	item.icon.color = Color.yellow
	item.isClick = true

	if not LuaUtil.tableContains(self.curStepItem.kwList) then
		table.insert(self.curStepItem.kwList, item.id)

		self._curround[self.curStepItem.step].kws = self.curStepItem.kwList
	end

	self:_showKw(self.curStepItem)
	self:_showCurRound()
end

function GMAct165EditView:_removeKw(item)
	item.icon.color = Color.white
	item.isClick = false

	tabletool.removeValue(self.curStepItem.kwList, item.id)

	self._curround[self.curStepItem.step].kws = self.curStepItem.kwList

	self:_showKw(self.curStepItem)
	self:_showCurRound()
end

function GMAct165EditView:_refreshKwItem(item)
	for i, _item in pairs(self._kwItemList) do
		local isClick = LuaUtil.tableContains(item.kwList)

		if isClick then
			_item.icon.color = Color.yellow or Color.white
		end

		_item.isClick = isClick
	end
end

function GMAct165EditView:_showKw(item)
	if item then
		item.txtkw.text = self:_getListStr(item.kwList, "#")
	end
end

function GMAct165EditView:_showTip(tip)
	self._txttip.text = tip

	TaskDispatcher.cancelTask(self._hideTip, self)
	TaskDispatcher.runDelay(self._hideTip, self, 3)
end

function GMAct165EditView:_hideTip()
	self._txttip.text = ""
end

function GMAct165EditView:_activeRoundPanel(isActive)
	local posX = isActive and -960 or -2480

	transformhelper.setLocalPosXY(self._goscrollround.transform, posX, 540)

	self._isShowRoundPanel = isActive
end

function GMAct165EditView:_getListStr(list, symbol)
	local str = ""

	if list then
		for i, kw in pairs(list) do
			str = self:_getStr(str, i, kw, symbol)
		end
	end

	return str
end

function GMAct165EditView:_getStr(str, i, info, symbol)
	str = i == 1 and str .. info or str .. symbol .. info

	return str
end

function GMAct165EditView:_getConfig(step, index, rounds)
	local _ids = {}
	local nextStepInfo = {}
	local curid = self:_getStepId(step, index)

	for i, round in pairs(rounds) do
		local isCur = false
		local kws = {}

		_ids[i] = {}

		for _step, info in pairs(round) do
			if isCur then
				local id = self:_getStepId(_step, info.index)

				table.insert(_ids[i], 1, id)

				local _kws = nextStepInfo[id]

				if _kws then
					if not self:_isSameTable(_kws, kws) then
						local str = string.format("相同后置步骤选择的关键词不同：%s   %s   %s   %s", curid, id, self:_getListStr(kws, "#"), self:_getListStr(_kws, "#"))

						self:_showTip(str)
					end

					break
				end

				nextStepInfo[id] = kws

				break
			end

			if _step == step then
				isCur = true
				kws = info.kws
			else
				local id = self:_getStepId(_step, info.index)

				table.insert(_ids[i], id)
			end
		end
	end

	local str1 = ""

	for i, list in pairs(_ids) do
		local str2 = self:_getListStr(list, "#")

		str1 = self:_getStr(str1, i, str2, "|")
	end

	local str3 = ""
	local index = 1
	local kwIds = {}

	for id, list in pairs(nextStepInfo) do
		local str4 = id .. "#" .. self:_getListStr(list, "#")

		str3 = self:_getStr(str3, index, str4, "|")
		index = index + 1

		for _, kw in pairs(list) do
			if not LuaUtil.tableContains(kwIds, kw) then
				table.insert(kwIds, kw)
			end
		end
	end

	local nextStepConditionIds = "可跳转步骤的前置步骤要求:  " .. str1

	return curid, nextStepConditionIds
end

return GMAct165EditView

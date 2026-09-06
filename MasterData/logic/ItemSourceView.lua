-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemSourceView.lua

module("logic.extensions.material.view.ItemSourceView", package.seeall)

local ItemSourceView = class("ItemSourceView", TableViewComponent)

function ItemSourceView:ctor()
	ItemSourceView.super.ctor(self)
end

function ItemSourceView:_getPath()
	return {
		cellPath = "viewBgIma/goodsScrollGo/Cell",
		viewPath = "viewBgIma/goodsScrollGo/ScrollView"
	}
end

function ItemSourceView:bindEvents()
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function ItemSourceView:unbindEvents()
	self._customInput:RemoveListener()
end

function ItemSourceView:buildUI()
	ItemSourceView.super.buildUI(self)

	self.viewBgImaTran = self:getGo("viewBgIma"):GetComponent("RectTransform")
	self._customInput = UICustomInput.Get(self.viewBgImaTran.gameObject)
	self.goodsShowGo = self:getGo("viewBgIma/goodsShowGo")
	self._iconBgImg = goutil.findChild(self.goodsShowGo, "IconBg")

	local nameTxtGo = goutil.findChild(self.goodsShowGo, "TxtName")

	self._nameTxt = nameTxtGo:GetComponent("Text")
	self.group = nameTxtGo:GetComponent("UIChangeGroup")
	self._txtNum = goutil.findChild(self.goodsShowGo, "IconHas/Txt_Num"):GetComponent("Text")
	self.goodsScrollGo = self:getGo("viewBgIma/goodsScrollGo")
	self._goEmptyText = goutil.findChild(self.goodsScrollGo, "emptyText")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "viewBgIma/goodsShowGo/txtDesc")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "viewBgIma/goodsScrollGo/Text")
end

function ItemSourceView:_onCustomInputCallback(hover)
	if not hover then
		UIStateManager.instance:popByName(self._viewPresentor.viewName)
	end
end

function ItemSourceView:destroyUI()
	return
end

function ItemSourceView:onEnter()
	ItemSourceView.super.onEnter(self)

	self._curData = self._viewPresentor._openParam[1]
	self.isHideGoods = self._viewPresentor._openParam[2]
	self.jumpCallBack = self._viewPresentor._openParam[3]
	self._titleStr = self._viewPresentor._openParam[4] or "获取途径"
	self._txtTitle.text = self._titleStr

	if self._curData == nil then
		error("sr_道具来源   ItemSourceView:onEnter()     收到数据为空！")

		return
	end

	self:InitGoodsAndScorllView()
end

function ItemSourceView:onEnterFinished()
	return
end

function ItemSourceView:onExit()
	ItemSourceView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil
	self._curData = nil
end

function ItemSourceView:onExitFinished()
	ItemSourceView.super.onExitFinished(self)
end

function ItemSourceView:_cellSize()
	return 384, 64
end

function ItemSourceView:_updateBagBoxCell(cell, data)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn")
	local icon = goutil.findChild(cell, "Icon_Jian")
	local lock = goutil.findChild(cell, "lock")
	local desc = goutil.findChild(cell, "Txt_Desc"):GetComponent("Text")
	local TxtSortNum = goutil.findChild(cell, "TxtSortNum"):GetComponent("Text")
	local sweepBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "sweepBtn")
	local btnFight = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnFight")

	if cell.index == 0 then
		icon:SetActive(true)

		local img = Framework.ImageBigBG.Get(icon.gameObject)

		img:SetImage(langpath("ui/views/itembag/bb_tips_tj01.png"), nil)
		GameUtil.SetActive(TxtSortNum, false)
	else
		icon:SetActive(false)
		GameUtil.SetActive(TxtSortNum, true)
	end

	GameUtil.SetActive(lock, false)
	GameUtil.SetActive(sweepBtn, false)
	GameUtil.SetActive(btnFight, false)
	btn:RemoveClickListener()

	local matName = MaterialMgr.getMaterialsName(data.matType, data.matId)

	desc.text = string.format("背包-%s\n(库存：%s)", matName, data.matNum)
	TxtSortNum.text = string.format("%02d", cell.index + 1)

	btn:AddClickListener(function()
		self:_onClickBagBox(data)
	end, self)
end

function ItemSourceView:_updateCell(view, cell, data)
	if data.bagBox then
		self:_updateBagBoxCell(cell, data)

		return
	end

	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn")
	local icon = goutil.findChild(cell, "Icon_Jian")
	local lock = goutil.findChild(cell, "lock")
	local desc = goutil.findChild(cell, "Txt_Desc"):GetComponent("Text")
	local TxtSortNum = goutil.findChild(cell, "TxtSortNum"):GetComponent("Text")
	local sweepBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "sweepBtn")
	local btnFight = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnFight")

	if cell.index == 0 then
		icon:SetActive(true)

		local img = Framework.ImageBigBG.Get(icon.gameObject)

		img:SetImage(langpath("ui/views/itembag/bb_tips_tj01.png"), nil)
		GameUtil.SetActive(TxtSortNum, false)
	else
		icon:SetActive(false)
		GameUtil.SetActive(TxtSortNum, true)
	end

	local isOpen = self:getFuncIsOpen(data.funcId) and FuncOpenController.instance:checkOpenTime(data.openTime)
	local params = string.split(data.jumpTo, "#")
	local goKey = params[1]

	if goKey == "func" then
		local funcId = params[2]

		isOpen = isOpen and FuncOpenController.instance:getOtherReachedById(funcId)
	end

	local isLock = not isOpen

	GameUtil.SetActive(lock, isLock)
	GameUtil.SetActive(sweepBtn, false)
	GameUtil.SetActive(btnFight, false)
	MopupModel.instance:checkCanSweep(data.jumpTo, function(canSweep)
		if sweepBtn and not goutil.isNil(sweepBtn) then
			GameUtil.SetActive(sweepBtn, canSweep)
		end

		if not canSweep and not string.nilorempty(data.jumpTo) then
			local list = string.split(data.jumpTo, "#")
			local tag = list[1]

			if tag == "fb" then
				local isStageOpen = PlotCopyModel.instance:isStageUnlock(checknumber(list[2]), checknumber(list[3]))

				GameUtil.SetActive(btnFight, isStageOpen)
				GameUtil.SetActive(lock, isLock or not isStageOpen)
			end
		end
	end)
	btn:RemoveClickListener()
	sweepBtn:RemoveClickListener()
	btnFight:RemoveClickListener()

	desc.text = data.name
	TxtSortNum.text = string.format("%02d", cell.index + 1)

	btn:AddClickListener(function()
		self:_clickItem(data)
	end, self)
	sweepBtn:AddClickListener(function()
		self:_clickSweep(data)
	end, self)
	btnFight:AddClickListener(function()
		self:_clickFight(data)
	end, self)
end

function ItemSourceView:_clearTableview(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn")
	local sweepBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "sweepBtn")

	btn:RemoveClickListener()
	sweepBtn:RemoveClickListener()
end

function ItemSourceView:getFuncIsOpen(funcId)
	local arr = string.splitToNumber(funcId, "#")
	local boo = true

	for i, v in ipairs(arr) do
		if v > 0 then
			boo = boo and FuncOpenModel.instance:getFuncIsOpen(v)
		end
	end

	return boo
end

function ItemSourceView:_clickItem(data)
	local isOpen = self:getFuncIsOpen(data.funcId) and FuncOpenController.instance:checkOpenTime(data.openTime)

	if not string.nilorempty(data.jumpTo) then
		local list = string.split(data.jumpTo, "#")
		local tag = list[1]

		if tag == "fb" then
			isOpen = isOpen and PlotCopyModel.instance:isStageUnlock(checknumber(list[2]), checknumber(list[3]))
		end
	end

	local params = string.split(data.jumpTo, "#")
	local goKey = params[1]

	if goKey == "func" then
		local funcId = params[2]

		isOpen = isOpen and FuncOpenController.instance:getOtherReachedById(funcId)
	end

	local isLock = not isOpen

	if isLock then
		local isFound = false
		local arr = string.splitToNumber(data.funcId)

		for i, v in ipairs(arr) do
			if v > 0 and FuncOpenController.instance:checkFuncIdOrShowLockTips(v) == false then
				isFound = true

				break
			end
		end

		if isFound == false then
			FloatWordMgr.instance:show(data.lockedTips)
		end
	else
		local mo = MaterialModel.instance:createMo(self._curData.type, self._curData.id)

		GameUtil.callBack(self.jumpCallBack)
		self:_onClickClose()
		ViewAutoShowController.instance:saveCurModalView()
		GotoMgr.gotoByString(data.jumpTo, mo)
	end
end

function ItemSourceView:_clickSweep(data)
	MopupModel.instance:clickItemSourceSweep(data.jumpTo, self._curData.type, self._curData.id)
end

function ItemSourceView:_clickFight(data)
	self:_clickItem(data)
end

function ItemSourceView:_onClickBagBox(data)
	ItemBagController.instance:openUsePanel(data.mo)
	self:close()
end

function ItemSourceView:InitGoodsAndScorllView()
	local str = ""

	if self.isHideGoods then
		self.goodsShowGo:SetActive(false)

		self.viewBgImaTran.sizeDelta = Vector2.New(505, 480)

		Framework.TransformUtil.SetLocalPos(self.goodsScrollGo.transform, 0, 0, 0)

		str = self._curData
	else
		self.goodsShowGo:SetActive(true)

		self.viewBgImaTran.sizeDelta = Vector2.New(505, 625)

		Framework.TransformUtil.SetLocalPos(self.goodsScrollGo.transform, 0, -70, 0)

		str = self:ShowGoodsAndStr()
	end

	self._curViewDatas = {}

	local infos = string.split(str, ",")

	for k, v in pairs(infos or {}) do
		if checknumber(v) > 0 then
			local cf = ItemConfig.instance:getSourceCfg(checknumber(v))

			if cf == nil or not self:getFuncIsOpen(cf.funcId) and checknumber(cf.openType) == 1 then
				-- block empty
			else
				table.insert(self._curViewDatas, cf)
			end
		elseif v == "FROM_FB" and not self.isHideGoods then
			local plotArr = PlotCopyModel.instance:getSweepListByMat(checknumber(self._curData.type), checknumber(self._curData.id))

			for _k, _v in pairs(plotArr) do
				table.insert(self._curViewDatas, _v)
			end
		end
	end

	self:_insertBagCell()
	GameUtil.SetActive(self._goEmptyText, not self._curViewDatas or #self._curViewDatas <= 0)
	self._tableview:ReloadData()
end

function ItemSourceView:ShowGoodsAndStr()
	self.group:SetState(0)
	MaterialMgr.resetAll(self._iconBgImg)

	if self._curData.id == nil or self._curData.id < 0 then
		self._tableview.gameObject:SetActive(false)

		self._nameTxt.text = ""
		self._descTxt.text = ""
		self._txtNum.text = ""
		self._txtDesc.text = ""

		GameUtil.SetActive(self._goEmptyText, false)

		return
	end

	local cfg = MaterialMgr.getMatCfg(self._curData.type, self._curData.id)

	if cfg == nil then
		return
	end

	MaterialMgr.setCell(self._curData.type, self._curData.id, self._iconBgImg)

	self._nameTxt.text = MaterialMgr.getMaterialsName(self._curData.type, self._curData.id)
	self._txtDesc.text = cfg.desc

	local num = MaterialFacade.instance:getMatNumber(self._curData.type, self._curData.id)

	if self._curData.type == MatType.Diamond or self._curData.type == MatType.PayDiamond then
		num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()
	end

	self._txtNum.text = num < 0 and langPara("拥有<color=#c83c49>%s</color>个", num) or langPara("拥有%s个", num)

	if self._curData.type == MatType.PET_SKIN then
		local raceId = cfg.raceId
		local pp = MaterialMgr.getMatCfg(MatType.Pet, raceId)
		local rare = CharacterConfig.instance:getRareByAwakenLv(pp.initAwakenLv, raceId)

		self.group:SetState(1 + (rare or 0))

		self._txtNum.text = ""
	else
		self.group:SetState(1 + (cfg.quality or 0))
	end

	self._tableview.gameObject:SetActive(true)

	return cfg.source
end

function ItemSourceView:_onClickClose()
	self:close()
end

function ItemSourceView:_insertBagCell()
	if self.isHideGoods or not self._curData then
		return
	end

	local cfg = MaterialMgr.getMatCfg(self._curData.type, self._curData.id)

	if cfg == nil then
		return
	end

	local list = MaterialModel.instance:getMaterialsByTypeExceptSub(MatType.Item_GoodFeel) or {}
	local bagBoxList = {}

	for i, v in ipairs(list) do
		local type, id = v:getMatType(), v:getDefineId()
		local matCfg = MaterialMgr.getMatCfg(type, id)

		if matCfg and matCfg.useType == 1 then
			local useCfg = MaterialConfig.instance:getCfgByMatAndId(type, id)

			if useCfg and ItemBagController.instance:checkCanUseNotWithTips(useCfg) and self:_checkUseContentMatch(useCfg.content, self._curData.type, self._curData.id) then
				local hasNum = MaterialFacade.instance:getMatNumber(type, id)

				table.insert(bagBoxList, {
					bagBox = true,
					matType = type,
					matId = id,
					matNum = hasNum,
					mo = v
				})
			end
		end
	end

	table.sort(bagBoxList, function(a, b)
		return a.matNum < b.matNum
	end)

	for i, v in ipairs(bagBoxList) do
		table.insert(self._curViewDatas, 1, v)
	end
end

function ItemSourceView:_checkUseContentMatch(content, type, id)
	local match = string.match(content, string.format("^%s:%s:%%d+", type, id))

	match = match or string.match(content, string.format("[^%%d:]%s:%s:%%d+", type, id))

	return match
end

return ItemSourceView

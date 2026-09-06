-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stronger/view/StrongerView.lua

module("logic.extensions.stronger.view.StrongerView", package.seeall)

local StrongerView = class("StrongerView", ViewComponent)

function StrongerView:ctor()
	StrongerView.super.ctor(self)

	self._isFirst = true
	self._rightScrollView = StrongerScrollView.New()
end

function StrongerView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnCheck:AddClickListener(self._onClickCheck, self)
end

function StrongerView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
end

function StrongerView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._tableview = self:getGo("scrollView"):GetComponent("UITableview")
	self._tableCell = self:getGo("scrollView/itemCell")

	self._tableCell:SetActive(false)

	local rightTableView = self:getGo("right/rightScrollView"):GetComponent("UITableview")
	local rightTableCell = self:getGo("right/rightScrollView/rightCell")
	local rightTableCell2 = self:getGo("right/rightScrollView/rightCell2")

	self._rightScrollView:buildUI(rightTableView, rightTableCell, rightTableCell2)

	self._btnTip = self:getBtn("btnTip")
	self._btnCheck = self:getBtn("right/btnCheck")
	self._effectGo = self:getGo("right/btnCheck/effect")
end

function StrongerView:destroyUI()
	self._rightScrollView:destroyUI()

	self._rightScrollView = nil
end

function StrongerView:onEnter()
	self._isFirst = true

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	local petMo = BagModel.instance:getFirstPet()

	if not petMo then
		return
	end

	self._maxZdl = RoleModel.instance:getMaxPower()
	self.curPetMo = petMo
	self.maxPetMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(petMo.raceId)
	self._curViewDatas = {}

	local param = self:getFirstParam()

	if param then
		self._curSelectId = param
	end

	local cfgs = StrongerConfig.instance:getStrongerCfgs()

	for i, v in ipairs(cfgs) do
		self._curViewDatas[i] = {}
		self._curViewDatas[i].index = v.id
		self._curViewDatas[i].name = v.name
		self._curViewDatas[i].selected = v.id == self._curSelectId
		self._curViewDatas[i].isRec = self:_isRec(v.zdlRange)
	end

	self._tableview:ReloadData()
	self:_initRightScrollView(self._curSelectId)
	self:_loadEffect()
	HandbookController.instance:checkDataAndCall(function()
		self:_refreshPage(self._curSelectId)
	end)
end

function StrongerView:onExit()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
	self._rightScrollView:onExit()
	self:_removeEffect()
end

function StrongerView:_onClickClose()
	UIStateManager.instance:pop()
end

function StrongerView:_onClickTip()
	TipsFacade.instance:openRulesView("strongerview")
end

function StrongerView:_onClickCheck()
	FuncOpenController.instance:openFunc(331)
end

function StrongerView:_numInView()
	return #self._curViewDatas
end

function StrongerView:_cellSize()
	return 212, 78
end

function StrongerView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.data = index + 1

	self:_updateCell(view, cell, data)

	return cell
end

function StrongerView:_updateCell(view, cell, data)
	local txtName = goutil.findChild(cell, "btnClick/txtName"):GetComponent(goutil.Type_UIText)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")
	local imgSelected = goutil.findChild(cell, "btnClick/imgSelected")
	local rec = goutil.findChild(cell, "rec")

	goutil.setActive(rec, data.isRec)

	txtName.text = data.name

	if data.selected then
		txtName.color = Color.white or Color.New(0.14901960784313725, 0.18823529411764706, 0.2784313725490196, 1)
	end

	local outline = goutil.findChild(cell, "btnClick/txtName"):GetComponent("Outline")

	if outline then
		outline.effectColor = data.selected and parsecolor("#2e91d0") or parsecolor("#ebeff2")
	end

	goutil.setActive(imgSelected, data.selected)
	btnClick:AddClickListener(function()
		self:_setSelected(data.index)
		self:_refreshPage(data.index)
	end)
end

function StrongerView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick"):RemoveClickListener()
end

function StrongerView:_setSelected(index)
	self._curSelectId = index

	for i, v in ipairs(self._curViewDatas) do
		v.selected = v.index == index
	end

	self._tableview:ReloadData()
end

function StrongerView:_initRightScrollView(defaultSelected)
	local curViewDatas = {}
	local cfgs = StrongerConfig.instance:getStrongerPageCfgsById(defaultSelected)

	for i, v in ipairs(cfgs) do
		curViewDatas[i] = {}
		curViewDatas[i].cfg = v

		if defaultSelected == 1 then
			self:_setSliderData(curViewDatas[i])
		end
	end

	self._rightScrollView:onEnter(curViewDatas, self._updateCellCallBack, self)
end

function StrongerView:_refreshPage(index)
	local curViewDatas = {}
	local cfgs = StrongerConfig.instance:getStrongerPageCfgsById(index)

	for i, v in ipairs(cfgs) do
		curViewDatas[i] = {}
		curViewDatas[i].cfg = v

		if index == 1 then
			self:_setSliderData(curViewDatas[i])
		end
	end

	self._rightScrollView:refreshData(curViewDatas)
end

function StrongerView:_setSliderData(entity)
	local zdl = 0
	local maxZdl = 1
	local jumpId = entity.cfg.jumpId
	local cfg = HandbookConfig.instance:getPowerCheckDetailCfg(jumpId)

	if cfg then
		local attrMo = self.curPetMo.attrMo
		local attr = attrMo[cfg.value]
		local maxMo = self.maxPetMo.attrMo
		local attr2 = maxMo[cfg.value]

		if cfg.value == "assistAttr" then
			zdl = Mathf.Ceil(PetAssistModel.instance:GetTotalPowerCount() / 5)

			local count = #PetAssistConfig.instance:getPetTeamCfgs()

			maxZdl = Mathf.Ceil(AttrMo.calcFightPowerByAttrs(attr2))
		else
			zdl = AttrMo.calcFightPowerByAttrs(attr)
			maxZdl = AttrMo.calcFightPowerByAttrs(attr2)
		end

		entity.sliderValue = Mathf.Ceil(math.min(1, zdl / math.max(maxZdl, 1)) * 1000) / 1000
		entity.maxLvTxt = string.format("极限战力：%s", maxZdl)
	else
		local allPet, curValue = PetbookModel.instance:getFilterPetList()
		local maxValue = #allPet

		maxValue = maxValue > 0 and maxValue or 1

		printInfo("test 精灵数量", curValue, maxValue)

		entity.sliderValue = Mathf.Ceil(math.min(1, curValue / maxValue) * 1000) / 1000
		entity.maxLvTxt = "满图鉴"
	end
end

function StrongerView:_updateCellCallBack(view, cell, data)
	local icon = goutil.findChild(cell, "bg/icon")

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/stronger/%s.png", data.cfg.spritePath))

	local txtTitle = goutil.findChild(cell, "txtTitle"):GetComponent(goutil.Type_UIText)
	local txtDesc = goutil.findChild(cell, "txtDesc"):GetComponent(goutil.Type_UIText)
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")
	local rec = goutil.findChild(cell, "rec")

	goutil.setActive(rec, self:_isRec(data.cfg.zdlRange))

	txtTitle.text = data.cfg.title
	txtDesc.text = data.cfg.desc

	local goType = data.cfg.goType

	btnGo:AddClickListener(function()
		if goType == 1 then
			printInfo("viewname = " .. data.cfg.funcId)

			if tostring(data.cfg.param.viewName) == ViewName.IdleGame then
				self:_onClickClose()
				FuncOpenController.instance:openFunc(17)
			else
				local isOpen = FuncOpenModel.instance:getFuncIsOpen(data.cfg.funcId)

				if isOpen then
					self:_onClickClose()
				end

				if not string.nilorempty(data.cfg.param) then
					local num = tonumber(data.cfg.param)

					if num then
						FuncOpenController.instance:openFunc(data.cfg.funcId, num)
					else
						FuncOpenController.instance:openFunc(data.cfg.funcId, unpack(string.split(data.cfg.param, "#")))
					end
				else
					FuncOpenController.instance:openFunc(data.cfg.funcId)
				end
			end
		elseif goType == 2 then
			self:_onClickClose()

			local sceneId = checknumber(data.cfg.param)

			SceneFacade.instance:enterCityFromThisScene(sceneId)
		elseif goType == 0 then
			FloatWordMgr.instance:show("未指定操作")
		end
	end)

	if cell.tag == 101 then
		local slider = Framework.SliderAdapter.GetFrom(cell.gameObject, "progressBar")
		local txtMax = goutil.findChildTextComponent(cell, "txtMax")
		local txtPercent = goutil.findChildTextComponent(cell, "txtPercent")
		local component = goutil.findChild(cell, "progressBar/fillArea/fill"):GetComponent("UIImageColorChange")

		self:_setSliderColor(component, data.sliderValue)
		slider:SetValue(data.sliderValue)

		txtPercent.text = data.sliderValue * 100 .. "%"
		txtMax.text = data.maxLvTxt
	end
end

function StrongerView:_setSliderColor(colorChange, percent)
	colorChange:SetState(percent >= 0 and percent <= 0.25 and 0 or percent > 0.25 and percent <= 0.5 and 1 or percent > 0.5 and percent <= 0.75 and 2 or 3)
end

function StrongerView:_loadEffect()
	local path = "20211217/anniu/fx_ui_anniu.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._effectGo, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function StrongerView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function StrongerView:_isRec(zdlRange)
	if not string.nilorempty(zdlRange) then
		list = string.split(zdlRange, "#")

		if list and #list == 2 then
			return self._maxZdl >= checknumber(list[1]) and self._maxZdl <= checknumber(list[2])
		end
	end

	return false
end

return StrongerView

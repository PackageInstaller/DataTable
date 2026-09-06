-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/ItemGetView.lua

module("logic.extensions.itemget.ItemGetView", package.seeall)

local ItemGetView = class("ItemGetView", TableViewComponent)
local numRowsOrCols = 5

function ItemGetView:ctor()
	ItemGetView.super.ctor(self)
end

function ItemGetView:_getPath()
	return {
		cellPath = "container/tablecell",
		viewPath = "container/tableview"
	}
end

function ItemGetView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSkip:AddClickListener(self._onClickSkip, self)
	GameUtil.addClickHandler(self.btnOpen, self._onClickOpen, self)
end

function ItemGetView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnOpen)
end

function ItemGetView:buildUI()
	ItemGetView.super.buildUI(self)

	self._btnClose = self:getBtn("container/btnClose")
	self._container = self:getGo("container")
	self._animator = self._container:GetComponent("Animator")
	self._scrollRect = goutil.findChildComponent(self._container, "tableview", "ScrollRect")
	self._point_fangkuai = self:getGo("container/point_fangkuai")
	self._btnSkip = self:getBtn("container/btnSkip")
	self._gridLayout = goutil.findChildComponent(self._scrollRect.gameObject, "Viewport/Content", "GridLayoutGroup")
	self._rectLayout = self._gridLayout:GetComponent("RectTransform")

	goutil.setActive(self._container, false)

	self.btnOpen = self:getGo("container/btnOpen")
	self.txtExtraGetGo = self:getGo("container/txtExtraGet")

	GameUtil.SetActive(self.txtExtraGetGo, true)

	self.txtExtraGet = self:getTxt("container/txtExtraGet")
	self.titleImg = self:getGo("container/Gettip"):GetComponent("UIImageSpriteChange")
	self.titleImgBg = self:getGo("container/Gettip_02"):GetComponent("UIImageSpriteChange")
	self._imgTitle = self:getGo("container/Gettip"):GetComponent(goutil.Type_UIImage)
	self._imgTitleBg = self:getGo("container/Gettip_02"):GetComponent(goutil.Type_UIImage)
end

local effPaths = {
	{
		goPath = "container/point_bg",
		path = "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab"
	},
	{
		goPath = "container/point_huodejiangli",
		path = "fx_ui_huodejiangli/fx_ui_huodejiangli_liang.prefab"
	}
}

function ItemGetView:_buildEffects(callback)
	self._effs = {}

	for i, effPath in ipairs(effPaths) do
		local parent = self:getGo(effPath.goPath)
		local eff = UIEffectManager.instance:playHUDEffect(effPath.path, parent, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

			if i == #effPaths then
				self._animator:Rebind()
				GameUtil.callBack(callback)
			end
		end, nil, false)

		table.insert(self._effs, eff)
	end
end

function ItemGetView:onEnter()
	local openParam = self._viewPresentor._openParam

	self.goldCount = checknumber(openParam[2])

	local obj = openParam[1]
	local titleIdx = ItemGetController.instance:getTitleType(obj.ci)

	self.titleImg:SetState(titleIdx)
	self.titleImgBg:SetState(titleIdx)
	self._imgTitle:SetNativeSize()
	self._imgTitleBg:SetNativeSize()

	self._currItemData = obj.items

	if titleIdx == ItemGetController.TITLE_PRIZE then
		self:_buildEffects(GameUtil.handler(self._updateUI, self))
	else
		self._animator:Rebind()
		self:_updateUI()
	end

	settimer(1, self._enableSkip, self, false)
end

function ItemGetView:_enableSkip()
	self._canSkip = true
end

function ItemGetView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "fangkuai")
	local sptNumGo = goutil.findChild(container, "sptNumGo")
	local txtNum = goutil.findChildTextComponent(container, "txtNum")
	local txtName = goutil.findChildTextComponent(container, "txtName")
	local animator = container:GetComponent("Animator")
	local pointEff = goutil.findChild(container, "point_eff")
	local con = goutil.findChild(container, "con")
	local sptNumGo = goutil.findChild(container, "sptNumGo")
	local model = MaterialMgr.getModel(data.materialType, data.id)

	goutil.setActive(sptNumGo, model ~= nil)

	if model then
		local cfgId = model:getDefineId()
		local matType = data.materialType

		if matType == MatType.BorrowPet then
			matType = MatType.Pet
		end

		txtName.text = MaterialModel.instance:getMaterialsName(matType, cfgId)

		if data.materialType == MatType.Equipment then
			sptNumGo:SetActive(false)

			txtNum.text = ""

			GameUtil.SetActive(txtName, true)
		elseif data.materialType == MatType.PetTitle then
			sptNumGo:SetActive(false)

			txtNum.text = ""

			GameUtil.SetActive(txtName, false)
		else
			sptNumGo:SetActive(true)

			txtNum.text = data.num

			GameUtil.SetActive(txtName, true)
		end

		local proxy = MaterialMgr.setCellByData(data.materialType, model, con)

		if proxy then
			proxy.binder:setNum(0)

			if data.materialType == MatType.Pet then
				proxy.binder:setCallBack(function(petCell)
					CommonTipsMgr.instance:openMaterialTips(petCell, data.materialType, data.id)
				end)
			end
		end

		goutil.setActive(container, checknumber(self._curShowIndex) > #self._curViewDatas)

		animator.enabled = false

		Framework.TransformUtil.SetLocalScale(container.transform, 1, 1, 1)
		GoUtil.SetSortingOrder(pointEff, UGUIToolHelper.GetNodeCanvansSortingOrder(pointEff) + 1)
		goutil.setActive(pointEff, false)
	else
		MaterialMgr.resetAll(con)

		txtName.text = ""
		txtNum.text = ""

		if enableDebug then
			printError(">>>>>>>>>>>>>>>>>>>>>>>>看看是前端没先保存数据还是后端发了defineID | type and ID =>", data.materialType, data.id)
		end
	end
end

function ItemGetView:_updateUI()
	self.txtExtraGet.text = ""

	if self._currItemData == nil then
		return
	end

	if checknumber(self.goldCount) > 0 then
		self.txtExtraGet.text = langPara("成功购买%s金币，额外赠送：", self.goldCount)
		self.goldCount = nil
	end

	AudioPlayerEx.instance:playEffect(30216)
	goutil.setActive(self._container, true)

	self._curViewDatas = self._currItemData

	GameUtil.SetActive(self.btnOpen, false)

	self.boxItems = {}

	local tempCount = 0

	for i, v in ipairs(self._curViewDatas or {}) do
		if checknumber(v.materialType) == MatType.Item then
			local cfg = MaterialConfig.instance:getCfgByMatAndId(checknumber(v.materialType), checknumber(v.id))

			if cfg and cfg.materialValuable > 0 and (cfg.materialUseType == MatUseType.PACK or cfg.materialUseType == MatUseType.WEIGHT_PACK or cfg.materialUseType == MatUseType.MIX_SELECT) then
				tempCount = tempCount + 1

				local obj = self.boxItems[checknumber(v.id)]

				if obj then
					obj.num = obj.num + checknumber(v.num)
				else
					obj = {
						type = checknumber(v.materialType),
						id = checknumber(v.id),
						num = checknumber(v.num),
						useType = cfg.materialUseType
					}
					self.boxItems[checknumber(v.id)] = obj
				end
			end
		end
	end

	GameUtil.SetActive(self.btnOpen, tempCount > 0)

	self._curShowIndex = 0

	goutil.setActive(self._btnSkip.gameObject, true)

	self._scrollRect.enabled = false
	self._gridLayout.enabled = false

	self:reloadData()
end

function ItemGetView:_onReloadFinish()
	if checknumber(self._curShowIndex) == 0 then
		self._tableview:MoveCellInView(0, false)

		self._curShowIndex = 1

		if #self._curViewDatas > 0 then
			settimer(0.2, self._showItems, self, true)
		end
	end

	self:_updateTrans()
end

function ItemGetView:_updateTrans()
	local itemNums = #self._curViewDatas
	local canScroll = itemNums > numRowsOrCols * 2

	self._scrollRect.enabled = canScroll
	self._gridLayout.enabled = not canScroll

	Framework.TransformUtil.SetLocalPos(self._gridLayout.transform, canScroll and 0 or -147, canScroll and 0 or 11, 0)

	if not canScroll then
		self._rectLayout.sizeDelta = Vector2.New(680, 278)

		for i = 1, itemNums do
			local cell = self._tableview:GetCellAtIndex(i - 1)

			if cell ~= nil then
				cell.transform:SetSiblingIndex(i - 1)
			end
		end
	end
end

function ItemGetView:_showItems()
	local cell = self._tableview:GetCellAtIndex(self._curShowIndex - 1)

	if cell ~= nil then
		local container = goutil.findChild(cell.gameObject, "fangkuai")
		local animator = container:GetComponent("Animator")
		local pointEff = goutil.findChild(container, "point_eff")

		goutil.setActive(pointEff, true)
		goutil.setActive(container, true)

		local mask = ParticleMask.Get(pointEff)

		mask.viewSizeDeltaW = 0
		mask.viewSizeDeltaH = 0

		mask:SetScrollRect(self._scrollRect)

		animator.enabled = true
	end

	self._curShowIndex = self._curShowIndex + 1

	if self._curShowIndex > #self._curViewDatas then
		goutil.setActive(self._btnSkip.gameObject, false)
		removetimer(self._showItems, self)
	elseif self._curShowIndex > numRowsOrCols * 2 and self._curShowIndex % numRowsOrCols == 1 then
		self._tableview:MoveCellInView(self._curShowIndex - 1, true)
	end
end

function ItemGetView:_onClickOpen()
	local hasEff = false

	for i, v in pairs(self.boxItems or {}) do
		local cfg = MaterialConfig.instance:getCfgByMatAndId(checknumber(v.type), checknumber(v.id))

		if cfg and cfg.materialValuable == 1 then
			local timeOk = true

			if not string.nilorempty(cfg.useStartTime) then
				local nowTime = ServerTime.now()
				local useStartTime = GameUtil.string2time(cfg.useStartTime)

				if nowTime < useStartTime then
					timeOk = false
				end
			end

			if timeOk then
				hasEff = true

				break
			end
		end
	end

	if hasEff then
		UIStateManager.instance:open(ViewName.GiftbagopenView, function()
			self:sendOpen()
		end)
	else
		self:sendOpen()
	end
end

function ItemGetView:sendOpen()
	local items = {}
	local typeItems = {}
	local notOpenTimeTypeItems = {}
	local nowTime = ServerTime.now()
	local timeOk = true

	for i, v in pairs(self.boxItems or {}) do
		local cfg = MaterialConfig.instance:getCfgByMatAndId(checknumber(v.type), checknumber(v.id))

		timeOk = true

		if not string.nilorempty(cfg.useStartTime) then
			local useStartTime = GameUtil.string2time(cfg.useStartTime)

			if nowTime < useStartTime then
				timeOk = false
			end
		end

		if timeOk then
			if v.useType == MatUseType.MIX_SELECT then
				ItemGetController.instance:addMixItems(v)
			else
				typeItems[v.useType] = typeItems[v.useType] or {}

				table.insert(typeItems[v.useType], v)
			end
		else
			table.insert(notOpenTimeTypeItems, v)
		end
	end

	local maxCnt = 0

	for k, v in pairs(typeItems) do
		local cnt = #v

		if maxCnt < cnt then
			maxCnt = cnt
			items = v
		end
	end

	self.boxItems = nil

	if #notOpenTimeTypeItems > 0 then
		for i, v in ipairs(notOpenTimeTypeItems) do
			local cfg = MaterialConfig.instance:getCfgByMatAndId(checknumber(v.type), checknumber(v.id))
			local date = GameUtil.string2date(cfg.useStartTime)
			local str = string.format("[%s] %s年%s月%s日%s时%s分后可打开", cfg.materialName, date.year, date.month, date.day, date.hour, date.min)

			FloatWordMgr.instance:show(str)
		end
	end

	if #items > 0 then
		MaterialFacade.instance:batchUseItem(MatType.Item, items, "", function(msg)
			if checknumber(msg.changeSetId) > 0 then
				self:_onClickClose()
			end
		end)
	else
		self:_onClickClose()
	end
end

function ItemGetView:_onClickSkip()
	if self._canSkip ~= true then
		return
	end

	removetimer(self._showItems, self)
	goutil.setActive(self._btnSkip.gameObject, false)

	self._curShowIndex = #self._curViewDatas + 1

	if #self._curViewDatas > numRowsOrCols * 2 then
		self._scrollRect.enabled = false
		self._gridLayout.enabled = false

		self:reloadData()
		self._tableview:MoveCellInView(#self._curViewDatas - 1, false)
	else
		self:reloadData()
		self._gridLayout:CalculateLayoutInputHorizontal()
		self._gridLayout:CalculateLayoutInputVertical()
		self._gridLayout:SetLayoutHorizontal()
		self._gridLayout:SetLayoutVertical()
	end
end

function ItemGetView:onExit()
	self._currItemData = {}
	self._curViewDatas = {}

	self:reloadData()
	GameUtil.SetActive(self._container, false)
	GlobalDispatcher:dispatch(GlobalNotify.ItemGetViewDoClosed, 0)
	self._tableview:Travel(function(cell)
		local container = goutil.findChild(cell.gameObject, "fangkuai")
		local con = goutil.findChild(container, "con")

		MaterialMgr.resetAll(con)
	end, nil)

	if self._effs then
		for k, v in pairs(self._effs) do
			if self._effs[k] then
				UIEffectManager.instance:stopEffect(self._effs[k])

				self._effs[k] = nil
			end
		end
	end

	removetimer(self._enableSkip, self)
end

function ItemGetView:_onClickClose()
	if self._viewPresentor._availableToClose then
		self:_handleShowHightShow()

		if not self:_tryShowNextItem() then
			GlobalDispatcher:dispatch(GlobalNotify.OnMaterialPopEnd, MatType.Item)
			self:close()
			ItemGetController.instance:tryShowNexMixItems()
		end
	end
end

function ItemGetView:_tryShowNextItem()
	local itemSet = ItemGetController.instance:getItemSets()

	if itemSet and not itemSet:IsEmpty() then
		local obj = itemSet:PopFront()
		local titleIdx = ItemGetController.instance:getTitleType(obj.ci)

		self.titleImg:SetState(titleIdx)
		self.titleImgBg:SetState(titleIdx)

		self._currItemData = obj.items

		self._animator:Rebind()
		self:_updateUI()

		return true
	end
end

function ItemGetView:_handleShowHightShow()
	if self._currItemData then
		for i, v in ipairs(self._currItemData) do
			if v.materialType == MatType.Item then
				local cf = ItemConfig.instance:getCfgById(checknumber(v.id))

				if cf and cf.showType and cf.showType == 2 then
					local param = {}

					param.id = v.id
					param.materialType = v.materialType

					ItemGetController.instance:onAddHightItemShow(param)
				end
			end
		end

		self._currItemData = nil
	end

	ItemGetController.instance:onStartShowHightShow()
end

return ItemGetView

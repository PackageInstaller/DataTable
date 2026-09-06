-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessdelicacy/view/GoddessRecipeView.lua

module("logic.extensions.goddessdelicacy.view.GoddessRecipeView", package.seeall)

local GoddessRecipeView = class("GoddessRecipeView", TableViewComponent)

function GoddessRecipeView:ctor()
	GoddessRecipeView.super.ctor(self)

	self._itemListData = nil
	self._rewardEffList = nil
end

function GoddessRecipeView:bindEvents()
	GoddessRecipeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tableview:AddOnScrollValueChanged(self._onCellUpdatePosition, self)
end

function GoddessRecipeView:unbindEvents()
	GoddessRecipeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function GoddessRecipeView:onExit()
	GoddessRecipeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataGoddessDelicacyPrize, self._updateShowProgressBar, self)

	self._itemListData = nil

	for _, effGo in pairs(self._rewardEffList or {}) do
		if effGo then
			UIEffectManager.instance:stopEffect(effGo)
		end
	end

	self._rewardEffList = nil
end

function GoddessRecipeView:buildUI()
	GoddessRecipeView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "closeBtn")
	self._itemListSR = goutil.findChild(viewBgGo, "itemListSR"):GetComponent(ComponentType.UITableview)
	self._itemCell = goutil.findChild(viewBgGo, "itemGo")

	self._itemCell:SetActive(false)

	local downInfoGo = goutil.findChild(viewBgGo, "downInfoGo")

	self._srViewportTran = goutil.findChild(downInfoGo, "cellItemSR/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._haveTxt = goutil.findChildTextComponent(downInfoGo, "haveTxt")
	self._haveTxt.text = ""
	self.progBarGo = goutil.findChild(downInfoGo, "cellItemSR/Viewport/progBarGo/progBarSli")
	self.progBarSli = self.progBarGo:GetComponent("Slider")
	self.progBarSli.value = 0

	self:_registCallback()
end

function GoddessRecipeView:_registCallback()
	self._itemListSR:RegisterCallback(self._ItemInView, function()
		return 160, 168
	end, self._ItemAtIndex, self)
	self._itemListSR:RegisterUpdateCellCallback(self._OnItemCellUpdate)
end

function GoddessRecipeView:_ItemInView()
	if not self._itemListData then
		return 0
	end

	return #self._itemListData
end

function GoddessRecipeView:_ItemAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._itemCell)

	local data = self._itemListData[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateItemCell(view, cell, data)

	return cell
end

function GoddessRecipeView:_OnItemCellUpdate(view, cell)
	local index = cell.index
	local data = self._itemListData[index + 1]

	cell.data = index + 1

	self:_UpdateItemCell(view, cell, data)
end

function GoddessRecipeView:onEnter()
	GoddessRecipeView.super.onEnter(self)

	self._actId = self:getFirstParam()

	if checknumber(self._actId) <= 0 then
		self._actId = GoddessDelicacyConfig.instance:getOpenActivityId()
	end

	if checknumber(self._actId) <= 0 then
		printError("sr---美女美食 GoddessRecipeView:onEnter()   美食的活动时间错误 = " .. self._actId)

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataGoddessDelicacyPrize, self._updateShowProgressBar, self)

	self._itemListData, self._unlockCount = GoddessDelicacyModel.instance:getAllDelicacyCfgs(self._actId)

	self:_updateShowProgressBar()
	self._itemListSR:ReloadData()
end

function GoddessRecipeView:_updateShowProgressBar()
	self._curViewDatas = GoddessDelicacyModel.instance:getAllPrizeCfgs(self._actId)

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0

			if count <= 0 then
				self.progBarSli.value = 0
				self._haveTxt.text = langPara("text_goddess_desc_17", 0, 0)
			else
				local maxCount = self._curViewDatas[count].progress

				self.progBarSli.value = self._unlockCount / maxCount
				self._haveTxt.text = langPara("text_goddess_desc_17", self._unlockCount, maxCount)
			end

			self._tableview:ReloadData()

			local width = count * 120

			GameUtil.setWidth(self.progBarGo, width)

			if count == 0 or self._unlockCount <= 0 then
				self.progBarSli.value = 0

				return
			end

			local once = 1 / count
			local value = 0

			for i = 1, count do
				if self._curViewDatas[i] then
					if self._curViewDatas[i].progress <= self._unlockCount then
						value = value + once
					else
						local syc = 0

						if self._curViewDatas[i - 1] and self._curViewDatas[i - 1].progress > 0 then
							syc = self._curViewDatas[i - 1].progress
						end

						local temp = (self._unlockCount - syc) * once / (self._curViewDatas[i].progress - syc)

						value = value + temp

						break
					end
				end
			end

			self.progBarSli.value = value
		end
	end
end

function GoddessRecipeView:_onCellUpdatePosition(pos)
	local contentGo = self._tableview:GetContent()

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0
			local width = count * 120 + 60

			GameUtil.setWidth(contentGo, width)
			Framework.TransformUtil.SetLocalPos(self.progBarGo.transform, contentGo.transform.localPosition.x, -40, 0)
		end
	end
end

function GoddessRecipeView:_onReloadFinish()
	self:_onCellUpdatePosition()
end

function GoddessRecipeView:_getPath()
	return {
		cellPath = "viewBgGo/downInfoGo/cellItem",
		viewPath = "viewBgGo/downInfoGo/cellItemSR"
	}
end

function GoddessRecipeView:_cellSize()
	return 120, 100
end

function GoddessRecipeView:_updateCell(view, cell, data)
	local cellGoodsGo = goutil.findChild(cell, "cellGoodsGo")
	local cellCountTxt = goutil.findChildTextComponent(cell, "cellCountTxt")
	local cellLingquGo = goutil.findChild(cell, "cellLingquGo")
	local clickGo = goutil.findChild(cell, "clickGo")

	MaterialMgr.resetAll(cellGoodsGo)

	if self._rewardEffList and self._rewardEffList[cell] then
		UIEffectManager.instance:stopEffect(self._rewardEffList[cell])

		self._rewardEffList[cell] = nil
	end

	GameUtil.asBtn(clickGo):RemoveClickListener()
	MaterialMgr.setCellByCfg(data.progressPrize, cellGoodsGo)

	cellCountTxt.text = tostring(data.progress)

	GameUtil.SetActive(cellLingquGo, data.isFinish)

	local isFull = self._unlockCount >= data.progress

	if isFull and not data.isFinish then
		self._rewardEffList = self._rewardEffList or {}

		if not self._rewardEffList[cell] then
			local effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", cell.transform, 0, 0, true, false, nil, function(target, eff)
				eff:setClipping(self._srViewportTran)
			end)

			effect:setParent(cell.transform)
			effect:setScale(0.6)
			effect:setLocalPos(0, 10.5, 0)

			self._rewardEffList[cell] = effect
		end
	end

	if not isFull then
		GameUtil.SetActive(clickGo, false)

		return
	end

	GameUtil.SetActive(clickGo, true)
	GameUtil.asBtn(clickGo):AddClickListener(function()
		if data.isFinish then
			FloatWordMgr.instance:show(lang("text_goddess_desc_18"))

			return
		end

		if not isFull then
			FloatWordMgr.instance:show(lang("text_goddess_desc_19"))

			return
		end

		GoddessDelicacyController.instance:csRequestFoodNotesGainPrizeReq(self._actId, data.prizeId)
	end, self)
end

function GoddessRecipeView:_UpdateItemCell(view, cell, data)
	local goodsGo = goutil.findChild(cell, "goodsGo")
	local nameIma = goutil.findChild(cell, "nameIma"):GetComponent("UIImageSpriteChange")
	local nameTxt = goutil.findChildTextComponent(cell, "nameIma/nameTxt")
	local levelIma = goutil.findChild(cell, "levelIma"):GetComponent("UIImageSpriteChange")

	MaterialMgr.resetAll(goodsGo)
	GameUtil.asBtn(cell):RemoveClickListener()
	uGuiUtil.setSpriteToImage(goodsGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.icon))

	nameTxt.text = data.name

	nameIma:SetState(#data.foodIds - 2)
	levelIma:SetState(#data.foodIds - 2)

	if data.stage ~= GoddessDelicacyController.instance.unLockFinish then
		uGuiUtil.setTextGrayState(nameTxt.gameObject, true)
		uGuiUtil.setImageGrayState(nameIma.gameObject, true)
		uGuiUtil.setImageGrayState(levelIma.gameObject, true)
		uGuiUtil.setImageGrayState(goodsGo, true)
	else
		uGuiUtil.setTextGrayState(nameTxt.gameObject, false)
		uGuiUtil.setImageGrayState(nameIma.gameObject, false)
		uGuiUtil.setImageGrayState(levelIma.gameObject, false)
		uGuiUtil.setImageGrayState(goodsGo, false)
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		UIStateManager.instance:push(ViewName.GoddessContent, data)
	end, self)
end

return GoddessRecipeView

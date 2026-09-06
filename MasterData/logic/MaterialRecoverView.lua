-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialrecover/view/MaterialRecoverView.lua

module("logic.extensions.materialrecover.view.MaterialRecoverView", package.seeall)

local MaterialRecoverView = class("MaterialRecoverView", ViewComponent)

function MaterialRecoverView:buildUI()
	MaterialRecoverView.super.buildUI(self)

	self._node = self:getGo("node")
	self._nodeBonus = self:getGo("nodeBonus")
	self._tableview = self:getGo("node/tableview"):GetComponent(typeof(UITableviewForLua))
	self._tableCell = self:getGo("node/cell")
	self._refreshTime = self:getTxt("node/refreshTime")
	self._btnTips = self:getBtn("nodeBonus/btnTips")
	self._btnClose = self:getBtn("node/btnClose")
	self._togTip = self:getToggle("togTip")

	self._tableCell:SetActive(false)

	self._goldendiamond = self:getGo("node/goldendiamond")

	local tempClipRect = self:getGo("node/tempClipRect")

	if tempClipRect then
		self._tempClipRect = tempClipRect.transform
	end
end

function MaterialRecoverView:bindEvents()
	MaterialRecoverView.super.bindEvents(self)
	self._tableview:RegisterCallback(self._numCellsInTableview, self._cellSizeForIndex, self._tableCellAtIndex, self)
	self._btnTips:AddClickListener(self._onClickTips, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function MaterialRecoverView:unbindEvents()
	MaterialRecoverView.super.unbindEvents(self)
	self._tableview:UnRegisterAllCallbacks()
	self._btnTips:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function MaterialRecoverView:onEnter()
	MaterialRecoverView.super.onEnter(self)
	MaterialRecoverController.instance:requestAllInfos()
	GlobalDispatcher:addListener(GlobalNotify.OnResRecoverInfos, self._onResRecoverInfos, self)
	GlobalDispatcher:addListener(GlobalNotify.OnRecoverRes, self._onRecoverRes, self)
	self:_updateViewLayout()
	settimer(1, self._refreshRefreshCD, self)
	self:_refreshRefreshCD()
	self._tableview:SetOffsetWithoutRefresh(0)
	self:_refreshView()
	self._goldendiamond:SetActive(GoldenDiamondCardModel.instance.isUser)
	settimer(0, self._refreshItemEffects, self)
end

function MaterialRecoverView:onExit()
	MaterialRecoverView.super.onExit(self)
	removetimer(self._refreshRefreshCD, self)
	removetimer(self._refreshItemEffects, self)

	if not self._isBonusTab and self._togTip.isOn then
		MaterialRecoverController.instance:setHasShowUIOnEnterGame()
	end

	self._refreshTimeTamp = nil

	self._tableview:Travel(self._clearTableview, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnResRecoverInfos, self._onResRecoverInfos, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnRecoverRes, self._onRecoverRes, self)
end

function MaterialRecoverView:_updateViewLayout()
	self._isBonusTab = ViewMgr.instance:isOpen(ViewName.bonus)

	if self._isBonusTab then
		Framework.TransformUtil.SetLocalPos(self._node.transform, 0, 0, 0)
		self._nodeBonus:SetActive(true)
		self._btnClose.gameObject:SetActive(false)
		self._togTip.gameObject:SetActive(false)
	else
		self._btnClose.gameObject:SetActive(true)
		self._nodeBonus:SetActive(false)
		self._togTip.gameObject:SetActive(true)

		self._togTip.isOn = false

		Framework.TransformUtil.SetLocalPos(self._node.transform, -80, 40, 0)
	end
end

function MaterialRecoverView:_refreshRefreshCD()
	self._refreshTimeTamp = self._refreshTimeTamp or GameUtil.GetGameResetTimeStamp()

	local leftTime = math.max(0, self._refreshTimeTamp - ServerTime.nowMs() * 0.001)
	local hour, min, sec = GameUtil.getTimeHHMMSS(math.ceil(leftTime))
	local timeStr = string.format("%02d:%02d:%02d", hour, min, sec)

	self._refreshTime.text = string.format("资源刷新时间：%s", timeStr)

	if leftTime <= 0 then
		self._refreshTimeTamp = nil
	end
end

function MaterialRecoverView:_refreshItemEffects()
	return
end

function MaterialRecoverView:_numCellsInTableview()
	if not self._resRevocerInfos then
		return 0
	end

	return #self._resRevocerInfos
end

function MaterialRecoverView:_cellSizeForIndex(view, idx)
	return 1032, 106
end

function MaterialRecoverView:_tableCellAtIndex(view, idx)
	local cell = self._tableview:DequeueCell()

	cell = cell or self._tableview:AddChild(self._tableCell)

	local data = self._resRevocerInfos[idx + 1]
	local txtdDesc = goutil.findChildTextComponent(cell.gameObject, "txtdDesc")
	local txtTips = goutil.findChildTextComponent(cell.gameObject, "txtTips")
	local tagGo = goutil.findChild(cell.gameObject, "tag")
	local txtTag = goutil.findChildTextComponent(cell.gameObject, "tag/txt")
	local recoverCo = MaterialRecoverConfig.instance:getRecoverDefine(data.funType)

	LoginController.instance:checkConfig(recoverCo)

	txtdDesc.text = recoverCo.desc

	if txtTips then
		txtTips.text = "<color=#eb4642>" .. (recoverCo.tips or "") .. "</color>"
	end

	GameUtil.SetActive(tagGo, false)

	if not string.nilorempty(recoverCo.tag) then
		GameUtil.SetActive(tagGo, true)

		txtTag.text = recoverCo.tag
	end

	local emptyNode = goutil.findChild(cell.gameObject, "empty")
	local recoverableNode = goutil.findChild(cell.gameObject, "recoverable")

	emptyNode:SetActive(data.isEmpty or false)
	recoverableNode:SetActive(not data.isEmpty)

	if data.isEmpty then
		return cell
	end

	local txtCost = goutil.findChildTextComponent(cell.gameObject, "recoverable/txtCost")
	local over = goutil.findChild(cell.gameObject, "recoverable/over")

	self:_fillNormalBtn(cell, data)
	self:_fillPerfectBtn(cell, data)
	self:_fillResources(cell, data)
	self:_initItemDrag(cell)

	txtCost.text = tostring(data.price)

	over:SetActive(data.state == 2)
	txtCost.gameObject:SetActive(data.state ~= 2)

	if not string.nilorempty(recoverCo.tips) then
		Framework.TransformUtil.SetAnchoredPos(txtdDesc.transform, -384, 18)
	else
		Framework.TransformUtil.SetAnchoredPos(txtdDesc.transform, -384, 2)
	end

	return cell
end

function MaterialRecoverView:_fillResources(cell, data)
	local itemViewContent = goutil.findChild(cell.gameObject, "recoverable/tableview/Viewport/Content").transform
	local itemViewLayout = goutil.findChild(cell.gameObject, "recoverable/tableview/Viewport/Content/items")

	itemViewLayout = itemViewLayout:GetComponent(ComponentType.UILayoutSingleLine)

	if not data.sumMp then
		local prize = ""
		local awards = string.split(prize, "#")
		local transform = itemViewLayout.transform
		local childCount = transform.childCount
		local itemNum = #awards

		while childCount < itemNum do
			UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

			childCount = childCount + 1
		end

		for i = 1, itemNum do
			local data = awards[i]
			local go = transform:GetChild(i - 1).gameObject

			MaterialMgr.resetAll(go)
			MaterialMgr.setCellByCfg(data, go)
			go:SetActive(true)
		end

		for i = itemNum + 1, childCount do
			local go = transform:GetChild(i - 1).gameObject

			go:SetActive(false)
		end

		itemViewLayout:Layout()

		local sizeDelta = itemViewContent.sizeDelta

		sizeDelta.x = itemNum * 88
		itemViewContent.sizeDelta = sizeDelta
	end
end

function MaterialRecoverView:_initItemDrag(cell)
	local drag = self:_clearItemDrag(cell)

	drag:AddDragListener(self._onDrag, self)
	drag:AddBeginDragListener(self._onBeginDrag, self)
	drag:AddEndDragListener(self._onEndDrag, self)
end

function MaterialRecoverView:_clearItemDrag(cell)
	local itemViewContent = goutil.findChild(cell.gameObject, "recoverable/tableview")
	local drag = Framework.UIDragTrigger.Get(itemViewContent)

	drag:RemoveDragListener()
	drag:RemoveBeginDragListener()
	drag:RemoveEndDragListener()

	return drag
end

function MaterialRecoverView:_onDrag(eventData)
	if self._tableview then
		self._tableview:GetScrollRect():OnDrag(eventData)
	end
end

function MaterialRecoverView:_onBeginDrag(eventData)
	if self._tableview then
		self._tableview:GetScrollRect():OnBeginDrag(eventData)
	end
end

function MaterialRecoverView:_onEndDrag(eventData)
	if self._tableview then
		self._tableview:GetScrollRect():OnEndDrag(eventData)
	end
end

function MaterialRecoverView:_fillNormalBtn(cell, data)
	local btnNormal = Framework.ButtonAdapter.GetFrom(cell.gameObject, "recoverable/btnNormal")
	local normalTxt = goutil.findChildTextComponent(cell.gameObject, "recoverable/btnNormal/Text")
	local normalGraphic = btnNormal:GetComponent(goutil.Type_UIImage)

	btnNormal:RemoveClickListener()

	if data.state == 0 then
		GameUtil.setBtnState(btnNormal.gameObject, normalTxt, false)

		normalTxt.text = "免费找回"

		btnNormal:AddClickListener(function()
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format("本次免费找回只能找回%d%%的资源哦", MaterialRecoverConfig.instance:getRecoverNormalPercent()) .. "\n\n<color=#eb4642>用免费找回后，界面只显示可额外找回的资源，资源第二日5:00刷新。</color>", function()
				MaterialRecoverController.instance:requestGainMaterialRecover(data.funType, 1)
			end, function()
				return
			end, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
		end)

		normalGraphic.raycastTarget = true

		btnNormal.gameObject:SetActive(true)
	elseif data.state == 2 then
		btnNormal.gameObject:SetActive(false)
	else
		btnNormal.gameObject:SetActive(true)

		normalGraphic.raycastTarget = false
		normalTxt.text = "已找回"

		GameUtil.setBtnState(btnNormal.gameObject, normalTxt, true)
	end
end

function MaterialRecoverView:_fillPerfectBtn(cell, data)
	local blackline = goutil.findChild(cell.gameObject, "recoverable/blackline")
	local btnPerfect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "recoverable/btnPerfect")
	local btnGoldenDiamond = Framework.ButtonAdapter.GetFrom(cell.gameObject, "recoverable/btnGoldenDiamond")
	local perfectTxt = goutil.findChildTextComponent(cell.gameObject, "recoverable/btnPerfect/Text")
	local perfectGraphic = btnPerfect:GetComponent(goutil.Type_UIImage)
	local goldenDiamondGraphic = btnGoldenDiamond:GetComponent(goutil.Type_UIImage)

	btnGoldenDiamond:RemoveClickListener()
	btnPerfect:RemoveClickListener()

	if data.state ~= 2 then
		perfectTxt.text = "额外找回"

		GameUtil.setBtnState(btnPerfect.gameObject, perfectTxt, false)

		local function hanlder()
			local percent = MaterialRecoverConfig.instance:getRecoverPerfectPercent()

			if data.state ~= 0 then
				percent = percent - MaterialRecoverConfig.instance:getRecoverNormalPercent()
			end

			TipsFacade.instance:openPopupWindow(lang("tip"), string.format("本次额外找回%d%%的资源诶！", percent) .. "\n\n<color=#eb4642>若未使用免费找回，此次找回将同时领取免费找回资源。</color>", function()
				MaterialRecoverController.instance:requestGainMaterialRecover(data.funType, 2)
			end, function()
				return
			end, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
		end

		btnGoldenDiamond:AddClickListener(hanlder)
		btnPerfect:AddClickListener(hanlder)

		perfectGraphic.raycastTarget = true
		goldenDiamondGraphic.raycastTarget = true

		btnPerfect.gameObject:SetActive(not GoldenDiamondCardModel.instance.isUser)
		btnGoldenDiamond.gameObject:SetActive(GoldenDiamondCardModel.instance.isUser)
		blackline:SetActive(GoldenDiamondCardModel.instance.isUser)
	else
		btnPerfect.gameObject:SetActive(false)
		btnGoldenDiamond.gameObject:SetActive(false)
		blackline:SetActive(false)
	end
end

function MaterialRecoverView:_clearTableview(cell)
	local btnPerfect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "recoverable/btnPerfect")
	local btnNormal = Framework.ButtonAdapter.GetFrom(cell.gameObject, "recoverable/btnNormal")
	local btnGoldenDiamond = Framework.ButtonAdapter.GetFrom(cell.gameObject, "recoverable/btnGoldenDiamond")

	btnNormal:RemoveClickListener()
	btnPerfect:RemoveClickListener()
	btnGoldenDiamond:RemoveClickListener()

	local itemViewLayout = goutil.findChild(cell.gameObject, "recoverable/tableview/Viewport/Content/items")
	local childCount = itemViewLayout.transform.childCount - 1

	for i = 0, childCount do
		local go = itemViewLayout.transform:GetChild(i).gameObject

		MaterialMgr.resetAll(go)
	end

	self:_clearItemDrag(cell)
end

function MaterialRecoverView:_onResRecoverInfos()
	self:_refreshView()
end

function MaterialRecoverView:_onRecoverRes()
	self:_refreshView()
end

function MaterialRecoverView:_refreshView()
	self._resRevocerInfos = MaterialRecoverModel.instance:getAllRecoverInfos()

	if self._resRevocerInfos then
		table.sort(self._resRevocerInfos, function(x, y)
			if x.isEmpty and not y.isEmpty then
				return false
			end

			if not x.isEmpty and y.isEmpty then
				return true
			end

			if not x.isEmpty and not y.isEmpty then
				if x.state == 2 and x.state ~= y.state then
					return false
				end

				if y.state == 2 and x.state ~= y.state then
					return true
				end
			end

			return x.funType < y.funType
		end)
	end

	self._tableview:ReloadData()
end

function MaterialRecoverView:_onClickTips()
	TipsFacade.instance:openRulesView("resrecover")
end

function MaterialRecoverView:_onClickClose()
	self:close()
	FloatWordMgr.instance:show("可在福利功能再次进入资源找回界面")
end

return MaterialRecoverView

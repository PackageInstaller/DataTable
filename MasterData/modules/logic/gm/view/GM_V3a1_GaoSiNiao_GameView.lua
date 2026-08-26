-- chunkname: @modules/logic/gm/view/GM_V3a1_GaoSiNiao_GameView.lua

local ti = table.insert
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
local kYellow = "#FFFF00"
local kGreen = "#00FF00"
local kBlack = "#000000"

module("modules.logic.gm.view.GM_V3a1_GaoSiNiao_GameView", package.seeall)

local GM_V3a1_GaoSiNiao_GameView = class("GM_V3a1_GaoSiNiao_GameView", BaseView)

function GM_V3a1_GaoSiNiao_GameView.register()
	addGlobalModule("modules.logic.gm.gaosiniao.GaoSiNiaoBattleMapMO__Edit", "GaoSiNiaoBattleMapMO__Edit")
	GM_V3a1_GaoSiNiao_GameView.V3a1_GaoSiNiao_GameView_register(V3a1_GaoSiNiao_GameView)
	GM_V3a1_GaoSiNiao_GameView.V3a1_GaoSiNiao_GameView_BagItem_register(V3a1_GaoSiNiao_GameView_BagItem)
	GM_V3a1_GaoSiNiao_GameView.V3a1_GaoSiNiao_GameView_GridItem_register(V3a1_GaoSiNiao_GameView_GridItem)
end

local BtnTextView = _G.class("GM_V3a1_GaoSiNiao_GameView_BtnTextView", RougeSimpleItemBase)

function BtnTextView.ctor(selfObj, ctorParam)
	RougeSimpleItemBase.ctor(selfObj, ctorParam)

	selfObj._btnCmp = ctorParam.btnCmp
	selfObj._btnText = ctorParam.btnText
	selfObj._btnTrans = selfObj._btnCmp.transform
	selfObj._textTrans = selfObj._btnText.transform
end

function BtnTextView.addEvents(selfObj)
	selfObj._btnCmp:AddClickListener(selfObj._onClick, selfObj)
end

function BtnTextView.removeEvents(selfObj)
	selfObj._btnCmp:RemoveClickListener()
end

function BtnTextView._onClick(selfObj)
	local cb = selfObj._staticData.onClickCb

	if cb then
		selfObj._staticData.onClickCb(selfObj)
	end
end

function BtnTextView.setBtnWidth(selfObj, width)
	recthelper.setWidth(selfObj._btnTrans, math.max(100, width or 0))
end

function BtnTextView.setBtnHeight(selfObj, h)
	recthelper.setHeight(selfObj._btnTrans, math.max(100, h or 0))
end

function BtnTextView.setBtnTextColor(selfObj, hexColor)
	UIColorHelper.set(selfObj._btnText, hexColor)
end

function BtnTextView.setText(selfObj, desc)
	selfObj._btnText.text = desc
end

function BtnTextView._editableInitView(selfObj)
	RougeSimpleItemBase._editableInitView(selfObj)
	selfObj:setBtnWidth(169)

	selfObj._textTrans.anchorMin = Vector2.New(0, 0)
	selfObj._textTrans.anchorMax = Vector2.New(1, 1)

	recthelper.setAnchor(selfObj._textTrans, 0, 0)

	selfObj._textTrans.sizeDelta = Vector2.New(0, 0)

	selfObj:setBtnTextColor(kBlack)
end

local DropdownView = _G.class("GM_V3a1_GaoSiNiao_GameView_DropdownView", RougeSimpleItemBase)

function DropdownView.ctor(selfObj, ctorParam)
	RougeSimpleItemBase.ctor(selfObj, ctorParam)

	selfObj._btnCmp = ctorParam.btnCmp
	selfObj._btnText = ctorParam.btnText
	selfObj._btnTextGo = selfObj._btnText.gameObject
	selfObj._curSelectIndex = 0
	selfObj._valueList = {}
end

function DropdownView.addEvents(selfObj)
	selfObj._btnCmp:AddClickListener(selfObj._onClick, selfObj)
end

function DropdownView.removeEvents(selfObj)
	selfObj._btnCmp:RemoveClickListener()
end

function DropdownView._editableInitView(selfObj)
	RougeSimpleItemBase._editableInitView(selfObj)

	local imgGo = gohelper.create2d(selfObj.viewGO)
	local imgTrans = imgGo.transform
	local textGo = gohelper.clone(selfObj._btnTextGo, imgGo, "Dropdown Text")
	local textTrans = textGo.transform
	local img = gohelper.onceAddComponent(imgGo, gohelper.Type_Image)
	local dropDownText = gohelper.findChildText(textGo, "")

	imgTrans.pivot = Vector2.New(0.5, 1)

	UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, imgTrans, selfObj:transform())

	dropDownText.richText = true
	textTrans.anchorMin = Vector2.New(0, 0)
	textTrans.anchorMax = Vector2.New(1, 1)

	recthelper.setAnchor(textTrans, 0, 0)

	textTrans.sizeDelta = Vector2.New(0, 0)

	ZProj.UGUIHelper.SetColorAlpha(img, 0.5)
	UIColorHelper.set(dropDownText, kBlack)

	selfObj._imgGo = imgGo
	selfObj._imgTrans = imgTrans
	selfObj._dropDownText = dropDownText

	selfObj:setActive_imgTrans(false)
end

function DropdownView.optionCount(selfObj)
	return (selfObj._valueList or nil) and (#selfObj._valueList or 0)
end

function DropdownView.setOptionList(selfObj, valList, nameList)
	nameList = nameList or valList
	selfObj._valueList = valList or {}
	selfObj._nameList = nameList or {}
	selfObj._curSelectIndex = 0

	selfObj:onUpdateMO()
end

function DropdownView.setBtnDesc(selfObj, desc)
	selfObj._btnText.text = gohelper.getRichColorText(desc, kYellow)
end

function DropdownView.setData(selfObj)
	local sb = {}
	local selectedStr = "None"

	for i, str in ipairs(selfObj._nameList or {}) do
		if i - 1 == selfObj._curSelectIndex then
			selectedStr = str
			str = gohelper.getRichColorText(str, kGreen)
		end

		ti(sb, str)
	end

	selfObj._dropDownText.text = table.concat(sb, "\n")

	recthelper.setHeight(selfObj._imgTrans, selfObj._dropDownText.preferredHeight)

	if selfObj._curSelectIndex < 0 then
		selfObj:setBtnDesc("--")
	end
end

function DropdownView.setDropdownWidth(selfObj, width)
	recthelper.setWidth(selfObj._imgTrans, math.max(100, width or 0))
end

function DropdownView._onClick(selfObj)
	local cb = selfObj._staticData.onClickCb

	if cb then
		selfObj._staticData.onClickCb(selfObj)
	end
end

function DropdownView.isCapturing(selfObj)
	local p = selfObj:parent()

	return p:_gm_getCurSelectedDropdownView() == selfObj
end

function DropdownView.selectLast(selfObj)
	local N = selfObj:optionCount()
	local index = (selfObj._curSelectIndex + N - 1) % N

	selfObj:_onDropDownChange(index)

	return selfObj:getSelectedValue()
end

function DropdownView.selectNext(selfObj)
	local N = selfObj:optionCount()
	local index = (selfObj._curSelectIndex + 1) % N

	selfObj:_onDropDownChange(index)

	return selfObj:getSelectedValue()
end

function DropdownView._onDropDownChange(selfObj, index)
	local N = selfObj:optionCount()

	if N <= 0 then
		return
	end

	index = GameUtil.clamp(index, 0, N - 1)

	if selfObj._curSelectIndex == index then
		return
	end

	selfObj._curSelectIndex = index

	selfObj:onUpdateMO()
end

function DropdownView.selectNone(selfObj, expectSelectValue)
	selfObj._curSelectIndex = -1

	selfObj:refresh()
end

function DropdownView.selectByValue(selfObj, expectSelectValue)
	if expectSelectValue == nil then
		selfObj:selectNone()

		return
	end

	for i, value in ipairs(selfObj._valueList) do
		if value == expectSelectValue then
			selfObj._curSelectIndex = i - 1

			selfObj:refresh()

			return
		end
	end

	selfObj:selectNone()
end

function DropdownView.getSelectedValue(selfObj)
	return selfObj._valueList[selfObj._curSelectIndex + 1]
end

function DropdownView.setActive_imgTrans(selfObj, isActive)
	GameUtil.setActive01(selfObj._imgTrans, isActive)
end

function DropdownView.onDestroyView(selfObj, ...)
	RougeSimpleItemBase.onDestroyView(selfObj, ...)
end

function GM_V3a1_GaoSiNiao_GameView.V3a1_GaoSiNiao_GameView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "onDestroyView")

	function T._editableInitView(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_editableInitView", ...)
		selfObj:_gm_editableInitView()
		selfObj:_gm_onClickSwitchMode()
		UpdateBeat:Add(selfObj._gm_onUpdate, selfObj)
	end

	function T.addEvents(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "addEvents", ...)
		selfObj:_gm_addEvents()
	end

	function T.removeEvents(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "removeEvents", ...)
		selfObj:_gm_removeEvents()
	end

	function T.onDestroyView(selfObj, ...)
		selfObj:_gm_onDestroyView()
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onDestroyView", ...)
	end

	function T._gm_cloneMenuBtn(selfObj, goName, txtDesc)
		local btnGo = gohelper.clone(selfObj._gm_menuBtnSrcGo, selfObj._gm_menuRootGo, goName)
		local btnCmp = gohelper.findChildButtonWithAudio(btnGo, "")
		local btnText = gohelper.findChildText(btnGo, "txt_Reset")

		btnText.text = txtDesc or ""

		return btnCmp, btnGo, btnText
	end

	function T._gm_cloneHMenuBtn(selfObj, goName, txtDesc, offsetX)
		local btnCmp, btnGo, btnText = selfObj:_gm_cloneMenuBtn(goName, txtDesc)
		local btnTrans = btnGo.transform

		selfObj._gm_menuBtnPosOffsetX = selfObj._gm_menuBtnPosOffsetX - 160 + (offsetX or 0)

		local newPosX = recthelper.getAnchorX(btnTrans) + selfObj._gm_menuBtnPosOffsetX

		recthelper.setAnchorX(btnTrans, newPosX)

		return btnCmp, btnGo, btnText
	end

	function T._gm_cloneVMenuBtn(selfObj, goName, txtDesc, offsetY)
		local btnCmp, btnGo, btnText = selfObj:_gm_cloneMenuBtn(goName, txtDesc)
		local btnTrans = btnGo.transform

		selfObj._gm_menuBtnPosOffsetY = selfObj._gm_menuBtnPosOffsetY - 152 + (offsetY or 0)

		local newPosY = recthelper.getAnchorY(btnTrans) + selfObj._gm_menuBtnPosOffsetY

		recthelper.setAnchorY(btnTrans, newPosY)

		return btnCmp, btnGo, btnText
	end

	function T._gm_createDropdownView(selfObj, onClickCb, ...)
		local btnCmp, btnGo, btnText = selfObj:_gm_cloneHMenuBtn(...)
		local myDropdownView = DropdownView.New({
			parent = selfObj,
			baseViewContainer = selfObj.viewContainer,
			btnCmp = btnCmp,
			btnText = btnText,
			onClickCb,
			onClickCb
		})

		myDropdownView:init(btnGo)

		return myDropdownView
	end

	function T._gm_createBtnTextView_FixedZRot(selfObj, onClickCb)
		local btnCmp, btnText, rootGo = GMMinusModel.instance:_addBtnText(selfObj._gm_rotateEditRootGo)
		local myBtnText = BtnTextView.New({
			parent = selfObj,
			baseViewContainer = selfObj.viewContainer,
			btnCmp = btnCmp,
			btnText = btnText,
			onClickCb = onClickCb
		})

		myBtnText:init(rootGo)

		return myBtnText
	end

	function T._gm_editableInitView(selfObj, ...)
		GMMinusModel.instance:addBtnGM(selfObj)

		selfObj._gm_menuRootGo = gohelper.create2d(selfObj.viewGO, "=== Edit Menu(Right-Top) ===")
		selfObj._gm_menuBtnSrcGo = selfObj._btnreset.gameObject
		selfObj._gm_menuBtnPosOffsetX = 0
		selfObj._gm_menuBtnPosOffsetY = 0
		selfObj._gm_curSelectedDropdownView = nil
		selfObj._gm_editSelectedGridItemObjSet = selfObj:getUserDataTb_()
		selfObj._gm_saveMapBtn = selfObj:_gm_cloneHMenuBtn("=== GM Save Map===", luaLang("room_layoutplan_copy_btn_confirm_txt"))
		selfObj._gm_DumpBtn = selfObj:_gm_cloneVMenuBtn("=== GM Dump===", "Dump")

		gohelper.addChild(selfObj.viewGO, selfObj._gm_DumpBtn.gameObject)

		local gridTypeOps = {}
		local gridTypeOpsName = {}

		selfObj._gm_gridTypeDropdownView = selfObj:_gm_createDropdownView(function(obj)
			local p = obj:parent()

			p:_gm_selectDropdownMenuView(selfObj)
		end, "=== GM Grid GridType Dropdown ===", "Grid\nType Edit...", -10)

		selfObj._gm_gridTypeDropdownView:setDropdownWidth(200)

		for eName, eValue in pairs(GaoSiNiaoEnum.GridType) do
			if eValue ~= GaoSiNiaoEnum.GridType.__End then
				ti(gridTypeOps, eValue)
			end
		end

		table.sort(gridTypeOps, function(a, b)
			return a < b
		end)

		for _, eValue in ipairs(gridTypeOps) do
			ti(gridTypeOpsName, GaoSiNiaoEnum._edit_nameOfGridType(eValue))
		end

		selfObj._gm_gridTypeDropdownView:setOptionList(gridTypeOps, gridTypeOpsName)

		local gridPathSpriteOps = {}
		local gridPathSpriteOpsName = {}

		selfObj._gm_gridPathSpriteDropdownView = selfObj:_gm_createDropdownView("=== GM Grid Path Dropdown ===", "Grid\nPath Edit...", -50)

		selfObj._gm_gridPathSpriteDropdownView:setDropdownWidth(200)

		for eName, eValue in pairs(GaoSiNiaoEnum.PathSpriteId) do
			if eValue ~= GaoSiNiaoEnum.PathSpriteId.__End and eValue ~= GaoSiNiaoEnum.PathSpriteId.None then
				ti(gridPathSpriteOps, eValue)
			end
		end

		table.sort(gridPathSpriteOps, function(a, b)
			return a < b
		end)

		for _, eValue in ipairs(gridPathSpriteOps) do
			ti(gridPathSpriteOpsName, GaoSiNiaoEnum.rPathSpriteId[eValue])
		end

		selfObj._gm_gridPathSpriteDropdownView:setOptionList(gridPathSpriteOps, gridPathSpriteOpsName)

		selfObj._gm_simageMaskClick = gohelper.getClick(selfObj._simageMask.gameObject)
		selfObj._gm_simageFullBGClick = gohelper.getClick(selfObj._simageFullBG.gameObject)
		selfObj._gm_rotateEditRootGo = gohelper.create2d(selfObj.viewGO, "=== Edit Rotate(Mid-Right) ===")
		selfObj._gm_rotateZ0 = selfObj:_gm_createBtnTextView_FixedZRot(function(btnObj)
			local p = btnObj:parent()

			p:_gm_onClickFixedRot(0)
		end)

		selfObj._gm_rotateZ0:setText("0°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, selfObj._gm_rotateZ0:transform(), selfObj._gm_saveMapBtn.transform, 0, -20)

		selfObj._gm_rotateZ_90 = selfObj:_gm_createBtnTextView_FixedZRot(function(btnObj)
			local p = btnObj:parent()

			p:_gm_onClickFixedRot(-90)
		end)

		selfObj._gm_rotateZ_90:setText("-90°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.ML_L, selfObj._gm_rotateZ_90:transform(), selfObj._gm_rotateZ0:transform(), -20)

		selfObj._gm_rotateZ90 = selfObj:_gm_createBtnTextView_FixedZRot(function(btnObj)
			local p = btnObj:parent()

			p:_gm_onClickFixedRot(90)
		end)

		selfObj._gm_rotateZ90:setText("90°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, selfObj._gm_rotateZ90:transform(), selfObj._gm_rotateZ0:transform(), 0, -20)

		selfObj._gm_rotateZ180 = selfObj:_gm_createBtnTextView_FixedZRot(function(btnObj)
			local p = btnObj:parent()

			p:_gm_onClickFixedRot(180)
		end)

		selfObj._gm_rotateZ180:setText("180°")
		UIDockingHelper.setDock(UIDockingHelper.Dock.MB_D, selfObj._gm_rotateZ180:transform(), selfObj._gm_rotateZ_90:transform(), 0, -20)
	end

	function T._gm_onClickFixedRot(selfObj, zRot)
		selfObj:_gm_edit_selectedZRot(zRot)
	end

	function T._gm_edit_selectedZRot(selfObj, zRot)
		zRot = zRot % 360

		selfObj:_gm_edit_selectedProp("zRot", zRot)
	end

	function T._gm_edit_selectGridType(selfObj, eGridType)
		selfObj:_gm_edit_selectedProp("type", eGridType)
	end

	function T._gm_edit_selectPathType(selfObj, ePathType)
		selfObj:_gm_edit_selectedProp("ePathType", ePathType)
	end

	function T._gm_edit_selectedProp(selfObj, propName, propValue)
		for gridItemObj, isSelected in pairs(selfObj._gm_editSelectedGridItemObjSet) do
			if isSelected and gridItemObj then
				gridItemObj._mo[propName] = propValue

				gridItemObj:_gm_FlashHighLight()
			end
		end
	end

	function T._gm_addEvents(selfObj)
		GMMinusModel.instance:btnGM_AddClickListener(selfObj)
		selfObj._gm_saveMapBtn:AddClickListener(selfObj._gm_saveMapBtnOnClick, selfObj)
		selfObj._gm_DumpBtn:AddClickListener(selfObj._gm_DumpBtnOnClick, selfObj)
		selfObj._gm_simageMaskClick:AddClickListener(selfObj._gm_onClick_simageMaskClick, selfObj)
		selfObj._gm_simageFullBGClick:AddClickListener(selfObj._gm_onClick_simageMaskClick, selfObj)
		GM_V3a1_GaoSiNiao_GameViewContainer.addEvents(selfObj)
	end

	function T._gm_removeEvents(selfObj)
		GMMinusModel.instance:btnGM_RemoveClickListener(selfObj)
		selfObj._gm_saveMapBtn:RemoveClickListener()
		selfObj._gm_DumpBtn:RemoveClickListener()
		selfObj._gm_simageMaskClick:RemoveClickListener()
		selfObj._gm_simageFullBGClick:RemoveClickListener()
		GM_V3a1_GaoSiNiao_GameViewContainer.removeEvents(selfObj)
	end

	function T._gm_selectDropdownMenuView(selfObj, dropdownViewObj)
		if selfObj._gm_curSelectedDropdownView then
			selfObj._gm_curSelectedDropdownView:setActive_imgTrans(false)
		end

		selfObj._gm_curSelectedDropdownView = dropdownViewObj

		if dropdownViewObj then
			dropdownViewObj:setActive_imgTrans(true)
		end
	end

	function T._gm_getCurSelectedDropdownView(selfObj)
		return selfObj._gm_curSelectedDropdownView
	end

	function T._gm_onDestroyView(selfObj)
		UpdateBeat:Remove(selfObj._gm_onUpdate, selfObj)
		GameUtil.onDestroyViewMember(selfObj, "_gm_gridTypeDropdownView")
		GameUtil.onDestroyViewMember(selfObj, "_gm_gridPathSpriteDropdownView")
		GameUtil.onDestroyViewMember(selfObj, "_gm_rotateZ0")
		GameUtil.onDestroyViewMember(selfObj, "_gm_rotateZ90")
		GameUtil.onDestroyViewMember(selfObj, "_gm_rotateZ_90")
		GameUtil.onDestroyViewMember(selfObj, "_gm_rotateZ180")
	end

	function T._gm_onClickSwitchMode(selfObj)
		local isEditMode = GM_V3a1_GaoSiNiao_GameView.s_isEditMode

		GaoSiNiaoTesting.instance:cSwitchMode(isEditMode)
		selfObj:_gm_refresh()
	end

	function T._gm_refresh(selfObj)
		selfObj:_gm_refreshBagList()
		selfObj:_gm_refreshGridList()
		gohelper.setActive(selfObj._gm_menuRootGo, GM_V3a1_GaoSiNiao_GameView.s_isEditMode)
		gohelper.setActive(selfObj._gm_rotateEditRootGo, GM_V3a1_GaoSiNiao_GameView.s_isEditMode)
		selfObj:_gm_refreshActive_gridPathSpriteDropdownView()
	end

	function T._gm_refreshActive_gridPathSpriteDropdownView(selfObj)
		local eGridType = selfObj._gm_gridTypeDropdownView:getSelectedValue()
		local isActive = eGridType == GaoSiNiaoEnum.GridType.Path or eGridType == GaoSiNiaoEnum.GridType._edit_BagPath

		selfObj._gm_gridPathSpriteDropdownView:setActive(isActive)
	end

	function T._gm_refreshBagList(selfObj)
		selfObj._tmpBagDataList = nil

		selfObj:_refreshBagList()
	end

	function T._gm_refreshGridList(selfObj)
		selfObj._tmpGridDataList = nil

		selfObj:_refreshGridList()
	end

	function T._gm_saveMapBtnOnClick(selfObj)
		if not GM_V3a1_GaoSiNiao_GameView.s_isEditMode then
			logError("Invalid Operator: _gm_saveMapBtnOnClick")

			return
		end

		selfObj:_gm_selectDropdownMenuView(nil)

		local mapMO = selfObj.viewContainer:mapMO()

		mapMO:_edit_confirmSaveOrNot()
	end

	function T._gm_DumpBtnOnClick(selfObj)
		selfObj:_gm_selectDropdownMenuView(nil)

		local refStrBuf = {}

		GaoSiNiaoBattleModel.instance:dump(refStrBuf)
		logError(table.concat(refStrBuf, "\n"))
	end

	function T._gm_onUpdate(selfObj)
		if GM_V3a1_GaoSiNiao_GameView.s_isEditMode then
			return selfObj:_gm_edit_onUpdate()
		end

		local lCtrl = Input.GetKey(KeyCode.LeftControl)
		local rCtrl = Input.GetKey(KeyCode.RightControl)
		local ctrl = lCtrl or rCtrl

		if ctrl and Input.GetKeyDown(KeyCode.W) then
			selfObj:_dragContext():_critical_beforeClear()
			GaoSiNiaoController.instance:completeGame()
		end
	end

	function T._gm_edit_onUpdate(selfObj)
		local lAlt = Input.GetKey(KeyCode.LeftAlt)
		local rAlt = Input.GetKey(KeyCode.RightAlt)
		local lShift = Input.GetKey(KeyCode.LeftShift)
		local rShift = Input.GetKey(KeyCode.RightShift)
		local lCtrl = Input.GetKey(KeyCode.LeftControl)
		local rCtrl = Input.GetKey(KeyCode.RightControl)

		if selfObj._gm_curSelectedDropdownView then
			if Input.GetKeyDown(KeyCode.UpArrow) then
				local eValue = selfObj._gm_curSelectedDropdownView:selectLast()

				if selfObj._gm_gridTypeDropdownView:isCapturing() then
					selfObj:_gm_refreshActive_gridPathSpriteDropdownView()
				elseif selfObj._gm_gridPathSpriteDropdownView:isCapturing() then
					-- block empty
				end

				return
			elseif Input.GetKeyDown(KeyCode.DownArrow) then
				local eValue = selfObj._gm_curSelectedDropdownView:selectNext()

				if selfObj._gm_gridTypeDropdownView:isCapturing() then
					selfObj:_gm_refreshActive_gridPathSpriteDropdownView()
				elseif selfObj._gm_gridPathSpriteDropdownView:isCapturing() then
					-- block empty
				end

				return
			elseif Input.GetKeyDown(KeyCode.KeypadEnter) or Input.GetKeyDown(KeyCode.Return) or Input.GetKeyDown(KeyCode.Escape) then
				selfObj:_gm_selectDropdownMenuView(nil)

				return
			end
		end
	end

	function T._gm_onClick_simageMaskClick(selfObj)
		if Input.GetMouseButtonUp(0) then
			selfObj:_gm_selectDropdownMenuView(nil)
		end
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		return
	end

	function T._gm_reSeletedGridItemObj(selfObj, gridItemObj)
		local isSelected = selfObj._gm_editSelectedGridItemObjSet[gridItemObj]

		isSelected = isSelected == nil and true or not isSelected
		selfObj._gm_editSelectedGridItemObjSet[gridItemObj] = isSelected

		gridItemObj:onShowSelected(isSelected)

		local selectValue

		for _gridItemObj, _ in pairs(selfObj._gm_editSelectedGridItemObjSet) do
			local gtype = _gridItemObj:getType()

			if selectValue == nil then
				selectValue = gtype
			elseif selectValue ~= gtype then
				selectValue = false

				break
			end
		end

		if selectValue then
			selfObj._gm_gridTypeDropdownView:selectByValue(selectValue)
		else
			selfObj._gm_gridTypeDropdownView:selectNone()
		end

		selfObj:_gm_refreshActive_gridPathSpriteDropdownView()
	end

	function T._gm_singleSeletedGridItemObj(selfObj, gridItemObj)
		selfObj:_gm_clearAllSeletedGridItemObj()

		selfObj._gm_editSelectedGridItemObjSet[gridItemObj] = true

		gridItemObj:onShowSelected(true)
		selfObj._gm_gridTypeDropdownView:selectByValue(gridItemObj:getType())
		selfObj:_gm_refreshActive_gridPathSpriteDropdownView()
	end

	function T._gm_clearAllSeletedGridItemObj(selfObj)
		for gridItemObj, _ in pairs(selfObj._gm_editSelectedGridItemObjSet) do
			selfObj._gm_editSelectedGridItemObjSet[gridItemObj] = false

			gridItemObj:onShowSelected(false)
		end

		selfObj._gm_gridTypeDropdownView:selectNone()
		selfObj:_gm_refreshActive_gridPathSpriteDropdownView()
	end
end

function GM_V3a1_GaoSiNiao_GameView.V3a1_GaoSiNiao_GameView_BagItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_onBeginDrag")
	GMMinusModel.instance:saveOriginalFunc(T, "_onDragging")
	GMMinusModel.instance:saveOriginalFunc(T, "_onEndDrag")

	function T._editableInitView(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_editableInitView", ...)

		selfObj._gm_gocontentClick = gohelper.getClick(selfObj._gocontent)
	end

	function T.addEvents(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "addEvents", ...)
		selfObj._gm_gocontentClick:AddClickListener(selfObj._gm_onClick_gocontent, selfObj)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GameUtil.onDestroyViewMember_ClickListener(self, "_gm_gocontentClick")
	end

	function T._onBeginDrag(selfObj, dragObj, ...)
		if GM_V3a1_GaoSiNiao_GameView.s_isEditMode then
			return
		end

		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_onBeginDrag", dragObj, ...)
	end

	function T._onDragging(selfObj, dragObj, ...)
		if GM_V3a1_GaoSiNiao_GameView.s_isEditMode then
			return
		end

		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_onDragging", dragObj, ...)
	end

	function T._onEndDrag(selfObj, dragObj, ...)
		if GM_V3a1_GaoSiNiao_GameView.s_isEditMode then
			return
		end

		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_onEndDrag", dragObj, ...)
	end

	function T._gm_onClick_gocontent(selfObj)
		if not GM_V3a1_GaoSiNiao_GameView.s_isEditMode then
			return
		end

		local lAlt = Input.GetKey(KeyCode.LeftAlt)
		local rAlt = Input.GetKey(KeyCode.RightAlt)
		local alt = lAlt or rAlt
		local curCount = selfObj:getCount()

		curCount = alt and curCount - 1 or curCount + 1

		selfObj:setCount(math.max(curCount, 0))

		selfObj._mo.count = selfObj:getCount()
	end
end

function GM_V3a1_GaoSiNiao_GameView.V3a1_GaoSiNiao_GameView_GridItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_onBeginDrag")
	GMMinusModel.instance:saveOriginalFunc(T, "_onDragging")
	GMMinusModel.instance:saveOriginalFunc(T, "_onEndDrag")

	function T._editableInitView(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_editableInitView", ...)

		selfObj._gm_viewGOClick = gohelper.getClick(selfObj.viewGO)
	end

	function T.addEvents(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "addEvents", ...)
		selfObj._gm_viewGOClick:AddClickListener(selfObj._gm_onClick_viewGO, selfObj)
	end

	function T.removeEvents(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "removeEvents", ...)
		selfObj._gm_viewGOClick:RemoveClickListener()
	end

	function T._gm_onClick_viewGO(selfObj)
		if not GM_V3a1_GaoSiNiao_GameView.s_isEditMode then
			return
		end

		local lCtrl = Input.GetKey(KeyCode.LeftControl)
		local rCtrl = Input.GetKey(KeyCode.RightControl)
		local ctrl = lCtrl or rCtrl
		local p = selfObj:parent()

		if ctrl then
			p:_gm_reSeletedGridItemObj(selfObj)
		else
			p:_gm_singleSeletedGridItemObj(selfObj)
		end
	end
end

function GM_V3a1_GaoSiNiao_GameView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item2/Button")
	self._item2Btn_Text1Go = gohelper.findChild(self.viewGO, "viewport/content/item2/Button/Label1")
	self._item2Btn_Text2Go = gohelper.findChild(self.viewGO, "viewport/content/item2/Button/Label2")
	self._item3Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item3/Button")
end

function GM_V3a1_GaoSiNiao_GameView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Btn:AddClickListener(self._onItem2Click, self)
	self._item3Btn:AddClickListener(self._onItem3Click, self)
end

function GM_V3a1_GaoSiNiao_GameView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Btn:RemoveClickListener()
	self._item3Btn:RemoveClickListener()
end

function GM_V3a1_GaoSiNiao_GameView:onUpdateParam()
	self:refresh()
end

function GM_V3a1_GaoSiNiao_GameView:onOpen()
	self:onUpdateParam()
end

function GM_V3a1_GaoSiNiao_GameView:refresh()
	self:_refreshItem1()
	self:_refreshItem2()
	self:_refreshItem3()
end

function GM_V3a1_GaoSiNiao_GameView:onDestroyView()
	return
end

GM_V3a1_GaoSiNiao_GameView.s_ShowAllTabId = false

function GM_V3a1_GaoSiNiao_GameView:_refreshItem1()
	self._item1Toggle.isOn = GM_V3a1_GaoSiNiao_GameView.s_ShowAllTabId
end

function GM_V3a1_GaoSiNiao_GameView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_V3a1_GaoSiNiao_GameView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_GameView_ShowAllTabIdUpdate, isOn)
end

GM_V3a1_GaoSiNiao_GameView.s_isEditMode = false

function GM_V3a1_GaoSiNiao_GameView:_refreshItem2()
	local isEditMode = GM_V3a1_GaoSiNiao_GameView.s_isEditMode

	gohelper.setActive(self._item2Btn_Text1Go, not isEditMode)
	gohelper.setActive(self._item2Btn_Text2Go, isEditMode)
end

function GM_V3a1_GaoSiNiao_GameView:_onItem2Click()
	GM_V3a1_GaoSiNiao_GameView.s_isEditMode = not GM_V3a1_GaoSiNiao_GameView.s_isEditMode

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_GameView_OnClickSwitchMode)
	self:_refreshItem2()
end

function GM_V3a1_GaoSiNiao_GameView:_refreshItem3()
	return
end

function GM_V3a1_GaoSiNiao_GameView:_onItem3Click()
	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_GameView_OnClickDump)
end

return GM_V3a1_GaoSiNiao_GameView

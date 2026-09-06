-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowStarGodStack.lua

module("logic.extensions.bag.panel.stack.PetShowStarGodStack", package.seeall)

local PetShowStarGodStack = class("PetShowStarGodStack", ViewComponent)

function PetShowStarGodStack:ctor()
	PetShowStarGodStack.super.ctor(self)
end

function PetShowStarGodStack:bindEvents()
	self._stargodButton:AddClickListener(self._onClickStarGod, self)
	self._redButton:AddClickListener(self._onClickRed, self)
	self._sortButton:AddClickListener(self._onClickSort, self)
	self._diffButton:AddClickListener(self._onClickDiff, self)
	self._oneKeyButton:AddClickListener(self._onClickOnekey, self)
	self._huntButton:AddClickListener(self._onClickHunt, self)
	self._searchText:AddOnValueChanged(self._onClickSearch, self)
	self.btnRtn:AddClickListener(self.onTabClick, self)
	StarGodNotify.addListener(StarGodNotify.OnBagInfoChanged, self._refreshBag, self)
	StarGodNotify.addListener(StarGodNotify.OnClickStarGod, self._selectChanged, self)
end

function PetShowStarGodStack:unbindEvents()
	self._stargodButton:RemoveClickListener()
	self._redButton:RemoveClickListener()
	self._sortButton:RemoveClickListener()
	self._diffButton:RemoveClickListener()
	self._oneKeyButton:RemoveClickListener()
	self._huntButton:RemoveClickListener()
	self.btnRtn:RemoveClickListener()
	self._searchText:RemoveOnValueChanged()
	StarGodNotify.removeListener(StarGodNotify.OnBagInfoChanged, self._refreshBag, self)
	StarGodNotify.removeListener(StarGodNotify.OnClickStarGod, self._selectChanged, self)
end

function PetShowStarGodStack:buildUI()
	self._sortButton = self:getBtn("BagList/top/BtnSort")
	self._bagInfoText = self:getGo("BagList/top/ImgNumBg/TxtNum"):GetComponent("Text")
	self._stargodButton = self:getBtn("BagList/top/btnGod")
	self._redButton = self:getBtn("BagList/top/btnRed")
	self.btn1 = goutil.findChild(self.mainGO, "BagList/top/btnGod"):GetComponent("UIChangeGroup")
	self.btn2 = goutil.findChild(self.mainGO, "BagList/top/btnRed"):GetComponent("UIChangeGroup")
	self._diffButton = self:getBtn("BagList/top/BtnDiff")
	self._oneKeyButton = self:getBtn("BagList/top/BtnOneKey")
	self._huntButton = self:getBtn("BagList/top/BtnHunt")
	self._searchText = self:getInput("BagList/top/TweensNode/Search")
	self._tableview = self:getGo("BagList/top/TweensNode/ScrollView"):GetComponent("UITableview")
	self._tableCell = self:getGo("Cell")
	self._sortOpText = goutil.findChild(self._sortButton.gameObject, "text"):GetComponent("Text")
	self._diffOpText = goutil.findChild(self._diffButton.gameObject, "text"):GetComponent("Text")
	self.btnRtn = self:getBtn("BagList/imgStargod")

	self._tableCell:SetActive(false)
end

function PetShowStarGodStack:destroyUI()
	self:unbindEvents()
end

function PetShowStarGodStack:onEnter()
	self._curViewDatas = {}
	self._isRed = false
	self._curSortCfg = 1
	self._curDiffCfg = 1
	self._curSelectId = -1
	self._uiCanvas = Framework.UIGlobalTouchTrigger.uiCanvas

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterUpdateCellCallback(self._onCellUpdate)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	self._tableview:RegisterDraggingCallback(self.onDragCellAvailable, self.onDragCellStarted, self.onDragCellMoved, self.onDragCellEnded, self.cloneDraggingObject, self)
	self:initPopCfg()
	self:_onChangeBag(false)
	self:_onPopupMenuSelectSortIndex(1)
	self:showEffect()

	if not StarGodModel.instance:isDataInited() then
		StarGodAgent.instance:sendLoadStarGodReq()
	end

	StarGodNotify.addListener(StarGodNotify.OnPickUp, self._onPickUp, self)
end

function PetShowStarGodStack:showEffect()
	if self:getGo("BagList/imgStargod/progressBar") then
		self.txtStargod = self:getTxt("BagList/imgStargod/txt")
		self._Slider_Stargod = self:getGo("BagList/imgStargod/progressBar"):GetComponent(typeof(ProgressBar))

		local effect = self:getGo("BagList/imgStargod/progressBar/Mask/imgTop/effect")
		local effectMaxLv = self:getGo("rigBagListht/imgStargod/progressBar/Mask/effectMaxLv")
		local maskRect = goutil.findChild(self._Slider_Stargod, "Mask"):GetComponent(goutil.Type_RectTransform)

		BagPetsFacade._loadEffect(self, effect.transform, "fx_ui_zhandoujiesuan/fx_ui_jingyan_mask.prefab", 1, maskRect)
		BagPetsFacade._loadEffect(self, effect.transform, "fx_ui_zhandoujiesuan/fx_ui_jingyan_nomask.prefab", 1, maskRect)
	end
end

function PetShowStarGodStack:_onPickUp(preIdList, collectids, fusionids)
	self:_onChangeBag(self._isRed)
end

function PetShowStarGodStack:onDragCellAvailable(container, cell)
	local obj = goutil.findChild(cell, "StarGod")

	return not self._isRed and obj.activeInHierarchy
end

function PetShowStarGodStack:onDragCellStarted()
	self._draggingObj.gameObject.transform.localScale = Vector3.New(1, 1, 1)
end

function PetShowStarGodStack:onDragCellMoved(vec2, vec3)
	local rate = 1
	local dy = 0
	local dx = 0
	local d = UnityEngine.Screen.width / UnityEngine.Screen.height

	if d > 2 then
		dx = 80
	end

	if d < 1.7777777778 then
		rate = 1280 / UnityEngine.Screen.width
		dy = (UnityEngine.Screen.height - 720 / (1280 / UnityEngine.Screen.width)) * 0.5
	else
		rate = 720 / UnityEngine.Screen.height
	end

	self._draggingObj.transform.localPosition = Vector3.New(vec3.x * rate - dx, (vec3.y - dy) * rate, 0)

	return true
end

function PetShowStarGodStack:onDragCellEnded(sContainer, cell, endContainer)
	if endContainer ~= nil then
		if endContainer.gameObject.name == "Container" then
			if endContainer.data ~= cell.data then
				local data1 = StarGodModel.instance:getUsualInfos(cell.data)
				local data2 = StarGodModel.instance:getUsualInfos(endContainer.data)

				if data2.place == 2 then
					FloatWordMgr.instance:show(lang("锁定的星辉不能被吞噬"))
				else
					TipsFacade.instance:openPopupWindow(lang("tip"), langPara("stargod_swallow", data1.name .. "Lv" .. data1.level, data2.name .. "Lv" .. data2.level, data2.exp + data2.baseExp), function()
						StarGodBagCtrl.instance:freeStarGodFusion(cell.data, {
							endContainer.data
						})
					end)
				end
			end
		elseif endContainer.gameObject.name == "EqpContainer" then
			StarGodModel.instance:setEquipingStarGod(cell.data)
			StarGodBagCtrl.instance:doEquipLogic(endContainer.data)
		end
	end

	return true
end

function PetShowStarGodStack:cloneDraggingObject(container, cell)
	local con = goutil.findChild(cell, "StarGod/con")
	local icon = GameUtil.findChildEx(con, "Icon")

	self._draggingObj = icon and goutil.clone(icon) or goutil.clone(con)

	return self._draggingObj
end

function PetShowStarGodStack:initPopCfg()
	self._sortPopConfig = {
		"品质从高到低",
		"品质从低到高",
		"等级从高到低",
		"等级从低到高"
	}
	self._diffPopConfig = {
		"全部",
		"迷你星元",
		"小星元",
		"大星元",
		"无敌星元",
		"超级星元"
	}
end

function PetShowStarGodStack:onTabClick()
	GlobalDispatcher:dispatch(GlobalNotify.PET_VIEW_CHANGE_TAB, PetShowView.TAB_INFO)
end

function PetShowStarGodStack:_getItemDataByFunc(func, isRed)
	local datas = StarGodModel.instance:getBagStarGods(isRed)
	local count = #datas

	self._curViewDatas = {}

	for i = 1, count do
		if func(datas[i]) then
			table.insert(self._curViewDatas, datas[i])
		end
	end

	local cnt, cap = StarGodModel.instance:getBagInfo(isRed)

	while count < 12 or count % 3 ~= 0 do
		table.insert(self._curViewDatas, {})

		count = count + 1
	end
end

function PetShowStarGodStack:_numInView()
	return #self._curViewDatas
end

function PetShowStarGodStack:_cellSize()
	return 90, 90
end

function PetShowStarGodStack:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1

	self:_updateCell(view, cell, data)

	return cell
end

function PetShowStarGodStack:_onCellUpdate(view, cell)
	local idx = cell.index
	local data = self._curViewDatas[idx + 1]

	cell.data = idx + 1

	self:_updateCell(view, cell, data)
end

function PetShowStarGodStack:_updateCell(view, cell, data)
	local obj = goutil.findChild(cell, "StarGod")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	if data.defineId then
		local lockObj = goutil.findChild(cell, "StarGod/Lock")
		local container = goutil.findChild(cell, "StarGod/Container"):GetComponent("UIDragContainer")
		local con = goutil.findChild(cell, "StarGod/con")

		obj:SetActive(true)
	else
		btn:RemoveClickListener()
		obj:SetActive(false)
	end
end

function PetShowStarGodStack:_clearTableview(cell)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
end

function PetShowStarGodStack:_selectItem(id)
	StarGodNotify.dispatch(StarGodNotify.OnClickStarGod, id, false, self._isRed)
end

function PetShowStarGodStack:_onReloadFinish()
	return
end

function PetShowStarGodStack:onEnterFinished()
	self:_refreshBag()
end

function PetShowStarGodStack:onExit()
	self._firstLoadList = nil
	self._curViewDatas = {}

	self._tableview:Travel(self._clearTableview, self)
	StarGodNotify.removeListener(StarGodNotify.OnPickUp, self._onPickUp, self)
end

function PetShowStarGodStack:onExitFinished()
	return
end

function PetShowStarGodStack:_OnMenuCloseSort()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._onPopupMenuSelectSortIndex, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseSort, self)
end

function PetShowStarGodStack:_onClickSort()
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseSort, self)
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnPopupClick, self._onPopupMenuSelectSortIndex, self)

	local t = {}

	for i, name in ipairs(self._sortPopConfig) do
		t[i] = {
			name = name,
			value = i
		}
	end

	CommonPopupMenuFacade.instance:OpenView(self._sortButton.transform.position, t)
end

function PetShowStarGodStack:_OnMenuCloseDiff()
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnPopupClick, self._onPopupMenuSelectDiffIndex, self)
	CommonPopupMenuFacade.instance:removeListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseDiff, self)
end

function PetShowStarGodStack:_onClickDiff()
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnViewClose, self._OnMenuCloseDiff, self)
	CommonPopupMenuFacade.instance:addListener(CommonPopupMenuFacade.OnPopupClick, self._onPopupMenuSelectDiffIndex, self)

	local t = {}

	for i, name in ipairs(self._diffPopConfig) do
		t[i] = {
			name = name,
			value = i
		}
	end

	CommonPopupMenuFacade.instance:OpenView(self._diffButton.transform.position, t)
end

function PetShowStarGodStack:_onPopupMenuSelectSortIndex(idx)
	self._curSortCfg = idx

	self:_onSortCfgChanged()
end

function PetShowStarGodStack:_onSortCfgChanged()
	self._sortOpText.text = self._sortPopConfig[self._curSortCfg]

	self:_getItemDataByFunc(function()
		return true
	end, self._isRed)
	StarGodBagCtrl.instance:sortDataByQulityAndLevel(self._curViewDatas)
	self._tableview:ReloadData()
end

function PetShowStarGodStack:_onPopupMenuSortCloseHandler()
	return
end

function PetShowStarGodStack:_onPopupMenuSelectDiffIndex(idx)
	self._curDiffCfg = idx

	self:_onDiffCfgChanged()
end

function PetShowStarGodStack:_onDiffCfgChanged()
	self._diffOpText.text = self._diffPopConfig[self._curDiffCfg]

	self:_getItemDataByFunc(function(data)
		return self._curDiffCfg == 1 or data.defineId == 99 + self._curDiffCfg
	end, self._isRed)
	StarGodBagCtrl.instance:sortDataByQulityAndLevelForStarUnit(self._curViewDatas)
	self._tableview:ReloadData()
end

function PetShowStarGodStack:_onPopupMenuDiffCloseHandler()
	return
end

function PetShowStarGodStack:_onChangeBag(isRed)
	self._isRed = isRed

	local cap, cnt = StarGodModel.instance:getBagInfo(isRed)

	self._bagInfoText.text = cap .. "/" .. cnt

	if isRed then
		self.btn1:SetState(1)
		self.btn2:SetState(0)
		self:_onDiffCfgChanged()
	else
		self.btn1:SetState(0)
		self.btn2:SetState(1)
		self:_onSortCfgChanged()
	end

	self:_onClickChange()
end

function PetShowStarGodStack:_selectChanged(id)
	self._curSelectId = id

	self._tableview:Refresh()
end

function PetShowStarGodStack:_refreshBag()
	self:_onChangeBag(self._isRed)
end

function PetShowStarGodStack:_showStarGodByName(name)
	local datas = StarGodModel.instance:getBagStarGods(self._isRed)
	local count = #datas

	self._curViewDatas = {}

	for i = 1, count do
		local cfg = StarGodConfig.instance:getCfgByDefineId(datas[i].defineId)

		if cfg ~= nil then
			local str = GameUtil.filter_spec_chars(name)

			if string.find(cfg.name, str) then
				self._curViewDatas[#self._curViewDatas + 1] = datas[i]
			end
		end
	end

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
end

function PetShowStarGodStack:_onClickSearch()
	local text = self._searchText:GetText()

	if not text or #text == 0 then
		self:_onChangeBag(self._isRed)

		return
	end

	self:_showStarGodByName(text)
end

function PetShowStarGodStack:_onClickOnekey()
	StarGodBagCtrl.instance:oneKeyFusion(self._isRed)
end

function PetShowStarGodStack:_onClickHunt()
	return
end

function PetShowStarGodStack:_onClickChange()
	StarGodNotify.dispatch(StarGodNotify.OnChangeOneKey, self._isRed)
end

function PetShowStarGodStack:_onClickStarGod()
	self:_onChangeBag(false)
end

function PetShowStarGodStack:_onClickRed()
	self:_onChangeBag(true)
end

return PetShowStarGodStack

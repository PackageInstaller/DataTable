-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familytech/view/FamilyTechMainView.lua

module("logic.extensions.familytech.view.FamilyTechMainView", package.seeall)

local FamilyTechMainView = class("FamilyTechMainView", TableViewComponent)

function FamilyTechMainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilyTechMainView:unbindEvents()
	FamilyTechMainView.super.unbindEvents(self)

	for _, v in ipairs(self._btnTabs) do
		GameUtil.rmClickHandler(v)
	end
end

function FamilyTechMainView:bindEvents()
	FamilyTechMainView.super.bindEvents(self)

	for i, v in ipairs(self._btnTabs) do
		GameUtil.addClickHandler(v, function()
			self:_onClickTab(i)
		end)
	end
end

function FamilyTechMainView:onExit()
	FamilyTechMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateFamilyTechUI, self._onFamilyTechInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyTechUpgradeSuccess, self._onTechChange, self)
end

function FamilyTechMainView:buildUI()
	FamilyTechMainView.super.buildUI(self)

	self._btnTabs = {}

	table.insert(self._btnTabs, self:getGo("btnEnhance"))
	table.insert(self._btnTabs, self:getGo("btnResistance"))
end

function FamilyTechMainView:_onClickTab(i, isForce)
	if self._curIndex ~= i or isForce then
		self._curIndex = i

		for k, v in ipairs(self._btnTabs) do
			local changeGroup = v:GetComponent(typeof(UIChangeGroup))

			changeGroup:SetState(k == i and 1 or 0)
		end

		self:_updateUI()
	end
end

function FamilyTechMainView:onEnter()
	FamilyTechMainView.super.onEnter(self)

	self._srvMsgGet = false

	GlobalDispatcher:addListener(GlobalNotify.UpdateFamilyTechUI, self._onFamilyTechInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyTechUpgradeSuccess, self._onTechChange, self)
	FamilyTechController.instance:reqTechInfo()
	self:_onClickTab(1, true)
end

function FamilyTechMainView:_onTechChange()
	print("FamilyTechMainView _onTechChange")
	self:_updateUI()
end

function FamilyTechMainView:_onFamilyTechInfoRes()
	self._srvMsgGet = true

	self:_updateUI()
end

function FamilyTechMainView:_updateUI()
	if not self._srvMsgGet then
		return
	end

	local cfgs = FamilyTechConfig.instance:getFamilyTechCfgs()

	self._curViewDatas = {}

	local maxColumn = 0

	for _, v in ipairs(cfgs) do
		if v.sequenceId == self._curIndex then
			local column = v.column

			maxColumn = math.max(maxColumn, column)

			if self._curViewDatas[column] == nil then
				self._curViewDatas[column] = {}
			end

			table.insert(self._curViewDatas[column], v)
		end
	end

	for i = 1, maxColumn do
		if self._curViewDatas[i] == nil then
			self._curViewDatas[i] = {}
		end
	end

	self:reloadData()
end

function FamilyTechMainView:_updateCell(view, cell, techCfgs)
	local gridLayoutGroup = goutil.findChild(cell.gameObject, "gridLayoutGroup")

	GameUtil.updateCellsWithCreate(gridLayoutGroup, techCfgs, self._updateOneTechCell, self)

	local dict = {}

	for _, v in ipairs(techCfgs) do
		local preTechs = v.preTechs

		if preTechs and #preTechs > 0 then
			local key = ""

			for k, preTechId in ipairs(preTechs) do
				key = k == 1 and preTechId or key .. ":" .. preTechId
			end

			dict[key] = dict[key] or {}

			table.insert(dict[key], v)
		end
	end

	for k, v in pairs(dict) do
		print("key = " .. k)

		local preTechIds = string.splitToNumber(k, ":")
	end
end

function FamilyTechMainView:_updateOneTechCell(go, cfg)
	local techId = cfg.id

	go = goutil.findChild(go, "btnClick")

	local btnClick = Framework.ButtonAdapter.Get(go)
	local imgIconChange = goutil.findChild(go, "imgIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local lock = goutil.findChild(go, "lock")
	local url = string.format("ui/icon/familytech/%s.png", cfg.icon)

	uGuiUtil.setSpriteToImage(imgIconChange, uGuiUtil.SpriteType.BigBg, url)

	txtName.text = cfg.name
	txtLevel.text = FamilyTechModel.instance:getTechLevel(techId)

	lock:SetActive(not FamilyTechModel.instance:getTechUnlocked(techId))
	btnClick:AddClickListener(function()
		self:_onClickTech(techId)
	end)
	self:_inActiveChildren(goutil.findChild(btnClick.transform, "linesParent"))

	local cfg = FamilyTechConfig.instance:getFamilyTechCfg(techId)

	if cfg ~= nil and cfg.preTechs then
		for _, v in ipairs(cfg.preTechs) do
			local preCfg = FamilyTechConfig.instance:getFamilyTechCfg(v)

			self:_drawLine(cfg.row, cfg.column, preCfg.row, preCfg.column, btnClick.transform)
		end
	end

	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

	Framework.TransformUtil.SetLocalPos(go.transform, x, (2 - cfg.row) * 180, z)
end

function FamilyTechMainView:_drawLine(row1, column1, row2, column2, trans)
	local rectTransForm = trans:GetComponent(typeof(UnityEngine.RectTransform))
	local sizeDelta = rectTransForm.sizeDelta
	local width = (column1 - column2) * 180 - sizeDelta.x
	local height = (row1 - row2) * 180
	local linesParent = goutil.findChild(trans, "linesParent")
	local freeLine = self:_getFreeChild(linesParent)

	freeLine:SetActive(true)
	Framework.TransformUtil.SetLocalPos(freeLine.transform, -sizeDelta.x * 0.5 + 3, 0, 0)

	local freeLineRectTrans = freeLine:GetComponent(typeof(UnityEngine.RectTransform))
	local oldSizeDelta = freeLineRectTrans.sizeDelta

	freeLineRectTrans.sizeDelta = Vector2.New(math.sqrt(width * width + height * height) + 6, oldSizeDelta.y)

	print("width = " .. width .. "height = " .. height)

	local angle = math.atan(height / width) / math.pi * 180

	Framework.TransformUtil.SetLocalRotation(freeLine.transform, 0, 0, -angle)
end

function FamilyTechMainView:_inActiveChildren(parent)
	parent = parent.transform

	local childCount = parent.childCount

	if childCount == 0 then
		return nil
	end

	for i = 1, childCount do
		local child = parent:GetChild(i - 1)

		child.gameObject:SetActive(false)
	end
end

function FamilyTechMainView:_getFreeChild(parent)
	parent = parent.transform

	local childCount = parent.childCount

	if childCount == 0 then
		return nil
	end

	for i = 1, childCount do
		local child = parent:GetChild(i - 1).gameObject

		if not child.activeSelf then
			return child
		end
	end

	local firstChild = parent:GetChild(0)

	return (goutil.cloneAndSetParent(firstChild.gameObject, parent))
end

function FamilyTechMainView:_getLocalPosYByRow(row)
	local maxRow = 5
	local sizeY = 90

	return (maxRow / 2 - row + 0.5) * sizeY
end

function FamilyTechMainView:_onClickTech(techId)
	local isUnlock, tips = FamilyTechModel.instance:getTechUnlocked(techId)

	if isUnlock then
		UIStateManager.instance:push(ViewName.FamilyTechUpgradeView, techId)
	else
		FloatWordMgr.instance:show(tips)
	end
end

return FamilyTechMainView

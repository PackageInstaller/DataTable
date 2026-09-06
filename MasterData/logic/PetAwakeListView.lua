-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeListView.lua

module("logic.extensions.bag.view.stack.PetAwakeListView", package.seeall)

local PetAwakeListView = class("PetAwakeListView", TableViewComponent)

function PetAwakeListView:ctor()
	PetAwakeListView.super.ctor(self)
end

function PetAwakeListView:_getPath()
	return {
		cellPath = "Nego_Content/tablecell",
		viewPath = "Nego_Content/tableview"
	}
end

function PetAwakeListView:unbindEvents()
	PetAwakeListView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetAwakeListView:bindEvents()
	PetAwakeListView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function PetAwakeListView:buildUI()
	PetAwakeListView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._cellTip = self:getGo("Nego_Content/cellTip")

	self._cellTip:SetActive(false)
	goutil.setActive(self._tableCell, true)
	Framework.TransformUtil.SetLocalPos(self._tableCell.transform, 10000, 10000, 0)

	self._contentSizeImmediate = goutil.findChildComponent(self._tableCell, "bg/container", "ContentSizeImmediate")
end

function PetAwakeListView:onEnter()
	PetAwakeListView.super.onEnter(self)

	self._mo = self:getFirstParam()

	if self._mo == nil then
		self._mo = BagPetsController.instance:GetCurPetMo()
	end

	local cfg = CharacterConfig.instance:getPetCo(self._mo.raceId)
	local initAwakenLv = checknumber(cfg.initAwakenLv)
	local curRare = CharacterConfig.instance:getRareByAwakenLv(self._mo.awakeLevel, self._mo.raceId)
	local awakenCfgs = CharacterConfig.instance:getPetAwakenCfgs(cfg.awakenStrategyId)

	table.sort(awakenCfgs, function(a, b)
		return a.awakenLevel < b.awakenLevel
	end)

	self.heightList = {}

	local tempList = {}

	for k, v in ipairs(awakenCfgs) do
		local curRareCfg = CharacterConfig.instance:getAwakenRareCfg(v.awakenLevel)
		local nextCfg = awakenCfgs[k + 1]

		table.insert(tempList, v)

		local insert = false

		if nextCfg == nil then
			insert = true
		else
			local nextRareCfg = CharacterConfig.instance:getAwakenRareCfg(nextCfg.awakenLevel)

			if curRareCfg.starNum ~= nextRareCfg.starNum then
				insert = true
			end
		end

		if insert then
			self:_recordHeight(tempList)
			table.insert(self._curViewDatas, tempList)

			tempList = {}
		end
	end

	self:reloadData()
end

function PetAwakeListView:_recordHeight(data)
	self:_updateCell(nil, self._tableCell, data)

	local size = self._contentSizeImmediate:GetPreferredSize()

	table.insert(self.heightList, math.max(150, size.y + 62))
end

function PetAwakeListView:_cellAtIndex(view, idx)
	local cell
	local data = self._curViewDatas[idx + 1]
	local tag = type(data) == "string" and 0 or 1
	local cell = view:DequeueCellByTag(tag)

	if not cell then
		cell = type(data) == "string" and view:AddChild(self._cellTip, tag) or view:AddChild(self._tableCell, tag)

		self:initCell(cell)
	end

	cell.data = idx + 1
	cell.index = idx

	self:_updateCell(view, cell, data)

	return cell
end

function PetAwakeListView:_cellSize(view, index)
	local height = self.heightList[index + 1]

	return 300, height
end

function PetAwakeListView:_getTipList(data)
	local tips = {}
	local cfg = CharacterConfig.instance:getPetCo(data.id)
	local rareCfg = CharacterConfig.instance:getAwakenRareCfg(data.awakenLevel)
	local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, data.awakenLevel)

	table.insert(tips, string.format("<color=#0083e7>%s</color>效果：", rareCfg.name))

	local attrAdd = 100 + costCfg.allPropertyWanPercent / 100 .. "%"

	table.insert(tips, string.format("全属性<color=#11a568>%s</color>成长，且全属性提升至<color=#11a568>%s</color>", rareCfg.attrUpTitle, attrAdd))

	return tips
end

function PetAwakeListView:_updateCell(view, cell, data)
	if type(data) == "string" then
		local textTip = goutil.findChildTextComponent(cell.gameObject, "Txt_Tip")

		textTip.text = data

		return
	end

	local datas = data

	data = datas[1]

	local isActive = datas[1].awakenLevel <= self._mo.awakeLevel
	local container = goutil.findChild(cell.gameObject, "bg")
	local starsContainer = goutil.findChild(container, "stars")
	local stars = GameUtil.getChildren(starsContainer)
	local txtLv = goutil.findChildTextComponent(container, "txt_lv")
	local txtLvColorChange = txtLv:GetComponent("UITextColorChange")
	local desContainer = goutil.findChild(container, "container")
	local cells = GameUtil.getChildren(desContainer)
	local rareCfg = CharacterConfig.instance:getAwakenRareCfg(data.awakenLevel)

	txtLv.text = rareCfg.name

	txtLvColorChange:SetState(isActive and 0 or 1)

	for k, v in ipairs(cells) do
		v:SetActive(false)
	end

	for k, v in ipairs(datas) do
		local cell = cells[k]
		local isActiveRing = v.awakenLevel <= self._mo.awakeLevel

		if cell == nil then
			local cloneGo = desContainer.transform:GetChild(0).gameObject

			cell = goutil.cloneAndSetParent(cloneGo, desContainer.transform, "cell")

			Framework.TransformUtil.SetLocalScale(cell.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalRotation(cell.transform, 0, 0, 0)
			table.insert(cells, cell)
		end

		local uiChangeGroup = cell:GetComponent("UIChangeGroup")

		cell:SetActive(true)

		local childList = GameUtil.getChildren(cell)
		local textList = {}

		for _, v in ipairs(childList) do
			if not goutil.isNil(v:GetComponent(goutil.Type_UIText)) then
				table.insert(textList, v)
			end
		end

		local tipList = self:_getTipList(v)

		for i = 1, #textList do
			textList[i]:SetActive(false)
		end

		for i = 1, #tipList do
			textList[i]:SetActive(true)

			local str = tipList[i]

			if not isActiveRing then
				str = string.gsub(str, "<color=#[%w]+>", "")
				str = string.gsub(str, "</color>", "")
			end

			textList[i]:GetComponent(goutil.Type_UIText).text = str
		end

		uiChangeGroup:SetState(isActiveRing and 0 or 1)
	end

	for k, v in ipairs(stars) do
		goutil.setActive(v, k <= rareCfg.starNum)
	end

	if view then
		GameUtil.setHeight(cell, self.heightList[cell.data])
	end
end

function PetAwakeListView:_onReloadFinish()
	if self._curViewDatas and #self._curViewDatas > 0 then
		local centerIndex = 0

		for k, v in ipairs(self._curViewDatas) do
			if type(v) == "table" then
				for _, cfg in ipairs(v) do
					if cfg.awakenLevel == self._mo.awakeLevel then
						centerIndex = k - 1

						break
					end
				end
			end
		end

		centerIndex = math.max(0, centerIndex)
		centerIndex = math.min(#self._curViewDatas - 1, centerIndex)

		self._tableview:MoveCellToCebter(centerIndex)
	end
end

return PetAwakeListView

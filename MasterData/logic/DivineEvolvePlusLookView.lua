-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineEvolvePlusLookView.lua

module("logic.extensions.divineevolveplus.view.DivineEvolvePlusLookView", package.seeall)

local DivineEvolvePlusLookView = class("DivineEvolvePlusLookView", TableViewComponent)

function DivineEvolvePlusLookView:ctor()
	DivineEvolvePlusLookView.super.ctor(self)
end

function DivineEvolvePlusLookView:buildUI()
	DivineEvolvePlusLookView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._skillIcon = self:getGo("info/skillIcon")
	self._txtName = self:getTxt("info/txtName")
	self._txtSkill = self:getTxt("info/txtSkill")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._scrollrect = self:getGo("tableview"):GetComponent("ScrollRect")
	self._cellGo = self:getGo("petList/cell")
	self._tableGo = self:getGo("petList/tableview")
	self._petListTableview = ScrollerList.create(self._tableGo, self._cellGo, GameUtil.handler(self._updatePetListCell, self), GameUtil.handler(self._clearPetListTableview, self))
end

function DivineEvolvePlusLookView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DivineEvolvePlusLookView:bindEvents()
	DivineEvolvePlusLookView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function DivineEvolvePlusLookView:unbindEvents()
	DivineEvolvePlusLookView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineEvolvePlusLookView:onEnter()
	DivineEvolvePlusLookView.super.onEnter(self)
	DivineEvolvePlusController.instance:registerNotify(DivineEvolvePlusController.DivineLookItemClick, self._onClickDivineLookItem, self)
	DivineEvolvePlusController.instance:registerNotify(DivineEvolvePlusController.PetListItemClick, self._onClickPetListItem, self)

	self._initSelectRaceId = self:getFirstParam()

	self:_initPetList()
end

function DivineEvolvePlusLookView:onExit()
	DivineEvolvePlusLookView.super.onExit(self)
	DivineEvolvePlusController.instance:unregisterNotify(DivineEvolvePlusController.DivineLookItemClick, self._onClickDivineLookItem, self)
	DivineEvolvePlusController.instance:unregisterNotify(DivineEvolvePlusController.PetListItemClick, self._onClickPetListItem, self)
	self:_removeIcon()
	self._petListTableview:dispose()
end

function DivineEvolvePlusLookView:_onClickClose()
	self:close()
end

function DivineEvolvePlusLookView:_updateCell(view, cell, data)
	local item = GameUtil.AddLuaOnce(cell.gameObject, DivinePlusLookItem)

	item:init(self, data)
end

function DivineEvolvePlusLookView:_clearTableview(cell)
	local item = GameUtil.AddLuaOnce(cell.gameObject, DivinePlusLookItem)

	item:reset()
end

function DivineEvolvePlusLookView:_getShenweiId(raceId)
	local evolveCfg = EvolveConfig.instance:getDivineEvolvePlusCfg(raceId, EvolveEnum.EvolveType.Divine)

	if not evolveCfg then
		evolveCfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(raceId)

		if not evolveCfg then
			return 0
		end
	end

	local postPetCfg = CharacterConfig.instance:getPetCo(evolveCfg.newRaceId)

	if postPetCfg then
		return postPetCfg.kamuiProgramId
	end
end

function DivineEvolvePlusLookView:_showScrollView(raceId)
	self._isFirst = true

	local id = self:_getShenweiId(raceId)
	local firstCfg
	local name = "nil"
	local list = {}
	local cfgLevels = DomainCultivateConfig.instance:getLevelCfg(id)

	printInfo("test", raceId, id, cfgLevels)

	if not cfgLevels then
		printError("test 精灵基础信息表，神威方案不存在 id：raceId = ", id, raceId)

		return
	end

	for i, v in ipairs(cfgLevels) do
		if v.level == 3 or v.level == 6 or v.level == 10 then
			local subGroup = {}

			subGroup.cfg = v
			subGroup.list = {}

			local cfgPrograms = DomainCultivateConfig.instance:getProgramCfg(v.id, v.level)

			if cfgPrograms then
				for k, cfg in pairs(cfgPrograms) do
					local element = {}

					element.cfg = DomainCultivateConfig.instance:getDefineCfg(cfg.kamuiId)
					element.isSelect = false

					table.insert(subGroup.list, element)
				end
			end

			table.sort(subGroup.list, function(a, b)
				return a.cfg.kamuiId < b.cfg.kamuiId
			end)

			if self._isFirst and #subGroup.list > 0 then
				self._isFirst = false
				subGroup.list[1].isSelect = true
				firstCfg = subGroup.list[1].cfg
				name = "神格" .. GameUtil.toRomanNumber(subGroup.cfg.level)
			end

			table.insert(list, subGroup)
		end
	end

	self:updateListData(list)
	self:_refreshInfo(firstCfg, name)
end

function DivineEvolvePlusLookView:_onClickDivineLookItem(level, cfg, name)
	local preIndex = 0
	local postIndex = 0

	for i, v in ipairs(self._curViewDatas) do
		for k, element in ipairs(v.list) do
			if element.isSelect then
				preIndex = i - 1
			end

			element.isSelect = v.cfg.level == level and element.cfg.kamuiId == cfg.kamuiId

			if element.isSelect then
				postIndex = i - 1
			end
		end
	end

	if preIndex ~= postIndex then
		local preCell = self._tableview:GetCellAtIndex(preIndex)

		if preCell then
			local component = GameUtil.GetLua(preCell.gameObject, DivinePlusLookItem)

			component:reloadData()
		end
	end

	local postCell = self._tableview:GetCellAtIndex(postIndex)

	if postCell then
		local component = GameUtil.GetLua(postCell.gameObject, DivinePlusLookItem)

		component:reloadData()
	end

	self:_refreshInfo(cfg, name)
end

function DivineEvolvePlusLookView:_refreshInfo(cfg, name)
	if not cfg then
		return
	end

	self._txtName.text = name
	self._txtSkill.text = cfg.name
	self._txtDesc.text = cfg.desc

	uGuiUtil.setSpriteToImage(self._skillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
end

function DivineEvolvePlusLookView:_removeIcon()
	MaterialMgr.clearIcon(self._skillIcon)
end

function DivineEvolvePlusLookView:dragCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnDrag(eventData)
	end
end

function DivineEvolvePlusLookView:dragBegingCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function DivineEvolvePlusLookView:dragEndCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnEndDrag(eventData)
	end
end

function DivineEvolvePlusLookView:_updatePetListCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	txtName.text = ""

	MaterialMgr.resetAll(icon)

	local raceId = data.cfg.raceId
	local isSelect = data.isSelect

	btnClick:AddClickListener(function()
		DivineEvolvePlusController.instance:notify(DivineEvolvePlusController.PetListItemClick, isSelect, raceId)
	end)
	goutil.setActive(select, data.isSelect)

	local proxy = MaterialMgr.setCell(MatType.Pet, data.cfg.newRaceId, icon)
	local cfg = CharacterConfig.instance:getPetCo(data.cfg.newRaceId)

	if cfg then
		txtName.text = cfg.name
	end
end

function DivineEvolvePlusLookView:_clearPetListTableview(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	MaterialMgr.resetAll(icon)
	btnClick:RemoveClickListener()
end

function DivineEvolvePlusLookView:_initPetList()
	local cfgList = EvolveConfig.instance:getReverseDivineEvolvePlusList()
	local selectIndex = 1
	local showList = {}

	for i, v in ipairs(cfgList) do
		local element = {}

		element.cfg = v
		element.isSelect = self:_isSelectPet(i, v, self._initSelectRaceId)

		if element.isSelect then
			selectIndex = i
		end

		table.insert(showList, element)
	end

	self._petListTableview:reloadData(showList)
	self._petListTableview:MoveCellToCenter(selectIndex - 1)
	self:_showScrollView(showList[selectIndex].cfg.raceId)
end

function DivineEvolvePlusLookView:_isSelectPet(index, cfg, raceId)
	return (raceId == nil or raceId == 0) and index == 1 or raceId == cfg.raceId
end

function DivineEvolvePlusLookView:_refreshSelectState(raceId)
	local list = self._petListTableview:getData()

	for i, v in ipairs(list) do
		v.isSelect = v.cfg.raceId == raceId
	end

	self._petListTableview:getView():ReloadData()
	self._tableview:SetOffsetWithoutRefresh(1)
end

function DivineEvolvePlusLookView:_onClickPetListItem(isSelect, raceId)
	self:_refreshSelectState(raceId)
	self:_showScrollView(raceId)
end

return DivineEvolvePlusLookView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveLookView.lua

module("logic.extensions.divineevolve.view.DivineEvolveLookView", package.seeall)

local DivineEvolveLookView = class("DivineEvolveLookView", TableViewComponent)

function DivineEvolveLookView:ctor()
	DivineEvolveLookView.super.ctor(self)
end

function DivineEvolveLookView:buildUI()
	DivineEvolveLookView.super.buildUI(self)

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

function DivineEvolveLookView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DivineEvolveLookView:bindEvents()
	DivineEvolveLookView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function DivineEvolveLookView:unbindEvents()
	DivineEvolveLookView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineEvolveLookView:onEnter()
	DivineEvolveLookView.super.onEnter(self)
	DivineEvolveController.instance:registerNotify(DivineEvolveController.DivineLookItemClick, self._onClickDivineLookItem, self)
	DivineEvolveController.instance:registerNotify(DivineEvolveController.PetListItemClick, self._onClickPetListItem, self)

	self._initSelectRaceId = self:getFirstParam()

	self:_initPetList()
end

function DivineEvolveLookView:onExit()
	DivineEvolveLookView.super.onExit(self)
	DivineEvolveController.instance:unregisterNotify(DivineEvolveController.DivineLookItemClick, self._onClickDivineLookItem, self)
	DivineEvolveController.instance:unregisterNotify(DivineEvolveController.PetListItemClick, self._onClickPetListItem, self)
	self:_removeIcon()
	self._petListTableview:dispose()
end

function DivineEvolveLookView:_onClickClose()
	self:close()
end

function DivineEvolveLookView:_updateCell(view, cell, data)
	local item = GameUtil.AddLuaOnce(cell.gameObject, DivineLookItem)

	item:init(self, data)
end

function DivineEvolveLookView:_clearTableview(cell)
	local item = GameUtil.AddLuaOnce(cell.gameObject, DivineLookItem)

	item:reset()
end

function DivineEvolveLookView:_getShenweiId(raceId)
	local evolveCfg = EvolveConfig.instance:getDivineEvolveCfg(raceId)

	if not evolveCfg then
		evolveCfg = EvolveConfig.instance:getDivineEvolveCfgByNewRaceId(raceId)

		if not evolveCfg then
			return 0
		end
	end

	local postPetCfg = CharacterConfig.instance:getPetCo(evolveCfg.newRaceId)

	if postPetCfg then
		return postPetCfg.kamuiProgramId
	end
end

function DivineEvolveLookView:_showScrollView(raceId)
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
			name = "神威" .. GameUtil.toRomanNumber(subGroup.cfg.level)
		end

		table.insert(list, subGroup)
	end

	self:updateListData(list)
	self:_refreshInfo(firstCfg, name)
end

function DivineEvolveLookView:_onClickDivineLookItem(level, cfg, name)
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
			local component = GameUtil.GetLua(preCell.gameObject, DivineLookItem)

			component:reloadData()
		end
	end

	local postCell = self._tableview:GetCellAtIndex(postIndex)

	if postCell then
		local component = GameUtil.GetLua(postCell.gameObject, DivineLookItem)

		component:reloadData()
	end

	self:_refreshInfo(cfg, name)
end

function DivineEvolveLookView:_refreshInfo(cfg, name)
	if not cfg then
		return
	end

	self._txtName.text = name
	self._txtSkill.text = cfg.name
	self._txtDesc.text = cfg.desc

	uGuiUtil.setSpriteToImage(self._skillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
end

function DivineEvolveLookView:_removeIcon()
	MaterialMgr.clearIcon(self._skillIcon)
end

function DivineEvolveLookView:dragCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnDrag(eventData)
	end
end

function DivineEvolveLookView:dragBegingCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function DivineEvolveLookView:dragEndCellChild(eventData)
	if self._tableview then
		self._scrollrect:OnEndDrag(eventData)
	end
end

function DivineEvolveLookView:_updatePetListCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	txtName.text = ""

	MaterialMgr.resetAll(icon)

	local raceId = data.raceId
	local isSelect = data.isSelect

	btnClick:AddClickListener(function()
		DivineEvolveController.instance:notify(DivineEvolveController.PetListItemClick, isSelect, raceId)
	end)
	goutil.setActive(select, data.isSelect)

	if data.isExistInBag then
		MaterialMgr.setCellByMo(data.petMo, icon)

		txtName.text = data.petMo:getName()
	else
		local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, icon)

		proxy.binder:setGray(true)

		local cfg = CharacterConfig.instance:getPetCo(data.raceId)

		if cfg then
			txtName.text = cfg.name
		end
	end
end

function DivineEvolveLookView:_clearPetListTableview(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	MaterialMgr.resetAll(icon)
	btnClick:RemoveClickListener()
end

function DivineEvolveLookView:_initPetList()
	local petMoList = DivineEvolveController.instance:getDivineMainList()
	local selectIndex = 1
	local showList = {}

	for i, v in ipairs(petMoList) do
		local element = {}

		element.isExistInBag = v.isExistInBag
		element.petMo = v.petMo
		element.raceId = v.raceId
		element.isSelect = (self._initSelectRaceId == nil or self._initSelectRaceId == 0) and i == 1 or v.petMo and v.petMo.raceId == self._initSelectRaceId and true or self._initSelectRaceId == v.raceId

		if element.isSelect then
			selectIndex = i
		end

		table.insert(showList, element)
	end

	self._petListTableview:reloadData(showList)
	self:_showScrollView(showList[selectIndex].raceId)
end

function DivineEvolveLookView:_refreshSelectState(raceId)
	local list = self._petListTableview:getData()

	for i, v in ipairs(list) do
		v.isSelect = v.raceId == raceId
	end

	self._petListTableview:getView():ReloadData()
	self._tableview:SetOffsetWithoutRefresh(1)
end

function DivineEvolveLookView:_onClickPetListItem(isSelect, raceId)
	self:_refreshSelectState(raceId)
	self:_showScrollView(raceId)
end

return DivineEvolveLookView

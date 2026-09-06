-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceEvolveLookView.lua

module("logic.extensions.sourcetrace.view.SourceTraceEvolveLookView", package.seeall)

local SourceTraceEvolveLookView = class("SourceTraceEvolveLookView", ViewComponent)
local NODE_TYPE_NORMAL = 1
local NODE_TYPE_MULTI = 2
local ICON_TYPE_LOAD = 1
local ICON_TYPE_SPRITE = 2

function SourceTraceEvolveLookView:ctor()
	SourceTraceEvolveLookView.super.ctor(self)
end

function SourceTraceEvolveLookView:unbindEvents()
	SourceTraceEvolveLookView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SourceTraceEvolveLookView:bindEvents()
	SourceTraceEvolveLookView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function SourceTraceEvolveLookView:buildUI()
	SourceTraceEvolveLookView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._multiCell = self:getGo("sourceTraceSkillRoot/multiCell")
	self._normalCell = self:getGo("sourceTraceSkillRoot/normalCell")
	self._mapLinkRoot = self:getGo("sourceTraceSkillRoot/mapLinkRoot")
	self._mapRoot = self:getGo("sourceTraceSkillRoot/mapRoot")
	self._cellContain = self:getGo("sourceTraceSkillRoot/cellContain")
	self._mapBg = self:getGo("sourceTraceSkillRoot/mapBg")
	self._sourceTraceSkillRoot = self:getGo("sourceTraceSkillRoot")
	self._baseShowLine = goutil.findChildComponent(self._sourceTraceSkillRoot, "mapLinkRoot", "LineGraphic")
	self._cellGo = self:getGo("petList/cell")
	self._tableGo = self:getGo("petList/tableview")
	self._petListTableview = ScrollerList.create(self._tableGo, self._cellGo, GameUtil.handler(self._updatePetListCell, self), GameUtil.handler(self._clearPetListTableview, self))
	self._skillTableview = self:getGo("info/multiEffect/tableview")
	self._skillTablecell = self:getGo("info/multiEffect/tableview/tablecell")
	self._skillTableList = ScrollerList.create(self._skillTableview, self._skillTablecell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))

	self._skillTableList:setCenterMode(true)

	self._multiEffect = self:getGo("info/multiEffect")
	self._singleEffect = self:getGo("info/singleEffect")
	self._txtEffectName = self:getTxt("info/txtName")
	self._txtEffectDesc = self:getTxt("info/txtDesc")
	self._curSkillIconLoad = self:getGo("info/singleEffect/Mask/ImgC_Skill")
	self._curSkillIconSprite = self:getGo("info/singleEffect/Mask/ImgC_Icon")
	self._imageChangeCurSkillIcon = self._curSkillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	self._txtBaseDesc = self:getTxt("baseDesc/tableview/viewport/content/txt")
end

function SourceTraceEvolveLookView:onExit()
	SourceTraceEvolveLookView.super.onExit(self)
	self:_clearSourceTraceSkill()

	for i, v in pairs(self._cellPools) do
		v:clear()
	end
end

function SourceTraceEvolveLookView:onEnter()
	SourceTraceEvolveLookView.super.onEnter(self)
	self.addGEvent(self, DivineEvolvePlusController.PetListItemClick, self._onPetListItemClick, self)

	self._selectReceId = checknumber(self:getFirstParam())

	local selectIndex = self:_initPetList()

	self:_updateView()
	self._petListTableview:MoveCellToCenter(selectIndex - 1)
end

function SourceTraceEvolveLookView:_getVisibleCfgList()
	return SourceTraceController.instance:getEvolvePreviewVisibleList()
end

function SourceTraceEvolveLookView:_syncSelectRaceId(cfgList)
	if not cfgList or #cfgList <= 0 then
		self._selectReceId = 0

		return 1
	end

	if self._selectReceId == nil or self._selectReceId == 0 then
		self._selectReceId = cfgList[1].raceId

		return 1
	end

	for i, cfg in ipairs(cfgList) do
		if cfg.raceId == self._selectReceId then
			return i
		end
	end

	self._selectReceId = cfgList[1].raceId

	return 1
end

function SourceTraceEvolveLookView:_updateView()
	local cfgList = self:_getVisibleCfgList()

	self:_syncSelectRaceId(cfgList)
	self._petListTableview:reloadData(cfgList)

	local evolveCfg = EvolveConfig.instance:getDivineEvolvePlusCfg(self._selectReceId, EvolveEnum.EvolveType.SourceTrace)

	if not evolveCfg then
		evolveCfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(self._selectReceId)

		if not evolveCfg then
			return 0
		end
	end

	local petCfg = CharacterConfig.instance:getPetCo(evolveCfg.newRaceId)
	local sourceTraceId = petCfg.sourceTraceId

	self._curNodeId = self._curNodeId or 1

	local curNodeCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(sourceTraceId, self._curNodeId)

	self._curEffect = self._curEffect or curNodeCfg.effectIds[1]

	self:_clearSourceTraceSkill()
	self:_createSourceTraceSkill(self._mapRoot, sourceTraceId)

	self._isMultiEffect = #curNodeCfg.effectIds > 1

	GameUtil.SetActive(self._multiEffect, self._isMultiEffect == true)
	GameUtil.SetActive(self._singleEffect, not self._isMultiEffect)
	self._skillTableList:reloadData(curNodeCfg.effectIds)

	local curEffectCfg = SourceTraceConfig.instance:getEffectCfg(self._curEffect)

	self._txtEffectName.text = curEffectCfg.name
	self._txtEffectDesc.text = curEffectCfg.desc

	uGuiUtil.clearImage(self._curSkillIconLoad)

	if not self._isMultiEffect then
		GameUtil.SetActive(self._curSkillIconLoad, false)
		GameUtil.SetActive(self._curSkillIconSprite, false)

		if curEffectCfg.iconType == ICON_TYPE_LOAD then
			GameUtil.SetActive(self._curSkillIconLoad, true)
			uGuiUtil.setSpriteToImage(self._curSkillIconLoad, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(curEffectCfg.iconRes))
		elseif curEffectCfg.iconType == ICON_TYPE_SPRITE then
			GameUtil.SetActive(self._curSkillIconSprite, true)
			self._imageChangeCurSkillIcon:ChangeSprite(curEffectCfg.iconRes)
		end
	end

	local groupInfoCfg = SourceTraceConfig.instance:getGroupInfoCfg(sourceTraceId)

	if groupInfoCfg then
		uGuiUtil.setSpriteToImage(self._mapBg, nil, groupInfoCfg.mapBgRes)

		self._txtBaseDesc.text = langPara("源起技：%s", groupInfoCfg.skillBaseDesc)
	else
		printError("图谱背景图未配置，id = ", sourceTraceId)

		self._txtBaseDesc.text = lang("无效果")
	end
end

function SourceTraceEvolveLookView:_initPetList()
	local cfgList = self:_getVisibleCfgList()

	return self:_syncSelectRaceId(cfgList)
end

function SourceTraceEvolveLookView:_updatePetListCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	txtName.text = ""

	MaterialMgr.resetAll(icon)

	local raceId = data.raceId

	btnClick:AddClickListener(function()
		DivineEvolveController.instance:notify(DivineEvolveController.PetListItemClick, self._selectReceId == data.raceId, raceId)
	end)
	goutil.setActive(select, self._selectReceId == data.raceId)

	local proxy = MaterialMgr.setCell(MatType.Pet, data.newRaceId, icon)

	proxy.binder:setAutoTips(false)

	local cfg = CharacterConfig.instance:getPetCo(data.newRaceId)

	if cfg then
		txtName.text = cfg.name
	end
end

function SourceTraceEvolveLookView:_clearPetListTableview(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	MaterialMgr.resetAll(icon)
	btnClick:RemoveClickListener()
end

function SourceTraceEvolveLookView:_createSourceTraceSkill(rootGo, sourceTraceId)
	GameUtil.SetActive(self._multiCell, false)
	GameUtil.SetActive(self._normalCell, false)

	local nodesCfg = SourceTraceConfig.instance:getSourceTraceNodeCfgs(sourceTraceId)

	self._nodeCellList = {}

	for i, v in ipairs(nodesCfg) do
		local cell = self:_genarateNodeCell(rootGo, v)

		if #v.effectIds <= 1 then
			self:_updateNormalCell(cell, v)

			self._nodeCellList[v.nodeId] = {
				type = NODE_TYPE_NORMAL,
				cell = cell,
				index = v.nodeId
			}
		else
			self:_updateMultiCell(cell, v)

			self._nodeCellList[v.nodeId] = {
				type = NODE_TYPE_MULTI,
				cell = cell,
				index = v.nodeId
			}
		end
	end

	self._baseShowLine:ClearVertices()

	for i, v in ipairs(nodesCfg) do
		if v.preNodeIds and #v.preNodeIds > 0 then
			local curCell = self._nodeCellList[v.nodeId].cell

			for j, id in ipairs(v.preNodeIds) do
				local targetCell = self._nodeCellList[id].cell

				self._baseShowLine:AddVertices(GameUtil.getLocalPos(curCell), GameUtil.getLocalPos(targetCell), Framework.ColorUtil.ParseColor("FFFFFFFF"), 16)
			end
		end
	end
end

function SourceTraceEvolveLookView:_clearSourceTraceSkill()
	if self._nodeCellList then
		for i, v in ipairs(self._nodeCellList) do
			if v.type == NODE_TYPE_NORMAL then
				self:_clearNormalCell(v.cell)
			else
				self:_clearMultiCell(v.cell)
			end

			self._cellPools[v.type]:returnObject(v.cell)
		end

		self._nodeCellList = {}
	end
end

function SourceTraceEvolveLookView:_genarateNodeCell(rootGo, cellCfg)
	self._cellPools = self._cellPools or {}

	local index = NODE_TYPE_NORMAL

	if #cellCfg.effectIds > 1 then
		index = NODE_TYPE_MULTI
	end

	if not self._cellPools[index] then
		local function resetFunc(obj)
			self:_resetFunc(obj, index)
		end

		local function disposeFunc(obj)
			self:_disposeFunc(obj, index)
		end

		local createFunc

		self._cellPools[index] = ObjectPool.New(5, index == NODE_TYPE_MULTI and function()
			return (goutil.cloneAndSetParent(self._multiCell, rootGo.gameObject.transform))
		end or function()
			return (goutil.cloneAndSetParent(self._normalCell, rootGo.gameObject.transform))
		end, disposeFunc, resetFunc)
	end

	local cellObj = self._cellPools[index]:fetchObject()

	goutil.addChildToParent(cellObj.gameObject, rootGo.gameObject.transform)
	GameUtil.SetActive(cellObj.gameObject, true)

	return cellObj
end

function SourceTraceEvolveLookView:_disposeFunc(obj, index)
	goutil.destroy(obj)
end

function SourceTraceEvolveLookView:_resetFunc(obj, index)
	GameUtil.SetActive(obj.gameObject, false)
end

function SourceTraceEvolveLookView:_updateNormalCell(cellGo, cfg)
	local go = cellGo

	GameUtil.setAnchoredPos(go, cfg.pos[1], cfg.pos[2])

	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btn = goutil.findChild(go, "btn")
	local effectCfg = SourceTraceConfig.instance:getEffectCfg(cfg.effectIds[1])

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.SetActive(skillIconLoad, false)
	GameUtil.SetActive(skillIconSprite, false)

	if effectCfg.iconType == ICON_TYPE_LOAD then
		GameUtil.SetActive(skillIconLoad, true)
		uGuiUtil.setSpriteToImage(skillIconLoad, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(effectCfg.iconRes))
	elseif effectCfg.iconType == ICON_TYPE_SPRITE then
		GameUtil.SetActive(skillIconSprite, true)
		imageChangeSkillIcon:ChangeSprite(effectCfg.iconRes)
	end

	local isActive = true

	GameUtil.SetGray(go, not isActive)
	GameUtil.SetActive(imgSelect, self._curNodeId == cfg.nodeId)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickNormalCell(cfg.nodeId)
	end)
end

function SourceTraceEvolveLookView:_clearNormalCell(cellGo)
	local go = cellGo
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local btn = goutil.findChild(go, "btn")

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.rmClickHandler(btn)
end

function SourceTraceEvolveLookView:_updateMultiCell(cellGo, cfg)
	local go = cellGo

	GameUtil.setAnchoredPos(go, cfg.pos[1], cfg.pos[2])

	local cellRoot = goutil.findChild(go, "cellsRoot")
	local cell = goutil.findChild(go, "cellsRoot/cell")
	local recordPos = cellRoot:GetComponent(ComponentType.TestRecordPos)
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btn = goutil.findChild(go, "btnEffect")
	local singleCellInfos = {}
	local firstEffectId, firstInfo

	for i, v in ipairs(cfg.effectIds) do
		if not firstEffectId then
			firstEffectId = v
			firstInfo = {
				nodeCfg = cfg,
				effectId = v
			}
		else
			table.insert(singleCellInfos, {
				nodeCfg = cfg,
				effectId = v
			})
		end
	end

	table.insert(singleCellInfos, firstInfo)

	for i, v in ipairs(singleCellInfos) do
		v.firstEffectId = firstEffectId
	end

	GameUtil.updateCellsList(cellRoot, cell, singleCellInfos, self._updateMutiSingleCell, self)
	recordPos:LoadPlan(#singleCellInfos - 1)
	GameUtil.SetActive(imgSelect, self._curNodeId == cfg.nodeId)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickMutiCell(cfg.nodeId, firstEffectId)
	end)
end

function SourceTraceEvolveLookView:_clearMultiCell(cellGo)
	local go = cellGo
	local cellRoot = goutil.findChild(go, "cellsRoot")
	local btn = goutil.findChild(go, "btnEffect")

	GameUtil.SetActive(go, false)
	GameUtil.clearCells(cellRoot, self._clearMultiSingleCell, self, false)
	GameUtil.rmClickHandler(btn)
end

function SourceTraceEvolveLookView:_updateMutiSingleCell(cell, data, index)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local effectCfg = SourceTraceConfig.instance:getEffectCfg(data.effectId)

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.SetActive(skillIconLoad, false)
	GameUtil.SetActive(skillIconSprite, false)

	if effectCfg.iconType == ICON_TYPE_LOAD then
		GameUtil.SetActive(skillIconLoad, true)
		uGuiUtil.setSpriteToImage(skillIconLoad, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(effectCfg.iconRes))
	elseif effectCfg.iconType == ICON_TYPE_SPRITE then
		GameUtil.SetActive(skillIconSprite, true)
		imageChangeSkillIcon:ChangeSprite(effectCfg.iconRes)
	end
end

function SourceTraceEvolveLookView:_clearMultiSingleCell(cell)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIconLoad)
end

function SourceTraceEvolveLookView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btn = goutil.findChild(go, "btn")
	local effectCfg = SourceTraceConfig.instance:getEffectCfg(data)

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.SetActive(skillIconLoad, false)
	GameUtil.SetActive(skillIconSprite, false)

	if effectCfg.iconType == ICON_TYPE_LOAD then
		GameUtil.SetActive(skillIconLoad, true)
		uGuiUtil.setSpriteToImage(skillIconLoad, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(effectCfg.iconRes))
	elseif effectCfg.iconType == ICON_TYPE_SPRITE then
		GameUtil.SetActive(skillIconSprite, true)
		imageChangeSkillIcon:ChangeSprite(effectCfg.iconRes)
	end

	GameUtil.SetActive(imgSelect, self._isMultiEffect and data == self._curEffect)
	GameUtil.addClickHandler(btn, function()
		self:_onClickEffect(data)
	end)
end

function SourceTraceEvolveLookView:_clearSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIconLoad)
end

function SourceTraceEvolveLookView:_onClickNormalCell(nodeId)
	self._curNodeId = nodeId
	self._curEffect = nil

	self:_updateView()
end

function SourceTraceEvolveLookView:_onClickMutiCell(nodeId, effectId)
	self._curNodeId = nodeId
	self._curEffect = effectId

	self:_updateView()
end

function SourceTraceEvolveLookView:_onClickEffect(effectId)
	self._curEffect = effectId

	self:_updateView()
end

function SourceTraceEvolveLookView:_onPetListItemClick(isSelect, raceId)
	self._curNodeId = nil
	self._curEffect = nil
	self._selectReceId = raceId

	self:_updateView()
end

return SourceTraceEvolveLookView

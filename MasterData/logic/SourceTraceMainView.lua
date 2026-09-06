-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceMainView.lua

module("logic.extensions.sourcetrace.view.SourceTraceMainView", package.seeall)

local SourceTraceMainView = class("SourceTraceMainView", ViewComponent)
local NODE_TYPE_NORMAL = 1
local NODE_TYPE_MULTI = 2
local ICON_TYPE_LOAD = 1
local ICON_TYPE_SPRITE = 2

function SourceTraceMainView:ctor()
	SourceTraceMainView.super.ctor(self)
end

function SourceTraceMainView:unbindEvents()
	SourceTraceMainView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function SourceTraceMainView:bindEvents()
	SourceTraceMainView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickDetail, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function SourceTraceMainView:buildUI()
	SourceTraceMainView.super.buildUI(self)

	self._multiCell = self:getGo("sourceTraceSkillRoot/multiCell")
	self._normalCell = self:getGo("sourceTraceSkillRoot/normalCell")
	self._mapLinkRoot = self:getGo("sourceTraceSkillRoot/mapLinkRoot")
	self._mapRoot = self:getGo("sourceTraceSkillRoot/mapRoot")
	self._cellContain = self:getGo("sourceTraceSkillRoot/cellContain")
	self._mapBg = self:getGo("sourceTraceSkillRoot/mapBg")
	self._sourceTraceSkillRoot = self:getGo("sourceTraceSkillRoot")
	self._baseShowLine = goutil.findChildComponent(self._sourceTraceSkillRoot, "mapLinkRoot", "LineGraphic")
	self._skillTableview = self:getGo("attrRoot/skillTableview")
	self._skillTablecell = self:getGo("attrRoot/skillTablecell")
	self._skillTableList = ScrollerList.create(self._skillTableview, self._skillTablecell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))
	self._skillEmptyTips = self:getGo("attrRoot/emptyTips")
	self._attrTablecell = self:getGo("attrRoot/attrTablecell")
	self._attrTableview = self:getGo("attrRoot/attrTableview")
	self._attrTableList = ScrollerList.create(self._attrTableview, self._attrTablecell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._txtBaseDesc = self:getTxt("baseDesc/tableview/viewport/content/txt")
	self._detailInfo = self:getGo("detailInfo")
	self._txtNodeInfo = self:getTxt("detailInfo/nodeTableview/viewport/content/txtNodeInfo")
	self._txtDetailDesc = self:getTxt("detailInfo/baseTableview/viewport/content/txtDesc")
	self._customInput = UICustomInput.Get(self._detailInfo)
	self._btnOneKey = self:getGo("btnOneKey")
	self._btnDetail = self:getGo("btnDetail")
end

function SourceTraceMainView:onExit()
	SourceTraceMainView.super.onExit(self)
	self:_clearSourceTraceSkill()

	for i, v in pairs(self._cellPools) do
		v:clear()
	end
end

function SourceTraceMainView:onEnter()
	SourceTraceMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OnPetSelect, self._updateView, self)
	self.addGEvent(self, GlobalNotify.handlePM_SourceTraceUnlockNodeRes, self._updateView, self)
	self.addGEvent(self, GlobalNotify.handlePM_SourceTraceChangeEffectRes, self._updateView, self)
	GameUtil.SetActive(self._detailInfo, false)
	self:_updateView()
end

function SourceTraceMainView:_updateView()
	self._curPetMo = BagPetsController.instance:GetCurPetMo()

	local petCfg = CharacterConfig.instance:getPetCo(self._curPetMo.raceId)
	local sourceTraceId = petCfg.sourceTraceId

	if checknumber(sourceTraceId) <= 0 then
		return
	end

	self._nodeInfoMap = {}

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		self._nodeInfoMap[v.nodeId] = v
	end

	self:_clearSourceTraceSkill()
	self:_createSourceTraceSkill(self._mapRoot, sourceTraceId)
	self:_refreshAttrInfo(sourceTraceId)
	self:_refreshDetailInfo(sourceTraceId)
end

function SourceTraceMainView:_refreshDetailInfo(sourceTraceId)
	local groupInfoCfg = SourceTraceConfig.instance:getGroupInfoCfg(sourceTraceId)

	self._txtDetailDesc.text = groupInfoCfg and langPara("源起技：%s", groupInfoCfg.skillBaseDesc) or langPara("源起技无基础效果")

	local nodesCfg = SourceTraceConfig.instance:getSourceTraceNodeCfgs(sourceTraceId)
	local nodeInfoList = {}

	for i, v in ipairs(nodesCfg) do
		if #v.effectIds > 1 then
			if not NODE_TYPE_MULTI then
				local type = NODE_TYPE_NORMAL

				if self._nodeInfoMap[v.nodeId] then
					local effectCfg = SourceTraceConfig.instance:getEffectCfg(self._nodeInfoMap[v.nodeId].effectId)
					local content

					if type == NODE_TYPE_MULTI then
						local romanChar = string.sub(effectCfg.name, 1, 3)

						content = langPara("源核%s :\n%s", romanChar, effectCfg.desc)
					else
						content = langPara("%s :\n%s", effectCfg.name, effectCfg.desc)
					end

					table.insert(nodeInfoList, {
						index = 1,
						active = 1,
						type = type,
						nodeId = v.nodeId,
						content = content
					})
				else
					for j, id in ipairs(v.effectIds) do
						local effectCfg = SourceTraceConfig.instance:getEffectCfg(id)
						local content = type == NODE_TYPE_MULTI and langPara("源核%s :\n%s", effectCfg.name, effectCfg.desc) or langPara("%s :\n%s", effectCfg.name, effectCfg.desc)

						table.insert(nodeInfoList, {
							active = 0,
							type = type,
							nodeId = v.nodeId,
							index = j,
							content = content
						})
					end
				end
			end
		end
	end

	ArraySort.sortOn(nodeInfoList, {
		"active",
		"type",
		"nodeId",
		"index"
	}, {
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE,
		ArraySort.NONE
	})

	local activeList = {}
	local unActIveList = {}

	for i, v in ipairs(nodeInfoList) do
		if v.active == 0 then
			table.insert(unActIveList, v.content)
		else
			table.insert(activeList, v.content)
		end
	end

	local activeStr = table.concat(activeList, "\n\n")
	local unActIveStr = table.concat(unActIveList, "\n\n")

	self._txtNodeInfo.text = string.format("<color=#466687FF>%s</color>\n\n<color=#909294FF>%s</color>", activeStr, unActIveStr)
end

function SourceTraceMainView:_refreshAttrInfo(sourceTraceId)
	local attrMap = {}
	local buffList = {}

	for i, v in ipairs(self._curPetMo.sourceTraces) do
		local nodesCfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(sourceTraceId, v.nodeId)
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(v.effectId)
		local attrValue = FightingPowerFormula.instance:parseAttrValues(effectCfg.propertyParam) or {}

		for attrType, value in pairs(attrValue) do
			attrMap[attrType] = checknumber(attrMap[attrType]) + value
		end

		if nodesCfg.effectIds and #nodesCfg.effectIds > 1 then
			table.insert(buffList, effectCfg)
		end
	end

	local attrList = {}

	for i, v in pairs(attrMap) do
		table.insert(attrList, {
			attrType = i,
			value = v
		})
	end

	table.sort(attrList, function(a, b)
		return a.attrType < b.attrType
	end)
	self._attrTableList:reloadData(attrList)
	GameUtil.SetActive(self._skillEmptyTips, #buffList <= 0)
	self._skillTableList:reloadData(buffList)

	local groupInfoCfg = SourceTraceConfig.instance:getGroupInfoCfg(sourceTraceId)

	if groupInfoCfg then
		uGuiUtil.setSpriteToImage(self._mapBg, nil, groupInfoCfg.mapBgRes)

		self._txtBaseDesc.text = langPara("源起技：%s", groupInfoCfg.skillBaseDesc)
	else
		printError("图谱背景图未配置，id = ", sourceTraceId)

		self._txtBaseDesc.text = langPara("源起技无基础效果")
	end
end

function SourceTraceMainView:_createSourceTraceSkill(rootGo, sourceTraceId)
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

				self._baseShowLine:AddVertices(GameUtil.getLocalPos(curCell), GameUtil.getLocalPos(targetCell), Framework.ColorUtil.ParseColor("FFFFFFFF"), 26)
			end
		end
	end
end

function SourceTraceMainView:_clearSourceTraceSkill()
	if self._nodeCellList then
		for i, v in pairs(self._nodeCellList) do
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

function SourceTraceMainView:_genarateNodeCell(rootGo, cellCfg)
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

function SourceTraceMainView:_disposeFunc(obj, index)
	goutil.destroy(obj)
end

function SourceTraceMainView:_resetFunc(obj, index)
	GameUtil.SetActive(obj.gameObject, false)
end

function SourceTraceMainView:_updateNormalCell(cellGo, cfg)
	local go = cellGo

	GameUtil.setAnchoredPos(go, cfg.pos[1], cfg.pos[2])

	local iconGo = goutil.findChild(go, "Mask")
	local iconBg = goutil.findChild(go, "ImgC_Bg")
	local unActiveableMaskGo = goutil.findChild(go, "unActiveableMask")
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local imageChangeSkillIcon = skillIconSprite:GetComponent(ComponentType.UIImageSpriteChange)
	local btn = goutil.findChild(go, "btn")
	local activableGo = goutil.findChild(go, "activeableGo")
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

	local isActive = self._nodeInfoMap[cfg.nodeId] ~= nil

	GameUtil.SetActive(unActiveableMaskGo, not isActive)

	if self:_isCanActiveNode(cfg.groupId, cfg.nodeId) == true then
		GameUtil.SetActive(activableGo, true)
	else
		GameUtil.SetActive(activableGo, false)
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickNormalCell(cfg.nodeId)
	end)
end

function SourceTraceMainView:_clearNormalCell(cellGo)
	local go = cellGo
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local btn = goutil.findChild(go, "btn")

	uGuiUtil.clearImage(skillIconLoad)
	GameUtil.rmClickHandler(btn)
end

function SourceTraceMainView:_updateMultiCell(cellGo, cfg)
	local go = cellGo

	GameUtil.setAnchoredPos(go, cfg.pos[1], cfg.pos[2])

	local cellRoot = goutil.findChild(go, "cellsRoot")
	local cell = goutil.findChild(go, "cellsRoot/cell")
	local recordPos = cellRoot:GetComponent(ComponentType.TestRecordPos)
	local activableGo = goutil.findChild(go, "activeableGo")
	local activeTag = goutil.findChild(go, "activeTag")
	local btn = goutil.findChild(go, "btnEffect")
	local singleCellInfos = {}
	local firstEffectId, selectInfo

	for i, v in ipairs(cfg.effectIds) do
		firstEffectId = firstEffectId or v

		if self._nodeInfoMap[cfg.nodeId] and self._nodeInfoMap[cfg.nodeId].effectId == v then
			selectInfo = {
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

	if selectInfo then
		firstEffectId = selectInfo.effectId

		table.insert(singleCellInfos, selectInfo)
	end

	GameUtil.updateCellsList(cellRoot, cell, singleCellInfos, self._updateMutiSingleCell, self)
	recordPos:LoadPlan(#singleCellInfos - 1)
	GameUtil.SetActive(activeTag, self._nodeInfoMap[cfg.nodeId])

	if self:_isCanActiveNode(cfg.groupId, cfg.nodeId) == true then
		GameUtil.SetActive(activableGo, true)
	else
		GameUtil.SetActive(activableGo, false)
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickMutiCell(cfg.nodeId, firstEffectId)
	end)
end

function SourceTraceMainView:_clearMultiCell(cellGo)
	local go = cellGo
	local cellRoot = goutil.findChild(go, "cellsRoot")
	local btn = goutil.findChild(go, "btnEffect")

	GameUtil.SetActive(go, false)
	GameUtil.clearCells(cellRoot, self._clearMultiSingleCell, self, false)
	GameUtil.rmClickHandler(btn)
end

function SourceTraceMainView:_updateMutiSingleCell(cell, data, index)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")
	local skillIconSprite = goutil.findChild(go, "Mask/ImgC_Icon")
	local unActiveableMask = goutil.findChild(go, "unActiveableMask")
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

	local isActive = self._nodeInfoMap[data.nodeCfg.nodeId] ~= nil
	local isSelect = isActive and self._nodeInfoMap[data.nodeCfg.nodeId].effectId == data.effectId

	GameUtil.SetActive(unActiveableMask, not isSelect)
end

function SourceTraceMainView:_clearMultiSingleCell(cell)
	local go = cell.gameObject
	local skillIconLoad = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIconLoad)
end

function SourceTraceMainView:_isCanActiveNode(groupId, nodeId)
	local cfg = SourceTraceConfig.instance:getSourceTraceNodeCfg(groupId, nodeId)
	local isActivable = self._nodeInfoMap[cfg.nodeId] == nil

	if isActivable == true and cfg.preNodeIds then
		for i, v in ipairs(cfg.preNodeIds) do
			if self._nodeInfoMap[v] == nil then
				isActivable = false

				break
			end
		end
	end

	local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(cfg.unlockCost)

	if isActivable == true and not MaterialModel.instance:IsEnough(costMatType, costMatId, costMatNum) then
		isActivable = false
	end

	return isActivable
end

function SourceTraceMainView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt = goutil.findChildTextComponent(go, "nameText")
	local valueTxt = goutil.findChildTextComponent(go, "valueText")
	local iconGo = goutil.findChild(go, "attr")
	local icon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")

	if data.attrType then
		goutil.setActive(iconGo, true)
		icon:SetState(data.attrType - 1)
	else
		goutil.setActive(iconGo, false)
	end

	valueTxt.text = data.value > 0 and data.value < 1 and string.format("%s%%", data.value * 100) or data.value
	nameTxt.text = GameEnum.AttrTypeName[data.attrType]
end

function SourceTraceMainView:_clearAttrCell(cell)
	return
end

function SourceTraceMainView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local skillIcon = goutil.findChild(go, "Mask/ImgC_Skill")
	local txtDesc = goutil.findChildTextComponent(go, "desc")

	uGuiUtil.setSpriteToImage(skillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(data.iconRes))

	txtDesc.text = data.desc
end

function SourceTraceMainView:_clearSkillCell(cell)
	local go = cell.gameObject
	local skillIcon = goutil.findChild(go, "Mask/ImgC_Skill")

	uGuiUtil.clearImage(skillIcon)
end

function SourceTraceMainView:_onClickNormalCell(nodeId)
	UIStateManager.instance:push(ViewName.SourceTraceUpgradeView, nodeId)
end

function SourceTraceMainView:_onClickMutiCell(nodeId, effectId)
	UIStateManager.instance:push(ViewName.SourceTraceMultiNodeView, nodeId, effectId)
end

function SourceTraceMainView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._detailInfo, false)
	end
end

function SourceTraceMainView:_onClickDetail()
	GameUtil.SetActive(self._detailInfo, true)
end

function SourceTraceMainView:_onClickOneKey()
	self._curPetMo = BagPetsController.instance:GetCurPetMo()

	local petCfg = CharacterConfig.instance:getPetCo(self._curPetMo.raceId)
	local sourceTraceId = petCfg.sourceTraceId

	if checknumber(sourceTraceId) <= 0 then
		return
	end

	local checkList = {}
	local nodeCfgs = SourceTraceConfig.instance:getSourceTraceNodeCfgs(sourceTraceId)

	for i, v in ipairs(nodeCfgs) do
		if not self._nodeInfoMap[v.nodeId] then
			local isAllPreActive = true

			for j, id in ipairs(v.preNodeIds) do
				if not self._nodeInfoMap[id] then
					isAllPreActive = false

					break
				end
			end

			if isAllPreActive == true then
				table.insert(checkList, v)
			end
		end
	end

	if #checkList <= 0 then
		FloatWordMgr.instance:show(lang("已激活全部节点"))

		return
	end

	local isCanActive = false

	for i, v in ipairs(checkList) do
		local unlockCostArr = string.split(v.unlockCost, "#")
		local isAllMatEnough = true

		for j, str in ipairs(unlockCostArr) do
			local matType, matId, matNum = MaterialMgr.getMatParams(str)

			if not MaterialModel.instance:IsEnough(matType, matId, matNum) then
				isAllMatEnough = false

				break
			end
		end

		if isAllMatEnough == true then
			isCanActive = true

			break
		end
	end

	if isCanActive == true then
		SourceTraceAgent.instance:sendPM_SourceTraceOneKeyUnlockNodeReq(self._curPetMo.petId)
	else
		FloatWordMgr.instance:show(lang("无可激活节点"))
	end
end

return SourceTraceMainView

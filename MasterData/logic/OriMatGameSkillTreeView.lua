-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameSkillTreeView.lua

module("logic.extensions.orimatgame.view.OriMatGameSkillTreeView", package.seeall)

local OriMatGameSkillTreeView = class("OriMatGameSkillTreeView", ViewComponent)
local TreeWidth = 3

function OriMatGameSkillTreeView:buildUI()
	OriMatGameSkillTreeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtName = self:getTxt("infoCol/name/txt")
	self._skillIcon = self:getGo("infoCol/skillIcon")
	self._txtDesc = self:getTxt("infoCol/txtDesc")
	self._tagActive = self:getGo("infoCol/tagActive")
	self._btnActive = self:getGo("infoCol/active/btn")
	self._activeCol = self:getGo("infoCol/active")
	self._coin = self:getGo("infoCol/active/coin")
	self._txtCoin = self:getTxt("infoCol/active/coin/txt")
	self._iconCoin = self:getGo("infoCol/active/coin/icon")

	local talentScrView = self:getGo("talentCol/scrView")
	local talentScrCell = self:getGo("talentCol/scrCell")

	self._talentScrollerList = ScrollerList.create(talentScrView, talentScrCell, GameUtil.handler(self._updateTalentCell, self), GameUtil.handler(self._clearTalentCell, self))
	self._goldBarCon = self:getGo("goldBarCon")
	self._unitCellLists = {}
end

function OriMatGameSkillTreeView:bindEvents()
	OriMatGameSkillTreeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnActive, self._onClickBtnActive, self)
end

function OriMatGameSkillTreeView:unbindEvents()
	OriMatGameSkillTreeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnActive)
end

function OriMatGameSkillTreeView:onEnter()
	OriMatGameSkillTreeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._subMo = OriMatGameController.instance:getSubMo(self._seasonId)
	self._selectedTalentId = self._selectedTalentId or 1
	self._unlockTalentIdPool = {}

	local matList = {}
	local dataList = OriMatGameConfig.instance:getTalentDataList()

	for _, data in ipairs(dataList) do
		if not string.nilorempty(data.cost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)

			matList[matType .. ":" .. matId] = true
		end
	end

	local list = {}

	for matStr, _ in pairs(matList) do
		local tab = {
			showAdd = false,
			id = matStr
		}

		table.insert(list, tab)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameUnlockTalentRes, self._handlePM_OriginMaterialGameUnlockTalentRes, self)
	self:_onUpdate()
end

function OriMatGameSkillTreeView:onExit()
	OriMatGameSkillTreeView.super.onExit(self)
	self:_onClearTalentCol()
	self:_onClearInfoCol()
end

function OriMatGameSkillTreeView:_handlePM_OriginMaterialGameUnlockTalentRes(msg)
	local talentId = checknumber(msg.talentId)

	self._unlockTalentIdPool[talentId] = true

	self:_onUpdateTalentCol()
end

function OriMatGameSkillTreeView:_onUpdate()
	local dataList = OriMatGameConfig.instance:getTalentDataList()

	self._layerInfoList = {}
	self._unlockList = {}

	for _, data in ipairs(dataList) do
		local talentId = data.talentId
		local pos = data.pos
		local posX, posY = pos[1], pos[2]

		self._layerInfoList[posX] = self._layerInfoList[posX] or {}
		self._layerInfoList[posX][posY] = talentId

		for i, v in ipairs(data.lockIds) do
			self._unlockList[v] = self._unlockList[v] or {}

			table.insert(self._unlockList[v], talentId)
		end
	end

	self:_onUpdateTalentCol()
	self:_onUpdateInfoCol()
end

function OriMatGameSkillTreeView:_onUpdateTalentCol()
	self._talentScrollerList:reloadData(self._layerInfoList)

	local firstLockedLayer = 1

	for posX, array in ipairs(self._layerInfoList) do
		firstLockedLayer = posX

		local allUnlocked = true

		for posY = 1, TreeWidth do
			local talentId = checknumber(array[posY])

			if talentId > 0 and not self._subMo:isUnlockTalent(talentId) then
				allUnlocked = false

				break
			end
		end

		if not allUnlocked then
			break
		end
	end

	self._talentScrollerList:MoveCellInView(Mathf.Min(firstLockedLayer, #self._layerInfoList) - 1, true)
end

function OriMatGameSkillTreeView:_onClearTalentCol()
	self._talentScrollerList:dispose()

	self._unitCellLists = {}
end

function OriMatGameSkillTreeView:_updateTalentCell(view, talentCell, info, tag)
	local mainGo = talentCell.gameObject
	local unitCellList = self._unitCellLists[mainGo]

	if unitCellList == nil then
		unitCellList = {}

		for posY = 1, TreeWidth do
			local cell = {}
			local go = goutil.findChild(mainGo, string.format("unit%d", posY))

			cell._mainGo = go
			cell._btn = goutil.findChild(go, "btn")
			cell._tagSelect = goutil.findChild(go, "btn/tagSelect")
			cell._icon = goutil.findChild(go, "btn/icon")
			cell._tagActive = goutil.findChild(go, "btn/tagActive")
			cell._red = goutil.findChild(go, "btn/red")
			cell._effRoot = goutil.findChild(go, "btn/effRoot")
			cell._linesLeft = goutil.findChild(go, "lines/left")
			cell._linesRight = goutil.findChild(go, "lines/right")
			cell._linesCenter = goutil.findChild(go, "lines/center")
			unitCellList[posY] = cell
		end

		self._unitCellLists[mainGo] = unitCellList
	end

	for posY = 1, TreeWidth do
		local cell = unitCellList[posY]
		local talentId = checknumber(info[posY])
		local talentData = OriMatGameConfig.instance:getTalentCfg(talentId)

		if talentData then
			local buffData = OriMatGameConfig.instance:getBuffCfg(talentData.buffId)
			local iconUrl = string.format("ui/icon/%s.png", talentData.iconUrl)

			uGuiUtil.setSpriteToImage(cell._icon, uGuiUtil.SpriteType.BigBg, iconUrl)

			local isSelected = self._selectedTalentId == talentId

			GameUtil.SetActive(cell._tagSelect, isSelected)

			local isUnlock = self._subMo:isUnlockTalent(talentId)

			GameUtil.SetActive(cell._tagActive, not isUnlock)

			if self._unlockTalentIdPool[talentId] then
				self._unlockTalentIdPool[talentId] = nil

				local effPath = "fx_ui_2021930/fx_ui_shenqi/fx_ui_01_shenqishenwei.prefab"

				self:playViewEffectUniGo(effPath, cell._effRoot, nil, false)
			else
				self:stopViewEffectUniGo(cell._effRoot)
			end

			local result = OriMatGameController.instance:getTryUnlockTalentResultAndTips(false, self._seasonId, talentId)

			GameUtil.SetActive(cell._red, result == GameEnum.ResultCode.Success)

			if not self._unlockList[talentId] then
				GameUtil.SetActive(cell._linesLeft, false)
				GameUtil.SetActive(cell._linesCenter, false)
				GameUtil.SetActive(cell._linesRight, false)

				for _, id in ipairs(self._unlockList[talentId]) do
					local data = OriMatGameConfig.instance:getTalentCfg(id)
					local py = data.pos[2]
					local value = py - posY

					if value < 0 then
						GameUtil.SetActive(cell._linesLeft, true)
					elseif value == 0 then
						GameUtil.SetActive(cell._linesCenter, true)
					elseif value > 0 then
						GameUtil.SetActive(cell._linesRight, true)
					end
				end

				GameUtil.addClickHandler(cell._btn, function()
					if self._selectedTalentId == talentId then
						return
					end

					local curSelect = self._selectedTalentId

					self._selectedTalentId = talentId

					local list = self._talentScrollerList:getData()

					for posX, posYList in pairs(list) do
						for posY = 1, TreeWidth do
							if posYList[posY] == curSelect then
								self._talentScrollerList:updateCellInViewByIndex(posX - 1)

								break
							end
						end
					end

					GameUtil.SetActive(cell._tagSelect, true)
					self:_onUpdateInfoCol()
				end)
				GameUtil.SetActive(cell._mainGo, true)
			end
		else
			GameUtil.SetActive(cell._mainGo, false)
		end
	end
end

function OriMatGameSkillTreeView:_clearTalentCell(cell)
	local mainGo = cell.gameObject

	for posY = 1, TreeWidth do
		local go = goutil.findChild(mainGo, string.format("unit%d", posY))
		local btn = goutil.findChild(go, "btn")
		local icon = goutil.findChild(go, "btn/icon")
		local effRoot = goutil.findChild(go, "btn/effRoot")

		uGuiUtil.clearImage(icon)
		GameUtil.rmClickHandler(btn)
		self:stopViewEffectUniGo(effRoot)
	end
end

function OriMatGameSkillTreeView:_onUpdateInfoCol()
	local talentData = OriMatGameConfig.instance:getTalentCfg(self._selectedTalentId)

	if talentData then
		if not talentData.talentId then
			local talentId = 0

			if talentData then
				if not talentData.buffId then
					local buffId = 0
					local buffData = OriMatGameConfig.instance:getBuffCfg(buffId)

					if talentData then
						local iconUrl = string.format("ui/icon/%s.png", talentData.iconUrl)

						uGuiUtil.setSpriteToImage(self._skillIcon, uGuiUtil.SpriteType.BigBg, iconUrl)
					else
						uGuiUtil.clearImage(self._skillIcon)
					end

					self._txtDesc.text = talentData and talentData.desc
					self._txtName.text = talentData and talentData.name

					local isUnlock = self._subMo:isUnlockTalent(talentId)

					GameUtil.SetActive(self._tagActive, isUnlock)
					GameUtil.SetActive(self._activeCol, not isUnlock)

					local cost = talentData and talentData.cost

					if not string.nilorempty(cost) then
						local matType, matId, matNum = MaterialMgr.getMatParams(cost)

						MaterialMgr.setIcon(self._iconCoin, matType, matId, nil, nil)

						self._txtCoin.text = matNum

						GameUtil.SetActive(self._coin, true)
					else
						MaterialMgr.clearIcon(self._iconCoin)
						GameUtil.SetActive(self._coin, false)
					end

					local result = OriMatGameController.instance:getTryUnlockTalentResultAndTips(false, self._seasonId, self._selectedTalentId)

					GameUtil.SetGray(self._btnActive, result ~= GameEnum.ResultCode.Success)
				end
			end
		end
	end
end

function OriMatGameSkillTreeView:_onClearInfoCol()
	uGuiUtil.clearImage(self._skillIcon)
	MaterialMgr.clearIcon(self._iconCoin)
	GameUtil.SetGray(self._btnActive, false)
end

function OriMatGameSkillTreeView:_onClickBtnTip()
	local key = OriMatGameConfig.instance:getCommonValue("RULEKEY_TALENT", false)

	TipsFacade.instance:openRulesView(key)
end

function OriMatGameSkillTreeView:_onClickBtnActive()
	local result = OriMatGameController.instance:getTryUnlockTalentResultAndTips(true, self._seasonId, self._selectedTalentId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	OriMatGameController.instance:sendPM_OriginMaterialGameUnlockTalentReq(self._seasonId, self._selectedTalentId)
end

return OriMatGameSkillTreeView

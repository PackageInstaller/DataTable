-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetRuneMainDlg.lua

local PetRuneInfoPanel = require("UI/Pet/PetRuneInfoPanel")
local ResPetRune = require("ClientData/ResPetRune")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local DragHeroSortPanel = require("UI/Battle/DragHeroSortPanel")
local Hero = require("Common/Object/Hero")
local strClassName = "PetRuneMainDlg"
local PetRuneMainDlg = Class(strClassName, UIControls.Window)
local EXCLUSIVE_RUNE_NODE_NUM = 5
local NORMAL_RUNE_NODE_NUM = 32
local PET_RUNE_ATLAS = "Atlas/PetAtlas/PetRuneMainAtlas"

function PetRuneMainDlg:ctor(...)
	self:initUI()
end

function PetRuneMainDlg:getExclusiveRuneNum()
	local num = 1

	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_EXCLUSIVE and num < v.node_id then
			num = v.node_id
		end
	end

	return num
end

function PetRuneMainDlg:initUI(...)
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.uIClickThrough02 = UIControls.Button(self, "InfoPanel/Rune02/UIClickThrough")

	self.uIClickThrough02:addEventClick(self.onUIClickThrough02Click)

	self.uIClickThrough01 = UIControls.Button(self, "InfoPanel/Rune01/UIClickThrough")

	self.uIClickThrough01:addEventClick(self.onUIClickThrough01Click)

	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self.onSelfAniFinish)

	self.panelRune01 = UIControls.Panel(self, "InfoPanel/Rune01")
	self.panelRune02 = UIControls.Panel(self, "InfoPanel/Rune02")
	self.runeInfoPanel01 = UIControls.UIAni(self, "InfoPanel/Rune01/RuneInfoPanel")
	self.runeInfoPanel02 = UIControls.UIAni(self, "InfoPanel/Rune02/RuneInfoPanel")

	self.runeInfoPanel01:addEventFinish(self.onPanel01AniFinish)
	self.runeInfoPanel02:addEventFinish(self.onPanel02AniFinish)

	self.normalRuneInfoPanel = PetRuneInfoPanel(self, "InfoPanel/Rune01/RuneInfoPanel")
	self.exclusiveRuneInfoPanel = PetRuneInfoPanel(self, "InfoPanel/Rune02/RuneInfoPanel")
	self.btnChange01 = UIControls.Button(self, "InfoPanel/Rune01/BtnChange")

	self.btnChange01:addEventClick(self.onBtnChange01Click)

	self.btnChange02 = UIControls.Button(self, "InfoPanel/Rune02/BtnChange")

	self.btnChange02:addEventClick(self.onBtnChange02Click)

	self.iconNew01 = UIControls.Image(self, "InfoPanel/Rune01/BtnChange/IconNew")
	self.iconNew02 = UIControls.Image(self, "InfoPanel/Rune02/BtnChange/IconNew")
	self.exclusiveNodeGroup = {}

	for i = 1, EXCLUSIVE_RUNE_NODE_NUM do
		local node = UIControls.Panel(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i)
		local iconImg = UIControls.Image(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i .. "/IconImg")
		local btn = UIControls.Button(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i .. "/IconImg")

		btn:addEventClick(Functor(self.onBtnExRuneClick, self, i))

		local selectImg = UIControls.Image(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i .. "/SelectImg")
		local textNum = UIControls.Label(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i .. "/TextNum")
		local efx = UIControls.LazyEffectPlayer(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i .. "/Efx")
		local iconNew = UIControls.Panel(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i .. "/IconNew")

		table.insert(self.exclusiveNodeGroup, {
			node = node,
			iconImg = iconImg,
			selectImg = selectImg,
			textNum = textNum,
			efx = efx,
			iconNew = iconNew
		})
	end

	self.normalNodeGroup = {}

	for j = 1, 2 do
		local subNodeGroup = {}

		for i = 1, NORMAL_RUNE_NODE_NUM do
			local numStr = i >= 10 and i or "0" .. i
			local node = UIControls.Panel(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr)
			local lineImgs = {}
			local lineImg01 = UIControls.Image(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr .. "/LineImg")

			table.insert(lineImgs, lineImg01)

			for k = 2, 5 do
				local lineImg

				if UIControls.checkControlFunc(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr .. "/LineImg/LineImg0" .. k) then
					lineImg = UIControls.Image(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr .. "/LineImg/LineImg0" .. k)

					table.insert(lineImgs, lineImg)
				end
			end

			local iconImg = UIControls.Image(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr .. "/IconImg")
			local btn = UIControls.Button(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr .. "/IconImg")

			btn:addEventClick(Functor(self.onBtnNormalRuneClick, self, j, i))

			local selectImg = UIControls.Image(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr .. "/SelectImg")
			local efx = UIControls.LazyEffectPlayer(self, "InfoPanel/Rune01/NodeGroup/Viewport/Content/NodeGroup0" .. j .. "/Node" .. numStr .. "/Efx")

			table.insert(subNodeGroup, {
				node = node,
				iconImg = iconImg,
				selectImg = selectImg,
				lineImgs = lineImgs,
				efx = efx
			})
		end

		self.normalNodeGroup[j] = subNodeGroup
	end

	self.heroGrids = {}

	if UIControls.checkControlFunc(self, "InfoPanel/Rune02/CardListPanel") then
		self.panelChoose = UIControls.Panel(self, "InfoPanel/Rune02/CardListPanel")
		self.btnSave = UIControls.Button(self, "InfoPanel/Rune02/CardListPanel/BtnFuncPanel/BtnSave")

		self.btnSave:addEventClick(self.onBtnSaveClick)

		self.btnCancel = UIControls.Button(self, "InfoPanel/Rune02/CardListPanel/BtnFuncPanel/BtnCancel")

		self.btnCancel:addEventClick(self.onBtnCancelClick)

		self.scrollView = UIControls.ScrollViewLoopV(self, "InfoPanel/Rune02/CardListPanel/CardPanel")

		self.scrollView:addEventCellChanged(self.onHeroCellChanged)

		self.cells = {}
		self.filterSelectPanel = FilterSelectPanel(self, "InfoPanel/Rune02/CardListPanel/BtnFuncPanel/ListSelectPanel")
		self.panelSort = DragHeroSortPanel(self, "InfoPanel/Rune02/CardListPanel/BtnFuncPanel")
		self.panelSort.mEventHeroListChanged = Slot(self.onHerosChanged, self)
		self.panelSort.filterSelectPanel = self.filterSelectPanel

		self.panelSort:initSortPanel(UIConst.HERO_DEFAULT_SORT_MAP, UIConst.HERO_DEFAULT_FILTER_PANEL_MAP)

		self.choosedHero = nil
		self.inChooseMode = false
	end

	self.imgPlanNameBg = UIControls.Image(self, "InfoPanel/Rune02/BgProgramName")
	self.txtPlanName = UIControls.Label(self, "InfoPanel/Rune02/BgProgramName/TextProgramName")
	self.btnSavePlan = UIControls.Button(self, "InfoPanel/Rune02/BtnSave")

	self.btnSavePlan:addEventClick(self.onClickBtnSavePlan)
end

function PetRuneMainDlg:setData(type)
	self.isEditPlan = false
	self.type = type or Const.PET_RUNE_TYPE_NORMAL
	self.exclusiveRuneNum = self:getExclusiveRuneNum()

	for i, v in ipairs(self.exclusiveNodeGroup) do
		if i <= self.exclusiveRuneNum then
			v.node:setVisible(true)
		else
			v.node:setVisible(false)
		end
	end

	self:initNormalRuneResData()
	self:refreshUI()
end

function PetRuneMainDlg:setPlanData(isEditPlan, planId)
	self.imgPlanNameBg:setVisible(true)

	if isEditPlan then
		self.isEditPlan = true
		self.planId = planId

		local planData = CurAvatar:getEquipPlanData(self.planId)

		self.planData = utils.deepcopy(planData)
		self.fakeExclusiveRuneList = utils.deepcopy(self.planData.runeList)
		self.type = Const.PET_RUNE_TYPE_EXCLUSIVE
		self.exclusiveRuneNum = self:getExclusiveRuneNum()

		for i, v in ipairs(self.exclusiveNodeGroup) do
			if i <= self.exclusiveRuneNum then
				v.node:setVisible(true)
			else
				v.node:setVisible(false)
			end
		end

		self.txtPlanName:setText(self.planData.name)
		self:refreshUI()
	else
		self.txtPlanName:setText(Lang.get(98969))
		self:setData(Const.PET_RUNE_TYPE_EXCLUSIVE)
	end
end

function PetRuneMainDlg:initNormalRuneResData()
	self.normalRuneData = {}

	for i, v in pairs(ResPetRune) do
		if v.node_type == Const.PET_RUNE_TYPE_NORMAL then
			if not self.normalRuneData[v.group] then
				self.normalRuneData[v.group] = {}
			end

			if not self.normalRuneData[v.group][v.node_id] then
				self.normalRuneData[v.group][v.node_id] = {}
			end

			table.insert(self.normalRuneData[v.group][v.node_id], v)
			table.sort(self.normalRuneData[v.group][v.node_id], function(a, b)
				return a.id < b.id
			end)
		end
	end
end

function PetRuneMainDlg:refreshUI(resid)
	self.panelRune01:setVisible(self.type == Const.PET_RUNE_TYPE_NORMAL)
	self.panelRune02:setVisible(self.type == Const.PET_RUNE_TYPE_EXCLUSIVE)
	self.iconNew02:setVisible(CurAvatar:checkNormalRuneRedHint())
	self.iconNew01:setVisible(CurAvatar:checkExclusiveRuneRedHint())

	if self.type == Const.PET_RUNE_TYPE_NORMAL then
		self:refreshNormalRuneUI(resid)
	elseif self.type == Const.PET_RUNE_TYPE_EXCLUSIVE then
		self:refreshExclusiveRuneUI(resid)
	end

	self:refreshRuneInfoUI()
	self:refreshBtnSavePlan()
end

function PetRuneMainDlg:refreshNormalRuneUI(resid)
	self.normalRuneList = CurAvatar:getNormalRuneList()
	self.normalRuneNodeDic = {}

	for i, v in ipairs(self.normalRuneList) do
		local runeData = ResPetRune[v.id]

		if runeData then
			if not self.normalRuneNodeDic[runeData.group] then
				self.normalRuneNodeDic[runeData.group] = {}
			end

			if not self.normalRuneNodeDic[runeData.group][runeData.node_id] then
				self.normalRuneNodeDic[runeData.group][runeData.node_id] = {}
			end

			table.insert(self.normalRuneNodeDic[runeData.group][runeData.node_id], v.id)
		end
	end

	for group_id, group in ipairs(self.normalRuneData) do
		local groupNodeNum = 0
		local lineImgName = group_id == 1 and "BgLine01Nml" or "BgLine02Nml"

		for node_id, nodeGroup in ipairs(group) do
			for i, node in ipairs(nodeGroup) do
				groupNodeNum = groupNodeNum + 1

				local iconImgNmlName = group_id == 1 and "IconSmallFoodNml" or "IconSmallPlayNml"
				local iconImgDisName = group_id == 1 and "IconSmallFoodDis" or "IconSmallPlayDis"

				if groupNodeNum == 1 then
					iconImgNmlName = group_id == 1 and "IconBigFoodNml" or "IconBigPlayNml"
					iconImgDisName = group_id == 1 and "IconBigFoodDis" or "IconBigPlayDis"
				end

				local curNodeUI = self.normalNodeGroup[group_id][groupNodeNum]

				if self:isNodeActive(group_id, node_id, node.id) then
					if resid and node.id == resid then
						curNodeUI.efx:setVisible(true)
					end

					curNodeUI.iconImg:setImage(PET_RUNE_ATLAS, iconImgNmlName)

					for _, lineImg in pairs(curNodeUI.lineImgs) do
						if lineImg then
							lineImg:setImage(PET_RUNE_ATLAS, lineImgName)
						end
					end
				else
					curNodeUI.iconImg:setImage(PET_RUNE_ATLAS, iconImgDisName)

					for _, lineImg in pairs(curNodeUI.lineImgs) do
						if lineImg then
							lineImg:setImage(PET_RUNE_ATLAS, "BgLine01Dis")
						end
					end
				end
			end
		end
	end
end

function PetRuneMainDlg:isNodeActive(group_id, node_id, resid)
	if self.normalRuneNodeDic[group_id] and self.normalRuneNodeDic[group_id][node_id] and utils.tableIsContainsElement(self.normalRuneNodeDic[group_id][node_id], resid) then
		return true
	end

	return false
end

function PetRuneMainDlg:refreshExclusiveRuneUI(resid)
	self.exclusiveRuneNodeDic = {}

	if self.isEditPlan then
		local exclusiveRuneList = CurAvatar:getExclusiveRuneList()

		for i, v in ipairs(exclusiveRuneList) do
			local runeData = ResPetRune[v.id]

			if runeData then
				if self.exclusiveRuneNodeDic[runeData.node_id] then
					local oldRuneData = ResPetRune[self.exclusiveRuneNodeDic[runeData.node_id].id]

					if oldRuneData.level < runeData.level then
						local data = utils.deepcopy(v)

						data.hero_gid = 0
						self.exclusiveRuneNodeDic[runeData.node_id] = data
					end
				else
					local data = utils.deepcopy(v)

					data.hero_gid = 0
					self.exclusiveRuneNodeDic[runeData.node_id] = data
				end
			end
		end

		for _, data in pairs(self.fakeExclusiveRuneList) do
			if self.exclusiveRuneNodeDic[data.nodeId] and CurAvatar.heroDic[data.heroGid] then
				self.exclusiveRuneNodeDic[data.nodeId].hero_gid = data.heroGid
			end
		end
	else
		local exclusiveRuneList = CurAvatar:getExclusiveRuneList()

		for i, v in ipairs(exclusiveRuneList) do
			local runeData = ResPetRune[v.id]

			if runeData then
				if self.exclusiveRuneNodeDic[runeData.node_id] then
					local oldRuneData = ResPetRune[self.exclusiveRuneNodeDic[runeData.node_id].id]

					if oldRuneData.level < runeData.level then
						self.exclusiveRuneNodeDic[runeData.node_id] = v
					end
				else
					self.exclusiveRuneNodeDic[runeData.node_id] = v
				end
			end
		end
	end

	for i = 1, self.exclusiveRuneNum do
		if CurAvatar:isPetRuneValid(i) then
			self.exclusiveNodeGroup[i].node:setVisible(true)

			local runeData = self.exclusiveRuneNodeDic[i]
			local canActive = CurAvatar:checkExclusiveRuneCanActiveByNodeId(i)

			self.exclusiveNodeGroup[i].iconNew:setVisible(canActive)

			if runeData then
				if not CurAvatar["showExRune" .. i] and not CurAvatar:checkExclusiveRuneBindHero(i) then
					self.exclusiveNodeGroup[i].iconNew:setVisible(true)
				end

				self.exclusiveNodeGroup[i].efx:setVisible(false)

				if resid and resid == runeData.id then
					self.exclusiveNodeGroup[i].efx:setVisible(true)
				end

				if Const.REVIEW_VERSION then
					self.exclusiveNodeGroup[i].textNum:setText(Lang.get(1203) .. ResPetRune[runeData.id].level)
				else
					self.exclusiveNodeGroup[i].textNum:setText("Lv." .. ResPetRune[runeData.id].level)
				end

				local heroGid = runeData.hero_gid

				self.exclusiveNodeGroup[i].node:playStateAnimator("PetRuneNml")

				if heroGid and CurAvatar.heroDic[heroGid] then
					if not self.heroGrids[i] then
						self.heroGrids[i] = UIControls.HeroGridChild(self, "InfoPanel/Rune02/NodeGroup/Node0" .. i .. "/HeroItem", "System/StarUp/GridHeroStarUp", 0, 0, true)
						self.heroGrids[i].mEnableTips = false
						self.heroGrids[i].isShowPreviewTips = false
					end

					self.heroGrids[i]:setVisible(true)
					self.heroGrids[i]:setObj(CurAvatar.heroDic[heroGid])
				elseif self.heroGrids[i] then
					self.heroGrids[i]:setVisible(false)
				end
			else
				self.exclusiveNodeGroup[i].node:playStateAnimator("PetRuneDis")
				self.exclusiveNodeGroup[i].textNum:setText("")
			end
		else
			self.exclusiveNodeGroup[i].node:setVisible(false)
		end
	end
end

function PetRuneMainDlg:refreshRuneInfoUI()
	if self.runeInfoPanel01:getVisible() then
		self.normalRuneInfoPanel:refreshUI()
	end

	if self.runeInfoPanel02:getVisible() then
		if self.panelChoose and self.panelChoose:getVisible() then
			self.panelChoose:setVisible(false)
		end

		self.exclusiveRuneInfoPanel:refreshUI()
	end
end

function PetRuneMainDlg:onBtnNormalRuneClick(treeIndex, index)
	for i, tree in ipairs(self.normalNodeGroup) do
		for j, v in ipairs(tree) do
			v.selectImg:setVisible(i == treeIndex and j == index)
		end
	end

	self.selectTree = treeIndex
	self.selectRuneIndex = index

	self.normalRuneInfoPanel:setData()
	self.runeInfoPanel01:setVisible(true)
	self.runeInfoPanel01:stopAni("CloseRuneInfoPanel")
	self.runeInfoPanel01:startAni("ShowRuneInfoPanel")
	self.uIClickThrough01:setVisible(true)
end

function PetRuneMainDlg:onBtnExRuneClick(index)
	for i, v in ipairs(self.exclusiveNodeGroup) do
		v.selectImg:setVisible(i == index)

		if i == index then
			CurAvatar["showExRune" .. i] = true

			local canActive = CurAvatar:checkExclusiveRuneCanActiveByNodeId(index)

			v.iconNew:setVisible(canActive)
			CurAvatar:checkPetRuneRedHint()
		end
	end

	self.selectRuneIndex = index

	self.exclusiveRuneInfoPanel:setData()
	self.runeInfoPanel02:setVisible(true)
	self.runeInfoPanel02:stopAni("CloseRuneInfoPanel")
	self.runeInfoPanel02:startAni("ShowRuneInfoPanel")
	self.uIClickThrough02:setVisible(true)
end

function PetRuneMainDlg:onBtnChange01Click()
	if self.type == Const.PET_RUNE_TYPE_NORMAL then
		self.type = Const.PET_RUNE_TYPE_EXCLUSIVE

		self.aniSelf:startAni("CloseRune01")
	end
end

function PetRuneMainDlg:onBtnChange02Click()
	if self.type == Const.PET_RUNE_TYPE_EXCLUSIVE then
		self.type = Const.PET_RUNE_TYPE_NORMAL

		for i, tree in ipairs(self.normalNodeGroup) do
			for j, v in ipairs(tree) do
				v.efx:setVisible(false)
			end
		end

		self.aniSelf:startAni("CloseRune02")
	end
end

function PetRuneMainDlg:hideChangeBtn()
	self.btnChange01:setVisible(false)
	self.btnChange02:setVisible(false)
end

function PetRuneMainDlg:onUIClickThrough01Click()
	self.selectTree = nil
	self.selectRuneIndex = nil

	self.runeInfoPanel01:stopAni("ShowRuneInfoPanel")
	self.runeInfoPanel01:startAni("CloseRuneInfoPanel")
	self.uIClickThrough01:setVisible(false)

	for _, tree in ipairs(self.normalNodeGroup) do
		for _, v in ipairs(tree) do
			v.selectImg:setVisible(false)
		end
	end
end

function PetRuneMainDlg:onUIClickThrough02Click()
	self.selectRuneIndex = nil

	self.runeInfoPanel02:stopAni("ShowRuneInfoPanel")
	self.runeInfoPanel02:startAni("CloseRuneInfoPanel")
	self.uIClickThrough02:setVisible(false)

	for i, v in ipairs(self.exclusiveNodeGroup) do
		v.selectImg:setVisible(false)
	end
end

function PetRuneMainDlg:onPanel01AniFinish(aniCom, aniName)
	if aniName == "CloseRuneInfoPanel" then
		self.runeInfoPanel01:setVisible(false)
	end
end

function PetRuneMainDlg:onPanel02AniFinish(aniCom, aniName)
	if aniName == "CloseRuneInfoPanel" then
		self.runeInfoPanel02:setVisible(false)
	end
end

function PetRuneMainDlg:onSelfAniFinish(aniCom, aniName)
	if aniName == "CloseRune01" then
		self.aniSelf:startAni("ShowRune02")
		self:refreshUI()
	elseif aniName == "CloseRune02" then
		self.aniSelf:startAni("ShowRune01")
		self:refreshUI()
	elseif aniName ~= "ShowRune01" and aniName == "ShowRune02" then
		-- block empty
	end
end

function PetRuneMainDlg:updateHeroBag(allHeros, filter)
	self.allHeros = allHeros or self.allHeros
	self.filter = filter or {}
	self.showHeros = {}

	for _, hero in ipairs(self.allHeros) do
		if not self.filter[hero.gid] then
			table.insert(self.showHeros, hero)
		end
	end

	self:refreshList(true)
end

function PetRuneMainDlg:refreshList(isTop)
	if isTop then
		self.scrollView:setTotalCount(#self.showHeros, 1)
	else
		self.scrollView:setTotalCount(#self.showHeros)
	end
end

function PetRuneMainDlg:openHeroBag(rune)
	self:updateHeroBag()
	self.panelChoose:setVisible(true)
end

function PetRuneMainDlg:onHerosChanged(heros)
	self:updateHeroBag(heros, self.filter)
end

function PetRuneMainDlg:onHeroCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.HeroCardLoop(sender, "System/Hero/GridHeroCard", newIdx, 0, 0)

		targetCell:setSelectCallback(Slot(self.onCellSelect, self))
	else
		targetCell.mIndex = newIdx
	end

	local hero = self.showHeros[newIdx]

	if hero then
		targetCell:setHero(hero)

		targetCell.isDragTip = false

		targetCell.imgStateIcon:setVisible(false)

		targetCell.showSelect = true

		targetCell:setSelected(self.exclusiveRuneInfoPanel.choosedHero and self.exclusiveRuneInfoPanel.choosedHero.gid == hero.gid)

		local check = true

		if self.isEditPlan then
			check = self.exclusiveRuneInfoPanel.rune and self:checkFakeHeroBindByOtherRune(hero.gid, self.selectRuneIndex)
		else
			check = self.exclusiveRuneInfoPanel.rune and CurAvatar:checkHeroBindByOtherRune(hero.gid, self.exclusiveRuneInfoPanel.rune.id)
		end

		if check then
			if targetCell.imgSelRune then
				targetCell.imgSelRune:setVisible(true)
			end

			targetCell.btnSelf:setEnable(false)
		else
			if targetCell.imgSelRune then
				targetCell.imgSelRune:setVisible(false)
			end

			targetCell.btnSelf:setEnable(true)
		end
	end

	self.cells[newIdx] = targetCell
end

function PetRuneMainDlg:onCellSelect(sender)
	if self.exclusiveRuneInfoPanel.choosedHero == sender.hero then
		self.exclusiveRuneInfoPanel.choosedHero = nil

		sender:setSelected(false)
		self.exclusiveRuneInfoPanel:refreshRuneInfoUI()
	else
		self.exclusiveRuneInfoPanel.choosedHero = sender.hero

		for i, cell in pairs(self.cells) do
			cell:setSelected(false)
		end

		sender:setSelected(true)
		self.exclusiveRuneInfoPanel:refreshRuneInfoUI()
	end
end

function PetRuneMainDlg:refreshBtnSavePlan()
	self.btnSavePlan:setVisible(self.isEditPlan and self.checkWearChange)
end

function PetRuneMainDlg:checkFakeHeroBindByOtherRune(heroGid, nodeId)
	local num = 0

	for _, v in pairs(self.fakeExclusiveRuneList) do
		if v.nodeId ~= nodeId and CurAvatar.heroDic[v.heroGid] and CurAvatar.heroDic[heroGid] then
			local hero1 = CurAvatar.heroDic[v.heroGid]
			local hero2 = CurAvatar.heroDic[heroGid]

			if hero1.id == hero2.id then
				num = num + 1
			end
		end
	end

	return num >= 2
end

function PetRuneMainDlg:onBtnCancelClick(...)
	self.exclusiveRuneInfoPanel:initChoosedHero()
	self.exclusiveRuneInfoPanel:refreshRuneInfoUI()
	self.panelChoose:setVisible(false)
end

function PetRuneMainDlg:onBtnSaveClick(...)
	local runeData = self.exclusiveRuneNodeDic[self.selectRuneIndex]

	if self.isEditPlan then
		local check = false

		for _, v in pairs(self.fakeExclusiveRuneList) do
			if v.nodeId == self.selectRuneIndex then
				v.heroGid = self.exclusiveRuneInfoPanel.choosedHero and self.exclusiveRuneInfoPanel.choosedHero.gid or 0
				check = true

				break
			end
		end

		if not check and self.exclusiveRuneInfoPanel.choosedHero then
			table.insert(self.fakeExclusiveRuneList, {
				nodeId = self.selectRuneIndex,
				heroGid = self.exclusiveRuneInfoPanel.choosedHero.gid or 0
			})
		end

		self:refreshExclusiveRuneUI()
		self.panelChoose:setVisible(false)

		self.checkWearChange = true

		self:refreshBtnSavePlan()
	else
		local offHeroGid = runeData.hero_gid or "0"
		local onHeroGid = self.exclusiveRuneInfoPanel.choosedHero and self.exclusiveRuneInfoPanel.choosedHero.gid or "0"

		if offHeroGid ~= onHeroGid then
			RPC.petRuneHeroBind(self.exclusiveRuneInfoPanel.rune.id, onHeroGid, offHeroGid)
		else
			self.panelChoose:setVisible(false)
		end
	end
end

function PetRuneMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_RUNE)
end

function PetRuneMainDlg:onBtnCloseClick()
	if self.isEditPlan then
		if self.checkWearChange then
			local function yesFunc()
				self:onClickBtnSavePlan()
			end

			local function noFunc()
				self:setVisible(false)
			end

			UIManager.showConfirmWithId(1128, nil, Slot(yesFunc, self), Slot(noFunc, self))

			local ui = UIManager.tryGetUI("confirmui")

			if ui and ui.textContent then
				ui.textContent:setText(string.format(ResClientConfirm[1128].content, self.planData.name))
			end
		else
			self:setVisible(false)
		end
	else
		self:setVisible(false)
	end
end

function PetRuneMainDlg:onClickBtnSavePlan()
	CurAvatar.isSaveingPlan = true
	self.planData.runeList = self.fakeExclusiveRuneList

	local planItem = CurAvatar:getPlanItembyPlanData(self.planData)
	local rpcData = {
		{
			item_id = self.planData.id,
			item = planItem,
			name = planItem.name
		}
	}
	local update = 0

	RPC.equipSchemeUpdate(rpcData, CurAvatar.equipPlanVersion, update)

	self.checkWearChange = true
end

function PetRuneMainDlg:updatePlan(planData)
	if self.isEditPlan and planData and planData.id == self.planData.id then
		self.checkWearChange = false

		self:setPlanData(true, self.planData.id)
	end
end

return PetRuneMainDlg

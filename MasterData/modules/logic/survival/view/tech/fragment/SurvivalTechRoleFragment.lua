-- chunkname: @modules/logic/survival/view/tech/fragment/SurvivalTechRoleFragment.lua

module("modules.logic.survival.view.tech.fragment.SurvivalTechRoleFragment", package.seeall)

local SurvivalTechRoleFragment = class("SurvivalTechRoleFragment", LuaCompBase)

function SurvivalTechRoleFragment:ctor(survivalTechView)
	self.survivalTechView = survivalTechView
	self.survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo
	self.slotsDic = {}
end

function SurvivalTechRoleFragment:init(viewGO)
	self.viewGO = viewGO
	self.txt_role = gohelper.findChildTextMesh(self.viewGO, "#txt_role")
	self.scroll_tech = gohelper.findChild(self.viewGO, "#scroll_tech")
	self.simage_bg = gohelper.findChildSingleImage(self.viewGO, "simage_bg")
	self.imgBg = self.simage_bg:GetComponent(gohelper.Type_Image)

	local param = SimpleListParam.New()

	param.cellClass = SurvivalTechRoleDescItem
	self.descList = GameFacade.createSimpleListComp(self.scroll_tech, param, nil, self.viewContainer)
end

function SurvivalTechRoleFragment:addEventListeners()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTechChange, self.onTechChange, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalOutSideTechUnlockReply, self.onReceiveSurvivalOutSideTechUnlockReply, self)
end

function SurvivalTechRoleFragment:onDestroy()
	self.simage_bg:UnLoadImage()
end

function SurvivalTechRoleFragment:onClickSlotItem(survivalTechRoleSlotItem)
	self.survivalTechView:selectCell(survivalTechRoleSlotItem.itemIndex, survivalTechRoleSlotItem.cfg.id)
end

function SurvivalTechRoleFragment:onSelectSlotItem(survivalTechRoleSlotItem)
	if not survivalTechRoleSlotItem then
		self.descList:setSelect(nil)

		return
	end

	local descItems = self.descList:getItems()
	local descItem

	for i, v in ipairs(descItems) do
		if v.cfg.id == survivalTechRoleSlotItem.cfg.id then
			descItem = v

			break
		end
	end

	self.descList:moveTo(descItem.itemIndex)
	self.descList:setSelect(descItem.itemIndex)
end

function SurvivalTechRoleFragment:selectCell(itemIndex)
	local slotList = self:getCurSlotList()

	slotList:setSelect(itemIndex)

	if itemIndex then
		local item = slotList:getItemByIndex(itemIndex)

		return item.isFinish
	end
end

function SurvivalTechRoleFragment:onTechChange()
	if self.techId == nil then
		return
	end

	local slotList = self:getCurSlotList()

	slotList:setSelect(nil)
	self.descList:setSelect(nil)
	self:refreshTech()
end

function SurvivalTechRoleFragment:onReceiveSurvivalOutSideTechUnlockReply(param)
	AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_unlock_2)

	local techId = param.techId
	local teachCellId = param.teachCellId

	if not self.techId or techId ~= self.techId then
		return
	end

	self:refreshTech()

	local slotListComp = self:getCurSlotList()
	local items = slotListComp:getItems()

	for i, v in ipairs(items) do
		if v.cfg.id == teachCellId then
			v:playUpAnim()

			break
		end
	end

	local descItems = self.descList:getItems()
	local descItem

	for i, v in ipairs(descItems) do
		if v.cfg.id == teachCellId then
			descItem = v

			break
		end
	end

	self.descList:moveTo(descItem.itemIndex)
	self.descList:setSelect(descItem.itemIndex)
	descItem:playUpAnim()

	local slotList = self:getCurSlotList()
	local item = slotList:getCurSelectItem()

	if item and item.cfg.id == teachCellId then
		self.survivalTechView:onReceiveSurvivalOutSideTechUnlockReply(teachCellId)
	end
end

function SurvivalTechRoleFragment:setData(techId)
	self.techId = techId
	self.roleCfg = SurvivalRoleConfig.instance:getRoleCfgByTechId(techId)
	self.techIconType = self.roleCfg.techIconType

	local slotRoot

	for i = 1, 6 do
		local go = gohelper.findChild(self.viewGO, "cells/Suit_0" .. i)

		if i == self.techIconType then
			gohelper.setActive(go, true)

			slotRoot = go
		else
			gohelper.setActive(go, false)
		end
	end

	if self.slotsDic[self.techIconType] == nil then
		self.slotsDic[self.techIconType] = {}

		local param = SimpleListParam.New()

		param.cellClass = SurvivalTechRoleSlotItem

		local slotList = GameFacade.createSimpleListComp(slotRoot, param, nil, self.viewContainer)

		slotList:setOnClickItem(self.onClickSlotItem, self)
		slotList:setOnSelectChange(self.onSelectSlotItem, self)

		for i = 1, 8 do
			local str = "item" .. i
			local go = gohelper.findChild(slotRoot, str)

			slotList:addCustomItem(go)
		end

		self.slotsDic[self.techIconType] = slotList
	end

	local roleCfg = lua_survival_role.configDict[techId]

	self.txt_role.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalTechRoleFragment_1"), {
		roleCfg.name
	})

	self.descList:setSelect(nil)

	local slotList = self:getCurSlotList()

	slotList:setSelect(nil)
	self:refreshTech()

	local path = "survivaltech_tech_role" .. self.roleCfg.id

	self.simage_bg:LoadImage(ResUrl.getSurvivalTechIcon(path), function()
		self:onLoadedImage()
	end)
end

function SurvivalTechRoleFragment:onLoadedImage()
	self.imgBg:SetNativeSize()
end

function SurvivalTechRoleFragment:refreshTech()
	local data = {}
	local data2 = {}
	local techList = SurvivalTechConfig.instance:getTechList(self.techId)

	if techList then
		for i, cfg in ipairs(techList) do
			local isFinish = self.survivalOutSideTechMo:isFinish(self.techId, cfg.id)
			local isCanUp = self.survivalOutSideTechMo:isCanUp(self.techId, cfg.id)

			table.insert(data, {
				cfg = cfg,
				isFinish = isFinish
			})
			table.insert(data2, {
				cfg = cfg,
				isFinish = isFinish,
				isCanUp = isCanUp,
				slotIndex = self.techIconType
			})
		end

		table.sort(data, self.techCfgSort)
	end

	self.descList:setData(data, false)

	local slotList = self:getCurSlotList()

	slotList:setData(data2, false)

	local items = slotList:getItems()

	for i, v in pairs(items) do
		v:tryPlayCanUpAnim()
	end
end

function SurvivalTechRoleFragment.techCfgSort(dataA, dataB)
	local cfgA = dataA.cfg
	local cfgB = dataB.cfg
	local isFinishA = dataA.isFinish
	local isFinishB = dataB.isFinish

	if isFinishA ~= isFinishB then
		return isFinishA
	end

	return cfgA.point < cfgB.point
end

function SurvivalTechRoleFragment:getCurSlotList()
	return self.slotsDic[self.techIconType]
end

return SurvivalTechRoleFragment

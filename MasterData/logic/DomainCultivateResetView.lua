-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomainCultivateResetView.lua

module("logic.extensions.domaincultivate.view.DomainCultivateResetView", package.seeall)

local DomainCultivateResetView = class("DomainCultivateResetView", TableViewComponent)

function DomainCultivateResetView:ctor()
	DomainCultivateResetView.super.ctor(self)
end

function DomainCultivateResetView:unbindEvents()
	DomainCultivateResetView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function DomainCultivateResetView:bindEvents()
	DomainCultivateResetView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function DomainCultivateResetView:buildUI()
	DomainCultivateResetView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._skillIcon = self:getGo("skill/skillIcon")
	self._txtName = self:getTxt("skill/txtName")
	self._txtDesc = self:getTxt("skill/txtDesc")
	self._txtCost = {}
	self._txtCost[1] = self:getTxt("layout/item1/txtCost")
	self._txtCost[2] = self:getTxt("layout/item2/txtCost")
	self._itemIcon = {}
	self._item2 = self:getGo("layout/item2")
	self._itemIcon[1] = self:getGo("layout/item1/txtCost/icon")
	self._itemIcon[2] = self:getGo("layout/item2/txtCost/icon")
end

function DomainCultivateResetView:onExit()
	DomainCultivateResetView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KamuiCultivateChange, self._refreshCurBuff, self)

	for k, v in pairs(self._itemIcon) do
		uGuiUtil.clearImage(v)
	end

	uGuiUtil.clearImage(self._skillIcon)
end

function DomainCultivateResetView:onEnter()
	DomainCultivateResetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petId = params[1]
	self._level = params[2]

	GlobalDispatcher:addListener(GlobalNotify.KamuiCultivateChange, self._refreshCurBuff, self)
	self:_refreshCurBuff()

	local petCfg = CharacterConfig.instance:getPetCo(self._petMo.raceId)
	local planId = petCfg.kamuiProgramId
	local levelCfg = DomainCultivateConfig.instance:getLevelCfg2(petCfg.kamuiProgramId, self._level)

	self._consume = levelCfg.resetCost

	local cfgStrategys = DomainCultivateConfig.instance:getProgramCfg(planId, self._level)
	local list = {}

	for k, v in pairs(cfgStrategys) do
		table.insert(list, v)
	end

	self:updateListData(list)

	local consums = string.split(self._consume, "#")

	goutil.setActive(self._item2, #consums > 1)

	for k, v in ipairs(consums) do
		local matType, cfgId, num = MaterialMgr.getMatParams(v)

		self._txtCost[k].text = num

		local spriteType = uGuiUtil.SpriteType.BigBg
		local iconUrl = ""
		local cfg = MaterialMgr.getMatCfg(matType, cfgId)

		if cfg then
			local icon = cfg.icon

			iconUrl = GameUrl.getItemIconUrl(icon)
		end

		uGuiUtil.setSpriteToImage(self._itemIcon[k], spriteType, iconUrl)
	end
end

function DomainCultivateResetView:_refreshCurBuff()
	self._petMo = BagModel.instance:getPet(self._petId)
	self._kamuiInfos = self._petMo:getKamuiInfos()
	self._kamuiInfo = self._kamuiInfos[self._level]

	local id = self._kamuiInfo.kamuiId
	local kamuiCfg = DomainCultivateConfig.instance:getDefineCfg(id)

	uGuiUtil.setSpriteToImage(self._skillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(kamuiCfg.icon))

	self._txtName.text = kamuiCfg.name
	self._txtDesc.text = kamuiCfg.desc
end

function DomainCultivateResetView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local id = data.kamuiId
	local kamuiCfg = DomainCultivateConfig.instance:getDefineCfg(id)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(kamuiCfg.icon))

	txtDesc.text = kamuiCfg.desc
	txtName.text = kamuiCfg.name
end

function DomainCultivateResetView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function DomainCultivateResetView:_clearTableview(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function DomainCultivateResetView:_onClickReset()
	local consums = string.split(self._consume, "#")
	local matType, cfgId, num = MaterialMgr.getMatParams(consums[1])
	local name = MaterialMgr.getMaterialsName(matType, cfgId)
	local str = string.format("%d个%s", num, name)

	if #consums > 1 then
		local matType2, cfgId2, num2 = MaterialMgr.getMatParams(consums[2])
		local name2 = MaterialMgr.getMaterialsName(matType2, cfgId2)

		str = str .. "和" .. string.format("%d个%s", num2, name2)
	end

	local content = string.format("是否消耗%s，进行技能重置？", str)

	local function func()
		DomainCultivateController.instance:resetKamuiReq(self._petId, self._level)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), content, func)
end

function DomainCultivateResetView:_onClickClose()
	self:close()
end

return DomainCultivateResetView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomainCultivateResetSureView.lua

module("logic.extensions.domaincultivate.view.DomainCultivateResetSureView", package.seeall)

local DomainCultivateResetSureView = class("DomainCultivateResetSureView", ViewComponent)
local resetStr = "是否消耗%s，进行技能重置？"
local cancelStr = "是否放弃替换新的神威?"
local enoughStr = "%s数量不足"

function DomainCultivateResetSureView:ctor()
	DomainCultivateResetSureView.super.ctor(self)
end

function DomainCultivateResetSureView:unbindEvents()
	DomainCultivateResetSureView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function DomainCultivateResetSureView:bindEvents()
	DomainCultivateResetSureView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
end

function DomainCultivateResetSureView:buildUI()
	DomainCultivateResetSureView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._goldBar = self:getGo("goldBarCon")
	self._txtCost = {}
	self._txtCost[1] = self:getTxt("txtCost")
	self._txtCost[2] = self:getTxt("txtCost2")
	self._itemIcon = {}
	self._itemIcon[1] = self:getGo("txtCost/icon")
	self._itemIcon[2] = self:getGo("txtCost2/icon")
	self._item2 = self:getGo("txtCost2")
	self._newSkillIcon = self:getGo("newItem/skillIcon")
	self._newTxtName = self:getTxt("newItem/txtName")
	self._newTxtDesc = self:getTxt("newItem/txtDesc")
	self._nowSkillIcon = self:getGo("nowItem/skillIcon")
	self._nowTxtName = self:getTxt("nowItem/txtName")
	self._nowTxtDesc = self:getTxt("nowItem/txtDesc")
end

function DomainCultivateResetSureView:onExit()
	DomainCultivateResetSureView.super.onExit(self)

	for k, v in pairs(self._itemIcon) do
		Framework.ImageBigBG.Get(v):ClearImage()
	end

	uGuiUtil.clearImage(self._nowSkillIcon)
	uGuiUtil.clearImage(self._newSkillIcon)
end

function DomainCultivateResetSureView:onEnter()
	DomainCultivateResetSureView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petId = params[1]
	self._level = params[2]
	self._tempId = params[3]
	self._petMo = BagModel.instance:getPet(self._petId)
	self._kamuiInfos = self._petMo:getKamuiInfos()
	self._kamuiInfo = self._kamuiInfos[self._level]

	local petCfg = CharacterConfig.instance:getPetCo(self._petMo.raceId)
	local levelCfg = DomainCultivateConfig.instance:getLevelCfg2(petCfg.kamuiProgramId, self._level)

	self._consume = levelCfg.resetCost

	local consums = string.split(self._consume, "#")
	local objList = {}

	for k, v in ipairs(consums) do
		local matMo = string.splitToNumber(v, ":")

		table.insert(objList, {
			showAdd = true,
			id = MaterialMgr.createSerName(matMo[1], matMo[2])
		})
	end

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, objList)

	local cfgNow = DomainCultivateConfig.instance:getDefineCfg(self._kamuiInfo.kamuiId)

	if cfgNow then
		self._nowTxtName.text = cfgNow.name
		self._nowTxtDesc.text = cfgNow.desc

		uGuiUtil.setSpriteToImage(self._nowSkillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgNow.icon))
	end

	local cfgNew = DomainCultivateConfig.instance:getDefineCfg(self._tempId)

	if cfgNew then
		self._newTxtName.text = cfgNew.name
		self._newTxtDesc.text = cfgNew.desc

		uGuiUtil.setSpriteToImage(self._newSkillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgNew.icon))
	end

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

function DomainCultivateResetSureView:_onClickReset()
	local enough1, enough2 = true, true
	local strEnough = ""
	local consums = string.split(self._consume, "#")
	local matType, cfgId, num = MaterialMgr.getMatParams(consums[1])
	local name = MaterialMgr.getMaterialsName(matType, cfgId)
	local hasNum = MaterialModel.instance:getMaterialsNumber(matType, cfgId)

	if hasNum < num then
		enough1 = false
		strEnough = string.format(enoughStr, name)

		MaterialMgr.openGetSource(matType, cfgId)
	end

	local str = string.format("%d个%s", num, name)

	if #consums > 1 then
		local matType2, cfgId2, num2 = MaterialMgr.getMatParams(consums[2])
		local name2 = MaterialMgr.getMaterialsName(matType2, cfgId2)

		str = str .. "和" .. string.format("%d个%s", num2, name2)

		local hasNum2 = MaterialModel.instance:getMaterialsNumber(matType2, cfgId2)

		if hasNum2 < num2 then
			enough2 = false
			strEnough = string.format(enoughStr, name2)

			MaterialMgr.openGetSource(matType2, cfgId2)
		end
	end

	local content = string.format(resetStr, str)

	if enough1 and enough2 then
		local function func()
			DomainCultivateController.instance:resetKamuiReq(self._petId, self._level)
			self:_onClickClose()
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), content, func)
	else
		FloatWordMgr.instance:show(strEnough)
	end
end

function DomainCultivateResetSureView:_onClickCancel()
	local function func()
		DomainCultivateController.instance:confirmResetKamuiReq(self._petId, self._level, false)
		self:_onClickClose()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), cancelStr, func)
end

function DomainCultivateResetSureView:_onClickSure()
	DomainCultivateController.instance:confirmResetKamuiReq(self._petId, self._level, true)
	self:_onClickClose()
end

function DomainCultivateResetSureView:_onClickClose()
	self:close()
end

return DomainCultivateResetSureView

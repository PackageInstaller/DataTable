-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetmgrView.lua

module("logic.extensions.cutepet.view.CutepetmgrView", package.seeall)

local CutepetmgrView = class("CutepetmgrView", ViewComponent)
local colorRed = "DF5757FF"
local colorGreen = "4EAE1AFF"

function CutepetmgrView:ctor()
	CutepetmgrView.super.ctor(self)
end

function CutepetmgrView:unbindEvents()
	CutepetmgrView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function CutepetmgrView:bindEvents()
	CutepetmgrView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function CutepetmgrView:buildUI()
	CutepetmgrView.super.buildUI(self)

	self._txtNum = self:getTxt("root/txts/txtNum")
	self._txtPetAddNum = self:getTxt("root/txts/txtPetAddNum")
	self._txtPlayerLv = self:getTxt("root/txts/txtPlayerLv")
	self._txtItemNum = self:getTxt("root/txts/txtItemNum")
	self._itemCon = self:getGo("root/item")
	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._imgScore = goutil.findChildComponent(self.mainGO, "root/txts/scoreCol/imgScore", "UIImgNumeralText")
	self._txtTitle_2 = self:getTxt("root/bgs/txtTitle_2")
end

function CutepetmgrView:onExit()
	CutepetmgrView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LvlUpGardenResp, self._updateUI, self)
end

function CutepetmgrView:onEnter()
	CutepetmgrView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_LvlUpGardenResp, self._updateUI, self)
	self:_updateUI()
end

function CutepetmgrView:_onClickbtnClose()
	self:close()
end

function CutepetmgrView:_onClickbtnSure()
	if self._nextConfig == nil or checknumber(self._gardenLevel) <= 0 then
		return
	else
		local matType, matId, needNum = MaterialMgr.getMatParams(self._nextConfig.lvlUpMaterialCost)

		if RoleModel.instance:getMyLevel() < self._nextConfig.minPlayerLvl then
			FloatWordMgr.instance:show(lang("未达到指定训练师等级"))
		elseif not MaterialModel.instance:IsEnough(matType, matId, needNum) then
			FloatWordMgr.instance:show(lang("材料不足"))
			MaterialMgr.openGetSource(matType, matId)
		else
			CutePetGardenAgent.instance:sendPM_LvlUpGardenReq()
		end
	end
end

function CutepetmgrView:_updateUI()
	self._gardenLevel = CutePetModel.instance:getBuildingLevel(CutePetBuildingType.Management)

	if checknumber(self._gardenLevel) <= 0 then
		return
	end

	self._config = CutePetConfig.instance:getGardenCfg(self._gardenLevel)
	self._nextConfig = CutePetConfig.instance:getGardenCfg(self._gardenLevel + 1)

	self._imgScore:SetNum(self._config.lvl)

	self._txtNum.text = self._config.cutePetCapacity
	self._txtTitle_2.text = lang("升级条件")

	if self._nextConfig == nil then
		self._txtTitle_2.text = lang("满级效果")

		GameUtil.SetActive(self._btnSure, false)

		self._txtPetAddNum.text = lang("已满级")

		local num = 0
		local name = "萌宠园"
		local type = MatType.CutePet
		local petCount = ItemBagModel.instance:getMaxLvlSSRPetNum()

		num = checknumber(CutePetConfig.instance:getCommonValue("GardenMaxCapacityLimit"))

		local list = MaterialMgr.getModelList(type) or {}
		local total, addPercent = CutePetModel.instance:getLimitTotalNum(petCount, num)
		local petStartLine = CutePetModel.instance:getPetStartLine()
		local incrCapacityPetGap = CutePetModel.instance:getIncrCapacityPetGap()
		local gapAddPercent = CutePetModel.instance:getGapAddPercent()
		local maxCapacity = CutePetModel.instance:getMaxCapacity()
		local cur = langPara("%s/%s", #list, total)
		local str = "%s初始容量为<color=#C54949>%s</color>。\n当拥有<color=#C54949>%s只满级传说精灵</color>时，每超出<color=#C54949>%s</color>只增加<color=#C54949>%s%%</color>的容量上限，最多可以达到<color=#C54949>%s</color>。\n当前增加比例:<color=#C54949>%s%%</color>\n当前容量:<color=#C54949>%s</color>"

		self._txtPlayerLv.text = langPara(str, name, num, petStartLine, incrCapacityPetGap, gapAddPercent, maxCapacity, addPercent, cur)
		self._txtItemNum.text = ""

		MaterialMgr.resetAll(self._itemCon)
	else
		GameUtil.SetActive(self._btnSure, true)

		self._txtPetAddNum.text = langPara("宠物容量: <color=#%s>+%d</color>", colorGreen, self._nextConfig.cutePetCapacity - self._config.cutePetCapacity)
		self._txtPlayerLv.text = RoleModel.instance:getMyLevel() < self._nextConfig.minPlayerLvl and langPara("训练师等级：<color=#%s>%d/%d</color>", colorRed, RoleModel.instance:getMyLevel(), self._nextConfig.minPlayerLvl) or langPara("训练师等级：<color=#%s>%d/%d</color>", colorGreen, RoleModel.instance:getMyLevel(), self._nextConfig.minPlayerLvl)

		local matType, matId, needNum = MaterialMgr.getMatParams(self._nextConfig.lvlUpMaterialCost)
		local proxy = MaterialMgr.setCellByCfg(self._nextConfig.lvlUpMaterialCost, self._itemCon)

		if proxy then
			proxy.binder:setNum(0)
		end

		self._txtItemNum.text = needNum > MaterialModel.instance:getMaterialsNumber(matType, matId) and langPara("<color=#%s>%d/%d</color>", colorRed, MaterialModel.instance:getMaterialsNumber(matType, matId), needNum) or langPara("<color=#%s>%d/%d</color>", colorGreen, MaterialModel.instance:getMaterialsNumber(matType, matId), needNum)
	end
end

return CutepetmgrView

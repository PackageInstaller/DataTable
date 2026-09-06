-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusequiptipView.lua

module("logic.extensions.stargodplus.view.StargodplusequiptipView", package.seeall)

local StargodplusequiptipView = class("StargodplusequiptipView", ViewComponent)

function StargodplusequiptipView:ctor()
	StargodplusequiptipView.super.ctor(self)
end

function StargodplusequiptipView:buildUI()
	StargodplusequiptipView.super.buildUI(self)

	self._replaceBtnGo = self:getGo("root/btnCon/replaceBtn")
	self._replaceBtn = self:getBtn("root/btnCon/replaceBtn")
	self._strengthBtn = self:getBtn("root/btnCon/strengthBtn")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "root/nameText")
	self._lvText = goutil.findChildTextComponent(self.mainGO, "root/textInfo/lvText")
	self._jobText = goutil.findChildTextComponent(self.mainGO, "root/textInfo/jobText")
	self._changeGroup = self:getGo("root/bg"):GetComponent(ComponentType.UIChangeGroup)
	self._cellGo = self:getGo("root/attrCon/cell")
	self._attrConGo = self:getGo("root/attrCon")
	self._attrGroup = ItemGroup.New(self._attrConGo, self._cellGo, nil, nil, true)
	self._itemconGo = self:getGo("root/itemcon")
	self._powerText = goutil.findChildTextComponent(self.mainGO, "root/power/text")
	self._strengthBtnDotGo = self:getGo("root/btnCon/strengthBtn/dot")
end

function StargodplusequiptipView:bindEvents()
	StargodplusequiptipView.super.bindEvents(self)
	self._replaceBtn:AddClickListener(self._onClickreplaceBtn, self)
	self._strengthBtn:AddClickListener(self._onClickstrengthBtn, self)
end

function StargodplusequiptipView:unbindEvents()
	StargodplusequiptipView.super.unbindEvents(self)
	self._replaceBtn:RemoveClickListener()
	self._strengthBtn:RemoveClickListener()
end

function StargodplusequiptipView:destroyUI()
	StargodplusequiptipView.super.destroyUI(self)
end

function StargodplusequiptipView:onEnter()
	StargodplusequiptipView.super.onEnter(self)
	self:_initSlotData()
	self:_updateView()
	self:_checkBtnShowState()
end

function StargodplusequiptipView:onEnterFinished()
	StargodplusequiptipView.super.onEnterFinished(self)
end

function StargodplusequiptipView:onExit()
	StargodplusequiptipView.super.onExit(self)
	MaterialMgr.resetAll(self._itemconGo)
end

function StargodplusequiptipView:onExitFinished()
	StargodplusequiptipView.super.onExitFinished(self)
end

function StargodplusequiptipView:_onClickreplaceBtn()
	UIStateManager.instance:push(ViewName.StargodplusbagView, self._slotData.slot, self._slotData)
	self:close()
end

function StargodplusequiptipView:_onClickstrengthBtn()
	local petId = StargodplusModel.instance:getCurrShowPetId()
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo and petMo:isBorrowPet() == true then
		FloatWordMgr.instance:show(lang("当前强化已上限"))
		self:close()

		return
	else
		UIStateManager.instance:push(ViewName.StargodplusstrengthView, self._slotData.slot)
		self:close()
	end
end

function StargodplusequiptipView:_initSlotData()
	self._slotData = self:getFirstParam()
	self._ismyData = not self._slotData.notFromBag
end

function StargodplusequiptipView:_checkBtnShowState()
	goutil.setActive(self._replaceBtn.gameObject, self._ismyData)
	goutil.setActive(self._strengthBtn.gameObject, self._ismyData)
end

function StargodplusequiptipView:_updateView()
	self._slotLv = StargodplusModel.instance:getSlotLv(self._slotData.slot, self._slotData.exp)

	local isMax = StargodplusModel.instance:isSlotMaxLv(self._slotData.slot, self._slotData.exp)
	local cfg = StargodplusConfig.instance:getFillerCfg(self._slotData.fillerDefineId)

	self._lvText.text = "Lv." .. self._slotLv
	self._nameText.text = cfg.name

	if not string.nilorempty(cfg.equipPetChecker) then
		local jobLimitStr = ""
		local procStr = string.gsub(cfg.equipPetChecker, "[%(%)]", "")

		procStr = string.gsub(procStr, "[%&%|%!]", "#")

		local expStrs = string.split(procStr, "#")

		for i, v in ipairs(expStrs) do
			local express = string.split(v, "$")
			local pre = express[1]
			local tail = express[2]

			if pre == "Job" then
				jobLimitStr = string.nilorempty(jobLimitStr) and tail or string.format("%s、%s", jobLimitStr, tail)
			end
		end

		if not string.nilorempty(jobLimitStr) then
			self._jobText.text = langPara("限制：%s", jobLimitStr)

			GameUtil.SetActive(self._jobText, true)
		else
			GameUtil.SetActive(self._jobText, false)
		end
	else
		GameUtil.SetActive(self._jobText, false)
	end

	self._changeGroup:SetState(cfg.quality)
	goutil.setActive(self._strengthBtn.gameObject, not isMax)
	goutil.setActive(self._strengthBtnDotGo, StargodplusModel.instance:checkSlotCanUpgrade(self._slotData.slot, self._slotData.exp))

	if checknumber(self._slotData.fillerId) <= 0 then
		local proxy = MaterialMgr.setCell(MatType.StarGodPlus, self._slotData.fillerDefineId, self._itemconGo)

		if proxy then
			local raceId = checknumber(self._slotData.raceId)

			proxy.binder:setAutoTips(false)
			proxy.binder:setRaceHead(raceId)
		end
	else
		local proxy = MaterialMgr.setCellByGId(MatType.StarGodPlus, self._slotData.fillerId, self._itemconGo)

		if proxy then
			proxy.binder:setAutoTips(false)
		end
	end

	self:_updateAttr()
end

function StargodplusequiptipView:_updateAttr()
	local list = StargodplusModel.instance:getAttrList(self._slotData.fillerDefineId, self._slotLv)

	self._attrGroup:updateWithMoArray(list, function(item, data)
		local change = goutil.findChild(item.mainGO, "attricon"):GetComponent(ComponentType.UIImageSpriteChange)
		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local numText = goutil.findChildTextComponent(item.mainGO, "numText")
		local name, value = GameUtil.getPropertyInfo(data.id, data.value)

		change:SetState(data.id - 1)

		numText.text = value
		nameText.text = name .. (data.id == GameEnum.AttrType.OriginalVigour and "增加" or "")
	end)

	local tempList = {}

	for i, v in ipairs(list or {}) do
		tempList[v.id] = v.value
	end

	self._powerText.text = AttrMo.calcFightPowerByAttrs(tempList)
end

return StargodplusequiptipView

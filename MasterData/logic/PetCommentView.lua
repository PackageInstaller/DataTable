-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetCommentView.lua

module("logic.extensions.equipment.view.PetCommentView", package.seeall)

local PetCommentView = class("PetCommentView", TableViewComponent)

function PetCommentView:ctor()
	PetCommentView.super.ctor(self)

	self.isZX = true
	self.petCfg = nil
	self.jubaoIndex = 0
	self.jubaoId = ""
	self.clickTimer = 0
	self.coolTimer = 300
end

function PetCommentView:buildUI()
	PetCommentView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewBg/viewCloseBtn")

	local viewBgGo = self:getGo("viewBg")

	self.petGridIma = goutil.findChildComponent(viewBgGo, "petGridIma", "UIImageSpriteChange")
	self.petHeadImaGo = goutil.findChild(viewBgGo, "petGridIma/petHeadIma")
	self.petStageIma = goutil.findChildComponent(viewBgGo, "petGridIma/petStageIma", "UIImageSpriteChange")
	self.petLevelGo = goutil.findChild(viewBgGo, "petGridIma/petLevelGo")
	self.petLevelTxt = goutil.findChildTextComponent(self.petLevelGo, "petLevelTxt")
	self.petNameTxt = goutil.findChildTextComponent(viewBgGo, "petNameTxt")
	self.petDesTxt = goutil.findChildTextComponent(viewBgGo, "petDesTxt")
	self.zuixinBtn = self:getBtn("viewBg/zuixinBtn")
	self.zuixinGo = goutil.findChild(viewBgGo, "zuixinBtn/zuixinGo")
	self.reduBtn = self:getBtn("viewBg/reduBtn")
	self.reduGo = goutil.findChild(viewBgGo, "reduBtn/reduGo")
	self.pinglunIpt = goutil.findChild(viewBgGo, "pinglunIpt"):GetComponent("InputField")
	self.placeholderTxt = goutil.findChildTextComponent(viewBgGo, "pinglunIpt/Placeholder")
	self.pinglunBtn = self:getBtn("viewBg/pinglunBtn")
	self.noPinglunTxt = goutil.findChildTextComponent(viewBgGo, "noPinglunTxt")
	self.noPinglunTxt.text = ""

	self.zuixinGo:SetActive(false)
	self.reduGo:SetActive(false)

	self.jubaoBgGo = self:getGo("jubaoBgGo")
	self.jubaoCloseBtn = self:getBtn("jubaoBgGo/jubaoBg/jubaoCloseBtn")
	self.liyouTogg_1 = goutil.findChild(self.jubaoBgGo, "jubaoBg/liyouTogg_1"):GetComponent("Toggle")
	self.liyouTxt_1 = goutil.findChildTextComponent(self.jubaoBgGo, "jubaoBg/liyouTogg_1/liyouTxt")
	self.liyouTogg_2 = goutil.findChild(self.jubaoBgGo, "jubaoBg/liyouTogg_2"):GetComponent("Toggle")
	self.liyouTxt_2 = goutil.findChildTextComponent(self.jubaoBgGo, "jubaoBg/liyouTogg_2/liyouTxt")
	self.liyouTogg_3 = goutil.findChild(self.jubaoBgGo, "jubaoBg/liyouTogg_3"):GetComponent("Toggle")
	self.liyouTxt_3 = goutil.findChildTextComponent(self.jubaoBgGo, "jubaoBg/liyouTogg_3/liyouTxt")
	self.liyouIpt = goutil.findChild(self.jubaoBgGo, "jubaoBg/liyouIpt"):GetComponent("InputField")
	self.quxiaoBtn = self:getBtn("jubaoBgGo/jubaoBg/quxiaoBtn")
	self.quedingBtn = self:getBtn("jubaoBgGo/jubaoBg/quedingBtn")

	self.jubaoBgGo:SetActive(false)
end

function PetCommentView:bindEvents()
	PetCommentView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.pinglunBtn:AddClickListener(self.OnClickPinglunBtn, self)
	self.zuixinBtn:AddClickListener(function()
		self:ChoiseZuixinOrRedu(true)
	end, self)
	self.reduBtn:AddClickListener(self.ChoiseZuixinOrRedu, self)

	self.pinglunHandler = InputFieldValueChangedHandler.Get(self.pinglunIpt.gameObject):AddLuaHandler(function(_, txt)
		self:OnInputValueChange(txt)
	end)

	self.jubaoCloseBtn:AddClickListener(self.OpenJubaoView, self)

	self.liyouHandler1 = ToggleValueChangedHandler.Get(self.liyouTogg_1.gameObject):AddLuaHandler(function(_, isOn)
		if isOn then
			self:OnClickLiyouToggle(1)
		end
	end)
	self.liyouHandler2 = ToggleValueChangedHandler.Get(self.liyouTogg_2.gameObject):AddLuaHandler(function(_, isOn)
		if isOn then
			self:OnClickLiyouToggle(2)
		end
	end)
	self.liyouHandler3 = ToggleValueChangedHandler.Get(self.liyouTogg_3.gameObject):AddLuaHandler(function(_, isOn)
		if isOn then
			self:OnClickLiyouToggle(3)
		end
	end)

	self.quxiaoBtn:AddClickListener(self.OpenJubaoView, self)
	self.quedingBtn:AddClickListener(function()
		local content = self.liyouIpt.text

		if self.jubaoIndex == 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_20"))

			return
		end

		if not string.nilorempty(content) then
			local list = StringUtil.utf8split(content)

			if list then
				if not #list then
					local len = 0

					if len > self.baseCfg.jbTextCount then
						FloatWordMgr.instance:show(langPara("text_equip_desc_21", self.baseCfg.jbTextCount))

						return
					end
				end
			end
		end

		if string.nilorempty(self.jubaoId) then
			error("sr_精灵评论 PetCommentView:bindEvents()   举报评论id为空！")

			return
		end

		if not self:ClickCoolingTime() then
			return
		end

		self:OpenJubaoView()
		PetEquipController.instance:CSJubaoRoleComment(self.petCfg.raceId, self.jubaoId, self.jubaoIndex, content)
	end, self)
end

function PetCommentView:unbindEvents()
	PetCommentView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.pinglunBtn:RemoveClickListener()
	self.zuixinBtn:RemoveClickListener()
	self.reduBtn:RemoveClickListener()
	InputFieldValueChangedHandler.Get(self.pinglunIpt.gameObject):RemoveLuaHandler(self.pinglunHandler)
	self.jubaoCloseBtn:RemoveClickListener()
	ToggleValueChangedHandler.Get(self.liyouTogg_1.gameObject):RemoveLuaHandler(self.liyouHandler1)
	ToggleValueChangedHandler.Get(self.liyouTogg_2.gameObject):RemoveLuaHandler(self.liyouHandler2)
	ToggleValueChangedHandler.Get(self.liyouTogg_3.gameObject):RemoveLuaHandler(self.liyouHandler3)
end

function PetCommentView:onExit()
	self.isZX = true
	self._curViewDatas = nil
	self.jubaoId = ""

	MaterialMgr.clearIcon(self.petHeadImaGo)
	GlobalDispatcher:removeListener("UpdatePetPinglunInfo", self.UpdatePinglunList, self)
end

function PetCommentView:destroyUI()
	PetCommentView.super.destroyUI(self)

	self.petCfg = nil
end

function PetCommentView:onEnter()
	PetCommentView.super.onEnter(self)

	self.isZX = true

	local petId = 90019

	if self._viewPresentor._openParam == nil or self._viewPresentor._openParam[1] == nil then
		error("sr_精灵评论  PetCommentView:onEnter()    传入的参数为空！ ")
		self:close()

		return
	else
		petId = checknumber(self._viewPresentor._openParam[1])
	end

	self.petCfg = MaterialMgr.getMatCfg(MatType.Pet, petId)

	local petInfoCfg = CharacterConfig.instance:getPetInfoCo(petId)

	if self.petCfg == nil or petInfoCfg == nil then
		error("sr_精灵评论  PetCommentView:onEnter()    获取的精灵配置为空 = " .. petId)
		self:close()

		return
	end

	self.baseCfg = PetCommentConfig.instance:GetPetCommentBase()

	local ownInfo = RoleModel.instance:GetRole()

	if ownInfo then
		self.ownId = ownInfo.userId or 0
	end

	GlobalDispatcher:addListener("UpdatePetPinglunInfo", self.UpdatePinglunList, self)
	MaterialMgr.setIcon(self.petHeadImaGo, MatType.Pet, self.petCfg.raceId)

	local nowLevel = BagModel.instance:getPetMaxLv(self.petCfg.raceId)

	if nowLevel <= 0 then
		self.petLevelTxt.text = ""

		self.petLevelGo:SetActive(false)
	else
		self.petLevelGo:SetActive(true)

		self.petLevelTxt.text = tostring(nowLevel)
	end

	local xiyoudu = CharacterConfig.instance:getInitRare(self.petCfg.raceId)

	self.petGridIma:SetState(xiyoudu - 1)
	self.petStageIma:SetState(xiyoudu - 1)

	self.petNameTxt.text = self.petCfg.name
	self.petDesTxt.text = string.gsub(petInfoCfg.stragegy, "\n", ", ")

	self:ChoiseZuixinOrRedu(self.isZX)

	self.pinglunIpt.text = ""
	self.pinglunIpt.characterLimit = self.baseCfg.plTextCount
	self.placeholderTxt.text = string.format(self.baseCfg.plDes, self.baseCfg.plLevel, self.baseCfg.plTextCount)

	PetEquipController.instance:CSGetPetCommentInfo(petId)
end

function PetCommentView:ChoiseZuixinOrRedu(isZX)
	self.isZX = isZX

	if self.isZX then
		self.zuixinGo:SetActive(true)
		self.reduGo:SetActive(false)
	else
		self.zuixinGo:SetActive(false)
		self.reduGo:SetActive(true)
	end

	self:UpdatePinglunList()
end

function PetCommentView:UpdatePinglunList()
	self.pinglunData = PetEquipModel.instance:GetPinglunInfoList(self.petCfg.raceId)
	self._curViewDatas = {}

	if self.pinglunData then
		if self.isZX then
			self._curViewDatas = self.pinglunData.zxList or self.pinglunData.zrList
		end
	end

	self._tableview:ReloadData()

	self.noPinglunTxt.text = self._curViewDatas and #self._curViewDatas > 0 and "" or lang("text_equip_desc_22")
end

function PetCommentView:OnClickPinglunBtn()
	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		FloatWordMgr.instance:show("本功能正在进行技术维护，具体开放时间请留意公告！")

		return
	end

	if self.pinglunData and self.pinglunData.isPL then
		self.placeholderTxt.text = string.format(self.baseCfg.plDes, self.baseCfg.plLevel, self.baseCfg.plTextCount)

		FloatWordMgr.instance:show(lang("text_equip_desc_23"))

		return
	end

	local nowLevel = BagModel.instance:getPetMaxLv(self.petCfg.raceId)

	if nowLevel < self.baseCfg.plLevel then
		self.placeholderTxt.text = string.format(self.baseCfg.plDes, self.baseCfg.plLevel, self.baseCfg.plTextCount)

		FloatWordMgr.instance:show(langPara("text_equip_desc_24", self.baseCfg.plLevel))

		return
	end

	local content = self.pinglunIpt.text
	local list = StringUtil.utf8split(content)

	if list then
		if not #list then
			local len = 0

			if len > self.baseCfg.plTextCount then
				FloatWordMgr.instance:show(langPara("text_equip_desc_25", self.baseCfg.plTextCount))

				return
			end

			if string.nilorempty(content) then
				FloatWordMgr.instance:show(lang("text_equip_desc_26"))

				return
			end

			PetEquipController.instance:CSPinglunPetContent(self.petCfg.raceId, content)

			self.pinglunIpt.text = ""
			self.placeholderTxt.text = string.format(self.baseCfg.plDes, self.baseCfg.plLevel, self.baseCfg.plTextCount)
		end
	end
end

function PetCommentView:OnInputValueChange(txt)
	local newText = string.gsub(txt, "\n", "")

	if newText ~= txt then
		self.pinglunIpt.text = newText
	end
end

function PetCommentView:_getPath()
	return {
		cellPath = "viewBg/cellItem",
		viewPath = "viewBg/cellItemSR"
	}
end

function PetCommentView:_cellSize()
	return 1110, 100
end

function PetCommentView:_updateCell(view, cell, data)
	local hotImaGo = goutil.findChild(cell, "hotImaGo")
	local roleNameTxt = goutil.findChildTextComponent(cell, "roleNameTxt")
	local roleDesTxt = goutil.findChildTextComponent(cell, "roleDesTxt")
	local dianzanBtnGo = goutil.findChild(cell, "dianzanBtn")
	local dianzanIma = dianzanBtnGo:GetComponent("UIImageSpriteChange")
	local iconIma = goutil.findChildComponent(dianzanBtnGo, "iconIma", "UIImageSpriteChange")
	local dianzanTxt = goutil.findChildTextComponent(cell, "dianzanBtn/dianzanTxt")

	if not self.isZX and cell.data <= 3 then
		hotImaGo:SetActive(true)
	else
		hotImaGo:SetActive(false)
	end

	dianzanIma:SetState(data.isDZ and 0 or 1)
	iconIma:SetState(data.isDZ and 0 or 1)

	roleNameTxt.text = self.ownId == data.userId and "<color=#01C32BFF>" .. data.roleName .. "</color>" or "<color=#466887FF>" .. data.roleName .. "</color>"
	roleDesTxt.text = data.petDes
	dianzanTxt.text = tostring(data.dzCount)

	GameUtil.asBtn(dianzanBtnGo):AddClickListener(function()
		if data.isDZ then
			FloatWordMgr.instance:show(lang("text_equip_desc_27"))

			return
		end

		PetEquipController.instance:CSGiveRoleDianzan(self.petCfg.raceId, data.plId)
	end, self)
end

function PetCommentView:ClickCoolingTime()
	if self.clickTimer == 0 then
		self.clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self.clickTimer < self.coolTimer then
			FloatWordMgr.instance:show(lang("text_equip_desc_28"))

			return
		end

		self.clickTimer = now
	end

	return true
end

function PetCommentView:OpenJubaoView(isOpen, plId)
	self.jubaoId = ""

	self.jubaoBgGo:SetActive(isOpen)

	self.liyouTogg_1.isOn = false
	self.liyouTogg_2.isOn = false
	self.liyouTogg_3.isOn = false

	if isOpen then
		self.liyouTxt_1.text = "1"
		self.liyouTxt_2.text = "2"
		self.liyouTxt_3.text = "3"
		self.jubaoId = plId
	else
		self.liyouTxt_1.text = ""
		self.liyouTxt_2.text = ""
		self.liyouTxt_3.text = ""
	end

	self.liyouIpt.text = ""
end

function PetCommentView:OnClickLiyouToggle(index)
	self.jubaoIndex = self.jubaoIndex == index and 0 or index

	if self.jubaoIndex == 0 then
		self.liyouTogg_1.isOn = false
		self.liyouTogg_2.isOn = false
		self.liyouTogg_3.isOn = false
	elseif self.jubaoIndex == 1 then
		self.liyouTogg_2.isOn = false
		self.liyouTogg_3.isOn = false
	elseif self.jubaoIndex == 2 then
		self.liyouTogg_1.isOn = false
		self.liyouTogg_3.isOn = false
	else
		self.liyouTogg_1.isOn = false
		self.liyouTogg_2.isOn = false
	end
end

return PetCommentView

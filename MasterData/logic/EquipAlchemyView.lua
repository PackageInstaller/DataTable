-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipAlchemyView.lua

module("logic.extensions.equipment.view.EquipAlchemyView", package.seeall)

local EquipAlchemyView = class("EquipAlchemyView", ViewComponent)

function EquipAlchemyView:ctor()
	EquipAlchemyView.super.ctor(self)

	self._itemBtsList = nil
end

function EquipAlchemyView:bindEvents()
	EquipAlchemyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "equipalchemy")
	end, self)

	for i = 1, #self._itemBtsList do
		if self._itemBtsList[i] and self._itemBtsList[i].itemBtn then
			self._itemBtsList[i].itemBtn:AddClickListener(function()
				self:_onClickItemBtn(i)
			end, self)
		end
	end
end

function EquipAlchemyView:unbindEvents()
	EquipAlchemyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()

	for _, item in pairs(self._itemBtsList or {}) do
		if item and item.itemBtn then
			item.itemBtn:RemoveClickListener()
		end
	end
end

function EquipAlchemyView:onExit()
	EquipAlchemyView.super.onExit(self)
end

function EquipAlchemyView:destroyUI()
	EquipAlchemyView.super.destroyUI(self)

	self._itemBtsList = nil
end

function EquipAlchemyView:buildUI()
	EquipAlchemyView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._itemBtsList = {}

	local var_8_0 = {
		itemBtn = self:getBtn("itemBtn_1")
	}

	var_8_0.iconChg = self:getGo("itemBtn_1/iconGo"):GetComponent("UIImageSpriteChange")
	var_8_0.nameTxt = self:getTxt("itemBtn_1/nameTxt")
	var_8_0.descTxt = self:getTxt("itemBtn_1/descTxt")
	var_8_0.lockGo = self:getGo("itemBtn_1/lockGo")
	var_8_0.lockTxt = self:getTxt("itemBtn_1/lockGo/lockTxt")
	var_8_0.redpointGo = self:getGo("itemBtn_1/redpointGo")
	self._itemBtsList[1] = var_8_0

	local var_8_1 = {
		itemBtn = self:getBtn("itemBtn_2")
	}

	var_8_1.iconChg = self:getGo("itemBtn_2/iconGo"):GetComponent("UIImageSpriteChange")
	var_8_1.nameTxt = self:getTxt("itemBtn_2/nameTxt")
	var_8_1.descTxt = self:getTxt("itemBtn_2/descTxt")
	var_8_1.lockGo = self:getGo("itemBtn_2/lockGo")
	var_8_1.lockTxt = self:getTxt("itemBtn_2/lockGo/lockTxt")
	var_8_1.redpointGo = self:getGo("itemBtn_2/redpointGo")
	self._itemBtsList[2] = var_8_1

	local var_8_2 = {
		itemBtn = self:getBtn("itemBtn_3")
	}

	var_8_2.iconChg = self:getGo("itemBtn_3/iconGo"):GetComponent("UIImageSpriteChange")
	var_8_2.nameTxt = self:getTxt("itemBtn_3/nameTxt")
	var_8_2.descTxt = self:getTxt("itemBtn_3/descTxt")
	var_8_2.lockGo = self:getGo("itemBtn_3/lockGo")
	var_8_2.lockTxt = self:getTxt("itemBtn_3/lockGo/lockTxt")
	var_8_2.redpointGo = self:getGo("itemBtn_3/redpointGo")
	self._itemBtsList[3] = var_8_2

	local var_8_3 = {
		itemBtn = self:getBtn("itemBtn_4")
	}

	var_8_3.iconChg = self:getGo("itemBtn_4/iconGo"):GetComponent("UIImageSpriteChange")
	var_8_3.nameTxt = self:getTxt("itemBtn_4/nameTxt")
	var_8_3.descTxt = self:getTxt("itemBtn_4/descTxt")
	var_8_3.lockGo = self:getGo("itemBtn_4/lockGo")
	var_8_3.lockTxt = self:getTxt("itemBtn_4/lockGo/lockTxt")
	var_8_3.redpointGo = self:getGo("itemBtn_4/redpointGo")
	self._itemBtsList[4] = var_8_3
	self._timeTxt = goutil.findChildTextComponent(self.mainGO, "timeTxt")
	self._timeTxt.text = ""
end

function EquipAlchemyView:onEnter()
	EquipAlchemyView.super.onEnter(self)

	self._nowLevel = RoleModel.instance:getMyLevel()

	self:_initAllItemBtnsShow()
end

function EquipAlchemyView:_initAllItemBtnsShow()
	if self._itemBtsList == nil or #self._itemBtsList == 0 then
		return
	end

	local cfg

	for i = 1, #self._itemBtsList do
		cfg = EquipmentConfig.instance:GetComposeDdefineCfgs(i)

		self._itemBtsList[i].iconChg:ChangeSprite(cfg.icon)

		self._itemBtsList[i].nameTxt.text = cfg.mainName
		self._itemBtsList[i].descTxt.text = cfg.tabDes

		local level = PetEquipModel.instance:getAlchemyUnlockLevel(cfg.planId)

		if level > self._nowLevel then
			GameUtil.SetActive(self._itemBtsList[i].lockGo, true)
			GameUtil.SetActive(self._itemBtsList[i].redpointGo, false)

			self._itemBtsList[i].lockTxt.text = langPara("text_equip_desc_2", level)
		else
			self._itemBtsList[i].lockTxt.text = ""

			GameUtil.SetActive(self._itemBtsList[i].redpointGo, not GameUtil.getUserData("dataEquipAlchemyView" .. cfg.tabId))
			GameUtil.SetActive(self._itemBtsList[i].lockGo, false)
		end

		local pos = string.split(cfg.itemPos, ",")

		Framework.TransformUtil.SetLocalPos(self._itemBtsList[i].itemBtn.gameObject.transform, checknumber(pos[1]), checknumber(pos[2]), 0)
	end
end

function EquipAlchemyView:_onClickItemBtn(tabId)
	local cfg = EquipmentConfig.instance:GetComposeDdefineCfgs(tabId)

	if cfg == nil then
		return
	end

	local level = PetEquipModel.instance:getAlchemyUnlockLevel(cfg.planId)

	if level > self._nowLevel then
		FloatWordMgr.instance:show(langPara("text_equip_desc_2", level))

		return
	end

	if tabId == 4 then
		UIStateManager.instance:push(ViewName.EquipFunction)
	else
		UIStateManager.instance:push(ViewName.EquipFactory, tabId)

		if not GameUtil.getUserData("dataEquipAlchemyView" .. tabId) then
			GameUtil.saveUserData("dataEquipAlchemyView" .. tabId, true)
		end
	end
end

return EquipAlchemyView

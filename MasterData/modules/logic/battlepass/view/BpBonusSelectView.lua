-- chunkname: @modules/logic/battlepass/view/BpBonusSelectView.lua

module("modules.logic.battlepass.view.BpBonusSelectView", package.seeall)

local BpBonusSelectView = class("BpBonusSelectView", BaseView)
local BonusStatu = {
	Finish = 3,
	CanGet = 2,
	Lock = 1
}

function BpBonusSelectView:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "txt_titledec")
	self._btnGet = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_get")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._finish = gohelper.findChild(self.viewGO, "#go_finish")
	self._txtgetname = gohelper.findChildTextMesh(self.viewGO, "#go_finish/#txt_getname")
	self._items = {}

	for i = 1, 4 do
		local itemGo = gohelper.findChild(self.viewGO, "item" .. i)

		self._items[i] = self:getUserDataTb_()
		self._items[i].select = gohelper.findChild(itemGo, "#go_select")
		self._items[i].btnClick = gohelper.findChildButtonWithAudio(itemGo, "#btn_click")
		self._items[i].btnDetail = gohelper.findChildButtonWithAudio(itemGo, "#btn_detail")
		self._items[i].imageSign = gohelper.findChildSingleImage(itemGo, "#simage_sign")
		self._items[i].mask = gohelper.findChild(itemGo, "#go_mask")
		self._items[i].owned = gohelper.findChild(itemGo, "#go_owned")
		self._items[i].get = gohelper.findChild(itemGo, "#go_get")
		self._items[i].getAnim = self._items[i].get:GetComponent(typeof(UnityEngine.Animator))

		if i == 4 then
			self._items[i].txtname = gohelper.findChildTextMesh(itemGo, "#txt_name")
		else
			self._items[i].txtskinname = gohelper.findChildTextMesh(itemGo, "#txt_skinname")
			self._items[i].txtname = gohelper.findChildTextMesh(itemGo, "#txt_skinname/#txt_name")
		end

		self.addClickCb(self, self._items[i].btnClick, self._onGetClick, self, i)
		self.addClickCb(self, self._items[i].btnDetail, self._onDetailClick, self, i)
	end

	self.addClickCb(self, self._btnGet, self._getBonus, self)
	self.addClickCb(self, self._btnClose, self.closeThis, self)
end

function BpBonusSelectView:onClickModalMask()
	self:closeThis()
end

function BpBonusSelectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_mln_unlock)

	local bpBonusCoList = BpConfig.instance:getBonusCOList(BpModel.instance.id)
	local selectBonusCo

	for _, co in ipairs(bpBonusCoList) do
		if not string.nilorempty(co.selfSelectPayBonus) then
			selectBonusCo = co

			break
		end
	end

	if not selectBonusCo then
		logError("没有皮肤可选！！！")

		return
	end

	self._itemInfo = GameUtil.splitString2(selectBonusCo.selfSelectPayBonus, true)
	self._level = selectBonusCo.level

	local bpLv = BpModel.instance:getBpLv()

	self._getIndex = BpBonusModel.instance:isGetSelectBonus(self._level)

	if BpModel.instance.firstShowSp or bpLv < self._level then
		self._statu = BonusStatu.Lock

		self:setFinish(0)
	elseif self._getIndex then
		self._statu = BonusStatu.Finish

		self:setFinish(self._getIndex)
	else
		self._statu = BonusStatu.CanGet

		self:setFinish(0)
	end

	self:setSelect(0)
	gohelper.setActive(self._btnGet, self._statu == BonusStatu.CanGet)
	gohelper.setActive(self._golock, self._statu == BonusStatu.Lock)
	gohelper.setActive(self._finish, self._statu == BonusStatu.Finish)
	gohelper.setActive(self._goselect, self._statu ~= BonusStatu.Finish)
	ZProj.UGUIHelper.SetGrayFactor(self._btnGet.gameObject, 1)

	for i = 1, 4 do
		local haveItem = ItemModel.instance:getItemQuantity(self._itemInfo[i][1], self._itemInfo[i][2]) > 0

		gohelper.setActive(self._items[i].owned, haveItem)

		if self._statu == BonusStatu.Finish then
			gohelper.setActive(self._items[i].mask, self._getIndex ~= i)

			if self._getIndex == i then
				gohelper.setActive(self._items[i].owned, false)
			end
		else
			gohelper.setActive(self._items[i].mask, haveItem)
		end

		local itemCo = ItemConfig.instance:getItemConfig(self._itemInfo[i][1], self._itemInfo[i][2])
		local getName = ""

		if i == 4 then
			self._items[i].txtname.text = itemCo.name
			getName = itemCo.name
		else
			self._items[i].txtskinname.text = itemCo.des

			local heroConfig = HeroConfig.instance:getHeroCO(itemCo.characterId)

			self._items[i].txtname.text = heroConfig.name
			getName = string.format("%s——%s", heroConfig.name, itemCo.des)
		end

		if self._getIndex == i then
			self._txtgetname.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_get_bound"), getName)
		end
	end
end

function BpBonusSelectView:setSelect(index)
	for i = 1, 4 do
		gohelper.setActive(self._items[i].select, index == i)
	end
end

function BpBonusSelectView:setFinish(index)
	for i = 1, 4 do
		gohelper.setActive(self._items[i].get, index == i)

		if index == i then
			self._items[i].getAnim:Play("in")
		end
	end
end

function BpBonusSelectView:_onGetClick(i)
	if self._statu == BonusStatu.CanGet then
		if self._items[i].mask.activeSelf then
			return
		end

		ZProj.UGUIHelper.SetGrayFactor(self._btnGet.gameObject, 0)

		self._nowSelect = i

		self:setSelect(i)
	else
		self:_onDetailClick(i)
	end
end

function BpBonusSelectView:_getBonus()
	if not self._nowSelect then
		return
	end

	BpRpc.instance:sendGetSelfSelectBonusRequest(self._level or 0, self._nowSelect - 1)
	self:closeThis()
end

function BpBonusSelectView:_onDetailClick(i)
	if not self._itemInfo[i] then
		return
	end

	MaterialTipController.instance:showMaterialInfo(self._itemInfo[i][1], self._itemInfo[i][2], false, nil, false)
end

return BpBonusSelectView

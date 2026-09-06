-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItemstackView.lua

module("logic.extensions.itembag.stack.ItemstackView", package.seeall)

local ItemstackView = class("ItemstackView", ViewComponent)

function ItemstackView:ctor()
	ItemstackView.super.ctor(self)
end

function ItemstackView:buildUI()
	ItemstackView.super.buildUI(self)

	self.layoutGroup = self:getGo("info/btnsGrid"):GetComponent("GridLayoutGroup")
	self.layoutGroup.enabled = false
	self._sellButton = self:getBtn("info/btnsGrid/BtnSell")
	self._useButton = self:getBtn("info/btnsGrid/BtnUse")
	self._mergeButton = self:getBtn("info/btnsGrid/BtnMerge")
	self._btnEvolve = self:getBtn("info/btnsGrid/BtnEvolve")
	self._btnQuickUse = self:getBtn("info/btnsGrid/BtnQuickUse")
	self._sourceBtn = self:getBtn("info/btnSource")
	self.txtUse = self:getTxt("info/btnsGrid/BtnUse/Txt")
	self._nameTxt = self:getTxt("info/txtName")
	self.group = self:getGo("info/txtName"):GetComponent("UIChangeGroup")
	self._descTxt = self:getGo("info/bottom/ScrollView/Viewport/content/txtDesc"):GetComponent("Text")
	self.itemCell = self:getGo("info/icon")
	self.txtNum = self:getTxt("info/txtNum")
	self.goNum = self:getGo("info/txtNum")
	self.ImgC_Line = self:getGo("info/ImgC_Line")
	self._iconBg = self:getGo("info/iconBg")
	self.prize = self:getGo("info/bottom/price")
	self._sellTip = self:getTxt("info/bottom/price/txtPrice")
	self._txtExt = self:getTxt("info/bottom/txtExt")
	self._scroll = self:getGo("info/bottom/ScrollView"):GetComponent("ScrollRect")
	self._viewport = self:getGo("info/bottom/ScrollView/Viewport")
end

function ItemstackView:bindEvents()
	ItemstackView.super.bindEvents(self)
	self._sellButton:AddClickListener(self._onClickSell, self)
	self._useButton:AddClickListener(self._onClickUse, self)
	self._mergeButton:AddClickListener(self._onClickMerge, self)
	self._btnEvolve:AddClickListener(self._onClickEvolve, self)
	self._sourceBtn:AddClickListener(self._onClickSource, self)
	self._btnQuickUse:AddClickListener(self._onClickQuickUse, self)
end

function ItemstackView:unbindEvents()
	ItemstackView.super.unbindEvents(self)
	self._sellButton:RemoveClickListener()
	self._useButton:RemoveClickListener()
	self._mergeButton:RemoveClickListener()
	self._btnEvolve:RemoveClickListener()
	self._sourceBtn:RemoveClickListener()
	self._btnQuickUse:RemoveClickListener()
end

function ItemstackView:destroyUI()
	ItemstackView.super.destroyUI(self)
end

function ItemstackView:onEnter()
	ItemstackView.super.onEnter(self)
	self:_refreshList()
	GlobalDispatcher:addListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
end

function ItemstackView:onEnterFinished()
	ItemstackView.super.onEnterFinished(self)
end

function ItemstackView:onExit()
	ItemstackView.super.onExit(self)
	GlobalDispatcher:removeListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
end

function ItemstackView:onExitFinished()
	ItemstackView.super.onExitFinished(self)
end

function ItemstackView:_onClickSell()
	local data = ItemBagModel.instance:getCurrItem()

	UIStateManager.instance:open(ViewName.Itemproc, ItemProcView.TYPE_SOLD, data)
end

function ItemstackView:_onClickUse()
	ItemBagController.instance:openCurrUseItemPanel()
end

function ItemstackView:_onClickMerge()
	ItemBagController.instance:openCurrUseItemPanel()
end

function ItemstackView:_onClickEvolve()
	ItemBagController.instance:openEvolvePanel()
end

function ItemstackView:_onClickQuickUse()
	ItemBagController.instance:openCurQuickUsePanel()
end

function ItemstackView:_onClickSource()
	local data = ItemBagModel.instance:getCurrItem()

	MaterialMgr.openGetSourceByData(data)
end

function ItemstackView:_refreshList()
	local data = ItemBagModel.instance:getCurrItem()

	self:_refreshTip(data)
end

function ItemstackView:checkPriceTime(priceTimeLimit)
	if not string.nilorempty(priceTimeLimit) then
		local arr = string.split(priceTimeLimit, "#")

		return GameUtil.checkIsInTimePeriod(arr[1], arr[2])
	end

	return true
end

function ItemstackView:_refreshTip(data)
	GameUtil.SetActive(self._sourceBtn, false)
	GameUtil.SetActive(self.goNum, true)
	GameUtil.SetActive(self._iconBg, false)
	GameUtil.SetActive(self._txtExt.gameObject, false)

	self.txtNum.text = ""
	self._txtExt.text = ""
	self._nameTxt.text = ""
	self._descTxt.text = ""

	self.itemCell.gameObject:SetActive(false)
	GameUtil.SetActive(self.prize, false)
	GameUtil.SetActive(self.ImgC_Line, false)
	self.group:SetState(0)
	self._sellButton.gameObject:SetActive(false)
	self._useButton.gameObject:SetActive(false)
	self._mergeButton.gameObject:SetActive(false)
	self._btnEvolve.gameObject:SetActive(false)
	self._btnQuickUse.gameObject:SetActive(false)

	self._sellTip.text = ""

	GameUtil.setHeight(self._viewport, 200)

	self.txtUse.text = lang("使用")

	if data == nil then
		return
	end

	local defineId = data:getDefineId()
	local mattype = data:getMatType()

	if defineId == nil or mattype == nil or defineId == 0 or mattype == 0 then
		return
	end

	local view

	self.txtNum.text = MaterialModel.instance:getMaterialsNumber(mattype, defineId)

	if mattype == MatType.Item then
		local cfg = ItemConfig.instance:getCfgById(defineId)

		if cfg then
			self.itemCell.gameObject:SetActive(true)

			local cfg = ItemConfig.instance:getCfgById(defineId)

			if cfg and cfg.source ~= "" then
				GameUtil.SetActive(self._sourceBtn, true)
			end

			MaterialMgr.setIcon(self.itemCell, mattype, defineId)

			self._nameTxt.text = cfg.name

			self.group:SetState(1 + (cfg.quality or 0))

			self._descTxt.text = cfg.desc

			GameUtil.SetActive(self.prize, cfg.price > 0 and self:checkPriceTime(cfg.priceTimeLimit))
			self._sellButton.gameObject:SetActive(cfg.price > 0 and self:checkPriceTime(cfg.priceTimeLimit))
			self._useButton.gameObject:SetActive(cfg.useType == 1)
			self._btnEvolve.gameObject:SetActive(cfg.useType == GameEnum.ItemUseType.Evolve)

			if cfg.useType == 1 then
				local usecfg = MaterialConfig.instance:getCfgByMatAndId(mattype, defineId)

				if usecfg and not string.nilorempty(usecfg.useDesc) then
					self.txtUse.text = usecfg.useDesc
				end

				if cfg.subType == MatType.Item_ConsumeLottery then
					self._useButton.gameObject:SetActive(FuncOpenModel.instance:getFuncIsOpen(218))
				end

				local cfg = TreasureNewConfig.instance:getMapCfgByMatId(defineId)
				local showQuick = cfg and cfg.directGainLevel < 999

				self._btnQuickUse.gameObject:SetActive(showQuick)
			end

			local count, _type, _id, _num = MaterialConfig.instance:getMergeCfgByMatAndId(MatType.Item, defineId)

			self._mergeButton.gameObject:SetActive(cfg.useType == 2 and count > -1)

			local hasBtn = cfg.price > 0 and self:checkPriceTime(cfg.priceTimeLimit) or cfg.useType == 1 or cfg.useType == 2

			GameUtil.SetActive(self.ImgC_Line, hasBtn)

			if not hasBtn then
				GameUtil.setHeight(self._viewport, 360)
			end

			self._sellTip.text = cfg.price
		end
	elseif mattype == MatType.Coin then
		local cfg = MaterialMgr.getMatCfg(mattype, defineId)

		if cfg then
			self.itemCell.gameObject:SetActive(true)
			MaterialMgr.setIcon(self.itemCell, mattype, defineId)

			self._nameTxt.text = cfg.name
			self._descTxt.text = cfg.desc
		end
	elseif mattype == MatType.StarGodPlus then
		local cfg = MaterialMgr.getMatCfg(mattype, defineId)

		if cfg then
			self.itemCell.gameObject:SetActive(true)
			MaterialMgr.setIcon(self.itemCell, mattype, defineId)

			self._nameTxt.text = MaterialMgr.getMaterialsName(mattype, defineId)
			self._descTxt.text = cfg.desc

			self.group:SetState(1 + (cfg.quality or 0))
			GameUtil.SetActive(self._sourceBtn, true)
			GameUtil.SetActive(self.goNum, false)
		end
	elseif mattype == MatType.PET_SKIN then
		local cfg = MaterialMgr.getMatCfg(mattype, defineId)

		if cfg then
			GameUtil.SetActive(self._iconBg, true)
			self.itemCell.gameObject:SetActive(true)
			MaterialMgr.setIcon(self.itemCell, mattype, defineId)

			local skinCfg = PetSkinConfig.instance:getPetSkinCfg(defineId)
			local rare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, (skinCfg or nil) and skinCfg.raceId)

			self._nameTxt.text = MaterialMgr.getMaterialsName(mattype, defineId)
			self._descTxt.text = cfg.desc

			self.group:SetState(1 + (rare or 0))
			GameUtil.SetActive(self._sourceBtn, true)
			GameUtil.SetActive(self.goNum, false)
		end
	elseif mattype == MatType.HIRE_PET then
		local cfg = MaterialMgr.getMatCfg(mattype, defineId)

		if cfg then
			GameUtil.SetActive(self._iconBg, true)
			self.itemCell.gameObject:SetActive(true)
			MaterialMgr.setIcon(self.itemCell, mattype, defineId)

			local skinId = checknumber(cfg.raceId)
			local rare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, (checknumber(cfg.faceId) > 0 or nil) and checknumber(cfg.faceId))

			self._nameTxt.text = MaterialMgr.getMaterialsName(mattype, defineId)
			self._descTxt.text = cfg.desc

			self.group:SetState(1 + (rare or 0))
			GameUtil.SetActive(self._sourceBtn, not string.nilorempty(cfg.source))
			GameUtil.SetActive(self.goNum, false)
		end
	elseif mattype == MatType.ExpirableItem then
		local expiredTime = data:getExpiredTimeMillis()

		if expiredTime > 0 then
			GameUtil.SetActive(self._txtExt.gameObject, true)

			local expireDate = GameUtil.time2date(expiredTime / 1000)

			self._txtExt.text = langPara("%04d.%02d.%02d %02d:00:00 过期 ", expireDate.year, expireDate.month, expireDate.day, expireDate.hour)
		end

		local cfg = MaterialMgr.getMatCfg(mattype, defineId)

		if cfg then
			GameUtil.SetActive(self._iconBg, true)
			self.itemCell.gameObject:SetActive(true)
			MaterialMgr.setIcon(self.itemCell, mattype, defineId)

			self._nameTxt.text = MaterialMgr.getMaterialsName(mattype, defineId)
			self._descTxt.text = cfg.desc

			self.group:SetState(1 + (cfg.quality or 0))
			GameUtil.SetActive(self._sourceBtn, false)
			GameUtil.SetActive(self.goNum, false)
		end
	end

	self._scroll.verticalNormalizedPosition = 1

	self.layoutGroup:CalculateLayoutInputHorizontal()
	self.layoutGroup:CalculateLayoutInputVertical()
	self.layoutGroup:SetLayoutHorizontal()
	self.layoutGroup:SetLayoutVertical()
end

return ItemstackView
